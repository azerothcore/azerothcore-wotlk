## How to compile:

first of all, if you need some custom configuration you have to copy
/conf/dist/config.sh in /conf/config.sh and configure it

* for a "clean" compilation you must run all scripts in their order:

        ./1-clean.sh
        ./2-configure.sh
        ./3-build.sh

* if you add/rename/delete some sources and you need to compile it you have to run:

        ./2-configure.sh
        ./3-build.sh

* if you have modified code only, you just need to run

        ./3-build.sh


## compiler.sh 

compiler.sh script contains an interactive menu to clean/compile/build. You can also run actions directly by command lines specifying the option.
Ex:
  ./compiler.sh 3  

It will start the build process (it's equivalent to ./3-build.sh)

## Note:

For an optimal development process and **really faster** compilation time, is suggested to use clang instead of gcc
