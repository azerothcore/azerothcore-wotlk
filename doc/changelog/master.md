## 4.0.0-dev.4 | Commit: [fbad1f3d6c27a5d3eea22483913c67a827ab01be
](https://github.com/azerothcore/azerothcore-wotlk/commit/fbad1f3d6c27a5d3eea22483913c67a827ab01be


### Added
- new hook `OnBeforeSendJoinMessageArenaQueue` and `OnBeforeSendExitMessageArenaQueue`

### Changed
- Rename `CanExitJoinMessageArenaQueue` to `OnBeforeSendExitMessageArenaQueue`
- Rename `CanSendJoinMessageArenaQueue` to `OnBeforeSendJoinMessageArenaQueue`

### How to upgrade
- Just rename all hooks from `CanExitJoinMessageArenaQueue` and `CanSendMessageArenaQueue`, to `OnBeforeSendExitMessageArenaQueue`
- Just rename all hooks from `CanSendJoinMessageArenaQueue` and `OnBeforeSendJoinMessageArenaQueue`

## 4.0.0-dev.3 | Commit: [c35dde6fae732269357b78fb796fba21956b83fc
](https://github.com/azerothcore/azerothcore-wotlk/commit/c35dde6fae732269357b78fb796fba21956b83fc


Changelog for commit "[refactor(Collision): Update some methods to UpperCamelCase](https://github.com/azerothcore/azerothcore-wotlk/commit/b84f9b8a4b334632cb37dcebbb2dd4e087f65610)"

### Changes

```diff
- getPosition
- getBounds
- getBounds2
- getInstanceMapTree
- getModelInstances
- getPosInfo
- getMeshData
- getGroupModels
- getIntersectionTime
- getObjectHitPos
- getAreaInfo
+ GetPosition
+ GetBounds
+ GetBounds2
+ GetInstanceMapTree
+ GetModelInstances
+ GetPosInfo
+ GetMeshData
+ GetGroupModels
+ GetIntersectionTime
+ GetObjectHitPos
+ GetAreaInfo
```

### How to upgrade

If you are using any of those methods, simply rename it by changing the first letter of the method from lowercase to uppercase.

Example: `getAreaInfo` -> `GetAreaInfo`

## 4.0.0-dev.2 | Commit: [3f70d0b80ff483f142ffbebf8960aeb503913a35](https://github.com/azerothcore/azerothcore-wotlk/commit/3f70d0b80ff483f142ffbebf8960aeb503913a35)


### Added
- Created new changelog system.

### How to upgrade

To create a new changelog please follow the instructions on our [wiki page](https://www.azerothcore.org/wiki/how-to-use-changelog)


