<!--- 	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# CF_SSL CUSTON TAG
# A ColdFusion custom tag that implements SSL POP3 protocol JVM 
# attributes so the next CFPOP call proceeds with SSL enabling 
# its use against a POP3 SSL enabled server as Gmail "pop.gmail.com"
# server.
#
# Author...........: Vicente Junior - Salvador, BA, Brazil
# Last modified....: Oct-15-2007 - 01:30AM
# Contacts.........: macieljr@gmail.com
#                    http://teclandoalto.blogspot.com
#
# More info........: Solution based on my own following blog entry:
# http://teclandoalto.blogspot.com/2007/10/connecting-to-gmail-using-cfpop.html
#
# Instructions.....: Use it as you normally use CFPOP native tag to
#                    request messages.
#                    When no SSL is needed, use CFPOP itself.
#
#                    IMPORTANT NOTE:
#                    Although CF_SSLPOP uses just the same attributes
#                    supported by CFMAIL ColdFusion's native tag, the
#                    NAME and PORT attributes is required to use it.
#
# BSD LICENSE 
#
# Copyright (c) 2007, Vicente Junior
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this list
#   of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or other
#   materials provided with the distribution.
# * Neither the name of the Vicente Junior nor the names of its contributors may be
#   used to endorse or promote products derived from this software without specific
#   prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
--->

<cfif NOT isDefined("ATTRIBUTES.name")>
	<cfthrow message="Parameter NAME is required for CF_SSLPOP custom tag"/>
</cfif>

<cfif NOT isDefined("ATTRIBUTES.port")>
	<cfthrow message="Parameter PORT is required for CF_SSLPOP custom tag"/>
</cfif>

<cfset javaSystem = createObject("java", "java.lang.System") />
<cfset javaSystemProps = javaSystem.getProperties() />
<cfset javaSystemProps.setProperty("mail.pop3.socketFactory.class", "javax.net.ssl.SSLSocketFactory") />
<cfset javaSystemProps.setProperty("mail.pop3.port", ATTRIBUTES.port) />
<cfset javaSystemProps.setProperty("mail.pop3.socketFactory.port", ATTRIBUTES.port) />

<cfset originalNameAttrib = ATTRIBUTES.name />

<cfset ATTRIBUTES.name = "cfpopQuery" />

<cfpop attributeCollection="#ATTRIBUTES#"/>

<cfset CALLER[originalNameAttrib] = cfpopQuery />