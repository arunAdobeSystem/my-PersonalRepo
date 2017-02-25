<%@page import="com.day.cq.wcm.api.WCMMode,
                org.apache.commons.lang3.StringUtils"%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@page session="false" %><%
%><%
    String videoScript = properties.get("videoSource", "");
    if (WCMMode.fromRequest(request) == WCMMode.EDIT || WCMMode.fromRequest(request) == WCMMode.DESIGN )  {
    	if (StringUtils.isEmpty(videoScript)) {
    		out.println("The video script editor component has not been configured.");
    	}
    }
    out.println(videoScript);
%>