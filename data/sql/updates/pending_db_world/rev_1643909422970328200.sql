INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643909422970328200');

SET @NPC_ENTRY := 278; /* Sara Timberlain */
SET @GOSSIP_MENU_ID := 61033;
SET @NPC_TEXT_ID := 50039;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Hello, good $gsir:lady;.  Have a seat, and a meal if you\'re hungry.  Don\'t fret if I look busy with my needlework - I\'m listening to you...',
        'Hello, good $gsir:lady;.  Have a seat, and a meal if you\'re hungry.  Don\'t fret if I look busy with my needlework - I\'m listening to you...', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
