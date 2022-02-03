INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643915090263929400');

SET @NPC_ENTRY := 313; /* Theocritus */
SET @GOSSIP_MENU_ID := 61037;
SET @NPC_TEXT_ID := 50043;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Welcome to the Tower of Azora, young $C.  I am Theocritus.$B$BDo you have business with me?  Or...do I have business with you, perhaps?',
        'Welcome to the Tower of Azora, young $C.  I am Theocritus.$B$BDo you have business with me?  Or...do I have business with you, perhaps?', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
