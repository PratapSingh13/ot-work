#!/bin/bash
clear
. /etc/os-release

echo "Your OS is $ID"
echo " "
if [ $ID == ubuntu ]
    then
        osVersion=$(cat /etc/os-release | awk -F= '/VERSION_ID/{print $2}' | sed 's|"||g')
        
        if [[ ("$osVersion" == "16.04" || "$osVersion" == "18.04") ]]
            then
            echo $osVersion
            else
            echo "You have not required version"
        fi
        elif [ $ID == centos ]
            then
            osVersion=$(cat /etc/os-release | awk -F= '/VERSION_ID/{print $2}' | sed 's|"||g')
            if [[ ("$osVersion" == "6" || "$osVersion" == "7") ]]
               then
               echo $osVersion
               else
               echo "You have not required version"
            fi
    else
       echo "You need to have either Ubuntu or Centos"       
fi
echo " "

#Check staus of Python
pythonStatus=$(which python > /dev/null)
if [[("$osVersion" == "16.04" || "$osVersion" == "18.04") && $pythonStatus -ne 0  ]]
   then
   echo "About to install Python"
   sudo apt-get install python
   elif [[ ("$osVersion" == "6" || "$osVersion" == "7") && $pythonStatus -ne 0  ]]
     then
      echo "About to install Python"
      sudo yum install python
     else
     echo "Some error occured"
fi


choice=0
while [ $choice -lt 6 ]
 do
  #Providing List of Features to the User
   echo "Press the follwing and Hit ENTER to do:"
   echo "1) Using Package Manager"
   echo "2) Using PIP"
   echo "3) Using Source Code"
   echo "4) Using Tarball"
   echo "5) Exit"
   read choice

   case $choice in
      1) echo " " 
         echo "Using Package Manager"
         which ansible > /dev/null
          if [[("$osVersion" == "16.04" || "$osVersion" == "18.04") && $? -ne 0  ]]
             then
              sudo apt install ansible
             elif [[ ("$osVersion" == "6" || "$osVersion" == "7") && $? -ne 0  ]]
                  then
                    sudo yum install ansible
             else
              echo "Some issues occured" 
         fi
      ;;

      2) echo " "
         echo "Installing Ansible using PIP"
         pipStatus = $(which pip > /dev/null)
         if [[($ID == ubuntu ) && $pipStatus -ne 0 ]]
            then
            sudo apt-get install python-pip
            elif [[$ID == centos && $pipStatus -ne 0  ]]
               then
                 sudo yum install python-pip
               else
               echo "Some issues occured"  
         fi
          ansibleStatus = $(which ansible > /dev/null)
          if [ $ansibleStatus -ne 0 ]
             then
               pip install --user ansible
             else
               echo "You already have Ansible"  
           fi    
      ;;

      3) echo " "
         echo "Installing Ansible through Source Code"
         git clone https://github.com/ansible/ansible.git
         cd ./ansible
         source ./hacking/env-setup
         git pull --rebase
         git submodule update --init --recursive
         echo "127.0.0.1" > ~/ansible_hosts
         export ANSIBLE_INVENTORY=~/ansible_hosts
      ;;

      4) echo " "
         echo "Installing Ansible using Tarball"
         curl -o ansible.tar.gz https://releases.ansible.com/ansible/ansible-latest.tar.gz 
         tar xvf ansible.tar.gz
         cd ansible-2.9.6/
         sudo python setup.py install
         PATH=$PATH:/usr/local/bin
      ;;

      5) echo " "
         echo "About to Exit"
	      echo " "
	      exit
      ;;    

      *)
         echo "Please Pass Valid Argument"
         exit
      ;;     
   esac
done