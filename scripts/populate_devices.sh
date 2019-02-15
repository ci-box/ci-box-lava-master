#!/bin/sh

DEV_DIR=/etc/lava-server/dispatcher-config/devices

while [ -z $(pidof /usr/bin/lava-server -xs) ]; do
	echo "${0}: Waiting for lava-server"
	sleep 5
done

lava-server manage device-types add '*'

for worker in ${WORKERS}; do
	lava-server manage workers add ${worker}
done

for file in ${DEV_DIR}/*.jinja2; do
	type=`basename $file | cut -d- -f1`
	device=`basename $file | cut -d. -f1`
	worker=`basename $file | rev | cut -d- -f2 | rev`
	echo "ADDING device <${device}>, type <${type}> to worker <${worker}>"
	lava-server manage devices add --device-type ${type} --worker ${worker} ${device}
done
