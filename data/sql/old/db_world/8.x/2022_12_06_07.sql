-- DB update 2022_12_06_06 -> 2022_12_06_07
--
DELETE FROM `creature_text` WHERE `CreatureID` = 18338;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18338, 0, 0, 'Azeroth has cowered too long under our shadow! Now, feel the power of the Burning Crusade, and despair!', 14, 0, 100, 0, 0, 0, 16046, 3, 'Highlord Kruul - On Spawn'),
(18338, 0, 1, 'Your fate is sealed, Azeroth! I will find the Aspect Shards, and then you will not stand against our might!', 14, 0, 100, 0, 0, 0, 16047, 3, 'Highlord Kruul - On Spawn'),
(18338, 0, 2, 'Cower, little worms! Your heroes are nothing! Your saviors will be our first feast!', 14, 0, 100, 0, 0, 0, 16045, 3, 'Highlord Kruul - On Spawn'),
(18338, 0, 3, 'Where? Where are the Shards! You cannot hide them from us!', 14, 0, 100, 0, 0, 0, 17097, 3, 'Highlord Kruul - On Spawn'),
(18338, 0, 4, 'Your world will die, mortals! Your doom is now at hand!', 14, 0, 100, 0, 0, 0, 16044, 3, 'Highlord Kruul - On Spawn'),
(18338, 1, 0, 'Your own strength feeds me, $n!', 14, 0, 100, 0, 0, 0, 8461, 0, 'Highlord Kruul - Just Killed'),
(18338, 2, 0, 'Ha! This place is not yet worthy of my infliction.', 14, 0, 100, 0, 0, 0, 16048, 0, 'Highlord Kruul - On Despawn');
