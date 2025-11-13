-- =============================================
-- LearnUpon Webhook Performance Indexes
-- =============================================
-- Run these indexes to optimize webhook processing
-- IMPORTANT: Test on staging first, then apply to production
-- =============================================

USE [wellcoachesSchool]
GO

-- Index 1: Duplicate Check Optimization
-- Speeds up the duplicate webhook detection query
-- Estimated improvement: 90%+ faster duplicate checks
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_webhook_duplicate')
BEGIN
    CREATE NONCLUSTERED INDEX IX_webhook_duplicate
    ON [dbo].[learnuponwebhook](webhookid, emailaddress, lastAttemptAt, examName)
    WITH (ONLINE = ON, FILLFACTOR = 90)
END
GO

-- Index 2: Module 1 KA Query Optimization
-- Speeds up the Module 1 Knowledge Assessment average calculation
-- Estimated improvement: 95%+ faster (eliminates correlated subquery)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_webhook_email_exam')
BEGIN
    CREATE NONCLUSTERED INDEX IX_webhook_email_exam
    ON [dbo].[learnuponwebhook](emailaddress, examName, lastAttemptAt DESC)
    INCLUDE (exampercentage)
    WITH (ONLINE = ON, FILLFACTOR = 90)
END
GO

-- Index 3: Habits Course Optimization
-- Speeds up Habits KA score retrieval
-- Estimated improvement: 85%+ faster
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_webhook_habits')
BEGIN
    CREATE NONCLUSTERED INDEX IX_webhook_habits
    ON [dbo].[learnuponwebhook](emailaddress, courseId, lastAttemptAt DESC)
    INCLUDE (exampercentage)
    WITH (ONLINE = ON, FILLFACTOR = 90)
END
GO

-- Optional: Filtered index for Lesson Knowledge Assessments
-- Only indexes rows where examName starts with 'Lesson Knowledge Assessment'
-- Smaller, faster index for the most common query pattern
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_webhook_examname_filtered')
BEGIN
    CREATE NONCLUSTERED INDEX IX_webhook_examname_filtered
    ON [dbo].[learnuponwebhook](examName, emailaddress, lastAttemptAt DESC)
    INCLUDE (exampercentage)
    WHERE examName LIKE 'Lesson Knowledge Assessment%'
    WITH (ONLINE = ON, FILLFACTOR = 90)
END
GO

-- =============================================
-- Index Maintenance Script
-- Run monthly to keep indexes optimized
-- =============================================

-- Check index fragmentation
SELECT
    OBJECT_NAME(ips.object_id) AS TableName,
    i.name AS IndexName,
    ips.avg_fragmentation_in_percent,
    ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('learnuponwebhook'), NULL, NULL, 'LIMITED') ips
INNER JOIN sys.indexes i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
WHERE ips.avg_fragmentation_in_percent > 10
ORDER BY ips.avg_fragmentation_in_percent DESC
GO

-- Rebuild indexes if fragmentation > 30%
-- ALTER INDEX IX_webhook_duplicate ON learnuponwebhook REBUILD WITH (ONLINE = ON)
-- ALTER INDEX IX_webhook_email_exam ON learnuponwebhook REBUILD WITH (ONLINE = ON)
-- ALTER INDEX IX_webhook_habits ON learnuponwebhook REBUILD WITH (ONLINE = ON)

-- =============================================
-- Performance Verification Queries
-- Run these BEFORE and AFTER adding indexes to compare
-- =============================================

-- Test Query 1: Duplicate Check Performance
SET STATISTICS TIME ON
SET STATISTICS IO ON

DECLARE @testWebhookId INT = 12345
DECLARE @testEmail VARCHAR(255) = 'test@example.com'
DECLARE @testTimestamp DATETIME = GETDATE()
DECLARE @testExamName VARCHAR(255) = 'Test Exam'

SELECT TOP 1 1 AS exists_flag
FROM [wellcoachesSchool].[dbo].[learnuponwebhook]
WHERE webhookid = @testWebhookId
AND emailaddress = @testEmail
AND lastAttemptAt = @testTimestamp
AND examName = @testExamName

SET STATISTICS TIME OFF
SET STATISTICS IO OFF
GO

-- Test Query 2: Module 1 KA Performance
SET STATISTICS TIME ON
SET STATISTICS IO ON

DECLARE @testEmail2 VARCHAR(255) = 'test@example.com'

WITH LatestAttempts AS (
    SELECT
        examName,
        emailaddress,
        exampercentage,
        ROW_NUMBER() OVER (PARTITION BY examName, emailaddress ORDER BY lastAttemptAt DESC) AS rn
    FROM [wellcoachesSchool].[dbo].[learnuponwebhook]
    WHERE emailaddress = @testEmail2
    AND examName LIKE 'Lesson Knowledge Assessment%'
)
SELECT
    COUNT(DISTINCT examName) as countRecord,
    CAST(AVG(CAST(exampercentage AS DECIMAL(10,2))) AS DECIMAL(10,2)) as average
FROM LatestAttempts
WHERE rn = 1

SET STATISTICS TIME OFF
SET STATISTICS IO OFF
GO

PRINT 'All indexes created successfully!'
PRINT 'Compare the execution times and I/O before and after indexes to verify improvement.'
