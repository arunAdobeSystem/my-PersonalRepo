<%@include file="/libs/foundation/global.jsp"%>
<%@page session="false" %>
<%@ page import="com.day.cq.i18n.I18n,
    			   com.adobe.cq.commerce.api.CommerceConstants,
                   com.day.cq.personalization.ProfileUtil,
                   com.day.cq.security.profile.Profile,
	               com.day.cq.security.Authorizable,
    	           org.apache.sling.api.resource.Resource,
				   org.apache.sling.api.resource.ResourceResolver,
                   com.day.cq.wcm.api.WCMMode" %><%
%><%@taglib prefix="personalization" uri="http://www.day.com/taglibs/cq/personalization/1.0" %><%

    final I18n i18n = new I18n(slingRequest);
    final Profile currentProfile = slingRequest.adaptTo(Profile.class);
    final boolean isAnonymous = ProfileUtil.isAnonymous(currentProfile);
    final boolean isDisabled = WCMMode.DISABLED.equals(WCMMode.fromRequest(request));
    final String loginPagePath = currentStyle.get("loginPage", String.class);
	final String logoutPath = request.getContextPath() + "/system/sling/logout.html?resource="+loginPagePath+".html";
	//out.println("logoutPath---->"+logoutPath);
    final String profilePagePath = currentStyle.get("profilePage", String.class);
    final String myProfileLink = currentProfile.getPath()+".form.html" + profilePagePath;
    
    final String signupPagePath = currentStyle.get("signupPage", String.class);

%>

<script type="text/javascript">function logout() {
    if (_g && _g.shared && _g.shared.ClientSidePersistence) {
        _g.shared.ClientSidePersistence.clearAllMaps();
    }

<% if( !isDisabled ) { %>
    if (CQ_Analytics && CQ_Analytics.CCM) {
        CQ_Analytics.ProfileDataMgr.loadProfile("anonymous");
        CQ.shared.Util.reload();
    }
<% } else { %>
    if (CQ_Analytics && CQ_Analytics.CCM) {
        CQ_Analytics.ProfileDataMgr.clear();
        CQ_Analytics.CCM.reset();
    }
    CQ.shared.HTTP.clearCookie("<%=CommerceConstants.COMMERCE_COOKIE_NAME %>", "/");
    CQ.shared.Util.load("<%= xssAPI.encodeForJSString(logoutPath) %>");
<% } %>
}</script>

        <%
            if (isDisabled) {
                //in publish mode, only display the name if !anonymous
                if (!isAnonymous) {
        %>
        <li>Welcome , <span class="userName"><%=ProfileUtil.getValue(currentProfile,"txtName")%></span> <span>|</span></li>

        <%
                    if (null != profilePagePath) {
        %>
        <li><a href="<%= myProfileLink %>" title="My Profile">My Profile</a> <span>|</span></li>
        <%
                    }
        %>
        <li><a href="javascript:logout();" title="Sign Out">Sign Out</a></li>
        <%
                } else {
                    slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, loginPagePath+".html"));
                }

        } else {
            if (!isAnonymous) {
            //on author handle link from the ContextCloud
        %>
            <li>Welcome , <span class="userName"><%=ProfileUtil.getValue(currentProfile,"txtName")%></span> <span>|</span></li>
        <%
            if (null != profilePagePath) {
        %>
            <li><a href="<%= myProfileLink %>" title="My Profile">My Profile</a> <span>|</span></li>
        <%
            }
        %>
            <li><a href="javascript:logout();" title="Sign Out">Sign Out</a></li>
        <%       
            }              
         }
        %>