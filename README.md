# Polygon Client

This project contains a Python script for interacting web3, on this case polygon.

## Prerequisites

- Python 3.x installed
- Docker installed 
- AWS CLI installed 
- Terraform 
## Setup

1. Clone the repository:

2. Install depdencies
```
pip install -r requirements.txt
```
Set the environment variable required by the environment:
```
export ENVIRONMENT=testnet
```

## Running the script

To run the script execute:

```
cd src/polygon-web3-client
python polygon_client.py
```
It uses the config.yaml located in  src/polygon-web3-client/config/testnet/config.yaml

The config is defined as this:

```
- name: <operation_name>
  url: <RPC_endpoint_url>
  method: <web3_method>
  payload:
    method: <web3_method>
    params:
      - <param1>
      - <param2>
    # Additional payload properties specific to the RPC method

- name: <operation_name>
  url: <RPC_endpoint_url>
  method: <web3_method>
  payload:
    method: <web3_method>
    params:
      - <param1>
      - <param2>
```


## Running the Tests
The project includes unit tests for the PolygonClient class. To run the tests, use the following command:

```
cd src/polygon-web3-client
python -m pytest test_client.py
```


## Deploying with Terraform


Navigate to the Terraform configuration directory:
```
cd infrastructure/terraform/environments/testnet
```

## Initialize Terraform:
```
terraform init
```
## Deploy the infrastructure:

```
terraform plan --var-file tf.vars
terraform apply --var-file tf.vars
```


