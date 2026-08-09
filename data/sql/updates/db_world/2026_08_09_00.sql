-- DB update 2026_08_08_14 -> 2026_08_09_00
-- Thorim: Clash of Thunder factions (sniffed). The captured mercenaries (1692) and the
-- Jormungar Behemoth (1693) are mutually hostile, driving the pre-encounter mock fight;
-- the arena Dark Rune Acolyte (2119) is friendly to both sides so it can heal across it.
UPDATE `creature_template` SET `faction` = 1693, `VerifiedBuild` = 68887 WHERE `entry` IN (32882, 33154);
UPDATE `creature_template` SET `faction` = 1692, `VerifiedBuild` = 68887 WHERE `entry` IN (32883, 32885, 32907, 32908, 33150, 33151, 33152, 33153);
UPDATE `creature_template` SET `faction` = 2119, `VerifiedBuild` = 68887 WHERE `entry` IN (32886, 33159);

-- Restrict the acolyte's mock fight Circle of Healing (61964) to the pack. It is a
-- TARGET_UNIT_SRC_AREA_ENTRY spell (100 yd, no target cap) and heals anything in the arena
-- without these conditions; the sniff shows it hitting exactly the six pack members.
-- Greater Heal (61965) and Renew (61967) are single-target and script-targeted instead.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (61964, 61965, 61967);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 61964, 0, 0, 31, 0, 3, 32882, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Jormungar Behemoth'),
(13, 1, 61964, 0, 1, 31, 0, 3, 32883, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Captured Mercenary Soldier'),
(13, 1, 61964, 0, 2, 31, 0, 3, 32885, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Captured Mercenary Soldier'),
(13, 1, 61964, 0, 3, 31, 0, 3, 32886, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Dark Rune Acolyte'),
(13, 1, 61964, 0, 4, 31, 0, 3, 32907, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Captured Mercenary Captain'),
(13, 1, 61964, 0, 5, 31, 0, 3, 32908, 0, 0, 0, 0, '', 'Thorim arena - Circle of Healing targets Captured Mercenary Captain');
