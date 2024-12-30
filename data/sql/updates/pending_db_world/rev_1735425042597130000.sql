-- Remove HARD_RESET flag while retaining IMMUNITY_KNOCKBACK
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~ (2147483648) WHERE `entry` = 36658;
