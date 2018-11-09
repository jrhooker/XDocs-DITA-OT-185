<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

    <xsl:output method="xml"/>

    <xsl:template match="/*">
        <html>
            <head>
                <title>SuiteHelp Demo</title>
            </head>
            <body id="SuiteHelpDemo">
                <h1>Welcome to the SuiteHelp Demo</h1>
                <p>SuiteHelp is the new online help platform built ground-up on the latest web standards and technologies including HTML5, CSS3 and Ajax. SuiteHelp is cross-platform, mobile-friendly and supports all the major web browsers and operating systems, deployment on server or client, as well as packaging into a single executable file - without need for any client installation. SuiteHelp does not use frames or other outdated HTML features, enabling quick, secure and reliable access to content.</p>
                <h2>Basic Features</h2>
                <ul>
                    <li>Collapsible table of contents (TOC)</li>
                    <li>Index</li>
                    <li>Search</li>
                    <li>Glossary</li>
                    <li>Breadcrumbs</li>
                    <li>Browse</li>
                    <li>Context sensitivity</li>
                </ul>

                <h2>Localization</h2>

                <p>The content and platform can be fully localized into multiple languages, including European, Far Eastern and right-to-left languages</p>

                <h2>Deployment Options</h2>
                <p>SuiteHelp can be deployed in a variety of configurations: on a server or client, as a set of uncompiled HTML and script files or as a single packaged executable.</p>
                <p>The platform supports Internet Explorer, Firefox, Chrome and Safari on Windows, Linux and Mac.</p>
                <p>Content is served using Ajax and HTML5, yet remains backwards compatible with older systems by implementing graceful degradation. </p>

                <h2>Delivering Your Content with SuiteHelp</h2>
                <p>SuiteHelp is easily modified to support corporate branding standards, color schemes, logos and icons using standard CSS3.</p>
                <p>SuiteHelp ships with a plug-in to the DITA Open Toolkit for fully automated XML publishing and can be easily integrated with all commonly used DITA CMS solutions. Groups using tools such as Robohelp, WebWorks ePublisher, Madcap Flare and AuthorIT can also deliver their content using SuiteHelp.</p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
