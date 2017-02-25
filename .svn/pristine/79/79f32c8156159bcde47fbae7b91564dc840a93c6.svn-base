<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="com.paccalVet.FormComponents,
                java.util.Map"%>
<sling:defineObjects/>
<cq:includeClientLib categories="paccalVet.all.form"/>

<%
    String error = request.getParameter("error"); 
%>
<div class="loginRegisterContent">
    <h2 class="loginH2">Change Password</h2>
    <section>
        <form method="POST" action="${resource.path}.profile.html" enctype="multipart/form-data" onSubmit="return validator(this);" novalidate>
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
                            <input type="submit"  name="sumit" value="Submit" class="button" onclick="javascript:document.getElementById('submitAction').value='change';return true;" />
                        </div>
                         <input type="hidden" id="submitAction" name="submitAction" value="" class="button" />
                    </div>
                </div>                
            </fieldset>
        </form>
    </section>
</div>

