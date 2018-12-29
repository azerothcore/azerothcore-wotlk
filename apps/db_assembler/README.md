## Description

This script allows you to assemble all sql files into one so you can easily import it to your databases (or use the main script to import directly). By default, it creates the merged files in `/env/dist`.

## How to use:

First of all, if you need some custom configuration, you have to copy and rename `/conf/config.sh.dist` to `/conf/config.sh` and configure it. The file is here: https://github.com/azerothcore/azerothcore-wotlk/tree/master/conf

_Read it because there are several options to configure._

`db_assembler.sh` script contains an interactive menu to assemble and import sql files.
Just run it to display the options.


Note: You can even use actions directly by command lines specifying the option.
Ex:

    ./db_assembler.sh 1  

It will merge all sql files without an interactive menu.


