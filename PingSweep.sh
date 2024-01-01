#!/bin/bash

# add a newline before printing the final msg
trap "echo 'Exiting program'; exit 2" 2
echo "Please enter the subnet:"
read SUBNET
    
function ping_and_get_output(){
    # Perform the actual ping and return the loss percentage 
    packet_loss=$(ping -c 2 $SUBNET.$IP | sed -n 'x;$p' | rev | cut -d "," -f 2 | rev | cut -d "%" -f 1)
    echo $packet_loss
}
for IP in $(seq 1 254); do
    packet_losp=$(ping_and_get_output $IP)
    # Check whether the packet was delivered.
    case $packet_losp in 
        "100") echo "Unable to connect to host: $SUBNET.$IP" ;;
        *) echo "Host $SUBNET.$IP is up" ;;
    esac
done

echo "PingSweep completed succesfully"
exit 0

