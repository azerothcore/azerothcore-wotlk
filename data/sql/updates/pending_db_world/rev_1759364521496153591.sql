-- Moorabi hard reset
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 2147483648 WHERE `entry` IN (29305, 30530);
