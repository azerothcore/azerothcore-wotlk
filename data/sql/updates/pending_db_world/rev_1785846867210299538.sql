-- Ritual of Refreshment portals (186811/193062) had no click animation, Data2 was unset.
-- The table also spawned wherever the caster happened to be facing, so the conjure spells now
-- go through a script that places it on the portal's own position and orientation.
UPDATE `gameobject_template` SET `Data2` = 32783 WHERE `entry` IN (186811, 193062);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (43985, 58661);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43985, 'spell_mage_conjure_refreshment_table_r1'),
(58661, 'spell_mage_conjure_refreshment_table_r2');
