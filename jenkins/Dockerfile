FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get install -y awscli && \
    apt-get install -y groovy
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml
