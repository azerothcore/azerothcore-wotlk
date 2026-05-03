-- DB update 2026_05_01_03 -> 2026_05_01_04

-- Set Quest Pre-requisite From the Depths of Azjol-Nerub for Strength of Icemist.
UPDATE `quest_template_addon` SET `PrevQuestID` = 12036 WHERE (`ID` = 12063);

-- Delete wrong guid (Taunka Soldier)
DELETE FROM `creature` WHERE (`id1` = 26437) AND (`guid` IN (102363));
DELETE FROM `creature_addon` WHERE (`guid` IN (102363));

-- Set Reward Spells
UPDATE `quest_template` SET `RewardSpell` = 46997 WHERE `ID` = 11978;
UPDATE `quest_template` SET `RewardSpell` = 47418 WHERE `ID` = 12069;

DELETE FROM `spell_area` WHERE (`spell` IN (46997, 47418));
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(46997, 4165, 11978, 0, 0, 0, 2, 1, 64, 0),
(47418, 4165, 12069, 0, 0, 0, 2, 1, 64, 0);

-- Set Auras (Taunka Soldiers & Greatmother Icemist)
UPDATE `creature_addon` SET `auras` = '46996' WHERE (`guid` IN (102326, 102327, 102328, 102329, 102330, 102331, 102332, 102333, 102337, 102338, 102340, 102341, 98402));

-- Set Unit Flags for Roanauk Icemist (Sniffed)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |768 WHERE (`entry` = 26810);

-- Set Auras (Roanauk Icemist)
DELETE FROM `creature_template_addon` WHERE (`entry` = 26810);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(26810, 0, 0, 0, 0, 0, 0, '47417');
