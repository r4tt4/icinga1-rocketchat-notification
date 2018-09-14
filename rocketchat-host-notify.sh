#!/bin/bash

ICINGA_HOSTNAME="<YOUR_ICINGA1_HOSTNAME"
ROCKETCHAT_WEBHOOK_URL="<YOUR_ROCKETCHAT_WEBHOOK_INTEGRATION_URL>"
NOTIFICATIONTYPE="$1"
HOSTNAME="$2"
HOSTSTATE="$3"
HOSTOUTPUT="$4"
LONGDATETIME="$5"

MESS="$1"

#Set the message icon based on ICINGA service state
if [ "$HOSTSTATE" = "DOWN" ]
then
    ICON=":exclamation:"
elif [ "$HOSTSTATE" = "UP" ]
then
    ICON=":white_check_mark:"
else
    ICON=":white_medium_square:"
fi

#Send message to Rocket.Chat
PAYLOAD="payload={\"text\": \"${ICON} *** ${NOTIFICATIONTYPE} *** \n Host: ${HOSTNAME} is ${HOSTSTATE} \n Status: ${HOSTOUTPUT} \n Date: ${LONGDATETIME}  \"}"

curl --connect-timeout 30 --max-time 60 -s -S -X POST --data-urlencode "${PAYLOAD}" "${ROCKETCHAT_WEBHOOK_URL}"

