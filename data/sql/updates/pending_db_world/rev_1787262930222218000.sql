-- Guardian of Yogg-Saron: the 25-man Shadow Nova (65209) entry-targeted effect must hit other
-- Guardians (33136) like its 10-man variant (62714) does since 2026_08_03_03. Its condition still
-- targeted Sara (33134), dealing her a second 25k per Guardian on top of the dedicated 65719 nova.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 2) AND (`SourceEntry` = 65209) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 65209, 0, 0, 31, 0, 3, 33136, 0, 0, 0, 0, '', 'Shadow Nova');

-- Sara is friendly in phase 1 and thus never in combat, so out-of-combat regen undoes the
-- Guardians' Shadow Nova damage. Disable health regen like Yogg-Saron (33288); the script
-- restores her to full health on reset and on the phase 2 transformation instead.
UPDATE `creature_template` SET `RegenHealth` = 0 WHERE `entry` IN (33134, 34332);
