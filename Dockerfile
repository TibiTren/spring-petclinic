FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
FROM jenkins/jenkins:lts

# 2. Oprim "Setup Wizard-ul" (acel ecran care îți cerea parola inițială și instalarea plugin-urilor)
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# 3. Instalăm automat plugin-ul Configuration as Code
RUN jenkins-plugin-cli --plugins configuration-as-code workflow-aggregator git

# 4. Copiem fișierul nostru YAML în interiorul containerului
COPY jenkins.yaml /var/jenkins_home/jenkins.yaml

# 5. Îi spunem lui Jenkins unde să găsească fișierul pentru a se autoconfigura
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yaml