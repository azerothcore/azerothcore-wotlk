#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup
import os

# Allow setup.py to be run from any path
os.chdir(os.path.normpath(os.path.join(os.path.abspath(__file__), os.pardir)))

setup(
    name='JSONPath.sh',
    scripts=[
        'JSONPath.sh',
    ],
    version='0.0.14',
    description="JSONPath implementation written in Bash",
    long_description="",
    author='Mark Clarkson',
    author_email='mark.clarkson@smorg.co.uk',
    url='https://github.com/mclarkson/JSONPath.sh',
    classifiers=[
        "Programming Language :: Unix Shell",
        "License :: OSI Approved :: MIT License",
        "License :: OSI Approved :: Apache Software License",
        "Intended Audience :: System Administrators",
        "Intended Audience :: Developers",
        "Operating System :: POSIX :: Linux",
        "Topic :: Utilities",
        "Topic :: Software Development :: Libraries",
    ],
)
