# Configuration
DOMAIN="www.example.com"

# Remove the existing certificate
fmsadmin certificate delete --yes

# Install the new certificate
fmsadmin certificate import --yes --keyfile /etc/letsencrypt/live/$DOMAIN/privkey.pem --intermediateCA /etc/letsencrypt/live/$DOMAIN/chain.pem /etc/letsencrypt/live/$DOMAIN/cert.pem

# Restart FileMaker Server
launchctl stop com.filemaker.fms
sleep 15s
launchctl start com.filemaker.fms
