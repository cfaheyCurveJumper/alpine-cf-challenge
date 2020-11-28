<!doctype html><cfoutput>

<!--- requires login --->
<cfif NOT structkeyexists( session, "userGUID" )>
	<cflocation url="index.cfm" addtoken="no">
</cfif>

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
							<a href="index.cfm" class="float-left">
								&lt; Back
							</a>
						</div>
						<div class="cell small-12 text-center">
							<h3>
								<small>
									Your Profile
								</small>
							</h3>
						</div>
						<div class="cell small-12">

							<cfquery name="local.getProfile" datasource="#application.dsn#">
								SELECT
									emailAddress,
									nameFirst,
									nameLast,
									isAdmin,
									userGUID
								FROM alpine_users
								WHERE userGUID = <cfqueryparam value="#session.userGUID#" cfsqltype="CF_SQL_VARCHAR">
							</cfquery>

							<table>
								<thead>
									<tr>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>First</th>
										<td>#local.getProfile.nameFirst#</td>
									</tr>
									<tr>
										<th>Last</th>
										<td>#local.getProfile.nameLast#</td>
									</tr>
									<tr>
										<th>Email</th>
										<td>#local.getProfile.emailAddress#</td>
									</tr>
									<tr>
										<th>ID</th>
										<td>#local.getProfile.userGUID#</td>
									</tr>
									<tr>
										<th>Is an Admin?</th>
										<td>
											<cfif val( local.getProfile.isAdmin )>
												Yes
											<cfelse>
												No
											</cfif>
										</td>
									</tr>
								</tbody>
							</table>

						</div>
					</div>
				</div>
			</div>
			<div class="cell small-4"></div>
		</div>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/foundation-sites@6.5.3/dist/js/foundation.min.js" integrity="sha256-/PFxCnsMh+nTuM0k3VJCRch1gwnCfKjaP8rJNq5SoBg= sha384-9ksAFjQjZnpqt6VtpjMjlp2S0qrGbcwF/rvrLUg2vciMhwc1UJJeAAOLuJ96w+Nj sha512-UMSn6RHqqJeJcIfV1eS2tPKCjzaHkU/KqgAnQ7Nzn0mLicFxaVhm9vq7zG5+0LALt15j1ljlg8Fp9PT1VGNmDw==" crossorigin="anonymous"></script>

	</body>
</html>
</cfoutput>
