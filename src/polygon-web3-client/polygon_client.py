import logging
import os
import yaml
import json
from web3 import Web3
from web3.middleware import geth_poa_middleware

class PolygonClient:
    """
    Polygon client class
    Loads config from yaml files
    Execute requests to polygon RPC
    """
    def __init__(self):
        """
        Class constructor
        Inputs:
            env String
        """
        self.environment = os.environ.get('ENV')

    def load_yaml_config(self):
        """
        Load configs from yaml files
        """
        try:
            if self.environment is None:
                raise TypeError
            config_file = os.path.join(
                "config",
                self.environment,
                'config.yaml'
                )
            logging.info(
                'Loading config from file: %s', 
                config_file
                )
            with open(config_file) as file:
                self.config = yaml.safe_load(file)
        except TypeError as err:
                logging.critical(
                    'TypeError %s', 
                    err
                    )
        except FileNotFoundError as err:
                logging.critical(
                    '%s Please, validate your ENV environment variable', 
                    err,
                    )
                
    def web3_client(self):
        """
        Execute operations based in the yaml config provided
        """
        for operation in self.config:
            try:
                logging.info(
                    'Method found in config file: %s', 
                    operation['payload']['method']
                )
                web3 = Web3(Web3.HTTPProvider(operation['url']))
                web3.middleware_onion.inject(geth_poa_middleware, layer=0)
                name = operation['name']
                method = operation['method']
                payload = operation['payload']
                if payload['method'] == 'eth_blockNumber':
                    self.response = web3.eth.get_block_number()
                elif payload['method'] == 'eth_getBlockByNumber':
                    self.response = web3.eth.get_block(*payload['params'])
                else:
                    raise AttributeError
                if self.response:
                    logging.info(
                        'Method: %s Response:%s', 
                        payload['method'],
                        self.response
                        )
            except ConnectionAbortedError as err:
                logging.critical(
                    'Failure on operation %s execution', 
                    name
                    )
                exit(1)
            except AttributeError as err:
                logging.critical(
                    'Atttribute error %s', 
                    err
                    )
                exit(1)

if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    client_instance = PolygonClient()
    client_instance.load_yaml_config()
    client_instance.web3_client()
