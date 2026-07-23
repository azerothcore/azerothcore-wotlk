-- DB update 2025_02_06_01 -> 2025_02_06_02
-- Fix quest 11343 so that quest credit spell is cast on caster, not player
UPDATE `smart_scripts`
SET `target_type` = 1
WHERE `entryorguid` = 2431400 AND `action_type` = 11 AND `action_param1` = 43458;
