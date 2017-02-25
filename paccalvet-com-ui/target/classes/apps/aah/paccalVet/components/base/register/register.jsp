<%@include file="/libs/foundation/global.jsp"%>
<sling:defineObjects/>
<cq:includeClientLib categories="paccalvet.all"/>

<%
    String error = request.getParameter("error");
   
    
%>
<div class="loginRegisterContent">
    <br>

       <h2 class="loginH2"><%=properties.get("heading","enter title")%></h2>

    <section class="padding-adj">
        <form method="POST" action="${resource.path}.register.html" enctype="multipart/form-data" onSubmit="return validator(this);" novalidate>



            <fieldset class="formFields">
                <div class="leftContainor">
                <% if(error != null){ %>
                    <ul>
                        <li><strong style="color:red;"><%=error%></strong></li>
                    </ul>
                <% } %>
                    <ul>
                        <li><label for="txtName"><%=properties.get("name","")%><span class="required">&nbsp;</span></label><input type="text" value="" tabindex="1" validate="true" errorTitle="" id="txtName" name="txtName" class="inputField"  autofocus /></li>
                        <li><label for="txtPassword"><%=properties.get("password","")%><span class="required">&nbsp;</span></label><input type="password" value="" tabindex="3" minlength="6" validate="true" errorTitle=""  id="txtPassword" name="txtPassword" class="inputField" /></li>
                        <li><label for="txtAddress"><%=properties.get("address","") %><span class="required">&nbsp;</span></label><input type="text" value="" tabindex="5" validate="true" errorTitle="" id="txtAddress" name="txtAddress" class="inputField"/></li>
                        <li><label for="txtState"><%=properties.get("state","")%><span class="required">&nbsp;</span></label><input type="text" value="" tabindex="7" validate="true" errorTitle="" id="txtState" name="txtState" class="inputField"  /></li>
                        <li><label for="txtPhoneNo"><%=properties.get("phoneno","")%></label><input type="text" value="" tabindex="9" validate="true" errorTitle="" id="txtPhoneNo" name="txtPhoneNo" class="inputField" /></li>                        
                        <li class="alignleft termPolicy"><input type="checkbox" name="termPolicyGroup" class="checkbox" tabindex="11"/><span class="required">&nbsp;</span><span><%=properties.get("tou","")%></span></li>
                    </ul>
                </div>
                <div class="rightContainor">
                    <ul>
                        <li><label for="txtEmailAddress"><%=properties.get("email","")%><span class="required">&nbsp;</span></label><input type="email" value="" tabindex="2" validate="true" errorTitle="" id="txtEmailAddress" name="txtEmailAddress" class="inputField" /></li>
                        <li><label for="txtConfirmPassword"><%=properties.get("cpassword","")%><span class="required">&nbsp;</span></label><input type="password" value="" tabindex="4" minlength="6" validate="true" errorTitle="" id="txtConfirmPassword" name="txtConfirmPassword" class="inputField" /></li>
                        <li><label for="txtCity"><%=properties.get("city","")%><span class="required">&nbsp;</span></label><input type="text" value="" tabindex="6" validate="true" errorTitle="" id="txtCity" name="txtCity" class="inputField" /></li>
                        <li><label for="txtZipCode"><%=properties.get("zip","")%><span class="required">&nbsp;</span></label><input type="text" value="" tabindex="8" errorTitle="" validate="true" id="txtZipCode" name="txtZipCode" class="inputField" /></li>
                        <li><label for="txtClinic"><%=properties.get("clinic","")%> <span class="required">&nbsp;</span></label><input type="text" value="" tabindex="10" validate="true" errorTitle="" id="txtClinic" name="txtClinic" class="inputField"  /></li>
			             <li class="alignleft">
						<input type="hidden" name="txtoptInHid" id="txtoptInHid" value="abc" validatesp="true" />
						<input type="hidden" name="txtBlank" id="txtBlank" value="null" />	
                        <input type="checkbox" id="txtoptIn" name="txtoptIn" validatesp="true" value="on" class="checkbox" tabindex="12"/><span><%=properties.get("update","")%></span>
                        </li>
                    </ul>
                    <div class="buttonBottomBlock"><input type="submit" disabled="disabled" value="Submit" id="submit" class="button disableButton btnRegister"/></div>
                    <div class="clear"></div>
                </div>
					<div class="clear"></div>
            </fieldset>
        </form>
    </section>
    <div class="clear"></div>
</div>

