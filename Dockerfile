# building from the InterSystems IRIS
FROM store/intersystems/iris-community:2019.4.0.379.0

# we need to use Root user to set up environment USER root
USER root

# copy all external dependencies, you can use apt-get here 

# copy in application code and build class 
#RUN mkdir -p /opt/webinar/install
#COPY install /opt/webinar/install
#RUN mkdir -p /opt/webinar/src
#COPY src /opt/webinar/src/

# change permissions to IRIS user
#RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/webinar

# Change back to IRIS user 
USER irisowner

# Compile the application code
RUN iris start iris && \
    printf 'zn "USER" \n \
    zn "%%SYS"\n \
    Do ##class(Security.Users).UnExpireUserPasswords("*")\n \      
    do ##class(SYS.Container).QuiesceForBundling()\n \
    h\n' | irissession IRIS \
&& iris stop iris quietly 
