This example shows how to create a k0s cluster in AWS using Terraform and then install MKE-4 on it.

#### Prerequisites

Along with `mkectl`, you will also need the following tools installed:

* [k0sctl](https://github.com/k0sproject/k0sctl#installation) - required for installing a k0s distribution
* [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) - for creating VMs in AWS

You will also need an AWS account and the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_SESSION_TOKEN` env variables set for the AWS CLI.

#### Create virtual machines on AWS

Creating virtual machines on AWS can be easily done using the [example Terraform scripts](./terraform/).

After copying the example Terraform folder to your local machine, you can create the VMs with the following steps:

1. Create a `terraform.tfvars` file with content similar to:
```
cluster_name = "k0s-cluster"
controller_count = 1
worker_count = 1
cluster_flavor = "m5.large"
region = "us-east-1"
```
2. `terraform init`
3. `terraform apply -auto-approve`
4. `terraform output --raw k0s_cluster > VMs.yaml`

> To get detailed information about the created VMs, use the AWS CLI:
> ```
> aws ec2 describe-instances --region $(grep "region" terraform.tfvars | awk -F' *= *' '{print $2}' | tr -d '"')
> ```
> Alternatively, for a visual overview:
> Go to the AWS EC2 page. Select the desired region from the dropdown menu at the top-right corner.

#### Install MKE4 on `k0s`

1. Generate a sample mke.yaml file using the following command:
```shell   
mkectl init > mke.yaml
```

2. Edit the `hosts` section in `mke.yaml` using the values from the `VMs.yaml` file.

The `hosts` section should look similar to:
```yaml
hosts:
  - role: controller+worker
    ssh:
      address: 54.91.231.190
      keyPath: <path_to_terraform_folder>/aws_private.pem
      port: 22
      user: ubuntu
  - role: worker
    ssh:
      address: 18.206.202.16
      keyPath: <path_to_terraform_folder>/aws_private.pem
      port: 22
      user: ubuntu
```

3. Create the MKE-4 cluster
```shell
mkectl apply -f mke.yaml
```

This shall install MKE-4 in the aws cluster.

#### Cleanup

Delete virtual machines by changing to the example Terraform folder and running:
``` bash
terraform destroy --auto-approve
```
