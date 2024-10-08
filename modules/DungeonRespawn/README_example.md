# MY_NEW_MODULE

## Description

This module allows to do this and this.


## How to use ingame

Do this and that.

![my_new_module screenshot](/screenshots/my_module.png?raw=true "my_new_module screenshot")

<!-- Video example - We can't embed videos on github, only on github.io pages. If you can, make an animated gif of your video instead (but it's not required) -->
[![Youtube Link](https://i.imgur.com/Jhrdgv6.png)](https://www.youtube.com/watch?v=T6UEX47mPeE)


## Requirements

My_new_module requires:

- AzerothCore v4.0.0+


## Installation

```
1) Simply `git clone` the module under the `modules` directory of your AzerothCore source or copy paste it manually.
2) Import the SQL manually to the right Database (auth, world or characters) or with the `db_assembler.sh` (if `include.sh` provided).
3) Re-run cmake and launch a clean build of AzerothCore.
```

## Edit the module's configuration (optional)

If you need to change the module configuration, go to your server configuration directory (where your `worldserver` or `worldserver.exe` is), copy `my_module.conf.dist` to `my_module.conf` and edit that new file.


## Credits

* [Me](https://github.com/YOUR_GITHUB_NAME) (author of the module): Check out my soundcloud - Join my discord
* AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
