#!/bin/bash

if [[ $EUID = 0 ]] 
then
	echo "This script should not be run as root" 1>&2
   	exit 1
fi



installVolatility(){
#setup dir 

cd ~/

#phase-1
echo "Installing Volatility2"
mkdir volatility && cd volatility
 
pip2 install -q --no-python-version-warning pycrypto
pip2 install -q --no-python-version-warning distorm3
mkdir volatility2 && cd volatility2
git clone https://github.com/volatilityfoundation/volatility
cd volatility
#sudo python setup.py install --record volatility2-files.txt
pip2 install -q --no-python-version-warning .
echo "Volatility 2 installed OK."
printf "\n\n"

echo "Installing Volatility3"
cd ~/volatility
mkdir volatility3 && cd volatility3
git clone https://github.com/volatilityfoundation/volatility3.git

cd volatility3
pip3 install -r -q requirements.txt
python3 setup.py build 

pip3 install -qq .
u="$USER"
#echo "User name $u"
echo "export PATH=/home/$u/.local/bin:$PATH" >> ~/.bashrc
. ~/.bashrc
echo "Volatility 3 installed OK."
printf "\nTo use Volatility2 type 'vol.py' in terminal"
printf "\nTo use Volatility3 type 'vol' in terminal\n"
}

uninstallVolatility(){
pip2 uninstall -q -y --no-python-version-warning volatility
printf "\nUninstall Volatility2 OK\n"

pip3 uninstall -q -y volatility3
printf "\nUninstall Volatility3 OK\n"

printf "\nCleaning up.."
rm -rf $HOME/volatility
printf "\ndone.\n"

}

showHelp() {
# `cat << EOF` This means that cat should stop reading when EOF is detected
cat << EOF  
Usage: $0 [-iuh]

-i,	Install Volatility2 & Volatility3

-u,	Install Volatility2 & Volatility3

-h,	Display help

EOF
# EOF is found above and hence cat command stops reading. This is equivalent to echo but much neater when printing out.
}


while getopts "hiu" arg; do
  case $arg in
    i) # install
	installVolatility
	exit 1
	;;
    u) # uninstall
	uninstallVolatility
	exit 1
	;;
    *) # Display help.
	showHelp
	exit 0
	;;
  esac
done

if (( $OPTIND == 1 )); then
	showHelp
fi

exit 1
