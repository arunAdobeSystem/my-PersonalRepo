<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="com.paccalVet.FormComponents,
                java.util.Map"%>
<sling:defineObjects/>
<cq:includeClientLib categories="paccalvet.all"/>

<%
    String error = request.getParameter("error");
    final String key = request.getParameter("ky") == null ? null : slingRequest.getRequestParameter("ky").getString();
    final String uid = request.getParameter("uid") == null ? null : slingRequest.getRequestParameter("uid").getString();
  
%>
<div class="loginRegisterContent">
    <h2 class="loginH2"><%=properties.get("heading","enter title")%></h2>
    <section>
        <form method="POST" action="${resource.path}.changepassword.html" enctype="multipart/form-data" onSubmit="return validator(this);" novalidate>
            <fieldset class="formFields">                
                <div class="leftContainor">
                <% if(error != null){ %>
                    <ul>
                        <li><strong style="color:red;"><%=error%></strong></li>
                    </ul>
                <% } %>
                    <ul>
                        <li><label for="txtPassword">New Password <span class="required">&nbsp;</span></label><input type="password" value="" minlength="6" validate="true" errorTitle=""  id="txtPassword" name="txtPassword" class="inputField" /></li>
                    </ul>
                </div>
                <div class="rightContainor">
                    <ul>
                        <li><label for="txtConfirmPassword">Confirm Password <span class="required">&nbsp;</span></label><input type="password" value="" minlength="6" validate="true" errorTitle="" id="txtConfirmPassword" name="txtConfirmPassword" class="inputField" /></li>
                    </ul>
                    <div class="buttonPanel">
                        <div class="buttonBlock">
                            <input type="submit"  name="sumit" value="Submit" class="button" onclick="javascript:document.getElementById('submitAction').value='passwordChange';return true;" />
                        </div>
                         <input type="hidden" id="submitAction" name="submitAction" value="" class="button" />
                         <input type="hidden" id="ky" name="ky" value="<%=key%>"  />
                         <input type="hidden" id="uid" name="uid" value="<%=uid%>" />
                    </div>
                </div>                
            </fieldset>
        </form>
    </section>
</div>

