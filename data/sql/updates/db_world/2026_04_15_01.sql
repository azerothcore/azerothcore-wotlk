-- DB update 2026_04_15_00 -> 2026_04_15_01

-- Set respawn time on 0 (17 - Force Despawn).
UPDATE `smart_scripts` SET `action_param2` = 0 WHERE (`entryorguid` = 29686) AND (`source_type` = 0) AND (`id` IN (7));

-- Set Text Type on 12 (say).
UPDATE `creature_text` SET `Type` = 12 WHERE (`CreatureID` = 29686) AND (`GroupID` = 0);
