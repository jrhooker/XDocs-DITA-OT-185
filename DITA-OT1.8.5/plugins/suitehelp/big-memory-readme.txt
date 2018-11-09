One of our customers, Fujitsu, has a very large and complex DITA
project that requires quite a bit of memory to compile in SuiteHelp -
at least 8 Gb, perhaps as much as 12 Gb. Here is information about how
to make that work:

1. Currently (August 2013) this cannot be done on Windows. Even when
compiled using a 64-bit GHC on Windows and run on a machine that has
plenty of memory, the resulting suitehelp.exe crashes (with a "BEX64"
error) when compiling very large and complex projects. This appears to
be an issue with the 64-bit GHC compiler for Windows. Instruct the
customer to use Linux or Mac OS X.

2. Make sure that the suitehelp executable was compiled with the
-rtsopts option to GHC. This has been added to the cabal file. But if
we decide to take it out for general builds (e.g. there might be some
minor security issues with this), then a special build would be needed
to enable that option.

3. Add the options "+RTS -K1g -RTS" to the suitehelp command line. If
running in DITA-OT mode, do this by adding three <arg> directives to
the <exec> directive for running suitehelp in
conductor_template.xml. Place these before the other <arg>
directives. This enables the GHC runtime to use up to 1 Gb of memory
for stack space; you can adjust that amount if needed. You can use m
instead of g to specify the amount of memory in megabytes instead of
gigabytes.

4. Instruct the customer to add extra memory to the Java VM as
well. See the instructions how to do that in the DITA-OT User
Guide. Note that since we launch an additional DITA-OT process, this
must be done via an environment variable (ANT_OPTS), not just by the
user specifying it directly on the ant or java command line.
