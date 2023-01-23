# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## Build Status

3.3.5
:------------:
[![Build status](https://ci.appveyor.com/api/projects/status/9cd8gd9io83l3v14/branch/npcbots_3.3.5?svg=true)](https://ci.appveyor.com/project/trickerer/azerothcore-npcbots/branch/npcbots_3.3.5)

## Introduction

AzerothCore (AC) is an open-source game-server application for World of Warcraft, currently supporting the 3.3.5a game version.

It is written in C++ and is based on MaNGOS, TrinityCore and SunwellCore.

[NPCBots](https://github.com/trickerer/Trinity-Bots) is AzerothCore mod.


## Why AzerothCore?

1. Stability
1. The authenticity of the content
1. [Modularity](https://en.wikipedia.org/wiki/Modular_programming)
1. A lot of modules to choose from
1. Better configuration files system
1. Compatibility with other emulators
1. Friendly and helpful community

### Stability

As players and administrators ourselves, we take great care into the stability of our core. Other projects focus on the development side of things and tend to forget that users want stability above everything else.

Hence why nobody is allowed to push commits directly to the core. All changes are reviewed and tested before they get to the `master` branch which means we need as many testers as possible to avoid stalling issues.

### Authenticity

Fixing and implementing missing blizzlike content is one of our priorities, and we can boast to offer the most content-complete open-source emulator.
<!-- Not sure for this below -->
<!-- We were the first open-source emulator to have almost every dungeon and raid working. -->

### Modules

Modules are essential to AzerothCore's success. Modules allow users to plug them in and out easily, and do not require to modify the core files. It also means users can keep pulling the git changes from the main repository and only develop their modules.

We have a lot of modules already made, some of them are very important and will ease your work:

* [Transmogrification](https://github.com/azerothcore/mod-transmog)
* [Eluna (lua engine) support](https://github.com/azerothcore/mod-eluna/ "Creator of Eluna is part of our core team")
* Full list available in the AzerothCore catalogue (link at the end)

### Configuration files

Our configuration file system allows the user to use a tiny configuration file for better readability and maintenance.

### Compatibility with other emulators

Not very far from its ancestor TrinityCore, most scripts can be adapted quite easily. For MaNGOS compatibility, it might require more knowledge but it shares a common base.


## Installation

Installation instructions are available [here](http://www.azerothcore.org/wiki/Installation).

NPCBots installation guide is available in the [NPCBots Readme](https://github.com/trickerer/Trinity-Bots#npcbot-mod-installation).


## Support

AzerothCore self-made wiki probably has a lot of answers for you.

For help requests, it is recommended to ask your question on [StackOverflow](https://stackoverflow.com/questions/tagged/azerothcore) and link it in [our chat](https://discordapp.com/channels/217589275766685707/284406375495368704).


## Reporting issues

NPCBots issues can be reported via the [Github issue tracker](https://github.com/trickerer/Trinity-Bots/issues/).

Please take the time to review existing issues before submitting your own to
prevent duplicates.


## Submitting fixes

C++ fixes are submitted as [pull requests](https://github.com/trickerer/Azerothcore-wotlk-with-NPCBots/pulls).


## Authors & Contributors

This project exists thanks to:

- **The [AzerothCore developers and contributors](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)**
- The [SunwellCore developers xinef and pussywizard](http://www.azerothcore.org/pages/sunwell.pl/)
- All the [TrinityCore developers and contributors](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/AUTHORS)
- All the [MaNGOS, ScriptDev2 and UDB developers and contributors](https://github.com/cmangos/mangos-wotlk/blob/master/AUTHORS.md)


## Important Links

- [NPCBots Readme](https://github.com/trickerer/Trinity-Bots/)

- [Doxygen Documentation](https://www.azerothcore.org/pages/doxygen/index.html)

- [Code of Conduct](https://github.com/azerothcore/azerothcore-wotlk/blob/master/.github/CODE_OF_CONDUCT.md)
- [Website](http://www.azerothcore.org/)
- [AzerothCore catalogue](http://www.azerothcore.org/catalogue.html  "Modules, tools, and other stuff for AzerothCore") (modules, tools, etc...)
- [Module template / Module skeleton](https://github.com/azerothcore/skeleton-module/)
- [Our community hub (Discord)](https://discord.gg/gkt4y2x)
- [Our wiki](http://www.azerothcore.org/wiki "Easy to use and developed by AzerothCore founder")
- [Our Forum](https://github.com/azerothcore/azerothcore-wotlk/discussions/)
- [Our Facebook page](https://www.facebook.com/AzerothCore/)
- [Our LinkedIn page](https://www.linkedin.com/company/azerothcore/)

## License

- The new AzerothCore source components are released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3)
- The old sources based on MaNGOS/TrinityCore are released under the [GNU GPL v2](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2)
