<%@include file="/libs/foundation/global.jsp" %>


<div class="content">
		<!-- Content :Starts -->
        <div class="topContentArea">
            <div class="main">
                <div class="clear"></div>
                <div class="contentWrapper">
                    <!-- Left Menu Accordion -->
                    <aside>
                       
                   		<cq:include path="left" resourceType="aah/paccalVet/components/base/leftNavigation"/>
                    
                    </aside>
                    <article class="rightContentArea">
                       <cq:include path="center" resourceType="foundation/components/parsys"/>
                    </article>
                </div>
            </div>
        </div>
            <div class="middleContentArea">
           <article class="main">
			<div class="innerContent">
           		<cq:include path="bottom" resourceType="foundation/components/parsys"/>
               </div>
           </article> 
           <div class="clear"></div>
        </div>

        <!-- Content : Ends -->
</div>	

