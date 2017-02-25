<%@include file="/libs/foundation/global.jsp"%>
<cq:include script="/apps/aah/paccalVet/global/init.jsp"/>
<%@page import="com.paccalVet.FormComponents"%>
<%try{
   FormComponents.redirectToLoginPage(slingRequest,slingResponse, currentStyle, currentPage);
}catch(Exception e){}
%>

<cq:include script="head.jsp"/>
<cq:include path="clientcontext" resourceType="cq/personalization/components/clientcontext"/>

<div class="mainWrapper">
    <div class="innermainWrapper">
        <!-- Header: Starts -->
        <div class="headerWrapper clearfix">

        <cq:include script="header.jsp"/>  
               
        </div>
        <!-- Header: End -->
        <!-- Content: Starts -->

         <cq:include script="content.jsp"/>

           <!-- Content: End -->
<!-- Footer : Starts-->
        <div class="footer clearfix">
  		<cq:include script="footer.jsp"/> 

        </div>

        <!-- Footer : End-->
</div>
</div>
<cq:include path="cloudservices" resourceType="cq/cloudserviceconfigs/components/servicecomponents"/>