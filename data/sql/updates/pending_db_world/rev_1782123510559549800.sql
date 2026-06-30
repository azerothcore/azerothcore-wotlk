--
-- Spirit of the Vale (entry 17087, Azuremyst Isle) - gossip greeting was race-insensitive.
-- Issue azerothcore/azerothcore-wotlk#14219 (chromiecraft/chromiecraft#4535).
--
-- The gossip text (menu 7376) only distinguished shaman from non-shaman: every non-shaman
-- (PR #9942, condition CLASS != shaman on text 8824) saw the draenei line "Return to your
-- people and tell them to send one of your shaman to me." regardless of race, and Horde
-- characters saw it too. Per Wrath Classic (Wowhead/Wowpedia npc=17087) the greeting varies
-- by race:
--   * draenei      -> 8824 "Return to your people and tell them to send one of your shaman to me."   (broadcast 13549)
--   * non-draenei  -> 8825 "Return to the draenei and tell them to send me one of their shaman."     (broadcast 13550)
--   * Horde        -> 8831 "Your presence here can only mean trouble, <son/daughter> of the Horde.  Go in peace."  (broadcast 13557)
-- The shaman quest-chain texts are kept: 8827 while "Call of Earth" (9451) is in progress,
-- 8826 once it is rewarded.
--
-- Reference cores (TrinityCore, cMaNGOS) do not implement the race split for this NPC; the
-- intended data already exists in AC (npc_text 8824/8825 and broadcast 13557), so this
-- only wires it up with gossip conditions. npc_text 8825 (non-draenei) and 8826/8827 (shaman)
-- already exist; 8831 is added to wrap the Horde broadcast 13557.

-- Horde greeting text (wraps broadcast 13557).
DELETE FROM `npc_text` WHERE `ID` = 8831;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`, `Probability0`) VALUES
(8831, 'Your presence here can only mean trouble, $g son : daughter; of the Horde.  Go in peace.', 13557, 1);

-- Make the race-specific greetings selectable from menu 7376 (8824/8826/8827 already present).
DELETE FROM `gossip_menu` WHERE `MenuID` = 7376 AND `TextID` IN (8825, 8831);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7376, 8825),
(7376, 8831);

-- Rebuild the gossip-menu text conditions so exactly one line matches each player.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 7376;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7376, 8824, 0, 0, 16, 0, 1024, 0, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8824 if player is a draenei'),
(14, 7376, 8824, 0, 0, 15, 0, 64, 0, 0, 1, 0, 0, '', 'Spirit of the Vale - text 8824 if player is not a shaman'),
(14, 7376, 8825, 0, 0, 6, 0, 469, 0, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8825 if player is Alliance'),
(14, 7376, 8825, 0, 0, 16, 0, 1024, 0, 0, 1, 0, 0, '', 'Spirit of the Vale - text 8825 if player is not a draenei'),
(14, 7376, 8826, 0, 0, 47, 0, 9451, 64, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8826 if quest Call of Earth (9451) is rewarded'),
(14, 7376, 8827, 0, 0, 6, 0, 469, 0, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8827 if player is Alliance'),
(14, 7376, 8827, 0, 0, 15, 0, 64, 0, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8827 if player is a shaman'),
(14, 7376, 8827, 0, 0, 47, 0, 9451, 64, 0, 1, 0, 0, '', 'Spirit of the Vale - text 8827 if quest Call of Earth (9451) is not rewarded'),
(14, 7376, 8831, 0, 0, 6, 0, 67, 0, 0, 0, 0, 0, '', 'Spirit of the Vale - text 8831 if player is Horde');
