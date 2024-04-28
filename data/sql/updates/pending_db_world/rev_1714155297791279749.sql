--
-- Web Wrap: disable move, pacified; disable turn
UPDATE `creature_template` SET `unit_flags` = 4 | 131076, `unit_flags2` = 32768 WHERE (`entry` = 16486);

-- 28622: Web Wrap stunned dot
DELETE FROM `spell_script_names` WHERE `spell_id` = 28622;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES(28622, 'spell_web_wrap_damage');

-- 28618: Disable pull effect and periodic trigger event. Keep pacify silence and set duration to 5 seconds
UPDATE `spell_dbc` SET `DurationIndex` = 27, `Effect_0` = 0, `Effect_1` = 0 WHERE `id` = 28618;
