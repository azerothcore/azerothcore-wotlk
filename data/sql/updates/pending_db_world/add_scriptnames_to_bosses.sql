--
UPDATE `creature_template` SET `ScriptName` = 'boss_mennu_the_betrayer', `AIName` = '' WHERE `entry` = 17941;
UPDATE `creature_template` SET `ScriptName` = 'boss_quagmirran', `AIName` = '' WHERE `entry` = 17942;
UPDATE `creature_template` SET `ScriptName` = 'boss_rokmar_the_crackler', `AIName` = '' WHERE `entry` = 17991;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (17941, 17942, 17991) AND `source_type` = 0;
