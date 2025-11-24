# ColdFusion Survey Processing Scripts - Developer Guide

## Overview
This directory contains ColdFusion scripts that integrate SurveyGizmo/Alchemer surveys with Keap (Infusionsoft) CRM. The scripts process survey completions and apply tags to contacts based on their progress.

## Critical Environment Issues

### Local Development Email Problem
**ISSUE**: Using `cfmail()` script-based syntax causes HTTP 500 errors in local development (.loc domains)
**CAUSE**: Local ColdFusion mail signing configuration causes failures
**SOLUTION**: Always use tag-based `<cfmail>` syntax instead of script-based `cfmail()`

```cfm
<!-- ✅ CORRECT - Tag-based syntax -->
<cfmail to="#email#" from="noreply@wellcoaches.com" subject="Error">
  Message content
</cfmail>

<!-- ❌ WRONG - Script-based syntax (fails locally) -->
<cfscript>
cfmail(to=email, from="noreply@wellcoaches.com", subject="Error") {
  writeOutput("Message content");
}
</cfscript>
```

### Keap API Configuration
**API Endpoint**: `https://api.infusionsoft.com/crm/xmlrpc/v1/`
**API Key**: Stored in `API_KEY` variable at top of each file
**Format**: XML-RPC (uses `utilities/XML-RPC.cfc` component)

## File Types & Purposes

### Batch Processors (for scheduled tasks)
These process ALL submissions without requiring URL parameters:

1. **surveyCompleteALL.cfm**
   - Processes 18 feedback surveys
   - Runs daily at midnight via scheduled task
   - Filters by today's date only
   - Bidirectional sync: adds AND removes tags based on current state
   - Custom field: `_Module2SurveysComplete`

2. **module2AddOnALL.cfm**
   - Processes Module 2 Add-on courses (Survey ID: 8397154)
   - Requires 3 survey completions
   - Required tag: 23728 ("LU Access to Mod 2 Additional Classes ONLY [Sep25 fwd]")
   - Completion tag: 23744 ("Mod 2 Additional Courses 2025 Surveys Complete")
   - Custom field: `_Mod2AddonStandAlone`
   - Only adds tags (no removal logic needed - see below)

### Webhook Processors (triggered by SurveyGizmo)
These require `?email=user@example.com` URL parameter:

1. **surveyComplete.cfm** - Single feedback survey webhook
2. **habitsSurvey.cfm** - Habits survey webhook
3. **habitsSurveyALL.cfm** - Habits batch (requires email parameter, NOT suitable for scheduling)

### Setup & Utilities

1. **setup_scheduled_tasks.cfm**
   - Creates/updates ColdFusion scheduled tasks
   - Must be run on production after code changes to scheduled task configuration
   - Creates two daily tasks running at midnight

## Scheduled Tasks

### Current Configuration (Daily Processing)
- **DailyFeedbackSurveyProcessor**: Runs `surveyCompleteALL.cfm` at midnight
- **DailyModule2AddOnProcessor**: Runs `module2AddOnALL.cfm` at midnight

### How to Update Scheduled Tasks on Production
1. Push code changes to GitHub
2. Visit: `https://scripts.wellcoachesschool.com/utilities/infusionsoft/setup_scheduled_tasks.cfm`
3. Go to ColdFusion Administrator → Debugging & Logging → Scheduled Tasks
4. Delete old/obsolete scheduled tasks manually

**IMPORTANT**: Scheduled task configuration is stored in ColdFusion, not in code files. Running the setup script is required after any scheduling changes.

## Date Filtering Pattern

All batch processors use date filtering to process only today's submissions:

```cfm
// Date filter - process only today's submissions (for daily scheduled task)
TODAY_DATE = dateFormat(now(), "yyyy-mm-dd");

// SurveyGizmo API URL with date filters
filter[field][0]=date_submitted&filter[operator][0]=>=&filter[value][0]=#TODAY_DATE#%2000:00:00
&filter[field][1]=date_submitted&filter[operator][1]=<=&filter[value][1]=#TODAY_DATE#%2023:59:59
```

**Benefits**:
- Faster processing (fewer records per run)
- Lower server load
- Easier troubleshooting
- More frequent updates (daily vs weekly)

## Tag Management Strategies

### Bidirectional Sync (surveyCompleteALL.cfm)
- Fetches contacts who currently have the completion tag
- Removes tag if they no longer meet completion criteria
- Adds tag if they newly completed all required surveys
- Ensures tags accurately reflect current state

### One-Way Tag Addition (module2AddOnALL.cfm)
- Only adds completion tag when requirements met
- Does NOT remove tags later
- Why: Required prerequisite tag (23728) acts as gatekeeper
- Contacts must have prerequisite tag to be processed
- Completion tag (23744) is just a marker, won't cause issues if it remains

## Error Handling Pattern

All scripts use consistent error handling:

```cfm
// Configuration
ERROR_EMAIL = "rdiveley@wellcoaches.com";
MAX_RETRIES = 3;
RETRY_DELAY_MS = 1000;

// Log errors to request scope
function logAndEmailError(errorType, errorMessage, errorDetail, userEmail) {
    if (!structKeyExists(request, "surveyErrors")) {
        request.surveyErrors = [];
    }
    arrayAppend(request.surveyErrors, {
        errorType: errorType,
        errorMessage: errorMessage,
        errorDetail: errorDetail,
        userEmail: userEmail,
        timestamp: now()
    });
}

// At end of file: send error emails via tag-based cfmail
<cfif structKeyExists(request, "surveyErrors") AND arrayLen(request.surveyErrors) GT 0>
    <cfloop array="#request.surveyErrors#" index="errorInfo">
        <cfmail to="#ERROR_EMAIL#" from="noreply@wellcoaches.com" subject="Survey Error" type="html">
            <!-- Error details -->
        </cfmail>
    </cfloop>
</cfif>
```

