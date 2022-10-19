--
UPDATE `gameobject_template` SET `ScriptName`='go_pumpkin_shrine' WHERE `entry`=186267;

DELETE FROM `creature_text` WHERE `CreatureID`=23682 AND `GroupID`=5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (23682, 5, 0, 'Your body lies beaten, battered and broken! Let my curse be your own, fate has spoken!', 14, 0, 100, 0, 0, 11962, 40546, 0, 'headless horseman SAY_PLAYER_DEATH');
