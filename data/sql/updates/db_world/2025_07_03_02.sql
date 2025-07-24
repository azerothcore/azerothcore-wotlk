-- DB update 2025_07_03_01 -> 2025_07_03_02
-- The Aldor
-- Venom Sac: From Hatred to Neutral
UPDATE `quest_template_addon` SET  `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepFaction` = 0, `RequiredMaxRepFaction` = 932 WHERE `id` IN (10017, 10019);

-- Mark of Kil'jaden: From Neutral to Honoured
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 9000, `RequiredMinRepFaction` = 932, `RequiredMaxRepFaction` = 932 WHERE `id` IN (10325, 10326, 10327);

-- Mark of Sargeras: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepFaction` = 932, `RequiredMaxRepFaction` = 0 WHERE `id` IN (10653, 10654, 10655, 10826, 10827, 10828);

-- 	Fel Armament: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepFaction` = 932, `RequiredMaxRepFaction` = 0 WHERE `id` IN (10420, 10421);

-- The Scryers
-- Basilisk Eye: From Hatred to Neutral
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepValue` = 0, `RequiredMaxRepFaction` = 934 WHERE `id` IN (10024, 10025);

-- Firewing Signet: From Neutral to Honoured
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 9000, `RequiredMinRepFaction` = 934, `RequiredMaxRepFaction` = 934 WHERE `id` IN (10412, 10415, 10414);

-- Sunfury Signet: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepFaction` = 934, `RequiredMaxRepFaction` = 0 WHERE `id` IN (10656, 10658, 10659, 10822, 10822, 10823, 10824);

-- 	Arcane Tome: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0, `RequiredMinRepFaction` = 934, `RequiredMaxRepFaction` = 0 WHERE `id` IN (10419, 10416);
