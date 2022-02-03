INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643907761874539000');

SET @NPC_ENTRY := 272; /* Chef Grual */
SET @GOSSIP_MENU_ID := 61031;
SET @NPC_TEXT_ID := 50037;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Hello, hello!  Welcome to my kitchen, $g sir : m\'lady;!  This is where all of the Scarlet Raven Tavern\'s finest delicacies are made.  Ah, just smell the wonderful aroma!',
        'Hello, hello!  Welcome to my kitchen, $g sir : m\'lady;!  This is where all of the Scarlet Raven Tavern\'s finest delicacies are made.  Ah, just smell the wonderful aroma!', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
