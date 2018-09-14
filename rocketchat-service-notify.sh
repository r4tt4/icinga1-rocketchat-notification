#!/bin/bash

ICINGA_HOSTNAME="<YOUR_ICINGA1_HOSTNAME>"
ROCKETCHAT_WEBHOOK_URL="<YOUR_ROCKETCHAT_WEBHOOK_INTEGRATION_URL>"
NOTIFICATIONTYPE="$1"
HOSTNAME="$2"
SERVICEDESC="$3"
SERVICESTATE="$4"
SERVICEOUTPUT="$5"
LONGDATETIME="$6"


#Set the message icon based on ICINGA service state
if [ "$SERVICESTATE" = "CRITICAL" ]
then
    ICON=":exclamation:"
elif [ "$SERVICESTATE" = "WARNING" ]
then
    ICON=":warning:"
elif [ "$SERVICESTATE" = "OK" ]
then
    ICON=":white_check_mark:"
elif [ "$SERVICESTATE" = "UNKNOWN" ]
then
    ICON=":question:"
else
    ICON=":white_medium_square:"
fi


#Send message to Rocket.Chat
PAYLOAD="payload={\"text\": \"${ICON} *** ${NOTIFICATIONTYPE} *** \n Service: ${SERVICEDESC} on Host ${HOSTNAME} is ${SERVICESTATE} \n Status: ${SERVICEOUTPUT} \n Date: ${LONGDATETIME} \"}"

curl --connect-timeout 30 --max-time 60 -s -S -X POST --data-urlencode "${PAYLOAD}" "${ROCKETCHAT_WEBHOOK_URL}"

