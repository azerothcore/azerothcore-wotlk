## How to compile:

first of all, if you need some custom configuration you have to copy and rename
/conf/config.sh.dist in /conf/config.sh and configure it

* for a "clean" compilation you must run all scripts in their order:

        ./1-clean.sh
        ./2-configure.sh
        ./3-build.sh

* if you add/rename/delete some sources and you need to compile it you have to run:

        ./2-configure.sh
        ./3-build.sh

* if you have modified code only, you just need to run

        ./3-build.sh


## Note:

For an optimal development process and **really faster** compilation time, is suggested to use clang instead of gcc
