# Terraform

## Commands to execute the scripts

```
$ terraofrm fmt
$ terraofrm init
$ terraofrm plan
$ terraofrm validate
$ terraofrm apply -auto-approve
$ terraofrm destroy -auto-approve

```

## Terraform Commands description

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
