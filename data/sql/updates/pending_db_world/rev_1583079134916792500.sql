INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583079134916792500');

-- One space too much: 'Greetings. ' instead of 'Greetings.  ' - No locales texts available!
UPDATE `quest_request_items` SET `CompletionText`='Greetings. And welcome to the Harborage.' WHERE `ID`=1392;

-- Text error grammar: 'hölzernen' instead of 'hölzernes' & wrong location: 'Badlands' instead of 'Searing Gorge'- Text in quest_template is already correct! 
UPDATE `quest_template_locale` SET `CompletedText`='Kehrt zum hölzernen Plumpsklo in der sengenden Schlucht zurück.' WHERE `ID`=4449 AND `locale`='deDE';

-- Quest obejctives lead to Hellscream's Vigil which was added in Cataclysm. - Text in quest_template is already correct, cannot proof the correctness of other locales!
-- https://wow.gamepedia.com/Mitsuwa
UPDATE `quest_template_locale` SET `Objectives`='Bringt Mitsuwa beim Außenposten von Zoram''gar 8 Trollglücksbringer.' WHERE `ID`=6462 AND `locale`='deDE';
