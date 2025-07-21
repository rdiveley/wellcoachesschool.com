<cfinclude template="credentials.cfm">

<cfif structKeyExists(form,'email')>
	<cfset URL.email = FORM.email>
</cfif>

<cfset local.message="An Error has occurred, Wellcoaches IT has been informed and will get back to you shortly." />

<!--- 1. add the Learn Upon group IDs here --->
<cfset local.group_id = "986468,965750,986003,971601,971602,966452,959902,929342,929341,929340,929339,919766,907870,907872,906878,906887,905522,901768,900069,900067,894855,893888,893210,893209,893208,871061,856231,856229,855397,846340,846335,846327,816040,804988,804987,804985,793694,793693,793691,793682,785081,776255,775645,770351,764200,764037,760391,747386,756035,756033,752456,748581,748578,744246,747386,731913,729855,728278,720840,720428,715258,704813,674596,654892,651296,650725,647797,645020,638088,625819,611521,607295,595986,588117,583849,570664,570659,569236,569228,555224,555223,550736,546704,545173,539864,539861,537709,531867,517483,517484,497231,497171,476138,476136,475536,457198,467705,467704,467702,457195,444680,443399,443398,418135,418067,417007,415904,415521,399396,397128,394270,383008,357954,345594,335420,335393,331706,331102,326955,311207,310295,270378,215044,215036,204048,204039,133730,200727,200614,86550,92767,122134,122751,124692,132795,132796,133227,134579,135804,133731,133732,138684,143303,149768,149769,158563,165525,166587,135804,151620,172370,177643,179908,179925,166047,196765">
<cfset local.group_id = listRemoveDuplicates(local.group_id) />
<!--- 2. create the associated tags to the groups --->

<!--- IS tags for Learn Upon 86550 Fundamentals of Lifestyle Medicine--->
<cfset local.LU86550_tags = "9831,1382,1384,9821">
<!--- IS tags for 92767 NBC-HWC Exam Preparation 2018--->
<cfset local.LU92767_tags = "9777,1382,1384">

