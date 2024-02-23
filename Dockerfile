# Use Alpine Linux as base image
FROM alpine:latest

# Set environment variables
ENV JMETER_VERSION 5.4.1
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV PATH ${JMETER_HOME}/bin:$PATH

# Install necessary packages
RUN sudo yum update -y && \
    sudo yum install -y java-11-openjdk wget ca-certificates && \
    sudo yum clean all

# Download and install JMeter
RUN wget -q https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xf apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm apache-jmeter-${JMETER_VERSION}.tgz

# Set working directory
WORKDIR ${JMETER_HOME}

# Expose JMeter ports
EXPOSE 1099 60000

# Set default command to run JMeter
CMD ["jmeter", "--version"]
