INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643908217724798700');

SET @NPC_ENTRY := 273; /* Tavernkeep Smitts */
SET @GOSSIP_MENU_ID := 61032;
SET @NPC_TEXT_ID := 50038;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Keep the door closed, $C. Never know when the Dark Riders will be passing through again.',
        'Keep the door closed, $C. Never know when the Dark Riders will be passing through again.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
