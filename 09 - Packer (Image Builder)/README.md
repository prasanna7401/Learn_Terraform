[Packer](./7%20-%20packer/) - VM Image builder tool: can use config management tools like Shell, Ansible, Chef, etc. alongside. Also contains `lifecycle`, `terraform import` examples to build an apache http server

Source - https://developer.hashicorp.com/packer/tutorials/aws-get-started/aws-get-started-build-image

Steps:

1. Install dependencies using `packer init`
2. Build image - `packer build`

Packer code explanation:

- `source{}` - Where & what kind of image to build.
- `build{}` - Reference to the source block configuration, and used to run any additional script using the following blocks,
    - `provisioners{}`
    - `post-provisioners{}`