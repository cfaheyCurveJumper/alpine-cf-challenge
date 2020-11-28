<cfcomponent displayname="Application" output="false">

	<cfscript>
		this.clientmanagement	= "no";
		this.sessionmanagement	= "yes";
		this.setclientcookies	= "yes";
		this.setdomaincookies	= "yes";
		this.sessiontimeout	= CreateTimeSpan(0,0,30,0);
	</cfscript>


	<cffunction name="onApplicationStart" output="false">
		<cfscript>
			application.dsn = "alpine";
		</cfscript>
	</cffunction>

</cfcomponent>
