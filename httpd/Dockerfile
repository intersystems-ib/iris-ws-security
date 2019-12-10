FROM ubuntu:latest

# == install apache + mod_ssl
RUN apt-get update && apt-get -y install apache2
RUN a2enmod ssl

# == enable SSL site
WORKDIR /etc/apache2/sites-enabled
RUN ln -s ../sites-available/default-ssl.conf default-ssl.conf

# == install webgateway
COPY ./WebGateway-2019.3.0.311.0-lnxubuntux64.tar /tmp
WORKDIR /tmp 
RUN tar -xvf ./WebGateway-2019.3.0.311.0-lnxubuntux64.tar
WORKDIR /tmp/WebGateway-2019.3.0.311.0-lnxubuntux64
# rename directory, to enable install on docker ubuntu platform
RUN mv lnxubuntux64 dockerubuntux64
# unattended web gateway install
WORKDIR /tmp/WebGateway-2019.3.0.311.0-lnxubuntux64/install
RUN printf '1\n\n\n\n\n\niris\n51773\nIRIS\n\n\n\n' | ./GatewayInstall
# webgateway configuration
COPY ./CSP.ini /opt/webgateway/bin/CSP.ini
RUN chown www-data:root /opt/webgateway/bin/CSP.ini
RUN service apache2 restart
WORKDIR /opt/webgateway/bin

# == container entrypoint
CMD apachectl -D FOREGROUND