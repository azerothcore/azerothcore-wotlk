INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643914580453955500');

SET @NPC_ENTRY := 294; /* Marshal Haggard */
SET @GOSSIP_MENU_ID := 61036;
SET @NPC_TEXT_ID := 50042;

UPDATE `creature_template` SET `gossip_menu_id` = @GOSSIP_MENU_ID WHERE `entry` = @NPC_ENTRY;
UPDATE `creature_template` SET `npcflag` = `npcflag`|1 WHERE `entry` = @NPC_ENTRY;
DELETE FROM `npc_text` WHERE `ID` = @NPC_TEXT_ID;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`)
VALUES (@NPC_TEXT_ID,
        'Hail, traveler.  My eyesight may be poor but I can sense the footsteps of a $c from a mile away.  For years I defended Stormwind with pride but once my eyes failed me, I was forced to retire.',
        'Hail, traveler.  My eyesight may be poor but I can sense the footsteps of a $c from a mile away.  For years I defended Stormwind with pride but once my eyes failed me, I was forced to retire.', 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = @GOSSIP_MENU_ID AND `TextID` = @NPC_TEXT_ID;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(@GOSSIP_MENU_ID, @NPC_TEXT_ID);
