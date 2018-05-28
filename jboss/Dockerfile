
# Use latest jboss/base-jdk:8 image as the base
FROM jboss/wildfly:12.0.0.Final
# Set the WILDFLY_VERSION env variable
# ENV WILDFLY_VERSION 10.1.0.Final
# ENV WILDFLY_SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333

#ENV HTTP_PROXY "http://172.21.1.14:12080"
#ENV HTTPS_PROXY "http://172.21.1.14:12080"



ENV JAVA_OPTS="-Xms3g -Xmx3g -XX:MaxMetaspaceSize=6072m -Djava.net.preferIPv4Stack=true"

USER root

ADD ./docker-config/jboss-setup.sh  /tmp
RUN chmod +x /tmp/jboss-setup.sh \
 && chown -R jboss:jboss /opt/jboss/wildfly/ \
 && chmod 777 -R /opt/jboss/wildfly/standalone/configuration/


# # Ensure signals are forwarded to the JVM process correctly for graceful shutdown
# ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

RUN /opt/jboss/wildfly/bin/add-user.sh admin password --silent \
&&  /tmp/jboss-setup.sh
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current/*

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990





# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]



