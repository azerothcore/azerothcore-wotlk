INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553712779275952300');

DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=1050;
INSERT INTO conditions VALUES (15, 1050, 0, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display option if player has red card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 2, 0, 9281, 1, 0, 0, 0, 0, '', 'Display option if player has red card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 2, 0, 9327, 1, 0, 0, 0, 0, '', 'Display option if player has delta card');
INSERT INTO conditions VALUES (15, 1050, 1, 0, 0, 25, 0, 3959, 0, 0, 1, 0, 0, '', 'Display option if player has no Discombobulator Ray spell');
