--
-- Barrett Ramsey is summoned per stage instead of standing in the arena
DELETE FROM `creature` WHERE (`id` = 34816) AND (`guid` = 202957);

UPDATE `creature_template` SET `gossip_menu_id` = 10599, `npcflag` = 1, `unit_flags` = 768, `AIName` = '', `ScriptName` = 'npc_barrett_toc' WHERE (`entry` = 34816);
UPDATE `creature_template` SET `gossip_menu_id` = 10704, `npcflag` = 1, `ScriptName` = 'npc_barrett_toc' WHERE (`entry` = 35909);
UPDATE `creature_template` SET `ScriptName` = 'npc_barrett_toc' WHERE (`entry` IN (35035, 35766, 35770));
UPDATE `creature_template` SET `gossip_menu_id` = 10692, `npcflag` = 1, `ScriptName` = 'npc_barrett_toc' WHERE (`entry` = 35771);

DELETE FROM `gossip_menu` WHERE (`MenuID` IN (10599, 10600, 10609, 10610, 10678, 10679, 10687, 10688, 10692, 10693, 10704, 10705, 10706));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(10599, 14664),
(10599, 14667),
(10600, 14665),
(10600, 14668),
(10609, 14678),
(10609, 14679),
(10610, 14680),
(10610, 14682),
(10678, 14813),
(10678, 14815),
(10679, 14819),
(10679, 14820),
(10687, 14814),
(10687, 14816),
(10688, 14821),
(10688, 14822),
(10692, 14828),
(10693, 14829),
(10704, 14667),
(10704, 14850),
(10705, 14852),
(10706, 14853);

-- Boss state FAIL (2) on Northrend Beasts (0), Lord Jaraxxus (1), Faction Champions (2) and Twin Val'kyr (3) switches Barrett to his retry text
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (14, 15)) AND (`SourceGroup` IN (10599, 10600, 10609, 10610, 10678, 10679, 10687, 10688, 10704));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 10599, 14664, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10599, 14667, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(14, 10600, 14665, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10600, 14668, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(14, 10609, 14678, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was not failed'),
(14, 10609, 14679, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was failed'),
(14, 10610, 14680, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was not failed'),
(14, 10610, 14682, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was failed'),
(14, 10678, 14813, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were not failed'),
(14, 10678, 14815, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were failed'),
(14, 10687, 14814, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were not failed'),
(14, 10687, 14816, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were failed'),
(14, 10679, 14819, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were not failed'),
(14, 10679, 14820, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were failed'),
(14, 10688, 14821, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were not failed'),
(14, 10688, 14822, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were failed'),
(14, 10704, 14850, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10704, 14667, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(15, 10599, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10599, 1, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed'),
(15, 10600, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10600, 1, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed'),
(15, 10609, 0, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was not failed'),
(15, 10609, 1, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was failed'),
(15, 10610, 0, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was not failed'),
(15, 10610, 1, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was failed'),
(15, 10678, 0, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were not failed'),
(15, 10678, 1, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were failed'),
(15, 10687, 0, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were not failed'),
(15, 10687, 1, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were failed'),
(15, 10679, 0, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were not failed'),
(15, 10679, 1, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were failed'),
(15, 10688, 0, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were not failed'),
(15, 10688, 1, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were failed'),
(15, 10704, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 0, 0, 0, 17, 0, 3916, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if player has Call of the Crusade (25 player)'),
(15, 10704, 0, 0, 0, 19, 0, 8, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 25 player heroic'),
(15, 10704, 0, 0, 1, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 0, 0, 1, 17, 0, 3917, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if player has Call of the Crusade (10 player)'),
(15, 10704, 0, 0, 1, 19, 0, 4, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 10 player heroic'),
(15, 10704, 1, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 1, 0, 0, 17, 0, 3916, 0, 0, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if player lacks Call of the Crusade (25 player)'),
(15, 10704, 1, 0, 0, 19, 0, 8, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 25 player heroic'),
(15, 10704, 1, 0, 1, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 1, 0, 1, 17, 0, 3917, 0, 0, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if player lacks Call of the Crusade (10 player)'),
(15, 10704, 1, 0, 1, 19, 0, 4, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 10 player heroic'),
(15, 10704, 2, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed');

DELETE FROM `npc_text` WHERE (`ID` BETWEEN 724001 AND 724005);
DELETE FROM `npc_text_locale` WHERE (`ID` BETWEEN 724001 AND 724005);