<!--- IS tags for #10163 (Core Nov2018 Mod 1*) --->
<cfset local.LU122134_tags = "10163,1382,1384">
<!--- IS tags for #10480 Res Dec2018 [Bemidji] Mod 1* and #10610 Res Feb2019 [Ft Worth] Mod 1* --->
<cfset local.LU122751_tags = "10480,10610,10910,1382,1384">
<!--- #3054 – I have a Membership Free #1826 – I have a Membership Paid --->
<cfset local.LU124692_tags = "1382,1384,7892">
<!--- #10371 (Core Jan2019 Mod 1*) for  Core Coach Training - 18 Week Teleclasses --->
<cfset local.LU132795_tags = "10371,1382,1384">
<!--- #10732 Core Mar2019 Mod 1* --->
<cfset local.LU132796_tags = "10732,1382,1384">
<!--- #133227 Core Coach Training: Module 2 --->
<cfset local.LU133227_tags = "22712,17886,9617,1382,1384,18672,9617">
<!--- #134579 Professional Coach Training 2019 --->
<cfset local.LU134579_tags = "1382,1384,10145">
<!--- 135804 = Burnout Prevention Program for Physicians --->
<cfset local.LU135804_tags = "1382,1384,11448,12319">
<!--- 133732 = Core Coach Training: Module 1  (University of Wisconsin) --->
<cfset local.LU133732_tags="11420,1382,1384" >
<!--- 138684 = Core Coach Training: Module 1  (May 2019 cohort) --->
<cfset local.LU138684_tags = "1382,1384,11458">
<!--- 143303 = Core Coach Training: Module 1 (August 2019: 4-day residential) --->
<cfset local.LU143303_tags = "11108,1382,1384">
<!--- Core Coach Training: Module 1 (June 2019: 4-day residential) --->
<cfset local.LU149768_tags = "11012,1382,1384">
<!--- Core Coach Training: Module 1 (July 2019 cohort) --->
<cfset local.LU149769_tags = "11669,1382,1384">
<!--- Core Coach Training: Module 1 (Oct 2019: 4-day residential) --->
<cfset local.LU151620_tags = "11204,1382,1384">
<!--- Core Coach Training: Core Sep2019 Mod 1* --->
<cfset local.LU158563_tags = "11909,1382,1384">
<!--- Res Jul2019 [Singapore] Mod 1* --->
<cfset local.LU165525_tags = "12383,1382,1384">
<!--- Core Coach Training: Module 1  (Nov 2019 cohort) --->
<cfset local.LU166587_tags = "12229,1382,1384">
<!--- 12649 Res Feb2020 [AZ] Mod 1* --->
<cfset local.LU172370_tags = "12649,1382,1384">
<!--- Core Coach Training: Module 1 (Dec 2019: 4-day residential) --->
<cfset local.LU177643_tags = "12877,1382,1384">
<!--- Core Jan2020 Mod 1* --->
<cfset local.LU179908_tags = "12771,1382,1384">
<!--- Core Feb2020 Mod 1* --->
<cfset local.LU179925_tags = "13001,1382,1384">
<!--- PCTP Jan2020 --->
<cfset local.LU166047_tags = "12535,1382,1384">
<!--- 	Res Apr2020 [FL] Mod 1* --->
<cfset local.LU196765_tags = "13237,1382,1384">
<!--- 200614 	Core Coach Training: Module 1  (Mar 2020 cohort) --->
<cfset local.LU200614_tags = "13091,1382,1384">
<!--- Core Coach Training: Module 1  (April 2020 cohort) --->
<cfset local.LU200727_tags = "13343,1382,1384">
<!--- Core Coach Training: Module 2 (California University of PA) --->
<cfset local.LU133730_tags = "19658,19056,18990,17760,16438,15445,13673,1382,1384">
<!--- Core Coach Training: Module 1  (California Univ of PA) --->
<cfset local.LU133731_tags = "21412,19526,18990,11372,12583,16436,16438,15443,15445,12858,13671,13673,1382,1384,17762">
<!---Core Coach Training: Module 1  (May 2020 cohort) --->
<cfset local.LU204039_tags = "13489,1382,1384">
<!--- Core Coach Training: Module 1 (June 2020: 4-day residential) --->
<cfset local.LU204048_tags = "13577,1382,1384">
<!---  Core Coach Training: Module 1  (July 2020 cohort)--->
<cfset local.LU215036_tags = "13975,1382,1384">
<!---  Core Coach Training: Module 1  (June 2020 cohort) --->
<cfset local.LU215044_tags = "13887,1382,1384">
<!--- Core Coach Training: Module 1 (April 2020 Singapore) --->
<cfset local.LU270378_tags = "14557,1382,1384">
<!--- core Coach Training: Module 1  (Aug 2020 cohort) --->
<cfset local.LU310295_tags = "14383,1382,1384" >
<!--- Core Coach Training: Module 1  (Monarch Dedicated 2020 cohort)  --->
<cfset local.LU311207_tags = "14711,1382,1384" >
<!--- Core Coach Training: Module 1  (Sept 2020 cohort) --->
<cfset local.LU326955_tags = "14845,1382,1384" >
<!--- 14935	Core Oct2020 Mod 1* --->
<cfset local.LU331102_tags = "14935,1382,1384" >
<!--- Core Coach Training: Module 1  (Nov 2020 cohort) --->
<cfset local.LU331706_tags = "15023,1382,1384" >
<!--- Core Coach Training: Module 1  (Oct 2020 4-day) --->
<cfset local.LU335393_tags = "15217,1382,1384" >
<!--- Core Coach Training: Module 1  (Dec 2020 4-day)  --->
<cfset local.LU335420_tags = "15311,1382,1384" >
<!--- Core Coach Training: Module 1  (Jan 2021 cohort)--->
<cfset local.LU357954_tags = "15506,1382,1384" />
<!--- behavior change agent --->
<cfset local.LU345594_tags = "15644,15660,1382,1384,15646" />
<!--- Core Coach Training: Module 1  (Feb 2021 9-wk cohort)s --->
<cfset local.LU383008_tags = "15762,1382,1384" />
<!--- 15942	Core Mar2021 Mod 1* --->
<cfset local.LU394270_tags = "15942,1382,1384" />
<!--- Core Coach Training: Module 1 (Apr 2021 9-wk). --->
<cfset local.LU397128_tags = "16138,1382,1384" />
<!--- Core Coach Training: Module 1  (Apr 2021, 4-Friday  cohort) --->
<cfset local.LU399396_tags = "16044,1382,1384" />
<!--- Core Coach Training: Module 1  (May 2021 cohort) --->
<cfset local.LU415521_tags = "16516,1382,1384" />
<!--- Core Coach Training: Module 1  (June 2021 9-wk cohort) --->
<cfset local.LU415904_tags = "16600,1382,1384" />
<!--- Core Coach Training: Module 1 (March 2021 4-day)--->
<cfset local.LU417007_tags = "16886,1382,1384" />
<!--- Core Coach Training: Module 1 (Apr 2021[2] 4-day) --->
<cfset local.LU418067_tags = "16962,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2021 4-week)--->
<cfset local.LU418135_tags = "16748,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2021 4-day)--->
<cfset local.LU443398_tags = "17232,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2021 4-day) --->
<cfset local.LU443399_tags = "17256,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2021 9-week) --->
<cfset local.LU444680_tags = "17192,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 4-week) --->
<cfset local.LU457195_tags = "17344,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 9-week)  --->
<cfset local.LU467705_tags = "17420,1382,1384" />
<!--- Core Coach Training: Module 1 (Sept 2021 4-day) --->
<cfset local.LU467704_tags = "17436,1382,1384" />
<!--- Core Coach Training: Module 1 (Sept 2021 4-week) --->
<cfset local.LU467702_tags = "17612,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2021 9-week) --->
<cfset local.LU457198_tags = "17328,1382,1384" />
<!--- Professional Coach Training 2022 --->
<cfset local.LU475536_tags = "17706,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2021 9-week) --->
<cfset local.LU476136_tags = "17468,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2021 4-week)  --->
<cfset local.LU476138_tags = "17516,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2021 4-day) --->
<cfset local.LU497171_tags = "17532,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2021 9-week) --->
<cfset local.LU497231_tags = "17484,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2021 9-week) --->
<cfset local.LU517484_tags = "17500,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2021 4-day) --->
<cfset local.LU517483_tags = "17548,1382,1384" />
<!--- Core Coach Training: Module 1 (Jan 2022 9-week) --->
<cfset local.LU531867_tags = "17922,1382,1384" />
<!--- Core Coach Training: Module 1 (Jan 2022 4-day) --->
<cfset local.LU537709_tags = "17938,18056,1382,1384" />
<!--- Core Coach Training: Module 1 (Feb 2022 9-week) --->
<cfset local.LU539861_tags = "18004,1382,1384" />
<!--- Core Coach Training: Module 1 (Feb 2022 4-week) --->
<cfset local.LU539864_tags = "18020,1382,1384" />
<!--- Holiday Extra Credit Offer --->
<cfset local.LU546704_tags = "18194,1382,1384" />
<!--- Core Coach Training: Module 1 (Mar 2022 9-week) --->
<cfset local.LU545173_tags = "18074,18154,1382,1384" />
<!--- Core Coach Training: Module 1 (April 2022 4-week)--->
<cfset local.LU555223_tags = "18242,1382,1384" />
<!--- Core Coach Training: Module 1 (April 2022 9-week)--->
<cfset local.LU555224_tags = "18216,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2022 9-week)--->
<cfset local.LU569228_tags = "18338,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2022 4-day) --->
<cfset local.LU569236_tags = "18364,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2022 9-week) --->
<cfset local.LU570659_tags = "18420,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2022 4-week) --->
<cfset local.LU570664_tags = "18446,18472,1382,1384" />
<!--- Core Coach Training: Module 1 (Mar 2022 4-day) --->
<cfset local.LU550736_tags = "18128,18602,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2022 4-day) --->
<cfset local.LU583849_tags = "18510,18562,18536,1382,1384" />
<!--- Core Coach Training: Module 1 (Aug 2022) --->
<cfset local.LU588117_tags = "18714,18688,1382,1384" />
<!--- Core Coach Training: Module 1 (Sept 2022) --->
<cfset local.LU595986_tags = "18773,18748,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2022) --->
<cfset local.LU607295_tags = "18840,18814,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2022) --->
<cfset local.LU611521_tags = "19102,18910,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2022)  --->
<cfset local.LU625819_tags = "19006,1382,1384" />
<!--- Core Coach Training: Module 1 (Jan 2023)  --->
<cfset local.LU638088_tags = "19180,19154,1382,1384" />
<!--- Core Coach Training: Module 1 (Feb 2023)  --->
<cfset local.LU645020_tags = "19288,19262,1382,1384" />
<!--- Core Coach Training: Module 1 (Mar 2023) --->
<cfset local.LU647797_tags = "19376,19350,1382,1384" />
<!--- Core Coach Training: Module 1 (Apr 2023) --->
<cfset local.LU650725_tags = "19450,19476,1382,1384" />
<!--- Professional Coach Training 2023 --->
<cfset local.LU651296_tags = "19076,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2023) --->
<cfset local.LU654892_tags = "19614,19530,19556,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2023) --->
<cfset local.LU674596_tags = "19960,19672,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2023) --->
<cfset local.LU704813_tags = "19832,1382,1384" />
<!--- Core Coach Training: Module 1 (Aug 2023)  --->
<cfset local.LU715258_tags = "20620,20340,19884,19858,1382,1384" />
<!--- Coaching for Mental Well-being  --->
<cfset local.LU720428_tags = "20570,20118,1382,1384" />
<!--- Core Coach Training: Module 1 (Sep 2023)  --->
<cfset local.LU720840_tags = "20084,19934,19910,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2023)  --->
<cfset local.LU728278_tags = "20950,20272,20182,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2023)  --->
<cfset local.LU729855_tags = "20320,20288,20198,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2023) --->
<cfset local.LU731913_tags = "20510,20304,1382,1384" />
<!--- Coaching for Social Resources and Health Equity --->
<cfset local.LU747386_tags = "20374,1382,1384" />
<!--- Professional Coach Training 2024 --->
<cfset local.LU744246_tags = "20662,1382,1384" />
<!--- Collection Offering #1 --->
<cfset local.LU748578_tags = "20642,1382,1384" />
<!--- Collection Offering #2 --->
<cfset local.LU748581_tags = "20902,1382,1384" />
<!--- Core Coach Training: Module 1 (Jan 2024) --->
<cfset local.LU752456_tags = "21360,20788,20716,1382,1384" />
<!--- Core Coach Training: Module 1 (Feb 2024) --->
<cfset local.LU756033_tags = "21528,20812,20740,1382,1384" />
<!--- Core Coach Training: Module 1 (Mar 2024) --->
<cfset local.LU756035_tags = "20836,20764,1382,1384" />
<!--- Coaching for Social Resources and Health Equity --->
<cfset local.LU747386_tags = "20990,1382,1384" />
<!--- Coaching for Social Resources and Health Equity --->
<cfset local.LU760391_tags = "20992,1382,1384" />
<!--- Coaching Clients to a Healthy Weight (on-demand) --->
<cfset local.LU764037_tags = "21256,1382,1384" />
<!--- Coaching for Mental Well-being Dec 2023 --->
<cfset local.LU764200_tags = "20578,1382,1384" />
<!--- Core Coach Training: Module 1 (Apr 2024) --->
<cfset local.LU770351_tags = "21098,21026,1382,1384" />
<!--- Core Coach Training: Module 1 (May 2024) --->
<cfset local.LU775645_tags = "21918,21122,21050,1382,1384" />
<!--- Core Coach Training: Module 1 (June 2024) --->
<cfset local.LU776255_tags = "21146,21074,1382,1384" />
<!--- Cut Through the Noise  --->
<cfset local.LU785081_tags = "21458,21460,1382,1384" />
<!--- Coaching for Mental Well-being - Feb 2024 --->
<cfset local.LU793682_tags = "21426,1382,1382,1384" />
<!--- Coaching for Mental Well-being - May 2024 --->
<cfset local.LU793691_tags = "21436,1382,1382,1384" />
<!--- Coaching for Mental Well-being - Sep 2024 --->
<cfset local.LU793693_tags = "21446,1382,1382,1384" />
<!--- Coaching for Mental Well-being - Nov 2024 --->
<cfset local.LU793694_tags = "21456,1382,1382,1384" />
<!--- Core Coach Training: Module 1 (July 2024) --->
<cfset local.LU804985_tags = "21728,21626,1382,1384" />
<!--- Core Coach Training: Module 1 (August 2024) --->
<cfset local.LU804987_tags = "21762,21660,1382,1384" />
<!--- Core Coach Training: Module 1 (Sep 2024) --->
<cfset local.LU804988_tags = "21796,21694,1382,1384" />
<!--- Professional Coach Training 2025 --->
<cfset local.LU816040_tags = "21962,1382,1384" />
<!--- Core Coach Training: Module 1 (Oct 2024) --->
<cfset local.LU846327_tags = "22112,22010,1382,1384" />
<!--- Core Coach Training: Module 1 (Nov 2024) --->
<cfset local.LU846335_tags = "22146,22044,1382,1384" />
<!--- Core Coach Training: Module 1 (Dec 2024) --->
<cfset local.LU846340_tags = "22180,22078,1382,1384" />
<!--- NBC-HWC Preparation Course 2.0 --->
<cfset local.LU855397_tags = "22304,1382,1384" />
<!--- Coaching for Social Resources and Health Equity - Aug2024 --->
<cfset local.LU856229_tags = "21540,1382,1384" />
<!--- Coaching for Social Resources and Health Equity - Nov2024 --->
<cfset local.LU856231_tags = "21546,1382,1384" />
<!--- USCF - Module 1 4-day Training, September 2024 --->
<cfset local.LU871061_tags = "22352,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (January 2025) --->
<cfset local.LU893208_tags = "22380,1382,1384" />
<!--- Core Coach Training: Module 1  - 9 week (February 2025) --->
<cfset local.LU893209_tags = "22414,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (March 2025)--->
<cfset local.LU893210_tags = "22448,1382,1384" />
<!---  Core Coach Training: Module 1 - 4 week (January 2025) --->
<cfset local.LU893888_tags = "22482,1382,1384" />
<!---  Wellcoaches Membership: Upcoming Classes and Recorded Continuing Education Libra --->
<cfset local.LU894855_tags = "7706,1826,3054,1382,1384" />
<!---   Core Coach Training: Module 1 - 4 week (February 2025) --->
<cfset local.LU900067_tags = "22516,1382,1384" />
<!---   Core Coach Training: Module 1 - 4 week (March 2025) --->
<cfset local.LU900069_tags = "22550,1382,1384" />
<!---  Core Coach Training: Module 1 - 9 week (April 2025) --->
<cfset local.LU901768_tags = "22756,1382,1384" />
<!---  Core Coach Training: Module 1 - 4 week (April 2025) --->
<cfset local.LU905522_tags = "22788,1382,1384" />
<!---  Core Coach Training: Module 1 - 4 week (May 2025) --->
<cfset local.LU906887_tags = "22916,1382,1384" />
<!---  Core Coach Training: Module 1 - 9 week (May 2025) --->
<cfset local.LU906878_tags = "22852,1382,1384" />
<!--- Core Coach Training: Module 1 - 4 week (June 2025) --->
<cfset local.LU907872_tags = "22948,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (June 2025) --->
<cfset local.LU907870_tags = "22884,1382,1384" />
<!--- Motivational Interviewing On-Demand --->
<cfset local.LU919766_tags = "23096,23098,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (July 2025) --->
<cfset local.LU929339_tags = "23172,1382,1384" />
<!--- Core Coach Training: Module 1 - 4 week (July 2025) --->
<cfset local.LU929340_tags = "23236,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (August 2025) --->
<cfset local.LU929341_tags = "23204,1382,1384" />
<!--- Core Coach Training: Module 1 - 4 week (August 2025) --->
<cfset local.LU929342_tags = "23268,1382,1384" />
<!--- Core Coach Training: Module 1 - 9 week (September 2025) --->
<cfset local.LU959902_tags = "23408,1382,1384" />
<!--- Professional Coach Training 2026 --->
<cfset local.LU966452_tags = "23536,1382,1384" />
<!--- Core Coach Training: Module 1 - Coaching Habits Course --->
<cfset local.LU971601_tags = "23594,23408,1382,1384" />
<!--- Core Coach Training: Module 1 - (September 2025) --->
<cfset local.LU971602_tags = "23408,1382,1384" />
<!--- Core Coach Training: Module 1 - Rutgers Dedicated (August 2025) --->
<cfset local.LU986003_tags = "23700,1382,1384" />
<!--- Module 1 - Lessons 1-18: Knowledge Assessments 2025 --->
<cfset local.LU965750_tags = "23594,23408,1382,1384" />
<!--- Core Coach Training: Module 1 - (October 2025) --->
<cfset local.LU986468_tags = "23594,1382,1384" />

