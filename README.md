# icinga1-rocketchat-notification
Notification vie Rocket.Chat with ICINGA1. Inspired by https://github.com/BackIsBachus/icinga2-rocketchat-notification

****
Removed Link to Host/Service in Base Version. Maybee will add this feature later, but only for THRUK.
****

****
Installation
****
To use the icinga1-rocket-chat-notification follow this little howto:

- cd to your ICINGA1/libexec dir.
- git clone this repo
- Make sure the two .sh files are executeable and you have curl installed.
- Insert the follwing in your ICINGA1 "notifications command definitions config":

# "notify-host-by-rocketchat" command definition
define command{
        command_name    host-notify-by-rocketchat
        command_line    $USER1$/icinga1-rocketchat-notification/rocketchat-host-notify.sh $NOTIFICATIONTYPE$ $HOSTNAME$ $HOSTSTATE$ $HOSTOUTPUT$ $LONGDATETIME$
	}


# "notify-by-rocketchat" command definition
define command{
        command_name    notify-by-rocketchat
        command_line    $USER1$/icinga1-rocketchat-notification/rocketchat-service-notify.sh $NOTIFICATIONTYPE$ $HOSTNAME$ $SERVICEDESC$ $SERVICESTATE$ $SERVICEOUTPUT$ $LONGDATETIME$
	}

- Make sure you defined a contact for your notifiaction:

# "user_rocketchat" contact definition
define contact{
        contact_name                    user_rocketchat
        alias                           <username>
        service_notification_period     <your_timeperiod>
        host_notification_period        <your_timeperiod>
        service_notification_options    w,u,c,r
        host_notification_options       d,u,r
        service_notification_commands   notify-by-rocketchat
        host_notification_commands      host-notify-by-rocketchat
        }


- And finally check your contactgroups and template definition to use this.

Done.

Feel free to comment and change this for your needs.

