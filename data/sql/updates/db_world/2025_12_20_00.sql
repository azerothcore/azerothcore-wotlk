-- DB update 2025_12_19_04 -> 2025_12_20_00
--
-- Quest: Thrusting Hodir's Spear - 13003
SET @ENTRY := 30275;

UPDATE `creature_template` SET `HoverHeight`=5.2 WHERE `entry`=@ENTRY;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (60603, 56689, 60533, 56690, 60586, 60596, 60864, 60776, 56705, 60587, 55795, 56672);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(60603, 'spell_eject_passenger_wild_wyrm'),
(56689, 'spell_grip'),
(60533, 'spell_grab_on'),
(56690, 'spell_thrust_spear'),
(60586, 'spell_mighty_spear_thrust'),
(60596, 'spell_low_health_trigger'),
(60864, 'spell_jaws_of_death_claw_swipe_pct_damage'),
(60776, 'spell_jaws_of_death_claw_swipe_pct_damage'),
(56705, 'spell_claw_swipe_check'),
(60587, 'spell_fatal_strike'),
(55795, 'spell_gen_feign_death_all_flags'),
(56672, 'spell_player_mount_wyrm');

DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (56690,60586,60776,60881,60864);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(56690, 0x8000),
(60586, 0x8000),
(60776, 0x8000),
(60881, 0x8000),
(60864, 0x8000);

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 30275) AND (`Index` IN (4, 5));
