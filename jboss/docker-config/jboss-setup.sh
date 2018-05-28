#!/bin/bash

# Usage: execute.sh [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.

echo "AAAAAAAAALAAAA=>　★　Executing Customization script"

JBOSS_HOME=/opt/jboss/wildfly
JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

function wait_for_server() {
  until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    echo "＊＊＊＊JBOSS 起動まち＊＊＊＊"
    sleep 1
  done
}

echo "=> Starting WildFly server"

echo "JBOSS_HOME  : " $JBOSS_HOME
echo "JBOSS_CLI   : " $JBOSS_CLI
echo "JBOSS_MODE  : " $JBOSS_MODE
echo "JBOSS_CONFIG: " $JBOSS_CONFIG

echo $JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG &
$JBOSS_HOME/bin/$JBOSS_MODE.sh -b 0.0.0.0 -c $JBOSS_CONFIG &

echo "=> Waiting for the server to boot"
wait_for_server

echo "=> Executing the commands"

/opt/jboss/wildfly/bin/jboss-cli.sh -c --controller=127.0.0.1:9990 <<EOF
#
# SETUP for java:global/earth-sap/properties
#
/subsystem=naming/binding=java\:global\/earth-sap\/properties:add(binding-type=external-context, cache=false, class=javax.naming.InitialContext, module=org.jboss.as.naming, environment=[destinationName=destination1, jco.client.ashost=172.31.194.21, jco.client.user=SAP903, jco.client.passwd=Batch1, jco.client.lang=en, jco.client.sysnr=00, jco.client.client=700, jco.destination.peak_limit=20, jco.destination.pool_capacity=10])
/subsystem=naming/binding=java\:global\/earth-sap\/properties:read-resource

#
# SETUP for java:global/earth/properties
#
/subsystem=naming/binding=java\:global\/earth\/profile:add(binding-type=simple, value=development)
/subsystem=naming/binding=java\:global\/earth\/profile:read-resource
#
# SETUP for java:global/jbpm-package/properties
#
/subsystem=naming/binding=java\:global\/jbpm-package\/profile:add(binding-type=simple, value=development)
/subsystem=naming/binding=java\:global\/jbpm-package\/profile:read-resource

#
# SETUP for java:global/earth-rest-bpm-api/properties
#
/subsystem=naming/binding=java\:global\/earth-rest-bpm-api\/properties:add(binding-type=external-context, cache=false, class=javax.naming.InitialContext, module=org.jboss.as.naming, environment=[scheme=http, host=172.31.206.12, port=8180, contextPath="\/bpm\/restful", userName=jc580, password=jc580, active=1])
/subsystem=naming/binding=java\:global\/earth-rest-bpm-api\/properties:read-resource

#
# SETUP for java:global/earth-rest-bpm-local/properties
#
/subsystem=naming/binding=java\:global\/earth-rest-bpm-local\/properties:add(binding-type=external-context, cache=false, class=javax.naming.InitialContext, module=org.jboss.as.naming, environment=[scheme=http, host=172.31.206.12, port=8180, contextPath="\/bpm\/bpRestful", userName=jc580, password=jc580, active=1])
/subsystem=naming/binding=java\:global\/earth-rest-bpm-local\/properties:read-resource
EOF

