#!/bin/sh

# This script handles the output for the pihole-polybar module
# This script will only work if you have 'jq' and 'curl' installed on your system!
# Feel free to modify this script to your needs!



#################################################################################################
###########################################SETUP START###########################################
#################################################################################################

# Please uncomment 'API_via_IP' & 'IP' if the module doesnt work via FQDN and specify the IP of your pihole 
# In addtion 'API' needs to be commented and vice versa

# IP="192.168.24.1"
# API_via_IP="http://$IP/admin/api.php"
API="http://pi.hole/admin/api.php"

# Specifiy the module output:
# "status" = output the current operational-status of your pihole
# "queries_today" = output total number of queries today
# "blocked_queries" = output blocked queries today
# "blocklist" = output total domains on blocklist

outputType="status"

#################################################################################################
############################################SETUP END############################################
#################################################################################################



#check if at least one type of variable has been specified
if [ -n "$API" ]; then

    #get api data with curl
    current=$(curl -sf "$API")
    exitStatus=$(echo $?)

elif [ -n "$API_via_IP" ]; then

    #get api data with curl
    current=$(curl -sf "$API_via_IP")
    exitStatus=$(echo $?)

else

    #echo error if setup is configured wrong
    echo "Please use either 'API' or 'API_via_IP'!"

fi

# check user selection
case $outputType in

  "status")
    currentOutput="currently $(echo "$current" | jq ".status" | tr '"' '\b')"
    ;;

  "blocklist")
    currentOutput="blocking $(echo "$current" | jq ".domains_being_blocked") domains"
    ;;

  "queries_today")
    currentOutput="received $(echo "$current" | jq ".dns_queries_today") queries"
    ;;

  "blocked_queries")
    currentOutput="blocked $(echo "$current" | jq ".ads_blocked_today") queries"
    ;;

  *)
    currentOutput="Syntax error in \$outputType!"
    ;;

esac

# output based on user preference
if [ "$exitStatus" -eq 0 ]; then

    echo "$currentOutput"

else

    echo "Pi-hole unreachable!"

fi
