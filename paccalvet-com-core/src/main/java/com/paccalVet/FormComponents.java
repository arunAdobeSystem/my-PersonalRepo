package com.paccalVet;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.jcr.AccessDeniedException;
import javax.jcr.RepositoryException;
import javax.jcr.Session;
import javax.jcr.SimpleCredentials;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.request.RequestParameter;
import org.apache.sling.api.request.RequestParameterMap;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.resource.ResourceResolver;
import org.apache.sling.api.resource.ResourceUtil;
import org.apache.sling.api.resource.ValueMap;
import org.apache.sling.api.scripting.SlingScriptHelper;
import org.apache.sling.jcr.api.SlingRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.commons.LanguageUtil;
import com.day.cq.personalization.ProfileUtil;
import com.day.cq.security.AccountManager;
import com.day.cq.security.AccountManagerFactory;
import com.day.cq.security.User;
import com.day.cq.security.UserManager;
import com.day.cq.security.UserManagerFactory;
import com.day.cq.security.profile.Profile;
import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageManager;
import com.day.cq.wcm.api.designer.Style;
import com.day.cq.wcm.foundation.forms.FormsHelper;

public class FormComponents {
	
	private static final Logger LOG = LoggerFactory.getLogger(FormComponents.class);
	final static String LOGINID = "txtEmailAddress";
	final static String PWD = "txtPassword";
    final static String PWD_CONFIRM = "txtConfirmPassword";
    final static String NAME = "txtName";
    final static String ADDRESS = "txtAddress";
    final static String STATE = "txtState";
    final static String ZIP = "txtZipCode";
    final static String PHONENO = "txtPhoneNo";
    final static String PHONENOVALUE="";
    final static String CITY = "txtCity";
    final static String CLINIC = "txtClinic";
    final static String OPTIN = "txtoptInHid";
    final static String SUBMIT = "submit";
    final String MEMBER_OF = "memberOf";
    final static String REDIRECT = "redirect";
    final static String HOME = "home";
    final static String INTER_PATH = "intermediatePath";
    final static String EMAIL_TEMPLATE_PATH_USERNAME = "/etc/designs/aah/paccalvet/EmailTemplates/RegistrationConfirmationUserName.txt";
	final static String EMAIL_TEMPLATE_PATH_PASSWORD = "/etc/designs/aah/paccalvet/EmailTemplates/RegistrationConfirmationPassword.txt";
	

