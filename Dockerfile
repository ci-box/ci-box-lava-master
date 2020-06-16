ARG version=latest
FROM lavasoftware/lava-server:${version}

ARG extra_packages=""
RUN apt -q update || apt -q update
RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y install ${extra_packages}

ARG admin_username="admin"
ENV ADMIN_USERNAME=$admin_username

ARG admin_password="password"
ENV ADMIN_PASSWORD=$admin_password

ARG admin_email="$admin_username@localhost.com"
ENV ADMIN_EMAIL=$admin_email

ARG admin_token=""
ENV ADMIN_TOKEN=$admin_token

ARG workers=
ENV WORKERS=$workers

ENTRYPOINT ["/root/entrypoint.sh"]
