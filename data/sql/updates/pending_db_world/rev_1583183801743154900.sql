INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583183801743154900');

-- Quest texts changed to patch stand 3.3.5a from 4.0.3a
-- https://wowwiki.fandom.com/wiki/Senani_Thunderheart
-- https://wowwiki.fandom.com/wiki/Captain_Tarkan

-- Quest details & obejctives lead to Senani Thunderheart in Silverwind Refuge which was moved to that position in Cataclysm. - Text in quest_template is already correct, cannot proof the correctness of other locales!
-- https://wow.gamepedia.com/Sharptalon%27s_Claw_(old)
-- Quest 2
UPDATE `quest_template_locale` SET `Objectives`='Bringt die Klaue von Scharfkralle zu Senani Donnerherz im Splitterholzposten im Eschental.' WHERE `ID`=2 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Details`='Der mächtige Hippogryph Scharfkralle wurde getötet und die Klaue der erschlagenen Bestie dient als Beweis für Euren Sieg.$b$bSenani Donnerherz im Splitterholzposten wird zum Beweis Eurer Tat sicher gern diese Trophäe sehen wollen.' WHERE `ID`=2 AND `locale`='deDE';

-- Quest obejctives lead to Captain Tarkan in Silverwind Refuge which was added in Cataclysm. - Text in quest_template is already correct, cannot proof the correctness of other locales!
-- https://wowwiki.fandom.com/wiki/Quest:Ursangous%27s_Paw
-- Quest 23
UPDATE `quest_template_locale` SET `Objectives`='Bringt Ursangus'' Tatze zu Senani Donnerherz im Splitterholzposten im Eschental.' WHERE `ID`=23 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Details`='Die Tatze des mächtigen Bären Ursangus stellt die Trophäe für diesen Teil der Jagd im Eschental dar. Auf der Tatze befindet sich ein kleines Halbmond-Emblem; die Bedeutung dieses Emblems bleibt jedoch ein Geheimnis.$B$BDie Tatze soll zu Senani Donnerherz im Splitterholzposten gebracht werden, um zu beweisen, dass Ihr das mächtige Tier besiegt und diesen Teil der Jagd abgeschlossen habt.' WHERE `ID`=23 AND `locale`='deDE';

-- Quest details & obejctives lead to Captain Tarkan in Silverwind Refuge which was added in Cataclysm. - Text in quest_template is already correct, cannot proof the correctness of other locales!
-- https://wowwiki.fandom.com/wiki/Quest:Shadumbra%27s_Head
-- Quest 24
UPDATE `quest_template_locale` SET `Objectives`='Bringt Schattumbras Kopf zu Senani Donnerherz im Splitterholzposten im Eschental.' WHERE `ID`=24 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Details`='Der einstmals so flinke Schattumbra liegt jetzt regungslos vor Euch und der Sieg ist Euer.$B$BDer Kopf des erschlagenen Nachtsäblers ist eine passende Trophäe für diesen Kampf. Senani Donnerherz im Splitterholzposten wird eine solche Trophäe sehen wollen, um Euch den Erfolg in diesem Teil der Jagd im Eschental anzurechnen.' WHERE `ID`=24 AND `locale`='deDE';
