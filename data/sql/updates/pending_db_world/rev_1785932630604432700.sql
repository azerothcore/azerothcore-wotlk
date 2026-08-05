--
-- Hodir loot chests: spawn them in DB instead of summoning them from the boss.
--
-- They were summoned by the Hodir creature itself, which made him their owner,
-- so Unit::RemoveAllGameObjects() deleted them when he despawned after the
-- post-defeat teleport RP (~15 seconds after the kill).
--
-- Positions are the ones previously hardcoded in instance_ulduar.cpp:
--   normalChestPosition = { 1967.152588f, -204.188461f, 432.686951f, 5.50957f  }
--   hardChestPosition   = { 2035.94600f,  -202.084885f, 432.686859f, 3.164077f }
--
-- spawnMask: 1 = 10-man normal, 2 = 25-man normal (Ulduar has no heroic difficulty).
-- spawntimesecs 604800 (7 days) keeps a looted or shattered chest from coming back
-- within the raid lockout.
--

SET @GO_CHEST_NORMAL      := 194307; -- GO_HODIR_CHEST_NORMAL      (Cache of Winter, 10m)
SET @GO_CHEST_HARD        := 194200; -- GO_HODIR_CHEST_HARD        (Rare Cache of Winter, 10m)
SET @GO_CHEST_NORMAL_HERO := 194308; -- GO_HODIR_CHEST_NORMAL_HERO (Cache of Winter, 25m)
SET @GO_CHEST_HARD_HERO   := 194201; -- GO_HODIR_CHEST_HARD_HERO   (Rare Cache of Winter, 25m)

-- Free guid block. Verify with: SELECT MAX(`guid`) + 1 FROM `gameobject`;
SET @OGUID := 5714442;

-- Deleting by id (not by guid range) so a wrong @OGUID can never wipe unrelated spawns.
DELETE FROM `gameobject` WHERE `id` IN (@GO_CHEST_NORMAL, @GO_CHEST_HARD, @GO_CHEST_NORMAL_HERO, @GO_CHEST_HARD_HERO);
INSERT INTO `gameobject`
(`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
 `position_x`, `position_y`, `position_z`, `orientation`,
 `rotation0`, `rotation1`, `rotation2`, `rotation3`,
 `spawntimesecs`, `animprogress`, `state`) VALUES
(@OGUID+0, @GO_CHEST_NORMAL,      603, 0, 0, 1, 1, 1967.152588, -204.188461, 432.686951, 5.50957,  0, 0, 0.377233, -0.926118, 604800, 0, 1),
(@OGUID+1, @GO_CHEST_HARD,        603, 0, 0, 1, 1, 2035.946000, -202.084885, 432.686859, 3.164077, 0, 0, 0.999937, -0.011243, 604800, 0, 1),
(@OGUID+2, @GO_CHEST_NORMAL_HERO, 603, 0, 0, 2, 1, 1967.152588, -204.188461, 432.686951, 5.50957,  0, 0, 0.377233, -0.926118, 604800, 0, 1),
(@OGUID+3, @GO_CHEST_HARD_HERO,   603, 0, 0, 2, 1, 2035.946000, -202.084885, 432.686859, 3.164077, 0, 0, 0.999937, -0.011243, 604800, 0, 1);

-- The chests are present from the start of the encounter but must not be lootable
-- until Hodir is defeated. Flag 16 = GO_FLAG_NOT_SELECTABLE; the instance script
-- removes it in setChestsLootable() once the encounter is DONE.
-- 194200 already carries this flag; the other three are brought in line with it.
UPDATE `gameobject_template_addon` SET `flags` = `flags` | 16
WHERE `entry` IN (@GO_CHEST_NORMAL, @GO_CHEST_HARD, @GO_CHEST_NORMAL_HERO, @GO_CHEST_HARD_HERO);
