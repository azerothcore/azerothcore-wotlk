INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1550874957572075786');

UPDATE `creature_text`
SET `BroadcastTextID` = 37093, `Sound` = 16747, `Text` = 'Intruders have entered the master''s domain. Signal the alarms!', `comment` = 'tyrannus SAY_TYRANNUS_INTRO_1'
WHERE `CreatureID` = 36794 AND `groupid` = 1;

UPDATE `creature_text`
SET `BroadcastTextID` = 37392, `Sound` = 17045, `Text` = 'Soldiers of the Horde, attack!', `comment` = 'sylvanas SAY_SYLVANAS_INTRO_1'
WHERE `CreatureID` = 36990 AND `groupid` = 3;

UPDATE `creature_text`
SET `BroadcastTextID` = 37087, `Sound` = 16626, `Text` = 'Heroes of the Alliance, attack!', `comment` = 'jaina SAY_JAINA_INTRO_1'
WHERE `CreatureID` = 36993 AND `groupid` = 2;
