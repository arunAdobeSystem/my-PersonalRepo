<%@include file="/libs/foundation/global.jsp"%>


<%

String text=properties.get("text","text");
String link=properties.get("link","link");
String check=properties.get("newWindow","");
String wol=properties.get("wol","");




%>

<%if(check.equals("true")) {%>

  <p><a target="_blank" href="<%=link%>"><%=text%></a></p>

<% } else if(wol.equals("true")){ %>

<p><a href="<%=link%>" data-reveal-id="approvedOrder" onclick="getUrl(this)" data-animation="fade"><%=text%></a></p> 

<% } else {%>   

 <p><a href="<%=link%>"><%=text%></a></p>

<% }%>

<!-- approved order -->
<div id="approvedOrder" class="reveal-modal approvedOrder medium">
	<div class="modalHeader">
    	You are about to leave for a 3rd party website <a href="javascript:void(0);" class="closeModalLink close-reveal-modal">&nbsp;&nbsp;&nbsp;&nbsp;</a>
    </div>
    <div class="modalContent">
		<div>        	
            <p>The "Yes" link below will take you out of the Abbott Laboratories family of websites.</p>
            <p>Links which take you out of Abbott Laboratories worldwide web sites are not under the control of Abbott Laboratories,
            and Abbott Laboratories is not responsible for the contents of any such site or any further links from such site.</p>
            <p>Abbott Laboratories is providing these links to you only as a convenience, and the inclusion of any link does not imply
            endorsement of the linked site by Abbott Laboratories.</p>
        </div>
        <div class="instructionsModal">
        	  <p>Do you wish to leave this site?</p>
        </div>

        <div class="modalButtons">
        	<a href="#" class="activeBtn close-reveal-modal" id="externalUrl" target="_blank">Yes</a>
			<a href="javascript:void(0);" class="inActiveBtn close-reveal-modal" >No</a>   	   
        </div>
	</div>
</div>
<!-- /approved order -->
