-- DB update 2022_09_13_01 -> 2022_09_13_02
--
SET @GOSSIP_MENU_ID1 := 6560; /* Hive'Ashi Glyphed Crystal */
SET @GOSSIP_MENU_ID2 := 6561; /* Hive'Regal Glyphed Crystal */
SET @GOSSIP_MENU_ID3 := 6559; /* Hive'Zora Glyphed Crystal */

SET @QUEST_ID := 8309; /* Glyph Chasing */

SET @RUBBING_KIT := 20453;
SET @ITEM_ID1 := 20455;  /* Hive'Ashi Rubbing */
SET @ITEM_ID2 := 20456; /* Hive'Regal Rubbing */
SET @ITEM_ID3 := 20454; /* Hive'Zora Rubbing */

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (@GOSSIP_MENU_ID1, @GOSSIP_MENU_ID2, @GOSSIP_MENU_ID3);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15, @GOSSIP_MENU_ID1, 0, 0, 0, 9, 0, @QUEST_ID, 0, 0, 0, 0, '', 'Requires Quest Taken'),
(15, @GOSSIP_MENU_ID1, 0, 0, 0, 2, 0, @ITEM_ID1, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, @GOSSIP_MENU_ID1, 0, 0, 0, 2, 0, @RUBBING_KIT, 1, 0, 0, 0, '', 'Requires Item'),
(15, @GOSSIP_MENU_ID2, 0, 0, 0, 9, 0, @QUEST_ID, 0, 0, 0, 0, '', 'Requires Quest Taken'),
(15, @GOSSIP_MENU_ID2, 0, 0, 0, 2, 0, @ITEM_ID2, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, @GOSSIP_MENU_ID2, 0, 0, 0, 2, 0, @RUBBING_KIT, 1, 0, 0, 0, '', 'Requires Item'),
(15, @GOSSIP_MENU_ID3, 0, 0, 0, 9, 0, @QUEST_ID, 0, 0, 0, 0, '', 'Requires Quest Taken'),
(15, @GOSSIP_MENU_ID3, 0, 0, 0, 2, 0, @ITEM_ID3, 1, 0, 1, 0, '', 'Requires Missing Item'),
(15, @GOSSIP_MENU_ID3, 0, 0, 0, 2, 0, @RUBBING_KIT, 1, 0, 0, 0, '', 'Requires Item');
