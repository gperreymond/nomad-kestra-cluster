# Nomad kestra cluster

A complete nomad kestra distibuted cluster

---

## Features

- **Nomad Cluster**: With 3 servers
- **Kestra Cluster**: With 3 tenants (pikachu, ronflex, rondoudou)

---

## Prerequisites

1. Install [ASDF](https://asdf-vm.com/guide/getting-started.html) by following their guide.
2. Ensure you have the necessary permissions to run shell scripts and install dependencies on your system.

---

## Installation

### 1. Install Ministack
Run the following command to install Ministack:
```sh
$ curl -fsSL https://raw.githubusercontent.com/gperreymond/ministack/main/install | bash
```

### 2. Initial Setup
Prepare your environment by executing the setup script:
```sh
$ ./scripts/install-dependencies.sh
```
This will install all ASDF dependencies:

```
nomad 1.10.0
terraform 1.10.4
terragrunt 0.72.6
jq 1.7.1
mc 2025-02-15T10-36-16Z
```

---

## Usage

### Start the Cluster
To start the cluster, use:
```sh
$ ministack --config configurations/servers/cluster.yaml --start
# or...
$ docker compose -f configurations/servers/.ministack/cluster.yaml down
```

### Stop the Cluster
To stop the cluster, use:
```sh
$ ministack --config configurations/servers/cluster.yaml --stop
# or...
$ docker compose -f configurations/servers/.ministack/cluster.yaml down
```

---

### Terragrunt

Now with this nomad cluster, it's time to deploy some jobs.

```sh
# run only once, to create the bucket in minio for terraform states
$ ./scripts/init-minio.sh
# then very classic approach
$ terragrunt init
$ terragrunt apply
```

---

## Directory Structure

- **scripts/**: Contains bash scripts.
- **devops/**: Contains terraform infra provisionning.

---

## Some useful links

When ministack has started:
* http://traefik.docker.localhost
* http://nomad.docker.localhost
* http://minio-webui.docker.localhost (admin/changeme)

After terraform apply:


Everytime you add/update/remove rules or scrape configs, do a prometheus reload:
```sh
$ curl -X POST http://prometheus.docker.localhost/-/reload
```

---

## Contributing

Contributions are welcome! Feel free to fork the repository and submit a pull request.

---
