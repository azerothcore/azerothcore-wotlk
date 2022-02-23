-- DB update 2021_10_28_02 -> 2021_10_28_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_28_02 2021_10_28_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631173309078216738'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631173309078216738');

-- -- Nelson the Nice
SET @NELSON_WPID := 4322400;

INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@NELSON_WPID,1,-7724.21,1676.43,7.05759,0,0,0,0,100,0),
(@NELSON_WPID,2,-7733.06,1688.73,7.71128,0,0,0,0,100,0),
(@NELSON_WPID,3,-7747.69,1695.995,4.364,0,0,0,0,100,0),
(@NELSON_WPID,4,-7762.220,1703.208,2.005,0,0,0,0,100,0),
(@NELSON_WPID,5,-7776.71,1710.39,1.8921,0,0,0,0,100,0),
(@NELSON_WPID,6,-7778.698,1726.611,2.312,0,0,0,0,100,0),
(@NELSON_WPID,7,-7780.469,1744.140,1.427,0,0,0,0,100,0),
(@NELSON_WPID,8,-7782.158,1760.855,0.021,0,0,0,0,100,0),
(@NELSON_WPID,9,-7783.868,1777.784,0.938,0,0,0,0,100,0),
(@NELSON_WPID,10,-7785.598,1794.902,0.469,0,0,0,0,100,0),
(@NELSON_WPID,11,-7787.22,1811.91,1.06598,0,0,0,0,100,0),
(@NELSON_WPID,12,-7790.603,1822.960,1.821,0,0,0,0,100,0),
(@NELSON_WPID,13,-7793.95,1833.97,2.33555,0,0,0,0,100,0),
(@NELSON_WPID,14,-7807.091,1836.017,4.011,0,0,0,0,100,0),
(@NELSON_WPID,15,-7820.3,1838.11,4.71981,0,0,0,0,100,0),
(@NELSON_WPID,16,-7836.246,1835.991,4.563,0,0,0,0,100,0),
(@NELSON_WPID,17,-7851.99,1833.99,2.63924,0,0,0,0,100,0),
(@NELSON_WPID,18,-7865.563,1825.987,3.917,0,0,0,0,100,0),
(@NELSON_WPID,19,-7879.830,1817.575,1.494,0,0,0,0,100,0),
(@NELSON_WPID,20,-7894.841,1808.725,1.520,0,0,0,0,100,0),
(@NELSON_WPID,21,-7909.313,1800.193,2.558,0,0,0,0,100,0),
(@NELSON_WPID,22,-7923.43,1791.55,2.32481,0,0,0,0,100,0),
(@NELSON_WPID,23,-7929.228,1777.654,1.062,0,0,0,0,100,0),
(@NELSON_WPID,24,-7935.053,1763.802,-2.753,0,0,0,0,100,0),
(@NELSON_WPID,25,-7940.930,1749.826,-3.905,0,0,0,0,100,0),
(@NELSON_WPID,26,-7946.756,1735.967,-2.015,0,0,0,0,100,0),
(@NELSON_WPID,27,-7953.225,1720.585,-2.273,0,0,0,0,100,0),
(@NELSON_WPID,28,-7959.83,1705.47,-2.79899,0,0,0,0,100,0),
(@NELSON_WPID,29,-7956.756,1692.529,-3.825,0,0,0,0,100,0),
(@NELSON_WPID,30,-7953.331,1678.105,-3.835,0,0,0,0,100,0),
(@NELSON_WPID,31,-7949.98,1663.59,-3.32333,0,0,0,0,100,0),
(@NELSON_WPID,32,-7941.660,1650.552,-4.973,0,0,0,0,100,0),
(@NELSON_WPID,33,-7932.747,1636.584,-3.027,0,0,0,0,100,0),
(@NELSON_WPID,34,-7923.472,1622.051,-1.661,0,0,0,0,100,0),
(@NELSON_WPID,35,-7914.17,1607.52,-3.11146,0,0,0,0,100,0),
(@NELSON_WPID,36,-7900.821,1598.480,0.627,0,0,0,0,100,0),
(@NELSON_WPID,37,-7887.451,1589.426,2.230,0,0,0,0,100,0),
(@NELSON_WPID,38,-7873.95,1580.5,3.04117,0,0,0,0,100,0),
(@NELSON_WPID,39,-7863.373,1570.436,2.732,0,0,0,0,100,0),
(@NELSON_WPID,40,-7852.92,1560.24,1.5244,0,0,0,0,100,0),
(@NELSON_WPID,41,-7838.393,1555.745,-1.005,0,0,0,0,100,0),
(@NELSON_WPID,42,-7824.891,1551.567,-1.685,0,0,0,0,100,0),
(@NELSON_WPID,43,-7811.29,1547.2,0.534844,0,0,0,0,100,0),
(@NELSON_WPID,44,-7800.038,1536.851,1.423,0,0,0,0,100,0),
(@NELSON_WPID,45,-7788.91,1526.39,1.35146,0,0,0,0,100,0),
(@NELSON_WPID,46,-7776.083,1524.080,0.854,0,0,0,0,100,0),
(@NELSON_WPID,47,-7763.28,1521.68,0.441107,0,0,0,0,100,0),
(@NELSON_WPID,48,-7747.104,1522.547,-0.491,0,0,0,0,100,0),
(@NELSON_WPID,49,-7731,1523.34,-2.33413,0,0,0,0,100,0),
(@NELSON_WPID,50,-7715.639,1526.94,0.265,0,0,0,0,100,0),
(@NELSON_WPID,51,-7700.29,1530.48,3.78541,0,0,0,0,100,0),
(@NELSON_WPID,52,-7686.12,1543.72,5.65941,0,0,0,0,100,0),
(@NELSON_WPID,53,-7678.839,1557.686,5.651,0,0,0,0,100,0),
(@NELSON_WPID,54,-7671.578,1571.616,3.642,0,0,0,0,100,0),
(@NELSON_WPID,55,-7664.272,1585.63,1.946,0,0,0,0,100,0),
(@NELSON_WPID,56,-7656.79,1599.46,3.04037,0,0,0,0,100,0),
(@NELSON_WPID,57,-7667.404,1611.825,3.916,0,0,0,0,100,0),
(@NELSON_WPID,58,-7677.943,1624.102,5.435,0,0,0,0,100,0),
(@NELSON_WPID,59,-7688.485,1636.382,5.052,0,0,0,0,100,0),
(@NELSON_WPID,60,-7699.277,1648.954,7.374,0,0,0,0,100,0),
(@NELSON_WPID,61,-7710.01,1661.66,6.96938,0,0,0,0,100,0);

