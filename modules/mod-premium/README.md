# Premium Account

- Latest Premium Account build status with azerothcore

This is a module for [AzerothCore](http://www.azerothcore.org) that adds Premium account features to players.

Current features:

This module allows players to:
- Morph
- Mobile Bank
- Mobile Auction
- Demoph
- Mount (40%)
- Summon Vendor

Upcoming features:
- ** To apply Checks if creatures are already spawned

## Requirements

Premium module currently requires: players to import the sql into character datavase

AzerothCore v1.0.1+

## How to install

###1) Simply place the module under the `modules` folder of your AzerothCore source folder.

You can do clone it via git under the azerothcore/modules directory:

`cd path/to/azerothcore/modules`

`git clone https://github.com/talamortis/mod-premium.git

or you can manually [download the module] https://github.com/talamortis/mod-premium.git here unzip the premium.rar and place it under the `azerothcore/modules` directory.

###2) Re-run cmake and launch a clean build of AzerothCore

###3) import the sql into the character database

###4) Assign the script to a item such as hearthstone(6948) script name is "premium_account"

**That's it.**

### (Optional) Edit module configuration

If you need to change the module configuration, go to your server configuration folder (e.g. **etc**), copy `premium.conf.dist` to `premium.conf` and edit it as you prefer.






