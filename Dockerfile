FROM debian:bookworm-slim

ENV	DEBIAN_FRONTEND=noninteractive \
	TZ="Asia/Taipei" \
	SYSLOG_OPTION="|/dev/stdout"

# SYSLOG_OPTION="action(type=\"omfwd\" target=\"172.17.0.1\" port=\"514\" protocol=\"tcp\")"

WORKDIR /
RUN	printf "deb http://httpredir.debian.org/debian bookworm-backports main non-free\ndeb-src http://httpredir.debian.org/debian bookworm-backports main non-free" > /etc/apt/sources.list.d/backports.list && \
	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get install --no-install-recommends --no-install-suggests -y apt-utils && \
	apt-get install --no-install-recommends --no-install-suggests -y \
	  bash bash-completion sudo openssl ca-certificates apt-transport-https rsyslog cron gnupg dirmngr curl wget jq git net-tools dnsutils procps && \
	apt-get -y autoremove && apt-get -y autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	curl -L 'https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-x86.tar.gz' | tar xz

COPY	s6.d /etc/s6.d
COPY	entrypoint.sh /

ENTRYPOINT	["/entrypoint.sh"]
