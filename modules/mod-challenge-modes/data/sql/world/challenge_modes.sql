-- World DB: Keeper of Challenges (entry 190012) + Shrine of Challenge (GO 254605).
-- Gossip text lives in npc_text so the client never shows ???.
-- ScriptName must stay npc_challenge_modes / gobject_challenge_modes.
-- Spawn the NPC with: .npc add 190012

DELETE FROM `creature` WHERE `id` = 190012 AND `guid` BETWEEN 5900120 AND 5900128;
DELETE FROM `creature_template_locale` WHERE `entry` = 190012;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 190012;
DELETE FROM `creature_template` WHERE `entry` = 190012;
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 190012;
DELETE FROM `gossip_menu` WHERE `MenuID` IN (190012, 190013);
DELETE FROM `npc_text_locale` WHERE `ID` IN (190012, 190013);
DELETE FROM `npc_text` WHERE `ID` IN (190012, 190013);
DELETE FROM `gameobject_template` WHERE `entry` = 254605;

INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`,
    `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `VerifiedBuild`) VALUES
(190012,
    'The Keeper of Challenges weighs your resolve.$B$BYou may accept a challenge only at level 1 (or level 55 if you are a Death Knight). Once accepted, a challenge cannot be turned off.$B$BChoose carefully.',
    '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 12340);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`) VALUES
(190012, 'esES',
    'El Guardian de los Desafios sopesa tu determinacion.$B$BSolo puedes aceptar un desafio en nivel 1 (o 55 si eres Caballero de la Muerte). Una vez aceptado, no se puede desactivar.$B$BElige con cuidado.',
    ''),
(190012, 'esMX',
    'El Guardian de los Desafios sopesa tu determinacion.$B$BSolo puedes aceptar un desafio en nivel 1 (o 55 si eres Caballero de la Muerte). Una vez aceptado, no se puede desactivar.$B$BElige con cuidado.',
    '');

INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`,
    `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `VerifiedBuild`) VALUES
(190013,
    'Welcome, adventurer.$B$BThis is your first step. Choose how this character will play: a challenge, or the classic path.$B$BYou may pick only one, and you cannot change it later.',
    '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 12340);

INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`) VALUES
(190013, 'esES',
    'Bienvenido, aventurero.$B$BEste es tu primer paso. Elige como jugara este personaje: un desafio, o el camino clasico.$B$BSolo puedes escoger uno, y no se puede cambiar despues.',
    ''),
(190013, 'esMX',
    'Bienvenido, aventurero.$B$BEste es tu primer paso. Elige como jugara este personaje: un desafio, o el camino clasico.$B$BSolo puedes escoger uno, y no se puede cambiar despues.',
    '');

INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(190012, 190012),
(190013, 190013);

INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`,
    `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`,
    `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(190012, 0, 0, 'Enable Hardcore', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 1, 0, 'Enable Semi-Hardcore', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 2, 0, 'Enable Self-Crafted', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 3, 0, 'Enable Item Quality', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 4, 0, 'Enable Slow XP', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 5, 0, 'Enable Very Slow XP', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 6, 0, 'Enable Quest XP Only', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340),
(190012, 7, 0, 'Enable Iron Man', 0, 1, 1, 0, 0, 0, 0, '', 0, 12340);

INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
    `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`,
    `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`,
    `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`,
    `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`,
    `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`,
    `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`,
    `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(190012, 0, 0, 0, 0, 0, 'Keeper of Challenges', 'Challenge Modes', 'Speak', 190012, 80, 80, 2, 35, 1, 1, 1.14286,
    1, 1, 20, 0, 0, 1, 2000, 2000, 1, 1, 1, 2, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1,
    0, 2, 'npc_challenge_modes', 12340);

INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(190012, 'esES', 'Guardian de los Desafios', 'Modos desafio', 12340),
(190012, 'esMX', 'Guardian de los Desafios', 'Modos desafio', 12340);

INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`,
    `VerifiedBuild`) VALUES
(190012, 0, 25344, 1, 1, 12340);

INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`,
    `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`,
    `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`,
    `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(254605, 2, 6925, 'Shrine of Challenge', '', '', '', 1.2, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, '', 'gobject_challenge_modes', 0);

-- Starting-area keepers (same spots as the original shrine).
/*INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`,
    `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
    `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`,
    `Comment`) VALUES
(5900120, 190012, 0, 1, 1, 0, -8920.64, -178.191, 80.891, 4.3208, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Elwynn'),
(5900121, 190012, 0, 1, 1, 0, -6135.29, 336.119, 402.238, 5.55195, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Dun Morogh'),
(5900122, 190012, 1, 1, 1, 0, 10415.2, 809.575, 1318.19, 2.37082, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Teldrassil'),
(5900123, 190012, 530, 1, 1, 0, -4147.11, -13667.7, 75.8166, 5.06421, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Azuremyst'),
(5900124, 190012, 1, 1, 1, 0, -658.88, -4311.88, 45.666, 3.06225, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Durotar'),
(5900125, 190012, 0, 1, 1, 0, 1842.91, 1651.33, 95.6206, 1.58336, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Tirisfal'),
(5900126, 190012, 1, 1, 1, 0, -2994.22, -136.321, 77.9491, 1.05411, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Mulgore'),
(5900127, 190012, 530, 1, 1, 0, 10452, -6389.91, 43.7962, 1.84851, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Eversong'),
(5900128, 190012, 609, 1, 1, 0, 2415.84, -5649.91, 376.819, 1.87356, 300, 0, 0, 1, 0, 0, 0, 0, 0, '', 12340, 0, 'Challenge keeper - Ebon Hold');
*/