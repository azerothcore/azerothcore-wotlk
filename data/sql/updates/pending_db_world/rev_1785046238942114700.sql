-- Reverts the ForceAttack() demo added in the previous file. Not required unless you ran
-- that one - see it for context. Safe to run any time after.
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 29195;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29195 AND `source_type` = 0 AND `id` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2919500, 2919501, 2919502) AND `source_type` = 9;
