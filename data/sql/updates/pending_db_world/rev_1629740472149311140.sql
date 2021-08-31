INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629740472149311140');

-- Fixed the quest skill needed and moved the spectral chalice near Gloomrel instead of near Angerrel
UPDATE `quest_template_addon` SET `RequiredSkillID` = 186, `RequiredSkillPoints` = 230 WHERE (`ID` = 4083);
UPDATE `gameobject` SET `position_x` = 1225.07, `position_y` = -244.98, `position_z` = -85.67  WHERE (`id` = 164869) AND (`guid` IN (67871));

-- Changed the text of the introductory gossip
UPDATE `gossip_menu` SET `textid` = 2598 WHERE `menuid` = 1945;

-- Fix the text and broadcast option of the gossip texts
UPDATE `gossip_menu_option` SET `OptionText` = 'I have paid your price, Gloom''rel.  Now, teach me your secrets!', `OptionBroadcastTextID` = 4900 WHERE (`MenuID` = 1945) AND (`OptionID` IN (0));
UPDATE `gossip_menu_option` SET `OptionText` = 'Gloom''rel, tell me your secrets!', `OptionBroadcastTextID` = 4897 WHERE (`MenuID` = 1945) AND (`OptionID` IN (1));

-- Fixed the completion and the reward text, they were switched
UPDATE `quest_offer_reward` SET `RewardText` = 'The gems make no sound as they fall into depths of the chalice...' WHERE (`ID` = 4083);
UPDATE `quest_request_items` SET `CompletionText` = 'The spectral chalice floats in the air, slowing rising and falling... as if to the beat of a dying heart.' WHERE (`ID` = 4083);
