-- DB update 2023_03_11_08 -> 2023_03_11_09
--
-- Temporus Level fix
UPDATE `creature_template` SET `minlevel`=72, `maxlevel`=72 WHERE `entry`=17880;
