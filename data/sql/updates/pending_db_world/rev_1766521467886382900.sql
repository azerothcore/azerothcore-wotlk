-- Both Mending Fences and A Spark of Hope must be completed to change Phase to the friendly Dun Niffelem
UPDATE `spell_area` SET `quest_start` = 12924, `quest_start_status` = 74 WHERE `quest_start` = 12956 AND `spell` = 55858;
