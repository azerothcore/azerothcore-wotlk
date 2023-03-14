-- DB update 2022_12_11_05 -> 2022_12_11_06
--
UPDATE `creature_text` SET `text`='The shield is nearly gone! All that I have worked for is in danger!', `Sound`=10439, `BroadcastTextId`=16795 WHERE `CreatureID`=15608 AND `GroupId`=2;
UPDATE `creature_text` SET `text`='Champions! My shield grows weak!', `Sound`=10437, `BroadcastTextId`=16792 WHERE `CreatureID`=15608 AND `GroupId`=4;
