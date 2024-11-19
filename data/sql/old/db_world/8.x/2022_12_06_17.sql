-- DB update 2022_12_06_16 -> 2022_12_06_17
--
DELETE FROM `creature_text` WHERE `CreatureID` IN (17805,17959);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17805,0,0,'Hurry up with it already! The longer you take, the more of a hurtin\ I\m putting on you!',14,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,0,1,'This is terrible..... my arms grow tired from beating on you lazy peons!',14,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,0,2,'Too soon! You are slacking off too soon!',14,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,0,3,'Wake up! Now get up and back to work!',14,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,0,4,'What is this?! Didn\t mommy and daddy teach you anything?!',14,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,1,0,'By Nazjatar\s Depths!',12,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,1,1,'Die, warmblood!',12,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,1,2,'For the Master!',12,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,1,3,'Illidan reigns!',12,0,100,0,0,0,0,0,'Coilfang Slavemaster'),
(17805,1,4,'My blood is like venom!',12,0,100,0,0,0,0,0,'Coilfang Slavemaster'),

(17959,0,0,'Hurry up with it already! The longer you take, the more of a hurtin\ I\m putting on you!',14,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,0,1,'This is terrible..... my arms grow tired from beating on you lazy peons!',14,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,0,2,'Too soon! You are slacking off too soon!',14,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,0,3,'Wake up! Now get up and back to work!',14,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,0,4,'What is this?! Didn\t mommy and daddy teach you anything?!',14,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,1,0,'By Nazjatar\s Depths!',12,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,1,1,'Die, warmblood!',12,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,1,2,'For the Master!',12,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,1,3,'Illidan reigns!',12,0,100,0,0,0,0,0,'Coilfang Slavehandler'),
(17959,1,4,'My blood is like venom!',12,0,100,0,0,0,0,0,'Coilfang Slavehandler');

UPDATE `smart_scripts` SET `event_chance`=50 WHERE `entryorguid`=17959 AND `source_type`=0 AND `id`=5;
UPDATE `smart_scripts` SET `event_chance`=50 WHERE `entryorguid`=17805 AND `source_type`=0 AND `id`=4;
UPDATE `smart_scripts` SET `event_chance`=50 WHERE `entryorguid`=18206 AND `source_type`=0 AND `id`=0;
