INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1625571576605726121');

-- Set Riding Skill (762) to 75/75 where Apprentice Riding (33388) is max
UPDATE `character_skills` SET `value`=75, `max`=75 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=33388);

-- Set Riding Skill (762) to 150/150 where Journeyman Riding (33391) is max
UPDATE `character_skills` SET `value`=150, `max`=150 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=33391);

-- Set Riding Skill (762) to 225/225 where Expert Riding (34090) is max
UPDATE `character_skills` SET `value`=225, `max`=225 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=34090);

-- Set Riding Skill (762) to 300/300 where Artisan Riding (34091) is max
UPDATE `character_skills` SET `value`=300, `max`=300 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=34091);
