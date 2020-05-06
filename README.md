# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e61f4ea81de14b289fbf83d2b0da0c35)](https://app.codacy.com/app/FrancescoBorzi/azerothcore-wotlk?utm_source=github.com&utm_medium=referral&utm_content=azerothcore/azerothcore-wotlk&utm_campaign=Badge_Grade_Settings)
[![core-build](https://github.com/azerothcore/azerothcore-wotlk/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/azerothcore-wotlk/actions?query=workflow%3Acore-build+branch%3Amaster+event%3Apush)
<a href="https://scan.coverity.com/projects/azerothcore-azerothcore-wotlk">
  <img alt="Coverity Scan Build Status"  src="https://scan.coverity.com/projects/13814/badge.svg"/>
</a>
[![Bountysource](https://www.bountysource.com/badge/tracker?tracker_id=40032087)](https://www.bountysource.com/teams/azerothcore/bounties "Put money on issues or get paid for fixing them")
[![StackOverflow](http://img.shields.io/badge/stackoverflow-azerothcore-blue.svg)](https://stackoverflow.com/questions/tagged/azerothcore?sort=newest "Ask / browse questions here")
[![Discord](https://img.shields.io/discord/217589275766685707.svg)](https://discord.gg/gkt4y2x "Our community hub on Discord")


## INTRODUCTION

AzerothCore (AC) is an open source game-server application for World of Warcraft, currently supporting the 3.3.5a game version.

It is written in C++ and is based on MaNGOS, TrinityCore and SunwellCore.


## WHY AZEROTHCORE?

1. Stability
1. Authenticity of the content
1. [Modularity](https://en.wikipedia.org/wiki/Modular_programming)
1. A lot of modules to choose from
1. Better configuration files system
1. Compatibility with other emulators
1. Friendly and helpful community

#### Stability

As players and administrators ourselves, we take great care into the stability of our core. Other projects focus on the development side of things and tend to forget that users want stability above everything else.

Hence why nobody is allowed to push commits directly to the core. All changes are reviewed and tested before they get to the `master` branch which means we need as many testers as possible to avoid stalling issues.

#### Authenticity

Fixing and implementing missing blizzlike content is one of our priorities, and we can boast to offer the most content-complete open source emulator.
<!-- Not sure for this below -->
<!-- We were the first open source emulator to have almost every dungeon and raid working. -->

#### Modules

Modules are essential to AzerothCore's success. Modules allows users to plug them in and out easily, and do not require to modify the core files. It also means users can keep pulling the git changes from the main repository and only develop their own modules.

We have a lot of modules already made, some of them are very important and will ease your work:

* [Transmogrification](https://github.com/azerothcore/mod-transmog)
* [Eluna (lua engine) support](https://github.com/azerothcore/mod-eluna-lua-engine/ "Creator of Eluna is part of our core team")
* Full list available in the AzerothCore catalogue (link at the end)

#### Configuration files

Our configuration file system allows the user to use a tiny configuration file for better readability and maintenance.

#### Compatibility with other emulators

Not very far from its ancestor TrinityCore, most scripts can be adapted quite easily. For MaNGOS compatibility, it might require more knowledge but it shares a common base.


## PHILOSOPHY

Our main goal is to create a playable game server, offering a fully working game experience.

Here are the main points we focus on:

* Stability
* Ease of use / Practicability
* Playability (ingame content)
* Customization
* Community driven software (check our discord)

We also welcome new users (even non-english speaking users!) and help them learn / improve their skills (C++, SQL, Git, software collaboration, tutoring / wiki etc...).

Unlike other projects which focus more on the developer's side of things, we want users to be able to run their own server with as few troubles as possible. All of our contributors run their own private server (in local or not).

That's why AzerothCore is easier to use, to maintain, to understand, to develop on and to customize to suit your needs, than other emulators.

In short, we focus on the **user experience (UX)**, whether it be the **player's experience**, the **developer's experience** or the **administrator's experience**.


## HOW TO THANK US

Being an open source project, we rely on volunteers to pursue development. Here are ways to help us if you use AzerothCore:

#### Github star

Click on the "star this repository" button to help us gain more visibility on Github!

#### By contributing

Check the **CONTRIBUTING** section below.

#### Financially :moneybag:

You can support the project by financing the resolution of issues [using Bountysource](http://www.azerothcore.org/wiki/Bountysource "Bountysource explained in our wiki").

#### Advertising

By talking about us on different platforms or to people who would like to get involved.


## CONTRIBUTING

AzerothCore is a learning project, and there are lots of different ways to contribute to the project:

* By [testing our fixes](http://www.azerothcore.org/wiki/How-to-test-a-PR) (we can teach you how to correctly use Git to help us but that will also help you out tremendously)
* By developing directly to the core or to the modules
* By [creating new modules](http://www.azerothcore.org/wiki/Create-a-Module)
* By improving our wiki
* By providing direct support to our community (on discord, stackoverflow or specialized forums)
* By making extra content (video tutorial for example)
* By putting bounties on issues


If you want to contribute to the project, you will find a lot of resources that will guide you in our wiki.

Feel free to join us on [our discord chat server][discord] where we taught a lot of new people how to get started and who are now important contributors!

<!-- TO UNCOMMENT LATER -->
<!-- As we put a big emphasis on community, there are also special rewards for contributors such as reputation ranks (displayed in our discord and our website), reputation badges (to display on your project/portfolio), premium software licenses, private modules access, private tools access and a lot of small private repositories access. -->


## INSTALLATION

Installation instructions are available [here](http://www.azerothcore.org/wiki/Installation).

We also have an auto-installation bash script [here](/apps/installer/main.sh) (*Warning: try it/analyze it before running it*).

Dockerization of AzerothCore is fully supported, and we have various community made tutorials (eg: AWS / Digital Ocean installation).


## SUPPORT

Our self-made wiki probably has a lot of answers for you.

For help requests, it is recommended to ask your question on [StackOverflow](https://stackoverflow.com/questions/tagged/azerothcore) and link it in [our chat](https://discordapp.com/channels/217589275766685707/284406375495368704).


## AUTHORS & CONTRIBUTORS

This project exists thanks to:

- **The [AzerothCore developers and contributors](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)**
- The [SunwellCore developers xinef and pussywizard](http://www.azerothcore.org/pages/sunwell.pl/)
- All the [TrinityCore developers and contributors](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/AUTHORS)
- All the [MaNGOS, ScriptDev2 and UDB developers and contributors](https://github.com/cmangos/mangos-wotlk/blob/master/AUTHORS.md)


## IMPORTANT LINKS

- [Website](http://www.azerothcore.org/)
- [AzerothCore catalogue](http://www.azerothcore.org/modules-catalogue/  "Modules, tools, and other things for AzerothCore") (modules, tools etc...)
- [Module template / Module skeleton](https://github.com/azerothcore/skeleton-module/)
- [Our community hub (Discord)](https://discord.gg/gkt4y2x)
- [Our wiki](http://www.azerothcore.org/wiki "Easy to use and developed by AzerothCore founder")
- [Our Facebook page](https://www.facebook.com/AzerothCore/)
- [Our LinkedIn page](https://www.linkedin.com/company/azerothcore/)


## SPONSORS

List of organizations that help AzerothCore:

[![JetBrains](https://user-images.githubusercontent.com/75517/51205146-7f225c80-1905-11e9-82e0-835627be170d.png)](https://www.jetbrains.com/?from=AzerothCore)


## LICENSE

- The new AzerothCore source components are released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3)
- The old sources based on MaNGOS/TrinityCore are released under the [GNU GPL v2](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2)
