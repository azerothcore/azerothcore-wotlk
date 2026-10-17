-- DB update 2025_11_24_01 -> 2025_11_24_02
-- Alliance
UPDATE `conditions` SET `ConditionValue1` = 11248, `Comment` = 'Vrykul Scroll of Ascension - Requires quest Operation: Skornful Wrath completed' WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 33314 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 11247;
-- Horde
UPDATE `conditions` SET `ConditionValue1` = 11256, `Comment` = 'Vrykul Scroll of Ascension - Requires quest Skorn Must Fall! completed' WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 33345 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 11258;
