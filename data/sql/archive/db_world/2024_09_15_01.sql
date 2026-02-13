-- DB update 2024_09_15_00 -> 2024_09_15_01
-- implement QUEST_SPECIAL_FLAGS_NO_LOREMASTER_COUNT
-- extend column datatype from tinyint to int
ALTER TABLE `quest_template_addon` MODIFY COLUMN `SpecialFlags` INT UNSIGNED DEFAULT 0 NOT NULL;

-- add flag to Corrupted Flower Quests in Felwood
UPDATE `quest_template_addon` SET `SpecialFlags` = (`SpecialFlags` | 256)
WHERE (`ID` IN (996, 998, 1514, 2523, 2878, 3363, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467));
