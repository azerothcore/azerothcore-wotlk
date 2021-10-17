-- DB update 2019_01_12_01 -> 2019_01_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_12_01 2019_01_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546089286503990302'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546089286503990302');

-- locales_achievement_reward
INSERT INTO `achievement_reward_locale` (`ID`, `Locale`, `Subject`, `Text`)
  (SELECT `entry`, "koKR", `subject_loc1`, `text_loc1` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc1) > 0 OR LENGTH(text_loc1) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "frFR", `subject_loc2`, `text_loc2` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc2) > 0 OR LENGTH(text_loc2) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "deDE", `subject_loc3`, `text_loc3` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc3) > 0 OR LENGTH(text_loc3) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "zhCN", `subject_loc4`, `text_loc4` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc4) > 0 OR LENGTH(text_loc4) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "zhTW", `subject_loc5`, `text_loc5` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc5) > 0 OR LENGTH(text_loc5) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "esES", `subject_loc6`, `text_loc6` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc6) > 0 OR LENGTH(text_loc6) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "esMX", `subject_loc7`, `text_loc7` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc7) > 0 OR LENGTH(text_loc7) > 0);

INSERT INTO `achievement_reward_locale` (`ID`, `locale`, `Subject`, `Text`)
  (SELECT `entry`, "ruRU", `subject_loc8`, `text_loc8` FROM `locales_achievement_reward` WHERE LENGTH(subject_loc8) > 0 OR LENGTH(text_loc8) > 0);


-- locales_broadcast_text
INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "koKR", `MaleText_loc1`, `FemaleText_loc1`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc1) > 0 OR LENGTH(FemaleText_loc1) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "frFR", `MaleText_loc2`, `FemaleText_loc2`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc2) > 0 OR LENGTH(FemaleText_loc2) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "deDE", `MaleText_loc3`, `FemaleText_loc3`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc3) > 0 OR LENGTH(FemaleText_loc3) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "zhCN", `MaleText_loc4`, `FemaleText_loc4`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc4) > 0 OR LENGTH(FemaleText_loc4) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "zhTW", `MaleText_loc5`, `FemaleText_loc5`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc5) > 0 OR LENGTH(FemaleText_loc5) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "esES", `MaleText_loc6`, `FemaleText_loc6`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc6) > 0 OR LENGTH(FemaleText_loc6) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "esMX", `MaleText_loc7`, `FemaleText_loc7`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc7) > 0 OR LENGTH(FemaleText_loc7) > 0);

INSERT INTO `broadcast_text_locale` (`ID`, `locale`, `MaleText`, `FemaleText`, `VerifiedBuild`)
  (SELECT `Id`, "ruRU", `MaleText_loc8`, `FemaleText_loc8`, `VerifiedBuild` FROM `locales_broadcast_text` WHERE LENGTH(MaleText_loc8) > 0 OR LENGTH(FemaleText_loc8) > 0);


-- Creature_text_locale
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "koKR", `text_loc1` FROM `locales_creature_text` WHERE LENGTH(text_loc1) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "frFR", `text_loc2` FROM `locales_creature_text` WHERE LENGTH(text_loc2) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "deDE", `text_loc3` FROM `locales_creature_text` WHERE LENGTH(text_loc3) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "zhCN", `text_loc4` FROM `locales_creature_text` WHERE LENGTH(text_loc4) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "zhTW", `text_loc5` FROM `locales_creature_text` WHERE LENGTH(text_loc5) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "esES", `text_loc6` FROM `locales_creature_text` WHERE LENGTH(text_loc6) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "esMX", `text_loc7` FROM `locales_creature_text` WHERE LENGTH(text_loc7) > 0);

INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`)
  (SELECT `entry`, `groupid`, `id`, "ruRU", `text_loc8` FROM `locales_creature_text` WHERE LENGTH(text_loc8) > 0);


-- Gossip_menu_option_locale
INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "koKR", `option_text_loc1`, `box_text_loc1` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc1) > 0 || LENGTH(box_text_loc1) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "frFR", `option_text_loc2`, `box_text_loc2` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc2) > 0 || LENGTH(box_text_loc2) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "deDE", `option_text_loc3`, `box_text_loc3` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc3) > 0 || LENGTH(box_text_loc3) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "zhCN", `option_text_loc4`, `box_text_loc4` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc4) > 0 || LENGTH(box_text_loc4) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "zhTW", `option_text_loc5`, `box_text_loc5` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc5) > 0 || LENGTH(box_text_loc5) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "esES", `option_text_loc6`, `box_text_loc6` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc6) > 0 || LENGTH(box_text_loc6) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "esMX", `option_text_loc7`, `box_text_loc7` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc7) > 0 || LENGTH(box_text_loc7) > 0);

INSERT INTO `gossip_menu_option_locale` (`MenuID`, `OptionID`, `Locale`, `OptionText`, `BoxText`)
  (SELECT `menu_id`, `id`, "ruRU", `option_text_loc8`, `box_text_loc8` FROM `locales_gossip_menu_option` WHERE LENGTH(option_text_loc8) > 0 || LENGTH(box_text_loc8) > 0);


-- Item_template_locale
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "koKR", `name_loc1`, `description_loc1`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc1) > 0 OR LENGTH(description_loc1) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "frFR", `name_loc2`, `description_loc2`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc2) > 0 OR LENGTH(description_loc2) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "deDE", `name_loc3`, `description_loc3`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc3) > 0 OR LENGTH(description_loc3) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "zhCN", `name_loc4`, `description_loc4`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc4) > 0 OR LENGTH(description_loc4) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "zhTW", `name_loc5`, `description_loc5`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc5) > 0 OR LENGTH(description_loc5) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "esES", `name_loc6`, `description_loc6`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc6) > 0 OR LENGTH(description_loc6) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "esMX", `name_loc7`, `description_loc7`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc7) > 0 OR LENGTH(description_loc7) > 0);

INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`)
  (SELECT `entry`, "ruRU", `name_loc8`, `description_loc8`, `VerifiedBuild` FROM `locales_item` WHERE LENGTH(name_loc8) > 0 OR LENGTH(description_loc8) > 0);


