/*jslint browser: true, regexp: true */

// Note: it is recommended to test this code with JSLint:
//
// http://www.jslint.com/
//
// You will need to indicate that the following global variables are already
// defined:
//
/*global $:true, Modernizr:true,  whLoad:true,  suitehelp:true, unescape:true, escape:true */


suitehelp.autoCloseTOC = false;
suitehelp.draggerMainSel = "article";
suitehelp.andSearch = false;
suitehelp.customizeRootBreadCrumb = false;
suitehelp.customScrollBar = false;
suitehelp.tocArray = suitehelp.leftbarContent.tocArray;
suitehelp.tocObject = {};
suitehelp.resizeSearchWidth = 0;
suitehelp.breadcrumbGraphic = false;
suitehelp.rtl = ($('html').attr('lang') === 'he' || $('html').attr('lang') === 'ar') ? true : false;

//Attach the approot to the relative urls to make absolute urls.
suitehelp.addApproot = function (t) {
    "use strict";
    var approot = $("body").attr("data-approot");
    return t.replace(/%APPROOT%/g, approot);
};

//Add html content to the DOM.
suitehelp.addContent =  function (name, content) {
    "use strict";
    $("#leftbar > nav." + name).html(suitehelp.makeAbsoluteURLs(document.location.href, suitehelp.addApproot(content)));
};

//Make an AJAX call to get the underlying trees of the Table of Contents.
suitehelp.setupSecondLeftBar = function () {
    "use strict";
    if (!suitehelp.synchronousJS) {
        var secondSearch = $("body").attr("data-approot") + 'static/tocbranches.js';
        $.ajax({
            url: secondSearch,
            dataType: 'script',
            cache: true, // otherwise will get fresh copy every page load
            success: function () { suitehelp.loadSecondLeftBar(); }
        });
    } else {
        suitehelp.loadSecondLeftBar();
    }
};

//Load the html content for the underlying trees of the Table of Contents.
suitehelp.loadSecondLeftBar = function () {
    "use strict";
    $("#leftbar > nav.toc > nav > ul > li.closed").each(function () {
        $(this).append(suitehelp.makeAbsoluteURLs(document.location.href, suitehelp.addApproot(suitehelp.secondlevel[$(this).attr("id")])));
    });
    $("#leftbar > nav.toc li.open, #leftbar > nav.toc li.closed").click(function (event) {
        // Prevent event propogation from inner elements
        if (event.target.id === this.id) {
            $(this).toggleClass("open").toggleClass("closed");
        }
    });
    // Change closed to open for currently exposed trees.
    suitehelp.leftbarOpen();
};
//Load the index content.  
suitehelp.loadIndex = function () {
    "use strict";
    if (suitehelp.showIndex) {
        if ($("#leftbar > nav.index").length) { //if it is in body.hamlet
            suitehelp.addContent("index", suitehelp.indexBarContent.index);
            if ($("#leftbar > nav.index li").length) { //if something loaded
                $("#leftbar > .tabs .index").parent().show();
                // Enable Javascript-powered index popups
                suitehelp.setupIndexPopups();
            }
        }
    }
};
//Make an AJAX call to get index information when the web page requests it
suitehelp.setupIndex = function () {
    "use strict";
    if (suitehelp.showIndex) {
        if ($("#leftbar > nav.index").length) {
            //Read in index
            if (!suitehelp.synchronousJS) {
                var urlIndex = $("body").attr("data-approot") +  'static/index.js';
                $.ajax({
                    url: urlIndex,
                    dataType: 'script',
                    cache: true, // otherwise will get fresh copy every page load
                    success: function () {suitehelp.loadIndex(); }
                });
            } else {
                suitehelp.loadIndex();
            }
        }
    }
};

 //Make an AJAX call to get the default Search content.  
suitehelp.loadSearch = function () {
    "use strict";
    if (!suitehelp.synchronousJS) {
        var urlSearch = $("body").attr("data-approot") + 'static/search.js';
        $.ajax({
            url: urlSearch,
            dataType: 'script',
            cache: true // otherwise will get fresh copy every page load
        });
    }
};
//Create the Table of Contents
suitehelp.setupLeftBar = function () {
    "use strict";
    // To make pages smaller, the TOC, index and glossary are stored in JavaScript.
    // Pull in that content now.
    suitehelp.addContent("toc", suitehelp.toc.toc);
    suitehelp.addContent("glossary", suitehelp.leftbarContent.glossary);
    // Set up the tabs to work properly.
    $("#leftbar > .tabs a").click(function () {
        $("#leftbar > .tabs a.current").parent().removeClass("currentli");
        $("#leftbar > .tabs a.current").removeClass("current");
        $("#leftbar > nav.current").removeClass("current");
        $("#leftbar ." + $(this).attr("class")).parent().addClass("currentli");
        $("#leftbar ." + $(this).attr("class")).addClass("current");
        return false;
    });

    suitehelp.setupSecondLeftBar();
    // Enable click events
    $("#leftbar > nav.toc > nav > ul > li.open", "#leftbar > nav.toc > nav > ul > li.closed").click(function (event) {
        // Prevent event propogation from inner elements
        if (event.target.id === this.id) {
            $(this).toggleClass("open").toggleClass("closed");
        }
    });

    // Hide index and glossary tabs if their content is empty
    function hideTab(name) {
        $("#leftbar > .tabs ." + name).parent().hide();
    }
    hideTab("index");
    if (!$("#leftbar > nav.glossary li").length) {
        hideTab("glossary");
    }
};

