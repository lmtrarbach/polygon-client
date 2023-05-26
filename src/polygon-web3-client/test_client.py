import os
import unittest
from unittest.mock import patch
from polygon_client import PolygonClient


class TestPolygonClient(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        os.environ['ENV'] = 'testnet'

    def setUp(self):
        self.client_instance = PolygonClient()

    def test_load_yaml_config(self):
        self.client_instance.load_yaml_config()
        self.assertIsNotNone(self.client_instance.config)

    def test_web3_client(self):
        self.client_instance.load_yaml_config()
        self.client_instance.web3_client()
        self.assertIsNotNone(self.client_instance.response)

    def test_web3_client_no_configs(self):
        with self.assertRaises(AttributeError):
            self.client_instance.web3_client()

    @classmethod
    def tearDownClass(cls):
        del os.environ['ENV']


if __name__ == '__main__':
    unittest.main()
