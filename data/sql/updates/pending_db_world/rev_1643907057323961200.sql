INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643907057323961200');

SET @NPC_ENTRY := 267; /* Clerk Daltry */
SET @GOSSIP_MENU_ID := 61030;
SET @NPC_TEXT_ID := 50036;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Welcome to the town of Darkshire.  Clerk Daltry at your service.  Can I be of some assistance?',
        'Welcome to the town of Darkshire.  Clerk Daltry at your service.  Can I be of some assistance?', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
