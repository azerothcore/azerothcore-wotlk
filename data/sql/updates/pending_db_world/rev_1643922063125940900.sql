INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643922063125940900');

SET @NPC_ENTRY := 342; /* Martie Jainrose */
SET @GOSSIP_MENU_ID := 61039;
SET @NPC_TEXT_ID := 50045;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Hail, $n. Welcome to my humble garden. The weather has been perfect lately. Let us hope it holds steady for a ripe harvest.',
        'Hail, $n. Welcome to my humble garden. The weather has been perfect lately. Let us hope it holds steady for a ripe harvest.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
