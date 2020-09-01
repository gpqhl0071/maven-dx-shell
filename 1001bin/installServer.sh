tar -zxvf *.tar.gz
file_name=$(ls *.tar.gz)
file_name_d=${file_name%-assembly.tar.gz}

cd ${file_name_d}
zip -r dx.zip *

mv dx.zip ../work

cd ../work

unzip -o dx.zip