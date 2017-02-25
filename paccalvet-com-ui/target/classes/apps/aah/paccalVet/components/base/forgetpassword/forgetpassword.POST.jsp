<%@include file="/libs/foundation/global.jsp"%><cq:defineObjects />
<%@page session="false" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.net.URL" %>
<%@ page import="javax.jcr.Session" %>
<%@ page import="org.apache.sling.api.request.RequestParameter" %>
<%@ page import="org.apache.sling.api.resource.ResourceUtil" %>
<%@ page import="org.apache.sling.api.resource.ValueMap" %>
<%@ page import="org.apache.sling.jcr.api.SlingRepository" %>
<%@ page import="com.day.cq.security.AccountManager" %>
<%@ page import="com.day.cq.security.AccountManagerFactory" %>
<%@ page import="com.day.cq.security.Authorizable" %>
<%@ page import="com.day.cq.security.User" %>
<%@ page import="com.day.text.Text"%>
<%@ page import="com.day.cq.wcm.foundation.forms.FormsHelper" %>

<%@taglib prefix="sling" uri="http://sling.apache.org/taglibs/sling/1.0" %><%!

    final String LOGIN = "txtEmailAddress";

%><sling:defineObjects/><%

    final ValueMap localproperties = ResourceUtil.getValueMap(resource);
    final SlingRepository repos = sling.getService(SlingRepository.class);
    final AccountManagerFactory af = sling.getService(AccountManagerFactory.class);
    Session session = null;
    String error = null;
    boolean success = false;
	Authorizable authorizable = null;
    try {
        session = repos.loginAdministrative(null);
        final AccountManager am = af.createAccountManager(session);
        final String auth = request.getParameter(LOGIN)==null? null : slingRequest.getRequestParameter(LOGIN).getString();
        if (auth!=null) {
            authorizable = am.findAccount(auth);
            String changePwdPage = localproperties.get("changePwdPage", null);

            if (authorizable != null && changePwdPage != null && authorizable.isUser()) {
                if (!changePwdPage.endsWith(".html")) {
                    changePwdPage += ".html";
                }
                URL url = new URL(request.getRequestURL().toString());
                success = am.requestPasswordReset((User)authorizable, new URL(url.getProtocol(), url.getHost(), url.getPort(), changePwdPage));
            }
        }
        } catch (Exception e) {
            error = e.getMessage();
        } finally {
            if (session!=null) {
                session.logout();
            }
        }
    if (error!=null) {
        log.error(error);
    } 
    String path = localproperties.get("redirect", "");
    if ("".equals(path)) {
          FormsHelper.redirectToReferrer(slingRequest, slingResponse, new HashMap<String, String[]>());
    } else {
        if (path.indexOf(".")<0) {
            path += ".html"; 
        }
        if(null == authorizable){
			Map<String, String[]> params = new HashMap<String, String[]>();	
			params.put("error", new String[] {"User does not exist"});
			FormsHelper.redirectToReferrer(slingRequest, slingResponse, params);
        }else{
        	 response.sendRedirect(slingRequest.getResourceResolver().map(request, path));
        }
    }
%>