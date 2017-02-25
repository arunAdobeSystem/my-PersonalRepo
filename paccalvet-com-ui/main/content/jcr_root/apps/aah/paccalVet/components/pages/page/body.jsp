<%@include file="/libs/foundation/global.jsp"%>
<cq:include script="/apps/aah/paccalVet/global/init.jsp"/>


<cq:include script="head.jsp"/>

<cq:include path="clientcontext" resourceType="cq/personalization/components/clientcontext"/>

<!-- Main Wrapper :Parent Template Starts -->
    <div class="mainWrapper">
	<div class="innermainWrapper">
        <!-- Header -->
        <div class="headerWrapper">

           <cq:include script="header.jsp"/>

            </div>

        <!-- content -->
        <cq:include script="content.jsp"/>  

        <!-- Footer -->

            <cq:include script="footer.jsp"/>  
       


    </div>
</div>

<cq:include path="cloudservices" resourceType="cq/cloudserviceconfigs/components/servicecomponents"/>
