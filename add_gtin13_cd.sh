#!/bin/bash
function add_cd() {
    if [ ${#1} -ne 12 ]; then
        echo "Your number $1 is ${#1} digits. Please input 12 digits number."
        exit 1
    fi
    local twelve=$1
    local odd=0
    local even=0
    # echo ${twelve:0:1}
    local count=1
    local val_added=0
    local check_digit=0
    while [ $count -lt 13 ]; do
        val_added=${twelve:$(($count - 1)):1}
        if [ $(($count % 2)) -eq 0 ]; then
            even=$(($even + $val_added))
        else
            odd=$(($odd + $val_added))
        fi
        # count=`expr $count + 1`
        count=$((count + 1))
    done
    even=$(($even * 3))
    sum=$(($odd + $even))
    if [ ${sum:$((${#sum} - 1)):1} -ne 0 ]; then
        check_digit=$((10 - ${sum:$((${#sum} - 1)):1}))
    fi
    echo $twelve$check_digit
}
starting_twelve=$1
num_of_jan=$2
for ((i=0;i<$num_of_jan;i++))
do
    processed_twelve=$(($starting_twelve + $i))
    add_cd $processed_twelve
done
