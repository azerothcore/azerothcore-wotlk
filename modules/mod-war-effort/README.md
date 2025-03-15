# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## mod-war-effort

[English](README.md) | [Español](README_ES.md)

- Latest build status with azerothcore:

[![Build Status](https://github.com/azerothcore/mod-war-effort/workflows/core-build/badge.svg)](https://github.com/azerothcore/mod-war-effort)

## Description

- This module brings back the war effort of the two factions for the opening of the gates of Ahn'Qiraj

## How to install

1. Simply place the module under the `modules` directory of your AzerothCore source

You can do clone it via git under the azerothcore/modules directory:

```sh
cd path/to/azerothcore/modules
git clone https://github.com/azerothcore/mod-war-effort.git
```

or you can manually [download the module](https://github.com/azerothcore/mod-war-effort/archive/master.zip), unzip the Transmog folder and place it under the `azerothcore/modules` directory.

2. Import the SQL to the right Database (world & characters)

Import the SQL manually to the right Database (world & characters) or with the `db_assembler.sh` (if `include.sh` provided).

3. Re-run CMake and rebuild the AzerothCore source

4. Edit module configuration

Go to your server configuration folder (where your worldserver or worldserver.exe is), copy `mod_aq_war_effort.conf.dist` to `mod_aq_war_effort.conf` and edit that new file.

```
#    ModWarEffort.Enable
#        Description: Enables the module
#        Default:     0 - Disabled
#                     1 - Enabled
```

## License

This module is released under the [MIT license](https://github.com/azerothcore/mod-war-effort/blob/master/LICENSE).
