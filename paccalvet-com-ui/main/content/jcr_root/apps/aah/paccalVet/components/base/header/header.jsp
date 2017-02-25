<%@include file="/libs/foundation/global.jsp"%>

<%@page session="false" %>
<%@page import="com.day.cq.wcm.foundation.Image,
                com.day.cq.security.profile.Profile,
                com.day.cq.personalization.ProfileUtil,
                com.day.cq.security.Authorizable,
                org.apache.sling.api.resource.Resource,
                org.apache.sling.api.resource.ResourceResolver"%>

<%

		String path = currentPage.getPath();

		String homePagePath="/content/aah/paccalvet/en/index.html";
%>

<h1 class="siteLogo1"><a target="_blank" href="http://www.abbott.com"><img src="/etc/designs/aah/paccalvet/clientlib/images/abbotLogo.png" alt="Abbott" title="Abbott" /></a></h1>
<h2><a href="<%=homePagePath%>" class="header-logo"><img src="/etc/designs/aah/paccalvet/clientlib/images/headerTitle.png" alt="Paccal Vet - CA1" title="Paccal Vet - CA1" style="float:left;" /></a></h2>


