#!//usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JBOSS_DIR=${JBOSS_DIR:-/usr/src/jboss-eap-6.4}
ZABBIX_SOURCE_DIR=${ZABBIX_SOURCE_DIR:-/usr/src/zabbix-3.2.7}

main() {
    cd "$ZABBIX_SOURCE_DIR" || return 1
    cp "$DIR/JMXItemChecker.java" src/zabbix_java/src/com/zabbix/gateway/JMXItemChecker.java
    ./configure --enable-java
    make install
    cp "$JBOSS_DIR/bin/client/jboss-client.jar" /usr/local/sbin/zabbix_java/lib
}

main "$@"