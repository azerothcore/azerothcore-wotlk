# Transmog Module

- Latest Transmog build status with azerothcore: [![Build Status](https://travis-ci.org/azerothcore/mod-transmog.svg?branch=master)](https://travis-ci.org/azerothcore/mod-transmog)

This is a module for [AzerothCore](http://www.azerothcore.org) that adds transmog feature, it's based on [Rochet2 Transmog Script](http://rochet2.github.io/Transmogrification.html) 

## Requirements

Transmogrification module currently requires:

AzerothCore v1.0.2+

## How to install

###1) Simply place the module under the `modules` folder of your AzerothCore source folder.

You can do clone it via git under the azerothcore/modules directory:

`cd path/to/azerothcore/modules`

`git clone https://github.com/azerothcore/mod-transmog.git`

or you can manually [download the module](https://github.com/azerothcore/mod-transmog/archive/master.zip), unzip the Transmog folder and place it under the `azerothcore/modules` directory.

###2) Re-run cmake and launch a clean build of AzerothCore

**That's it.**

### (Optional) Edit module configuration

If you need to change the module configuration, go to your server configuration folder (e.g. **etc**), copy `transmog.conf.dist` to `transmog.conf` and edit it as you prefer.


## License

This module is released under the [GNU AGPL license](https://github.com/azerothcore/mod-transmog/blob/master/LICENSE).





