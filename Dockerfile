FROM openjdk:8-alpine

ARG RELEASE=4.0.0.1744

LABEL maintainer="Goffity Corleone"

WORKDIR /root

RUN apk add --no-cache  curl grep sed unzip

RUN curl --insecure -o ./sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${RELEASE}-linux.zip
RUN unzip sonarscanner.zip
# RUN mv sonar-scanner-${RELEASE}-linux /usr/lib/sonar-scanner
# RUN ln -s /usr/lib/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner
RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /root/sonar-scanner-${RELEASE}-linux/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/root/sonar-scanner-${RELEASE}-linux
ENV PATH $PATH:/root/sonar-scanner-${RELEASE}-linux/bin

COPY sonar-project.properties ./sonar-scanner-${RELEASE}-linux/conf/sonar-scanner.properties

CMD sonar-scanner -Dsonar.projectBaseDir=./src