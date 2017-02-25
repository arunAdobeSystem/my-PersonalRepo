<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="java.util.Iterator,
                com.day.cq.wcm.api.PageFilter" %>

 
 <%
 String vetRootPath = "/content/aah/paccalvet/en/vet";
 Page   vetRootPage = slingRequest.getResourceResolver().adaptTo(PageManager.class).getPage(vetRootPath);

 String vetTitle = "";
 String vetPath="";

if(vetRootPage!=null){
vetTitle=vetRootPage.getTitle();
vetPath=vetRootPage.getPath();

}
else{
String vetLoginPath="/content/aah/paccalvet/en/login";
Page vetLoginPage=slingRequest.getResourceResolver().adaptTo(PageManager.class).getPage(vetLoginPath);

    if(vetLoginPage!=null){

	vetTitle=vetLoginPage.getNavigationTitle();
	vetPath=vetLoginPath;


    }


}

 String ownerPath="/content/aah/paccalvet/en/owners";
 Page petRootPage = slingRequest.getResourceResolver().adaptTo(PageManager.class).getPage(ownerPath);


 String petTitle=petRootPage.getTitle();
 String petPath="/content/aah/paccalvet/en/owners";


// get navigation root page
Page navRootPage = currentPage.getAbsoluteParent(4);



// check to make sure the page exists
if (navRootPage == null) {
    navRootPage = currentPage;
} 

%>



<% if(currentPage.getAbsoluteParent(4).getTitle().equals(vetTitle)){ %>

 <aside>



     						<nav>

                            <ul class="parentNav" >
                            
                                 
                                <li>
                                    <a href="<%=vetPath%>.html" title="<%=vetTitle%>"><%=vetTitle%></a>
                                </li>
                            </ul>







   <ul class="innerNav" style="display: block";>
                            
          <% 
if (navRootPage!= null){
    // create an iterator object of all nav root's child pages
    Iterator<Page> children = navRootPage.listChildren(new PageFilter());

    while (children.hasNext()) {
        // get next child page
        Page child = children.next();
        
        // display the link in an <A HREF...
       
        
        %>


       <%if(currentPage.getTitle()==child.getTitle()){ %>

 <li class="activeMenuItem">

  <a href="<%= child.getPath()%>.html"><%=child.getTitle()%></a>
 </li>



       <% } else { %>

       <li>
 
  <a href="<%= child.getPath()%>.html"><%=child.getTitle()%></a>
 </li>

       <% }%>

       <%


    }
} 
%>             
                            </ul>
                            
                            
                            
                            <ul class="parentNav" >
                                <li>
                                    <a href="<%=petPath%>.html"><%=petTitle%></a>
                                </li>
                            </ul>
                            
 </nav>
 </aside>
                   
       
<% } else  if(currentPage.getAbsoluteParent(4).getTitle().equals(petTitle)) {%> 


 <aside>



     						<nav>

                            <ul class="parentNav">
                            
                                 
                                <li>
                                    <a href="<%=petPath%>.html" title="<%=petTitle%>"><%=petTitle%></a>
                                </li>
                            </ul>







   <ul class="innerNav" style="display: block";>

          <% 
if (navRootPage!= null){
    // create an iterator object of all nav root's child pages
    Iterator<Page> children = navRootPage.listChildren(new PageFilter());

    while (children.hasNext()) {
        // get next child page
        Page child = children.next();
        
        // display the link in an <A HREF...
       
        
        %>
                                                         

       <%if(currentPage.getTitle()==child.getTitle()){ %>

 <li class="activeMenuItem">
 
  <a href="<%= child.getPath()%>.html"><%=child.getTitle()%></a>
 </li>



       <% } else { %>

       <li>
 
  <a href="<%= child.getPath()%>.html"><%=child.getTitle()%></a>
 </li>

       <% }%>





       <%
    }
} 
%>             
                            </ul>
                            
                            

                            <ul class="parentNav">
                                <li>
                                    <a href="<%=vetPath%>.html"><%=vetTitle%></a>
                                </li>
                            </ul>
                            
 </nav>
 </aside>

<% } else { %>



 <aside>



     						<nav>

                            <ul class="parentNav">
                            

                                <li>
                                    <a href="<%=vetPath%>.html" title="<%=vetTitle%>"><%=vetTitle%></a>
                                </li>
                            </ul>


 							<ul class="parentNav">
                                <li>
                                    <a href="<%=petPath%>.html"><%=petTitle%></a>
                                </li>
                            </ul>
                            
 </nav>
 </aside>


<% }%>
        
  



                      
