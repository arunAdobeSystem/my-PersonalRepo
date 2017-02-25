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
      <h2 class="loginH2"><%="Profile"%></h2>
    <section>
        <form method="POST" action="${resource.path}.profile.html" enctype="multipart/form-data" onSubmit="return validator(this);" novalidate>
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
                        <li><label for="txtName">Name</label><input type="text" value="<%=data.get("txtName") == null ? null : data.get("txtName")%>" readonly="readonly" id="txtName" name="txtName" class="inputField disableField" autofocus /></li>
                        <li><label for="txtAddress">Clinic Address</label><input type="text" value="<%=data.get("txtAddress") == null ? null : data.get("txtAddress")%>" readonly="readonly" id="txtAddress" name="txtAddress" class="inputField disableField" /></li>
                        <li><label for="txtState">Clinic State</label><input type="text" value="<%=data.get("txtState") == null ? null : data.get("txtState")%>" readonly="readonly" id="txtState" name="txtState" class="inputField disableField" /></li>


                        <li><label for="txtPhoneNo">Clinic Phone No</label><input type="text" value="<%=data.get("txtPhoneNo") == null ? null : data.get("txtPhoneNo")%>" readonly="readonly" id="txtPhoneNo" name="txtPhoneNo" class="inputField disableField" /></li>
                    </ul>
                </div>
                <div class="rightContainor">
                    <ul>
                        <li><label for="txtEmailAddress">Email Address </label><input type="email" value="<%=data.get("txtEmailAddress") == null ? null : data.get("txtEmailAddress")%>" readonly="readonly" id="txtEmailAddress" name="txtEmailAddress" class="inputField disableField" /></li>
                        <li><label for="txtCity">Clinic City</label><input type="text" value="<%=data.get("txtCity") == null ? null : data.get("txtCity")%>" readonly="readonly" id="txtCity" name="txtCity" class="inputField disableField" /></li>
                        <li><label for="txtZipCode">Clinic ZIP (Postal) Code</label><input type="text" value="<%=data.get("txtZipCode") == null ? null : data.get("txtZipCode")%>" readonly="readonly" id="txtZipCode" name="txtZipCode" class="inputField disableField" /></li>
                        <li><label for="txtClinic">Clinic Name </label><input type="text" value="<%=data.get("txtClinic") == null ? null : data.get("txtClinic")%>" readonly="readonly" id="txtClinic" name="txtClinic" class="inputField disableField" /></li>


                        <li class="alignleft"><input type="checkbox" readonly="readonly" disabled="disabled" <% if(data.get("txtoptInHid").equals("on")) { out.print("checked"); }else { out.print("unchecked");}%> value="<%=data.get("txtoptInHid") == null ? null : data.get("txtoptInHid")%>"  name="txtoptIn" class="checkbox"  /><span>Yes I would like to receive updates on the product.</span></li>    
						<input type="hidden" name="txtBlank" id="txtBlank" value="null" />	

                    </ul>
                    <div class="buttonPanel">
                            <div class="buttonBlock">                                
                                <input type="submit" name="sumit" value="Change Password" class="button" onclick="javascript:document.getElementById('submitAction').value='changePassword';return true;" />
                            </div>
                         <div class="buttonBlock">
                            <input type="submit" name="sumit" value="Edit Profile" class="button" onclick="javascript:document.getElementById('submitAction').value='edit';return true;" />
                        </div>
                        <input type="hidden" id="submitAction" name="submitAction" value="" class="button" />
                    </div>
                </div>                
            </fieldset>
        </form>
    </section>
</div>

<script>

</script>

			<%
                    }
				%>
