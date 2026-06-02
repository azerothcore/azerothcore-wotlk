-- Frostwing Chimaera (24673): remove SMARTCAST_COMBAT_MOVE flag from Venom Spit.
-- This caused SmartAI to treat Venom Spit as the primary attack and stop chasing
-- at ~25 yards (spell range) instead of pursuing to melee.
UPDATE `smart_scripts` SET `action_param2` = 0
WHERE `entryorguid` = 24673 AND `source_type` = 0 AND `id` = 0;
