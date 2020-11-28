<cfoutput>

	<!--- can't get here from there. Or anywhere --->
	<cfif cgi.REQUEST_METHOD NEQ "post">
		<cflocation url="index.cfm" addtoken="no">
	</cfif>

	<cfif structkeyexists( form, "emailAddress" ) AND structkeyexists( form, "password" ) AND structkeyexists( form, "password_confirm" )>

		<!--- check for a matching user email --->
		<cfquery name="local.getDupe" datasource="#application.dsn#">
			SELECT userGUID
			FROM alpine_users
			WHERE
				isDeleted = 0
				AND emailAddress = <cfqueryparam value="#trim( form.emailAddress )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">
		</cfquery>

		<!--- dupe email --->
		<cfif val( local.getDupe.recordcount )>

			<cfsavecontent variable="local.msg">
				<h4>Uh-oh.</h4>
				<p>
					The provided email address (#form.emailAddress#) already has an account. <a href="log-in.cfm">You may log in here</a>
				</p>
			</cfsavecontent>

		<!--- password mismatch --->
		<cfelseif form.password NEQ form.password_confirm>

			<cfsavecontent variable="local.msg">
				<h4>Uh-oh.</h4>
				<p>
					The passwords you provided did not match. <a href="javascript:window.history.back();">Please return to the Account Creation form</a>
				</p>
			</cfsavecontent>

		<cfelse>

			<!--- season the password --->
			<cfset local.salt = hash( generatesecretkey( "AES" ), "SHA-512" )>
			<cfset local.pwHash = "#hash( '#form.password##local.salt#', 'SHA-512' )#">

			<!--- save the user --->
			<cfquery datasource="#application.dsn#">
				INSERT INTO alpine_users ( nameFirst, nameLast, emailAddress, password, salt )
				VALUES (
					<cfqueryparam value="#trim( form.nameFirst )#" cfsqltype="CF_SQL_VARCHAR" maxlength="128">,
					<cfqueryparam value="#trim( form.nameLast )#" cfsqltype="CF_SQL_VARCHAR" maxlength="128">,
					<cfqueryparam value="#trim( form.emailAddress )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">,
					<cfqueryparam value="#local.pwHash#" cfsqltype="CF_SQL_CHAR" maxlength="128">,
					<cfqueryparam value="#local.salt#" cfsqltype="CF_SQL_CHAR" maxlength="128">
				)
			</cfquery>

			<cflocation url="log-in.cfm?success=1" addtoken="no">

		</cfif>


		<cflocation url="index.cfm" addtoken="no">

	</cfif>

</cfoutput>
