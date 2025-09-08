<p align="center">
  <img src="https://raw.githubusercontent.com/n4ru/warsongcore-azeroth/d96441e757a0cd8cb05fc5486e41d8edb3e2f3b0/wsc.png">
</p>

## Introduction

WarsongCore is a modification of AzerothCore, with the expressed goal of optimizing for a pure battlegrounds only experience, and in particular replicating the experience of Blizzlike Warsong Gulch premades across twink brackets (and more).

## Philosophy

The main goal is to create a Warsong focused core, optimizing out the unecessary bits and enabling a streamlined web-server lobby -> in-game experience. The goal is to drop players into a battlegrounds lobby of their choice (Warsong Gulch to start) and allow easy to run premades.

The *eventual* goal would be to enable db-less (or SQLite/memcache) p2p lightweight server hosting and external clients to manage the realmlist connection before jumping into the BG lobby. This would let a party host a premade at any time without any centralized server, provided one of the players has adequete resources to host a lightweight server. This will likely be further down the line, once the guts are pulled and optimizations are made.

## Installation

## Contributing

## License

- The new WarsongCore and AzerothCore source components are released under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html)
- The old sources based on MaNGOS/TrinityCore are released under the [GNU GPL v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

It's important to note that WarsongCore/AzerothCore is not an official Blizzard Entertainment product, and it is not affiliated with or endorsed by World of Warcraft or Blizzard Entertainment. AzerothCore does not in any case sponsor nor support illegal public servers. If you use this project to run an illegal public server and not for testing and learning it is your own personal choice.
