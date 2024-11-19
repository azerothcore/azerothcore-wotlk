-- DB update 2023_11_10_02 -> 2023_11_11_00
-- Thekal (14509)
-- Update SAY_AGGRO to include emote ONESHOT_ROAR
-- Update comments
UPDATE `creature_text` SET `Emote`=15, `comment`='High Priest Thekal - SAY_AGGRO' WHERE `CreatureID`=14509 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `comment`='High Priest Thekal - SAY_DEATH' WHERE `CreatureID`=14509 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `comment`='High Priest Thekal - EMOTE_DIES' WHERE `CreatureID`=14509 AND `GroupID`=2 AND `ID`=0;

-- Thekal (14509)
-- Remove static idle (talking) emote
UPDATE `creature_addon` SET `emote`=0 WHERE `guid`=49310;

-- Zealot Lor'Khan (11347)
-- Update comments
UPDATE `creature_text` SET `comment`='Zealot LorKhan - EMOTE_ZEALOT_DIES' WHERE `CreatureID`=11347 AND `GroupID`=0 AND `ID`=0;

-- Zealot Zath (11348)
-- Update comments
UPDATE `creature_text` SET `comment`='Zealot Zath - EMOTE_ZEALOT_DIES' WHERE `CreatureID`=11348 AND `GroupID`=0 AND `ID`=0;
