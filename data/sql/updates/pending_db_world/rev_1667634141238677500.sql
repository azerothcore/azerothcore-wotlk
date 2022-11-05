
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17000;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17000) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17000, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Just Summoned - Cast \'Spawn - Red Lightning\''), /*Casts 'Red Lightning' when Aggonis appears*/
(17000, 0, 1, 0, 60, 0, 100, 1, 4000, 4000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Update - Say Line 0 (No Repeat)'), /*Wait four seconds to speak, this event is repeated if and only if Aggonar is out of combat again. Aggonar will chase the player until he kills him, see event id 4 (Although it may happen that someone uses an ability that moves him away, in that case Aggonar will return to his starting place, if no one attacks him after that, he will disappear after 30 seconds as stated in the original summoning event).*/
(17000, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Just Summoned - Set Flags Not Attackable'), /*When Aggonar appears, set a flag to 2 (not attackable).*/
(17000, 0, 3, 0, 60, 0, 100, 0, 7000, 7000, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Update - Remove Flags Not Attackable'), /*Wait seven seconds to remove the non-attackable flag.*/
(17000, 0, 4, 0, 60, 0, 100, 0, 7000, 7000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 17, 0, 20, 0, 0, 0, 0, 0, 0, 'Aggonis - On Update - Start Attacking'), /*When the non-attackable flag is removed (after seven seconds), Aggonar will start attacking any player within a range of 20.*/
(17000, 0, 5, 0, 5, 0, 100, 0, 0, 0, 1, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Killed Unit - Despawn In 1000 ms'); /*If aggonar kills the player, he disappears after one second.*/

DELETE FROM `creature_text` WHERE `CreatureID` = 17000 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17000, 0, 0, "Fools! You seek to abjure my father's presence? Death awaits you, mortals!", 12, 0, 100, 0, 0, 0, 0, 0, 'Aggonis'); /*creates the missing text*/

DELETE FROM `creature_text_locale` WHERE `CreatureID` = 17000 AND `GroupID` IN (0) AND `Locale` IN ('esES','esMX');
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(17000 , 0, 0, 'esES',"¡Estúpidos! ¿Queréis repudiar la presencia de mi padre? ¡La muerte os espera, mortales!"),
(17000 , 0, 0, 'esMX',"¡Estúpidos! ¿Queréis repudiar la presencia de mi padre? ¡La muerte os espera, mortales!"); /*translates it into Spanish*/
