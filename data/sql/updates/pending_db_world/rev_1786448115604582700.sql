-- Deathbringer Saurfang outro: the camp props only spawned on 10N/25N.
UPDATE `gameobject` SET `spawnMask` = 15 WHERE `guid` IN (12363, 55882, 81649);

-- Grip of Agony hangs Muradin/High Overlord and their guards in the air, and the script owns the
-- disable-gravity flag for that. Without 512 (CREATURE_FLAG_EXTRA_NO_MOVE_FLAGS_UPDATE) the core
-- clears the flag again on the next terrain update and they drop back to the floor mid-intro.
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|512 WHERE `entry` IN (37187, 37200, 37830, 37920);

-- Two emote beats of the Alliance outro that have no creature_text row.
DELETE FROM `creature_text` WHERE (`CreatureID` = 37187 AND `GroupID` = 19) OR (`CreatureID` = 37188 AND `GroupID` = 2);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(37187, 19, 0, '%s nods.', 16, 0, 0, 273, 0, 0, 37531, 0, 'High Overlord Saurfang - SAY_OUTRO_ALLIANCE_SAURFANG_NOD'),
(37188, 2, 0, '%s wipes her tears away and smiles at King Varian Wrynn.', 16, 0, 0, 0, 0, 0, 37544, 0, 'Lady Jaina Proudmoore - SAY_OUTRO_ALLIANCE_JAINA_SMILE');
