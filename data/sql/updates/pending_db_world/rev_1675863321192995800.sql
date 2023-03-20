-- Cherry-pick: https://github.com/TrinityCore/TrinityCore/commit/3d4bebd8d9210fbb84f8fc75742e248071192b09
-- (Co-authored-by: Treeston <treeston@users.noreply.github.com>)
DELETE FROM `spawn_group` WHERE `spawnType`=0 AND `spawnId` IN (22831,36626,23708,39059);
INSERT INTO `spawn_group` (`groupId`,`spawnType`,`spawnId`) VALUES
(3,0,22831), (3,0,36626), (3,0,23708), (3,0,39059);
