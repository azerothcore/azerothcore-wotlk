
-- Scourge Gryphons
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29501) AND (`guid` IN (128509,128510));
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29488) AND (`guid` IN (128500,128501));

-- Lady Alistra
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28471) AND (`guid` IN (128505));

-- Lord Thorval
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28472) AND (`guid` IN (128506));

-- Amal'thazad
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28474) AND (`guid` IN (128507));

-- Master Siegesmith Corvus
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28500) AND (`guid` IN (128577));

-- Enslaved Laborer
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28505) AND (`guid` IN (128579));

-- Mindless Laborer
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 28506) AND (`guid` IN (128580));

-- Alchemist Karloff
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29203) AND (`guid` IN (128456));

-- Gangrenus
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29207) AND (`guid` IN (128458));

-- Fester
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29208) AND (`guid` IN (128459));

-- Corpulus
UPDATE `creature` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 29205) AND (`guid` IN (128457));

-- Skeletal Gryphon Roost
UPDATE `gameobject` SET `phaseMask` = `phaseMask` |128 WHERE (`id` = 191554) AND (`guid` IN (66431, 66432));