SET @NELSON_ENTRY := 14536;
SET @NELSON_GUID := 43224;

-- Set MovementType and path_id
UPDATE `creature` SET `MovementType` = 2 WHERE (`id` = @NELSON_ENTRY) AND (`guid` = @NELSON_GUID);
UPDATE `creature_addon` SET `path_id` = @NELSON_WPID WHERE (`guid` = @NELSON_GUID);

-- Allow player interaction, remove the quest item from the humanoid form, set Movement Type and change the Script Name
UPDATE `creature_template`
SET `npcflag` = 1,
    `unit_flags2` = 18432,
    `MovementType` = 2,
    `lootid` = 0,
    `ScriptName` = 'npc_nelson'
WHERE (`entry` = @NELSON_ENTRY);

-- Delete the unused loot_template
DELETE FROM `creature_loot_template` WHERE `Entry` = @NELSON_ENTRY;

-- Add creature text for gossip option
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES
(@NELSON_ENTRY, 0, 0, "A gnome? How pathetic. Face me, demon!", 0, 0, 0, 0, 0, 0, 9753, "Nelson the Nice");

-- Correct Nelson evil entry(Solenor the Slayer) speed_walk
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14530);

-- Reduce Creeping Doom speed and increase the damage
UPDATE `creature_template`
SET `speed_run` = 0.33,
    `speed_walk` = 0.33,
    `DamageModifier` = 2.25
WHERE `entry` = 14761;

