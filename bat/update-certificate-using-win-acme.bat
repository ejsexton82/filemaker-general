SET host=www.example.com
SET user=Administrator
SET "pass=abcd1234"

REM Remove the existing certificate
fmsadmin certificate delete

REM The intermediate needs to be installed the first time, but causes errors on 
REM subsequent attempts.

REM Try it first with the intermediate
fmsadmin certificate import --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem --intermediateCA C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\ca-%host%-crt.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Try it once without the intermediate
fmsadmin certificate import --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Restart FileMaker Server
fmsadmin restart -y -u %user% -p "%pass%" server
