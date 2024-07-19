-- DB update 2024_07_19_02 -> 2024_07_19_03
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 10996 AND `SourceEntry` = 6 AND `ConditionTypeOrReference` IN (2,8);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10996, 6, 0, 1, 2, 0, 50375, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Courage\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50376, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Vengeance\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50377, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Destruction\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50378, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Wisdom\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50384, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Greater Destruction\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50386, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Greater Wisdom\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50387, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Greater Vengeance\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50388, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Greater Courage\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50397, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Unmatched Destruction\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50398, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Endless Destruction\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50399, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Unmatched Wisdom\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50400, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Endless Wisdom\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50401, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Unmatched Vengeance\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50402, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Endless Vengeance\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50403, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Unmatched Courage\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 50404, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Endless Courage\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 52569, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Might\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 52570, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Greater Might\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 52571, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Unmatched Might\' AND'),
(15, 10996, 6, 0, 1, 2, 0, 52572, 1, 1, 1, 0, 0, '', 'Show Gossip Option 6 if player does not have item \'Ashen Band of Endless Might\' AND'),
(15, 10996, 6, 0, 1, 8, 0, 24815, 0, 0, 0, 0, 0, '', 'Show Gossip Option 6 if Quest \'Choose your path\' is rewarded');
