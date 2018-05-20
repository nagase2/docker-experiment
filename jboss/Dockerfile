
# Use latest jboss/base-jdk:8 image as the base
FROM jboss/base-jdk:8
# Set the WILDFLY_VERSION env variable
# ENV WILDFLY_VERSION 10.1.0.Final
# ENV WILDFLY_SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333

#ENV HTTP_PROXY "http://172.21.1.14:12080"
#ENV HTTPS_PROXY "http://172.21.1.14:12080"


ENV WILDFLY_VERSION 12.0.0.Final
ENV WILDFLY_SHA1 b2039cc4979c7e50a0b6ee0e5153d13d537d492f 
ENV JBOSS_HOME /opt/jboss/jboss-as-7.1.1.Final

USER root


#http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip \
    && unzip jboss-as-7.1.1.Final.zip \
    && mv $HOME/jboss-as-7.1.1.Final $JBOSS_HOME \
    && rm jboss-as-7.1.1.Final.zip \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

#ADD ./build/libs/jboss.war /opt/jboss/wildfly/standalone/deployments/

# ここで、予め用意しておいたstandalone.xmlに置き換える
#RUN /opt/jboss/jboss-as-7.1.1.Final/bin/add-user.sh admin password --silent



# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

# Expose the ports we're interested in
EXPOSE 8080
EXPOSE 9990





# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]



