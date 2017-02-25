<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="com.paccalVet.FormComponents,
                java.util.Map"%>
<sling:defineObjects/>
<cq:includeClientLib categories="paccalvet.all"/>

<%
    String error = request.getParameter("error");
    Map<String, String> data = FormComponents.getUserProfile(slingRequest, resource,sling);    
	if(data != null){
%>
<div class="loginRegisterContent">
    <h2 class="loginH2">Profile</h2>
    <section>
        <form method="POST" action="${resource.path}.profile.html" enctype="multipart/form-data" onSubmit="return validator(this);">

			<!-- Hidden Field is required for retaining the previous values -->
            <input type="hidden" id="editForm" />

            <fieldset class="formFields">
                <div class="leftContainor">
                <% if(error != null){ %>
                    <ul>
                        <li><strong style="color:red;"><%=error%></strong></li>
                    </ul>
                <% } %>
                    <ul>
                        <li><label for="txtName">Name <span class="required">&nbsp;</span></label><input type="text" value="<%=data.get("txtName") == null ? null : data.get("txtName")%>" id="txtName" name="txtName" validate="true" errorTitle="" class="inputField" autofocus /></li>
                        <li><label for="txtAddress">Clinic Address <span class="required">&nbsp;</span></label><input type="text" value="<%=data.get("txtAddress") == null ? null : data.get("txtAddress")%>" id="txtAddress"  name="txtAddress" validate="true" errorTitle="" class="inputField" /></li>
                        <li><label for="txtState">Clinic State <span class="required">&nbsp;</span></label><input type="text" validate="true" value="<%=data.get("txtState") == null ? null : data.get("txtState")%>" id="txtState" name="txtState"  errorTitle="" class="inputField" /></li>
                        <li><label for="txtZipCode">Clinic Zip (Postal) Code <span class="required">&nbsp;</span></label><input type="text" value="<%=data.get("txtZipCode") == null ? null : data.get("txtZipCode")%>" id="txtZipCode" validate="true" errorTitle="" name="txtZipCode" class="inputField" /></li>

                        <li><label for="txtPhoneNo">Clinic Phone No</label><input type="text" value="<%=data.get("txtPhoneNo") == null ? null : data.get("txtPhoneNo")%>"id="txtPhoneNo" name="txtPhoneNo" errorTitle="" validate="true" class="inputField" style="padding-left:2px" /></li>
                    </ul>

                </div>
                <div class="rightContainor">
                    <ul>
                        <li><label for="txtEmailAddress">Email Address</label><input type="email" value="<%=data.get("txtEmailAddress") == null ? null : data.get("txtEmailAddress")%>" readonly="readonly" id="txtEmailAddress" name="txtEmailAddress" class="inputField disableField" /></li>
                        <li><label for="txtCity">Clinic City <span class="required">&nbsp;</span></label><input type="text" value="<%=data.get("txtCity") == null ? null : data.get("txtCity")%>" id="txtCity" name="txtCity" validate="true" errorTitle="" class="inputField" /></li>
                        <li><label for="txtClinic">Clinic Name<span class="required">&nbsp;</span></label><input type="text" value="<%=data.get("txtClinic") == null ? null : data.get("txtClinic")%>" id="txtClinic" name="txtClinic" validate="true" errorTitle="" class="inputField" /></li>
  				
						<input type="hidden" name="txtoptInHid" id="txtoptInHid" value="abc" validatesp="true" />

						<input type="hidden" name="txtBlank" id="txtBlank" value="null" />	


                        <li class="alignleft"><input type="checkbox" id="txtoptIn" validatesp="true" <% if(data.get("txtoptInHid").equals("on")) { out.print("checked"); }else{out.print("unchecked");} %> value="<%=data.get("txtoptInHid") == null ? null : data.get("txtoptIn")%>"  name="txtoptIn" class="checkbox"  /><span>Yes I would like to receive updates on the product.</span></li>    

                    </ul>
                    <div class="buttonPanel"> 
                        <div class="buttonBlock">
                            <input type="submit"  name="sumit" value="Save Profile" class="button" onclick="javascript:document.getElementById('submitAction').value='save';return true;" />
                        </div>
                       <input type="hidden" id="submitAction" name="submitAction" value="" class="button" />
                    </div>
                </div>                
            </fieldset>
        </form>
    </section>
</div>

	<%
                    }
				%>

