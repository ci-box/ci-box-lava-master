#!/bin/sh

# populate devices
/root/populate_devices.sh &

# main entrypoint
/root/entrypoint.sh
