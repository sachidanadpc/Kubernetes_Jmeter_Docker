# Use Alpine Linux as base image
FROM amazonlinux:2

# Set environment variables
ENV JMETER_VERSION 5.4.1
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV PATH ${JMETER_HOME}/bin:$PATH

# Install necessary packages
RUN yum update -y && \
    yum install -y java-11-amazon-corretto-devel wget ca-certificates && \
    yum clean all

# Download and install JMeter
RUN curl -L https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xz -C /opt

# Set working directory
WORKDIR ${JMETER_HOME}

# Expose JMeter ports
EXPOSE 1099 60000

# Set default command to run JMeter
CMD ["jmeter", "--version"]
