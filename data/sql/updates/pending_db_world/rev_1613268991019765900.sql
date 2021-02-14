INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613268991019765900');

/* Correctly set Amplify Magic Ranks 4 thru 7 as positive buffs.
*/
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (43017, 33946, 27130, 10170);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES 
(43017, 100663296),
(33946, 100663296),
(27130, 100663296),
(10170, 100663296);
