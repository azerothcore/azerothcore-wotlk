-- --------------------------------------------------------------------------------------------
-- The Eye of Eternity (The Eye of Eternity, map 616)
-- Power Spark (Entry 30084)
-- Correct level from 79 to 80
-- -------------------------------------------
-- Power Spark is the only creature in The Eye of Eternity left below level 80. Its own 25-man
-- entry (32187) is level 80, as are the other adds Malygos brings along: Nexus Lord (30245),
-- Scion of Eternity (30249) and Hover Disk (30248).
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80 WHERE (`entry` = 30084);
