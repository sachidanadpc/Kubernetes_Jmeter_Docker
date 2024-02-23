FROM amazonlinux:2

RUN yum update -y && \
    yum install -y java-11-amazon-corretto-devel curl && \
    yum clean all

ARG JMETER_VERSION=5.4.1

RUN curl -L https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz --output /opt/apache-jmeter-${JMETER_VERSION}.tgz \
    && tar -xf /opt/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm /opt/apache-jmeter-${JMETER_VERSION}.tgz

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV PATH $JMETER_HOME/bin:$PATH

EXPOSE 1099 60000

CMD ["jmeter"]
