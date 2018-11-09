#!/bin/bash

DITA_DIR=$(pwd)
echo $DITA_DIR

ANT_OPTS="-Xmx512m $ANT_OPTS -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl"
echo $ANT_OPTS
ANT_HOME="$DITA_DIR/tools/ant"
echo $ANT_HOME
PATH="$DITA_DIR/tools/ant/bin:$PATH"
CLASSPATH="$DITA_DIR/lib:$DITA_DIR/lib/dost.jar:$DITA_DIR/lib/commons-codec-1.4.jar:$DITA_DIR/lib/resolver.jar:$DITA_DIR/lib/icu4j.jar:$CLASSPATH"
CLASSPATH="$DITA_DIR/lib/xercesImpl.jar:$DITA_DIR\lib/xml-apis.jar:$CLASSPATH"
CLASSPATH="$DITA_DIR/lib/saxon/saxon9.jar:$DITA_DIR/lib/saxon/saxon9-dom.jar:$CLASSPATH"
echo $CLASSPATH
ant -f integrator.xml
