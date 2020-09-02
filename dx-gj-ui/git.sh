cd /www/project/dx-gj-ui/
git pull

cd /www/project/dx-gj-ui/wap/

if [ "$1" == "Y" ]; then
  npm install
fi

npm run build

cd /www/wap/
rm -r *.zip

cd /www/project/dx-gj-ui/wap/
zip -r dx.zip .nuxt/ static/ package.json nuxt.config.js
mv dx.zip /www/wap/

cd /www/wap/
unzip -o dx.zip



