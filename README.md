# ![BlackroseWoW](.github/assets/blackrose-icon.png) BlackroseWoW

BlackroseWoW is a custom AzerothCore-based Wrath of the Lich King server
distribution focused on controlled gameplay customization, stable operations,
and easy local development.

## Highlights

- Blackrose-specific gameplay tuning and server-side rule controls
- Startup and service scripts for streamlined server lifecycle management
- Continuous compatibility with AzerothCore upstream improvements

## Blackrose Recent Release Notes

### Added

- New config option `Death.AllowCorpseReclaim` to allow or deny corpse reclaim
  requests server-side (default: enabled).

### Changed

- `WorldSession::HandleReclaimCorpseOpcode` now respects
  `Death.AllowCorpseReclaim` and exits early when reclaiming is disabled.
- `worldserver.conf.dist` now documents the new corpse reclaim behavior and
  clarifies client UI limitations when reclaim is blocked server-side.
- Startup and utility scripts now include executable permissions for
  consistency in Linux deployments.

### How to upgrade

- Pull latest changes and ensure script files keep executable mode:
  - `acore.sh`
  - `apps/startup-scripts/src/run-engine`
  - `apps/startup-scripts/src/service-manager.sh`
  - `apps/startup-scripts/src/simple-restarter`
  - `apps/startup-scripts/src/starter`
  - `deps/jsonpath/JSONPath.sh`
- In your `worldserver.conf`, add (or keep) this setting:

```ini
Death.AllowCorpseReclaim = 1
```

Set it to `0` to disable corpse resurrection at player corpses.

## AzerothCore

BlackroseWoW is built on top of
[AzerothCore](https://github.com/azerothcore/azerothcore-wotlk), an open-source
MMORPG framework for WoW 3.3.5a. AzerothCore provides the core architecture,
game systems, and community-maintained content fixes used by this project.

Useful AzerothCore resources:

- [AzerothCore Website](https://www.azerothcore.org/)
- [AzerothCore Wiki](https://www.azerothcore.org/wiki)
- [AzerothCore Modules Catalogue](https://www.azerothcore.org/catalogue.html#/)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)

## Credits

- BlackroseWoW customization and maintenance by the Blackrose team.
- Core framework and major upstream content support by the AzerothCore
  community and contributors.
- Historical upstream lineage includes MaNGOS, TrinityCore, and SunwellCore.

## License

This project follows the upstream AzerothCore license:
[GNU GPL v2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).
