Installing SSL Certificate on FileMaker Server
==============================================

This article details how to install a Let's Encrypt SSL Certificate on FileMaker Server using the [PKISharp/win-acme](https://github.com/PKISharp/win-acme) Simple ACME Client for Windows.

What is Let's Encrypt?
----------------------

> Let's Encrypt is a free, automated, and open certificate authority (CA), run for the public's benefit. It is a service provived by the [Internet Security Research Group (ISRG)](https://letsencrypt.org/isrg/).
>
> -- <cite>The Linux Foundation</cite>

For more information, visit [LetsEncrypt.org](https://letsencrypt.org).

Enable SSL in FileMaker Admin Console
-------------------------------------

Before an SSL certificate can be installed on FileMaker Server, SSL must first be enabled.

*Note: This step only needs to occur once.*

1. Login to the FileMaker Admin Console.
2. Navigate to the "Database Server > Security" tab.
3. Select the "Use SSL for database connections" check box.
4. Click the "Save" button.
5. Restart the FileMaker Server service:

```dos
net stop "FileMaker Server"
net start "FileMaker Server"
```

Download the PKISharp/win-acme Simple ACME Client
-------------------------------------------------

The win-acme Simple ACME Client provides a command-line tool that simplifies and automates the process of installing an SSL Certificate from Let's Encrypt.

1. Visit the [PKISharp/win-acme Release](https://github.com/PKISharp/win-acme/releases) page.
2. Download the latest "win-acme.vX.X.X.X.zip" file.
3. Extract the folder in a accessible location where it won't be deleted.
    * These files will be used to renew the certificate automatically.
    * Example: C:\Users\Administrator\Documents\win-acme.vX.X.X.X\

Configure the Web Publishing Engine Web Site
--------------------------------------------

With a simple configuration, much of the SSL Certificate installation and update process can be automated.

*Note: This step **usually** only needs to occur once.*

1. Open the Internet Information Services (IIS) Manager.
2. Expand the server tree, which will have the same name as the machine.
3. Expand the "Sites" tree.
4. Select the "FMWebSite" web site.
5. On the right panel, under "Edit Site," select "Bindings..."
6. Click the "Add..." button.
7. Type the host name for the SSL certificate in the "Host name" field.
    * Usually, this will be "www.example.com" or "sub.example.com"
8. Click the "OK" button.
9. Click the "Close" button.

Set Up FileMaker Server Update Script
-------------------------------------

This script will automatically update the FileMaker Server SSL Certificate whenever win-acme runs.

1. Open a text editor.
2. Copy and paste the code into a new file.
3. Save the file as "update-fms-ssl.bat" in the win-acme folder.
    * Example: C:\Users\Administrator\Documents\win-acme.vX.X.X.X\update-fms-ssl.bat

```bat
@ECHO off

SET host=%1

REM Remove the existing certificate
fmsadmin certificate delete

REM Install the new certificate
fmsadmin certificate import --keyfile C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-key.pem --intermediateCA C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\ca-%host%-crt.pem C:\ProgramData\win-acme\httpsacme-v01.api.letsencrypt.org\%host%-crt.pem

REM Restart FileMaker Server
net stop "FileMaker Server"
net start "FileMaker Server"
```

Run win-acme
------------

Now it's time to request the SSL Certificate, validate it, install it, and schedule automatic renewal.

1. Double-click "letsencrypt.exe" executable file.
2. Type "M: Create new certificate with advanced options".
3. Type "1: Single binding of an IIS site".
4. Type the number of the site that matches the host name of the SSL Certificate.
5. Type "5: [http-01] Self-host verification files (recommended)".
6. Type "1: Create or update https bindings in IIS".
7. Type "y" to add another installer step.
8. Type "1: Run a custom script".
9. Type "n" to not user a different site for installation.
10. Type the entire path of the "update-fms-ssl.bat" script.
    * Example: C:\Users\Administrator\Documents\win-acme.vX.X.X.X\update-fms-ssl.bat
11. Type "{0}" as a parameter string for the script.
12. Answer any task configuration questions that may pop up.

