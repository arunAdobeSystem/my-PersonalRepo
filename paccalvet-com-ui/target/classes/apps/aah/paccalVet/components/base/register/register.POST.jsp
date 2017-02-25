<%@include file="/libs/foundation/global.jsp"%><cq:defineObjects />
<%@page session="false" %>
<%@ page import="com.paccalVet.FormComponents"%>
<%

FormComponents.registerNewUser(request, slingRequest,slingResponse,resource,sling);

%>