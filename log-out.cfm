<cfoutput>

	<cfset structdelete( session, "loggedIn" )>
	<cfset structdelete( session, "nameFirst" )>
	<cfset structdelete( session, "isAdmin" )>
	<cfset structdelete( session, "userGUID" )>

	<cflocation url="index.cfm" addtoken="no">

</cfoutput>
