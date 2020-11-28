<!doctype html><cfoutput>

<!--- no need to login twice --->
<cfif structkeyexists( session, "userGUID" )>
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
						<div class="cell small-12">

							<form method="post" action="log-in-submit.cfm">

								<div class="grid-container">
									<div class="grid-x">
										<div class="cell small-12 text-center">
											<h3>
												<small>
													Log Into Your Account
												</small>
											</h3>
										</div>

										<cfparam name="url.error" default="0">
										<cfparam name="url.success" default="0">

										<cfif val( url.error )>
											<div class="cell small-12">
												<span class="alert label expanded text-center">
													Email or Password incorrect.
												</span>
											</div>
										</cfif>

										<cfif val( url.success )>
											<div class="cell small-12">
												<span class="success label expanded text-center">
													Success! Account created.
												</span>
											</div>
										</cfif>

										<div class="cell small-12">
											<label>Email Address
												<input type="text" value="" name="emailAddress">
											</label>
										</div>
										<div class="cell small-12">
											<label>Password
												<input type="password" value="" name="password">
											</label>
										</div>
										<div class="cell small-12 text-center">
											<button type="submit" class="success button">
												Log In
											</button>
										</div>
									</div>
								</div>

							</form>

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