// Switch "closed" to "open" as necessary, based on supplied current ID
suitehelp.leftbarOpen = function () {
    "use strict";
    $("#toc-" + suitehelp.currid).parents("li").andSelf().filter(".closed").removeClass("closed").addClass("open");
};

// attempt to call whLoad, hiding exceptions if the function is not defined
suitehelp.whLoadHelper = function (isFirst) {
    "use strict";
    // Set up HTML5 video
    if (!Modernizr.video.h264) {
        $.each($("video"), function () {
            var $v = $(this),
                swf = $("body").attr("data-approot") + "static/flowplayer.swf",
                src = $v.attr("src"),
                html = [];
            html.push("<object ");
            html.push("width='640' ");
            html.push("height='480' ");
            html.push("type='application/x-shockwave-flash' data='");
            html.push(swf);
            html.push("'><param name='allowfullscreen' value='true'/><param name='movie' value='");
            html.push(swf);
            html.push("'/><param name='flashvars' value=\"config={'playlist':[{'url': '");
            html.push(src);
            html.push("','autoPlay':false,'autoBuffering':true}]}\" /></object>");
            $v.before(html.join("")).detach();
        });
    }
    try {
        whLoad(isFirst);
    } catch (ignore) {
    }
};

// Update the contents of the breadcrumbs div with the ancestors of the given topic ID
suitehelp.breadcrumbs = function () {
    "use strict";
    if (!suitehelp.currid) {
        suitehelp.currid = "__index";
    }

    var crumbs = [],
        currLink = $("#toc-" + suitehelp.currid + " > a");

    currLink.parents("li").each(function () {
        var $e = $(this),
            j = $e.children("a"),
            href = j.attr("href");

        if (suitehelp.breadcrumbGraphic) {
            if (href) {
                crumbs.unshift(" <span class='arrow'></span> <a rel='internal' href='" + href + "'>" + $.trim(j.text()) + "</a>");
            } else {
                crumbs.unshift(" <span class='arrow'></span> <a>" + $e.children("span").text() + "</a>");
            }
        } else {
            if (href) {
                crumbs.unshift(" <span class='arrowString'>_{BreadcrumbSymbol}</span> <a rel='internal' href='" + href + "'>" + $.trim(j.text()) + "</a>");
            } else {
                crumbs.unshift(" <span class='arrowString'>_{BreadcrumbSymbol}</span> <a>" + $e.children("span").text() + "</a>");
            }
        }
    });

    crumbs.unshift(suitehelp.getRootOfBreadCrumbs());
    $("#breadcrumbs").html(crumbs.join(""));
    $("#breadcrumbs a:last-child").addClass("current-breadcrumb");

    $("#leftbar > nav.toc a.current").removeClass("current");
    currLink.addClass("current");

    // Same thing in search
    $("#leftbar > nav.search li.current").removeClass("current");
    $("#search-" + suitehelp.currid).addClass("current");

    // If requested, close all other branches in the TOC
    if (suitehelp.autoCloseTOC) {
        $("#leftbar > nav.toc li.open").toggleClass("closed").toggleClass("open");
    }

    // Open all parent nodes
    suitehelp.leftbarOpen();
};

//Determine the root of the breadcrumbs
suitehelp.getRootOfBreadCrumbs = function () {
    "use strict";
    var currentTab = $("#leftbar ul.tabs a.current").attr("class").match("search|toc|index|glossary");
    if (suitehelp.customizeRootBreadCrumb) {
        switch (currentTab[0]) {
        case "toc":
            return "<a href='" + $("#logo-link").attr("href") + "'>_{BreadCrumb TOC}</a>";
        case "search":
            return "<a href='" + $("#logo-link").attr("href") + "'>_{BreadCrumb Search}</a>";
        case "index":
            return "<a href='" + $("#logo-link").attr("href") + "'>_{BreadCrumb Index}</a>";
        case "glossary":
            return "<a href='" + $("#logo-link").attr("href") + "'>_{BreadCrumb Glossary}</a>";
        default:
            return "<a href='" + $("#logo-link").attr("href") + "'>_{Home}</a>";
        }
    }
    return "<a href='" + $("#logo-link").attr("href") + "'>_{Home}</a>";
};

