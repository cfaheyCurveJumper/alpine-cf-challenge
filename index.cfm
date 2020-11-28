<!doctype html><cfoutput>
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

						<!--- logged in user --->
						<cfif structkeyexists( session, "loggedIn" )>

							<div class="cell small-12">
								<a href="log-out.cfm" class="float-right small hollow button">
									Log Out
								</a>
							</div>
							<div class="cell small-12 text-center">
								<h4>
									Hello #session.nameFirst#!
								</h4>
								<p>
									<a href="profile.cfm">
										View your profile
									</a>
								</p>
							</div>
							<cfif structkeyexists( session, "isAdmin" ) AND val( session.isAdmin )>
								<div class="cell small-10 small-offset-1">
									<div class="card">
										<div class="card-divider text-center">
											<p><b>Wow! You're Mister Manager.</b></p>
										</div>
										<div class="card-section">
											<img src="admin-badge.png">
										</div>
										<div class="card-section text-center">
											<p>You also get to view the <a href="user-list.cfm">User List</a></p>
										</div>
									</div>
								</div>
							</cfif>

						<!--- not logged in --->
						<cfelse>

							<div class="cell small-6">
								<a href="sign-up.cfm" class="float-left small hollow button">
									Create Account
								</a>
							</div>
							<div class="cell small-6">
								<a href="log-in.cfm" class="float-right small hollow button">
									Log In
								</a>
							</div>
							<div class="cell small-12 text-center">
								<h4>Get ready to be rocked.</h4>
								<p>
									With this amazing app you may create a new account, log in, log out, view your profile, and&mdash;if you're lucky&mdash;view a list of all users.
								</p>
								<p>
									Yes, I know. Mind. Blown.
								</p>
							</div>
						</cfif>
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
