#!/usr/bin/env bash

TEMP_FOLDER=/tmp/eventstore-repo
RUN_FOLDER="$(pwd)"
SCRIPT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir $TEMP_FOLDER
pushd $TEMP_FOLDER

for ver in "$@" 
do
	$SCRIPT_FOLDER/package.sh $ver
done

mkdir eventstore-repository
mkdir eventstore-repository/binary

cp ./*.deb eventstore-repository/binary

pushd eventstore-repository
dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz
popd

cp -r eventstore-repository $RUN_FOLDER

popd

rm -fr $TEMP_FOLDER