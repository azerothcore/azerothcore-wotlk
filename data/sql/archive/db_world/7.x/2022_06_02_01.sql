-- DB update 2022_06_02_00 -> 2022_06_02_01
-- Condition for Loh'atu gossip
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=3481;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15,3481,0,0,0,8,0,5535,0,0,0,0,0,'','Show gossip option 0 if player has quest ''Spiritual Unrest'' rewarded'),
(15,3481,0,0,0,8,0,5536,0,0,0,0,0,'','Show gossip option 0 if player has quest ''A Land Filled with Hatred'' rewarded'),
(15,3481,1,0,0,8,0,5535,0,0,0,0,0,'','Show gossip option 1 if player has quest ''Spiritual Unrest'' rewarded'),
(15,3481,1,0,0,8,0,5536,0,0,0,0,0,'','Show gossip option 1 if player has quest ''A Land Filled with Hatred'' rewarded'),
(15,3481,2,0,0,8,0,5535,0,0,0,0,0,'','Show gossip option 2 if player has quest ''Spiritual Unrest'' rewarded'),
(15,3481,2,0,0,8,0,5536,0,0,0,0,0,'','Show gossip option 2 if player has quest ''A Land Filled with Hatred'' rewarded'),
(15,3481,3,0,0,8,0,5535,0,0,0,0,0,'','Show gossip option 3 if player has quest ''Spiritual Unrest'' rewarded'),
(15,3481,3,0,0,8,0,5536,0,0,0,0,0,'','Show gossip option 3 if player has quest ''A Land Filled with Hatred'' rewarded'),
(15,3481,4,0,0,8,0,5535,0,0,0,0,0,'','Show gossip option 4 if player has quest ''Spiritual Unrest'' rewarded'),
(15,3481,4,0,0,8,0,5536,0,0,0,0,0,'','Show gossip option 4 if player has quest ''A Land Filled with Hatred'' rewarded');
