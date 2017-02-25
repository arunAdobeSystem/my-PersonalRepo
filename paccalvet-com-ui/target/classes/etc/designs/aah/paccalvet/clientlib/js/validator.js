/* Form field validation script (Required jQuery library file).
* ||USER GUIDE||
* 1. Targeted form require an attribute 'novalidate' to support old browsers which dont supports HTML5 validation.
* 2. The validator method need to be called on 'onsubmit' event of the HTML form. Eg. '<form onsubmit="return validator(this);">'.
* 3. Fields which need to be validated require an attribute 'validate="true"'.
*/
var validator = function (obj) {
        var $this = $(obj);
        var chkError = true;
        var emptyErrorMsg = "This field should not be empty."; // Error message for empty checking
        var emailErrorMsg = "Please check the email format."; // Error message for invalid email address
        var maxCharError = "Please check the number of Characters." // Error message for exceeding maximum number of characters
        var passwdNotEqualError = "Confirm Password do not match with Password Field."; // Error message id preferred email is not matching confirm email
        var noError = "";
        var firstEle = null; // Required to set focus on first error field
        var passwordVal = "";

        /* Checking all text field which required empty checking (Including email fields)*/
        if ($this.find('input[validate="true"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $this.find('input[validate="true"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) !== "Clinic Phone No") {
                    checkEmpty($(this));
                }
            });
        }

        /* Checking all email fields which required email address verification*/
        if ($this.find('input[type="email"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $this.find('input[type="email"]').each(function (n) {
                if ($(this).val() != '' && $(this).attr('validate') == 'true') {
                    checkEmail($(this));
                }
            });
        } /* Checking all special characters specific to First Name & Last Name text field. */
        if ($this.find('input[validate="true"]').length > 0) {
            // Check existance of the element in page to avoid errors in IE
            $this.find('input[validate="true"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) === "Name" || $.trim($(this).parent().find("label").text()) === "State" || $.trim($(this).parent().find("label").text()) === "City") {
                    if ($(this).val().length != 0 && $(this).val() != '') {
                        checkSpecialChars($(this));
                    }
                }
            });
        }


        /* Adding Password & Confirm Password validation rules */
        if ($this.find('input[type="password"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $this.find('input[type="password"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) === "Password" || $.trim($(this).parent().find("label").text()) === "New Password" || $.trim($(this).parent().find("label").text()) === "Confirm Password") {
                    if ($(this).val() != '' && $(this).attr('validate') == 'true') {
                        if (!restrictPasswordRules($(this))) {
                            errorHandler($(this), "Incorrect Password ", true);
                        } else {
                            errorHandler($(this), noError, false);
                        }
                    }
                }
            });
        }

        /* Checking Password to be same as Confirm Password field. */
        if ($this.find('input[type="password"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            var passwordVal = '', newPasswordVal = '';
            $this.find('input[type="password"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) === "Password") {
                    passwordVal = $(this).val();
                }
if ($.trim($(this).parent().find("label").text()) === "New Password") {
                    newPasswordVal = $(this).val();
                }
                if ($.trim($(this).parent().find("label").text()) === "Confirm Password" && (passwordVal !== '' || newPasswordVal !== '')) {
                    if ($(this).val() != '' && $(this).attr('validate') == 'true' && restrictPasswordRules($(this))) {
                                if(newPasswordVal !== ''){
                                checkEqualValues($(this), newPasswordVal);
                                 } else if(passwordVal !== '') {
                                checkEqualValues($(this), passwordVal);
                                                                                                }
                    }
                }
            });
        }


        /* Adding Zip (Postal) Code validation rules */
        if ($this.find('input[validate="true"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $this.find('input[validate="true"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) === "Clinic Zip (Postal) Code") {
                    if ($(this).val().length != 0 && $(this).attr('validate') == 'true') {
                        if (!restrictZipCode($(this))) {
                            errorHandler($(this), "Only Alphanumeric and Space allowed for Zip (Postal) Code", true);
                        } else {
                            errorHandler($(this), noError, false);
                        }

                    }
                }
            });
        }



	var hid;
   // alert("first");
    if ($this.find('input[validatesp="true"]').length > 0) { // Check existance of the element in page to avoid errors in IE
        $this.find('input[validatesp="true"]').each(function (n) {
             if($.trim($(this).attr("id")) === "txtoptInHid") {
                //  alert("second");

                hid = $(this);
            }
        });

        $this.find('input[validatesp="true"]').each(function (n) {           
         if($.trim($(this).attr("id")) === "txtoptIn") {  

           //  alert("third"+hid);

             if($(this).attr('checked')){
              hid.val('on');  

           }else{
                hid.val('off');
            }           
         } 
              });
    }



        /* Adding Phone No Code validation rules */
        if ($this.find('input[validate="true"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $this.find('input[validate="true"]').each(function (n) {
                if ($.trim($(this).parent().find("label").text()) === "Clinic Phone No" && $.trim($(this).val()) != "") {
                    if ($(this).val().length != 0 && $(this).attr('validate') == 'true') {
                        if (!restrictPhoneNoCode($(this))) {
                            errorHandler($(this), "Only Alphanumeric and Space allowed for Phone No", true);
                        } else {
                            errorHandler($(this), noError, false);
                        }

                    }
                }
            });
        } /* Handler for empty field checking */

        function checkEmpty(ele) {
            var str = String(ele.val());
            str = str.replace(/\s+/g, ' '); // Replacing spaces as an user can put space into a field.
            if (str == '') {
                errorHandler(ele, emptyErrorMsg, true);
            } else {
                errorHandler(ele, noError, false);
            }
        }

        /* Handler for email field checking */

        function checkEmail(ele) {
            var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!filter.test(ele.val())) {
                errorHandler(ele, emailErrorMsg, true);
            } else {
                errorHandler(ele, noError, false);
            }
        }

        /* Handler for special character checking */

        function restrictSpecialCharacter(ele) {
            var filter = /^[a-zA-Z ]*$/;
            return (filter.test(ele.val()));
        }



        /* Handler for adding clinic rules */

        function restrictClinic(ele) {
            var filter = /^[A-Za-z0-9]+(?:[\s][A-Za-z0-9]+)*$/;
            return (filter.test(ele.val()));
        }

        /* Handler to check equal values */

        function checkEqualValues(sourceEle, matchVal) {
            if ($.trim(sourceEle.val()) === matchVal) {
                errorHandler(sourceEle, noError, false);
            } else {
                errorHandler(sourceEle, passwdNotEqualError, true);
            }
        }

        /* Handler to check Zip Code Validation */

        function restrictZipCode(ele) {
            // var filter = /^[A-Za-z0-9]+(?:[\s-][A-Za-z0-9]+)*$/;
            var filter = /^[\d\s\-]+$/;
            return (filter.test(ele.val()));
        }


        function restrictPhoneNoCode(ele) {

            if (ele.val() != "") {
                // var filter = /^[A-Za-z0-9]+(?:[\s-][A-Za-z0-9]+)*$/;
                var filter = /^[\d\s\-]+$/;
                return (filter.test(ele.val()));
            } else {
                return true;
            }
        }



        /* Handler for checking Password field */

        function restrictPasswordRules(ele) {

            //var filter = (/^(?=(.*\d){1,})(?=(.*[a-z]){1,})(?=(.*[A-Z]){1,})[0-9a-zA-Z]{6,}$/);
            var filter = (/^((?=(.*\d){1,})(?=(.*[a-z]){1,}))|((?=(.*\d){1,})(?=(.*[A-Z]){1,}))|((?=(.*[a-z]){1,})(?=(.*[A-Z]){1,}))[0-9a-zA-Z]{6,}$/);

            return (filter.test(ele.val()));



        }


        function checkSpecialChars(ele) {
           if (!restrictSpecialCharacter(ele)) {
                errorHandler(ele, "Special character and numbers are not allowed", true);
            } else {
                errorHandler(ele, noError, false);
            }
        }

        /* Common handler for display/remove error messages and style */

        function errorHandler(ele, msg, bool) {
            if (bool) {
                if (firstEle == null) {
                    firstEle = ele; // Reffering first found element which has error if not found already
                    var topPos = ele.parent().offset().top - 50;
                    $('html, body').animate({
                        scrollTop: topPos
                    }, 600);
                    ele.focus(); // Setting focus into first found element which required correction                                                     
                }
                chkError = false;
                ele.addClass('errorField');
                if (typeof ele.attr("errorTitle") != "undefined") { // Checks if already a error message has been printed for this element
                    ele.attr("errorTitle", msg)
                }
                //alert(ele.attr("errorTitle"));
                $('.termPolicy input[type="checkbox"]').attr("checked", false);
                nameSpace.disableEnableButton(".btnRegister", "disableButton", $('.termPolicy input[type="checkbox"]').is(":checked"));
            } else {
                if (chkError != false) {
                    chkError = true;
                }
                if (ele.hasClass('errorField')) {
                    ele.removeClass('errorField');
                }
/*if (typeof ele.attr("errorTitle") != "undefined") {
              ele.attr("errorTitle" , "");
                   }*/
            }
        }
        return chkError; // Form will not be submitted until this method returns true.
    }

    /* Resets the form */
