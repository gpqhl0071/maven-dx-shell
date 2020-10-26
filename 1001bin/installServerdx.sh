# 解析编译后的包
tar -zxvf *.tar.gz
file_name=$(ls *.tar.gz)
file_name_d=${file_name%-assembly.tar.gz}

cd ${file_name_d}
zip -r dx.zip *

mv dx.zip ../

cd ../

path_name=$(pwd)
rm -rf ${path_name}/lib

unzip -o dx.zip