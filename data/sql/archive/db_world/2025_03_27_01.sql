-- DB update 2025_03_27_00 -> 2025_03_27_01
-- Set Kirtonos the Herald level to 60
UPDATE `creature_template` SET `minlevel` = 60, `maxlevel` = 60 WHERE (`entry` = 10506);
