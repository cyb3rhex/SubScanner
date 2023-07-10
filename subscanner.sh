#!/bin/bash

SCRIPT_NAME="SubScanner"
SCRIPT_VERSION="1.0"
SCRIPT_DEVELOPER="LSDeep"

clear

# Banner
echo "==================================================================="
echo "              $SCRIPT_NAME - Version $SCRIPT_VERSION"
echo "                    Dev: $SCRIPT_DEVELOPER"
echo "          Fast SubD3main Scanner - level23hacktools.com."
echo "==================================================================="

read -p "Enter the domain: " DOMAIN

SUBDOMAINS=("www" "mail" "webmail" "blog" "ftp" "admin" "secure" "dashboard")

for SUBDOMAIN in "${SUBDOMAINS[@]}"
do
    URL="${SUBDOMAIN}.${DOMAIN}"
    IP=$(nslookup "$URL" 2>/dev/null | awk '/^Address: / { print $2 }')

    if [ -z "$IP" ]
    then
        echo "${URL} does not resolve to an IP address."
    else
        HTTP_CODE=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "http://${URL}")
        HTTPS_CODE=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "https://${URL}")

        echo "URL: ${URL}, IP: ${IP}, HTTP: ${HTTP_CODE}, HTTPS: ${HTTPS_CODE}"
    fi
done
