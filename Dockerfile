FROM openjdk:8
RUN echo "Asia/Seoul" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN apt-get update && apt-get install -y unzip wget &&\
 wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.tar.gz --no-check-certificate &&\
 tar -xvzf apache-tomcat-9.0.83.tar.gz &&\
 mv apache-tomcat-9.0.83 /usr/local/tomcat &&\
 rm apache-tomcat-9.0.83.tar.gz &&\
 echo "CATALINA_HOME=/usr/local/tomcat" >> /etc/bashrc &&\
 echo "CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/lib-jsp-api.jar:$CATALINA_HOME/lib/servlet-api.jar" >> /etc/bashrc &&\
 rm -rf /usr/local/tomcat/webapps/*
ENV TZ=Asia/Seoul
COPY stu.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
WORKDIR /usr/local/tomcat
ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh", "run"]
