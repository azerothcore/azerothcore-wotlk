INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643910021942173600');

SET @NPC_ENTRY := 288; /* Jitters */
SET @GOSSIP_MENU_ID := 61034;
SET @NPC_TEXT_ID := 50040;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Huh?!?  Oh.  You don\'t look like a Defias thief...or a member of the Night Watch.  Take pity on a poor soul, will ya?',
        'Huh?!?  Oh.  You don\'t look like a Defias thief...or a member of the Night Watch.  Take pity on a poor soul, will ya?', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
