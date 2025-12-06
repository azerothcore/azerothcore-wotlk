-- DATA
SET
@NpcEntry:=55009,
@NpcName:="Pick a spec",
@NpcSubname:="AzerothCore Template",
@NpcDisplayID:=24877;

DELETE FROM `creature_template` WHERE `entry` IN (@NpcEntry);
INSERT INTO `creature_template` (`entry`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `ScriptName`) VALUES
(@NpcEntry, @NpcName , @NpcSubname, "Speak", 0, 80, 80, 35, 1, 1, 1.14286, 1, 0, 1, 2, 7, 138936390, 1, 2, "TemplateNPC");

DELETE FROM `creature_template_model` WHERE `CreatureID` = @NpcEntry;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (@NpcEntry, 0, @NpcDisplayID, 1, 1, 0);

DELETE FROM `npc_text` WHERE `ID` = @NpcEntry;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES
(@NpcEntry, 'Here you can select a character template which will gear up, gem up, set talent specialization, and set glyphs for your character instantly.\r\n\r\nSelect your spec:', 'Here you can select a character template which will gear up, gem up, set talent specialization, and set glyphs for your character instantly.\r\n\r\nSelect your spec:');

-- creatture_template_movement
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (@NpcEntry);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(@NpcEntry, 1, 1, 0, 0, 0, 0, NULL);