     public static void redirectToTargetpage(final HttpServletRequest request, final SlingHttpServletRequest slingRequest, final SlingHttpServletResponse slingResponse, final Resource resource, final SlingScriptHelper sling){
    	Session session = null;
    	final String submitAction = request.getParameter("submitAction")== null? null : slingRequest.getRequestParameter("submitAction").getString();
    	if(StringUtils.isNotBlank(submitAction) && submitAction.equalsIgnoreCase("edit")){    		
			try {
		        String path = getCurrentPagePath(resource);
				slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, path + ".edit.html"));
			} catch (IOException e) {
				LOG.error("Error in Profile EDIT :"+ e.getMessage());
			}
    	    }else if(StringUtils.isNotBlank(submitAction) && submitAction.equalsIgnoreCase("save")){
    		Map<String, RequestParameter[]> userProps = getFormParameter(slingRequest.getRequestParameterMap());
    		try {
				session = getAdminSession(sling);
				User user = getCurrentUser(slingRequest, session, sling); 
				final AccountManagerFactory af = sling.getService(AccountManagerFactory.class);
				af.createAccountManager(session).updateAccount(user, userProps);
	    		String path = getCurrentPagePath(resource);
	    		endAdminSession(session);
	    		slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, path + ".html"));
			} catch (RepositoryException e) {
				LOG.error("Error in Profile SAVE:"+ e.getMessage());
			} catch (IOException e) {
				LOG.error("Error in Profile SAVE :"+ e.getMessage());
			}finally {
				endAdminSession(session);
			}
    	} else if(StringUtils.isNotBlank(submitAction) && submitAction.equalsIgnoreCase("changePassword")){
    		try {
		        String path = getCurrentPagePath(resource);
				slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, path + ".changepassword.html"));
			} catch (IOException e) {
				LOG.error("Error in Profile EDIT :"+ e.getMessage());
			}
    	} else if(StringUtils.isNotBlank(submitAction) && submitAction.equalsIgnoreCase("change")){
    		final ValueMap properties = ResourceUtil.getValueMap(resource);
    		String changePwdPage =  properties.get(REDIRECT, null);
    		final String pwd = request.getParameter(PWD)== null? null : slingRequest.getRequestParameter(PWD).getString();
    		final String confirm_pwd = request.getParameter(PWD_CONFIRM)== null? null : slingRequest.getRequestParameter(PWD_CONFIRM).getString();
    		if(pwd.equals(confirm_pwd)){
    			try {
    				session = getAdminSession(sling);
    				User user = getCurrentUser(slingRequest, session, sling);
    				if(user!= null && changePwdPage != null){
    					user.changePassword(pwd);
    					if (!changePwdPage.endsWith(".html")) {
    	                    changePwdPage += ".html";
    	                }
    					endAdminSession(session);
    					slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, changePwdPage ));
    				}else if(user!= null && changePwdPage == null){
    					user.changePassword(pwd);
    					String path = getCurrentPagePath(resource);
    					endAdminSession(session);
    					slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, path + ".html"));
    				}
    			} catch (RepositoryException e) {
    				LOG.error("Error in Profile SAVE:"+ e.getMessage());
    			} catch (IOException e) {
    				LOG.error("Error in Profile SAVE :"+ e.getMessage());
    			}finally {
    				endAdminSession(session);
    			}
    		}
    	} else if(StringUtils.isNotBlank(submitAction) && submitAction.equalsIgnoreCase("passwordChange")){
    		final ValueMap properties = ResourceUtil.getValueMap(resource);
    		String changePwdPage =  properties.get(REDIRECT, null);
    		final String key = request.getParameter("ky") == null ? null : slingRequest.getRequestParameter("ky").getString();
    	    final String uid = request.getParameter("uid") == null ? null : slingRequest.getRequestParameter("uid").getString();
    	    final String pwd = request.getParameter(PWD)== null? null : slingRequest.getRequestParameter(PWD).getString();
    	    try {
    	    	session = getAdminSession(sling);
    	    	final AccountManagerFactory af = sling.getService(AccountManagerFactory.class);
    	    	AccountManager accountManager = af.createAccountManager(session);
    	    	if (key != null && !key.equals("null") && uid != null && !uid.equals("null")) {
    	    		 User user = accountManager.findAccount(uid);
    	    		 boolean success = accountManager.setPassword(user, key, pwd);
    	    		 if(success && changePwdPage != null){
    	    			 if (!changePwdPage.endsWith(".html")) {
     	                    changePwdPage += ".html";
     	                }
    	    			endAdminSession(session);
     					slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, changePwdPage ));
    	    		 }else if(!success){
    	    			endAdminSession(session);
    	    			Map<String, String[]> params = new HashMap<String, String[]>();	
    	 				params.put("error", new String[] {"Error in Password reset."});
    	 				FormsHelper.redirectToReferrer(slingRequest, slingResponse, params);
    	    		 }
    	    	}else {
    	    		endAdminSession(session);
	    			Map<String, String[]> params = new HashMap<String, String[]>();	
	 				params.put("error", new String[] {"Error in Password reset."});
	 				FormsHelper.redirectToReferrer(slingRequest, slingResponse, params);
	    		 }    	    	
    	     } catch (RepositoryException e) {
				LOG.error("Error in Profile SAVE:"+ e.getMessage());
			}catch (IOException e) {
				LOG.error("Error in Profile SAVE :"+ e.getMessage());
			}finally {
				endAdminSession(session);
			}
    	}
    
    }
    
    private static String getCurrentPagePath(final Resource resource){
        return getCurrentPage(resource).getPath();
    }
    private static Page getCurrentPage(final Resource resource){
    	final ResourceResolver resolver = resource.getResourceResolver();
        final PageManager pmmanager = resolver.adaptTo(PageManager.class);
        return pmmanager.getContainingPage(resource);
    }
    
    private static Session getAdminSession(final SlingScriptHelper sling) throws RepositoryException{
    	final SlingRepository repos = sling.getService(SlingRepository.class);
    	return repos.loginAdministrative(null);
    }
    
    private static void endAdminSession(Session session){
    	if (session!=null) {
            session.logout();
        }
    }
   private static User getCurrentUser(final SlingHttpServletRequest slingRequest, final Session adminSession, final SlingScriptHelper sling) throws AccessDeniedException{
    	final UserManagerFactory userManagerFactory = sling.getService(UserManagerFactory.class);
    	final Profile currentProfile = slingRequest.adaptTo(Profile.class);
	    String id = currentProfile.getAuthorizable().getID();
        UserManager userManager = userManagerFactory.createUserManager(adminSession); 
		return (User) userManager.get(id);
		
    }
    
    public static Map<String, String> getUserProfile(final SlingHttpServletRequest slingRequest, final Resource resource, final SlingScriptHelper sling){
    	Session session = null;  
    	String phoneValue=null;

    	final Profile currentProfile = slingRequest.adaptTo(Profile.class);
		boolean anonymous = ProfileUtil.isAnonymous(currentProfile);
		
			if(!anonymous) {
    	
    	try {
 		
    		Map<String, String> params = new HashMap<String, String>();
    		session = getAdminSession(sling);
    		User user = getCurrentUser(slingRequest, session, sling);    		
    		Profile userProfile = user.getProfile();
    		String name = (String) userProfile.get(NAME); 
    		params.put(NAME, name);
    		String address = (String) userProfile.get(ADDRESS);
    		params.put(ADDRESS, address);
    		String state = (String) userProfile.get(STATE);
    		params.put(STATE, state);
    		String zip = (String) userProfile.get(ZIP);
    		params.put(ZIP, zip);
    		String phoneNo = (String)userProfile.get(PHONENO);
    		params.put(PHONENO, phoneNo);
    		if(phoneNo.equals("null")){
    			params.put(PHONENO, "");	
    		}
    		String city = (String) userProfile.get(CITY);
    		params.put(CITY, city);
    		String clinic = (String) userProfile.get(CLINIC);
    		params.put(CLINIC, clinic);
    		String optIn =(String)userProfile.get(OPTIN);
    		params.put(OPTIN, optIn);
    		String email = (String) userProfile.get("email");
    		params.put(LOGINID, email);
    		return params;
    	} catch (RepositoryException e) {
			LOG.error("Error while accessing Repository :"+ e.getMessage());
		} finally {
			endAdminSession(session);
		}
		}
    	return null;
    }
	
	public static void registerNewUser(final HttpServletRequest request, final SlingHttpServletRequest slingRequest, final SlingHttpServletResponse slingResponse, final Resource resource, final SlingScriptHelper sling){
		
		Session session = null;
		String error = null;
		final ValueMap properties = ResourceUtil.getValueMap(resource);
		final SlingRepository repos = sling.getService(SlingRepository.class);
		final AccountManagerFactory af = sling.getService(AccountManagerFactory.class);
		try {
			session = getAdminSession(sling);
			final String group = properties.get("memberOf", "");
			final String intermediatePath = properties.get(INTER_PATH, null);
			final String auth = request.getParameter(LOGINID)== null? null : slingRequest.getRequestParameter(LOGINID).getString();
			final String pwd = request.getParameter(PWD)==null? null : slingRequest.getRequestParameter(PWD).getString();
			Map<String, RequestParameter[]> userProps = getFormParameter(slingRequest.getRequestParameterMap());
			if(StringUtils.isNotBlank(intermediatePath)){
				FormComponents f = new FormComponents();
				userProps.put("rep:intermediatePath",  new RequestParameter[] {f.new IntermediatePathParam(intermediatePath)});
			}
			if (!authenticate(repos, auth, pwd)) {
                error = "Error credentials do not authenticate";
            }
			
			if(af.createAccountManager(session).findAccount(auth) != null){
				endAdminSession(session);
				error=null;
				Map<String, String[]> params = new HashMap<String, String[]>();	
				params.put("error", new String[] {"User already exist"});
				FormsHelper.redirectToReferrer(slingRequest, slingResponse, params);
			}
			else if(error != null){	
				User user = af.createAccountManager(session).getOrCreateAccount(auth, pwd, group, userProps);
				sendEmailForNewUser(af.createAccountManager(session), user, resource, pwd);
				sendEmailForNewPassword(af.createAccountManager(session), user, resource, pwd);
			}
			
		} catch (RepositoryException e) {
			error = e.getMessage();
			LOG.error("Error while accessing Repository :"+ e.getMessage());
		} catch (Exception e) {
			error = "Error while creating account:";
			LOG.error("Error while creating account: " + e.getMessage());
		} finally {
			endAdminSession(session);
				
			  if(error != null){
	        	try{
					
		        	String path =  StringUtils.isNotBlank(properties.get(REDIRECT, "")) ? properties.get(REDIRECT, "") : properties.get(HOME, "");	
					   	if ("".equals(path)) {
						FormsHelper.redirectToReferrer(slingRequest, slingResponse, new HashMap<String, String[]>());
		            } else {
		            	
		                if (path.indexOf(".")<0) {
		                	
		                    path += ".html"; 
		                }
						slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, path));
		            }
	        	} catch (IOException e) {
	        		LOG.error("Error : " + e.getMessage());
				}
	        }
	    }		
	}
	
	private static boolean sendEmailForNewUser(final AccountManager am, final User user, final Resource resource, final String password) throws RepositoryException, IOException{
		Map<String,String> replace = new HashMap<String,String>();
		replace.put("name", user.getProfile().get("txtName", "User"));
		replace.put("username",  user.getProfile().get("email", "Userid"));
		
		String fromEmailId = "ais_support@abbott.com";
		String emailSubject = "Registration Confirmation";
		Resource emailResource = resource.getResourceResolver().getResource(EMAIL_TEMPLATE_PATH_USERNAME);
		InputStream inputStream = emailResource.adaptTo(InputStream.class);
		int ch;
		final StringBuffer emailBody = new StringBuffer("");
		while ((ch = inputStream.read()) != -1) {
			emailBody.append((char) ch);
        }				
		boolean mailSentSuccess = am.sendMail(user, fromEmailId, emailSubject,  emailBody.toString() , replace);
		
		return mailSentSuccess;
	}

	private static boolean sendEmailForNewPassword(final AccountManager am, final User user, final Resource resource, final String password) throws RepositoryException, IOException{
		Map<String,String> replace = new HashMap<String,String>();
		replace.put("name", user.getProfile().get("txtName", "User"));
		
		replace.put("password",  password);
		String fromEmailId = "ais_support@abbott.com";
		String emailSubject = "Registration Confirmation";
		Resource emailResource = resource.getResourceResolver().getResource(EMAIL_TEMPLATE_PATH_PASSWORD);
		InputStream inputStream = emailResource.adaptTo(InputStream.class);
		int ch;
		final StringBuffer emailBody = new StringBuffer("");
		while ((ch = inputStream.read()) != -1) {
			emailBody.append((char) ch);
        }				
		boolean mailSentSuccess = am.sendMail(user, fromEmailId, emailSubject,  emailBody.toString() , replace);
		
		return mailSentSuccess;
	}
	
	public static void redirectToLoginPage(final SlingHttpServletRequest slingRequest, final SlingHttpServletResponse slingResponse, final Style currentStyle, final Page currentPage){
		final Profile currentProfile = slingRequest.adaptTo(Profile.class);
		boolean anonymous = ProfileUtil.isAnonymous(currentProfile);
			if(anonymous) {
			final String languageRoot = LanguageUtil.getLanguageRoot(currentPage.getPath());
			final String pageLanguage = StringUtils.substringAfterLast(languageRoot, "/");			
			String path = currentStyle.get("loginPage", String.class);			
			path = path.replace("<language>", pageLanguage) + ".html";	
			final String loginPagePath = path;
			try {
				slingResponse.sendRedirect(slingRequest.getResourceResolver().map(slingRequest, loginPagePath));
			} catch (IOException e) {
				LOG.error("Error : " + e.getMessage());
			}
		}
	}
	
	private static Map<String, RequestParameter[]> getFormParameter(RequestParameterMap paras){
		 Map<String, RequestParameter[]> prefs = new HashMap<String, RequestParameter[]>();		 

			 prefs.put(NAME, paras.getValues(NAME));
			 prefs.put(ADDRESS, paras.getValues(ADDRESS));
			 prefs.put(STATE, paras.getValues(STATE));
			 prefs.put(ZIP, paras.getValues(ZIP));
			 prefs.put(PHONENO, paras.getValues(PHONENO));
			 if(StringUtils.isBlank(paras.getValue(PHONENO).getString())){
				 prefs.put(PHONENO,paras.getValues("txtBlank"));
			 }
			 prefs.put(CITY, paras.getValues(CITY));
			 prefs.put(CLINIC, paras.getValues(CLINIC));
			 prefs.put(OPTIN, paras.getValues(OPTIN));
			 
					 
		 return prefs;
	}
	
	private static boolean authenticate(SlingRepository repos, String auth, String pwd) {
        Session session = null;
        try {

			SimpleCredentials creds = new SimpleCredentials(auth, pwd.toCharArray());
            session = repos.login(creds);
            return true;
        } catch (RepositoryException e) {
            return false;
        } finally {
            if (session!=null) {
                session.logout();
            }
        }
    }
	
	private final class IntermediatePathParam implements RequestParameter {

        private final String intermediatePath;

        private IntermediatePathParam(String intermediatePath) {
            this.intermediatePath = intermediatePath;
        }

        public boolean isFormField() {
            return true;
        }

        public String getContentType() {
            return null;
        }

		
		
        public long getSize() {
            return intermediatePath.length();
        }

        public byte[] get() {
            return intermediatePath.getBytes();
        }

        public InputStream getInputStream() throws IOException {
            return null;
        }

        public String getFileName() {
            return null;
        }

        public String getString() {
            return intermediatePath;
        }

        public String getString(String s) throws UnsupportedEncodingException {
            return new String(intermediatePath.getBytes(s));
        }
    }

}
