# cat > trace1.sh Create script


#! /bin/sh
set -x #Turn on tracing
echo 1st echo #Do something
set +x #Turn off tracing
echo 2nd echo