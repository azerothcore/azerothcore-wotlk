INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606594157029530500');

-- Correct spell Algalon the Observer, 10 & 25 player 'Phase Punch' to be applied as negative buff

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 64412;

-- Correct spell High King Maulgar, 'Death Coil' to be applied as negative buff

INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (33130,12288);

