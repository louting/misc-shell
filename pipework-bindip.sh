#!/bin/bash

#####author louting#####

ipsegment=88.88.15
ipstart=201
ipend=211
gateway=88.88.15.1

createip()
{
index=0
for ((ip=$ipstart;ip<$ipend;ip++))
  do
    iplist[index]=$ipsegment.$ip
    index=$(($index+1))
done
}

listcontainername(){
seq=0
for i in `/usr/bin/docker ps |grep ubuntu-ssh |awk '{print $NF}'`
  do
    containername[seq]=$i
    ((seq++))
done
}

bindip()
{
for ((i=0;i<10;i++))
  do

    /usr/bin/pipework enp2s0 ${containername[i]} ${iplist[i]}/24@$gateway

    if [ $i -eq 0 ];then
        echo "#################################################"
        echo "####### Contaniner name & It's Ipaddress.########"
        echo "#################################################"
        echo " "
    fi

    echo "Container name is \"${containername[i]}\" and it's IPaddr is ${iplist[i]}. Bind Success."

    echo "--------------------------------------------------------------------------------------------------"

done
}


###################shell start #########################

createip
listcontainername
bindip

####################shell end ###########################
