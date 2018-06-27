# DEPRECATED

This repository has been deprecated as part of this RFC:
https://github.com/TeliaSoneraNorge/rfcs/blob/master/1_terraform/proposal.md

Relevant parts:
- [Where should modules live?](https://github.com/TeliaSoneraNorge/rfcs/blob/master/1_terraform/proposal.md#where-should-modules-live)
- [Should we put modules on the terraform registry?](https://github.com/TeliaSoneraNorge/rfcs/blob/master/1_terraform/proposal.md#should-we-put-modules-on-the-terraform-registry)

To avoid developing on two repository, this one has been archived and will be deleted when everyone has moved over.

## Replacement

#### New organisation

The new organisation for open source software can be found [here](https://github.com/telia-oss), if
you need access talk to @itsdalmo, @mikael-lindstrom or @colincoleman.

#### New (moved) modules

The new repositories can be found here:

- All `terraform-aws-<name>` modules are found in the new org.
- Our published modules can be found here: https://registry.terraform.io/modules/telia-oss
- The new mono repository (for unpublished modules) can be found here (TODO): https://github.com/telia-oss/terraform-aws-modules

All modules will be moved to the new organisation eventually.

#### Moving modules

Both published modules and mono-repo modules should follow the structure of this template:
- https://github.com/telia-oss/terraform-module-template
