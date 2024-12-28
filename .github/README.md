# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)
[![CodeFactor](https://www.codefactor.io/repository/github/azerothcore/azerothcore-wotlk/badge)](https://www.codefactor.io/repository/github/azerothcore/azerothcore-wotlk)
[![StackOverflow](http://img.shields.io/badge/stackoverflow-azerothcore-blue.svg?logo=stackoverflow)](https://stackoverflow.com/questions/tagged/azerothcore?sort=newest "Ask / browse questions here")
[![Discord](https://img.shields.io/discord/217589275766685707?logo=discord&logoColor=white)](https://discord.gg/gkt4y2x "Our community hub on Discord")

## Build Status

[![nopch-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core-build-nopch.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core-build-nopch.yml?query=branch%3Amaster)
[![pch-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core-build-pch.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core-build-pch.yml?query=branch%3Amaster)
[![core-modules-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core_modules_build.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/core_modules_build.yml?query=branch%3Amaster)
[![windows-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/windows_build.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/windows_build.yml?query=branch%3Amaster)
[![macos-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/macos_build.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/macos_build.yml?query=branch%3Amaster)
[![docker-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/docker_build.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/docker_build.yml?query=branch%3Amaster)
[![tools-build](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/tools_build.yml/badge.svg?branch=master)](https://github.com/azerothcore/azerothcore-wotlk/actions/workflows/tools_build.yml?query=branch%3Amaster)

## Introduction

AzerothCore is a community-driven, open-source game server framework designed to host massive multiplayer online role-playing games (MMORPGs). This project is based on World of Warcraft (WoW) and aims to recreate the gameplay experience of the Wrath of the Lich King (WotLK) expansion, specifically patch 3.3.5a.

Originally derived from MaNGOS, TrinityCore, and SunwellCore, AzerothCore has developed extensively to improve stability, in-game mechanics, and modularity. The project has become a reliable foundation for creating private servers replicating the official WoW experience while fostering a collaborative environment for developers and enthusiasts.

## Philosophy

Our objective is to deliver a high-quality, fully functional game server emulator that provides a seamless in-game experience.

Key objectives include:

- **Stability**: We ensure all pull requests pass the CI checks before being pushed into the master branch.
- **Blizzlike content**: We strive to replicate the authentic WoW experience with a high standard for bug fixes, gameplay mechanics, and content accuracy.
- **Customization**: AzerothCore’s modular design makes it easy to customize gameplay experiences using different community-made modules.
- **Community-driven**: AzerothCore is supported by an active community of developers, contributors, and players who collaborate to enhance the project and provide support through different platforms.

### Modular Design

AzerothCore is built with a highly modular structure, allowing developers to extend and customize the game to meet specific needs or create unique new gameplay experiences. Numerous modules, many created by the community, are available and can be found in the [Module Catalogue](https://www.azerothcore.org/catalogue.html#/).

## Installation

For detailed installation instructions please see our [installation guide](http://www.azerothcore.org/wiki/installation).

## Contributing

AzerothCore is an excellent resource for developers seeking to learn about MMORPG server architecture, game server emulation, C++, and SQL. If you're interested in contributing to the project, we encourage you to explore our [contribution guide](https://www.azerothcore.org/wiki/contribute).

We also encourage you to review the [Contributor Covenant Code of Conduct](https://github.com/azerothcore/azerothcore-wotlk/blob/master/.github/CODE_OF_CONDUCT.md) before getting involved.

Join our [Discord community](https://discord.gg/gkt4y2x) for real-time discussions and support.

Show your support by clicking the "⭐ Star" button to help us gain more visibility on GitHub!

## Documentation

- [Doxygen documentation](https://www.azerothcore.org/pages/doxygen/index.html) - Up-to-date API and source code documentation.
- [Official Wiki](http://www.azerothcore.org/wiki) - In-depth resources, guides, and database documentation developed by the AzerothCore contributors.

## Useful Links

- [Official Website](http://www.azerothcore.org/) - Learn more about AzerothCore and its features.
- [AzerothCore Catalogue](http://www.azerothcore.org/catalogue.html) - Modules, tools, and additional resources for AzerothCore.
- [Discord Community](https://discord.gg/gkt4y2x) - Join us for support and discussion.
- [GitHub Discussions](https://github.com/azerothcore/azerothcore-wotlk/discussions/) – Ask questions and engage with the community.
- [LinkedIn](https://www.linkedin.com/company/azerothcore/)

## Authors & Contributors

AzerothCore was initially created in 2016 based on SunwellCore. Unfortunately, SunwellCore did not have a Git history, so earlier contributors are not listed in the repository. However, you can find a list of authors and contributors in the [AUTHORS](https://github.com/azerothcore/azerothcore-wotlk/blob/master/AUTHORS) file.

## License

- **AzerothCore** is released under the [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.en.html)
- The original sources from MaNGOS/TrinityCore are released under the [GNU GPL v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

Please note, **AzerothCore is not affiliated with Blizzard Entertainment** and is not endorsed by World of Warcraft. It is intended solely for personal use, testing, and educational purposes. Running illegal public servers is not supported by the project.


## Special thanks

We would like to thank [JetBrains](https://www.jetbrains.com/?from=AzerothCore) for providing free [open-source licenses](https://www.jetbrains.com/community/opensource/) to the AzerothCore developers.

[![JetBrains](https://user-images.githubusercontent.com/75517/51205146-7f225c80-1905-11e9-82e0-835627be170d.png)](https://www.jetbrains.com/?from=AzerothCore)
