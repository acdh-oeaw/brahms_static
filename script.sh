# bin/bash

echo "download and copy fundament"
FUNDAMENT_VERSION=1.2.1
FUNDAMENT_GIT=https://github.com/acdh-oeaw/fundament/archive/refs/tags/
wget ${FUNDAMENT_GIT}v${FUNDAMENT_VERSION}.zip && unzip v${FUNDAMENT_VERSION}.zip && rm -rf v${FUNDAMENT_VERSION}.zip
cp -r fundament-${FUNDAMENT_VERSION}/dist  html/
rm -rf fundament-${FUNDAMENT_VERSION}

echo "download saxon"
rm -rf saxon
wget https://sourceforge.net/projects/saxon/files/Saxon-HE/9.9/SaxonHE9-9-1-7J.zip/download && unzip download -d saxon && rm -rf download

echo "copy-task"
ant -f copy-task.xml
