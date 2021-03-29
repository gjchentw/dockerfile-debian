FROM debian:buster-slim

ENV	DEBIAN_FRONTEND=noninteractive \
	TZ="Asia/Taipei" \
	SYSLOG_OPTION="|/dev/stdout"

# SYSLOG_OPTION="action(type=\"omfwd\" target=\"172.17.0.1\" port=\"514\" protocol=\"tcp\")"

WORKDIR /
RUN	printf "deb http://httpredir.debian.org/debian buster-backports main non-free\ndeb-src http://httpredir.debian.org/debian buster-backports main non-free" > /etc/apt/sources.list.d/backports.list && \
	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get install --no-install-recommends --no-install-suggests -y \
	  bash bash-completion sudo openssl ca-certificates apt-transport-https rsyslog cron gnupg dirmngr curl wget jq git net-tools dnsutils procps && \
	apt-get -y autoremove && apt-get -y autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	wget -O- $(curl 'https://api.github.com/repos/just-containers/s6-overlay/releases/latest' | jq -r '.assets |map(select(.name | contains("amd64")))|map(select(.name | contains("sig") | not)) | .[].browser_download_url' | grep 'tar\.gz' | head -n 1) | tar xz

COPY	s6.d /etc/s6.d
COPY	entrypoint.sh /

ENTRYPOINT	["/entrypoint.sh"]