**Key Points**:
- Only email for API/communication errors
- Do NOT email for validation errors (missing contacts, etc.)
- Use tag-based `<cfmail>` syntax (not script-based)
- Retry logic with exponential backoff

## API Helper Functions

### callInfusionsoftAPI()
- Handles XML-RPC conversion
- Automatic retry logic (3 attempts)
- Returns standardized result: `{success: boolean, data/error: any}`

### Common Keap API Calls

```cfm
// Find contact by email
ContactService.findByEmail(API_KEY, email, ["Id", "FirstName", "LastName"])

// Load contact with groups/tags
ContactService.load(API_KEY, contactId, ["Id", "Groups"])

// Update contact field
ContactService.update(API_KEY, contactId, {fieldName: value})

// Add tag to contact
ContactService.addToGroup(API_KEY, contactId, tagId)

// Remove tag from contact
ContactService.removeFromGroup(API_KEY, contactId, tagId)

// Query custom field data
DataService.query(API_KEY, "Contact", limit, offset, {Id: contactId}, ["fieldName", "Id"])
```

## Common Pitfalls & Solutions

### 1. Email Script Syntax
**Problem**: Script-based `cfmail()` fails locally
**Solution**: Always use tag-based `<cfmail>` syntax

### 2. Scheduled Tasks Not Updating
**Problem**: Code changes don't affect scheduled tasks
**Solution**: Run `setup_scheduled_tasks.cfm` on production after changes

### 3. Processing Old Data
**Problem**: Scripts processing all historical data
**Solution**: Always add date filtering to limit to today's submissions

### 4. URL Encoding
**Problem**: Spaces in URL parameters cause API errors
**Solution**: Use `urlEncodedFormat()` or `%20` for spaces

### 5. Tag Prerequisites
**Problem**: Script tries to update contacts without required access tag
**Solution**: Check for required tag before processing (e.g., line 196 in module2AddOnALL.cfm)

## Survey & Tag Mapping

### Feedback Surveys (surveyCompleteALL.cfm)
- 18 surveys required for completion
- Custom field: `_Module2SurveysComplete`
- Tracks individual survey completions before marking "Y"

### Module 2 Add-on (module2AddOnALL.cfm)
- Survey ID: 8397154
- Required tag: 23728 ("LU Access to Mod 2 Additional Classes ONLY [Sep25 fwd]")
- Completion tag: 23744 ("Mod 2 Additional Courses 2025 Surveys Complete")
- Custom field: `_Mod2AddonStandAlone`
- 3 surveys required

## Testing Checklist

### Local Testing
1. ✅ Use tag-based `<cfmail>` syntax
2. ✅ Test with .loc domain
3. ✅ Verify API calls work
4. ✅ Check error handling

### Production Deployment
1. ✅ Commit and push to GitHub
2. ✅ Run `setup_scheduled_tasks.cfm` if scheduled task config changed
3. ✅ Verify scheduled tasks in CF Administrator
4. ✅ Monitor error emails for first 24 hours

## Git Workflow

### Recent Improvements
- Restructured LearnUpon group tags to modern struct format
- Reversed group order (newest first) for easier tracking
- Optimized tag matching from O(n×m) to O(n) with early exit
- Added URL encoding for email parameters
- Improved error handling with retry logic
- Added bidirectional sync for tag management
- Removed debug output for production readiness

### Commit Message Format
```
Brief summary of changes

- Bullet points of specific changes
- Technical improvements
- Bug fixes

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Support & Troubleshooting

### Error Email Recipients
- Primary: rdiveley@wellcoaches.com

### Common Debug Steps
1. Check CF Administrator → Debugging & Logging → Scheduled Tasks
2. Review error emails sent to rdiveley@wellcoaches.com
3. Test individual scripts via browser (add `?email=test@example.com` for webhook scripts)
4. Check SurveyGizmo API for response data
5. Verify Keap API key is valid

### Useful CF Administrator Paths
- Scheduled Tasks: Debugging & Logging → Scheduled Tasks
- Data Sources: Data & Services → Data Sources
- Mail Settings: Server Settings → Mail

## File Change History

### 2025 Updates
- Converted all scripts from script-based to tag-based `<cfmail>` syntax
- Added date filtering for daily processing
- Changed from weekly to daily scheduled task execution
- Removed validation error emails (kept only API errors)
- Added bidirectional sync to surveyCompleteALL.cfm
- Created modern struct format for LearnUpon groups

## Additional Resources

### XML-RPC Component
Location: `utilities/XML-RPC.cfc`
Purpose: Converts ColdFusion data structures to/from XML-RPC format for Keap API

### SurveyGizmo API Documentation
- Base URL: `https://restapi.surveygizmo.com/v5/`
- Authentication: API token + secret in URL parameters
- Results limit: 500 per page

### Keap API Documentation
- Endpoint: `https://api.infusionsoft.com/crm/xmlrpc/v1/`
- Format: XML-RPC
- Header: `X-Keap-API-Key`

---

**Last Updated**: 2025-01-24
**Maintained By**: Wellcoaches Development Team
**Contact**: rdiveley@wellcoaches.com