suitehelp.highlight = function () {
    "use strict";
    //Split out words and phrases ( series of words surrounded by quotes")
    var terms,
        term,
        termsOnly;
    if ($("#searchform input.search").val() !== "") {
        if (suitehelp.checkSearch) {
            termsOnly = $("#searchform input.search").val().replace(/\s(NOT|AND|OR|NEAR|NEAR\/\d+)\s/g, " ");
            //splits words by spaces but will not split up a section in quotes
            terms = termsOnly.toLowerCase().replace(/^\s+|\s+$/g, '').match(/([^"\s]+)|("([^"]+)")/g);
        } else {
            terms = $("#searchform input.search").val().toLowerCase().replace(/^\s+|\s+$/g, '').split(" ");
        }
        // Remove highlighting of the terms   
        $("article").unhighlight({className: 'search-term'});
        if (terms) {
            while (terms.length) {
                term = terms.pop();
                // sanitize any special regex characters
                // term = term.replace(/([\[\\\^\$\.\|\?\*\+\(\)])/g, "\\$1"); Mantis 10108
                //remove leading and trailing quotes and trailing star
                term = term.replace(/^"/g, "").replace(/"$/g, "").replace(/\*$/g, "");
                if (term.length <= 3) {
                    $("article").highlight(term, { wordsOnly: true, className: 'search-term' });
                } else {
                    $("article").highlight(term, { className: 'search-term' });
                }
            }
        }
    }
};

// Configure the index terms to have the proper pop-up behavior.
suitehelp.setupIndexPopups = function () {
    "use strict";
    $("#leftbar nav.index .pop-term").click(function () {
        $(this).toggleClass("active");
        $("#leftbar nav.index .pop-term.active").not(this).removeClass("active");
    });
};

// Add a ?q=searchterm query string to a URL.
suitehelp.addQueryStringToURL = function (url, key, value) {
    "use strict";

    if (url.match(/\?/)) {
        url += "&";
    } else {
        url += "?";
    }

    return url + escape(key) + "=" + escape(value);
};

// Execute a search 
suitehelp.simpleSearch = function (val) {
    'use strict';
    var terms = val
        .toLowerCase() // basic normalization
        // turn control characters and symbols into whitespace except for
        //period(u002E), underscore(u005F), apostrophe(u00027), colon (u003A)
        .replace(/[\u0000-\u0026\u0028-\u002d\u002f\u003b-\u0040\u005b-\u005e\u0060\u007b-\u00bf]/g, " ")
        //remove white spaces before and after the entry
        .replace(/^\s+|\s+$/g, '')
        //remove white spaces in between words when a phrase is entered
        .replace(/\s+/g, " ")
        .split(" "),
        matches = {},
        i,
        fs,
        j,
        pair,
        file,
        score,
        total,
        pairs = [],
        m,
        tocid,
        title,
        termCount,
        fileMatch;
    termCount = terms.length;

    for (i = 0; i < termCount; i += 1) {
        //periods at the begining of words are not preserved in the database: ..json becomes json.  
        //periods within words do get preserved: u.s.a or boomi.com
        fs = suitehelp.tokens[terms[i].replace(/(^(\.|:|'))\b/g, '')];
        if (fs) {
            for (j = 0; j < fs.length; j += 1) {
                pair = fs[j];
                file = pair[0];
                score = pair[1];
                total = matches[file] || {score: 0, matchCount: 0};
                matches[file] = {score: total.score + score, matchCount: total.matchCount + 1};
            }
        }
    }
    pairs = [];
    for (file in matches) {
        if (matches.hasOwnProperty(file)) {
            fileMatch = matches[file];
            if (fileMatch.matchCount === termCount || !(suitehelp.andSearch)) {
                m = fileMatch.score;
                score = m;
                tocid = suitehelp.files[file];
                // Eliminate whitespace from the title
                // See http://www.cleancode.co.nz/blog/182/javascript-regex-bug-fails-jquery-trim
                title = $("#toc-" + tocid + " > a").text().replace(/(^[\s\xA0]+|[\s\xA0]+$)/g, '');
                if (title !== "") {
                    pairs.push({
                        id:  suitehelp.files[file],
                        score: score,
                        title: title
                    });
                }
            }
        }
    }
    return pairs.sort(function (a, b) {
        return b.score - a.score;
    });
};
//Format the search results for display.
suitehelp.processSearchResults = function (results) {
    'use strict';
    var html, result, i, href, snippet, removegt, replacegt;
    html = [];

    if (results.length) {
        if (results.length === 1 ){
            html.push("<div class='results-wrapper'><div class='results'><p class='searchtitle'>_{Search Result}</p>"); 
        } else {
             html.push("<div class='results-wrapper'><div class='results'><p class='searchtitle'>_{Search Results}</p>");
        }
       
        html.push("<p class='searchedfor'>_{Searched for}: " +  $("#searchform input.search").val() + "</p>");
        html.push("</div><nav class='results'><ul>");
    } else {
        html.push("<div class='results'><p class='searchmsg'>_{No Search Results}</p></div>");
    }
    for (i = 0; i < results.length; i += 1) {
        html.push("<li");
        html.push(" id='search-");
        result = results[i];
        html.push(result.id);
        if (result.id === suitehelp.currid) {
            html.push("' class='current");
        }
        html.push("'>");
        //Go to the DOM to get the href for a particular page
        href = $('[id="toc-' + result.id + '"] > a').attr('href');
        html.push("<a href='");
        html.push(href);
        html.push("' rel='internal'>");
        html.push(result.title + " ");
        html.push("</a>");
        if (result.score !== 0) {
            html.push("<span class='score'> Score: ");
            html.push((result.score).toFixed(1));
            html.push("</span>");
        }
        if (result.hasOwnProperty("snippet") && result.snippet.length > 0) {
            html.push("<p class='snippet'>");
            snippet = result.snippet;
            //(<[^b\/])= all tags that don't start with <b or </
            //(<b[^>]) = all tags that start <b and are followed by another character other then >
            if (snippet.search(/(<[^b\/])|(<b[^>])/g) >= 0) {
                removegt = snippet.replace(/<b>/g, "openb").replace(/<\/b>/g, "closeb");
                replacegt = removegt.replace(/</g, "&lt;");
                snippet = replacegt.replace(/openb/g, "<b>").replace(/closeb/g, "</b>");
            }
            html.push(snippet);
            html.push("</p>");
        }
        html.push("</li>");
    }
   //  html.push(results.length ?"</div>": "");
    html.push(results.length ? "</ul></nav></div>" : "");
    $("#leftbar > nav.search .results").detach();
    $("#leftbar > nav.search .results-wrapper").detach();
    $("#leftbar > nav.search").append(html.join("")).ajaxify();
    $(".searchtitle").prepend("<span class='searchtotal'>" + results.length + " </span>");
    // Display the search pane in the left bar
    $("#leftbar > .tabs .current, #leftbar > nav.current").removeClass("current");
    $("#leftbar > .tabs .search, #leftbar > nav.search").addClass("current");
    if (suitehelp.resizeSearchWidth > 0) {
        $("#leftbar nav.search nav.results ul").width(suitehelp.resizeSearchWidth);
    }
    if (suitehelp.customScrollBar) {
        suitehelp.searchScroll = suitehelp.resetScrollBars(" #leftbar nav.search nav.results");
    }
    if (results.length) {
        suitehelp.highlight();
    }
    suitehelp.breadcrumbs();
};
//Call the web server search.
suitehelp.callWebSearch = function (val) {
    'use strict';
    $.ajax({
        data: {q : val},
        datatype: "json",
        success: function (data) {
            suitehelp.processSearchResults(data);
        },
        error: function () {
            suitehelp.processSearchResults(suitehelp.simpleSearch(val));
        }
    });
};
//Check to see if the web server search is enabled.
suitehelp.callCheckSearch = function (val) {
    'use strict';
    $.ajax({
        data: {check : "search"},
        datatype: "json",
        success: function (data) {
            if ($.type(data) === "object" && data.search === true) {
                suitehelp.checkSearch = data.search;
                suitehelp.callWebSearch(val);
            } else {
                suitehelp.checkSearch = false;
                suitehelp.processSearchResults(suitehelp.simpleSearch(val));
            }
        },
        error: function () {
            suitehelp.checkSearch = false;
            suitehelp.processSearchResults(suitehelp.simpleSearch(val));
        }
    });
};

//If SuiteHelp+ is running, the search will happen with a web service call.
//Otherwise the static search will be called. 
suitehelp.performSearch = function (val) {
    "use strict";
    if (suitehelp.checkSearch === true) {
        suitehelp.callWebSearch(val);
    } else if (suitehelp.checkSearch === false) {
        suitehelp.processSearchResults(suitehelp.simpleSearch(val));
    } else {
        suitehelp.callCheckSearch(val);
    }
};

// Given a base URL, convert all links in the given HTML to be absolute.
suitehelp.makeAbsoluteURLs = function (url, html) {
    "use strict";

    url = url || "";
    html = html || "";

    var relPath = url.replace(/#.*$/, '').replace(/\/[^\/]+$/, '/');

    // Make sure "# URLs don't get changed
    html = html.replace(/(<[^>]*)"#/ig, "$1\"/REMOVEME/#");

    // Set absolute URLs to something else
    html = html.replace(/(<[^>]*\bsrc)(="[^"]+:)/ig, "$1abs$2");
    html = html.replace(/(<[^>]*\bhref)(="[^"]+:)/ig, "$1abs$2");
    html = html.replace(/(<[^>]*\bsrc)(="\/)/ig, "$1abs$2");
    html = html.replace(/(<[^>]*\bhref)(="\/)/ig, "$1abs$2");

    // Fix the URLs
    html = html.replace(/(<[^>]*)(\bsrc=")([^"]\/)?/ig, "$1$2" + relPath);
    html = html.replace(/(<[^>]*)(\bhref=["'])([^"']\/)?/ig, "$1 rel='internal' $2" + relPath);

    // Replace the absolute URLs
    html = html.replace(/srcabs=/ig, "src=");
    html = html.replace(/hrefabs=/ig, "href=");

    // Undo the "# fix
    html = html.replace(/"\/REMOVEME\/#/g, "\"#");

    return html;
};

// Redirect to the given URL without Ajax, setting query string parameters as
// necessary
suitehelp.nonAjaxRedirect = function (url) {
    "use strict";
    var q = $("#searchform input.search").val();
    if (q) {
        url = suitehelp.addQueryStringToURL(url, "q", q);
    }
    if ($("body").hasClass("hide-nav")) {
        url = suitehelp.addQueryStringToURL(url, "hidenav", "true");
    }
    document.location.href = url;
    return false;
};

// Set up Ajax
suitehelp.setupHistory = function () {
    "use strict";
    var History = window.History,
        /* Application Specific Variables */
        $content = $("article"),
        /* Application Generic Variables */
        $body = $(document.body),
        rootUrl = History.getRootUrl();

    // Ensure Content
    if ($content.length === 0) {
        $content = $body;
    }

    // Internal Helper
    $.expr[':'].internal = function (obj) {
        // Prepare
        var
            $this = $(obj),
            url = $this.attr('href') || '',
            isInternalLink;

        // Check link
        //mailto:suitesol.com
        isInternalLink = (url.substring(0, rootUrl.length) === rootUrl) || ($this.attr("rel") === "internal");
        // Ignore or Keep
        return isInternalLink;
    };

    // HTML Helper
    function documentHtml(html) {
        return String(html)
            .replace(/<\!DOCTYPE[^>]*>/i, '')
            .replace(/<(html|head|body|title|meta|article)/gi, ' <div class="document-$1"')
            .replace(/<\/(html|head|body|title|meta|article)/gi, ' </div');
    }

    // Ajaxify Helper
    $.fn.ajaxify = function () {
        //ajaxload calls ajaxify() on content.html.  Each time ajaxify is called another
        //click event is added to the selector.  This increases the click events that get 
        //fired by one each time we load an article.  We need to unbind() and remove the 
        //previous click events before we add new ones.  
        $(this).unbind();
        // Ajaxify
        //$this will be the article or body.  We changed from document to $this.  
        $(this).on("click", 'a:internal', function (event) {
            // Prepare
            var
                $this = $(this),
                url = $this.attr('href'),
                title = $this.attr('title') || null,
                id = $this.parent().attr('id'),
                destinationHash,
                destinationUrl,
                currentUrl,
                currentHash;
            if ((id !== undefined) && (id.search('^search-') === -1)) {
                $("#searchform input.search").val("");
            }
            // External links break everything below, get rid of them
            if ($this.attr("target")) {
                return true;
            }
            // Continue as normal for cmd clicks etc
            if (event.which === 2 || event.metaKey) {
                return true;
            }
            if (url.match(/#/) !== null) {
                destinationHash = String(url).replace(/([^#]*)#?([^#]*)#?(.*)/, '$2');
                destinationUrl = String(url).replace(/([^#]*)#?([^#]*)#?(.*)/, '$1');
                currentUrl = String(window.location.href).replace(/([^#|\?]*)#?([^#]*)#?(.*)/, '$1');
                currentHash = (window.location.hash).slice((window.location.hash).indexOf('#') + 1);
                if (currentHash.match(/\?/) !== null) {
                    currentHash = currentHash.slice(0, currentHash.indexOf('?'));
                }
                //Google Chrome
                if (currentUrl === destinationUrl) {
                    $("#" + destinationHash)[0].scrollIntoView();
                    return false;
                }
                //IE
                currentUrl = History.getBaseUrl(window.location.href) + currentHash;
                if (currentUrl === destinationUrl) {
                    $("#" + destinationHash)[0].scrollIntoView();
                    return false;
                }
                url = destinationUrl + "?scroll=" + destinationHash;
            }
            // Ajaxify this link
            try {
                History.pushState(null, title, url);
            } catch (e) {
                // The pushState can fail if the browser's security policy
                // disallows it.
                suitehelp.nonAjaxRedirect(url);
            }
            event.preventDefault();

            // This blur (and a few that follow) get rid of the dotted outlines
            // in FF. We do not disable this at the CSS level since the
            // outlines are an accessibility feature for keyboard users.
            $this.blur();

            return false;
        });

        // Chain
        return $(this);
    };

    // Hook into State Changes
    $(window).bind('statechange', function () {
        // Prepare Variables
        var
            State = History.getState(),
            url = State.url;

        // Set Loading
        $body.addClass('loading');

        // Ajax Request the Traditional Page
        function ajaxLoad() {
            if (suitehelp.addAnalytics !== undefined) {
                suitehelp.addAnalytics(url);
            }
            $.ajax({
                url: url,
                success: function (data) {
                    // Replace all relative URLs with absolute URLs
                    data = suitehelp.makeAbsoluteURLs(url, data);

                    // Prepare
                    var
                        $data = $(documentHtml(data)),
                        $dataBody = $data.find("div.document-body"),
                        $article = $data.find("div.document-article"),
                        contentHtml,
                        $metaRedirect = $data.find("div.document-meta").attr("name") !== undefined ? $data.find("div.document-meta").attr("name") : "",
                        $queryString = document.location.search !== undefined ? document.location.search : "",
                        redirectUrl,
                        selAudience;
                    if ($metaRedirect === "redirectUrl") {
                        redirectUrl =  $dataBody.find("a").attr("href") + $queryString;
                        if (redirectUrl !== undefined) {
                            url = redirectUrl;
                            History.replaceState(null, null, url);
                            ajaxLoad();
                            return;
                        }
                    }
                    // Fetch the content
                    contentHtml = $article.html();
                    // Update the content
                    $content.stop(true, true);
                    $content.html(contentHtml).ajaxify().show(); /* you could fade in here if you'd like */

                    if (suitehelp.styleArticle !== undefined) {
                        suitehelp.styleArticle();
                    }
                    // Set the document title
                    document.title = $data.find("div.document-title:first").text();

                    // Complete the change
                    $body.removeClass('loading');
                    if (suitehelp.audience) {
                        //get ?selAudience= and then the actual value
                        //&_suid=188 is added during previous and next click on IE.  
                        selAudience = String((window.location.href).match(/\?selAudience=[^#\?\&]*/)).match(/\=(.*)/);
                        if (selAudience !== null) {
                            $("#audience-selector").val(selAudience[1]);
                            suitehelp.changeAudience(false);
                        } else {
                            suitehelp.changeAudience(false);
                        }
                    }
                    // Update TOC, breadcrumbs, etc
                    suitehelp.currid = $dataBody.attr("id");
                    suitehelp.breadcrumbs();

                    // Highlight search terms
                    suitehelp.highlight();
                    suitehelp.setupThumbNailDialog();

                    // Call custom load code
                    suitehelp.whLoadHelper(false);
                    suitehelp.checkScroll();
                },
                error: function () {
                    return suitehelp.nonAjaxRedirect(url);
                }
            }); // end ajax
        }

        suitehelp.checkAjax(ajaxLoad,
            function () {
                suitehelp.nonAjaxRedirect(url);
            });

    }); // end onStateChange
};


// Lookup a query string variable
suitehelp.getQueryString = function (key) {
    "use strict";

    if (!suitehelp.queryString) {
        suitehelp.queryString = {};
        var query = window.location.search.substring(1),
            vars = query.split("&"),
            i,
            pair;
        for (i = 0; i < vars.length; i += 1) {
            pair = vars[i].split("=");
            suitehelp.queryString[pair[0]] = unescape(pair[1]);
        }
    }

    return suitehelp.queryString[key];
};

suitehelp.checkScroll = function () {
    "use strict";
    var scroll;
    function getScrollValue(key) {
        suitehelp.queryString = {};
        var query = window.location.search.substring(1),
            vars,
            i,
            pair,
            hash;
        if (!query) {
            hash = window.location.hash;
            query = hash.slice(hash.indexOf('?') + 1);
        }
        vars = query.split("&");
        for (i = 0; i < vars.length; i += 1) {
            pair = vars[i].split("=");
            suitehelp.queryString[pair[0]] = unescape(pair[1]);
        }
        return suitehelp.queryString[key];
    }
    scroll = getScrollValue("scroll");
    if (scroll) {
        $("#" + scroll)[0].scrollIntoView();
    } else {
        $("article").scrollTop(0);
        if (suitehelp.customScrollBar) {
            (suitehelp.centerScroll).data('jsp').scrollTo(1, 1);
        }
    }
};
// Check for a context-sensitive link and redirect if present (and valid)
suitehelp.checkContext = function () {
    "use strict";
    var context = suitehelp.contexts[suitehelp.getQueryString("context")],
        hidenav = suitehelp.getQueryString("hidenav");
    if (context) {
        if (hidenav) {
            document.location = $("body").attr("data-approot") + context + "?hidenav=" + hidenav;
        } else {
            document.location = $("body").attr("data-approot") + context;
        }
    }

    // Check another query string parameter at the same time: open the system with TOC closed
    if (hidenav) {
        $("body").toggleClass("hide-nav");
    }
};
// If a q= parameter is specified on load, perform an initial search
suitehelp.performInitialSearch = function () {
    "use strict";
    var q = suitehelp.getQueryString("q");
    if (q) {
        $("#searchform input.search").val(q);
        suitehelp.performSearch(q);
    }
};


suitehelp.changeAudience = function (clicked) {
    "use strict";
    var audience = $("#audience-selector").val(),
        elementhref,
        test,
        toccount;
    $("nav.toc li").each(function () {
        $("#" + this.id).removeClass("hideaudience").removeClass("tempLeaf");
        //only one instance of selAudience should exist
        elementhref =  $("#" + this.id + "> a").attr("href").replace(/\?selAudience=[^#]*/, "") + "?selAudience=" + audience;
        $("#" + this.id + "> a").attr("href", elementhref);
    });
    if (audience !== "ALL") {
        test = $('nav.toc li').not('[data-audience~="' + $("#audience-selector").val() + '"]');
        test.each(function () {
            $("#" + this.id).addClass("hideaudience");
        });
        if (clicked) {
            $("#toc-" + suitehelp.currid).parents("li").andSelf().removeClass("hideaudience");
            $("nav.toc li.open, nav.toc li.closed").not('[class~="hideaudience"]').each(function () {
                if ($("#" + this.id + " li").not('[class~="hideaudience"]').length === 0) {
                    $("#" + this.id).addClass("tempLeaf");
                }
            });
        }
    }
    suitehelp.tocArray.length = 0;
    suitehelp.tocObject = {};
    toccount = 0;
    $('nav.toc li').not('[class~="hideaudience"]').each(function () {
        suitehelp.tocArray[toccount] = $(this).attr("id").replace(/toc-/g, "");
        suitehelp.tocObject[$(this).attr("id").replace(/toc-/g, "")] = toccount;
        toccount = toccount + 1;
    });
};
// Set up the back, forward and print buttons
suitehelp.setupTopButtons = function () {
    "use strict";
    function moveTo(i) {
        suitehelp.currid = suitehelp.tocArray[i];

        var $t = $("#toc-" + suitehelp.currid + " a"),
            url = $t.attr("href"),
            title = $t.text();

        // Catch exceptions and redirect manually if there is an error
        // on the local filesystem.
        try {
            window.History.pushState(null, title, url);
        } catch (e) {
            document.location.href = url;
            return;
        }

        suitehelp.breadcrumbs();
    }
    $("#button-back").click(function () {
        var j = (suitehelp.tocObject[suitehelp.currid] || suitehelp.tocArray.length) - 1;
        moveTo(j);
        return false;
    });
    $("#button-forward").click(function () {
        var k = (suitehelp.tocObject[suitehelp.currid] + 1 || 0) % suitehelp.tocArray.length;
        moveTo(k);
        return false;
    });
    $("#button-print").click(function () {
        $("#printall").detach();
        window.print();
        return false;
    });
    $("#button-print-all").click(function () {
        $("#printall").detach();
        $("article").append("<div id='printall'/>");
        suitehelp.loadChildren($("#toc-" + suitehelp.currid), $("#printall"), window.print);
        return false;
    });
    $("#button-highlighting").click(function () {
        $("body").toggleClass("no-highlighting");
        return false;
    });

    $("#button-hide-navigation").click(function () {
        $("body").toggleClass("hide-nav");
        if ($('body[class~="hide-nav"]').length > 0) {
            $("#button-hide-navigation").attr("title", "_{Show Navigation}");
            $("#button-hide-navigation span").text("_{Show Navigation}");
        } else {
            $("#button-hide-navigation").attr("title", "_{Hide Navigation}");
            $("#button-hide-navigation span").text("_{Hide Navigation}");
        }
        return false;
    });
    $("#audience-selector").change(function () {
        suitehelp.changeAudience(true);
        return false;
    });
};

suitehelp.setupThumbNailDialog = function () {
    "use strict";
    $(".thumbnail").click(function () {

        var dialogDimensions = suitehelp.getDialogDimensions($(this));
        $("#thumbnailDialog img").remove();
        $("#thumbnailDialog").append('<img src="' + $(this).attr("src") + '" alt="' + $(this).attr("alt") + '">');
        $('#thumbnailDialog').dialog({
            height: dialogDimensions.height,
            width: dialogDimensions.width,
            title: suitehelp.getDialogTitle($(this)),
            modal: true
        });
    });
    $("body").on("click", ".ui-widget-overlay", function () {
        $('#thumbnailDialog').dialog("close");
    });
};
suitehelp.loadChildren = function (top, dest, andThen) {
    "use strict";
    var li0 = top.children("ul").children("li").first();

    function go(li) {
        if (li.length === 0) {
            return andThen();
        }

        var id = li.attr("id");
        dest.append("<div id='printall-" + id + "'/>");
        //First resolve all urls before loading data for printing
        $.ajax({
            url: li.children("a").attr("href"),
            success: function (data) {
                // Replace all relative URLs with absolute URLs
                data = suitehelp.makeAbsoluteURLs(li.children("a").attr("href"), data);
                var $data = $(data),
                    contentHtml = $data.find("article").html();
                $("#printall-" + id).html(contentHtml);
                suitehelp.loadChildren(li, $("#printall-" + id), function () {
                    go(li.next("li"));
                });
            }
        });
    }
    go(li0);
};

suitehelp.setupTocDragger = function () {
    "use strict";

    // Add the TOC dragger
    $("body").append("<div id='dragger'/>");

    // When the user clicks on the dragger, start listening to mousemove events
    $("#dragger").mousedown(function () {
        // First, turn off text selection. We'll turn it back on later.
        $("body").css("-webkit-user-select", "none");
        $("body").css("-moz-user-select", "none");
        $("body").css("-khtml-user-select", "none");
        $("body").css("user-select", "none");

        $("body").mousemove(function (event) {
            // Adjust CSS properties as necessary
            if (suitehelp.rtl) {
                $("#leftbar").css("width", $(window).width() - event.pageX);
                $("#dragger").css("right", $(window).width() - event.pageX);
                $(suitehelp.draggerMainSel).css("right", $(window).width() - event.pageX + 10);
            } else {
                $("#leftbar").css("width", event.pageX);
                $("#dragger").css("left", event.pageX);
                $(suitehelp.draggerMainSel).css("left", event.pageX + 10);
            }
        });
    });

    // Finished dragging, *or* dragged outside of the browser window
    $(document).mouseup(function () {
        // Stop listening to mousemove events
        $("body").unbind("mousemove");

        // Re-enable text selection
        $("body").css("-webkit-user-select", "");
        $("body").css("-moz-user-select", "");
        $("body").css("-khtml-user-select", "");
        $("body").css("user-select", "");
    });
};

// Determine if Ajax is supported by the current browser on the current page
// by making an asynchronous Ajax call.
// This function is passed two callbacks: one to be performed if Ajax is 
// available, a second to be called if Ajax is not available.
suitehelp.checkAjax = function (withAjax, withoutAjax) {
    "use strict";
    function go(x) {
        suitehelp.hasAjax = x;
        (x ? withAjax : withoutAjax)();
    }

    // Cache the result in the suitehelp object so that only one Ajax call
    // needs be performed. Initially, this value will be undefined. Check for
    // strict equality against true and false to determine if a cached answer
    // is present.
    if (suitehelp.hasAjax === true) {
        withAjax();
    } else if (suitehelp.hasAjax === false) {
        withoutAjax();
    } else {
        // No cache available. Try to load up an arbitrary page from the TOC
        // via Ajax. We need to ensure that the page we are trying to load is
        // not the current page, since most implementations will allow an Ajax
        // load for the current page even if other Ajax loads are disallowed.
        var links = $("nav.toc a[href]"),
            stringLoc = (document.location.href).match(/[^\?]*/)[0],
            // Initial URL to try. If there are no links found in the TOC,
            // try loading the current page.
            url = stringLoc,
            i;
        for (i = 0; i < links.length; i += 1) {
            url = links[i].toString();
            if (url !== stringLoc) {
                break;
            }
        }
        $.ajax({
            url: url,
            success: function (data) {
                // Check that AJAX works by making sure that the data
                // is a string.  This will catch the case of Firefox responding
                // with an empty object in data when running from a filesystem.
                go(typeof data === "string");
            },
            error: function () {
                go(false);
            }
        });
    }
};

suitehelp.setUpAudienceSelector = function () {
    "use strict";
    var values,
        i;
    if ($("#audience-selector").length > 0 && $('nav.toc li').not('[data-audience~="NONE"]').length > 0) {
        suitehelp.audience = true;
        $("#audience-selector").removeClass("hideaudience");
        values = $.map($('#audience-selector option'), function (ele) { return " " + ele.value; });
        values = values + " ";
        values = values.replace(/,/g, " ");
        $('nav.toc li[data-audience~="ALL"]').attr("data-audience", values);
        if (suitehelp.getQueryString("selAudience")) {
            $("#audience-selector").val(suitehelp.getQueryString("selAudience"));
            suitehelp.changeAudience(false);
        } else {
            suitehelp.changeAudience(false);
        }
    } else {
        // Fill an array with all topics in the toc   
        for (i = 0; i < suitehelp.tocArray.length; i += 1) {
            suitehelp.tocObject[suitehelp.tocArray[i]] = i;
        }
    }
};

// Set up page and event handling on page load.
suitehelp.onload = function () {
    "use strict";
    // Context sensitive links
    suitehelp.checkContext();

    // Global variable setup
    suitehelp.currid = $("body").attr("id");

    $("#searchform .submit").attr("value", "_{Go}");
    $("#searchform .search").attr("placeholder", "_{Search}");
    // Left bar setup
    suitehelp.setupLeftBar();
    // Set up History.js
    suitehelp.setupHistory();
    // Do absolute URL conversion of header, footer, article, to get it ready for ajaxification
    function urlConvert(name) {
        var $name = $(name);

        // Nothing to convert if the element doesn't exist
        if (!$name.length) {
            return;
        }

        $name.html(suitehelp.makeAbsoluteURLs(document.location.href, $name.html()));
    }
    urlConvert("article");
    urlConvert("header");
    urlConvert("footer");

    if (suitehelp.styleArticle !== undefined) {
        suitehelp.styleArticle();
    }
    suitehelp.setUpAudienceSelector();
    // Initialize breadcrumbs
    suitehelp.breadcrumbs();

    // Ajaxify the document
    $("body").ajaxify();

    // Set up search form handling
    $("#searchform").submit(function () {
        if ($("body.hide-nav").length) {
            $("body").toggleClass("hide-nav");
        }
        var val = $("#searchform input.search").attr("value");
        if (suitehelp.audience) {
            $("#audience-selector").val("ALL");
            suitehelp.changeAudience(false);
        }
        suitehelp.performSearch(val);
        return false;
    });

    // Enable the #topbuttons
    suitehelp.setupTopButtons();

    suitehelp.setupThumbNailDialog();
    // Setup the TOC dragger
    suitehelp.setupTocDragger();

    // Call customization code
    suitehelp.whLoadHelper(true);

    // Add the ajax class to the body as relevant
    suitehelp.checkAjax(
        function () {
            $("body").addClass("ajax");
            suitehelp.setupIndex();
            suitehelp.loadSearch();
        },
        function () {
            suitehelp.loadIndex();
            // If a q= parameter is available on load, perform an initial search
            suitehelp.performInitialSearch();
        }
    );
    suitehelp.checkScroll();
};

$(suitehelp.onload);
