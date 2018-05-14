#!/bin/bash
if [ "$#" -ne 3 ]; then
    echo 'Must be called with input and output file and number of subnets e.g  build-spotrequest.sh small.csv small.tf 3'
    exit 1
fi

cat spotfleet-head.template > ${2}

while IFS=, read type weighting;
  do
    for ((subnet=0; subnet<=$3-1; subnet++));
      do
        cat launch_specification.template |\
          sed 's#{{subnet_id}}#${var.subnets['${subnet}]'}#g' |\
          sed 's#{{weighted_capacity}}#'${weighting}'#g'>>${2}
    done
  done <  $1
echo } >>${2}
terraform fmt ${2}
