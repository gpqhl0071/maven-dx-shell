echo 'checkout $0'
cd ../dx-web-app/
git checkout .
git checkout "$0"
git pull

cd ../maven-dx-shell/
sed -i '/<\/build>/r deploy.xml' ../dx-web-app/pom.xml

mvn clean deploy -P env_staging --settings /usr/share/maven/conf/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging
