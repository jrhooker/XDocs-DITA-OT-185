
suitehelp.resetLayout = function () {
    var leftbar = $("#leftbar").width();
    if (suitehelp.rtl) {
        $(suitehelp.draggerMainSel).css("right", leftbar + 10);
    } else {
        $(suitehelp.draggerMainSel).css("left", leftbar + 10);
    }
}

//Uncomment suitehelp.addAnalytics to add analytics code. 
//suitehelp.addAnalytics = function ( url ) {
//    ga('send', 'pageview', url); //Example for Google Analytics
//}

function whLoad(init) {
    if (init) {
        suitehelp.resetLayout();
    }
}
