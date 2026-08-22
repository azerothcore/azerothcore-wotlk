-- The refreshment portal never played an animation when clicked: Data2 (animSpell) was 0 and the
-- core fallback casts with TRIGGERED_CAST_DIRECTLY, which skips the visual. 32783 is the same
-- generic ritual channel the summoning portals (36727 / 179944) already use.
UPDATE `gameobject_template` SET `Data2` = 32783 WHERE `entry` IN (186811, 193062);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (43985, 58661);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43985, 'spell_mage_conjure_refreshment_table_r1'),
(58661, 'spell_mage_conjure_refreshment_table_r2');
