INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606594157029530500');

-- (Algalon the Observer): 'Phase Punch' applied as debuff
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 64412;

-- (High King Maulgar): 'Death Coil' applied as debuff
DELETE FROM `spell_custom_attr` WHERE  `spell_id`=33130;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES 
(33130,12288);

