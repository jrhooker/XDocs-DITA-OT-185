#!/bin/sh
#  This file is part of the DITA Open Toolkit project hosted on 
#  Sourceforge.net. See the accompanying license.txt file for 
#  applicable licenses.
#  (c) Copyright IBM Corp. 2006 All Rights Reserved.

realpath() {
  case $1 in
    /*) echo "$1" ;;
    *) echo "$PWD/${1#./}" ;;
  esac
}

if [ "${DITA_HOME:+1}" = "1" ] && [ -e "$DITA_HOME" ]; then
  export DITA_DIR="$(realpath "$DITA_HOME")"
else #elif [ "${DITA_HOME:+1}" != "1" ]; then
  export DITA_DIR="$(dirname "$(realpath "$0")")"
fi

if [ -f "$DITA_DIR"/tools/ant/bin/ant ] && [ ! -x "$DITA_DIR"/tools/ant/bin/ant ]; then
  chmod +x "$DITA_DIR"/tools/ant/bin/ant
fi

export ANT_OPTS="-Xmx1200m $ANT_OPTS"
export ANT_OPTS="$ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
export ANT_HOME="$DITA_DIR"/tools/ant
export PATH="$DITA_DIR"/tools/ant/bin:%DITA_DIR%lib/ImageMagick-7.0.6-Q16:"$PATH"
export JHHOME=%DITA_DIR%lib/javahelp2_0_04/jh2.0

NEW_CLASSPATH="$DITA_DIR/lib/dost.jar"
NEW_CLASSPATH="$DITA_DIR/lib:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/commons-codec-1.4.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/resolver.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/icu4j.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xercesImpl.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/xml-apis.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9.jar:$NEW_CLASSPATH"
NEW_CLASSPATH="$DITA_DIR/lib/saxon/saxon9-dom.jar:$NEW_CLASSPATH"
if test -n "$CLASSPATH"; then
  export CLASSPATH="$NEW_CLASSPATH":"$CLASSPATH"
else
  export CLASSPATH="$NEW_CLASSPATH"
fi

echo input: $1
echo transtype: $2
echo validate: $3
echo pdf.formater: $4
echo output.dir: $5
echo filter: $6

ant -Dargs.input=$1  -Dtranstype=$2 -Dvalidate=$3 -Dpdf.formatter=$4 -Doutput.dir=$5 -Dargs.filter=$6 -Douter.control=warn -Dclean.temp=true -DmaxJavaMemory=3200m

REM ant -Dargs.dir.input=samples/PublishTest -Dargs.input=samples/PublishTest/PublishTest.ditamap  -Dtranstype=mchp-pdf -Dvalidate=false -Dpdf.formatter=xep -Doutput.dir=out/PublishTest/pdf -Douter.control=warn -Dclean.temp=false  -DmaxJavaMemory=3200m 