-- DB update 2023_03_14_04 -> 2023_03_14_05
--
UPDATE `quest_template_addon` SET `RequiredMaxRepValue`=5000 WHERE `ID` IN (7893,8222,7903,7898,7885);
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=5000 WHERE `ID` IN (7939,8223,7943,7942,7941);
