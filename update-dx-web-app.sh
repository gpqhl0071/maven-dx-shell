echo 'cd ../dx-web-app/'
cd ../dx-web-app/

echo 'git pull'
git pull

cd shell/dx-web-app

echo 'mvn deploy install --settings ~/.m2/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging'
mvn clean deploy --settings ~/.m2/settings-new-work.xml -Dmaven.test.skip=true -T6 -Penv_staging
