echo 'cd ../dx-web-app/'
cd ../dx-web/

echo 'git pull'
git pull

echo 'cd shell/dx-web/'
cd shell/dx-web/

echo 'mvn clean install --settings ~/.m2/settings-new-work.xml -Dmaven.test.skip=true'
mvn clean deploy --settings ~/.m2/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging
