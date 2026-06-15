-- DB update 2026_03_13_06 -> 2026_03_13_07
-- Update npc (ruRU) ; from WowHead Wotlk > TBC > Classic > Cata > Mop > Retail
-- If locale datas strictly equals AC enUS, or if locale datas strictly equals to Wowhead enUS, then we use AC fallback to enUS
-- Disclaimer : Datas of technical NPCs (Theoretically not visible to players) could be wrong, here we strictly align with WoWHead datas

-- Entries without any translation datas, on any version
-- AC datas : OLD Name : "Andrew Test Dummy 80 Hostile Low Damage", Name AC enUS : "QA Test Dummy 80 Hostile Low Damage" OLD Subname : "QA Punching Bag", Subname AC enUS : "QA Punching Bag" ; Reason : Match AC enUS datas
DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU' AND `entry` = 30888;

-- Update existing entries, from CLASSIC
-- AC datas : OLD Name : "", Name AC enUS : "DEBUG - Gossip Gryphon Master" ; Wowhead enUS : "DEBUG - Gossip Gryphon Master"
UPDATE `creature_template_locale` SET `Name` = 'DEBUG - укротитель грифонов, сплетни', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 2833;
-- AC datas : OLD Name : "", Name AC enUS : "Cap'n Copyright" ; Wowhead enUS : "Cap'n Copyright"
UPDATE `creature_template_locale` SET `Name` = 'Капитанские права', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 3152;
-- AC datas : OLD Name : "Наставница суккубов", Name AC enUS : "World Succubus Trainer" ; Wowhead enUS : "World Succubus Trainer"
UPDATE `creature_template_locale` SET `Name` = 'Дрессировщица суккубов', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 5014;
-- AC datas : OLD Name : "Наставница демонов Бездны", Name AC enUS : "World Voidwalker Trainer" ; Wowhead enUS : "World Voidwalker Trainer"
UPDATE `creature_template_locale` SET `Name` = 'Дрессировщица демонов Бездны', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 5016;
-- AC datas : OLD Name : "", Name AC enUS : "World Mount Vendor" ; Wowhead enUS : "World Mount Vendor"
UPDATE `creature_template_locale` SET `Name` = 'Мир - продавщица скакунов', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 7747;
-- AC datas : OLD Name : "", Name AC enUS : "World Gnome Engineering Trainer" ; Wowhead enUS : "World Gnome Engineering Trainer"
UPDATE `creature_template_locale` SET `Name` = 'Мир - гном - учитель - инженерное дело', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 8676;
-- AC datas : OLD Name : "Yor", Name AC enUS : "Yor <UNUSED>" ; Wowhead enUS : "Yor"
UPDATE `creature_template_locale` SET `Name` = 'Йор', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 10237;

-- Update existing entries, from CATA
-- AC datas : OLD Name : "", Name AC enUS : "Invis Horde Siege Engine - West 02" ; Wowhead enUS : "Invis Horde Siege Engine - West 02"
UPDATE `creature_template_locale` SET `Name` = 'Невидимая осадная машина Орды - запад 02', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 21236;
-- AC datas : OLD Name : "", Name AC enUS : "Invis Horde Siege Engine - East 02" ; Wowhead enUS : "Invis Horde Siege Engine - East 02"
UPDATE `creature_template_locale` SET `Name` = 'Невидимая осадная машина Орды - восток 02', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 21237;
-- AC datas : OLD Name : "", Name AC enUS : "Gnome Defender - 209" ; Wowhead enUS : "Gnome Defender - 209"
UPDATE `creature_template_locale` SET `Name` = 'Защитник гномов - 209', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 21426;

-- Update existing entries, from RETAIL
-- AC datas : OLD Subname : "Алхимик *модель отсутствует*", Subname AC enUS : "Alchemist <Needs Model>" ; Wowhead enUS : "Journeyman Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = 'Учитель подмастерьев алхимиков', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 3070;
-- AC datas : OLD Subname : "Травник <модель отсутствует>", Subname AC enUS : "Herbalist <Needs Model>" ; Wowhead enUS : "Herbalism Trainer"
UPDATE `creature_template_locale` SET `Title` = 'Учитель травничества', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 3071;
-- AC datas : OLD Subname : "", Subname AC enUS : "No Clothes NPC" ; Wowhead enUS : "No Clothes NPC"
UPDATE `creature_template_locale` SET `Title` = 'Голый NPC', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 4045;
-- AC datas : OLD Name : "", Name AC enUS : "Test BattleMaster" ; Wowhead enUS : "Test BattleMaster"
UPDATE `creature_template_locale` SET `Name` = 'Тестовый военачальник', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 7314;
-- AC datas : OLD Subname : "", Subname AC enUS : "Designer Extraordinaire" ; Wowhead enUS : "Designer Extraordinaire"
UPDATE `creature_template_locale` SET `Title` = 'Выдающийся дизайнер', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 14885;
-- AC datas : OLD Subname : "", Subname AC enUS : "Designer Extraordinaire" ; Wowhead enUS : "Designer Extraordinaire"
UPDATE `creature_template_locale` SET `Title` = 'Выдающийся дизайнер', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 15123;
-- AC datas : OLD Name : "", Name AC enUS : "Vulculon UNUSED" ; Wowhead enUS : "Vulculon UNUSED"
UPDATE `creature_template_locale` SET `Name` = 'Вулкулон UNUSED', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 15210;
-- AC datas : OLD Name : "RC Blimp", Name AC enUS : "RC Blimp <PH>" ; Wowhead enUS : "RC Blimp"
UPDATE `creature_template_locale` SET `Name` = 'Радиоуправляемый дирижабль', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 15349;
-- AC datas : OLD Subname : "", Subname AC enUS : "Cheesy Test Alchemist" ; Wowhead enUS : "Alchemy Trainer"
UPDATE `creature_template_locale` SET `Title` = 'Учитель алхимии', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 16487;
-- AC datas : OLD Subname : "Учительница верховой езды", Subname AC enUS : "Horse Riding Trainer" ; Wowhead enUS : "Stable Master"
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 19491;
-- AC datas : OLD Subname : "Учительница верховой езды", Subname AC enUS : "Horse Riding Trainer" ; Wowhead enUS : "Stable Master"
UPDATE `creature_template_locale` SET `Title` = 'Смотрительница стойл', `VerifiedBuild` = 0 WHERE `locale` = 'ruRU' AND `entry` = 19492;

-- List of entries using CLASSIC datas :
-- 2833,3152,5014,5016,7747,8676,10237
-- List of entries using CATA datas :
-- 21236,21237,21426
-- List of entries using RETAIL datas :
-- 3070,3071,4045,7314,14885,15123,15210,15349,16487,19491,19492
