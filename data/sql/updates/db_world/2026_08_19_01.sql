-- DB update 2026_08_19_00 -> 2026_08_19_01
-- They already have LinkedTrap set on one of them
UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` = 176751;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 176751);
UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` = 176752;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 176752);
