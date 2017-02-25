<%@page session="false"%>
<%@ page import="com.day.cq.commons.Doctype,
    com.day.cq.wcm.api.WCMMode,
     com.day.cq.wcm.foundation.Image" %><%
%><%@include file="/libs/foundation/global.jsp"%><%


    Image image = new Image(resource, "image");

%>


						<figure class="vectorSmartObject">
						<% image.draw(out); %>

						</figure>
						<section>
							<p><%=properties.get("text","")%></p>


						</section>










