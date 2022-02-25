# bin/bash

echo "download static search"
rm -rf ./static-search
rm -rf ./tmp
wget https://github.com/projectEndings/staticSearch/archive/refs/tags/v1.4.1.zip && unzip v1.4.1.zip -d tmp && rm v1.4.1.zip
mv ./tmp/staticSearch-1.4.1 ./static-search && rm -rf ./tmp

echo "get stopword list"
wget https://raw.githubusercontent.com/stopwords-iso/stopwords-de/master/stopwords-de.txt -O stopwords.txt
touch words.txt

echo "copy/replace custom makeSearchPage.xsl"
cp ./static_search_customized/makeSearchPage_custom.xsl ./static-search/xsl/makeSearchPage.xsl

echo "copy/replace custom StaticSearch.js"
cp ./static_search_customized/StaticSearch_custom.js ./static-search/js/StaticSearch.js
