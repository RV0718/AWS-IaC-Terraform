# ECS AWS Fargate

[AWS Fargate](https://aws.amazon.com/fargate/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&fargate-blogs.sort-by=item.additionalFields.createdDate&fargate-blogs.sort-order=desc) is a serverless compute engine that works with both [ECS](https://aws.amazon.com/ecs/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&ecs-blogs.sort-by=item.additionalFields.createdDate&ecs-blogs.sort-order=desc) and [Amazon Elastic Kubernetes Service](https://aws.amazon.com/eks/?whats-new-cards.sort-by=item.additionalFields.postDateTime&whats-new-cards.sort-order=desc&eks-blogs.sort-by=item.additionalFields.createdDate&eks-blogs.sort-order=desc) (EKS). This technology removes the need to equip and manage servers. This way we only use the resources needed by the application and improve security throughout application isolation.

AWS Fargate isn’t available in all regions. To work with it, first verify its availability in your working region. Check the AWS documentation for more information regarding this matter. This article uses the European (Ireland) region as an example: eu-west-1.

## Terraform Commands

- To initialise the terraform repository.

```
$terraform init
```

- To see the plan or the resources which will get created upon successful execution of terradorm scripts.

```
$terraform plan
```

- Apply the terraform script on target cloud provider

```
$terraform apply
```

- To format all the terraform scripts

```
$terraform fmt
```

- While applying the terraform changes, it will ask you for your permission to go ahead and configured. By adding **-auto-approve** you're giving your permission and no promt will gets displayed.

```
$terraform apply -auto-approve
$terraform destroy -auto-approve
```

- To validate all your terraform scripts.

```
$terraform validate
```