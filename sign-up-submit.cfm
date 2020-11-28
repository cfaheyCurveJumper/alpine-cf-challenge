<cfoutput>

	<!--- can't get here from there. Or anywhere --->
	<cfif cgi.REQUEST_METHOD NEQ "post">
		<cflocation url="index.cfm" addtoken="no">
	</cfif>

	<cfif structkeyexists( form, "emailAddress" ) AND structkeyexists( form, "password" ) AND structkeyexists( form, "password_confirm" )>

		<cfparam name="local.msg" default="">

		<!--- check for a matching user email --->
		<cfquery name="local.getDupe" datasource="#application.dsn#">
			SELECT userGUID
			FROM alpine_users
			WHERE
				isDeleted = 0
				AND emailAddress = <cfqueryparam value="#left( trim( form.emailAddress ), 64 )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">
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
					<cfqueryparam value="#left( trim( form.nameFirst ), 128 )#" cfsqltype="CF_SQL_VARCHAR" maxlength="128">,
					<cfqueryparam value="#left( trim( form.nameLast ), 128 )#" cfsqltype="CF_SQL_VARCHAR" maxlength="128">,
					<cfqueryparam value="#left( trim( form.emailAddress ), 64 )#" cfsqltype="CF_SQL_VARCHAR" maxlength="64">,
					<cfqueryparam value="#local.pwHash#" cfsqltype="CF_SQL_CHAR" maxlength="128">,
					<cfqueryparam value="#local.salt#" cfsqltype="CF_SQL_CHAR" maxlength="128">
				)
			</cfquery>

			<cflocation url="log-in.cfm?success=1" addtoken="no">

		</cfif>


		<cfif len(trim( local.msg ))>
			<!doctype html>
			<html class="no-js" lang="en">
				<head>
					<meta charset="utf-8" />
					<meta http-equiv="x-ua-compatible" content="ie=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0" />
					<title>Alpine Coldfusion Challenge</title>
					<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/foundation-sites@6.5.3/dist/css/foundation.min.css" integrity="sha256-xpOKVlYXzQ3P03j397+jWFZLMBXLES3IiryeClgU5og= sha384-gP4DhqyoT9b1vaikoHi9XQ8If7UNLO73JFOOlQV1RATrA7D0O7TjJZifac6NwPps sha512-AKwIib1E+xDeXe0tCgbc9uSvPwVYl6Awj7xl0FoaPFostZHOuDQ1abnDNCYtxL/HWEnVOMrFyf91TDgLPi9pNg==" crossorigin="anonymous">
				</head>
				<body>

					<div class="grid-x grid-margin-x grid-padding-x grid-padding-y">
						<div class="cell small-4"></div>
						<div class="cell small-4">
							<div class="callout">
								<div class="grid-x">
									<div class="cell small-12">
										#local.msg#
									</div>
								</div>
							</div>
						</div>
						<div class="cell small-4"></div>
					</div>
				</body>
			</html>

			<cfabort>
		</cfif>

		<cflocation url="index.cfm" addtoken="no">

	</cfif>

</cfoutput>
