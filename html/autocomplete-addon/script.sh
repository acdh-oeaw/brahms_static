# bin/bash

cd html/autocomplete-addon

echo "delete .git"
if [ -d .git ]
    then
        echo "remove .git"
        rm -rf .git
fi

echo "reading config.txt"
if [ -f ./config.txt ]
    then
        array=()
        while IFS= read -r line; do
            array+=($line)
        done < config.txt
    else
        echo "config.txt not found!"
fi

projectdir=${array[1]}
inputdir=${array[2]}/${array[3]}
outputdir=`autocomplete-addon`
filename="${array[0]}.txt"

cd ..
if [ -f $outputdir/$filename ]
    then
        echo "$outputdir/$filename already exists; delete"
        rm -f "$outputdir/$filename"
fi

echo "create file: $filename"
touch "$outputdir/$filename"
echo "open inputdir: $inputdir"
for file in $inputdir/*.json; do
    echo $file | sed -e "s_${projectdir}/__g" >> $outputdir/$filename
done
echo "$filename in $outputdir created"