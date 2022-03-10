### In this project, below resources will be newly provisioned .
1. IPAM + VPC(Subnets/IGW/EIPs/NGWs/RTs)
2. EC2
3. ElastiCache for Redis

### Step 1. VPC
####1) IPAM

> Plan for IP address provisioning: Pools in multiple AWS Regions - https://docs.aws.amazon.com/vpc/latest/ipam/planning-examples-ipam.html#w2aab9c13c21b5

- [x] IPAM - regions: ap-northeast-2, us-east-1, us-west-2
  - [x] top_level_pool - cidr: 10.0.0.0/8
    - [x] apn2_pool - region: ap-northeast-2, scope: private_scope, cidr: 10.0.0.0/16
      - [x] dev_apn2_pool - region: ap-northeast-2, scope: private_scope
        - dev_apn2_cidr_public_001: 10.0.0.0/24
        - dev_apn2_cidr_public_002: 10.0.1.0/24
        - dev_apn2_cidr_private_001: 10.0.2.0/24
        - dev_apn2_cidr_private_002: 10.0.3.0/24
      - [ ] ~~prod_apn2_pool - region: ap-northeast-2, scope: private_scope~~
        - prod_apn2_cidr_public_001: 10.0.10.0/24
        - prod_apn2_cidr_public_002: 10.0.11.0/24
        - prod_apn2_cidr_private_001: 10.0.12.0/24
        - prod_apn2_cidr_private_002: 10.0.13.0/24
    - [ ] ~~ue1_pool~~
    - [ ] ~~uw2_pool~~

*In this project, prod_apn2_pool, ue1_pool and uw2_pool will not be provisioned.*


####2) A VPC (with basic Resource configuration)
***The module for vpc 'terraform-aws-vpc' will be used in the following project.***
- VPC - IPAM_pool: dev_apn2_pool
  - Subnets
    - dev_public_subnets_001: ap-northeast-2a, cidr: dev_apn2_cidr_public_001.cidr
    - dev_public_subnets_002: ap-northeast-2c, cidr: dev_apn2_cidr_public_002.cidr
    - dev_private_subnets_001: ap-northeast-2a, cidr: dev_apn2_cidr_private_001.cidr
    - dev_private_subnets_001: ap-northeast-2c, cidr: dev_apn2_cidr_private_002.cidr
  - Internet Gateway
  - EIP: 2 for NGWs
  - Nat Gateway: 2 for each AZ
  - Route Table
    - default_route_table: dev_public_rt
    - route_table: dev_private_rt_001, dev_private_rt_002

####3) File List
- IPAM
  - resource-IPAM.tf
  - variables-IPAM.tf
- VPC
  - resource-vpc.tf
  - variables-vpc.tf
---
### Step 2. EC2 instance
####1) Security group for ssh
####2) EC2 instance as a bastion host and Redis client

---
### Step 3. ElastiCache for Redis
####1) Subnet group for Redis cluster
####2) Security group for accessing
####3) Redis cluster (cluster mode disabled)





