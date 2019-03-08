FROM debian:stretch
MAINTAINER Nick Pratley <nick@npratley.net>

RUN	apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr && rm -rf /var/lib/apt/lists/*

RUN	set -x 

RUN	echo "deb http://download.proxmox.com/debian/pmg stretch pmg-no-subscription" > /etc/apt/sources.list.d/pmg.list

RUN	apt-get update \
	&& apt-get install -y proxmox-mailgateway \
	&& rm -rf /var/lib/apt/lists/*

RUN	echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc
