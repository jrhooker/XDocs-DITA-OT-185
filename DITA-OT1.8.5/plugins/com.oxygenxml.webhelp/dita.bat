@echo off

REM  Oxygen Webhelp plugin
REM  Copyright (c) 1998-2015 Syncro Soft SRL, Romania.  All rights reserved.
REM  Licensed under the terms stated in the license file EULA_Webhelp.txt 
REM  available in the base directory of this Oxygen Webhelp plugin.


REM The path of the Java Virtual Machine install directory
set JVM_INSTALL_DIR=C:\Java\jdk1.7.0_80

REM The path of the DITA Open Toolkit install directory
set DITA_OT_INSTALL_DIR=C:\ProgFiles\XDocs40DRC9Server64\Server\publish\DITA-OT1.8.5_all

REM The path of the Saxon 9.1.0.8 install directory  
set SAXON_9_DIR=C:\ProgFiles\XDocs40DRC9Server64\Server\publish\DITA-OT1.8.5_all\lib\saxon

REM One of the following three values: 
REM      webhelp
REM      webhelp-feedback
REM      webhelp-mobile
set TRANSTYPE=webhelp

REM The path of the directory of the input DITA map file
set DITA_MAP_BASE_DIR=C:\ProgFiles\XDocs40DRC9Server64\Server\publish\DITA-OT1.8.5_all\samples

REM The name of the input DITA map file
set DITAMAP_FILE=hierarchy.ditamap

REM The name of the DITAVAL input filter file 
set DITAVAL_FILE=
REM The path of the directory of the DITAVAL input filter file
set DITAVAL_DIR=


REM  IMPORTANT NOTE: If you use DITA-OT version 1.7.x you must replace 
REM  dost-patches-DITA-1.8.jar with dost-patches-DITA-1.7.jar in the following 
REM  java command.

"%JVM_INSTALL_DIR%\bin\java"^
 -Xmx512m^
 -classpath^
 "%DITA_OT_INSTALL_DIR%\tools\ant\lib\ant-launcher.jar"^
 "-Dant.home=%DITA_OT_INSTALL_DIR%\tools\ant" org.apache.tools.ant.launch.Launcher^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\xercesImpl.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\xml-apis.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\xml-apis-ext.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\dost-patches-DITA-1.8.jar"^
 -lib "%DITA_OT_INSTALL_DIR%"^
 -lib "%DITA_OT_INSTALL_DIR%\lib"^
 -lib "%SAXON_9_DIR%\saxon9.jar"^
 -lib "%SAXON_9_DIR%\saxon9-dom.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\license.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\log4j.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\resolver.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\ant-contrib-1.0b3.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\lucene-analyzers-common-4.0.0.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\lucene-core-4.0.0.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\xhtml-indexer.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.highlight\lib\xslthl-2.1.0.jar"^
 -lib "%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\lib\webhelpXsltExtensions.jar"^
 -f "%DITA_OT_INSTALL_DIR%\build.xml"^
 "-Dtranstype=%TRANSTYPE%"^
 "-Dbasedir=%DITA_MAP_BASE_DIR%"^
 "-Doutput.dir=%DITA_MAP_BASE_DIR%\out\%TRANSTYPE%"^
 "-Ddita.temp.dir=%DITA_MAP_BASE_DIR%\temp\%TRANSTYPE%"^
 "-Dargs.hide.parent.link=no"^
 "-Dargs.filter=%DITAVAL_DIR%\%DITAVAL_FILE%"^
 "-Ddita.input.valfile=%DITAVAL_DIR%\%DITAVAL_FILE%"^
 "-Ddita.dir=%DITA_OT_INSTALL_DIR%"^
 "-Dargs.xhtml.classattr=yes"^
 "-Dargs.input=%DITA_MAP_BASE_DIR%\%DITAMAP_FILE%"^
  "-Dwebhelp.skin.css=%DITA_OT_INSTALL_DIR%\plugins\com.oxygenxml.webhelp\predefined-skins\dita\oxygen\skin.css"^
 "-DbaseJVMArgLine=-Xmx384m"