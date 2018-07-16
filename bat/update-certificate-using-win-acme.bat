SET host=www.example.com

REM Remove the existing certificate
fmsadmin certificate delete

REM Install the new certificate
fmsadmin certificate import --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem --intermediateCA C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\ca-%host%-crt.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Restart FileMaker Server
net stop "FileMaker Server"
net start "FileMaker Server"
