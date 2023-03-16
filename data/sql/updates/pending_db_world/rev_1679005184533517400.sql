--
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel` = 63 WHERE (`entry` = 20700);
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 18703);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18703) AND (`source_type` = 0);
