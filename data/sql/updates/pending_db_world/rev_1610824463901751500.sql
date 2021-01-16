INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610824463901751500');

DELETE FROM `spell_script_names` WHERE `ScriptName`="spell_gen_charmed_unit_spell_cooldown";
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37727, "spell_gen_charmed_unit_spell_cooldown"),
(37851, "spell_gen_charmed_unit_spell_cooldown"),
(37917, "spell_gen_charmed_unit_spell_cooldown"),
(37918, "spell_gen_charmed_unit_spell_cooldown"),
(37919, "spell_gen_charmed_unit_spell_cooldown"),
(47911, "spell_gen_charmed_unit_spell_cooldown"),
(48620, "spell_gen_charmed_unit_spell_cooldown"),
(51748, "spell_gen_charmed_unit_spell_cooldown"),
(51752, "spell_gen_charmed_unit_spell_cooldown"),
(51756, "spell_gen_charmed_unit_spell_cooldown"),
(54996, "spell_gen_charmed_unit_spell_cooldown"),
(54997, "spell_gen_charmed_unit_spell_cooldown"),
(56513, "spell_gen_charmed_unit_spell_cooldown"),
(56524, "spell_gen_charmed_unit_spell_cooldown");
