-- DB update 2026_05_30_09 -> 2026_05_30_10
-- Update item (esMX) ; from WowHead Wotlk > TBC > Classic > Cata > Mop > Retail
-- If locale datas strictly equals AC enUS, or if locale datas strictly equals to Wowhead enUS, then we use AC fallback to enUS
-- Disclaimer : Datas of technical NPCs (Theoretically not visible to players) could be wrong, here we strictly align with WoWHead datas

-- Entries without any translation datas, on any version
-- AC datas : OLD Title : "Deprecated Old Pants", Title AC enUS : "Deprecated Old Pants" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 88;
-- AC datas : OLD Title : "Deprecated Dwarven Squire\'s Pants", Title AC enUS : "Deprecated Dwarven Squire\'s Pants" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 100;
-- AC datas : OLD Title : "Deprecated Tauren Trapper\'s Pants", Title AC enUS : "Deprecated Tauren Trapper\'s Pants" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 128;
-- AC datas : OLD Title : "Deprecated War Harness", Title AC enUS : "Deprecated War Harness" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 138;
-- AC datas : OLD Title : "Deprecated Tauren Recruit\'s Pants", Title AC enUS : "Deprecated Tauren Recruit\'s Pants" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 156;
-- AC datas : OLD Title : "Vendetta", Title AC enUS : "Vendetta" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 776;
-- AC datas : OLD Title : "Deprecated Nightmare Summoning (Mount)", Title AC enUS : "Deprecated Nightmare Summoning (Mount)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 900;
-- AC datas : OLD Title : "Deprecated Heavy Brown Sack", Title AC enUS : "Deprecated Heavy Brown Sack" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 931;
-- AC datas : OLD Title : "Deprecated Dented Skullcap", Title AC enUS : "Deprecated Dented Skullcap" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 1028;
-- AC datas : OLD Title : "Deprecated Overseer\'s Helm", Title AC enUS : "Deprecated Overseer\'s Helm" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 1192;
-- AC datas : OLD Title : "Tabar", Title AC enUS : "Tabar" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 1196;
-- AC datas : OLD Title : "Jade", Title AC enUS : "Jade" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 1529;
-- AC datas : OLD Title : "Deprecated Ogre Head", Title AC enUS : "Deprecated Ogre Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 1672;
-- AC datas : OLD Title : "Jambiya", Title AC enUS : "Jambiya" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2207;
-- AC datas : OLD Title : "Kris", Title AC enUS : "Kris" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2209;
-- AC datas : OLD Title : "Deprecated Sentinel Coif", Title AC enUS : "Deprecated Sentinel Coif" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2275;
-- AC datas : OLD Title : "Deprecated Light Winter Cloak", Title AC enUS : "Deprecated Light Winter Cloak" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2305;
-- AC datas : OLD Title : "Deprecated Light Winter Boots", Title AC enUS : "Deprecated Light Winter Boots" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2306;
-- AC datas : OLD Title : "Gladius", Title AC enUS : "Gladius" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2488;
-- AC datas : OLD Title : "Tomahawk", Title AC enUS : "Tomahawk" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2490;
-- AC datas : OLD Title : "Flamberge", Title AC enUS : "Flamberge" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2521;
-- AC datas : OLD Title : "Bullova", Title AC enUS : "Bullova" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2523;
-- AC datas : OLD Title : "Francisca", Title AC enUS : "Francisca" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2530;
-- AC datas : OLD Title : "Rondel", Title AC enUS : "Rondel" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2534;
-- AC datas : OLD Title : "Deprecated Red Leather Mask", Title AC enUS : "Deprecated Red Leather Mask" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2588;
-- AC datas : OLD Title : "Deprecated Pattern: Forest Silk Gloves", Title AC enUS : "Deprecated Pattern: Forest Silk Gloves" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2599;
-- AC datas : OLD Title : "Deprecated Ironband\'s Powder Approval", Title AC enUS : "Deprecated Ironband\'s Powder Approval" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2638;
-- AC datas : OLD Title : "Deprecated Coif of Inner Strength", Title AC enUS : "Deprecated Coif of Inner Strength" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2918;
-- AC datas : OLD Title : "Deprecated Burnished Chain Coif", Title AC enUS : "Deprecated Burnished Chain Coif" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 2995;
-- AC datas : OLD Title : "BKP 42 "Ultra"", Title AC enUS : "BKP 42 "Ultra"" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3025;
-- AC datas : OLD Title : "Depricated Razor Arrow", Title AC enUS : "Depricated Razor Arrow" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3031;
-- AC datas : OLD Title : "Deprecated Glinting Scale Crown", Title AC enUS : "Deprecated Glinting Scale Crown" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3046;
-- AC datas : OLD Title : "Deprecated Winter Mail Coif", Title AC enUS : "Deprecated Winter Mail Coif" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3052;
-- AC datas : OLD Title : "Deprecated Deepwood Gloves", Title AC enUS : "Deprecated Deepwood Gloves" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3062;
-- AC datas : OLD Title : "Deprecated Deepwood Helm", Title AC enUS : "Deprecated Deepwood Helm" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3063;
-- AC datas : OLD Title : "Deprecated Contract for the Magistrate", Title AC enUS : "Deprecated Contract for the Magistrate" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3513;
-- AC datas : OLD Title : "Deprecated Perenolde\'s Head", Title AC enUS : "Deprecated Perenolde\'s Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3584;
-- AC datas : OLD Title : "Deprecated Jkaplan TEST", Title AC enUS : "Deprecated Jkaplan TEST" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3686;
-- AC datas : OLD Title : "Deprecated Cured Leather Cap", Title AC enUS : "Deprecated Cured Leather Cap" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3884;
-- AC datas : OLD Title : "Deprecated Warden Blade", Title AC enUS : "Deprecated Warden Blade" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 3934;
-- AC datas : OLD Title : "Olmann Sewar", Title AC enUS : "Olmann Sewar" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4116;
-- AC datas : OLD Title : "Deprecated Hunting Spaulders", Title AC enUS : "Deprecated Hunting Spaulders" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4688;
-- AC datas : OLD Title : "OLDCeremonial Club", Title AC enUS : "OLDCeremonial Club" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4704;
-- AC datas : OLD Title : "Deprecated Pearled Chain Pants", Title AC enUS : "Deprecated Pearled Chain Pants" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4761;
-- AC datas : OLD Title : "Deprecated Blessed Bracers", Title AC enUS : "Deprecated Blessed Bracers" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4773;
-- AC datas : OLD Title : "Deprecated Heavy Bracers", Title AC enUS : "Deprecated Heavy Bracers" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4774;
-- AC datas : OLD Title : "Deprecated Scorched Heart", Title AC enUS : "Deprecated Scorched Heart" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 4868;
-- AC datas : OLD Title : "OLDCeremonial Club", Title AC enUS : "OLDCeremonial Club" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 5410;
-- AC datas : OLD Title : "Deprecated Iron Pummel", Title AC enUS : "Deprecated Iron Pummel" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 5515;
-- AC datas : OLD Title : "Deprecated Brakgul Deathbringer\'s Head", Title AC enUS : "Deprecated Brakgul Deathbringer\'s Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 5531;
-- AC datas : OLD Title : "Deprecated Band of the Order", Title AC enUS : "Deprecated Band of the Order" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 5625;
-- AC datas : OLD Title : "NG-5", Title AC enUS : "NG-5" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 5732;
-- AC datas : OLD Title : "Draco-Incarcinatrix 900", Title AC enUS : "Draco-Incarcinatrix 900" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 12284;
-- AC datas : OLD Title : "Serathil", Title AC enUS : "Serathil" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13015;
-- AC datas : OLD Title : "Deprecated Stormrage Boots", Title AC enUS : "Deprecated Stormrage Boots" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13242;
-- AC datas : OLD Title : "[PH] Rising Dawn Hat", Title AC enUS : "[PH] Rising Dawn Hat" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13787;
-- AC datas : OLD Title : "[PH] Shining Dawn Hat", Title AC enUS : "[PH] Shining Dawn Hat" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13788;
-- AC datas : OLD Title : "[PH] Rising Dawn Cap", Title AC enUS : "[PH] Rising Dawn Cap" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13790;
-- AC datas : OLD Title : "[PH] Shining Dawn Cap", Title AC enUS : "[PH] Shining Dawn Cap" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13791;
-- AC datas : OLD Title : "[PH] Rising Dawn Coif", Title AC enUS : "[PH] Rising Dawn Coif" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13793;
-- AC datas : OLD Title : "[PH] Shining Dawn Coif", Title AC enUS : "[PH] Shining Dawn Coif" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 13794;
-- AC datas : OLD Title : "Shinsollo", Title AC enUS : "Shinsollo" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 16171;
-- AC datas : OLD Title : "Ankh", Title AC enUS : "Ankh" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 17030;
-- AC datas : OLD Title : "QAEnchant Chest +100 Health", Title AC enUS : "QAEnchant Chest +100 Health" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 17882;
-- AC datas : OLD Title : "QAEnchant 2H Weapon +9 Damage", Title AC enUS : "QAEnchant 2H Weapon +9 Damage" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 17887;
-- AC datas : OLD Title : "AHNQIRAJ TEST ITEM D PLATE BOOTS", Title AC enUS : "AHNQIRAJ TEST ITEM D PLATE BOOTS" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 21442;
-- AC datas : OLD Title : "Jom Gabbar", Title AC enUS : "Jom Gabbar" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 23570;
-- AC datas : OLD Title : "PH Plate Ramparts Reward", Title AC enUS : "PH Plate Ramparts Reward" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 24137;
-- AC datas : OLD Title : "130 Test Caster Belt", Title AC enUS : "130 Test Caster Belt" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 24561;
-- AC datas : OLD Title : "QR 9863 Warrior Chest", Title AC enUS : "QR 9863 Warrior Chest" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 25573;
-- AC datas : OLD Title : "59 TEST Green Rogue Legs", Title AC enUS : "59 TEST Green Rogue Legs" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26173;
-- AC datas : OLD Title : "59 TEST Green Rogue Shoulder", Title AC enUS : "59 TEST Green Rogue Shoulder" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26174;
-- AC datas : OLD Title : "59 TEST Green Rogue Wrist", Title AC enUS : "59 TEST Green Rogue Wrist" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26175;
-- AC datas : OLD Title : "60 TEST Green Rogue Head", Title AC enUS : "60 TEST Green Rogue Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26180;
-- AC datas : OLD Title : "67 TEST Green Rogue Hand", Title AC enUS : "67 TEST Green Rogue Hand" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26235;
-- AC datas : OLD Title : "64 TEST Green Hunter Head", Title AC enUS : "64 TEST Green Hunter Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26324;
-- AC datas : OLD Title : "70 TEST Green Hunter Belt", Title AC enUS : "70 TEST Green Hunter Belt" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26368;
-- AC datas : OLD Title : "70 TEST Green Hunter Head", Title AC enUS : "70 TEST Green Hunter Head" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26372;
-- AC datas : OLD Title : "68 TEST Green Warrior Belt", Title AC enUS : "68 TEST Green Warrior Belt" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26464;
-- AC datas : OLD Title : "68 TEST Green Warrior Boot", Title AC enUS : "68 TEST Green Warrior Boot" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26465;
-- AC datas : OLD Title : "61 TEST Green Shield", Title AC enUS : "61 TEST Green Shield" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26548;
-- AC datas : OLD Title : "70 TEST Green Staff", Title AC enUS : "70 TEST Green Staff" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26655;
-- AC datas : OLD Title : "69 TEST Green Crossbow", Title AC enUS : "69 TEST Green Crossbow" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26738;
-- AC datas : OLD Title : "67 TEST Green Healer Mace", Title AC enUS : "67 TEST Green Healer Mace" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26792;
-- AC datas : OLD Title : "62 TEST Green Druid Wrist", Title AC enUS : "62 TEST Green Druid Wrist" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 26843;
-- AC datas : OLD Title : "65 TEST Green Druid/Warrior Cloak", Title AC enUS : "65 TEST Green Druid/Warrior Cloak" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 27196;
-- AC datas : OLD Title : "59 TEST Green Druid/Warrior Necklace", Title AC enUS : "59 TEST Green Druid/Warrior Necklace" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 27218;
-- AC datas : OLD Title : "Level 63 Test Gear Green - Mail - Hunter 2", Title AC enUS : "Level 63 Test Gear Green - Mail - Hunter 2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 27590;
-- AC datas : OLD Title : "TEST 130 Epic Paladin DPS Chest", Title AC enUS : "TEST 130 Epic Paladin DPS Chest" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 27965;
-- AC datas : OLD Title : "Monster - Throwing Axe (Poison)", Title AC enUS : "Monster - Throwing Axe (Poison)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28023;
-- AC datas : OLD Title : "Stellaris", Title AC enUS : "Stellaris" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28263;
-- AC datas : OLD Title : "Monster - Work Wrench, Ethereal (Red Glow)", Title AC enUS : "Monster - Work Wrench, Ethereal (Red Glow)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28489;
-- AC datas : OLD Title : "Monster - Staff, Benediction", Title AC enUS : "Monster - Staff, Benediction" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28738;
-- AC datas : OLD Title : "Monster - Staff, Anathema", Title AC enUS : "Monster - Staff, Anathema" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28739;
-- AC datas : OLD Title : "Malchazeen", Title AC enUS : "Malchazeen" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28768;
-- AC datas : OLD Title : "Monster - Claw, Badass", Title AC enUS : "Monster - Claw, Badass" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 28905;
-- AC datas : OLD Title : "Monster - Mace2H, Warhammer Ebony - White Flame", Title AC enUS : "Monster - Mace2H, Warhammer Ebony - White Flame" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29410;
-- AC datas : OLD Title : "Monster - Glaive - 3 Blade Purple - Ethereal, Ethereum (Red Glow)", Title AC enUS : "Monster - Glaive - 3 Blade Purple - Ethereal, Ethereum (Red Glow)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29419;
-- AC datas : OLD Title : "Monster - Sword2H, Draenei A02 Rusty", Title AC enUS : "Monster - Sword2H, Draenei A02 Rusty" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29645;
-- AC datas : OLD Title : "Monster - Axe, Draenei C01 Ice", Title AC enUS : "Monster - Axe, Draenei C01 Ice" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29712;
-- AC datas : OLD Title : "Rogue 150 Epic Test Dagger 1800", Title AC enUS : "Rogue 150 Epic Test Dagger 1800" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29828;
-- AC datas : OLD Title : "QAEnchant Weapon Sunfire", Title AC enUS : "QAEnchant Weapon Sunfire" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29841;
-- AC datas : OLD Title : "QAEnchant Gloves +26 Attack Power", Title AC enUS : "QAEnchant Gloves +26 Attack Power" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29868;
-- AC datas : OLD Title : "QAEnchant Chest +15 Spirit", Title AC enUS : "QAEnchant Chest +15 Spirit" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 29871;
-- AC datas : OLD Title : "Monster - Work Wrench", Title AC enUS : "Monster - Work Wrench" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 31824;
-- AC datas : OLD Title : "Tom\'s Legs A", Title AC enUS : "Tom\'s Legs A" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32414;
-- AC datas : OLD Title : "Tom\'s Legs B", Title AC enUS : "Tom\'s Legs B" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32415;
-- AC datas : OLD Title : "Tom\'s Legs C", Title AC enUS : "Tom\'s Legs C" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32416;
-- AC datas : OLD Title : "Tom\'s Legs 1", Title AC enUS : "Tom\'s Legs 1" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32417;
-- AC datas : OLD Title : "Tom\'s Legs 2", Title AC enUS : "Tom\'s Legs 2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32418;
-- AC datas : OLD Title : "Tom\'s Legs 3", Title AC enUS : "Tom\'s Legs 3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32419;
-- AC datas : OLD Title : "Tom\'s Axe A", Title AC enUS : "Tom\'s Axe A" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32421;
-- AC datas : OLD Title : "Tom\'s Axe B", Title AC enUS : "Tom\'s Axe B" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32422;
-- AC datas : OLD Title : "Tier 5 Druid Test Gear", Title AC enUS : "Tier 5 Druid Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32543;
-- AC datas : OLD Title : "Tier 5 Hunter Test Gear", Title AC enUS : "Tier 5 Hunter Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32545;
-- AC datas : OLD Title : "Tier 5 Mage Test Gear", Title AC enUS : "Tier 5 Mage Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32547;
-- AC datas : OLD Title : "Tier 5 Paladin Test Gear", Title AC enUS : "Tier 5 Paladin Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32549;
-- AC datas : OLD Title : "Tier 5 Priest Test Gear", Title AC enUS : "Tier 5 Priest Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32551;
-- AC datas : OLD Title : "Tier 5 Rogue Test Gear", Title AC enUS : "Tier 5 Rogue Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32553;
-- AC datas : OLD Title : "Tier 5 Rogue Test Gear Box 2", Title AC enUS : "Tier 5 Rogue Test Gear Box 2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32554;
-- AC datas : OLD Title : "Tier 5 Shaman Test Gear", Title AC enUS : "Tier 5 Shaman Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32555;
-- AC datas : OLD Title : "Tier 5 Warlock Test Gear", Title AC enUS : "Tier 5 Warlock Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32557;
-- AC datas : OLD Title : "Tier 5 Warrior Test Gear", Title AC enUS : "Tier 5 Warrior Test Gear" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32559;
-- AC datas : OLD Title : "Tier 5 Arrow Box", Title AC enUS : "Tier 5 Arrow Box" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32561;
-- AC datas : OLD Title : "Monster - Black Temple - Sword, 1H - Shadowmoon Soldier", Title AC enUS : "Monster - Black Temple - Sword, 1H - Shadowmoon Soldier" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32615;
-- AC datas : OLD Title : "[DEPRECATED]Crystalforged Darkrune", Title AC enUS : "[DEPRECATED]Crystalforged Darkrune" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32618;
-- AC datas : OLD Title : "Monster - Glavie, Illidan - Black Temple (Left Hand)", Title AC enUS : "Monster - Glavie, Illidan - Black Temple (Left Hand)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32633;
-- AC datas : OLD Title : "Monster - Dagger, Fang of Vashj", Title AC enUS : "Monster - Dagger, Fang of Vashj" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 32841;
-- AC datas : OLD Title : "Frostmourne Art Demo", Title AC enUS : "Frostmourne Art Demo" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 33350;
-- AC datas : OLD Title : "Indalamar\'s Ring of 200 Spell Crit", Title AC enUS : "Indalamar\'s Ring of 200 Spell Crit" OLD Description : "Don\'t you wish this was real!", Description AC enUS : "Don\'t you wish this was real!" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 33987;
-- AC datas : OLD Title : "Indalamar\'s Ring of 400 Attack Power", Title AC enUS : "Indalamar\'s Ring of 400 Attack Power" OLD Description : "Don\'t you wish this was real!", Description AC enUS : "Don\'t you wish this was real!" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 33997;
-- AC datas : OLD Title : "Clayton\'s Test Item", Title AC enUS : "Clayton\'s Test Item" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34025;
-- AC datas : OLD Title : "Clayton\'s Test Item Two", Title AC enUS : "Clayton\'s Test Item Two" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34030;
-- AC datas : OLD Title : "Team A Tabard", Title AC enUS : "Team A Tabard" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34158;
-- AC datas : OLD Title : "Muramasa", Title AC enUS : "Muramasa" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34214;
-- AC datas : OLD Title : "Armor Test Item", Title AC enUS : "Armor Test Item" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34219;
-- AC datas : OLD Title : "Monster - Shield, Shattered Sun D01 Red", Title AC enUS : "Monster - Shield, Shattered Sun D01 Red" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34589;
-- AC datas : OLD Title : "Monster - Shield, Shattered Sun D01 Yellow", Title AC enUS : "Monster - Shield, Shattered Sun D01 Yellow" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34590;
-- AC datas : OLD Title : "Monster - Shield, Shattered Sun D01 White", Title AC enUS : "Monster - Shield, Shattered Sun D01 White" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34591;
-- AC datas : OLD Title : "Monster - Sword2H, Horde PvP (Green)", Title AC enUS : "Monster - Sword2H, Horde PvP (Green)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34694;
-- AC datas : OLD Title : "Monster - Item, Fishing Pole (Tuskarr)", Title AC enUS : "Monster - Item, Fishing Pole (Tuskarr)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34784;
-- AC datas : OLD Title : "Monster - Sword, 1H Outland Raid D02", Title AC enUS : "Monster - Sword, 1H Outland Raid D02" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 34880;
-- AC datas : OLD Title : "Microfilm", Title AC enUS : "Microfilm" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 35123;
-- AC datas : OLD Title : "Monster - Sword2H, Northrend C02 Red (Red Flame)", Title AC enUS : "Monster - Sword2H, Northrend C02 Red (Red Flame)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 35757;
-- AC datas : OLD Title : "HF BLUE Leather DPS Chest", Title AC enUS : "HF BLUE Leather DPS Chest" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 36866;
-- AC datas : OLD Title : "HF BLUE Plate DPS Chest", Title AC enUS : "HF BLUE Plate DPS Chest" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 36867;
-- AC datas : OLD Title : "BT47 Cloth Healer Belt2", Title AC enUS : "BT47 Cloth Healer Belt2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37278;
-- AC datas : OLD Title : "BT48 Cloth Spell Bracer3", Title AC enUS : "BT48 Cloth Spell Bracer3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37279;
-- AC datas : OLD Title : "BT52 Cloth Healer Chest2", Title AC enUS : "BT52 Cloth Healer Chest2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37281;
-- AC datas : OLD Title : "BT55 Cloth Spell Boots4", Title AC enUS : "BT55 Cloth Spell Boots4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37284;
-- AC datas : OLD Title : "BT56 Cloth Spell Legs4", Title AC enUS : "BT56 Cloth Spell Legs4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37285;
-- AC datas : OLD Title : "BT57 Cloth Healer Glove2", Title AC enUS : "BT57 Cloth Healer Glove2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37286;
-- AC datas : OLD Title : "HF28 Cloth Spell Head4", Title AC enUS : "HF28 Cloth Spell Head4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37295;
-- AC datas : OLD Title : "Deprecated Test Glyph", Title AC enUS : "Deprecated Test Glyph" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37301;
-- AC datas : OLD Title : "BT59 Leather Physical Boots4", Title AC enUS : "BT59 Leather Physical Boots4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37315;
-- AC datas : OLD Title : "BT56 Leather Healer Boots2", Title AC enUS : "BT56 Leather Healer Boots2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37317;
-- AC datas : OLD Title : "BT55 Leather Physical Gloves4", Title AC enUS : "BT55 Leather Physical Gloves4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37318;
-- AC datas : OLD Title : "BT52 Leather Healer Legs2", Title AC enUS : "BT52 Leather Healer Legs2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37321;
-- AC datas : OLD Title : "BT48 Leather Physical Belt3", Title AC enUS : "BT48 Leather Physical Belt3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37323;
-- AC datas : OLD Title : "BT47 Leather Physical Gloves3", Title AC enUS : "BT47 Leather Physical Gloves3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37324;
-- AC datas : OLD Title : "BT49 Mail Physical Belt3", Title AC enUS : "BT49 Mail Physical Belt3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37451;
-- AC datas : OLD Title : "BT59 Mail Physical Belt4", Title AC enUS : "BT59 Mail Physical Belt4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37453;
-- AC datas : OLD Title : "HF28 Mail Physical Chest4", Title AC enUS : "HF28 Mail Physical Chest4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37454;
-- AC datas : OLD Title : "BT56 Mail Healer Gloves2", Title AC enUS : "BT56 Mail Healer Gloves2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37455;
-- AC datas : OLD Title : "BT55 Mail Physical Legs4", Title AC enUS : "BT55 Mail Physical Legs4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37457;
-- AC datas : OLD Title : "BT59 Plate Physical Chest4", Title AC enUS : "BT59 Plate Physical Chest4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37466;
-- AC datas : OLD Title : "HF28 Plate Physical Boots4", Title AC enUS : "HF28 Plate Physical Boots4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37468;
-- AC datas : OLD Title : "BT57 Plate Healer Bracer2", Title AC enUS : "BT57 Plate Healer Bracer2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37469;
-- AC datas : OLD Title : "BT56 Plate Physical Shoulders4", Title AC enUS : "BT56 Plate Physical Shoulders4" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37470;
-- AC datas : OLD Title : "BT49 Plate Physical Bracer", Title AC enUS : "BT49 Plate Physical Bracer" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37472;
-- AC datas : OLD Title : "BT48 Plate Healer Head2", Title AC enUS : "BT48 Plate Healer Head2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37473;
-- AC datas : OLD Title : "BT47 Plate Physical Boots3", Title AC enUS : "BT47 Plate Physical Boots3" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37474;
-- AC datas : OLD Title : "BT57 Fast Mace2", Title AC enUS : "BT57 Fast Mace2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37536;
-- AC datas : OLD Title : "Monster - Mace1H, Prince Arthas", Title AC enUS : "Monster - Mace1H, Prince Arthas" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37579;
-- AC datas : OLD Title : "DB42 Leather Healer Shoulder", Title AC enUS : "DB42 Leather Healer Shoulder" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38052;
-- AC datas : OLD Title : "TEST HASTE RING (1500)", Title AC enUS : "TEST HASTE RING (1500)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38164;
-- AC datas : OLD Title : "BTBlue Spell Cloak1", Title AC enUS : "BTBlue Spell Cloak1" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38254;
-- AC datas : OLD Title : "BTBlue Physical Cloak1", Title AC enUS : "BTBlue Physical Cloak1" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38255;
-- AC datas : OLD Title : "BTBlue Healer Cloak1", Title AC enUS : "BTBlue Healer Cloak1" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38256;
-- AC datas : OLD Title : "[PH] Reins of the Black Warp Stalker", Title AC enUS : "[PH] Reins of the Black Warp Stalker" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38265;
-- AC datas : OLD Title : "QA Test Slow Fist Weapon", Title AC enUS : "QA Test Slow Fist Weapon" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38469;
-- AC datas : OLD Title : "QA Test Slow Gun", Title AC enUS : "QA Test Slow Gun" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38471;
-- AC datas : OLD Title : "QA Test Slow Two-Handed Mace", Title AC enUS : "QA Test Slow Two-Handed Mace" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38480;
-- AC datas : OLD Title : "QA Test Slow Two-Handed Axe", Title AC enUS : "QA Test Slow Two-Handed Axe" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38481;
-- AC datas : OLD Title : "QA Test +2000 Spell Power Ring", Title AC enUS : "QA Test +2000 Spell Power Ring" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38484;
-- AC datas : OLD Title : "QA Test Gem Bracers", Title AC enUS : "QA Test Gem Bracers" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38496;
-- AC datas : OLD Title : "QA Test Meta Hat", Title AC enUS : "QA Test Meta Hat" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38497;
-- AC datas : OLD Title : "Papaya", Title AC enUS : "Papaya" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 38655;
-- AC datas : OLD Title : "Test expire transform", Title AC enUS : "Test expire transform" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 39163;
-- AC datas : OLD Title : "Kungaloosh", Title AC enUS : "Kungaloosh" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 39520;
-- AC datas : OLD Title : "Monster - Staff, Northrend Runed (Iron)", Title AC enUS : "Monster - Staff, Northrend Runed (Iron)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 39743;
-- AC datas : OLD Title : "Monster - Sword, Northrend Iron Dwarf", Title AC enUS : "Monster - Sword, Northrend Iron Dwarf" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 39754;
-- AC datas : OLD Title : "TEST ARMOR DEATH KNIGHT HELM", Title AC enUS : "TEST ARMOR DEATH KNIGHT HELM" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40307;
-- AC datas : OLD Title : "Naxxramas 40 Test God Sword", Title AC enUS : "Naxxramas 40 Test God Sword" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40480;
-- AC datas : OLD Title : "ICECROWN TEST GOD BP", Title AC enUS : "ICECROWN TEST GOD BP" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40481;
-- AC datas : OLD Title : "QA Test Ring +300 Hit Rating", Title AC enUS : "QA Test Ring +300 Hit Rating" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40599;
-- AC datas : OLD Title : "LK ARENA TEST WARRIOR BRACERS 213", Title AC enUS : "LK ARENA TEST WARRIOR BRACERS 213" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40650;
-- AC datas : OLD Title : "DEPRECATED Flame Red Ejector Seat", Title AC enUS : "DEPRECATED Flame Red Ejector Seat" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40754;
-- AC datas : OLD Title : "Robinson Test Helm", Title AC enUS : "Robinson Test Helm" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 40762;
-- AC datas : OLD Title : "zzOLD", Title AC enUS : "zzOLD" OLD Description : "zzOLD", Description AC enUS : "zzOLD" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 41125;
-- AC datas : OLD Title : "zzDEPRECATED Sanctified Spellthread", Title AC enUS : "zzDEPRECATED Sanctified Spellthread" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 41605;
-- AC datas : OLD Title : "zzDEPRECATED Master\'s Spellthread", Title AC enUS : "zzDEPRECATED Master\'s Spellthread" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 41606;
-- AC datas : OLD Title : "TEST FRUITCAKE", Title AC enUS : "TEST FRUITCAKE" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 42590;
-- AC datas : OLD Title : "Monster - Staff, Xarantaur\'s Staff", Title AC enUS : "Monster - Staff, Xarantaur\'s Staff" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 42755;
-- AC datas : OLD Title : "Monster - Gun, PvP Alliance", Title AC enUS : "Monster - Gun, PvP Alliance" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 42776;
-- AC datas : OLD Title : "Monster - Mace, Zul\'aman 1H - D02 Blue", Title AC enUS : "Monster - Mace, Zul\'aman 1H - D02 Blue" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 42940;
-- AC datas : OLD Title : "Monster - Staff, Dalaran", Title AC enUS : "Monster - Staff, Dalaran" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 43093;
-- AC datas : OLD Title : "Monster - Sword, Iblis (Back-Sheath)", Title AC enUS : "Monster - Sword, Iblis (Back-Sheath)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 43267;
-- AC datas : OLD Title : "Monster - Staff, Dalaran Blue", Title AC enUS : "Monster - Staff, Dalaran Blue" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 43617;
-- AC datas : OLD Title : "Monster - Staff, Dalaran Green", Title AC enUS : "Monster - Staff, Dalaran Green" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 43618;
-- AC datas : OLD Title : "Monster - Staff, Dalaran Red", Title AC enUS : "Monster - Staff, Dalaran Red" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 43619;
-- AC datas : OLD Title : "Test Mail Shoulder 2", Title AC enUS : "Test Mail Shoulder 2" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 44090;
-- AC datas : OLD Title : "Monster - Item, Harpoon (2H)", Title AC enUS : "Monster - Item, Harpoon (2H)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 44236;
-- AC datas : OLD Title : "Monster - Sword - 1H, King Varian Wrynn", Title AC enUS : "Monster - Sword - 1H, King Varian Wrynn" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 44705;
-- AC datas : OLD Title : "Squirt Gun [PH]", Title AC enUS : "Squirt Gun [PH]" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 44832;
-- AC datas : OLD Title : "Empty Squirt Gun [PH]", Title AC enUS : "Empty Squirt Gun [PH]" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 44833;
-- AC datas : OLD Title : "QATest +1500 Spell Dmg Ring", Title AC enUS : "QATest +1500 Spell Dmg Ring" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45024;
-- AC datas : OLD Title : "[PH] Bridle of the Charger", Title AC enUS : "[PH] Bridle of the Charger" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45026;
-- AC datas : OLD Title : "[PH] Bridle of the Ram", Title AC enUS : "[PH] Bridle of the Ram" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45028;
-- AC datas : OLD Title : "[PH] Bridle of the Mechanostrider", Title AC enUS : "[PH] Bridle of the Mechanostrider" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45029;
-- AC datas : OLD Title : "[PH] Bridle of the Elekk", Title AC enUS : "[PH] Bridle of the Elekk" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45030;
-- AC datas : OLD Title : "[PH] Bridle of the Nightsaber", Title AC enUS : "[PH] Bridle of the Nightsaber" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45031;
-- AC datas : OLD Title : "[PH] Bridle of the Wolf", Title AC enUS : "[PH] Bridle of the Wolf" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45032;
-- AC datas : OLD Title : "[PH] Bridle of the Raptor", Title AC enUS : "[PH] Bridle of the Raptor" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45033;
-- AC datas : OLD Title : "[PH] Bridle of the Kodo", Title AC enUS : "[PH] Bridle of the Kodo" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45034;
-- AC datas : OLD Title : "[PH] Bridle of the Hawkstrider", Title AC enUS : "[PH] Bridle of the Hawkstrider" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45035;
-- AC datas : OLD Title : "[PH] Bridle of the Warhorse", Title AC enUS : "[PH] Bridle of the Warhorse" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45036;
-- AC datas : OLD Title : "[ph] Mark of the Scourge Boss 01", Title AC enUS : "[ph] Mark of the Scourge Boss 01" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45229;
-- AC datas : OLD Title : "[ph] Mark of the Scourge Boss 02", Title AC enUS : "[ph] Mark of the Scourge Boss 02" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45230;
-- AC datas : OLD Title : "[ph] Mark of the Scourge Boss 03", Title AC enUS : "[ph] Mark of the Scourge Boss 03" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45231;
-- AC datas : OLD Title : "[PH] Bridle of the Deathcharger", Title AC enUS : "[PH] Bridle of the Deathcharger" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45569;
-- AC datas : OLD Title : "Test Melee Rifle [PH]", Title AC enUS : "Test Melee Rifle [PH]" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45575;
-- AC datas : OLD Title : "Constellus", Title AC enUS : "Constellus" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45612;
-- AC datas : OLD Title : "Cosmos", Title AC enUS : "Cosmos" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45617;
-- AC datas : OLD Title : "Ebon Cavalry Blade [PH]", Title AC enUS : "Ebon Cavalry Blade [PH]" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45765;
-- AC datas : OLD Title : "Monster - 1H Sword - Varian\'s Blade", Title AC enUS : "Monster - 1H Sword - Varian\'s Blade" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45899;
-- AC datas : OLD Title : "Monster - Mace, Thorim (Ulduar Raid)", Title AC enUS : "Monster - Mace, Thorim (Ulduar Raid)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 45900;
-- AC datas : OLD Title : "Monster - Sword, 1H Horde PvP Red", Title AC enUS : "Monster - Sword, 1H Horde PvP Red" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 46957;
-- AC datas : OLD Title : "Mortalis", Title AC enUS : "Mortalis" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 47518;
-- AC datas : OLD Title : "Jeeves", Title AC enUS : "Jeeves" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49040;
-- AC datas : OLD Title : "Monster - Icecrown - 1H Sword - D03 - Blue", Title AC enUS : "Monster - Icecrown - 1H Sword - D03 - Blue" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49340;
-- AC datas : OLD Title : "Monster - Axe, 2H Icecrown Raid (Shadow)", Title AC enUS : "Monster - Axe, 2H Icecrown Raid (Shadow)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49645;
-- AC datas : OLD Title : "Monster - Axe, 1H Northrend B03 Black", Title AC enUS : "Monster - Axe, 1H Northrend B03 Black" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49689;
-- AC datas : OLD Title : "Monster - Frostmourne (Arthas Only Special)", Title AC enUS : "Monster - Frostmourne (Arthas Only Special)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49706;
-- AC datas : OLD Title : "Monster - Icecrown Citadel - Skybreaker Dreadblade", Title AC enUS : "Monster - Icecrown Citadel - Skybreaker Dreadblade" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49708;
-- AC datas : OLD Title : "Monster - Sword 2H, Icecrown Citadel", Title AC enUS : "Monster - Sword 2H, Icecrown Citadel" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49733;
-- AC datas : OLD Title : "Monster - Axe 1H, Horde D03 Gold (Thrown)", Title AC enUS : "Monster - Axe 1H, Horde D03 Gold (Thrown)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49873;
-- AC datas : OLD Title : "Monster - Sword2H, Ebon Blade (Green)", Title AC enUS : "Monster - Sword2H, Ebon Blade (Green)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 49984;
-- AC datas : OLD Title : "Trauma", Title AC enUS : "Trauma" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50028;
-- AC datas : OLD Title : "Monster - Sword, 1H IcecrownRaid D02", Title AC enUS : "Monster - Sword, 1H IcecrownRaid D02" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50248;
-- AC datas : OLD Title : "Monster - Mace, Basic Stone Hammer (Kobold Worker)", Title AC enUS : "Monster - Mace, Basic Stone Hammer (Kobold Worker)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50431;
-- AC datas : OLD Title : "Trauma", Title AC enUS : "Trauma" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50685;
-- AC datas : OLD Title : "Shadowmourne Monster Offhand", Title AC enUS : "Shadowmourne Monster Offhand" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50815;
-- AC datas : OLD Title : "Monster - Frostmourne, Broken (Arthas Only Special)", Title AC enUS : "Monster - Frostmourne, Broken (Arthas Only Special)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 50840;
-- AC datas : OLD Title : "Monster - Dreadlord\'s Blade", Title AC enUS : "Monster - Dreadlord\'s Blade" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 52011;
-- AC datas : OLD Title : "Monster - Sword 2H, Icecrown Citadel - Valanar", Title AC enUS : "Monster - Sword 2H, Icecrown Citadel - Valanar" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 52062;
-- AC datas : OLD Title : "Test Buyback Gold Cost Ring", Title AC enUS : "Test Buyback Gold Cost Ring" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 52567;
-- AC datas : OLD Title : "Monster - Shield, Zulaman (Blue)", Title AC enUS : "Monster - Shield, Zulaman (Blue)" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 53891;
-- AC datas : OLD Title : "Monster - Sword, Troll 1H", Title AC enUS : "Monster - Sword, Troll 1H" OLD Description : "", Description AC enUS : "" ; Reason : Locale datas strictly equals to AC enUS, no more data available from WoWHead
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 53924;

-- Update existing entries, from WOTLK
-- AC datas : OLD Name : "Restos de lino", Name AC enUS : "Red Linen Bandana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pañuelo de lino rojo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1019;
-- AC datas : OLD Name : "Electro-linterna rota", Name AC enUS : "Broken Electro-lantern" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Electrolinterna rota', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1630;
-- AC datas : OLD Name : "Lanza de hueso con la punta envenenada", Name AC enUS : "Poison-tipped Bone Spear" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lanza de hueso con punta envenenada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1726;
-- AC datas : OLD Name : "Calzas de Hogger", Name AC enUS : "Stonemason Trousers" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calzas de albañil', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1934;
-- AC datas : OLD Name : "Maza pesada", Name AC enUS : "Priest's Mace" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Maza de sacerdote', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2075;
-- AC datas : OLD Name : "Dirk", Name AC enUS : "Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2139;
-- AC datas : OLD Name : "Mono de cadáver", Name AC enUS : "Foreman's Boots" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Botas de supervisor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2168;
-- AC datas : OLD Description : "", Description AC enUS : "Engraved with the words 'For years of service: -EVC.'" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Estas palabras están grabadas "Por los años de servicio: -EVC".', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2239;
-- AC datas : OLD Name : "Toga de Maestro de Juego", Name AC enUS : "Gamemaster's Robe" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Toga de maestro de juego', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2586;
-- AC datas : OLD Name : "Frasco de oporto", Name AC enUS : "Flask of Port" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Frasco de cerveza leonada de Ventormenta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2593;
-- AC datas : OLD Name : "Cántaro de hidromiel", Name AC enUS : "Flagon of Mead" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cántaro de hidromiel enano', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2594;
-- AC datas : OLD Name : "Jarra de bourbon", Name AC enUS : "Jug of Bourbon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Jarra de bourbon de las Tierras Inhóspitas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2595;
-- AC datas : OLD Name : "Botella de pinot noir", Name AC enUS : "Bottle of Pinot Noir" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Botella de Dalaran Noir', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2723;
-- AC datas : OLD Name : "Túnica de cuero duro", Name AC enUS : "Soft Leather Tunic" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Túnica de cuero suave', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2817;
-- AC datas : OLD Name : "[DEPRECATED] Una carta sin enviar", Name AC enUS : "An Unsent Letter" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Una carta sin enviar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2874;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2893;
-- AC datas : OLD Name : "Sangre frenética", Name AC enUS : "Crocolisk Tear" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lágrima de crocolisco', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2939;
-- AC datas : OLD Name : "Conclusiones de Holland", Name AC enUS : "Johaan's Findings" ; Wowhead enUS : "",  OLD Description : "Las conclusiones selladas del boticario auxiliar Holland.", Description AC enUS : "The sealed findings of Apothecary Johaan." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Hallazgos de Johaan', `Description` = 'Las conclusiones selladas del boticario Johaan.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3238;
-- AC datas : OLD Name : "Vial de cristal", Name AC enUS : "Empty Vial" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vial vacío', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3371;
-- AC datas : OLD Name : "Vial rajado", Name AC enUS : "Leaded Vial" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vial emplomado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3372;
-- AC datas : OLD Name : "Bebida especial de Holland", Name AC enUS : "Johaan's Special Drink" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Bebida especial de Johaan', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3460;
-- AC datas : OLD Name : "Flor Morrobarro", Name AC enUS : "Mudsnout Blossoms" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Flores Morrobarro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3502;
-- AC datas : OLD Name : "Veneno entorpecedor", Name AC enUS : "Crippling Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno entorpecedor II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3776;
-- AC datas : OLD Name : "Dirk lustroso", Name AC enUS : "Shiny Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla lustrosa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 3786;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Ritual of Doom." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Ritual de fatalidad.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 4213;
-- AC datas : OLD Name : "Tubo de cobre doblado", Name AC enUS : "Copper Tube" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tubo de cobre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 4361;
-- AC datas : OLD Name : "Modulador roto", Name AC enUS : "Copper Modulator" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Modulador de cobre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 4363;
-- AC datas : OLD Name : "Cerveza trogg", Name AC enUS : "Trogg Ale" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brebaje trogg', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 4953;
-- AC datas : OLD Name : "Cabeza del capitán Garvey", Name AC enUS : "Baron Longshore's Head" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cabeza del barón Longavera', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5084;
-- AC datas : OLD Name : "Colmillo de jabaespín", Name AC enUS : "Bristleback Quilboar Tusk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Colmillo de jabaespín erizapúas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5085;
-- AC datas : OLD Name : "Garras de cazadora", Name AC enUS : "Prowler Claws" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Garras de merodeador', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5096;
-- AC datas : OLD Name : "Siegaenemigos", Name AC enUS : "Rhahk'Zor's Hammer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Martillo de Rhahk''Zor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5187;
-- AC datas : OLD Name : "Piedra de alma", Name AC enUS : "Minor Soulstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de alma menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5232;
-- AC datas : OLD Name : "Flechas flamígeras", Name AC enUS : "Flaming Arrows" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Monster - Bow, Red', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5259;
-- AC datas : OLD Name : "Pólvora Defias", Name AC enUS : "Defias Gunpowder" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pólvora de los Defias', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5397;
-- AC datas : OLD Name : "Piedra de salud", Name AC enUS : "Minor Healthstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de salud menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5512;
-- AC datas : OLD Name : "Almeja de concha espesa", Name AC enUS : "Thick-shelled Clam" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Almeja gruesa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5524;
-- AC datas : OLD Name : "Partículas cegadoras", Name AC enUS : "Worthless Blinding Powder" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Partículas cegadoras insignificantes.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5530;
-- AC datas : OLD Name : "Colección de Zarpasangrante", Name AC enUS : "Dal Bloodclaw's Skull" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calavera de Dal Zarpasangrante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5544;
-- AC datas : OLD Name : "Cohete de fuegos artificiales rojo", Name AC enUS : "Red Fireworks Rocket" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cohete de fuegos artificiales rojos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5740;
-- AC datas : OLD Name : "Camisa de trampero", Name AC enUS : "Thug Shirt" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Camisa de matón', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6136;
-- AC datas : OLD Name : "Botas de trampero", Name AC enUS : "Thug Boots" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Botas de matón', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6138;
-- AC datas : OLD Name : "Monster - Item, Flowers  - Bouquet Roses", Name AC enUS : "Monster - Item, Flowers  - Bouquet Roses" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Monster - Item, Flowers - Boquet Roses', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6232;
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 6232;
-- AC datas : OLD Name : "Corazón de Comar", Name AC enUS : "Comar's Heart" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Corazón de Corma', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6313;
-- AC datas : OLD Name : "Hombreras con babosas taraceadas", Name AC enUS : "Slime-encrusted Pads" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Hombreras taraceadas con babosas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6461;
-- AC datas : OLD Name : "Caja mecánica", Name AC enUS : "Practice Lock" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cerradura de prácticas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6712;
-- AC datas : OLD Name : "Llave de diente de muerto", Name AC enUS : "Dead-tooth's Key" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Llave de Dentomuerto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6783;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6949;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison III" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo III', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6950;
-- AC datas : OLD Name : "Veneno de aturdimiento mental", Name AC enUS : "Mind-numbing Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno de aturdimiento mental II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 6951;
-- AC datas : OLD Name : "Helado de fresa de Tigule y Foror", Name AC enUS : "Tigule and Foror's Strawberry Ice Cream" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Helado de fresa de Tigule', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 7228;
-- AC datas : OLD Name : "Toga abisal", Name AC enUS : "Nether-lace Robe" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Toga de encaje abisal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 7512;
-- AC datas : OLD Name : "Calendario de envíos", Name AC enUS : "Defias Shipping Schedule" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calendario de envíos Defias', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 7675;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8586;
-- AC datas : OLD Name : "Vial corrupto", Name AC enUS : "Crystal Vial" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vial de cristal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8925;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison IV" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo IV', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8926;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison V" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo V', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8927;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison VI" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo VI', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8928;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison III" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal III', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8984;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison IV" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal IV', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 8985;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Inferno." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Inferno.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9214;
-- AC datas : OLD Name : "Corazón de trol marchito", Name AC enUS : "Shriveled Heart" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Corazón marchito', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9243;
-- AC datas : OLD Name : "Ruta de navegación deteriorada por el agua", Name AC enUS : "Ship Schedule" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ruta de navegación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9250;
-- AC datas : OLD Name : "La tercera pierna de Wirt", Name AC enUS : "Wirt's Third Leg" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Farol de los Mares del Sur', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9359;
-- AC datas : OLD Name : "Espada de jin-su", Name AC enUS : "Ginn-su Sword" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Espada de Ginn-Su', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9424;
-- AC datas : OLD Name : "Guerrera abisal", Name AC enUS : "Nether-lace Tunic" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guerrera de encaje abisal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9515;
-- AC datas : OLD Name : "Runa corrupta", Name AC enUS : "Tainted Memorandum" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Memorándum corrupto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 9577;
-- AC datas : OLD Name : "Jarra de Nori", Name AC enUS : "Nori's Mug" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Taza de Nori', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10440;
-- AC datas : OLD Description : "Cuando coges este objeto tu corazón se siente ligero.", Description AC enUS : "Your heart feels light when you hold this item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Al tocar este objeto, tu corazón se siente ligero.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10458;
-- AC datas : OLD Description : "La llama nunca muere.", Description AC enUS : "The flame never falters" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'La llama nunca muere', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10515;
-- AC datas : OLD Description : "Lleva la marca de Kalaran el Falsario.", Description AC enUS : "Bears the mark of Kalaran the Deceiver" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Lleva la marca de Velarok el Falsario.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10569;
-- AC datas : OLD Description : "Un parche gris pálido de piel de dragón negro.", Description AC enUS : "A dull and gray patch of black dragon skin" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Un parche gris pálido de piel de dragón Negro.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10575;
-- AC datas : OLD Name : "Fragmento de Afrasa", Name AC enUS : "Shard of Afrasa" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Fragmento de los Pezuña Quebrada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10659;
-- AC datas : OLD Name : "Dirk fuerza de vida", Name AC enUS : "Lifeforce Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de fuerza de vida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10750;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10920;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison III" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente III', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10921;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison IV" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente IV', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10922;
-- AC datas : OLD Name : "Collar de Nida", Name AC enUS : "Hilary's Necklace" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Collar de Hilary', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 10958;
-- AC datas : OLD Name : "Llave Sombratiniebla", Name AC enUS : "Shadowforge Key" ; Wowhead enUS : "",  OLD Description : "Maestro de la llave de las Profundidades, Cortesía de F.F.F.", Description AC enUS : "Master Key to the Depths, Courtesy of F.F.F." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Llave de Forjatiniebla', `Description` = 'Llave maestra de las Profundidades, Cortesía de F.F.F.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11000;
-- AC datas : OLD Name : "Fórmula: encantar brazales: esquivar inferior", Name AC enUS : "Formula: Enchant Bracer - Lesser Deflection" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente unos brazales para aumentar el índice de esquivar 3 p.", Description AC enUS : "Teaches you how to permanently enchant bracers to increase defense rating by 3." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar brazal: desvío inferior', `Description` = 'Te enseña a encantar de forma permanente un brazal para aumentar el índice de defensa 3 p.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11163;
-- AC datas : OLD Name : "Fórmula: encantar escudo: parada inferior", Name AC enUS : "Formula: Enchant Shield - Lesser Block" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente un escudo para aumentar el índice de parada 10 p.", Description AC enUS : "Teaches you how to permanently enchant a shield to increase block rating by 10." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar escudo: bloqueo inferior', `Description` = 'Te enseña a encantar de forma permanente un escudo para aumentar el índice de bloqueo 10 p.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11168;
-- AC datas : OLD Name : "Fórmula: encantar brazales: esquivar", Name AC enUS : "Formula: Enchant Bracer - Deflection" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente unos brazales para aumentar el índice de esquivar 5 p.", Description AC enUS : "Teaches you how to permanently enchant bracers to increase defense rating by 5." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar brazal: desvío', `Description` = 'Te enseña a encantar de forma permanente un brazal para aumentar el índice de defensa 5 p.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11223;
-- AC datas : OLD Description : "Un parche gris pálido de piel de dragón negro.", Description AC enUS : "A dull and gray patch of black dragon skin" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Un parche gris pálido de piel de dragón Negro.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11231;
-- AC datas : OLD Name : "Zapatillas de Maestro de Juego", Name AC enUS : "Gamemaster's Slippers" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Zapatillas de maestro de juego', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 11508;
-- AC datas : OLD Name : "Caperuza de Maestro de Juego", Name AC enUS : "Gamemaster Hood" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Caperuza de maestro de juego', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12064;
-- AC datas : OLD Name : "Dirk temerario", Name AC enUS : "Daring Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla temeraria', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12248;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12302;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12303;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12330;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12351;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12353;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12354;
-- AC datas : OLD Name : "Gambito de Alexi", Name AC enUS : "Dawn's Gambit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Gambito del Alba', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12368;
-- AC datas : OLD Name : "Desollador de Finkle", Name AC enUS : "Finkle's Skinner" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Despellejador de Pip', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 12709;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13086;
-- AC datas : OLD Name : "Tabaco de calidad de Siabi", Name AC enUS : "Siabi's Premium Tobacco" ; Wowhead enUS : "",  OLD Description : "Lleva la marca de Fras Siabi.", Description AC enUS : "Bears the mark of Fras Siabi." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tabaco de calidad de Grimm', `Description` = 'Lleva la marca de Ezra Grimm.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13172;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13317;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13326;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13327;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13328;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13329;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13334;
-- AC datas : OLD Description : "Te enseña a invocar el corcel del Barón Osahendido.", Description AC enUS : "Teaches you how to summon Baron Rivendare's steed.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar el corcel del Barón Osahendido. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13335;
-- AC datas : OLD Name : "Anuncio de Fras Siabi", Name AC enUS : "Fras Siabi's Advertisement" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Anuncio de Ezra Grimm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13364;
-- AC datas : OLD Name : "Musgopena", Name AC enUS : "Plaguebloom" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Flor de plaga', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13466;
-- AC datas : OLD Name : "Receta: piedra de alquimista", Name AC enUS : "Recipe: Alchemist's Stone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Receta: Piedra de alquimista', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13517;
-- AC datas : OLD Name : "Espaldares con grabados de ácido", Name AC enUS : "Acid-etched Pauldrons" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Espaldares grabados con ácido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13533;
-- AC datas : OLD Description : "Te enseña a crear un cinturón de cuero con gemas incrustadas.", Description AC enUS : "Teaches you how to craft a Gem-studded Leather Belt." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a fabricar un cinturón de cuero con gemas incrustadas.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 14635;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 15292;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 15293;
-- AC datas : OLD Name : "Báculo de paño de ascuas", Name AC enUS : "Embersilk Stave" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Báculo de seda de ascuas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 15979;
-- AC datas : OLD Name : "Esquema estropeado: proyectiles de torio", Name AC enUS : "Schematic: Thorium Shells" ; Wowhead enUS : "",  OLD Description : "", Description AC enUS : "Teaches you how to make Thorium Shells." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esquema: proyectiles de torio', `Description` = 'Te enseña a hacer unos proyectiles de torio.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16051;
-- AC datas : OLD Name : "Pedido de Morris", Name AC enUS : "Podrig's Order" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Orden de Podrig', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16209;
-- AC datas : OLD Name : "Libro de recetas de Dolanaar", Name AC enUS : "Nessa's Collection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Colección de Nessa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16262;
-- AC datas : OLD Name : "Nota de la hermana Aquinne", Name AC enUS : "Laird's Response" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Respuesta de Laird', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16263;
-- AC datas : OLD Name : "Carnes de Grimtak", Name AC enUS : "Zargh's Meats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Carne de Zargh', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16306;
-- AC datas : OLD Name : "Lista de Gremlock", Name AC enUS : "Brock's List" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lista de Brock', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16310;
-- AC datas : OLD Name : "Abrazadera de cuero de Guardia de sangre", Name AC enUS : "Blood Guard's Leather Vices" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Abrazaderas de cuero de Guardia de sangre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16499;
-- AC datas : OLD Name : "Sangre de dragón negro Campeón", Name AC enUS : "Blood of the Black Dragon Champion" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sangre de dragón Negro Campeón', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16663;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Intenta eliminar 1 efecto de enfurecer y 1 efecto mágico de un objetivo enemigo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16665;
-- AC datas : OLD Name : "Estandarte de Senani", Name AC enUS : "Karang's Banner" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Estandarte de Karang', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 16972;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Fortitude (Rank 1)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Rezo de entereza (Rango 1).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17413;
-- AC datas : OLD Name : "Códice: Rezo de Entereza", Name AC enUS : "Codex: Prayer of Fortitude II" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Fortitude (Rank 2)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice: Rezo de entereza II', `Description` = 'Enseña Rezo de entereza (Rango 2).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17414;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Gift of the Wild (Rank 1)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Don de lo Salvaje (Rango 1).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17682;
-- AC datas : OLD Name : "Libro: Don de lo Salvaje", Name AC enUS : "Book: Gift of the Wild II" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Gift of the Wild (Rank 2)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Libro: Don de lo Salvaje II', `Description` = 'Enseña Don de lo Salvaje (Rango 2).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17683;
-- AC datas : OLD Name : "Dirk de calcinita", Name AC enUS : "Charstone Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de calcinita', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17710;
-- AC datas : OLD Name : "Barra de elementium encantado", Name AC enUS : "Elementium Bar" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Barra de elementium', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17771;
-- AC datas : OLD Name : "Criminosa", Name AC enUS : "Lasher Root" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Raíz de azotador', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18224;
-- AC datas : OLD Name : "Foto autografiada de Foror y Tigule", Name AC enUS : "Autographed Picture of Foror & Tigule" ; Wowhead enUS : "",  OLD Description : "El misterio aún no se ha resuelto.", Description AC enUS : "The mystery remains unsolved." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Foto autografiada de Tigule', `Description` = 'O es una firma, o es una mancha de tinta muy artística.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18228;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18241;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18242;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18243;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18244;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18245;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18246;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18247;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18248;
-- AC datas : OLD Name : "Vial derretido", Name AC enUS : "Imbued Vial" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vial imbuido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18256;
-- AC datas : OLD Name : "Compendio de matar dragones de Foror", Name AC enUS : "Foror's Compendium of Dragon Slaying" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Compendio de matar dragones de Nostro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18401;
-- AC datas : OLD Name : "Lingote de elementium", Name AC enUS : "Elementium Ore" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Mena de elementium', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18562;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Arcane Brilliance (Rank 1)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Luminosidad Arcana (Rango 1).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18600;
-- AC datas : OLD Name : "Tendón de dragón azul maduro", Name AC enUS : "Mature Blue Dragon Sinew" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tendón de dragón Azul maduro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18704;
-- AC datas : OLD Name : "Tendón de dragón negro maduro", Name AC enUS : "Mature Black Dragon Sinew" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tendón de dragón Negro maduro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18705;
-- AC datas : OLD Name : "Tendón de dragón negro encantado", Name AC enUS : "Enchanted Black Dragon Sinew" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tendón de dragón Negro encantado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18724;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18766;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18767;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18768;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18772;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18773;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18774;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18776;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18777;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18778;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18785;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18786;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18787;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18788;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18789;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18790;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18791;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18793;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18794;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18795;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18796;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18797;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18798;
-- AC datas : OLD Name : "Draga de lava de Finkle", Name AC enUS : "Finkle's Lava Dredger" ; Wowhead enUS : "",  OLD Description : "Propiedad de Finkle Einhorn, gran maestro aventurero.", Description AC enUS : "Property of Finkle Einhorn, Grandmaster Adventurer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Draga de lava hipertérmicamente aislada', `Description` = 'Propiedad de Pip Perspicaz, gran maestro aventurero', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18803;
-- AC datas : OLD Name : "Dirk de Gran mariscal", Name AC enUS : "Grand Marshal's Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de Gran mariscal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18838;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18902;
-- AC datas : OLD Name : "Pellejo de yeti Cicatriz Feral", Name AC enUS : "Rage Scar Yeti Hide" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pellejo de yeti Cicatriz de Rabia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18947;
-- AC datas : OLD Name : "Piedra de salud", Name AC enUS : "Minor Healthstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de salud menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19004;
-- AC datas : OLD Name : "Piedra de salud", Name AC enUS : "Minor Healthstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de salud menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19005;
-- AC datas : OLD Name : "Fuegos artificiales con forma de culebra", Name AC enUS : "Snake Burst Firework" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fuegos artificiales serpenteantes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19026;
-- AC datas : OLD Name : "Esquema: fuegos artificiales con forma de culebra", Name AC enUS : "Schematic: Snake Burst Firework" ; Wowhead enUS : "",  OLD Description : "Te enseña a hacer fuegos artificiales con forma de culebra.", Description AC enUS : "Teaches you how to make a Snake Burst Firework." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esquema: fuegos artificiales serpenteantes', `Description` = 'Te enseña a hacer fuegos artificiales serpenteantes.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19027;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19029;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19030;
-- AC datas : OLD Name : "Vale para la Feria de la Luna Negra destrozado", Name AC enUS : "Darkmoon Faire Prize Ticket" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vale de la Feria de la Luna Negra', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19182;
-- AC datas : OLD Name : "Naipe de la Luna Negra: Dragón azul", Name AC enUS : "Darkmoon Card: Blue Dragon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Naipe de la Luna Negra: Dragón Azul', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19288;
-- AC datas : OLD Description : "Encontrarás la felicidad con un nuevo amor.", Description AC enUS : "Your fortune awaits you inside the Deadmines." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'La Fortuna te espera en Las Minas de la Muerte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19424;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente unos brazales para aumentar el espíritu 9 p.", Description AC enUS : "Teaches you how to permanently enchant bracers to restore 5 mana every 5 seconds." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente unos brazales para restaurar 5 p. de maná cada 5 s.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19446;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon Bloodlord Mandokir's raptor.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar al raptor del Señor sangriento Mandokir. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19872;
-- AC datas : OLD Description : "Te enseña a invocar al tigre del sumo sacerdote Thekal.", Description AC enUS : "Teaches you how to summon High Preist Thekal's tiger.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar al tigre del sumo sacerdote Thekal. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19902;
-- AC datas : OLD Name : "Parche del ojo de Foror", Name AC enUS : "Foror's Eyepatch" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Parche para ojo de escamas de lagarto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19945;
-- AC datas : OLD Name : "Flayed Demon Skin [Depricated]", Name AC enUS : "Flayed Demon Skin" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piel de demonio despellejada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20310;
-- AC datas : OLD Name : "Máscara de gnomo", Name AC enUS : "Flimsy Male Gnome Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de gnomo endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20391;
-- AC datas : OLD Name : "Máscara de gnoma", Name AC enUS : "Flimsy Female Gnome Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de gnoma endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20392;
-- AC datas : OLD Name : "Pastilla de goma Lanza Negra", Name AC enUS : "Darkspear Gumdrop" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Gominola Lanza Negra', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20495;
-- AC datas : OLD Name : "Máscara de enano", Name AC enUS : "Flimsy Male Dwarf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de enano endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20561;
-- AC datas : OLD Name : "Máscara de enana", Name AC enUS : "Flimsy Female Dwarf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de enana endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20562;
-- AC datas : OLD Name : "Máscara de elfa de la noche", Name AC enUS : "Flimsy Female Night Elf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de elfa de la noche endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20563;
-- AC datas : OLD Name : "Máscara de elfo de la noche", Name AC enUS : "Flimsy Male Night Elf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de elfo de la noche endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20564;
-- AC datas : OLD Name : "Máscara de humana", Name AC enUS : "Flimsy Female Human Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de humana endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20565;
-- AC datas : OLD Name : "Máscara de humano", Name AC enUS : "Flimsy Male Human Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de humano endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20566;
-- AC datas : OLD Name : "Máscara de trol hembra", Name AC enUS : "Flimsy Female Troll Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de trol hembra endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20567;
-- AC datas : OLD Name : "Máscara de trol macho", Name AC enUS : "Flimsy Male Troll Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de trol macho endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20568;
-- AC datas : OLD Name : "Máscara de orco hembra", Name AC enUS : "Flimsy Female Orc Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de orco hembra endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20569;
-- AC datas : OLD Name : "Máscara de orco macho", Name AC enUS : "Flimsy Male Orc Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de orco endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20570;
-- AC datas : OLD Name : "Máscara de tauren hembra", Name AC enUS : "Flimsy Female Tauren Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de tauren hembra endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20571;
-- AC datas : OLD Name : "Máscara de tauren macho", Name AC enUS : "Flimsy Male Tauren Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de tauren macho endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20572;
-- AC datas : OLD Name : "Máscara de no-muerto", Name AC enUS : "Flimsy Male Undead Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de no-muerto endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20573;
-- AC datas : OLD Name : "Máscara de no-muerta", Name AC enUS : "Flimsy Female Undead Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de no-muerta endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20574;
-- AC datas : OLD Name : "Capa de piel de dragón verde", Name AC enUS : "Green Dragonskin Cloak" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Capa de piel de dragón Verde', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20579;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente una capa para aumentar la agilidad y el índice de esquivar 8 p.", Description AC enUS : "Teaches you how to permanently enchant a cloak to increase stealth." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente una capa para que aumente el sigilo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20734;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison V" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal V', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20844;
-- AC datas : OLD Name : "Dirk forjado de Arcano", Name AC enUS : "Arcane Forged Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla forjada de Arcano', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 20852;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21176;
-- AC datas : OLD Name : "Escrito sobre Descarga de Escarcha", Name AC enUS : "Tome of Frostbolt XI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Frostbolt (Rank 11)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Descarga de Escarcha XI', `Description` = 'Enseña Descarga de Escarcha (Rango 11).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21214;
-- AC datas : OLD Name : "Escrito sobre Bola de Fuego", Name AC enUS : "Tome of Fireball XII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Fireball (Rank 12)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Bola de Fuego XII', `Description` = 'Enseña Bola de Fuego (Rango 12).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21279;
-- AC datas : OLD Name : "Escrito sobre Misiles Arcanos", Name AC enUS : "Tome of Arcane Missiles VIII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Arcane Missiles (Rank 8)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Misiles Arcanos VIII', `Description` = 'Enseña Misiles Arcanos (Rango 8).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21280;
-- AC datas : OLD Name : "Grimorio Descarga de las Sombras", Name AC enUS : "Grimoire of Shadow Bolt X" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Shadow Bolt (Rank 10)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Grimorio Descarga de las Sombras X', `Description` = 'Enseña Descarga de las Sombras (Rango 10).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21281;
-- AC datas : OLD Name : "Grimorio Inmolar", Name AC enUS : "Grimoire of Immolate VIII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Immolate (Rank 8)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Grimorio Inmolar VIII', `Description` = 'Enseña Inmolar (Rango 8).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21282;
-- AC datas : OLD Name : "Grimorio Corrupción", Name AC enUS : "Grimoire of Corruption VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Corruption (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Grimorio Corrupción VII', `Description` = 'Enseña Corrupción (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21283;
-- AC datas : OLD Name : "Códice de Sanación superior", Name AC enUS : "Codex of Greater Heal V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Greater Heal (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice de Sanación superior V', `Description` = 'Enseña Sanación superior (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21284;
-- AC datas : OLD Name : "Códice de Renovar", Name AC enUS : "Codex of Renew X" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Renew (Rank 10)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice de Renovar X', `Description` = 'Enseña Renovar (Rango 10).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21285;
-- AC datas : OLD Name : "Códice de Rezo de sanación", Name AC enUS : "Codex of Prayer of Healing V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Healing (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice de Rezo de sanación V', `Description` = 'Enseña Rezo de sanación (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21287;
-- AC datas : OLD Name : "Tratado: Bendición de sabiduría", Name AC enUS : "Libram: Blessing of Wisdom VI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Blessing of Wisdom (Rank 6)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tratado: Bendición de sabiduría VI', `Description` = 'Enseña Bendición de sabiduría (Rango 6).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21288;
-- AC datas : OLD Name : "Tratado: Bendición de poderío", Name AC enUS : "Libram: Blessing of Might VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Blessing of Might (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tratado: Bendición de poderío VII', `Description` = 'Enseña Bendición de poderío (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21289;
-- AC datas : OLD Name : "Tratado: Luz Sagrada", Name AC enUS : "Libram: Holy Light IX" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Holy Light (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tratado: Luz Sagrada IX', `Description` = 'Enseña Luz Sagrada (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21290;
-- AC datas : OLD Name : "Tablilla de Ola de sanación", Name AC enUS : "Tablet of Healing Wave X" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Healing Wave (Rank 10)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tablilla de Ola de sanación X', `Description` = 'Enseña Ola de sanación (Rango 10).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21291;
-- AC datas : OLD Name : "Tablilla de Tótem Fuerza de la tierra", Name AC enUS : "Tablet of Strength of Earth Totem V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Strength of Earth Totem (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tablilla de Tótem Fuerza de la tierra V', `Description` = 'Enseña Tótem Fuerza de la tierra (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21292;
-- AC datas : OLD Name : "Tablilla de Tótem Gracia del Aire", Name AC enUS : "Tablet of Grace of Air Totem III" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Grace of Air Totem (Rank 3)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tablilla de Tótem Gracia del Aire III', `Description` = 'Enseña Tótem Gracia del aire (Rango 3).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21293;
-- AC datas : OLD Name : "Libro sobre Toque de sanación", Name AC enUS : "Book of Healing Touch XI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Healing Touch (Rank 11)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Libro sobre Toque de sanación XI', `Description` = 'Enseña Toque de sanación (Rango 11).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21294;
-- AC datas : OLD Name : "Libro sobre Fuego estelar", Name AC enUS : "Book of Starfire VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Starfire (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Libro sobre Fuego estelar VII', `Description` = 'Enseña Fuego estelar (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21295;
-- AC datas : OLD Name : "Libro sobre Rejuvenecimiento", Name AC enUS : "Book of Rejuvenation XI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Rejuvenation (Rank 11)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Libro sobre Rejuvenecimiento XI', `Description` = 'Enseña Rejuvenecimiento (Rango 11).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21296;
-- AC datas : OLD Name : "Manual de Golpe Heroico", Name AC enUS : "Manual of Heroic Strike IX" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Heroic Strike (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Manual de Golpe heroico IX', `Description` = 'Enseña Golpe heroico (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21297;
-- AC datas : OLD Name : "Manual de Grito de batalla", Name AC enUS : "Manual of Battle Shout VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Battle Shout (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Manual de Grito de batalla VII', `Description` = 'Enseña Grito de batalla (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21298;
-- AC datas : OLD Name : "Manual de Revancha", Name AC enUS : "Manual of Revenge VI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Revenge (Rank 6)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Manual de Revancha VI', `Description` = 'Enseña Revancha (Rango 6).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21299;
-- AC datas : OLD Name : "Vademécum de Puñalada", Name AC enUS : "Handbook of Backstab IX" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Backstab (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vademécum de Puñalada IX', `Description` = 'Enseña Puñalada (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21300;
-- AC datas : OLD Name : "Vademécum de Veneno mortal", Name AC enUS : "Handbook of Deadly Poison V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Deadly Poison (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vademécum de Veneno mortal V', `Description` = 'Enseña Veneno mortal (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21302;
-- AC datas : OLD Name : "Vademécum de Amago", Name AC enUS : "Handbook of Feint V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Feint (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vademécum de Amago V', `Description` = 'Enseña Amago (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21303;
-- AC datas : OLD Name : "Guía: Multidisparo", Name AC enUS : "Guide: Multi-Shot V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Multi-Shot (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guía: Multidisparo V', `Description` = 'Enseña Multidisparo (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21304;
-- AC datas : OLD Name : "Guía: Picadura de serpiente", Name AC enUS : "Guide: Serpent Sting IX" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Serpent Sting (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guía: Picadura de serpiente IX', `Description` = 'Enseña Picadura de serpiente (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21306;
-- AC datas : OLD Name : "Guía: Aspecto del halcón", Name AC enUS : "Guide: Aspect of the Hawk VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Aspect of the Hawk (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guía: Aspecto del halcón VII', `Description` = 'Enseña Aspecto del halcón (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21307;
-- AC datas : OLD Description : "Consumir antes de 2012", Description AC enUS : "Use before 2010" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Usar antes de la fecha de caducidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21545;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison VII" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo VII', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21927;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison VI" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal VI', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22053;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison VII" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal VII', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22054;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison V" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente V', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22055;
-- AC datas : OLD Name : "Libro: Don de lo Salvaje", Name AC enUS : "Book: Gift of the Wild III" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Gift of the Wild (Rank 3)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Libro: Ofrenda de la fieras III', `Description` = 'Enseña Don de lo Salvaje (Rango 3).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22146;
-- AC datas : OLD Name : "Escrito sobre Luminosidad Arcana", Name AC enUS : "Tome of Arcane Brilliance 2" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Arcane Brilliance (Rank 2)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Resplandor Arcano 2', `Description` = 'Enseña Luminosidad Arcana (Rango 2).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22153;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22345;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Shadow Protection (Rank 1)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Rezo de Protección contra las Sombras (Rango 1).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22393;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22395;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22396;
-- AC datas : OLD Name : "Collar de perlas de Diana", Name AC enUS : "Diana's Pearl Necklace" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Collar de caparazones nacarados', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22403;
-- AC datas : OLD Name : "Fórmula: encantar brazales: esquivar superior", Name AC enUS : "Formula: Enchant Bracer - Major Defense" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente unos brazales para aumentar el índice de esquivar 12 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant bracers to increase defense rating by 12.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar brazal: defensa sublime', `Description` = 'Te enseña a encantar de forma permanente un brazal para aumentar el índice de defensa 12 p. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22530;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente unos brazales para aumentar el espíritu 12 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant bracers to restore 8 mana every 5 seconds.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente unos brazales para restaurar 8 p. de maná cada 5 s. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22532;
-- AC datas : OLD Name : "Fórmula: encantar escudo: parar", Name AC enUS : "Formula: Enchant Shield - Shield Block" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente un escudo para aumentar el índice de parada 15 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant a shield to increase block rating by 15.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar escudo: bloquear con escudo', `Description` = 'Te enseña a encantar de forma permanente un escudo para aumentar el índice de bloqueo 15 p. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22540;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente unas botas para aumentar el espíritu y el aguante 10 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant boots to restore 5 health and mana every 5 seconds.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente unas botas para restaurar 5 p. de maná y salud cada 5 s. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22542;
-- AC datas : OLD Name : "Solicitud de Sathiel", Name AC enUS : "Quartermaster Lymel's Bill of Lading" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Nota de embarque del intendente Lymel', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22549;
-- AC datas : OLD Name : "Bienes de Sathiel", Name AC enUS : "Quartermaster Lymel's Goods" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Bienes del intendente Lymel', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22550;
-- AC datas : OLD Name : "Abrazadera de anillas de Guardia de sangre", Name AC enUS : "Blood Guard's Chain Vices" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Abrazaderas de anillas de Guardia de sangre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22862;
-- AC datas : OLD Name : "Abrazadera de malla de Guardia de sangre", Name AC enUS : "Blood Guard's Mail Vices" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Abrazaderas de malla de Guardia de sangre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22867;
-- AC datas : OLD Name : "Escrito sobre Resguardo contra la Escarcha", Name AC enUS : "Tome of Frost Ward V" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Frost Ward (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Resguardo contra la Escarcha V', `Description` = 'Enseña Resguardo contra la Escarcha (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22890;
-- AC datas : OLD Name : "Grimorio Resguardo contra las Sombras", Name AC enUS : "Grimoire of Shadow Ward IV" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Shadow Ward (Rank 4)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Grimorio Resguardo contra las Sombras IV', `Description` = 'Enseña Resguardo contra las Sombras (Rango 4).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22891;
-- AC datas : OLD Name : "Escrito sobre Crear comida", Name AC enUS : "Tome of Conjure Food VII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Conjure Food (Rank 7)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Crear comida VII', `Description` = 'Enseña Crear comida (Rango 7).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 22897;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23005;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23098;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23099;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23100;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23101;
-- AC datas : OLD Name : "Peridoto intenso irregular", Name AC enUS : "Jagged Deep Peridot" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto intenso dentado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23104;
-- AC datas : OLD Name : "Boceto: granate de sangre luminoso", Name AC enUS : "Design: Teardrop Blood Garnet" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un granate de sangre luminoso.", Description AC enUS : "Teaches you how to cut a Teardrop Blood Garnet." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Lágrima de granate de sangre', `Description` = 'Te enseña a tallar una Lágrima de granate de sangre.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23130;
-- AC datas : OLD Name : "Boceto: granate de sangre luminoso", Name AC enUS : "Design: Runed Blood Garnet" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un granate de sangre luminoso.", Description AC enUS : "Teaches you how to cut a Runed Blood Garnet." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: granate de sangre rúnico', `Description` = 'Te enseña a tallar un granate de sangre rúnico.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23133;
-- AC datas : OLD Name : "Boceto: espesartita de llamas temeraria", Name AC enUS : "Design: Luminous Flame Spessarite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espesartita de llamas temeraria.", Description AC enUS : "Teaches you how to cut a Luminous Flame Spessarite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espesartita de llamas luminosa', `Description` = 'Te enseña a tallar una espesartita de llamas luminosa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23136;
-- AC datas : OLD Name : "Boceto: draenita de sombras destellante", Name AC enUS : "Design: Glinting Flame Spessarite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras destellante.", Description AC enUS : "Teaches you how to cut a Glinting Flame Spessarite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espesartita de llamas destellante', `Description` = 'Te enseña a tallar una espesartita de llamas destellante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23137;
-- AC datas : OLD Name : "Boceto: peridoto intenso regio", Name AC enUS : "Design: Enduring Deep Peridot" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un peridoto intenso regio.", Description AC enUS : "Teaches you how to cut an Enduring Deep Peridot." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: peridoto intenso duradero', `Description` = 'Te enseña a tallar un peridoto intenso duradero.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23142;
-- AC datas : OLD Name : "Boceto: draenita de sombras purificada", Name AC enUS : "Design: Dazzling Deep Peridot" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras purificada.", Description AC enUS : "Teaches you how to cut a Dazzling Deep Peridot." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: peridoto intenso deslumbrante', `Description` = 'Te enseña a tallar un peridoto intenso deslumbrante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23143;
-- AC datas : OLD Name : "Boceto: draenita de sombras intemporal", Name AC enUS : "Design: Glowing Shadow Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras intemporal.", Description AC enUS : "Teaches you how to cut a Glowing Shadow Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita de Sombras resplandeciente', `Description` = 'Te enseña a tallar una draenita de Sombras resplandeciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23144;
-- AC datas : OLD Name : "Boceto: draenita de sombras purificada", Name AC enUS : "Design: Royal Shadow Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras purificada.", Description AC enUS : "Teaches you how to cut a Royal Shadow Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita de Sombras real', `Description` = 'Te enseña a tallar una draenita de Sombras real.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23145;
-- AC datas : OLD Name : "Boceto: granate de sangre luminoso", Name AC enUS : "Design: Brilliant Golden Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un granate de sangre luminoso.", Description AC enUS : "Teaches you how to cut a Brilliant Golden Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita dorada luminosa', `Description` = 'Te enseña a tallar una draenita dorada luminosa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23148;
-- AC datas : OLD Name : "Boceto: draenita dorada lisa", Name AC enUS : "Design: Gleaming Golden Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita dorada lisa.", Description AC enUS : "Teaches you how to cut a Gleaming Golden Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita dorada reluciente', `Description` = 'Te enseña a tallar una draenita dorada reluciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23149;
-- AC datas : OLD Name : "Boceto: draenita dorada sutil", Name AC enUS : "Design: Thick Golden Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita dorada sutil.", Description AC enUS : "Teaches you how to cut a Thick Golden Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita dorada gruesa', `Description` = 'Te enseña a tallar una draenita dorada gruesa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23150;
-- AC datas : OLD Name : "Boceto: piedra lunar azur rígida", Name AC enUS : "Design: Rigid Golden Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra lunar azur rígida.", Description AC enUS : "Teaches you how to cut a Rigid Golden Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita dorada rígida', `Description` = 'Te enseña a tallar una draenita dorada rígida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23151;
-- AC datas : OLD Name : "Boceto: piedra lunar azur chispeante", Name AC enUS : "Design: Lustrous Azure Moonstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra lunar azur chispeante.", Description AC enUS : "Teaches you how to cut a Lustrous Azure Moonstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra lunar azur luciente', `Description` = 'Te enseña a tallar una piedra lunar azur luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23155;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23199;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23200;
-- AC datas : OLD Name : "Tablilla de Choque de llamas", Name AC enUS : "Tablet of Flame Shock VI" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Flame Shock (Rank 6)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tablilla de Choque de llamas VI', `Description` = 'Enseña Choque de llamas (Rango 6).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23320;
-- AC datas : OLD Description : "Un tótem de curioso aspecto con inscripciones de runas antiguas.", Description AC enUS : "An unusual looking totem with inscriptions in a language unknown to trolls." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Un tótem de curioso aspecto con inscripciones en una lengua desconocida para los trols.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23679;
-- AC datas : OLD Description : "La inscripción del tótem distingue alportador como un aliado del agua elemental Naias.", Description AC enUS : "The totem's inscription identifies the bearer as an ally of the water elemental Naias." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'La inscripción del tótem identifica al portador como un aliado del elemental de agua Naias.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23680;
-- AC datas : OLD Name : "Informe de la centinela Melyria", Name AC enUS : "Sentinel Luciel's Report" ; Wowhead enUS : "",  OLD Description : "Un informe sellado de la centinela Melyria Sombrigélida para la centinela Cantolejano.", Description AC enUS : "A sealed report written by Sentinel Luciel Starwhisper, intended for Sentinel Farsong." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Informe del centinela Luciel', `Description` = 'Un informe sellado de la centinela Luciel Susurrestelar para la centinela Cantolongo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23778;
-- AC datas : OLD Name : "Esquema estropeado", Name AC enUS : "Schematic: Adamantite Shell Machine" ; Wowhead enUS : "",  OLD Description : "Este esquema ha sido destruido por los elementos.", Description AC enUS : "Teaches you how to make an Adamantite Shell Machine." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esquema: máquina de balas de adamantita', `Description` = 'Te enseña a hacer una máquina de balas de adamantita.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23815;
-- AC datas : OLD Description : "La sangre que contiene burbujea, como si estuviera llena de rabia.", Description AC enUS : "Not quite the same shade of red as you might expect.  And it glows ever so slightly." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'No es del tono rojo que esperabas. Y brilla un poco.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23894;
-- AC datas : OLD Name : "Lista de Chellan", Name AC enUS : "Topher's List" ; Wowhead enUS : "",  OLD Description : "Una lista de objetos que necesitan con urgencia en la taberna de la Avanzada Azur.", Description AC enUS : "A list of items most urgently needed for the Blood Watch inn." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lista de Tropher', `Description` = 'Una lista de objetos que necesitan con urgencia en la Avanzada de Sangre.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23902;
-- AC datas : OLD Description : "Una caja llena de diversos materiales de construcción, suministros de primeros auxilios, así como otros artículos para la taberna de la Avanzada Azur.", Description AC enUS : "A box filled with a variety of building materials, first aid supplies, and other items for the Blood Watch inn." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Una caja llena de diversos materiales de construcción, así como otros artículos para la Avanzada de Sangre.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23903;
-- AC datas : OLD Name : "Estrella de Eluna luciente", Name AC enUS : "Lustrous Star of Elune" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Estrella de Elune luciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24037;
-- AC datas : OLD Name : "Topacio noble temerario", Name AC enUS : "Luminous Noble Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Topacio noble luminoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24060;
-- AC datas : OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24066;
-- AC datas : OLD Name : "Talasita irregular", Name AC enUS : "Jagged Talasite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Talasita dentada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24067;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Ferocious Bite (Rank 5)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Mordedura feroz (Rango 5).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24101;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Eviscerate (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Eviscerar (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24102;
-- AC datas : OLD Name : "Boceto: rubí vivo delicado", Name AC enUS : "Design: Bright Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo delicado.", Description AC enUS : "Teaches you how to cut a Bright Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí vivo brillante', `Description` = 'Te enseña a tallar un rubí vivo brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24192;
-- AC datas : OLD Name : "Boceto: rubí vivo luminoso", Name AC enUS : "Design: Teardrop Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo luminoso.", Description AC enUS : "Teaches you how to cut a Teardrop Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Lágrima de rubí vivo', `Description` = 'Te enseña a tallar una Lágrima de rubí vivo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24195;
-- AC datas : OLD Name : "Boceto: rubí vivo luminoso", Name AC enUS : "Design: Runed Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo luminoso.", Description AC enUS : "Teaches you how to cut a Runed Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí vivo rúnico', `Description` = 'Te enseña a tallar un rubí vivo rúnico.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24196;
-- AC datas : OLD Name : "Boceto: piedra del alba sutil", Name AC enUS : "Design: Subtle Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra del alba sutil.", Description AC enUS : "Teaches you how to cut a Subtle Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí vivo sutil', `Description` = 'Te enseña a tallar un rubí vivo sutil.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24197;
-- AC datas : OLD Name : "Boceto: estrella de Elune chispeante", Name AC enUS : "Design: Lustrous Star of Elune" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una estrella de Elune chispeante.", Description AC enUS : "Teaches you how to cut a Lustrous Star of Elune." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: estrella de Elune luciente', `Description` = 'Te enseña a tallar una estrella de Elune luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24201;
-- AC datas : OLD Name : "Boceto: rubí vivo luminoso", Name AC enUS : "Design: Brilliant Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo luminoso.", Description AC enUS : "Teaches you how to cut a Brilliant Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra del alba luminosa', `Description` = 'Te enseña a tallar una piedra del alba luminosa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24203;
-- AC datas : OLD Name : "Boceto: estrella de Elune rígida", Name AC enUS : "Design: Rigid Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una estrella de Elune rígida.", Description AC enUS : "Teaches you how to cut a Rigid Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra del alba rígida', `Description` = 'Te enseña a tallar una piedra del alba rígida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24205;
-- AC datas : OLD Name : "Boceto: piedra del alba lisa", Name AC enUS : "Design: Gleaming Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra del alba lisa.", Description AC enUS : "Teaches you how to cut a Gleaming Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra del alba reluciente', `Description` = 'Te enseña a tallar una piedra del alba reluciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24206;
-- AC datas : OLD Name : "Boceto: piedra del alba sutil", Name AC enUS : "Design: Thick Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra del alba sutil.", Description AC enUS : "Teaches you how to cut a Thick Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra del alba gruesa', `Description` = 'Te enseña a tallar una piedra del alba gruesa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24207;
-- AC datas : OLD Name : "Boceto: ojo de noche intemporal", Name AC enUS : "Design: Glowing Nightseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche intemporal.", Description AC enUS : "Teaches you how to cut a Glowing Nightseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de noche resplandeciente', `Description` = 'Te enseña a tallar un Ojo de noche resplandeciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24211;
-- AC datas : OLD Name : "Boceto: ojo de noche purificado", Name AC enUS : "Design: Royal Nightseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche purificado.", Description AC enUS : "Teaches you how to cut a Royal Nightseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de noche real', `Description` = 'Te enseña a tallar un Ojo de noche real.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24212;
-- AC datas : OLD Name : "Boceto: topacio noble temerario", Name AC enUS : "Design: Luminous Noble Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio noble temerario.", Description AC enUS : "Teaches you how to cut a Luminous Noble Topaz." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio noble luminoso', `Description` = 'Te enseña a tallar un topacio noble luminoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24215;
-- AC datas : OLD Name : "Boceto: ojo de noche destellante", Name AC enUS : "Design: Glinting Noble Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche destellante.", Description AC enUS : "Teaches you how to cut a Glinting Noble Topaz." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio noble destellante', `Description` = 'Te enseña a tallar un topacio noble destellante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24216;
-- AC datas : OLD Name : "Boceto: talasita regia", Name AC enUS : "Design: Enduring Talasite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una talasita regia.", Description AC enUS : "Teaches you how to cut an Enduring Talasite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: talasita duradera', `Description` = 'Te enseña a tallar una talasita duradera.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24217;
-- AC datas : OLD Name : "Boceto: ojo de noche purificado", Name AC enUS : "Design: Dazzling Talasite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche purificado.", Description AC enUS : "Teaches you how to cut a Dazzling Talasite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: talasita deslumbrante', `Description` = 'Te enseña a tallar una talasita deslumbrante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24219;
-- AC datas : OLD Description : "Parece que tiembla con poder psíquico.", Description AC enUS : "Ok, this is disgusting!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Vale, ¡esto es repugnante!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24248;
-- AC datas : OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Cower (Rank 4)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enseña Agazapar (Rango 4).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24345;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24413;
-- AC datas : OLD Description : "Un pellejo grueso con escamas de un descarnador Zarpacieno.", Description AC enUS : "A thick, scaly hide from a muckclaw thrasher" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Un pellejo grueso con escamas de un vándalo lodoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24486;
-- AC datas : OLD Description : "Pesa más de lo que pensabas.", Description AC enUS : "Looks like you'll need your friend's help to carry this one back to the camp." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Parece que necesitarás la ayuda de tus amigos para llevar esto hasta el campamento.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 24505;
-- AC datas : OLD Name : "Cetro de ascendente", Name AC enUS : "Ascendant's Scepter" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cetro de ascendiente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25323;
-- AC datas : OLD Name : "Escama con mugre incrustada", Name AC enUS : "Grime-encrusted Scale" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escama sucia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25429;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25470;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25471;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25472;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25473;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25474;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25475;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25476;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25477;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25527;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25528;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25529;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25531;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25532;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25533;
-- AC datas : OLD Name : "Dirk de talbuk", Name AC enUS : "Talbuk Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de talbuk', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25545;
-- AC datas : OLD Name : "Galochas manchadas de lodo", Name AC enUS : "Muck-ridden Galoshes" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Galochas cubiertas de barro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25561;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25645;
-- AC datas : OLD Name : "Ídolo de la bestia obsoleto", Name AC enUS : "ObsoleteIdol of the Beast" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ídolo de la bestia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25667;
-- AC datas : OLD Name : "Abrazadera de minero", Name AC enUS : "Miner's Brace" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guatas de minero', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 25984;
-- AC datas : OLD Name : "Guerrera forrada de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Tunic" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guerrera forrada de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26005;
-- AC datas : OLD Name : "Puños forrados de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Cuffs" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puños forrados de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26014;
-- AC datas : OLD Name : "Jubón forrado de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Vest" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Jubón forrado de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26019;
-- AC datas : OLD Name : "Braciles forrados de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Bands" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Braciles forrados de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26028;
-- AC datas : OLD Name : "Camisote forrado de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Hauberk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Camisote forrado de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26030;
-- AC datas : OLD Name : "Brazales forrados de hongos de Jessera", Name AC enUS : "Jessera's Fungus Lined Bracers" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brazales forrados de hongos de Maatparm', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 26040;
-- AC datas : OLD Description : "Esta pieza de armadura ha sido transmitida a través de once generaciones de jefes Lobo Gélido.", Description AC enUS : "This is a legacy chest piece worn by Frostwolf chieftans for eleven generations." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Esta pieza de armadura ha sido transmitida a través de once generaciones de jefes de Lobo Gélido.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27427;
-- AC datas : OLD Description : "Si lo miras detenidamente, puedes ver algo girando alrededor.", Description AC enUS : "If you look closely enough, you can see something swirling around in it.  Creepy." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Si lo miras detenidamente, puedes ver algo girando alrededor. Chungo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27480;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27544;
-- AC datas : OLD Description : "¡Las mascotas odian los aperitivos de esporinos!", Description AC enUS : "Pets love sporeling snacks!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡A las mascotas les encantan los aperitivos de esporinos!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27656;
-- AC datas : OLD Name : "Piedra del alba mística", Name AC enUS : "Sublime Mystic Dawnstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra del alba sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27679;
-- AC datas : OLD Name : "Receta estropeada", Name AC enUS : "Recipe: Sporeling Snack" ; Wowhead enUS : "",  OLD Description : "", Description AC enUS : "Teaches you how to cook a Sporeling Snack." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Receta: tentempié de esporino', `Description` = 'Te enseña a hacer tentempié de esporino.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27689;
-- AC datas : OLD Name : "Granate de sangre luminoso", Name AC enUS : "Stark Blood Garnet" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Granate de sangre completo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27777;
-- AC datas : OLD Name : "Peridoto intenso dentado", Name AC enUS : "Notched Deep Peridot" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto intenso con muesca', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27785;
-- AC datas : OLD Name : "Peridoto intenso dentado", Name AC enUS : "Barbed Deep Peridot" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto intenso mordaz', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27786;
-- AC datas : OLD Name : "Peridoto intenso dentado", Name AC enUS : "Barbed Deep Peridot" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto intenso mordaz', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27809;
-- AC datas : OLD Name : "Granate de sangre luminoso", Name AC enUS : "Stark Blood Garnet" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Granate de sangre completo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27812;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27815;
-- AC datas : OLD Name : "Peridoto intenso dentado", Name AC enUS : "Notched Deep Peridot" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto intenso con muesca', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27820;
-- AC datas : OLD Name : "Brianita de coste extendido", Name AC enUS : "Extended Cost Bryanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brianita de Bryan de coste extendido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27863;
-- AC datas : OLD Name : "Brianita copiadora de coste extendido", Name AC enUS : "Brian's Bryanite of Extended Cost Copying" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brianita de Bryan de coste extendido copia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27864;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27947;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 27984;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28066;
-- AC datas : OLD Name : "Rubí ornamentado luminoso", Name AC enUS : "Runed Ornate Ruby" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Rubí rúnico ornamentado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28118;
-- AC datas : OLD Name : "Piedra del alba ornamentada lisa", Name AC enUS : "Gleaming Ornate Dawnstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra del alba ornamentada reluciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28120;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28248;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28357;
-- AC datas : OLD Name : "Granate de sangre delicado", Name AC enUS : "Mighty Blood Garnet" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Granate de sangre poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28360;
-- AC datas : OLD Name : "Granate de sangre delicado", Name AC enUS : "Mighty Blood Garnet" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Granate de sangre poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28361;
-- AC datas : OLD Name : "Rubí ornamentado delicado", Name AC enUS : "Bold Ornate Ruby" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Rubí ornamentado llamativo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28362;
-- AC datas : OLD Name : "Topacio ornamentado mortal", Name AC enUS : "Inscribed Ornate Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Topacio ornamentado con inscripciones', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28363;
-- AC datas : OLD Name : "Turmalina luminosa", Name AC enUS : "Teardrop Tourmaline" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lágrima de turmalina', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28460;
-- AC datas : OLD Name : "Turmalina luminosa", Name AC enUS : "Runed Tourmaline" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Turmalina rúnica', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28461;
-- AC datas : OLD Name : "Turmalina delicada", Name AC enUS : "Bright Tourmaline" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Turmalina brillante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28462;
-- AC datas : OLD Name : "Circón chispeante", Name AC enUS : "Lustrous Zircon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Circón lustroso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28465;
-- AC datas : OLD Name : "Turmalina luminosa", Name AC enUS : "Brilliant Amber" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ámbar luminoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28466;
-- AC datas : OLD Name : "Circón rígido", Name AC enUS : "Rigid Amber" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ámbar rígido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28468;
-- AC datas : OLD Name : "Ámbar liso", Name AC enUS : "Gleaming Amber" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ámbar reluciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28469;
-- AC datas : OLD Name : "Ámbar sutil", Name AC enUS : "Thick Amber" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ámbar grueso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28470;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28482;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28523;
-- AC datas : OLD Name : "Diamante Fuego Estelar raudo", Name AC enUS : "Swift Starfire Diamond" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Diamante fuego estelar de velocidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28557;
-- AC datas : OLD Name : "Boceto: granate de sangre delicado", Name AC enUS : "Design: Bright Blood Garnet" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un granate de sangre delicado.", Description AC enUS : "Teaches you how to cut a Bright Blood Garnet." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: granate de sangre brillante', `Description` = 'Te enseña a tallar un granate de sangre brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28596;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28915;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 28936;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29102;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29103;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29104;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29105;
-- AC datas : OLD Name : "Dirk de piedra equilibrada", Name AC enUS : "Balanced Stone Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de piedra equilibrada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29212;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29223;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29224;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29227;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29228;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29229;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29230;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29231;
-- AC datas : OLD Name : "Autoesquivador 600 de Gnomeregan", Name AC enUS : "Gnomeregan Auto-Blocker 600" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Autobloqueador 600 de Gnomeregan', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29387;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29389;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29465;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29466;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29467;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29469;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29470;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29471;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29472;
-- AC datas : OLD Name : "Códice: Rezo de Entereza", Name AC enUS : "Codex: Prayer of Fortitude III" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Fortitude (Rank 3)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice: Rezo de Entereza III', `Description` = 'Enseña Rezo de entereza (Rango 3).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29549;
-- AC datas : OLD Name : "Escrito sobre Crear agua", Name AC enUS : "Tome of Conjure Water IX" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Conjure Water (Rank 9)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Crear agua IX', `Description` = 'Te enseña a crear agua (Rango 9).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29550;
-- AC datas : OLD Name : "Tripas de basilisco", Name AC enUS : "Basilisk Liver" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Hígado de basilisco', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29553;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29745;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29746;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29747;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30023;
-- AC datas : OLD Name : "Cola de crocolisco incomible", Name AC enUS : "Crocolisk Tail" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cola de crocolisco', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30467;
-- AC datas : OLD Description : "Te enseña a invocar el corcel de Attumen el Montero.", Description AC enUS : "Teaches you how to summon Attumen the Huntsman's steed.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar el corcel de Attumen el Montero. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30480;
-- AC datas : OLD Name : "Ópalo de fuego temerario", Name AC enUS : "Luminous Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego luminoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30547;
-- AC datas : OLD Name : "Crisoprasa dentada", Name AC enUS : "Polished Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa pulida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30548;
-- AC datas : OLD Name : "Crisoprasa brumosa", Name AC enUS : "Sundered Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa partida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30550;
-- AC datas : OLD Name : "Ópalo de fuego temerario", Name AC enUS : "Infused Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego imbuido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30551;
-- AC datas : OLD Name : "Tanzanita intemporal", Name AC enUS : "Blessed Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita bendecida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30552;
-- AC datas : OLD Name : "Tanzanita destellante", Name AC enUS : "Pristine Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego prístino', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30553;
-- AC datas : OLD Name : "Tanzanita intemporal", Name AC enUS : "Glowing Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita resplandeciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30555;
-- AC datas : OLD Name : "Tanzanita destellante", Name AC enUS : "Glinting Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego destellante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30556;
-- AC datas : OLD Name : "Ópalo de fuego de adepto", Name AC enUS : "Glimmering Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego de luz trémula', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30558;
-- AC datas : OLD Name : "Tanzanita con grabados", Name AC enUS : "Etched Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego grabado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30559;
-- AC datas : OLD Name : "Crisoprasa brumosa", Name AC enUS : "Rune Covered Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa cubierta de runas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30560;
-- AC datas : OLD Name : "Crisoprasa regia", Name AC enUS : "Regal Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita regia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30563;
-- AC datas : OLD Name : "Tanzanita velada", Name AC enUS : "Shining Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego brillante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30564;
-- AC datas : OLD Name : "Crisoprasa dentada", Name AC enUS : "Assassin's Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego de asesino', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30565;
-- AC datas : OLD Name : "Tanzanita purificada", Name AC enUS : "Imperial Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita imperial', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30572;
-- AC datas : OLD Name : "Tanzanita misteriosa", Name AC enUS : "Mysterious Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego misterioso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30573;
-- AC datas : OLD Name : "Tanzanita cambiante", Name AC enUS : "Brutal Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita brutal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30574;
-- AC datas : OLD Name : "Crisoprasa liviana", Name AC enUS : "Nimble Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego liviano', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30575;
-- AC datas : OLD Name : "Ópalo de fuego empecinado", Name AC enUS : "Durable Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego durable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30581;
-- AC datas : OLD Name : "Tanzanita intemporal", Name AC enUS : "Timeless Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa intemporal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30583;
-- AC datas : OLD Name : "Ópalo de fuego con inscripciones", Name AC enUS : "Enscribed Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego inscrito', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30584;
-- AC datas : OLD Name : "Ópalo de fuego pulido", Name AC enUS : "Glistening Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego reluciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30585;
-- AC datas : OLD Name : "Tanzanita purificada", Name AC enUS : "Seer's Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa de vidente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30586;
-- AC datas : OLD Name : "Tanzanita purificada", Name AC enUS : "Dazzling Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa deslumbrante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30589;
-- AC datas : OLD Name : "Crisoprasa regia", Name AC enUS : "Enduring Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa duradera', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30590;
-- AC datas : OLD Name : "Ópalo de fuego luciente", Name AC enUS : "Empowered Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego energizado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30591;
-- AC datas : OLD Name : "Ópalo de fuego pujante", Name AC enUS : "Iridescent Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego iridiscente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30593;
-- AC datas : OLD Name : "Crisoprasa regia", Name AC enUS : "Effulgent Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa refulgente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30594;
-- AC datas : OLD Name : "Tanzanita purificada", Name AC enUS : "Fluorescent Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita fluorescente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30600;
-- AC datas : OLD Name : "Crisoprasa resistente", Name AC enUS : "Beaming Fire Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de fuego flamante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30601;
-- AC datas : OLD Name : "Tanzanita purificada", Name AC enUS : "Royal Tanzanite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tanzanita real', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30603;
-- AC datas : OLD Name : "Crisoprasa liviana", Name AC enUS : "Vivid Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa vívida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30605;
-- AC datas : OLD Name : "Crisoprasa de relámpagos", Name AC enUS : "Lambent Chrysoprase" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Crisoprasa luminiscente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30606;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30609;
-- AC datas : OLD Name : "Llave de depósito", Name AC enUS : "Reservoir Key" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Llave de la reserva', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30623;
-- AC datas : OLD Description : "Desbloquea la dificultad heroica de las mazmorras de Auchindoun.", Description AC enUS : "Unlocks access to  Heroic mode for Auchindoun dungeons." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Desbloquea el acceso al modo Heroico en los calabozos de Auchindoun.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30633;
-- AC datas : OLD Name : "Leotardos anudados", Name AC enUS : "Bow-stitched Leggings" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Leotardos cosidos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30900;
-- AC datas : OLD Name : "Guerrera de la familia corazón roto", Name AC enUS : "Torn-heart Family Tunic" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Túnica de la familia corazón roto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30959;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31031;
-- AC datas : OLD Name : "Amatista intemporal", Name AC enUS : "Infused Amethyst" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Amatista imbuida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31116;
-- AC datas : OLD Name : "Amatista calmante incansable", Name AC enUS : "Soothing Amethyst" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Amatista calmante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31117;
-- AC datas : OLD Name : "Amatista soberana", Name AC enUS : "Pulsing Amethyst" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Amatista pulsante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31118;
-- AC datas : OLD Name : "Veleta abisal", Name AC enUS : "Nether-weather Vane" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pluma abisal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31124;
-- AC datas : OLD Name : "Falda de crecimiento vivo", Name AC enUS : "Pants of Living Growth" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pantalones de crecimiento vivo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31335;
-- AC datas : OLD Name : "Boceto: peridoto intenso regio", Name AC enUS : "Design: Enduring Deep Peridot" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un peridoto intenso regio.", Description AC enUS : "Teaches you how to cut an Enduring Deep Peridot." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: peridoto intenso duradero', `Description` = 'Te enseña a tallar un peridoto intenso duradero.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31359;
-- AC datas : OLD Name : "Dirk élfico pesado", Name AC enUS : "Heavy Elven Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla élfica pesada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31422;
-- AC datas : OLD Name : "Dirk de muerte lenta", Name AC enUS : "Slow Death Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de muerte lenta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31476;
-- AC datas : OLD Name : "Escrito sobre Crear comida", Name AC enUS : "Tome of Conjure Food VIII" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Conjure Food (Rank 8)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Conjurar comida VIII', `Description` = 'Te enseña a crear comida (Rango 8).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31501;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31829;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31830;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31831;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31832;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31833;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31834;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31835;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31836;
-- AC datas : OLD Name : "Códice: Rezo de Protección contra las Sombras", Name AC enUS : "Codex: Prayer of Shadow Protection II" ; Wowhead enUS : "",  OLD Description : "Los elementos parecen haber deteriorado este objeto y ya no se puede leer.", Description AC enUS : "Teaches Prayer of Shadow Protection (Rank 2)." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Códice: Rezo de Protección contra las Sombras II', `Description` = 'Enseña Rezo de Protección contra las Sombras (Rango 2).', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31837;
-- AC datas : OLD Name : "Gran piedra del alba ", Name AC enUS : "Great Dawnstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Gran piedra del alba', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31861;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31866;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo.", Description AC enUS : "Matches a Yellow or Red Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31869;
-- AC datas : OLD Name : "Boceto: piedra lunar azur rígida", Name AC enUS : "Design: Great Golden Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra lunar azur rígida.", Description AC enUS : "Teaches you how to cut a Great Golden Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: gran draenita dorada', `Description` = 'Te enseña a tallar una gran draenita dorada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31870;
-- AC datas : OLD Name : "Boceto: draenita de sombras cambiante", Name AC enUS : "Design: Balanced Shadow Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras cambiante.", Description AC enUS : "Teaches you how to cut a Balanced Shadow Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita de Sombras equilibrada', `Description` = 'Te enseña a tallar una draenita de Sombras equilibrada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31871;
-- AC datas : OLD Name : "Boceto: draenita de sombras cambiante", Name AC enUS : "Design: Infused Shadow Draenite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras cambiante.", Description AC enUS : "Teaches you how to cut an Infused Shadow Draenite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: draenita de Sombras imbuida', `Description` = 'Te enseña a tallar una draenita de Sombras imbuida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31872;
-- AC datas : OLD Name : "Boceto: draenita de sombras velada", Name AC enUS : "Design: Veiled Flame Spessarite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una draenita de sombras velada.", Description AC enUS : "Teaches you how to cut a Veiled Flame Spessarite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espesartita de llamas velada', `Description` = 'Te enseña a tallar una espesartita de llamas velada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31873;
-- AC datas : OLD Name : "Boceto: espesartita de llamas mortal", Name AC enUS : "Design: Wicked Flame Spessarite" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espesartita de llamas mortal.", Description AC enUS : "Teaches you how to cut a Wicked Flame Spessarite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espesartita de llamas maligna', `Description` = 'Te enseña a tallar una espesartita de llamas maligna.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31874;
-- AC datas : OLD Name : "Boceto: estrella de Elune rígida", Name AC enUS : "Design: Great Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una estrella de Elune rígida.", Description AC enUS : "Teaches you how to cut a Great Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: gran piedra del alba', `Description` = 'Te enseña a tallar una gran piedra del alba.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31875;
-- AC datas : OLD Name : "Boceto: ojo de noche cambiante", Name AC enUS : "Design: Balanced Nightseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche cambiante.", Description AC enUS : "Teaches you how to cut a Balanced Nightseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de noche equilibrado', `Description` = 'Te enseña a tallar un Ojo de noche equilibrado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31876;
-- AC datas : OLD Name : "Boceto: ojo de noche destellante", Name AC enUS : "Design: Infused Nightseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche destellante.", Description AC enUS : "Teaches you how to cut an Infused Nightseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de noche imbuido', `Description` = 'Te enseña a tallar un ojo de noche imbuido.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31877;
-- AC datas : OLD Name : "Boceto: ojo de noche velado", Name AC enUS : "Design: Veiled Noble Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de noche velado.", Description AC enUS : "Teaches you how to cut a Veiled Noble Topaz." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio noble velado', `Description` = 'Te enseña a tallar un topacio noble velado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31878;
-- AC datas : OLD Name : "Boceto: topacio noble mortal", Name AC enUS : "Design: Wicked Noble Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio noble mortal.", Description AC enUS : "Teaches you how to cut a Wicked Noble Topaz." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio noble maligno', `Description` = 'Te enseña a tallar un topacio noble maligno.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 31879;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo o amarillo", Description AC enUS : "Matches a Red or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32219;
-- AC datas : OLD Name : "Esmeralda de espuma marina duradera.", Name AC enUS : "Enduring Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esmeralda de espuma marina duradera', `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32223;
-- AC datas : OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32224;
-- AC datas : OLD Name : "Esmeralda de espuma marina deslumbrante.", Name AC enUS : "Dazzling Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esmeralda de espuma marina deslumbrante', `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32225;
-- AC datas : OLD Name : "Esmeralda de espuma marina irregular.", Name AC enUS : "Jagged Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esmeralda de espuma marina dentada', `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32226;
-- AC datas : OLD Name : "Cordón del caminasombras", Name AC enUS : "Shadow-walker's Cord" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cordón del Caminasombras', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32265;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Teardrop Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Teardrop Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Lágrima de espinela carmesí', `Description` = 'Te enseña a tallar una Lágrima de espinela carmesí.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32281;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Runed Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Runed Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí rúnica', `Description` = 'Te enseña a tallar una espinela carmesí rúnica.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32282;
-- AC datas : OLD Name : "Boceto: espinela carmesí delicada", Name AC enUS : "Design: Bright Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí delicada.", Description AC enUS : "Teaches you how to cut a Bright Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí brillante', `Description` = 'Te enseña a tallar una espinela carmesí brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32283;
-- AC datas : OLD Name : "Boceto: ojo de león sutil", Name AC enUS : "Design: Subtle Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león sutil.", Description AC enUS : "Teaches you how to cut a Subtle Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí sutil', `Description` = 'Te enseña a tallar una espinela carmesí sutil.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32284;
-- AC datas : OLD Name : "Boceto: zafiro empíreo chispeante", Name AC enUS : "Design: Lustrous Empyrean Sapphire" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo chispeante.", Description AC enUS : "Teaches you how to cut a Lustrous Empyrean Sapphire." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: zafiro empíreo luciente', `Description` = 'Te enseña a tallar un zafiro empíreo luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32288;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Brilliant Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Brilliant Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león luminoso', `Description` = 'Te enseña a tallar un Ojo de león luminoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32290;
-- AC datas : OLD Name : "Boceto: zafiro empíreo rígido", Name AC enUS : "Design: Rigid Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo rígido.", Description AC enUS : "Teaches you how to cut a Rigid Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león rígido', `Description` = 'Te enseña a tallar un Ojo de león rígido.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32292;
-- AC datas : OLD Name : "Boceto: ojo de león liso", Name AC enUS : "Design: Gleaming Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león liso.", Description AC enUS : "Teaches you how to cut a Gleaming Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león reluciente', `Description` = 'Te enseña a tallar un Ojo de león reluciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32293;
-- AC datas : OLD Name : "Boceto: ojo de león sutil", Name AC enUS : "Design: Thick Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león sutil.", Description AC enUS : "Teaches you how to cut a Thick Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león grueso', `Description` = 'Te enseña a tallar un Ojo de león grueso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32294;
-- AC datas : OLD Name : "Boceto: zafiro empíreo rígido", Name AC enUS : "Design: Great Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo rígido.", Description AC enUS : "Teaches you how to cut a Great Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: gran Ojo de león', `Description` = 'Te enseña a tallar un gran Ojo de león.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32296;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío cambiante", Name AC enUS : "Design: Balanced Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío cambiante.", Description AC enUS : "Teaches you how to cut a Balanced Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío equilibrada', `Description` = 'Te enseña a tallar una amatista Cantosombrío equilibrada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32299;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío destellante", Name AC enUS : "Design: Infused Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío destellante.", Description AC enUS : "Teaches you how to cut an Infused Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío imbuida', `Description` = 'Te enseña a tallar una amatista Cantosombrío imbuida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32300;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío intemporal", Name AC enUS : "Design: Glowing Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío intemporal.", Description AC enUS : "Teaches you how to cut a Glowing Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío resplandeciente', `Description` = 'Te enseña a tallar una amatista Cantosombrío resplandeciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32301;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío purificada", Name AC enUS : "Design: Royal Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío purificada.", Description AC enUS : "Teaches you how to cut a Royal Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío real', `Description` = 'Te enseña a tallar una amatista Cantosombrío real.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32302;
-- AC datas : OLD Name : "Boceto: piropiedra temeraria", Name AC enUS : "Design: Luminous Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piropiedra temeraria.", Description AC enUS : "Teaches you how to cut a Luminous Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra luminosa', `Description` = 'Te enseña a tallar una piropiedra luminosa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32305;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío destellante", Name AC enUS : "Design: Glinting Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío destellante.", Description AC enUS : "Teaches you how to cut a Glinting Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra destelleante', `Description` = 'Te enseña a tallar una piropiedra destelleante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32306;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío velada", Name AC enUS : "Design: Veiled Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío velada.", Description AC enUS : "Teaches you how to cut a Veiled Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra velada', `Description` = 'Te enseña a tallar una piropiedra velada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32307;
-- AC datas : OLD Name : "Boceto: piropiedra mortal", Name AC enUS : "Design: Wicked Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piropiedra mortal.", Description AC enUS : "Teaches you how to cut a Wicked Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra maligna', `Description` = 'Te enseña a tallar una piropiedra maligna.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32308;
-- AC datas : OLD Name : "Boceto: esmeralda de espuma marina regia", Name AC enUS : "Design: Enduring Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una esmeralda de espuma marina regia.", Description AC enUS : "Teaches you how to cut a Enduring Seaspray Emerald." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: esmeralda de espuma marina duradera', `Description` = 'Te enseña a tallar una esmeralda de espuma marina duradera.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32309;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío purificada", Name AC enUS : "Design: Dazzling Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío purificada.", Description AC enUS : "Teaches you how to cut a Dazzling Seaspray Emerald." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: esmeralda de espuma marina deslumbrante', `Description` = 'Te enseña a tallar una esmeralda de espuma marina deslumbrante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32311;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32314;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32316;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32317;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32318;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32319;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32330;
-- AC datas : OLD Name : "Hombreras maldición de sangre", Name AC enUS : "Blood-cursed Shoulderpads" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sobrehombros maldición de sangre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32338;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32458;
-- AC datas : OLD Name : "Amatista cambiante", Name AC enUS : "Unstable Amethyst" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Amatista inestable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32634;
-- AC datas : OLD Name : "Amatista intemporal", Name AC enUS : "Unstable Peridot" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color rojo o azul.", Description AC enUS : "Matches a Yellow or Blue Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Peridoto inestable', `Description` = 'Encaja en una ranura de color amarillo o azul.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32635;
-- AC datas : OLD Name : "Amatista purificada", Name AC enUS : "Unstable Sapphire" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Zafiro inestable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32636;
-- AC datas : OLD Name : "Citrino mortal", Name AC enUS : "Unstable Citrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Citrino inestable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32637;
-- AC datas : OLD Name : "Citrino temerario", Name AC enUS : "Unstable Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Topacio inestable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32638;
-- AC datas : OLD Name : "Musgorita dentada", Name AC enUS : "Unstable Talasite" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color amarillo o azul.", Description AC enUS : "Matches a Blue or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Talasita inestable', `Description` = 'Encaja en una ranura de color azul o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32639;
-- AC datas : OLD Name : "Diamante inestable tenso", Name AC enUS : "Potent Unstable Diamond" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Diamante potente inestable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32640;
-- AC datas : OLD Name : "Espencerita delicada", Name AC enUS : "Radiant Spencerite" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Spencerita radiante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32735;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32768;
-- AC datas : OLD Description : "¡A saber qué hay dentro!", Description AC enUS : "Who knows what's inside?  Cross your fingers for a darkrune." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡A saber qué hay dentro! Cruza los dedos a ver si consigues una runaoscura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32777;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32857;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32858;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32859;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32860;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32861;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32862;
-- AC datas : OLD Name : "Botas de ascendente", Name AC enUS : "Ascendant's Boots" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Botas de ascendiente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32866;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33078;
-- AC datas : OLD Name : "Piedra tajadera rígida", Name AC enUS : "Great Bladestone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Gran piedra tajadera', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33141;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente una capa para aumentar la agilidad y el índice de esquivar 8 p.", Description AC enUS : "Teaches you how to permanently enchant a cloak to increase stealth." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente una capa para aumentar el sigilo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33149;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33225;
-- AC datas : OLD Description : "Es... ¡ENORME!", Description AC enUS : "It's... HUGE!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Come y saborea!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33254;
-- AC datas : OLD Name : "Dirk de hueso", Name AC enUS : "Bone Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de hueso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33268;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente un arma de combate cuerpo a cuerpo para que te otorgue esporádicamente 120 p. de índice de golpe crítico. Requiere un objeto de nivel 60 o superior.", Description AC enUS : "Teaches you how to permanently enchant a melee weapon to occasionally grant you 120 armor penetration rating. Requires a level 60 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente un arma de combate cuerpo a cuerpo para que te otorgue esporádicamente 120 p. de índice de penetración de armadura. Requiere un objeto de nivel 60 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33307;
-- AC datas : OLD Name : "Escrito sobre Luminosidad Arcana", Name AC enUS : "Tome of Arcane Brilliance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Luminosidad Arcana 3', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33316;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33505;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33506;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33507;
-- AC datas : OLD Name : "Esquema estropeado", Name AC enUS : "Schematic: Adamantite Arrow Maker" ; Wowhead enUS : "",  OLD Description : "Este esquema ha sido destruido por los elementos.", Description AC enUS : "Teaches you how to make an Adamantite Arrow Maker." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esquema: generador de flechas de adamantita', `Description` = 'Te enseña a hacer un generador de flechas de adamantita.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33804;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33809;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33843;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33939;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33940;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33941;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33951;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33952;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33953;
-- AC datas : OLD Name : "Cerveza rubia de las Isla del Eco", Name AC enUS : "Harkor's Home Brew" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cerveza casera de Harkor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33956;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33977;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33999;
-- AC datas : OLD Name : "Máscara de elfa de sangre", Name AC enUS : "Flimsy Female Blood Elf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de elfa de sangre endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34000;
-- AC datas : OLD Name : "Máscara de draenei hembra", Name AC enUS : "Flimsy Female Draenei Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de draenei hembra endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34001;
-- AC datas : OLD Name : "Máscara de elfo de sangre", Name AC enUS : "Flimsy Male Blood Elf Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de elfo de sangre endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34002;
-- AC datas : OLD Name : "Máscara de draenei macho", Name AC enUS : "Flimsy Male Draenei Mask" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Máscara de draenei macho endeble', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34003;
-- AC datas : OLD Name : "Máquina voladora", Name AC enUS : "Flying Machine Control" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Mando de máquina voladora', `Description` = 'Te enseña a invocar esta montura. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34060;
-- AC datas : OLD Name : "Máquina voladora turboalimentada", Name AC enUS : "Turbo-Charged Flying Machine Control" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast ride." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Mando de máquina voladora turboalimentada', `Description` = 'Te enseña a invocar esta montura. Es un vehículo muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34061;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34092;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34129;
-- AC datas : OLD Name : "Calavera de dragón", Name AC enUS : "Dragon Skull" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Dragon Skull Test', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34187;
-- AC datas : OLD Name : "Patrón estropeado", Name AC enUS : "Pattern: Quiver of a Thousand Feathers" ; Wowhead enUS : "",  OLD Description : "Este detallado patrón ha sido estropeado por los elementos.", Description AC enUS : "Teaches you how to craft a Quiver of a Thousand Feathers." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Patrón: carcaj de mil plumas', `Description` = 'Te enseña a hacer un carcaj de mil plumas.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34200;
-- AC datas : OLD Name : "Patrón estropeado", Name AC enUS : "Pattern: Netherscale Ammo Pouch" ; Wowhead enUS : "",  OLD Description : "Este patrón desprende un hedor a lluvia y ceniza.", Description AC enUS : "Teaches you how to craft a Netherscale Ammo Pouch." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Patrón: faltriquera de munición de escamas abisales', `Description` = 'Te enseña a hacer una faltriquera de munición de escamas abisales.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34201;
-- AC datas : OLD Name : "Patrón estropeado", Name AC enUS : "Pattern: Netherscale Ammo Pouch" ; Wowhead enUS : "",  OLD Description : "", Description AC enUS : "Teaches you how to craft a Netherscale Ammo Pouch." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Patrón: faltriquera de munición de escamas abisales', `Description` = 'Te enseña a hacer una faltriquera de munición de escamas abisales.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34218;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35104;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35105;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35106;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35225;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35226;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío cambiante", Name AC enUS : "Design: Balanced Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío cambiante.", Description AC enUS : "Teaches you how to cut a Balanced Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío equilibrada', `Description` = 'Te enseña a tallar una amatista Cantosombrío equilibrada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35238;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío intemporal", Name AC enUS : "Design: Glowing Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío intemporal.", Description AC enUS : "Teaches you how to cut a Glowing Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío resplandeciente', `Description` = 'Te enseña a tallar una amatista Cantosombrío resplandeciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35239;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío destellante", Name AC enUS : "Design: Infused Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío destellante.", Description AC enUS : "Teaches you how to cut an Infused Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío imbuida', `Description` = 'Te enseña a tallar una amatista Cantosombrío imbuida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35240;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío purificada", Name AC enUS : "Design: Royal Shadowsong Amethyst" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío purificada.", Description AC enUS : "Teaches you how to cut a Royal Shadowsong Amethyst." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: amatista Cantosombrío real', `Description` = 'Te enseña a tallar una amatista Cantosombrío real.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35241;
-- AC datas : OLD Name : "Boceto: espinela carmesí delicada", Name AC enUS : "Design: Bright Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí delicada.", Description AC enUS : "Teaches you how to cut a Bright Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí brillante', `Description` = 'Te enseña cómo tallar una espinela carmesí brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35245;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Runed Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Runed Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí rúnica', `Description` = 'Te enseña a tallar una espinela carmesí rúnica.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35248;
-- AC datas : OLD Name : "Boceto: ojo de león sutil", Name AC enUS : "Design: Subtle Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león sutil.", Description AC enUS : "Teaches you how to cut a Subtle Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: espinela carmesí sutil', `Description` = 'Te enseña a tallar una espinela carmesí sutil.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35249;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Teardrop Crimson Spinel" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Teardrop Crimson Spinel." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Lágrima de espinela carmesí', `Description` = 'Te enseña a tallar una Lágrima de espinela carmesí.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35250;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío purificada", Name AC enUS : "Design: Dazzling Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío purificada.", Description AC enUS : "Teaches you how to cut a Dazzling Seaspray Emerald." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: esmeralda de espuma marina deslumbrante', `Description` = 'Te enseña cómo tallar una esmeralda de espuma marina deslumbrante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35251;
-- AC datas : OLD Name : "Boceto: esmeralda de espuma marina regia", Name AC enUS : "Design: Enduring Seaspray Emerald" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una esmeralda de espuma marina regia.", Description AC enUS : "Teaches you how to cut a Enduring Seaspray Emerald." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: esmeralda de espuma marina duradera', `Description` = 'Te enseña cómo tallar una esmeralda de espuma marina duradera.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35252;
-- AC datas : OLD Name : "Boceto: espinela carmesí luminosa", Name AC enUS : "Design: Brilliant Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una espinela carmesí luminosa.", Description AC enUS : "Teaches you how to cut a Brilliant Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león luminoso', `Description` = 'Te enseña cómo tallar un Ojo de león luminoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35255;
-- AC datas : OLD Name : "Boceto: ojo de león liso", Name AC enUS : "Design: Gleaming Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león liso.", Description AC enUS : "Teaches you how to cut a Gleaming Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león reluciente', `Description` = 'Te enseña a tallar un Ojo de león reluciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35256;
-- AC datas : OLD Name : "Boceto: zafiro empíreo rígido", Name AC enUS : "Design: Great Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo rígido.", Description AC enUS : "Teaches you how to cut a Great Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: gran Ojo de león', `Description` = 'Te enseña a tallar un gran Ojo de león.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35257;
-- AC datas : OLD Name : "Boceto: zafiro empíreo rígido", Name AC enUS : "Design: Rigid Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo rígido.", Description AC enUS : "Teaches you how to cut a Rigid Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león rígido', `Description` = 'Te enseña a tallar un Ojo de león rígido.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35259;
-- AC datas : OLD Name : "Boceto: ojo de león sutil", Name AC enUS : "Design: Thick Lionseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de león sutil.", Description AC enUS : "Teaches you how to cut a Thick Lionseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de león grueso', `Description` = 'Te enseña a tallar un Ojo de león grueso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35261;
-- AC datas : OLD Name : "Boceto: zafiro empíreo chispeante", Name AC enUS : "Design: Lustrous Empyrean Sapphire" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un zafiro empíreo chispeante.", Description AC enUS : "Teaches you how to cut a Lustrous Empyrean Sapphire." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: zafiro empíreo luciente', `Description` = 'Te enseña a tallar un zafiro empíreo luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35262;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío destellante", Name AC enUS : "Design: Glinting Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío destellante.", Description AC enUS : "Teaches you how to cut a Glinting Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra destelleante', `Description` = 'Te enseña a tallar una piropiedra destelleante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35266;
-- AC datas : OLD Name : "Boceto: piropiedra temeraria", Name AC enUS : "Design: Luminous Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piropiedra temeraria.", Description AC enUS : "Teaches you how to cut a Luminous Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra luminosa', `Description` = 'Te enseña a tallar una piropiedra luminosa.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35268;
-- AC datas : OLD Name : "Boceto: amatista Cantosombrío velada", Name AC enUS : "Design: Veiled Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una amatista Cantosombrío velada.", Description AC enUS : "Teaches you how to cut a Veiled Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra velada', `Description` = 'Te enseña a tallar una piropiedra velada.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35270;
-- AC datas : OLD Name : "Boceto: piropiedra mortal", Name AC enUS : "Design: Wicked Pyrestone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piropiedra mortal.", Description AC enUS : "Teaches you how to cut a Wicked Pyrestone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piropiedra maligna', `Description` = 'Te enseña a tallar una piropiedra maligna.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35271;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente unas botas para aumentar el espíritu y el aguante 10 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant boots to restore 5 health and mana every 5 seconds.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente botas para restaurar 5 p. de maná y salud cada 5 segundos. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35298;
-- AC datas : OLD Name : "Boceto: rubí vivo luminoso", Name AC enUS : "Design: Runed Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo luminoso.", Description AC enUS : "Teaches you how to cut a Runed Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí vivo rúnico', `Description` = 'Te enseña cómo tallar un rubí vivo único.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35305;
-- AC datas : OLD Name : "Boceto: rubí vivo delicado", Name AC enUS : "Design: Bright Living Ruby" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un rubí vivo delicado.", Description AC enUS : "Teaches you how to cut a Bright Living Ruby." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí vivo brillante', `Description` = 'Te enseña cómo tallar un rubí vivo brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35306;
-- AC datas : OLD Name : "Boceto: estrella de Elune rígida", Name AC enUS : "Design: Rigid Dawnstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una estrella de Elune rígida.", Description AC enUS : "Teaches you how to cut a Rigid Dawnstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra del alba rígida', `Description` = 'Te enseña cómo tallar una piedra del alba rígida.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35307;
-- AC datas : OLD Name : "Encantar brazales: esquivar superior", Name AC enUS : "Enchant Bracer - Major Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Encantar brazal: defensa sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35422;
-- AC datas : OLD Name : "Encantar escudo: parar", Name AC enUS : "Enchant Shield - Shield Block" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Encantar escudo: bloquear con escudo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35451;
-- AC datas : OLD Name : "Espinela carmesí delicada", Name AC enUS : "Bright Crimson Spinel" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Espinela carmesí brillante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35487;
-- AC datas : OLD Name : "Espinela carmesí luminosa", Name AC enUS : "Runed Crimson Spinel" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Espinela carmesí rúnica', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35488;
-- AC datas : OLD Name : "Espinela carmesí luminosa", Name AC enUS : "Teardrop Crimson Spinel" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Lágrima de espinela carmesí', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35489;
-- AC datas : OLD Description : "No quieres que esto se te clave en la piel bajo ningún concepto.", Description AC enUS : "Sample from a Crystalline Protector" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Muestra de un protector cristalino', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35490;
-- AC datas : OLD Name : "Fórmula: encantar pechera: esquivar", Name AC enUS : "Formula: Enchant Chest - Defense" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente una pechera para aumentar el índice de esquivar 18 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant chest armor to increase defense rating by 16.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar pechera: defensa', `Description` = 'Te enseña a encantar de forma permanente una pechera para aumentar el índice de defensa 16 p. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35500;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon the mount of Kael'thas Sunstrider.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar la montura de Kael''thas Caminante del Sol. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35513;
-- AC datas : OLD Description : "Rompe el hielo alrededor de un huevo de dragón azul y se aloja en la cáscara rota.", Description AC enUS : "Breaks the ice around a blue dragon egg and lodges itself in the broken shell." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Rompe el hielo alrededor de un huevo de dragón Azul y se aloja en la cáscara rota.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35586;
-- AC datas : OLD Name : "Ojo de noche regio", Name AC enUS : "Regal Nightseye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ojo de noche majestuoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35707;
-- AC datas : OLD Name : "Boceto: talasita regia", Name AC enUS : "Design: Regal Nightseye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una talasita regia.", Description AC enUS : "Teaches you how to cut a Regal Nightseye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de noche majestuoso', `Description` = 'Te enseña a tallar un Ojo de noche majestuoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35708;
-- AC datas : OLD Name : "Neutralizador de golpe de Foror", Name AC enUS : "Foror's Wipe Neutralizer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Neutralizador de golpe', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35722;
-- AC datas : OLD Name : "Fórmula: encantar capa: esquivar superior", Name AC enUS : "Formula: Enchant Cloak - Steelweave" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente una capa para aumentar el índice de esquivar 14 p. Requiere un objeto de nivel 35 o superior.", Description AC enUS : "Teaches you how to permanently enchant a cloak to increase defense rating by 12.  Requires a level 35 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar capa: tejido de acero', `Description` = 'Te enseña a encantar de forma permanente una capa para aumentar el índice de defensa 12 p. Requiere un objeto de nivel 35 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35756;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35906;
-- AC datas : OLD Name : "Zancos de fuego solar", Name AC enUS : "Sun-fired Striders" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Botas de fuego solar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35909;
-- AC datas : OLD Name : "Gema de maná", Name AC enUS : "Mana Gem" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ópalo de maná', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 36799;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37012;
-- AC datas : OLD Name : "Clayton's Test Item Three", Name AC enUS : "Clayton's Test Item Three" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Clayton''s Test Item Three TEST', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37126;
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 37126;
-- AC datas : OLD Name : "Esfera de sangre de dragón rojo", Name AC enUS : "Sphere of Red Dragon's Blood" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Esfera de sangre de dragón Rojo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37166;
-- AC datas : OLD Name : "Falda hogareña de Gorge", Name AC enUS : "Gorge's Loungewear" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Grek''lor''s Loungewear', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37276;
-- AC datas : OLD Name : "Fórmula: encantar pechera: esquivar superior", Name AC enUS : "Formula: Enchant Chest - Greater Dodge" ; Wowhead enUS : "",  OLD Description : "Te enseña a encantar de forma permanente una pechera para aumentar el índice de esquivar 22 p. Requiere un objeto de nivel 60 o superior.", Description AC enUS : "Teaches you how to permanently enchant chest armor to increase dodge rating by 22.   Requires a level 60 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Fórmula: encantar pechera: defensa superior', `Description` = 'Te enseña a encantar de forma permanente una pieza de armadura para el torso para aumentar el índice de defensa 22 p. Requiere un objeto de nivel 60 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37336;
-- AC datas : OLD Description : "Te enseña a encantar de forma permanente una capa para que aumente el sigilo ligeramente y la agilidad 10 p. Requiere un objeto de nivel 60 o superior.", Description AC enUS : "Teaches you how to permanently enchant a cloak to increase stealth slightly and Agility by 10.  Requires a level 60 or higher item." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a encantar de forma permanente una capa para aumentar el sigilo ligeramente y aumentar la agilidad 10 p. Requiere un objeto de nivel 60 o superior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37349;
-- AC datas : OLD Name : "Coraza de sanguinario de Gorge", Name AC enUS : "Gorge's Breastplate of Bloodrage" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Grek''lor''s Breastplate of Bloodrage', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37476;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37575;
-- AC datas : OLD Name : "Puñado de golosinas", Name AC enUS : "Handful of Candy" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puñado de caramelos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37586;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37598;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos con restricciones de nivel 35 o inferior.", Description AC enUS : "Can be targeted by Armor enchantments to store the enchantment for later use.  Only able to absorb enchantments with a level restriction of 35 or lower." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos con restricciones de nivel 35 o inferior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37602;
-- AC datas : OLD Name : "Encantar botas: maña", Name AC enUS : "Scroll of Enchant Boots - Dexterity" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: maña', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37603;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37676;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37719;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37828;
-- AC datas : OLD Description : "¡Soldados, resucitad, levantaos y luchad!", Description AC enUS : "Soldiers arise, stand and fight!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Soldados, álcense, levántense y luchen!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38175;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38361;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38367;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38368;
-- AC datas : OLD Name : "Rubí ornamentado delicado", Name AC enUS : "Bold Ornate Ruby" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Rubí ornamentado llamativo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38545;
-- AC datas : OLD Name : "Piedra del alba ornamentada lisa", Name AC enUS : "Gleaming Ornate Dawnstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra del alba ornamentada reluciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38546;
-- AC datas : OLD Name : "Topacio ornamentado mortal", Name AC enUS : "Inscribed Ornate Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Topacio ornamentado con inscripciones', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38547;
-- AC datas : OLD Name : "Rubí ornamentado luminoso", Name AC enUS : "Runed Ornate Ruby" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Rubí rúnico ornamentado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38549;
-- AC datas : OLD Name : "Manifiesto de prisionero Maraudine", Name AC enUS : "Maraudine Prisoner Manifest" ; Wowhead enUS : "",  OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Tablillas Drakkari antiguas', `Description` = 'Placas de metal con rebordes con jeroglíficos grabados.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38567;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38576;
-- AC datas : OLD Name : "Encantar brazales: salud menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: salud menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38679;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos sin restricciones de nivel.", Description AC enUS : "Can be targeted by Armor enchantments to store the enchantment for later use.  Only able to absorb enchantments with no level restrictions." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos sin restricciones de nivel.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38682;
-- AC datas : OLD Name : "ObsoleteSigil of the Dark Rider (OLD)", Name AC enUS : "ObsoleteSigil of the Dark Rider (OLD)" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sigil of the Dark Rider (OLD)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38683;
-- AC datas : OLD Name : "Encantar pechera: salud menor", Name AC enUS : "Scroll of Enchant Chest - Minor Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38766;
-- AC datas : OLD Name : "Encantar pechera: amortiguación menor", Name AC enUS : "Scroll of Enchant Chest - Minor Absorption" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: amortiguación menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38767;
-- AC datas : OLD Name : "Encantar brazales: esquivar menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Deflection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: Desvío menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38768;
-- AC datas : OLD Name : "Encantar pechera: maná menor", Name AC enUS : "Scroll of Enchant Chest - Minor Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38769;
-- AC datas : OLD Name : "Encantar capa: resistencia menor", Name AC enUS : "Scroll of Enchant Cloak - Minor Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38770;
-- AC datas : OLD Name : "Encantar brazales: aguante menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38771;
-- AC datas : OLD Name : "Encantar arma 2M: impacto menor", Name AC enUS : "Scroll of Enchant 2H Weapon - Minor Impact" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: impacto menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38772;
-- AC datas : OLD Name : "Encantar pechera: salud inferior", Name AC enUS : "Scroll of Enchant Chest - Lesser Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38773;
-- AC datas : OLD Name : "Encantar brazales: espíritu menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38774;
-- AC datas : OLD Name : "Encantar capa: protección menor", Name AC enUS : "Scroll of Enchant Cloak - Minor Protection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: protección menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38775;
-- AC datas : OLD Name : "Encantar pechera: maná inferior", Name AC enUS : "Scroll of Enchant Chest - Lesser Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38776;
-- AC datas : OLD Name : "Encantar brazales: agilidad menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: agilidad menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38777;
-- AC datas : OLD Name : "Encantar brazales: fuerza menor", Name AC enUS : "Scroll of Enchant Bracer - Minor Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: fuerza menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38778;
-- AC datas : OLD Name : "Encantar arma: Destripadora de bestias menor", Name AC enUS : "Scroll of Enchant Weapon - Minor Beastslayer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Destripadora de bestias menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38779;
-- AC datas : OLD Name : "Encantar arma: golpear menor", Name AC enUS : "Scroll of Enchant Weapon - Minor Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpear menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38780;
-- AC datas : OLD Name : "Encantar arma 2M: intelecto inferior", Name AC enUS : "Scroll of Enchant 2H Weapon - Lesser Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: intelecto inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38781;
-- AC datas : OLD Name : "Encantar pechera: salud", Name AC enUS : "Scroll of Enchant Chest - Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38782;
-- AC datas : OLD Name : "Encantar brazales: espíritu inferior", Name AC enUS : "Scroll of Enchant Bracer - Lesser Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38783;
-- AC datas : OLD Name : "Encantar capa: Resistencia al Fuego inferior", Name AC enUS : "Scroll of Enchant Cloak - Lesser Fire Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia al Fuego inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38784;
-- AC datas : OLD Name : "Encantar botas: aguante menor", Name AC enUS : "Scroll of Enchant Boots - Minor Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: aguante menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38785;
-- AC datas : OLD Name : "Encantar botas: agilidad menor", Name AC enUS : "Scroll of Enchant Boots - Minor Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: agilidad menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38786;
-- AC datas : OLD Name : "Encantar escudo: aguante menor", Name AC enUS : "Scroll of Enchant Shield - Minor Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38787;
-- AC datas : OLD Name : "Encantar arma 2M: espíritu inferior", Name AC enUS : "Scroll of Enchant 2H Weapon - Lesser Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: espíritu inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38788;
-- AC datas : OLD Name : "Encantar capa: agilidad menor", Name AC enUS : "Scroll of Enchant Cloak - Minor Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: agilidad menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38789;
-- AC datas : OLD Name : "Encantar capa: protección inferior", Name AC enUS : "Scroll of Enchant Cloak - Lesser Protection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: protección inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38790;
-- AC datas : OLD Name : "Encantar escudo: protección inferior", Name AC enUS : "Scroll of Enchant Shield - Lesser Protection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: protección inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38791;
-- AC datas : OLD Name : "Encantar escudo: espíritu inferior", Name AC enUS : "Scroll of Enchant Shield - Lesser Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: espíritu inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38792;
-- AC datas : OLD Name : "Encantar brazales: aguante inferior", Name AC enUS : "Scroll of Enchant Bracer - Lesser Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38793;
-- AC datas : OLD Name : "Encantar arma: golpear inferior", Name AC enUS : "Scroll of Enchant Weapon - Lesser Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpear inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38794;
-- AC datas : OLD Name : "Encantar capa: Resistencia a las Sombras inferior", Name AC enUS : "Scroll of Enchant Cloak - Lesser Shadow Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia a las Sombras inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38795;
-- AC datas : OLD Name : "Encantar arma 2M: impacto inferior", Name AC enUS : "Scroll of Enchant 2H Weapon - Lesser Impact" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: impacto inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38796;
-- AC datas : OLD Name : "Encantar brazales: fuerza inferior", Name AC enUS : "Scroll of Enchant Bracer - Lesser Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: fuerza inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38797;
-- AC datas : OLD Name : "Encantar pechera: amortiguación inferior", Name AC enUS : "Scroll of Enchant Chest - Lesser Absorption" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: amortiguación inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38798;
-- AC datas : OLD Name : "Encantar pechera: maná", Name AC enUS : "Scroll of Enchant Chest - Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38799;
-- AC datas : OLD Name : "Encantar guantes: minería", Name AC enUS : "Scroll of Enchant Gloves - Mining" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: minería', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38800;
-- AC datas : OLD Name : "Encantar guantes: herboristería", Name AC enUS : "Scroll of Enchant Gloves - Herbalism" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: herboristería', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38801;
-- AC datas : OLD Name : "Encantar guantes: pesca", Name AC enUS : "Scroll of Enchant Gloves - Fishing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: pesca', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38802;
-- AC datas : OLD Name : "Encantar brazales: intelecto inferior", Name AC enUS : "Scroll of Enchant Bracer - Lesser Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: intelecto inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38803;
-- AC datas : OLD Name : "Encantar pechera: estadísticas menores", Name AC enUS : "Scroll of Enchant Chest - Minor Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas menores', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38804;
-- AC datas : OLD Name : "Encantar escudo: aguante inferior", Name AC enUS : "Scroll of Enchant Shield - Lesser Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38805;
-- AC datas : OLD Name : "Encantar capa: defensa", Name AC enUS : "Scroll of Enchant Cloak - Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: defensa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38806;
-- AC datas : OLD Name : "Encantar botas: agilidad inferior", Name AC enUS : "Scroll of Enchant Boots - Lesser Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: agilidad inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38807;
-- AC datas : OLD Name : "Encantar pechera: salud superior", Name AC enUS : "Scroll of Enchant Chest - Greater Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38808;
-- AC datas : OLD Name : "Encantar brazales: espíritu", Name AC enUS : "Scroll of Enchant Bracer - Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38809;
-- AC datas : OLD Name : "Encantar botas: aguante inferior", Name AC enUS : "Scroll of Enchant Boots - Lesser Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: aguante inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38810;
-- AC datas : OLD Name : "Encantar brazales: esquivar inferior", Name AC enUS : "Scroll of Enchant Bracer - Lesser Deflection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: desvío inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38811;
-- AC datas : OLD Name : "Encantar brazales: aguante", Name AC enUS : "Scroll of Enchant Bracer - Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38812;
-- AC datas : OLD Name : "Encantar arma: Destripadora de bestias inferior", Name AC enUS : "Scroll of Enchant Weapon - Lesser Beastslayer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Destripadora de bestias inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38813;
-- AC datas : OLD Name : "Encantar arma: mataelementales inferior", Name AC enUS : "Scroll of Enchant Weapon - Lesser Elemental Slayer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: mataelementales inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38814;
-- AC datas : OLD Name : "Encantar capa: Resistencia al Fuego", Name AC enUS : "Scroll of Enchant Cloak - Fire Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia al Fuego', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38815;
-- AC datas : OLD Name : "Encantar escudo: espíritu", Name AC enUS : "Scroll of Enchant Shield - Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: espíritu', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38816;
-- AC datas : OLD Name : "Encantar brazales: fuerza", Name AC enUS : "Scroll of Enchant Bracer - Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: fuerza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38817;
-- AC datas : OLD Name : "Encantar pechera: maná superior", Name AC enUS : "Scroll of Enchant Chest - Greater Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38818;
-- AC datas : OLD Name : "Encantar botas: espíritu inferior", Name AC enUS : "Scroll of Enchant Boots - Lesser Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: espíritu inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38819;
-- AC datas : OLD Name : "Encantar escudo: parada inferior", Name AC enUS : "Scroll of Enchant Shield - Lesser Block" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: bloqueo inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38820;
-- AC datas : OLD Name : "Encantar arma: golpear", Name AC enUS : "Scroll of Enchant Weapon - Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpear', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38821;
-- AC datas : OLD Name : "Encantar arma 2M: impacto", Name AC enUS : "Scroll of Enchant 2H Weapon - Impact" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: impacto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38822;
-- AC datas : OLD Name : "Encantar guantes: desuello", Name AC enUS : "Scroll of Enchant Gloves - Skinning" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: desuello', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38823;
-- AC datas : OLD Name : "Encantar pechera: estadísticas inferiores", Name AC enUS : "Scroll of Enchant Chest - Lesser Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas inferiores', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38824;
-- AC datas : OLD Name : "Encantar capa: defensa superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: defensa superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38825;
-- AC datas : OLD Name : "Encantar capa: Resistencia", Name AC enUS : "Scroll of Enchant Cloak - Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38826;
-- AC datas : OLD Name : "Encantar guantes: Agilidad", Name AC enUS : "Scroll of Enchant Gloves - Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Agilidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38827;
-- AC datas : OLD Name : "Encantar escudo: aguante", Name AC enUS : "Scroll of Enchant Shield - Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38828;
-- AC datas : OLD Name : "Encantar brazales: intelecto", Name AC enUS : "Scroll of Enchant Bracer - Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: intelecto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38829;
-- AC datas : OLD Name : "Encantar botas: aguante", Name AC enUS : "Scroll of Enchant Boots - Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: aguante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38830;
-- AC datas : OLD Name : "Encantar guantes: minería avanzada", Name AC enUS : "Scroll of Enchant Gloves - Advanced Mining" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: minería avanzada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38831;
-- AC datas : OLD Name : "Encantar brazales: espíritu superior", Name AC enUS : "Scroll of Enchant Bracer - Greater Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38832;
-- AC datas : OLD Name : "Encantar pechera: salud excelente", Name AC enUS : "Scroll of Enchant Chest - Superior Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38833;
-- AC datas : OLD Name : "Encantar guantes: herboristería avanzada", Name AC enUS : "Scroll of Enchant Gloves - Advanced Herbalism" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: herboristería avanzada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38834;
-- AC datas : OLD Name : "Encantar capa: agilidad inferior", Name AC enUS : "Scroll of Enchant Cloak - Lesser Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: agilidad inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38835;
-- AC datas : OLD Name : "Encantar guantes: fuerza", Name AC enUS : "Scroll of Enchant Gloves - Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: fuerza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38836;
-- AC datas : OLD Name : "Encantar botas: Velocidad menor", Name AC enUS : "Scroll of Enchant Boots - Minor Speed" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: Velocidad menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38837;
-- AC datas : OLD Name : "Encantar arma: arma ígnea", Name AC enUS : "Scroll of Enchant Weapon - Fiery Weapon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: arma ígnea', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38838;
-- AC datas : OLD Name : "Encantar escudo: espíritu superior", Name AC enUS : "Scroll of Enchant Shield - Greater Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: espíritu superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38839;
-- AC datas : OLD Name : "Encantar arma: matanza de demonios", Name AC enUS : "Scroll of Enchant Weapon - Demonslaying" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: matanza de demonios', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38840;
-- AC datas : OLD Name : "Encantar pechera: maná excelente", Name AC enUS : "Scroll of Enchant Chest - Superior Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38841;
-- AC datas : OLD Name : "Encantar brazales: esquivar", Name AC enUS : "Scroll of Enchant Bracer - Deflection" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: Desvío', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38842;
-- AC datas : OLD Name : "Encantar escudo: Resistencia a la Escarcha", Name AC enUS : "Scroll of Enchant Shield - Frost Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: Resistencia a la Escarcha', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38843;
-- AC datas : OLD Name : "Encantar botas: Agilidad", Name AC enUS : "Scroll of Enchant Boots - Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: Agilidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38844;
-- AC datas : OLD Name : "Encantar arma 2M: impacto superior", Name AC enUS : "Scroll of Enchant 2H Weapon - Greater Impact" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: impacto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38845;
-- AC datas : OLD Name : "Encantar brazales: fuerza superior", Name AC enUS : "Scroll of Enchant Bracer - Greater Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: fuerza superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38846;
-- AC datas : OLD Name : "Encantar pechera: estadísticas", Name AC enUS : "Scroll of Enchant Chest - Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38847;
-- AC datas : OLD Name : "Encantar arma: golpear superior", Name AC enUS : "Scroll of Enchant Weapon - Greater Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpear superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38848;
-- AC datas : OLD Name : "Encantar brazales: aguante superior", Name AC enUS : "Scroll of Enchant Bracer - Greater Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38849;
-- AC datas : OLD Name : "Encantar guantes: equitación", Name AC enUS : "Scroll of Enchant Gloves - Riding Skill" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: equitación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38850;
-- AC datas : OLD Name : "Encantar guantes: celeridad menor", Name AC enUS : "Scroll of Enchant Gloves - Minor Haste" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: celeridad menor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38851;
-- AC datas : OLD Name : "Encantar brazales: Intelecto superior", Name AC enUS : "Scroll of Enchant Bracer - Greater Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: Intelecto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38852;
-- AC datas : OLD Name : "Encantar brazales: espíritu excelente", Name AC enUS : "Scroll of Enchant Bracer - Superior Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38853;
-- AC datas : OLD Name : "Encantar brazales: fuerza excelente", Name AC enUS : "Scroll of Enchant Bracer - Superior Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: fuerza excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38854;
-- AC datas : OLD Name : "Encantar brazales: aguante excelente", Name AC enUS : "Scroll of Enchant Bracer - Superior Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38855;
-- AC datas : OLD Name : "Encantar guantes: agilidad superior", Name AC enUS : "Scroll of Enchant Gloves - Greater Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: agilidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38856;
-- AC datas : OLD Name : "Encantar guantes: fuerza superior", Name AC enUS : "Scroll of Enchant Gloves - Greater Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: fuerza superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38857;
-- AC datas : OLD Name : "Encantar capa: resistencia superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38858;
-- AC datas : OLD Name : "Encantar capa: defensa excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: defensa excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38859;
-- AC datas : OLD Name : "Encantar escudo: Vitalidad", Name AC enUS : "Scroll of Enchant Shield - Vitality" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: Vitalidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38860;
-- AC datas : OLD Name : "Encantar escudo: aguante superior", Name AC enUS : "Scroll of Enchant Shield - Greater Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38861;
-- AC datas : OLD Name : "Encantar botas: aguante superior", Name AC enUS : "Scroll of Enchant Boots - Greater Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: aguante superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38862;
-- AC datas : OLD Name : "Encantar botas: agilidad superior", Name AC enUS : "Scroll of Enchant Boots - Greater Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: agilidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38863;
-- AC datas : OLD Name : "Encantar botas: espíritu", Name AC enUS : "Scroll of Enchant Boots - Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: espíritu', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38864;
-- AC datas : OLD Name : "Encantar pechera: estadísticas superiores", Name AC enUS : "Scroll of Enchant Chest - Greater Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas superiores', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38865;
-- AC datas : OLD Name : "Encantar pechera: salud sublime", Name AC enUS : "Scroll of Enchant Chest - Major Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38866;
-- AC datas : OLD Name : "Encantar pechera: maná sublime", Name AC enUS : "Scroll of Enchant Chest - Major Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38867;
-- AC datas : OLD Name : "Encantar arma: escalofrío gélido", Name AC enUS : "Scroll of Enchant Weapon - Icy Chill" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: escalofrío gélido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38868;
-- AC datas : OLD Name : "Encantar arma 2M: impacto excelente", Name AC enUS : "Scroll of Enchant 2H Weapon - Superior Impact" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: impacto excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38869;
-- AC datas : OLD Name : "Encantar arma: golpes excelentes", Name AC enUS : "Scroll of Enchant Weapon - Superior Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpes excelentes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38870;
-- AC datas : OLD Name : "Encantar arma: robo de vida", Name AC enUS : "Scroll of Enchant Weapon - Lifestealing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: robo de vida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38871;
-- AC datas : OLD Name : "Encantar arma: arma profana", Name AC enUS : "Scroll of Enchant Weapon - Unholy Weapon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: arma profana', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38872;
-- AC datas : OLD Name : "Encantar arma: cruzado", Name AC enUS : "Scroll of Enchant Weapon - Crusader" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: cruzado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38873;
-- AC datas : OLD Name : "Encantar arma 2M: espíritu sublime", Name AC enUS : "Scroll of Enchant 2H Weapon - Major Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: espíritu sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38874;
-- AC datas : OLD Name : "Encantar arma 2M: intelecto sublime", Name AC enUS : "Scroll of Enchant 2H Weapon - Major Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: intelecto sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38875;
-- AC datas : OLD Name : "Encantar arma: poderío del invierno", Name AC enUS : "Scroll of Enchant Weapon - Winter's Might" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poderío del invierno', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38876;
-- AC datas : OLD Name : "Encantar arma: poder con hechizos", Name AC enUS : "Scroll of Enchant Weapon - Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poder con hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38877;
-- AC datas : OLD Name : "Encantar arma: poder de sanación", Name AC enUS : "Scroll of Enchant Weapon - Healing Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poder de sanación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38878;
-- AC datas : OLD Name : "Encantar arma: fuerza", Name AC enUS : "Scroll of Enchant Weapon - Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: fuerza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38879;
-- AC datas : OLD Name : "Encantar arma: Agilidad", Name AC enUS : "Scroll of Enchant Weapon - Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Agilidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38880;
-- AC datas : OLD Name : "Encantar brazales: regeneración de maná", Name AC enUS : "Scroll of Enchant Bracer - Mana Regeneration" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: regeneración de maná', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38881;
-- AC datas : OLD Name : "Encantar brazales: poder de sanación", Name AC enUS : "Scroll of Enchant Bracer - Healing Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: poder de sanación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38882;
-- AC datas : OLD Name : "Encantar arma: espíritu poderoso", Name AC enUS : "Scroll of Enchant Weapon - Mighty Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: espíritu poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38883;
-- AC datas : OLD Name : "Encantar arma: intelecto poderoso", Name AC enUS : "Scroll of Enchant Weapon - Mighty Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: intelecto poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38884;
-- AC datas : OLD Name : "Encantar guantes: amenaza", Name AC enUS : "Scroll of Enchant Gloves - Threat" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: amenaza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38885;
-- AC datas : OLD Name : "Encantar guantes: Poder de las Sombras", Name AC enUS : "Scroll of Enchant Gloves - Shadow Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Poder de las Sombras', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38886;
-- AC datas : OLD Name : "Encantar guantes: Poder de Escarcha", Name AC enUS : "Scroll of Enchant Gloves - Frost Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Poder de Escarcha', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38887;
-- AC datas : OLD Name : "Encantar guantes: Poder de Fuego", Name AC enUS : "Scroll of Enchant Gloves - Fire Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Poder de Fuego', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38888;
-- AC datas : OLD Name : "Encantar guantes: poder de sanación", Name AC enUS : "Scroll of Enchant Gloves - Healing Power" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: poder de sanación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38889;
-- AC datas : OLD Name : "Encantar guantes: agilidad excelente", Name AC enUS : "Scroll of Enchant Gloves - Superior Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: agilidad excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38890;
-- AC datas : OLD Name : "Encantar capa: Resistencia al Fuego superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Fire Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia al Fuego superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38891;
-- AC datas : OLD Name : "Encantar capa: resistencia a la Naturaleza superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Nature Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia a la Naturaleza superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38892;
-- AC datas : OLD Name : "Encantar capa: sigilo", Name AC enUS : "Scroll of Enchant Cloak - Stealth" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: sigilo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38893;
-- AC datas : OLD Name : "Encantar capa: sutileza", Name AC enUS : "Scroll of Enchant Cloak - Subtlety" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: sutileza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38894;
-- AC datas : OLD Name : "Encantar capa: esquivar", Name AC enUS : "Scroll of Enchant Cloak - Dodge" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: esquivar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38895;
-- AC datas : OLD Name : "Encantar arma 2M: Agilidad", Name AC enUS : "Scroll of Enchant 2H Weapon - Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: Agilidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38896;
-- AC datas : OLD Name : "Encantar brazales: lozanía", Name AC enUS : "Scroll of Enchant Bracer - Brawn" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: lozanía', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38897;
-- AC datas : OLD Name : "Encantar brazales: estadísticas", Name AC enUS : "Scroll of Enchant Bracer - Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: estadísticas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38898;
-- AC datas : OLD Name : "Encantar brazales: esquivar superior", Name AC enUS : "Scroll of Enchant Bracer - Major Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: defensa sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38899;
-- AC datas : OLD Name : "Encantar brazales: sanación excelente", Name AC enUS : "Scroll of Enchant Bracer - Superior Healing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: sanación excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38900;
-- AC datas : OLD Name : "Encantar brazales: restaurar maná de primera", Name AC enUS : "Scroll of Enchant Bracer - Restore Mana Prime" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: restaurar maná de primera', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38901;
-- AC datas : OLD Name : "Encantar brazales: entereza", Name AC enUS : "Scroll of Enchant Bracer - Fortitude" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: entereza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38902;
-- AC datas : OLD Name : "Encantar brazales: poder con hechizos", Name AC enUS : "Scroll of Enchant Bracer - Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: poder con hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38903;
-- AC datas : OLD Name : "Encantar escudo: esquivar inferior", Name AC enUS : "Scroll of Enchant Shield - Tough Shield" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: escudo consistente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38904;
-- AC datas : OLD Name : "Encantar escudo: intelecto", Name AC enUS : "Scroll of Enchant Shield - Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: intelecto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38905;
-- AC datas : OLD Name : "Encantar escudo: parar", Name AC enUS : "Scroll of Enchant Shield - Shield Block" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: bloquear con escudo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38906;
-- AC datas : OLD Name : "Encantar escudo: resistencia", Name AC enUS : "Scroll of Enchant Shield - Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: Resistencia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38907;
-- AC datas : OLD Name : "Encantar botas: vitalidad", Name AC enUS : "Scroll of Enchant Boots - Vitality" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: vitalidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38908;
-- AC datas : OLD Name : "Encantar botas: entereza", Name AC enUS : "Scroll of Enchant Boots - Fortitude" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: entereza', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38909;
-- AC datas : OLD Name : "Encantar botas: Pies de plomo", Name AC enUS : "Scroll of Enchant Boots - Surefooted" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: Pies de plomo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38910;
-- AC datas : OLD Name : "Encantar pechera: salud excepcional", Name AC enUS : "Scroll of Enchant Chest - Exceptional Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38911;
-- AC datas : OLD Name : "Encantar pechera: maná excepcional", Name AC enUS : "Scroll of Enchant Chest - Exceptional Mana" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: maná excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38912;
-- AC datas : OLD Name : "Encantar pechera: estadísticas excepcionales", Name AC enUS : "Scroll of Enchant Chest - Exceptional Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas excepcionales', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38913;
-- AC datas : OLD Name : "Encantar capa: armadura sublime", Name AC enUS : "Scroll of Enchant Cloak - Major Armor" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: armadura sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38914;
-- AC datas : OLD Name : "Encantar capa: resistencia sublime", Name AC enUS : "Scroll of Enchant Cloak - Major Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38915;
-- AC datas : OLD Name : "Encantar arma: espíritu sublime", Name AC enUS : "Enchant Weapon - Major Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: espíritu sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38916;
-- AC datas : OLD Name : "Encantar arma: golpear sublime", Name AC enUS : "Scroll of Enchant Weapon - Major Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: golpear sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38917;
-- AC datas : OLD Name : "Encantar arma: intelecto sublime", Name AC enUS : "Scroll of Enchant Weapon - Major Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: intelecto sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38918;
-- AC datas : OLD Name : "Encantar arma 2M: salvajismo", Name AC enUS : "Scroll of Enchant 2H Weapon - Savagery" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: Salvajismo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38919;
-- AC datas : OLD Name : "Encantar arma: potencia", Name AC enUS : "Scroll of Enchant Weapon - Potency" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: potencia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38920;
-- AC datas : OLD Name : "Encantar arma: poder con hechizos sublime", Name AC enUS : "Scroll of Enchant Weapon - Major Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poder con hechizos sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38921;
-- AC datas : OLD Name : "Encantar arma 2M: agilidad sublime", Name AC enUS : "Scroll of Enchant 2H Weapon - Major Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: agilidad sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38922;
-- AC datas : OLD Name : "Encantar arma: Fuego solar", Name AC enUS : "Scroll of Enchant Weapon - Sunfire" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Fuego Solar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38923;
-- AC datas : OLD Name : "Encantar arma: escarcha de alma", Name AC enUS : "Scroll of Enchant Weapon - Soulfrost" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: escarcha de alma', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38924;
-- AC datas : OLD Name : "Encantar arma: mangosta", Name AC enUS : "Scroll of Enchant Weapon - Mongoose" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: mangosta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38925;
-- AC datas : OLD Name : "Encantar arma: oleada de hechizos", Name AC enUS : "Scroll of Enchant Weapon - Spellsurge" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: oleada de hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38926;
-- AC datas : OLD Name : "Encantar arma: maestro de batalla", Name AC enUS : "Scroll of Enchant Weapon - Battlemaster" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: maestro de batalla', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38927;
-- AC datas : OLD Name : "Encantar pechera: espíritu sublime", Name AC enUS : "Scroll of Enchant Chest - Major Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: espíritu sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38928;
-- AC datas : OLD Name : "Encantar pechera: restaurar maná de primera", Name AC enUS : "Scroll of Enchant Chest - Restore Mana Prime" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: restaurar maná de primera', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38929;
-- AC datas : OLD Name : "Encantar pechera: temple sublime", Name AC enUS : "Scroll of Enchant Chest - Major Resilience" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: temple sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38930;
-- AC datas : OLD Name : "Encantar guantes: detonación", Name AC enUS : "Scroll of Enchant Gloves - Blasting" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Detonación', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38931;
-- AC datas : OLD Name : "Encantar guantes: Golpes precisos", Name AC enUS : "Scroll of Enchant Gloves - Precise Strikes" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Golpes precisos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38932;
-- AC datas : OLD Name : "Encantar guantes: fuerza sublime", Name AC enUS : "Scroll of Enchant Gloves - Major Strength" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: fuerza sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38933;
-- AC datas : OLD Name : "Encantar guantes: asalto", Name AC enUS : "Scroll of Enchant Gloves - Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Asalto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38934;
-- AC datas : OLD Name : "Encantar guantes: poder con hechizos sublime", Name AC enUS : "Scroll of Enchant Gloves - Major Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: poder con hechizos sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38935;
-- AC datas : OLD Name : "Encantar guantes: sanación sublime", Name AC enUS : "Scroll of Enchant Gloves - Major Healing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: sanación sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38936;
-- AC datas : OLD Name : "Encantar brazales: intelecto sublime", Name AC enUS : "Scroll of Enchant Bracer - Major Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: intelecto sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38937;
-- AC datas : OLD Name : "Encantar brazales: asalto inferior", Name AC enUS : "Scroll of Enchant Bracer - Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: Asalto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38938;
-- AC datas : OLD Name : "Encantar capa: penetración de hechizos", Name AC enUS : "Scroll of Enchant Cloak - Spell Penetration" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: penetración de hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38939;
-- AC datas : OLD Name : "Encantar capa: agilidad superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: agilidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38940;
-- AC datas : OLD Name : "Encantar capa: resistencia a lo Arcano superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Arcane Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia a lo Arcano superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38941;
-- AC datas : OLD Name : "Encantar capa: resistencia a las Sombras superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Shadow Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia a las Sombras superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38942;
-- AC datas : OLD Name : "Encantar botas: presteza felina", Name AC enUS : "Scroll of Enchant Boots - Cat's Swiftness" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: presteza felina', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38943;
-- AC datas : OLD Name : "Encantar botas: velocidad de jabalí", Name AC enUS : "Scroll of Enchant Boots - Boar's Speed" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: velocidad de jabalí', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38944;
-- AC datas : OLD Name : "Encantar escudo: aguante sublime", Name AC enUS : "Scroll of Enchant Shield - Major Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38945;
-- AC datas : OLD Name : "Encantar arma: sanación sublime", Name AC enUS : "Scroll of Enchant Weapon - Major Healing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: sanación sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38946;
-- AC datas : OLD Name : "Encantar arma: agilidad superior", Name AC enUS : "Scroll of Enchant Weapon - Greater Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: agilidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38947;
-- AC datas : OLD Name : "Encantar arma: verdugo", Name AC enUS : "Scroll of Enchant Weapon - Executioner" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: verdugo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38948;
-- AC datas : OLD Name : "Encantar escudo: temple", Name AC enUS : "Scroll of Enchant Shield - Resilience" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: temple', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38949;
-- AC datas : OLD Name : "Encantar capa: Resistencia a la Escarcha excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Frost Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia a la Escarcha excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38950;
-- AC datas : OLD Name : "Encantar guantes: Pericia", Name AC enUS : "Scroll of Enchant Gloves - Expertise" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Pericia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38951;
-- AC datas : OLD Name : "Encantar guantes: Precisión", Name AC enUS : "Scroll of Enchant Gloves - Precision" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: Precisión', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38953;
-- AC datas : OLD Name : "Encantar escudo: esquivar", Name AC enUS : "Scroll of Enchant Shield - Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: defensa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38954;
-- AC datas : OLD Name : "Encantar pechera: salud poderosa", Name AC enUS : "Scroll of Enchant Chest - Mighty Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: salud poderosa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38955;
-- AC datas : OLD Name : "Encantar capa: resistencia a la Naturaleza excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Nature Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: resistencia a la Naturaleza excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38956;
-- AC datas : OLD Name : "Encantar arma: intelecto excepcional", Name AC enUS : "Scroll of Enchant Weapon - Exceptional Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: intelecto excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38958;
-- AC datas : OLD Name : "Encantar capa: agilidad excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: agilidad excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38959;
-- AC datas : OLD Name : "Encantar guantes: recolector", Name AC enUS : "Scroll of Enchant Gloves - Gatherer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: recolector', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38960;
-- AC datas : OLD Name : "Encantar botas: espíritu superior", Name AC enUS : "Scroll of Enchant Boots - Greater Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: espíritu superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38961;
-- AC datas : OLD Name : "Encantar pechera: restaurar maná superior", Name AC enUS : "Scroll of Enchant Chest - Greater Mana Restoration" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: restaurar maná superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38962;
-- AC datas : OLD Name : "Encantar arma: espíritu excepcional", Name AC enUS : "Scroll of Enchant Weapon - Exceptional Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: espíritu excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38963;
-- AC datas : OLD Name : "Encantar guantes: asalto superior", Name AC enUS : "Scroll of Enchant Gloves - Greater Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: asalto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38964;
-- AC datas : OLD Name : "Encantar arma: Rompehielo", Name AC enUS : "Scroll of Enchant Weapon - Icebreaker" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Rompehielo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38965;
-- AC datas : OLD Name : "Encantar botas: entereza superior", Name AC enUS : "Scroll of Enchant Boots - Greater Fortitude" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: entereza superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38966;
-- AC datas : OLD Name : "Encantar guantes: agilidad sublime", Name AC enUS : "Scroll of Enchant Gloves - Major Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: agilidad sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38967;
-- AC datas : OLD Name : "Encantar brazales: intelecto excepcional", Name AC enUS : "Scroll of Enchant Bracers - Exceptional Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: intelecto excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38968;
-- AC datas : OLD Name : "Encantar capa: Resistencia al Fuego excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Fire Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia al Fuego excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38969;
-- AC datas : OLD Name : "Encantar brazales: asalto", Name AC enUS : "Scroll of Enchant Bracers - Striking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: golpear', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38971;
-- AC datas : OLD Name : "Encantar arma: Resguardo de vida", Name AC enUS : "Scroll of Enchant Weapon - Lifeward" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Resguardo de vida', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38972;
-- AC datas : OLD Name : "Encantar capa: Perforar con hechizos", Name AC enUS : "Scroll of Enchant Cloak - Spell Piercing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Perforar con hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38973;
-- AC datas : OLD Name : "Encantar botas: vitalidad superior", Name AC enUS : "Scroll of Enchant Boots - Greater Vitality" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: vitalidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38974;
-- AC datas : OLD Name : "Encantar pechera: temple excepcional", Name AC enUS : "Scroll of Enchant Chest - Exceptional Resilience" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: temple excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38975;
-- AC datas : OLD Name : "Encantar botas: agilidad excelente", Name AC enUS : "Scroll of Enchant Boots - Superior Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: agilidad excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38976;
-- AC datas : OLD Name : "Encantar capa: Resistencia a las Sombras excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Shadow Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia a las Sombras excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38977;
-- AC datas : OLD Name : "Encantar capa: esquivar excelente", Name AC enUS : "Scroll of Enchant Cloak - Titanweave" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: tejido de titán', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38978;
-- AC datas : OLD Name : "Encantar guantes: poder con hechizos excepcional", Name AC enUS : "Scroll of Enchant Gloves - Exceptional Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: poder con hechizos excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38979;
-- AC datas : OLD Name : "Encantar brazales: espíritu sublime", Name AC enUS : "Scroll of Enchant Bracers - Major Spirit" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: espíritu sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38980;
-- AC datas : OLD Name : "Encantar arma 2M: Finiquiplaga", Name AC enUS : "Scroll of Enchant 2H Weapon - Scourgebane" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: Finiquiplaga', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38981;
-- AC datas : OLD Name : "Encantar capa: Resistencia a lo Arcano excelente", Name AC enUS : "Scroll of Enchant Cloak - Superior Arcane Resistance" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Resistencia a lo Arcano excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38982;
-- AC datas : OLD Name : "Encantar escudo: aguante poderoso", Name AC enUS : "Scroll of Enchant Shield - Exceptional Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: aguante poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38983;
-- AC datas : OLD Name : "Encantar brazales: Pericia", Name AC enUS : "Scroll of Enchant Bracer - Expertise" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: Pericia', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38984;
-- AC datas : OLD Name : "Encantar guantes: detonación superior", Name AC enUS : "Scroll of Enchant Gloves - Greater Blasting" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: detonación superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38985;
-- AC datas : OLD Name : "Encantar botas: caminante del hielo", Name AC enUS : "Scroll of Enchant Boots - Icewalker" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: caminante del hielo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38986;
-- AC datas : OLD Name : "Encantar brazales: estadísticas superiores", Name AC enUS : "Scroll of Enchant Bracers - Greater Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: estadísticas superiores', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38987;
-- AC datas : OLD Name : "Encantar arma: matagigantes", Name AC enUS : "Scroll of Enchant Weapon - Giant Slayer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: matagigantes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38988;
-- AC datas : OLD Name : "Encantar pechera: estadísticas excelentes", Name AC enUS : "Scroll of Enchant Chest - Super Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas excelentes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38989;
-- AC datas : OLD Name : "Encantar guantes: armero", Name AC enUS : "Scroll of Enchant Gloves - Armsman" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: armero', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38990;
-- AC datas : OLD Name : "Encantar arma: poder con hechizos excepcional", Name AC enUS : "Scroll of Enchant Weapon - Exceptional Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poder con hechizos excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38991;
-- AC datas : OLD Name : "Encantar arma 2M: Salvajismo superior", Name AC enUS : "Scroll of Enchant 2H Weapon - Greater Savagery" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: Salvajismo superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38992;
-- AC datas : OLD Name : "Encantar capa: armadura de las Sombras", Name AC enUS : "Scroll of Enchant Cloak - Shadow Armor" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: armadura de las Sombras', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38993;
-- AC datas : OLD Name : "Encantar arma: sanación excepcional", Name AC enUS : "Scroll of Enchant Weapon - Exceptional Healing" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: sanación excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38994;
-- AC datas : OLD Name : "Encantar arma: agilidad excepcional", Name AC enUS : "Scroll of Enchant Weapon - Exceptional Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: agilidad excepcional', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38995;
-- AC datas : OLD Name : "Encantar brazales: poder con hechizos superior", Name AC enUS : "Scroll of Enchant Bracers - Greater Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: poder con hechizos superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38997;
-- AC datas : OLD Name : "Encantar arma: escarcha letal", Name AC enUS : "Scroll of Enchant Weapon - Deathfrost" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: escarcha letal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38998;
-- AC datas : OLD Name : "Encantar pechera: esquivar", Name AC enUS : "Scroll of Enchant Chest - Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: defensa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38999;
-- AC datas : OLD Name : "Encantar capa: esquivar superior", Name AC enUS : "Scroll of Enchant Cloak - Steelweave" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: tejido de acero', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39000;
-- AC datas : OLD Name : "Encantar capa: Armadura poderosa", Name AC enUS : "Scroll of Enchant Cloak - Mighty Armor" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Armadura poderosa', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39001;
-- AC datas : OLD Name : "Encantar pechera: esquivar superior", Name AC enUS : "Scroll of Enchant Chest - Greater Defense" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: defensa superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39002;
-- AC datas : OLD Name : "Encantar capa: velocidad superior", Name AC enUS : "Scroll of Enchant Cloak - Greater Speed" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: velocidad superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39003;
-- AC datas : OLD Name : "Encantar capa: sabiduría", Name AC enUS : "Scroll of Enchant Cloak - Wisdom" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: sabiduría', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39004;
-- AC datas : OLD Name : "Encantar pechera: súper salud", Name AC enUS : "Scroll of Enchant Chest - Super Health" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: súper salud', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39005;
-- AC datas : OLD Name : "Encantar botas: vitalidad colmillarr", Name AC enUS : "Scroll of Enchant Boots - Tuskarr's Vitality" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: vitalidad colmillarr', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39006;
-- AC datas : OLD Description : "Normalmente se obtiene moliendo pálida, espina de oro, mostacho de Khadgar o dientes de dragón.", Description AC enUS : "Commonly obtained when milling Fadeleaf, Goldthorn, Khadgar's Whisker, or Wintersbite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Normalmente se obtiene moliendo pálida, espina de oro, mostacho de Khadgar o Invernalia.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39339;
-- AC datas : OLD Description : "Normalmente se obtiene moliendo sansam dorado, hojasueño, salviargenta de montaña, musgopena o setelo.", Description AC enUS : "Commonly obtained when milling Golden Sansam, Dreamfoil, Mountain Silversage, Plaguebloom, or Icecap." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Normalmente se obtiene moliendo sansam dorado, hojasueño, salviargenta de montaña, flor de peste o setelo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39341;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos sin restricciones de nivel.", Description AC enUS : "Can be targeted by Weapon enchantments to store the enchantment for later use.  Only able to absorb enchantments with no level restrictions." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos sin restricciones de nivel.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39349;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos con restricciones de nivel 35 o inferior.", Description AC enUS : "Can be targeted by Weapon enchantments to store the enchantment for later use.  Only able to absorb enchantments with a level restriction of 35 or lower." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos con restricciones de nivel 35 o inferior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39350;
-- AC datas : OLD Name : "ObsoleteSigilo del caído recordado DO NOT USE", Name AC enUS : "Sigil of the Remembered Fallen - DO NOT USE" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sigilo del caído recordado DO NOT USE', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39715;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39728;
-- AC datas : OLD Name : "Calcedonia brillante", Name AC enUS : "Sparkling Chalcedony" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calcedonia chispeante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39920;
-- AC datas : OLD Name : "Cristal de Sombras de defensor", Name AC enUS : "Defender's Shadow Crystal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cristal de sombras del defensor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39939;
-- AC datas : OLD Name : "Citrino enorme iluminado", Name AC enUS : "Lucent Huge Citrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Citrino enorme luciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 39954;
-- AC datas : OLD Name : "Brillo de otoño luminoso", Name AC enUS : "Brilliant Autumn's Glow" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brillo del otoño luminoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40012;
-- AC datas : OLD Name : "Brillo de otoño rígido", Name AC enUS : "Rigid Autumn's Glow" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Brillo del otoño rígido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40014;
-- AC datas : OLD Name : "Topacio monarca iluminado", Name AC enUS : "Lucent Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Topacio monarca luciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40045;
-- AC datas : OLD Name : "Piedra de terror de defensor", Name AC enUS : "Defender's Dreadstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de terror del defensor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40139;
-- AC datas : OLD Name : "Ametrino resplandeciente", Name AC enUS : "Resplendent Ametrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ametrino rutilante', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40145;
-- AC datas : OLD Name : "Ametrino iluminado", Name AC enUS : "Lucent Ametrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ametrino luciente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40149;
-- AC datas : OLD Name : "Ojo de Zul irregular", Name AC enUS : "Jagged Eye of Zul" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ojo de Zul dentado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40165;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40267;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40322;
-- AC datas : OLD Name : "Vial destrozado", Name AC enUS : "Enchanted Vial" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Vial encantado', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40411;
-- AC datas : OLD Name : "Yelmo de Aspecto azul", Name AC enUS : "Blue Aspect Helm" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Yelmo de Aspecto Azul', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40543;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40708;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40709;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40710;
-- AC datas : OLD Name : "Contenedor de gravedad gnómico", Name AC enUS : "Gnomish Gravity Well" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Asiento eyectable personal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40727;
-- AC datas : OLD Name : "Puños de la sombra ascendente", Name AC enUS : "Cuffs of the Shadow Ascendant" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puños del ascendiente de las Sombras', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40741;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Speed scales to riding skill." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'La velocidad varía según la habilidad de equitación.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40775;
-- AC datas : OLD Name : "ObsoleteSigilo de toque pestífero", Name AC enUS : "ObsoleteSigil of Pestilential Touch" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sigilo de toque pestífero', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40832;
-- AC datas : OLD Name : "ObsoleteSigilo del error glorioso", Name AC enUS : "ObsoleteSigil of the Glorious Mistake" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sigilo del error glorioso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40839;
-- AC datas : OLD Name : "Hacha pico afilada", Name AC enUS : "Bladed Pickaxe" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piqueta afilada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40893;
-- AC datas : OLD Name : "Glifo de Flebotomía", Name AC enUS : "Glyph of Shred" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Triturar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40901;
-- AC datas : OLD Name : "Glifo de Protección divina", Name AC enUS : "Glyph of Spiritual Attunement" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Armonización espiritual', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41096;
-- AC datas : OLD Name : "Piedra de fuego", Name AC enUS : "Lesser Firestone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Piedra de fuego inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41170;
-- AC datas : OLD Name : "Dirk de saronita mortal", Name AC enUS : "Deadly Saronite Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de saronita mortal', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41245;
-- AC datas : OLD Name : "Sangrita luminosa perfecta", Name AC enUS : "Perfect Runed Bloodstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sangrita rúnica perfecta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41438;
-- AC datas : OLD Name : "Sangrita sutil perfecta", Name AC enUS : "Perfect Subtle Bloodstone" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Sangrita sutil perfecto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41439;
-- AC datas : OLD Name : "Calcedonia brillante perfecta", Name AC enUS : "Perfect Sparkling Chalcedony" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calcedonia chispeante perfecta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41442;
-- AC datas : OLD Name : "Cristal de Sombras de defensor perfecto", Name AC enUS : "Perfect Defender's Shadow Crystal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cristal de sombras de defensor perfecto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41451;
-- AC datas : OLD Name : "Citrino enorme iluminado perfecto", Name AC enUS : "Perfect Lucent Huge Citrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Citrino enorme luciente perfecto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41493;
-- AC datas : OLD Name : "Cristal de sombras destellante perfecto", Name AC enUS : "Perfect Pristine Huge Citrine" ; Wowhead enUS : "",  OLD Description : "Encaja en una ranura de color rojo o azul.", Description AC enUS : "Matches a Red or Yellow Socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Citrino enorme prístino perfecto', `Description` = 'Encaja en una ranura de color rojo o amarillo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41496;
-- AC datas : OLD Name : "Boceto: citrino enorme iluminado", Name AC enUS : "Design: Lucent Huge Citrine" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un citrino enorme iluminado.", Description AC enUS : "Teaches you how to cut a Lucent Huge Citrine" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: citrino enorme luciente', `Description` = 'Te enseña a tallar un citrino enorme luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41565;
-- AC datas : OLD Name : "Boceto: cristal de sombras de defensor", Name AC enUS : "Design: Defender's Shadow Crystal" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un cristal de Sombras de defensor.", Description AC enUS : "Teaches you how to cut a Defender's Shadow Crystal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: cristal de sombras del defensor', `Description` = 'Te enseña a tallar un cristal de sombras del defensor.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41574;
-- AC datas : OLD Name : "Boceto: brillo del otoño rígido", Name AC enUS : "Design: Rigid Autumn's Glow" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un brillo del otoño rígido.", Description AC enUS : "Teaches you how to cut a Rigid Autumn's Glow" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Brillo del otoño rígido', `Description` = 'Te enseña a tallar un Brillo del otoño rígido.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41580;
-- AC datas : OLD Name : "Boceto: topacio monarca mortal", Name AC enUS : "Design: Wicked Monarch Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio monarca mortal.", Description AC enUS : "Teaches you how to cut a Wicked Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio monarca maligno', `Description` = 'Te enseña a tallar un topacio monarca maligno.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41721;
-- AC datas : OLD Name : "Boceto: topacio monarca de adepto", Name AC enUS : "Design: Glimmering Monarch Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio monarca de adepto.", Description AC enUS : "Teaches you how to cut a Glimmering Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio monarca de luz trémula', `Description` = 'Te enseña a tallar un topacio monarca de luz trémula.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41722;
-- AC datas : OLD Name : "Boceto: ópalo crepuscular intemporal", Name AC enUS : "Design: Glowing Twilight Opal" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ópalo crepuscular intemporal.", Description AC enUS : "Teaches you how to cut a Glowing Twilight Opal" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: ópalo crepuscular resplandeciente', `Description` = 'Te enseña a tallar un ópalo crepuscular resplandeciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41725;
-- AC datas : OLD Name : "Boceto: topacio monarca empecinado", Name AC enUS : "Design: Durable Monarch Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio monarca empecinado.", Description AC enUS : "Teaches you how to cut a Durable Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio monarca durable', `Description` = 'Te enseña a tallar un topacio monarca durable.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41730;
-- AC datas : OLD Name : "Boceto: topacio monarca luciente", Name AC enUS : "Design: Empowered Monarch Topaz" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un topacio monarca luciente.", Description AC enUS : "Teaches you how to cut a Empowered Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio monarca potenciado', `Description` = 'Te enseña a tallar un topacio monarca potenciado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41732;
-- AC datas : OLD Name : "Boceto: brillo del otoño grueso", Name AC enUS : "Design: Thick Autumn's Glow" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un brillo del otoño grueso.", Description AC enUS : "Teaches you how to cut a Thick Autumn's Glow" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Brillo del otoño grueso', `Description` = 'Te enseña a tallar un Brillo del otoño grueso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41791;
-- AC datas : OLD Name : "Boceto: ópalo crepuscular de precisión", Name AC enUS : "Design: Accurate Monarch Topaz" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: topacio monarca de precisión', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 41818;
-- AC datas : OLD Name : "Ojo de dragón rúnino", Name AC enUS : "Runed Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón rúnico', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42144;
-- AC datas : OLD Description : "Encaja en una ranura de color amarillo.", Description AC enUS : "Matches a Red socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42151;
-- AC datas : OLD Description : "Te enseña a tallar un ojo de dragón llamativo.", Description AC enUS : "Teaches you how to cut a Bold Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un Ojo de dragón llamativo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42298;
-- AC datas : OLD Name : "Boceto: ojo de dragón brillante", Name AC enUS : "Design: Bright Dragon's Eye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de dragón brillante.", Description AC enUS : "Teaches you how to cut a Bright Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón brillante', `Description` = 'Te enseña a tallar un Ojo de dragón brillante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42299;
-- AC datas : OLD Description : "Te enseña a tallar un ojo de dragón ostentoso.", Description AC enUS : "Teaches you how to cut a Flashing Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un Ojo de dragón ostentoso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42302;
-- AC datas : OLD Name : "Boceto: ojo de dragón fracturado", Name AC enUS : "Design: Fractured Dragon's Eye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de dragón fracturado.", Description AC enUS : "Teaches you how to cut a Fractured Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón fracturado', `Description` = 'Te enseña a tallar un Ojo de dragón fracturado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42303;
-- AC datas : OLD Name : "Boceto: ojo de dragón lustroso", Name AC enUS : "Design: Lustrous Dragon's Eye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de dragón lustroso.", Description AC enUS : "Teaches you how to cut a Lustrous Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón lustroso', `Description` = 'Te enseña a tallar un Ojo de dragón lustroso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42304;
-- AC datas : OLD Name : "Boceto: ojo de dragón rápido", Name AC enUS : "Design: Quick Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón rápido', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42307;
-- AC datas : OLD Name : "Boceto: ojo de dragón rúnico", Name AC enUS : "Design: Runed Dragon's Eye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de dragón rúnico.", Description AC enUS : "Teaches you how to cut a Runed Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón rúnico', `Description` = 'Te enseña a tallar un Ojo de dragón rúnico.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42309;
-- AC datas : OLD Name : "Boceto: ojo de dragón grueso", Name AC enUS : "Design: Thick Dragon's Eye" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de dragón grueso.", Description AC enUS : "Teaches you how to cut a Thick Dragon's Eye" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: Ojo de dragón grueso', `Description` = 'Te enseña a tallar un Ojo de dragón grueso.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42315;
-- AC datas : OLD Name : "Glifo de Seducción", Name AC enUS : "Glyph of Succubus" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de súcubo', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42471;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42593;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42594;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42595;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42596;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42597;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42598;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42599;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42601;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42602;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42603;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42604;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42606;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42607;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42608;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42609;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo, amarillo o azul. Solo puedes encajar una en tu equipo.", Description AC enUS : "Matches any Socket.  Maximum of one socketed in your equipment" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en cualquier ranura. Solo puedes encajar una en tu equipo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42701;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo, amarillo o azul. Solo puedes encajar una en tu equipo.", Description AC enUS : "Matches any Socket.  Maximum of one socketed in your equipment" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en cualquier ranura. Solo puedes encajar una en tu equipo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42702;
-- AC datas : OLD Name : "Glifo de Gema de maná", Name AC enUS : "Glyph of Mana Gem" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de gema de maná', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42750;
-- AC datas : OLD Name : "El anillo "D"", Name AC enUS : "The "D" Ring" ; Wowhead enUS : "",  OLD Description : "Para cuando el anillo "C" no sea eficaz.", Description AC enUS : "When the "C" ring just doesn't get the job done." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Anillo conmemorativo de expedición de K3', `Description` = '¡Edición limitada!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42812;
-- AC datas : OLD Name : "Glifo de halcón", Name AC enUS : "Glyph of the Hawk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo del halcón', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 42909;
-- AC datas : OLD Description : "Volumen XIX.", Description AC enUS : "Notes on the Arcanomicron" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Notas del arcanomicrón.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43095;
-- AC datas : OLD Description : "Rara vez se halla moliendo pálida, espina de oro, mostacho de Khadgar o dientes de dragón.", Description AC enUS : "Rarely found when milling Fadeleaf, Goldthorn, Khadgar's Whisker, or Wintersbite." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Rara vez se halla moliendo pálida, espina de oro, mostacho de Khadgar o Invernalia.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43105;
-- AC datas : OLD Description : "Raras veces se halla moliendo sansam dorado, hojasueño, salviargenta de montaña, musgopena o setelo.", Description AC enUS : "Rarely found when milling Golden Sansam, Dreamfoil, Mountain Silversage, Plaguebloom, or Icecap." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Raras veces se halla moliendo sansam dorado, hojasueño, salviargenta de montaña, flor de peste o setelo.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43107;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos con restricciones de nivel 60 o inferior.", Description AC enUS : "Can be targeted by Armor enchantments to store the enchantment for later use.  Only able to absorb enchantments with a level restriction of 60 or lower." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armadura para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos con restricciones de nivel 60 o inferior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43145;
-- AC datas : OLD Description : "Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo m├ís tarde. Solo puede absorber encantamientos con restricciones de nivel 60 o inferior.", Description AC enUS : "Can be targeted by Weapon enchantments to store the enchantment for later use.  Only able to absorb enchantments with a level restriction of 60 or lower." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Se puede marcar como el objetivo de varios encantamientos de armas para almacenar el encantamiento y usarlo más tarde. Solo puede absorber encantamientos con restricciones de nivel 60 o inferior.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43146;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison VIII" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo VIII', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43230;
-- AC datas : OLD Name : "Veneno instantáneo", Name AC enUS : "Instant Poison IX" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno instantáneo IX', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43231;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison VIII" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal VIII', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43232;
-- AC datas : OLD Name : "Veneno mortal", Name AC enUS : "Deadly Poison IX" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno mortal IX', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43233;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison VI" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente VI', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43234;
-- AC datas : OLD Name : "Veneno hiriente", Name AC enUS : "Wound Poison VII" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno hiriente VII', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43235;
-- AC datas : OLD Name : "Veneno anestésico", Name AC enUS : "Anesthetic Poison II" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Veneno anestésico II', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43237;
-- AC datas : OLD Name : "Glifo de Esclavizar demonio", Name AC enUS : "Glyph of Enslave Demon" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Subyugar demonio', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43393;
-- AC datas : OLD Name : "Glifo de Ira rabiosa", Name AC enUS : "Glyph of Bloodrage" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Ira sangrienta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43396;
-- AC datas : OLD Name : "Al Jefe de Guerra de la Horda", Name AC enUS : "To Thrall, Warchief of the Horde" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'A Thrall, Jefe de Guerra de la Horda', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43441;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43516;
-- AC datas : OLD Description : "Turalyon y Alleria, donde estéis, que estéis bien.", Description AC enUS : "Turalyon and Alleria, wherever you are, may you be well." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Turalyon y Alleria, donde estén, que estén bien.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43683;
-- AC datas : OLD Description : "Magos, os negáis a darme lo único que acelera el destino inevitable de dos enamorados cuando solo uno es tan ingenuo para darse cuenta. Os deseo lo peor.", Description AC enUS : "You mages refuse to provide me that which hastens the inevitable fate of two people in love, when only one is too naive to see it. I wish you all ruin." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Magos, se niegan a darme lo único que acelera el destino inevitable de dos enamorados cuando solo uno es tan ingenuo para darse cuenta. Les deseo lo peor.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43721;
-- AC datas : OLD Name : "Moneda de cobre de Vareesa", Name AC enUS : "Vareesa's Copper Coin" ; Wowhead enUS : "",  OLD Description : "Asto're da shan're. Turus Fulo Il'amare, A'Talah Adore. Isera'duna...", Description AC enUS : "Asto're da shan're. Turus Fulo Il'amare, A'Talah Adore. Isera'duna..." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Moneda de cobre de Vereesa', `Description` = NULL, `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43722;
-- AC datas : OLD Name : "Amuleto del nigromante malévolo", Name AC enUS : "Amulet of the Malefic Necromancer" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Amuleto del nigromante maléfico', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43884;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43951;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43952;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43953;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43954;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43955;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43956;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43958;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43959;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43961;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43962;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43963;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43964;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43986;
-- AC datas : OLD Name : "Encantar arma: magia negra", Name AC enUS : "Scroll of Enchant Weapon - Black Magic" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: magia negra', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43987;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44077;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44080;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44083;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44086;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44151;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44160;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44164;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44168;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44175;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora. Un personaje que no sea maestro jinete aprenderá esta habilidad la primera vez que la monte.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44177;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz. Esta montura solo se puede invocar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44178;
-- AC datas : OLD Name : "Dirk de la Luna Negra", Name AC enUS : "Darkmoon Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de la Luna Negra', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44217;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44223;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44224;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44225;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44226;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44230;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44231;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas con vendedores.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast three-person mount that carries vendors." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es una montura muy veloz para tres personas que lleva vendedores.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44234;
-- AC datas : OLD Description : "Te enseña a invocar una montura para tres personas con vendedores.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast three-person mount that carries vendors." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es una montura muy veloz para tres personas que lleva vendedores.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44235;
-- AC datas : OLD Name : "Encantar botas: Asalto", Name AC enUS : "Scroll of Enchant Boots - Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: Asalto', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44449;
-- AC datas : OLD Name : "Encantar arma: potencia superior", Name AC enUS : "Scroll of Enchant Weapon - Greater Potency" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: potencia superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44453;
-- AC datas : OLD Name : "Encantar escudo: intelecto III", Name AC enUS : "Scroll of Enchant Shield - Greater Intellect" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar escudo: Intelecto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44455;
-- AC datas : OLD Name : "Encantar capa: Velocidad", Name AC enUS : "Scroll of Enchant Cloak - Speed" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: Velocidad', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44456;
-- AC datas : OLD Name : "Encantar capa: agilidad sublime", Name AC enUS : "Scroll of Enchant Cloak - Major Agility" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar capa: agilidad sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44457;
-- AC datas : OLD Name : "Encantar guantes: triturador", Name AC enUS : "Scroll of Enchant Gloves - Crusher" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: triturador', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44458;
-- AC datas : OLD Name : "Encantar arma 2M: masacre", Name AC enUS : "Scroll of Enchant 2H Weapon - Massacre" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma 2M: masacre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44463;
-- AC datas : OLD Name : "Encantar pechera: estadísticas potentes", Name AC enUS : "Scroll of Enchant Chest - Powerful Stats" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar pechera: estadísticas potentes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44465;
-- AC datas : OLD Name : "Encantar arma: potencia excelente", Name AC enUS : "Scroll of Enchant Weapon - Superior Potency" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: potencia excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44466;
-- AC datas : OLD Name : "Encantar arma: poder con hechizos poderoso", Name AC enUS : "Scroll of Enchant Weapon - Mighty Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: poder con hechizos poderoso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44467;
-- AC datas : OLD Name : "Encantar botas: asalto superior", Name AC enUS : "Scroll of Enchant Boots - Greater Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: asalto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44469;
-- AC datas : OLD Name : "Encantar brazales: poder con hechizos excelente", Name AC enUS : "Scroll of Enchant Bracer - Superior Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: poder con hechizos excelente', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44470;
-- AC datas : OLD Name : "Encantar arma: Rabiar", Name AC enUS : "Scroll of Enchant Weapon - Berserking" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Rabiar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44493;
-- AC datas : OLD Name : "Encantar arma: Precisión", Name AC enUS : "Scroll of Enchant Weapon - Accuracy" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: Precisión', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44497;
-- AC datas : OLD Name : "Patrón estropeado", Name AC enUS : "Pattern: Dragonscale Ammo Pouch" ; Wowhead enUS : "",  OLD Description : "Aunque hayas leído antes este patrón, los elementos lo estropearon así que lo has olvidado de todas formas.", Description AC enUS : "Teaches you how to make a Dragonscale Ammo Pouch." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Patrón: faltriquera de munición de escamas de dragón', `Description` = 'Te enseña a hacer una faltriquera de munición de escamas de dragón.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44511;
-- AC datas : OLD Name : "Patrón estropeado", Name AC enUS : "Pattern: Nerubian Reinforced Quiver" ; Wowhead enUS : "",  OLD Description : "Este patrón que una vez fue útil, ha sido estropeado por los elementos.", Description AC enUS : "Teaches you how to make a Nerubian Reinforced Quiver." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Patrón: carcaj reforzado nerubiano', `Description` = 'Te enseña a hacer un carcaj reforzado nerubiano.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44512;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this rug.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta alfombra. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44554;
-- AC datas : OLD Name : "Alfombra de tela lunar presta (NOT IN GAME)", Name AC enUS : "Swift Mooncloth Carpet" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta alfombra. Es una montura voladora.", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Alfombra de tela lunar presta', `Description` = 'Te enseña a invocar esta alfombra. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44555;
-- AC datas : OLD Name : "Alfombra de fuego de hechizo presta (NOT IN GAME)", Name AC enUS : "Swift Spellfire Carpet" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta alfombra. Es una montura voladora.", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Alfombra de fuego de hechizo presta', `Description` = 'Te enseña a invocar esta alfombra. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44556;
-- AC datas : OLD Name : "Alfombra de tejido de ébano presta (NOT IN GAME)", Name AC enUS : "Swift Ebonweave Carpet" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Alfombra de tejido de ébano presta', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44557;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this rug.  Can only be summoned in Outland or Northrend.  This is a very fast rug." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta alfombra. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44558;
-- AC datas : OLD Description : "Esta joya mágica imita a la perfección la forma de un ojo de dragón azul.", Description AC enUS : "This magical jewel is perfectly formed into the likeness of a blue dragon's eye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Esta joya mágica imita a la perfección la forma de un ojo de dragón Azul.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44569;
-- AC datas : OLD Description : "Esta joya mágica imita a la perfección la forma de un ojo de dragón azul.", Description AC enUS : "This magical jewel is perfectly formed into the likeness of a blue dragon's eye." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Esta joya mágica imita a la perfección la forma de un ojo de dragón Azul.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44577;
-- AC datas : OLD Name : "Escrito sobre Luminosidad de Dalaran", Name AC enUS : "Tome of Dalaran Intellect" ; Wowhead enUS : "",  OLD Description : "Enseña Luminosidad Arcana al estilo de Dalaran.", Description AC enUS : "Teaches Arcane Intellect with a Dalaran flair." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Escrito sobre Intelecto de Dalaran', `Description` = 'Enseña Intelecto Arcano al estilo de Dalaran.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44602;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44689;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44690;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44707;
-- AC datas : OLD Name : "Cesta de huevos prestada", Name AC enUS : "Egg Basket" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Cesta de huevos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44802;
-- AC datas : OLD Description : "Escrito sobre Polimorfia: pavo", Description AC enUS : "Teaches Polymorph: Turkey" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Transforma al enemigo en un inofensivo pavo y le fuerza a andar durante un máximo de 50 sec. Mientras se pasea el pavo no puede atacar o lanzar hechizos, pero se regenerará muy rápido. Cualquier daño hará que el objetivo recupere su forma normal. Solo puedes cambiar de forma un objetivo al mismo tiempo. Solo funciona con bestias, humanoides y alimañas.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44811;
-- AC datas : OLD Name : "Encantar brazales: asalto superior", Name AC enUS : "Scroll of Enchant Bracers - Greater Assault" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: asalto superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44815;
-- AC datas : OLD Name : "Dracohalcón rojo", Name AC enUS : "Red Dragonhawk Mount" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Montura de dracohalcón rojo', `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44842;
-- AC datas : OLD Name : "Dracohalcón azul", Name AC enUS : "Blue Dragonhawk Mount" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Montura de dracohalcón azul', `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44843;
-- AC datas : OLD Description : "Te enseña a hacer un lanzatracas.", Description AC enUS : "Teaches you how to make a Firework Cluster Launcher." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a hacer un lanzatracas de fuegos de artificio.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44918;
-- AC datas : OLD Name : "Encantar arma: protección de titanes", Name AC enUS : "Scroll of Enchant Weapon - Titanguard" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: protección de titanio', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44946;
-- AC datas : OLD Name : "Encantar brazales: aguante sublime", Name AC enUS : "Scroll of Enchant Bracer - Major Stamina" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar brazales: aguante sublime', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44947;
-- AC datas : OLD Name : "Encantar bastón: poder con hechizos superior", Name AC enUS : "Scroll of Enchant Staff - Greater Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar bastón: poder con hechizos superior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45056;
-- AC datas : OLD Name : "Encantar bastón: poder con hechizos", Name AC enUS : "Scroll of Enchant Staff - Spellpower" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar bastón: poder con hechizos', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45060;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45114;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45125;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45169;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45255;
-- AC datas : OLD Name : "Tabardo Lanza Negra", Name AC enUS : "Sen'jin Tabard" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Tabardo de Sen''jin', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45582;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45586;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45589;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45590;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45591;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45592;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45593;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45595;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45596;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45597;
-- AC datas : OLD Name : "Encantar botas: Precisión inferior", Name AC enUS : "Scroll of Enchant Boots - Lesser Accuracy" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar botas: Precisión inferior', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45628;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this construction.  Can only be summoned in Outland or Northrend.  This is a very fast... head." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta construcción. Es... una cabeza muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45693;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45725;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45801;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45802;
-- AC datas : OLD Name : "Joya de tormenta luminosa", Name AC enUS : "Runed Stormjewel" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Joya de tormenta rúnica', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45883;
-- AC datas : OLD Name : "zzOLDGlifo de Envenenar", Name AC enUS : "Glyph of Envenom" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Envenenar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45908;
-- AC datas : OLD Name : "Dirk de Gladiador furioso", Name AC enUS : "Furious Gladiator's Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de Gladiador furioso', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45962;
-- AC datas : OLD Name : "Encantar arma: amparo de hojas", Name AC enUS : "Scroll of Enchant Weapon - Blade Ward" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: amparo de hojas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46026;
-- AC datas : OLD Name : "Encantar arma: drenador de sangre", Name AC enUS : "Scroll of Enchant Weapon - Blood Draining" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar arma: drenador de sangre', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46098;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46102;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46171;
-- AC datas : OLD Name : "Jaula para gatos (Gata tricolor)", Name AC enUS : "Calico Cat" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Gata tricolor', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46398;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46708;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46743;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46744;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46745;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46746;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46747;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46748;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46749;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46750;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46751;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46752;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46755;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46756;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46757;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46758;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46759;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46760;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46761;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46762;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46763;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46764;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : ""Teaches you how to summon this mount. This is a very fast mount."" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46778;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46813;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46814;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46815;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46816;
-- AC datas : OLD Description : "", Description AC enUS : "Tiffany Cartier of Dalaran would be very interested in this fine powder." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'A Timothy Jones de Dalaran le interesarían mucho estas partículas tan finas.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46849;
-- AC datas : OLD Name : "Boceto: ojo de Zul irregular", Name AC enUS : "Design: Jagged Eye of Zul" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ojo de Zul irregular.", Description AC enUS : "Teaches you how to cut a Jagged Eye of Zul." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de Zul dentado', `Description` = 'Te enseña a tallar un ojo de Zul dentado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46901;
-- AC datas : OLD Name : "Boceto: piedra de terror de defensor", Name AC enUS : "Design: Defender's Dreadstone" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una piedra de terror de defensor.", Description AC enUS : "Teaches you how to cut a Defender's Dreadstone." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: piedra de terror del defensor', `Description` = 'Te enseña a tallar una piedra de terror del defensor.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46941;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46978;
-- AC datas : OLD Description : "Te enseña a tallar un ametrino potenciado.", Description AC enUS : "Teaches you how to cut an Empowered Ametrine." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a crear un ametrino potenciado.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47016;
-- AC datas : OLD Name : "Boceto: ametrino resplandeciente", Name AC enUS : "Design: Resplendent Ametrine" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ametrino resplandeciente.", Description AC enUS : "Teaches you how to cut a Resplendent Ametrine." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: ametrino rutilante', `Description` = 'Te enseña a tallar un ametrino rutilante.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47018;
-- AC datas : OLD Name : "Boceto: ametrino iluminado", Name AC enUS : "Design: Lucent Ametrine" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar un ametrino iluminado.", Description AC enUS : "Teaches you how to cut a Lucent Ametrine." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: ametrino luciente', `Description` = 'Te enseña a tallar un ametrino luciente.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47021;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47101;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47179;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47180;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47665;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47666;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47667;
-- AC datas : OLD Name : "Dirk de La Guardia Nocturna", Name AC enUS : "Dirk of the Night Watch" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de La Guardia Nocturna', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47676;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47840;
-- AC datas : OLD Name : "Dirk de La Guardia Nocturna", Name AC enUS : "Dirk of the Night Watch" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de La Guardia Nocturna', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 47938;
-- AC datas : OLD Name : "Dirk de Gladiador incansable", Name AC enUS : "Relentless Gladiator's Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de Gladiador incansable', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 48428;
-- AC datas : OLD Name : "Manoplas de Caminante del Sol", Name AC enUS : "Sunstrider's Gauntlets" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Guanteletes de Caminante del Sol', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 48730;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49044;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49046;
-- AC datas : OLD Name : "Glifo de orden", Name AC enUS : "Glyph of Command" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Glifo de Ordenar', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49084;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49096;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49098;
-- AC datas : OLD Description : "Encaja en una ranura de color rojo, amarillo o azul. Solo puedes encajar una en tu equipo.", Description AC enUS : "Matches any socket." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Encaja en cualquier ranura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49110;
-- AC datas : OLD Name : "Boceto: lágrima de pesadilla", Name AC enUS : "Design: Nightmare Tear" ; Wowhead enUS : "",  OLD Description : "Te enseña a tallar una lágrima de pesadilla.", Description AC enUS : "Teaches you how to cut a Nightmare Tear." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Boceto: fragmento de pesadilla', `Description` = 'Te enseña a tallar un fragmento de pesadilla.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49112;
-- AC datas : OLD Description : "¡Soldados, resucitad, levantaos y luchad!", Description AC enUS : "Soldiers arise, stand and fight!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Soldados, álcense, levántense y luchen!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49128;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49282;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49284;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be used in Outland or Northrend." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Solo se puede usar en Terrallende o Rasganorte.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49285;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49286;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49290;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49636;
-- AC datas : OLD Name : "Calzones de piel de dragón negro", Name AC enUS : "Black Dragonskin Breeches" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Calzones de piel de dragón Negro', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49811;
-- AC datas : OLD Description : "Del Jefe de Guerra de la Horda, Garrosh.", Description AC enUS : "From the Warchief of the Horde, Thrall." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Del Jefe de Guerra de la Horda, Thrall.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49939;
-- AC datas : OLD Description : "De Muradin Barbabronce del Consejo de los Tres Martillos.", Description AC enUS : "From the Lord of Ironforge, King Magni Bronzebeard." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Del Señor de Forjaz, el rey Magni Barbabronce.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49940;
-- AC datas : OLD Description : "Del Gran jefe de Cima del Trueno, Baine Pezuña de Sangre.", Description AC enUS : "From the High Chieftain of Thunder Bluff, Cairne Bloodhoof." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Del Gran jefe de Cima del Trueno, Cairne Pezuña de Sangre.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49941;
-- AC datas : OLD Name : "Dirk desgastado", Name AC enUS : "Worn Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla desgastada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50055;
-- AC datas : OLD Name : "Dirk afilado", Name AC enUS : "Sharp Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla afilada', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50057;
-- AC datas : OLD Name : "Gran cohete de amor", Name AC enUS : "Big Love Rocket" ; Wowhead enUS : "",  OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Rompecorazones X-45', `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50250;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50435;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50458;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50463;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50464;
-- AC datas : OLD Name : "Encantar guantes: pescador", Name AC enUS : "Scroll of Enchant Gloves - Angler" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Pergamino de Encantar guantes: pescador', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50816;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50818;
-- AC datas : OLD Name : "Dirk de Gladiador colérico", Name AC enUS : "Wrathful Gladiator's Dirk" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Puntilla de Gladiador colérico', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51442;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51501;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51507;
-- AC datas : OLD Description : "Cuenta como un tótem de aire, tierra, fuego y agua.", Description AC enUS : "Counts as an Air, Earth, Fire, and Water totem." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Cuenta como un tótem de Aire, Tierra, Fuego y Agua.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51513;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51954;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount.  Can only be summoned in Outland or Northrend.  This is an extremely fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es extremadamente veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 51955;
-- AC datas : OLD Name : "Diseño: Balas destrozadoras", Name AC enUS : "Plans: Shatter Rounds" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Diseño: balas destrozadoras', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52022;
-- AC datas : OLD Name : "Suministros del Anillo de la Tierra", Name AC enUS : "Earthen Ring Supplies" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Bolsa de cosas de chamanes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52274;
-- AC datas : OLD Name : "Suministros del Anillo de la Tierra", Name AC enUS : "Earthen Ring Supplies" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Bolsa de cosas de chamanes', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52344;
-- AC datas : OLD Name : "Toga de recluta", Name AC enUS : "Recruit's Robe" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Toga de recluta del Día del Juicio Final', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52729;
-- AC datas : OLD Description : "Pequeños instrumentos portátiles que almacenan poderosos elementales.", Description AC enUS : "Small, portable devices housing powerful elementals." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Pequeños instrumentos portátiles que almacenan poderosos elementales de Fuego.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52835;
-- AC datas : OLD Description : "Te enseña a invocar esta montura.", Description AC enUS : "Teaches you how to summon this mount.  This is a very fast mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54068;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Es una montura voladora.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54069;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this rug.  Can only be summoned in Outland or Northrend.  This is a very fast rug." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta alfombra. Es muy veloz.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54797;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54811;
-- AC datas : OLD Description : "Te enseña a invocar esta montura. Cambia según tu habilidad en equitación y la zona en la que estés.", Description AC enUS : "Teaches you how to summon this mount." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te enseña a invocar esta montura.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54860;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Transforma al taumaturgo para que se parezca a un miembro de la facción contraria. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1973;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Provoca que todos los jugadores cercanos se pongan a bailar. (1 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 13379;
-- AC datas : OLD Description : "Para cuando el tiempo fuera dé miedo...", Description AC enUS : "For when the weather outside is frightful..." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te transforma en algo más acorde con la estación de invierno. Requiere una Bola de nieve.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17712;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Permite a un ingeniero experimentado convertir el agua en una bola de nieve. El Señor de las nieves necesita un día para acumular el frío necesario para crear otra bola de nieve. (1 Día Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 17716;
-- AC datas : OLD Description : "¡Solo con la tecnología gnómica se podría inventar un dispositivo que afectase a todo el mundo!", Description AC enUS : "Only Gnomish Technology could invent a device that affects the entire world!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Agranda el mundo entero durante 5 min o hasta que ataques. (15 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18660;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Rasga los muros dimensionales y te transporta a Vista Eterna en Cuna del Invierno. A veces hay problemas técnicos, ¡la ingeniería goblin es lo que tiene! (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18984;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Te transporta a Gadgetzan, Tanaris con total seguridad! ¡Con este instrumento no tendrás ningún contratiempo! (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 18986;
-- AC datas : OLD Description : "Un dispositivo que dicen que captura la luz que irradia Elune en persona.", Description AC enUS : "A device said to capture the light shed by Elune herself." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Crea una piedra elunarita. Requiere una piedra sólida. (1 Día Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 21540;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para invocar a una mascota robot que luchará contra otros robots luchadores. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 23767;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Desgarra los muros dimensionales y te lleva al Área 52 en Tormenta Abisal. A veces hay problemillas técnicos, pero ¡qué sería la ingeniería goblin sin ellos! (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30542;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te transporta de manera segura al la Estación de Toshley en Filospada. ¡Con este invento estás a salvo! ¡La ingeniería gnómica te lleva y de manera rápida y eficaz! (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30544;
-- AC datas : OLD Description : "Lo mejor después de ir a la Academia.", Description AC enUS : "The next best thing to going to the Academy." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Destruye ensamblajes de terror tecnológicos. (5 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30690;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Formula una pregunta y haz clic con el botón derecho para ver la respuesta! (30 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32542;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para montar un picnic tranquilito. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32566;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Transforma al taumaturgo para que tenga la apariencia de un arakkoa de Skettis. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 32782;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Es un traje de múrloc.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33079;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para crear una tetera de potaje goblin picante.El potaje goblin desaparece si el jugador permanece desconectado durante más de 15 min. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33219;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para sacar una cómoda silla para pescar. (5 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33223;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para espitar un cuñete de cerveza de la Fiesta de la cerveza deliciosa.La cerveza de la Fiesta de la cerveza desaparece si permaneces desconectado durante más de 15 minutos. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 33927;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para montar un picnic romántico. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34480;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para crear un girocóptero de papel. (30 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34499;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para colocar tu blandón de llamas bailarinas. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 34686;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para activar tu máquina de clima personal. (30 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35227;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Disfrázate como un elfo de sangre. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 35275;
-- AC datas : OLD Description : "Si necesitas algo, desde luego no se trata de un par de zapatos.", Description AC enUS : "Whatever you may need, it's not a pair of shoes!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Lanza un par de dados. ¡A ver si tienes suerte! (10 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 36862;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Tira unos dados. (10 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 36863;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Enloquece en una burbuja durante 5 min. (1 Hora Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37254;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Una correa de cuerda.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37460;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Invoca y controla tu coche de carreras triturador. (5 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37710;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Deja chispas de fuego vil a tu paso durante 5 min. (15 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38233;
-- AC datas : OLD Name : "D.I.S.C.O.", Name AC enUS : "D.I.S.C.O." ; Wowhead enUS : "",  OLD Description : "Dispositivo Integral de Sonido Cachondo y Original", Description AC enUS : "Dancer's Integrated Sonic Celebration Oscillator" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = NULL, `Description` = 'Haz clic con el botón derecho para empezar la fiesta. (5 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38301;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Coloca una bandera sobre un cadáver de un jugador enemigo frente a ti. (1 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 38578;
-- AC datas : OLD Name : "MOLL-E", Name AC enUS : "MOLL-E" ; Wowhead enUS : "",  OLD Description : "Maquinaria Organizadora de Libros Literarios Enormes", Description AC enUS : "Mobile Oversized Letter and Literary Extractor" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = NULL, `Description` = 'Crea un buzón portátil durante 10 min. MOLL-E no se destruye después de usarla. (2 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 40768;
-- AC datas : OLD Description : "Es hora de encargarse de algunos locos.", Description AC enUS : "It's Time to Pity Some Fools" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Haz clic con el botón derecho del ratón para encargarte de algunos locos!', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43489;
-- AC datas : OLD Description : "Tiene un sabor metálico...", Description AC enUS : "It has a metallic taste..." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Adopta la forma de un enano férreo durante 10 min. (Probabilidad de que accione: 10%, 30s de reutilización) (1 Hora Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43499;
-- AC datas : OLD Description : "Contiene el secreto del alto conocimiento.", Description AC enUS : "Contains the secret of higher learning." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Teletransporta al taumaturgo desde y a las agujas a lo alto de La Ciudadela Violeta. Este hechizo solo funcionará en la ciudad de Dalaran.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 43824;
-- AC datas : OLD Description : "Al sostener la moneda ante tus ojos ves que tiene un nivel de artesanía difícil de encontrar.", Description AC enUS : "Holding the coin up to your eye reveals a level of craftsmanship that you have rarely seen." ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Prueba suerte! (10 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44430;
-- AC datas : OLD Description : "¡Todos a bordo!", Description AC enUS : "All Aboard!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para colocar tu conjunto de trenes de juguete. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44606;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Saca el wolvar que hay en ti! (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44719;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Una correa de lazo rojo para mascota.', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 44820;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Ventormenta. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45011;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Cima del Trueno. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45013;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Orgrimmar. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45014;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Sen''jin. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45015;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Entrañas. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45016;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de la Ciudad de Lunargenta. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45017;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Forjaz. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45018;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Gnomeregan. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45019;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de El Exodar. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45020;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte de Darnassus. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45021;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para colocar un escachatrenes de cuerda. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45057;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para colocar un expositor para espadas de gomaespuma.Las espadas de gomaespuma desaparecen si el jugador permanece desconectado durante más de 15 min. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45063;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Apunta con la brújula! (10 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 45984;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Invoca y controla tu tonque de vapor. (30 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46709;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Coloca una piñata ogra rellena de caramelos. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46780;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para clavar tu estandarte del cruzado Argenta. (3 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 46843;
-- AC datas : OLD Description : "La manipulación del espacio dimensional no se puede comprender en su totalidad. ¡Más vale tener a mano un paracaídas y suministros médicos!", Description AC enUS : "Dimensional folding is not fully understood in any capacity.  A parachute and medical supplies are best kept on hand!" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Crea un agujero de gusano inestable que el ingeniero puede usar para viajar por Rasganorte. Dura 1 min. (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 48933;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Dispara fuegos artificiales que estallan en un millar de estrellas moradas. (30 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49703;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = '¡Conviértete en un enorme ogro rojo durante 10 min! (10 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 49704;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Este extraño dispositivo fue diseñado para que reventara la cavidad torácica del objetivo e hiciera salir un chorro de sangre caliente. En su lugar, provoca un breve pero penoso arrebato de sollozos miserables y desgraciados. (1 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 50471;
-- AC datas : OLD Description : "Siempre te consideraré un hermano.", Description AC enUS : "I will always count you as a brother" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Adoptas la forma de un enano de escarcha durante 10 min. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52201;
-- AC datas : OLD Description : "Un lamento por los días que la Reina alma en pena ha perdido para siempre.", Description AC enUS : "A lament for the days forever lost to the Banshee Queen" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Invoca lamentadoras de Sylvanas. (1 Hora Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 52253;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho del ratón para convertirte en tu propia estatua heroica. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54212;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Invoca y controla tu coche de carreras triturador. (5 Seg Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54343;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para colocar una muñeca de trapo verde diminuta. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54437;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Haz clic con el botón derecho para colocar una muñeca de trapo azul diminuta. (30 Min Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54438;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te transforma en infantería de Gnomeregan. (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54651;
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Te transforma en un guerrero Lanza Negra. (4 H Reutilización)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 54653;

-- Update existing entries, from TBC
-- AC datas : OLD Name : "Monster - Axe, 2H Gorehowl (GROM HELLSCREAM ONLY)", Name AC enUS : "Monster - Axe, 2H Gorehowl (GROM HELLSCREAM ONLY)" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Monster - Axe, 2H Gorehowl', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 30414;
DELETE FROM `item_template_locale` WHERE `locale` = 'esMX' AND `ID` = 30414;

-- Update existing entries, from CLASSIC
-- AC datas : OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Description` = 'Testing the LOC trigger', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5550;

-- Update existing entries, from CATA
-- AC datas : OLD Name : "Monedero grande (OLD)", Name AC enUS : "Large Moneybag (old)" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Monedero grande (old)', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1014;
-- AC datas : OLD Name : "Zafiro celestial sólido", Name AC enUS : "Solid Sky Sapphire (Unused)" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'Solid Sky Sapphire', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 37430;

-- Update existing entries, from MOP
-- AC datas : OLD Name : "Objeto de prueba JYoo", Name AC enUS : "JYoo test item" ; Wowhead enUS : ""
-- UPDATE `item_template_locale` SET `Name` = 'JLeCraft Test Item', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 1259;
-- AC datas : OLD Name : "Monstruo: daga, básica con pinchos ornamentada", Name AC enUS : "Monster - Dagger, Ornate Spikey Base" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = '"Monster - Dagger, Ornate Spikey Base"', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 5283;
-- AC datas : OLD Name : "Monstruo: daga, garfio colmillo curva oscura", Name AC enUS : "Monster - Dagger, Fang Hook Curve Dark" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = '"Monster - Dagger, Fang Hook Curve Dark"', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 19924;
-- AC datas : OLD Name : "Monster - Fist, Zul'Aman (Main)", Name AC enUS : "Monster - Fist, Zul'Aman (Main)" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = '"Monster - Fist, Zul''Aman (Main)"', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 53889;
-- AC datas : OLD Name : "Monster - Fist, Zul'Aman (Offhand)", Name AC enUS : "Monster - Fist, Zul'Aman (Offhand)" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = '"Monster - Fist, Zul''Aman (Offhand)"', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 53890;

-- Update existing entries, from RETAIL
-- AC datas : OLD Name : "Elixir de lenguas (NYI)", Name AC enUS : "Elixir of Tongues (NYI)" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = 'Elixir de lenguas', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 2460;
-- AC datas : OLD Name : "zzoldSwift Warstrider", Name AC enUS : "zzoldSwift Warstrider" ; Wowhead enUS : "",  OLD Description : "", Description AC enUS : "" ; Wowhead enUS : ""
UPDATE `item_template_locale` SET `Name` = NULL, `Description` = 'Si ves lo que pasa cuando atacan a sus amos, verás a esas aves comportarse de forma completamente distinta. -Asaltante Bork', `VerifiedBuild` = 0 WHERE `locale` = 'esMX' AND `ID` = 29225;

-- Insert new entries, from WOTLK
DELETE FROM `item_template_locale` WHERE `ID` IN(875,886,945,948,966,967,968,973,974,975,976,980,985,986,989,992,994,997,1004,1029) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(875,'esMX','Invocación de caballo marrón',NULL,0),
(886,'esMX','Espada corta de metal negro',NULL,0),
(945,'esMX','Espada de las Sombras',NULL,0),
(948,'esMX','Espada Naturaleza',NULL,0),
(966,'esMX','Escrito sobre Escudo contra Escarcha',NULL,0),
(967,'esMX','Escrito sobre Resguardo contra la Escarcha',NULL,0),
(968,'esMX','Escrito sobre Explosión de Fuego',NULL,0),
(973,'esMX','Escrito sobre Bola de Fuego II',NULL,0),
(974,'esMX','Escrito sobre Armadura de Escarcha II',NULL,0),
(975,'esMX','Escrito sobre Cadenas de hielo',NULL,0),
(976,'esMX','Escrito sobre Eliminar maldición',NULL,0),
(980,'esMX','Escrito sobre Escudo contra Escarcha II',NULL,0),
(985,'esMX','Escrito sobre Liberación de Khadgar',NULL,0),
(986,'esMX','Escrito sobre Descarga de Escarcha II',NULL,0),
(989,'esMX','Escrito sobre Nova de Escarcha',NULL,0),
(992,'esMX','Escrito sobre Bola de Fuego III',NULL,0),
(994,'esMX','Escrito sobre Armadura de hielo',NULL,0),
(997,'esMX','Espada entorpecedora de Fuego',NULL,0),
(1004,'esMX','Escrito sobre Cadenas de hielo II',NULL,0),
(1029,'esMX','Tablilla de Tótem serpiente',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1030,1031,1032,1033,1034,1035,1036,1037,1038,1048,1049,1052,1053,1057,1058,1061,1063,1072,1078,1084) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1030,'esMX','Tablilla de voluntad férrea',NULL,0),
(1031,'esMX','Tablilla de Explosión de arrabio',NULL,0),
(1032,'esMX','Tablilla de Tótem agitador',NULL,0),
(1033,'esMX','Tablilla de Veneno de anulación',NULL,0),
(1034,'esMX','Tablilla de fuerza eterna',NULL,0),
(1035,'esMX','Tablilla de Llamar a espíritu',NULL,0),
(1036,'esMX','Tablilla de Enfermedad de anulación',NULL,0),
(1037,'esMX','Tablilla de Descarga de relámpagos II',NULL,0),
(1038,'esMX','Tablilla de Restauración II',NULL,0),
(1048,'esMX','Tablilla de Escudo de relámpagos II',NULL,0),
(1049,'esMX','Tablilla de Purgar',NULL,0),
(1052,'esMX','Tablilla de armadura de espíritu II',NULL,0),
(1053,'esMX','Tablilla de Explosión de arrabio II',NULL,0),
(1057,'esMX','Tablilla de Restauración III',NULL,0),
(1058,'esMX','Tablilla de Descarga de relámpagos III',NULL,0),
(1061,'esMX','Tablilla de Veneno de anulación II',NULL,0),
(1063,'esMX','Tablilla de Enfermedad de anulación II',NULL,0),
(1072,'esMX','Luna llena',NULL,0),
(1078,'esMX',NULL,'Firmado por el honorable Magistrado Solomon.',0),
(1084,'esMX','Códice de Renovar',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1085,1086,1087,1088,1089,1090,1091,1092,1093,1095,1096,1100,1101,1102,1105,1108,1109,1111,1112,1119) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1085,'esMX','Códice de Visión mental',NULL,0),
(1086,'esMX','Códice de Fuego interno',NULL,0),
(1087,'esMX','Códice de Palabra de las Sombras: dolor',NULL,0),
(1088,'esMX','Códice de Renovar II',NULL,0),
(1089,'esMX','Códice de Enfermedad de anulación',NULL,0),
(1090,'esMX','Códice de Resurrección',NULL,0),
(1091,'esMX','Códice de Punición Sagrada II',NULL,0),
(1092,'esMX','Códice de Curación inferior II',NULL,0),
(1093,'esMX','Códice de Eliminar maldición',NULL,0),
(1095,'esMX','Códice de Disipar magia',NULL,0),
(1096,'esMX','Códice de Palabra de las Sombras: dolor II',NULL,0),
(1100,'esMX','Peazo bolsa',NULL,0),
(1101,'esMX','Códice de Renovar V',NULL,0),
(1102,'esMX','Códice de Curación inferior III',NULL,0),
(1105,'esMX','Códice de Renovar VI',NULL,0),
(1108,'esMX','Códice de Renovar III',NULL,0),
(1109,'esMX','Códice de Dominación',NULL,0),
(1111,'esMX','Códice de Dormir',NULL,0),
(1112,'esMX','Códice de Palabra Sagrada: entereza II',NULL,0),
(1119,'esMX','Licor embotellado',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1122,1123,1124,1125,1133,1134,1136,1138,1139,1141,1144,1146,1149,1150,1151,1164,1176,1199,1216,1224) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1122,'esMX',NULL,'Invoca a un semental blanco para usarlo como tu corcel.',0),
(1123,'esMX',NULL,'Invoca a un pinto para usarlo como tu corcel.',0),
(1124,'esMX',NULL,'Invoca a un palomino para usarlo como tu corcel.',0),
(1125,'esMX',NULL,'Invoca a una pesadilla para usarla como tu corcel.',0),
(1133,'esMX','Cuerno del lobo invernal',NULL,0),
(1134,'esMX','Cuerno del lobo grisáceo',NULL,0),
(1136,'esMX','Tratado: Favor divino II',NULL,0),
(1138,'esMX','Tratado: Favor divino',NULL,0),
(1139,'esMX','Tratado: Limpieza',NULL,0),
(1141,'esMX','Tratado: Luz Sagrada II',NULL,0),
(1144,'esMX','Tratado: Escudo divino',NULL,0),
(1146,'esMX','Tratado: Resurrección',NULL,0),
(1149,'esMX','Tratado: Sello de poderío II',NULL,0),
(1150,'esMX','Tratado: Purificar',NULL,0),
(1151,'esMX','Tratado: Luz Sagrada III',NULL,0),
(1164,'esMX','Escrito de Sam',NULL,0),
(1176,'esMX','Sales aromáticas',NULL,0),
(1199,'esMX','Piedra de alma cargada',NULL,0),
(1216,'esMX','Brazales escarchados',NULL,0),
(1224,'esMX','Grimorio Captar demonios',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1228,1229,1231,1232,1238,1239,1243,1244,1245,1246,1250,1254,1255,1323,1328,1332,1334,1339,1341,1350) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1228,'esMX','Grimorio Hervor de sangre',NULL,0),
(1229,'esMX','Grimorio Crear piedra de alma',NULL,0),
(1231,'esMX','Grimorio Descarga de las Sombras II',NULL,0),
(1232,'esMX','Grimorio Piel de demonio II',NULL,0),
(1238,'esMX','Grimorio Miedo',NULL,0),
(1239,'esMX','Grimorio de Succión de maná',NULL,0),
(1243,'esMX','Grimorio Descarga de las Sombras III',NULL,0),
(1244,'esMX','Grimorio Armadura demoníaca',NULL,0),
(1245,'esMX','Grimorio Inmolar II',NULL,0),
(1246,'esMX','Grimorio Aliento demoníaco',NULL,0),
(1250,'esMX','Grimorio Detectar invisibilidad inferior',NULL,0),
(1254,'esMX','Piedra de fuego inferior (DEPRECATED)',NULL,0),
(1255,'esMX','Deprecated Conjured Mana Gem',NULL,0),
(1323,'esMX',NULL,'Será una receta de cocina de habilidad comercial',0),
(1328,'esMX','Libro sobre Fuego Feérico',NULL,0),
(1332,'esMX','Libro sobre Veneno de Cura',NULL,0),
(1334,'esMX','Libro sobre Rejuvenecimiento II',NULL,0),
(1339,'esMX','Libro sobre Raíces enredadoras',NULL,0),
(1341,'esMX','Libro sobre Fuego lunar',NULL,0),
(1350,'esMX',NULL,'Hay muchos maleficios cosidos a esta muñeca de trapo.',0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1400,1402,1492,1500,1534,1536,1554,1559,1567,1568,1571,1574,1588,1589,1591,1597,1599,1603,1619,1623) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1400,'esMX','Muestra Plumapresto',NULL,0),
(1402,'esMX','Azufre',NULL,0),
(1492,'esMX',NULL,'Será una receta de cocina de habilidad comercial',0),
(1500,'esMX','Tótem maestro','Este tótem representa al Aire, Tierra, Fuego y Agua.',0),
(1534,'esMX','Tratado: Luz Sagrada IV',NULL,0),
(1536,'esMX','Tratado: Sello de cólera',NULL,0),
(1554,'esMX','Escrito sobre Descarga de Escarcha III',NULL,0),
(1559,'esMX','Escrito sobre Misiles Arcanos II',NULL,0),
(1567,'esMX','Escrito sobre Liberación de Khadgar II',NULL,0),
(1568,'esMX','Escrito sobre elemental de Agua',NULL,0),
(1571,'esMX','Escrito sobre Nova de Escarcha II',NULL,0),
(1574,'esMX','Escrito sobre Resguardo contra el Fuego',NULL,0),
(1588,'esMX','Tablilla de Explosión de arrabio III',NULL,0),
(1589,'esMX','Tablilla de armadura de espíritu III',NULL,0),
(1591,'esMX','Tablilla de Escudo de relámpagos III',NULL,0),
(1597,'esMX','Tablilla de Tormenta de relámpagos',NULL,0),
(1599,'esMX',NULL,'Será una receta de cocina de habilidad comercial',0),
(1603,'esMX','Tablilla de Llamar a espíritu II',NULL,0),
(1619,'esMX','Tablilla de Tormenta de relámpagos II',NULL,0),
(1623,'esMX','Faltriquera de piel de raptor',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(1641,1648,1651,1657,1658,1676,1681,1700,1851,1877,1882,1886,1977,2003,2021,2056,2410,2415,2556,2669) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1641,'esMX','Códice de Palabra de las Sombras: dolor III',NULL,0),
(1648,'esMX','Códice de Sanar IV',NULL,0),
(1651,'esMX','Códice de Palabra Sagrada: escudo VI',NULL,0),
(1657,'esMX','Códice de Resurrección II',NULL,0),
(1658,'esMX','Códice de Palabra de las Sombras: dolor IV',NULL,0),
(1676,'esMX','Códice de Dormir II',NULL,0),
(1681,'esMX','Grimorio Entorpecer',NULL,0),
(1700,'esMX','Deprecated Blood Totem',NULL,0),
(1851,'esMX','Agua de limpieza',NULL,0),
(1877,'esMX','Libro sobre Rejuvenecimiento III',NULL,0),
(1882,'esMX','Libro sobre Fuego lunar III',NULL,0),
(1886,'esMX','Libro sobre Fuego lunar II',NULL,0),
(1977,'esMX','Bolsa con 20 casillas',NULL,0),
(2003,'esMX',NULL,'Un gran carcaj.',0),
(2021,'esMX','Escudo de caparazón verde',NULL,0),
(2056,'esMX','El martillo de terciopelo',NULL,0),
(2410,'esMX','Antorcha humeante',NULL,0),
(2415,'esMX','Semental blanco',NULL,0),
(2556,'esMX','Receta: elixir de lenguas','Esta poción no tiene efecto hasta que no indicas los idiomas.',0),
(2669,'esMX','Garra de trillanodonte',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(2688,2693,2695,2789,2790,2791,2792,2887,2890,2895,2896,2919,2920,2921,2922,2923,2929,2932,3002,3003) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(2688,'esMX','Nuez de ardilla',NULL,0),
(2693,'esMX','OLD Stormwind Seasoning Salts',NULL,0),
(2695,'esMX','Monster - Mace, Board with Nail Club',NULL,0),
(2789,'esMX',NULL,'Abre cerraduras de dificultad 25.',0),
(2790,'esMX',NULL,'Abre cerraduras de dificultad 50.',0),
(2791,'esMX',NULL,'Abre cerraduras de dificultad 75.',0),
(2792,'esMX',NULL,'Abre cerraduras de dificultad 100.',0),
(2887,'esMX','Pelambre de lobo estropeada',NULL,0),
(2890,'esMX','Pelambre de jabalí estropeada',NULL,0),
(2895,'esMX','Dolor espeluznante',NULL,0),
(2896,'esMX','Angustia espeluznante',NULL,0),
(2919,'esMX','Reliquia de los Antiguos',NULL,0),
(2920,'esMX','Reliquia sacra',NULL,0),
(2921,'esMX','Reliquia bendita',NULL,0),
(2922,'esMX','Reliquia de espíritu',NULL,0),
(2923,'esMX','Reliquia de Rectitud',NULL,0),
(2929,'esMX','Podredumbre de tumba','Usado por los pícaros para crear veneno.',0),
(2932,'esMX','Viña tormenta','Usado por los pícaros para crear veneno.',0),
(3002,'esMX','Cuerno de Justicia de reliquia',NULL,0),
(3003,'esMX','Reliquia del Ojo',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(3004,3005,3006,3028,3034,3088,3089,3090,3091,3092,3093,3094,3095,3096,3097,3098,3099,3100,3101,3102) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(3004,'esMX','Reliquia de los Muertos',NULL,0),
(3005,'esMX','Reliquia de Verdad',NULL,0),
(3006,'esMX','Fragmento de reliquia Sagrada',NULL,0),
(3028,'esMX','Arco largo',NULL,0),
(3034,'esMX','Deprecated BKP "Impact" Shot',NULL,0),
(3088,'esMX','Libro sobre Rejuvenecimiento IV',NULL,0),
(3089,'esMX','Escrito sobre Fogonazo',NULL,0),
(3090,'esMX','Escrito sobre Descarga de Escarcha',NULL,0),
(3091,'esMX','Escrito sobre Intelecto Arcano II',NULL,0),
(3092,'esMX','Escrito sobre Fogonazo III',NULL,0),
(3093,'esMX','Escrito sobre Fogonazo II',NULL,0),
(3094,'esMX','Escrito sobre Explosión de Fuego II',NULL,0),
(3095,'esMX','Escrito sobre Explosión de Fuego III',NULL,0),
(3096,'esMX','Escrito sobre Caída de pluma',NULL,0),
(3097,'esMX','Escrito sobre Crear agua II',NULL,0),
(3098,'esMX','Escrito sobre Lentitud',NULL,0),
(3099,'esMX','Escrito sobre Armadura de hielo II',NULL,0),
(3100,'esMX','Escrito sobre Ventisca II',NULL,0),
(3101,'esMX','Escrito sobre Nova de Escarcha III',NULL,0),
(3102,'esMX','Escrito sobre Intelecto Arcano III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(3113,3114,3115,3116,3118,3119,3120,3121,3123,3124,3125,3126,3127,3129,3130,3132,3133,3134,3138,3139) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(3113,'esMX','Códice de Palabra Sagrada: escudo',NULL,0),
(3114,'esMX','Códice de Palabra de las Sombras: ofuscar',NULL,0),
(3115,'esMX','Códice de Renovar IV',NULL,0),
(3116,'esMX','Códice de Palabra Sagrada: escudo II',NULL,0),
(3118,'esMX','Códice de Sanación superior',NULL,0),
(3119,'esMX','Códice de Palabra Sagrada: escudo V',NULL,0),
(3120,'esMX','Códice de Punición Sagrada IV',NULL,0),
(3121,'esMX','Códice de Levitar',NULL,0),
(3123,'esMX','Códice de Palabra Sagrada: entereza III',NULL,0),
(3124,'esMX','Códice de Fuego interno III',NULL,0),
(3125,'esMX','Tablilla de Tótem serpiente II',NULL,0),
(3126,'esMX','Tablilla de choque II',NULL,0),
(3127,'esMX','Tablilla de choque III',NULL,0),
(3129,'esMX','Tablilla de Descarga de relámpagos IV',NULL,0),
(3130,'esMX','Tablilla de Restauración IV',NULL,0),
(3132,'esMX','Tablilla de Explosión de arrabio IV',NULL,0),
(3133,'esMX','Tablilla de Tótem de maná',NULL,0),
(3134,'esMX','Grimorio Maldición de Mannoroth',NULL,0),
(3138,'esMX','Grimorio Descarga de las Sombras IV',NULL,0),
(3139,'esMX','Grimorio Armadura demoníaca II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(3140,3141,3142,3143,3144,3146,3148,3227,3249,3259,3278,3438,3467,3499,3522,3526,3527,3528,3529,3533) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(3140,'esMX','Grimorio Hervor de sangre II',NULL,0),
(3141,'esMX','Grimorio Drenaje de vida',NULL,0),
(3142,'esMX','Grimorio Maldición de Sargeras',NULL,0),
(3143,'esMX','Grimorio Espíritu ardiente',NULL,0),
(3144,'esMX','Grimorio Espíritu ardiente II',NULL,0),
(3146,'esMX','Grimorio Espíritu ardiente III',NULL,0),
(3148,'esMX','Deprecated Work Shirt',NULL,0),
(3227,'esMX','Bastón de Nocturno',NULL,0),
(3249,'esMX',NULL,'Un objeto para probar los objetos mágicos.',0),
(3259,'esMX','Pellejo de murciélago estropeado',NULL,0),
(3278,'esMX','Espada de daño de proc aura',NULL,0),
(3438,'esMX','Ankh de Resurrección',NULL,0),
(3467,'esMX','Llave de hierro mate',NULL,0),
(3499,'esMX','Llave de oro bruñida',NULL,0),
(3522,'esMX','Coraza negro de elfo de la noche',NULL,0),
(3526,'esMX','Guantes negros de elfo de la noche',NULL,0),
(3527,'esMX','Coraza de elfo de la noche blanca',NULL,0),
(3528,'esMX','Coraza de cuero rojo C03',NULL,0),
(3529,'esMX','Yelmo negro de elfos de la noche',NULL,0),
(3533,'esMX','Botas de cuero rojo C03',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(3535,3537,3538,3541,3542,3545,3546,3547,3557,3620,3675,3704,3762,3788,3789,3790,3791,3861,3929,3930) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(3535,'esMX','Brazales de cuero rojo C03',NULL,0),
(3537,'esMX','D02 Coraza de cuero negro',NULL,0),
(3538,'esMX','Coraza de cuero gris D02',NULL,0),
(3541,'esMX','D02 Botas de cuero negras',NULL,0),
(3542,'esMX','Botas de cuero gris D02',NULL,0),
(3545,'esMX','D02 Brazales de cuero negros',NULL,0),
(3546,'esMX','Brazales de cuero gris D02',NULL,0),
(3547,'esMX','Coraza de cuero blanco D03',NULL,0),
(3557,'esMX','Tabardo de tripas sin usar',NULL,0),
(3620,'esMX','Restos de Lillith',NULL,0),
(3675,'esMX','Antorcha totalmente quemada',NULL,0),
(3704,'esMX','Llave de hierro oxidada',NULL,0),
(3762,'esMX','Cartera de bibliotecario',NULL,0),
(3788,'esMX','Reliquia de cristal de alma',NULL,0),
(3789,'esMX','Piedra reliquia de Piedad',NULL,0),
(3790,'esMX','Papiro de reliquia consagrada',NULL,0),
(3791,'esMX','Reliquia de la Luz',NULL,0),
(3861,'esMX','Barra de acero negro',NULL,0),
(3929,'esMX','Botín de Maury',NULL,0),
(3930,'esMX','Llave de Maury',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4030,4031,4032,4033,4141,4143,4145,4146,4147,4148,4149,4150,4151,4152,4153,4154,4155,4157,4158,4159) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4030,'esMX','Agua de reliquia Sagrada',NULL,0),
(4031,'esMX','Talismán de reliquia sacralizado',NULL,0),
(4032,'esMX','Martillo de reliquia radiante',NULL,0),
(4033,'esMX','Resplandor del Alba',NULL,0),
(4141,'esMX','Escrito sobre Crear comida',NULL,0),
(4143,'esMX','Escrito sobre Crear comida II',NULL,0),
(4145,'esMX','Escrito sobre Crear gema de maná',NULL,0),
(4146,'esMX','Escrito sobre Polimorfia: oveja',NULL,0),
(4147,'esMX','Escrito sobre Crear comida III',NULL,0),
(4148,'esMX','Escrito sobre Contrahechizo',NULL,0),
(4149,'esMX','Escrito sobre Escudo contra Escarcha III',NULL,0),
(4150,'esMX','Escrito sobre Crear agua IV',NULL,0),
(4151,'esMX','Escrito sobre Descarga de Escarcha IV',NULL,0),
(4152,'esMX','Escrito sobre Crear comida IV',NULL,0),
(4153,'esMX','Escrito sobre Misiles Arcanos III',NULL,0),
(4154,'esMX','Escrito sobre Lentitud II',NULL,0),
(4155,'esMX','Escrito sobre elemental de Agua II',NULL,0),
(4157,'esMX','Escrito sobre Atenuar magia',NULL,0),
(4158,'esMX','Escrito sobre Liberación de Khadgar III',NULL,0),
(4159,'esMX','Escrito sobre Misiles Arcanos',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4161,4162,4164,4165,4166,4167,4168,4169,4170,4171,4172,4173,4174,4175,4176,4177,4178,4179,4180,4181) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4161,'esMX','Escrito sobre Bola de Fuego IV',NULL,0),
(4162,'esMX','Escrito sobre Traslación II',NULL,0),
(4164,'esMX','Tratado: Luz Sagrada V',NULL,0),
(4165,'esMX','Tratado: Luz Sagrada VI',NULL,0),
(4166,'esMX','Tratado: Sello de protección',NULL,0),
(4167,'esMX','Tratado: Sentencia',NULL,0),
(4168,'esMX','Tablilla de Tótem enredador',NULL,0),
(4169,'esMX','Tablilla de voluntad férrea II',NULL,0),
(4170,'esMX','Tablilla de Regreso astral',NULL,0),
(4171,'esMX','Tablilla de Tótem agitador III',NULL,0),
(4172,'esMX','Tablilla de Atronar II',NULL,0),
(4173,'esMX','Tablilla de choque IV',NULL,0),
(4174,'esMX','Tablilla de choque V',NULL,0),
(4175,'esMX','Tablilla de Escudo de relámpagos IV',NULL,0),
(4176,'esMX','Tablilla de fuerza eterna II',NULL,0),
(4177,'esMX','Tablilla de resistencia a la Naturaleza',NULL,0),
(4178,'esMX','Tablilla de Descarga de relámpagos V',NULL,0),
(4179,'esMX','Tablilla de Restauración V',NULL,0),
(4180,'esMX','Tablilla de forma etérea II',NULL,0),
(4181,'esMX','Tablilla de Tótem agitador IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4182,4183,4184,4185,4186,4187,4188,4189,4190,4192,4194,4195,4198,4199,4201,4202,4203,4204,4205,4206) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4182,'esMX','Tablilla de voluntad férrea III',NULL,0),
(4183,'esMX','Tablilla de Tótem sanador V',NULL,0),
(4184,'esMX','Tablilla de Explosión de arrabio V',NULL,0),
(4185,'esMX','Tablilla de Regreso astral en grupo',NULL,0),
(4186,'esMX','Tablilla de Resistencia al Fuego',NULL,0),
(4187,'esMX','Tablilla de Tótem serpiente V',NULL,0),
(4188,'esMX','Tablilla de Tótem de Invisibilidad',NULL,0),
(4189,'esMX','Tablilla de Cadena de relámpagos',NULL,0),
(4190,'esMX','Armadura de plumas',NULL,0),
(4192,'esMX','Guanteletes con plumas sin usar',NULL,0),
(4194,'esMX','Brazales de plumas',NULL,0),
(4195,'esMX','Botas de plumas',NULL,0),
(4198,'esMX','Grimorio Cauce de almas',NULL,0),
(4199,'esMX','Grimorio Cauce de almas II',NULL,0),
(4201,'esMX','Grimorio Ojo de Kilrogg',NULL,0),
(4202,'esMX','Grimorio Miedo II',NULL,0),
(4203,'esMX','Grimorio Pestilencia II',NULL,0),
(4204,'esMX','Grimorio Cauce de almas III',NULL,0),
(4205,'esMX','Grimorio Inmolar IV',NULL,0),
(4206,'esMX','Grimorio Maldición de Sargeras II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4207,4208,4209,4210,4211,4212,4214,4215,4216,4217,4218,4219,4220,4221,4223,4225,4226,4228,4230,4266) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4207,'esMX','Grimorio Maldición de Archimonde',NULL,0),
(4208,'esMX','Grimorio Bomba mental',NULL,0),
(4209,'esMX','Grimorio Resguardo contra las Sombras',NULL,0),
(4210,'esMX','Grimorio Crear sangrita inferior',NULL,0),
(4211,'esMX','Grimorio Pestilencia',NULL,0),
(4212,'esMX','Grimorio Maldición de Mannoroth III',NULL,0),
(4214,'esMX','Grimorio Drenaje de vida III',NULL,0),
(4215,'esMX','Grimorio Lluvia de Fuego',NULL,0),
(4216,'esMX','Grimorio Resguardo contra lo Sagrado',NULL,0),
(4217,'esMX','Grimorio Cauce de almas IV',NULL,0),
(4218,'esMX','Grimorio Crear sangrita',NULL,0),
(4219,'esMX','Grimorio Espíritu ardiente IV',NULL,0),
(4220,'esMX','Grimorio Hervor de sangre III',NULL,0),
(4221,'esMX','Grimorio Detectar invisibilidad',NULL,0),
(4223,'esMX','Libro sobre Suprimir Magia',NULL,0),
(4225,'esMX','Libro sobre Raíces enredadoras III',NULL,0),
(4226,'esMX','Libro sobre Cólera VI',NULL,0),
(4228,'esMX','Libro sobre Fuego lunar IV',NULL,0),
(4230,'esMX','Libro sobre Toque de sanación VI',NULL,0),
(4266,'esMX','Códice de Fuego interno II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4267,4268,4269,4270,4271,4272,4273,4274,4275,4276,4277,4279,4280,4281,4282,4283,4284,4285,4286,4287) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4267,'esMX','Códice de Palabra de las Sombras: fracaso',NULL,0),
(4268,'esMX','Códice de Sanar II',NULL,0),
(4269,'esMX','Códice de Rezo de sanación',NULL,0),
(4270,'esMX','Códice de Sanar III',NULL,0),
(4271,'esMX','Códice de Punición Sagrada V',NULL,0),
(4272,'esMX','Códice de Protección contra lo Sagrado',NULL,0),
(4273,'esMX','Códice de Sanar',NULL,0),
(4274,'esMX','Códice de Escape divino',NULL,0),
(4275,'esMX','Códice de Putrefacción mental',NULL,0),
(4276,'esMX','Códice de Palabra de las Sombras: fracaso II',NULL,0),
(4277,'esMX','Códice de Palabra de las Sombras: ofuscar II',NULL,0),
(4279,'esMX','Códice de Palabra de las Sombras: dolor V',NULL,0),
(4280,'esMX','Códice de Palabra Sagrada: escudo IV',NULL,0),
(4281,'esMX','Códice de Protección contra las Sombras',NULL,0),
(4282,'esMX','Códice de Disipar magia II',NULL,0),
(4283,'esMX','Códice de Dormir III',NULL,0),
(4284,'esMX','Códice de Punición Sagrada VI',NULL,0),
(4285,'esMX','Códice de Palabra Sagrada: entereza IV',NULL,0),
(4286,'esMX','Códice de Rezo de sanación II',NULL,0),
(4287,'esMX','Códice de Enfermedad de anulación II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(4288,4295,4620,4728,4747,4748,4756,4882,4930,4959,4966,4981,4988,5004,5005,5008,5013,5045,5049,5105) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4288,'esMX','Códice de Eliminar maldición II',NULL,0),
(4295,'esMX','Patrón: guantes de cuero de doble puntada OLD',NULL,0),
(4620,'esMX',NULL,'La vieja nota tiene algo escrito en tiza...',0),
(4728,'esMX','Sobrehombro de Oposti',NULL,0),
(4747,'esMX','Agua de poza de Ventoro',NULL,0),
(4748,'esMX','Agua de poza de Cuerno Rojo',NULL,0),
(4756,'esMX','Pelambre de gato estropeada',NULL,0),
(4882,'esMX','Llave de Benedict',NULL,0),
(4930,'esMX','Bolsa de cuero hecha a mano',NULL,0),
(4959,'esMX','Tomahawk arrojadizo roto',NULL,0),
(4966,'esMX','Cabeza de Mazzranache',NULL,0),
(4981,'esMX','Faltriquera de cinturón de Agmond',NULL,0),
(4988,'esMX','Sortija de obsidiana ardiente',NULL,0),
(5004,'esMX','Marca del Kirin Tor',NULL,0),
(5005,'esMX','Colgante de chispa de ascuas',NULL,0),
(5008,'esMX','Anillo de mercurio',NULL,0),
(5013,'esMX','Bulbo fértil',NULL,0),
(5045,'esMX','Calavera obsequio',NULL,0),
(5049,'esMX','Lámina de hierro con autocierre','Para abrir este obsequio necesitarás nivel 150 de la habilidad para forzar cerraduras.',0),
(5105,'esMX','Cartucho explosivo',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5106,5126,5127,5129,5130,5131,5132,5139,5141,5142,5145,5147,5148,5149,5150,5151,5152,5153,5154,5155) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5106,'esMX','Deprecated Red Mask',NULL,0),
(5126,'esMX','Conocimiento: Disfraz de Defias',NULL,0),
(5127,'esMX','Conocimiento: Disfraz de pirata de los Mares del Sur',NULL,0),
(5129,'esMX','Conocimiento: Disfraz de enano Hierro Negro',NULL,0),
(5130,'esMX','Conocimiento: Disfraz de zahorí de Dalaran',NULL,0),
(5131,'esMX','Conocimiento: Disfraz de Rompecantos',NULL,0),
(5132,'esMX','Conocimiento: Disfraz de Hermandad',NULL,0),
(5139,'esMX','Libro sobre Espinas',NULL,0),
(5141,'esMX','Libro sobre Recrecimiento',NULL,0),
(5142,'esMX','Libro sobre Cólera II',NULL,0),
(5145,'esMX','Libro sobre Toque de sanación II',NULL,0),
(5147,'esMX','Libro sobre Raíces enredadoras II',NULL,0),
(5148,'esMX','Libro sobre Espinas II',NULL,0),
(5149,'esMX','Libro sobre Cólera III',NULL,0),
(5150,'esMX','Libro sobre Toque de sanación III',NULL,0),
(5151,'esMX','Libro sobre Cólera IV',NULL,0),
(5152,'esMX','Libro sobre Toque de sanación IV',NULL,0),
(5153,'esMX','Libro sobre Marca de lo Salvaje IV',NULL,0),
(5154,'esMX','Libro sobre Espinas III',NULL,0),
(5155,'esMX','Libro sobre Marca de lo Salvaje II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5156,5158,5160,5163,5172,5174,5223,5227,5229,5264,5265,5330,5333,5372,5380,5381,5401,5402,5403,5406) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5156,'esMX','Libro sobre Cólera V',NULL,0),
(5158,'esMX','Libro sobre Tranquilidad',NULL,0),
(5160,'esMX','Libro sobre Toque de sanación V',NULL,0),
(5163,'esMX','Libro sobre Marca de lo Salvaje III',NULL,0),
(5172,'esMX','Cápsula de la Muerte',NULL,0),
(5174,'esMX','Nota de Neeru',NULL,0),
(5223,'esMX','Gema de maná vacía',NULL,0),
(5227,'esMX','Joya de maná vacía',NULL,0),
(5229,'esMX','Sangrita superior vacía',NULL,0),
(5264,'esMX','Muestra de cerveza de obsequio',NULL,0),
(5265,'esMX','Cerveza aguada',NULL,0),
(5330,'esMX','Reliquia de copa élfica',NULL,0),
(5333,'esMX','Deprecated Mathystra Relic',NULL,0),
(5372,'esMX',NULL,'Los ojos brillan intensamente en la calavera.',0),
(5380,'esMX','Carta lacrada para Elissa','Una carta sellada para Elissa Brisa Estelar en Auberdine.',0),
(5381,'esMX','Carta lacrada para Balthule','Una carta sellada para Balthule Golpesombra.',0),
(5401,'esMX','Sangre de Pythas',NULL,0),
(5402,'esMX','Sangre de Anacondra',NULL,0),
(5403,'esMX','Sangre de Serpentis',NULL,0),
(5406,'esMX','Sangrita menor vacía',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5495,5517,5518,5522,5559,5562,5563,5577,5603,5641,5644,5647,5648,5649,5650,5657,5658,5660,5661,5662) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5495,'esMX','Monster - Mace2H, Large Metal (1H, Special)',NULL,0),
(5517,'esMX','Llave pequeña de bronce','Un componente para hechizos mágicos.',0),
(5518,'esMX','Pequeña llave de hierro','Un componente para hechizos mágicos.',0),
(5522,'esMX','Piedra de hechizo (DEPRECATED)',NULL,0),
(5559,'esMX','Prueba rápida arrojadiza rota',NULL,0),
(5562,'esMX','Voidstone (Deprecated)',NULL,0),
(5563,'esMX','Succubi Stone (Deprecated)',NULL,0),
(5577,'esMX','Diseño: brazales de bronce férreos',NULL,0),
(5603,'esMX','Zurrón de Zumbang',NULL,0),
(5641,'esMX','Receta: poción de huida cobarde',NULL,0),
(5644,'esMX','Escrito sobre Crear agua',NULL,0),
(5647,'esMX','Escrito sobre Traslación',NULL,0),
(5648,'esMX','Escrito sobre Armadura de Escarcha III',NULL,0),
(5649,'esMX','Escrito sobre Ventisca',NULL,0),
(5650,'esMX','Escrito sobre Crear agua III',NULL,0),
(5657,'esMX','Receta: toxina instantánea',NULL,0),
(5658,'esMX','Tratado: Sello de poderío',NULL,0),
(5660,'esMX','Tratado: Sello de rectitud',NULL,0),
(5661,'esMX','Tratado: Sello de rectitud II',NULL,0),
(5662,'esMX','Tratado: Sello de rectitud III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5663,5666,5667,5670,5671,5672,5673,5674,5676,5677,5679,5680,5682,5683,5684,5685,5696,5697,5698,5699) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5663,'esMX','Cuerno del lobo rojo',NULL,0),
(5666,'esMX','Tratado: Sello de cólera II',NULL,0),
(5667,'esMX','Tratado: Sello de sabiduría II',NULL,0),
(5670,'esMX','Tratado: Sello de cólera IV',NULL,0),
(5671,'esMX','Tratado: Sello de poderío III',NULL,0),
(5672,'esMX','Tratado: Exorcismo',NULL,0),
(5673,'esMX','Tratado: Exorcismo II',NULL,0),
(5674,'esMX','Tratado: Exorcismo III',NULL,0),
(5676,'esMX','Tratado: Captar no-muertos',NULL,0),
(5677,'esMX','Tratado: Ahuyentar a no-muertos',NULL,0),
(5679,'esMX','Tratado: Sello de sabiduría III',NULL,0),
(5680,'esMX','Tratado: Sello de protección II',NULL,0),
(5682,'esMX','Tratado: Ahuyentar a no-muertos II',NULL,0),
(5683,'esMX','Tratado: Escudo divino II',NULL,0),
(5684,'esMX','Tratado: Sello de salvación',NULL,0),
(5685,'esMX','Tratado: Redención',NULL,0),
(5696,'esMX','Tablilla de choque',NULL,0),
(5697,'esMX','Tablilla de Tótem sanador',NULL,0),
(5698,'esMX','Tablilla de Escudo de relámpagos',NULL,0),
(5699,'esMX','Tablilla de Lobo fantasmal',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5700,5701,5702,5703,5704,5705,5706,5707,5708,5709,5710,5711,5712,5713,5714,5715,5716,5719,5720,5721) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5700,'esMX','Tablilla de Tótem sanador II',NULL,0),
(5701,'esMX','Tablilla de Tótem avizor',NULL,0),
(5702,'esMX','Tablilla de Tótem agitador II',NULL,0),
(5703,'esMX','Tablilla de Atronar',NULL,0),
(5704,'esMX','Tablilla de Respiración acuática',NULL,0),
(5705,'esMX','Tablilla de Tótem sanador III',NULL,0),
(5706,'esMX','Tablilla de Tótem serpiente III',NULL,0),
(5707,'esMX','Tablilla de Visión lejana',NULL,0),
(5708,'esMX','Tablilla de Forma etérea',NULL,0),
(5709,'esMX','Tablilla de Caminar sobre el agua',NULL,0),
(5710,'esMX','Tablilla de Tótem sanador IV',NULL,0),
(5711,'esMX','Tablilla de Lobo fantasmal II',NULL,0),
(5712,'esMX','Tablilla de Tótem serpiente IV',NULL,0),
(5713,'esMX','Tablilla de Descarga de truenos',NULL,0),
(5714,'esMX','Tablilla de Tótem enredador II',NULL,0),
(5715,'esMX','Tablilla de Tormenta de relámpagos III',NULL,0),
(5716,'esMX','Tablilla de Restauración VI',NULL,0),
(5719,'esMX','Grimorio Drenaje de vida II',NULL,0),
(5720,'esMX','Grimorio Maldición de Mannoroth II',NULL,0),
(5721,'esMX','Grimorio Crear piedra de hechizo',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(5722,5723,5724,5725,5726,5727,5728,5729,5730,5823,5857,5858,5874,5875,5896,5916,5937,5949,6130,6132) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5722,'esMX','Grimorio de Succión de maná II',NULL,0),
(5723,'esMX','Grimorio Maldición de Sargeras III',NULL,0),
(5724,'esMX','Grimorio Maldición de lenguas',NULL,0),
(5725,'esMX','Grimorio Pestilencia III',NULL,0),
(5726,'esMX','Grimorio Crear sangrita superior',NULL,0),
(5727,'esMX','Grimorio Cauce de maná',NULL,0),
(5728,'esMX','Grimorio Lluvia de Fuego II',NULL,0),
(5729,'esMX','Grimorio Miedo III',NULL,0),
(5730,'esMX','Libro sobre Rejuvenecimiento',NULL,0),
(5823,'esMX','Champiñón venenoso',NULL,0),
(5857,'esMX','Caja con premio gnomo','¡Ábrela y obtendrás un premio!',0),
(5858,'esMX','Caja con premio goblin','¡Ábrela y obtendrás un premio!',0),
(5874,'esMX','Arnés: carnero negro',NULL,0),
(5875,'esMX','Arnés: carnero azul',NULL,0),
(5896,'esMX',NULL,'El nombre Muren Macfeere está estampado.',0),
(5916,'esMX','Llave de cámara gnoma',NULL,0),
(5937,'esMX','Llave de cámara goblin',NULL,0),
(5949,'esMX','Tira de papel',NULL,0),
(6130,'esMX','Camisa de trampero',NULL,0),
(6132,'esMX','Tratado: Sello de sabiduría',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(6133,6182,6183,6192,6207,6208,6209,6210,6216,6222,6233,6237,6262,6273,6276,6277,6278,6279,6280,6295) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(6133,'esMX','Tratado: Sello de furia',NULL,0),
(6182,'esMX','Antorcha poco iluminada',NULL,0),
(6183,'esMX','Antorcha pobre sin encender',NULL,0),
(6192,'esMX','Cabeza de Khan Hratha',NULL,0),
(6207,'esMX','JcJ: diseños de torre de la Horda',NULL,0),
(6208,'esMX','JcJ: diseños de torre de la Alianza',NULL,0),
(6209,'esMX','JcJ: certificado de mina de la Horda',NULL,0),
(6210,'esMX','JcJ: certificado de mina de la Alianza',NULL,0),
(6216,'esMX','Partículas místicas','Usado por los encantadores para encantar objetos.',0),
(6222,'esMX','Fórmula: imbuir pechera: espíritu menor',NULL,0),
(6233,'esMX','Monster - Item, Flowers - Boquet Wildflowers',NULL,0),
(6237,'esMX','Monster - Item, Flowers - Boquet Roses (Black)',NULL,0),
(6262,'esMX','Diario de Galen',NULL,0),
(6273,'esMX','Patrón: toga de lana verde',NULL,0),
(6276,'esMX','Nota mohosa',NULL,0),
(6277,'esMX','Papiro mohoso',NULL,0),
(6278,'esMX','Pergamino mohoso',NULL,0),
(6279,'esMX','Carta mohosa',NULL,0),
(6280,'esMX','Misiva mohosa',NULL,0),
(6295,'esMX','Pargo de lodo de 7 kilos',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(6345,6374,6376,6489,6490,6491,6492,6493,6494,6495,6496,6497,6499,6544,6589,6619,6620,6621,6623,6638) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(6345,'esMX','Fórmula: imbuir capa: protección',NULL,0),
(6374,'esMX','Partículas encantadas','Usado por los encantadores para encantar objetos.',0),
(6376,'esMX','Fórmula: encantar botas: aguante menor',NULL,0),
(6489,'esMX','Papiro deteriorado',NULL,0),
(6490,'esMX','Papiro oscuro',NULL,0),
(6491,'esMX','Papiro pesado',NULL,0),
(6492,'esMX','Papiro tiznado',NULL,0),
(6493,'esMX','Papiro andrajoso',NULL,0),
(6494,'esMX','Papiro garabateado',NULL,0),
(6495,'esMX','Papiro estropeado',NULL,0),
(6496,'esMX','Papiro detallado',NULL,0),
(6497,'esMX','Papiro simple',NULL,0),
(6499,'esMX','Cuero de kodo grabado',NULL,0),
(6544,'esMX','Pergamino de invocación de abisario',NULL,0),
(6589,'esMX','Sortija viridiana',NULL,0),
(6619,'esMX','Manual: el camino de la defensa',NULL,0),
(6620,'esMX','Papiro elaborado',NULL,0),
(6621,'esMX','Manual de Provocación',NULL,0),
(6623,'esMX','Pergamino para invocar a Súcubo',NULL,0),
(6638,'esMX','Sapta de aire',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(6644,6646,6648,6649,6698,6707,6708,6711,6724,6728,6734,6736,6754,6777,6778,6779,6837,6850,6852,6891) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(6644,'esMX','Caballa hinchada',NULL,0),
(6646,'esMX','Atún hinchado',NULL,0),
(6648,'esMX','Pergamino de Tótem Piel de piedra',NULL,0),
(6649,'esMX','Pergamino de Tótem abrasador',NULL,0),
(6698,'esMX','Piedra de Pierce',NULL,0),
(6707,'esMX','Piedra de Lapidis',NULL,0),
(6708,'esMX','Piedra de Buenhombre',NULL,0),
(6711,'esMX','Piedra de Kurtz',NULL,0),
(6724,'esMX','Piedra de Backus',NULL,0),
(6728,'esMX','Piedra de Brownell',NULL,0),
(6734,'esMX','Diseño: cadena de Forjaz',NULL,0),
(6736,'esMX','Diseño: guanteletes de Forjaz',NULL,0),
(6754,'esMX','Monedero grande',NULL,0),
(6777,'esMX','Escrito sobre Rectitud',NULL,0),
(6778,'esMX','Escrito sobre Justicia',NULL,0),
(6779,'esMX','Escrito sobre Nobleza',NULL,0),
(6837,'esMX','Vestido de boda',NULL,0),
(6850,'esMX','Cabellera Sangrapellejo',NULL,0),
(6852,'esMX','Ojo eterno',NULL,0),
(6891,'esMX','Receta: huevo a las finas hierbas',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(6897,6899,6988,7007,7093,7192,7275,7347,7388,7425,7426,7427,7466,7467,7497,7547,7548,7550,7868,7869) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(6897,'esMX','Manual: camino del rabioso',NULL,0),
(6899,'esMX','Orbe de brujo 35',NULL,0),
(6988,'esMX','Pergamino para invocar manáfagos',NULL,0),
(7007,'esMX','Equipamiento de élite de Backus',NULL,0),
(7093,'esMX','Patrón: botas de oscuridad',NULL,0),
(7192,'esMX','Esquema: botas cohete goblin',NULL,0),
(7275,'esMX','Los pergaminos de Agamaggan',NULL,0),
(7347,'esMX','Inversor de piñón de Bingles',NULL,0),
(7388,'esMX','Llave calavera',NULL,0),
(7425,'esMX','Cabeza de Cyrik',NULL,0),
(7426,'esMX','Anillo cerúleo',NULL,0),
(7427,'esMX','Dije cerúleo',NULL,0),
(7466,'esMX','Sortija bermellón',NULL,0),
(7467,'esMX','Collar bermellón',NULL,0),
(7497,'esMX','Sortija de marfil',NULL,0),
(7547,'esMX','Anillo de ónice',NULL,0),
(7548,'esMX','Gargantilla de ónice',NULL,0),
(7550,'esMX','Honor de guerrero',NULL,0),
(7868,'esMX','Equipamiento de ladrón',NULL,0),
(7869,'esMX','Arcón de Lucius',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(7872,7923,7977,7986,7987,7988,7994,8147,8148,8243,8388,8493,8502,8503,8504,8505,8506,8507,8543,8546) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(7872,'esMX','Útiles de ladrón herrumbrados',NULL,0),
(7923,'esMX','Llave de la torre Defias',NULL,0),
(7977,'esMX','Diseño: guantes de escamas de mitril',NULL,0),
(7986,'esMX','Diseño: coraza de mitril ornamentado',NULL,0),
(7987,'esMX','Diseño: yelmo de mitril ornamentado',NULL,0),
(7988,'esMX','Diseño: botas de mitril ornamentado',NULL,0),
(7994,'esMX','Diseño: leotardos de guerra orcos',NULL,0),
(8147,'esMX','Llave pequeña de cobre','Un componente para hechizos mágicos.',0),
(8148,'esMX','Llave de plata diminuta','Un componente para hechizos mágicos.',0),
(8243,'esMX','Chuchería de Scooby','¡Escubi-dubi-du!',0),
(8388,'esMX','Patrón: capa Nochefugaz',NULL,0),
(8493,'esMX','Barrica de Weegli',NULL,0),
(8502,'esMX','Caja de lotería de bronce','Siempre tendrá un objeto raro de nivel 20 o superior.',0),
(8503,'esMX','Caja de lotería de bronce pesada','Siempre tendrá un objeto raro de nivel 25 o superior.',0),
(8504,'esMX','Caja de lotería de hierro','Siempre tendrá un objeto raro de nivel 30 o superior.',0),
(8505,'esMX','Caja de lotería de hierro pesado','Siempre tendrá un objeto raro de nivel 35 o superior.',0),
(8506,'esMX','Caja de lotería de mitril','Siempre tendrá un objeto raro de nivel 40 o superior.',0),
(8507,'esMX','Caja de lotería de mitril pesado','Siempre tendrá un objeto raro de nivel 45 o superior.',0),
(8543,'esMX','Hongos subacuáticos',NULL,0),
(8546,'esMX','Sales aromáticas potentes',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8547,8583,8589,8590,8628,8630,8633,8743,8744,8756,8757,8758,8759,8760,8761,8762,8763,8764,8765,8768) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8547,'esMX','Formula: Powerful Smelling Salts [PH]',NULL,0),
(8583,'esMX','Cuerno de la montura esquelética',NULL,0),
(8589,'esMX','Silbato viejo de raptor marfil',NULL,0),
(8590,'esMX','Silbato viejo de raptor obsidiana',NULL,0),
(8628,'esMX','Riendas del sable de la noche moteado',NULL,0),
(8630,'esMX','Riendas del tigre de bengala',NULL,0),
(8633,'esMX','Riendas del leopardo',NULL,0),
(8743,'esMX','Libro sobre Marca de lo Salvaje',NULL,0),
(8744,'esMX','Libro sobre Cólera',NULL,0),
(8756,'esMX','Libro sobre Recrecimiento II',NULL,0),
(8757,'esMX','Libro sobre Fuego estelar',NULL,0),
(8758,'esMX','Libro sobre Eliminar maldición',NULL,0),
(8759,'esMX','Libro sobre Recrecimiento III',NULL,0),
(8760,'esMX','Libro sobre Suprimir Veneno',NULL,0),
(8761,'esMX','Libro sobre Fuego estelar II',NULL,0),
(8762,'esMX','Libro sobre Rejuvenecimiento V',NULL,0),
(8763,'esMX','Libro sobre Fuego lunar V',NULL,0),
(8764,'esMX','Libro sobre Fuego Feérico II',NULL,0),
(8765,'esMX','Libro sobre Recrecimiento IV',NULL,0),
(8768,'esMX','Libro sobre Fuego estelar III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8769,8770,8771,8772,8773,8774,8775,8776,8777,8778,8779,8780,8781,8782,8783,8784,8785,8786,8787,8788) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8769,'esMX','Libro sobre Espinas IV',NULL,0),
(8770,'esMX','Libro sobre Fuego lunar VI',NULL,0),
(8771,'esMX','Libro sobre Rejuvenecimiento VI',NULL,0),
(8772,'esMX','Libro sobre Recrecimiento V',NULL,0),
(8773,'esMX','Libro sobre Raíces enredadoras V',NULL,0),
(8774,'esMX','Libro sobre Toque de sanación VII',NULL,0),
(8775,'esMX','Libro sobre Tranquilidad II',NULL,0),
(8776,'esMX','Libro sobre Marca de lo Salvaje VI',NULL,0),
(8777,'esMX','Libro sobre Fuego lunar IX',NULL,0),
(8778,'esMX','Libro sobre Rejuvenecimiento VII',NULL,0),
(8779,'esMX','Libro sobre Fuego Feérico III',NULL,0),
(8780,'esMX','Libro sobre Fuego estelar V',NULL,0),
(8781,'esMX','Libro sobre Recrecimiento VII',NULL,0),
(8782,'esMX','Libro sobre Espinas V',NULL,0),
(8783,'esMX','Libro sobre Toque de sanación IX',NULL,0),
(8784,'esMX','Libro sobre Cólera VII',NULL,0),
(8785,'esMX','Libro sobre Rejuvenecimiento IX',NULL,0),
(8786,'esMX','Libro sobre Tranquilidad III',NULL,0),
(8787,'esMX','Libro sobre Calma de animales',NULL,0),
(8788,'esMX','Libro sobre Calma de animales II',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8789,8790,8791,8792,8793,8794,8795,8796,8797,8798,8799,8800,8801,8802,8804,8805,8806,8807,8808,8809) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8789,'esMX','Libro sobre Calma de animales III',NULL,0),
(8790,'esMX','Libro sobre Fuego Feérico IV',NULL,0),
(8791,'esMX','Libro sobre Recrecimiento VIII',NULL,0),
(8792,'esMX','Libro sobre Espinas VI',NULL,0),
(8793,'esMX','Libro sobre Cólera VIII',NULL,0),
(8794,'esMX','Libro sobre Toque de sanación X',NULL,0),
(8795,'esMX','Libro sobre Raíces enredadoras VI',NULL,0),
(8796,'esMX','Libro sobre Fuego lunar X',NULL,0),
(8797,'esMX','Libro sobre Rejuvenecimiento X',NULL,0),
(8798,'esMX','Libro sobre Fuego estelar VI',NULL,0),
(8799,'esMX','Libro sobre Marca de lo Salvaje VII',NULL,0),
(8800,'esMX','Libro sobre Recrecimiento IX',NULL,0),
(8801,'esMX','Libro sobre Tranquilidad IV',NULL,0),
(8802,'esMX','Escrito sobre Intelecto Arcano',NULL,0),
(8804,'esMX','Escrito sobre Deflagración Arcana',NULL,0),
(8805,'esMX','Escrito sobre Detectar magia',NULL,0),
(8806,'esMX','Escrito sobre Eliminar maldición inferior',NULL,0),
(8807,'esMX','Escrito sobre Amplificar magia',NULL,0),
(8808,'esMX','Escrito sobre Escudo de maná',NULL,0),
(8809,'esMX','Escrito sobre Sueño',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8810,8811,8812,8813,8814,8815,8816,8818,8819,8820,8821,8822,8823,8824,8825,8826,8828,8829,8830,8832) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8810,'esMX','Escrito sobre Sueño II',NULL,0),
(8811,'esMX','Escrito sobre Agostar',NULL,0),
(8812,'esMX','Escrito sobre Deflagración Arcana II',NULL,0),
(8813,'esMX','Escrito sobre Atenuar magia II',NULL,0),
(8814,'esMX','Escrito sobre Bola de Fuego V',NULL,0),
(8815,'esMX','Escrito sobre Cono de frío',NULL,0),
(8816,'esMX','Escrito sobre Descarga de Escarcha V',NULL,0),
(8818,'esMX','Escrito sobre Escudo de maná II',NULL,0),
(8819,'esMX','Escrito sobre Agostar II',NULL,0),
(8820,'esMX','Escrito sobre Resguardo contra el Fuego II',NULL,0),
(8821,'esMX','Escrito sobre Amplificar magia II',NULL,0),
(8822,'esMX','Escrito sobre Deflagración Arcana III',NULL,0),
(8823,'esMX','Escrito sobre Explosión de Fuego IV',NULL,0),
(8824,'esMX','Escrito sobre Bola de Fuego VI',NULL,0),
(8825,'esMX','Escrito sobre Resguardo contra la Escarcha III',NULL,0),
(8826,'esMX','Escrito sobre Misiles Arcanos IV',NULL,0),
(8828,'esMX','Escrito sobre Descarga de Escarcha VI',NULL,0),
(8829,'esMX','Escrito sobre Cono de frío II',NULL,0),
(8830,'esMX','Escrito sobre Agostar III',NULL,0),
(8832,'esMX','Escrito sobre Ventisca III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8833,8834,8835,8837,8840,8841,8842,8843,8844,8847,8848,8849,8850,8851,8852,8853,8854,8855,8856,8857) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8833,'esMX','Escrito sobre Escudo de maná III',NULL,0),
(8834,'esMX','Escrito sobre Atenuar magia III',NULL,0),
(8835,'esMX','Escrito sobre Bola de Fuego VII',NULL,0),
(8837,'esMX','Escrito sobre Deflagración Arcana V',NULL,0),
(8840,'esMX','Escrito sobre Crear gema de maná II',NULL,0),
(8841,'esMX','Escrito sobre Explosión de Fuego V',NULL,0),
(8842,'esMX','Escrito sobre Descarga de Escarcha VII',NULL,0),
(8843,'esMX','Escrito sobre Resguardo contra el Fuego III',NULL,0),
(8844,'esMX','Escrito sobre Sueño III',NULL,0),
(8847,'esMX','Escrito sobre Agostar V',NULL,0),
(8848,'esMX','Escrito sobre Fogonazo IV',NULL,0),
(8849,'esMX','Escrito sobre Misiles Arcanos V',NULL,0),
(8850,'esMX','Escrito sobre Crear agua V',NULL,0),
(8851,'esMX','Escrito sobre Bola de Fuego VIII',NULL,0),
(8852,'esMX','Escrito sobre Intelecto Arcano IV',NULL,0),
(8853,'esMX','Escrito sobre Crear comida V',NULL,0),
(8854,'esMX','Escrito sobre Cono de frío III',NULL,0),
(8855,'esMX','Escrito sobre Amplificar magia III',NULL,0),
(8856,'esMX','Escrito sobre Descarga de Escarcha VIII',NULL,0),
(8857,'esMX','Escrito sobre Ventisca IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8858,8859,8860,8861,8862,8863,8864,8865,8866,8867,8868,8869,8871,8872,8873,8874,8875,8876,8877,8878) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8858,'esMX','Escrito sobre Escudo de maná IV',NULL,0),
(8859,'esMX','Escrito sobre Explosión de Fuego VI',NULL,0),
(8860,'esMX','Escrito sobre Bola de Fuego IX',NULL,0),
(8861,'esMX','Escrito sobre Crear gema de maná III',NULL,0),
(8862,'esMX','Escrito sobre Misiles Arcanos VI',NULL,0),
(8863,'esMX','Escrito sobre Atenuar magia IV',NULL,0),
(8864,'esMX','Escrito sobre Fogonazo V',NULL,0),
(8865,'esMX','Escrito sobre Armadura de hielo III',NULL,0),
(8866,'esMX','Escrito sobre Cono de frío IV',NULL,0),
(8867,'esMX','Escrito sobre Descarga de Escarcha IX',NULL,0),
(8868,'esMX','Escrito sobre Crear agua VI',NULL,0),
(8869,'esMX','Escrito sobre Resguardo contra el Fuego IV',NULL,0),
(8871,'esMX','Escrito sobre Crear comida VI',NULL,0),
(8872,'esMX','Escrito sobre Ventisca V',NULL,0),
(8873,'esMX','Escrito sobre Escudo de maná V',NULL,0),
(8874,'esMX','Escrito sobre Agostar VI',NULL,0),
(8875,'esMX','Escrito sobre Resguardo contra la Escarcha IV',NULL,0),
(8876,'esMX','Escrito sobre Resguardo contra la Escarcha II',NULL,0),
(8877,'esMX','Escrito sobre Bola de Fuego X',NULL,0),
(8878,'esMX','Escrito sobre Explosión de Fuego VII',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8879,8880,8881,8882,8883,8884,8885,8886,8887,8888,8889,8890,8891,8892,8893,8894,8895,8896,8897,8898) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8879,'esMX','Escrito sobre Nova de Escarcha IV',NULL,0),
(8880,'esMX','Escrito sobre Deflagración Arcana VI',NULL,0),
(8881,'esMX','Escrito sobre Liberación de Khadgar IV',NULL,0),
(8882,'esMX','Escrito sobre Amplificar magia IV',NULL,0),
(8883,'esMX','Escrito sobre Intelecto Arcano V',NULL,0),
(8884,'esMX','Escrito sobre Descarga de Escarcha X',NULL,0),
(8885,'esMX','Escrito sobre Misiles Arcanos VII',NULL,0),
(8886,'esMX','Escrito sobre Fogonazo VI',NULL,0),
(8887,'esMX','Escrito sobre Agostar VII',NULL,0),
(8888,'esMX','Escrito sobre Cono de frío V',NULL,0),
(8889,'esMX','Escrito sobre Crear gema de maná IV',NULL,0),
(8890,'esMX','Escrito sobre Bola de Fuego XI',NULL,0),
(8891,'esMX','Escrito sobre Armadura de hielo IV',NULL,0),
(8892,'esMX','Escrito sobre Crear agua VII',NULL,0),
(8893,'esMX','Escrito sobre Sueño IV',NULL,0),
(8894,'esMX','Escrito sobre Atenuar magia V',NULL,0),
(8895,'esMX','Escrito sobre Ventisca VI',NULL,0),
(8896,'esMX','Escrito sobre Escudo de maná VI',NULL,0),
(8897,'esMX','Escrito sobre Resguardo contra el Fuego V',NULL,0),
(8898,'esMX','Escrito sobre Deflagración Arcana IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8899,8900,8901,8902,8903,8904,8905,8906,8907,8909,8910,8911,8912,8913,8914,8915,8916,8917,8918,8919) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8899,'esMX','Escrito sobre Agostar IV',NULL,0),
(8900,'esMX','Libro sobre Raíces enredadoras IV',NULL,0),
(8901,'esMX','Libro sobre Toque de sanación VIII',NULL,0),
(8902,'esMX','Libro sobre Marca de lo Salvaje V',NULL,0),
(8903,'esMX','Libro sobre Fuego lunar VII',NULL,0),
(8904,'esMX','Libro sobre Fuego lunar VIII',NULL,0),
(8905,'esMX','Libro sobre Recrecimiento VI',NULL,0),
(8906,'esMX','Libro sobre Rejuvenecimiento VIII',NULL,0),
(8907,'esMX','Libro sobre Fuego estelar IV',NULL,0),
(8909,'esMX','Tratado: Golpe Sagrado II',NULL,0),
(8910,'esMX','Tratado: Imposición de manos',NULL,0),
(8911,'esMX','Tratado: Puño de justicia',NULL,0),
(8912,'esMX','Tratado: Golpe de cruzado',NULL,0),
(8913,'esMX','Tratado: Golpe Sagrado III',NULL,0),
(8914,'esMX','Tratado: Golpe de cruzado II',NULL,0),
(8915,'esMX','Tratado: Golpe Sagrado IV',NULL,0),
(8916,'esMX','Tratado: Puño de justicia II',NULL,0),
(8917,'esMX','Tratado: Imposición de manos II',NULL,0),
(8918,'esMX','Tratado: Sello de protección III',NULL,0),
(8919,'esMX','Tratado: Golpe Sagrado V',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8920,8921,8922,8929,8930,8931,8933,8934,8935,8936,8937,8938,8939,8940,8941,8942,8943,8944,8945,8947) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8920,'esMX','Tratado: Golpe de cruzado III',NULL,0),
(8921,'esMX','Tratado: Puño de justicia III',NULL,0),
(8922,'esMX','Tratado: Golpe Sagrado VI',NULL,0),
(8929,'esMX','Tratado: Exorcismo IV',NULL,0),
(8930,'esMX','Tratado: Sello de rectitud IV',NULL,0),
(8931,'esMX','Tratado: Golpe de cruzado IV',NULL,0),
(8933,'esMX','Tratado: Luz Sagrada VII',NULL,0),
(8934,'esMX','Tratado: Golpe Sagrado VII',NULL,0),
(8935,'esMX','Tratado: Sentencia II',NULL,0),
(8936,'esMX','Tratado: Sello de cólera III',NULL,0),
(8937,'esMX','Tratado: Imposición de manos III',NULL,0),
(8938,'esMX','Tratado: Ahuyentar a no-muertos III',NULL,0),
(8939,'esMX','Tratado: Exorcismo V',NULL,0),
(8940,'esMX','Tratado: Puño de justicia IV',NULL,0),
(8941,'esMX','Tratado: Luz Sagrada VIII',NULL,0),
(8942,'esMX','Tratado: Sello de rectitud V',NULL,0),
(8943,'esMX','Tratado: Golpe Sagrado VIII',NULL,0),
(8944,'esMX','Tratado: Golpe de cruzado V',NULL,0),
(8945,'esMX','Tratado: Sentencia III',NULL,0),
(8947,'esMX','Tratado: Exorcismo VI',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8954,8955,8958,8960,8961,8962,8963,8964,8965,8966,8967,8968,8969,8971,8972,8974,8975,8976,8977,8978) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8954,'esMX','Códice de Palabra Sagrada: entereza',NULL,0),
(8955,'esMX','Códice de Desvanecerse',NULL,0),
(8958,'esMX','Códice de Explosión mental',NULL,0),
(8960,'esMX','Códice de Curar enfermedad',NULL,0),
(8961,'esMX','Códice de Alarido psíquico',NULL,0),
(8962,'esMX','Códice de Explosión mental II',NULL,0),
(8963,'esMX','Códice de Calma mental',NULL,0),
(8964,'esMX','Códice de Sanación relámpago',NULL,0),
(8965,'esMX','Códice de Desvanecerse II',NULL,0),
(8966,'esMX','Códice de Encadenar no-muerto',NULL,0),
(8967,'esMX','Códice de Explosión mental III',NULL,0),
(8968,'esMX','Códice de Quemar maná',NULL,0),
(8969,'esMX','Códice de Sanación relámpago II',NULL,0),
(8971,'esMX','Códice de Alarido psíquico II',NULL,0),
(8972,'esMX','Códice de Explosión mental IV',NULL,0),
(8974,'esMX','Códice de Control mental',NULL,0),
(8975,'esMX','Códice de Desvanecerse III',NULL,0),
(8976,'esMX','Códice de Suprimir enfermedad',NULL,0),
(8977,'esMX','Códice de Quemar maná II',NULL,0),
(8978,'esMX','Códice de Sanación relámpago III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(8980,8981,8983,8986,8987,8988,8989,8990,8991,8992,8994,8995,8996,8997,8998,8999,9000,9001,9002,9003) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(8980,'esMX','Códice de Explosión mental V',NULL,0),
(8981,'esMX','Códice de Calma mental II',NULL,0),
(8983,'esMX','Códice de Sanación relámpago IV',NULL,0),
(8986,'esMX','Códice de Encadenar no-muerto II',NULL,0),
(8987,'esMX','Códice de Protección contra lo Sagrado II',NULL,0),
(8988,'esMX','Códice de Quemar maná III',NULL,0),
(8989,'esMX','Códice de Desvanecerse IV',NULL,0),
(8990,'esMX','Códice de Explosión mental VI',NULL,0),
(8991,'esMX','Códice de Fuego interno IV',NULL,0),
(8992,'esMX','Códice de Alarido psíquico III',NULL,0),
(8994,'esMX','Códice de palabra de las Sombras: dolor VI',NULL,0),
(8995,'esMX','Códice de Palabra Sagrada: escudo VII',NULL,0),
(8996,'esMX','Códice de Resurrección III',NULL,0),
(8997,'esMX','Códice de Control mental II',NULL,0),
(8998,'esMX','Códice de Visión mental II',NULL,0),
(8999,'esMX','Códice de Sanación relámpago V',NULL,0),
(9000,'esMX','Códice de Renovar VII',NULL,0),
(9001,'esMX','Códice de Sanación superior II',NULL,0),
(9002,'esMX','Códice de Explosión mental VII',NULL,0),
(9003,'esMX','Códice de Punición Sagrada VII',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9004,9005,9006,9007,9008,9009,9010,9011,9012,9013,9014,9015,9016,9017,9018,9019,9020,9021,9022,9023) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9004,'esMX','Códice de Palabra Sagrada: entereza V',NULL,0),
(9005,'esMX','Códice de Quemar maná IV',NULL,0),
(9006,'esMX','Códice de Palabra Sagrada: escudo VIII',NULL,0),
(9007,'esMX','Códice de Desvanecerse V',NULL,0),
(9008,'esMX','Códice de Rezo de sanación III',NULL,0),
(9009,'esMX','Códice de Fuego interno V',NULL,0),
(9010,'esMX','Códice de Sanación relámpago VI',NULL,0),
(9011,'esMX','Códice de palabra de las Sombras: dolor VII',NULL,0),
(9012,'esMX','Códice de Renovar VIII',NULL,0),
(9013,'esMX','Códice de Sanación superior III',NULL,0),
(9014,'esMX','Códice de Calma mental III',NULL,0),
(9015,'esMX','Códice de Explosión mental VIII',NULL,0),
(9016,'esMX','Códice de Punición Sagrada VIII',NULL,0),
(9017,'esMX','Códice de Protección contra lo Sagrado III',NULL,0),
(9018,'esMX','Códice de Palabra Sagrada: escudo IX',NULL,0),
(9019,'esMX','Códice de Renovar IX',NULL,0),
(9020,'esMX','Códice de Alarido psíquico IV',NULL,0),
(9021,'esMX','Códice de Quemar maná V',NULL,0),
(9022,'esMX','Códice de Sanación relámpago VII',NULL,0),
(9023,'esMX','Códice de Protección contra las Sombras III',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9024,9025,9026,9027,9028,9029,9031,9032,9033,9034,9035,9037,9039,9040,9041,9043,9044,9046,9047,9048) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9024,'esMX','Códice de Control mental III',NULL,0),
(9025,'esMX','Códice de Sanación superior IV',NULL,0),
(9026,'esMX','Códice de Resurrección IV',NULL,0),
(9027,'esMX','Códice de Explosión mental IX',NULL,0),
(9028,'esMX','Códice de Palabra de las Sombras: dolor VIII',NULL,0),
(9029,'esMX','Códice de Desvanecerse VI',NULL,0),
(9031,'esMX','Códice de Encadenar no-muerto III',NULL,0),
(9032,'esMX','Códice de Rezo de sanación IV',NULL,0),
(9033,'esMX','Códice de Fuego interno VI',NULL,0),
(9034,'esMX','Códice de Palabra Sagrada: entereza VI',NULL,0),
(9035,'esMX','Códice de Palabra Sagrada: escudo X',NULL,0),
(9037,'esMX','Tablilla de arma de Muerdepiedras',NULL,0),
(9039,'esMX','Tablilla de Choque de tierra',NULL,0),
(9040,'esMX','Tablilla de Ola de sanación II',NULL,0),
(9041,'esMX','Tablilla de Tótem Nexo Terrestre',NULL,0),
(9043,'esMX','Tablilla de Tótem Garra de piedra',NULL,0),
(9044,'esMX','Tablilla de Choque de tierra II',NULL,0),
(9046,'esMX','Tablilla de Tótem Fuerza de la tierra',NULL,0),
(9047,'esMX','Tablilla de Choque de llamas',NULL,0),
(9048,'esMX','Tablilla de Renacer',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9049,9050,9051,9052,9053,9054,9055,9056,9057,9058,9059,9062,9063,9064,9065,9066,9067,9068,9069,9070) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9049,'esMX','Tablilla de Tótem Nova de Fuego',NULL,0),
(9050,'esMX','Tablilla de Ola de sanación III',NULL,0),
(9051,'esMX','Tablilla de Choque de tierra III',NULL,0),
(9052,'esMX','Tablilla de Tótem Piel de piedra II',NULL,0),
(9053,'esMX','Tablilla de arma de Muerdepiedras II',NULL,0),
(9054,'esMX','Tablilla de Choque de llamas II',NULL,0),
(9055,'esMX','Tablilla de Tótem Garra de piedra II',NULL,0),
(9056,'esMX','Tablilla de Ola de sanación IV',NULL,0),
(9057,'esMX','Tablilla de arma Estigma de Escarcha',NULL,0),
(9058,'esMX','Tablilla de Choque de Escarcha',NULL,0),
(9059,'esMX','Tablilla de Arma Lengua de Fuego',NULL,0),
(9062,'esMX','Tablilla de Curar enfermedad',NULL,0),
(9063,'esMX','Tablilla de Tótem contraveneno',NULL,0),
(9064,'esMX','Tablilla de Arma Lengua de Fuego II',NULL,0),
(9065,'esMX','Tablilla de Tótem Nova de Fuego II',NULL,0),
(9066,'esMX','Tablilla de Tótem de resistencia a la Escarcha',NULL,0),
(9067,'esMX','Tablilla de Tótem Fuerza de la tierra II',NULL,0),
(9068,'esMX','Tablilla de Tótem Piel de piedra III',NULL,0),
(9069,'esMX','Tablilla de Choque de tierra IV',NULL,0),
(9070,'esMX','Tablilla de Ola de sanación V',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9071,9072,9073,9074,9075,9076,9077,9078,9079,9080,9081,9082,9083,9084,9085,9086,9087,9089,9090,9091) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9071,'esMX','Tablilla de Tótem fuente de maná',NULL,0),
(9072,'esMX','Tablilla de Tótem Lengua de Fuego',NULL,0),
(9073,'esMX','Tablilla de arma Viento Furioso',NULL,0),
(9074,'esMX','Tablilla de Choque de llamas III',NULL,0),
(9075,'esMX','Tablilla de Tótem de resistencia al Fuego',NULL,0),
(9076,'esMX','Tablilla de Tótem de magma',NULL,0),
(9077,'esMX','Tablilla de Tótem Garra de piedra III',NULL,0),
(9078,'esMX','Tablilla de Tótem derribador',NULL,0),
(9079,'esMX','Tablilla de Choque de relámpagos',NULL,0),
(9080,'esMX','Tablilla de Tótem de resistencia a la Naturaleza',NULL,0),
(9081,'esMX','Tablilla de Tótem Corriente de sanación II',NULL,0),
(9082,'esMX','Tablilla de arma de Muerdepiedras III',NULL,0),
(9083,'esMX','Tablilla de Tótem abrasador III',NULL,0),
(9084,'esMX','Tablilla de Tótem Viento Furioso',NULL,0),
(9085,'esMX','Tablilla de Tótem Nova de Fuego III',NULL,0),
(9086,'esMX','Tablilla de Ola de sanación VI',NULL,0),
(9087,'esMX','Tablilla de Purgar II',NULL,0),
(9089,'esMX','Tablilla de Choque de Escarcha II',NULL,0),
(9090,'esMX','Tablilla de arma Estigma de Escarcha II',NULL,0),
(9091,'esMX','Tablilla de Tótem Piel de piedra IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9093,9094,9095,9096,9097,9098,9099,9100,9101,9102,9103,9104,9105,9123,9124,9125,9126,9127,9128,9129) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9093,'esMX','Tablilla de Tótem fuente de maná II',NULL,0),
(9094,'esMX','Tablilla de Arma Lengua de Fuego III',NULL,0),
(9095,'esMX','Tablilla de Choque de tierra V',NULL,0),
(9096,'esMX','Tablilla de Tótem de limpieza de enfermedades',NULL,0),
(9097,'esMX','Tablilla de Tótem de magma II',NULL,0),
(9098,'esMX','Tablilla de Tótem Fuerza de la tierra III',NULL,0),
(9099,'esMX','Tablilla de Tótem Garra de piedra IV',NULL,0),
(9100,'esMX','Tablilla de Escudo de relámpagos V',NULL,0),
(9101,'esMX','Tablilla de arma Viento Furioso II',NULL,0),
(9102,'esMX','Tablilla de Cadena de relámpagos II',NULL,0),
(9103,'esMX','Tablilla de Tótem Corriente de sanación III',NULL,0),
(9104,'esMX','Tablilla de Tótem abrasador IV',NULL,0),
(9105,'esMX','Tablilla de Ola de sanación VII',NULL,0),
(9123,'esMX','Tablilla de Descarga de relámpagos VI',NULL,0),
(9124,'esMX','Tablilla de Choque de relámpagos II',NULL,0),
(9125,'esMX','Tablilla de Tótem Gracia del Aire',NULL,0),
(9126,'esMX','Tablilla de Tótem Lengua de Fuego II',NULL,0),
(9127,'esMX','Tablilla de Tótem de resistencia al Fuego II',NULL,0),
(9128,'esMX','Tablilla de Tótem Nova de Fuego IV',NULL,0),
(9129,'esMX','Tablilla de arma de Muerdepiedras IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9130,9131,9132,9133,9134,9135,9136,9137,9138,9139,9140,9141,9142,9143,9145,9146,9147,9148,9150,9151) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9130,'esMX','Tablilla de Tótem de resistencia a la Naturaleza II',NULL,0),
(9131,'esMX','Tablilla de Tótem Piel de piedra V',NULL,0),
(9132,'esMX','Tablilla de Explosión de arrabio VI',NULL,0),
(9133,'esMX','Tablilla de Sanación en cadena II',NULL,0),
(9134,'esMX','Tablilla de Tótem Viento Furioso II',NULL,0),
(9135,'esMX','Tablilla de Choque de Escarcha III',NULL,0),
(9136,'esMX','Tablilla de Tótem fuente de maná III',NULL,0),
(9137,'esMX','Tablilla de Escudo de relámpagos VI',NULL,0),
(9138,'esMX','Tablilla de Tótem de magma III',NULL,0),
(9139,'esMX','Tablilla de arma Estigma de Escarcha III',NULL,0),
(9140,'esMX','Tablilla de Cadena de relámpagos III',NULL,0),
(9141,'esMX','Tablilla de Tótem Garra de piedra V',NULL,0),
(9142,'esMX','Tablilla de Choque de tierra VI',NULL,0),
(9143,'esMX','Tablilla de Ola de sanación VIII',NULL,0),
(9145,'esMX','Tablilla de Descarga de relámpagos VII',NULL,0),
(9146,'esMX','Tablilla de Tótem abrasador V',NULL,0),
(9147,'esMX','Tablilla de Tótem Corriente de sanación IV',NULL,0),
(9148,'esMX','Tablilla de Arma Lengua de Fuego IV',NULL,0),
(9150,'esMX','Tablilla de Tótem Fuerza de la tierra IV',NULL,0),
(9151,'esMX','Tablilla de Choque de llamas V',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9152,9156,9157,9158,9159,9160,9161,9162,9164,9165,9166,9167,9168,9169,9170,9171,9174,9175,9176,9177) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9152,'esMX','Tablilla de Tótem Nova de Fuego V',NULL,0),
(9156,'esMX','Tablilla de Explosión de arrabio VII',NULL,0),
(9157,'esMX','Tablilla de Sanación en cadena III',NULL,0),
(9158,'esMX','Tablilla de Tótem de resistencia a la Escarcha III',NULL,0),
(9159,'esMX','Tablilla de Choque de relámpagos III',NULL,0),
(9160,'esMX','Tablilla de arma Viento Furioso III',NULL,0),
(9161,'esMX','Tablilla de Tótem Piel de piedra VI',NULL,0),
(9162,'esMX','Tablilla de Escudo de relámpagos VII',NULL,0),
(9164,'esMX','Tablilla de Tótem Gracia del Aire II',NULL,0),
(9165,'esMX','Tablilla de Tótem Lengua de Fuego III',NULL,0),
(9166,'esMX','Tablilla de Tótem fuente de maná IV',NULL,0),
(9167,'esMX','Tablilla de Cadena de relámpagos IV',NULL,0),
(9168,'esMX','Tablilla de Ola de sanación IX',NULL,0),
(9169,'esMX','Tablilla de Descarga de relámpagos VIII',NULL,0),
(9170,'esMX','Tablilla de Tótem de resistencia al Fuego III',NULL,0),
(9171,'esMX','Tablilla de Tótem de magma IV',NULL,0),
(9174,'esMX','Tablilla de choque de Escarcha IV',NULL,0),
(9175,'esMX','Tablilla de arma de Muerdepiedras V',NULL,0),
(9176,'esMX','Tablilla de Tótem Garra de piedra VI',NULL,0),
(9177,'esMX','Tablilla de choque de tierra VII',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9178,9180,9181,9182,9183,9184,9185,9188,9190,9191,9192,9193,9194,9195,9198,9199,9200,9201,9202,9203) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9178,'esMX','Tablilla de Tótem de resistencia a la Naturaleza III',NULL,0),
(9180,'esMX','Tablilla de Tótem Viento Furioso III',NULL,0),
(9181,'esMX','Tablilla de Tótem Corriente de sanación V',NULL,0),
(9182,'esMX','Tablilla de Tótem abrasador VI',NULL,0),
(9183,'esMX','Tablilla de Sanación en cadena',NULL,0),
(9184,'esMX','Tablilla de Choque de llamas IV',NULL,0),
(9185,'esMX','Tablilla de Tótem de resistencia a la Escarcha II',NULL,0),
(9188,'esMX','Tablilla de Tótem abrasador II',NULL,0),
(9190,'esMX','Grimorio Inmolar',NULL,0),
(9191,'esMX','Grimorio Maldición de debilidad',NULL,0),
(9192,'esMX','Grimorio Corrupción',NULL,0),
(9193,'esMX','Grimorio Transfusión de vida',NULL,0),
(9194,'esMX','Grimorio Maldición de agonía',NULL,0),
(9195,'esMX','Grimorio Drenar alma',NULL,0),
(9198,'esMX','Grimorio Cauce de salud',NULL,0),
(9199,'esMX','Grimorio Maldición de temeridad',NULL,0),
(9200,'esMX','Grimorio Maldición de debilidad II',NULL,0),
(9201,'esMX','Grimorio Corrupción II',NULL,0),
(9202,'esMX','Grimorio Transfusión de vida II',NULL,0),
(9203,'esMX','Grimorio Ritual de invocación',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9204,9205,9207,9208,9209,9211,9212,9215,9216,9217,9218,9219,9221,9222,9223,9225,9226,9227,9228,9229) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9204,'esMX','Grimorio Cauce de salud II',NULL,0),
(9205,'esMX','Grimorio Maldición de agonía II',NULL,0),
(9207,'esMX','Grimorio Crear sangrita II',NULL,0),
(9208,'esMX','Grimorio Drenar alma II',NULL,0),
(9209,'esMX','Grimorio Maldición de debilidad III',NULL,0),
(9211,'esMX','Grimorio Maldición de temeridad II',NULL,0),
(9212,'esMX','Grimorio Descarga de las Sombras V',NULL,0),
(9215,'esMX','Grimorio Cauce de salud III',NULL,0),
(9216,'esMX','Grimorio Corrupción III',NULL,0),
(9217,'esMX','Grimorio Transfusión de vida III',NULL,0),
(9218,'esMX','Grimorio Esclavizar demonio',NULL,0),
(9219,'esMX','Grimorio Llamas infernales',NULL,0),
(9221,'esMX','Grimorio Maldición de agonía III',NULL,0),
(9222,'esMX','Grimorio Maldición de los Elementos',NULL,0),
(9223,'esMX','Grimorio Maldición de debilidad IV',NULL,0),
(9225,'esMX','Grimorio Descarga de las Sombras VI',NULL,0),
(9226,'esMX','Grimorio Cauce de salud IV',NULL,0),
(9227,'esMX','Grimorio Drenar alma III',NULL,0),
(9228,'esMX','Grimorio Crear sangrita III',NULL,0),
(9229,'esMX','Grimorio Drenaje de vida IV',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(9230,9231,9299,9311,9417,9443,9489,9529,9532,9537,9572,9888,10303,10304,10313,10319,10322,10324,10460,10478) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(9230,'esMX','Grimorio Maldición de temeridad III',NULL,0),
(9231,'esMX','Grimorio Corrupción IV',NULL,0),
(9299,'esMX','Combinación de la caja fuerte de Termochufe',NULL,0),
(9311,'esMX','Papel y sobres para cartas estándar',NULL,0),
(9417,'esMX','Trozo arcádico',NULL,0),
(9443,'esMX','Muestra de monstruo utilizada',NULL,0),
(9489,'esMX','Hielera giromática',NULL,0),
(9529,'esMX','Juego de equipo de guerrero interno N25','Blandito como un flan.',0),
(9532,'esMX','Juego de equipo de guerrero interno N30','Hecho con amor',0),
(9537,'esMX','Caja bien envuelta',NULL,0),
(9572,'esMX','<UNUSED> Glyphic Rune',NULL,0),
(9888,'esMX','Deprecated Elven Protector',NULL,0),
(10303,'esMX','Patrón: pantalones de paño tormentoso',NULL,0),
(10304,'esMX','Patrón: guantes de paño tormentoso',NULL,0),
(10313,'esMX','Patrón: jubón de paño tormentoso',NULL,0),
(10319,'esMX','Patrón: cinta de paño tormentoso',NULL,0),
(10322,'esMX','Patrón: sobrehombros de paño tormentoso',NULL,0),
(10324,'esMX','Patrón: botas de paño tormentoso',NULL,0),
(10460,'esMX','Sangre Hakkari',NULL,0),
(10478,'esMX','Gema de maná de Roland',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(10580,10595,10650,10651,10683,10719,10723,10757,11079,11085,11099,11115,11171,11198,11199,11200,11201,11228,11321,11473) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(10580,'esMX','Caja goblin "Bum"',NULL,0),
(10595,'esMX','Basura de Kum''isha','Invalid loot table, crashes when you modify Miscellaneous',0),
(10650,'esMX','Melena de jabaespín infestada de peste',NULL,0),
(10651,'esMX','Cristal de enfoque Arcano rajado',NULL,0),
(10683,'esMX','Morral de expedicionario',NULL,0),
(10719,'esMX','Alarma móvil',NULL,0),
(10723,'esMX','Radio gnómica',NULL,0),
(10757,'esMX','Resguardo del Rapiñador','El amuleto completo de Rakh''likh.',0),
(11079,'esMX','Cabeza cortada de Gor''tesh','La cabeza cortada de Gor''tesh, pinchada en un pica.',0),
(11085,'esMX','Llave del arca del cliente del mes',NULL,0),
(11099,'esMX','Mena de hierro negro vieja',NULL,0),
(11115,'esMX','Llave de caja fuerte secreta',NULL,0),
(11171,'esMX','Hierro vil',NULL,0),
(11198,'esMX','Runa de escape','Grabado en oro: Forjaz',0),
(11199,'esMX','Escudo de ingeniero 1',NULL,0),
(11200,'esMX','Escudo de ingeniero 2',NULL,0),
(11201,'esMX','Escudo de ingeniero 3',NULL,0),
(11228,'esMX','Muda de piel de Vuelo demente','Un parche gris pálido de piel de dragón Negro.',0),
(11321,'esMX','Monster - Sword2H, Horde Massive Red',NULL,0),
(11473,'esMX','PX83-Enigmatrón',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(12143,12144,12211,12369,12452,12585,12762,12763,12778,12789,12805,12816,12817,12818,12826,12831,12832,12866,12947,13092) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(12143,'esMX','Llave de espinazo de dragón',NULL,0),
(12144,'esMX','Ovosciloscopio',NULL,0),
(12211,'esMX','Costillas de lobo especiadas',NULL,0),
(12369,'esMX','Cetro de Vectus',NULL,0),
(12452,'esMX','Monstruo: escudo, Horda A02 Acero',NULL,0),
(12585,'esMX','Medallón de Ventormenta',NULL,0),
(12762,'esMX','Secreto de diseños',NULL,0),
(12763,'esMX','Fruta de éter de Un''Goro',NULL,0),
(12778,'esMX','Cofre de documentos',NULL,0),
(12789,'esMX','QAprueba beneficios de banda nv. 60',NULL,0),
(12805,'esMX','Orbe de Fuego',NULL,0),
(12816,'esMX','Diseño: espada magna de torio',NULL,0),
(12817,'esMX','Diseño: Talladora de Picomadera',NULL,0),
(12818,'esMX','Diseño: martillo de torio taraceado',NULL,0),
(12826,'esMX','Diseño: filo rúnico',NULL,0),
(12831,'esMX','Diseño: garfa sangrienta',NULL,0),
(12832,'esMX','Diseño: Lanza Negra',NULL,0),
(12866,'esMX','Monster - Item, Book - B02 Black Glowing',NULL,0),
(12947,'esMX','Anillo de Audacia de Alex','Looks great. Less filling.',0),
(13092,'esMX','Deprecated Dragonstalker Tunic',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(13149,13151,13152,13153,13154,13223,13302,13303,13304,13305,13306,13307,13330,13337,13342,13343,13500,13602,13603,13699) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13149,'esMX','Escrito sobre Invocación de Eldarath Vol. 1',NULL,0),
(13151,'esMX','Los estudios místicos de Hor''ank',NULL,0),
(13152,'esMX','la historia sin conclusión',NULL,0),
(13153,'esMX','Escrito de Mal''cin Vorail',NULL,0),
(13154,'esMX','Estudios de Jael''marin de lo Arcano',NULL,0),
(13223,'esMX','Faltriquera de mensajero de Stratholme',NULL,0),
(13302,'esMX','Llave del buzón de la Fila del Mercado',NULL,0),
(13303,'esMX','Llave del buzón de la Plaza de los Cruzados',NULL,0),
(13304,'esMX','Llave del buzón de la calle del festival',NULL,0),
(13305,'esMX','Llave del buzón de la plaza de los Ancianos',NULL,0),
(13306,'esMX','Llave del buzón de la Plaza del Rey',NULL,0),
(13307,'esMX','Llave del buzón de Ezra Grimm',NULL,0),
(13330,'esMX','Bolsa de rábano de Derek','Derek guarda a todos sus amigos rábanos aquí.',0),
(13337,'esMX','Monster - Staff, Feathered Gold',NULL,0),
(13342,'esMX','Pez mascota',NULL,0),
(13343,'esMX','Piedra mascota',NULL,0),
(13500,'esMX','Receta: poción de Protección contra lo Sagrado superior',NULL,0),
(13602,'esMX','Piedra de hechizo superior (DEPRECATED)',NULL,0),
(13603,'esMX','Piedra de hechizo sublime (DEPRECATED)',NULL,0),
(13699,'esMX','Piedra de fuego (DEPRECATED)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(13700,13701,13811,13812,13842,13843,13844,13845,13846,13847,13848,13849,13936,14062,14100,14104,14382,14383,14384,14385) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13700,'esMX','Piedra de fuego superior (DEPRECATED)',NULL,0),
(13701,'esMX','Piedra de fuego sublime (DEPRECATED)',NULL,0),
(13811,'esMX','Collar del Alba',NULL,0),
(13812,'esMX','Anillo del Alba',NULL,0),
(13842,'esMX','Mañana de otoño/invierno',NULL,0),
(13843,'esMX','Tarde de otoño/invierno',NULL,0),
(13844,'esMX','Tarde noche de otoño/invierno',NULL,0),
(13845,'esMX','Noche de otoño/invierno',NULL,0),
(13846,'esMX','Mañana de primavera/verano',NULL,0),
(13847,'esMX','Mediodía de primavera/verano',NULL,0),
(13848,'esMX','Tarde de primavera/verano',NULL,0),
(13849,'esMX','Noche de primavera/verano',NULL,0),
(13936,'esMX','Deprecated Dreadmaster''s Shroud',NULL,0),
(14062,'esMX','Montura de kodo',NULL,0),
(14100,'esMX','Toga de paño brillante',NULL,0),
(14104,'esMX','Pantalones de paño brillante',NULL,0),
(14382,'esMX','Pechera Durabilidad',NULL,0),
(14383,'esMX','Brazales Durabilidad',NULL,0),
(14384,'esMX','Botas Durabilidad',NULL,0),
(14385,'esMX','Capa Durabilidad',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(14386,14387,14388,14389,14391,14393,14394,15054,15068,15069,15070,15071,15072,15074,15075,15446,15586,15688,16057,16073) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(14386,'esMX','Sombrero Durabilidad',NULL,0),
(14387,'esMX','Guantes Durabilidad',NULL,0),
(14388,'esMX','Leotardos Durabilidad',NULL,0),
(14389,'esMX','Hombreras Durabilidad',NULL,0),
(14391,'esMX','Espada Durabilidad',NULL,0),
(14393,'esMX','Escudo Durabilidad',NULL,0),
(14394,'esMX','Arco Durabilidad',NULL,0),
(15054,'esMX','Leotardos volcánicos',NULL,0),
(15068,'esMX','Guerrera de sable de hielo',NULL,0),
(15069,'esMX','Leotardos de sable de hielo',NULL,0),
(15070,'esMX','Guantes de sable de hielo',NULL,0),
(15071,'esMX','Botas de sable de hielo',NULL,0),
(15072,'esMX','Leotardos quiméricos',NULL,0),
(15074,'esMX','Guantes quiméricos',NULL,0),
(15075,'esMX','Jubón quimérico',NULL,0),
(15446,'esMX','Juego de diputado de Ventormenta',NULL,0),
(15586,'esMX','Flor de rápido crecimiento',NULL,0),
(15688,'esMX','Judías mágicas',NULL,0),
(16057,'esMX','Morral de expedicionario',NULL,0),
(16073,'esMX','Libro de cocina de artesano',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(16085,16191,16308,16338,16339,16343,16344,17000,17108,17115,17116,17199,17242,17262,17323,17325,17347,17354,17362,17363) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(16085,'esMX','Artesano de primeros auxilios: Cúrate tú mismo','Te enseña primeros auxilios avanzados con un máximo de 300 de habilidad.',0),
(16191,'esMX','Espejo ornamentado',NULL,0),
(16308,'esMX','Palanqueta de Crestanorte',NULL,0),
(16338,'esMX','Corcel de Teniente caballero',NULL,0),
(16339,'esMX','Corcel de Comandante',NULL,0),
(16343,'esMX','Montura de Guardia de sangre',NULL,0),
(16344,'esMX','zzUNUSEDMontura General',NULL,0),
(17000,'esMX','Sortija de la Aparición',NULL,0),
(17108,'esMX','Marca de Desvío',NULL,0),
(17115,'esMX','Muestra de ardilla','Valor es diez piezas de plata...',0),
(17116,'esMX','Muestra de ardilla','Valor es veinte piezas de plata...',0),
(17199,'esMX','Ponche de huevo estropeado',NULL,0),
(17242,'esMX','Llave del cofre de Salem','Abre el cofre del clérigo oscuro Salem',0),
(17262,'esMX','Llave de James','Abre el cofre robado de la Catedral de la Luz',0),
(17323,'esMX','Señal de Mulverick',NULL,0),
(17325,'esMX','Señal de Jeztor',NULL,0),
(17347,'esMX','Controlador de miembros de la Hermandad (MURP)',NULL,0),
(17354,'esMX','El ojo que todo lo ve del maestro Ryson',NULL,0),
(17362,'esMX','Señal de Ryson',NULL,0),
(17363,'esMX','Señal de Ryson',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(17384,17409,17410,17505,17506,17731,17782,17783,17967,18002,18023,18154,18155,18156,18157,18158,18159,18209,18235,18266) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(17384,'esMX','Unidad trituradora portátil de Zinfizzlex',NULL,0),
(17409,'esMX','Trozo de cristal taraceado',NULL,0),
(17410,'esMX','Unidad trituradora portátil de Zinfizzlex',NULL,0),
(17505,'esMX','Señal de Ichman',NULL,0),
(17506,'esMX','Señal de Vipore',NULL,0),
(17731,'esMX','Pergamino de Celebras',NULL,0),
(17782,'esMX','Fragmento de dije de vínculo',NULL,0),
(17783,'esMX','Trozo de dije de vínculo',NULL,0),
(17967,'esMX','Escama de Onyxia refinada',NULL,0),
(18002,'esMX','Monster - Axe, 2H Horde Massive Spiked Blue',NULL,0),
(18023,'esMX','Colgante de rubí de sangre',NULL,0),
(18154,'esMX','Papel y sobres para cartas de Blizzard',NULL,0),
(18155,'esMX','Gema Moro''gan azul',NULL,0),
(18156,'esMX','Gema moro''gan verde',NULL,0),
(18157,'esMX','Gema Moro''gan negra',NULL,0),
(18158,'esMX','Gema Moro''gan de oro',NULL,0),
(18159,'esMX','Gema Moro''gan blanca',NULL,0),
(18209,'esMX','Bujía energizada',NULL,0),
(18235,'esMX','Esquema: robot de reparación de campo 74A',NULL,0),
(18266,'esMX','Llave de patio de Gordok',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(18268,18316,18355,18438,18593,18595,18627,18630,18747,18942,18963,18964,18965,18966,18967,19322,19482,19804,19989,20024) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(18268,'esMX','Llave de puerta interior de Gordok',NULL,0),
(18316,'esMX','Adorno de obsidiana',NULL,0),
(18355,'esMX','Collera de Ferra',NULL,0),
(18438,'esMX','Marca de Sargento',NULL,0),
(18593,'esMX',NULL,'Delimitado con alambre de Hierro Negro',0),
(18595,'esMX','Ópalo de sangre',NULL,0),
(18627,'esMX','Gong de Dethmoora',NULL,0),
(18630,'esMX','Llama del día del Juicio Final',NULL,0),
(18747,'esMX','Prueba de propiedades de objeto',NULL,0),
(18942,'esMX','Flujo ígneo',NULL,0),
(18963,'esMX','Huevo de tortuga (albino)',NULL,0),
(18964,'esMX','Huevo de tortuga (leñobeza)','Te enseña a invocar este compañero.',0),
(18965,'esMX','Huevo de tortuga (alconil)',NULL,0),
(18966,'esMX','Huevo de tortuga (cuerospalda)',NULL,0),
(18967,'esMX','Huevo de tortuga (oliva)',NULL,0),
(19322,'esMX',NULL,'Prueba de victoria en la Garganta Grito de Guerra.',0),
(19482,'esMX','Pelambre de conejo L''Artesano',NULL,0),
(19804,'esMX','Pez demonio pálido',NULL,0),
(19989,'esMX','Escrito sobre Sombras devoradoras','Es mejor no desvelar algunos secretos.',0),
(20024,'esMX','Conducto de bilis putrefacto',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20026,20084,20221,20337,20364,20367,20423,20446,20460,20473,20485,20489,20525,20583,20584,20585,20586,20587,20588,20589) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20026,'esMX','Carne en descomposición',NULL,0),
(20084,'esMX','Red de caza',NULL,0),
(20221,'esMX','Corcel fabuloso','Invoca y retira a un draco cromático que se puede montar. Es una montura muy veloz. ¡Más querrías! (3 Seg Reutilización)',0),
(20337,'esMX','Cabeza de gnomo en un palo',NULL,0),
(20364,'esMX','Test Ammo Arcón',NULL,0),
(20367,'esMX','Equipo de caza','Una buena caja de herramientas.',0),
(20423,'esMX','Garra de escórpido arenoso',NULL,0),
(20446,'esMX','Test anillo de defensa +140',NULL,0),
(20460,'esMX','Carta perdida de Brann Barbabronce',NULL,0),
(20473,'esMX','El Compendio del Arcanista, volumen 4',NULL,0),
(20485,'esMX','Sello del duque',NULL,0),
(20489,'esMX','Corona del Consejo',NULL,0),
(20525,'esMX','Sigilo terráneo',NULL,0),
(20583,'esMX','Máscara de enana robusta',NULL,0),
(20584,'esMX','Máscara de gnomo hembra robusta',NULL,0),
(20585,'esMX','Máscara de mujer robusta',NULL,0),
(20586,'esMX','Máscara de elfa de la noche robusta',NULL,0),
(20587,'esMX','Máscara de orco hembra robusta',NULL,0),
(20588,'esMX','Máscara de tauren hembra robusta',NULL,0),
(20589,'esMX','Máscara de trol hembra robusta',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20590,20591,20592,20593,20594,20595,20596,20597,20598,20609,20737,20762,20773,20774,20775,20776,20777,20778,20779,20780) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20590,'esMX','Máscara de no-muerta robusta',NULL,0),
(20591,'esMX','Máscara de enano robusta',NULL,0),
(20592,'esMX','Máscara de gnomo robusta',NULL,0),
(20593,'esMX','Máscara de hombre robusta',NULL,0),
(20594,'esMX','Máscara de elfo de la noche robusta',NULL,0),
(20595,'esMX','Máscara de orco robusta',NULL,0),
(20596,'esMX','Máscara de tauren robusta',NULL,0),
(20597,'esMX','Máscara de trol robusta',NULL,0),
(20598,'esMX','Máscara de no-muerto robusta',NULL,0),
(20609,'esMX','Plumas vudú',NULL,0),
(20737,'esMX','Piedra nuclearia chamuscada',NULL,0),
(20762,'esMX','DEPRECATED: Esencia cristalizada',NULL,0),
(20773,'esMX','63 almófar de chamán verde',NULL,0),
(20774,'esMX','63 espaldares de chamán verdes',NULL,0),
(20775,'esMX','63 jubón de chamán verde',NULL,0),
(20776,'esMX','63 ataduras de chamán verdes',NULL,0),
(20777,'esMX','63 guanteletes de chamán verdes',NULL,0),
(20778,'esMX','63 cordón de chamán verde',NULL,0),
(20779,'esMX','63 falda de chamán verde',NULL,0),
(20780,'esMX','63 botas de chamán verdes',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20781,20782,20783,20784,20785,20786,20787,20788,20789,20790,20791,20792,20793,20794,20795,20796,20798,20814,20819,20822) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20781,'esMX','63 gola de chamán verde',NULL,0),
(20782,'esMX','63 espalda de chamán verde',NULL,0),
(20783,'esMX','63 anillo de chamán verde',NULL,0),
(20784,'esMX','63 arma de chamán verde',NULL,0),
(20785,'esMX','90 espalda de chamán verde',NULL,0),
(20786,'esMX','90 ataduras de chamán verdes',NULL,0),
(20787,'esMX','90 botas de chamán verdes',NULL,0),
(20788,'esMX','90 almófar de chamán verde',NULL,0),
(20789,'esMX','90 cordón de chamán verde',NULL,0),
(20790,'esMX','90 guanteletes de chamán verdes',NULL,0),
(20791,'esMX','90 falda de chamán verde',NULL,0),
(20792,'esMX','90 gola verde de chamán',NULL,0),
(20793,'esMX','90 espaldares de chamán verde',NULL,0),
(20794,'esMX','90 anillo de chamán verde',NULL,0),
(20795,'esMX','90 jubón de chamán verde',NULL,0),
(20796,'esMX','90 arma de chamán verde',NULL,0),
(20798,'esMX','Convertidor Arcano intacto',NULL,0),
(20814,'esMX','Daga arrojadiza del maestro rota',NULL,0),
(20819,'esMX','Malaquita tallada',NULL,0),
(20822,'esMX','Ojo de tigre tallado',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20825,20829,20834,20883,20908,20936,20937,20946,20952,20953,20956,20962,20965,20972,21026,21034,21035,21036,21044,21045) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20825,'esMX','Gema de las Sombras tallada',NULL,0),
(20829,'esMX','Piedra lunar tallada',NULL,0),
(20834,'esMX','Catalejo XT ornamentado',NULL,0),
(20883,'esMX','Joya qiraji con inscripciones',NULL,0),
(20908,'esMX','Fuegos artificiales del Festival de Nian',NULL,0),
(20936,'esMX','Joya qiraji bendita',NULL,0),
(20937,'esMX','Joya qiraji encerrada',NULL,0),
(20946,'esMX','Instrucciones de la misión táctica III',NULL,0),
(20952,'esMX','Ágata tallada',NULL,0),
(20953,'esMX','Jade tallado',NULL,0),
(20956,'esMX','Colgante rosa de plata',NULL,0),
(20962,'esMX','Aguamarina tallada',NULL,0),
(20965,'esMX','Rubí tallado',NULL,0),
(20972,'esMX','Boceto: colgante rosa de plata',NULL,0),
(21026,'esMX','Esfera de oráculo',NULL,0),
(21034,'esMX','3300 Test Hacha 2M 60 blanca',NULL,0),
(21035,'esMX','1700 Test Daga 60 blanca',NULL,0),
(21036,'esMX','2800 test arco',NULL,0),
(21044,'esMX','Riendas de reno (TEST)',NULL,0),
(21045,'esMX','63 Cinturón azul de fuego',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(21046,21047,21048,21049,21050,21051,21052,21053,21054,21055,21056,21057,21058,21059,21060,21061,21062,21063,21064,21065) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(21046,'esMX','63 Ataduras azules de fuego',NULL,0),
(21047,'esMX','63 Botas azules de fuegos',NULL,0),
(21048,'esMX','63 Corona azul de fuego',NULL,0),
(21049,'esMX','63 Guantes azules de fuego',NULL,0),
(21050,'esMX','63 Leotardos azules de fuego',NULL,0),
(21051,'esMX','63 Manto azul de fuego',NULL,0),
(21052,'esMX','63 Gola azul de fuego',NULL,0),
(21053,'esMX','63 Anillo azul de fuego',NULL,0),
(21054,'esMX','63 Toga azul de fuego',NULL,0),
(21055,'esMX','63 Embozo azul de fuego',NULL,0),
(21056,'esMX','63 Bastón azul de fuego',NULL,0),
(21057,'esMX','63 Varita azul de fuego',NULL,0),
(21058,'esMX','66 Cinturón épico de fuego',NULL,0),
(21059,'esMX','66 Ataduras épicas de fuego',NULL,0),
(21060,'esMX','66 Botas épicas de fuego',NULL,0),
(21061,'esMX','66 Corona épica de fuego',NULL,0),
(21062,'esMX','66 Guantes épicos de fuego',NULL,0),
(21063,'esMX','66 Leotardos épicos de fuego',NULL,0),
(21064,'esMX','66 Manto épico de fuego',NULL,0),
(21065,'esMX','66 Gola épica de fuego',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(21066,21067,21068,21069,21070,21073,21074,21075,21076,21077,21078,21079,21080,21081,21082,21083,21084,21085,21086,21087) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(21066,'esMX','66 Anillo épico de fuego',NULL,0),
(21067,'esMX','66 Togas épicas de fuego',NULL,0),
(21068,'esMX','66 Embozo épico de fuego',NULL,0),
(21069,'esMX','66 Bastón épico de fuego',NULL,0),
(21070,'esMX','66 Varita épica de fuego',NULL,0),
(21073,'esMX','63 Cinturón azul de sombra',NULL,0),
(21074,'esMX','63 Ataduras azules de sombra',NULL,0),
(21075,'esMX','63 Botas azules de sombra',NULL,0),
(21076,'esMX','63 Corona azul de sombra',NULL,0),
(21077,'esMX','63 Guantes azules de sombra',NULL,0),
(21078,'esMX','63 Leotardos azules de sombra',NULL,0),
(21079,'esMX','63 Manto azul de sombra',NULL,0),
(21080,'esMX','63 Gola azul de sombra',NULL,0),
(21081,'esMX','63 Anillo azul de sombra',NULL,0),
(21082,'esMX','63 Toga azul de sombra',NULL,0),
(21083,'esMX','63 Embozo azul de sombra',NULL,0),
(21084,'esMX','63 Bastón azul de sombra',NULL,0),
(21085,'esMX','63 Varita azul de sombra',NULL,0),
(21086,'esMX','66 Cinturón épico de sombra',NULL,0),
(21087,'esMX','66 Ataduras épicas de sombra',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(21088,21089,21090,21091,21092,21093,21094,21095,21096,21097,21098,21135,21163,21173,21193,21194,21195,21236,21240,21246) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(21088,'esMX','66 Botas épicas de sombra',NULL,0),
(21089,'esMX','66 Corona épica de sombra',NULL,0),
(21090,'esMX','66 Guantes épicos de sombra',NULL,0),
(21091,'esMX','66 Leotardos épicos de sombra',NULL,0),
(21092,'esMX','66 Manto épico de sombra',NULL,0),
(21093,'esMX','66 Gola épica de sombra',NULL,0),
(21094,'esMX','66 Anillo épico de sombra',NULL,0),
(21095,'esMX','66 Toga épica de sombra',NULL,0),
(21096,'esMX','66 Embozo épico de sombra',NULL,0),
(21097,'esMX','66 Bastón épico de sombra',NULL,0),
(21098,'esMX','66 Varita épica de sombra',NULL,0),
(21135,'esMX','Hacha arrojadiza de asesino rota',NULL,0),
(21163,'esMX','Pargo de fuego hinchado',NULL,0),
(21173,'esMX','Jarra festiva vacía',NULL,0),
(21193,'esMX','Saco de El''saco',NULL,0),
(21194,'esMX','Saco grande de El''saco',NULL,0),
(21195,'esMX','Sactástico de El''saco',NULL,0),
(21236,'esMX','Pan del Festival de Invierno',NULL,0),
(21240,'esMX','Dulce de Festival de Invierno',NULL,0),
(21246,'esMX','Informe de tareas de combate I',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(21247,21276,21313,21369,21550,21575,21580,21691,21717,21719,21720,21736,21739,21761,21762,21772,21773,21785,21786,21793) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(21247,'esMX','Informe de tareas de combate II',NULL,0),
(21276,'esMX',NULL,'Esta arma está infundida y reforzada con elementium.',0),
(21313,'esMX','Bolsa pequeña de El''saco',NULL,0),
(21369,'esMX','Patrón: bolsa de tela vil',NULL,0),
(21550,'esMX','Monstruo: ballesta, Hakkari',NULL,0),
(21575,'esMX','Traca de cohetes morados',NULL,0),
(21580,'esMX','Monster - Axe, 2H Horde PvP',NULL,0),
(21691,'esMX','Guanteletes de moco',NULL,0),
(21717,'esMX','Traca de cohetes morados grandes',NULL,0),
(21719,'esMX','Traca de cohetes blancos grandes',NULL,0),
(21720,'esMX','Traca de cohetes amarillos grandes',NULL,0),
(21736,'esMX','Riendas de grifo de montar',NULL,0),
(21739,'esMX','Invitación al Festival Lunar DEBUG',NULL,0),
(21761,'esMX','Llave del arca del Escarabajo',NULL,0),
(21762,'esMX','Llave del arca del Escarabajo superior',NULL,0),
(21772,'esMX','Zafiro tallado',NULL,0),
(21773,'esMX','Ópalo tallado',NULL,0),
(21785,'esMX','Esmeralda tallada',NULL,0),
(21786,'esMX','Diamante de Azeroth tallado',NULL,0),
(21793,'esMX','Colgante de espada de arcanita',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(21878,21879,21880,21883,21924,21950,21951,21958,21959,22026,22058,22095,22096,22097,22098,22099,22100,22101,22102,22128) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(21878,'esMX','zzDEPRECATED Spellthread',NULL,0),
(21879,'esMX','Cristal draenetista cargado',NULL,0),
(21880,'esMX','Cristal draenetista perfecto',NULL,0),
(21883,'esMX','Tela vil de ébano',NULL,0),
(21924,'esMX','Patrón: toga de paño rúnico',NULL,0),
(21950,'esMX','Boceto: esmeralda tallada - deprecated',NULL,0),
(21951,'esMX','Boceto: diamante de Azeroth tallado',NULL,0),
(21958,'esMX','Boceto: colgante de espada de arcanita',NULL,0),
(21959,'esMX','Boceto: corona de sangre',NULL,0),
(22026,'esMX','QAE Test Item Update',NULL,0),
(22058,'esMX','Papel y sobres para cartas de San Valentín',NULL,0),
(22095,'esMX','Ataduras de los Cinco Truenos',NULL,0),
(22096,'esMX','Botas de los Cinco Truenos',NULL,0),
(22097,'esMX','Almófar de los Cinco Truenos',NULL,0),
(22098,'esMX','Cordón de los Cinco Truenos',NULL,0),
(22099,'esMX','Guanteletes de los Cinco truenos',NULL,0),
(22100,'esMX','Falda de los Cinco Truenos',NULL,0),
(22101,'esMX','Espaldares de los Cinco Truenos',NULL,0),
(22102,'esMX','Jubón de los Cinco Truenos',NULL,0),
(22128,'esMX','Piedra de fuego maestra (DEPRECATED)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(22130,22151,22152,22233,22258,22415,22474,22475,22546,22564,22569,22581,22582,22619,22625,22626,22646,22684,22685,22686) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(22130,'esMX','Símbolo de Amor',NULL,0),
(22151,'esMX','Agua bendita de Anthion',NULL,0),
(22152,'esMX','Faltriquera de Anthion',NULL,0),
(22233,'esMX','Baúl de Zigris',NULL,0),
(22258,'esMX','Poción de amor',NULL,0),
(22415,'esMX','Pluma de dracohalcón',NULL,0),
(22474,'esMX','Distintivo de aprendiz de Meledor',NULL,0),
(22475,'esMX','Distintivo de aprendiz de Ralen',NULL,0),
(22546,'esMX','Fórmula: encantar pechera: maná excepcional DEPRECATED',NULL,0),
(22564,'esMX','Fórmula: polvo Arcano',NULL,0),
(22569,'esMX','Colmillo de araña intacto',NULL,0),
(22581,'esMX','Instrumentos Arcanos dañados',NULL,0),
(22582,'esMX','Caja de esencias cristalizadas',NULL,0),
(22619,'esMX','Libranza del artesano: poción de Protección contra la Escarcha superior','Lleva el sello de El Alba Argenta.',0),
(22625,'esMX','Libranza del artesano: salmón al horno','Lleva el sello de El Alba Argenta.',0),
(22626,'esMX','Libranza del artesano: sorpresa de tubérculo runtún','Lleva el sello de El Alba Argenta.',0),
(22646,'esMX','Piedra de hechizos maestra (DEPRECATED)',NULL,0),
(22684,'esMX','Patrón: guantes glaciales',NULL,0),
(22685,'esMX','Patrón: capa glacial',NULL,0),
(22686,'esMX','Patrón: jubón glacial',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(22687,22692,22694,22695,22696,22697,22698,22703,22704,22705,22736,22765,22896,22898,22928,22929,22931,22989,23026,23051) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(22687,'esMX','Patrón: muñequeras glaciales',NULL,0),
(22692,'esMX','Patrón: guerrera polar',NULL,0),
(22694,'esMX','Patrón: guantes polares',NULL,0),
(22695,'esMX','Patrón: brazales polares',NULL,0),
(22696,'esMX','Patrón: coraza de escamas heladas',NULL,0),
(22697,'esMX','Patrón: guanteletes de escamas heladas',NULL,0),
(22698,'esMX','Patrón: brazales de escamas heladas',NULL,0),
(22703,'esMX','Diseño: coraza Deliriohelado',NULL,0),
(22704,'esMX','Diseño: guanteletes Deliriohelado',NULL,0),
(22705,'esMX','Diseño: brazales Deliriohelado',NULL,0),
(22736,'esMX','Andonisus, Segador de almas','Esta espada es dimensional. Parece estar desapareciendo de este plano.',0),
(22765,'esMX','Carta enmohecida','Aún se pueden leer unas palabras...',0),
(22896,'esMX','Cristal de sanación',NULL,0),
(22898,'esMX','Cristal consagrado',NULL,0),
(22928,'esMX','Cristal simple',NULL,0),
(22929,'esMX','Cristal glífico',NULL,0),
(22931,'esMX','Cristal hueco',NULL,0),
(22989,'esMX','Amuleto de los elfos de sangre','Apenas alguna salpicadura de sangre.',0),
(23026,'esMX','Cristal de pedido de suministros','El cristal brilla con la lista de suministros de urgencia que contiene.',0),
(23051,'esMX','Monstruo: arco, culebra de asalto ZG',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23052,23158,23159,23162,23163,23164,23172,23174,23175,23176,23212,23213,23216,23222,23223,23225,23230,23231,23232,23233) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23052,'esMX','Monstruo: ballesta, ornamentada',NULL,0),
(23158,'esMX','Aguamarina maciza',NULL,0),
(23159,'esMX','Aguamarina chispeante',NULL,0),
(23162,'esMX','Una bolsa muy grande',NULL,0),
(23163,'esMX','Varita de intérprete',NULL,0),
(23164,'esMX','Bebida espumosa',NULL,0),
(23172,'esMX','Manzana roja refrescante','Un tentempié perfecto para un caluroso día de verano.',0),
(23174,'esMX','Monstruo: daga básica verde',NULL,0),
(23175,'esMX','Golosina de verano rica',NULL,0),
(23176,'esMX','Bebida energética con burbujas',NULL,0),
(23212,'esMX','Jubón de contendiente',NULL,0),
(23213,'esMX','Pantalones de contendiente',NULL,0),
(23216,'esMX','Esencia de abisario palpitante','Rebosante de energía malévola, si te pilla descuidado, es fácil que te corrompa si fijas la mirada en ella.',0),
(23222,'esMX','Pellejo de uñagrieta','Pellejo grueso, pesado y descolorido de un uñagrieta mutante.',0),
(23223,'esMX','Huesos de uñagrieta','Un conjunto de huesos mutantes de un animal que tuvo que ser majestuoso.',0),
(23225,'esMX','Monster - Sword, 1H Blood Elf A02 Red',NULL,0),
(23230,'esMX','Daga de bonanza engarzable',NULL,0),
(23231,'esMX','Tendón de uñagrieta','Marchito y retorcido tendón de una bestia mutante originaria de Terrallende.',0),
(23232,'esMX','Espada enorme de bonanza engarzable',NULL,0),
(23233,'esMX','Brianita roja de fuerza',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23234,23235,23236,23240,23241,23335,23349,23351,23357,23374,23382,23388,23416,23428,23443,23450,23462,23463,23470,23472) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23234,'esMX','Brianita azul de agilidad',NULL,0),
(23235,'esMX','Brianita amarilla de aguante',NULL,0),
(23236,'esMX','Brianita metálica de maná',NULL,0),
(23240,'esMX','Monstruo: bastón, elfo de sangre A01 azul',NULL,0),
(23241,'esMX','Monster - Dagger, Blood Elf A01 Red',NULL,0),
(23335,'esMX','Monstruo: Bastón, (Thiah Redmane)',NULL,0),
(23349,'esMX','Botas desgastadas por la batalla',NULL,0),
(23351,'esMX','Camisa desgastada por la batalla',NULL,0),
(23357,'esMX','Huevo de devastador eclosionado','Ya ha salido un devastador de este huevo.',0),
(23374,'esMX','Sangre de can de distorsión',NULL,0),
(23382,'esMX','Monster - Sword, 1H Blood Elf A01 Gold',NULL,0),
(23388,'esMX','Tabardo de Tranquillien',NULL,0),
(23416,'esMX','Monster - Staff, Gul''dan',NULL,0),
(23428,'esMX','Monstruo: hacha, 1m Grom',NULL,0),
(23443,'esMX','zzOLDTEST Sanctified Crystal','El cristal resplandece con el poder de un hechizo guardado.',0),
(23450,'esMX','Monstruo: daga, Gul''dan',NULL,0),
(23462,'esMX','Escrito sobre destrucción del Gran Señor de la Guerra',NULL,0),
(23463,'esMX','Escrito sobre Alivio del Gran Señor de la Guerra',NULL,0),
(23470,'esMX','Camisa de trampero basta',NULL,0),
(23472,'esMX','Botas de trampero bastas',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23481,23567,23578,23579,23616,23647,23648,23649,23650,23651,23652,23653,23655,23656,23673,23674,23684,23689,23704,23708) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23481,'esMX','Monster - Dagger, Epic Red Tassel',NULL,0),
(23567,'esMX','zzOLD[PH] Silithus PvP Dust [DEP]',NULL,0),
(23578,'esMX','Dieta MacSalsafloja','Alimento para la mente',0),
(23579,'esMX','El clásico MacSalsafloja','El original.',0),
(23616,'esMX','Trozo de cristal triturado','Parece que en otros tiempos tuvo que ser parte de El Exodar.',0),
(23647,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23648,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23649,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23650,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23651,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23652,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23653,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23655,'esMX','Esposas elfas','Un bonito instrumento compacto fruto de la más exquisita artesanía.',0),
(23656,'esMX','Test Elemento de promoción',NULL,0),
(23673,'esMX','Monstruo: espada, sable de luz azul',NULL,0),
(23674,'esMX','Llave de panel de control de Robotrón','Esta extraña llave parece encajar en la ranura de encendido del panel de control que está al lado de Wizlo Rodabrillante.',0),
(23684,'esMX','Crystal Infused Bandage [PH]',NULL,0),
(23689,'esMX','Manual: Crystal Infused Bandage [PH]',NULL,0),
(23704,'esMX','Oporto de Canción Eterna',NULL,0),
(23708,'esMX','Monster - Mace2H, WarA01/B02Silver (1H, Special)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23710,23715,23718,23719,23721,23722,23740,23741,23754,23794,23795,23796,23812,23813,23831,23832,23840,23853,23855,23856) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23710,'esMX','Tabardo de Upperdeck n.º 3',NULL,0),
(23715,'esMX','Cóctel de zumo de pulmón perpetuo','Zumo de pulmón 100% calidad superior: Recién exprimido',0),
(23718,'esMX','Polvo de scorpok machacado permanente',NULL,0),
(23719,'esMX','Compuesto de córtex cerebral permanente','Servir frío.',0),
(23721,'esMX','Chicle permanente de mollejas','Sabe a fresa.',0),
(23722,'esMX','IFRDHR permanente','Infusión funcional robusta derivada de Hiena risitas',0),
(23740,'esMX','Planes supersecretos de Ventura y Cía.','Del escritorio de Mogul Razdunk',0),
(23741,'esMX','Monster - 1H Sword - Widow''s Remore',NULL,0),
(23754,'esMX','Pellejo de uñagrieta lomohirsuto',NULL,0),
(23794,'esMX','Brillo permanente de Zanza','¡Bendecido con el mojo de Zanza!',0),
(23795,'esMX','Espíritu permanente de Zanza','¡Bendecido con el mojo de Zanza!',0),
(23796,'esMX','Presteza permanente de Zanza','¡Bendecido con el mojo de Zanza!',0),
(23812,'esMX','Esquema: bengala de humo rojo',NULL,0),
(23813,'esMX','Esquema: bengala de humo azul',NULL,0),
(23831,'esMX','Controlador de tonque goblin',NULL,0),
(23832,'esMX','Controlador de tonque gnómico',NULL,0),
(23840,'esMX','Terminal portátil de correo',NULL,0),
(23853,'esMX','Carta a <Name>',NULL,0),
(23855,'esMX','Paño de fuego de hechizo',NULL,0),
(23856,'esMX','Monster - Mace2H, Horde Black Spiked Badass Fire',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23861,23872,23889,23895,23904,23905,23906,23907,23908,23911,23912,23914,23916,23917,23918,23940,23941,23942,23943,23950) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23861,'esMX','Material para dibujar','Un sencillo conjunto de dibujo portátil para hacer bocetos o calcar relieves en el exterior.',0),
(23872,'esMX','Cartera azul',NULL,0),
(23889,'esMX','Monstruo: arco, Horda JcJ',NULL,0),
(23895,'esMX','Mercancía envuelta','¡Parece que has encontrado algo!',0),
(23904,'esMX','Hoja destrozada',NULL,0),
(23905,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23906,'esMX','Monster - Mace, Draenei A02 Orange',NULL,0),
(23907,'esMX','Monster - Shield, Draenei A02 Purple',NULL,0),
(23908,'esMX','Monster - Dagger, Blood Elf A01 Blue',NULL,0),
(23911,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23912,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23914,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23916,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23917,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23918,'esMX','Deprecated: Testamento de Keanna',NULL,0),
(23940,'esMX','Colmillo de devastador prístino',NULL,0),
(23941,'esMX','Caparazón de devastador aplastada',NULL,0),
(23942,'esMX','Colmillo de devastador triturado',NULL,0),
(23943,'esMX','Zarpa aplastada de devastador',NULL,0),
(23950,'esMX','Caparazón de devastador dañado',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23951,23953,23954,23955,23957,23958,23959,23960,23961,23962,23966,23967,23968,23969,23970,23971,23972,23973,23974,23975) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23951,'esMX','Colmillo de devastador dañado',NULL,0),
(23953,'esMX','Caparazón de devastador desgastado',NULL,0),
(23954,'esMX','Colmillo de devastador desgastado',NULL,0),
(23955,'esMX','Garra de desvastador desgastada',NULL,0),
(23957,'esMX','Caparazón de devastador deteriorado',NULL,0),
(23958,'esMX','Colmillo de devastador deteriorado',NULL,0),
(23959,'esMX','Garra de devastador deteriorada',NULL,0),
(23960,'esMX','Caparazón de devastador martilleado',NULL,0),
(23961,'esMX','Colmillo de devastador martilleado',NULL,0),
(23962,'esMX','Garra de devastador martilleada',NULL,0),
(23966,'esMX','Caparazón de devastador con imperfecciones',NULL,0),
(23967,'esMX','Colmillo de devastador con imperfecciones',NULL,0),
(23968,'esMX','Garra de devastador con imperfecciones',NULL,0),
(23969,'esMX','Caparazón de devastador imperfecto',NULL,0),
(23970,'esMX','Colmillo de devastador imperfecto',NULL,0),
(23971,'esMX','Garra de desvastador imperfecta',NULL,0),
(23972,'esMX','Caparazón de devastador destrozado',NULL,0),
(23973,'esMX','Colmillo de devastador destrozado',NULL,0),
(23974,'esMX','Garra de devastador destrozada',NULL,0),
(23975,'esMX','Colmillo de devastador dañado',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(23982,23983,23990,23992,23993,23996,23998,24005,24010,24011,24012,24013,24014,24015,24016,24017,24018,24019,24034,24038) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(23982,'esMX','Silbato de Kessel','Solo se puede usar en la Isla Bruma Azur.',0),
(23983,'esMX','Sangre de murciélago de las sombras',NULL,0),
(23990,'esMX','Mapa de estrellas completado',NULL,0),
(23992,'esMX','Pelambre de saurio rota',NULL,0),
(23993,'esMX','Garra de saurio resquebrajada',NULL,0),
(23996,'esMX','Monster - Axe, Malchezzar',NULL,0),
(23998,'esMX','Monster - Staff, Atiesh',NULL,0),
(24005,'esMX','Resguardo de tarjeta múrloc','El resguardo tiene un escudo con una secuencia de letras y números correspondientes a la etiqueta que lleva un múrloc con suerte.',0),
(24010,'esMX','Llave de prisión de Fuego Infernal',NULL,0),
(24011,'esMX','Monster - Mace2H, Draenei A01 Magenta',NULL,0),
(24012,'esMX','Monster - Mace2H, Draenei A01 Gold',NULL,0),
(24013,'esMX','Monster - Mace2H, Draenei A01 Olive',NULL,0),
(24014,'esMX','Monster - Mace2H, Draenei A01 Purple',NULL,0),
(24015,'esMX','Monster - Mace2H, Draenei A01 Silver',NULL,0),
(24016,'esMX','Monstruo: maza 2M, draenei A02 oro',NULL,0),
(24017,'esMX','Monstruo: maza 2M, draenei A02 magenta',NULL,0),
(24018,'esMX','Monstruo: maza 2M, draenei A02 oliva',NULL,0),
(24019,'esMX','Monstruo: maza 2M, draenei A02 plata',NULL,0),
(24034,'esMX','Monster - Sword, 1H Blood Elf A03 Red',NULL,0),
(24038,'esMX','Monster - Shield, Blood Elf A01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(24068,24115,24147,24148,24149,24187,24191,24228,24229,24244,24269,24288,24319,24320,24321,24322,24324,24325,24326,24327) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(24068,'esMX','Residuos Arcanos',NULL,0),
(24115,'esMX','TestProspectIronOre',NULL,0),
(24147,'esMX','Mapa de estrellas sin preparar','Las constelaciones, las órbitas y las eclípticas no están marcadas en este mapa.',0),
(24148,'esMX','Mapa de estrellas parcial','Las constelaciones y las órbitas no están marcadas en este mapa.',0),
(24149,'esMX','Mapa de estrellas sin terminar','Las órbitas no están indicadas en este mapa.',0),
(24187,'esMX','Roca fulgente',NULL,0),
(24191,'esMX','Pequeños fragmentos de gemas',NULL,0),
(24228,'esMX','Las órdenes del Rey del Sol','Esta carta lleva el sello de los elfos de sangre.',0),
(24229,'esMX','UNUSED Translated Sun King''s Command','Esta carta lleva el sello de los elfos de sangre.',0),
(24244,'esMX','Monster - Gun, Draenei A01 Orange',NULL,0),
(24269,'esMX','Red de tejido abisal pesada',NULL,0),
(24288,'esMX','zzDEPRECATED Greater Spellthread',NULL,0),
(24319,'esMX','Monstruo: arco, elfo de sangre B01 azul',NULL,0),
(24320,'esMX','Monster - Axe, 1H Blood Elf A02 Gold',NULL,0),
(24321,'esMX','Monstruo: bastón, elfo de sangre A02 rojo',NULL,0),
(24322,'esMX','Monstruo: escudo, elfo de sangre A02',NULL,0),
(24324,'esMX','Monster - Dagger, Blood Elf A01 Gold',NULL,0),
(24325,'esMX','Monstruo: espada2M, elfo de sangre B02 verde',NULL,0),
(24326,'esMX','Monstruo: arco, elfo de sangre B01 amarillo',NULL,0),
(24327,'esMX','Monstruo: hacha, 1H elfo de sangre A02 morado',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(24328,24329,24331,24332,24333,24369,24409,24410,24418,24420,24491,24495,24512,24515,24518,24524,24525,24527,24528,24529) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(24328,'esMX','Monstruo: escudo, elfo de sangre A03',NULL,0),
(24329,'esMX','Test Robe',NULL,0),
(24331,'esMX','Monstruo: escudo, draenei A02 oro',NULL,0),
(24332,'esMX','Monstruo: maza, draenei A02 azul',NULL,0),
(24333,'esMX','Monstruo: maza, draenei A01 magenta',NULL,0),
(24369,'esMX','Libro de hechizos de Colmillo Torcido',NULL,0),
(24409,'esMX','Monster - Axe, 2H Grom''s',NULL,0),
(24410,'esMX','Aguja alcaudón DEPRECATED',NULL,0),
(24418,'esMX','Monstruo: daga malote Naxx',NULL,0),
(24420,'esMX','Unique Equippable Test Item',NULL,0),
(24491,'esMX','Bola de cañón',NULL,0),
(24495,'esMX','Monstruo: espada2M, legionario guardia vil',NULL,0),
(24512,'esMX','Monster - Axe, 2H Zul''Gurub Red',NULL,0),
(24515,'esMX','Crin sarnosa',NULL,0),
(24518,'esMX','Crin burda',NULL,0),
(24524,'esMX','130 Hacha de guerrero épica',NULL,0),
(24525,'esMX','zzold',NULL,0),
(24527,'esMX','130 Coraza de guerrero épica',NULL,0),
(24528,'esMX','130 Capa de guerrero épica',NULL,0),
(24529,'esMX','130 Guanteletes de guerrero épicos',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(24530,24531,24532,24533,24534,24535,24536,24537,24541,24548,24562,24563,24564,24565,24566,24568,24569,24570,24571,24572) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(24530,'esMX','130 Arma de fuego de guerrero épica',NULL,0),
(24531,'esMX','130 Yelmo épico de guerrero',NULL,0),
(24532,'esMX','130 Quijotes de guerrero',NULL,0),
(24533,'esMX','130 Gola de guerrero épica',NULL,0),
(24534,'esMX','130 Espaldares de guerrero épicos',NULL,0),
(24535,'esMX','130 Anillo de guerrero épico',NULL,0),
(24536,'esMX','130 Escarpes de guerrero épicos',NULL,0),
(24537,'esMX','130 Pretina de guerrero épica',NULL,0),
(24541,'esMX','Musgo de pantano medicinal',NULL,0),
(24548,'esMX','zzOLDbrokenitem',NULL,0),
(24562,'esMX','130 Test Caster Shoulder',NULL,0),
(24563,'esMX','130 Test Caster Helm',NULL,0),
(24564,'esMX','130 Test Caster Robe',NULL,0),
(24565,'esMX','130 Test Caster Boots',NULL,0),
(24566,'esMX','130 Test Caster Gloves',NULL,0),
(24568,'esMX','130 Test Anillo de taumaturgo',NULL,0),
(24569,'esMX','130 Test Caster Wand',NULL,0),
(24570,'esMX','130 Test Caster Staff',NULL,0),
(24571,'esMX','130 Test Caster Neck',NULL,0),
(24572,'esMX','130 Test Caster Bracer',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(25493,25497,25520,25546,25547,25551,25571,25572,25587,25588,25625,25626,25646,25663,25664,25665,25684,25688,25698,25706) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(25493,'esMX','QR 9447 2H Axe',NULL,0),
(25497,'esMX','Puntilla de piedra equilibrada rota',NULL,0),
(25520,'esMX','Monster - Polearm, Lantresor',NULL,0),
(25546,'esMX','QR XXXX Paladin Chest',NULL,0),
(25547,'esMX','QR XXXX Druid Shoulders',NULL,0),
(25551,'esMX','QR XXXX Hunter Legs',NULL,0),
(25571,'esMX','QR 9863 Druid Helm',NULL,0),
(25572,'esMX','QR 9863 Shaman Legs',NULL,0),
(25587,'esMX','Monster - Item, Broom (On Fire)',NULL,0),
(25588,'esMX','Monster - Mace2H, Totem (Zorbo)',NULL,0),
(25625,'esMX','QR 9922 Feral Druid Staff',NULL,0),
(25626,'esMX','QR 9922 Paladin Bracer',NULL,0),
(25646,'esMX','Monster - Item, Rolling Pin (Mace)',NULL,0),
(25663,'esMX','Monster - Mace, Good Wooden Hammer, On Fire',NULL,0),
(25664,'esMX','Campana de Crappy',NULL,0),
(25665,'esMX','Broken Test Throwing Axe',NULL,0),
(25684,'esMX','Dije de Kokorek',NULL,0),
(25688,'esMX','Monster - Sword2H, Draenei A02 Orange',NULL,0),
(25698,'esMX','Monster - Staff, Green Feathered - Green Glow',NULL,0),
(25706,'esMX','Órdenes de Luanga','Un documento impreso con caracteres angulosos y nítidos. El propio escrito parece contener ira en ebullición.',0);

DELETE FROM `item_template_locale` WHERE `ID` IN(25752,25753,25758,25798,25799,25800,25801,25816,25839,25840,25859,25860,25871,25879,25884,25888,26003,26056,26057,26058) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(25752,'esMX','(Deprecated)Mana Bomb Schematics',NULL,0),
(25753,'esMX','(Deprecated)Mana Bomb Schematics',NULL,0),
(25758,'esMX','Monster - Polearm, Blood Elf D01',NULL,0),
(25798,'esMX','130 Epic Warrior Trinket',NULL,0),
(25799,'esMX','130 Epic Warrior 1H Axe',NULL,0),
(25800,'esMX','130 Test Caster Legs',NULL,0),
(25801,'esMX','130 Test Caster Trinket',NULL,0),
(25816,'esMX','Monster - Sword, Legion (2H as 1H)',NULL,0),
(25839,'esMX','Monster - Staff, Basic Blue',NULL,0),
(25840,'esMX','Extracto del más allá',NULL,0),
(25859,'esMX','Monster - Axe (No Visual)',NULL,0),
(25860,'esMX','Monster - Sword (No Visual)',NULL,0),
(25871,'esMX','Arma arrojadiza estándar',NULL,0),
(25879,'esMX','Monstruo: espada 2M, caminante de fatalidad',NULL,0),
(25884,'esMX','Estatua de piedra primigenia',NULL,0),
(25888,'esMX','Boceto: estatua de piedra primigenia',NULL,0),
(26003,'esMX','Monster - Sword2H, Blood Elf B02',NULL,0),
(26056,'esMX','59 TEST Green Cloth Belt',NULL,0),
(26057,'esMX','59 TEST Green Cloth Boot',NULL,0),
(26058,'esMX','59 TEST Green Cloth Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26059,26060,26061,26062,26063,26064,26065,26066,26067,26068,26069,26070,26071,26072,26073,26074,26075,26076,26077,26078) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26059,'esMX','59 TEST Green Cloth Hand',NULL,0),
(26060,'esMX','59 TEST Green Cloth Head',NULL,0),
(26061,'esMX','59 TEST Green Cloth Legs',NULL,0),
(26062,'esMX','59 TEST Green Cloth Shoulder',NULL,0),
(26063,'esMX','59 TEST Green Cloth Wrist',NULL,0),
(26064,'esMX','60 TEST Green Cloth Belt',NULL,0),
(26065,'esMX','60 TEST Green Cloth Boot',NULL,0),
(26066,'esMX','60 TEST Green Cloth Chest',NULL,0),
(26067,'esMX','60 TEST Green Cloth Hand',NULL,0),
(26068,'esMX','60 TEST Green Cloth Head',NULL,0),
(26069,'esMX','60 TEST Green Cloth Legs',NULL,0),
(26070,'esMX','60 TEST Green Cloth Shoulder',NULL,0),
(26071,'esMX','60 TEST Green Cloth Wrist',NULL,0),
(26072,'esMX','61 TEST Green Cloth Belt',NULL,0),
(26073,'esMX','61 TEST Green Cloth Boot',NULL,0),
(26074,'esMX','61 TEST Green Cloth Chest',NULL,0),
(26075,'esMX','61 TEST Green Cloth Hand',NULL,0),
(26076,'esMX','61 TEST Green Cloth Head',NULL,0),
(26077,'esMX','61 TEST Green Cloth Legs',NULL,0),
(26078,'esMX','61 TEST Green Cloth Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26079,26080,26081,26082,26083,26084,26085,26086,26087,26088,26089,26090,26091,26092,26093,26094,26095,26096,26097,26098) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26079,'esMX','61 TEST Green Cloth Wrist',NULL,0),
(26080,'esMX','62 TEST Green Cloth Belt',NULL,0),
(26081,'esMX','62 TEST Green Cloth Boot',NULL,0),
(26082,'esMX','62 TEST Green Cloth Chest',NULL,0),
(26083,'esMX','62 TEST Green Cloth Hand',NULL,0),
(26084,'esMX','62 TEST Green Cloth Head',NULL,0),
(26085,'esMX','62 TEST Green Cloth Legs',NULL,0),
(26086,'esMX','62 TEST Green Cloth Shoulder',NULL,0),
(26087,'esMX','62 TEST Green Cloth Wrist',NULL,0),
(26088,'esMX','63 TEST Green Cloth Belt',NULL,0),
(26089,'esMX','63 TEST Green Cloth Boot',NULL,0),
(26090,'esMX','63 TEST Green Cloth Chest',NULL,0),
(26091,'esMX','63 TEST Green Cloth Hand',NULL,0),
(26092,'esMX','63 TEST Green Cloth Head',NULL,0),
(26093,'esMX','63 TEST Green Cloth Legs',NULL,0),
(26094,'esMX','63 TEST Green Cloth Shoulder',NULL,0),
(26095,'esMX','63 TEST Green Cloth Wrist',NULL,0),
(26096,'esMX','64 TEST Green Cloth Belt',NULL,0),
(26097,'esMX','64 TEST Green Cloth Boot',NULL,0),
(26098,'esMX','64 TEST Green Cloth Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26099,26100,26101,26102,26103,26104,26105,26106,26107,26108,26109,26110,26111,26112,26113,26114,26115,26116,26117,26118) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26099,'esMX','64 TEST Green Cloth Hand',NULL,0),
(26100,'esMX','64 TEST Green Cloth Head',NULL,0),
(26101,'esMX','64 TEST Green Cloth Legs',NULL,0),
(26102,'esMX','64 TEST Green Cloth Shoulder',NULL,0),
(26103,'esMX','64 TEST Green Cloth Wrist',NULL,0),
(26104,'esMX','65 TEST Green Cloth Belt',NULL,0),
(26105,'esMX','65 TEST Green Cloth Boot',NULL,0),
(26106,'esMX','65 TEST Green Cloth Chest',NULL,0),
(26107,'esMX','65 TEST Green Cloth Hand',NULL,0),
(26108,'esMX','65 TEST Green Cloth Head',NULL,0),
(26109,'esMX','65 TEST Green Cloth Legs',NULL,0),
(26110,'esMX','65 TEST Green Cloth Shoulder',NULL,0),
(26111,'esMX','65 TEST Green Cloth Wrist',NULL,0),
(26112,'esMX','66 TEST Green Cloth Belt',NULL,0),
(26113,'esMX','66 TEST Green Cloth Boot',NULL,0),
(26114,'esMX','66 TEST Green Cloth Chest',NULL,0),
(26115,'esMX','66 TEST Green Cloth Hand',NULL,0),
(26116,'esMX','66 TEST Green Cloth Head',NULL,0),
(26117,'esMX','66 TEST Green Cloth Legs',NULL,0),
(26118,'esMX','66 TEST Green Cloth Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26119,26120,26121,26122,26123,26124,26125,26126,26127,26136,26137,26138,26139,26140,26141,26142,26143,26144,26145,26146) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26119,'esMX','66 TEST Green Cloth Wrist',NULL,0),
(26120,'esMX','67 TEST Green Cloth Belt',NULL,0),
(26121,'esMX','67 TEST Green Cloth Boot',NULL,0),
(26122,'esMX','67 TEST Green Cloth Chest',NULL,0),
(26123,'esMX','67 TEST Green Cloth Hand',NULL,0),
(26124,'esMX','67 TEST Green Cloth Head',NULL,0),
(26125,'esMX','67 TEST Green Cloth Legs',NULL,0),
(26126,'esMX','67 TEST Green Cloth Shoulder',NULL,0),
(26127,'esMX','67 TEST Green Cloth Wrist',NULL,0),
(26136,'esMX','69 TEST Green Cloth Belt',NULL,0),
(26137,'esMX','69 TEST Green Cloth Boot',NULL,0),
(26138,'esMX','69 TEST Green Cloth Chest',NULL,0),
(26139,'esMX','69 TEST Green Cloth Hand',NULL,0),
(26140,'esMX','69 TEST Green Cloth Head',NULL,0),
(26141,'esMX','69 TEST Green Cloth Legs',NULL,0),
(26142,'esMX','69 TEST Green Cloth Shoulder',NULL,0),
(26143,'esMX','69 TEST Green Cloth Wrist',NULL,0),
(26144,'esMX','70 TEST Green Cloth Belt',NULL,0),
(26145,'esMX','70 TEST Green Cloth Boot',NULL,0),
(26146,'esMX','70 TEST Green Cloth Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26147,26148,26149,26150,26151,26152,26153,26154,26155,26156,26157,26158,26159,26160,26161,26162,26163,26164,26165,26166) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26147,'esMX','70 TEST Green Cloth Hand',NULL,0),
(26148,'esMX','70 TEST Green Cloth Head',NULL,0),
(26149,'esMX','70 TEST Green Cloth Legs',NULL,0),
(26150,'esMX','70 TEST Green Cloth Shoulder',NULL,0),
(26151,'esMX','70 TEST Green Cloth Wrist',NULL,0),
(26152,'esMX','71 TEST Green Cloth Belt',NULL,0),
(26153,'esMX','71 TEST Green Cloth Boot',NULL,0),
(26154,'esMX','71 TEST Green Cloth Chest',NULL,0),
(26155,'esMX','71 TEST Green Cloth Hand',NULL,0),
(26156,'esMX','71 TEST Green Cloth Head',NULL,0),
(26157,'esMX','71 TEST Green Cloth Legs',NULL,0),
(26158,'esMX','71 TEST Green Cloth Shoulder',NULL,0),
(26159,'esMX','71 TEST Green Cloth Wrist',NULL,0),
(26160,'esMX','72 TEST Green Cloth Belt',NULL,0),
(26161,'esMX','72 TEST Green Cloth Boot',NULL,0),
(26162,'esMX','72 TEST Green Cloth Chest',NULL,0),
(26163,'esMX','72 TEST Green Cloth Hand',NULL,0),
(26164,'esMX','72 TEST Green Cloth Head',NULL,0),
(26165,'esMX','72 TEST Green Cloth Legs',NULL,0),
(26166,'esMX','72 TEST Green Cloth Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26167,26168,26169,26170,26171,26172,26176,26177,26178,26179,26181,26182,26183,26184,26185,26186,26187,26188,26189,26190) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26167,'esMX','72 TEST Green Cloth Wrist',NULL,0),
(26168,'esMX','59 TEST Green Rogue Belt',NULL,0),
(26169,'esMX','59 TEST Green Rogue Boot',NULL,0),
(26170,'esMX','59 TEST Green Rogue Chest',NULL,0),
(26171,'esMX','59 TEST Green Rogue Hand',NULL,0),
(26172,'esMX','59 TEST Green Rogue Head',NULL,0),
(26176,'esMX','60 TEST Green Rogue Belt',NULL,0),
(26177,'esMX','60 TEST Green Rogue Boot',NULL,0),
(26178,'esMX','60 TEST Green Rogue Chest',NULL,0),
(26179,'esMX','60 TEST Green Rogue Hand',NULL,0),
(26181,'esMX','60 TEST Green Rogue Legs',NULL,0),
(26182,'esMX','60 TEST Green Rogue Shoulder',NULL,0),
(26183,'esMX','60 TEST Green Rogue Wrist',NULL,0),
(26184,'esMX','61 TEST Green Rogue Belt',NULL,0),
(26185,'esMX','61 TEST Green Rogue Boot',NULL,0),
(26186,'esMX','61 TEST Green Rogue Chest',NULL,0),
(26187,'esMX','61 TEST Green Rogue Hand',NULL,0),
(26188,'esMX','61 TEST Green Rogue Head',NULL,0),
(26189,'esMX','61 TEST Green Rogue Legs',NULL,0),
(26190,'esMX','61 TEST Green Rogue Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26191,26192,26193,26194,26195,26196,26197,26198,26199,26200,26201,26202,26203,26204,26205,26206,26207,26208,26209,26210) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26191,'esMX','61 TEST Green Rogue Wrist',NULL,0),
(26192,'esMX','62 TEST Green Rogue Belt',NULL,0),
(26193,'esMX','62 TEST Green Rogue Boot',NULL,0),
(26194,'esMX','62 TEST Green Rogue Chest',NULL,0),
(26195,'esMX','62 TEST Green Rogue Hand',NULL,0),
(26196,'esMX','62 TEST Green Rogue Head',NULL,0),
(26197,'esMX','62 TEST Green Rogue Legs',NULL,0),
(26198,'esMX','62 TEST Green Rogue Shoulder',NULL,0),
(26199,'esMX','62 TEST Green Rogue Wrist',NULL,0),
(26200,'esMX','63 TEST Green Rogue Belt',NULL,0),
(26201,'esMX','63 TEST Green Rogue Boot',NULL,0),
(26202,'esMX','63 TEST Green Rogue Chest',NULL,0),
(26203,'esMX','63 TEST Green Rogue Hand',NULL,0),
(26204,'esMX','63 TEST Green Rogue Head',NULL,0),
(26205,'esMX','63 TEST Green Rogue Legs',NULL,0),
(26206,'esMX','63 TEST Green Rogue Shoulder',NULL,0),
(26207,'esMX','63 TEST Green Rogue Wrist',NULL,0),
(26208,'esMX','64 TEST Green Rogue Belt',NULL,0),
(26209,'esMX','64 TEST Green Rogue Boot',NULL,0),
(26210,'esMX','64 TEST Green Rogue Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26211,26212,26213,26214,26215,26216,26217,26218,26219,26220,26221,26222,26223,26224,26225,26226,26227,26228,26229,26230) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26211,'esMX','64 TEST Green Rogue Hand',NULL,0),
(26212,'esMX','64 TEST Green Rogue Head',NULL,0),
(26213,'esMX','64 TEST Green Rogue Legs',NULL,0),
(26214,'esMX','64 TEST Green Rogue Shoulder',NULL,0),
(26215,'esMX','64 TEST Green Rogue Wrist',NULL,0),
(26216,'esMX','65 TEST Green Rogue Belt',NULL,0),
(26217,'esMX','65 TEST Green Rogue Boot',NULL,0),
(26218,'esMX','65 TEST Green Rogue Chest',NULL,0),
(26219,'esMX','65 TEST Green Rogue Hand',NULL,0),
(26220,'esMX','65 TEST Green Rogue Head',NULL,0),
(26221,'esMX','65 TEST Green Rogue Legs',NULL,0),
(26222,'esMX','65 TEST Green Rogue Shoulder',NULL,0),
(26223,'esMX','65 TEST Green Rogue Wrist',NULL,0),
(26224,'esMX','66 TEST Green Rogue Belt',NULL,0),
(26225,'esMX','66 TEST Green Rogue Boot',NULL,0),
(26226,'esMX','66 TEST Green Rogue Chest',NULL,0),
(26227,'esMX','66 TEST Green Rogue Hand',NULL,0),
(26228,'esMX','66 TEST Green Rogue Head',NULL,0),
(26229,'esMX','66 TEST Green Rogue Legs',NULL,0),
(26230,'esMX','66 TEST Green Rogue Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26231,26232,26233,26234,26236,26237,26238,26239,26240,26241,26242,26243,26244,26245,26246,26247,26248,26249,26250,26251) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26231,'esMX','66 TEST Green Rogue Wrist',NULL,0),
(26232,'esMX','67 TEST Green Rogue Belt',NULL,0),
(26233,'esMX','67 TEST Green Rogue Boot',NULL,0),
(26234,'esMX','67 TEST Green Rogue Chest',NULL,0),
(26236,'esMX','67 TEST Green Rogue Head',NULL,0),
(26237,'esMX','67 TEST Green Rogue Legs',NULL,0),
(26238,'esMX','67 TEST Green Rogue Shoulder',NULL,0),
(26239,'esMX','67 TEST Green Rogue Wrist',NULL,0),
(26240,'esMX','68 TEST Green Rogue Belt',NULL,0),
(26241,'esMX','68 TEST Green Rogue Boot',NULL,0),
(26242,'esMX','68 TEST Green Rogue Chest',NULL,0),
(26243,'esMX','68 TEST Green Rogue Hand',NULL,0),
(26244,'esMX','68 TEST Green Rogue Head',NULL,0),
(26245,'esMX','68 TEST Green Rogue Legs',NULL,0),
(26246,'esMX','68 TEST Green Rogue Shoulder',NULL,0),
(26247,'esMX','68 TEST Green Rogue Wrist',NULL,0),
(26248,'esMX','69 TEST Green Rogue Belt',NULL,0),
(26249,'esMX','69 TEST Green Rogue Boot',NULL,0),
(26250,'esMX','69 TEST Green Rogue Chest',NULL,0),
(26251,'esMX','69 TEST Green Rogue Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26252,26253,26254,26255,26256,26257,26258,26259,26260,26261,26262,26263,26264,26265,26266,26267,26268,26269,26270,26271) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26252,'esMX','69 TEST Green Rogue Head',NULL,0),
(26253,'esMX','69 TEST Green Rogue Legs',NULL,0),
(26254,'esMX','69 TEST Green Rogue Shoulder',NULL,0),
(26255,'esMX','69 TEST Green Rogue Wrist',NULL,0),
(26256,'esMX','70 TEST Green Rogue Belt',NULL,0),
(26257,'esMX','70 TEST Green Rogue Boot',NULL,0),
(26258,'esMX','70 TEST Green Rogue Chest',NULL,0),
(26259,'esMX','70 TEST Green Rogue Hand',NULL,0),
(26260,'esMX','70 TEST Green Rogue Head',NULL,0),
(26261,'esMX','70 TEST Green Rogue Legs',NULL,0),
(26262,'esMX','70 TEST Green Rogue Shoulder',NULL,0),
(26263,'esMX','70 TEST Green Rogue Wrist',NULL,0),
(26264,'esMX','71 TEST Green Rogue Belt',NULL,0),
(26265,'esMX','71 TEST Green Rogue Boot',NULL,0),
(26266,'esMX','71 TEST Green Rogue Chest',NULL,0),
(26267,'esMX','71 TEST Green Rogue Hand',NULL,0),
(26268,'esMX','71 TEST Green Rogue Head',NULL,0),
(26269,'esMX','71 TEST Green Rogue Legs',NULL,0),
(26270,'esMX','71 TEST Green Rogue Shoulder',NULL,0),
(26271,'esMX','71 TEST Green Rogue Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26272,26273,26274,26275,26276,26277,26278,26279,26280,26281,26282,26283,26284,26285,26286,26287,26288,26289,26290,26291) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26272,'esMX','72 TEST Green Rogue Belt',NULL,0),
(26273,'esMX','72 TEST Green Rogue Boot',NULL,0),
(26274,'esMX','72 TEST Green Rogue Chest',NULL,0),
(26275,'esMX','72 TEST Green Rogue Hand',NULL,0),
(26276,'esMX','72 TEST Green Rogue Head',NULL,0),
(26277,'esMX','72 TEST Green Rogue Legs',NULL,0),
(26278,'esMX','72 TEST Green Rogue Shoulder',NULL,0),
(26279,'esMX','72 TEST Green Rogue Wrist',NULL,0),
(26280,'esMX','59 TEST Green Hunter Belt',NULL,0),
(26281,'esMX','59 TEST Green Hunter Boot',NULL,0),
(26282,'esMX','59 TEST Green Hunter Chest',NULL,0),
(26283,'esMX','59 TEST Green Hunter Hand',NULL,0),
(26284,'esMX','59 TEST Green Hunter Head',NULL,0),
(26285,'esMX','59 TEST Green Hunter Legs',NULL,0),
(26286,'esMX','59 TEST Green Hunter Shoulder',NULL,0),
(26287,'esMX','59 TEST Green Hunter Wrist',NULL,0),
(26288,'esMX','60 TEST Green Hunter Belt',NULL,0),
(26289,'esMX','60 TEST Green Hunter Boot',NULL,0),
(26290,'esMX','60 TEST Green Hunter Chest',NULL,0),
(26291,'esMX','60 TEST Green Hunter Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26292,26293,26294,26295,26296,26297,26298,26299,26300,26301,26302,26303,26304,26305,26306,26307,26308,26309,26310,26311) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26292,'esMX','60 TEST Green Hunter Head',NULL,0),
(26293,'esMX','60 TEST Green Hunter Legs',NULL,0),
(26294,'esMX','60 TEST Green Hunter Shoulder',NULL,0),
(26295,'esMX','60 TEST Green Hunter Wrist',NULL,0),
(26296,'esMX','61 TEST Green Hunter Belt',NULL,0),
(26297,'esMX','61 TEST Green Hunter Boot',NULL,0),
(26298,'esMX','61 TEST Green Hunter Chest',NULL,0),
(26299,'esMX','61 TEST Green Hunter Hand',NULL,0),
(26300,'esMX','61 TEST Green Hunter Head',NULL,0),
(26301,'esMX','61 TEST Green Hunter Legs',NULL,0),
(26302,'esMX','61 TEST Green Hunter Shoulder',NULL,0),
(26303,'esMX','61 TEST Green Hunter Wrist',NULL,0),
(26304,'esMX','62 TEST Green Hunter Belt',NULL,0),
(26305,'esMX','62 TEST Green Hunter Boot',NULL,0),
(26306,'esMX','62 TEST Green Hunter Chest',NULL,0),
(26307,'esMX','62 TEST Green Hunter Hand',NULL,0),
(26308,'esMX','62 TEST Green Hunter Head',NULL,0),
(26309,'esMX','62 TEST Green Hunter Legs',NULL,0),
(26310,'esMX','62 TEST Green Hunter Shoulder',NULL,0),
(26311,'esMX','62 TEST Green Hunter Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26312,26313,26314,26315,26316,26317,26318,26319,26320,26321,26322,26323,26325,26326,26327,26328,26329,26330,26331,26332) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26312,'esMX','63 TEST Green Hunter Belt',NULL,0),
(26313,'esMX','63 TEST Green Hunter Boot',NULL,0),
(26314,'esMX','63 TEST Green Hunter Chest',NULL,0),
(26315,'esMX','63 TEST Green Hunter Hand',NULL,0),
(26316,'esMX','63 TEST Green Hunter Head',NULL,0),
(26317,'esMX','63 TEST Green Hunter Legs',NULL,0),
(26318,'esMX','63 TEST Green Hunter Shoulder',NULL,0),
(26319,'esMX','63 TEST Green Hunter Wrist',NULL,0),
(26320,'esMX','64 TEST Green Hunter Belt',NULL,0),
(26321,'esMX','64 TEST Green Hunter Boot',NULL,0),
(26322,'esMX','64 TEST Green Hunter Chest',NULL,0),
(26323,'esMX','64 TEST Green Hunter Hand',NULL,0),
(26325,'esMX','64 TEST Green Hunter Legs',NULL,0),
(26326,'esMX','64 TEST Green Hunter Shoulder',NULL,0),
(26327,'esMX','64 TEST Green Hunter Wrist',NULL,0),
(26328,'esMX','65 TEST Green Hunter Belt',NULL,0),
(26329,'esMX','65 TEST Green Hunter Boot',NULL,0),
(26330,'esMX','65 TEST Green Hunter Chest',NULL,0),
(26331,'esMX','65 TEST Green Hunter Hand',NULL,0),
(26332,'esMX','65 TEST Green Hunter Head',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26333,26334,26335,26336,26337,26338,26339,26340,26341,26342,26343,26344,26345,26346,26347,26348,26349,26350,26351,26352) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26333,'esMX','65 TEST Green Hunter Legs',NULL,0),
(26334,'esMX','65 TEST Green Hunter Shoulder',NULL,0),
(26335,'esMX','65 TEST Green Hunter Wrist',NULL,0),
(26336,'esMX','66 TEST Green Hunter Belt',NULL,0),
(26337,'esMX','66 TEST Green Hunter Boot',NULL,0),
(26338,'esMX','66 TEST Green Hunter Chest',NULL,0),
(26339,'esMX','66 TEST Green Hunter Hand',NULL,0),
(26340,'esMX','66 TEST Green Hunter Head',NULL,0),
(26341,'esMX','66 TEST Green Hunter Legs',NULL,0),
(26342,'esMX','66 TEST Green Hunter Shoulder',NULL,0),
(26343,'esMX','66 TEST Green Hunter Wrist',NULL,0),
(26344,'esMX','67 TEST Green Hunter Belt',NULL,0),
(26345,'esMX','67 TEST Green Hunter Boot',NULL,0),
(26346,'esMX','67 TEST Green Hunter Chest',NULL,0),
(26347,'esMX','67 TEST Green Hunter Hand',NULL,0),
(26348,'esMX','67 TEST Green Hunter Head',NULL,0),
(26349,'esMX','67 TEST Green Hunter Legs',NULL,0),
(26350,'esMX','67 TEST Green Hunter Shoulder',NULL,0),
(26351,'esMX','67 TEST Green Hunter Wrist',NULL,0),
(26352,'esMX','68 TEST Green Hunter Belt',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26353,26354,26355,26356,26357,26358,26359,26360,26361,26362,26363,26364,26365,26366,26367,26369,26370,26371,26373,26374) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26353,'esMX','68 TEST Green Hunter Boot',NULL,0),
(26354,'esMX','68 TEST Green Hunter Chest',NULL,0),
(26355,'esMX','68 TEST Green Hunter Hand',NULL,0),
(26356,'esMX','68 TEST Green Hunter Head',NULL,0),
(26357,'esMX','68 TEST Green Hunter Legs',NULL,0),
(26358,'esMX','68 TEST Green Hunter Shoulder',NULL,0),
(26359,'esMX','68 TEST Green Hunter Wrist',NULL,0),
(26360,'esMX','69 TEST Green Hunter Belt',NULL,0),
(26361,'esMX','69 TEST Green Hunter Boot',NULL,0),
(26362,'esMX','69 TEST Green Hunter Chest',NULL,0),
(26363,'esMX','69 TEST Green Hunter Hand',NULL,0),
(26364,'esMX','69 TEST Green Hunter Head',NULL,0),
(26365,'esMX','69 TEST Green Hunter Legs',NULL,0),
(26366,'esMX','69 TEST Green Hunter Shoulder',NULL,0),
(26367,'esMX','69 TEST Green Hunter Wrist',NULL,0),
(26369,'esMX','70 TEST Green Hunter Boot',NULL,0),
(26370,'esMX','70 TEST Green Hunter Chest',NULL,0),
(26371,'esMX','70 TEST Green Hunter Hand',NULL,0),
(26373,'esMX','70 TEST Green Hunter Legs',NULL,0),
(26374,'esMX','70 TEST Green Hunter Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26375,26376,26377,26378,26379,26380,26381,26382,26383,26384,26385,26386,26387,26388,26389,26390,26391,26392,26393,26394) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26375,'esMX','70 TEST Green Hunter Wrist',NULL,0),
(26376,'esMX','71 TEST Green Hunter Belt',NULL,0),
(26377,'esMX','71 TEST Green Hunter Boot',NULL,0),
(26378,'esMX','71 TEST Green Hunter Chest',NULL,0),
(26379,'esMX','71 TEST Green Hunter Hand',NULL,0),
(26380,'esMX','71 TEST Green Hunter Head',NULL,0),
(26381,'esMX','71 TEST Green Hunter Legs',NULL,0),
(26382,'esMX','71 TEST Green Hunter Shoulder',NULL,0),
(26383,'esMX','71 TEST Green Hunter Wrist',NULL,0),
(26384,'esMX','72 TEST Green Hunter Belt',NULL,0),
(26385,'esMX','72 TEST Green Hunter Boot',NULL,0),
(26386,'esMX','72 TEST Green Hunter Chest',NULL,0),
(26387,'esMX','72 TEST Green Hunter Hand',NULL,0),
(26388,'esMX','72 TEST Green Hunter Head',NULL,0),
(26389,'esMX','72 TEST Green Hunter Legs',NULL,0),
(26390,'esMX','72 TEST Green Hunter Shoulder',NULL,0),
(26391,'esMX','72 TEST Green Hunter Wrist',NULL,0),
(26392,'esMX','59 TEST Green Warrior Belt',NULL,0),
(26393,'esMX','59 TEST Green Warrior Boot',NULL,0),
(26394,'esMX','59 TEST Green Warrior Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26395,26396,26397,26398,26399,26400,26401,26402,26403,26404,26405,26406,26407,26408,26409,26410,26411,26412,26413,26414) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26395,'esMX','59 TEST Green Warrior Hand',NULL,0),
(26396,'esMX','59 TEST Green Warrior Head',NULL,0),
(26397,'esMX','59 TEST Green Warrior Legs',NULL,0),
(26398,'esMX','59 TEST Green Warrior Shoulder',NULL,0),
(26399,'esMX','59 TEST Green Warrior Wrist',NULL,0),
(26400,'esMX','60 TEST Green Warrior Belt',NULL,0),
(26401,'esMX','60 TEST Green Warrior Boot',NULL,0),
(26402,'esMX','60 TEST Green Warrior Chest',NULL,0),
(26403,'esMX','60 TEST Green Warrior Hand',NULL,0),
(26404,'esMX','60 TEST Green Warrior Head',NULL,0),
(26405,'esMX','60 TEST Green Warrior Legs',NULL,0),
(26406,'esMX','60 TEST Green Warrior Shoulder',NULL,0),
(26407,'esMX','60 TEST Green Warrior Wrist',NULL,0),
(26408,'esMX','61 TEST Green Warrior Belt',NULL,0),
(26409,'esMX','61 TEST Green Warrior Boot',NULL,0),
(26410,'esMX','61 TEST Green Warrior Chest',NULL,0),
(26411,'esMX','61 TEST Green Warrior Hand',NULL,0),
(26412,'esMX','61 TEST Green Warrior Head',NULL,0),
(26413,'esMX','61 TEST Green Warrior Legs',NULL,0),
(26414,'esMX','61 TEST Green Warrior Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26415,26416,26417,26418,26419,26420,26421,26422,26423,26424,26425,26426,26427,26428,26429,26430,26431,26432,26433,26434) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26415,'esMX','61 TEST Green Warrior Wrist',NULL,0),
(26416,'esMX','62 TEST Green Warrior Belt',NULL,0),
(26417,'esMX','62 TEST Green Warrior Boot',NULL,0),
(26418,'esMX','62 TEST Green Warrior Chest',NULL,0),
(26419,'esMX','62 TEST Green Warrior Hand',NULL,0),
(26420,'esMX','62 TEST Green Warrior Head',NULL,0),
(26421,'esMX','62 TEST Green Warrior Legs',NULL,0),
(26422,'esMX','62 TEST Green Warrior Shoulder',NULL,0),
(26423,'esMX','62 TEST Green Warrior Wrist',NULL,0),
(26424,'esMX','63 TEST Green Warrior Belt',NULL,0),
(26425,'esMX','63 TEST Green Warrior Boot',NULL,0),
(26426,'esMX','63 TEST Green Warrior Chest',NULL,0),
(26427,'esMX','63 TEST Green Warrior Hand',NULL,0),
(26428,'esMX','63 TEST Green Warrior Head',NULL,0),
(26429,'esMX','63 TEST Green Warrior Legs',NULL,0),
(26430,'esMX','63 TEST Green Warrior Shoulder',NULL,0),
(26431,'esMX','63 TEST Green Warrior Wrist',NULL,0),
(26432,'esMX','64 TEST Green Warrior Belt',NULL,0),
(26433,'esMX','64 TEST Green Warrior Boot',NULL,0),
(26434,'esMX','64 TEST Green Warrior Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26435,26436,26437,26438,26439,26440,26441,26442,26443,26444,26445,26446,26447,26448,26449,26450,26451,26452,26453,26454) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26435,'esMX','64 TEST Green Warrior Hand',NULL,0),
(26436,'esMX','64 TEST Green Warrior Head',NULL,0),
(26437,'esMX','64 TEST Green Warrior Legs',NULL,0),
(26438,'esMX','64 TEST Green Warrior Shoulder',NULL,0),
(26439,'esMX','64 TEST Green Warrior Wrist',NULL,0),
(26440,'esMX','65 TEST Green Warrior Belt',NULL,0),
(26441,'esMX','65 TEST Green Warrior Boot',NULL,0),
(26442,'esMX','65 TEST Green Warrior Chest',NULL,0),
(26443,'esMX','65 TEST Green Warrior Hand',NULL,0),
(26444,'esMX','65 TEST Green Warrior Head',NULL,0),
(26445,'esMX','65 TEST Green Warrior Legs',NULL,0),
(26446,'esMX','65 TEST Green Warrior Shoulder',NULL,0),
(26447,'esMX','65 TEST Green Warrior Wrist',NULL,0),
(26448,'esMX','66 TEST Green Warrior Belt',NULL,0),
(26449,'esMX','66 TEST Green Warrior Boot',NULL,0),
(26450,'esMX','66 TEST Green Warrior Chest',NULL,0),
(26451,'esMX','66 TEST Green Warrior Hand',NULL,0),
(26452,'esMX','66 TEST Green Warrior Head',NULL,0),
(26453,'esMX','66 TEST Green Warrior Legs',NULL,0),
(26454,'esMX','66 TEST Green Warrior Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26455,26456,26457,26458,26459,26460,26461,26462,26463,26466,26467,26468,26469,26470,26471,26472,26473,26474,26475,26476) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26455,'esMX','66 TEST Green Warrior Wrist',NULL,0),
(26456,'esMX','67 TEST Green Warrior Belt',NULL,0),
(26457,'esMX','67 TEST Green Warrior Boot',NULL,0),
(26458,'esMX','67 TEST Green Warrior Chest',NULL,0),
(26459,'esMX','67 TEST Green Warrior Hand',NULL,0),
(26460,'esMX','67 TEST Green Warrior Head',NULL,0),
(26461,'esMX','67 TEST Green Warrior Legs',NULL,0),
(26462,'esMX','67 TEST Green Warrior Shoulder',NULL,0),
(26463,'esMX','67 TEST Green Warrior Wrist',NULL,0),
(26466,'esMX','68 TEST Green Warrior Chest',NULL,0),
(26467,'esMX','68 TEST Green Warrior Hand',NULL,0),
(26468,'esMX','68 TEST Green Warrior Head',NULL,0),
(26469,'esMX','68 TEST Green Warrior Legs',NULL,0),
(26470,'esMX','68 TEST Green Warrior Shoulder',NULL,0),
(26471,'esMX','68 TEST Green Warrior Wrist',NULL,0),
(26472,'esMX','69 TEST Green Warrior Belt',NULL,0),
(26473,'esMX','69 TEST Green Warrior Boot',NULL,0),
(26474,'esMX','69 TEST Green Warrior Chest',NULL,0),
(26475,'esMX','69 TEST Green Warrior Hand',NULL,0),
(26476,'esMX','69 TEST Green Warrior Head',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26477,26478,26479,26480,26481,26482,26483,26484,26485,26486,26487,26488,26489,26490,26491,26492,26493,26494,26495,26496) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26477,'esMX','69 TEST Green Warrior Legs',NULL,0),
(26478,'esMX','69 TEST Green Warrior Shoulder',NULL,0),
(26479,'esMX','69 TEST Green Warrior Wrist',NULL,0),
(26480,'esMX','70 TEST Green Warrior Belt',NULL,0),
(26481,'esMX','70 TEST Green Warrior Boot',NULL,0),
(26482,'esMX','70 TEST Green Warrior Chest',NULL,0),
(26483,'esMX','70 TEST Green Warrior Hand',NULL,0),
(26484,'esMX','70 TEST Green Warrior Head',NULL,0),
(26485,'esMX','70 TEST Green Warrior Legs',NULL,0),
(26486,'esMX','70 TEST Green Warrior Shoulder',NULL,0),
(26487,'esMX','70 TEST Green Warrior Wrist',NULL,0),
(26488,'esMX','71 TEST Green Warrior Belt',NULL,0),
(26489,'esMX','71 TEST Green Warrior Boot',NULL,0),
(26490,'esMX','71 TEST Green Warrior Chest',NULL,0),
(26491,'esMX','71 TEST Green Warrior Hand',NULL,0),
(26492,'esMX','71 TEST Green Warrior Head',NULL,0),
(26493,'esMX','71 TEST Green Warrior Legs',NULL,0),
(26494,'esMX','71 TEST Green Warrior Shoulder',NULL,0),
(26495,'esMX','71 TEST Green Warrior Wrist',NULL,0),
(26496,'esMX','72 TEST Green Warrior Belt',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26497,26498,26499,26500,26501,26502,26503,26504,26505,26506,26507,26508,26509,26510,26511,26512,26514,26515,26516,26517) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26497,'esMX','72 TEST Green Warrior Boot',NULL,0),
(26498,'esMX','72 TEST Green Warrior Chest',NULL,0),
(26499,'esMX','72 TEST Green Warrior Hand',NULL,0),
(26500,'esMX','72 TEST Green Warrior Head',NULL,0),
(26501,'esMX','72 TEST Green Warrior Legs',NULL,0),
(26502,'esMX','72 TEST Green Warrior Shoulder',NULL,0),
(26503,'esMX','72 TEST Green Warrior Wrist',NULL,0),
(26504,'esMX','59 TEST Green Cloth Cloak',NULL,0),
(26505,'esMX','60 TEST Green Cloth Cloak',NULL,0),
(26506,'esMX','61 TEST Green Cloth Cloak',NULL,0),
(26507,'esMX','62 TEST Green Cloth Cloak',NULL,0),
(26508,'esMX','63 TEST Green Cloth Cloak',NULL,0),
(26509,'esMX','64 TEST Green Cloth Cloak',NULL,0),
(26510,'esMX','65 TEST Green Cloth Cloak',NULL,0),
(26511,'esMX','66 TEST Green Cloth Cloak',NULL,0),
(26512,'esMX','67 TEST Green Cloth Cloak',NULL,0),
(26514,'esMX','69 TEST Green Cloth Cloak',NULL,0),
(26515,'esMX','70 TEST Green Cloth Cloak',NULL,0),
(26516,'esMX','71 TEST Green Cloth Cloak',NULL,0),
(26517,'esMX','72 TEST Green Cloth Cloak',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26518,26519,26520,26521,26522,26523,26524,26525,26526,26528,26529,26530,26531,26532,26533,26534,26535,26536,26537,26538) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26518,'esMX','59 TEST Green Cloth Ring',NULL,0),
(26519,'esMX','60 TEST Green Cloth Ring',NULL,0),
(26520,'esMX','61 TEST Green Cloth Ring',NULL,0),
(26521,'esMX','62 TEST Green Cloth Ring',NULL,0),
(26522,'esMX','63 TEST Green Cloth Ring',NULL,0),
(26523,'esMX','64 TEST Green Cloth Ring',NULL,0),
(26524,'esMX','65 TEST Green Cloth Ring',NULL,0),
(26525,'esMX','66 TEST Green Cloth Ring',NULL,0),
(26526,'esMX','67 TEST Green Cloth Ring',NULL,0),
(26528,'esMX','69 TEST Green Cloth Ring',NULL,0),
(26529,'esMX','70 TEST Green Cloth Ring',NULL,0),
(26530,'esMX','71 TEST Green Cloth Ring',NULL,0),
(26531,'esMX','72 TEST Green Cloth Ring',NULL,0),
(26532,'esMX','59 TEST Green Cloth Necklace',NULL,0),
(26533,'esMX','60 TEST Green Cloth Necklace',NULL,0),
(26534,'esMX','61 TEST Green Cloth Necklace',NULL,0),
(26535,'esMX','62 TEST Green Cloth Necklace',NULL,0),
(26536,'esMX','63 TEST Green Cloth Necklace',NULL,0),
(26537,'esMX','64 TEST Green Cloth Necklace',NULL,0),
(26538,'esMX','65 TEST Green Cloth Necklace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26539,26540,26542,26543,26544,26545,26546,26547,26549,26550,26551,26552,26553,26554,26555,26556,26557,26558,26559,26560) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26539,'esMX','66 TEST Green Cloth Necklace',NULL,0),
(26540,'esMX','67 TEST Green Cloth Necklace',NULL,0),
(26542,'esMX','69 TEST Green Cloth Necklace',NULL,0),
(26543,'esMX','70 TEST Green Cloth Necklace',NULL,0),
(26544,'esMX','71 TEST Green Cloth Necklace',NULL,0),
(26545,'esMX','72 TEST Green Cloth Necklace',NULL,0),
(26546,'esMX','59 TEST Green Shield',NULL,0),
(26547,'esMX','60 TEST Green Shield',NULL,0),
(26549,'esMX','62 TEST Green Shield',NULL,0),
(26550,'esMX','63 TEST Green Shield',NULL,0),
(26551,'esMX','64 TEST Green Shield',NULL,0),
(26552,'esMX','65 TEST Green Shield',NULL,0),
(26553,'esMX','66 TEST Green Shield',NULL,0),
(26554,'esMX','67 TEST Green Shield',NULL,0),
(26555,'esMX','68 TEST Green Shield',NULL,0),
(26556,'esMX','69 TEST Green Shield',NULL,0),
(26557,'esMX','70 TEST Green Shield',NULL,0),
(26558,'esMX','71 TEST Green Shield',NULL,0),
(26559,'esMX','72 TEST Green Shield',NULL,0),
(26560,'esMX','59 TEST Green Off Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26561,26562,26563,26564,26565,26566,26567,26568,26570,26571,26572,26573,26574,26575,26576,26577,26578,26579,26580,26581) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26561,'esMX','60 TEST Green Off Hand',NULL,0),
(26562,'esMX','61 TEST Green Off Hand',NULL,0),
(26563,'esMX','62 TEST Green Off Hand',NULL,0),
(26564,'esMX','63 TEST Green Off Hand',NULL,0),
(26565,'esMX','64 TEST Green Off Hand',NULL,0),
(26566,'esMX','65 TEST Green Off Hand',NULL,0),
(26567,'esMX','66 TEST Green Off Hand',NULL,0),
(26568,'esMX','67 TEST Green Off Hand',NULL,0),
(26570,'esMX','69 TEST Green Off Hand',NULL,0),
(26571,'esMX','70 TEST Green Off Hand',NULL,0),
(26572,'esMX','71 TEST Green Off Hand',NULL,0),
(26573,'esMX','72 TEST Green Off Hand',NULL,0),
(26574,'esMX','59 TEST Green Dagger',NULL,0),
(26575,'esMX','60 TEST Green Dagger',NULL,0),
(26576,'esMX','61 TEST Green Dagger',NULL,0),
(26577,'esMX','62 TEST Green Dagger',NULL,0),
(26578,'esMX','63 TEST Green Dagger',NULL,0),
(26579,'esMX','64 TEST Green Dagger',NULL,0),
(26580,'esMX','65 TEST Green Dagger',NULL,0),
(26581,'esMX','66 TEST Green Dagger',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26582,26583,26584,26585,26586,26587,26588,26589,26590,26591,26592,26593,26594,26595,26596,26597,26598,26599,26600,26601) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26582,'esMX','67 TEST Green Dagger',NULL,0),
(26583,'esMX','68 TEST Green Dagger',NULL,0),
(26584,'esMX','69 TEST Green Dagger',NULL,0),
(26585,'esMX','70 TEST Green Dagger',NULL,0),
(26586,'esMX','71 TEST Green Dagger',NULL,0),
(26587,'esMX','72 TEST Green Dagger',NULL,0),
(26588,'esMX','59 TEST Green Mace1H',NULL,0),
(26589,'esMX','60 TEST Green Mace1H',NULL,0),
(26590,'esMX','61 TEST Green Mace1H',NULL,0),
(26591,'esMX','62 TEST Green Mace1H',NULL,0),
(26592,'esMX','63 TEST Green Mace1H',NULL,0),
(26593,'esMX','64 TEST Green Mace1H',NULL,0),
(26594,'esMX','65 TEST Green Mace1H',NULL,0),
(26595,'esMX','66 TEST Green Mace1H',NULL,0),
(26596,'esMX','67 TEST Green Mace1H',NULL,0),
(26597,'esMX','68 TEST Green Mace1H',NULL,0),
(26598,'esMX','69 TEST Green Mace1H',NULL,0),
(26599,'esMX','70 TEST Green Mace1H',NULL,0),
(26600,'esMX','71 TEST Green Mace1H',NULL,0),
(26601,'esMX','72 TEST Green Mace1H',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26602,26603,26604,26605,26606,26607,26608,26609,26610,26611,26612,26613,26614,26615,26616,26617,26618,26619,26620,26621) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26602,'esMX','59 TEST Green Mace2H',NULL,0),
(26603,'esMX','60 TEST Green Mace2H',NULL,0),
(26604,'esMX','61 TEST Green Mace2H',NULL,0),
(26605,'esMX','62 TEST Green Mace2H',NULL,0),
(26606,'esMX','63 TEST Green Mace2H',NULL,0),
(26607,'esMX','64 TEST Green Mace2H',NULL,0),
(26608,'esMX','65 TEST Green Mace2H',NULL,0),
(26609,'esMX','66 TEST Green Mace2H',NULL,0),
(26610,'esMX','67 TEST Green Mace2H',NULL,0),
(26611,'esMX','68 TEST Green Mace2H',NULL,0),
(26612,'esMX','69 TEST Green Mace2H',NULL,0),
(26613,'esMX','70 TEST Green Mace2H',NULL,0),
(26614,'esMX','71 TEST Green Mace2H',NULL,0),
(26615,'esMX','72 TEST Green Mace2H',NULL,0),
(26616,'esMX','59 TEST Green Sword1H',NULL,0),
(26617,'esMX','60 TEST Green Sword1H',NULL,0),
(26618,'esMX','61 TEST Green Sword1H',NULL,0),
(26619,'esMX','62 TEST Green Sword1H',NULL,0),
(26620,'esMX','63 TEST Green Sword1H',NULL,0),
(26621,'esMX','64 TEST Green Sword1H',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26622,26623,26624,26625,26626,26627,26628,26629,26630,26631,26632,26633,26634,26635,26636,26637,26638,26639,26640,26641) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26622,'esMX','65 TEST Green Sword1H',NULL,0),
(26623,'esMX','66 TEST Green Sword1H',NULL,0),
(26624,'esMX','67 TEST Green Sword1H',NULL,0),
(26625,'esMX','68 TEST Green Sword1H',NULL,0),
(26626,'esMX','69 TEST Green Sword1H',NULL,0),
(26627,'esMX','70 TEST Green Sword1H',NULL,0),
(26628,'esMX','71 TEST Green Sword1H',NULL,0),
(26629,'esMX','72 TEST Green Sword1H',NULL,0),
(26630,'esMX','59 TEST Green Sword2H',NULL,0),
(26631,'esMX','60 TEST Green Sword2H',NULL,0),
(26632,'esMX','61 TEST Green Sword2H',NULL,0),
(26633,'esMX','62 TEST Green Sword2H',NULL,0),
(26634,'esMX','63 TEST Green Sword2H',NULL,0),
(26635,'esMX','64 TEST Green Sword2H',NULL,0),
(26636,'esMX','65 TEST Green Sword2H',NULL,0),
(26637,'esMX','66 TEST Green Sword2H',NULL,0),
(26638,'esMX','67 TEST Green Sword2H',NULL,0),
(26639,'esMX','68 TEST Green Sword2H',NULL,0),
(26640,'esMX','69 TEST Green Sword2H',NULL,0),
(26641,'esMX','70 TEST Green Sword2H',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26642,26643,26644,26645,26646,26647,26648,26649,26650,26651,26652,26653,26654,26656,26657,26658,26659,26660,26661,26662) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26642,'esMX','71 TEST Green Sword2H',NULL,0),
(26643,'esMX','72 TEST Green Sword2H',NULL,0),
(26644,'esMX','59 TEST Green Staff',NULL,0),
(26645,'esMX','60 TEST Green Staff',NULL,0),
(26646,'esMX','61 TEST Green Staff',NULL,0),
(26647,'esMX','62 TEST Green Staff',NULL,0),
(26648,'esMX','63 TEST Green Staff',NULL,0),
(26649,'esMX','64 TEST Green Staff',NULL,0),
(26650,'esMX','65 TEST Green Staff',NULL,0),
(26651,'esMX','66 TEST Green Staff',NULL,0),
(26652,'esMX','67 TEST Green Staff',NULL,0),
(26653,'esMX','68 TEST Green Staff',NULL,0),
(26654,'esMX','69 TEST Green Staff',NULL,0),
(26656,'esMX','71 TEST Green Staff',NULL,0),
(26657,'esMX','72 TEST Green Staff',NULL,0),
(26658,'esMX','59 TEST Green FistWeapon',NULL,0),
(26659,'esMX','60 TEST Green FistWeapon',NULL,0),
(26660,'esMX','61 TEST Green FistWeapon',NULL,0),
(26661,'esMX','62 TEST Green FistWeapon',NULL,0),
(26662,'esMX','63 TEST Green FistWeapon',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26663,26664,26665,26666,26667,26668,26669,26670,26671,26672,26673,26674,26675,26676,26677,26678,26679,26680,26681,26682) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26663,'esMX','64 TEST Green FistWeapon',NULL,0),
(26664,'esMX','65 TEST Green FistWeapon',NULL,0),
(26665,'esMX','66 TEST Green FistWeapon',NULL,0),
(26666,'esMX','67 TEST Green FistWeapon',NULL,0),
(26667,'esMX','68 TEST Green FistWeapon',NULL,0),
(26668,'esMX','69 TEST Green FistWeapon',NULL,0),
(26669,'esMX','70 TEST Green FistWeapon',NULL,0),
(26670,'esMX','71 TEST Green FistWeapon',NULL,0),
(26671,'esMX','72 TEST Green FistWeapon',NULL,0),
(26672,'esMX','59 TEST Green Axe1H',NULL,0),
(26673,'esMX','60 TEST Green Axe1H',NULL,0),
(26674,'esMX','61 TEST Green Axe1H',NULL,0),
(26675,'esMX','62 TEST Green Axe1H',NULL,0),
(26676,'esMX','63 TEST Green Axe1H',NULL,0),
(26677,'esMX','64 TEST Green Axe1H',NULL,0),
(26678,'esMX','65 TEST Green Axe1H',NULL,0),
(26679,'esMX','66 TEST Green Axe1H',NULL,0),
(26680,'esMX','67 TEST Green Axe1H',NULL,0),
(26681,'esMX','68 TEST Green Axe1H',NULL,0),
(26682,'esMX','69 TEST Green Axe1H',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26683,26684,26685,26686,26687,26688,26689,26690,26691,26692,26693,26694,26695,26696,26697,26698,26699,26700,26701,26702) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26683,'esMX','70 TEST Green Axe1H',NULL,0),
(26684,'esMX','71 TEST Green Axe1H',NULL,0),
(26685,'esMX','72 TEST Green Axe1H',NULL,0),
(26686,'esMX','59 TEST Green Axe2H',NULL,0),
(26687,'esMX','60 TEST Green Axe2H',NULL,0),
(26688,'esMX','61 TEST Green Axe2H',NULL,0),
(26689,'esMX','62 TEST Green Axe2H',NULL,0),
(26690,'esMX','63 TEST Green Axe2H',NULL,0),
(26691,'esMX','64 TEST Green Axe2H',NULL,0),
(26692,'esMX','65 TEST Green Axe2H',NULL,0),
(26693,'esMX','66 TEST Green Axe2H',NULL,0),
(26694,'esMX','67 TEST Green Axe2H',NULL,0),
(26695,'esMX','68 TEST Green Axe2H',NULL,0),
(26696,'esMX','69 TEST Green Axe2H',NULL,0),
(26697,'esMX','70 TEST Green Axe2H',NULL,0),
(26698,'esMX','71 TEST Green Axe2H',NULL,0),
(26699,'esMX','72 TEST Green Axe2H',NULL,0),
(26700,'esMX','59 TEST Green Polearm',NULL,0),
(26701,'esMX','60 TEST Green Polearm',NULL,0),
(26702,'esMX','61 TEST Green Polearm',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26703,26704,26705,26706,26707,26708,26709,26710,26711,26712,26713,26714,26715,26716,26717,26718,26719,26720,26721,26722) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26703,'esMX','62 TEST Green Polearm',NULL,0),
(26704,'esMX','63 TEST Green Polearm',NULL,0),
(26705,'esMX','64 TEST Green Polearm',NULL,0),
(26706,'esMX','65 TEST Green Polearm',NULL,0),
(26707,'esMX','66 TEST Green Polearm',NULL,0),
(26708,'esMX','67 TEST Green Polearm',NULL,0),
(26709,'esMX','68 TEST Green Polearm',NULL,0),
(26710,'esMX','69 TEST Green Polearm',NULL,0),
(26711,'esMX','70 TEST Green Polearm',NULL,0),
(26712,'esMX','71 TEST Green Polearm',NULL,0),
(26713,'esMX','72 TEST Green Polearm',NULL,0),
(26714,'esMX','59 TEST Green Bow',NULL,0),
(26715,'esMX','60 TEST Green Bow',NULL,0),
(26716,'esMX','61 TEST Green Bow',NULL,0),
(26717,'esMX','62 TEST Green Bow',NULL,0),
(26718,'esMX','63 TEST Green Bow',NULL,0),
(26719,'esMX','64 TEST Green Bow',NULL,0),
(26720,'esMX','65 TEST Green Bow',NULL,0),
(26721,'esMX','66 TEST Green Bow',NULL,0),
(26722,'esMX','67 TEST Green Bow',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26723,26724,26725,26726,26727,26728,26729,26730,26731,26732,26733,26734,26735,26736,26737,26739,26740,26741,26742,26743) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26723,'esMX','68 TEST Green Bow',NULL,0),
(26724,'esMX','69 TEST Green Bow',NULL,0),
(26725,'esMX','70 TEST Green Bow',NULL,0),
(26726,'esMX','71 TEST Green Bow',NULL,0),
(26727,'esMX','72 TEST Green Bow',NULL,0),
(26728,'esMX','59 TEST Green Crossbow',NULL,0),
(26729,'esMX','60 TEST Green Crossbow',NULL,0),
(26730,'esMX','61 TEST Green Crossbow',NULL,0),
(26731,'esMX','62 TEST Green Crossbow',NULL,0),
(26732,'esMX','63 TEST Green Crossbow',NULL,0),
(26733,'esMX','64 TEST Green Crossbow',NULL,0),
(26734,'esMX','65 TEST Green Crossbow',NULL,0),
(26735,'esMX','66 TEST Green Crossbow',NULL,0),
(26736,'esMX','67 TEST Green Crossbow',NULL,0),
(26737,'esMX','68 TEST Green Crossbow',NULL,0),
(26739,'esMX','70 TEST Green Crossbow',NULL,0),
(26740,'esMX','71 TEST Green Crossbow',NULL,0),
(26741,'esMX','72 TEST Green Crossbow',NULL,0),
(26742,'esMX','59 TEST Green Gun',NULL,0),
(26743,'esMX','60 TEST Green Gun',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26744,26745,26746,26747,26748,26749,26750,26751,26752,26753,26754,26755,26756,26757,26758,26759,26760,26761,26762,26763) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26744,'esMX','61 TEST Green Gun',NULL,0),
(26745,'esMX','62 TEST Green Gun',NULL,0),
(26746,'esMX','63 TEST Green Gun',NULL,0),
(26747,'esMX','64 TEST Green Gun',NULL,0),
(26748,'esMX','65 TEST Green Gun',NULL,0),
(26749,'esMX','66 TEST Green Gun',NULL,0),
(26750,'esMX','67 TEST Green Gun',NULL,0),
(26751,'esMX','68 TEST Green Gun',NULL,0),
(26752,'esMX','69 TEST Green Gun',NULL,0),
(26753,'esMX','70 TEST Green Gun',NULL,0),
(26754,'esMX','71 TEST Green Gun',NULL,0),
(26755,'esMX','72 TEST Green Gun',NULL,0),
(26756,'esMX','59 TEST Green Wand',NULL,0),
(26757,'esMX','60 TEST Green Wand',NULL,0),
(26758,'esMX','61 TEST Green Wand',NULL,0),
(26759,'esMX','62 TEST Green Wand',NULL,0),
(26760,'esMX','63 TEST Green Wand',NULL,0),
(26761,'esMX','64 TEST Green Wand',NULL,0),
(26762,'esMX','65 TEST Green Wand',NULL,0),
(26763,'esMX','66 TEST Green Wand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26764,26766,26767,26768,26769,26770,26771,26772,26773,26774,26775,26776,26777,26778,26780,26781,26782,26783,26784,26785) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26764,'esMX','67 TEST Green Wand',NULL,0),
(26766,'esMX','69 TEST Green Wand',NULL,0),
(26767,'esMX','70 TEST Green Wand',NULL,0),
(26768,'esMX','71 TEST Green Wand',NULL,0),
(26769,'esMX','72 TEST Green Wand',NULL,0),
(26770,'esMX','59 TEST Green Spell Dagger',NULL,0),
(26771,'esMX','60 TEST Green Spell Dagger',NULL,0),
(26772,'esMX','61 TEST Green Spell Dagger',NULL,0),
(26773,'esMX','62 TEST Green Spell Dagger',NULL,0),
(26774,'esMX','63 TEST Green Spell Dagger',NULL,0),
(26775,'esMX','64 TEST Green Spell Dagger',NULL,0),
(26776,'esMX','65 TEST Green Spell Dagger',NULL,0),
(26777,'esMX','66 TEST Green Spell Dagger',NULL,0),
(26778,'esMX','67 TEST Green Spell Dagger',NULL,0),
(26780,'esMX','69 TEST Green Spell Dagger',NULL,0),
(26781,'esMX','70 TEST Green Spell Dagger',NULL,0),
(26782,'esMX','71 TEST Green Spell Dagger',NULL,0),
(26783,'esMX','72 TEST Green Spell Dagger',NULL,0),
(26784,'esMX','59 TEST Green Healer Mace',NULL,0),
(26785,'esMX','60 TEST Green Healer Mace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26786,26787,26788,26789,26790,26791,26793,26794,26795,26796,26797,26798,26799,26800,26801,26802,26803,26804,26805,26806) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26786,'esMX','61 TEST Green Healer Mace',NULL,0),
(26787,'esMX','62 TEST Green Healer Mace',NULL,0),
(26788,'esMX','63 TEST Green Healer Mace',NULL,0),
(26789,'esMX','64 TEST Green Healer Mace',NULL,0),
(26790,'esMX','65 TEST Green Healer Mace',NULL,0),
(26791,'esMX','66 TEST Green Healer Mace',NULL,0),
(26793,'esMX','68 TEST Green Healer Mace',NULL,0),
(26794,'esMX','69 TEST Green Healer Mace',NULL,0),
(26795,'esMX','70 TEST Green Healer Mace',NULL,0),
(26796,'esMX','71 TEST Green Healer Mace',NULL,0),
(26797,'esMX','72 TEST Green Healer Mace',NULL,0),
(26798,'esMX','59 TEST Green Feral Staff',NULL,0),
(26799,'esMX','60 TEST Green Feral Staff',NULL,0),
(26800,'esMX','61 TEST Green Feral Staff',NULL,0),
(26801,'esMX','62 TEST Green Feral Staff',NULL,0),
(26802,'esMX','63 TEST Green Feral Staff',NULL,0),
(26803,'esMX','64 TEST Green Feral Staff',NULL,0),
(26804,'esMX','65 TEST Green Feral Staff',NULL,0),
(26805,'esMX','66 TEST Green Feral Staff',NULL,0),
(26806,'esMX','67 TEST Green Feral Staff',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26807,26808,26809,26810,26811,26812,26813,26814,26815,26816,26817,26818,26819,26820,26821,26822,26823,26824,26825,26826) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26807,'esMX','68 TEST Green Feral Staff',NULL,0),
(26808,'esMX','69 TEST Green Feral Staff',NULL,0),
(26809,'esMX','70 TEST Green Feral Staff',NULL,0),
(26810,'esMX','71 TEST Green Feral Staff',NULL,0),
(26811,'esMX','72 TEST Green Feral Staff',NULL,0),
(26812,'esMX','59 TEST Green Druid Belt',NULL,0),
(26813,'esMX','59 TEST Green Druid Boot',NULL,0),
(26814,'esMX','59 TEST Green Druid Chest',NULL,0),
(26815,'esMX','59 TEST Green Druid Hand',NULL,0),
(26816,'esMX','59 TEST Green Druid Head',NULL,0),
(26817,'esMX','59 TEST Green Druid Legs',NULL,0),
(26818,'esMX','59 TEST Green Druid Shoulder',NULL,0),
(26819,'esMX','59 TEST Green Druid Wrist',NULL,0),
(26820,'esMX','60 TEST Green Druid Belt',NULL,0),
(26821,'esMX','60 TEST Green Druid Boot',NULL,0),
(26822,'esMX','60 TEST Green Druid Chest',NULL,0),
(26823,'esMX','60 TEST Green Druid Hand',NULL,0),
(26824,'esMX','60 TEST Green Druid Head',NULL,0),
(26825,'esMX','60 TEST Green Druid Legs',NULL,0),
(26826,'esMX','60 TEST Green Druid Shoulder',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26827,26828,26829,26830,26831,26832,26833,26834,26835,26836,26837,26838,26839,26840,26841,26842,26844,26845,26846,26847) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26827,'esMX','60 TEST Green Druid Wrist',NULL,0),
(26828,'esMX','61 TEST Green Druid Belt',NULL,0),
(26829,'esMX','61 TEST Green Druid Boot',NULL,0),
(26830,'esMX','61 TEST Green Druid Chest',NULL,0),
(26831,'esMX','61 TEST Green Druid Hand',NULL,0),
(26832,'esMX','61 TEST Green Druid Head',NULL,0),
(26833,'esMX','61 TEST Green Druid Legs',NULL,0),
(26834,'esMX','61 TEST Green Druid Shoulder',NULL,0),
(26835,'esMX','61 TEST Green Druid Wrist',NULL,0),
(26836,'esMX','62 TEST Green Druid Belt',NULL,0),
(26837,'esMX','62 TEST Green Druid Boot',NULL,0),
(26838,'esMX','62 TEST Green Druid Chest',NULL,0),
(26839,'esMX','62 TEST Green Druid Hand',NULL,0),
(26840,'esMX','62 TEST Green Druid Head',NULL,0),
(26841,'esMX','62 TEST Green Druid Legs',NULL,0),
(26842,'esMX','62 TEST Green Druid Shoulder',NULL,0),
(26844,'esMX','63 TEST Green Druid Belt',NULL,0),
(26845,'esMX','63 TEST Green Druid Boot',NULL,0),
(26846,'esMX','63 TEST Green Druid Chest',NULL,0),
(26847,'esMX','63 TEST Green Druid Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26848,26849,26850,26851,26852,26853,26854,26855,26856,26857,26858,26859,26860,26861,26862,26863,26864,26865,26866,26867) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26848,'esMX','63 TEST Green Druid Head',NULL,0),
(26849,'esMX','63 TEST Green Druid Legs',NULL,0),
(26850,'esMX','63 TEST Green Druid Shoulder',NULL,0),
(26851,'esMX','63 TEST Green Druid Wrist',NULL,0),
(26852,'esMX','64 TEST Green Druid Belt',NULL,0),
(26853,'esMX','64 TEST Green Druid Boot',NULL,0),
(26854,'esMX','64 TEST Green Druid Chest',NULL,0),
(26855,'esMX','64 TEST Green Druid Hand',NULL,0),
(26856,'esMX','64 TEST Green Druid Head',NULL,0),
(26857,'esMX','64 TEST Green Druid Legs',NULL,0),
(26858,'esMX','64 TEST Green Druid Shoulder',NULL,0),
(26859,'esMX','64 TEST Green Druid Wrist',NULL,0),
(26860,'esMX','65 TEST Green Druid Belt',NULL,0),
(26861,'esMX','65 TEST Green Druid Boot',NULL,0),
(26862,'esMX','65 TEST Green Druid Chest',NULL,0),
(26863,'esMX','65 TEST Green Druid Hand',NULL,0),
(26864,'esMX','65 TEST Green Druid Head',NULL,0),
(26865,'esMX','65 TEST Green Druid Legs',NULL,0),
(26866,'esMX','65 TEST Green Druid Shoulder',NULL,0),
(26867,'esMX','65 TEST Green Druid Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26868,26869,26870,26871,26872,26873,26874,26875,26876,26877,26878,26879,26880,26881,26882,26883,26884,26885,26886,26887) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26868,'esMX','66 TEST Green Druid Belt',NULL,0),
(26869,'esMX','66 TEST Green Druid Boot',NULL,0),
(26870,'esMX','66 TEST Green Druid Chest',NULL,0),
(26871,'esMX','66 TEST Green Druid Hand',NULL,0),
(26872,'esMX','66 TEST Green Druid Head',NULL,0),
(26873,'esMX','66 TEST Green Druid Legs',NULL,0),
(26874,'esMX','66 TEST Green Druid Shoulder',NULL,0),
(26875,'esMX','66 TEST Green Druid Wrist',NULL,0),
(26876,'esMX','67 TEST Green Druid Belt',NULL,0),
(26877,'esMX','67 TEST Green Druid Boot',NULL,0),
(26878,'esMX','67 TEST Green Druid Chest',NULL,0),
(26879,'esMX','67 TEST Green Druid Hand',NULL,0),
(26880,'esMX','67 TEST Green Druid Head',NULL,0),
(26881,'esMX','67 TEST Green Druid Legs',NULL,0),
(26882,'esMX','67 TEST Green Druid Shoulder',NULL,0),
(26883,'esMX','67 TEST Green Druid Wrist',NULL,0),
(26884,'esMX','68 TEST Green Druid Belt',NULL,0),
(26885,'esMX','68 TEST Green Druid Boot',NULL,0),
(26886,'esMX','68 TEST Green Druid Chest',NULL,0),
(26887,'esMX','68 TEST Green Druid Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26888,26889,26890,26891,26892,26893,26894,26895,26896,26897,26898,26899,26900,26901,26902,26903,26904,26905,26906,26907) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26888,'esMX','68 TEST Green Druid Head',NULL,0),
(26889,'esMX','68 TEST Green Druid Legs',NULL,0),
(26890,'esMX','68 TEST Green Druid Shoulder',NULL,0),
(26891,'esMX','68 TEST Green Druid Wrist',NULL,0),
(26892,'esMX','69 TEST Green Druid Belt',NULL,0),
(26893,'esMX','69 TEST Green Druid Boot',NULL,0),
(26894,'esMX','69 TEST Green Druid Chest',NULL,0),
(26895,'esMX','69 TEST Green Druid Hand',NULL,0),
(26896,'esMX','69 TEST Green Druid Head',NULL,0),
(26897,'esMX','69 TEST Green Druid Legs',NULL,0),
(26898,'esMX','69 TEST Green Druid Shoulder',NULL,0),
(26899,'esMX','69 TEST Green Druid Wrist',NULL,0),
(26900,'esMX','70 TEST Green Druid Belt',NULL,0),
(26901,'esMX','70 TEST Green Druid Boot',NULL,0),
(26902,'esMX','70 TEST Green Druid Chest',NULL,0),
(26903,'esMX','70 TEST Green Druid Hand',NULL,0),
(26904,'esMX','70 TEST Green Druid Head',NULL,0),
(26905,'esMX','70 TEST Green Druid Legs',NULL,0),
(26906,'esMX','70 TEST Green Druid Shoulder',NULL,0),
(26907,'esMX','70 TEST Green Druid Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26908,26909,26910,26911,26912,26913,26914,26915,26916,26917,26918,26919,26920,26921,26922,26923,26924,26925,26926,26927) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26908,'esMX','71 TEST Green Druid Belt',NULL,0),
(26909,'esMX','71 TEST Green Druid Boot',NULL,0),
(26910,'esMX','71 TEST Green Druid Chest',NULL,0),
(26911,'esMX','71 TEST Green Druid Hand',NULL,0),
(26912,'esMX','71 TEST Green Druid Head',NULL,0),
(26913,'esMX','71 TEST Green Druid Legs',NULL,0),
(26914,'esMX','71 TEST Green Druid Shoulder',NULL,0),
(26915,'esMX','71 TEST Green Druid Wrist',NULL,0),
(26916,'esMX','72 TEST Green Druid Belt',NULL,0),
(26917,'esMX','72 TEST Green Druid Boot',NULL,0),
(26918,'esMX','72 TEST Green Druid Chest',NULL,0),
(26919,'esMX','72 TEST Green Druid Hand',NULL,0),
(26920,'esMX','72 TEST Green Druid Head',NULL,0),
(26921,'esMX','72 TEST Green Druid Legs',NULL,0),
(26922,'esMX','72 TEST Green Druid Shoulder',NULL,0),
(26923,'esMX','72 TEST Green Druid Wrist',NULL,0),
(26924,'esMX','59 TEST Green Shaman Belt',NULL,0),
(26925,'esMX','59 TEST Green Shaman Boot',NULL,0),
(26926,'esMX','59 TEST Green Shaman Chest',NULL,0),
(26927,'esMX','59 TEST Green Shaman Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26928,26929,26930,26931,26932,26933,26934,26935,26936,26937,26938,26939,26940,26941,26942,26943,26944,26945,26946,26947) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26928,'esMX','59 TEST Green Shaman Head',NULL,0),
(26929,'esMX','59 TEST Green Shaman Legs',NULL,0),
(26930,'esMX','59 TEST Green Shaman Shoulder',NULL,0),
(26931,'esMX','59 TEST Green Shaman Wrist',NULL,0),
(26932,'esMX','60 TEST Green Shaman Belt',NULL,0),
(26933,'esMX','60 TEST Green Shaman Boot',NULL,0),
(26934,'esMX','60 TEST Green Shaman Chest',NULL,0),
(26935,'esMX','60 TEST Green Shaman Hand',NULL,0),
(26936,'esMX','60 TEST Green Shaman Head',NULL,0),
(26937,'esMX','60 TEST Green Shaman Legs',NULL,0),
(26938,'esMX','60 TEST Green Shaman Shoulder',NULL,0),
(26939,'esMX','60 TEST Green Shaman Wrist',NULL,0),
(26940,'esMX','61 TEST Green Shaman Belt',NULL,0),
(26941,'esMX','61 TEST Green Shaman Boot',NULL,0),
(26942,'esMX','61 TEST Green Shaman Chest',NULL,0),
(26943,'esMX','61 TEST Green Shaman Hand',NULL,0),
(26944,'esMX','61 TEST Green Shaman Head',NULL,0),
(26945,'esMX','61 TEST Green Shaman Legs',NULL,0),
(26946,'esMX','61 TEST Green Shaman Shoulder',NULL,0),
(26947,'esMX','61 TEST Green Shaman Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26948,26949,26950,26951,26952,26953,26954,26955,26956,26957,26958,26959,26960,26961,26962,26963,26964,26965,26966,26967) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26948,'esMX','62 TEST Green Shaman Belt',NULL,0),
(26949,'esMX','62 TEST Green Shaman Boot',NULL,0),
(26950,'esMX','62 TEST Green Shaman Chest',NULL,0),
(26951,'esMX','62 TEST Green Shaman Hand',NULL,0),
(26952,'esMX','62 TEST Green Shaman Head',NULL,0),
(26953,'esMX','62 TEST Green Shaman Legs',NULL,0),
(26954,'esMX','62 TEST Green Shaman Shoulder',NULL,0),
(26955,'esMX','62 TEST Green Shaman Wrist',NULL,0),
(26956,'esMX','63 TEST Green Shaman Belt',NULL,0),
(26957,'esMX','63 TEST Green Shaman Boot',NULL,0),
(26958,'esMX','63 TEST Green Shaman Chest',NULL,0),
(26959,'esMX','63 TEST Green Shaman Hand',NULL,0),
(26960,'esMX','63 TEST Green Shaman Head',NULL,0),
(26961,'esMX','63 TEST Green Shaman Legs',NULL,0),
(26962,'esMX','63 TEST Green Shaman Shoulder',NULL,0),
(26963,'esMX','63 TEST Green Shaman Wrist',NULL,0),
(26964,'esMX','64 TEST Green Shaman Belt',NULL,0),
(26965,'esMX','64 TEST Green Shaman Boot',NULL,0),
(26966,'esMX','64 TEST Green Shaman Chest',NULL,0),
(26967,'esMX','64 TEST Green Shaman Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26968,26969,26970,26971,26972,26973,26974,26975,26976,26977,26978,26979,26980,26981,26982,26983,26984,26985,26986,26987) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26968,'esMX','64 TEST Green Shaman Head',NULL,0),
(26969,'esMX','64 TEST Green Shaman Legs',NULL,0),
(26970,'esMX','64 TEST Green Shaman Shoulder',NULL,0),
(26971,'esMX','64 TEST Green Shaman Wrist',NULL,0),
(26972,'esMX','65 TEST Green Shaman Belt',NULL,0),
(26973,'esMX','65 TEST Green Shaman Boot',NULL,0),
(26974,'esMX','65 TEST Green Shaman Chest',NULL,0),
(26975,'esMX','65 TEST Green Shaman Hand',NULL,0),
(26976,'esMX','65 TEST Green Shaman Head',NULL,0),
(26977,'esMX','65 TEST Green Shaman Legs',NULL,0),
(26978,'esMX','65 TEST Green Shaman Shoulder',NULL,0),
(26979,'esMX','65 TEST Green Shaman Wrist',NULL,0),
(26980,'esMX','66 TEST Green Shaman Belt',NULL,0),
(26981,'esMX','66 TEST Green Shaman Boot',NULL,0),
(26982,'esMX','66 TEST Green Shaman Chest',NULL,0),
(26983,'esMX','66 TEST Green Shaman Hand',NULL,0),
(26984,'esMX','66 TEST Green Shaman Head',NULL,0),
(26985,'esMX','66 TEST Green Shaman Legs',NULL,0),
(26986,'esMX','66 TEST Green Shaman Shoulder',NULL,0),
(26987,'esMX','66 TEST Green Shaman Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(26988,26989,26990,26991,26992,26993,26994,26995,26996,26997,26998,26999,27000,27001,27002,27003,27004,27005,27006,27007) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(26988,'esMX','67 TEST Green Shaman Belt',NULL,0),
(26989,'esMX','67 TEST Green Shaman Boot',NULL,0),
(26990,'esMX','67 TEST Green Shaman Chest',NULL,0),
(26991,'esMX','67 TEST Green Shaman Hand',NULL,0),
(26992,'esMX','67 TEST Green Shaman Head',NULL,0),
(26993,'esMX','67 TEST Green Shaman Legs',NULL,0),
(26994,'esMX','67 TEST Green Shaman Shoulder',NULL,0),
(26995,'esMX','67 TEST Green Shaman Wrist',NULL,0),
(26996,'esMX','68 TEST Green Shaman Belt',NULL,0),
(26997,'esMX','68 TEST Green Shaman Boot',NULL,0),
(26998,'esMX','68 TEST Green Shaman Chest',NULL,0),
(26999,'esMX','68 TEST Green Shaman Hand',NULL,0),
(27000,'esMX','68 TEST Green Shaman Head',NULL,0),
(27001,'esMX','68 TEST Green Shaman Legs',NULL,0),
(27002,'esMX','68 TEST Green Shaman Shoulder',NULL,0),
(27003,'esMX','68 TEST Green Shaman Wrist',NULL,0),
(27004,'esMX','69 TEST Green Shaman Belt',NULL,0),
(27005,'esMX','69 TEST Green Shaman Boot',NULL,0),
(27006,'esMX','69 TEST Green Shaman Chest',NULL,0),
(27007,'esMX','69 TEST Green Shaman Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27008,27009,27010,27011,27012,27013,27014,27015,27016,27017,27018,27019,27020,27021,27022,27023,27024,27025,27026,27027) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27008,'esMX','69 TEST Green Shaman Head',NULL,0),
(27009,'esMX','69 TEST Green Shaman Legs',NULL,0),
(27010,'esMX','69 TEST Green Shaman Shoulder',NULL,0),
(27011,'esMX','69 TEST Green Shaman Wrist',NULL,0),
(27012,'esMX','70 TEST Green Shaman Belt',NULL,0),
(27013,'esMX','70 TEST Green Shaman Boot',NULL,0),
(27014,'esMX','70 TEST Green Shaman Chest',NULL,0),
(27015,'esMX','70 TEST Green Shaman Hand',NULL,0),
(27016,'esMX','70 TEST Green Shaman Head',NULL,0),
(27017,'esMX','70 TEST Green Shaman Legs',NULL,0),
(27018,'esMX','70 TEST Green Shaman Shoulder',NULL,0),
(27019,'esMX','70 TEST Green Shaman Wrist',NULL,0),
(27020,'esMX','71 TEST Green Shaman Belt',NULL,0),
(27021,'esMX','71 TEST Green Shaman Boot',NULL,0),
(27022,'esMX','71 TEST Green Shaman Chest',NULL,0),
(27023,'esMX','71 TEST Green Shaman Hand',NULL,0),
(27024,'esMX','71 TEST Green Shaman Head',NULL,0),
(27025,'esMX','71 TEST Green Shaman Legs',NULL,0),
(27026,'esMX','71 TEST Green Shaman Shoulder',NULL,0),
(27027,'esMX','71 TEST Green Shaman Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27028,27029,27030,27031,27032,27033,27034,27035,27036,27037,27038,27039,27040,27041,27042,27043,27044,27045,27046,27047) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27028,'esMX','72 TEST Green Shaman Belt',NULL,0),
(27029,'esMX','72 TEST Green Shaman Boot',NULL,0),
(27030,'esMX','72 TEST Green Shaman Chest',NULL,0),
(27031,'esMX','72 TEST Green Shaman Hand',NULL,0),
(27032,'esMX','72 TEST Green Shaman Head',NULL,0),
(27033,'esMX','72 TEST Green Shaman Legs',NULL,0),
(27034,'esMX','72 TEST Green Shaman Shoulder',NULL,0),
(27035,'esMX','72 TEST Green Shaman Wrist',NULL,0),
(27036,'esMX','59 TEST Green Paladin Belt',NULL,0),
(27037,'esMX','59 TEST Green Paladin Boot',NULL,0),
(27038,'esMX','59 TEST Green Paladin Chest',NULL,0),
(27039,'esMX','59 TEST Green Paladin Hand',NULL,0),
(27040,'esMX','59 TEST Green Paladin Head',NULL,0),
(27041,'esMX','59 TEST Green Paladin Legs',NULL,0),
(27042,'esMX','59 TEST Green Paladin Shoulder',NULL,0),
(27043,'esMX','59 TEST Green Paladin Wrist',NULL,0),
(27044,'esMX','60 TEST Green Paladin Belt',NULL,0),
(27045,'esMX','60 TEST Green Paladin Boot',NULL,0),
(27046,'esMX','60 TEST Green Paladin Chest',NULL,0),
(27047,'esMX','60 TEST Green Paladin Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27048,27049,27050,27051,27052,27053,27054,27055,27056,27057,27058,27059,27060,27061,27062,27063,27064,27065,27066,27067) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27048,'esMX','60 TEST Green Paladin Head',NULL,0),
(27049,'esMX','60 TEST Green Paladin Legs',NULL,0),
(27050,'esMX','60 TEST Green Paladin Shoulder',NULL,0),
(27051,'esMX','60 TEST Green Paladin Wrist',NULL,0),
(27052,'esMX','61 TEST Green Paladin Belt',NULL,0),
(27053,'esMX','61 TEST Green Paladin Boot',NULL,0),
(27054,'esMX','61 TEST Green Paladin Chest',NULL,0),
(27055,'esMX','61 TEST Green Paladin Hand',NULL,0),
(27056,'esMX','61 TEST Green Paladin Head',NULL,0),
(27057,'esMX','61 TEST Green Paladin Legs',NULL,0),
(27058,'esMX','61 TEST Green Paladin Shoulder',NULL,0),
(27059,'esMX','61 TEST Green Paladin Wrist',NULL,0),
(27060,'esMX','62 TEST Green Paladin Belt',NULL,0),
(27061,'esMX','62 TEST Green Paladin Boot',NULL,0),
(27062,'esMX','62 TEST Green Paladin Chest',NULL,0),
(27063,'esMX','62 TEST Green Paladin Hand',NULL,0),
(27064,'esMX','62 TEST Green Paladin Head',NULL,0),
(27065,'esMX','62 TEST Green Paladin Legs',NULL,0),
(27066,'esMX','62 TEST Green Paladin Shoulder',NULL,0),
(27067,'esMX','62 TEST Green Paladin Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27068,27069,27070,27071,27072,27073,27074,27075,27076,27077,27078,27079,27080,27081,27082,27083,27084,27085,27086,27087) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27068,'esMX','63 TEST Green Paladin Belt',NULL,0),
(27069,'esMX','63 TEST Green Paladin Boot',NULL,0),
(27070,'esMX','63 TEST Green Paladin Chest',NULL,0),
(27071,'esMX','63 TEST Green Paladin Hand',NULL,0),
(27072,'esMX','63 TEST Green Paladin Head',NULL,0),
(27073,'esMX','63 TEST Green Paladin Legs',NULL,0),
(27074,'esMX','63 TEST Green Paladin Shoulder',NULL,0),
(27075,'esMX','63 TEST Green Paladin Wrist',NULL,0),
(27076,'esMX','64 TEST Green Paladin Belt',NULL,0),
(27077,'esMX','64 TEST Green Paladin Boot',NULL,0),
(27078,'esMX','64 TEST Green Paladin Chest',NULL,0),
(27079,'esMX','64 TEST Green Paladin Hand',NULL,0),
(27080,'esMX','64 TEST Green Paladin Head',NULL,0),
(27081,'esMX','64 TEST Green Paladin Legs',NULL,0),
(27082,'esMX','64 TEST Green Paladin Shoulder',NULL,0),
(27083,'esMX','64 TEST Green Paladin Wrist',NULL,0),
(27084,'esMX','65 TEST Green Paladin Belt',NULL,0),
(27085,'esMX','65 TEST Green Paladin Boot',NULL,0),
(27086,'esMX','65 TEST Green Paladin Chest',NULL,0),
(27087,'esMX','65 TEST Green Paladin Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27088,27089,27090,27091,27092,27093,27094,27095,27096,27097,27098,27099,27100,27101,27102,27103,27104,27105,27106,27107) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27088,'esMX','65 TEST Green Paladin Head',NULL,0),
(27089,'esMX','65 TEST Green Paladin Legs',NULL,0),
(27090,'esMX','65 TEST Green Paladin Shoulder',NULL,0),
(27091,'esMX','65 TEST Green Paladin Wrist',NULL,0),
(27092,'esMX','66 TEST Green Paladin Belt',NULL,0),
(27093,'esMX','66 TEST Green Paladin Boot',NULL,0),
(27094,'esMX','66 TEST Green Paladin Chest',NULL,0),
(27095,'esMX','66 TEST Green Paladin Hand',NULL,0),
(27096,'esMX','66 TEST Green Paladin Head',NULL,0),
(27097,'esMX','66 TEST Green Paladin Legs',NULL,0),
(27098,'esMX','66 TEST Green Paladin Shoulder',NULL,0),
(27099,'esMX','66 TEST Green Paladin Wrist',NULL,0),
(27100,'esMX','67 TEST Green Paladin Belt',NULL,0),
(27101,'esMX','67 TEST Green Paladin Boot',NULL,0),
(27102,'esMX','67 TEST Green Paladin Chest',NULL,0),
(27103,'esMX','67 TEST Green Paladin Hand',NULL,0),
(27104,'esMX','67 TEST Green Paladin Head',NULL,0),
(27105,'esMX','67 TEST Green Paladin Legs',NULL,0),
(27106,'esMX','67 TEST Green Paladin Shoulder',NULL,0),
(27107,'esMX','67 TEST Green Paladin Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27108,27109,27110,27111,27112,27113,27114,27115,27116,27117,27118,27119,27120,27121,27122,27123,27124,27125,27126,27127) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27108,'esMX','68 TEST Green Paladin Belt',NULL,0),
(27109,'esMX','68 TEST Green Paladin Boot',NULL,0),
(27110,'esMX','68 TEST Green Paladin Chest',NULL,0),
(27111,'esMX','68 TEST Green Paladin Hand',NULL,0),
(27112,'esMX','68 TEST Green Paladin Head',NULL,0),
(27113,'esMX','68 TEST Green Paladin Legs',NULL,0),
(27114,'esMX','68 TEST Green Paladin Shoulder',NULL,0),
(27115,'esMX','68 TEST Green Paladin Wrist',NULL,0),
(27116,'esMX','69 TEST Green Paladin Belt',NULL,0),
(27117,'esMX','69 TEST Green Paladin Boot',NULL,0),
(27118,'esMX','69 TEST Green Paladin Chest',NULL,0),
(27119,'esMX','69 TEST Green Paladin Hand',NULL,0),
(27120,'esMX','69 TEST Green Paladin Head',NULL,0),
(27121,'esMX','69 TEST Green Paladin Legs',NULL,0),
(27122,'esMX','69 TEST Green Paladin Shoulder',NULL,0),
(27123,'esMX','69 TEST Green Paladin Wrist',NULL,0),
(27124,'esMX','70 TEST Green Paladin Belt',NULL,0),
(27125,'esMX','70 TEST Green Paladin Boot',NULL,0),
(27126,'esMX','70 TEST Green Paladin Chest',NULL,0),
(27127,'esMX','70 TEST Green Paladin Hand',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27128,27129,27130,27131,27132,27133,27134,27135,27136,27137,27138,27139,27140,27141,27142,27143,27144,27145,27146,27147) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27128,'esMX','70 TEST Green Paladin Head',NULL,0),
(27129,'esMX','70 TEST Green Paladin Legs',NULL,0),
(27130,'esMX','70 TEST Green Paladin Shoulder',NULL,0),
(27131,'esMX','70 TEST Green Paladin Wrist',NULL,0),
(27132,'esMX','71 TEST Green Paladin Belt',NULL,0),
(27133,'esMX','71 TEST Green Paladin Boot',NULL,0),
(27134,'esMX','71 TEST Green Paladin Chest',NULL,0),
(27135,'esMX','71 TEST Green Paladin Hand',NULL,0),
(27136,'esMX','71 TEST Green Paladin Head',NULL,0),
(27137,'esMX','71 TEST Green Paladin Legs',NULL,0),
(27138,'esMX','71 TEST Green Paladin Shoulder',NULL,0),
(27139,'esMX','71 TEST Green Paladin Wrist',NULL,0),
(27140,'esMX','72 TEST Green Paladin Belt',NULL,0),
(27141,'esMX','72 TEST Green Paladin Boot',NULL,0),
(27142,'esMX','72 TEST Green Paladin Chest',NULL,0),
(27143,'esMX','72 TEST Green Paladin Hand',NULL,0),
(27144,'esMX','72 TEST Green Paladin Head',NULL,0),
(27145,'esMX','72 TEST Green Paladin Legs',NULL,0),
(27146,'esMX','72 TEST Green Paladin Shoulder',NULL,0),
(27147,'esMX','72 TEST Green Paladin Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27148,27149,27150,27151,27152,27153,27154,27155,27156,27157,27158,27159,27160,27161,27162,27163,27164,27165,27166,27167) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27148,'esMX','59 TEST Green Rogue/Hunter Cloak',NULL,0),
(27149,'esMX','60 TEST Green Rogue/Hunter Cloak',NULL,0),
(27150,'esMX','61 TEST Green Rogue/Hunter Cloak',NULL,0),
(27151,'esMX','62 TEST Green Rogue/Hunter Cloak',NULL,0),
(27152,'esMX','63 TEST Green Rogue/Hunter Cloak',NULL,0),
(27153,'esMX','64 TEST Green Rogue/Hunter Cloak',NULL,0),
(27154,'esMX','65 TEST Green Rogue/Hunter Cloak',NULL,0),
(27155,'esMX','66 TEST Green Rogue/Hunter Cloak',NULL,0),
(27156,'esMX','67 TEST Green Rogue/Hunter Cloak',NULL,0),
(27157,'esMX','68 TEST Green Rogue/Hunter Cloak',NULL,0),
(27158,'esMX','69 TEST Green Rogue/Hunter Cloak',NULL,0),
(27159,'esMX','70 TEST Green Rogue/Hunter Cloak',NULL,0),
(27160,'esMX','71 TEST Green Rogue/Hunter Cloak',NULL,0),
(27161,'esMX','72 TEST Green Rogue/Hunter Cloak',NULL,0),
(27162,'esMX','59 TEST Green Rogue/Hunter Ring',NULL,0),
(27163,'esMX','60 TEST Green Rogue/Hunter Ring',NULL,0),
(27164,'esMX','61 TEST Green Rogue/Hunter Ring',NULL,0),
(27165,'esMX','62 TEST Green Rogue/Hunter Ring',NULL,0),
(27166,'esMX','63 TEST Green Rogue/Hunter Ring',NULL,0),
(27167,'esMX','64 TEST Green Rogue/Hunter Ring',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27168,27169,27170,27171,27172,27173,27174,27175,27176,27177,27178,27179,27180,27181,27182,27183,27184,27185,27186,27187) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27168,'esMX','65 TEST Green Rogue/Hunter Ring',NULL,0),
(27169,'esMX','66 TEST Green Rogue/Hunter Ring',NULL,0),
(27170,'esMX','67 TEST Green Rogue/Hunter Ring',NULL,0),
(27171,'esMX','68 TEST Green Rogue/Hunter Ring',NULL,0),
(27172,'esMX','69 TEST Green Rogue/Hunter Ring',NULL,0),
(27173,'esMX','70 TEST Green Rogue/Hunter Ring',NULL,0),
(27174,'esMX','71 TEST Green Rogue/Hunter Ring',NULL,0),
(27175,'esMX','72 TEST Green Rogue/Hunter Ring',NULL,0),
(27176,'esMX','59 TEST Green Rogue/Hunter Necklace',NULL,0),
(27177,'esMX','60 TEST Green Rogue/Hunter Necklace',NULL,0),
(27178,'esMX','61 TEST Green Rogue/Hunter Necklace',NULL,0),
(27179,'esMX','62 TEST Green Rogue/Hunter Necklace',NULL,0),
(27180,'esMX','63 TEST Green Rogue/Hunter Necklace',NULL,0),
(27181,'esMX','64 TEST Green Rogue/Hunter Necklace',NULL,0),
(27182,'esMX','65 TEST Green Rogue/Hunter Necklace',NULL,0),
(27183,'esMX','66 TEST Green Rogue/Hunter Necklace',NULL,0),
(27184,'esMX','67 TEST Green Rogue/Hunter Necklace',NULL,0),
(27185,'esMX','68 TEST Green Rogue/Hunter Necklace',NULL,0),
(27186,'esMX','69 TEST Green Rogue/Hunter Necklace',NULL,0),
(27187,'esMX','70 TEST Green Rogue/Hunter Necklace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27188,27189,27190,27191,27192,27193,27194,27195,27197,27198,27199,27200,27201,27202,27203,27204,27205,27206,27207,27208) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27188,'esMX','71 TEST Green Rogue/Hunter Necklace',NULL,0),
(27189,'esMX','72 TEST Green Rogue/Hunter Necklace',NULL,0),
(27190,'esMX','59 TEST Green Druid/Warrior Cloak',NULL,0),
(27191,'esMX','60 TEST Green Druid/Warrior Cloak',NULL,0),
(27192,'esMX','61 TEST Green Druid/Warrior Cloak',NULL,0),
(27193,'esMX','62 TEST Green Druid/Warrior Cloak',NULL,0),
(27194,'esMX','63 TEST Green Druid/Warrior Cloak',NULL,0),
(27195,'esMX','64 TEST Green Druid/Warrior Cloak',NULL,0),
(27197,'esMX','66 TEST Green Druid/Warrior Cloak',NULL,0),
(27198,'esMX','67 TEST Green Druid/Warrior Cloak',NULL,0),
(27199,'esMX','68 TEST Green Druid/Warrior Cloak',NULL,0),
(27200,'esMX','69 TEST Green Druid/Warrior Cloak',NULL,0),
(27201,'esMX','70 TEST Green Druid/Warrior Cloak',NULL,0),
(27202,'esMX','71 TEST Green Druid/Warrior Cloak',NULL,0),
(27203,'esMX','72 TEST Green Druid/Warrior Cloak',NULL,0),
(27204,'esMX','59 TEST Green Druid/Warrior Ring',NULL,0),
(27205,'esMX','60 TEST Green Druid/Warrior Ring',NULL,0),
(27206,'esMX','61 TEST Green Druid/Warrior Ring',NULL,0),
(27207,'esMX','62 TEST Green Druid/Warrior Ring',NULL,0),
(27208,'esMX','63 TEST Green Druid/Warrior Ring',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27209,27210,27211,27212,27213,27214,27215,27216,27217,27219,27220,27221,27222,27223,27224,27225,27226,27227,27228,27229) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27209,'esMX','64 TEST Green Druid/Warrior Ring',NULL,0),
(27210,'esMX','65 TEST Green Druid/Warrior Ring',NULL,0),
(27211,'esMX','66 TEST Green Druid/Warrior Ring',NULL,0),
(27212,'esMX','67 TEST Green Druid/Warrior Ring',NULL,0),
(27213,'esMX','68 TEST Green Druid/Warrior Ring',NULL,0),
(27214,'esMX','69 TEST Green Druid/Warrior Ring',NULL,0),
(27215,'esMX','70 TEST Green Druid/Warrior Ring',NULL,0),
(27216,'esMX','71 TEST Green Druid/Warrior Ring',NULL,0),
(27217,'esMX','72 TEST Green Druid/Warrior Ring',NULL,0),
(27219,'esMX','60 TEST Green Druid/Warrior Necklace',NULL,0),
(27220,'esMX','61 TEST Green Druid/Warrior Necklace',NULL,0),
(27221,'esMX','62 TEST Green Druid/Warrior Necklace',NULL,0),
(27222,'esMX','63 TEST Green Druid/Warrior Necklace',NULL,0),
(27223,'esMX','64 TEST Green Druid/Warrior Necklace',NULL,0),
(27224,'esMX','65 TEST Green Druid/Warrior Necklace',NULL,0),
(27225,'esMX','66 TEST Green Druid/Warrior Necklace',NULL,0),
(27226,'esMX','67 TEST Green Druid/Warrior Necklace',NULL,0),
(27227,'esMX','68 TEST Green Druid/Warrior Necklace',NULL,0),
(27228,'esMX','69 TEST Green Druid/Warrior Necklace',NULL,0),
(27229,'esMX','70 TEST Green Druid/Warrior Necklace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27230,27231,27232,27233,27234,27235,27236,27237,27238,27239,27240,27241,27242,27243,27244,27245,27246,27247,27248,27249) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27230,'esMX','71 TEST Green Druid/Warrior Necklace',NULL,0),
(27231,'esMX','72 TEST Green Druid/Warrior Necklace',NULL,0),
(27232,'esMX','59 TEST Green Shaman Cloak',NULL,0),
(27233,'esMX','60 TEST Green Shaman Cloak',NULL,0),
(27234,'esMX','61 TEST Green Shaman Cloak',NULL,0),
(27235,'esMX','62 TEST Green Shaman Cloak',NULL,0),
(27236,'esMX','63 TEST Green Shaman Cloak',NULL,0),
(27237,'esMX','64 TEST Green Shaman Cloak',NULL,0),
(27238,'esMX','65 TEST Green Shaman Cloak',NULL,0),
(27239,'esMX','66 TEST Green Shaman Cloak',NULL,0),
(27240,'esMX','67 TEST Green Shaman Cloak',NULL,0),
(27241,'esMX','68 TEST Green Shaman Cloak',NULL,0),
(27242,'esMX','69 TEST Green Shaman Cloak',NULL,0),
(27243,'esMX','70 TEST Green Shaman Cloak',NULL,0),
(27244,'esMX','71 TEST Green Shaman Cloak',NULL,0),
(27245,'esMX','72 TEST Green Shaman Cloak',NULL,0),
(27246,'esMX','59 TEST Green Shaman Ring',NULL,0),
(27247,'esMX','60 TEST Green Shaman Ring',NULL,0),
(27248,'esMX','61 TEST Green Shaman Ring',NULL,0),
(27249,'esMX','62 TEST Green Shaman Ring',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27250,27251,27252,27253,27254,27255,27256,27257,27258,27259,27260,27261,27262,27263,27264,27265,27266,27267,27268,27269) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27250,'esMX','63 TEST Green Shaman Ring',NULL,0),
(27251,'esMX','64 TEST Green Shaman Ring',NULL,0),
(27252,'esMX','65 TEST Green Shaman Ring',NULL,0),
(27253,'esMX','66 TEST Green Shaman Ring',NULL,0),
(27254,'esMX','67 TEST Green Shaman Ring',NULL,0),
(27255,'esMX','68 TEST Green Shaman Ring',NULL,0),
(27256,'esMX','69 TEST Green Shaman Ring',NULL,0),
(27257,'esMX','70 TEST Green Shaman Ring',NULL,0),
(27258,'esMX','71 TEST Green Shaman Ring',NULL,0),
(27259,'esMX','72 TEST Green Shaman Ring',NULL,0),
(27260,'esMX','59 TEST Green Shaman Necklace',NULL,0),
(27261,'esMX','60 TEST Green Shaman Necklace',NULL,0),
(27262,'esMX','61 TEST Green Shaman Necklace',NULL,0),
(27263,'esMX','62 TEST Green Shaman Necklace',NULL,0),
(27264,'esMX','63 TEST Green Shaman Necklace',NULL,0),
(27265,'esMX','64 TEST Green Shaman Necklace',NULL,0),
(27266,'esMX','65 TEST Green Shaman Necklace',NULL,0),
(27267,'esMX','66 TEST Green Shaman Necklace',NULL,0),
(27268,'esMX','67 TEST Green Shaman Necklace',NULL,0),
(27269,'esMX','68 TEST Green Shaman Necklace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27270,27271,27272,27273,27274,27275,27276,27277,27278,27279,27280,27281,27282,27283,27284,27285,27286,27287,27288,27289) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27270,'esMX','69 TEST Green Shaman Necklace',NULL,0),
(27271,'esMX','70 TEST Green Shaman Necklace',NULL,0),
(27272,'esMX','71 TEST Green Shaman Necklace',NULL,0),
(27273,'esMX','72 TEST Green Shaman Necklace',NULL,0),
(27274,'esMX','59 TEST Green Paladin Cloak',NULL,0),
(27275,'esMX','60 TEST Green Paladin Cloak',NULL,0),
(27276,'esMX','61 TEST Green Paladin Cloak',NULL,0),
(27277,'esMX','62 TEST Green Paladin Cloak',NULL,0),
(27278,'esMX','63 TEST Green Paladin Cloak',NULL,0),
(27279,'esMX','64 TEST Green Paladin Cloak',NULL,0),
(27280,'esMX','65 TEST Green Paladin Cloak',NULL,0),
(27281,'esMX','66 TEST Green Paladin Cloak',NULL,0),
(27282,'esMX','67 TEST Green Paladin Cloak',NULL,0),
(27283,'esMX','68 TEST Green Paladin Cloak',NULL,0),
(27284,'esMX','69 TEST Green Paladin Cloak',NULL,0),
(27285,'esMX','70 TEST Green Paladin Cloak',NULL,0),
(27286,'esMX','71 TEST Green Paladin Cloak',NULL,0),
(27287,'esMX','72 TEST Green Paladin Cloak',NULL,0),
(27288,'esMX','59 TEST Green Paladin Ring',NULL,0),
(27289,'esMX','60 TEST Green Paladin Ring',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27290,27291,27292,27293,27294,27295,27296,27297,27298,27299,27300,27301,27302,27303,27304,27305,27306,27307,27308,27309) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27290,'esMX','61 TEST Green Paladin Ring',NULL,0),
(27291,'esMX','62 TEST Green Paladin Ring',NULL,0),
(27292,'esMX','63 TEST Green Paladin Ring',NULL,0),
(27293,'esMX','64 TEST Green Paladin Ring',NULL,0),
(27294,'esMX','65 TEST Green Paladin Ring',NULL,0),
(27295,'esMX','66 TEST Green Paladin Ring',NULL,0),
(27296,'esMX','67 TEST Green Paladin Ring',NULL,0),
(27297,'esMX','68 TEST Green Paladin Ring',NULL,0),
(27298,'esMX','69 TEST Green Paladin Ring',NULL,0),
(27299,'esMX','70 TEST Green Paladin Ring',NULL,0),
(27300,'esMX','71 TEST Green Paladin Ring',NULL,0),
(27301,'esMX','72 TEST Green Paladin Ring',NULL,0),
(27302,'esMX','59 TEST Green Paladin Necklace',NULL,0),
(27303,'esMX','60 TEST Green Paladin Necklace',NULL,0),
(27304,'esMX','61 TEST Green Paladin Necklace',NULL,0),
(27305,'esMX','62 TEST Green Paladin Necklace',NULL,0),
(27306,'esMX','63 TEST Green Paladin Necklace',NULL,0),
(27307,'esMX','64 TEST Green Paladin Necklace',NULL,0),
(27308,'esMX','65 TEST Green Paladin Necklace',NULL,0),
(27309,'esMX','66 TEST Green Paladin Necklace',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27310,27311,27312,27313,27314,27315,27316,27318,27319,27320,27321,27322,27323,27324,27325,27326,27327,27328,27329,27330) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27310,'esMX','67 TEST Green Paladin Necklace',NULL,0),
(27311,'esMX','68 TEST Green Paladin Necklace',NULL,0),
(27312,'esMX','69 TEST Green Paladin Necklace',NULL,0),
(27313,'esMX','70 TEST Green Paladin Necklace',NULL,0),
(27314,'esMX','71 TEST Green Paladin Necklace',NULL,0),
(27315,'esMX','72 TEST Green Paladin Necklace',NULL,0),
(27316,'esMX','Level 61 Test Gear Green - Cloth',NULL,0),
(27318,'esMX','Level 62 Test Gear Green - Cloth',NULL,0),
(27319,'esMX','Level 63 Test Gear Green - Cloth',NULL,0),
(27320,'esMX','Level 64 Test Gear Green - Cloth',NULL,0),
(27321,'esMX','Level 65 Test Gear Green - Cloth',NULL,0),
(27322,'esMX','Level 66 Test Gear Green - Cloth',NULL,0),
(27323,'esMX','Level 67 Test Gear Green - Cloth',NULL,0),
(27324,'esMX','Level 68 Test Gear Green - Cloth',NULL,0),
(27325,'esMX','Level 69 Test Gear Green - Cloth',NULL,0),
(27326,'esMX','Level 70 Test Gear Green - Cloth',NULL,0),
(27327,'esMX','Level 61 Test Gear Green - Leather - Rogue',NULL,0),
(27328,'esMX','Level 62 Test Gear Green - Leather - Rogue',NULL,0),
(27329,'esMX','Level 63 Test Gear Green - Leather - Rogue',NULL,0),
(27330,'esMX','Level 64 Test Gear Green - Leather - Rogue',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27331,27332,27333,27334,27335,27336,27337,27338,27339,27340,27341,27342,27343,27344,27345,27346,27347,27348,27349,27350) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27331,'esMX','Level 65 Test Gear Green - Leather - Rogue',NULL,0),
(27332,'esMX','Level 66 Test Gear Green - Leather - Rogue',NULL,0),
(27333,'esMX','Level 67 Test Gear Green - Leather - Rogue',NULL,0),
(27334,'esMX','Level 68 Test Gear Green - Leather - Rogue',NULL,0),
(27335,'esMX','Level 69 Test Gear Green - Leather - Rogue',NULL,0),
(27336,'esMX','Level 70 Test Gear Green - Leather - Rogue',NULL,0),
(27337,'esMX','Level 61 Test Gear Green - Leather - Druid',NULL,0),
(27338,'esMX','Level 62 Test Gear Green - Leather - Druid',NULL,0),
(27339,'esMX','Level 63 Test Gear Green - Leather - Druid',NULL,0),
(27340,'esMX','Level 64 Test Gear Green - Leather - Druid',NULL,0),
(27341,'esMX','Level 65 Test Gear Green - Leather - Druid',NULL,0),
(27342,'esMX','Level 66 Test Gear Green - Leather - Druid',NULL,0),
(27343,'esMX','Level 67 Test Gear Green - Leather - Druid',NULL,0),
(27344,'esMX','Level 68 Test Gear Green - Leather - Druid',NULL,0),
(27345,'esMX','Level 69 Test Gear Green - Leather - Druid',NULL,0),
(27346,'esMX','Level 70 Test Gear Green - Leather - Druid',NULL,0),
(27347,'esMX','Level 61 Test Gear Green - Mail - Hunter',NULL,0),
(27348,'esMX','Level 62 Test Gear Green - Mail - Hunter',NULL,0),
(27349,'esMX','Level 63 Test Gear Green - Mail - Hunter',NULL,0),
(27350,'esMX','Level 64 Test Gear Green - Mail - Hunter',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27351,27352,27353,27354,27355,27356,27357,27358,27359,27360,27361,27362,27363,27364,27365,27366,27367,27368,27369,27370) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27351,'esMX','Level 65 Test Gear Green - Mail - Hunter',NULL,0),
(27352,'esMX','Level 66 Test Gear Green - Mail - Hunter',NULL,0),
(27353,'esMX','Level 67 Test Gear Green - Mail - Hunter',NULL,0),
(27354,'esMX','Level 68 Test Gear Green - Mail - Hunter',NULL,0),
(27355,'esMX','Level 69 Test Gear Green - Mail - Hunter',NULL,0),
(27356,'esMX','Level 70 Test Gear Green - Mail - Hunter',NULL,0),
(27357,'esMX','Poción de visión superior','Bébela para abrir tus caminos espirituales y ver lo que no ves normalmente.',0),
(27358,'esMX','Level 61 Test Gear Green - Plate - Pally',NULL,0),
(27359,'esMX','Level 62 Test Gear Green - Plate - Pally',NULL,0),
(27360,'esMX','Level 63 Test Gear Green - Plate - Pally',NULL,0),
(27361,'esMX','Level 64 Test Gear Green - Plate - Pally',NULL,0),
(27362,'esMX','Level 65 Test Gear Green - Plate - Pally',NULL,0),
(27363,'esMX','Level 66 Test Gear Green - Plate - Pally',NULL,0),
(27364,'esMX','Level 67 Test Gear Green - Plate - Pally',NULL,0),
(27365,'esMX','Level 68 Test Gear Green - Plate - Pally',NULL,0),
(27366,'esMX','Level 69 Test Gear Green - Plate - Pally',NULL,0),
(27367,'esMX','Level 70 Test Gear Green - Plate - Pally',NULL,0),
(27368,'esMX','Level 61 Test Gear Green - Plate - Warrior',NULL,0),
(27369,'esMX','Level 62 Test Gear Green - Plate - Warrior',NULL,0),
(27370,'esMX','Level 63 Test Gear Green - Plate - Warrior',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27371,27372,27373,27374,27375,27376,27377,27378,27379,27380,27381,27382,27383,27384,27385,27386,27387,27391,27392,27393) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27371,'esMX','Level 64 Test Gear Green - Plate - Warrior',NULL,0),
(27372,'esMX','Level 65 Test Gear Green - Plate - Warrior',NULL,0),
(27373,'esMX','Level 66 Test Gear Green - Plate - Warrior',NULL,0),
(27374,'esMX','Level 67 Test Gear Green - Plate - Warrior',NULL,0),
(27375,'esMX','Level 68 Test Gear Green - Plate - Warrior',NULL,0),
(27376,'esMX','Level 69 Test Gear Green - Plate - Warrior',NULL,0),
(27377,'esMX','Level 70 Test Gear Green - Plate - Warrior',NULL,0),
(27378,'esMX','Level 61 Test Gear Green - Mail - Shaman',NULL,0),
(27379,'esMX','Level 62 Test Gear Green - Mail - Shaman',NULL,0),
(27380,'esMX','Level 63 Test Gear Green - Mail - Shaman',NULL,0),
(27381,'esMX','Level 64 Test Gear Green - Mail - Shaman',NULL,0),
(27382,'esMX','Level 65 Test Gear Green - Mail - Shaman',NULL,0),
(27383,'esMX','Level 66 Test Gear Green - Mail - Shaman',NULL,0),
(27384,'esMX','Level 67 Test Gear Green - Mail - Shaman',NULL,0),
(27385,'esMX','Level 68 Test Gear Green - Mail - Shaman',NULL,0),
(27386,'esMX','Level 69 Test Gear Green - Mail - Shaman',NULL,0),
(27387,'esMX','Level 70 Test Gear Green - Mail - Shaman',NULL,0),
(27391,'esMX','Level 60 Test Gear Green - Cloth',NULL,0),
(27392,'esMX','Level 60 Test Gear Green - Leather - Druid',NULL,0),
(27393,'esMX','Level 60 Test Gear Green - Leather - Rogue',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27394,27395,27396,27397,27405,27406,27407,27421,27444,27486,27496,27530,27554,27555,27556,27557,27558,27559,27560,27561) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27394,'esMX','Level 60 Test Gear Green - Mail - Hunter',NULL,0),
(27395,'esMX','Level 60 Test Gear Green - Mail - Shaman',NULL,0),
(27396,'esMX','Level 60 Test Gear Green - Plate - Pally',NULL,0),
(27397,'esMX','Level 60 Test Gear Green - Plate - Warrior',NULL,0),
(27405,'esMX','Monster - Sword, 1H Blood Elf A03 (Blood Knight)',NULL,0),
(27406,'esMX','Monster - Shield, Blood Elf (Blood Knight)',NULL,0),
(27407,'esMX','Monster - Mace, Draenei A02 Gold',NULL,0),
(27421,'esMX','Planes de Campamento Forja: Ira',NULL,0),
(27444,'esMX','Aleta mácula',NULL,0),
(27486,'esMX','Alex Test BK Helm',NULL,0),
(27496,'esMX','Monster - Dagger, Blood Elf A01 Black',NULL,0),
(27530,'esMX','Test Epic Belt',NULL,0),
(27554,'esMX','Level 60 Test Gear Green - Cloth 2',NULL,0),
(27555,'esMX','Level 61 Test Gear Green - Cloth 2',NULL,0),
(27556,'esMX','Level 62 Test Gear Green - Cloth 2',NULL,0),
(27557,'esMX','Level 63 Test Gear Green - Cloth 2',NULL,0),
(27558,'esMX','Level 64 Test Gear Green - Cloth 2',NULL,0),
(27559,'esMX','Level 65 Test Gear Green - Cloth 2',NULL,0),
(27560,'esMX','Level 66 Test Gear Green - Cloth 2',NULL,0),
(27561,'esMX','Level 67 Test Gear Green - Cloth 2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27562,27563,27564,27565,27566,27567,27568,27569,27570,27571,27572,27573,27574,27575,27576,27577,27578,27579,27580,27581) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27562,'esMX','Level 68 Test Gear Green - Cloth 2',NULL,0),
(27563,'esMX','Level 69 Test Gear Green - Cloth 2',NULL,0),
(27564,'esMX','Level 70 Test Gear Green - Cloth 2',NULL,0),
(27565,'esMX','Level 60 Test Gear Green - Leather - Druid 2',NULL,0),
(27566,'esMX','Level 61 Test Gear Green - Leather - Druid 2',NULL,0),
(27567,'esMX','Level 62 Test Gear Green - Leather - Druid 2',NULL,0),
(27568,'esMX','Level 63 Test Gear Green - Leather - Druid 2',NULL,0),
(27569,'esMX','Level 64 Test Gear Green - Leather - Druid 2',NULL,0),
(27570,'esMX','Level 65 Test Gear Green - Leather - Druid 2',NULL,0),
(27571,'esMX','Level 66 Test Gear Green - Leather - Druid 2',NULL,0),
(27572,'esMX','Level 67 Test Gear Green - Leather - Druid 2',NULL,0),
(27573,'esMX','Level 68 Test Gear Green - Leather - Druid 2',NULL,0),
(27574,'esMX','Level 69 Test Gear Green - Leather - Druid 2',NULL,0),
(27575,'esMX','Level 70 Test Gear Green - Leather - Druid 2',NULL,0),
(27576,'esMX','Level 60 Test Gear Green - Leather - Rogue 2',NULL,0),
(27577,'esMX','Level 61 Test Gear Green - Leather - Rogue 2',NULL,0),
(27578,'esMX','Level 62 Test Gear Green - Leather - Rogue 2',NULL,0),
(27579,'esMX','Level 63 Test Gear Green - Leather - Rogue 2',NULL,0),
(27580,'esMX','Level 64 Test Gear Green - Leather - Rogue 2',NULL,0),
(27581,'esMX','Level 65 Test Gear Green - Leather - Rogue 2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27582,27583,27584,27585,27586,27587,27588,27589,27591,27592,27593,27594,27595,27596,27597,27598,27599,27600,27601,27602) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27582,'esMX','Level 66 Test Gear Green - Leather - Rogue 2',NULL,0),
(27583,'esMX','Level 70 Test Gear Green - Leather - Rogue 2',NULL,0),
(27584,'esMX','Level 69 Test Gear Green - Leather - Rogue 2',NULL,0),
(27585,'esMX','Level 68 Test Gear Green - Leather - Rogue 2',NULL,0),
(27586,'esMX','Level 67 Test Gear Green - Leather - Rogue 2',NULL,0),
(27587,'esMX','Level 60 Test Gear Green - Mail - Hunter 2',NULL,0),
(27588,'esMX','Level 61 Test Gear Green - Mail - Hunter 2',NULL,0),
(27589,'esMX','Level 62 Test Gear Green - Mail - Hunter 2',NULL,0),
(27591,'esMX','Level 70 Test Gear Green - Mail - Hunter 2',NULL,0),
(27592,'esMX','Level 69 Test Gear Green - Mail - Hunter 2',NULL,0),
(27593,'esMX','Level 68 Test Gear Green - Mail - Hunter 2',NULL,0),
(27594,'esMX','Level 67 Test Gear Green - Mail - Hunter 2',NULL,0),
(27595,'esMX','Level 66 Test Gear Green - Mail - Hunter 2',NULL,0),
(27596,'esMX','Level 65 Test Gear Green - Mail - Hunter 2',NULL,0),
(27597,'esMX','Level 64 Test Gear Green - Mail - Hunter 2',NULL,0),
(27598,'esMX','Nivel 70 equipo verde de prueba - anillas - Chamán 2',NULL,0),
(27599,'esMX','Nivel 69 equipo verde de prueba - anillas - Chamán 2',NULL,0),
(27600,'esMX','Nivel 68 equipo verde de prueba - anillas - Chamán 2',NULL,0),
(27601,'esMX','Level 67 Test Gear Green - Mail - Shaman 2',NULL,0),
(27602,'esMX','Level 66 Test Gear Green - Mail - Shaman 2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27603,27604,27605,27606,27607,27608,27609,27610,27611,27612,27613,27614,27615,27616,27617,27618,27619,27620,27621,27622) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27603,'esMX','Level 65 Test Gear Green - Mail - Shaman 2',NULL,0),
(27604,'esMX','Level 64 Test Gear Green - Mail - Shaman 2',NULL,0),
(27605,'esMX','Level 63 Test Gear Green - Mail - Shaman 2',NULL,0),
(27606,'esMX','Level 62 Test Gear Green - Mail - Shaman 2',NULL,0),
(27607,'esMX','Level 61 Test Gear Green - Mail - Shaman 2',NULL,0),
(27608,'esMX','Level 60 Test Gear Green - Mail - Shaman 2',NULL,0),
(27609,'esMX','Level 70 Test Gear Green - Plate - Pally 2',NULL,0),
(27610,'esMX','Level 69 Test Gear Green - Plate - Pally 2',NULL,0),
(27611,'esMX','Level 68 Test Gear Green - Plate - Pally 2',NULL,0),
(27612,'esMX','Level 67 Test Gear Green - Plate - Pally 2',NULL,0),
(27613,'esMX','Level 66 Test Gear Green - Plate - Pally 2',NULL,0),
(27614,'esMX','Level 65 Test Gear Green - Plate - Pally 2',NULL,0),
(27615,'esMX','Level 64 Test Gear Green - Plate - Pally 2',NULL,0),
(27616,'esMX','Level 63 Test Gear Green - Plate - Pally 2',NULL,0),
(27617,'esMX','Level 62 Test Gear Green - Plate - Pally 2',NULL,0),
(27618,'esMX','Level 61 Test Gear Green - Plate - Pally 2',NULL,0),
(27619,'esMX','Level 60 Test Gear Green - Plate - Pally 2',NULL,0),
(27620,'esMX','Level 70 Test Gear Green - Plate - Warrior 2',NULL,0),
(27621,'esMX','Level 69 Test Gear Green - Plate - Warrior 2',NULL,0),
(27622,'esMX','Level 68 Test Gear Green - Plate - Warrior 2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27623,27624,27625,27626,27627,27628,27629,27630,27701,27808,27819,27836,27849,27850,27851,27852,27853,27862,27894,27923) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27623,'esMX','Level 67 Test Gear Green - Plate - Warrior 2',NULL,0),
(27624,'esMX','Level 66 Test Gear Green - Plate - Warrior 2',NULL,0),
(27625,'esMX','Level 65 Test Gear Green - Plate - Warrior 2',NULL,0),
(27626,'esMX','Level 64 Test Gear Green - Plate - Warrior 2',NULL,0),
(27627,'esMX','Level 63 Test Gear Green - Plate - Warrior 2',NULL,0),
(27628,'esMX','Level 62 Test Gear Green - Plate - Warrior 2',NULL,0),
(27629,'esMX','Level 61 Test Gear Green - Plate - Warrior 2',NULL,0),
(27630,'esMX','Level 60 Test Gear Green - Plate - Warrior 2',NULL,0),
(27701,'esMX','Monster - Mace, Durn',NULL,0),
(27808,'esMX','Llave del Saltatrón 4000','Grabado en un lateral: Wazat se exime de toda responsabilidad en caso de accidente a consecuencia de usar el Saltatrón 4000.',0),
(27819,'esMX','Raptor loco 75',NULL,0),
(27836,'esMX','Monster - Mace, Ornate Metal Hammer (Red Fire)',NULL,0),
(27849,'esMX','Monster - Axe, 1H Large Double Bladed (Broken)',NULL,0),
(27850,'esMX','Monster - Axe, 1H Hot Steel (Broken)',NULL,0),
(27851,'esMX','Monster - Shield (Broken)',NULL,0),
(27852,'esMX','Monster - Mace2H (Broken)',NULL,0),
(27853,'esMX','Raptor loco 150',NULL,0),
(27862,'esMX','Monster - Mace2H, Olhorn Totem',NULL,0),
(27894,'esMX','Melena enredada',NULL,0),
(27923,'esMX','Monster - Staff, Coryth''s',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27950,27951,27952,27953,27954,27955,27956,27957,27958,27959,27960,27961,27962,27963,27964,27966,27967,27968,27969,27970) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27950,'esMX','TEST 60 Blue Paladin DPS Belt',NULL,0),
(27951,'esMX','TEST 60 Blue Paladin DPS Boot',NULL,0),
(27952,'esMX','TEST 60 Blue Paladin DPS Chest',NULL,0),
(27953,'esMX','TEST 60 Blue Paladin DPS Hand',NULL,0),
(27954,'esMX','TEST 60 Blue Paladin DPS Head',NULL,0),
(27955,'esMX','TEST 60 Blue Paladin DPS Legs',NULL,0),
(27956,'esMX','TEST 60 Blue Paladin DPS Shoulder',NULL,0),
(27957,'esMX','TEST 60 Blue Paladin DPS Wrist',NULL,0),
(27958,'esMX','TEST 60 Blue Paladin DPS Necklace',NULL,0),
(27959,'esMX','TEST 60 Blue Paladin DPS Ring',NULL,0),
(27960,'esMX','TEST 60 Blue Paladin DPS Cloak',NULL,0),
(27961,'esMX','TEST 60 Blue Paladin DPS Sword2H Slow',NULL,0),
(27962,'esMX','TEST 60 Blue Paladin DPS Sword2H Fast',NULL,0),
(27963,'esMX','TEST 130 Epic Paladin DPS Belt',NULL,0),
(27964,'esMX','TEST 130 Epic Paladin DPS Boot',NULL,0),
(27966,'esMX','TEST 130 Epic Paladin DPS Hand',NULL,0),
(27967,'esMX','TEST 130 Epic Paladin DPS Head',NULL,0),
(27968,'esMX','TEST 130 Epic Paladin DPS Legs',NULL,0),
(27969,'esMX','TEST 130 Epic Paladin DPS Shoulder',NULL,0),
(27970,'esMX','TEST 130 Epic Paladin DPS Wrist',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(27971,27972,27973,27974,27975,27997,27998,27999,28000,28001,28002,28003,28004,28005,28006,28007,28008,28009,28010,28011) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(27971,'esMX','TEST 130 Epic Paladin DPS Necklace',NULL,0),
(27972,'esMX','TEST 130 Epic Paladin DPS Ring',NULL,0),
(27973,'esMX','TEST 130 Epic Paladin DPS Cloak',NULL,0),
(27974,'esMX','TEST 130 Epic Paladin DPS Sword2H Slow',NULL,0),
(27975,'esMX','TEST 130 Epic Paladin DPS Sword2H Fast',NULL,0),
(27997,'esMX','TEST 60 Blue Ret Paladin DPS Belt',NULL,0),
(27998,'esMX','TEST 60 Blue Ret Paladin DPS Boot',NULL,0),
(27999,'esMX','TEST 60 Blue Ret Paladin DPS Chest',NULL,0),
(28000,'esMX','TEST 60 Blue Ret Paladin DPS Hand',NULL,0),
(28001,'esMX','TEST 60 Blue Ret Paladin DPS Head',NULL,0),
(28002,'esMX','TEST 60 Blue Ret Paladin DPS Legs',NULL,0),
(28003,'esMX','TEST 60 Blue Ret Paladin DPS Shoulder',NULL,0),
(28004,'esMX','TEST 60 Blue Ret Paladin DPS Wrist',NULL,0),
(28005,'esMX','TEST 60 Blue Ret Paladin DPS Necklace',NULL,0),
(28006,'esMX','TEST 60 Blue Ret Paladin DPS Ring',NULL,0),
(28007,'esMX','TEST 60 Blue Ret Paladin DPS Cloak',NULL,0),
(28008,'esMX','TEST 60 Blue Ret Paladin DPS Sword2H Slow',NULL,0),
(28009,'esMX','TEST 60 Blue Ret Paladin DPS Sword2H Fast',NULL,0),
(28010,'esMX','TEST 130 Epic Ret Paladin DPS Belt',NULL,0),
(28011,'esMX','TEST 130 Epic Ret Paladin DPS Boot',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(28012,28013,28014,28015,28016,28017,28018,28019,28020,28021,28022,28025,28037,28043,28044,28046,28049,28067,28076,28077) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(28012,'esMX','TEST 130 Epic Ret Paladin DPS Chest',NULL,0),
(28013,'esMX','TEST 130 Epic Ret Paladin DPS Hand',NULL,0),
(28014,'esMX','TEST 130 Epic Ret Paladin DPS Head',NULL,0),
(28015,'esMX','TEST 130 Epic Ret Paladin DPS Legs',NULL,0),
(28016,'esMX','TEST 130 Epic Ret Paladin DPS Shoulder',NULL,0),
(28017,'esMX','TEST 130 Epic Ret Paladin DPS Wrist',NULL,0),
(28018,'esMX','TEST 130 Epic Ret Paladin DPS Necklace',NULL,0),
(28019,'esMX','TEST 130 Epic Ret Paladin DPS Ring',NULL,0),
(28020,'esMX','TEST 130 Epic Ret Paladin DPS Cloak',NULL,0),
(28021,'esMX','TEST 130 Epic Ret Paladin DPS Sword2H Slow',NULL,0),
(28022,'esMX','TEST 130 Epic Ret Paladin DPS Sword2H Fast',NULL,0),
(28025,'esMX','Videomontura','Debug - Video Mount',0),
(28037,'esMX','Monster - Sword, Shivan',NULL,0),
(28043,'esMX','Colgante de acechademonios',NULL,0),
(28044,'esMX','Sortija del acechademonios',NULL,0),
(28046,'esMX','Misiva de la Legión','Lleva el sello de Arazzius.',0),
(28049,'esMX','(Deprecated)Gems of Goliathon',NULL,0),
(28067,'esMX','Monster - Staff, Atiesh (Medivh''s)',NULL,0),
(28076,'esMX','Level 60 Test Gear Green - Leather - Rogue 3',NULL,0),
(28077,'esMX','Level 61 Test Gear Green - Leather - Rogue 3',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(28078,28079,28080,28081,28082,28083,28084,28085,28086,28087,28088,28089,28090,28091,28092,28093,28094,28095,28096,28097) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(28078,'esMX','Level 62 Test Gear Green - Leather - Rogue 3',NULL,0),
(28079,'esMX','Level 63 Test Gear Green - Leather - Rogue 3',NULL,0),
(28080,'esMX','Level 64 Test Gear Green - Leather - Rogue 3',NULL,0),
(28081,'esMX','Level 65 Test Gear Green - Leather - Rogue 3',NULL,0),
(28082,'esMX','Level 66 Test Gear Green - Leather - Rogue 3',NULL,0),
(28083,'esMX','Level 67 Test Gear Green - Leather - Rogue 3',NULL,0),
(28084,'esMX','Level 68 Test Gear Green - Leather - Rogue 3',NULL,0),
(28085,'esMX','Level 69 Test Gear Green - Leather - Rogue 3',NULL,0),
(28086,'esMX','Level 70 Test Gear Green - Leather - Rogue 3',NULL,0),
(28087,'esMX','Monster - Sword, Iblis, Blade of the Fallen Seraph',NULL,0),
(28088,'esMX','Level 60 Test Gear Green - Plate - Warrior 3',NULL,0),
(28089,'esMX','Level 61 Test Gear Green - Plate - Warrior 3',NULL,0),
(28090,'esMX','Level 62 Test Gear Green - Plate - Warrior 3',NULL,0),
(28091,'esMX','Level 63 Test Gear Green - Plate - Warrior 3',NULL,0),
(28092,'esMX','Level 64 Test Gear Green - Plate - Warrior 3',NULL,0),
(28093,'esMX','Level 65 Test Gear Green - Plate - Warrior 3',NULL,0),
(28094,'esMX','Level 66 Test Gear Green - Plate - Warrior 3',NULL,0),
(28095,'esMX','Level 67 Test Gear Green - Plate - Warrior 3',NULL,0),
(28096,'esMX','Level 68 Test Gear Green - Plate - Warrior 3',NULL,0),
(28097,'esMX','Level 69 Test Gear Green - Plate - Warrior 3',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(28098,28107,28110,28113,28114,28115,28125,28131,28133,28135,28165,28195,28196,28197,28198,28199,28200,28201,28208,28261) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(28098,'esMX','Level 70 Test Gear Green - Plate - Warrior 3',NULL,0),
(28107,'esMX','Misiva de la Legión','Lleva el sello de Arazzius.',0),
(28110,'esMX','Gnomón y elfito',NULL,0),
(28113,'esMX','Órdenes del dirigente de guerra Nekrogg',NULL,0),
(28114,'esMX','Órdenes del dirigente de guerra Nekrogg',NULL,0),
(28115,'esMX','Monster - Obsidian Edged Blade',NULL,0),
(28125,'esMX','Monster - Sword2H, Vazruden',NULL,0),
(28131,'esMX','Lanza explosiones de espetadora',NULL,0),
(28133,'esMX','Monster - Sword, Shivan D01',NULL,0),
(28135,'esMX','Cajón de bombas','Precaución: contiene bombas.',0),
(28165,'esMX','TEST GUN RocketLauncher',NULL,0),
(28195,'esMX','Monster - Staff, Ethereal (Black)',NULL,0),
(28196,'esMX','Monster - Staff, Ethereal (Gold)',NULL,0),
(28197,'esMX','Monster - Staff, Ethereal (Gray)',NULL,0),
(28198,'esMX','Monster - Staff, Ethereal (Purple)',NULL,0),
(28199,'esMX','Monster - Staff, Ethereal (White)',NULL,0),
(28200,'esMX','Monster - Staff, Ethereal (Black) (White Glow)',NULL,0),
(28201,'esMX','Monster - Mace, Ethereal (Orange)',NULL,0),
(28208,'esMX','Monster - Staff, Ethereal (White) (Black Glow)',NULL,0),
(28261,'esMX','Video Invis','Debug - Video Invis',0);

DELETE FROM `item_template_locale` WHERE `ID` IN(28289,28354,28365,28366,28456,28471,28487,28488,28546,28549,28598,28648,28650,28678,28736,28737,28798,28816,28906,28914) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(28289,'esMX','Silbato de dracohalcón',NULL,0),
(28354,'esMX','Monster - Axe, 2H Draenei B01 Red',NULL,0),
(28365,'esMX','Monster - Glaive - Magtheridon',NULL,0),
(28366,'esMX','Test Orb',NULL,0),
(28456,'esMX','Monster - Staff, Archmage Vargoth''s',NULL,0),
(28471,'esMX','Compendio de Krasus',NULL,0),
(28487,'esMX','Monster - Work Wrench, Ethereal (Purple Glow)',NULL,0),
(28488,'esMX','Monster - Sword2H, Draenei A02 Purple',NULL,0),
(28546,'esMX','TEST Tabard',NULL,0),
(28549,'esMX','Historia del arsenal','Un tomo indescifrable que llevaba un espíritu implacable.',0),
(28598,'esMX','Manual de construcción de atracador vil',NULL,0),
(28648,'esMX','Monster - Item, Book - Book of the Dead (Skull)',NULL,0),
(28650,'esMX','Monster - Polearm, Battle Scythe',NULL,0),
(28678,'esMX','Monster - Dagger, Curvey Silver - Purple Glow',NULL,0),
(28736,'esMX','Monster - Mace, Aurastone Hammer',NULL,0),
(28737,'esMX','Monster - Shield, Malistar''s Defender',NULL,0),
(28798,'esMX','Distintivo del protector','Por su heroísmo en la batalla del Portal Oscuro',0),
(28816,'esMX','QATest +400 Spell Dmg Ring',NULL,0),
(28906,'esMX','Monster - Claw, Badass offhand',NULL,0),
(28914,'esMX','Monster - Spear, Darkspear',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(28916,28965,29052,29107,29114,29188,29208,29293,29310,29311,29402,29403,29404,29405,29406,29407,29408,29409,29413,29414) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(28916,'esMX','Monster - Sword2H, Sin''dorei Warblade',NULL,0),
(28965,'esMX','Monster - Trident, Ornate (Red Glow)',NULL,0),
(29052,'esMX','Extractor de abismo de distorsión','Un instrumento extraño fabricado por Ogath el Loco.',0),
(29107,'esMX','Monster - Staff, Jeweled Blue Staff, Blue Glow',NULL,0),
(29114,'esMX','Monster - Staff, Blood Elf A02 Red - High Red Glow',NULL,0),
(29188,'esMX','zzoldGlyph of the Wild',NULL,0),
(29208,'esMX','Test Ammo Expansion 65 Lockbox',NULL,0),
(29293,'esMX','Alitas picantes de águila ratonera limpiahuesos',NULL,0),
(29310,'esMX','Monster - Staff, Red Feathered - Red Glow',NULL,0),
(29311,'esMX','Manual de construcción de atracador vil',NULL,0),
(29402,'esMX','Jessen''s Special Slop OLD',NULL,0),
(29403,'esMX','Monster - Sword, 1H Blood Elf A01 Gold - Red Glow',NULL,0),
(29404,'esMX','Monster - Sword, 1H Blood Elf A01 Gold - White Glow',NULL,0),
(29405,'esMX','Monster - Sword, 1H Blood Elf A01 Gold - Blue Glow',NULL,0),
(29406,'esMX','Monster - Sword, 1H Blood Elf A01 Gold - Black Glow',NULL,0),
(29407,'esMX','Monster - Mace2H, Warhammer Ebony - Red Flame',NULL,0),
(29408,'esMX','Monster - Mace2H, Warhammer Ebony - Black Flame',NULL,0),
(29409,'esMX','Monster - Mace2H, Warhammer Ebony - Blue Flame',NULL,0),
(29413,'esMX','Monster - Glaive - 2 Blade Purple - Ethereal, Consortium (Purple Glow)',NULL,0),
(29414,'esMX','Monster - Glaive - 4 Blade Purple - Ethereal, Consortium (Purple Glow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29415,29416,29417,29418,29420,29421,29422,29423,29424,29427,29430,29431,29432,29433,29435,29436,29437,29438,29439,29440) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29415,'esMX','Monster - Glaive - Crystal Scimitar - Ethereal, Consortium (Yellow)',NULL,0),
(29416,'esMX','Monster - Glaive - Staff - Ethereal, Consortium',NULL,0),
(29417,'esMX','Monster - Axe - Ethereal, Consortium (Purple Glow)',NULL,0),
(29418,'esMX','Monster - Glaive - 2 Blade Purple - Ethereal, Ethereum (Red Glow)',NULL,0),
(29420,'esMX','Monster - Sword - 2H Crystal - Ethereal, Ethereum (Red Glow)',NULL,0),
(29421,'esMX','Monster - Staff - 2H Crystal - Ethereal, Ethereum (Red Glow)',NULL,0),
(29422,'esMX','Monster - Axe - Ethereal, Ethereum (Red Glow)',NULL,0),
(29423,'esMX','Monster - Mace - 2H Crystal - Ethereal, Ethereum (Red Glow)',NULL,0),
(29424,'esMX','Monster - Mace - 1H Crystal - Ethereal, Ethereum (Red Glow)',NULL,0),
(29427,'esMX','Marca del Traidor',NULL,0),
(29430,'esMX','Monster - Glaive - 2 Blade Purple - Protectorate (White Glow)',NULL,0),
(29431,'esMX','Monster - Staff, Ethereal (Black) (Red Glow)',NULL,0),
(29432,'esMX','Monster - Staff, Ethereal (Gold) (Red Glow)',NULL,0),
(29433,'esMX','Monster - Glaive - 2 Blade B03 Red - High Red Glow',NULL,0),
(29435,'esMX','Monster - Dagger, Curvey Silver - Red Glow',NULL,0),
(29436,'esMX','Monster - Axe - Ethereal, Protectorate (White Glow)',NULL,0),
(29437,'esMX','Monster - Glaive - 2 Blade Purple - Ethereal, Protectorate (White Glow)',NULL,0),
(29438,'esMX','Monster - Glaive - 4 Blade Purple - Ethereal, Protectorate (White Glow)',NULL,0),
(29439,'esMX','Monster - Sword - Crystal Scimitar - Ethereal, Protectorate (White Glow, Pink Crystal)',NULL,0),
(29440,'esMX','Monster - Staff - 2H Crystal - Ethereal, Protectorate (White Glow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29441,29442,29444,29446,29455,29462,29479,29484,29537,29538,29541,29542,29543,29544,29551,29552,29557,29558,29566,29585) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29441,'esMX','Monster - Staff - 2H Crystal - Ethereal, Consortium (Purple Glow)',NULL,0),
(29442,'esMX','Monster - Staff, Ethereal (Purple) (Purple Glow)',NULL,0),
(29444,'esMX','Monster - Glaive - 2 Blade Purple - Ethereal, Ethereum Darkstalker (Black Glow)',NULL,0),
(29446,'esMX','Monster - Sword, Frost Battlemage Longsword',NULL,0),
(29455,'esMX','Monster - Mace2H, Gear (Red, Green Glow)',NULL,0),
(29462,'esMX','Monster - Sword - Crystal - Ethereal, Protectorate (White Glow)',NULL,0),
(29479,'esMX','Monster - Mace2H, Firemaul of Destruction',NULL,0),
(29484,'esMX','Monster - Mace2H, Firemaul of Destruction (No Fire)',NULL,0),
(29537,'esMX','Monster - Staff, Blood Elf A02 Red - High Purple Glow',NULL,0),
(29538,'esMX','Monstruo - Espada - 2H Cristal C03 - Etéreo Etereum (Brillo negro)',NULL,0),
(29541,'esMX','Monster - Axe, Horde Double Blade A02 (Red Glow)',NULL,0),
(29542,'esMX','Monster - Sword, Horde Sword B04 Black (Red Glow)',NULL,0),
(29543,'esMX','Monster - Mace, Ethereal (Red Glow)',NULL,0),
(29544,'esMX','Monster - Staff, Ethereal (White) (Red Glow)',NULL,0),
(29551,'esMX','Cola cortada',NULL,0),
(29552,'esMX','Garfa de despellejador de roca rota',NULL,0),
(29557,'esMX','Pluma arcoiris',NULL,0),
(29558,'esMX','Escama cargada',NULL,0),
(29566,'esMX','Pluma de sangre de raptor',NULL,0),
(29585,'esMX','Látigo de la Legión',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29619,29620,29621,29622,29623,29626,29627,29628,29629,29630,29631,29632,29633,29634,29635,29636,29637,29638,29639,29640) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29619,'esMX','Monster - Mace, Draenei A01 Blue',NULL,0),
(29620,'esMX','Monster - Axe, 2H Draenei B01 Blue',NULL,0),
(29621,'esMX','Monster - Axe, 2H Draenei B01 Green',NULL,0),
(29622,'esMX','Monster - Axe, 2H Draenei B01 Purple',NULL,0),
(29623,'esMX','Monster - Axe, 2H Draenei B01 Yellow',NULL,0),
(29626,'esMX','Monster - Gun, Draenei A01',NULL,0),
(29627,'esMX','Monster - Gun, Draenei A01 Gold',NULL,0),
(29628,'esMX','Monster - Gun, Draenei A01 Olive',NULL,0),
(29629,'esMX','Monster - Gun, Draenei A01 Purple',NULL,0),
(29630,'esMX','Monster - Mace, Draenei A01 Gold',NULL,0),
(29631,'esMX','Monster - Mace, Draenei A01 Orange',NULL,0),
(29632,'esMX','Monster - Mace, Draenei A01 Purple',NULL,0),
(29633,'esMX','Monster - Mace, Draenei A02 Magenta',NULL,0),
(29634,'esMX','Monster - Mace, Draenei A02 Purple',NULL,0),
(29635,'esMX','Monster - Shield, Draenei A02 Black',NULL,0),
(29636,'esMX','Monster - Shield, Draenei A02 Orange',NULL,0),
(29637,'esMX','Monster - Shield, Draenei A02 Red',NULL,0),
(29638,'esMX','Monster - Shield, Draenei A01 Blue',NULL,0),
(29639,'esMX','Monster - Shield, Draenei A01 Brown',NULL,0),
(29640,'esMX','Monster - Shield, Draenei A01 Gold',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29641,29642,29643,29644,29646,29647,29648,29649,29650,29651,29652,29653,29654,29655,29656,29657,29658,29659,29660,29661) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29641,'esMX','Monster - Shield, Draenei A01 Orange',NULL,0),
(29642,'esMX','Monster - Shield, Draenei A01 Purple',NULL,0),
(29643,'esMX','Monster - Sword2H, Draenei A02 Grey',NULL,0),
(29644,'esMX','Monster - Sword2H, Draenei A02 Red',NULL,0),
(29646,'esMX','Monster - Sword2H, Draenei A01 Blue',NULL,0),
(29647,'esMX','Monster - Sword2H, Draenei A01 Green',NULL,0),
(29648,'esMX','Monster - Sword2H, Draenei A01 Grey',NULL,0),
(29649,'esMX','Monster - Sword2H, Draenei A01 Orange',NULL,0),
(29650,'esMX','Monster - Sword2H, Draenei A01 Purple',NULL,0),
(29651,'esMX','Monster - Axe, 2H Draenei A01 Blue',NULL,0),
(29652,'esMX','Monster - Axe, 2H Draenei A01 Green',NULL,0),
(29653,'esMX','Monster - Axe, 2H Draenei A01 Purple',NULL,0),
(29654,'esMX','Monster - Axe, 2H Draenei A01 Red',NULL,0),
(29655,'esMX','Monster - Axe, 2H Draenei C01 Blue',NULL,0),
(29656,'esMX','Monster - Axe, 2H Draenei C01 Green',NULL,0),
(29657,'esMX','Monster - Axe, 2H Draenei C01 Orange',NULL,0),
(29658,'esMX','Monster - Axe, 2H Draenei C01 Purple',NULL,0),
(29659,'esMX','Monster - Axe, 2H Draenei C01 Yellow',NULL,0),
(29660,'esMX','Monster - Axe, 2H Draenei D01 Blue',NULL,0),
(29661,'esMX','Monster - Axe, 2H Draenei D01 Green',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29662,29663,29665,29666,29667,29668,29670,29671,29676,29678,29679,29680,29681,29683,29685,29686,29687,29688,29690,29692) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29662,'esMX','Monster - Axe, 2H Draenei D01 Pink',NULL,0),
(29663,'esMX','Monster - Axe, 2H Draenei D01 Purple',NULL,0),
(29665,'esMX','Monster - Axe, 2H Draenei D01 Red',NULL,0),
(29666,'esMX','Monster - Sword, Draenei A01 Blue',NULL,0),
(29667,'esMX','Monster - Sword, Draenei A01 Green',NULL,0),
(29668,'esMX','Monster - Sword, Draenei A01 Grey',NULL,0),
(29670,'esMX','Monster - Sword, Draenei A01 Orange',NULL,0),
(29671,'esMX','Monster - Sword, Draenei A01 Purple',NULL,0),
(29676,'esMX','Monster - Staff, Draenei A01 Blue',NULL,0),
(29678,'esMX','Monster - Staff, Draenei A01 Brown',NULL,0),
(29679,'esMX','Monster - Staff, Draenei A01 Green',NULL,0),
(29680,'esMX','Monster - Staff, Draenei A01 Grey',NULL,0),
(29681,'esMX','Monster - Staff, Draenei A01 Purple',NULL,0),
(29683,'esMX','Monster - Staff, Draenei A02 Blue',NULL,0),
(29685,'esMX','Monster - Staff, Draenei A02 Copper',NULL,0),
(29686,'esMX','Monster - Staff, Draenei A02 Green',NULL,0),
(29687,'esMX','Monster - Staff, Draenei A02 Grey',NULL,0),
(29688,'esMX','Monster - Staff, Draenei A02 Purple',NULL,0),
(29690,'esMX','Monster - Staff, Draenei A03',NULL,0),
(29692,'esMX','Monster - Staff, Draenei A03 Blue',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29694,29695,29696,29697,29705,29706,29707,29708,29709,29710,29711,29715,29716,29748,29790,29802,29809,29816,29819,29820) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29694,'esMX','Monster - Staff, Draenei A03 Dirt',NULL,0),
(29695,'esMX','Monster - Staff, Draenei A03 Grey',NULL,0),
(29696,'esMX','Monster - Staff, Draenei A03 Pink',NULL,0),
(29697,'esMX','Monster - Staff, Draenei A03 Purple',NULL,0),
(29705,'esMX','Monster - Axe, Draenei B01 Amethyst',NULL,0),
(29706,'esMX','Monster - Axe, Draenei B01 Blue',NULL,0),
(29707,'esMX','Monster - Axe, Draenei B01 Gold',NULL,0),
(29708,'esMX','Monster - Axe, Draenei B01 Ice',NULL,0),
(29709,'esMX','Monster - Axe, Draenei C01 Amethyst',NULL,0),
(29710,'esMX','Monster - Axe, Draenei C01 Blue',NULL,0),
(29711,'esMX','Monster - Axe, Draenei C01 Gold',NULL,0),
(29715,'esMX','Monster - Staff, Blood Elf A01 Green',NULL,0),
(29716,'esMX','Monster - Staff, Blood Elf A01 Red',NULL,0),
(29748,'esMX','Monster - Staff, Blooming Druid Staff',NULL,0),
(29790,'esMX','Cargas de demolición',NULL,0),
(29802,'esMX','Piel de crocolisco escamapúas',NULL,0),
(29809,'esMX','Monster - Axe, Horde Massive Spiked (2H as 1H)',NULL,0),
(29816,'esMX','Monster - Sword, Consortium Phase Blade',NULL,0),
(29819,'esMX','Monster - Sword - 2H Crystal C03 - Ethereal, Ethereum (White Glow)',NULL,0),
(29820,'esMX','Monster - Sword - 2H (1H) Crystal C03 - Ethereal, Protectorate (White Glow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29821,29823,29824,29825,29826,29827,29829,29830,29831,29832,29833,29834,29835,29836,29837,29838,29843,29844,29845,29846) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29821,'esMX','Monster - Shield, Ethereal',NULL,0),
(29823,'esMX','Rogue 105 Epic Test Chest',NULL,0),
(29824,'esMX','Rogue 150 Epic Test Chest',NULL,0),
(29825,'esMX','Rogue 105 Epic Test Dagger 1800',NULL,0),
(29826,'esMX','Rogue 105 Epic Test Dagger 1300',NULL,0),
(29827,'esMX','Rogue 150 Epic Test Dagger 1300',NULL,0),
(29829,'esMX','Warrior 105 Epic Test Chest',NULL,0),
(29830,'esMX','Warrior 150 Epic Test Chest',NULL,0),
(29831,'esMX','Warrior 105 Test 1H Sword',NULL,0),
(29832,'esMX','Warrior 150 Test 1H Sword',NULL,0),
(29833,'esMX','Warrior 105 Test 2H Axe',NULL,0),
(29834,'esMX','Warrior 150 Test 2H Axe',NULL,0),
(29835,'esMX','Paladin 105 Epic Test Chest',NULL,0),
(29836,'esMX','Paladin 150 Epic Test Chest',NULL,0),
(29837,'esMX','QAEnchant Weapon +81 Healing',NULL,0),
(29838,'esMX','QAEnchant Weapon Battlemaster',NULL,0),
(29843,'esMX','QAEnchant Weapon +30 Intellect',NULL,0),
(29844,'esMX','QAEnchant Weapon +7 Damage',NULL,0),
(29845,'esMX','QAEnchant Weapon +20 Strength',NULL,0),
(29846,'esMX','QAEnchant 2H Weapon +35 Agility',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29847,29848,29849,29850,29851,29852,29853,29854,29855,29858,29859,29862,29864,29865,29866,29867,29869,29870,29873,29875) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29847,'esMX','QAEnchant 2H Weapon +70 Attack Power',NULL,0),
(29848,'esMX','QAEnchant Shield +5 Resistances',NULL,0),
(29849,'esMX','QAEnchant Shield +18 Stamina',NULL,0),
(29850,'esMX','QAEnchant Shield +12 Intellect',NULL,0),
(29851,'esMX','QAEnchant Shield +15 Block Value',NULL,0),
(29852,'esMX','QAEnchant Boots +9 Stamina & +8% Speed',NULL,0),
(29853,'esMX','QAEnchant Boots +6 Agility & +8% Speed',NULL,0),
(29854,'esMX','QAEnchant Boots +5 Snare Resist & +10 Hit Rating',NULL,0),
(29855,'esMX','Mage 105 Epic Test Chest',NULL,0),
(29858,'esMX','QAEnchant Cloak +15 Shadow Resistance',NULL,0),
(29859,'esMX','QAEnchant Cloak +15 Arcane Resistance',NULL,0),
(29862,'esMX','QAEnchant Gloves +35 Healing',NULL,0),
(29864,'esMX','QAEnchant Gloves +15 Spell Hit Rating',NULL,0),
(29865,'esMX','Mage 150 Epic Test Chest',NULL,0),
(29866,'esMX','QAEnchant Gloves +10 Spell Crit Rating',NULL,0),
(29867,'esMX','QAEnchant Gloves +15 Strength',NULL,0),
(29869,'esMX','QAEnchant Chest +15 Resilience',NULL,0),
(29870,'esMX','QAEnchant Chest +6 Mana5',NULL,0),
(29873,'esMX','QAEnchant Chest +150 Mana',NULL,0),
(29875,'esMX','Warlock 105 Epic Test Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29876,29877,29878,29879,29880,29881,29882,29883,29884,29886,29888,29889,29890,29891,29892,29893,29894,29895,29896,29897) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29876,'esMX','Warlock 150 Epic Test Chest',NULL,0),
(29877,'esMX','Súper picante de Indalamar',NULL,0),
(29878,'esMX','Priest 105 Epic Test Chest',NULL,0),
(29879,'esMX','Priest 150 Epic Test Chest',NULL,0),
(29880,'esMX','Paladin 105 Test 2H Axe',NULL,0),
(29881,'esMX','Paladin 150 Test 2H Axe',NULL,0),
(29882,'esMX','Hunter 105 Epic Test Chest',NULL,0),
(29883,'esMX','Hunter 150 Epic Test Chest',NULL,0),
(29884,'esMX','Hunter 105 Epic Test Gun',NULL,0),
(29886,'esMX','Hunter 105 Epic Ammo Box',NULL,0),
(29888,'esMX','Hunter 150 Epic Test Gun',NULL,0),
(29889,'esMX','Hunter 105/150 Epic Test Ammo Pouch',NULL,0),
(29890,'esMX','Druid 105 Epic Feral Test Chest',NULL,0),
(29891,'esMX','Druid 150 Epic Feral Test Chest',NULL,0),
(29892,'esMX','Druid 105 Epic Moonkin Test Chest',NULL,0),
(29893,'esMX','Druid 150 Epic Moonkin Test Chest',NULL,0),
(29894,'esMX','Paladin 105 Command Test Chest',NULL,0),
(29895,'esMX','Paladin 150 Command Test Chest',NULL,0),
(29896,'esMX','Shaman 105 Test Melee Chest',NULL,0),
(29897,'esMX','Shaman 150 Test Melee Chest',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(29898,29899,29900,29907,30078,30128,30147,30176,30178,30179,30180,30181,30182,30191,30195,30198,30199,30204,30208,30209) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(29898,'esMX','Shaman 105 Epic Nuker Test Chest',NULL,0),
(29899,'esMX','Shaman 150 Epic Nuker Test Chest',NULL,0),
(29900,'esMX','Monster - Axe, Horde C04 Fire',NULL,0),
(29907,'esMX','Monster - Magic Arrow',NULL,0),
(30078,'esMX','Monster - Mace, Basic Metal Hammer (Fiery)',NULL,0),
(30128,'esMX','Monster - Gun, Techno',NULL,0),
(30147,'esMX','Monster - Sword, 1H Blood Elf A03 Red - Red Flame',NULL,0),
(30176,'esMX','Shaman 150 Epic Test 1H Axe 2200',NULL,0),
(30178,'esMX','Monster - Axe, 2H Kor''kron Defender (A01 Purple)',NULL,0),
(30179,'esMX','Monster - Mace, 2H Kor''kron Defender (PvP Red)',NULL,0),
(30180,'esMX','Monster - Axe, 1H Kor''kron Defender (D02 Wolf)',NULL,0),
(30181,'esMX','Monster - Sword, 1H Kor''kron Defender (PvP Horde 2H)',NULL,0),
(30182,'esMX','Monster - Polearm, 2H Kor''kron Defender (PvP Horde 2H)',NULL,0),
(30191,'esMX','QAEnchant Ring +2 Weapon Damage',NULL,0),
(30195,'esMX','QAEnchant Ring +20 Healing',NULL,0),
(30198,'esMX','QAEnchant Cloak +7 Resistances',NULL,0),
(30199,'esMX','QAEnchant Boots +4 Health & Mana5',NULL,0),
(30204,'esMX','Monster - Sword2H, Claymore Blue - Medium Blue Glow',NULL,0),
(30208,'esMX','Monster - Glaive - Demonhunter Black (Red Flame)',NULL,0),
(30209,'esMX','Monster - Glaive - Demonhunter Black Offhand (Red Flame)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(30261,30292,30310,30325,30347,30367,30376,30385,30387,30388,30389,30390,30391,30392,30393,30403,30405,30406,30407,30408) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30261,'esMX','Monster - Mace2H, Draenei A01 Olive (Red Flame)',NULL,0),
(30292,'esMX','Mi amiguito','Entierra esas cucarachas...',0),
(30310,'esMX','Monster - Staff, Ornate Jeweled Staff - Purple High Purple Glow',NULL,0),
(30325,'esMX','Huevo de devastador voraz','¡Parece que está a punto de resquebrajarse!',0),
(30347,'esMX','Alexander''s Test Healthstone',NULL,0),
(30367,'esMX','Monster - Sword2H, Blood Elf B02 (Red Glow)',NULL,0),
(30376,'esMX','Monster - Mace, Jeweled Club (Purple Flame)',NULL,0),
(30385,'esMX','QR XXXX Plate Spell Bracer',NULL,0),
(30387,'esMX','Monster - Mace, Cosmic Infuser',NULL,0),
(30388,'esMX','Monster - Axe, 2H Devastation',NULL,0),
(30389,'esMX','Monster - Dagger, Infinity Blade',NULL,0),
(30390,'esMX','Monster - Bow, Netherstrand Longbow',NULL,0),
(30391,'esMX','Monster - Shield, Phaseshift Bulwark',NULL,0),
(30392,'esMX','Monster - Staff, Staff of Disintegration',NULL,0),
(30393,'esMX','Monster - Sword, Warp Slicer',NULL,0),
(30403,'esMX','Monster - Sword, Scimitar Badass (Red Glow, High)',NULL,0),
(30405,'esMX','Monster - Sword, Draenei A02 Blue',NULL,0),
(30406,'esMX','Monster - Sword, Draenei A02 Green',NULL,0),
(30407,'esMX','Monster - Sword, Draenei A02 Grey',NULL,0),
(30408,'esMX','Monster - Sword, Draenei A02 Purple',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(30409,30410,30411,30412,30423,30424,30427,30438,30439,30440,30441,30445,30452,30455,30456,30469,30470,30471,30472,30473) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30409,'esMX','Monster - Sword, Draenei A02 Yellow',NULL,0),
(30410,'esMX','Monster - Sword, Draenei C01 Blue',NULL,0),
(30411,'esMX','Monster - Sword, Draenei B01 Blue',NULL,0),
(30412,'esMX','Monster - Sword, Draenei B01 Blue (Low White Glow)',NULL,0),
(30423,'esMX','Monster - Staff, Blood Elf A01 Blue - Med Blue Glow',NULL,0),
(30424,'esMX','Monster - Staff, Blood Elf A01 Red - High Red Glow',NULL,0),
(30427,'esMX',NULL,'X ssseñala el sssitio.',0),
(30438,'esMX','Copia de la llave de la Legión',NULL,0),
(30439,'esMX','Monster - Polearm, 2H Ruul',NULL,0),
(30440,'esMX','Monstruo - lanza, La Punta de Trueno',NULL,0),
(30441,'esMX','Monster - Staff, Blood Elf A02 Red (Yellow Flame)',NULL,0),
(30445,'esMX','Monster - Mace, Kurdran''s Hammer',NULL,0),
(30452,'esMX','Monster - Bow, Spirit Hunter',NULL,0),
(30455,'esMX','Monster - 2H Typhoon',NULL,0),
(30456,'esMX','Monster - Bow, Hunter Epic',NULL,0),
(30469,'esMX','Patrón: toga de llama abisal',NULL,0),
(30470,'esMX','Patrón: cinturón de llama abisal',NULL,0),
(30471,'esMX','Patrón: botas de llama abisal',NULL,0),
(30472,'esMX','Patrón: leotardos de sangrevida',NULL,0),
(30473,'esMX','Patrón: cinturón de sangrevida',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(30474,30482,30484,30485,30502,30528,30545,30557,30576,30577,30578,30580,30624,30625,30630,30636,30647,30648,30660,30661) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30474,'esMX','Patrón: brazales de sangrevida',NULL,0),
(30482,'esMX','Monster - Sword2H, Blood Elf B02 (Blue Glow)',NULL,0),
(30484,'esMX','Monster - Sword, Caverns of Time Raid',NULL,0),
(30485,'esMX','Monster - Sword, Crystal C02, Purple, Black Glow',NULL,0),
(30502,'esMX','Monster - Draenei_D01_Red',NULL,0),
(30528,'esMX','Druid 105 Epic Bear Test Chest',NULL,0),
(30545,'esMX','Medallón de Cavrylin',NULL,0),
(30557,'esMX','Monster - Bow, Netherstrand Longbow (Held)',NULL,0),
(30576,'esMX','Monster - Dagger, Curved Bone Bloody (White Glow)',NULL,0),
(30577,'esMX','Monster - Axe, 2H Zul''Gurub Red (Blue Glow)',NULL,0),
(30578,'esMX','Monster - Dagger, Vulture Black (White Glow)',NULL,0),
(30580,'esMX','Monster - Crossbow, Draenei A01 Silver',NULL,0),
(30624,'esMX','Monster - Sword, Falchion (Black Glow)',NULL,0),
(30625,'esMX','Monster - Axe, 2H Arcanite Reaper (Green Glow)',NULL,0),
(30630,'esMX','Matriz energética de atracador vil',NULL,0),
(30636,'esMX','Monster - Sword, 2H Blood Elf A01 Yellow',NULL,0),
(30647,'esMX','Monster - Ruul''s Thunderfury',NULL,0),
(30648,'esMX','Monster - Sword, Katana (Sharpened effect)',NULL,0),
(30660,'esMX','Monster - Dagger, Borak',NULL,0),
(30661,'esMX','Monster - Axe, 1H Grom''tor',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(30662,30669,30670,30671,30697,30698,30699,30702,30711,30714,30715,30717,30790,30793,30795,30796,30801,30802,30805,30806) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30662,'esMX','Monster - Shield, Grom''tor',NULL,0),
(30669,'esMX','Monster - Staff, Oronok',NULL,0),
(30670,'esMX','Monster - Mace, Hammer Gold Orange (Yellow Glow)',NULL,0),
(30671,'esMX','Monster - Mace, Hammer Gold Orange (Low Yellow Glow)',NULL,0),
(30697,'esMX','Monster - Polearm, Battle Scythe (White)',NULL,0),
(30698,'esMX','Monster - Polearm, Battle Scythe (White - 1h)',NULL,0),
(30699,'esMX','Monster - Axe, Akama''s Scythe',NULL,0),
(30702,'esMX','Monster - EQUIPS RANDOM WEAPON VIA ACTION TRIGGER',NULL,0),
(30711,'esMX','QATest beneficios banda nv 70',NULL,0),
(30714,'esMX','Monster - Sword, 2H Crystal Purple (Purple Glow)',NULL,0),
(30715,'esMX','Monster - Axe, 1H Mounted Death Knight',NULL,0),
(30717,'esMX','Colgante de presagista',NULL,0),
(30790,'esMX','Monster - Staff Green Sphere (Old School Death Knight)',NULL,0),
(30793,'esMX','Poción de visión invisible de Skettis',NULL,0),
(30795,'esMX','Monstruo - lanza, Punta de Trueno flameante',NULL,0),
(30796,'esMX','Mineral de Terrallende','Objeto de misión del Fuego Infernal.',0),
(30801,'esMX','Monster - Sword2H, Horde Curved Black Red Flame',NULL,0),
(30802,'esMX','Monster - Mace2H, Draenei Paladin (Karsius)',NULL,0),
(30805,'esMX','Guantes gruesos resistentes a la suciedad',NULL,0),
(30806,'esMX','Equipo de paseo de can manáfago','Bolsa que contiene artículos para el recogecacas.',0);

DELETE FROM `item_template_locale` WHERE `ID` IN(30845,30848,30877,30920,30921,30934,30935,30949,30954,30963,30965,31081,31082,31083,31087,31205,31206,31207,31208,31253) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(30845,'esMX','Arcanum de amparo contra lo cromático',NULL,0),
(30848,'esMX','Monster - Axe, 2H Herod (Black Glow)',NULL,0),
(30877,'esMX','QAEnchant Bracer +6 Mana5 Sec',NULL,0),
(30920,'esMX','QR 10574 Cloth Mage Chest',NULL,0),
(30921,'esMX','QR 10637 Cloth Mage Legs',NULL,0),
(30934,'esMX','QR 10574 Leather Rogue Legs',NULL,0),
(30935,'esMX','QR 10637 Leather Rogue Helm',NULL,0),
(30949,'esMX','QR 10574 Mail Hunter Helm',NULL,0),
(30954,'esMX','QR 10637 Mail Hunter Bracers',NULL,0),
(30963,'esMX','QR 10574 Plate Warrior Gloves',NULL,0),
(30965,'esMX','QR 10637 Plate Warrior Boots',NULL,0),
(31081,'esMX','Monster - Sword, 2H Fathom-Lord Karathress',NULL,0),
(31082,'esMX','Monster - Mace, 2H Fathom-Lord Karathress',NULL,0),
(31083,'esMX','Monster - Bow, Val''zareq''s',NULL,0),
(31087,'esMX','Cristal de Ata''mal',NULL,0),
(31205,'esMX','Monstruo: hacha, soldado eclipsiano C04 fuego',NULL,0),
(31206,'esMX','Monstruo: hacha, soldado eclipsiano loco',NULL,0),
(31207,'esMX','Monstruo: espada2M, soldado eclipsiano',NULL,0),
(31208,'esMX','Monstruo: maza2M, soldado eclipsiano',NULL,0),
(31253,'esMX','(Action Figure) Bastón de druida elfo de la noche',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(31257,31259,31265,31267,31273,31274,31296,31301,31302,31309,31311,31325,31327,31348,31352,31353,31389,31466,31467,31468) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(31257,'esMX','(Action Figure) Bastón de sacerdote trol',NULL,0),
(31259,'esMX','(Action Figure) Espada de guerrero humano',NULL,0),
(31265,'esMX','(Action Figure) Escudo de guerrero humano',NULL,0),
(31267,'esMX','(Action Figure) Espada de guerrero enano',NULL,0),
(31273,'esMX','Monstruo - arma de asta, épica D',NULL,0),
(31274,'esMX','Monstruo - arma de asta, Fuego Infernal D verde',NULL,0),
(31296,'esMX','Monstruo - bastón, épico A',NULL,0),
(31301,'esMX','Monstruo - bastón, otro C 02',NULL,0),
(31302,'esMX','Monstruo - espada, Stratholme D3',NULL,0),
(31309,'esMX','Monster - Staff, Feral D02 Green',NULL,0),
(31311,'esMX','Monstruo - Espada1H Alto señor de fuego Illidari',NULL,0),
(31325,'esMX','Monstruo: arco, Lady Vashj',NULL,0),
(31327,'esMX','Monstruo: arma de asta, negro (brillo morado)',NULL,0),
(31348,'esMX','Monstruo: arco, Mordenai',NULL,0),
(31352,'esMX','Monstruo: ballesta, culebra verde',NULL,0),
(31353,'esMX','Monstruo: hacha, horda C03 obsidiana',NULL,0),
(31389,'esMX','Ojo de Grillok capturado',NULL,0),
(31466,'esMX','Monstruo: escudo, Illidari tipo 1',NULL,0),
(31467,'esMX','Monstruo: escudo, Illidari tipo 2',NULL,0),
(31468,'esMX','Monstruo: escudo, Illidari tipo 3',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(31469,31496,31497,31498,31499,31500,31502,31503,31505,31506,31507,31551,31600,31601,31603,31604,31605,31608,31609,31611) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(31469,'esMX','Cadáver de dragón Negro',NULL,0),
(31496,'esMX','Escrito sobre Bola de Fuego XIV',NULL,0),
(31497,'esMX','Monstruo: arroja tridente, malvado',NULL,0),
(31498,'esMX','Escrito sobre Descarga de Escarcha XIV',NULL,0),
(31499,'esMX','Monstruo: arroja tridente, malvado brillo azul',NULL,0),
(31500,'esMX','Escrito sobre Misiles Arcanos XI',NULL,0),
(31502,'esMX','Tratado: Bendición de poderío VIII',NULL,0),
(31503,'esMX','Tratado: Bendición de poderío superior III',NULL,0),
(31505,'esMX','Manual de Golpe Heroico XI',NULL,0),
(31506,'esMX','Manual de Revancha VIII',NULL,0),
(31507,'esMX','Grimorio Dolor abrasador VIII',NULL,0),
(31551,'esMX','Monstruo: faucedraco, Sombraluna - Martillo 2M',NULL,0),
(31600,'esMX','Monster - Faucedraco, Sombraluna - Hacha 1M',NULL,0),
(31601,'esMX','Monster - Faucedraco, Sombraluna - Hacha 2M',NULL,0),
(31603,'esMX','Monster - Faucedraco, Sombraluna - Espada 1M',NULL,0),
(31604,'esMX','Monster - Faucedraco, Sombraluna - Espada 2M',NULL,0),
(31605,'esMX','Monster - Faucedraco, Sombraluna - Bastón',NULL,0),
(31608,'esMX','Monstruo: bastón, elfo de sangre A02 rojo - llamas rojas altas',NULL,0),
(31609,'esMX','Monstruo: daga, horda JcJ - morado (brillo morado)',NULL,0),
(31611,'esMX','Monstruo: espada, 1M herrería Terrallende 01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(31612,31654,31665,31667,31669,31704,31743,31801,31802,31803,31805,31806,31842,31844,31846,31847,31848,31850,31851,31930) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(31612,'esMX','Monstruo: espada, llameante',NULL,0),
(31654,'esMX','Monstruo: faucedraco, Sombraluna - Maza 1M',NULL,0),
(31665,'esMX','Tanque mortero teledirigido de juguete',NULL,0),
(31667,'esMX','Cuchillo de mil mentiras','"Hay ocasiones en las que la verdad no puede ser revelada."',0),
(31669,'esMX','Monstruo: daga, malote rojo (envenenada)',NULL,0),
(31704,'esMX','Llave de la tempestad','Una llave cristalina que parece mantenerse unida por rayos de luz.',0),
(31743,'esMX','Monstruo: maza, draenei A02 morado (llama dorada baja)',NULL,0),
(31801,'esMX','Monster - Staff, Zul''Gurub 03',NULL,0),
(31802,'esMX','Monster - Claw, ZulGurub 02',NULL,0),
(31803,'esMX','Monster - Claw, ZulGurub 02 Offhand',NULL,0),
(31805,'esMX','Monster - Dagger, Outland Raid D04, Green',NULL,0),
(31806,'esMX','Monster - Sword, Zul''gurub 02',NULL,0),
(31842,'esMX','QAEnchant Bracer +12 Intellect',NULL,0),
(31844,'esMX','QAEnchant Bracer +30 Healing',NULL,0),
(31846,'esMX','QAEnchant Bracer +12 Defense',NULL,0),
(31847,'esMX','QAEnchant Bracer +12 Stamina',NULL,0),
(31848,'esMX','QAEnchant Bracer +4 All Stats',NULL,0),
(31850,'esMX','QATest +500 Defense Ring',NULL,0),
(31851,'esMX','QATest +150 Defense Ring',NULL,0),
(31930,'esMX','Talismán enigmático',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(31931,31932,31933,31934,31947,31948,31954,32065,32066,32075,32091,32191,32246,32272,32322,32360,32371,32372,32384,32424) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(31931,'esMX','Talismán ígneo',NULL,0),
(31932,'esMX','Talismán viviente',NULL,0),
(31933,'esMX','Talismán oscuro',NULL,0),
(31934,'esMX','Talismán gélido',NULL,0),
(31947,'esMX','Cubo de aislamiento energizado',NULL,0),
(31948,'esMX','Acecho celeste',NULL,0),
(31954,'esMX','Bota mordisqueada','Está mojada y cubierta de babas...',0),
(32065,'esMX','Monster - Glaive - Demonhunter Black (Black Glow - Illidan)',NULL,0),
(32066,'esMX','Monster - Glaive - Demonhunter Black Offhand (Black Glow - Illidan)',NULL,0),
(32075,'esMX','Libro del Cuervo','Manuscrito antiguo y mal conservado que narra las hazañas del Dios cuervo arakkoa.',0),
(32091,'esMX','Alex''s Test Beatdown Mace',NULL,0),
(32191,'esMX','Escrito sobre batalla de canciller',NULL,0),
(32246,'esMX','Monster - Mace, Spiked Skull',NULL,0),
(32272,'esMX','Monster - Sword, Chromatically Tempered',NULL,0),
(32322,'esMX','Monster - Crystal Offhand, Blood Elf - Green',NULL,0),
(32360,'esMX','Monster - Staff, Hellfire D01',NULL,0),
(32371,'esMX','Monster - Polearm, Epic D - Glow',NULL,0),
(32372,'esMX','Blade''s Edge Test Shard',NULL,0),
(32384,'esMX','Monster - Sword, 1H - Blackwing A02',NULL,0),
(32424,'esMX','Cerveza ogra de Filospada',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(32425,32426,32448,32457,32460,32463,32477,32484,32499,32504,32507,32530,32562,32565,32595,32603,32604,32605,32607,32610) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32425,'esMX','Monster - Sword, 1H Maiev''s Blade',NULL,0),
(32426,'esMX','Testing Darkrune',NULL,0),
(32448,'esMX','Monster - Trident, Ornate (Electrified)',NULL,0),
(32457,'esMX','Fetiche arakkoa',NULL,0),
(32460,'esMX','Monster - Sword, 2H Crystal Blue (Blue Flame)',NULL,0),
(32463,'esMX','Monstruo: espada, maza de cristal (azul)',NULL,0),
(32477,'esMX','Monster - Silithid Claw',NULL,0),
(32484,'esMX','Monster - Sword, Crystal (Blue)',NULL,0),
(32499,'esMX','Monster - Mace2H, Ogri''la Hammer',NULL,0),
(32504,'esMX','Monster - Silithid Claw (Offhand)',NULL,0),
(32507,'esMX','Monster - Polearm, Teron Gorefiend (Black Temple)',NULL,0),
(32530,'esMX','Monster - Polearm, Blood Elf D01 (Purple Glow)',NULL,0),
(32562,'esMX','Monster - Dagger, Curved Bone Bloody (Black Glow)',NULL,0),
(32565,'esMX','Monster - Axe, 2H Large Double Bladed (Black Glow)',NULL,0),
(32595,'esMX','Polvo de componentes de Ogrela',NULL,0),
(32603,'esMX','Monster - Black Temple - Sword, 2H - Shadowmoon Champion',NULL,0),
(32604,'esMX','Monster - Black Temple - Axe, 1H - Shadowmoon Reaver',NULL,0),
(32605,'esMX','Monster - Black Temple - Staff, 2H - Shadowmoon Blood Mage',NULL,0),
(32607,'esMX','Monster - Black Temple - Staff, 2H - Shadowmoon Deathshaper',NULL,0),
(32610,'esMX','Monster - Staff, Ornate Jeweled Staff - Blue Low Blue Glow',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(32611,32612,32613,32614,32632,32642,32644,32699,32729,32730,32731,32740,32743,32775,32826,32827,32856,32874,32875,32876) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32611,'esMX','Monster - Black Temple - Hammer, 1H - Shadowmoon Grunt',NULL,0),
(32612,'esMX','Monster - Black Temple - Axe, 2H - Shadowmoon Houndmaster',NULL,0),
(32613,'esMX','Monster - Black Temple - Bow, 2H - Shadowmoon Houndmaster',NULL,0),
(32614,'esMX','Monster - Black Temple - Sword, 2H - Shadowmoon Weapon Master',NULL,0),
(32632,'esMX','Monster - Glavie, Illidan - Black Temple (Right Hand)',NULL,0),
(32642,'esMX','Runaoscura en bruto','La energía vil ha invadido el contorno de la runa.',0),
(32644,'esMX','Monstruo - Bastón, 1H - Jefe Sobrestante Limo',NULL,0),
(32699,'esMX','Monstruo - Hacha, 2H BRaenei B01 Verde (Brillo Verde)',NULL,0),
(32729,'esMX','Monster - Polearm, Epic D 05',NULL,0),
(32730,'esMX','Monster - Bow, Outland Raid D04',NULL,0),
(32731,'esMX','Monster - Dagger, Naxxramas',NULL,0),
(32740,'esMX','Monster - Dagger (Maiev)',NULL,0),
(32743,'esMX','Monster - Axe -Doomguard Punisher','Esta hacha de batalla parece de otro mundo...',0),
(32775,'esMX','Perla de inmersión profunda',NULL,0),
(32826,'esMX','Monster - Bow, Scryer (Uber)',NULL,0),
(32827,'esMX','Monster - Bow, Scryer (Hobb)',NULL,0),
(32856,'esMX','Monster - Dagger, Blood Elf B02 Red',NULL,0),
(32874,'esMX','Monster - Black Temple - Mace, 1H - Bonechewer Taskmaster',NULL,0),
(32875,'esMX','Monster - Black Temple - Axe, 2H - Dragonmaw Wyrmcaller',NULL,0),
(32876,'esMX','Monster - Black Temple - Crossbow - Dragonmaw Sky Stalker',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(32877,32878,32879,32884,32885,32886,32887,32889,32890,32891,32892,32893,32894,32908,32916,32921,32922,32923,32924,32925) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32877,'esMX','Monster - Black Temple - Fist, 1H - Bonechewer Brawler (Left)',NULL,0),
(32878,'esMX','Monster - Black Temple - Fist, 1H - Bonechewer Brawler (Right)',NULL,0),
(32879,'esMX','Monster - Black Temple - Axe, 2H - Bonechewer Combatant',NULL,0),
(32884,'esMX','Monster - Black Temple - Staff, 2H - Bonechewer Blood Prophet',NULL,0),
(32885,'esMX','Monster - Black Temple - Shield - Bonechewer Shield Disciple',NULL,0),
(32886,'esMX','Monster - Black Temple - Axe, 1H - Bonechewer Shield Disciple',NULL,0),
(32887,'esMX','Monster - Black Temple - Axe, 1H - Bonechewer Blade Fury',NULL,0),
(32889,'esMX','Monster - Black Temple - Sword, 1H - Council Advisor',NULL,0),
(32890,'esMX','Monster - Black Temple - Sword, 1H - Council Advisor (Test)',NULL,0),
(32891,'esMX','Monster - Black Temple - Shield - Illidari Blood Lord',NULL,0),
(32892,'esMX','Monster - Black Temple - Hammer, 1H - Illidari Blood Lord',NULL,0),
(32893,'esMX','Monster - Black Temple - Staff, 2H - Illidari Archon',NULL,0),
(32894,'esMX','Monster - Black Temple - Dagger - Illidari Assassin',NULL,0),
(32908,'esMX','Armamentos de El Castillo de la Tempestad',NULL,0),
(32916,'esMX','Notas de investigación de Tragoamargo',NULL,0),
(32921,'esMX','Brewfest Mug 2007 (Filled, F)',NULL,0),
(32922,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Energy)',NULL,0),
(32923,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Energy)',NULL,0),
(32924,'esMX','Monster - Axe, Afrasiabi Particle Glaive Polearm Magtheridon',NULL,0),
(32925,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Light)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(32926,32927,32928,32929,32930,32931,32932,32933,32934,32935,32936,32937,32938,32939,32940,32951,32952,32953,32965,32966) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32926,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Light)',NULL,0),
(32927,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Small Energy)',NULL,0),
(32928,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Small Energy)',NULL,0),
(32929,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Holy)',NULL,0),
(32930,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Holy)',NULL,0),
(32931,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Fear Blade)',NULL,0),
(32932,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Fear Blade)',NULL,0),
(32933,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Rage)',NULL,0),
(32934,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Rage)',NULL,0),
(32935,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Vengeance)',NULL,0),
(32936,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Vengeance)',NULL,0),
(32937,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Purple Globes)',NULL,0),
(32938,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Purple Globes)',NULL,0),
(32939,'esMX','Monster - Axe, Afrasiabi Particle Test Dagger (Slowing Strike)',NULL,0),
(32940,'esMX','Monster - Axe, Afrasiabi Particle Test 2H Sword (Slowing Strike)',NULL,0),
(32951,'esMX','Montante inusualmente lento',NULL,0),
(32952,'esMX','encantar arma: oleada de hechizos',NULL,0),
(32953,'esMX','Monstruo - Espada2H, Kaz''rogal',NULL,0),
(32965,'esMX','DEBUG - Headless Horseman - Create Fire Node',NULL,0),
(32966,'esMX','DEBUG - Headless Horseman - Start Fire',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(32967,33001,33002,33003,33005,33022,33027,33046,33049,33073,33074,33075,33080,33094,33097,33100,33104,33116,33118,33125) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32967,'esMX','DEBUG - Headless Horseman - Extinguish Fire',NULL,0),
(33001,'esMX','Polvo reflectante',NULL,0),
(33002,'esMX','Monster - Staff, Feathered Gold (Red Flame)',NULL,0),
(33003,'esMX','Test Sword Skill Trinket',NULL,0),
(33005,'esMX','TEST CHEST MAIL HUNTER',NULL,0),
(33022,'esMX','Brewfest Mug 2008 (Filled, F)',NULL,0),
(33027,'esMX','TEST Mike''s Dagger',NULL,0),
(33046,'esMX','Insignia of PvP Pwn',NULL,0),
(33049,'esMX','Monster - Axe, Outland D04 Green',NULL,0),
(33073,'esMX','Test_Ears_Hidden(builtByBlue)','hides ears for testing',0),
(33074,'esMX','Test_Eyes_Hidden(builtByBlue)','hides eyes for testing',0),
(33075,'esMX','Test_NoseAndEars_Hidden(builtByBlue)','hides nose and ears for testing',0),
(33080,'esMX','Monster - Gun - Outland Raid D04',NULL,0),
(33094,'esMX','Monster - Axe, Hatchet B01 Gold',NULL,0),
(33097,'esMX','Anillo de champiñón','Este anillo esponjoso es sorprendentemente duradero.',0),
(33100,'esMX','Bomba incendiaria de Lysander',NULL,0),
(33104,'esMX','Anillo de habilidad',NULL,0),
(33116,'esMX','Monster - Axe, 2H D04 Red w/Flames',NULL,0),
(33118,'esMX','Socket Test Shoulders [PH]',NULL,0),
(33125,'esMX','Monster - Item, Tankard Metal (Red Glow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(33161,33162,33168,33169,33170,33171,33172,33177,33178,33180,33181,33193,33194,33195,33196,33198,33199,33200,33201,33210) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(33161,'esMX','Monster - Item, Tankard Gold (Yellow Glow)',NULL,0),
(33162,'esMX','Monster - Item, Tankard Gold Offhand (Yellow Glow)',NULL,0),
(33168,'esMX','Monster - Mace, Hammer Blue Mighty (Lightning)',NULL,0),
(33169,'esMX','Monster - Axe 1H, Vrykul Thane',NULL,0),
(33170,'esMX','Monster - Howling Fjord - Staff, 2H - Dragonflayer Oracle',NULL,0),
(33171,'esMX','Monster - Polearm, Dragonflayer Scythe',NULL,0),
(33172,'esMX','Monster - Sword2H, Claymore C01 (High Red Flame)',NULL,0),
(33177,'esMX','Monster - Axe, 2H Ingvar the Plunderer - Phase 1',NULL,0),
(33178,'esMX','Monster - Axe, 2H Ingvar the Plunderer - Phase 2',NULL,0),
(33180,'esMX','Monster - Sword2H, Claymore C01',NULL,0),
(33181,'esMX','Monster - Shield, OutlandRaid D04',NULL,0),
(33193,'esMX','Sortija musgosa',NULL,0),
(33194,'esMX','Sortija ceremonial antigua','Seguramente usada en alguna ceremonia ya olvidada, esta sortija parece no haber sido molestada en mucho tiempo.',0),
(33195,'esMX','Sortija con piedra rajada','Esta rudimentaria sortija está cubierta de moho y liquen.',0),
(33196,'esMX','Anillo con brillo suave','Un liquen luminiscente cubre la superficie de este sencillo anillo.',0),
(33198,'esMX','Collar de decadencia','Los huesos que adornan este collar están en parte consumidos por cientos de años de crecimiento de moho y liquen.',0),
(33199,'esMX','Amuleto de Antigüedad','Acribillado por oscuros pedacitos de moho, el origen de este amuleto es aún un misterio.',0),
(33200,'esMX','Collar ceremonial antiguo','Los símbolos grabados en este collar no han sido precisamente borrados por el liquen que lo cubre.',0),
(33201,'esMX','Colgante de piedra lunar plateado','A pesar del espeso liquen de color plateado que crece sobre él, aún se leen las iniciales S.L. sobre el colgante.',0),
(33210,'esMX','Monster - Shield, B01 WoodRedCap',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(33212,33213,33217,33220,33227,33275,33276,33288,33294,33295,33301,33318,33319,33320,33338,33442,33456,33521,33525,33526) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(33212,'esMX','Monster - Vrykul, Shield (Test)',NULL,0),
(33213,'esMX','Monster - Vrykul, Sword 2H (Test)',NULL,0),
(33217,'esMX','Dulce de Halloween no apilado',NULL,0),
(33220,'esMX','Monster - Shield, Vrykul Thane',NULL,0),
(33227,'esMX','Test Tabard of Stat Modding',NULL,0),
(33275,'esMX','Monster - Mace, Northrend C03',NULL,0),
(33276,'esMX','Monster - Axe, 2H Northrend C01 Black',NULL,0),
(33288,'esMX','Complimentary Brewfest Sampler DEBUG',NULL,0),
(33294,'esMX','Monster, Shield - Dragonflayer Tribesman',NULL,0),
(33295,'esMX','Monster - Sword, Draenei A01 Purple 1hander',NULL,0),
(33301,'esMX','Monster - Axe 2H, Dragonflayer Invader (Vrykul)',NULL,0),
(33318,'esMX','Monster - Axe, Hatchet A01/A02 Silver',NULL,0),
(33319,'esMX','Monster - Axe, 2H War B01/B02 Silver',NULL,0),
(33320,'esMX','Monster - Axe, Horde C04 Metal',NULL,0),
(33338,'esMX','Monster - Throwing Knife (Fire Trail)',NULL,0),
(33442,'esMX','Escopeta de balines','Escopeta de balines para probar tu puntería. Es inútil para el combate real.',0),
(33456,'esMX','Jaula de la jaula de Oluf',NULL,0),
(33521,'esMX','Monster - Mace2H, Maul B02 SilverPurple',NULL,0),
(33525,'esMX','Monster - Horde PvP, Main Hand, Green',NULL,0),
(33526,'esMX','Monster - Horde PvP, Off Hand, Green',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(33542,33543,33544,33564,33565,33570,33572,33573,33574,33594,33595,33596,33597,33598,33600,33601,33602,33603,33608,33609) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(33542,'esMX','Shaman Testing Axe',NULL,0),
(33543,'esMX','Shaman Testing Dagger',NULL,0),
(33544,'esMX','Monster - Axe 1H, Dragonflayer Berserker (Vrykul)',NULL,0),
(33564,'esMX','Certificado de objeto del mundo','Normalmente no sería un objeto del mundo genial, pero estás en la BlizzCon...',0),
(33565,'esMX','Certificado de objeto poco común','Normalmente no sería un objeto verde de Rasganorte guay, pero estás en la BlizzCon...',0),
(33570,'esMX','TEMP - Dwarf Loot 1','Placeholder Item',0),
(33572,'esMX','TEMP - Dwarf Loot 2','Placeholder Item',0),
(33573,'esMX','TEMP - Dwarf Loot 3','Placeholder Item',0),
(33574,'esMX','TEMP - Dwarf Loot 4','Placeholder Item',0),
(33594,'esMX','Monster - Axe 1H, Dragonflayer Gladiator (Firjus)',NULL,0),
(33595,'esMX','Monster - Mace 1H, Dragonflayer Gladiator (Firjus)',NULL,0),
(33596,'esMX','Monster - Shield, Dragonflayer Gladiator (Jlarborn)',NULL,0),
(33597,'esMX','Monster - Axe 2H, Dragonflayer Gladiator (Yorus)',NULL,0),
(33598,'esMX','Monster - Polearm, Dragonflayer Gladiator (Oluf)',NULL,0),
(33600,'esMX','TEMP - Troll Loot 1','Placeholder Item',0),
(33601,'esMX','TEMP - Troll Loot 3','Placeholder Item',0),
(33602,'esMX','TEMP - Troll Loot 2','Placeholder Item',0),
(33603,'esMX','TEMP - Troll Loot 4','Placeholder Item',0),
(33608,'esMX','Monster - Staff, Dragonflayer Soulreaver',NULL,0),
(33609,'esMX','Monster - Sword 1H, Dragonflayer Fleshripper',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(33623,33624,33625,33626,33633,33772,33773,33785,33786,33787,33788,33789,33790,33793,33795,33798,33802,33807,33958,33963) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(33623,'esMX','TEMP - Orc Loot 1','Placeholder Item',0),
(33624,'esMX','TEMP - Orc Loot 2','Placeholder Item',0),
(33625,'esMX','TEMP - Orc Loot 3','Placeholder Item',0),
(33626,'esMX','TEMP - Orc Loot 4','Placeholder Item',0),
(33633,'esMX','Diamante de tormenta de tierra fuerte','Solo encaja en una ranura de gema meta.',0),
(33772,'esMX','Testing Gladiator''s Lamellar Shoulders',NULL,0),
(33773,'esMX','Monster - Sword 2H, King Ymiron (Vrykul)',NULL,0),
(33785,'esMX','TEMP - Gnome Loot 1','Placeholder Item',0),
(33786,'esMX','TEMP - Gnome Loot 2','Placeholder Item',0),
(33787,'esMX','TEMP - Gnome Loot 3','Placeholder Item',0),
(33788,'esMX','TEMP - Gnome Loot 4','Placeholder Item',0),
(33789,'esMX','Monster - Shield, Zul''gurub',NULL,0),
(33790,'esMX','Monster - Axe, Horde B03 Copper (Thrown)',NULL,0),
(33793,'esMX','Monster - Mace, Zul''Gurub A01',NULL,0),
(33795,'esMX','Monster - Staff, Outland Raid D06, Red',NULL,0),
(33798,'esMX','Monster - Staff, Zul''Aman D02 Black',NULL,0),
(33802,'esMX','Muestra de runa de gigante de piedra',NULL,0),
(33807,'esMX','Cuerno de Vazruden','Un pequeño adorno para un orco vil. Probablemente es un obsequio de su maestro.',0),
(33958,'esMX','Estampa de El Jinete',NULL,0),
(33963,'esMX','Monster - Item, Tankard Brewfest (Year 1 Yellow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(33975,33979,33980,33981,33982,33983,33984,33986,33988,33989,33990,33991,33992,33994,33995,33996,33998,34004,34005,34006) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(33975,'esMX','Monster - Zul''jin Weapon',NULL,0),
(33979,'esMX','Monster - Zul''Aman - Hammer, 2H - Amani''shi Guardian',NULL,0),
(33980,'esMX','Monster - Zul''Aman - Axe, 1H - Amani''shi Tribesman',NULL,0),
(33981,'esMX','Monster - Zul''Aman - Axe, 1H - Amani''shi Axe Thrower',NULL,0),
(33982,'esMX','Monster - Zul''Aman - Axe, 1H - Amani''shi Warbringer',NULL,0),
(33983,'esMX','Monster - Zul''Aman - Staff, 2H - Amani''shi Flame Caster',NULL,0),
(33984,'esMX','Monster - Zul''Aman - Sword, 1H - Amani''shi Protector',NULL,0),
(33986,'esMX','Indalamar''s Ring of 200 Crit','Don''t you wish this was real!',0),
(33988,'esMX','Indalamar''s Ring of 200 Haste','Don''t you wish this was real!',0),
(33989,'esMX','Indalamar''s Ring of 200 Spell Haste','Don''t you wish this was real!',0),
(33990,'esMX','Monster - Zul''Aman - Sword, 1H - Halazzi',NULL,0),
(33991,'esMX','Monster - Zul''Aman - Bow - Amani''shi Handler',NULL,0),
(33992,'esMX','Monster - Zul''Aman - Knife, 1H - Amani''shi Handler',NULL,0),
(33994,'esMX','Anillo de prueba de Kjordan','¡Capitán Planeta!',0),
(33995,'esMX','Anillo de hegemonía de sanador de Indalamar','En serio. He dicho sanador.',0),
(33996,'esMX','Indalamar''s Ring of 234 Spell Damage','Don''t you wish this was real!',0),
(33998,'esMX','Indalamar''s Ring of 1400 Armor Penetration','Don''t you wish this was real!',0),
(34004,'esMX','Máscara de draenei hembra robusta',NULL,0),
(34005,'esMX','Máscara de elfa de sangre robusta',NULL,0),
(34006,'esMX','Máscara de elfo de sangre robusta',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34007,34034,34036,34037,34038,34039,34045,34046,34047,34048,34058,34071,34079,34080,34093,34094,34095,34096,34097,34098) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34007,'esMX','Máscara de draenei macho robusta',NULL,0),
(34034,'esMX','Monster - Gun, Plaguebringer',NULL,0),
(34036,'esMX','QA Test Ring +300 Resilience Rating',NULL,0),
(34037,'esMX','QA Test Ring +100 Hit Rating',NULL,0),
(34038,'esMX','QA Test Ring +100 Expertise Rating',NULL,0),
(34039,'esMX','Arco de lentitud poco corriente',NULL,0),
(34045,'esMX','Monster - Zul''Aman - Dagger - Amani''shi Tempest',NULL,0),
(34046,'esMX','Habilidad: atrapar',NULL,0),
(34047,'esMX','Habilidad: sprint',NULL,0),
(34048,'esMX','Habilidad: placar',NULL,0),
(34058,'esMX','Monster - Polearm, Harpoon (Vrykul)',NULL,0),
(34071,'esMX','Montón de calabazas iluminadas',NULL,0),
(34079,'esMX','Monster - Staff, Northrend Runed',NULL,0),
(34080,'esMX','Monster - Axe, 1H Broad, Spiked Blade',NULL,0),
(34093,'esMX','Test Alex Axe',NULL,0),
(34094,'esMX','Indalamar''s Ring of 200 Attack Power','Don''t you wish this was real!',0),
(34095,'esMX','Indalamar''s Ring of 200 Hit Rating','Don''t you wish this was real!',0),
(34096,'esMX','Test Eric Axe','Hi to the Data Miners!',0),
(34097,'esMX','Test Steve Axe','Hi to Dataminers! Hope you''re enjoying the digging.',0),
(34098,'esMX','Monster - Gun, Blood Elf Red',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34108,34117,34150,34151,34152,34153,34154,34155,34156,34159,34161,34217,34250,34251,34252,34260,34263,34264,34265,34266) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34108,'esMX','Conjunto de disfraz de pirata','¡Jo, jo, jo!',0),
(34117,'esMX','Llave de hierro herrumbrada',NULL,0),
(34150,'esMX','Riendas de reno volador (TEST)',NULL,0),
(34151,'esMX','Jugador, draenei/tauren',NULL,0),
(34152,'esMX','Jugador, enano/orco',NULL,0),
(34153,'esMX','Jugador, gnomo/elfo de sangre',NULL,0),
(34154,'esMX','Jugador, humano/no-muerto',NULL,0),
(34155,'esMX','Jugador, trol/elfo de la noche',NULL,0),
(34156,'esMX','BLB - Kit',NULL,0),
(34159,'esMX','Team B Tabard',NULL,0),
(34161,'esMX','Confalón de Kael',NULL,0),
(34217,'esMX','Monster - Shield, Skeletal - Vrykul Ancestor',NULL,0),
(34250,'esMX','Habilidad: lanzar bala',NULL,0),
(34251,'esMX','Habilidad: lanzar',NULL,0),
(34252,'esMX','Habilidad: fintar',NULL,0),
(34260,'esMX','Bandera pirata',NULL,0),
(34263,'esMX','Monster - Bow, Blood Elf A01 Black',NULL,0),
(34264,'esMX','Monster - Bow, Blood Elf A01 Blue',NULL,0),
(34265,'esMX','Monster - Bow, Blood Elf A01 Orange',NULL,0),
(34266,'esMX','Monster - Bow, Blood Elf A01 Red',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34267,34268,34269,34270,34271,34272,34273,34274,34275,34276,34277,34278,34279,34280,34281,34282,34283,34284,34285,34286) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34267,'esMX','Monster - Bow, Blood Elf A01 Yellow',NULL,0),
(34268,'esMX','Monster - Bow, Blood Elf B01 Orange',NULL,0),
(34269,'esMX','Monster - Bow, Blood Elf B01 Black',NULL,0),
(34270,'esMX','Monster - Bow, Blood Elf B01 Red',NULL,0),
(34271,'esMX','Monster - Bow, Blood Elf C01 Default',NULL,0),
(34272,'esMX','Monster - Bow, Blood Elf C01 Black',NULL,0),
(34273,'esMX','Monster - Bow, Blood Elf C01 Orange',NULL,0),
(34274,'esMX','Monster - Bow, Blood Elf C01 Red',NULL,0),
(34275,'esMX','Monster - Bow, Blood Elf C01 Silver',NULL,0),
(34276,'esMX','Monster - Bow, Blood Elf D01 Default',NULL,0),
(34277,'esMX','Monster - Bow, Blood Elf D01 Black',NULL,0),
(34278,'esMX','Monster - Bow, Blood Elf D01 Gold',NULL,0),
(34279,'esMX','Monster - Bow, Blood Elf D01 Orange',NULL,0),
(34280,'esMX','Monster - Bow, Blood Elf D01 Red',NULL,0),
(34281,'esMX','Monster - Bow, Blood Elf D01 Silver',NULL,0),
(34282,'esMX','Monster - Sword, 1H Blood Elf A01 Silver',NULL,0),
(34283,'esMX','Monster - Sword, 1H Blood Elf A02 Black',NULL,0),
(34284,'esMX','Monster - Sword, 1H Blood Elf A03 Black',NULL,0),
(34285,'esMX','Monster - Sword, 1H Blood Elf A03 Gold',NULL,0),
(34286,'esMX','Monster - Sword, 1H Blood Elf A03 Orange',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34287,34288,34289,34290,34291,34292,34293,34294,34295,34296,34297,34298,34299,34300,34301,34302,34303,34304,34305,34306) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34287,'esMX','Monster - Sword, 2H Blood Elf A01',NULL,0),
(34288,'esMX','Monster - Sword, 1H Blood Elf A03 Silver',NULL,0),
(34289,'esMX','Monster - Sword, 2H Blood Elf A01 Blue',NULL,0),
(34290,'esMX','Monster - Sword, 2H Blood Elf A01 Red',NULL,0),
(34291,'esMX','Monster - Sword, 2H Blood Elf A02',NULL,0),
(34292,'esMX','Monster - Sword, 2H Blood Elf A02 Blue',NULL,0),
(34293,'esMX','Monster - Sword, 2H Blood Elf A02 Green',NULL,0),
(34294,'esMX','Monster - Sword, 2H Blood Elf A02 Yellow',NULL,0),
(34295,'esMX','Monster - Sword, 2H Blood Elf B01 Gold',NULL,0),
(34296,'esMX','Monster - Sword, 2H Blood Elf B01 Red',NULL,0),
(34297,'esMX','Monster - Sword, 2H Blood Elf B01 Silver',NULL,0),
(34298,'esMX','Monster - Sword, 2H Blood Elf B02',NULL,0),
(34299,'esMX','Monster - Sword, 2H Blood Elf B02 Blue',NULL,0),
(34300,'esMX','Monster - Sword, 2H Blood Elf B02 Green',NULL,0),
(34301,'esMX','Monster - Sword, 2H Blood Elf B02 Red',NULL,0),
(34302,'esMX','Monster - Sword, 2H Blood Elf C01 Black',NULL,0),
(34303,'esMX','Monster - Sword, 2H Blood Elf C01 Orange',NULL,0),
(34304,'esMX','Monster - Sword, 2H Blood Elf C01 Purple',NULL,0),
(34305,'esMX','Monster - Sword, 2H Blood Elf C01 Red',NULL,0),
(34306,'esMX','Monster - Sword, 2H Blood Elf C02 Purple',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34307,34308,34309,34310,34311,34312,34313,34314,34315,34316,34317,34318,34320,34321,34322,34323,34324,34325,34326,34327) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34307,'esMX','Monster - Sword, 2H Blood Elf C02 Red',NULL,0),
(34308,'esMX','Monster - Sword, 2H Blood Elf C02 Yellow',NULL,0),
(34309,'esMX','Monster - Sword, 2H Blood Elf C03 Blue',NULL,0),
(34310,'esMX','Monster - Sword, 2H Blood Elf C03 Green',NULL,0),
(34311,'esMX','Monster - Sword, 2H Blood Elf C03 Red',NULL,0),
(34312,'esMX','Monster - Crossbow, Draenei A01',NULL,0),
(34313,'esMX','Monster - Crossbow, Draenei A01 Brown',NULL,0),
(34314,'esMX','Monster - Crossbow, Draenei A01 Gold',NULL,0),
(34315,'esMX','Monster - Crossbow, Draenei A01 Orange',NULL,0),
(34316,'esMX','Monster - Crossbow, Draenei A02 Blue',NULL,0),
(34317,'esMX','Monster - Crossbow, Draenei A02 Blue Trim',NULL,0),
(34318,'esMX','Monster - Crossbow, Draenei A02 Brown',NULL,0),
(34320,'esMX','Monster - Crossbow, Draenei A02 Green Trim',NULL,0),
(34321,'esMX','Monster - Crossbow, Draenei A02 Grey Trim',NULL,0),
(34322,'esMX','Monster - Crossbow, Draenei A02 Purple',NULL,0),
(34323,'esMX','Monster - Crossbow, Draenei A02 Red Trim',NULL,0),
(34324,'esMX','Monster - Sword, Draenei B01 Purple',NULL,0),
(34325,'esMX','Monster - Crossbow, Outland Raid D01',NULL,0),
(34326,'esMX','Monster - Crossbow, Outland Raid D04',NULL,0),
(34327,'esMX','Monster - Crossbow, Outland Raid D05',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34328,34449,34450,34451,34452,34453,34454,34455,34456,34457,34458,34459,34460,34461,34462,34463,34465,34466,34481,34496) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34328,'esMX','Monster - Crossbow, Outland Raid D06',NULL,0),
(34449,'esMX','Monster - Dagger, Draenei A01 Black',NULL,0),
(34450,'esMX','Monster - Dagger, Draenei A01 Blue',NULL,0),
(34451,'esMX','Monster - Dagger, Draenei A01 Orange',NULL,0),
(34452,'esMX','Monster - Dagger, Draenei A01 Purple',NULL,0),
(34453,'esMX','Monster - Dagger, Draenei A01 Yellow',NULL,0),
(34454,'esMX','Monster - Dagger, Draenei A02 Blue',NULL,0),
(34455,'esMX','Monster - Dagger, Draenei A02 Brown',NULL,0),
(34456,'esMX','Monster - Dagger, Draenei A02 Gold',NULL,0),
(34457,'esMX','Monster - Dagger, Draenei A02 Purple',NULL,0),
(34458,'esMX','Monster - Dagger, Draenei A02 Yellow',NULL,0),
(34459,'esMX','Monster - Dagger, Draenei A03 Black',NULL,0),
(34460,'esMX','Monster - Dagger, Draenei A03 Blue',NULL,0),
(34461,'esMX','Monster - Dagger, Draenei A03 Brown',NULL,0),
(34462,'esMX','Monster - Dagger, Draenei A03 Gold',NULL,0),
(34463,'esMX','Monster - Dagger, Draenei A03 Yellow',NULL,0),
(34465,'esMX','Test Firebloom',NULL,0),
(34466,'esMX','Test Fel Iron Toolbox',NULL,0),
(34481,'esMX','Receta: poción de alquimista loco',NULL,0),
(34496,'esMX','Upper Deck - Libro de aviones de papel',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34503,34505,34506,34507,34508,34509,34510,34511,34512,34513,34514,34515,34516,34517,34520,34521,34522,34523,34524,34525) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34503,'esMX','Caja de balas de adamantita',NULL,0),
(34505,'esMX','Monster - Sword, 1H Blood Elf A03 Red - High Red Glow',NULL,0),
(34506,'esMX','Monster - Axe, 1H Blood Elf A02 Blue',NULL,0),
(34507,'esMX','Monster - Axe, 1H Blood Elf A02 Green',NULL,0),
(34508,'esMX','Monster - Axe, 1H Blood Elf A01',NULL,0),
(34509,'esMX','Monster - Axe, 1H Blood Elf A01 Blue',NULL,0),
(34510,'esMX','Monster - Axe, 1H Blood Elf A01 Green',NULL,0),
(34511,'esMX','Monster - Axe, 1H Blood Elf A01 Yellow',NULL,0),
(34512,'esMX','Monster - Axe, 1H Blood Elf A03',NULL,0),
(34513,'esMX','Monster - Axe, 1H Blood Elf A03 Blue',NULL,0),
(34514,'esMX','Monster - Axe, 1H Blood Elf A03 Purple',NULL,0),
(34515,'esMX','Monster - Axe, 1H Blood Elf A03 Yellow',NULL,0),
(34516,'esMX','Monster - Mace, Blood Elf A01 Gold',NULL,0),
(34517,'esMX','Monster - Mace, Blood Elf A02 Gold',NULL,0),
(34520,'esMX','Monster - Axe, Draenei A01 Amethyst',NULL,0),
(34521,'esMX','Monster - Axe, Draenei A01 Blue',NULL,0),
(34522,'esMX','Monster - Axe, Draenei A01 Gold',NULL,0),
(34523,'esMX','Monster - Axe, Draenei A01 Ice',NULL,0),
(34524,'esMX','Monster - Axe, Draenei D01 Blue',NULL,0),
(34525,'esMX','Monster - Axe, Draenei D01 Gold',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34526,34531,34532,34534,34536,34550,34551,34552,34553,34586,34588,34596,34626,34637,34638,34639,34640,34642,34643,34644) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34526,'esMX','Monster - Axe, Draenei D01 Ice',NULL,0),
(34531,'esMX','Monster - Sword, 1H Shattered Sun Trainee',NULL,0),
(34532,'esMX','Monster - Shield, Shattered Sun Trainee',NULL,0),
(34534,'esMX','Monster - Fire Arrow (Not Arrow, Do Not Reuse)',NULL,0),
(34536,'esMX','Monster - Mace2H, Draenei A02 Magenta (High Purple Glow)',NULL,0),
(34550,'esMX','Indalamar''s Ring of 200 Spirit','Don''t you wish this was real!',0),
(34551,'esMX','Indalamar''s Ring of 80 mp5','Don''t you wish this was real!',0),
(34552,'esMX','Monster - Sword, 1H Shattered Sun Archmage',NULL,0),
(34553,'esMX','Monster - Shield, General Tiras',NULL,0),
(34586,'esMX','Monster - Shield, Shattered Sun D01 Green',NULL,0),
(34588,'esMX','Monster - Shield, Shattered Sun D01 Purple',NULL,0),
(34596,'esMX','Monster - Sword, 1H Blood Elf A02 Red (High Red Flame)',NULL,0),
(34626,'esMX','Mando de tonque prototipo',NULL,0),
(34637,'esMX','Monster - Axe 1H, Warsong Guards',NULL,0),
(34638,'esMX','Monster - Axe, 2H Warsong Guards',NULL,0),
(34639,'esMX','Monster - Mace2H, Warsong Guard',NULL,0),
(34640,'esMX','Monster - Sword, 1H Warsong Guard',NULL,0),
(34642,'esMX','Sangre de bestia DEPRECATED',NULL,0),
(34643,'esMX','Plumilla DEPRECATED',NULL,0),
(34644,'esMX','Plumín de cobre DEPRECATED',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34645,34647,34660,34662,34663,34668,34681,34682,34687,34693,34696,34712,34717,34723,34724,34725,34726,34727,34728,34729) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34645,'esMX','Tinta de tierra deprecated',NULL,0),
(34647,'esMX','Papiro basto',NULL,0),
(34660,'esMX','Plumín de plata DEPRECATED','Usado por los escribas para hacer plumillas.',0),
(34662,'esMX','zzOLDEnchanted Thorium Spikes',NULL,0),
(34663,'esMX','Pluma de plata DEPRECATED',NULL,0),
(34668,'esMX','Monster - Axe, 2H War B01 Red',NULL,0),
(34681,'esMX','Monster - Warsong Hold - Warsong Honor Guard - Honor Blade',NULL,0),
(34682,'esMX','Monster - Warsong Hold - Warsong Honor Guard - Honor Blade 1H',NULL,0),
(34687,'esMX','Documento de la investigación de La Falla Oeste','El sobre tiene un sello mágico que impide abrirlo.',0),
(34693,'esMX','Monster - Sword2H, Horde PvP (Red)',NULL,0),
(34696,'esMX','Monster - Sword, 1H Mage Hunter Basic',NULL,0),
(34712,'esMX','Sello centelleante',NULL,0),
(34717,'esMX','Monster - Item, Vial Green Offhand',NULL,0),
(34723,'esMX','Pescado de Rasganorte 01',NULL,0),
(34724,'esMX','Pescado de Rasganorte 02',NULL,0),
(34725,'esMX','Pescado de Rasganorte 03',NULL,0),
(34726,'esMX','Pescado de Rasganorte 04',NULL,0),
(34727,'esMX','Pescado de Rasganorte 05',NULL,0),
(34728,'esMX','Pescado de Rasganorte 06',NULL,0),
(34729,'esMX','Pescado de Rasganorte 07',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34730,34731,34732,34733,34734,34770,34771,34776,34803,34805,34816,34817,34818,34819,34820,34821,34873,34874,34875,34876) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34730,'esMX','Pescado de Rasganorte 08',NULL,0),
(34731,'esMX','Pescado de Rasganorte 09',NULL,0),
(34732,'esMX','Pescado de Rasganorte 10',NULL,0),
(34733,'esMX','Pescado de Rasganorte 11',NULL,0),
(34734,'esMX','Pescado de Rasganorte 12',NULL,0),
(34770,'esMX','Cooked Northrend Fish 12',NULL,0),
(34771,'esMX','Monster - Staff, Wooden Handle Rounded Head High Red Flame',NULL,0),
(34776,'esMX','QA Test Ring +100% Stun Resist',NULL,0),
(34803,'esMX','Tier 1 Northrend Engineering Widget',NULL,0),
(34805,'esMX','QA Test Ring +100 Spell Hit Rating',NULL,0),
(34816,'esMX','Monster - Vrykul - Axe, 1H',NULL,0),
(34817,'esMX','Monster - Vrykul - Axe, 2H',NULL,0),
(34818,'esMX','Monster - Vrykul - Mace, 2H',NULL,0),
(34819,'esMX','Monster - Vrykul - Mace, 1H',NULL,0),
(34820,'esMX','Monster - Vrykul - Sword, 2H',NULL,0),
(34821,'esMX','Monster - Vrykul - Sword, 1H',NULL,0),
(34873,'esMX','Monster - Sunwell Raid - Bow, D01 Green',NULL,0),
(34874,'esMX','Monster - Sunwell Raid - Polearm, Blue',NULL,0),
(34875,'esMX','Monster - Sunwell Raid - Dagger, D01 Yellow',NULL,0),
(34876,'esMX','Monster - Sunwell Raid - Sword, 2H DarkRed',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(34877,34878,34879,34881,34882,34883,34884,34885,34886,34899,34965,34966,34969,34970,35117,35118,35120,35124,35220,35235) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(34877,'esMX','Monster - Sunwell Raid - Staff, D02 Silver',NULL,0),
(34878,'esMX','Monster - Sunwell Raid - Staff, D03 Purple',NULL,0),
(34879,'esMX','Monster - Sunwell Raid - Sword, 1H D02 Dark',NULL,0),
(34881,'esMX','Monster - Item, Offhand Outland Raid D01',NULL,0),
(34882,'esMX','Monster - Staff, Outland Raid D06, Blue',NULL,0),
(34883,'esMX','Monster - Axe, 1H Outland Raid D02',NULL,0),
(34884,'esMX','Monster - Staff, Outland Raid D03',NULL,0),
(34885,'esMX','Monster - Mace, Outland Raid D03',NULL,0),
(34886,'esMX','Monster - Sword, 1H Outland Raid D05',NULL,0),
(34899,'esMX','Monster - Staff, Dragon',NULL,0),
(34965,'esMX','Test Copy Unwavering Legguards',NULL,0),
(34966,'esMX','Test Two Unwavering Legguards',NULL,0),
(34969,'esMX','Plate Helmet D3 (test) Two',NULL,0),
(34970,'esMX','Plate Helmet D3 (test) Three',NULL,0),
(35117,'esMX','Monster - Sword, 1H Blood Elf D01 Gold',NULL,0),
(35118,'esMX','DETA TEST',NULL,0),
(35120,'esMX','Símbolo de la Muerte','La insignia vil del Culto de los Malditos.',0),
(35124,'esMX','DETA TEST 2',NULL,0),
(35220,'esMX','Monster - Staff, Sunwell D02',NULL,0),
(35235,'esMX','Monster - Halberd, Kaw''s',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(35236,35312,35463,35480,35482,35485,35499,35510,35515,35517,35518,35519,35520,35521,35522,35523,35524,35525,35526,35527) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(35236,'esMX','Monster - Axe, 2H Black Temple Black',NULL,0),
(35312,'esMX','Monster - Item, Seal Horde',NULL,0),
(35463,'esMX','Monster - Axe, 1H Outland Raid D04',NULL,0),
(35480,'esMX','Guía de mantenimiento de recolector de cosecha',NULL,0),
(35482,'esMX','Ingeniería Agrícola para Torpes',NULL,0),
(35485,'esMX','Goblin Rocket Launcher [PH]',NULL,0),
(35499,'esMX','Ninja Grenade [PH]',NULL,0),
(35510,'esMX','Monster - Sword, 1H Kil''jaeden',NULL,0),
(35515,'esMX','Birmingham Test Item','For Brian to Test things',0),
(35517,'esMX','Patrón: ataduras de reflejos de relámpago',NULL,0),
(35518,'esMX','Patrón: brazales de pensamiento ágil',NULL,0),
(35519,'esMX','Patrón: brazales de vida renovada',NULL,0),
(35520,'esMX','Patrón: ataduras Tierra Viva',NULL,0),
(35521,'esMX','Patrón: sobrehombros Tierra Viva',NULL,0),
(35522,'esMX','Patrón: manto de pensamiento ágil',NULL,0),
(35523,'esMX','Patrón: hombreras de vida renovada',NULL,0),
(35524,'esMX','Patrón: sobrehombros de reflejos de relámpago',NULL,0),
(35525,'esMX','Patrón: manto Sanapresto',NULL,0),
(35526,'esMX','Patrón: brazaletes Sanapresto',NULL,0),
(35527,'esMX','Patrón: brazales Golpepresto',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(35529,35531,35533,35534,35535,35536,35537,35538,35539,35540,35541,35542,35544,35545,35546,35548,35549,35550,35551,35552) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(35529,'esMX','Diseño: brazales albacero',NULL,0),
(35531,'esMX','Diseño: brazales de acero presto',NULL,0),
(35533,'esMX','Boceto: amuleto de caudal de vida','Te enseña a crear un amuleto de caudal de vida.',0),
(35534,'esMX','Boceto: sortija de korio duro',NULL,0),
(35535,'esMX','Boceto: gargantilla de korio duro',NULL,0),
(35536,'esMX','Boceto: lazada de poder forjado',NULL,0),
(35537,'esMX','Boceto: colgante de fuego solar',NULL,0),
(35538,'esMX','Boceto: anillo de caudal de vida',NULL,0),
(35539,'esMX','Patrón: caparazón de sol y sombra',NULL,0),
(35540,'esMX','Patrón: abrazo del Fénix',NULL,0),
(35541,'esMX','Patrón: guantes del Fénix de flechero',NULL,0),
(35542,'esMX','Patrón: guantes de anochecer inmortal',NULL,0),
(35544,'esMX','Patrón: manos de Luz eterna',NULL,0),
(35545,'esMX','Patrón: coselete de cuero del sol',NULL,0),
(35546,'esMX','Patrón: guanteletes de cuero del sol',NULL,0),
(35548,'esMX','Patrón: toga de Luz eterna',NULL,0),
(35549,'esMX','Patrón: coselete de escamas caladas de sol',NULL,0),
(35550,'esMX','Patrón: guantes de escamas caladas de sol',NULL,0),
(35551,'esMX','Patrón: manijas de fuego solar',NULL,0),
(35552,'esMX','Patrón: toga de fuego solar',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(35553,35554,35556,35558,35561,35567,35621,35626,35667,35674,35684,35689,35710,35712,35713,35714,35715,35719,35721,35724) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(35553,'esMX','Diseño: puños de batalla de korio duro',NULL,0),
(35554,'esMX','Diseño: placa de batalla de korio duro',NULL,0),
(35556,'esMX','Diseño: guanteletes bendecidos por el sol',NULL,0),
(35558,'esMX','Tarjeta de alistamiento',NULL,0),
(35561,'esMX','Monster - Quest - Thassarian''s Sword',NULL,0),
(35567,'esMX','Pergamino sin descifrar DEPRECATED',NULL,0),
(35621,'esMX','Poder eterno',NULL,0),
(35626,'esMX','Maná eterno',NULL,0),
(35667,'esMX','Palabra rúnica de magia menor DEPRECATED',NULL,0),
(35674,'esMX','Test Druid Weapon',NULL,0),
(35684,'esMX','Monster - Dagger, Horde PvP - Purple (Special Glow)',NULL,0),
(35689,'esMX','Chris Test Artifact of Doom','A test artifact.',0),
(35710,'esMX','Jamón asado delicioso',NULL,0),
(35712,'esMX','Monster - Sword, 2H Blood Elf C03 Blue (Med Blue Glow)',NULL,0),
(35713,'esMX','Ninja Hook [PH]',NULL,0),
(35714,'esMX','Monster - Staff, Velen',NULL,0),
(35715,'esMX','Glifo de Maná ponzoñoso [PH]',NULL,0),
(35719,'esMX','Monster - Claw Insect Offhand',NULL,0),
(35721,'esMX','Lámpara de Frascotaur','Hogar de los Frascotaur.',0),
(35724,'esMX','Monster - Northrend - Hammer, 2H - Agmar''s Hammer',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(35727,35732,35735,35740,35741,35742,35743,35744,35745,35775,35776,35778,35779,35781,35787,35789,35804,35805,35853,35855) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(35727,'esMX','Monster - Mace, Iron Dwarf Lightning',NULL,0),
(35732,'esMX','TEST HELM',NULL,0),
(35735,'esMX','Craig''s Test Boots of Righteous Affliction',NULL,0),
(35740,'esMX','Monster - Staff, Feral D02 White',NULL,0),
(35741,'esMX','Monster - Staff, Feral D02',NULL,0),
(35742,'esMX','Monster - Staff, Feral D02 Black',NULL,0),
(35743,'esMX','Monster - Staff, Feral D02 Purple',NULL,0),
(35744,'esMX','Carta de la fortuna: Plata',NULL,0),
(35745,'esMX','Caja del tesoro',NULL,0),
(35775,'esMX','Carta de navegación de Skadir: parte 1','La primera parte de una compleja carta de navegación.',0),
(35776,'esMX','Carta de navegación de Skadir: parte 2','La segunda parte de una compleja carta de navegación.',0),
(35778,'esMX','Carta de navegación de Skadir: parte 4','La cuarta parte de una compleja carta de navegación.',0),
(35779,'esMX','Monster - Glaive - 3 Blade Black (Medium Blue Glow)',NULL,0),
(35781,'esMX','Monster - Staff, Sunwell D02 Purple (High Purple Glow)',NULL,0),
(35787,'esMX','Tarot de caza: bestias menores DEPRECATED',NULL,0),
(35789,'esMX','Tarot de caza: bestias menores DEPRECATED',NULL,0),
(35804,'esMX','Monster - Bow, Northrend - Soar Hawkfury',NULL,0),
(35805,'esMX','Monster - Dragonblight - Forsaken Blight Gun',NULL,0),
(35853,'esMX','Documento de Acuerdo de la Alianza',NULL,0),
(35855,'esMX','Una carta a casa',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(35874,35939,35942,36745,36749,36750,36755,36761,36762,36763,36773,36778,36790,36791,36792,36831,36837,36838,36839,36840) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(35874,'esMX','Mansión para mascotas portátil de Chisporroteo','Alimenta, da de beber, lava y recoge la caca automáticamente. No incluye la mascota.',0),
(35939,'esMX','Monster - Sword - 2H - Koltira Deathweaver',NULL,0),
(35942,'esMX','Monster - Staff, Greatmother Icemist',NULL,0),
(36745,'esMX','Piedra de adivinación',NULL,0),
(36749,'esMX','Monster - Sword, Falchion (Sheath: Back)',NULL,0),
(36750,'esMX','Monster - Staff, Jeweled D01 Green (Low Blue Flame)',NULL,0),
(36755,'esMX','Monster - Bow, Northrend C01 (Olive)',NULL,0),
(36761,'esMX','Monster - Item, Tankard Metal Offhand (Red Glow)',NULL,0),
(36762,'esMX','Monster - Utgarde, Crossbow',NULL,0),
(36763,'esMX','Llave de la prisión Anub''ar',NULL,0),
(36773,'esMX','Tubo gigante','Con agujeritos hechos.',0),
(36778,'esMX','Monster - Spear, Cool Blue (Medium Blue Glow)',NULL,0),
(36790,'esMX','Monster - Polearm, Dragon Hunter 001 (Troll)',NULL,0),
(36791,'esMX','Monster - Polearm, Dragon Hunter 002 (Troll)',NULL,0),
(36792,'esMX','Monster - Polearm, Dragon Hunter 003 (Troll)',NULL,0),
(36831,'esMX','Costillas robadas','Justo cuando iba a pegar un mordisco',0),
(36837,'esMX','Formula: 02 Enchanting Recipe Template (Good)',NULL,0),
(36838,'esMX','Formula: 03 Enchanting Recipe Template (Superior)',NULL,0),
(36839,'esMX','Formula: 04 Enchanting Recipe Template (Epic)',NULL,0),
(36840,'esMX','Formula: 01 Enchanting Recipe Template (Standard)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(36841,36842,36843,36844,36845,36869,36896,36897,36898,36900,36911,36915,36955,36959,36960,36963,36964,36965,36966,36967) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(36841,'esMX','Recipe: Alchemy Recipe Template 01 (Standard)',NULL,0),
(36842,'esMX','Recipe: Alchemy Recipe Template 02 (Good)',NULL,0),
(36843,'esMX','Recipe: Alchemy Recipe Template 03 (Superior)',NULL,0),
(36844,'esMX','Recipe: Alchemy Recipe Template 04 (Epic)',NULL,0),
(36845,'esMX','Deprecated Alchemy Elixir Template',NULL,0),
(36869,'esMX','Monster - Staff, Lord Valthalak (Particles)',NULL,0),
(36896,'esMX','Piedra de hechizo demoníaca (DEPRECATED)',NULL,0),
(36897,'esMX','Piedra de hechizo vil (DEPRECATED)',NULL,0),
(36898,'esMX','Vara rúnica de azurita','También puede servir de vara encantadora rúnica inferior.',0),
(36900,'esMX','Aceite de zahorí excepcional',NULL,0),
(36911,'esMX','Mena de azurita',NULL,0),
(36915,'esMX','Barra de acero gélido',NULL,0),
(36955,'esMX','Grimorio Descarga de Fuego (Rango 9)',NULL,0),
(36959,'esMX','Grimorio Pacto de Sangre (Rango 7)',NULL,0),
(36960,'esMX','Grimorio Escudo de Fuego (Rango 7)',NULL,0),
(36963,'esMX','Grimorio Tormento (Rango 8)',NULL,0),
(36964,'esMX','Grimorio Sacrificio (Rango 8)',NULL,0),
(36965,'esMX','Grimorio Sacrificio (Rango 9)',NULL,0),
(36966,'esMX','Grimorio Consumir Sombras (Rango 8)',NULL,0),
(36967,'esMX','Grimorio Consumir Sombras (Rango 9)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(36968,36970,36987,36990,37001,37059,37089,37090,37100,37102,37103,37119,37120,37123,37130,37131,37132,37133,37146,37249) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(36968,'esMX','Grimorio Sufrimiento (Rango 7)',NULL,0),
(36970,'esMX','Grimorio Sufrimiento (Rango 8)',NULL,0),
(36987,'esMX','Fragmentos de hueso endurecidos',NULL,0),
(36990,'esMX','Monster - Sword, Scimitar Golden (Blue Glow)',NULL,0),
(37001,'esMX','Test Scott K Sword',NULL,0),
(37059,'esMX','Monster - Item, Tankard Brewfest (Year 2 Blue)',NULL,0),
(37089,'esMX','Cono de miel',NULL,0),
(37090,'esMX','Rapiamapola',NULL,0),
(37100,'esMX','Tinta de plata',NULL,0),
(37102,'esMX','Tinta de esmeralda deprecated',NULL,0),
(37103,'esMX','Deprecated Alabaster Ink',NULL,0),
(37119,'esMX','Monster - Shield, Forgotten Footman',NULL,0),
(37120,'esMX','Monster - Mace, Alliance 1H',NULL,0),
(37123,'esMX','Monster - Sword2H, Horde Massive Black',NULL,0),
(37130,'esMX','Monster - Item, Harpoon (Thrown)',NULL,0),
(37131,'esMX','Deprecated Tome of Stamina [PH]',NULL,0),
(37132,'esMX','Deprecated Tome of Spells [PH]',NULL,0),
(37133,'esMX','Deprecated Tome of Life [PH]',NULL,0),
(37146,'esMX','Monster - Sword2H, Northrend D03 (Fear)',NULL,0),
(37249,'esMX','Monster - Bow, 7th Legion Sentinel',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(37266,37308,37309,37310,37327,37328,37341,37342,37531,37532,37533,37544,37549,37550,37551,37561,37563,37578,37589,37596) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(37266,'esMX','Monster - Wand, Stratholme D02',NULL,0),
(37308,'esMX','Monster - Sword2H, Northrend D03',NULL,0),
(37309,'esMX','Monster - Special Arrow (Thori''dal)',NULL,0),
(37310,'esMX','Monster - Mace, Stormhammer (Vengeful)',NULL,0),
(37327,'esMX','Fórmula: encantar arma: Finiquiplaga DEPRECATED',NULL,0),
(37328,'esMX','Fórmula: encantar arma: intelecto excepcional',NULL,0),
(37341,'esMX','Fórmula: encantar botas: agilidad excelente',NULL,0),
(37342,'esMX','Fórmula: encantar guantes: detonación superior',NULL,0),
(37531,'esMX','Círculo del viento gélido',NULL,0),
(37532,'esMX','BT49 Spell Ring4',NULL,0),
(37533,'esMX','BT52 Physical Ring5',NULL,0),
(37544,'esMX','Collar de hueso de draco',NULL,0),
(37549,'esMX','BT49 Healer Neck2',NULL,0),
(37550,'esMX','DEPRECATED Test Glyph 2',NULL,0),
(37551,'esMX','DEPRECATED Test Glyph 3 [PH]',NULL,0),
(37561,'esMX','Toque de los elementos',NULL,0),
(37563,'esMX','BT57 Spell Trinket4',NULL,0),
(37578,'esMX','BT52 Spell Trinket3',NULL,0),
(37589,'esMX','Extractor de mota hiperpotenciado','Succión superior.',0),
(37596,'esMX','Direbrew''s Bottle DO NOT USE',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(37600,37605,37608,37609,37610,37706,37711,37738,37832,37838,37878,37914,37916,37917,37919,37924,37926,37946,37951,37952) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(37600,'esMX','Raíz aterralobos',NULL,0),
(37605,'esMX','Bolsa de monedas','Una bolsa con monedas de cobre. Qué premio tan chungo.',0),
(37608,'esMX','Monster - Vrykul - Axe, 1H - Black Glow',NULL,0),
(37609,'esMX','Monster - Sword2H, Claymore Silver (Black Glow)',NULL,0),
(37610,'esMX','Monster - Sword2H, Claymore Silver (Red Flame)',NULL,0),
(37706,'esMX','Saronita reforjada',NULL,0),
(37711,'esMX','Currency Token Test Token',NULL,0),
(37738,'esMX','Un puñado de púas','Au, pincha.',0),
(37832,'esMX','Monster - Axe, Arcanite Reaper as 1H',NULL,0),
(37838,'esMX','Flauta gruesa','TEMP Test Vendor Item',0),
(37878,'esMX','Elixir de sangre de huargo',NULL,0),
(37914,'esMX','Monster - Mace 1H, 7th Legion Cleric',NULL,0),
(37916,'esMX','Monster - Shield, 7th Legion Cleric',NULL,0),
(37917,'esMX','Monster - Polearm, 7th Legion Wyrm Hunter',NULL,0),
(37919,'esMX','Test Scott K Bow',NULL,0),
(37924,'esMX','Monster - Dagger, Bowie Knife (Savagery)',NULL,0),
(37926,'esMX','DEPCREATED Epic Mana Potion',NULL,0),
(37946,'esMX','DB14 Cloth Healer Feet',NULL,0),
(37951,'esMX','DB21 Cloth Healer Legs',NULL,0),
(37952,'esMX','DB22 Healer Ring2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(37972,37973,37974,37975,37977,37978,37979,37994,37997,38009,38015,38016,38017,38018,38019,38020,38021,38022,38038,38058) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(37972,'esMX','DB49 Cloth Healer Feet2',NULL,0),
(37973,'esMX','DB51 Cloth Spell Legs3',NULL,0),
(37974,'esMX','DB52 Spell Cloak2',NULL,0),
(37975,'esMX','DB53 Cloth Spell Shoulder3',NULL,0),
(37977,'esMX','DB56 Cloth Healer Shoulder2',NULL,0),
(37978,'esMX','DB57 Cloth Spell Chest3',NULL,0),
(37979,'esMX','DB58 Cloth Spell Feet3',NULL,0),
(37994,'esMX','DB21 Leather Healer Head',NULL,0),
(37997,'esMX','DB26 Spell Neck2',NULL,0),
(38009,'esMX','DB42 Physical Ring4',NULL,0),
(38015,'esMX','DB49 Leather Physical Chest4',NULL,0),
(38016,'esMX','DB51 Leather Physical Head4',NULL,0),
(38017,'esMX','DB52 Leather Healer Glove',NULL,0),
(38018,'esMX','DB53 Leather Physical Feet3',NULL,0),
(38019,'esMX','DB54 Leather Physical Legs4',NULL,0),
(38020,'esMX','DB56 Leather Physical Gloves4',NULL,0),
(38021,'esMX','DB57 Leather Healer Head2',NULL,0),
(38022,'esMX','DB58 Leather Physical Shoulder4',NULL,0),
(38038,'esMX','DB21 Mail Healer Head',NULL,0),
(38058,'esMX','DB49 Mail Healer Legs2',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38059,38060,38061,38062,38063,38064,38065,38066,38067,38069,38074,38075,38076,38077,38078,38079,38099,38113,38119,38120) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38059,'esMX','Dumb Old Bag [PH]',NULL,0),
(38060,'esMX','DB51 Mail Physical Legs3',NULL,0),
(38061,'esMX','DB53 Mail Physical Waist3',NULL,0),
(38062,'esMX','DB54 Mail Physical Feet3',NULL,0),
(38063,'esMX','DB61Mail Physical Bracer3',NULL,0),
(38064,'esMX','DB56 Mail Healer Bracer2',NULL,0),
(38065,'esMX','DB57 Mail Healer Head2',NULL,0),
(38066,'esMX','DB58 Mail Healer Feet2',NULL,0),
(38067,'esMX','DB14 Physical Ring2',NULL,0),
(38069,'esMX','DB57 Physical Neck3',NULL,0),
(38074,'esMX','DB59 Healer Trinket2',NULL,0),
(38075,'esMX','DB59 Spell Trinket3',NULL,0),
(38076,'esMX','DB59 Physical Trinket5',NULL,0),
(38077,'esMX','DB22 Spell Trinket2',NULL,0),
(38078,'esMX','DB26 Physical Trinket3',NULL,0),
(38079,'esMX','DB52 Physical Trinket6',NULL,0),
(38099,'esMX','Monster - Axe 2H (EPL Deathknight Trainer)',NULL,0),
(38113,'esMX','DB42 Plate Healer Glove2',NULL,0),
(38119,'esMX','DB49 Plate Physical Head3',NULL,0),
(38120,'esMX','DB51 Plate Physical Bracer3',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38121,38122,38123,38124,38125,38136,38139,38158,38159,38166,38167,38168,38179,38180,38182,38183,38184,38185,38192,38193) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38121,'esMX','DB53 Plate Healer Shoulder',NULL,0),
(38122,'esMX','DB54 Plate Physical Bracer4',NULL,0),
(38123,'esMX','DB56 Plate Healer Head2',NULL,0),
(38124,'esMX','DB57 Plate Healer Chest2',NULL,0),
(38125,'esMX','DB58 Plate Physical Waist4',NULL,0),
(38136,'esMX','DB40 Spell Staff3',NULL,0),
(38139,'esMX','DB50 Healer Mace3',NULL,0),
(38158,'esMX','DB20 Fast Sword',NULL,0),
(38159,'esMX','DB20 Slow Right Fist',NULL,0),
(38166,'esMX','DB20 Gun',NULL,0),
(38167,'esMX','DB21 Thrown',NULL,0),
(38168,'esMX','DB22 Hunter Bow2',NULL,0),
(38179,'esMX','DB38 Slow Right Fist2',NULL,0),
(38180,'esMX','DB40 Slow Left Fist2',NULL,0),
(38182,'esMX','DB38 2H Sword2',NULL,0),
(38183,'esMX','DB40 Fast Sword2',NULL,0),
(38184,'esMX','DB40 Fast Dagger3',NULL,0),
(38185,'esMX','DB40 Bow3',NULL,0),
(38192,'esMX','DB55 Thrown2',NULL,0),
(38193,'esMX','DB50 2H Mace3',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38199,38200,38201,38203,38205,38209,38210,38211,38215,38216,38235,38236,38249,38296,38297,38298,38304,38315,38316,38317) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38199,'esMX','DB50 Slow Sword3',NULL,0),
(38200,'esMX','DB50 Crossbow3',NULL,0),
(38201,'esMX','DB14 Spell Wand',NULL,0),
(38203,'esMX','DB38 Healer Wand2',NULL,0),
(38205,'esMX','DB52 Healer Wand4',NULL,0),
(38209,'esMX','Monster - Polearm, Epic D 06',NULL,0),
(38210,'esMX','Monster - Polearm, Epic D 02',NULL,0),
(38211,'esMX','Monster - Polearm, Epic D 03',NULL,0),
(38215,'esMX','Monster - Sword, Rapier (High Red Glow)',NULL,0),
(38216,'esMX','Monster - Axe, Insano (High Red Flame)',NULL,0),
(38235,'esMX','Monster - Mace2H, Spikey',NULL,0),
(38236,'esMX','TEST QUEST SOCKET',NULL,0),
(38249,'esMX','Monster - Throwing Spear (Poisoned)',NULL,0),
(38296,'esMX','Monster - Polearm, C (Blue)',NULL,0),
(38297,'esMX','Monster - Polearm, C - Blue Flames (Blue)',NULL,0),
(38298,'esMX','Monster - Staff, Outland Raid D03 Blue',NULL,0),
(38304,'esMX','Monster - Scythe, Antiok''s',NULL,0),
(38315,'esMX','Monster - Staff, Epic A (Blue Fire)',NULL,0),
(38316,'esMX','Scaling Stat Test Shoulders',NULL,0),
(38317,'esMX','Ofrenda Drakkari preparada',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38331,38383,38385,38391,38392,38394,38395,38446,38447,38449,38450,38451,38470,38472,38474,38475,38476,38478,38479,38482) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38331,'esMX','Pluma esmeralda DEPRECATED','También usada por los inscriptores para crear libros, pergaminos y glifos.',0),
(38383,'esMX','Locura de Valonante',NULL,0),
(38385,'esMX','Scaling Stat Test Trinket',NULL,0),
(38391,'esMX','Scaling Stat Test 1H Sword',NULL,0),
(38392,'esMX','Scaling Stat Test 2H Sword',NULL,0),
(38394,'esMX','Scaling Stat Test Wand',NULL,0),
(38395,'esMX','Scaling Stat Test Bow',NULL,0),
(38446,'esMX','DEPRECATED Mail Caster Leatherworking Belt',NULL,0),
(38447,'esMX','DEPRECATED Leather Melee Leatherworking Legs',NULL,0),
(38449,'esMX','DEPRECATED Leather Melee Leatherworking Boots',NULL,0),
(38450,'esMX','DEPRECATED Leather Caster Leatherworking Chest',NULL,0),
(38451,'esMX','DEPRECATED Leather Caster Leatherworking Shoulders',NULL,0),
(38470,'esMX','QA Test Slow Dagger',NULL,0),
(38472,'esMX','QA Test Slow Crossbow',NULL,0),
(38474,'esMX','Tambores de gran batalla',NULL,0),
(38475,'esMX','Tambores de restauración sublime',NULL,0),
(38476,'esMX','Tambores de guerra oscura',NULL,0),
(38478,'esMX','Tambores de precisión',NULL,0),
(38479,'esMX','Control de máquina voladora (prototipo)','Para usarlo, necesitas habilidad de equitación de experto o un nivel superior.',0),
(38482,'esMX','QA Test Slow Two-Handed Polearm',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38485,38486,38487,38488,38489,38490,38491,38492,38493,38494,38495,38499,38500,38501,38502,38503,38507,38508,38509,38511) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38485,'esMX','zzoldQA Test +2000 Spell Healing Ring',NULL,0),
(38486,'esMX','QA Test 50% Stun Resist Ring',NULL,0),
(38487,'esMX','Monster - Polearm, Epic D 04',NULL,0),
(38488,'esMX','Monster - Polearm, Epic D 02 Glow Red Low',NULL,0),
(38489,'esMX','QA Test -50% Interrupt Duration Ring',NULL,0),
(38490,'esMX','Monster - Polearm, Epic D 03 Glow Purple Low',NULL,0),
(38491,'esMX','Monster - Polearm, Epic D Glow Yellow Low',NULL,0),
(38492,'esMX','QA Test Gem Slot Vest',NULL,0),
(38493,'esMX','QA Test Gem Pants',NULL,0),
(38494,'esMX','QA Test Gem Shoulderpads',NULL,0),
(38495,'esMX','QA Test Gem Gloves',NULL,0),
(38499,'esMX','QA Test Blank Blue Gem','Encaja en una ranura de color azul.',0),
(38500,'esMX','QA Test Blank Red Gem','Encaja en una ranura de color rojo.',0),
(38501,'esMX','QA Test Blank Yellow Gem','Encaja en una ranura de color amarillo.',0),
(38502,'esMX','QA Test Blank Orange Gem','Encaja en una ranura de color rojo o amarillo.',0),
(38503,'esMX','QA Test Blank Green Gem','Encaja en una ranura de color amarillo o azul.',0),
(38507,'esMX','Monster - Staff, Yellow Jeweled with High Yellow Glow',NULL,0),
(38508,'esMX','Monster - Polearm, Epic D Glow Purple Low',NULL,0),
(38509,'esMX','Monster - Axe, 2H Outland Raid D01',NULL,0),
(38511,'esMX','Monster - Mace, Hand of Edward the Odd (Deathfrost)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38526,38554,38565,38568,38569,38570,38571,38580,38593,38594,38595,38596,38598,38599,38602,38603,38604,38608,38609,38635) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38526,'esMX','Atadura del alma encarcelada',NULL,0),
(38554,'esMX','Monster - Shield, Crest B03',NULL,0),
(38565,'esMX','Reliquia Drakkari antigua',NULL,0),
(38568,'esMX','Pulsera de talismán Drakkari','No necesariamente de la buena suerte...',0),
(38569,'esMX','Ropas Drakkari antiguas','Parecen... personales.',0),
(38570,'esMX','Pendiente Drakkari roto',NULL,0),
(38571,'esMX','Trineo de cuero','Solo se puede usar en Rasganorte.',0),
(38580,'esMX','Monster - Apocalyptic Staff (Fiery Weapon)',NULL,0),
(38593,'esMX','Pattern: Leatherworking Template 01 (Standard)',NULL,0),
(38594,'esMX','Pattern: Leatherworking Template 02 (Uncommon)',NULL,0),
(38595,'esMX','Pattern: Leatherworking Template 03 (Superior)',NULL,0),
(38596,'esMX','Pattern: Leatherworking Template 04 (Epic)',NULL,0),
(38598,'esMX','Patrón: leotardos árticos oscuros',NULL,0),
(38599,'esMX','Patrón: pechera ártica oscura',NULL,0),
(38602,'esMX','Monster - Claw, Badass (Frost)',NULL,0),
(38603,'esMX','Monster - Claw, Badass offhand (Frost)',NULL,0),
(38604,'esMX','Monster - Polearm, PVPAlliance_A01 (No Sheathe Point)',NULL,0),
(38608,'esMX','Notas de testeo','Nunca sabes qué vas a encontrar',0),
(38609,'esMX','Monster - Polearm, Aspects (Orange)',NULL,0),
(38635,'esMX','Monster - Shield, Horde B03 Quest01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38641,38643,38652,38654,38685,38690,38692,38693,38694,38702,38704,38720,38721,38722,38723,38724,38725,38738,38740,38742) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38641,'esMX','Deprecated Frostweave Bandage [PH]',NULL,0),
(38643,'esMX','Venda de tejido de Escarcha tupida',NULL,0),
(38652,'esMX','Monster - Staff, Utgarde D01',NULL,0),
(38654,'esMX','Informe de Corvus',NULL,0),
(38685,'esMX','Pergamino de teletransporte: Zul''Farrak',NULL,0),
(38690,'esMX','Corazón de vermis de escarcha congelado',NULL,0),
(38692,'esMX','Rama bélica de Cenarius',NULL,0),
(38693,'esMX','Hoja de hechizo de Tirisfal',NULL,0),
(38694,'esMX','Hombreras de "familia"',NULL,0),
(38702,'esMX','Test Pet Renamer',NULL,0),
(38704,'esMX','Test Large Stack',NULL,0),
(38720,'esMX','Monster - Polearm, Scarlet Captain',NULL,0),
(38721,'esMX','Monster - Scarlet Crusade, Axe 1H',NULL,0),
(38722,'esMX','Monster - Scarlet Crusade, Mace 1H',NULL,0),
(38723,'esMX','Monster - Scarlet Crusade, Sword 1H',NULL,0),
(38724,'esMX','Glifo de fuerza natural Deprecated',NULL,0),
(38725,'esMX','DEPRECATED item',NULL,0),
(38738,'esMX','QR IC32 Cloth Spell Waist3 - PH',NULL,0),
(38740,'esMX','QR IC36 Cloth Spell Chest3 - PH',NULL,0),
(38742,'esMX','QR IC39 Cloth Spell Shoulder3 - PH',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(38952,38957,38970,38996,39007,39008,39009,39012,39014,39024,39032,39037,39039,39042,39061,39067,39069,39071,39101,39103) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(38952,'esMX','Deprecated Scroll of Enchant Bracer - Major Stamina',NULL,0),
(38957,'esMX','Pergamino de Encantar arma: golpe excepcional',NULL,0),
(38970,'esMX','Pergamino de Encantar guantes: sanación excepcional',NULL,0),
(38996,'esMX','Pergamino de Encantar brazales: sanación sublime',NULL,0),
(39007,'esMX','QR IC41 Spell Wand - PH',NULL,0),
(39008,'esMX','QR IC41Healer Wand - PH',NULL,0),
(39009,'esMX','QR IC41Healer Shield2 - PH',NULL,0),
(39012,'esMX','QR IC41 Tank Shield2 - PH',NULL,0),
(39014,'esMX','Fundaciones florales','Una pequeña colección de raras hierbas.',0),
(39024,'esMX','Monster - Sword2H, Northrend C02 Red',NULL,0),
(39032,'esMX','Monster - Scourge Sky Darkener, Bow',NULL,0),
(39037,'esMX','QR IC32 Leather Physical Legs3 - PH',NULL,0),
(39039,'esMX','QR IC36 Leather Physical Head3 - PH',NULL,0),
(39042,'esMX','QR IC39 Leather Physical Shoulder3 - PH',NULL,0),
(39061,'esMX','Manual of the Master Skinner DEPRECATED',NULL,0),
(39067,'esMX','QR IC32 Mail Physical Feet2 - PH',NULL,0),
(39069,'esMX','QR IC39 Mail Physical Chest3 - PH',NULL,0),
(39071,'esMX','QR IC36 Mail Physical Shoulder3 - PH',NULL,0),
(39101,'esMX','Monster - Scourge Sky Darkener, Bow v2',NULL,0),
(39103,'esMX','QR IC32 Plate Physical Shoulder3 - PH',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(39106,39107,39111,39122,39123,39126,39137,39145,39147,39149,39153,39155,39214,39287,39288,39289,39290,39300,39303,39304) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(39106,'esMX','QR IC36 Plate Healer Glove - PH',NULL,0),
(39107,'esMX','QR IC39 Plate Physical Waist3 - PH',NULL,0),
(39111,'esMX','QR IC41 Feral Staff3 - PH',NULL,0),
(39122,'esMX','QR IC35 Spell Staff2 - PH',NULL,0),
(39123,'esMX','QR IC35 Polearm (Hunter) - PH',NULL,0),
(39126,'esMX','QR IC35 Fast Dagger2 - PH',NULL,0),
(39137,'esMX','QR IC35 Healer Axe - PH',NULL,0),
(39145,'esMX','QR IC35 Fast Mace - PH',NULL,0),
(39147,'esMX','Pez espada de 56 kilos',NULL,0),
(39149,'esMX','DEPRECATED"Fred"','El pez mascota de alguien.',0),
(39153,'esMX','Manual: venda de tejido de Escarcha densa',NULL,0),
(39155,'esMX','Monster - Mace, Volkhan Encounter',NULL,0),
(39214,'esMX','obsolete',NULL,0),
(39287,'esMX','Monster - Sword, 1H Nexus D02 Dark, Black Glow',NULL,0),
(39288,'esMX','Monster - Shield, Northend C01 Black',NULL,0),
(39289,'esMX','Monster - Staff, Nexus D01 Purple w/Black Glow',NULL,0),
(39290,'esMX','Monster - Axe, 1H Nexus D01 Orange w/Black Glow',NULL,0),
(39300,'esMX','Extensor de capa con resorte',NULL,0),
(39303,'esMX','Alfombra voladora presta DEPRECATED','Te enseña a invocar esta alfombra. Solo se puede invocar en Terrallende o Rasganorte. Es muy rápida.',0),
(39304,'esMX','Glyph of Natural Force [PH]',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(39312,39325,39352,39359,39381,39382,39384,39447,39456,39511,39584,39585,39586,39587,39600,39658,39659,39660,39661,39662) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(39312,'esMX','Monster - Sword2H, Ragglesnout X''Caliboar (High Red Flame)',NULL,0),
(39325,'esMX','Monster - Polearm, Crypt Guardian',NULL,0),
(39352,'esMX','Tinta de ébano deprecated',NULL,0),
(39359,'esMX','Monster - Axe, 2H Hardened Skirmisher (1H as 2H)',NULL,0),
(39381,'esMX','Monster - Axe, 2H Northrend C01 Brown (Vrykul)',NULL,0),
(39382,'esMX','Monster - Axe, 1H Northrend C01 Stone (Vrykul)',NULL,0),
(39384,'esMX','Monster - Shield, Northend C02 Black',NULL,0),
(39447,'esMX','Monster - Axe, 2H Northrend B02 Brown',NULL,0),
(39456,'esMX','Monster - Scarlet Crusade, Mace 2H',NULL,0),
(39511,'esMX','Seis de Espadas DEPRECATED',NULL,0),
(39584,'esMX','Glifo de Espinas Deprecated',NULL,0),
(39585,'esMX','Glifo de robustez salvaje [PH]',NULL,0),
(39586,'esMX','Glifo de Fuego lunar (prueba de Kyle) [PH]','Glifo sublime',0),
(39587,'esMX','Glifo de maltrato salvaje Deprecated',NULL,0),
(39600,'esMX','Craig''s test chest',NULL,0),
(39658,'esMX','Monster - Mace2H, Maul B02 SilverPurple (Low Blue Glow)',NULL,0),
(39659,'esMX','Monster - Sword, 1H Alliance PvP (Low Blue Glow)',NULL,0),
(39660,'esMX','Monster - Shield, Militia A01 Blue',NULL,0),
(39661,'esMX','Monster - Mace2H, WarA01/B02Silver (1H, Special - High Blue Glow)',NULL,0),
(39662,'esMX','Monster - Sword, Long Silver - Green Pommel (Low Blue Glow)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(39663,39677,39699,39705,39741,39742,39744,39745,39746,39749,39750,39751,39752,39753,39813,39832,39879,39884,39885,39892) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(39663,'esMX','Monster - Mace, Draenei A01 Blue (Low Blue Glow)',NULL,0),
(39677,'esMX','Scaling Stat Test Plate Shoulders',NULL,0),
(39699,'esMX','Monster - Staff, Northrend C01 Black',NULL,0),
(39705,'esMX','Scaling Stat Test Mail Shoulders',NULL,0),
(39741,'esMX','Monster - Axe, 2H Hardened Skirmisher (1H as 2H - Lightning)',NULL,0),
(39742,'esMX','Monster - Staff, Red Jeweled with Low Purple Glow',NULL,0),
(39744,'esMX','Monster - Staff, Northrend (ID Mage)',NULL,0),
(39745,'esMX','Monster - Staff, Northrend D01 Blue',NULL,0),
(39746,'esMX','Monster - Staff (Northrend Polearm)',NULL,0),
(39749,'esMX','Monster - Mace, Northrend D01',NULL,0),
(39750,'esMX','Monster - Staff (Northrend Polearm - Lightning)',NULL,0),
(39751,'esMX','Monster - Mace, Northrend C01',NULL,0),
(39752,'esMX','Monster - Mace, Thaurissan Hammer (Lightning)',NULL,0),
(39753,'esMX','Monster - Mace, Nexus (Ice)(2H)',NULL,0),
(39813,'esMX','QR ZD25 Cloth Spell Glove2 - PH',NULL,0),
(39832,'esMX','QR ZD26 Spell Offhand - PH',NULL,0),
(39879,'esMX','QR ZD25 Leather Physical Shoulder2 - PH',NULL,0),
(39884,'esMX','QR ZD25 Mail Physical Feet2 - PH',NULL,0),
(39885,'esMX','QR ZD25 Plate Physical Chest2 - PH',NULL,0),
(39892,'esMX','Monster - Staff, Northrend B03 Gold (Fiery)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(39903,39904,39913,39921,39922,39923,39924,39925,39926,39928,39929,39930,39931,39971,39972,40183,40232,40276,40308,40309) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(39903,'esMX','Propina de la Cruzada Argenta','Las monedas tintinean.',0),
(39904,'esMX','Propina de la Cruzada Argenta','Las monedas tintinean.',0),
(39913,'esMX','Carta llamativa DEPRECATED','Una carta aleatoria de Espadas. Reúne la baraja completa para recibir una recompensa.',0),
(39921,'esMX','Monster - Shield, Horde A01 Blood',NULL,0),
(39922,'esMX','Monster - Shield, Horde A01 Blue',NULL,0),
(39923,'esMX','Monster - Shield, Horde A01 Green',NULL,0),
(39924,'esMX','Monster - Shield, Horde A01 Purple',NULL,0),
(39925,'esMX','Monster - Shield, Horde A01 Yellow',NULL,0),
(39926,'esMX','Monster - Shield, Horde A02 Blood',NULL,0),
(39928,'esMX','Monster - Shield, Horde A02 Blue',NULL,0),
(39929,'esMX','Monster - Shield, Horde A02 Green',NULL,0),
(39930,'esMX','Monster - Shield, Horde A02 Red',NULL,0),
(39931,'esMX','Monster - Shield, Horde A02 Wood',NULL,0),
(39971,'esMX','Poción de batalla rúnica','Solo se puede usar en campos de batalla y arenas.',0),
(39972,'esMX','Tambores',NULL,0),
(40183,'esMX','Monster - Dagger, Northrend B01 Red (Red Flame)',NULL,0),
(40232,'esMX',NULL,'Encaja en una ranura de color amarillo o azul.',0),
(40276,'esMX','Monster - Sword - 1H, Highlord Darion Mograine (Non-Instanced)',NULL,0),
(40308,'esMX','Tarro de alma de huesería',NULL,0),
(40309,'esMX','TEST ARMOR DEATH KNIGHT CHEST',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(40310,40311,40312,40313,40314,40355,40413,40434,40435,40436,40452,40464,40479,40484,40485,40487,40501,40534,40535,40537) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(40310,'esMX','TEST ARMOR DEATH KNIGHT LEGS',NULL,0),
(40311,'esMX','TEST ARMOR DEATH KNIGHT SHOULDERS',NULL,0),
(40312,'esMX','TEST ARMOR DEATH KNIGHT GLOVES',NULL,0),
(40313,'esMX','TEST ARMOR DEATH KNIGHT BOOTS',NULL,0),
(40314,'esMX','TEST ARMOR DEATH KNIGHT BELT',NULL,0),
(40355,'esMX','Vástago azur',NULL,0),
(40413,'esMX','Deprecated Elixir of Mighty Nothing',NULL,0),
(40434,'esMX','Monster - Vrykul - Mace, 2H - Blue Glow, High',NULL,0),
(40435,'esMX','Monster - Vrykul - Axe, 2H C_01 - Blue Glow, High',NULL,0),
(40436,'esMX','Monster - Polearm, Harpoon (Vrykul) - Blue Glow, High',NULL,0),
(40452,'esMX','Monster - Mace, Thaurissan Hammer (High Red Flame)',NULL,0),
(40464,'esMX','Monster - Sword, 2H Blood Elf B02 (High Red Glow)',NULL,0),
(40479,'esMX','SUNWELL TEST GOD BP',NULL,0),
(40484,'esMX','Glifo del oso blanco Deprecated',NULL,0),
(40485,'esMX','Monster - Polearm, Epic D 06 (High Red Flame)',NULL,0),
(40487,'esMX','Monster - Axe, 2H Northrend B02 Blue (High Blue Glow)',NULL,0),
(40501,'esMX','Monster - Mace 1H, Frost Giant Club',NULL,0),
(40534,'esMX','Monster - Axe, 1H Northrend C02 Blue',NULL,0),
(40535,'esMX','Monster - Mace2H, Northrend C01 Blue',NULL,0),
(40537,'esMX','Monster - Axe, 2H Northrend C03',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(40538,40540,40542,40595,40596,40597,40598,40605,40606,40607,40608,40609,40644,40646,40647,40648,40649,40651,40654,40655) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(40538,'esMX','Detonador a distancia DEPRECATED',NULL,0),
(40540,'esMX','Monster - Vrykul - Axe, 1H - Blue Glow, High',NULL,0),
(40542,'esMX','Monster - Axe, 1H Northrend C02 Blue, High Blue Glow',NULL,0),
(40595,'esMX','Monster - Mace1H, Argent Crusade',NULL,0),
(40596,'esMX','Monster - Shield, Argent Crusade',NULL,0),
(40597,'esMX','Monster - Shield, Argent Shieldman',NULL,0),
(40598,'esMX','Monster - Mace1H, Argent Shieldman',NULL,0),
(40605,'esMX','Monster - Staff, Vargul Runelord',NULL,0),
(40606,'esMX','Monster - Staff, Vargul Deathwaker',NULL,0),
(40607,'esMX','Monster - Polearm, Vargul',NULL,0),
(40608,'esMX','Monster - Axe, Vargul (2H)',NULL,0),
(40609,'esMX','Monster - Axe, Vargul (1H)',NULL,0),
(40644,'esMX','Monster - Sword, Vargul (2H)',NULL,0),
(40646,'esMX','LK ARENA TEST WARRIOR BP 252',NULL,0),
(40647,'esMX','LK ARENA TEST WARRIOR BP 213',NULL,0),
(40648,'esMX','LK ARENA TEST WARRIOR SHOULDERS 213',NULL,0),
(40649,'esMX','LK ARENA TEST WARRIOR SHOULDERS 252',NULL,0),
(40651,'esMX','LK ARENA TEST WARRIOR BRACERS 252',NULL,0),
(40654,'esMX','LK ARENA TEST MAGE BP 213',NULL,0),
(40655,'esMX','LK ARENA TEST MAGE BP 252',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(40656,40657,40658,40659,40660,40661,40662,40663,40664,40665,40677,40729,40759,40760,40761,40763,40764,40765,40766,40770) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(40656,'esMX','LK ARENA TEST PRIEST BP 213',NULL,0),
(40657,'esMX','LK ARENA TEST PRIEST BP 252',NULL,0),
(40658,'esMX','LK ARENA TEST MAGE SHOULDERS 213',NULL,0),
(40659,'esMX','LK ARENA TEST PRIEST SHOULDERS 213',NULL,0),
(40660,'esMX','LK ARENA TEST MAGE SHOULDERS 252',NULL,0),
(40661,'esMX','LK ARENA TEST PRIEST SHOULDERS 252',NULL,0),
(40662,'esMX','LK ARENA TEST MAGE BRACERS 213',NULL,0),
(40663,'esMX','LK ARENA TEST MAGE BRACERS 252',NULL,0),
(40664,'esMX','LK ARENA TEST PRIEST BRACERS 213',NULL,0),
(40665,'esMX','LK ARENA TEST PRIEST BRACERS 252',NULL,0),
(40677,'esMX','Crafty Potion PLACEHOLDER',NULL,0),
(40729,'esMX','Monster - Spear, Badass Blue (Poisoned)',NULL,0),
(40759,'esMX','Monster - Bow, Northrend C02 Silver',NULL,0),
(40760,'esMX','Robinson Test Bindings',NULL,0),
(40761,'esMX','Robinson Test Boots',NULL,0),
(40763,'esMX','Robinson Test Gloves',NULL,0),
(40764,'esMX','Robinson Test Legs',NULL,0),
(40765,'esMX','Robinson Test Shoulders',NULL,0),
(40766,'esMX','Robinson Test Robes',NULL,0),
(40770,'esMX','Monster - Mace, Frost Giant (Northrend)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(40774,40796,40800,40843,40894,40945,40967,40968,41022,41090,41175,41176,41177,41180,41244,41247,41256,41259,41261,41263) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(40774,'esMX','zzzOLDMaster Spellstone (DEPRECATED)',NULL,0),
(40796,'esMX','Vrykul de escarcha de reacción a la fuerza','Internal Only',0),
(40800,'esMX','Espinoculares con pinza de cinturón [DEPRECATED]',NULL,0),
(40843,'esMX','Bayas de hielo',NULL,0),
(40894,'esMX','Monster - Vrykul - Sword, 1H (Blue Glow, High)',NULL,0),
(40945,'esMX','Antorcha siemprenllamas',NULL,0),
(40967,'esMX','Monster - Claw, Wolvar MH',NULL,0),
(40968,'esMX','Monster - Claw, Wolvar OH',NULL,0),
(41022,'esMX','Monster - Polearm, Dragon Hunter 003 (Disintegrate)',NULL,0),
(41090,'esMX','Monster - Zul''Aman - Staff, 2H, Drakuru Prophet',NULL,0),
(41175,'esMX','Monster - Axe, 2H Deathknight C01, Purple Executioner',NULL,0),
(41176,'esMX','Monster - Staff, Naxxramas D01',NULL,0),
(41177,'esMX','Monster - Sword, 1H Northrend D02 Grey, Deathfrost',NULL,0),
(41180,'esMX','Monster - Staff, Northrend D01 Purple, Disintegration',NULL,0),
(41244,'esMX','Monster - Dagger, Curvey Silver (White Glow)',NULL,0),
(41247,'esMX','Titansteel (DEPRECATED)',NULL,0),
(41256,'esMX','Monster - Spear, Sharp Thin (No Sheathe Point)',NULL,0),
(41259,'esMX','Monster - Sword, 2H Deathknight B01 Purple',NULL,0),
(41261,'esMX','Monster - Axe 2H Deathknight C01 Blue',NULL,0),
(41263,'esMX','Monster - Sword, 1H Naxxramas D01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(41343,41358,41360,41364,41365,41370,41371,41425,41583,41613,41691,41695,41748,41756,41764,41823,41889,41977,41978,41979) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(41343,'esMX','Monster - Sword, 1H Naxxramas D02 (Shoulder)',NULL,0),
(41358,'esMX','Monster - Polearm, Northrend C01 Blue',NULL,0),
(41360,'esMX','Monster - Bow, Northrend B03 (Green)',NULL,0),
(41364,'esMX','Monster - Staff, Northrend D01 Red (Sunfire)',NULL,0),
(41365,'esMX','Monster - Staff, Zul''Aman D02 Purple',NULL,0),
(41370,'esMX','Monster - Sword, 2H Deathknight B01 Red',NULL,0),
(41371,'esMX','Monster - Sword, 2H Deathknight B01 Red (Blue Flame)',NULL,0),
(41425,'esMX','Crafty''s Test Ring',NULL,0),
(41583,'esMX','Monster - Axe 2H Deathknight C01 Red',NULL,0),
(41613,'esMX','Monster - Gun, Ulduar',NULL,0),
(41691,'esMX','Monster - Axe, 1H Northrend C03 (Using 2H Model)',NULL,0),
(41695,'esMX','Monster - Polearm, Northrend D01',NULL,0),
(41748,'esMX','Birmingham Test Item 2','For Brian to Test things',0),
(41756,'esMX','Sello de sangre de corazón',NULL,0),
(41764,'esMX','Monster - Axe, Vladof',NULL,0),
(41823,'esMX','Clayton''s Test Item Five',NULL,0),
(41889,'esMX','Monster - Polearm, PvPAlliance Purple',NULL,0),
(41977,'esMX','Monster - Mace2H, Northrend C01 Brown',NULL,0),
(41978,'esMX','Monster - Mace2H, Northrend C01 Green',NULL,0),
(41979,'esMX','Monster - Mace2H, Northrend C01 Red',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(41980,41981,41982,41983,42139,42140,42147,42161,42165,42166,42167,42168,42169,42170,42171,42205,42239,42240,42426,42427) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(41980,'esMX','Monster - Mace2H, Northrend C03 Blue',NULL,0),
(41981,'esMX','Monster - Mace2H, Northrend C03 Green',NULL,0),
(41982,'esMX','Monster - Mace2H, Northrend C03 Red',NULL,0),
(41983,'esMX','Monster - Mace2H, Northrend C03 Yellow',NULL,0),
(42139,'esMX','Monster - Staff, Rhonin',NULL,0),
(42140,'esMX','Monster - Bow, Vereesa',NULL,0),
(42147,'esMX','Gigantes de escarcha de reacción a la fuerza',NULL,0),
(42161,'esMX','Monster - Sword, 1H Northrend C01 Red, Red Glow',NULL,0),
(42165,'esMX','Monster - Staff, Northrend C03 Green',NULL,0),
(42166,'esMX','Monster - Dagger, Naxxramas D02',NULL,0),
(42167,'esMX','Monster - Dagger, Hellfire Blue',NULL,0),
(42168,'esMX','Monster - Mace, Naxxramas D02',NULL,0),
(42169,'esMX','Monster - Mace2H, Naxxramas D02',NULL,0),
(42170,'esMX','Broche de plata',NULL,0),
(42171,'esMX','Broche esmeralda',NULL,0),
(42205,'esMX','Retal de hierro enfriado',NULL,0),
(42239,'esMX','OBSOLETE - LK Arena 5 Hunter 1h Axe - OBSOLETE',NULL,0),
(42240,'esMX','OBSOLETE - LK Arena 6 Hunter 1h Axe - OBSOLETE',NULL,0),
(42426,'esMX','Monster - Staff - 2H - Forgotten Depths High Priest',NULL,0),
(42427,'esMX','Monster - Sword, 1H - Forgotten Depths Slayer',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(42477,42478,42506,42507,42509,42523,42529,42535,42543,42544,42547,42548,42756,42757,42759,42764,42773,42775,42856,42873) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(42477,'esMX','Monster - Sword, 2H Deathknight B01 Blue',NULL,0),
(42478,'esMX','Monster - Sword, 2H Deathknight B01 Green',NULL,0),
(42506,'esMX','Monster - Mace, Basic Metal Hammer (Glow, Blue - High)',NULL,0),
(42507,'esMX','Monster - Harpoon, D01',NULL,0),
(42509,'esMX','Monster - Spear, Frost Giant (Northrend)',NULL,0),
(42523,'esMX','Fin de juego de Gladiador indómito',NULL,0),
(42529,'esMX','Indulto de Gladiador indómito',NULL,0),
(42535,'esMX','Grimorio de Gladiador indómito',NULL,0),
(42543,'esMX','Monster - Shield, Argent Vanguard 01',NULL,0),
(42544,'esMX','Monster - Mace1H, Argent Vanguard 01',NULL,0),
(42547,'esMX','Monster - Sword, 2H Blood Elf B02 Blue (High Blue Glow)',NULL,0),
(42548,'esMX','Deprecated Speed Potion Injector',NULL,0),
(42756,'esMX','Monster - Item, Tome of Divine Right',NULL,0),
(42757,'esMX','Monster - Sword, Rapier (High Yellow Glow)',NULL,0),
(42759,'esMX','Monster - Work Wrench (Lightning)',NULL,0),
(42764,'esMX','Krolmir',NULL,0),
(42773,'esMX','Monster - Staff, Northrend C01 Red',NULL,0),
(42775,'esMX','Monster - Bow, Sylvanas',NULL,0),
(42856,'esMX','Amuleto Aúllaescarcha',NULL,0),
(42873,'esMX','Monster - Spear, Stormhoof''s Spear',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(42919,42920,42921,42923,42924,42925,42929,42932,42933,42934,42935,42936,42937,42938,42939,42941,43002,43008,43014,43091) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(42919,'esMX','Indalamar''s Test 2h Axe','Titan''s Grip ?',0),
(42920,'esMX','Monster - Sword, 1H Northrend B03 Black',NULL,0),
(42921,'esMX','Monster - Bow, Northrend B03 Red',NULL,0),
(42923,'esMX','Monster - Staff, Northrend D01 Green',NULL,0),
(42924,'esMX','Monster - Staff, Northrend D01 Purple',NULL,0),
(42925,'esMX','Monster - Staff, Northrend D01 Red',NULL,0),
(42929,'esMX','Espolones rotos','Hechos añicos por unos dientes muy muy afilados.',0),
(42932,'esMX','Monster - Sword, Zul''aman 1H - D01 Dark',NULL,0),
(42933,'esMX','Monster - Sword, Zul''aman 1H - D01 Red',NULL,0),
(42934,'esMX','Monster - Sword, Zul''aman 2H - D01 Blue',NULL,0),
(42935,'esMX','Monster - Sword, Zul''aman 2H - D01 Red',NULL,0),
(42936,'esMX','Monster - Shield, Zul''gurub D02 Blue',NULL,0),
(42937,'esMX','Monster - Shield, Zul''aman D01',NULL,0),
(42938,'esMX','Monster - Shield, Zul''aman D02 Red',NULL,0),
(42939,'esMX','Monster - Mace, Zul''aman 1H - D01 Blue',NULL,0),
(42941,'esMX','Monster - Staff, Special NPC (Northrend)',NULL,0),
(43002,'esMX','Minas terrestres hinchables','Solo para uso militar',0),
(43008,'esMX','Monster - Axe, 2H Alliance PvP',NULL,0),
(43014,'esMX','Monster - Staff, Alliance PVP',NULL,0),
(43091,'esMX','Monster - Sword, 1H Blood Elf D01 Purple',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(43092,43098,43110,43111,43112,43113,43114,43152,43170,43175,43196,43199,43205,43216,43219,43220,43221,43222,43223,43224) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(43092,'esMX','Monster - Shield, Dalaran',NULL,0),
(43098,'esMX','Ochre Pigment [PH]','A veces se obtiene moliendo brezospina, cardopresto, hierba cardenal y alga estranguladora.',0),
(43110,'esMX','Monster - Polearm, Northrend D01 Black',NULL,0),
(43111,'esMX','Monster - Axe, 2H Blackwing A02',NULL,0),
(43112,'esMX','Monster - Mace, Blackwing A01',NULL,0),
(43113,'esMX','Monster - Mace, Blackwing A02',NULL,0),
(43114,'esMX','Monster - Polearm, Blackwing A01',NULL,0),
(43152,'esMX','Monster - Staff, Northrend B02',NULL,0),
(43170,'esMX','Test Clam',NULL,0),
(43175,'esMX','Monster - Axe, 1H Horde PvP Red',NULL,0),
(43196,'esMX','Monster - Staff, Jeweled D01 Green (Purple Glow)',NULL,0),
(43199,'esMX','Monster - Mace, Blackwing A02 (Purple Glow)',NULL,0),
(43205,'esMX','Monster - Mace2H, Horde Black Spiked Badass (Savagery)',NULL,0),
(43216,'esMX','Monster - Staff, Northrend B03 Silver',NULL,0),
(43219,'esMX','Monster - Staff, Zul''Aman D03 Red',NULL,0),
(43220,'esMX','Monster - Staff, Blood Elf A01 Blue - High Yellow Glow',NULL,0),
(43221,'esMX','Monster - Shandaral - 1H Sword',NULL,0),
(43222,'esMX','Monster - Shandaral - Shield',NULL,0),
(43223,'esMX','Monster - Shandaral - Staff',NULL,0),
(43224,'esMX','Monster - Shandaral - Bow',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(43226,43227,43254,43292,43293,43294,43295,43296,43301,43383,43474,43477,43479,43487,43503,43514,43525,43532,43540,43557) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(43226,'esMX','Monster - Staff, Ahn''Qiraj 03',NULL,0),
(43227,'esMX','Monster - Staff, OutlandRaid Squid (Blue)',NULL,0),
(43254,'esMX','Cristal de esencia','Frío al tacto.',0),
(43292,'esMX','Monster - Shield, Northend D01 Horde',NULL,0),
(43293,'esMX','Monster - Shield, Northend D01 Blue',NULL,0),
(43294,'esMX','Monster - Shield, Northend D01 Green',NULL,0),
(43295,'esMX','Monster - Shield, Northend D01 Yellow',NULL,0),
(43296,'esMX','Monster - Axe, 1H Northrend (Iskalder''s Axe - Polearm D01 Black)',NULL,0),
(43301,'esMX','Mantón de peluquero',NULL,0),
(43383,'esMX','Glifo del lobo ártico Deprecated',NULL,0),
(43474,'esMX','Monster - Staff, Nexus D01',NULL,0),
(43477,'esMX','Monster - Polearm, Nexus D01',NULL,0),
(43479,'esMX','Monster - Dagger, Nexus D03',NULL,0),
(43487,'esMX','Monster - Sword, 1H Nexus D03',NULL,0),
(43503,'esMX','Deprecated Cinturón dador de tierra',NULL,0),
(43514,'esMX','Etiqueta de identificación estampada','867-5309',0),
(43525,'esMX','Monster - Mace, Northrend C02',NULL,0),
(43532,'esMX','Monster - Axe 2H Deathknight C01 Green',NULL,0),
(43540,'esMX','Glifo Deprecated',NULL,0),
(43557,'esMX','Bayas de hiedra venenosa','Rara vez se obtiene moliendo brezospina, cardopresto, hierba cardenal y alga estranguladora.',0);

DELETE FROM `item_template_locale` WHERE `ID` IN(43558,43559,43560,43561,43562,43563,43578,43579,43580,43581,43596,43598,43602,43603,43604,43605,43606,43607,43623,43625) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(43558,'esMX','Lila flor nocturna','Rara vez se obtiene moliendo acérita salvaje, musgo de tumba, sangrerregia y vidarraíz.',0),
(43559,'esMX','Aleta de langosta','Rara vez se obtiene moliendo pálida, espina de oro, mostacho de Khadgar e Invernalia.',0),
(43560,'esMX','Polvo de luciérnaga','Rara vez se obtiene moliendo flor de fuego, loto cárdeno, lágrimas de Arthas, solea, carolina, champiñón fantasma y gromsanguina.',0),
(43561,'esMX','Polen iridiscente','Rara vez se obtiene moliendo sansam dorado, hojasueño, salviargenta de montaña, flor de peste y setelo.',0),
(43562,'esMX','Bayas pesadilla','Rara vez se hallan moliendo hierbas autóctonas de Terrallende.',0),
(43563,'esMX','Caparazón de alfazaque congelado','Rara vez se obtiene moliendo hierbas autóctonas de Rasganorte.',0),
(43578,'esMX','Monster - Sword2H, Northrend D03 (Soulfrost)',NULL,0),
(43579,'esMX','Monster - Sword, 2H Orbaz Bloodbane Test',NULL,0),
(43580,'esMX','Monster - Vrykul, Sword 1h',NULL,0),
(43581,'esMX','Monster - Vrykul - Mace, 1H Spiked',NULL,0),
(43596,'esMX','Monster - Staff, Blood Elf A02 Blue - High Blue Flames',NULL,0),
(43598,'esMX','Monster - Dagger, Northrend D02 Red (Red Flame)',NULL,0),
(43602,'esMX','Deprecated Thriving Ink',NULL,0),
(43603,'esMX','Deprecated Demon''s Blood Ink',NULL,0),
(43604,'esMX','Deprecated Gorefellow Ink',NULL,0),
(43605,'esMX','Deprecated Starshine Ink',NULL,0),
(43606,'esMX','Deprecated Void Ink',NULL,0),
(43607,'esMX','Deprecated Noble''s Ink',NULL,0),
(43623,'esMX','Monster - Axe, 2H Northrend C01 Brown (Executioner)',NULL,0),
(43625,'esMX','Monster - Axe, 1H Northrend C01 Stone (Executioner)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(43649,43650,43692,43700,43886,43887,43901,43902,43967,43999,44056,44119,44124,44125,44126,44162,44169,44172,44227,44232) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(43649,'esMX','ITEMIZER TEST RING DO NOT LOCALIZE',NULL,0),
(43650,'esMX','Llave de prisión oxidada','Parece una llave para abrir cofres de tesoros bajo el agua...',0),
(43692,'esMX','Monster - Sword, 2H Deathknight B01 Red (Red Glow)',NULL,0),
(43700,'esMX','Geoset test boots do not localize',NULL,0),
(43886,'esMX','QR IC34 Healer Offhand - PH',NULL,0),
(43887,'esMX','QR IC34 Leather Physical Head3 - PH',NULL,0),
(43901,'esMX','QR IC34 Mail Physical Feet3 - PH',NULL,0),
(43902,'esMX','QR IC34 Plate Physical Shoulder2 - PH',NULL,0),
(43967,'esMX','Monster - Sword, 1H Northrend C01',NULL,0),
(43999,'esMX','Anillo del horizonte vacío',NULL,0),
(44056,'esMX','Monster - Axe, 1H Nexus D01',NULL,0),
(44119,'esMX','Recipe: Big Bear Steak [PH]',NULL,0),
(44124,'esMX','zzzOLD Arcanum of Reputation Template - PH',NULL,0),
(44125,'esMX','zzzOLDLesser Inscription of Template - PH',NULL,0),
(44126,'esMX','zzzOLDGreater Inscription of Template - PH',NULL,0),
(44162,'esMX','Monster - Sword, Iblis (Red particle)',NULL,0),
(44169,'esMX','Monster - Mace2H, Northrend D01',NULL,0),
(44172,'esMX','Monster - Axe, 2H Northrend C01 Purple (Med Blue Glow)',NULL,0),
(44227,'esMX','Monster - Axe, 2H Nexus',NULL,0),
(44232,'esMX','Monster - Mace, Nexus D01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(44233,44237,44238,44252,44389,44390,44391,44392,44414,44432,44439,44454,44508,44603,44699,44706,44715,44720,44726,44727) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(44233,'esMX','Monster - Shield, Nexus D01',NULL,0),
(44237,'esMX','Monster - Sword, Horde Jagged Bloody (Back)',NULL,0),
(44238,'esMX','Monster - Sword, 1H Nexus D01',NULL,0),
(44252,'esMX','Monster - Axe, 2H Horde Purple War Axe',NULL,0),
(44389,'esMX','Collar curativo',NULL,0),
(44390,'esMX','Colgante venenoso',NULL,0),
(44391,'esMX','Gargantilla de acero sólido',NULL,0),
(44392,'esMX','Collar de infiltración',NULL,0),
(44414,'esMX','Látigo de alma',NULL,0),
(44432,'esMX','Glifo del necrófago DEPRECATED',NULL,0),
(44439,'esMX','Monster - Sword, 1H Nexus D03 Dark, Black Glow',NULL,0),
(44454,'esMX','Monster - Throwing Axe, Horde B01 Green',NULL,0),
(44508,'esMX','¡Descubrimiento!','Descubre de forma aleatoria una receta de alquimia.',0),
(44603,'esMX','Monster - Polearm, Northrend D01 Black (Fear)',NULL,0),
(44699,'esMX','Modulador de voz roto',NULL,0),
(44706,'esMX','Monster - Staff, Nexus D02 Spellsurge',NULL,0),
(44715,'esMX','Monster - Gun, Dalaran',NULL,0),
(44720,'esMX','Test Anillo de índice de defensa +3320',NULL,0),
(44726,'esMX','Monster - Mace1H, Hyjal D 01 Blue',NULL,0),
(44727,'esMX','Monster - Sword, 1H Hyjal 02 Blue',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(44730,44733,44804,44805,44821,44845,44846,44847,44848,44857,44867,44945,44952,44964,45010,45041,45048,45053,45055,45081) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(44730,'esMX','Socket Test Helm',NULL,0),
(44733,'esMX','Monster - Mace, Draenei A01 Orange (Low Yellow Glow)',NULL,0),
(44804,'esMX','Perjudicador de Indalamar',NULL,0),
(44805,'esMX','Indalamar''s Test Totem',NULL,0),
(44821,'esMX','Monster - Mace2H, Northrend C03 Blue (Frozen Rune)',NULL,0),
(44845,'esMX','Test Mace of Unending Life',NULL,0),
(44846,'esMX','Test Martillo de guerra qiraji bendito','Esta arma está infundida y reforzada con elementium.',0),
(44847,'esMX','Test Martillo de Furia bestial',NULL,0),
(44848,'esMX','Test El fin de los sueños',NULL,0),
(44857,'esMX','Montura de dracohalcón negro',NULL,0),
(44867,'esMX','Mula de carga',NULL,0),
(44945,'esMX','Fórmula: encantar arma: protección de titanes','Te enseña a encantar de forma permanente un arma cuerpo a cuerpo para aumentar el aguante 50 p. Requiere un objeto de nivel 60 o superior.',0),
(44952,'esMX','Monstruo: lanza sónica',NULL,0),
(44964,'esMX','Joyas de familia de Omar','El mayor tesoro de Azeroth',0),
(45010,'esMX','Minería: Tu pico y tú',NULL,0),
(45041,'esMX','Prueba artística',NULL,0),
(45048,'esMX','Monster - Axe, 2H Zul''Aman Red',NULL,0),
(45053,'esMX','Monster - Mace2H, Horde PvP',NULL,0),
(45055,'esMX','Monster - Mace2H, Trainwrecker',NULL,0),
(45081,'esMX','Monster - Spear, Cool Blue (Frost Enchant)',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(45084,45123,45124,45280,45290,45499,45528,45692,45726,45727,45796,45856,45884,45918,45924,45925,45926,45942,45985,46020) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(45084,'esMX','Libro de secretos de la artesanía',NULL,0),
(45123,'esMX','Monster - (Weapon) Blacksmith Hammer',NULL,0),
(45124,'esMX','Monster - Sword2H, Northrend C02 Blue',NULL,0),
(45280,'esMX','Camisa de Uber','¡He probado el modo heroico del Coliseo Argenta y todo lo que he conseguido ha sido esta estúpida camiseta!',0),
(45290,'esMX','Pluma de pingüino negra',NULL,0),
(45499,'esMX','Test Wraps of the Item Purchase Refund',NULL,0),
(45528,'esMX','Monster - Axe, 2H Deathknight C01, Purple',NULL,0),
(45692,'esMX','Monster - Sword, Vargul (Blue) (2H)',NULL,0),
(45726,'esMX','Monster - Staff, Dalaran (Red) (1H)',NULL,0),
(45727,'esMX','Monster - Sword - 1H Dalaran (Red)',NULL,0),
(45796,'esMX','Llave de El Planetario Celestial',NULL,0),
(45856,'esMX','Monster - Shield, Northend B01 Brown',NULL,0),
(45884,'esMX','Monster - Polearm, Northrend D02 Gold',NULL,0),
(45918,'esMX','Monster - Forsaken Lance [PH]',NULL,0),
(45924,'esMX','Diploma de agradecimiento','Gracias por asistir. Por desgracia, tus objetos épicos están en otra mazmorra. Vuelve a intentarlo.',0),
(45925,'esMX','Monster - Ebon Cavalry Blade [PH]',NULL,0),
(45926,'esMX','Monster - Vrykul, Sword 2H (Ulduar)',NULL,0),
(45942,'esMX','Ensamblaje robótico XP-001','Te enseña a invocar este compañero.',0),
(45985,'esMX','Monster - Dagger (Algalon)',NULL,0),
(46020,'esMX','Monster - Ulduar Raid - Mace 04',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(46089,46090,46092,46093,46107,46112,46326,46327,46328,46329,46330,46332,46333,46334,46335,46336,46358,46371,46393,46394) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(46089,'esMX','Monster - Horde Lance',NULL,0),
(46090,'esMX','Monster - Alliance Lance',NULL,0),
(46092,'esMX','Monster - Shield, Horde PVP',NULL,0),
(46093,'esMX','Monster - Shield, Sunwell D01 Red',NULL,0),
(46107,'esMX','Monster - Argent Lance',NULL,0),
(46112,'esMX','Monster - Gun, Blood Elf (D) Silver',NULL,0),
(46326,'esMX','Botas de runaoscura de conquistador',NULL,0),
(46327,'esMX','Botas de rompedor de asedio de conquistador',NULL,0),
(46328,'esMX','Botas de égida de conquistador',NULL,0),
(46329,'esMX','Botas de santificación de conquistador',NULL,0),
(46330,'esMX','Botas de Arrullanoche de conquistador',NULL,0),
(46332,'esMX','Botas del Kirin Tor de conquistador',NULL,0),
(46333,'esMX','Botas libramorte de conquistador',NULL,0),
(46334,'esMX','Botas de rompemundos de conquistador',NULL,0),
(46335,'esMX','Botas de acechador de la Plaga de conquistador',NULL,0),
(46336,'esMX','zzOLD[ph]',NULL,0),
(46358,'esMX','Dummy Item [PH]',NULL,0),
(46371,'esMX',NULL,'La cerveza vudú de T''chali otorga una magia que no quieres entender.',0),
(46393,'esMX','Toga de aprendiz',NULL,0),
(46394,'esMX','Toga de acólito',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(46733,46736,46737,46738,46837,46839,46840,46841,46842,46844,46845,46854,46886,46894,46981,46982,46983,46984,46987,46998) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(46733,'esMX','Monster - Item, Tankard Brewfest (Year 3 Green)',NULL,0),
(46736,'esMX','Monster - Sword 2H, Tauren',NULL,0),
(46737,'esMX','Monster - Sword2H, Claymore Gold',NULL,0),
(46738,'esMX','Monster - Staff, Ornate Jeweled Staff - Yellow',NULL,0),
(46837,'esMX','Monster - Polearm, Northrend C01 Black',NULL,0),
(46839,'esMX','Insignia Lobo Gélido Rango 7','El Ojo del orden',0),
(46840,'esMX','Insignia Lobo Gélido Rango 7','El Ojo del orden',0),
(46841,'esMX','Monster - Spear, Rusty (1H)',NULL,0),
(46842,'esMX','Sortija de cruzado',NULL,0),
(46844,'esMX','Test Armor Pen Neck',NULL,0),
(46845,'esMX','Carga de seforio enorme 2',NULL,0),
(46854,'esMX','Flechas exterminadoras de saronita',NULL,0),
(46886,'esMX','Snóbold capturado',NULL,0),
(46894,'esMX','Jade encantado',NULL,0),
(46981,'esMX','Monster - Horde PvP, Main Hand, Red',NULL,0),
(46982,'esMX','Monster - Horde PvP, Off Hand, Red',NULL,0),
(46983,'esMX','Monster - Stave, 2H Horde PvP (Red)',NULL,0),
(46984,'esMX','Monster - Stave, 2H Horde PvP (Green)',NULL,0),
(46987,'esMX','Monster - Mace, 1H Alliance PvP',NULL,0),
(46998,'esMX','Monster - Gun, Alliance PvP',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(47005,47013,47014,47031,47032,47034,47102,47103,47505,47542,47543,47544,47842,47844,47846,48947,48949,49016,49018,49020) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(47005,'esMX','Monster - Dagger, Horde PvP (Red)',NULL,0),
(47013,'esMX','Monster - Polearm, Alliance PVP (Green/Silver)',NULL,0),
(47014,'esMX','Monster - Bow, Alliance PvP',NULL,0),
(47031,'esMX','Monster - Polearm, Horde PvP (Red)',NULL,0),
(47032,'esMX','Monster - Axe, 1H Alliance PvP',NULL,0),
(47034,'esMX','Monster - Axe, 2H Horde PvP (No Glow)',NULL,0),
(47102,'esMX','Toga Tejemaná',NULL,0),
(47103,'esMX','Manijas putrefactas',NULL,0),
(47505,'esMX','Monster - Polearm, Northrend D01 Black (Ltng)',NULL,0),
(47542,'esMX','Test Item 2v2 Rating',NULL,0),
(47543,'esMX','Test Item 3v3 Rating',NULL,0),
(47544,'esMX','Test Item 5v5 Rating',NULL,0),
(47842,'esMX','SERVER CRASHING ITEM [PROGRAMMER ONLY -- DO NOT MAKE]',NULL,0),
(47844,'esMX','Assassin''s Blade (Glow, Purple - Low)',NULL,0),
(47846,'esMX','Cruel Barb (Glow, Purple - Low)',NULL,0),
(48947,'esMX','Monster - Axe, 1H Northrend D01',NULL,0),
(48949,'esMX','Monster - Axe, 2H Northrend D01 Purple',NULL,0),
(49016,'esMX','Monster - Rod, Horde Purple Orb',NULL,0),
(49018,'esMX','Monster - Mace, 1H Horde PvP Red',NULL,0),
(49020,'esMX','Monster - Mace, 1H Horde PvP',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(49022,49024,49070,49072,49148,49152,49154,49156,49158,49160,49198,49206,49224,49225,49291,49292,49293,49311,49341,49342) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(49022,'esMX','Monster - Ancient Amani Longbow (Light Blue)',NULL,0),
(49024,'esMX','Monster - Ironforge Smasher (Light)',NULL,0),
(49070,'esMX','Monster - Fist (Main), Alliance PvP',NULL,0),
(49072,'esMX','Monster - Fist (Offhand), Alliance PvP',NULL,0),
(49148,'esMX','Monster - Axe, 2H Draenei D02',NULL,0),
(49152,'esMX','Monster - Dagger, Zul''aman D03 (Black)',NULL,0),
(49154,'esMX','Monster - Dagger, Zul''aman D02 (Dark)',NULL,0),
(49156,'esMX','Monster - Axe, 2H Zul''Aman Black',NULL,0),
(49158,'esMX','Monster - Ancient Amani Longbow (Dark)',NULL,0),
(49160,'esMX','Monster - Item, Book - C01 Silver',NULL,0),
(49198,'esMX','Monster - Axe, 2H Northrend C03 (No Particles)',NULL,0),
(49206,'esMX','Monster - Mace1H, Warhammer Ebony - White Flame',NULL,0),
(49224,'esMX','Autorización',NULL,0),
(49225,'esMX','Autorización',NULL,0),
(49291,'esMX','Monster - Polearm, Icecrown Raid (Vengeance Enchant)',NULL,0),
(49292,'esMX','Monster - Sword - Forgemaster 2h',NULL,0),
(49293,'esMX','Monster - Demise w/ Frost Enchant',NULL,0),
(49311,'esMX','Monster - Staff, Jeweled D01 Blue (Med Blue Glow)',NULL,0),
(49341,'esMX','Monster - Icecrown - 1H Sword - D01 - Blue',NULL,0),
(49342,'esMX','Monster - Icecrown - 1H Sword - D04 - Blue',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(49344,49345,49346,49349,49353,49357,49358,49363,49372,49374,49377,49637,49638,49640,49653,49654,49664,49666,49681,49684) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(49344,'esMX','Monster - Icecrown - 2H Mace - D01 - Blue',NULL,0),
(49345,'esMX','Monster - Icecrown - 2H Sword - D01 - Purple',NULL,0),
(49346,'esMX','Monster - Icecrown - 1H Axe - D01 - Blue',NULL,0),
(49349,'esMX','Cadenas doradas',NULL,0),
(49353,'esMX','Monster - Polearm, Epic D 02 Glow Red Low, On Fire (Onyxia Special)',NULL,0),
(49357,'esMX','Monster - Mace, 1H Tauren (Red, Fire)',NULL,0),
(49358,'esMX','Monster - Mace, Tauren Spiked (Lightning)',NULL,0),
(49363,'esMX','Monster - Scythe, Soulfrost',NULL,0),
(49372,'esMX','Autorización',NULL,0),
(49374,'esMX','Autorización',NULL,0),
(49377,'esMX','Autógrafo de Garrosh','Hay un mensaje grabado en el mango del hacha arrojadiza: ¡Lok''tar ogar! -- Garrosh',0),
(49637,'esMX','Monster - Sword 1H - Northrend D',NULL,0),
(49638,'esMX','Monster - Shield, Northrend C 01 - Red Shield',NULL,0),
(49640,'esMX','Esencia o polvos','Una cantidad aleatoria de esencia o polvos.',0),
(49653,'esMX','Monster - Staff - Deathspeaker Servant',NULL,0),
(49654,'esMX','Monster - War Scythe - Soulguard Reaper',NULL,0),
(49664,'esMX','Jade morado encantado',NULL,0),
(49666,'esMX','OMAR''S Furious Gladiator''s Claymore',NULL,0),
(49681,'esMX','Monster - Axe, 2H Northrend D01',NULL,0),
(49684,'esMX','Monster - Sword2H, Alliance PvP D01',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(49687,49691,49692,49709,49713,49714,49716,49717,49719,49720,49721,49722,49724,49725,49726,49727,49728,49729,49730,49731) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(49687,'esMX','Monster - Sword 1H - Northrend B01',NULL,0),
(49691,'esMX','Monster - Axe 1H, Horde D03 Gold',NULL,0),
(49692,'esMX','Orbe de fuego',NULL,0),
(49709,'esMX','Monster - Forge of Souls - Soulguard Adept Staff',NULL,0),
(49713,'esMX','Monster - Dagger, Icecrown',NULL,0),
(49714,'esMX','Monster - Dagger Offhand, Icecrown',NULL,0),
(49716,'esMX','Monster - Staff, Icecrown Citadel',NULL,0),
(49717,'esMX','Monster - Mace 1H, Icecrown Citadel',NULL,0),
(49719,'esMX','Monster - Sword 1H, Icecrown Citadel',NULL,0),
(49720,'esMX','Monster - Shield, Icecrown Citadel',NULL,0),
(49721,'esMX','Monster - Sword 1H, Icecrown Citadel',NULL,0),
(49722,'esMX','Monster - Caster Offhand, Icecrown Citadel',NULL,0),
(49724,'esMX','Monster - Healer Staff, Icecrown Citadel',NULL,0),
(49725,'esMX','Monster - Mace 1h, Icecrown Citadel',NULL,0),
(49726,'esMX','Monster - Alliance Shield, Icecrown Citadel',NULL,0),
(49727,'esMX','Monster - Orgrim''s Sword, Icecrown Citadel',NULL,0),
(49728,'esMX','Monster - Horde Shield, Icecrown Citadel',NULL,0),
(49729,'esMX','Monster - Sword 1H, Icecrown Citadel',NULL,0),
(49730,'esMX','Monster - Caster Offhand, Icecrown Citadel',NULL,0),
(49731,'esMX','Monster - Mace 1H, Icecrown Citadel',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(49732,49734,49735,49736,49737,49738,49761,49762,49763,49764,49767,49768,49773,49774,49775,49777,49814,49864,49865,49868) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(49732,'esMX','Monster - Shield, Icecrown Citadel',NULL,0),
(49734,'esMX','Monster - Dagger, Icecrown Citadel',NULL,0),
(49735,'esMX','Monster - Dagger OffHand, Icecrown Citadel',NULL,0),
(49736,'esMX','Monster - Staff, Icecrown Citadel',NULL,0),
(49737,'esMX','Monster - Mace 1H, Icecrown Citadel',NULL,0),
(49738,'esMX','Monster - Shield, Icecrown Citadel',NULL,0),
(49761,'esMX','Monster - Argent Alliance - Bow',NULL,0),
(49762,'esMX','Monster - Argent Horde - Gun',NULL,0),
(49763,'esMX','Monster - Gunship - Sword',NULL,0),
(49764,'esMX','Monster - Argent Horde - Caster Dagger',NULL,0),
(49767,'esMX','Monster - Sword2H, Quel''Delar',NULL,0),
(49768,'esMX','Pergamino de runas de Luminosidad',NULL,0),
(49773,'esMX','Monster - Icecrown Raid - Axe, 2H - High Overlord Saurfang',NULL,0),
(49774,'esMX','Monster - Icecrown Raid - Axe, 1H - Muradin Bronzebeard',NULL,0),
(49775,'esMX','Monster - Icecrown Raid - Hammer, 1H - Muradin Bronzebeard',NULL,0),
(49777,'esMX','Monster - Shield, Icecrown Raid - Entryway Skeletons',NULL,0),
(49814,'esMX','Monster - Sword, Scimitar Badass (Purple Glow, High)',NULL,0),
(49864,'esMX','Monster - Sword, Vargul (Blue) (2H) (Blue Particles)',NULL,0),
(49865,'esMX','Aparato de invisibilidad de Tuerceganzúas',NULL,0),
(49868,'esMX','Saronita forjada con runas',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(49886,49913,49931,49933,49935,50039,50043,50076,50091,50092,50129,50132,50133,50164,50216,50217,50221,50224,50225,50249) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(49886,'esMX','Monster - Axe 2H, Deathbringer Saurfang',NULL,0),
(49913,'esMX','Tabardo de El Pacto de Plata prestado',NULL,0),
(49931,'esMX','Monster - Sword1H, Quel''Delar',NULL,0),
(49933,'esMX','Escudo de cruzado Argenta',NULL,0),
(49935,'esMX','Monster - Dagger, Blood Elf A01 Blue (Frost Enchantment)',NULL,0),
(50039,'esMX','Monster - 2H, Highlord Darion Mograine',NULL,0),
(50043,'esMX','Monster - Axe2H, Ebon Blade (Purple)',NULL,0),
(50076,'esMX','Preparación de mascotas: Alentando a los expertos',NULL,0),
(50091,'esMX','Preparación de mascotas: Consejos avanzados','Se puede utilizar entre niveles 60 y 79.',0),
(50092,'esMX','Preparación de mascotas: Ideas para nivel intermedio','Se puede utilizar entre niveles 40 y 59.',0),
(50129,'esMX','Monster - Mace2H, Scourgelord Tyrannus',NULL,0),
(50132,'esMX','TEST RING ONE',NULL,0),
(50133,'esMX','TEST RING TWO',NULL,0),
(50164,'esMX','Cerveza apenas más grande de Fras Siabi','Para cuando cada pedazo cuenta',0),
(50216,'esMX','Monster - Shield - Stratholme D02',NULL,0),
(50217,'esMX','Monster - Sword, 1H CoTStratholme D01',NULL,0),
(50221,'esMX','Monster - 2H Axe, Deathspeaker Zealots [Missing Textures]',NULL,0),
(50224,'esMX','Monster - Staff, Icecrown Citadel (Warlock) (Blue)',NULL,0),
(50225,'esMX','Monster - Staff, Icecrown Citadel (Warlock) (Purple)',NULL,0),
(50249,'esMX','Monster - Sword, 1H IcecrownRaid D04 Black',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(50251,50252,50256,50257,50329,50330,50331,50332,50419,50422,50433,50434,50752,50753,50757,50758,50814,50817,51028,51029) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(50251,'esMX','Filo de las Sombras a una mano',NULL,0),
(50252,'esMX','Monster - 1H, Highlord Darion Mograine',NULL,0),
(50256,'esMX','Filo de las Sombras a una mano (NEW)',NULL,0),
(50257,'esMX','Filo de las Sombras de mano izquierda de monstruo',NULL,0),
(50329,'esMX','Icecrown-10 Normal Loot Token',NULL,0),
(50330,'esMX','Icecrown-10 Heroic Loot Token',NULL,0),
(50331,'esMX','Icecrown-25 Heroic Loot Token',NULL,0),
(50332,'esMX','Icecrown-25 Normal Loot Token',NULL,0),
(50419,'esMX','Monster - Shield, Naxxramas D02',NULL,0),
(50422,'esMX','Bomba artesana',NULL,0),
(50433,'esMX','Monster - Item, Pick (Kobold Laborer)',NULL,0),
(50434,'esMX','Monster - Axe, 2H Northrend C03 (No Particle)',NULL,0),
(50752,'esMX','Monster - Mace, Frost Giant (Northrend) (Enchant)',NULL,0),
(50753,'esMX','Morgan Test',NULL,0),
(50757,'esMX','Monster - Mace2H, Toravon (No Enchant)',NULL,0),
(50758,'esMX','Monster - Mace2H, Toravon (Enchanted)',NULL,0),
(50814,'esMX','Monster - Sword1H, Quel''Delar (Alternate Anims)',NULL,0),
(50817,'esMX','Monster - Gun, Silver Musket (0.5s Delay)',NULL,0),
(51028,'esMX','Icecrown Raid Blood Prince - 2h',NULL,0),
(51029,'esMX','Icecrown Raid Blood Prince Trash - 1H Dagger',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(51322,51323,51324,51949,51986,51988,52007,52008,52009,52010,52012,52015,52016,52034,52037,52042,52058,52358,52359,52361) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(51322,'esMX','Monster - Icecrown Blood Prince 2H Axe',NULL,0),
(51323,'esMX','Monster - Icecrown Raid Blood Prince 1h sword',NULL,0),
(51324,'esMX','Monster - Icecrown Raid Blood Prince Shield',NULL,0),
(51949,'esMX','Monster - Polearm, Epic D 07 (Val''kyr)',NULL,0),
(51986,'esMX','Envoltura de adepto',NULL,0),
(51988,'esMX','Manoplas de adepto',NULL,0),
(52007,'esMX','Monster - Hailstorm',NULL,0),
(52008,'esMX','Monster - Leeka''s Shield',NULL,0),
(52009,'esMX','Monster - Staff of Balzaphon',NULL,0),
(52010,'esMX','Monster - Bleak Scythe',NULL,0),
(52012,'esMX','Monster - Stanchion of Primal Instinct',NULL,0),
(52015,'esMX','Monster - Angry Dread',NULL,0),
(52016,'esMX','Monster - Damnation',NULL,0),
(52034,'esMX','Monster - Sword 1H, Icecrown Citadel (Sunfire Enchant)',NULL,0),
(52037,'esMX','Monster - Mace, Bloodqueen - D01',NULL,0),
(52042,'esMX','Monster - Mace 1H, Icecrown Citadel (Sunfire Enchant)',NULL,0),
(52058,'esMX','Monster - Valanos'' Longbow (0.5 Speed)',NULL,0),
(52358,'esMX','Monster - Item, Potion Purple',NULL,0),
(52359,'esMX','Monster - Item, Potion Purple Offhand',NULL,0),
(52361,'esMX','Autorización',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(52686,52713,53055,53056,53096,53476,53785,53835,53933,53934,53935,53936,53937,53938,53963,54468,54555,54612,54848) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(52686,'esMX','Monster - Gnomeregan Bonechopper (Dark)',NULL,0),
(52713,'esMX','Discurso de batalla del asalto a Gnomeregan','El mejor discurso de Toby.',0),
(53055,'esMX','Monster - Gnomeregan Bonechopper (Red)',NULL,0),
(53056,'esMX','Monster - Gnomeregan Bonechopper (Blue)',NULL,0),
(53096,'esMX','Monstruo: maza, equipamiento',NULL,0),
(53476,'esMX','Sobretodo de Gnomeregan','A prueba de agua, a prueba de manchas, talla única. ¡Un hurra por la ciencia!',0),
(53785,'esMX','Monster - Bwonsamdi''s Mace',NULL,0),
(53835,'esMX','Monster - Glaive Vol''jin 02',NULL,0),
(53933,'esMX','Monster - Shield, Troll (Blue)',NULL,0),
(53934,'esMX','Monster - Shield, Troll (Blood)',NULL,0),
(53935,'esMX','Monster - Shield, Troll (Green)',NULL,0),
(53936,'esMX','Monster - Shield, Troll (Purple)',NULL,0),
(53937,'esMX','Monster - Shield, Troll (Red)',NULL,0),
(53938,'esMX','Monster - Shield, Troll (Yellow)',NULL,0),
(53963,'esMX','Monster - Axe, 2H Troll ZG (Tooth)',NULL,0),
(54468,'esMX','Antipolillas apestoso','Mantiene a las polillas alejadas de los tabardos.',0),
(54555,'esMX','Monster - Mace, 1H - Troll Head',NULL,0),
(54612,'esMX','Monster - Item, Orb - A01 Ice',NULL,0),
(54848,'esMX','Hombreras de bruja de Escarcha (Test)',NULL,0);

-- Insert new entries, from TBC
DELETE FROM `item_template_locale` WHERE `ID` IN(32913,32972,33062,33063,34835) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(32913,'esMX','zzOld - Brewfest Drink A',NULL,0),
(32972,'esMX','Gafas de cerveza',NULL,0),
(33062,'esMX','zzOLD Empty Brewfest Sampler',NULL,0),
(33063,'esMX','Pan muy duro de la Fiesta de la cerveza','No es comestible, pero resulta muy útil como arma para defender tu bebida.',0),
(34835,'esMX','Omar''s Test Item',NULL,0);

-- Insert new entries, from CLASSIC
DELETE FROM `item_template_locale` WHERE `ID` IN(1002,3523,3524,3525,4142,4144,4160,5046,5047,5290,5678,7681,7716,8745,8803,8870,9092,11442,16315,16336) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(1002,'esMX','Escrito sobre Invisibilidad inferior',NULL,0),
(3523,'esMX','Pantalones de elfo de la noche sin usar',NULL,0),
(3524,'esMX','Botas de elfo de la noche sin usar',NULL,0),
(3525,'esMX','Brazales de elfo de la noche sin usar',NULL,0),
(4142,'esMX','Escrito sobre Polimorfismo: cerdo',NULL,0),
(4144,'esMX','Escrito sobre Polimorfismo: vaca',NULL,0),
(4160,'esMX','Escrito sobre Invisibilidad',NULL,0),
(5046,'esMX','Regalo cerrado',NULL,0),
(5047,'esMX','Papel para envolver de calaveras','Solo los jugadores de nivel 40 o superior podrán abrir este regalo.',0),
(5290,'esMX','Monster - Bow, Black Bow White Grip',NULL,0),
(5678,'esMX','Tratado: Lacre de sacrificio',NULL,0),
(7681,'esMX','Fragmento de gólem de obsidiana',NULL,0),
(7716,'esMX','Collar destrozado',NULL,0),
(8745,'esMX','Libro sobre Toque de sanación',NULL,0),
(8803,'esMX','Escrito sobre Bola de Fuego',NULL,0),
(8870,'esMX','Escrito sobre Invisibilidad superior',NULL,0),
(9092,'esMX','Tablilla de Tótem avizor',NULL,0),
(11442,'esMX','Juego de diputado de Ventormenta',NULL,0),
(16315,'esMX','Manteo de Alférez',NULL,0),
(16336,'esMX','Manteo de Alférez',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(16337,16367,16370,16394,16395,16398,16399,16400,16402,16404,16407,16411,16412,16438,16439,16445,16447,16458,16460,16461) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(16337,'esMX','Manteo de Alférez',NULL,0),
(16367,'esMX','Fajín de seda de Capitán caballero',NULL,0),
(16370,'esMX','Puños de seda de Capitán caballero',NULL,0),
(16394,'esMX','Brazales de cuero de Capitán caballero',NULL,0),
(16395,'esMX','Braquiales de pellejo de dragón de Capitán caballero',NULL,0),
(16398,'esMX','Cinturón de cuero de Capitán caballero',NULL,0),
(16399,'esMX','Faja de pellejo de dragón de Capitán caballero',NULL,0),
(16400,'esMX','Faja de anillas de Capitán caballero',NULL,0),
(16402,'esMX','Guardamuñecas de anillas de Capitán caballero',NULL,0),
(16404,'esMX','Guardamuñecas de placas de Capitán caballero',NULL,0),
(16407,'esMX','Faja de placas de Capitán caballero',NULL,0),
(16411,'esMX','Cincho de láminas de Capitán caballero',NULL,0),
(16412,'esMX','Braquiales de láminas de Capitán caballero',NULL,0),
(16438,'esMX','Brazales de seda de Mariscal',NULL,0),
(16439,'esMX','Fajín de seda de Mariscal',NULL,0),
(16445,'esMX','Brazales de pellejo de dragón de Mariscal',NULL,0),
(16447,'esMX','Guardarrenes de pellejo de dragón de Mariscal',NULL,0),
(16458,'esMX','Cincho de cuero de Mariscal',NULL,0),
(16460,'esMX','Braquiales de cuero de Mariscal',NULL,0),
(16461,'esMX','Brazales de anillas de Mariscal',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(16464,16469,16470,16481,16482,16488,16493,16495,16500,16511,16512,16517,16520,16529,16537,16538,16546,16547,16553,16556) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(16464,'esMX','Faja de anillas de Mariscal',NULL,0),
(16469,'esMX','Guardabrazos de láminas de Mariscal',NULL,0),
(16470,'esMX','Cinturón de láminas de Mariscal',NULL,0),
(16481,'esMX','Brazales de placas de Mariscal',NULL,0),
(16482,'esMX','Faja de placas de Mariscal',NULL,0),
(16488,'esMX','Cinturón de seda de Legionario',NULL,0),
(16493,'esMX','Guardabrazos de pellejo de dragón de Legionario',NULL,0),
(16495,'esMX','Pretina de pellejo de dragón de Legionario',NULL,0),
(16500,'esMX','Faja de cuero de Legionario',NULL,0),
(16511,'esMX','Cincho de placas de Legionario',NULL,0),
(16512,'esMX','Brazales de placas del Legionario',NULL,0),
(16517,'esMX','Brazales de anillas de Legionario',NULL,0),
(16520,'esMX','Cincho de malla de Legionario',NULL,0),
(16529,'esMX','Faja de anillas de Legionario',NULL,0),
(16537,'esMX','Fajín de seda de General',NULL,0),
(16538,'esMX','Puños de seda de General',NULL,0),
(16546,'esMX','Guardabrazos de placas de General',NULL,0),
(16547,'esMX','Faja de placas de General',NULL,0),
(16553,'esMX','Brazales de pellejo de dragón de General',NULL,0),
(16556,'esMX','Cinturón de pellejo de dragón de General',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(16557,16559,16570,16572,16575,16576,17563,17565,17574,17575,17582,17585,17587,17589,17595,17597,17606,17609,17614,17615) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(16557,'esMX','Faja de cuero de General',NULL,0),
(16559,'esMX','Braquiales de cuero de General',NULL,0),
(16570,'esMX','Guardamuñecas de anillas de General',NULL,0),
(16572,'esMX','Faja de anillas de General',NULL,0),
(16575,'esMX','Pretina de malla de General',NULL,0),
(16576,'esMX','Brazales de malla de General',NULL,0),
(17563,'esMX','Brazales de tejido de tinieblas de Capitán caballero',NULL,0),
(17565,'esMX','Cinturón de tejido de tinieblas de Capitán caballero',NULL,0),
(17574,'esMX','Cinturón de tejido de tinieblas de Legionario',NULL,0),
(17575,'esMX','Brazales de tejido de tinieblas de Legionario',NULL,0),
(17582,'esMX','Puños de tejido de tinieblas de Mariscal',NULL,0),
(17585,'esMX','Fajín de tejido de tinieblas de Mariscal',NULL,0),
(17587,'esMX','Brazales de tejido de tinieblas de General',NULL,0),
(17589,'esMX','Cinturón de tejido de tinieblas de General',NULL,0),
(17595,'esMX','Puños de satén de Capitán caballero',NULL,0),
(17597,'esMX','Cordón de satén de Capitán caballero',NULL,0),
(17606,'esMX','Brazales de satén de Mariscal',NULL,0),
(17609,'esMX','Fajín de satén de Mariscal',NULL,0),
(17614,'esMX','Fajín de satén de Legionario',NULL,0),
(17615,'esMX','Puños de satén de Legionario',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(17619,17621,20462,23683,23690) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(17619,'esMX','Brazales de satén de General',NULL,0),
(17621,'esMX','Cincho de satén de General',NULL,0),
(20462,'esMX','Medallón de Halloween',NULL,0),
(23683,'esMX','Pastilla para la garganta Copo de cristal',NULL,0),
(23690,'esMX','Receta: Pastilla para la garganta Copo de cristal',NULL,0);

-- Insert new entries, from CATA
DELETE FROM `item_template_locale` WHERE `ID` IN(4156,4163,5015,5291,6437,6683,10594,16027,16028,16029,16030,16031,16033,16034,16035,16036,16037,16038,17412,18685) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(4156,'esMX',NULL,'Enseña Purificar.',0),
(4163,'esMX',NULL,'Enseña Sello de furia (Rango 1).',0),
(5015,'esMX','Objeto envuelto (PT)',NULL,0),
(5291,'esMX','Monster - Mace, Jeweled Club (Black)',NULL,0),
(6437,'esMX','Piel de demonio despellejada (old)',NULL,0),
(6683,'esMX','Colgante de Tyranis (old)',NULL,0),
(10594,'esMX',NULL,'Tabla de botín inválida, se cuelga al modificar Misceláneas.',0),
(16027,'esMX','JcJ coraza de placas de la Alianza',NULL,0),
(16028,'esMX','JcJ quijotes de placas de la Alianza',NULL,0),
(16029,'esMX','JcJ guanteletes de placas de la Alianza',NULL,0),
(16030,'esMX','JcJ botas de placas de la Alianza',NULL,0),
(16031,'esMX','JcJ hombro de placas de la Alianza',NULL,0),
(16033,'esMX','JcJ muñequera de placas de la Alianza',NULL,0),
(16034,'esMX','JcJ capa de placas de la Alianza',NULL,0),
(16035,'esMX','JcJ yelmo de paño de la Horda',NULL,0),
(16036,'esMX','JcJ toga de paño de la Horda',NULL,0),
(16037,'esMX','JcJ piernas de paño de la Horda',NULL,0),
(16038,'esMX','JcJ sobrehombros de paño de la Horda',NULL,0),
(17412,'esMX',NULL,'Enseña Rezo de entereza (Rango 1).',0),
(18685,'esMX','Poción enigmática OLD',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(19742,19743,20135,20136,20137,20138,20139,20140,20141,20143,20144,20145,20146,20149,20238,20239,20240,20241,20242,20245) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(19742,'esMX','Falda Portaterra TEST',NULL,0),
(19743,'esMX','Caperuza invisible TEST',NULL,0),
(20135,'esMX','90 Pulseras épicas de guerrero',NULL,0),
(20136,'esMX','90 Coraza épica de guerrero',NULL,0),
(20137,'esMX','90 Guanteletes épicos de guerrero',NULL,0),
(20138,'esMX','90 Yelmo épico de guerrero',NULL,0),
(20139,'esMX','90 Quijotes épicos de guerrero',NULL,0),
(20140,'esMX','90 Espaldares épicos de guerrero',NULL,0),
(20141,'esMX','90 Escarpes épicos de guerrero',NULL,0),
(20143,'esMX','90 Gola épica de guerrero',NULL,0),
(20144,'esMX','90 Anillo épico de guerrero',NULL,0),
(20145,'esMX','90 Capa épica de guerrero',NULL,0),
(20146,'esMX','90 Arma de fuego épica de guerrero',NULL,0),
(20149,'esMX','90 Hacha épica de guerrero',NULL,0),
(20238,'esMX','90 Hacha verde de guerrero',NULL,0),
(20239,'esMX','90 Pulseras verdes de guerrero',NULL,0),
(20240,'esMX','90 Coraza verde de guerrero',NULL,0),
(20241,'esMX','90 Capa verde de guerrero',NULL,0),
(20242,'esMX','90 Guanteletes verdes de guerrero',NULL,0),
(20245,'esMX','90 Pistola verde de guerrero',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20246,20247,20248,20249,20250,20251,20252,20267,20268,20269,20270,20271,20272,20273,20274,20275,20276,20277,20278,20279) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20246,'esMX','90 Yelmo verde de guerrero',NULL,0),
(20247,'esMX','90 Quijotes verdes de guerrero',NULL,0),
(20248,'esMX','90 Gola verde de guerrero',NULL,0),
(20249,'esMX','90 Espaldares verdes de guerrero',NULL,0),
(20250,'esMX','90 Anillo verde de guerrero',NULL,0),
(20251,'esMX','90 Escarpes verdes de guerrero',NULL,0),
(20252,'esMX','90 Pretina verde de guerrero',NULL,0),
(20267,'esMX','90 Cinturón épico de pícaro',NULL,0),
(20268,'esMX','90 Botas épicas de pícaro',NULL,0),
(20269,'esMX','90 Brazales épicos de pícaro',NULL,0),
(20270,'esMX','90 Almete épico de pícaro',NULL,0),
(20271,'esMX','90 Guantes épicos de pícaro',NULL,0),
(20272,'esMX','90 Pantalones épicos de pícaro',NULL,0),
(20273,'esMX','90 Bufas épicas de pícaro',NULL,0),
(20274,'esMX','90 Guerrera épica de pícaro',NULL,0),
(20275,'esMX','90 Gola épica de pícaro',NULL,0),
(20276,'esMX','90 Capa épica de pícaro',NULL,0),
(20277,'esMX','90 Anillo épico de pícaro',NULL,0),
(20278,'esMX','90 Arco épico de pícaro',NULL,0),
(20279,'esMX','90 Daga épica de pícaro',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20280,20281,20282,20283,20284,20285,20286,20287,20288,20289,20290,20291,20292,20297,20298,20299,20300,20301,20302,20303) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20280,'esMX','63 Hacha verde de guerrero',NULL,0),
(20281,'esMX','63 Pulseras verdes de guerrero',NULL,0),
(20282,'esMX','63 Coraza verde de guerrero',NULL,0),
(20283,'esMX','63 Capa verde de guerrero',NULL,0),
(20284,'esMX','63 Guanteletes verdes de guerrero',NULL,0),
(20285,'esMX','63 Pistola verde de guerrero',NULL,0),
(20286,'esMX','63 Yelmo verde de guerrero',NULL,0),
(20287,'esMX','63 Quijotes verdes de guerrero',NULL,0),
(20288,'esMX','63 Gola verde de guerrero',NULL,0),
(20289,'esMX','63 Espaldares verdes de guerrero',NULL,0),
(20290,'esMX','63 Anillo verde de guerrero',NULL,0),
(20291,'esMX','63 Escarpes verdes de guerrero',NULL,0),
(20292,'esMX','63 Pretina verde de guerrero',NULL,0),
(20297,'esMX','90 Cinturón verde de pícaro',NULL,0),
(20298,'esMX','90 Botas verdes de pícaro',NULL,0),
(20299,'esMX','90 Arco verde de pícaro',NULL,0),
(20300,'esMX','90 Brazales verdes de pícaro',NULL,0),
(20301,'esMX','90 Almete verde de pícaro',NULL,0),
(20302,'esMX','90 Capa verde de pícaro',NULL,0),
(20303,'esMX','90 Daga verde de pícaro',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20304,20305,20306,20307,20308,20309,20311,20312,20313,20314,20315,20316,20317,20318,20319,20320,20321,20322,20323,20324) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20304,'esMX','90 Guantes verdes de pícaro',NULL,0),
(20305,'esMX','90 Gola verde de pícaro',NULL,0),
(20306,'esMX','90 Pantalones verdes de pícaro',NULL,0),
(20307,'esMX','90 Anillo verde de pícaro',NULL,0),
(20308,'esMX','90 Bufas verdes de pícaro',NULL,0),
(20309,'esMX','90 Guerrera verde de pícaro',NULL,0),
(20311,'esMX','63 Cinturón verde de pícaro',NULL,0),
(20312,'esMX','63 Botas verdes de pícaro',NULL,0),
(20313,'esMX','63 Arco verde de pícaro',NULL,0),
(20314,'esMX','63 Brazales verdes de pícaro',NULL,0),
(20315,'esMX','63 Almete verde de pícaro',NULL,0),
(20316,'esMX','63 Capa verde de pícaro',NULL,0),
(20317,'esMX','63 Daga verde de pícaro',NULL,0),
(20318,'esMX','63 Guantes verdes de pícaro',NULL,0),
(20319,'esMX','63 Gola verde de pícaro',NULL,0),
(20320,'esMX','63 Pantalones verdes de pícaro',NULL,0),
(20321,'esMX','63 Anillo verde de pícaro',NULL,0),
(20322,'esMX','63 Bufas verdes de pícaro',NULL,0),
(20323,'esMX','63 Guerrera verde de pícaro',NULL,0),
(20324,'esMX','90 Cinturón épico de Escarcha',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20325,20326,20327,20328,20330,20331,20332,20333,20334,20335,20336,20338,20339,20340,20341,20342,20343,20344,20345,20346) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20325,'esMX','90 Ataduras épicas de Escarcha',NULL,0),
(20326,'esMX','90 Botas épicas de Escarcha',NULL,0),
(20327,'esMX','90 Corona épica de Escarcha',NULL,0),
(20328,'esMX','90 Guantes épicos de Escarcha',NULL,0),
(20330,'esMX','90 Manto épico de Escarcha',NULL,0),
(20331,'esMX','90 Togas épicas de Escarcha',NULL,0),
(20332,'esMX','90 Gola épica de Escarcha',NULL,0),
(20333,'esMX','90 Anillo épico de Escarcha',NULL,0),
(20334,'esMX','90 Bastón épico de Escarcha',NULL,0),
(20335,'esMX','90 Varita épica de Escarcha',NULL,0),
(20336,'esMX','90 Embozo épico de Escarcha',NULL,0),
(20338,'esMX','90 Cinturón verde de Escarcha',NULL,0),
(20339,'esMX','90 Ataduras verdes de Escarcha',NULL,0),
(20340,'esMX','90 Botas verdes de Escarcha',NULL,0),
(20341,'esMX','90 Corona verde de Escarcha',NULL,0),
(20342,'esMX','90 Guantes verdes de Escarcha',NULL,0),
(20343,'esMX','90 Leotardos verdes de Escarcha',NULL,0),
(20344,'esMX','90 Manto verde de Escarcha',NULL,0),
(20345,'esMX','90 Gola verde de Escarcha',NULL,0),
(20346,'esMX','90 Anillo verde de Escarcha',NULL,0);

DELETE FROM `item_template_locale` WHERE `ID` IN(20347,20348,20349,20350,20351,20352,20353,20354,20355,20356,20357,20358,20359,20360,20361,20362,20363) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(20347,'esMX','90 Togas verdes de Escarcha',NULL,0),
(20348,'esMX','90 Embozo verde de Escarcha',NULL,0),
(20349,'esMX','90 Bastón verde de Escarcha',NULL,0),
(20350,'esMX','90 Varita verde de Escarcha',NULL,0),
(20351,'esMX','63 Cinturón verde de Escarcha',NULL,0),
(20352,'esMX','63 Ataduras verdes de Escarcha',NULL,0),
(20353,'esMX','63 Botas verdes de Escarcha',NULL,0),
(20354,'esMX','63 Corona verde de Escarcha',NULL,0),
(20355,'esMX','63 Guantes verdes de Escarcha',NULL,0),
(20356,'esMX','63 Leotardos verdes de Escarcha',NULL,0),
(20357,'esMX','63 Manto verde de Escarcha',NULL,0),
(20358,'esMX','63 Gola verde de Escarcha',NULL,0),
(20359,'esMX','63 Anillo verde de Escarcha',NULL,0),
(20360,'esMX','63 Togas verdes de Escarcha',NULL,0),
(20361,'esMX','63 Embozo verde de Escarcha',NULL,0),
(20362,'esMX','63 Bastón verde de Escarcha',NULL,0),
(20363,'esMX','63 Varita verde de Escarcha',NULL,0);

-- Insert new entries, from MOP
DELETE FROM `item_template_locale` WHERE `ID` IN(5281,5282,12063,19980,31167) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(5281,'esMX','"Monster - Dagger, Broad/Flat Blade"',NULL,0),
(5282,'esMX','"Monster - Dagger, Fang Hook Curve"',NULL,0),
(12063,'esMX','Monster - Trident, Wicked Red',NULL,0),
(19980,'esMX','"Monster - Dagger, Ornate Spikey Base Red"',NULL,0),
(31167,'esMX','Piedra de control de portal','El portador de esta piedra será transportado automáticamente cuando pase cerca de un portal demoníaco de un miembro del grupo o banda.',0);

-- Insert new entries, from RETAIL
DELETE FROM `item_template_locale` WHERE `ID` IN(18565,29025) AND `locale` = 'esMX';
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(18565,'esMX','Vasija de renacer',NULL,0),
(29025,'esMX','Bengala de D''kaan',NULL,0);

-- List of entries using TBC datas :
-- 30414,32913,32972,33062,33063,34835
-- List of entries using CLASSIC datas :
-- 5550,1002,3523,3524,3525,4142,4144,4160,5046,5047,5290,5678,7681,7716,8745,8803,8870,9092,11442,16315,16336,16337,16367,16370,16394,16395,16398,16399,16400,16402,16404,16407,16411,16412,16438,16439,16445,16447,16458,16460,16461,16464,16469,16470,16481,16482,16488,16493,16495,16500,16511,16512,16517,16520,16529,16537,16538,16546,16547,16553,16556,16557,16559,16570,16572,16575,16576,17563,17565,17574,17575,17582,17585,17587,17589,17595,17597,17606,17609,17614,17615,17619,17621,20462,23683,23690
-- List of entries using CATA datas :
-- 1014,37430,4156,4163,5015,5291,6437,6683,10594,16027,16028,16029,16030,16031,16033,16034,16035,16036,16037,16038,17412,18685,19742,19743,20135,20136,20137,20138,20139,20140,20141,20143,20144,20145,20146,20149,20238,20239,20240,20241,20242,20245,20246,20247,20248,20249,20250,20251,20252,20267,20268,20269,20270,20271,20272,20273,20274,20275,20276,20277,20278,20279,20280,20281,20282,20283,20284,20285,20286,20287,20288,20289,20290,20291,20292,20297,20298,20299,20300,20301,20302,20303,20304,20305,20306,20307,20308,20309,20311,20312,20313,20314,20315,20316,20317,20318,20319,20320,20321,20322,20323,20324,20325,20326,20327,20328,20330,20331,20332,20333,20334,20335,20336,20338,20339,20340,20341,20342,20343,20344,20345,20346,20347,20348,20349,20350,20351,20352,20353,20354,20355,20356,20357,20358,20359,20360,20361,20362,20363
-- List of entries using MOP datas :
-- 1259,5283,19924,53889,53890,5281,5282,12063,19980,31167
-- List of entries using RETAIL datas :
-- 2460,29225,18565,29025
