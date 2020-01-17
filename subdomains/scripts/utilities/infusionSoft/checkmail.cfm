<cfscript>

	// Query for the most recently undelivered mail definition. Since
	// we can't actually limit to a single file, we will order it
	// based on date file was created - newest ones first.
	// --
	// NOTE: The location of the undelivered mail folder (Undelivr)
	// will depend on your installation and ColdFusion configuration.
	mailItems = directoryList(
		"C:/ColdFusion11/cfusion/Mail/Undelivr/",
		false,
		"query",
		"*.cfmail",
		"dateLastModified DESC"
	);

	// If there is no mail, just exit.
	if ( ! mailItems.recordCount ) {

		writeOutput( "No undelivered mail found." );
		exit;

	}

	// Read in the content of the most recent undelivered mail item.
	// Note that this is NOT the raw content of the CFMail tag; rather,
	// it contains additional meta data about the mail. The content
	// will look somethign like this:
	// --
	// type: text/html
	// server: ...
	// from: ...
	// to: ...
	// replyto: ...
	// subject: ...
	// X-Mailer: ...
	// body: This is some mail content.
	// body: This is some mail content.
	// body: This is some mail content.
	content = fileRead( "#mailItems.directory#/#mailItems.name#" );

	// Find the type of mail content (HTML vs. Plain). If we don't
	// find "text/html", we're going to assume Plain text.
	isHtml = !! reFind( "(?mi)^type:\s*text/html", content );

	// Strip out all the meta-data before the mail content.
	content = javaCast( "string", content ).replaceAll(
		javaCast( "string", "(?mi)^(?!body:)[^\r\n]*[\r\n]" ),
		javaCast( "string", "" )
	);

	// Strip out all the per-line "body:" content markers.
	content = javaCast( "string", content ).replaceAll(
		javaCast( "string", "(?mi)^body:\s*" ),
		javaCast( "string", "" )
	);

	// Send out the mail using LIVE mail server credentials.
	new Mail().send(
		to = "ben@bennadel.com",
		from = "ben@bennadel.com",
		subject = "TEST EMAIL",
		body = content,
		type = ( isHtml ? "html" : "plain" ),
		spoolEnable = false,
		server = "",
		port = "587",
		username = "rdiveley@wellcoaches.com",
		password = "Boston8771"
	);

	writeOutput( "Mail Sent, check your inbox!" );

</cfscript>