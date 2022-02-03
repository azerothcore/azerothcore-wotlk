INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643911930946198700');

SET @NPC_ENTRY := 289; /* Abercrombie */
SET @GOSSIP_MENU_ID := 61035;
SET @NPC_TEXT_ID := 50041;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Eh?  Greetings, young $C.  You''re a brave one to find your way here with all those wandering creatures about!$B$BWell now that you are here, maybe you can help an old hermit...',
        'Eh?  Greetings, young $C.  You''re a brave one to find your way here with all those wandering creatures about!$B$BWell now that you are here, maybe you can help an old hermit...', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
