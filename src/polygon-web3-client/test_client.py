import os
from  polygon_client import PolygonClient
import pytest
import unittest
from unittest.mock import patch


class TestPolygonClient(unittest.TestCase):

    @patch.dict(os.environ, {'ENV': 'testnet'})
    def test_load_yaml_config(self):
        self.client_instance = PolygonClient()
        self.client_instance.load_yaml_config()
        self.assertTrue(self.client_instance.config)
    
    @patch.dict(os.environ, {'ENV': 'testnet'})
    def test_polygon_call(self):
        self.client_instance = PolygonClient()
        self.client_instance.load_yaml_config()
        self.client_instance.web3_client()
        self.assertIsNotNone(self.client_instance.response)
    
    @patch.dict(os.environ, {'ENV': 'testnet'})
    def test_polygon_call_no_configs(self):
        with self.assertRaises(AttributeError):
            self.client_instance = PolygonClient()
            self.client_instance.web3_client()
        

if __name__ == '__main__':
    unittest.main()
