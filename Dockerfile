
# Use the official Amazon Linux 2 image as base
FROM amazonlinux:2

# Update package repositories and install necessary packages
RUN yum update -y && \
    yum install -y java-11-amazon-corretto-devel curl tar gzip && \
    yum clean all

# Set JMeter version as a build argument
ARG JMETER_VERSION=5.4.1

# Download Apache JMeter using wget
RUN wget -q https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz -O /tmp/apache-jmeter-${JMETER_VERSION}.tgz \
    && tar -xzf /tmp/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm /tmp/apache-jmeter-${JMETER_VERSION}.tgz

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/lib/jvm/java-11-amazon-corretto

# Set JMeter home environment variable
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}

# Set JMeter bin directory in the path
ENV PATH $JMETER_HOME/bin:$PATH

# Expose JMeter ports
EXPOSE 1099 60000

# Set default command to run JMeter
CMD ["jmeter"]
