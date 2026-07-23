-- Issue #16101: Ritual of Refreshment portals (186811/193062) never played a click
-- animation - Data2 (animSpell) was unset. 32783 is the same generic ritual-channel
-- visual the Ritual of Summoning portals (36727/179944) already use for Data2.
UPDATE `gameobject_template` SET `Data2` = 32783 WHERE `entry` IN (186811, 193062);

-- Bind the table-conjure spells to a script that snaps the table's spawn point to the
-- portal's own position/orientation, instead of the caster's live facing at completion time.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (43985, 58661);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(43985, 'spell_mage_conjure_refreshment_table_r1'),
(58661, 'spell_mage_conjure_refreshment_table_r2');
