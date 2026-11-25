-- DB update 2026_11_25_02 -> 2026_11_25_03
-- Anachronos: hide the lost final signet ring options while the player owns any final Brood of Nozdormu ring
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 6539 AND `ConditionTypeOrReference` = 2 AND (`SourceEntry`, `ConditionValue1`) IN ((13, 21200), (13, 21210), (14, 21200), (14, 21205), (15, 21205), (15, 21210));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6539, 13, 0, 0, 2, 0, 21200, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Protector)'),
(15, 6539, 13, 0, 0, 2, 0, 21210, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Invoker)'),
(15, 6539, 14, 0, 0, 2, 0, 21200, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Protector)'),
(15, 6539, 14, 0, 0, 2, 0, 21205, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Conqueror)'),
(15, 6539, 15, 0, 0, 2, 0, 21205, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Conqueror)'),
(15, 6539, 15, 0, 0, 2, 0, 21210, 1, 1, 1, 0, 0, '', 'Anachronos - Show gossip option if player does not have Signet Ring of the Bronze Dragonflight (Invoker)');
