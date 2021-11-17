# bin/bash

echo "reading config.txt"
if [ -f html/autocomplete-addon/config.txt ]
    then
        array=()
        while IFS= read -r line; do
            array+=($line)
        done < html/autocomplete-addon/config.txt
    else
        echo "config.txt not found!"
fi

projectdir=${array[1]}
echo $projectdir
inputdir=${array[1]}/${array[2]}/${array[3]}
echo $inputdir
outputdir=`${array[1]}/autocomplete-addon`
echo $outputdir
filename="${array[0]}.txt"
echo $filename

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