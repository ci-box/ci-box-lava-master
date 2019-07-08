#!/bin/sh

handler() {
	exit 0
}

trap 'handler' INT QUIT TERM

if [ ${#} -le 3 ]; then
	echo "usage: ${0} <username> <password> <email> [token]"
	exit 1
fi

/root/entrypoint.sh &
ENTRYPOINT_PID=$!

while [ -z $(pidof /usr/bin/lava-server -xs) ]; do
	echo "${0}: Waiting for lava-server"
	sleep 1
done

lava-server manage users add ${1} --passwd ${2} --email ${3} --superuser --staff

# Add token manually if any
if [ ${#} -ge 4 ]; then
	lava-server manage tokens add --user ${1} --description "Admin token" --secret ${4}
fi

kill -9 ${ENTRYPOINT_PID}

exit 0
