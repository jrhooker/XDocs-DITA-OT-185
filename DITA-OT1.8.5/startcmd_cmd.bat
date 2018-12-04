@echo off
REM  This file is part of the DITA Open Toolkit project hosted on 
REM  Sourceforge.net. See the accompanying license.txt file for 
REM  applicable licenses.
REM  (c) Copyright IBM Corp. 2006 All Rights Reserved.

REM Get the absolute path of DITAOT's home directory
set DITA_DIR=%~dp0

REM Set environment variables
set ANT_OPTS=-Xmx3200m %ANT_OPTS%
set ANT_OPTS=%ANT_OPTS% -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl
set ANT_HOME=%DITA_DIR%tools\ant
set JHHOME=%DITA_DIR%lib\javahelp2_0_04\jh2.0\
set PATH=%DITA_DIR%tools\ant\bin;%DITA_DIR%lib\ImageMagick-7.0.6-Q16;%PATH%
set CLASSPATH=%DITA_DIR%lib;%DITA_DIR%lib\dost.jar;%DITA_DIR%lib\commons-codec-1.4.jar;%DITA_DIR%lib\resolver.jar;%DITA_DIR%lib\icu4j.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\xercesImpl.jar;%DITA_DIR%lib\xml-apis.jar;%CLASSPATH%
set CLASSPATH=%DITA_DIR%lib\saxon\saxon9.jar;%DITA_DIR%lib\saxon\saxon9-dom.jar;%CLASSPATH%

REM ant -Dargs.dir.input=%1 -Dargs.input=%2  -Dtranstype=%3 -Dvalidate=%4 -Dpdf.formatter=%5 -Doutput.dir=%6 -Douter.control=warn -Dclean.temp=true  -DmaxJavaMemory=3200m 

REM ant -Dargs.dir.input=samples/PublishTest -Dargs.input=samples/PublishTest/PublishTest.ditamap  -Dtranstype=mchp-pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/PublishTest/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m 

REM ant -Dargs.dir.input=samples/PublishTest -Dargs.input=samples/excel/excel.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/excel/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/digi -Dargs.input=samples/digi/digi.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/digi/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

ant -Dargs.dir.input=samples/sectionnum -Dargs.input=samples/sectionnum/sectionnum.ditamap  -Dtranstype=mchp-pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/sectionnum/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m