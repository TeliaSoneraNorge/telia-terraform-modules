## ec2/spot-request

Easy way of setting up a spot request, which also takes care of creating:

- Security group (including public egress).
- IAM role with instance profile.

#### Gotchas

##### Need to manually delete instances created
If your Spot request is active and has an associated running Spot Instance, "Canceling the request does not terminate
the instance; you must terminate the running Spot Instance manually."  This means that terraform destroy will not
get rid of everything you have created.  In the case of a script that creates a VPC and a spotfleet cluster you will
need to manually delete the EC2 instances created by the spot before terraform destroy can complete.

##### End date
Spot requests have an end date.  After this date instances that are terminated (manually or due to price point being
exceeded) are not replaced.

Note: By default spot fleets created by this module will become inactive on 2028-05-03T00:00:00Z
