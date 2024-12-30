-- Remove HARD_REST flag while retaining IMMUNITY_KNOCKBACK
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 1073741824 WHERE `entry` = 36658;
