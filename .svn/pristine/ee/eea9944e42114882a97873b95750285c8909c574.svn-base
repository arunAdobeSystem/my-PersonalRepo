<%@include file="/libs/foundation/global.jsp"%><%
%><%@page import="com.day.cq.wcm.api.WCMMode,
    com.day.cq.widget.HtmlLibraryManager" %><%
if (WCMMode.fromRequest(request) != WCMMode.DISABLED) {
    HtmlLibraryManager htmlMgr = sling.getService(HtmlLibraryManager.class);
    if (htmlMgr != null) {
        htmlMgr.writeCssInclude(slingRequest, out, "cq.wcm.edit");
        htmlMgr.writeJsInclude(slingRequest, out, "cq.wcm.edit");
        htmlMgr.writeJsInclude(slingRequest, out, "wu.widgets");
        out.flush();
        //htmlMgr.writeJsInclude(slingRequest, out, "cq.wcm.edit", "training.widgets");
    }
    String dlgPath = null;
    if (editContext != null && editContext.getComponent() != null) {
        dlgPath = editContext.getComponent().getDialogPath();
    }
    %>
    <script type="text/javascript" >
        var fct = function() {
            CQ.WCM.launchSidekick("<%= currentPage.getPath() %>", {
                propsDialog: "<%= dlgPath == null ? "" : dlgPath %>",
                locked: <%= currentPage.isLocked() %>
            });
        };
        window.setTimeout(fct, 1);
    </script><%
}
%>
