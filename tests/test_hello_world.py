#!/usr/bin/python3.6

from hello_world import hello_world
import unittest
from pprint import pprint

class TestHelloWorld(unittest.TestCase):

    def setUp(self):
        self.app = hello_world.app.test_client()
        self.app.testing = True

    def test_status_code(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)

    def test_message(self):
        response = self.app.get('/')
        message = hello_world.wrap_html('Hello world!')
        # print("Response data:\n{}".format(response.data.decode("utf-8")))
        # print(f"Message:\n{message}")
        self.assertEqual(response.data.decode("utf-8"), message) # decoding byte string into string

if __name__ == '__main__':
    unittest.main()