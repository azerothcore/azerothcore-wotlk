-- Ulduar: Mechanostriker 54-A should not have UNIT_FLAG_POSSESSED
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` IN (34161, 34162);
