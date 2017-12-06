# Anticheat Module

This is a port of the PassiveAnticheat Script from lordpsyan's repo to [AzerothCore](http://www.azerothcore.org)

## How to install

###1) Simply place the module under the `modules` folder of your AzerothCore source folder.

You can do clone it via git under the azerothcore/modules directory:

`cd path/to/azerothcore/modules`

`git clone https://github.com/azerothcore/mod-anticheat.git`

or you can manually [download the module](https://github.com/azerothcore/mod-anticheat/archive/master.zip), unzip and place it under the `azerothcore/modules` directory.

###2) Re-run cmake and launch a clean build of AzerothCore

###3) Execute the included "conf/SQL/charactersdb_anticheat.sql" file on your characters database. This creates the necessary tables for this module.

**That's it.**

### (Optional) Edit module configuration

If you need to change the module configuration, go to your server configuration folder (e.g. **etc**), copy `mod_anticheat.conf.dist` to `Anticheat.conf` and edit it as you prefer.
