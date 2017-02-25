<%@ page import="com.day.cq.wcm.api.WCMMode,
                   com.day.cq.wcm.foundation.forms.FormsHelper,
                   com.day.text.Text" %><%
%><%@include file="/libs/foundation/global.jsp"%>
<cq:includeClientLib categories="paccalvet.all"/>
<%
    String id = Text.getName(resource.getPath());
    String action = currentPage.getPath() + "/j_security_check";

    String referer = request.getHeader("Referer");
    String defaultRedirect = currentPage.getPath();
    if( referer != null ) {
        defaultRedirect = referer;
    }

    // managed URIs should respect sling mapping
    String redirectTo = slingRequest.getResourceResolver().map(request, properties.get("./redirectTo",defaultRedirect));
    if( !redirectTo.endsWith(".html")) {
        redirectTo += ".html";
    }

    boolean isDisabled = WCMMode.fromRequest(request).equals(WCMMode.DISABLED);
%>

<script type="text/javascript">
    function validation(item){
        if(validator(item) && profileValidation()){
            return true;
        }else{
            return false;
        }
    }
    function profileValidation() {
        if (CQ_Analytics) {
            var u = document.forms['<%=id%>']['j_username'].value;            
            <% if ( !isDisabled ) { %>
                if (CQ_Analytics.ProfileDataMgr) {
                    if (u) {
                        /*
                         * AdobePatentID="B1393"
                         */
                        var loaded = CQ_Analytics.ProfileDataMgr.loadProfile(u);
                        if (loaded) {
                            var url = CQ.shared.HTTP.noCaching("<%= xssAPI.encodeForJSString(redirectTo) %>");
                            CQ.shared.Util.load(url);
                        } else {
                            alert("The user could not be found.");
                        }
                        return false;
                    }
                }
                return true;
            <% } else { %>
                if (CQ_Analytics.ProfileDataMgr) {
                    CQ_Analytics.ProfileDataMgr.clear();
                }
                return true;
            <% } %>
        }
    }
</script>

<div class="loginRegisterContent loginContainor">
     <h2><%=properties.get("heading","enter title")%></h2>

<section>
<form method="POST"
      action="<%= xssAPI.getValidHref(action) %>"
      id="<%= xssAPI.encodeForHTMLAttr(id) %>"
      name="<%= xssAPI.encodeForHTMLAttr(id) %>"
      enctype="multipart/form-data"
      onsubmit="return validation(this);">
    
    <fieldset class="formFields">
        <input type="hidden" name="resource" value="<%= xssAPI.encodeForHTMLAttr(redirectTo) %>">
        <input type="hidden" name="_charset_" value="UTF-8"/>
        <ul>
            
            <li><label for="txtEmailAddress">Email Address <span class="required">&nbsp;</span></label><input type="email" value="" validate="true" errorTitle="" id="txtEmailAddress" name="j_username" class="inputField" autofocus /></li>
            <li><label for="txtPassword">Password <span class="required">&nbsp;</span></label><input type="password" value="" validate="true" errorTitle="" id="txtPassword" name="j_password" class="inputField" /></li>
        </ul>
        
        <div class="buttonBottomBlock"><input type="submit" value="Submit" class="button" /></div>
        <%
    String jReason = request.getParameter("j_reason");

    if (null != jReason) {
            %><div style="color:red;"><%=xssAPI.encodeForHTML("User name and password do not match")%></div>
    <%    }
	%>


    </fieldset>        
</form>
	<div class="clear"></div>
    <ul class="activeLinks">
        <li><a href="registration.html" title="Register">New to Paccal Vet<sup>&reg;</sup><em>-</em>CA1?</a></li>
        <li><a href="forgot.html" title="Forgot Password">Forgot your password?</a></li>
    </ul>
</section>
</div>