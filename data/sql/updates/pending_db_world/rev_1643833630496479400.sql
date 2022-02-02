INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643833630496479400');

SET @NPC_ENTRY := 235; /* Salma Saldean */
SET @GOSSIP_MENU_ID := 61027;
SET @NPC_TEXT_ID := 50033;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1|2 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Welcome to our humble abode! It\'s always nice to see a friendly face. And what strong arms you have. My husband and I are always looking for help around the farm. Now that most the good folk have left, it\'s hard to find an able body to help out.',
        'Welcome to our humble abode! It\'s always nice to see a friendly face. And what strong arms you have. My husband and I are always looking for help around the farm. Now that most the good folk have left, it\'s hard to find an able body to help out.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
