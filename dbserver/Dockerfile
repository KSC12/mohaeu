FROM centos:centos7

RUN mkdir -p /run/lock/subsys
RUN yum -y update && yum install -y libaio bc initscripts net-tools && yum clean all
RUN export NLS_LANG=KOREAN_KOREA.AL32UTF8
RUN mv /usr/bin/free /usr/bin/free.orig
ADD assets/fake-swap.sh /tmp/fake-swap.sh
ADD sql/startup.sql /tmp/startup.sql
ADD config/initdata.sh /tmp/initdata.sh
RUN chmod 755 /tmp/fake-swap.sh && /tmp/fake-swap.sh && rm /tmp/fake-swap.sh
ADD rpm/oracle-xe-11.2.0-1.0.x86_64.rpm /tmp/
RUN yum localinstall -y /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm; \
    rm -rf /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm
RUN mv /usr/bin/free.orig /usr/bin/free
ADD config/xe.rsp config/init.ora config/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/
RUN chown oracle:dba /u01/app/oracle/product/11.2.0/xe/config/scripts/*.ora \
                     /u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp
RUN chmod 755        /u01/app/oracle/product/11.2.0/xe/config/scripts/*.ora \
                     /u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp
ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV ORACLE_SID  XE
ENV PATH        $ORACLE_HOME/bin:$PATH
RUN /etc/init.d/oracle-xe configure responseFile=/u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp
ADD config/start.sh /
ENTRYPOINT ["/start.sh"]

