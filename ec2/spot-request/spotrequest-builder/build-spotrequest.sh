#!/bin/bash
if [ "$#" -ne 4 ]; then
    echo 'Must be called with input and output file, number of subnets and pre-defined-spotrequest name e.g  build-spotrequest.sh small.csv spotrequest-small.tf 3 small'
    exit 1
fi
echo 'resource "aws_spot_fleet_request" "'${4}'" {' >${2}
echo 'count = "${var.pre-defined-spotrequest=="'${4}'" ? 1 : 0}"'>>${2}
cat spotfleet-head.template >> ${2}

while IFS=, read type weighting;
  do
    for ((subnet=0; subnet<=$3-1; subnet++));
      do
        cat launch_specification.template |\
          sed 's#{{subnet_id}}#${var.subnet_ids['${subnet}]'}#g' |\
          sed 's#{{weighted_capacity}}#'${weighting}'#g'|\
          sed 's#{{instance_type}}#'${type}'#g' >>${2}
    done
  done <  $1
echo } >>${2}
terraform fmt ${2}
