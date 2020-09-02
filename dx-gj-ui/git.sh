cd /www/project/dx-gj-ui/
git pull

cd /www/wap/
rm -r *.zip

cd /www/project/dx-gj-ui/wap/
zip -r dx.zip *
mv dx.zip /www/wap/

cd /www/wap/
unzip -o dx.zip