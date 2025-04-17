# Security Policy

## Supported Versions

We support the following versions of dependencies.

| Icon                 |      Meaning      |
| :------------------- | :---------------: |
| :white_check_mark:   |   **Supported**   |
| :red_circle:         | **NOT** Supported |
| :large_blue_diamond: |  **Recommended**  |

### Versions of AzerothCore:

| AzerothCore Branch           |       Status       |     Recommended      |
| ---------------------------- | :----------------: | :------------------: |
| **master**                   | :white_check_mark: | :large_blue_diamond: |
| Any non-official fork        |    :red_circle:    |                      |
| Any Playerbots fork          |    :red_circle:    |                      |
| Any NPCBots fork             |    :red_circle:    |                      |
| Any AC (non-official) repack |    :red_circle:    |                      |

### Supported Operating Systems

| Linux (Ubuntu) |       Status       |     Recommended      |
| :------------- | :----------------: | :------------------: |
| 24.04          | :white_check_mark: | :large_blue_diamond: |
| 22.04          | :white_check_mark: |                      |
| 20.04 ≤        |    :red_circle:    |                      |

| macOS |       Status       |     Recommended      |
| :---- | :----------------: | :------------------: |
| 14    | :white_check_mark: | :large_blue_diamond: |
| 12 ≤  |    :red_circle:    |                      |

| Windows       |       Status       |     Recommended      |
| :------------ | :----------------: | :------------------: |
| Windows 11    | :white_check_mark: | :large_blue_diamond: |
| Windows 10    | :white_check_mark: |
| Windows 8.1 ≤ |    :red_circle:    |

<br>

### Supported Boost Versions:

| Boost  |       Status       |     Recommended      |
| :----- | :----------------: | :------------------: |
| 1.70 ≥ | :white_check_mark: | :large_blue_diamond: |

### Supported OpenSSL Versions:

| OpenSSL |       Status       |     Recommended      |
| :------ | :----------------: | :------------------: |
| 3.X.X ≥ | :white_check_mark: | :large_blue_diamond: |

### Supported CMake Versions:

| CMake  |       Status       |     Recommended      |
| :----- | :----------------: | :------------------: |
| 3.16 ≥ | :white_check_mark: | :large_blue_diamond: |

### Supported MySQL Versions:

| MySQL |       Status       |     Recommended      |
| :---- | :----------------: | :------------------: |
| 8.4 ≥ | :white_check_mark: | :large_blue_diamond: |
| 8.0   | :white_check_mark: |                      |
| 8.1   |    :red_circle:    |                      |
| 8.0 < |    :red_circle:    |                      |

### Supported CLang Versions:

| CLang |       Status       |     Recommended      |
| :---- | :----------------: | :------------------: |
| 18    | :white_check_mark: | :large_blue_diamond: |
| 15    | :white_check_mark: |                      |
| 14 ≤  |    :red_circle:    |                      |

### Supported GCC Versions:

| GCC  |       Status       |     Recommended      |
| :--- | :----------------: | :------------------: |
| 14   | :white_check_mark: | :large_blue_diamond: |
| 12   | :white_check_mark: |                      |
| 11 ≤ |    :red_circle:    |                      |

> [!NOTE]
> We do **NOT** support any repacks that may or may not have been made based on AzerothCore. This is because they are usually based on older versions and there is no way to know what is in the precompiled binaries. Instead, you should compile your binaries from the AzerothCore source. To get started, read the [Installation Guide](https://www.azerothcore.org/wiki/installation).

> [!CAUTION] 
> [Why you should not use repacks to run your WoW server](https://www.mangosrumors.org/why-you-should-not-use-repacks-to-run-your-wow-server/)

## Reporting a Vulnerability

We class a vulnerability to be any hack or exploit that has an impact on the server performance or that gives unfair advantages in the game (e.g. fly hacking or injection tools).

If a new vulnerability is found you should always create a new [bug report](https://github.com/azerothcore/azerothcore-wotlk/issues/new?assignees=&labels=&projects=&template=bug_report.yml).
