[
{
    ami = "${ami}"
    instance_type = "c3.large"
    weighted_capacity = 2
    tags = "${tags}"
    subnet_id = "${subnet_id}"
},
{
    ami = "${ami}"
    instance_type = "t2.large"
    weighted_capacity = 2
    tags = "${tags}"
    subnet_id = "${subnet_id}"
},
]