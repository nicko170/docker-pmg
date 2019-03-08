FROM debian:stretch
MAINTAINER Nick Pratley <nick@npratley.net>

RUN	apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr curl && rm -rf /var/lib/apt/lists/*

RUN	set -x 

RUN     curl http://download.proxmox.com/debian/proxmox-ve-release-5.x.gpg > /etc/apt/trusted.gpg.d/proxmox-ve-release-5.x.gpg

RUN	echo "deb http://download.proxmox.com/debian/pmg stretch pmg-no-subscription" > /etc/apt/sources.list.d/pmg.list

RUN	apt-get update

RUN     echo "postfix postfix/main_mailer_type string Satellite system" > preseed.txt

RUN      debconf-set-selections preseed.txt
RUN      DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix

RUN     apt-get install -y proxmox-mailgateway  \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "root:PMG!" | chpasswd
