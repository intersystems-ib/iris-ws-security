# Containers
* irissec: iris community
* httpd: ubuntu + httpd + web gateway

## Requirements
Download `WebGateway-2019.3.0.311.0-lnxubuntux64.tar` from [WRC](https://wrc.intersystems.com) and copy to `httpd/` sub-directory.

## How to run
```
docker-compose build --no-cache
docker-compose up
```

# IRIS
## IRIS As Certificate Authority (CA)
*System Administration > Security > Public Key Infraestructure*
1. Configure local Certificate Authority Server:
* irisLocalCA.cer - local certificate authority
* irisLocalCA.key - private key
* irisLocalCA.srl - serial number

## Create certificates signed by CA
Generate an example certificate.

1. Configure local Certificate Authority client: use local IRIS web port, so we can send CSR to local IRIS CA
2. Submit Certificate Signing Request to CA server
3. Get Certificate from CA server

For instance:
* server.cer - certificate signed by CA
* server.key - private key

## X.509 Credentials
*System Administration > Security > X.509 Credentials*
1. Create new X.509 called 'serverCred' credentials using certificate signed by CA.

## WebService
* Load, compile `Test.MyWebService`.
* A "serverCred" X.509 Credentials is required
* Set up ISCSOAP log
```
 set ^ISCSOAP("Log")="ios"
 set ^ISCSOAP("LogFile")="/shared/soap.log"
```

# SoapUI
* Import SoapUI project. This project will send *BinarySecurityToken* to WebService using a keystore.
* KeyStore can be created from server.cer, server.key files
```
openssl pkcs12 -export -in server.cer -inkey server.key -out server.p12
```
