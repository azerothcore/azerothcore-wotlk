INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629740472149311140');

-- Fixed the quest skill needed and moved the spectral chalice near Gloomrel instead of near Angerrel
UPDATE `quest_template_addon` SET `RequiredSkillID` = 186, `RequiredSkillPoints` = 230 WHERE (`ID` = 4083);
UPDATE `gameobject` SET `position_x` = 1225.07, `position_y` = -244.98, `position_z` = -85.67  WHERE (`id` = 164869) AND (`guid` IN (67871));

-- Changed the text of the introductory gossip
UPDATE `gossip_menu` SET `textid` = 2598 WHERE `menuid` = 1945;

-- Fix the text and broadcast option of the gossip texts
UPDATE `gossip_menu_option` SET `OptionText` = 'I have paid your price, Gloom´rel.  Now, teach me your secrets!', `OptionBroadcastTextID` = 4900 WHERE (`MenuID` = 1945) AND (`OptionID` IN (0));
UPDATE `gossip_menu_option` SET `OptionText` = 'Gloom`rel, tell me your secrets!', `OptionBroadcastTextID` = 4897 WHERE (`MenuID` = 1945) AND (`OptionID` IN (1));
