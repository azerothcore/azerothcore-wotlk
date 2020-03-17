# SKELETON - Module template

[English](README.md) | [Español](README_ES.md)


## How to create your own module

1. Use the script `create_module.sh` located in [`modules/`](https://github.com/azerothcore/azerothcore-wotlk/tree/master/modules) to start quickly with all the files you need and your git repo configured correctly (heavily recommended).
1. You can then use these scripts to start your project: https://github.com/azerothcore/azerothcore-boilerplates
1. Do not hesitate to compare with some of our newer/bigger/famous modules.
1. Edit the `README.md` and other files (`include.sh` etc...) to fit your module. Note: the README is automatically created from `README_example.md` when you use the script `create_module.sh`.
1. Publish your module to our [catalogue](https://github.com/azerothcore/modules-catalogue).


## How to test your module?

Disable PCH (precompiled headers) and try to compile. To disable PCH, set `-DNOPCH=1` with Cmake (more info [here](http://www.azerothcore.org/wiki/CMake-options)).

If you forgot some headers, it is time to add them!

