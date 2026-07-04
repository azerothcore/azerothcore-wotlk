-- DB update 2026_06_30_03 -> 2026_06_30_04
-- Frostwing Chimaera (24673): remove SMARTCAST_COMBAT_MOVE flag from Venom Spit.
-- This caused SmartAI to treat Venom Spit as the primary attack and stop chasing
-- at ~25 yards (spell range) instead of pursuing to melee.
-- The Vilewing Chimaera (21879) casts the same spell with castFlags = 0
-- that is the correct value here too.
UPDATE `smart_scripts` SET `action_param2` = 0
WHERE `entryorguid` = 24673 AND `source_type` = 0 AND `id` = 0 AND `action_type` = 11 AND `action_param1` = 16552;
