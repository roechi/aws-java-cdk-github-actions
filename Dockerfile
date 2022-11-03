FROM adoptopenjdk/openjdk11:debian-slim

RUN apt update && apt install -y nodejs npm python3 python3-pip jq curl bash git docker && \
	ln -sf /usr/bin/python3 /usr/bin/python

COPY entrypoint.sh /entrypoint.sh

ARG USER_HOME_DIR="/root"

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
 && curl -fsSL -o /tmp/apache-maven.tar.gz https://apache.osuosl.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.6-bin.tar.gz \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
 && echo $JAVA_HOME

ENV MAVEN_HOME /usr/share/maven

ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ENTRYPOINT ["/entrypoint.sh"]
