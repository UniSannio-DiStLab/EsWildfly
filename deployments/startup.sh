#!/bin/bash
# startup.sh

mv "/opt/jboss/wildfly/standalone/$DEPLOYMENT" /opt/jboss/wildfly/standalone/deployments/

CLASSPATH=$JBOSS_HOME/modules/system/layers/base/com/mysql/main
CLASSPATH=$CLASSPATH:$CLASSPATH/mysql-connector-java-8.0.12.jar

until java -cp $CLASSPATH TestConnection; do
  >&2 echo "MySQL is unavailable - sleeping 2s"
  sleep 2
done

>&2 echo "MySQL is up - executing command"

/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0