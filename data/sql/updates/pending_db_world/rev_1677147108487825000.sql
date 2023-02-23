-- Tamed Kodo - Remove GOSSIP flag, set via CreatureScript.
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 11627;
