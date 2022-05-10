-- fixed quest 12924 spell area
UPDATE `spell_area` SET `quest_start` = 12956 WHERE `spell` = 55858 AND `area` IN (4437,4438,4440,4455,4495) AND `quest_start` = 12924;
UPDATE `spell_area` SET `quest_start` = 12958 WHERE `spell` = 56780 AND `area` = 4439 AND `quest_start` = 12956;
