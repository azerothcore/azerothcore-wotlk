-- Emote States
DELETE FROM `creature_addon` WHERE (`guid` IN (138669, 138670, 138671, 138672));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(138669, 0, 0, 0, 1, 375, 0, ''),
(138670, 0, 0, 0, 1, 375, 0, ''),
(138671, 0, 0, 0, 1, 375, 0, ''),
(138672, 0, 0, 0, 1, 375, 0, '');

-- Avian Ripper
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 2 WHERE (`creature_id` IN (21891, 21989));

-- Sethekk Initiate (Heroic)
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 20693);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(20693, 1011, 0, 7, 0, 15, 0, 0, 0, 0);

-- Saga of Terokk
DELETE FROM `gameobject` WHERE `id` IN (183050, 183997) AND `guid` IN (7278, 7281);
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `id`=183050 AND `guid`=42095;
