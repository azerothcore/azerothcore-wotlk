-- DB update 2022_09_25_03 -> 2022_09_25_04
--
DELETE FROM `gossip_menu_option` WHERE `MenuId`=8934 AND `OptionId`=4 AND `ActionMenuId`=0;
UPDATE `gossip_menu_option` SET `OptionId`=4 WHERE `MenuId`=8934 AND `OptionId`=0 AND `ActionMenuId`=8953;

UPDATE `gossip_menu_option` SET `OptionText`='Do you still need some help moving kegs from the crash site near Razor Hill?', `OptionBroadcastTextID`=23546, `ActionMenuId`=8973 WHERE `MenuId`=8976 AND `OptionId`=4;

DELETE FROM `gossip_menu_option` WHERE `MenuID`=8973;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8973,0,0,'I\m ready to work for you today!  Give me that ram!',23545,1,1,0,0,0,0,NULL,0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (8934,8976);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,8934,1,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8934,1,0,0,47,0,11122,10,0,0,0,0,'','Show Gossip option only if player does not have \"There and Back Again\" taken'),
(15,8934,1,0,0,28,0,11122,0,0,1,0,0,'','Show Gossip option only if player has not quest \"There and Back Again\" rewarded'),

(15,8934,2,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8934,2,0,0,47,0,11318,10,0,0,0,0,'','Show Gossip option only if player does not have \"Now This is Ram Racing... Almost.\" taken'),
(15,8934,2,0,0,28,0,11318,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Now This is Ram Racing... Almost.\" rewarded'),

(15,8934,3,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8934,3,0,0,47,0,11293,10,0,0,0,0,'','Show Gossip option only if player does not have \"Bark for the Barleybrews!\" taken'),
(15,8934,3,0,1,47,0,11294,10,0,0,0,0,'','Show Gossip option only if player does not have \"Bark for the Thunderbrews!\" taken'),
(15,8934,3,0,0,28,0,11293,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Bark for the Barleybrews!\" rewarded'),
(15,8934,3,0,1,28,0,11294,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Bark for the Thunderbrews!\" rewarded'),

(15,8934,4,0,0,8,0,11122,0,0,0,0,0,'','Brewfest Relay Race - Show gossip if player has turned in the quest \"There and Back Again\"'),
(15,8934,4,0,0,1,0,44689,0,0,1,0,0,'','Brewfest Relay Race - Show gossip if player does not have aura \"Relay Race Accept Hidden Debuff - DND\"'),
(15,8934,4,0,0,1,0,43883,0,0,1,0,0,'','Brewfest Relay Race - Show gossip if player does not have aura \"Rental Racing Ram\"'),

(15,8976,1,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8976,1,0,0,47,0,11412,10,0,0,0,0,'','Show Gossip option only if player does not have \"There and Back Again\" taken'),
(15,8976,1,0,0,28,0,11412,0,0,1,0,0,'','Show Gossip option only if player has not quest \"There and Back Again\" rewarded'),

(15,8976,2,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8976,2,0,0,47,0,11409,10,0,0,0,0,'','Show Gossip option only if player does not have \"Now This is Ram Racing... Almost.\" taken'),
(15,8976,2,0,0,28,0,11409,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Now This is Ram Racing... Almost.\" rewarded'),

(15,8976,3,0,0,1,0,43883,0,0,1,0,0,'','Show Gossip option only if player does not have Aura \"Rental Racing Ram\"'),
(15,8976,3,0,0,47,0,11407,10,0,0,0,0,'','Show Gossip option only if player does not have \"Bark for Drohn\s Distillery!\" taken'),
(15,8976,3,0,1,47,0,11408,10,0,0,0,0,'','Show Gossip option only if player does not have \"Bark for T\chali\s Voodoo Brewery!\" taken'),
(15,8976,3,0,0,28,0,11407,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Bark for Drohn\s Distillery!\" rewarded'),
(15,8976,3,0,1,28,0,11408,0,0,1,0,0,'','Show Gossip option only if player has not quest \"Bark for T\chali\s Voodoo Brewery!\" rewarded'),

(15,8976,4,0,0,8,0,11412,0,0,0,0,0,'','Brewfest Relay Race - Show gossip if player has turned in the quest \"There and Back Again\"'),
(15,8976,4,0,0,1,0,44689,0,0,1,0,0,'','Brewfest Relay Race - Show gossip if player does not have aura \"Relay Race Accept Hidden Debuff - DND\"'),
(15,8976,4,0,0,1,0,43883,0,0,1,0,0,'','Brewfest Relay Race - Show gossip if player does not have aura \"Rental Racing Ram\"');
