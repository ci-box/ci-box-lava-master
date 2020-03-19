#!/bin/sh

# chown fix
/root/chown-fix.sh

# populate devices
/root/populate_devices.sh &

# main entrypoint
/root/entrypoint.sh