-- Npc_text_locale
INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "koKR", `Text0_0_loc1`, `Text0_1_loc1`, `Text1_0_loc1`, `Text1_1_loc1`, `Text2_0_loc1`, `Text2_1_loc1`, `Text3_0_loc1`, `Text3_1_loc1`, `Text4_0_loc1`, `Text4_1_loc1`, `Text5_0_loc1`, `Text5_1_loc1`, `Text6_0_loc1`, `Text6_1_loc1`, `Text7_0_loc1`, `Text7_1_loc1`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc1) > 0 && LENGTH(Text0_1_loc1) > 0 && LENGTH(Text1_0_loc1) > 0 && LENGTH(Text1_1_loc1) > 0 && LENGTH(Text2_0_loc1) > 0 && LENGTH(Text2_1_loc1) > 0 && LENGTH(Text3_0_loc1) > 0 && LENGTH(Text3_1_loc1) > 0 && LENGTH(Text4_0_loc1) > 0 && LENGTH(Text4_1_loc1) > 0 && LENGTH(Text5_0_loc1) > 0 && LENGTH(Text5_1_loc1) > 0 && LENGTH(Text6_0_loc1) > 0 && LENGTH(Text6_1_loc1) > 0 && LENGTH(Text7_0_loc1) > 0 && LENGTH(Text7_1_loc1) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "frFR", `Text0_0_loc2`, `Text0_1_loc2`, `Text1_0_loc2`, `Text1_1_loc2`, `Text2_0_loc2`, `Text2_1_loc2`, `Text3_0_loc2`, `Text3_1_loc2`, `Text4_0_loc2`, `Text4_1_loc2`, `Text5_0_loc2`, `Text5_1_loc2`, `Text6_0_loc2`, `Text6_1_loc2`, `Text7_0_loc2`, `Text7_1_loc2`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc2) > 0 && LENGTH(Text0_1_loc2) > 0 && LENGTH(Text1_0_loc2) > 0 && LENGTH(Text1_1_loc2) > 0 && LENGTH(Text2_0_loc2) > 0 && LENGTH(Text2_1_loc2) > 0 && LENGTH(Text3_0_loc2) > 0 && LENGTH(Text3_1_loc2) > 0 && LENGTH(Text4_0_loc2) > 0 && LENGTH(Text4_1_loc2) > 0 && LENGTH(Text5_0_loc2) > 0 && LENGTH(Text5_1_loc2) > 0 && LENGTH(Text6_0_loc2) > 0 && LENGTH(Text6_1_loc2) > 0 && LENGTH(Text7_0_loc2) > 0 && LENGTH(Text7_1_loc2) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "deDE", `Text0_0_loc3`, `Text0_1_loc3`, `Text1_0_loc3`, `Text1_1_loc3`, `Text2_0_loc3`, `Text2_1_loc3`, `Text3_0_loc3`, `Text3_1_loc3`, `Text4_0_loc3`, `Text4_1_loc3`, `Text5_0_loc3`, `Text5_1_loc3`, `Text6_0_loc3`, `Text6_1_loc3`, `Text7_0_loc3`, `Text7_1_loc3`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc3) > 0 && LENGTH(Text0_1_loc3) > 0 && LENGTH(Text1_0_loc3) > 0 && LENGTH(Text1_1_loc3) > 0 && LENGTH(Text2_0_loc3) > 0 && LENGTH(Text2_1_loc3) > 0 && LENGTH(Text3_0_loc3) > 0 && LENGTH(Text3_1_loc3) > 0 && LENGTH(Text4_0_loc3) > 0 && LENGTH(Text4_1_loc3) > 0 && LENGTH(Text5_0_loc3) > 0 && LENGTH(Text5_1_loc3) > 0 && LENGTH(Text6_0_loc3) > 0 && LENGTH(Text6_1_loc3) > 0 && LENGTH(Text7_0_loc3) > 0 && LENGTH(Text7_1_loc3) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "zhCN", `Text0_0_loc4`, `Text0_1_loc4`, `Text1_0_loc4`, `Text1_1_loc4`, `Text2_0_loc4`, `Text2_1_loc4`, `Text3_0_loc4`, `Text3_1_loc4`, `Text4_0_loc4`, `Text4_1_loc4`, `Text5_0_loc4`, `Text5_1_loc4`, `Text6_0_loc4`, `Text6_1_loc4`, `Text7_0_loc4`, `Text7_1_loc4`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc4) > 0 && LENGTH(Text0_1_loc4) > 0 && LENGTH(Text1_0_loc4) > 0 && LENGTH(Text1_1_loc4) > 0 && LENGTH(Text2_0_loc4) > 0 && LENGTH(Text2_1_loc4) > 0 && LENGTH(Text3_0_loc4) > 0 && LENGTH(Text3_1_loc4) > 0 && LENGTH(Text4_0_loc4) > 0 && LENGTH(Text4_1_loc4) > 0 && LENGTH(Text5_0_loc4) > 0 && LENGTH(Text5_1_loc4) > 0 && LENGTH(Text6_0_loc4) > 0 && LENGTH(Text6_1_loc4) > 0 && LENGTH(Text7_0_loc4) > 0 && LENGTH(Text7_1_loc4) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "zhTW", `Text0_0_loc5`, `Text0_1_loc5`, `Text1_0_loc5`, `Text1_1_loc5`, `Text2_0_loc5`, `Text2_1_loc5`, `Text3_0_loc5`, `Text3_1_loc5`, `Text4_0_loc5`, `Text4_1_loc5`, `Text5_0_loc5`, `Text5_1_loc5`, `Text6_0_loc5`, `Text6_1_loc5`, `Text7_0_loc5`, `Text7_1_loc5`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc5) > 0 && LENGTH(Text0_1_loc5) > 0 && LENGTH(Text1_0_loc5) > 0 && LENGTH(Text1_1_loc5) > 0 && LENGTH(Text2_0_loc5) > 0 && LENGTH(Text2_1_loc5) > 0 && LENGTH(Text3_0_loc5) > 0 && LENGTH(Text3_1_loc5) > 0 && LENGTH(Text4_0_loc5) > 0 && LENGTH(Text4_1_loc5) > 0 && LENGTH(Text5_0_loc5) > 0 && LENGTH(Text5_1_loc5) > 0 && LENGTH(Text6_0_loc5) > 0 && LENGTH(Text6_1_loc5) > 0 && LENGTH(Text7_0_loc5) > 0 && LENGTH(Text7_1_loc5) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "esES", `Text0_0_loc6`, `Text0_1_loc6`, `Text1_0_loc6`, `Text1_1_loc6`, `Text2_0_loc6`, `Text2_1_loc6`, `Text3_0_loc6`, `Text3_1_loc6`, `Text4_0_loc6`, `Text4_1_loc6`, `Text5_0_loc6`, `Text5_1_loc6`, `Text6_0_loc6`, `Text6_1_loc6`, `Text7_0_loc6`, `Text7_1_loc6`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc6) > 0 && LENGTH(Text0_1_loc6) > 0 && LENGTH(Text1_0_loc6) > 0 && LENGTH(Text1_1_loc6) > 0 && LENGTH(Text2_0_loc6) > 0 && LENGTH(Text2_1_loc6) > 0 && LENGTH(Text3_0_loc6) > 0 && LENGTH(Text3_1_loc6) > 0 && LENGTH(Text4_0_loc6) > 0 && LENGTH(Text4_1_loc6) > 0 && LENGTH(Text5_0_loc6) > 0 && LENGTH(Text5_1_loc6) > 0 && LENGTH(Text6_0_loc6) > 0 && LENGTH(Text6_1_loc6) > 0 && LENGTH(Text7_0_loc6) > 0 && LENGTH(Text7_1_loc6) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "esMX", `Text0_0_loc7`, `Text0_1_loc7`, `Text1_0_loc7`, `Text1_1_loc7`, `Text2_0_loc7`, `Text2_1_loc7`, `Text3_0_loc7`, `Text3_1_loc7`, `Text4_0_loc7`, `Text4_1_loc7`, `Text5_0_loc7`, `Text5_1_loc7`, `Text6_0_loc7`, `Text6_1_loc7`, `Text7_0_loc7`, `Text7_1_loc7`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc7) > 0 && LENGTH(Text0_1_loc7) > 0 && LENGTH(Text1_0_loc7) > 0 && LENGTH(Text1_1_loc7) > 0 && LENGTH(Text2_0_loc7) > 0 && LENGTH(Text2_1_loc7) > 0 && LENGTH(Text3_0_loc7) > 0 && LENGTH(Text3_1_loc7) > 0 && LENGTH(Text4_0_loc7) > 0 && LENGTH(Text4_1_loc7) > 0 && LENGTH(Text5_0_loc7) > 0 && LENGTH(Text5_1_loc7) > 0 && LENGTH(Text6_0_loc7) > 0 && LENGTH(Text6_1_loc7) > 0 && LENGTH(Text7_0_loc7) > 0 && LENGTH(Text7_1_loc7) > 0);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`)
  (SELECT `ID`, "ruRU", `Text0_0_loc8`, `Text0_1_loc8`, `Text1_0_loc8`, `Text1_1_loc8`, `Text2_0_loc8`, `Text2_1_loc8`, `Text3_0_loc8`, `Text3_1_loc8`, `Text4_0_loc8`, `Text4_1_loc8`, `Text5_0_loc8`, `Text5_1_loc8`, `Text6_0_loc8`, `Text6_1_loc8`, `Text7_0_loc8`, `Text7_1_loc8`
   FROM `locales_npc_text`
   WHERE LENGTH(Text0_0_loc8) > 0 && LENGTH(Text0_1_loc8) > 0 && LENGTH(Text1_0_loc8) > 0 && LENGTH(Text1_1_loc8) > 0 && LENGTH(Text2_0_loc8) > 0 && LENGTH(Text2_1_loc8) > 0 && LENGTH(Text3_0_loc8) > 0 && LENGTH(Text3_1_loc8) > 0 && LENGTH(Text4_0_loc8) > 0 && LENGTH(Text4_1_loc8) > 0 && LENGTH(Text5_0_loc8) > 0 && LENGTH(Text5_1_loc8) > 0 && LENGTH(Text6_0_loc8) > 0 && LENGTH(Text6_1_loc8) > 0 && LENGTH(Text7_0_loc8) > 0 && LENGTH(Text7_1_loc8) > 0);


-- Page_text_locale
INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "koKR", `text_loc1` FROM `locales_page_text` WHERE LENGTH(text_loc1) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "frFR", `text_loc2` FROM `locales_page_text` WHERE LENGTH(text_loc2) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "deDE", `text_loc3` FROM `locales_page_text` WHERE LENGTH(text_loc3) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "zhCN", `text_loc4` FROM `locales_page_text` WHERE LENGTH(text_loc4) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "zhTW", `text_loc5` FROM `locales_page_text` WHERE LENGTH(text_loc5) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "esES", `text_loc6` FROM `locales_page_text` WHERE LENGTH(text_loc6) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "esMX", `text_loc7` FROM `locales_page_text` WHERE LENGTH(text_loc7) > 0);

INSERT INTO `page_text_locale` (`ID`, `locale`, `Text`)
  (SELECT `entry`, "ruRU", `text_loc8` FROM `locales_page_text` WHERE LENGTH(text_loc8) > 0);


-- Points_of_interest_locale
INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "koKR", `icon_name_loc1` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc1) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "frFR", `icon_name_loc2` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc2) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "deDE", `icon_name_loc3` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc3) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "zhCN", `icon_name_loc4` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc4) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "zhTW", `icon_name_loc5` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc5) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "esES", `icon_name_loc6` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc6) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "esMX", `icon_name_loc7` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc7) > 0);

INSERT INTO `points_of_interest_locale` (`ID`, `locale`, `Name`)
  (SELECT `entry`, "ruRU", `icon_name_loc8` FROM `locales_points_of_interest` WHERE LENGTH(icon_name_loc8) > 0);

-- Quest_template_locale
INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "koKR", `Title_loc1`, `Details_loc1`, `Objectives_loc1`, `OfferRewardText_loc1`, `RequestItemsText_loc1`, `EndText_loc1`, `CompletedText_loc1`, `ObjectiveText1_loc1`, `ObjectiveText2_loc1`, `ObjectiveText3_loc1`, `ObjectiveText4_loc1`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc1) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "frFR", `Title_loc2`, `Details_loc2`, `Objectives_loc2`, `OfferRewardText_loc2`, `RequestItemsText_loc2`, `EndText_loc2`, `CompletedText_loc2`, `ObjectiveText1_loc2`, `ObjectiveText2_loc2`, `ObjectiveText3_loc2`, `ObjectiveText4_loc2`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc2) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "deDE", `Title_loc3`, `Details_loc3`, `Objectives_loc3`, `OfferRewardText_loc3`, `RequestItemsText_loc3`, `EndText_loc3`, `CompletedText_loc3`, `ObjectiveText1_loc3`, `ObjectiveText2_loc3`, `ObjectiveText3_loc3`, `ObjectiveText4_loc3`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc3) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "zhCN", `Title_loc4`, `Details_loc4`, `Objectives_loc4`, `OfferRewardText_loc4`, `RequestItemsText_loc4`, `EndText_loc4`, `CompletedText_loc4`, `ObjectiveText1_loc4`, `ObjectiveText2_loc4`, `ObjectiveText3_loc4`, `ObjectiveText4_loc4`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc4) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "zhTW", `Title_loc5`, `Details_loc5`, `Objectives_loc5`, `OfferRewardText_loc5`, `RequestItemsText_loc5`, `EndText_loc5`, `CompletedText_loc5`, `ObjectiveText1_loc5`, `ObjectiveText2_loc5`, `ObjectiveText3_loc5`, `ObjectiveText4_loc5`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc5) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "esES", `Title_loc6`, `Details_loc6`, `Objectives_loc6`, `OfferRewardText_loc6`, `RequestItemsText_loc6`, `EndText_loc6`, `CompletedText_loc6`, `ObjectiveText1_loc6`, `ObjectiveText2_loc6`, `ObjectiveText3_loc6`, `ObjectiveText4_loc6`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc6) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "esMX", `Title_loc7`, `Details_loc7`, `Objectives_loc7`, `OfferRewardText_loc7`, `RequestItemsText_loc7`, `EndText_loc7`, `CompletedText_loc7`, `ObjectiveText1_loc7`, `ObjectiveText2_loc7`, `ObjectiveText3_loc7`, `ObjectiveText4_loc7`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc7) > 0);

INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
  (SELECT `Id`, "ruRU", `Title_loc8`, `Details_loc8`, `Objectives_loc8`, `OfferRewardText_loc8`, `RequestItemsText_loc8`, `EndText_loc8`, `CompletedText_loc8`, `ObjectiveText1_loc8`, `ObjectiveText2_loc8`, `ObjectiveText3_loc8`, `ObjectiveText4_loc8`, `VerifiedBuild`
   FROM `locales_quest` WHERE LENGTH(Title_loc8) > 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
