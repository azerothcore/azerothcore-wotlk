-- DB update 2026_02_22_00 -> 2026_02_22_01
--
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` IN (193958, 193960) AND `ScriptName` = 'go_the_focusing_iris';
