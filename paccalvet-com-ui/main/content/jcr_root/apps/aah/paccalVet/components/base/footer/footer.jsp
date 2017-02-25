<%@include file="/libs/wcm/global.jsp"%>

<%
String forvetText = properties.get("forvet","For veterinary oncologists");
String vetLink = properties.get("vLink","/content/aah/paccalvet/en/vet/login");
String forpetText = properties.get("forpet","For dog owners");
String petLink = properties.get("petLink","/content/aah/paccalvet/en/owners");
String prescribingText = properties.get("pi","Prescribing Information");
String prescribingLink = properties.get("piLink","/content/dam/aah/paccalvet/docs/Prescribing_Info.pdf");

String riskInformationText = properties.get("ri","Important Risk Information");
String riskInformationLink = properties.get("rLink","");


String privacyText  = properties.get("pp","Privacy Policy");
String privacyLink = properties.get("ppLink","http://www.abbott.com/global/url/content/en_US/0:0/general_content/General_Content_00029.htm");
String touText = properties.get("tou","Terms Of Use");
String touLink = properties.get("touLink","http://www.abbott.com/global/url/content/en_US/0:0/general_content/General_Content_00014.htm");

String firstPara = properties.get("fpara","Enter The Text");
String copyRightText = properties.get("spara","Enter The Text");

String privacyCheck=properties.get("pcheck","");

String touCheck=properties.get("toucheck","");

String pwol=properties.get("pwol","");
String touwol=properties.get("twol","");

String footerLogo = properties.get("fLink","");


%>


<footer>
    <div class="footer-left-part"><img src="<%=footerLogo%>" title="" alt="" /></div>
    <div class="footer-right-part">
 <nav>
 <ul>
 <li><a href="<%=vetLink%>.html" title="<%=forvetText%>"><%=forvetText%></a> <span>|</span></li>
<li><a href="<%=petLink%>.html" title="<%=forpetText%>"><%=forpetText%></a> <span>|</span></li>
<li><a href="<%=prescribingLink%>" title="<%=prescribingText%>" target="_blank"><%=prescribingText%></a> <span>|</span></li>


<li><a href="<%=riskInformationLink%>" title="Important Risk Information" target="_blank"><%=riskInformationText%></a> <span>|</span></li>

<% if(privacyCheck.equals("true")){%>
<li><a target="_blank" href="<%=privacyLink%>"  title="Privacy Policy">Privacy Policy</a> <span>|</span></li>
<% } else if(pwol.equals("true")){ %>
<li><a  href="<%=privacyLink%>" data-reveal-id="approvedOrder" onclick="getUrl(this)" data-animation="fade" title="Privacy Policy">Privacy Policy</a> <span>|</span></li>
<%} else {%>
<li><a href="<%=privacyLink%>"  title="Privacy Policy">Privacy Policy</a> <span>|</span></li>
<%}%>
<% if(touCheck.equals("true")){%>
<li><a target="_blank"  href="<%=touLink%>"  title="Terms of Use">Terms of Use</a> </li>
<% } else if(touwol.equals("true")){ %>
<li><a href="<%=touLink%>" data-reveal-id="approvedOrder" onclick="getUrl(this)" data-animation="fade" title="Terms of Use">Terms of Use</a> </li>
<%} else  {%>
<li><a href="<%=touLink%>"  title="Terms of Use">Terms of Use</a> </li>
   <%}%>                        
 </ul>
</nav>
<p class="footerContainer"><%=firstPara%>
<%= properties.get("commodityNumber", "")%>.
    </p>
    </div>
 </footer>


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

