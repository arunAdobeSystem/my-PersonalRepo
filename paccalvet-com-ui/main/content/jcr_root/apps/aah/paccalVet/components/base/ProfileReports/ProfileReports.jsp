<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="com.day.cq.wcm.foundation.Search,com.day.cq.*,org.apache.sling.api.*,com.sun.org.apache.*,com.day.cq.tagging.*,java.util.*,java.util.ResourceBundle,java.util.Iterator,org.apache.sling.api.resource.ResourceResolver,com.day.cq.*"%>


<script type="text/javascript"> 
function ExportToExcel(mytbl)
 
    {

        var htmltable= document.getElementById(mytbl);
 
        var html = htmltable.outerHTML;
 



// MS OFFICE 2003  : data:application/vnd.ms-excel
 
// MS OFFICE 2007  : application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
 



        window.open('data:application/vnd.ms-excel,' + encodeURIComponent(html)); 

    }
 
</script>

<%
String optInValue;


 %>

<table id="mytbl"  border="1" width="100%" align="left">
<tr>
<th>Email Id</th>
<th>Name</th>
<th>Clinic Name</th>
<th>Clinic Address</th>
<th>Clinic City</th>    
<th>Clinic State</th>
<th>Zip Code</th>    
<th>Clinic Phone</th>
<th>Opt In</th>
</tr>

<%
Iterator<Resource> iter = resourceResolver.findResources("/jcr:root/home/users/paccalvet//element(*,rep:User)", "xpath");

//Iterate thru all sling resources
while(iter.hasNext()) {

    try{
                Resource user = iter.next();
                //get jcr node
                Node userNode = user.adaptTo(Node.class);
                // get profile node and initialise
                Node userProfNode = userNode.getNode("profile");    
                // get profile node
              
				String userId = userProfNode.getProperty("email").getString();
    			String name = userProfNode.getProperty("txtName").getString();
				String address = userProfNode.getProperty("txtAddress").getString();
    			String city = userProfNode.getProperty("txtCity").getString();
				String clinic = userProfNode.getProperty("txtClinic").getString();
    			String phoneNo = userProfNode.getProperty("txtPhoneNo").getString();
				String state = userProfNode.getProperty("txtState").getString();
    			String zipCode = userProfNode.getProperty("txtZipCode").getString();
        		String optIn=userProfNode.getProperty("txtoptInHid").getString();

        if(optIn.equals("on")){

            optInValue="Yes";

        }else{

		optInValue="No";
        }

				%>
    
<tr>
<td><%=userId%></td>
<td><%=name%></td>
<td><%=clinic%></td>
<td><%=address%></td>
<td><%=city%></td>
<td><%=state%></td>
<td><%=zipCode%></td>
<td><%=phoneNo%></td>
<td><%=optInValue%></td>


</tr>

<%
    }catch(Exception e){}
}

%>





</table> 
<div></div>&nbsp;&nbsp;&nbsp;<br>
<div style="padding-top:20px;">
<a id="clickToExcel" href="javascript:ExportToExcel('mytbl')">Export To Excel</a>
</div>




