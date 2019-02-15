#!/bin/sh

handler() {
	exit 0
}

trap 'handler' INT QUIT TERM

if [ ${#} -ne 3 ]; then
	echo "usage: ${0} <username> <password> <email>"
	exit 1
fi

/root/entrypoint.sh &
ENTRYPOINT_PID=$!

while [ -z $(pidof /usr/bin/lava-server -xs) ]; do
	echo "${0}: Waiting for lava-server"
	sleep 1
done

lava-server manage users add ${1} --passwd ${2} --email ${3} --superuser

kill -9 ${ENTRYPOINT_PID}

exit 0
