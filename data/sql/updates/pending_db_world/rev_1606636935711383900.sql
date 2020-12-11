INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606636935711383900');

-- Apply 'Shadowform' Aura to Saronite Animus

UPDATE `creature_template_addon` SET `auras` = '63359' WHERE `entry` IN (33524,34152);

