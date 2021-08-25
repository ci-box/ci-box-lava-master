#!/bin/sh

DEV_DIR=/etc/lava-server/dispatcher-config/devices

lava-server manage device-types add '*'

# The worker now auto-registers itself to get a token
#for worker in ${WORKERS}; do
#	lava-server manage workers add ${worker} 2>/dev/null
#done

# define definition should be named devicetype_idx@worker.jinja2

# Can fail at first start since worker is not yet registered
for file in ${DEV_DIR}/*.jinja2; do
	type=`basename $file | cut -d_ -f1`
	device=`basename $file | cut -d. -f1`
	worker=`basename $file | cut -d@ -f2 | cut -d. -f1`
	lava-server manage device-types add ${type} 2>/dev/null
	echo "ADDING device <${device}>, type <${type}> to worker <${worker}>"
	lava-server manage devices add --device-type ${type} --worker ${worker} ${device} 2>/dev/null
done

exit 0
