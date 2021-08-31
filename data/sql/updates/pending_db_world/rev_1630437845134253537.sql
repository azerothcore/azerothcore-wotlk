INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630437845134253537');

-- Set 5 rep until honored for Desert Rumbler, Dust Stormer, Greater Obsidian Elemental
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 4, `RewOnKillRepValue1` = 5 WHERE `creature_id` IN (11746, 11744, 7032);

-- Set 15 rep until revered for Lord Incendius
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 15 WHERE (`creature_id` = 9017);

-- Set 25 rep until revered for Huricanian
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 25 WHERE (`creature_id` = 14478);

-- Set 50 rep until revered for Pyroguard Emberseer
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 50 WHERE (`creature_id` = 9816);

-- Set 20 rep until revered for Molten Giant, Ancient Core Hound, Lava Surger, Firelord
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 20 WHERE `creature_id` IN (11658, 11673, 12101, 11668);

-- Set 40 rep until revered for Molten Destroyer, Lava Reaver, Lava Elemental, Flameguard, Firewalker
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5, `RewOnKillRepValue1` = 40 WHERE `creature_id` IN (11659, 12100, 12076, 11667, 11666);
 
-- Set 100 rep until exalted for Lucifron, Magmadar, Gehennas, Garr, Baron Geddon, Shazzrah, Sulfuron Harbinger 
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 6, `RewOnKillRepValue1` = 100 WHERE `creature_id` IN (12118, 11982, 12259, 12057, 12056, 12264, 12098);

-- Set 150 rep until end exalted for Golemagg the incinerator
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 7, `RewOnKillRepValue1` = 150 WHERE (`creature_id` = 11988);

-- Set 200 rep until end exalted for Ragnaros
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 7, `RewOnKillRepValue1` = 200 WHERE (`creature_id` = 11502);
