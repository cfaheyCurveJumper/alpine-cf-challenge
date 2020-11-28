<cfoutput>

	<!--- can't get here from there. Or anywhere --->
	<cfif cgi.REQUEST_METHOD NEQ "post">
		<cflocation url="index.cfm" addtoken="no">
	</cfif>

	<cfif structkeyexists( form, "emailAddress" ) AND structkeyexists( form, "password" )>

		<!--- find the matching user record --->
		<cfquery name="local.getUserSalt" datasource="#application.dsn#">
			SELECT salt
			FROM alpine_users
			WHERE
				isDeleted = 0
				AND emailAddress = <cfqueryparam value="#trim( form.emailAddress )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">
		</cfquery>

		<!--- no record --->
		<cfif NOT val( local.getUserSalt.recordcount )>
			<cflocation url="log-in.cfm?error=1" addtoken="no">
		</cfif>

		<!--- salt and hash the provided password --->
		<cfset local.pwHash = "#hash( '#form.password##local.getUserSalt.salt#', 'SHA-512' )#">

		<!--- query again for a match on user and pw --->
		<cfquery name="local.getUser" datasource="#application.dsn#">
			SELECT
				userGUID,
				nameFirst,
				isAdmin
			FROM alpine_users
			WHERE
				isDeleted = 0
				AND emailAddress = <cfqueryparam value="#trim( form.emailAddress )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">
				AND password = <cfqueryparam value="#local.pwHash#" cfsqltype="CF_SQL_CHAR" maxlength="128">
		</cfquery>

		<!--- no record --->
		<cfif NOT val( local.getUser.recordcount )>
			<cflocation url="log-in.cfm?error=1" addtoken="no">
		</cfif>

		<cfset session.loggedIn = 1>
		<cfset session.nameFirst = local.getUser.nameFirst>
		<cfset session.isAdmin = val( local.getUser.isAdmin )>
		<cfset session.userGUID = local.getUser.userGUID>

		<cflocation url="index.cfm" addtoken="no">

	</cfif>

</cfoutput>
