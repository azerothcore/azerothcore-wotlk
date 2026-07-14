-- Refuge Pointe Defender (10696) does not assist players in combat against
-- nearby hostile creatures because CREATURE_TYPE_FLAG_CAN_ASSIST is unset.
UPDATE `creature_template` SET `type_flags` = `type_flags` | 0x1000 WHERE `entry` = 10696;
