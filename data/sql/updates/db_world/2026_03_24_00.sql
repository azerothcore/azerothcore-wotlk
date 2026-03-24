-- DB update 2026_03_23_02 -> 2026_03_24_00
-- Move npc_maredis_firestar (Mathredis Firestar, entry 9836) from C++ script to DB gossip

-- Remove C++ ScriptName
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry`=9836;

-- Move gossip options from sub-menus (2299-2303) to the NPC's main menu (2298) with conditions
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2298,2299,2300,2301,2302,2303);
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(2298,0,0,'I present to you the Libram of Rumination.',5291,1,1,2299,0,0,0,'',0,0),
(2298,1,0,'I present to you the Libram of Constitution.',5416,1,1,2300,0,0,0,'',0,0),
(2298,2,0,'I present to you the Libram of Tenacity.',5417,1,1,2301,0,0,0,'',0,0),
(2298,3,0,'I present to you the Libram of Resilience.',5418,1,1,2302,0,0,0,'',0,0),
(2298,4,0,'I present to you the Libram of Voracity.',5419,1,1,2303,0,0,0,'',0,0);

-- Add conditions: show each option only if player has the corresponding Libram
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=2298;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,2298,0,0,0,2,0,11732,1,0,0,0,0,'','Show gossip option if player has Libram of Rumination'),
(15,2298,1,0,0,2,0,11733,1,0,0,0,0,'','Show gossip option if player has Libram of Constitution'),
(15,2298,2,0,0,2,0,11734,1,0,0,0,0,'','Show gossip option if player has Libram of Tenacity'),
(15,2298,3,0,0,2,0,11736,1,0,0,0,0,'','Show gossip option if player has Libram of Resilience'),
(15,2298,4,0,0,2,0,11737,1,0,0,0,0,'','Show gossip option if player has Libram of Voracity');
