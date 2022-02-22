# bin/bash

echo "start ant"
ant

echo "build index staticSearch"
./build_index.sh

echo "create autocomplete filenames"
html/autocomplete-addon/script.sh
