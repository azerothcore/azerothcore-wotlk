-- DB update 2024_12_08_00 -> 2024_12_08_01

-- Change Z position for two Silt Crawlers.

UPDATE `creature` SET `position_z` = -2.316132 WHERE `guid` = 34158;
UPDATE `creature` SET `position_z` = -2.4465983 WHERE `guid` = 32692;