-- Soul Flame spell_dbc addition
-- the change is needed because otherwise EnterEvadeMode() removes the aura from the creature and a C++ workaround is needed
INSERT IGNORE INTO spell_dbc (`ID`,`Category`,`DispelType`,`Mechanic`,`Attributes`,`AttributesEx`,`AttributesEx2`,`AttributesEx3`,`AttributesEx4`,`AttributesEx5`,`AttributesEx6`,`AttributesEx7`,`ShapeshiftMask`,`unk_320_2`,`ShapeshiftExclude`,`unk_320_3`,`Targets`,`TargetCreatureType`,`RequiresSpellFocus`,`FacingCasterFlags`,`CasterAuraState`,`TargetAuraState`,`ExcludeCasterAuraState`,`ExcludeTargetAuraState`,`CasterAuraSpell`,`TargetAuraSpell`,`ExcludeCasterAuraSpell`,`ExcludeTargetAuraSpell`,`CastingTimeIndex`,`RecoveryTime`,`CategoryRecoveryTime`,`InterruptFlags`,`AuraInterruptFlags`,`ChannelInterruptFlags`,`ProcTypeMask`,`ProcChance`,`ProcCharges`,`MaxLevel`,`BaseLevel`,`SpellLevel`,`DurationIndex`,`PowerType`,`ManaCost`,`ManaCostPerLevel`,`ManaPerSecond`,`ManaPerSecondPerLevel`,`RangeIndex`,`Speed`,`ModalNextSpell`,`CumulativeAura`,`Totem_1`,`Totem_2`,`Reagent_1`,`Reagent_2`,`Reagent_3`,`Reagent_4`,`Reagent_5`,`Reagent_6`,`Reagent_7`,`Reagent_8`,`ReagentCount_1`,`ReagentCount_2`,`ReagentCount_3`,`ReagentCount_4`,`ReagentCount_5`,`ReagentCount_6`,`ReagentCount_7`,`ReagentCount_8`,`EquippedItemClass`,`EquippedItemSubclass`,`EquippedItemInvTypes`,`Effect_1`,`Effect_2`,`Effect_3`,`EffectDieSides_1`,`EffectDieSides_2`,`EffectDieSides_3`,`EffectRealPointsPerLevel_1`,`EffectRealPointsPerLevel_2`,`EffectRealPointsPerLevel_3`,`EffectBasePoints_1`,`EffectBasePoints_2`,`EffectBasePoints_3`,`EffectMechanic_1`,`EffectMechanic_2`,`EffectMechanic_3`,`ImplicitTargetA_1`,`ImplicitTargetA_2`,`ImplicitTargetA_3`,`ImplicitTargetB_1`,`ImplicitTargetB_2`,`ImplicitTargetB_3`,`EffectRadiusIndex_1`,`EffectRadiusIndex_2`,`EffectRadiusIndex_3`,`EffectAura_1`,`EffectAura_2`,`EffectAura_3`,`EffectAuraPeriod_1`,`EffectAuraPeriod_2`,`EffectAuraPeriod_3`,`EffectMultipleValue_1`,`EffectMultipleValue_2`,`EffectMultipleValue_3`,`EffectChainTargets_1`,`EffectChainTargets_2`,`EffectChainTargets_3`,`EffectItemType_1`,`EffectItemType_2`,`EffectItemType_3`,`EffectMiscValue_1`,`EffectMiscValue_2`,`EffectMiscValue_3`,`EffectMiscValueB_1`,`EffectMiscValueB_2`,`EffectMiscValueB_3`,`EffectTriggerSpell_1`,`EffectTriggerSpell_2`,`EffectTriggerSpell_3`,`EffectPointsPerCombo_1`,`EffectPointsPerCombo_2`,`EffectPointsPerCombo_3`,`EffectSpellClassMaskA_1`,`EffectSpellClassMaskA_2`,`EffectSpellClassMaskA_3`,`EffectSpellClassMaskB_1`,`EffectSpellClassMaskB_2`,`EffectSpellClassMaskB_3`,`EffectSpellClassMaskC_1`,`EffectSpellClassMaskC_2`,`EffectSpellClassMaskC_3`,`SpellVisualID_1`,`SpellVisualID_2`,`SpellIconID`,`ActiveIconID`,`SpellPriority`,`Name_Lang_enUS`,`Name_Lang_enGB`,`Name_Lang_koKR`,`Name_Lang_frFR`,`Name_Lang_deDE`,`Name_Lang_enCN`,`Name_Lang_zhCN`,`Name_Lang_enTW`,`Name_Lang_zhTW`,`Name_Lang_esES`,`Name_Lang_esMX`,`Name_Lang_ruRU`,`Name_Lang_ptPT`,`Name_Lang_ptBR`,`Name_Lang_itIT`,`Name_Lang_Unk`,`Name_Lang_Mask`,`NameSubtext_Lang_enUS`,`NameSubtext_Lang_enGB`,`NameSubtext_Lang_koKR`,`NameSubtext_Lang_frFR`,`NameSubtext_Lang_deDE`,`NameSubtext_Lang_enCN`,`NameSubtext_Lang_zhCN`,`NameSubtext_Lang_enTW`,`NameSubtext_Lang_zhTW`,`NameSubtext_Lang_esES`,`NameSubtext_Lang_esMX`,`NameSubtext_Lang_ruRU`,`NameSubtext_Lang_ptPT`,`NameSubtext_Lang_ptBR`,`NameSubtext_Lang_itIT`,`NameSubtext_Lang_Unk`,`NameSubtext_Lang_Mask`,`Description_Lang_enUS`,`Description_Lang_enGB`,`Description_Lang_koKR`,`Description_Lang_frFR`,`Description_Lang_deDE`,`Description_Lang_enCN`,`Description_Lang_zhCN`,`Description_Lang_enTW`,`Description_Lang_zhTW`,`Description_Lang_esES`,`Description_Lang_esMX`,`Description_Lang_ruRU`,`Description_Lang_ptPT`,`Description_Lang_ptBR`,`Description_Lang_itIT`,`Description_Lang_Unk`,`Description_Lang_Mask`,`AuraDescription_Lang_enUS`,`AuraDescription_Lang_enGB`,`AuraDescription_Lang_koKR`,`AuraDescription_Lang_frFR`,`AuraDescription_Lang_deDE`,`AuraDescription_Lang_enCN`,`AuraDescription_Lang_zhCN`,`AuraDescription_Lang_enTW`,`AuraDescription_Lang_zhTW`,`AuraDescription_Lang_esES`,`AuraDescription_Lang_esMX`,`AuraDescription_Lang_ruRU`,`AuraDescription_Lang_ptPT`,`AuraDescription_Lang_ptBR`,`AuraDescription_Lang_itIT`,`AuraDescription_Lang_Unk`,`AuraDescription_Lang_Mask`,`ManaCostPct`,`StartRecoveryCategory`,`StartRecoveryTime`,`MaxTargetLevel`,`SpellClassSet`,`SpellClassMask_1`,`SpellClassMask_2`,`SpellClassMask_3`,`MaxTargets`,`DefenseType`,`PreventionType`,`StanceBarOrder`,`EffectChainAmplitude_1`,`EffectChainAmplitude_2`,`EffectChainAmplitude_3`,`MinFactionID`,`MinReputation`,`RequiredAuraVision`,`RequiredTotemCategoryID_1`,`RequiredTotemCategoryID_2`,`RequiredAreasID`,`SchoolMask`,`RuneCostID`,`SpellMissileID`,`PowerDisplayID`,`Field227`,`Field228`,`Field229`,`SpellDescriptionVariableID`,`SpellDifficultyID`) VALUES
(23272,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,101,0,0,0,0,21,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,6,6,46,91,1,0,0,0,0,554,99,0,0,0,0,1,1,0,0,0,0,0,0,0,15,101,0,0,0,0,0,0,0,0,0,0,0,0,0,0,127,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6803,0,937,0,0,'Soul Flame','','','','','','','','','','','','','','','',16712190,'','','','','','','','','','','','','','','','',16712172,'','','','','','','','','','','','','','','','',16712188,'','','','','','','','','','','','','','','','',16712188,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0);
UPDATE `spell_dbc` SET `ImplicitTargetA_3` = 1 WHERE ID = 23272;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_28_03' WHERE sql_rev = '1631173309078216738';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
