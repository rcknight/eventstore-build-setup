#!/usr/bin/env bash

VERSION=$1 #Todo: check this is valid

RUN_FOLDER="$(pwd)"
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TAR_NAME=EventStore-OSS-Linux-v$VERSION
PACKAGE_NAME=eventstore
TEMP_FOLDER=/tmp/eventstore-packager
INSTALL_FOLDER=usr/eventstore

[ -d $TEMP_FOLDER ] && rm -fr $TEMP_FOLDER

mkdir $TEMP_FOLDER
pushd $TEMP_FOLDER

wget https://github.com/EventStore/EventStore/releases/download/oss-v$VERSION/$TAR_NAME.tar.gz
tar -xf $TAR_NAME.tar.gz

rm $TAR_NAME.tar.gz

mkdir usr
mv $TAR_NAME usr/eventstore

mkdir usr/bin
pushd usr/bin

ln -s ../eventstore/run-node.sh eventstore
ln -s ../eventstore/testclient eventstore-testclient

popd

#mkdir etc
#mkdir etc/eventstore
#cp $SCRIPT_FOLDER/example.yaml etc/eventstore/example.yaml

#Patched run node to change directory correctly when running from symlink
rm $INSTALL_FOLDER/run-node.sh
cp $SCRIPT_FOLDER/run-node-patched.sh $INSTALL_FOLDER/run-node.sh
chmod +x $INSTALL_FOLDER/run-node.sh

#--config-files etc/eventstore
fpm -t deb -s dir -v $VERSION --no-depends --name $PACKAGE_NAME --url http://geteventstore.com --maintainer rich@geteventstore.com  --license "BSD 3-Clause" --description "Event Store Server" .

cp *.deb $RUN_FOLDER

popd

rm -fr $TEMP_FOLDER