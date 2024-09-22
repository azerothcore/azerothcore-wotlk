-- AzjolNerub
-- Anubarak 29120 txt line ruRU loc (BroadcastTextId unknown)
DELETE FROM `creature_text_locale` WHERE `CreatureID`=29120 AND `GroupID`=5 AND `ID`=0 AND `locale`='ruRU' ;
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES 
(29120, 5, 0, 'ruRU', 'Я был королем этой империи, когдато. При жизни я был героем смерти, я вернулся завоевателем. Теперь я снова оберегаю это королевство. Забавно, неправда ли?');

-- Pit of Saron
-- Lady Sylvanas Windrunner 36990 use localized lines
UPDATE `creature_text` SET `BroadcastTextId` = 37393 WHERE `CreatureID` = 36990 AND `GroupID`=7 AND `ID`=0;

-- Gorkun Ironskull 37320 use localized lines 
UPDATE `creature_text` SET `BroadcastTextId` = 37320 WHERE `CreatureID` = 37581 AND `GroupID`=61 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId` = 37321 WHERE `CreatureID` = 37581 AND `GroupID`=62 AND `ID`=0;

-- Rescued Horde Slave 36889 use localized lines
UPDATE `creature_text` SET `BroadcastTextId` = 36718 WHERE `CreatureID` = 36889 AND `GroupID`=0 AND `ID`=0;
-- connect heroic version template
UPDATE `creature_template` SET `difficulty_entry_1` = 37654 WHERE `entry` = 36889;

-- Rescued Alliance Slave connect heroic version template
UPDATE `creature_template` SET `difficulty_entry_1` = 37653 WHERE `entry` = 36888;

-- remove duplicated line (already exist in GroupID=0
DELETE FROM `creature_text` WHERE `CreatureID`=36993 AND `GroupID`=36 AND `ID`=0;
DELETE FROM `creature_text` WHERE `CreatureID`=36990 AND `GroupID`=37 AND `ID`=0;

-- remove duplicated line (already exist in GroupID=1
DELETE FROM `creature_text` WHERE `CreatureID`=36990 AND `GroupID`=40 AND `ID`=0;
DELETE FROM `creature_text` WHERE `CreatureID`=36993 AND `GroupID`=39 AND `ID`=0;

-- remove duplicated line (already exist in GroupID=2
DELETE FROM `creature_text` WHERE `CreatureID`=36990 AND `GroupID`=46 AND `ID`=0;

-- update comment according to core cript
UPDATE `creature_text` SET `comment` = 'Sylvanas SAY_SYLVANAS_KRICK_1' WHERE `CreatureID` = 36990 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `comment` = 'Sylvanas SAY_SYLVANAS_KRICK_2' WHERE `CreatureID` = 36990 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `comment` = 'Sylvanas SAY_SYLVANAS_KRICK_3' WHERE `CreatureID` = 36990 AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `comment` = 'Jaina SAY_JAINA_KRICK_2' WHERE `CreatureID` = 36993 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `comment` = 'Jaina SAY_JAINA_KRICK_1' WHERE `CreatureID` = 36993 AND `GroupID`=0 AND `ID`=0;
