#### gjchentw/debian
A flavored Debian Linux 

[GitHub Package](https://github.com/users/gjchentw/packages/container/package/debian)

ENTRYPOINT /entrypoint.sh:
* if CMD is not given, invoke s6 to init services placed at /etc/s6.d

Services:
* cron
* rsyslogd

Environment Varables:
* use -e TZ="UTC" to switch timezone
* use -e SYSLOG_OPTION="action(type=\"omfwd\" target=\"172.17.0.1\" port=\"514\" protocol=\"tcp\")" to forward the log to another syslog server

