INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606636935711383900');

-- Apply 'Shadowform' Aura to Saronite Animus

UPDATE `creature_template_addon` SET `auras` = 63359 WHERE (`entry` = 33524);
UPDATE `creature_template_addon` SET `auras` = 63359 WHERE (`entry` = 34152);

