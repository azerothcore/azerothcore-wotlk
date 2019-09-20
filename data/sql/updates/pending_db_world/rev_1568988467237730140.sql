INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1568988467237730140');

UPDATE `broadcast_text` SET `MaleText` = REPLACE(`MaleText`,'%s','$n'), `FemaleText` = REPLACE(`FemaleText`,'%s','$n') WHERE `ID` = 31843;
UPDATE `broadcast_text_locale` SET `MaleText` = REPLACE(`MaleText`,'%s','$n'), `FemaleText` = REPLACE(`FemaleText`,'%s','$n') WHERE `ID` = 31843;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (57426,57301,58474,58465);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(57426,'spell_item_feast'),
(57301,'spell_item_feast'),
(58474,'spell_item_feast'),
(58465,'spell_item_feast');
