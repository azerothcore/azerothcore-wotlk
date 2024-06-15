# Security Policy

## Supported Versions

We support the following versions of dependencies.

:white_check_mark: = supported

:red_circle: = NOT supported

unspecified = might work but no guarantee

Versions of AzerothCore:

| AzerothCore Branch | Supported          |
| ------------------ | ------------------ |
| master             | :white_check_mark: |

Versions of MySQL:

| MySQL Version | Supported          |
| ------------- | ------------------ |
| 8.1           | :white_check_mark: |
| 8.0           | :white_check_mark: |
| 5.7           | :white_check_mark: |
| 5.6 and lower | :red_circle:       |

Versions of MariaDB:

| MariaDB Version | Supported          |
| --------------- | ------------------ |
| 10.6            | :white_check_mark: |
| 10.5            | :white_check_mark: |
| 10.4 and lower  | :red_circle:       |

Versions of CLang:

| CLang Version | Supported          |
| ------------- | ------------------ |
| 18            | :white_check_mark: |
| 15            | :white_check_mark: |
| 14 and lower  | :red_circle:       |

Versions of GCC:

| GCC Version | Supported          |
| ----------- | ------------------ |
| 14          | :white_check_mark: |
| 12          | :white_check_mark: |
| 11 and lower| :red_circle:       |

Versions of Ubuntu:

| Ubuntu version | Supported          |
| -------------- | ------------------ |
| 24.04          | :white_check_mark: |
| 22.04          | :white_check_mark: |
| 20.04 and lower| :red_circle:       |

Versions of macOS:

| macOS Version  | Supported          |
| -------------- | ------------------ |
| 12             | :white_check_mark: |
| 11 and lower   | :red_circle:       |

**Note**: We do NOT support any repacks that may or may not have been made based on AzerothCore. This is because they are usually based on older versions and there is no way to know what is in the precompiled binaries. Instead, you should compile your binaries from the AzerothCore source. To get started, read the [Installation Guide](https://www.azerothcore.org/wiki/installation).

## Reporting a Vulnerability

We class a vulnerability to be any hack or exploit that has an impact on the server performance or that gives unfair advantages in the game (e.g. fly hacking or injection tools).

If a new vulnerability is found you should always create a new [bug report](https://github.com/azerothcore/azerothcore-wotlk/issues/new?assignees=&labels=&projects=&template=bug_report.yml).
