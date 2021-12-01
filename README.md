# Docker remote build using Hetzner cloud

## Prerequisites

* Hetzner Cloud Token
* Hetzner DNS Token
* Random domain
* Terraform
* Packer
* hcloud cli (optional)

NOTE: DNS support is optional and you can use public IP but you need to remove dns resources manually from TF code.

## Hetzner cloud setup

1. Login to Hetzner Cloud
2. Create new project
3. Obtain Hetzner Cloud token (read/write)
4. Obtain Hetzner DNS token (DNS panel)

### Build snapshot

1. Export hetzner token

```sh
export HCLOUD_TOKEN=your-token
```

2. Build snapshot

```
cd packer/
packer build image.pkr.hcl
```

3. Make sure snapshot was created successfuly

## Set up infrastructure

1. Init terraform modules

```sh
cd infrastructure
terraform init
```

2. Create secrets file (in `infrastructure` folder) that will be autoloaded on every run (keep it out of repo)

```sh
touch secrets.auto.tfvars
```

3. Edit secrets file

```
hcloud_token="..."
hcloud_dns_token="..."
username="kiwi"
domain="example.com"
subdomain="docker"
public_key="ssh-rsa AAAA..."
server_type="cpx21"
```

4. Run terraform

```
terraform apply
```

This will produce terraform state file, keep it out of repo.

## Docker context setup

1. Wait for DNS to be propagated or use IP (context can be updated later)

```
ssh kiwi@docker.example.com
```

2. Create new context

```sh
docker context create --docker host=ssh://kiwi@docker.example.com remote
docker context ls
```

3. Use context

```
docker context use remote
```

4. Check the configuration and start building

```
docker images
docker ps
docker build ...
docker push ...
```

5. Go back to local builder

```
docker context use default
```

## Appendix

### Checking available server types

```sh
export HCLOUD_TOKEN=...
hcloud server-type list
```

Example output:

```
ID   NAME    CORES   CPU TYPE    MEMORY     DISK     STORAGE TYPE
1    cx11    1       shared      2.0 GB     20 GB    local
3    cx21    2       shared      4.0 GB     40 GB    local
5    cx31    2       shared      8.0 GB     80 GB    local
7    cx41    4       shared      16.0 GB    160 GB   local
9    cx51    8       shared      32.0 GB    240 GB   local
11   ccx11   2       dedicated   8.0 GB     80 GB    local
12   ccx21   4       dedicated   16.0 GB    160 GB   local
13   ccx31   8       dedicated   32.0 GB    240 GB   local
14   ccx41   16      dedicated   64.0 GB    360 GB   local
15   ccx51   32      dedicated   128.0 GB   600 GB   local
22   cpx11   2       shared      2.0 GB     40 GB    local
23   cpx21   3       shared      4.0 GB     80 GB    local
24   cpx31   4       shared      8.0 GB     160 GB   local
25   cpx41   8       shared      16.0 GB    240 GB   local
26   cpx51   16      shared      32.0 GB    360 GB   local
33   ccx12   2       dedicated   8.0 GB     80 GB    local
34   ccx22   4       dedicated   16.0 GB    160 GB   local
35   ccx32   8       dedicated   32.0 GB    240 GB   local
36   ccx42   16      dedicated   64.0 GB    360 GB   local
37   ccx52   32      dedicated   128.0 GB   600 GB   local
38   ccx62   48      dedicated   192.0 GB   960 GB   local
```

Make sure to check pricing:

```sh
hcloud server-type describe cpx21
```

⚠️ Actual prices may be different now

```
ID:		23
Name:		cpx21
Description:	CPX 21
Cores:		3
CPU Type:	shared
Memory:		4.0 GB
Disk:		80 GB
Storage Type:	local
Pricings per Location:
  - Location:	ash:
    Hourly:	€ 0.0110000000000000
    Monthly:	€ 6.9000000000000000
  - Location:	fsn1:
    Hourly:	€ 0.0110000000000000
    Monthly:	€ 6.9000000000000000
  - Location:	nbg1:
    Hourly:	€ 0.0110000000000000
    Monthly:	€ 6.9000000000000000
  - Location:	hel1:
    Hourly:	€ 0.0110000000000000
    Monthly:	€ 6.9000000000000000
```
