#!/bin/sh

[ "$USER" != "root" ] && echo "run this as root" && exit 1

apt-get update

# install system packages
apt-get install -y collectd daemontools-run python-dev python-setuptools


# install python tools
pip_path=`which pip`
if [ "$pip_path" = "" ]; then
    easy_install pip
    pip install virtualenv
fi;


# install zymbit in a virtualenv
mkdir -p /opt/zymbit

VENV=/opt/zymbit/venv
[ ! -e "$VENV" ] && virtualenv $VENV

LATEST=/opt/zymbit/latest
[ ! -e "$LATEST" ] && ln -s $VENV $LATEST

/opt/zymbit/latest/bin/pip install -U zymbit

echo "You're ready to provision this device.  Please copy your provisioning token from the console at https://zymbit.com/console"
echo "Then run the command:\n/opt/zymbit/latest/bin/zymbit provision <provision token>"

exit 0
