ARG version=latest
FROM lavasoftware/lava-server:${version}

ARG extra_packages=""
RUN apt -q update || apt -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install ${extra_packages}

COPY ./overlays/etc/lava-server/dispatcher-config/device-types/* /etc/lava-server/dispatcher-config/device-types/
COPY ./scripts/add_admin.sh /root/add_admin.sh
COPY ./scripts/populate_devices.sh /root/populate_devices.sh
COPY ./scripts/entrypoint_custom.sh /root/entrypoint_custom.sh

# Add super user
ARG admin_username="root"
ARG admin_password="password"
ARG admin_email="$admin_username@localhost.com"
ARG admin_token=""
RUN /root/add_admin.sh $admin_username $admin_password $admin_email $admin_token

ARG workers=
ENV WORKERS=$workers

ARG dispatcher_ip
RUN if [ "x$dispatcher_ip" != "x" ] ; then echo "dispatcher_ip: $dispatcher_ip" >> /etc/lava-server/dispatcher.d/$workers.yaml; fi

ENTRYPOINT ["/root/entrypoint_custom.sh"]
