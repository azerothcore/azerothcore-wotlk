-- DB update 2023_03_15_05 -> 2023_03_15_06
-- Griftah
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19227 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(19227, 0, 0, 0, 38, 0, 100, 0, 0, 1, 60000, 60000, 0, 80, 1922700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Griftah - On Data Set 0 1 - Run Script (Areatrigger 4389 Invoker)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1922700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1922700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Griftah - Actionlist - Say Line 0'),
(1922700, 9, 1, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Griftah - Actionlist - Play Emote 1'),
(1922700, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Griftah - Actionlist - Play Emote 5');

DELETE FROM `creature_text` WHERE `CreatureID` = 19227;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(19227,0,0,"Hey! Hey, $r! I be havin' just the thing for ya. Ya ever see a tikbalang? Frightenin' creatures. Prone to stealin' ya away. What ya need is one of my tikbalang wards. Guaranteed to ward away all tikbalangs!",12,0,100,5,0,0,16318,0,"Griftah"),
(19227,0,1,"Look over here, $c! I got somethin' for ya. Just what ya need. It's soap, right... and it's on a rope! No offense, $G man:honey;, but yer a little ripe, know what I'm sayin'?",12,0,100,5,0,0,16319,0,"Griftah"),
(19227,0,2,"Ya look lovesick. Special someone be gettin' ya down, eh? No worries, no worries. Ya get this medallion from me, ya wear it when ya see 'em, and they be all over ya, $G man:sweetheart;!",12,0,100,5,0,0,16320,0,"Griftah"),
(19227,0,3,"Dangerous out there, innit? Know what ya need? Protection. I can help ya defy death itself! Ya wear this madstone 'round yer neck, see, and then ya be able to come back if ya find yerself in the spirit world! Just a quick jaunt to yer corpse and up ya come, fresh and new!",12,0,100,5,0,0,16321,0,"Griftah"),
(19227,0,4,"Amazing amulets! Incredible curios! The newfangled jewelcrafters be havin' nothin' on the tried and true mystical methods of ol' Griftah! Improve yerself through these magical talismans for a bargain price!",12,0,100,5,0,0,16322,0,"Griftah"),
(19227,0,5,"C'mere, $r. Ya don't want to be riskin' yerself in a dungeon, do ya? Filthy work, and for what? Some worthless trinket? Nah, what ya need be one of my amulets. Guaranteed to work!",12,0,100,5,0,0,16323,0,"Griftah"),
(19227,0,6,"Ya look tired, $c. I be havin' somethin' for ya. These amulets, they can help ya leap obstacles and swim through the rivers like ya be born to it. They energize the food ya be eatin', makin' yer wounds close before yer eyes!",12,0,100,5,0,0,16324,0,"Griftah");

-- Areatrigger
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4389;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4389, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 4389 AND `source_type` = 2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(4389,2,0,1,46,0,100,0,4389,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,"Areatrigger (Lower City) - On Trigger - Store Targetlist"),
(4389,2,1,2,61,0,100,0,0,0,0,0,0,100,1,0,0,0,0,0,10,68758,19227,0,0,0,0,0,0,"Areatrigger (Lower City) - On Link - Send Target 1 (Griftah)"),
(4389,2,2,0,61,0,100,0,0,0,0,0,0,45,0,1,0,0,0,0,10,68758,19227,0,0,0,0,0,0,"Areatrigger (Lower City) - On Link - Set Data 0 1 (Griftah)");
