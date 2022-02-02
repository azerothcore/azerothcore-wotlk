INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643838751939051400');

SET @NPC_ENTRY := 265; /* Madame Eva */
SET @GOSSIP_MENU_ID := 61029;
SET @NPC_TEXT_ID := 50035;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'I have sensed your coming for quite some time, $n.  It was written in the pattern of the stars.',
        'I have sensed your coming for quite some time, $n.  It was written in the pattern of the stars.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
