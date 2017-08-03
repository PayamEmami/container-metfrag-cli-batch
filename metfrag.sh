#!/bin/bash



while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -z|--zip)
    ZIPFILE="$2"
    shift # past argument
    ;;
    -p|--parameters)
    PARAM="$2"
    shift # past argument
    ;;
    -d|--database)
    DB="$2"
    shift # past argument
    ;;
    -o|--output)
    OUTPUT="$2"
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
    ;;
esac
shift # past argument or value
done
echo FILE EXTENSION  = "${ZIPFILE}"
echo SEARCH PATH     = "${PARAM}"
echo LIBRARY PATH    = "${DB}"

mkdir -p tmpmetf
mkdir -p resultsmet
unzip "${ZIPFILE}" -d tmpmetf


for filename in tmpmetf/*.*; do

FIleOutName=$(basename ${filename%.*}.csv)

java -Xmx2048m -Xms1024m -jar /usr/local/bin/MetFragCLI.jar "`cat $filename` ResultsFile=resultsmet/${FIleOutName} NumberThreads=1 $PARAM " LocalDatabasePath=${DB}
done

zip -r -j metfragres.zip resultsmet/*.*

cp metfragres.zip ${OUTPUT}




