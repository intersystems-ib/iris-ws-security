Include %soap

Class Test.MyWebService Extends %SOAP.WebService
{

Parameter SECURITYIN = "REQUIRE";

Parameter SERVICENAME = "MySOAPService";

Parameter NAMESPACE = "IrisSec";

Method MyMethod(arg1 As %Numeric, arg2 As %Numeric) As %Numeric [ WebMethod ]
{
	set credentials = ##class(%SYS.X509Credentials).GetByAlias("serverCred", "1234")
	
	set binSecToken = ##class(%SOAP.Security.BinarySecurityToken).CreateX509Token(credentials)
	do ..SecurityOut.AddSecurityElement(binSecToken)
	
	// assertion
	#dim assertion As %SAML.Assertion = ##class(%SAML.Assertion).CreateX509(binSecToken)
	set assertion.IssueInstant = $zdatetime($horolog,3)
	
	// issuer
	set issuer = ##class(%SAML.NameID).%New()
 	set issuer.NameID = "SampleIssuer"
 	set assertion.Issuer=issuer
 	
 	// subject
 	set subject = ##class(%SAML.Subject).%New()
 	#dim nameid As %SAML.NameID = ##class(%SAML.NameID).%New()
 	set nameid.NameID = "CN=Sample,OU=PRE,O=Org,ST=Barcelona,C=ES" 
 	set nameid.Format = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
 	set subject.NameID = nameid
 	set assertion.Subject = subject
 	
 	do ..SecurityOut.AddSecurityElement(assertion)
	
	quit arg1+arg2
}

}
