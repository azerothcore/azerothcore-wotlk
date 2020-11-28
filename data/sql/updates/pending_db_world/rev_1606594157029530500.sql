INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606594157029530500');

-- Correct buffs incorrectly placed as 'Positive'

DELETE FROM spell_custom_attr WHERE spell_id = 64412; -- Algalon the Observer, 25 player 'Phase Punch'
DELETE FROM spell_custom_attr WHERE spell_id = 54836; -- Noth the Plaguebringer, 25 player 'Wrath of the Plaguebringer'
DELETE FROM spell_custom_attr WHERE spell_id = 29214; -- Noth the Plaguebringer, 10 player 'Wrath of the Plaguebringer'
DELETE FROM spell_custom_attr WHERE spell_id = 72998; -- Blood-Prince Council, Heroic mode, 'Shadow Prison'
DELETE FROM spell_custom_attr WHERE spell_id = 11196; -- First Aid, 'Recently Bandaged'

