-- DB update 2026_04_23_00 -> 2026_04_23_01

-- Update targets
UPDATE `smart_scripts` SET `target_param1` = 65915, `target_param2` = 191577 WHERE (`entryorguid` IN (-128571)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65916, `target_param2` = 191580 WHERE (`entryorguid` IN (-128567)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65920, `target_param2` = 191581 WHERE (`entryorguid` IN (-128570)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65921, `target_param2` = 191582 WHERE (`entryorguid` IN (-128576)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65923, `target_param2` = 191583 WHERE (`entryorguid` IN (-128565)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65925, `target_param2` = 191584 WHERE (`entryorguid` IN (-128574)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65926, `target_param2` = 191585 WHERE (`entryorguid` IN (-128573)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65927, `target_param2` = 191586 WHERE (`entryorguid` IN (-128568)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65928, `target_param2` = 191587 WHERE (`entryorguid` IN (-128566)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65929, `target_param2` = 191588 WHERE (`entryorguid` IN (-128572)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65930, `target_param2` = 191589 WHERE (`entryorguid` IN (-128575)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));
UPDATE `smart_scripts` SET `target_param1` = 65931, `target_param2` = 191590 WHERE (`entryorguid` IN (-128569)) AND (`source_type` = 0) AND (`id` IN (1, 2, 3));

-- Delete creature_addon table from an Unworthy Initiate.
DELETE FROM `creature_addon` WHERE (`guid` IN (128740));
