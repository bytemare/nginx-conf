#!/usr/bin/env sh

set -e

#
# Create a certificate and make it sign by Let"s Encrypt, using secure parameters and options
# The engine used is acme.sh
#

# Before starting, check out the steps to include DNS operations, necessary for automation

git clone https://github.com/Neilpang/acme.sh.git
cd acme.sh


options=""
options="$options --install"
options="$options --issue"
options="$options --nginx"
options="$options --reloadcmd \"service nginx force-reload\""
options="$options --auto-upgrade"
options="$options --keylength ec-256"
options="$options --ocsp-must-staple"
options="$options --certhome /etc/letsencrypt/certs"

# Change values here
options="$options -d \"*.domain.tld\""
options="$options -d \"domain.tld\""
options="$options --dns "


# Launch acme.sh
sudo ./acme.sh "$options"