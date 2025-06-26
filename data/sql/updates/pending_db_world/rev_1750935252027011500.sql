-- The Aldor
-- Venom Sac: From Hatred to Unfriendly (-1/0), 1 point from Neutral
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = -42000, `RequiredMaxRepValue` = -1 WHERE `id` IN (10017, 10019);

-- Mark of Kil'jaden: From Neutral to Friendly (8999/9000), 1 point from Honour
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 8999 WHERE `id` IN (10325, 10326, 10327);

-- Mark of Sargeras: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0 WHERE `id` IN (10653, 10654, 10655, 10826, 10827, 10828);

-- 	Fel Armament: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0 WHERE `id` IN (10420, 10421);

-- The Scryers
-- Basilisk Eye: From Hatred to Unfriendly (-1/0), 1 point from Neutral
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = -42000, `RequiredMaxRepValue` = -1 WHERE `id` IN (10024, 10025);

-- Firewing Signet: From Neutral to Friendly (8999/9000), 1 point from Honour
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 8999 WHERE `id` IN (10412, 10415, 10414);

-- Sunfury Signet: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0 WHERE `id` IN (10656, 10658, 10659, 10822, 10822, 10823, 10824);

-- 	Arcane Tome: From Neutral to Exalted
UPDATE `quest_template_addon` SET `RequiredMinRepValue` = 0, `RequiredMaxRepValue` = 0 WHERE `id` IN (10419, 10416);
