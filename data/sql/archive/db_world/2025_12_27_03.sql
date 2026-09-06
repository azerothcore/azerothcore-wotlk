-- DB update 2025_12_27_02 -> 2025_12_27_03

-- Set State Melee
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 31001);
