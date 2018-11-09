//Taken from http://www.jacklmoore.com/notes/naturalwidth-and-naturalheight-in-ie/ on 1/7/2014
//There was no license and copyright information on the site on 1/7/2014

// adds .naturalWidth() and .naturalHeight() methods to jQuery
// for retreaving a normalized naturalWidth and naturalHeight.
(function ($) {
    "use strict";
    var
        props = ['Width', 'Height'],
        prop;

    while (prop = props.pop()) {
        (function (natural, prop) {
            $.fn[natural] = (natural in new Image()) ? 
            function () {
                return this[0][natural];
            } : 
            function () {
                var 
                node = this[0],
                img,
                value;

                if (node.tagName.toLowerCase() === 'img') {
                    img = new Image();
                    img.src = node.src,
                    value = img[prop];
                }
                return value;
            };
        }('natural' + prop, prop.toLowerCase()));
    }
}(jQuery));

//Taken from http://james.padolsey.com/javascript/get-document-height-cross-browser/ on 1/7/2014
//There was no license and copyright information on the site on 1/7/2014

$.getDocHeight = function(){
    return Math.min(
        $(document).height(),
        $(window).height()
    );
};

$.getDocWidth = function(){
    return Math.min(
        $(document).width(),
        $(window).width()
    );
};

suitehelp.getDialogDimensions = function (img) {
    "use strict";
    var dialogWidth, dialogHeight;
    if (($.getDocHeight() < img.naturalHeight()) && ($.getDocWidth() < img.naturalWidth())) {
        dialogWidth = $.getDocWidth() - 100;
        dialogHeight = $.getDocHeight() - 50;
    } else if (($.getDocHeight() < img.naturalHeight()) && ($.getDocWidth() > img.naturalWidth())) {
        //Very tall
        dialogWidth = img.naturalWidth() + 40;
        dialogHeight = $.getDocHeight() - 50;
    } else if (($.getDocHeight() > img.naturalHeight()) && ($.getDocWidth() < img.naturalWidth())) {
        //Very wide
        dialogWidth =  $.getDocWidth() - 100;
        dialogHeight = img.naturalHeight() + 80;
    } else {
        dialogWidth =  img.naturalWidth() + 40;
        dialogHeight =  img.naturalHeight() + 80;
    }
    return { height: dialogHeight, width: dialogWidth };
};

suitehelp.getDialogTitle = function (img) {
    "use strict";
    var dialogTitle = "";
    //DitatOT Mode
    dialogTitle = img.parent(".fig").find(".figcap").text();

    if (dialogTitle === "") {
        //NativeMode standard figure
        dialogTitle = img.parent(".figure").find(".figcap").text();
    }
    if (dialogTitle === "") {
        //NativeMode Html5
        dialogTitle = img.parent("figure").find("figcaption").text();
    }
    return dialogTitle;
};