<cftry>
	<!--- creates the structure that holds the tags as the key to the structure named using LU{group} --->
	<cfloop list="#local.group_id#" index="local.id">
		<cfset 'local.LU#local.id#' = {} />
		<cfloop list="#evaluate('local.LU'&local.id&'_tags')#" index="local.tag">
			<cfset local.LU[local.id][local.tag] = '' >
		</cfloop>
	</cfloop>

	<cfset key = "KeapAK-986c932da67be5b58500636bcc6b0e128efda00616e7dd8093" />
    <cfset selectedFieldsArray = ["Id", "FirstName", "LastName", "Password", "Groups"]>
    <cfset myArray = ["ContactService.findByEmail", key, URL.email, selectedFieldsArray]>

		<cfinvoke component="utilities/XML-RPC"
			method="CFML2XMLRPC"
			data="#myArray#"
			returnvariable="myPackage">
		
		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = '-X POST https://api.infusionsoft.com/crm/xmlrpc/ -H "X-Keap-API-Key: #key#" -H "Content-Type: application/xml" -H "Accept: application/xml" -d #myPackage.Trim()#'
			variable="myResult1"
			timeout = "200">
		</cfexecute>

		<cfinvoke component="utilities/XML-RPC"
			method="XMLRPC2CFML"
			data="#myResult1#"
			returnvariable="theData2">

		<cfif !isArray(theData2['Params'][1]) || !arrayLen(theData2['Params'][1])>
			User <cfoutput>#URL.email#</cfoutput> does not exist in our records.<br /><cfabort />
		</cfif>

		<cfset local.userInfo = theData2.Params[1][1]>
		<cfset local.tagList =  theData2.Params[1][1]['Groups'] />

		<cfif !structKeyExists(local.userInfo,'LastName')>
			<cfset local.userInfo = theData2.Params[1][2]>
			<cfset local.tagList =  theData2.Params[1][2]['Groups'] />
		</cfif>

		<cfset local.assignGroups = "">

		<!--- loop through all the tags, if you find a tag as a key to a structure/group, add that group to local.assignGroups --->
		<cfloop list="#local.tagList#" index="local.tag">
			<cfloop collection="#local.LU#" item="local.col">
				<cfif structKeyExists(local.LU[local.col],local.tag)>
					<cfset local.assignGroups = listAppend(local.assignGroups,local.col) />
				</cfif>
			</cfloop>
		</cfloop>

		<cfset local.assignGroups = listRemoveDuplicates(local.assignGroups)>

		<cfset local.id = "">

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/users/search?email=#URL.email#"
			variable="myResult"
			timeout = "200">
		</cfexecute>


		<cfset local.user = deserializeJSON(myResult)>

		<cfif !structKeyExists(local.user, 'response_code')>
			<cfset local.user = deserializeJSON(myResult).user[1]>
			<cfset local.id = local.user.id>
		</cfif>


		<cfif !len(local.id)>
			
			<cfset local.user =
					{"User": {    'last_name' : local.userInfo['lastName']
								, 'first_name' : local.userInfo['firstName']
								, 'email' : URL.email
								, 'password' : "#local.userInfo['Password']#"
								, 'language' : 'en'
								
							}
					}
			/>

			<!--- this creates the user  --->
			<cfset local.user = serializeJSON(local.user) />
			<cfset local.user = ReplaceNoCase(local.user,'"','\"','all') />
			<cfset local.user = ReplaceNoCase(local.user,' ','-','all') />


			<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
				arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/users -H "Content-Type: application/json" -d #local.user#'
				variable="myResult"
				timeout = "200">
			</cfexecute>


			<cfset local.messgeStruct = deserializeJSON(myresult)>

			<cfif structKeyExists(local.messgeStruct,'message') AND local.messgeStruct.message contains 'user already exists'>

				<cfif listLen(local.assignGroups)>
					<cfloop list="#local.assignGroups#" index="local.groupId">
						<!--- add to group --->
						<cfset local.addUser =
							{"GroupInvite": {
										  'email_addresses' : URL.email
										, 'group_id' : local.groupId
										, 'group_membership_type_id' : 1
									}
							}
						/>
						<!--- send invite to each group --->
						<cfset local.user = serializeJSON(local.addUser) />

						<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
							arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_invites -H "Content-Type: application/json" -d #ReplaceNoCase(local.addUser,'"','\"','all')# '
							variable="myResult"
							timeout = "200">
						</cfexecute>
					</cfloop>
				</cfif>

				<h3>User invite was sent successfully!</h3>
				<cfabort>
			</cfif>

			<cfset local.id = deserializeJSON(myResult).id>
		</cfif>

		<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
			arguments = "-u #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships?user_id=#local.id#"
			variable="myGroups"
			timeout = "200">
		</cfexecute>

		<cfset local.groups = deserializeJSON(myGroups)>

		<cfset local.groupids = "" />
		

		<cfloop array="#local.groups['group']#" index="local.group">
			<cfset local.groupids = listAppend(local.groupids,local.group['id']) />
		</cfloop>

		<!--- assign the user to groups they should belong to --->
		<cfif listLen(local.assignGroups)>
			<cfloop list="#local.assignGroups#" index="local.groupId">

				<cfif !listFind(local.groupids,local.groupid)>

					<cfset local.groupMemberShip =
						{"GroupMembership":
							{ 'group_id' : local.groupId
							,'user_id' : local.id
							}
						}
					/>
					<!--- this applies the newly created user to a group  --->
					<cfset local.groupMemberShip = serializeJSON(local.groupMemberShip) />
   
					<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
						arguments = '-u #local.username#:#local.password# -X POST https://wellcoaches.learnupon.com/api/v1/group_memberships -H "Content-Type: application/json" -d #ReplaceNoCase(local.groupMemberShip,'"','\"','all')# '
						variable="myResult"
						timeout = "200">
					</cfexecute>

				</cfif>	
			</cfloop>
		</cfif>

		<!--- Find group Ids user doesn't belong to --->
		<cfset local.deleteUserFromGroup = "" />
		<cfloop list="#local.groupids#" index="local.groupid">
			<cfif !listFind(local.assignGroups,local.groupid)>
				<cfset local.deleteUserFromGroup = listAppend(local.deleteUserFromGroup,local.groupid) />
			</cfif>
		</cfloop>


		<!--- remove user from groups he doesn't belong to --->
		<cfloop list="#local.deleteUserFromGroup#" index="local.deletegroupid">

			<cfset local.deleteGroup =
				{"GroupMembership":
					{ 'group_id' : local.deletegroupid
					,'user_id' : local.id
					}
				}
			/>

			<cfset local.deleteGroup = serializeJSON(local.deleteGroup) />

			<cfexecute name = "C:\websites\wellcoachesschool.com\subdomains\scripts\utilities\learnUpon\curl7_76_1\bin\curl.exe"
					arguments = '-X DELETE -H "Content-Type: application/json" --user #local.username#:#local.password# https://wellcoaches.learnupon.com/api/v1/group_memberships/0  -d #ReplaceNoCase(local.deleteGroup,'"','\"','all')# '>
			</cfexecute> 
			
		</cfloop>

		<cfset local.message = "User was added successfully to LearnUpon!">
		<cfif structKeyExists(url,'redirectFromCH')>
				 <cflocation url="https://wellcoaches.learnupon.com/sqsso?Email=#URL.email#&TS=#URL.TS#&SSOToken=#URL.SSOToken#" />
		</cfif>
		
		<cfcatch type="any">
			
			<cfmail to="rdiveley@wellcoaches.com" subject="LearnUpon Create Groups" from="wellcoaches@wellcoaches.com" type="html">
				<table>
					<tr>
						<td><cfdump var="#cfcatch#" format="html"></td>
					</tr>
					
					<tr>
						<td><cfdump var="#url#" format="html"></td>
					</tr>
				</table>
			</cfmail>
		</cfcatch>
	</cftry>

<cfoutput>
	<h3>#local.message#</h3>
</cfoutput>