var resetForm = function () {
        if ($('input[validate="true"]').length > 0) {
            $('input[validate="true"]').val("").removeClass("errorField");
            $('input[type="text"]').eq(0).focus();
        }

        $('input[type="checkbox"]').attr("checked", false);
        if ($('.tooltip').length > 0) $('.tooltip').remove();
    }

    /* To remove errorfield class on click of the element */
var resetFormFields = function (_obj) {
        if (_obj.hasClass('errorField')) {
            _obj.removeClass('errorField');
        }
        if ($('.tooltip').length > 0) $('.tooltip').remove();
    }

    /* To set events for removing error class's from target element */
var setTargetEvents = function () {
        if ($('input[validate="true"]').length > 0) { // Check existance of the element in page to avoid errors in IE
            $('input[validate="true"]').bind("keydown", function () { // To remove error class once clicked on the target element 
                resetFormFields($(this));
            })
            $('input[validate="true"]').bind("click", function () { // To remove error class once clicked on the target element 
                resetFormFields($(this));
            })

            /* Error tooltip on hovering on error field */
            $('.inputField').hover(

            function () {
                if (!$(this).hasClass('errorField')) return false;
                // Hover over code
                var title = $(this).attr('errorTitle');
                $(this).data('tipText', title).removeAttr('title');
                $('<p class="tooltip"></p>').text(title).appendTo('body').fadeIn('slow');
            }, function () {
                // Hover out code
                $(this).attr('errorTitle', $(this).data('tipText'));
                $('.tooltip').remove();
            }).mousemove(function (e) {
                var mousex = e.pageX + 20; //Get X coordinates
                var mousey = e.pageY + 10; //Get Y coordinates
                $('.tooltip').css({
                    top: mousey,
                    left: mousex
                })
            });
        }
    }

$(document).ready(function () {
    if (!$("#editForm").length) {
        resetForm();
    }
    setTargetEvents();

});
