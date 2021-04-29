"""Example File Processor"""
import base64
import uuid


def process_file_stub(data: str, **kwargs):
    """A do-nothing-method to use as an example for the Python process config"""
    print(f'External File Processor received the data file {data} and the named arguments {kwargs}. Doing nothing.')
