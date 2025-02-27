## Lifecycle block

```hcl
lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # ignore_changes = [ name, tags, ] or all # list of attributes
    # replace_triggerred_by = [ aws_vpc.id ] # external dependency trigger
}
```

## Deployment Strategies

- AWS Auto-scaling Group: `instance_refresh` block
- AWS Elastic Container Service: `deployment_maximum_percent` and `deployment_minimum_healthy_percent`
- Kubernetes: `strategy` parameter and `rolling_update` block.

## Loops - Refresh
- **count**
    - Use to loop over an entire resource and modules with same lifecycle and attributes.
    ```hcl
        resource "aws_something" "example" {
            count = 3 
            # or
            # count = var.workspace == "prod" ? 3 : 1 
            # count = length(var.device_names) 
            name = "somename-${count.index}"
            # name = var.device_names[count.index]
        }
    ```
    - Prefer using `for_each` instead of `count`. Because, if you try to individually modify a resource created by `count` (say, _n_), all the resources following this (_n+1_, _n+2_, ...) will get destroyed and recreated due to terraform trying to reorder them. This could cause downtime, or deletition of internal data of the resource.
- **for_each**
    - Use to loop over resources, inline blocks within a resource, and modules.
    - Use `each.key` and `each.value` to fetch values.
    - Supports only `sets` and `maps` when used on a resource.
    - Use for_each for an inline block in a resource. For example,
    ```hcl

    variable "ingress_rules" {
        type = list(object({
            from_port   = number
            to_port     = number
            protocol    = string
            cidr_blocks = list(string)
        }))
        default = [
            {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            },
            {
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            }
        ]
    }

    dynamic "ingress" {
        for_each = var.ingress_rules
        content {
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
        }
    }
    ```
- **for_each** with **if condition**:
    ```hcl
    dynamic "tag {
        for_each = {
            for key, value  in var.custom_tags: key => upper(value) if key!= "Name"
        }
    }
    ```
