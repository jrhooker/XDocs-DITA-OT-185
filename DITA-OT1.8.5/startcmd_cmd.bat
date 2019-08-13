@echo off
REM  This file is part of the DITA Open Toolkit project hosted on 
REM  Sourceforge.net. See the accompanying license.txt file for 
REM  applicable licenses.
REM  (c) Copyright IBM Corp. 2006 All Rights Reserved.

REM Get the absolute path of DITAOT's home directory
set DITA_DIR=%~dp0

REM Set environment variables
set JAVA_HOME=C:\ProgFiles\Java\jdk-8u211-64b
set JAVA_OPTS=C:\ProgFiles\Java\jdk-8u211-64b\bin
set ANT_OPTS=-Xms2400m  %ANT_OPTS%
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

REM ant -Dargs.dir.input=samples/sectionnum -Dargs.input=samples/sectionnum/sectionnum.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/sectionnum/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/MCHPSample -Dargs.input=samples/PublishTest/PublishTest.ditamap  -Dtranstype=mchp-pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/PublishTest/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m -Dargs.filter=ditaval/Global_Filterset.ditaval

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/ListNumbering/ListNumbering.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/ListNumbering/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m -Dargs.filter=ditaval/Global_Filterset.ditaval

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/firmware/firmware.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/firmware/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m -Dargs.filter=ditaval/Global_Filterset.ditaval

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/morristown/morristown_arch.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/morristown/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=1200m 

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/Export_2019-03-27_08-16-24/smartHBA2100_smartRAID3100_arcconf_cli.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/psxpfx/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m 

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/morristown/morristown.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/morristown/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m 

REM ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/Export_2019-03-27_08-16-39/SmartRAID-3154-HBA-1100_IUG_Qual.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/morristown/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m 

REM ant -Dargs.dir.input=samples/PublishTest -Dargs.input=samples/PublishTest/PublishTest.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/PublishTest/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/test/jobtemp -Dargs.input=samples/test/test.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/test/jobtemp -Dargs.input=samples/DDR_PPR_library/DDR_PPR_library.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/DDR_PPR_library/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/rda -Dargs.input=samples/rda/pm8596_jtag_view_for_ddimm_vendors_ad_reg.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/rda/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/rda -Dargs.input=samples/diffed/_b-0-file-/Trident/device/devspec/switchtec_g4_psxpfx_device_spec.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/diffed/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/rda -Dargs.input=samples/BSim_Users_Guide/BSim_Users_Guide.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/BSim_Users_Guide/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/psx -Dargs.input=samples/psx/psx.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/psx/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/pcie_subsystem -Dargs.input=samples/pcie_subsystem/pcie_subsystem.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/pcie_subsystem/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/PublishTest -Dargs.input=samples/PublishTest/PublishTest.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/publishtest/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/morristown -Dargs.input=samples/morristown/morristown.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/morristown/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/morristown -Dargs.input=samples/diffed/_b-0-file-/Trident/device/devspec/switchtec_g4_psxpfx_device_spec.ditamap  -Dtranstype=pdf2 -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/trident/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m


REM ant -Dargs.dir.input=samples/fireant -Dargs.input=samples/fireant/Vcore/vcore_map.ditamap  -Dtranstype=eclipsehelp -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/fireant/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/edison -Dargs.input=samples/edison/edison.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/edison/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/PI -Dargs.input=samples/adaptec/adaptec.ditamap -Dtranstype=mchp-xhtml -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/test/adaptec/xhtml -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m

ant -Dargs.dir.input=samples/ListNumbering -Dargs.input=samples/adaptec_1/smarthba_smartraid_releasenotes.ditamap  -Dtranstype=pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/adaptec_1/pdf -Douter.control=warn -Dclean.temp=false -Droot-chunk-override=by-topic  -DmaxJavaMemory=3200m -DFRONTMATTER=0