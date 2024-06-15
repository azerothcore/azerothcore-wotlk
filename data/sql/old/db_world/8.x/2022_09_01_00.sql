-- DB update 2022_08_30_01 -> 2022_09_01_00
-- Update Vekniss Hive Crawler formations.
UPDATE `creature_formations` SET `dist`=9 WHERE `memberGUID` IN (87940, 87942, 87944);
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID` BETWEEN 87939 AND 87944;

-- Update GroupAI in Stinger packs
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID` BETWEEN 87962 AND 87998;

-- Update GroupAI in Vekniss Warrior packs
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID` BETWEEN 87672 AND 87677;
