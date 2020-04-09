#!/bin/sh

DEV_DIR=/etc/lava-server/dispatcher-config/devices

lava-server manage device-types add '*'

for worker in ${WORKERS}; do
	lava-server manage workers add ${worker} 2>/dev/null
done

# define definition should be named devicetype_idx@worker.jinja2

for file in ${DEV_DIR}/*.jinja2; do
	type=`basename $file | cut -d_ -f1`
	device=`basename $file | cut -d. -f1`
	worker=`basename $file | cut -d@ -f2 | cut -d. -f1`
	echo "ADDING device <${device}>, type <${type}> to worker <${worker}>"
	lava-server manage devices add --device-type ${type} --worker ${worker} ${device} 2>/dev/null
done

exit 0
