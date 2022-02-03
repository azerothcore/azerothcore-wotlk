INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643921494850373200');

SET @NPC_ENTRY := 341; /* Foreman Oslow */
SET @GOSSIP_MENU_ID := 61038;
SET @NPC_TEXT_ID := 50044;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'I don\'t have much time for idle talk, $N. I\'ve got to get this bridge rebuilt before the rains come.  I\'ve finished every project on-time and under budget and I\'m not about to start slipping now.',
        'I don\'t have much time for idle talk, $N. I\'ve got to get this bridge rebuilt before the rains come.  I\'ve finished every project on-time and under budget and I\'m not about to start slipping now.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
