-- --------------------------------------------------------------------------------------------
-- Trial of the Crusader (Trial of the Crusader, map 649)
-- Frost Sphere (Entry 34606)
-- Remove the custom heroic entries (3460602, 3460603)
-- -------------------------------------------
-- Blizzard only has two Frost Sphere entries: 34606 (10-man) and 34649 (25-man). The custom heroic
-- entries are dropped so heroic falls back to the normal entry of the same raid size: 34606 for
-- 10N/10H (3,000 health) and 34649 for 25N/25H (9,000 health). The 25-man heroic entry had the
-- 10-man health modifier (3,000 health), and neither custom entry had the template addon.
UPDATE `creature_template` SET `difficulty_entry_2` = 0, `difficulty_entry_3` = 0 WHERE `entry` = 34606;
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (3460602, 3460603);
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (3460602, 3460603);
DELETE FROM `creature_template` WHERE `entry` IN (3460602, 3460603);
