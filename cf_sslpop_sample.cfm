<!--- 	
		#########################################################
		# Implementing CFPOP with SSL using CF_SSLPOP CustomTag
		#
		# Author: Vicente Junior - macieljr@gmail.com
		#         Adobe Advanced Certified Developer & Instructor
		#         Independent Web Solutions Developer
		# Date  : Sat,13/Oct - 2007
		#########################################################
--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LABS - CFPOP with SSL</title>
</head>

<body>

<form id="gmail_login" action="<cfoutput>#CGI.SCRIPT_NAME#?action=getHeaderOnly</cfoutput>" method="POST">

<p>
POP Server:<br />
<input type="text" id="popServer" name="popServer" size="30" value="<cfif isDefined("FORM.popServer")><cfoutput>#FORM.popServer#</cfoutput></cfif>" />
</p>

<p>
port:<br />
<input type="text" id="port" name="port" value="<cfif isDefined("FORM.port")><cfoutput>#FORM.port#</cfoutput></cfif>" />
</p>

<p>
<input type="checkbox" id="useSSL" name="useSSL" <cfif isDefined("FORM.useSSL")>checked</cfif> /> SSL
</p>

<p>
email:<br /> 
<input type="text" id="email" name="email" size="30" value="<cfif isDefined("FORM.email")><cfoutput>#FORM.email#</cfoutput></cfif>"/>
</p>

<p>
password:<br />
<input type="password" id="pass" name="pass" size="30" value="<cfif isDefined("FORM.pass")><cfoutput>#FORM.pass#</cfoutput></cfif>"/>
</p>

<p>
max messages:
<br />
<select id="max" name="max">
	<option value="10"
	
		<cfif isDefined("FORM.max") and FORM.max IS "10">
		selected
		</cfif>
	
	 >10</option>
	<option value="25"
	
		<cfif isDefined("FORM.max") and FORM.max IS "25">
		selected
		</cfif>
	
	>25</option>
	<option value="50"
	
		<cfif isDefined("FORM.max") and FORM.max IS "50">
		selected
		</cfif>
	
	>50</option>
</select>
</p>

<p>
<input type="submit" id="submitBtn" name="submitBtn" value="get message headers"/>
</p>

</form>

<cfif isDefined("FORM.fieldnames") AND isDefined("URL.action") AND len(URL.action)>
	
	<cfswitch expression="#URL.action#">
	
		<cfcase value="getHeaderOnly">
			
			<cfif isDefined("FORM.useSSL")>
				<cf_sslpop 
					name="emails"
					username="#FORM.email#"
					password="#FORM.pass#"
					server="#FORM.popServer#"
					port="#FORM.port#"
					maxrows="#FORM.max#"
				/>
			<cfelse>
				<cfpop 
					name="emails"
					username="#FORM.email#"
					password="#FORM.pass#"
					server="#FORM.popServer#"
					port="#FORM.port#"
					maxrows="#FORM.max#"
				/>
			</cfif>
			
			<p>Results:</p>
				   
			<cfif emails.recordcount>
				<cfdump var="#emails#"/>
			<cfelse>
				<p>NO MESSAGES</p>
			</cfif>
		
		</cfcase>
	
	</cfswitch>

</cfif>

</body>

</html>
