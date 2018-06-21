# Spot Request Builder

Due to a lack multiple pass interpolation support in Terraform, the spotfleet request files needed for the spot-request resource are very long with a lot of repeated content.
To avoid the inevitable errors that would result from manually trying to build and manage those files this spot request builder was created.

The spot request builder is a shell scirpt that takes 4 paramaters:
 
 1. A file listing the instance types and the weighting (# of vCPUs) you wish to include in your spot request
 2. The name of the terraform file you wish create (e.g  small.tf) 
 3. The number of subnets into which the request can launch a spot instance 
 4. A name for the predefined request that is used in calls to the spot-request module
 
 The script simply creates a terraform aws_spot_fleet_request with a block of code based on the launch_specification.template for each line times the number of subnets required.

