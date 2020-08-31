#!/bin/sh

root_path="/home/dx_write/project/"

cd "${root_path}"/dx-web/
/home/dx_write/apache-maven-3.6.3/bin/mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6
