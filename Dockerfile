# Use the official Amazon Linux 2 image as base
FROM amazonlinux:2

# Update package repositories and install necessary packages
RUN yum update -y && \
    yum install -y java-11-amazon-corretto-devel curl tar gzip && \
    yum clean all

# Set JMeter version as a build argument
ARG JMETER_VERSION=5.6.3

# Download and extract Apache JMeter using curl and tar
RUN curl -L https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xz -C /opt

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-11-amazon-corretto

# Set JMeter home environment variable
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}

# Update the JMeter script to use the correct Java executable path
RUN sed -i "s|JAVA_BIN=.*|JAVA_BIN=\$JAVA_HOME/bin/java|" ${JMETER_HOME}/bin/jmeter

# Set JMeter bin directory in the path
ENV PATH $JMETER_HOME/bin:$PATH

# Expose JMeter ports
EXPOSE 1099 60000

# Set default command to run JMeter
CMD ["jmeter"]
