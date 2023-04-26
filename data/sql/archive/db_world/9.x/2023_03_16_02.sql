-- DB update 2023_03_16_01 -> 2023_03_16_02
-- Headless Horseman
DELETE FROM `creature_text` WHERE `CreatureID`=23682;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(23682, 0, 0, 'It is over, your search is done. Let fate choose now, the righteous one.', 14, 0, 100, 0, 0, 11961, 22261, 0, 'Headless Horseman - TALK_ENTRANCE'),
(23682, 1, 0, 'Here\'s my body, fit and pure!  Now, your blackened souls I\'ll cure!', 14, 0, 100, 0, 0, 12567, 22271, 0, 'Headless Horseman - TALK_REJOINED'),
(23682, 2, 0, 'Harken, cur! Tis you I spurn! Now feel... the burn!', 12, 0, 100, 0, 0, 0, 22587, 0, 'Headless Horseman - TALK_CONFLAGRATION'),
(23682, 3, 0, 'Soldiers arise, stand and fight! Bring victory at last to this fallen knight!', 14, 0, 100, 0, 0, 11963, 23861, 0, 'Headless Horseman - TALK_SPROUTING_PUMPKINS'),
(23682, 4, 0, 'This end have I reached before.  What new adventure lies in store?', 14, 0, 100, 0, 0, 11964, 23455, 0, 'Headless Horseman - TALK_DEATH'),
(23682, 5, 0, 'Your body lies beaten, battered and broken! Let my curse be your own, fate has spoken!', 14, 0, 100, 0, 0, 11962, 40546, 0, 'Headless Horseman - TALK_PLAYER_DEATH');

-- Head of the Horseman
DELETE FROM `creature_text` WHERE `CreatureID`=23775;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(23775, 0, 0, '% laughs.', 16, 0, 100, 0, 0, 11965, 37127, 0, 'Head of the Horseman - TALK_LAUGH'),
(23775, 0, 1, '% laughs.', 16, 0, 100, 0, 0, 11975, 37127, 0, 'Head of the Horseman - TALK_LAUGH'),
(23775, 0, 2, '% laughs.', 16, 0, 100, 0, 0, 11976, 37127, 0, 'Head of the Horseman - TALK_LAUGH'),
(23775, 1, 0, 'Get over here, you idiot!', 12, 0, 100, 0, 0, 0, 22415, 0, 'Head of the Horseman - TALK_LOST_HEAD');

-- Add ScriptName to Pumpkin Shrine
UPDATE `gameobject_template` SET `ScriptName`='go_pumpkin_shrine' WHERE `entry`=186267;

-- Remove quest Call the Headless Horseman from Pumpkin Shrine
DELETE FROM `gameobject_queststarter` WHERE `id`=186267 AND `quest`=11405;
