#!//usr/bin/env bash

JBOSS_DIR=${JBOSS_DIR:-/usr/src/jboss-eap-6.4}
ZABBIX_SOURCE_DIR=${ZABBIX_SOURCE_DIR:-/usr/src/zabbix-4.0.2}

main() {
    cd "$ZABBIX_SOURCE_DIR" || return 1
    ./configure --enable-java
    make install
    cp "$JBOSS_DIR/bin/client/jboss-client.jar" /usr/local/sbin/zabbix_java/lib
}

main "$@"