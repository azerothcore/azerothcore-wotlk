# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore
## DuelReset

![DuelReset](https://raw.githubusercontent.com/azerothcore/mod-duel-reset/master/icon.png)

- Latest DuelReset build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-duel-reset/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-duel-reset)

This is a module for [AzerothCore](http://www.azerothcore.org) that adds some duel reset features.

Current features:

- **Health/mana reset**: when duel starts it sets the health/mana of the player to the MAX, when the duel ends it restores the health/mana values that the player had before the duel
- **Cooldown reset**: when duel starts it resets the player cooldowns
- **Cooldown age**: sets the required age of a cooldown to be reset in order to prevent the feature from being abused
- **Reset zones/areas**: specify the zones and areas where the resets actually apply

## Requirements

Duel Reset module currently requires:

AzerothCore v1.0.1+

## How to install

### 1) Simply place the module under the `modules` folder of your AzerothCore source folder.

You can do clone it via git under the azerothcore/modules directory:

`cd path/to/azerothcore/modules`

`git clone https://github.com/azerothcore/mod-duelreset.git`

or you can manually [download the module](https://github.com/azerothcore/mod-duelreset/archive/master.zip), unzip the DuelReset folder and place it under the `azerothcore/modules` directory.

### 2) Re-run cmake and launch a clean build of AzerothCore

**That's it.**

### (Optional) Edit module configuration

If you need to change the module configuration, go to your server configuration folder (e.g. **etc**), copy `duelreset.conf.dist` to `duelreset.conf` and edit it as you prefer.


## License

This module is released under the [GNU AGPL license](https://github.com/azerothcore/mod-duelreset/blob/master/LICENSE).





