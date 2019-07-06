REM Set the script parameter to "{CacheFile}"
SET file=%1

REM Remove the existing certificate
REM fmsadmin certificate delete --yes

REM Install the new certificate
REM fmsadmin certificate import --yes --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem --intermediateCA C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\ca-%host%-crt.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Restart FileMaker Server
REM net stop "FileMaker Server"
REM net start "FileMaker Server"
