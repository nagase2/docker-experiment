# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:8

# Set the WILDFLY_VERSION env variable
# ENV WILDFLY_VERSION 10.1.0.Final
# ENV WILDFLY_SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333

ENV WILDFLY_VERSION 12.0.0.Final
ENV WILDFLY_SHA1 b2039cc4979c7e50a0b6ee0e5153d13d537d492f 

ENV JBOSS_HOME /opt/jboss/wildfly


USER root

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

ADD build/libs/docker-experiment.war /opt/jboss/wildfly/standalone/deployments/

# ここで、予め用意しておいたstandalone.xmlに置き換える


RUN /opt/jboss/wildfly/bin/add-user.sh admin password --silent

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990


# FROM jboss/wildfly
#RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365 --silent


# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["echo", "起動を開始します"]
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

