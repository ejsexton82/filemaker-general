REM Set the script parameter to "{0}"
SET host=%1

REM Remove the existing certificate
fmsadmin certificate delete --yes

REM Install the new certificate
fmsadmin certificate import --yes --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem --intermediateCA C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\ca-%host%-crt.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Restart FileMaker Server
net stop "FileMaker Server"
net start "FileMaker Server"
