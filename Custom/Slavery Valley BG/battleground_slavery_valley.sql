-- acore_string
DELETE FROM `acore_string` WHERE `entry` IN (1500,1501,1502,1503,3000,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(1500, 'The Battle for Slavery Valley begins in 2 minutes.'),
(1501, 'The Battle for Slavery Valley begins in 1 minute.'),
(1502, 'The Battle for Slavery Valley begins in 30 seconds. Prepare yourselves!'),
(1503, 'Let the battle for Slavery Valley begin!'),
(3000, 'The %s has taken the %s!'),
(3001, 'The %s has taken the %s!'),
(3002, '$n has defended the %s!'),
(3003, '$n has assaulted the %s! If left unchallenged, they will control it in 1 minute!'),
(3004, 'Alliance'),
(3005, 'Horde'),
(3006, 'Mine'),
(3007, 'Prison'),
(3008, 'Restless Graveyard'),
(3009, 'The Slave Drivers appear in 1 minute.'),
(3010, 'The Slave Drivers appeared!');

-- battleground_template
DELETE FROM `battleground_template` WHERE `id` = 31;
INSERT INTO `battleground_template` (`ID`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`, `StartMaxDist`, `Weight`, `ScriptName`, `Comment`) VALUES (31, 5, 10, 71, 80, 1731, 0, 1730, 3, 120, 1, '', 'Slavery Valley');

-- creature_template
DELETE FROM `creature_template` WHERE `entry` IN (129999, 130000, 130001);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(129999, 0, 0, 0, 0, 0, 11353, 0, 0, 0, 'Developer Snoopzz', NULL, NULL, 5, 1, 1, 0, 35, 1, 1, 1, 1, 0, 0, 1, 2000, 2000, 1, 1, 8, 32768, 2048, 0, 0, 0, 0, 0, 0, 7, 4096, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340),
(130000, 0, 0, 0, 0, 0, 22054, 0, 0, 0, 'Manakos', 'Slave Driver', '', 0, 71, 80, 0, 84, 1, 1, 1.14286, 1.5, 3, 0, 35, 2500, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 50, 50, 1, 0, 0, 1, 208607, 0, 0, '', 12340),
(130001, 0, 0, 0, 0, 0, 22147, 0, 0, 0, 'Garog', 'Slave Driver', '', 0, 71, 80, 0, 83, 1, 1, 1.14286, 1.5, 3, 0, 35, 2500, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 50, 50, 1, 0, 0, 1, 208607, 0, 0, '', 12340);

-- creatture_template_movement
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (129999, 130000, 130001);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(129999, 1, 1, 0, 0, 0, 0, NULL),
(130000, 1, 1, 0, 0, 0, 0, NULL),
(130001, 1, 1, 0, 0, 0, 0, NULL);

-- creature_equip_template
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (130000, 130001) AND `ID`=1;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(130000, 1, 49984, 0, 0, 18019),
(130001, 1, 49984, 0, 0, 18019);

-- creature_text
DELETE FROM `creature_text` WHERE `CreatureID` IN (130000, 130001);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(130000, 0, 0, 'I will take pleasure in gutting you $N!', 12, 0, 100, 0, 0, 0, 0, 0, 'combat Say'),
(130001, 0, 0, 'I will take pleasure in gutting you $N!', 12, 0, 100, 0, 0, 0, 0, 0, 'combat Say');

-- smart_scripts
DELETE FROM `smart_scripts` WHERE entryorguid IN (130000,130001);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(130000, 0, 5, 0, 0, 0, 80, 0, 3000, 9000, 7000, 25000, 0, 11, 61343, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Dominate'),
(130000, 0, 4, 0, 0, 0, 100, 0, 15000, 15000, 25000, 32000, 0, 11, 49807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Whirlwind'),
(130000, 0, 3, 0, 0, 0, 100, 0, 7000, 9000, 17800, 19900, 0, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Sunder Armor'),
(130000, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 13400, 14400, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Mortal Strike'),
(130000, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Say on Aggro'),
(130000, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 61227, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Jump Attack on Aggro'),
(130001, 0, 5, 0, 0, 0, 80, 0, 3000, 9000, 7000, 25000, 0, 11, 61343, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Dominate'),
(130001, 0, 4, 0, 0, 0, 100, 0, 15000, 15000, 25000, 32000, 0, 11, 49807, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Whirlwind'),
(130001, 0, 3, 0, 0, 0, 100, 0, 7000, 9000, 17800, 19900, 0, 11, 50370, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Sunder Armor'),
(130001, 0, 2, 0, 0, 0, 100, 0, 5000, 5000, 13400, 14400, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Mortal Strike'),
(130001, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Say on Aggro'),
(130001, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 11, 61227, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cast Jump Attack on Aggro');


-- game_graveyard
DELETE FROM `game_graveyard` WHERE `ID` IN (1730, 1731, 1740, 1741, 1742, 1743, 1744);
INSERT INTO `game_graveyard` (`ID`, `Map`, `x`, `y`, `z`, `Comment`) VALUES
(1730, 801, 649.323791503906, 971.40625, 41.6282424926758, 'Slavery Valley - Horde Start'),
(1731, 801, -294.471862792969, 1297.80358886719, 86.6985321044922, 'Slavery Valley - Alliance Start'),
(1740, 801, 654.968627929688, 955.319702148438, 43.0611610412598, 'Slavery Valley - Horde Graveyard'),
(1741, 801, -290.855285644531, 1270.06005859375, 87.6719970703125, 'Slavery Valley - Alliance Graveyard'),
(1742, 801, 291.589996337891, 1396.36999511719, 28.2800006866455, 'Slavery Valley - Mine Graveyard'),
(1743, 801, 198.107162475586, 1133.76330566406, -20.7823028564453, 'Slavery Valley - Prison Graveyard'),
(1744, 801, 71.0179977416992, 897.242004394531, 0.425999999046326, 'Slavery Valley - Boss Graveyard');
