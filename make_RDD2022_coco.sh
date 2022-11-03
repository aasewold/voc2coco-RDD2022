#!/bin/bash

RDD2022_PATH=$1
OUTPUT_DIR=RDD2022_COCO

if [ ! -d "$RDD2022_PATH" ]; then
    echo "Error: $RDD2022_PATH is not a valid path"
    exit 1
fi



if [ ! -d $OUTPUT_DIR ]; then
    mkdir $OUTPUT_DIR
fi

for country in China_Drone China_MotorBike Czech India Japan Norway
do

    echo "Processing ${country}..."
    ANNOTATION_PATH=${RDD2022_PATH}/${country}/train/annotations/xmls/

    find $ANNOTATION_PATH -type f | sort > temp_path_list.txt

    JSON_OUTPUT_PATH=$OUTPUT_DIR/${country}/train

    if [ ! -d $JSON_OUTPUT_PATH ]; then
        mkdir -p $JSON_OUTPUT_PATH
    fi

    python voc2coco.py \
        --ann_paths_list temp_path_list.txt \
        --labels labels.txt \
        --output $JSON_OUTPUT_PATH/annotations.json

done

rm temp_path_list.txt

echo "Done!"
