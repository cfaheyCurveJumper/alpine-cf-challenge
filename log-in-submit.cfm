<cfoutput>

	<!--- can't get here from there. Or anywhere --->
	<cfif cgi.REQUEST_METHOD NEQ "post">
		<cflocation url="index.cfm" addtoken="no">
	</cfif>

	<cfif structkeyexists( form, "emailAddress" ) AND structkeyexists( form, "password" )>

		<!--- find the matching user record --->
		<cfstoredproc datasource="#application.dsn#" procedure="alpine_getUserSalt">

			<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" value="#left( trim( form.emailAddress ), 64 )#" dbvarname="emailAddress">

			<cfprocresult name="local.getUserSalt">

		</cfstoredproc>

		<!--- no record --->
		<cfif NOT val( local.getUserSalt.recordcount )>
			<cflocation url="log-in.cfm?error=1" addtoken="no">
		</cfif>

		<!--- salt and hash the provided password --->
		<cfset local.pwHash = "#hash( '#form.password##local.getUserSalt.salt#', 'SHA-512' )#">

		<!--- query again for a match on user and pw --->
		<cfstoredproc datasource="#application.dsn#" procedure="alpine_getUserByEmailPW">

			<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" value="#left( trim( form.emailAddress ), 64 )#" dbvarname="emailAddress">
			<cfprocparam cfsqltype="CF_SQL_VARCHAR" type="in" value="#local.pwHash#" dbvarname="password">

			<cfprocresult name="local.getUser">

		</cfstoredproc>

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
