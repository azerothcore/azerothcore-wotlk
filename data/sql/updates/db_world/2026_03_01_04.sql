-- DB update 2026_03_01_03 -> 2026_03_01_04
--
-- Tie Wintergrasp gear vendors to arena seasons
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` IN (32294, 32296, 39172, 39173) AND `SourceEntry` IN (46057, 46058, 46059, 46060, 46061, 46062, 46063, 46064, 46065, 46066, 46071, 46072, 46073, 46074, 46075, 46076, 46077, 46078, 46079, 46080, 46081, 46082, 46083, 46084, 46085, 46086, 46087, 46088, 48974, 48975, 48976, 48977, 48978, 48979, 48980, 48981, 48982, 48983, 48987, 48988, 48990, 48991, 48992, 48993, 48994, 48997, 48998, 48999, 49000, 51568, 51569, 51570, 51571, 51572, 51573, 51574, 51575, 51576, 51577, 51578, 51579, 51580, 51581);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Season 6
-- Titan-Forged Chestguard of Salvation (46057)
(23,32294,46057,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chestguard of Salvation - S6'),
(23,32294,46057,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chestguard of Salvation - S7'),
(23,32294,46057,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chestguard of Salvation - S8'),
(23,32296,46057,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chestguard of Salvation - S6'),
(23,32296,46057,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chestguard of Salvation - S7'),
(23,32296,46057,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chestguard of Salvation - S8'),
-- Titan-Forged Breastplate of Triumph (46058)
(23,32294,46058,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Breastplate of Triumph - S6'),
(23,32294,46058,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Breastplate of Triumph - S7'),
(23,32294,46058,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Breastplate of Triumph - S8'),
(23,32296,46058,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Breastplate of Triumph - S6'),
(23,32296,46058,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Breastplate of Triumph - S7'),
(23,32296,46058,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Breastplate of Triumph - S8'),
-- Titan-Forged Chain Armor of Triumph (46059)
(23,32294,46059,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chain Armor of Triumph - S6'),
(23,32294,46059,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chain Armor of Triumph - S7'),
(23,32294,46059,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chain Armor of Triumph - S8'),
(23,32296,46059,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chain Armor of Triumph - S6'),
(23,32296,46059,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chain Armor of Triumph - S7'),
(23,32296,46059,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chain Armor of Triumph - S8'),
-- Titan-Forged Ringmail of Salvation (46060)
(23,32294,46060,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Ringmail of Salvation - S6'),
(23,32294,46060,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Ringmail of Salvation - S7'),
(23,32294,46060,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Ringmail of Salvation - S8'),
(23,32296,46060,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Ringmail of Salvation - S6'),
(23,32296,46060,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Ringmail of Salvation - S7'),
(23,32296,46060,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Ringmail of Salvation - S8'),
-- Titan-Forged Mail Armor of Domination (46061)
(23,32294,46061,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Mail Armor of Domination - S6'),
(23,32294,46061,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Mail Armor of Domination - S7'),
(23,32294,46061,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Mail Armor of Domination - S8'),
(23,32296,46061,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Mail Armor of Domination - S6'),
(23,32296,46061,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Mail Armor of Domination - S7'),
(23,32296,46061,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Mail Armor of Domination - S8'),
-- Titan-Forged Leather Tunic of Triumph (46062)
(23,32294,46062,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Tunic of Triumph - S6'),
(23,32294,46062,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Tunic of Triumph - S7'),
(23,32294,46062,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Tunic of Triumph - S8'),
(23,32296,46062,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Tunic of Triumph - S6'),
(23,32296,46062,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Tunic of Triumph - S7'),
(23,32296,46062,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Tunic of Triumph - S8'),
-- Titan-Forged Leather Chestguard of Salvation (46063)
(23,32294,46063,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Salvation - S6'),
(23,32294,46063,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Salvation - S7'),
(23,32294,46063,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Salvation - S8'),
(23,32296,46063,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Salvation - S6'),
(23,32296,46063,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Salvation - S7'),
(23,32296,46063,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Salvation - S8'),
-- Titan-Forged Leather Chestguard of Dominance (46064)
(23,32294,46064,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Dominance - S6'),
(23,32294,46064,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Dominance - S7'),
(23,32294,46064,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Chestguard of Dominance - S8'),
(23,32296,46064,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Dominance - S6'),
(23,32296,46064,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Dominance - S7'),
(23,32296,46064,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Chestguard of Dominance - S8'),
-- Titan-Forged Raiment of Dominance (46065)
(23,32294,46065,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Dominance - S6'),
(23,32294,46065,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Dominance - S7'),
(23,32294,46065,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Dominance - S8'),
(23,32296,46065,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Dominance - S6'),
(23,32296,46065,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Dominance - S7'),
(23,32296,46065,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Dominance - S8'),
-- Titan-Forged Raiment of Salvation (46066)
(23,32294,46066,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Salvation - S6'),
(23,32294,46066,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Salvation - S7'),
(23,32294,46066,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Raiment of Salvation - S8'),
(23,32296,46066,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Salvation - S6'),
(23,32296,46066,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Salvation - S7'),
(23,32296,46066,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Raiment of Salvation - S8'),
-- Titan-Forged Girdle of Salvation (46071)
(23,32294,46071,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Salvation - S6'),
(23,32294,46071,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Salvation - S7'),
(23,32294,46071,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Salvation - S8'),
(23,32296,46071,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Salvation - S6'),
(23,32296,46071,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Salvation - S7'),
(23,32296,46071,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Salvation - S8'),
-- Titan-Forged Girdle of Triumph (46072)
(23,32294,46072,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Triumph - S6'),
(23,32294,46072,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Triumph - S7'),
(23,32294,46072,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Girdle of Triumph - S8'),
(23,32296,46072,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Triumph - S6'),
(23,32296,46072,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Triumph - S7'),
(23,32296,46072,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Girdle of Triumph - S8'),
-- Titan-Forged Waistguard of Dominance (46073)
(23,32294,46073,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Dominance - S6'),
(23,32294,46073,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Dominance - S7'),
(23,32294,46073,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Dominance - S8'),
(23,32296,46073,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Dominance - S6'),
(23,32296,46073,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Dominance - S7'),
(23,32296,46073,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Dominance - S8'),
-- Titan-Forged Waistguard of Salvation (46074)
(23,32294,46074,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Salvation - S6'),
(23,32294,46074,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Salvation - S7'),
(23,32294,46074,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Salvation - S8'),
(23,32296,46074,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Salvation - S6'),
(23,32296,46074,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Salvation - S7'),
(23,32296,46074,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Salvation - S8'),
-- Titan-Forged Waistguard of Triumph (46075)
(23,32294,46075,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Triumph - S6'),
(23,32294,46075,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Triumph - S7'),
(23,32294,46075,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Waistguard of Triumph - S8'),
(23,32296,46075,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Triumph - S6'),
(23,32296,46075,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Triumph - S7'),
(23,32296,46075,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Waistguard of Triumph - S8'),
-- Titan-Forged Belt of Dominance (46076)
(23,32294,46076,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Dominance - S6'),
(23,32294,46076,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Dominance - S7'),
(23,32294,46076,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Dominance - S8'),
(23,32296,46076,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Dominance - S6'),
(23,32296,46076,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Dominance - S7'),
(23,32296,46076,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Dominance - S8'),
-- Titan-Forged Belt of Salvation (46077)
(23,32294,46077,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Salvation - S6'),
(23,32294,46077,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Salvation - S7'),
(23,32294,46077,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Salvation - S8'),
(23,32296,46077,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Salvation - S6'),
(23,32296,46077,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Salvation - S7'),
(23,32296,46077,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Salvation - S8'),
-- Titan-Forged Belt of Triumph (46078)
(23,32294,46078,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Triumph - S6'),
(23,32294,46078,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Triumph - S7'),
(23,32294,46078,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Belt of Triumph - S8'),
(23,32296,46078,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Triumph - S6'),
(23,32296,46078,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Triumph - S7'),
(23,32296,46078,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Belt of Triumph - S8'),
-- Titan-Forged Cord of Dominance (46079)
(23,32294,46079,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Dominance - S6'),
(23,32294,46079,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Dominance - S7'),
(23,32294,46079,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Dominance - S8'),
(23,32296,46079,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Dominance - S6'),
(23,32296,46079,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Dominance - S7'),
(23,32296,46079,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Dominance - S8'),
-- Titan-Forged Cord of Salvation (46080)
(23,32294,46080,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Salvation - S6'),
(23,32294,46080,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Salvation - S7'),
(23,32294,46080,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cord of Salvation - S8'),
(23,32296,46080,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Salvation - S6'),
(23,32296,46080,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Salvation - S7'),
(23,32296,46080,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cord of Salvation - S8'),
-- Titan-Forged Rune of Audacity (46081)
(23,32294,46081,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Audacity - S6'),
(23,32294,46081,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Audacity - S7'),
(23,32294,46081,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Audacity - S8'),
(23,32296,46081,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Audacity - S6'),
(23,32296,46081,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Audacity - S7'),
(23,32296,46081,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Audacity - S8'),
-- Titan-Forged Rune of Determination (46082)
(23,32294,46082,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Determination - S6'),
(23,32294,46082,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Determination - S7'),
(23,32294,46082,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Determination - S8'),
(23,32296,46082,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Determination - S6'),
(23,32296,46082,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Determination - S7'),
(23,32296,46082,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Determination - S8'),
-- Titan-Forged Rune of Accuracy (46083)
(23,32294,46083,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Accuracy - S6'),
(23,32294,46083,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Accuracy - S7'),
(23,32294,46083,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Accuracy - S8'),
(23,32296,46083,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Accuracy - S6'),
(23,32296,46083,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Accuracy - S7'),
(23,32296,46083,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Accuracy - S8'),
-- Titan-Forged Rune of Cruelty (46084)
(23,32294,46084,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Cruelty - S6'),
(23,32294,46084,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Cruelty - S7'),
(23,32294,46084,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Cruelty - S8'),
(23,32296,46084,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Cruelty - S6'),
(23,32296,46084,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Cruelty - S7'),
(23,32296,46084,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Cruelty - S8'),
-- Titan-Forged Rune of Alacrity (46085)
(23,32294,46085,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Alacrity - S6'),
(23,32294,46085,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Alacrity - S7'),
(23,32294,46085,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Rune of Alacrity - S8'),
(23,32296,46085,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Alacrity - S6'),
(23,32296,46085,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Alacrity - S7'),
(23,32296,46085,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Rune of Alacrity - S8'),
-- Platinum Disks of Battle (46086)
(23,32294,46086,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Battle - S6'),
(23,32294,46086,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Battle - S7'),
(23,32294,46086,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Battle - S8'),
(23,32296,46086,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Battle - S6'),
(23,32296,46086,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Battle - S7'),
(23,32296,46086,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Battle - S8'),
-- Platinum Disks of Sorcery (46087)
(23,32294,46087,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Sorcery - S6'),
(23,32294,46087,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Sorcery - S7'),
(23,32294,46087,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Sorcery - S8'),
(23,32296,46087,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Sorcery - S6'),
(23,32296,46087,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Sorcery - S7'),
(23,32296,46087,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Sorcery - S8'),
-- Platinum Disks of Swiftness (46088)
(23,32294,46088,0,0,12,0,58,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Swiftness - S6'),
(23,32294,46088,0,1,12,0,59,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Swiftness - S7'),
(23,32294,46088,0,2,12,0,60,0,0,0,0,0,'','Knight Dameron - Platinum Disks of Swiftness - S8'),
(23,32296,46088,0,0,12,0,58,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Swiftness - S6'),
(23,32296,46088,0,1,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Swiftness - S7'),
(23,32296,46088,0,2,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Platinum Disks of Swiftness - S8'),
-- Season 7
-- Titan-Forged Armwraps of Dominance (48974)
(23,32294,48974,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Dominance - S7'),
(23,32294,48974,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Dominance - S8'),
(23,32296,48974,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Dominance - S7'),
(23,32296,48974,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Dominance - S8'),
-- Titan-Forged Armwraps of Salvation (48975)
(23,32294,48975,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Salvation - S7'),
(23,32294,48975,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Salvation - S8'),
(23,32296,48975,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Salvation - S7'),
(23,32296,48975,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Salvation - S8'),
-- Titan-Forged Armwraps of Triumph (48976)
(23,32294,48976,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Triumph - S7'),
(23,32294,48976,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Armwraps of Triumph - S8'),
(23,32296,48976,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Triumph - S7'),
(23,32296,48976,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Armwraps of Triumph - S8'),
-- Titan-Forged Bracers of Salvation (48977)
(23,32294,48977,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Bracers of Salvation - S7'),
(23,32294,48977,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Bracers of Salvation - S8'),
(23,32296,48977,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Bracers of Salvation - S7'),
(23,32296,48977,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Bracers of Salvation - S8'),
-- Titan-Forged Bracers of Triumph (48978)
(23,32294,48978,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Bracers of Triumph - S7'),
(23,32294,48978,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Bracers of Triumph - S8'),
(23,32296,48978,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Bracers of Triumph - S7'),
(23,32296,48978,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Bracers of Triumph - S8'),
-- Titan-Forged Cuffs of Salvation (48979)
(23,32294,48979,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cuffs of Salvation - S7'),
(23,32294,48979,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cuffs of Salvation - S8'),
(23,32296,48979,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cuffs of Salvation - S7'),
(23,32296,48979,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cuffs of Salvation - S8'),
-- Titan-Forged Wristguards of Dominance (48980)
(23,32294,48980,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Dominance - S7'),
(23,32294,48980,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Dominance - S8'),
(23,32296,48980,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Dominance - S7'),
(23,32296,48980,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Dominance - S8'),
-- Titan-Forged Wristguards of Salvation (48981)
(23,32294,48981,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Salvation - S7'),
(23,32294,48981,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Salvation - S8'),
(23,32296,48981,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Salvation - S7'),
(23,32296,48981,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Salvation - S8'),
-- Titan-Forged Wristguards of Triumph (48982)
(23,32294,48982,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Triumph - S7'),
(23,32294,48982,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Wristguards of Triumph - S8'),
(23,32296,48982,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Triumph - S7'),
(23,32296,48982,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Wristguards of Triumph - S8'),
-- Titan-Forged Chain Leggings of Triumph (48983)
(23,32294,48983,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chain Leggings of Triumph - S7'),
(23,32294,48983,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Chain Leggings of Triumph - S8'),
(23,32296,48983,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chain Leggings of Triumph - S7'),
(23,32296,48983,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Chain Leggings of Triumph - S8'),
-- Titan-Forged Leather Legguards of Salvation (48987)
(23,32294,48987,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Salvation - S7'),
(23,32294,48987,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Salvation - S8'),
(23,32296,48987,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Salvation - S7'),
(23,32296,48987,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Salvation - S8'),
-- Titan-Forged Leather Legguards of Triumph (48988)
(23,32294,48988,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Triumph - S7'),
(23,32294,48988,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Triumph - S8'),
(23,32296,48988,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Triumph - S7'),
(23,32296,48988,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Triumph - S8'),
-- Titan-Forged Mail Leggings of Dominance (48990)
(23,32294,48990,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Mail Leggings of Dominance - S7'),
(23,32294,48990,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Mail Leggings of Dominance - S8'),
(23,32296,48990,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Mail Leggings of Dominance - S7'),
(23,32296,48990,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Mail Leggings of Dominance - S8'),
-- Titan-Forged Cloth Leggings of Salvation (48991)
(23,32294,48991,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cloth Leggings of Salvation - S7'),
(23,32294,48991,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cloth Leggings of Salvation - S8'),
(23,32296,48991,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cloth Leggings of Salvation - S7'),
(23,32296,48991,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cloth Leggings of Salvation - S8'),
-- Titan-Forged Plate Legguards of Salvation (48992)
(23,32294,48992,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Plate Legguards of Salvation - S7'),
(23,32294,48992,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Plate Legguards of Salvation - S8'),
(23,32296,48992,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Plate Legguards of Salvation - S7'),
(23,32296,48992,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Plate Legguards of Salvation - S8'),
-- Titan-Forged Plate Legguards of Triumph (48993)
(23,32294,48993,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Plate Legguards of Triumph - S7'),
(23,32294,48993,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Plate Legguards of Triumph - S8'),
(23,32296,48993,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Plate Legguards of Triumph - S7'),
(23,32296,48993,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Plate Legguards of Triumph - S8'),
-- Titan-Forged Ringmail Leggings of Salvation (48994)
(23,32294,48994,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Ringmail Leggings of Salvation - S7'),
(23,32294,48994,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Ringmail Leggings of Salvation - S8'),
(23,32296,48994,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Ringmail Leggings of Salvation - S7'),
(23,32296,48994,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Ringmail Leggings of Salvation - S8'),
-- Titan-Forged Cloth Trousers of Domination (48997)
(23,32294,48997,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cloth Trousers of Domination - S7'),
(23,32294,48997,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Cloth Trousers of Domination - S8'),
(23,32296,48997,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cloth Trousers of Domination - S7'),
(23,32296,48997,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Cloth Trousers of Domination - S8'),
-- Titan-Forged Leather Legguards of Dominance (48998)
(23,32294,48998,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Dominance - S7'),
(23,32294,48998,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Leather Legguards of Dominance - S8'),
(23,32296,48998,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Dominance - S7'),
(23,32296,48998,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Leather Legguards of Dominance - S8'),
-- Titan-Forged Band of Ascendancy (48999)
(23,32294,48999,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Band of Ascendancy - S7'),
(23,32294,48999,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Band of Ascendancy - S8'),
(23,32296,48999,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Band of Ascendancy - S7'),
(23,32296,48999,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Band of Ascendancy - S8'),
-- Titan-Forged Band of Victory (49000)
(23,32294,49000,0,0,12,0,59,0,0,0,0,0,'','Knight Dameron - Titan-Forged Band of Victory - S7'),
(23,32294,49000,0,1,12,0,60,0,0,0,0,0,'','Knight Dameron - Titan-Forged Band of Victory - S8'),
(23,32296,49000,0,0,12,0,59,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Band of Victory - S7'),
(23,32296,49000,0,1,12,0,60,0,0,0,0,0,'','Stone Guard Mukar - Titan-Forged Band of Victory - S8'),
-- Season 8
-- Titan-Forged Pendant of Ascendancy (51568)
(23,39172,51568,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Pendant of Ascendancy - S8'),
(23,39173,51568,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Pendant of Ascendancy - S8'),
-- Titan-Forged Pendant of Victory (51569)
(23,39172,51569,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Pendant of Victory - S8'),
(23,39173,51569,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Pendant of Victory - S8'),
-- Titan-Forged Cloak of Ascendancy (51570)
(23,39172,51570,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Cloak of Ascendancy - S8'),
(23,39173,51570,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Cloak of Ascendancy - S8'),
-- Titan-Forged Cloak of Victory (51571)
(23,39172,51571,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Cloak of Victory - S8'),
(23,39173,51571,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Cloak of Victory - S8'),
-- Titan-Forged Shoulderpads of Salvation (51572)
(23,39172,51572,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulderpads of Salvation - S8'),
(23,39173,51572,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulderpads of Salvation - S8'),
-- Titan-Forged Shoulderpads of Domination (51573)
(23,39172,51573,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulderpads of Domination - S8'),
(23,39173,51573,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulderpads of Domination - S8'),
-- Titan-Forged Spaulders of Dominance (51574)
(23,39172,51574,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Spaulders of Dominance - S8'),
(23,39173,51574,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Spaulders of Dominance - S8'),
-- Titan-Forged Spaulders of Salvation (51575)
(23,39172,51575,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Spaulders of Salvation - S8'),
(23,39173,51575,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Spaulders of Salvation - S8'),
-- Titan-Forged Spaulders of Triumph (51576)
(23,39172,51576,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Spaulders of Triumph - S8'),
(23,39173,51576,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Spaulders of Triumph - S8'),
-- Titan-Forged Shoulders Triumph (51577)
(23,39172,51577,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulders Triumph - S8'),
(23,39173,51577,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulders Triumph - S8'),
-- Titan-Forged Shoulders of Dominance (51578)
(23,39172,51578,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulders of Dominance - S8'),
(23,39173,51578,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulders of Dominance - S8'),
-- Titan-Forged Shoulders of Salvation (51579)
(23,39172,51579,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulders of Salvation - S8'),
(23,39173,51579,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulders of Salvation - S8'),
-- Titan-Forged Shoulderplates of Triumph (51580)
(23,39172,51580,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulderplates of Triumph - S8'),
(23,39173,51580,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulderplates of Triumph - S8'),
-- Titan-Forged Shoulderplates of Salvation (51581)
(23,39172,51581,0,0,12,0,60,0,0,0,0,0,'','Marshal Magruder - Titan-Forged Shoulderplates of Salvation - S8'),
(23,39173,51581,0,0,12,0,60,0,0,0,0,0,'','Champion Ros''slai - Titan-Forged Shoulderplates of Salvation - S8');
