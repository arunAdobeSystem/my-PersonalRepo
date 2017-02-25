/* Gloabal Variable */
/* Creating Namespace for Abbott: Paccal Vet Module */
var nameSpace = createNamespace("abbott.paccalVetModule");

/* Function displays the left accordian menu on click
 * @param : void
 * @returns: void 
*/
nameSpace.onClickLeftMenu = function(){
	jQuery(".parentNav > li").click(function(){
		/* Checks whether sub menu present or not - to stop left accordian */
		//if(jQuery(this).parent(".parentNav").next(".innerNav").length == 0)
		//	return false;
		/* To reset the menu - removing class "activeMenu" */
		jQuery(this).parents("nav").find("ul.parentNav").each(function(){
			var liObj = jQuery(this).children("li");
			if(liObj.hasClass("activeMenu")){
				liObj.removeClass("activeMenu");
				liObj.removeClass("activeMainMenu"); 
			}
		});
		/* To reset the menu - removing class "activeMenuItem" */
		jQuery(this).parents("nav").find("ul.innerNav").each(function(){
			var liObj = jQuery(this).find("li");
			if(liObj.hasClass("activeMenuItem")){
				liObj.removeClass("activeMenuItem");
			}
		});
		if(false == $(this).parent("ul").next().is(':visible')) {
			/* To add class "activeMenu" to the current menu */
			jQuery(this).removeClass("activeMainMenu").addClass("activeMenu");
			jQuery('.innerNav').slideUp(300);
		}
		$(this).parent("ul").next().slideToggle(300);	
	});
};
/* Function displays the left accordian submenu on click
 * @param : void
 * @returns: void 
*/
nameSpace.onClickSubMenu = function(){
	jQuery(".innerNav > li").click(function(){
		/* To reset the menu - removing class "activeMenuItem" */
		jQuery(this).parent().each(function(){
			var liObj = jQuery(this).find("li");
			if(liObj.hasClass("activeMenuItem")){
				liObj.removeClass("activeMenuItem");
			}
		});
		/* To add class "activeMenuItem" to the current menu */
		jQuery(this).addClass("activeMenuItem");
	});
};
/* Function on clicking Terms and Policy Check Box
 * @param : Object
 * @returns: void 
*/
nameSpace.onCheckTermsPolicy = function(_obj){
	var chkObj = jQuery(_obj);
	chkObj.click(function(){
		nameSpace.disableEnableButton(".btnRegister" , "disableButton" , chkObj.is(":checked"));
	})
}
/* Function to enable and disable Button element
 * @param : _buttonEle Object , _disableClassName String , _enable Boolean
 * @returns: void 
*/
nameSpace.disableEnableButton = function(_buttonEle , _disableClassName ,_enable){
	if(_enable){
		jQuery(_buttonEle).removeAttr("disabled").removeClass(_disableClassName);
	}else{
		jQuery(".btnRegister").attr("disabled" , "disabled").addClass(_disableClassName);
	}
}
/* Function to set height of the wrapper depending upon content area 
 * @param : void
 * @returns: void 
*/
nameSpace.setContainorHeight = function(){
	if(jQuery(".topContentArea").length > 0){
       var contetntHt = jQuery(".topContentArea .rightContentArea").height();
        if(typeof(contetntHt)=='object'){contetntHt=jQuery(".topContentArea .loginRegisterContent").height()+20}
        //alert(typeof(contetntHt));
		contetntHt += 390;

		if(jQuery(".topContentArea").height() < contetntHt){
			jQuery(".topContentArea").height(contetntHt);
		}
	}
}




jQuery(document).ready(function () {
	/* Adding Left Menu Accordian */
	nameSpace.onClickLeftMenu();
	nameSpace.onClickSubMenu();
	/* Adding on clicking Terms of Use Checkbox */
	nameSpace.onCheckTermsPolicy("li.termPolicy input.checkbox");
	/* Adding Hover effect for Button's */
	jQuery("input.button").on(
	{
	    mouseenter: function() 
	    {
		 $(this).addClass("hoverButton");
	    },
	    mouseleave: function()
	    {
		 $(this).removeClass("hoverButton");
	    }
	});
	/* To show the first set of sub menu's of an accordian */
	if(jQuery(".activeMenu").length > 0){
		jQuery(".activeMenu").parent("ul").next().show();
	}
	/* To set the active menu on clicking sub menu navigation */
	if(jQuery(".activeMenuItem").length > 0){
		jQuery(".activeMenuItem").parent("ul").show();
		jQuery(".activeMenuItem").parent("ul").prev().show().children().addClass("activeMainMenu");;
	}
	/* Setting height of the wrapper depending upon content area */
	nameSpace.setContainorHeight();

	$('h1, h2, h3, p').each(function(i, elem) {
        $(elem).html(function(i, html) {
           return html.replace(/(®)/, "<sup>$1</sup>");
        });
    });
});
function getUrl(_obj){
	var url = $(_obj).attr('href');	
	$('#externalUrl').attr('href',url);
}

