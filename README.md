Configuring Zabbix for JBoss EAP monitoring
===========================================

Tested with Zabbix 3.2 and JBoss EAP 6.4.

1. Make sure you have a working Zabbix 3.2 and JBoss EAP 6.x installation

Access to each Java gateway is configured directly in Zabbix server or proxy configuration file, thus only one Java gateway may be configured per Zabbix server or Zabbix proxy.

2. Add JBoss EAP management user

```bash
/opt/jboss-eap-6.4/bin/add-user.sh -u zabbix -p <password>
```

3. Install fixed `src/JMXItemChecker.java` Zabbix Java Gateway matching the version of you Zabbix installation from the releases of this repository.

```bash
curl -Lo zabbix.tgz 'https://downloads.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.2.7/zabbix-3.2.7.tar.gz?r=&ts=1503001091&use_mirror=ufpr'
tar xzvf zabbix.tgz
cp src/JMXItemChecker.java zabbix-3.2.7/src/zabbix_java/src/com/zabbix/gateway/JMXItemChecker.java
cd zabbix-3.2.7/
./configure --enable-java
make
cp src/zabbix_java/bin/zabbix-java-gateway-3.2.7.jar /usr/share/zabbix-java-gateway/bin/
cd ..
tar -C /usr/share/zabbix-java-gateway/lib/ -xzvf files/libs.tgz
```

4. Configure Java Gateway in ``/etc/zabbix/zabbix_server.conf``:

/etc/zabbix/zabbix_server.conf:

```ini
JavaGateway = 192.168.122.12
StartJavaPollers = 1
```

https://www.zabbix.com/documentation/3.2/manual/concepts/java

5. `cp /opt/jboss-eap-6.4/bin/client/jboss-client.jar /usr/share/zabbix-java-gateway/lib`

6. Enable ``zabbix-java-gateway`` service

7. Add a JMX interface to JBoss EAP host you want to monitor.the host who is running the Zabbix Java Gateway and monitoring your JBoss EAP servers via JMX, e.g.

* IP/DNS: 192.168.122.12
* Port: 9999

8. Add item with:

interface, username, password, key: jmx["java.lang:type=Memory","HeapMemoryUsage.used"]

## Troubleshooting

com.zabbix.gateway.ZabbixException: javax.security.sasl.SaslException: Authentication failed: the server presented no authentication mechanisms
 => User cannot log in, e.g. because of missing or incorrent login data in Zabbix or missing user in EAP

## Resources

* https://www.zabbix.org/wiki/ConfigureJMX
* https://www.zabbix.org/wiki/Docs/howto/jmx_discovery
* https://github.com/jmxtrans/jmxtrans/wiki/MoreExamples
* https://www.denniskanbier.nl/blog/monitoring/jboss-eap-6-monitoring-using-remoting-jmx-and-zabbix/