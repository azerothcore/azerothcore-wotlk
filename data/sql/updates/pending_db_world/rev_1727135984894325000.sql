--
DELETE FROM `smart_scripts` WHERE `entryorguid`=24077 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=2407700 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24077, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 186565, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Repawn - Summon Ceremonial Dragonflayer Harpoon'),
(24077, 0, 1, 0, 8, 0, 100, 1, 42968, 0, 0, 0, 0, 0, 80, 2407700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On spell hit - Start Script'),
(2407700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 20, 186565, 10, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Set loot state'),
(2407700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Talk 0'),
(2407700, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 91, 255, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Remove Bytes '),
(2407700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Set Bytes 1'),
(2407700, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Talk 1'),
(2407700, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Kill Self'),
(2407700, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Impaled Valgarde Scout - On Script - Despawn');

DELETE FROM `creature_text` WHERE `CreatureID`=24077;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24077, 0, 0, '%s groans.', 16, 0, 100, 0, 0, 0, 22743, 0, 'Impaled Valgarde Scout'),
(24077, 0, 1, '%s screams in agony as the harpoon is removed.', 16, 0, 100, 0, 0, 0, 22744, 0, 'Impaled Valgarde Scout'),
(24077, 0, 2, '%s whimpers.', 16, 0, 100, 0, 0, 0, 22745, 0, 'Impaled Valgarde Scout'),
(24077, 1, 0, 'Don\'t let my death go unavenged, stranger... give ... them... hell...', 12, 0, 100, 0, 0, 0, 22752, 0, 'Impaled Valgarde Scout'),
(24077, 1, 1, 'I\'m done for... too much blood lost... Forget about me, tell Keller... People still alive inside...', 12, 0, 100, 0, 0, 0, 22749, 0, 'Impaled Valgarde Scout'),
(24077, 1, 2, 'Not... no... Our people... Wrymskull... some live...', 12, 0, 100, 0, 0, 0, 22747, 0, 'Impaled Valgarde Scout'),
(24077, 1, 3, 'My injuries are too great. I won\'t make it... Our citizenry held in cages... ritual...', 12, 0, 100, 0, 0, 0, 22748, 0, 'Impaled Valgarde Scout'),
(24077, 1, 4, 'They left us here impaled as a warning to the others... Several still alive... prisoners of...', 12, 0, 100, 0, 0, 0, 22751, 0, 'Impaled Valgarde Scout'),
(24077, 1, 5, 'My family must know... I... for them... always for them...', 12, 0, 100, 0, 0, 0, 22750, 0, 'Impaled Valgarde Scout');

DELETE FROM `gameobject` WHERE `id`=186565;

UPDATE `gameobject_template_locale` SET `castBarCaption`='Quitando' WHERE `entry`=186565 AND `locale` IN ('esES', 'esMX');
