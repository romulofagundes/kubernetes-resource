# kubernetes-resource

[![Build Status](https://travis-ci.org/zlabjp/kubernetes-resource.svg?branch=master)](https://travis-ci.org/zlabjp/kubernetes-resource)

A Concourse resource for controlling the Kubernetes cluster.

*This resource supports AWS EKS. (kubernetes-sigs/aws-iam-authenticator@v0.4.0)*

- `aws_eks_cluster_name`: the AWS EKS cluster name, required when `use_aws_iam_authenticator` is true.
- `aws_access_key_id`: AWS access key to use for iam authenticator.
- `aws_secret_access_key`: AWS secret key to use for iam authenticator.
- `aws_default_region`: AWS default region.

## Behavior

### `check`: Do nothing.

### `in`: Do nothing.

### `out`: Control the Kubernetes cluster.

Control the Kubernetes cluster like `kubectl apply`, `kubectl delete`, `kubectl set image` and so on.

#### Parameters

- `kubectl`: *Required.* Specify the operation that you want to perform on one or more resources, for example `apply`, `delete`, `set image`.

## Example

```yaml
resource_types:
- name: kubernetes
  type: docker-image
  source:
    repository: romulofc/kubernetes-resource
    tag: "latest"

resources:
- name: aws-eks
  type: kubernetes
  source:
    aws_eks_cluster_name: ((aws_k8s_name))
    aws_access_key_id: ((aws_k8s_access_key_id))
    aws_secret_access_key: ((aws_k8s_secret_access_key))
    aws_default_region: ((aws_k8s_region_name))
- name: my-app
  type: git
  source:
    ...

jobs:
- name: kubernetes-deploy-production
  plan:
  - get: my-app
    trigger: true
  - put: kubernetes-production
    params:
      kubectl: set image -n production deployment/sistema sistema=repository:$(cat .git/ref)
```

# Ref

[Original Source](https://github.com/zlabjp/kubernetes-resource)
