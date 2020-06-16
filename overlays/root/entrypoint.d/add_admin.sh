#!/bin/sh
set +x

lava-server manage users add ${ADMIN_USERNAME} --passwd ${ADMIN_PASSWORD} --email ${ADMIN_EMAIL} --superuser --staff 2>/dev/null
if [ ! -z ${ADMIN_TOKEN} ]; then
        lava-server manage tokens add --user ${ADMIN_USERNAME} --description "Admin token" --secret ${ADMIN_TOKEN}
fi

exit 0
