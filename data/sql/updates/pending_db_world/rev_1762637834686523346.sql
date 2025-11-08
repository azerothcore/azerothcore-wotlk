-- Update deDE ; from WowHead WOTLK
-- OLD name : Schmalspurrohling
-- Source : https://www.wowhead.com/wotlk/de/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Rohling der Defias' WHERE `locale` = 'deDE' AND `entry` = 38;
-- OLD name : Niederer Sukkubus
-- Source : https://www.wowhead.com/wotlk/de/npc=49
UPDATE `creature_template_locale` SET `Name` = 'Geringer Sukkubus' WHERE `locale` = 'deDE' AND `entry` = 49;
-- OLD name : Taschendieb
-- Source : https://www.wowhead.com/wotlk/de/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Taschendieb der Defias' WHERE `locale` = 'deDE' AND `entry` = 94;
-- OLD name : Kodowildtier
-- Source : https://www.wowhead.com/wotlk/de/npc=106
UPDATE `creature_template_locale` SET `Name` = 'Kodobestie' WHERE `locale` = 'deDE' AND `entry` = 106;
-- OLD name : Bandit
-- Source : https://www.wowhead.com/wotlk/de/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandit der Defias' WHERE `locale` = 'deDE' AND `entry` = 116;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=198
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 198;
-- OLD name : Verrottender Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Skelettschrecken' WHERE `locale` = 'deDE' AND `entry` = 202;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/de/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'deDE','Theodor Teufelswald','Holzschnitzer');
-- OLD name : Marschall Gryan Starkmantel, subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Starkmantel',`Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 234;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/de/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Ein halb aufgefressener Körper' WHERE `locale` = 'deDE' AND `entry` = 262;
-- OLD name : Koboldpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=281
UPDATE `creature_template_locale` SET `Name` = 'Koboldtank' WHERE `locale` = 'deDE' AND `entry` = 281;
-- OLD name : Junger Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Erkrankter junger Wolf' WHERE `locale` = 'deDE' AND `entry` = 299;
-- OLD name : Schimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Schimmel)' WHERE `locale` = 'deDE' AND `entry` = 305;
-- OLD name : Palomino
-- Source : https://www.wowhead.com/wotlk/de/npc=306
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Palomino)' WHERE `locale` = 'deDE' AND `entry` = 306;
-- OLD name : "Buried Upside-Down" Vehicle
-- Source : https://www.wowhead.com/wotlk/de/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Rolfs Leichnam' WHERE `locale` = 'deDE' AND `entry` = 309;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=328
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 328;
-- OLD subname : Anführer des SI:7
-- Source : https://www.wowhead.com/wotlk/de/npc=332
UPDATE `creature_template_locale` SET `Title` = 'Anführer von SI:7' WHERE `locale` = 'deDE' AND `entry` = 332;
-- OLD name : Winterwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=359
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Winter)' WHERE `locale` = 'deDE' AND `entry` = 359;
-- OLD name : Murak Winterborn
-- Source : https://www.wowhead.com/wotlk/de/npc=373
UPDATE `creature_template_locale` SET `Name` = 'Marek Winterborn' WHERE `locale` = 'deDE' AND `entry` = 373;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/de/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Kellnerin' WHERE `locale` = 'deDE' AND `entry` = 379;
-- OLD name : Katie Weidmann
-- Source : https://www.wowhead.com/wotlk/de/npc=384
UPDATE `creature_template_locale` SET `Name` = 'Katie Waidmann' WHERE `locale` = 'deDE' AND `entry` = 384;
-- OLD name : Niederer Leerwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=418
UPDATE `creature_template_locale` SET `Name` = 'Geringer Leerwandler' WHERE `locale` = 'deDE' AND `entry` = 418;
-- OLD name : Champion des Schwarzfels
-- Source : https://www.wowhead.com/wotlk/de/npc=435
UPDATE `creature_template_locale` SET `Name` = 'Held des Schwarzfels' WHERE `locale` = 'deDE' AND `entry` = 435;
-- OLD name : Wachhauptmann Parker
-- Source : https://www.wowhead.com/wotlk/de/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Wache Parker' WHERE `locale` = 'deDE' AND `entry` = 464;
-- OLD name : Abtrünniger Hexer
-- Source : https://www.wowhead.com/wotlk/de/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Abtrünniger Hexer der Defias' WHERE `locale` = 'deDE' AND `entry` = 474;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=487
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 487;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=488
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 488;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=489
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 489;
-- OLD name : Beschützerin Gariel, subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=490
UPDATE `creature_template_locale` SET `Name` = 'Beschützer Gariel',`Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 490;
-- OLD name : Wegelagerer
-- Source : https://www.wowhead.com/wotlk/de/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Wegelagerer der Defias' WHERE `locale` = 'deDE' AND `entry` = 583;
-- OLD name : Geschriebene Worte, subname : Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=693
UPDATE `creature_template_locale` SET `Name` = 'Lehrer für sekundäre Fertigkeiten',`Title` = 'Lehrer' WHERE `locale` = 'deDE' AND `entry` = 693;
-- OLD name : General Fangor
-- Source : https://www.wowhead.com/wotlk/de/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Leutnant Fangor' WHERE `locale` = 'deDE' AND `entry` = 703;
-- OLD name : Felsenkiefertrogg
-- Source : https://www.wowhead.com/wotlk/de/npc=707
UPDATE `creature_template_locale` SET `Name` = 'Trogg der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 707;
-- OLD name : Bulliger Felsenkiefertrogg
-- Source : https://www.wowhead.com/wotlk/de/npc=724
UPDATE `creature_template_locale` SET `Name` = 'Bulliger Trogg der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 724;
-- OLD name : Unteroffizierin Yohwa
-- Source : https://www.wowhead.com/wotlk/de/npc=733
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Yohwa' WHERE `locale` = 'deDE' AND `entry` = 733;
-- OLD name : Matschwirbler der Verirrten
-- Source : https://www.wowhead.com/wotlk/de/npc=760
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Verirrten' WHERE `locale` = 'deDE' AND `entry` = 760;
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=789
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacherin' WHERE `locale` = 'deDE' AND `entry` = 789;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=820
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 820;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=821
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 821;
-- OLD name : Unteroffizier Willem
-- Source : https://www.wowhead.com/wotlk/de/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Stellvertreter Willem' WHERE `locale` = 'deDE' AND `entry` = 823;
-- OLD name : Entfesselter Zyklon
-- Source : https://www.wowhead.com/wotlk/de/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Staubteufel' WHERE `locale` = 'deDE' AND `entry` = 832;
-- OLD name : Harl Cutter, subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'deDE','Harl Scherer','Holzschnitzbedarf');
-- OLD name : Wolfsbegleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=860
UPDATE `creature_template_locale` SET `Name` = 'Wolfstier' WHERE `locale` = 'deDE' AND `entry` = 860;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=869
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 869;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=870
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 870;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=874
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 874;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=876
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 876;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=878
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 878;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=944
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 944;
-- OLD subname : Librarian
-- Source : https://www.wowhead.com/wotlk/de/npc=951
UPDATE `creature_template_locale` SET `Title` = 'Bibliothekar' WHERE `locale` = 'deDE' AND `entry` = 951;
-- OLD name : Erik Dodds der Dritte
-- Source : https://www.wowhead.com/wotlk/de/npc=996
UPDATE `creature_template_locale` SET `Name` = 'Schneidermeister' WHERE `locale` = 'deDE' AND `entry` = 996;
-- OLD name : Unkillable Test Dummy, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=1000
UPDATE `creature_template_locale` SET `Name` = 'Behüter Blomberg',`Title` = 'Die Nachtwache' WHERE `locale` = 'deDE' AND `entry` = 1000;
-- OLD name : Matschwirbler der Blaukiemen
-- Source : https://www.wowhead.com/wotlk/de/npc=1028
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Blaukiemen' WHERE `locale` = 'deDE' AND `entry` = 1028;
-- OLD name : Schädelhauer der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1115
UPDATE `creature_template_locale` SET `Name` = 'Schädelhauer der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 1115;
-- OLD name : Wegelagerer der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1116
UPDATE `creature_template_locale` SET `Name` = 'Wegelagerer der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 1116;
-- OLD name : Knochenknacker der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1117
UPDATE `creature_template_locale` SET `Name` = 'Knochenknacker der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 1117;
-- OLD name : Kreuzbrecher der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1118
UPDATE `creature_template_locale` SET `Name` = 'Kreuzbrecher der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 1118;
-- OLD name : Schwarzbär
-- Source : https://www.wowhead.com/wotlk/de/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Alter Schwarzbär' WHERE `locale` = 'deDE' AND `entry` = 1186;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1228
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 1228;
-- OLD name : Weißer Widder X
-- Source : https://www.wowhead.com/wotlk/de/npc=1262
UPDATE `creature_template_locale` SET `Name` = 'Weißer Widder' WHERE `locale` = 'deDE' AND `entry` = 1262;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1294
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 1294;
-- OLD subname : Bogenhändler
-- Source : https://www.wowhead.com/wotlk/de/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Bogen- & Pfeilhändler' WHERE `locale` = 'deDE' AND `entry` = 1298;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1322
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 1322;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1323
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 1323;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1341
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 1341;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1349
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 1349;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Überragender Koch' WHERE `locale` = 'deDE' AND `entry` = 1382;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 1430;
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=1462
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacherin' WHERE `locale` = 'deDE' AND `entry` = 1462;
-- OLD name : Todeswache Simmer
-- Source : https://www.wowhead.com/wotlk/de/npc=1519
UPDATE `creature_template_locale` SET `Name` = 'Todeswache Brodler' WHERE `locale` = 'deDE' AND `entry` = 1519;
-- OLD name : Matschwirbler der Finsterflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=1545
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Finsterflossen' WHERE `locale` = 'deDE' AND `entry` = 1545;
-- OLD name : Slims Testschurke
-- Source : https://www.wowhead.com/wotlk/de/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40' WHERE `locale` = 'deDE' AND `entry` = 1601;
-- OLD name : Novizin Elreth
-- Source : https://www.wowhead.com/wotlk/de/npc=1661
UPDATE `creature_template_locale` SET `Name` = 'Novize Elreth' WHERE `locale` = 'deDE' AND `entry` = 1661;
-- OLD subname : Lederrüstungshändlerin
-- Source : https://www.wowhead.com/wotlk/de/npc=1695
UPDATE `creature_template_locale` SET `Title` = 'Lederrüstungshändler' WHERE `locale` = 'deDE' AND `entry` = 1695;
-- OLD name : Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Gefangener Defias' WHERE `locale` = 'deDE' AND `entry` = 1706;
-- OLD name : Eingekerkerter
-- Source : https://www.wowhead.com/wotlk/de/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Eingekerkerter Defias' WHERE `locale` = 'deDE' AND `entry` = 1711;
-- OLD name : Aufrührer
-- Source : https://www.wowhead.com/wotlk/de/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Aufrührer der Defias' WHERE `locale` = 'deDE' AND `entry` = 1715;
-- OLD name : Räuber der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1718
UPDATE `creature_template_locale` SET `Name` = 'Räuber der Felsenkiefer' WHERE `locale` = 'deDE' AND `entry` = 1718;
-- OLD name : Großadmiralin Jes-Tereth
-- Source : https://www.wowhead.com/wotlk/de/npc=1750
UPDATE `creature_template_locale` SET `Name` = 'Großadmiral Jes-Tereth' WHERE `locale` = 'deDE' AND `entry` = 1750;
-- OLD name : Tollwütiger Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Scheckiger Worg' WHERE `locale` = 'deDE' AND `entry` = 1766;
-- OLD name : Netzhuscherhetzer
-- Source : https://www.wowhead.com/wotlk/de/npc=1780
UPDATE `creature_template_locale` SET `Name` = 'Moospirscher' WHERE `locale` = 'deDE' AND `entry` = 1780;
-- OLD name : Netzhuscherlauerer
-- Source : https://www.wowhead.com/wotlk/de/npc=1781
UPDATE `creature_template_locale` SET `Name` = 'Nebelkrabbler' WHERE `locale` = 'deDE' AND `entry` = 1781;
-- OLD name : Skelettschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=1785
UPDATE `creature_template_locale` SET `Name` = 'Skelettschrecker' WHERE `locale` = 'deDE' AND `entry` = 1785;
-- OLD name : Tollwütiger Riesenbär
-- Source : https://www.wowhead.com/wotlk/de/npc=1797
UPDATE `creature_template_locale` SET `Name` = 'Ergrauter Riesenbär' WHERE `locale` = 'deDE' AND `entry` = 1797;
-- OLD name : Niederer Netherwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=1862
UPDATE `creature_template_locale` SET `Name` = 'Geringer Netherwandler' WHERE `locale` = 'deDE' AND `entry` = 1862;
-- OLD name : Behüter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Behüter von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1888;
-- OLD name : Hexer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Hexer von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1889;
-- OLD name : Beschützer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1912
UPDATE `creature_template_locale` SET `Name` = 'Beschützer von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1912;
-- OLD name : Wärter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1913
UPDATE `creature_template_locale` SET `Name` = 'Wärter von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1913;
-- OLD name : Magister von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1914
UPDATE `creature_template_locale` SET `Name` = 'Magier von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1914;
-- OLD name : Herbeizauberer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1915
UPDATE `creature_template_locale` SET `Name` = 'Herbeizauberer von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1915;
-- OLD name : Zauberschreiber von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1920
UPDATE `creature_template_locale` SET `Name` = 'Zauberschreiber von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 1920;
-- OLD subname : Immun gegen Körperliches
-- Source : https://www.wowhead.com/wotlk/de/npc=1930
UPDATE `creature_template_locale` SET `Title` = 'Immun gegen Körperschäden' WHERE `locale` = 'deDE' AND `entry` = 1930;
-- OLD name : Uralter Beschützer
-- Source : https://www.wowhead.com/wotlk/de/npc=2041
UPDATE `creature_template_locale` SET `Name` = 'Urtumbeschützer' WHERE `locale` = 'deDE' AND `entry` = 2041;
-- OLD name : Athridas Bärenfell
-- Source : https://www.wowhead.com/wotlk/de/npc=2078
UPDATE `creature_template_locale` SET `Name` = 'Athridas Bärenpelz' WHERE `locale` = 'deDE' AND `entry` = 2078;
-- OLD name : Ilthalaine
-- Source : https://www.wowhead.com/wotlk/de/npc=2079
UPDATE `creature_template_locale` SET `Name` = 'Konservator Ilthalaine' WHERE `locale` = 'deDE' AND `entry` = 2079;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2124
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 2124;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=2128
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 2128;
-- OLD name : Maggarrak
-- Source : https://www.wowhead.com/wotlk/de/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Steinwüter' WHERE `locale` = 'deDE' AND `entry` = 2258;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/de/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'deDE','Bogenträger',NULL);
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Arzt' WHERE `locale` = 'deDE' AND `entry` = 2326;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Ärztin' WHERE `locale` = 'deDE' AND `entry` = 2329;
-- OLD name : Fanatikerin des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=2336
UPDATE `creature_template_locale` SET `Name` = 'Fanatikerin des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 2336;
-- OLD name : Leerruferin des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=2337
UPDATE `creature_template_locale` SET `Name` = 'Leerruferin des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 2337;
-- OLD name : Domestizierter Krabbler
-- Source : https://www.wowhead.com/wotlk/de/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Riesiger Mooskrabbler' WHERE `locale` = 'deDE' AND `entry` = 2349;
-- OLD name : Waldkrabbler
-- Source : https://www.wowhead.com/wotlk/de/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Waldmooskrabbler' WHERE `locale` = 'deDE' AND `entry` = 2350;
-- OLD name : Verseuchter Bär
-- Source : https://www.wowhead.com/wotlk/de/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Graubär' WHERE `locale` = 'deDE' AND `entry` = 2351;
-- OLD name : Matschwirbler der Fetzenflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=2374
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Fetzenflossen' WHERE `locale` = 'deDE' AND `entry` = 2374;
-- OLD name : Hügellandpirscher
-- Source : https://www.wowhead.com/wotlk/de/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'Wilder Berglöwe' WHERE `locale` = 'deDE' AND `entry` = 2385;
-- OLD name : Wächter der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Wache von Süderstade' WHERE `locale` = 'deDE' AND `entry` = 2386;
-- OLD name : Gosh-Haldir
-- Source : https://www.wowhead.com/wotlk/de/npc=2476
UPDATE `creature_template_locale` SET `Name` = 'Großer Lochkrokilisk' WHERE `locale` = 'deDE' AND `entry` = 2476;
-- OLD name : Himmelsmähnengorilla
-- Source : https://www.wowhead.com/wotlk/de/npc=2521
UPDATE `creature_template_locale` SET `Name` = 'Blaumähnengorilla' WHERE `locale` = 'deDE' AND `entry` = 2521;
-- OLD subname : Gesandter von Zanzil
-- Source : https://www.wowhead.com/wotlk/de/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Geisel der Dunkelspeere' WHERE `locale` = 'deDE' AND `entry` = 2530;
-- OLD name : Diener von Doane
-- Source : https://www.wowhead.com/wotlk/de/npc=2531
UPDATE `creature_template_locale` SET `Name` = 'Diener von Morganth' WHERE `locale` = 'deDE' AND `entry` = 2531;
-- OLD name : Schlange von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=2540
UPDATE `creature_template_locale` SET `Name` = 'Schlange von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 2540;
-- OLD name : Soldat von Stromgarde
-- Source : https://www.wowhead.com/wotlk/de/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Verteidiger von Stromgarde' WHERE `locale` = 'deDE' AND `entry` = 2585;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/de/npc=2598
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeister des Schattenrats' WHERE `locale` = 'deDE' AND `entry` = 2598;
-- OLD name : Sängerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2600
UPDATE `creature_template_locale` SET `Name` = 'Sänger' WHERE `locale` = 'deDE' AND `entry` = 2600;
-- OLD name : Kommandantin Amaren
-- Source : https://www.wowhead.com/wotlk/de/npc=2608
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Amaren' WHERE `locale` = 'deDE' AND `entry` = 2608;
-- OLD name : Alter Schnappkieferkrokilisk
-- Source : https://www.wowhead.com/wotlk/de/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Alter Salzwasserkrokilisk' WHERE `locale` = 'deDE' AND `entry` = 2635;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'deDE','Hafenmeister Szik','Bootsverkäufer');
-- OLD name : Barrikade
-- Source : https://www.wowhead.com/wotlk/de/npc=2749
UPDATE `creature_template_locale` SET `Name` = 'Belagerungsgolem' WHERE `locale` = 'deDE' AND `entry` = 2749;
-- OLD name : Ausgedörrter Bussard
-- Source : https://www.wowhead.com/wotlk/de/npc=2830
UPDATE `creature_template_locale` SET `Name` = 'Bussard' WHERE `locale` = 'deDE' AND `entry` = 2830;
-- OLD subname : Klingenhändlerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2843
UPDATE `creature_template_locale` SET `Title` = 'Klingentrödlerin' WHERE `locale` = 'deDE' AND `entry` = 2843;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Krokiliskenausbilder' WHERE `locale` = 'deDE' AND `entry` = 2876;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Fertigkeitenlehrer für Distanzwaffen' WHERE `locale` = 'deDE' AND `entry` = 2886;
-- OLD name : Aldric Weidmann, subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2938
UPDATE `creature_template_locale` SET `Name` = 'Aldric Waidmann',`Title` = 'Bärenausbilder' WHERE `locale` = 'deDE' AND `entry` = 2938;
-- OLD subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'deDE',NULL,'Eberausbilder');
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2942
UPDATE `creature_template_locale` SET `Title` = 'Wolfausbilder' WHERE `locale` = 'deDE' AND `entry` = 2942;
-- OLD name : Eindringling der Borstennacken
-- Source : https://www.wowhead.com/wotlk/de/npc=2952
UPDATE `creature_template_locale` SET `Name` = 'Stacheleber der Borstennacken' WHERE `locale` = 'deDE' AND `entry` = 2952;
-- OLD name : Junger Kampfeber
-- Source : https://www.wowhead.com/wotlk/de/npc=2966
UPDATE `creature_template_locale` SET `Name` = 'Kampfeber' WHERE `locale` = 'deDE' AND `entry` = 2966;
-- OLD name : Geist der Ahnen
-- Source : https://www.wowhead.com/wotlk/de/npc=2994
UPDATE `creature_template_locale` SET `Name` = 'Vorfahrengeist' WHERE `locale` = 'deDE' AND `entry` = 2994;
-- OLD subname : Schneiderbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungs- & Schneiderbedarf' WHERE `locale` = 'deDE' AND `entry` = 3005;
-- OLD subname : Lederverarbeitungsbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungslehrling' WHERE `locale` = 'deDE' AND `entry` = 3008;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3047
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 3047;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=3048
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 3048;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3049
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 3049;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3067
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 3067;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3095
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 3095;
-- OLD name : Brandungskriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Zwergbrandungskriecher' WHERE `locale` = 'deDE' AND `entry` = 3106;
-- OLD name : Ausgewachsener Brandungskriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Brandungskriecher' WHERE `locale` = 'deDE' AND `entry` = 3107;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=3149
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar' WHERE `locale` = 'deDE' AND `entry` = 3149;
-- OLD name : Neeru Fireblade
-- Source : https://www.wowhead.com/wotlk/de/npc=3200
UPDATE `creature_template_locale` SET `Name` = 'Erics Superspezialbedarfverkäufer' WHERE `locale` = 'deDE' AND `entry` = 3200;
-- OLD name : Scott Mercer
-- Source : https://www.wowhead.com/wotlk/de/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob' WHERE `locale` = 'deDE' AND `entry` = 3201;
-- OLD name : Zischel Dunkelklaue
-- Source : https://www.wowhead.com/wotlk/de/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Zischel Düstersturm' WHERE `locale` = 'deDE' AND `entry` = 3203;
-- OLD name : Wissenshüter Regentotem
-- Source : https://www.wowhead.com/wotlk/de/npc=3233
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Regentotem' WHERE `locale` = 'deDE' AND `entry` = 3233;
-- OLD name : Sonnenschuppenschmetterschwanz
-- Source : https://www.wowhead.com/wotlk/de/npc=3254
UPDATE `creature_template_locale` SET `Name` = 'Bluthornschmetterschwanz' WHERE `locale` = 'deDE' AND `entry` = 3254;
-- OLD name : Sonnenschuppenkreischer
-- Source : https://www.wowhead.com/wotlk/de/npc=3255
UPDATE `creature_template_locale` SET `Name` = 'Bluthornkreischer' WHERE `locale` = 'deDE' AND `entry` = 3255;
-- OLD name : Sonnenschuppensensenklaue
-- Source : https://www.wowhead.com/wotlk/de/npc=3256
UPDATE `creature_template_locale` SET `Name` = 'Bluthornsensenklaue' WHERE `locale` = 'deDE' AND `entry` = 3256;
-- OLD name : Brandschatzer der Klingenmähnen
-- Source : https://www.wowhead.com/wotlk/de/npc=3267
UPDATE `creature_template_locale` SET `Name` = 'Wassersucher der Klingenmähnen' WHERE `locale` = 'deDE' AND `entry` = 3267;
-- OLD name : Schlickanomalie
-- Source : https://www.wowhead.com/wotlk/de/npc=3295
UPDATE `creature_template_locale` SET `Name` = 'Schlickbestie' WHERE `locale` = 'deDE' AND `entry` = 3295;
-- OLD subname : Stoffrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Händler für leichte Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 3317;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3319
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 3319;
-- OLD subname : Verkäuferin für Bögen & Gewehre
-- Source : https://www.wowhead.com/wotlk/de/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition' WHERE `locale` = 'deDE' AND `entry` = 3322;
-- OLD subname : Reagenzien & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundebedarf' WHERE `locale` = 'deDE' AND `entry` = 3405;
-- OLD name : Lebende Flamme
-- Source : https://www.wowhead.com/wotlk/de/npc=3417
UPDATE `creature_template_locale` SET `Name` = 'Lebendige Flamme' WHERE `locale` = 'deDE' AND `entry` = 3417;
-- OLD subname : Unabhängiger Vertragspartner
-- Source : https://www.wowhead.com/wotlk/de/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Tüftlerverband' WHERE `locale` = 'deDE' AND `entry` = 3442;
-- OLD subname : Händler für Leder- & Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3483
UPDATE `creature_template_locale` SET `Title` = 'Händler für Leder- & schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 3483;
-- OLD name : Temp Giftmischereibedarfsverkäufer Zwerg, subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3559
UPDATE `creature_template_locale` SET `Name` = 'Temp Giftmischereibedarfverkäufer Zwerg',`Title` = 'Giftreagenzien' WHERE `locale` = 'deDE' AND `entry` = 3559;
-- OLD name : Braumeister von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Braumeister von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 3577;
-- OLD name : Minenarbeiter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Minenarbeiter von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 3578;
-- OLD subname : Kult des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3660
UPDATE `creature_template_locale` SET `Title` = 'Kult des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3660;
-- OLD name : Muyoh
-- Source : https://www.wowhead.com/wotlk/de/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Jünger von Naralex' WHERE `locale` = 'deDE' AND `entry` = 3678;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'deDE','Kyln Langklaue','Eberausbilder');
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3698
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder' WHERE `locale` = 'deDE' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3699
UPDATE `creature_template_locale` SET `Title` = 'Katzenausbilderin' WHERE `locale` = 'deDE' AND `entry` = 3699;
-- OLD name : Nebelpeitscherhydra
-- Source : https://www.wowhead.com/wotlk/de/npc=3721
UPDATE `creature_template_locale` SET `Name` = 'Mythosschuppenhydra' WHERE `locale` = 'deDE' AND `entry` = 3721;
-- OLD name : Nebelpeitscherschinder
-- Source : https://www.wowhead.com/wotlk/de/npc=3722
UPDATE `creature_template_locale` SET `Name` = 'Mythosschuppenschinder' WHERE `locale` = 'deDE' AND `entry` = 3722;
-- OLD name : Kultist des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3725
UPDATE `creature_template_locale` SET `Name` = 'Kultist des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3725;
-- OLD name : Vollstrecker des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3727
UPDATE `creature_template_locale` SET `Name` = 'Vollstrecker des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3727;
-- OLD name : Adept des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3728
UPDATE `creature_template_locale` SET `Name` = 'Adept des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3728;
-- OLD name : Ausgräber des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3730
UPDATE `creature_template_locale` SET `Name` = 'Ausgräber des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3730;
-- OLD name : Orcischer Aufseher
-- Source : https://www.wowhead.com/wotlk/de/npc=3734
UPDATE `creature_template_locale` SET `Name` = 'Rohling der Verlassenen' WHERE `locale` = 'deDE' AND `entry` = 3734;
-- OLD name : Matschwirbler der Salzflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=3740
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Salzflossen' WHERE `locale` = 'deDE' AND `entry` = 3740;
-- OLD name : Angesengter Schlurfer
-- Source : https://www.wowhead.com/wotlk/de/npc=3780
UPDATE `creature_template_locale` SET `Name` = 'Schattendickichtmoosfresser' WHERE `locale` = 'deDE' AND `entry` = 3780;
-- OLD name : Flimmerdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=3815
UPDATE `creature_template_locale` SET `Name` = 'Beflügelter Großdrache' WHERE `locale` = 'deDE' AND `entry` = 3815;
-- OLD name : Teldira Mondfeder
-- Source : https://www.wowhead.com/wotlk/de/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Caylais Mondfeder' WHERE `locale` = 'deDE' AND `entry` = 3841;
-- OLD name : Niederer Gargoyle
-- Source : https://www.wowhead.com/wotlk/de/npc=3869
UPDATE `creature_template_locale` SET `Name` = 'Geringer Gargoyle' WHERE `locale` = 'deDE' AND `entry` = 3869;
-- OLD name : Auftragsmörder des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3879
UPDATE `creature_template_locale` SET `Name` = 'Auftragsmörder des dunklen Strangs' WHERE `locale` = 'deDE' AND `entry` = 3879;
-- OLD name : Siechendes Urtum
-- Source : https://www.wowhead.com/wotlk/de/npc=3919
UPDATE `creature_template_locale` SET `Name` = 'Welkes Urtum' WHERE `locale` = 'deDE' AND `entry` = 3919;
-- OLD subname : Generalin der Schildwachenarmee
-- Source : https://www.wowhead.com/wotlk/de/npc=3936
UPDATE `creature_template_locale` SET `Title` = 'General der Schildwachenarmee' WHERE `locale` = 'deDE' AND `entry` = 3936;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3966
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 3966;
-- OLD subname : Giftverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=3969
UPDATE `creature_template_locale` SET `Title` = 'Werkzeuge und Bedarfsartikel' WHERE `locale` = 'deDE' AND `entry` = 3969;
-- OLD name : Bewacher der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=3992
UPDATE `creature_template_locale` SET `Name` = 'Ingenieur der Venture Co.' WHERE `locale` = 'deDE' AND `entry` = 3992;
-- OLD name : Prachtschwingenwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=4012
UPDATE `creature_template_locale` SET `Name` = 'Prachtschwingenflügeldrache' WHERE `locale` = 'deDE' AND `entry` = 4012;
-- OLD name : Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=4016
UPDATE `creature_template_locale` SET `Name` = 'Siechdrache' WHERE `locale` = 'deDE' AND `entry` = 4016;
-- OLD name : Verschlagener Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=4017
UPDATE `creature_template_locale` SET `Name` = 'Verschlagener Siechdrache' WHERE `locale` = 'deDE' AND `entry` = 4017;
-- OLD name : Verderbte Blutsaftbestie
-- Source : https://www.wowhead.com/wotlk/de/npc=4021
UPDATE `creature_template_locale` SET `Name` = 'Ätzblutsaftbestie' WHERE `locale` = 'deDE' AND `entry` = 4021;
-- OLD name : Schwarzgebratener Basilisk
-- Source : https://www.wowhead.com/wotlk/de/npc=4044
UPDATE `creature_template_locale` SET `Name` = 'Geschwärzter Basilisk' WHERE `locale` = 'deDE' AND `entry` = 4044;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=4045
UPDATE `creature_template_locale` SET `Name` = '[UNUSED] JEFF CHOW TEST' WHERE `locale` = 'deDE' AND `entry` = 4045;
-- OLD name : Steilhangwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=4107
UPDATE `creature_template_locale` SET `Name` = 'Steilhangflügeldrache' WHERE `locale` = 'deDE' AND `entry` = 4107;
-- OLD name : Krkk'kx
-- Source : https://www.wowhead.com/wotlk/de/npc=4132
UPDATE `creature_template_locale` SET `Name` = 'Silithidverheerer' WHERE `locale` = 'deDE' AND `entry` = 4132;
-- OLD name : Skorpidschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=4139
UPDATE `creature_template_locale` SET `Name` = 'Skorpidschrecker' WHERE `locale` = 'deDE' AND `entry` = 4139;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4149
UPDATE `creature_template_locale` SET `Title` = 'Nahrungssuchelehrerin' WHERE `locale` = 'deDE' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4153
UPDATE `creature_template_locale` SET `Title` = 'Katzenausbilderin' WHERE `locale` = 'deDE' AND `entry` = 4153;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4157
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrerin' WHERE `locale` = 'deDE' AND `entry` = 4157;
-- OLD subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/de/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'deDE',NULL,'Pfeilhändlerin');
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4177
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 4177;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4178
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 4178;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4206
UPDATE `creature_template_locale` SET `Title` = 'Bärenausbilder' WHERE `locale` = 'deDE' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4207
UPDATE `creature_template_locale` SET `Title` = 'Wolfausbilder' WHERE `locale` = 'deDE' AND `entry` = 4207;
-- OLD subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'deDE',NULL,'Kartografiebedarf');
-- OLD name : Grauer Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=4268
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Grau)' WHERE `locale` = 'deDE' AND `entry` = 4268;
-- OLD name : Roter Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=4270
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Rot)' WHERE `locale` = 'deDE' AND `entry` = 4270;
-- OLD name : Scharlachroter Champion
-- Source : https://www.wowhead.com/wotlk/de/npc=4302
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Held' WHERE `locale` = 'deDE' AND `entry` = 4302;
-- OLD name : Scharlachroter Folterer
-- Source : https://www.wowhead.com/wotlk/de/npc=4306
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Folterknecht' WHERE `locale` = 'deDE' AND `entry` = 4306;
-- OLD name : Matschwirbler der Schlammflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=4361
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Schlammflossen' WHERE `locale` = 'deDE' AND `entry` = 4361;
-- OLD name : Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4391
UPDATE `creature_template_locale` SET `Name` = 'Sumpfbrühschlammer' WHERE `locale` = 'deDE' AND `entry` = 4391;
-- OLD name : Ätzender Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4392
UPDATE `creature_template_locale` SET `Name` = 'Ätzender Sumpfbrühschlammer' WHERE `locale` = 'deDE' AND `entry` = 4392;
-- OLD name : Wallender Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4395
UPDATE `creature_template_locale` SET `Name` = 'Wallender Sumpfbrühschlammer' WHERE `locale` = 'deDE' AND `entry` = 4395;
-- OLD name : Rennmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=4419
UPDATE `creature_template_locale` SET `Name` = 'Rennmeister Kronkreiter' WHERE `locale` = 'deDE' AND `entry` = 4419;
-- OLD subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/de/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'deDE',NULL,'Totemverkäuferin');
-- OLD name : Blut von Agamaggan
-- Source : https://www.wowhead.com/wotlk/de/npc=4541
UPDATE `creature_template_locale` SET `Name` = 'Blut von Agammagan' WHERE `locale` = 'deDE' AND `entry` = 4541;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4559
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 4559;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4560
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 4560;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4566
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 4566;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=4567
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 4567;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4568
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 4568;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Schattengewebeschneidermeisterin' WHERE `locale` = 'deDE' AND `entry` = 4578;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4621
UPDATE `creature_template_locale` SET `Title` = 'Raptorausbilder' WHERE `locale` = 'deDE' AND `entry` = 4621;
-- OLD name : Kolkarzentaure
-- Source : https://www.wowhead.com/wotlk/de/npc=4632
UPDATE `creature_template_locale` SET `Name` = 'Zentaur der Kolkar' WHERE `locale` = 'deDE' AND `entry` = 4632;
-- OLD name : Randal Weidmann
-- Source : https://www.wowhead.com/wotlk/de/npc=4732
UPDATE `creature_template_locale` SET `Name` = 'Randal Waidmann' WHERE `locale` = 'deDE' AND `entry` = 4732;
-- OLD name : Frostwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=4778
UPDATE `creature_template_locale` SET `Name` = 'Reitwidder (Blau)' WHERE `locale` = 'deDE' AND `entry` = 4778;
-- OLD name : Schwarzer Widder
-- Source : https://www.wowhead.com/wotlk/de/npc=4780
UPDATE `creature_template_locale` SET `Name` = 'Reitwidder (Schwarz)' WHERE `locale` = 'deDE' AND `entry` = 4780;
-- OLD name : Zwielichtakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=4809
UPDATE `creature_template_locale` SET `Name` = 'Akolyth des Schattenhammers' WHERE `locale` = 'deDE' AND `entry` = 4809;
-- OLD name : Matschwirbler der Nachtaugen
-- Source : https://www.wowhead.com/wotlk/de/npc=4819
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Nachtaugen' WHERE `locale` = 'deDE' AND `entry` = 4819;
-- OLD subname : Wissenshüter
-- Source : https://www.wowhead.com/wotlk/de/npc=4878
UPDATE `creature_template_locale` SET `Title` = 'Bewahrer der Lehren' WHERE `locale` = 'deDE' AND `entry` = 4878;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4881
UPDATE `creature_template_locale` SET `Title` = 'Schildkrötenausbilder' WHERE `locale` = 'deDE' AND `entry` = 4881;
-- OLD subname : Rüstungs- & Waffenschmied
-- Source : https://www.wowhead.com/wotlk/de/npc=4886
UPDATE `creature_template_locale` SET `Title` = 'Rüstungs- & Schildschmied' WHERE `locale` = 'deDE' AND `entry` = 4886;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedin' WHERE `locale` = 'deDE' AND `entry` = 4888;
-- OLD subname : Jägerlehrer & Bogenmacher
-- Source : https://www.wowhead.com/wotlk/de/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Bogenmacher' WHERE `locale` = 'deDE' AND `entry` = 4892;
-- OLD subname : Kochlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 4894;
-- OLD subname : Gemischtwaren & Reagenzien
-- Source : https://www.wowhead.com/wotlk/de/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Gemischtwaren' WHERE `locale` = 'deDE' AND `entry` = 4896;
-- OLD name : Wasserschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Mokassin' WHERE `locale` = 'deDE' AND `entry` = 4953;
-- OLD subname : Herrscherin über Theramore
-- Source : https://www.wowhead.com/wotlk/de/npc=4968
UPDATE `creature_template_locale` SET `Title` = 'Herrscherin von Theramore' WHERE `locale` = 'deDE' AND `entry` = 4968;
-- OLD name : Welt Magierlehrerin, subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4987
UPDATE `creature_template_locale` SET `Name` = 'Welt Magielehrerin',`Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 4987;
-- OLD subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4994
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Wölfe' WHERE `locale` = 'deDE' AND `entry` = 4994;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5001
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Vögel' WHERE `locale` = 'deDE' AND `entry` = 5001;
-- OLD name : World Boar Trainer, subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'deDE','Welt Eberausbilderin','Tierausbilderin für Eber');
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5003
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Katzen' WHERE `locale` = 'deDE' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5004
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Kriecher' WHERE `locale` = 'deDE' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5005
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Krokodile' WHERE `locale` = 'deDE' AND `entry` = 5005;
-- OLD name : Weltdämonenausbilderin, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'Welt Dämonenausbilderin',`Title` = 'Dämonenausbilderin' WHERE `locale` = 'deDE' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5008
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Gorillas' WHERE `locale` = 'deDE' AND `entry` = 5008;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5009
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Pferde' WHERE `locale` = 'deDE' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5011
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Raptoren' WHERE `locale` = 'deDE' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5012
UPDATE `creature_template_locale` SET `Title` = 'Skorpidtierausbilder' WHERE `locale` = 'deDE' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5013
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Spinnen' WHERE `locale` = 'deDE' AND `entry` = 5013;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5015
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Weitschreiter' WHERE `locale` = 'deDE' AND `entry` = 5015;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5017
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Schildkröten' WHERE `locale` = 'deDE' AND `entry` = 5017;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5026
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5026;
-- OLD name : [PH] Schmerzbanner der Mogu, subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5027
UPDATE `creature_template_locale` SET `Name` = 'Welt Schlossknackenlehrerin',`Title` = 'Schlossknackenlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5027;
-- OLD name : Jiming, subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5029
UPDATE `creature_template_locale` SET `Name` = 'Welt Überlebenskunstlehrerin',`Title` = 'Überlebenskunstlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5029;
-- OLD subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5030
UPDATE `creature_template_locale` SET `Title` = 'Tigerreitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5030;
-- OLD name : Welt-Alchemielehrerin, subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5032
UPDATE `creature_template_locale` SET `Name` = 'Welt Alchimielehrerin',`Title` = 'Alchimielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5032;
-- OLD name : Winwa, subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5034
UPDATE `creature_template_locale` SET `Name` = 'Welt Braukunstlehrerin',`Title` = 'Brauskunstlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5035
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5035;
-- OLD subname : Hexenmeisterlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5039
UPDATE `creature_template_locale` SET `Title` = 'Fährtenlesekunstlehrer' WHERE `locale` = 'deDE' AND `entry` = 5039;
-- OLD name : Rabauke
-- Source : https://www.wowhead.com/wotlk/de/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Rabauke der Defias' WHERE `locale` = 'deDE' AND `entry` = 5043;
-- OLD name : Zahlmeister Lendry
-- Source : https://www.wowhead.com/wotlk/de/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Amtmann Lendry' WHERE `locale` = 'deDE' AND `entry` = 5083;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5104
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffenlehrerin' WHERE `locale` = 'deDE' AND `entry` = 5104;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5106
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5106;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5107
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5107;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5125
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5125;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5126
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5126;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5144
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5144;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5145
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5145;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5146
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 5146;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrer' WHERE `locale` = 'deDE' AND `entry` = 5164;
-- OLD name : Jeremys Testmonster
-- Source : https://www.wowhead.com/wotlk/de/npc=5326
UPDATE `creature_template_locale` SET `Name` = 'Küstenkriecherklacker' WHERE `locale` = 'deDE' AND `entry` = 5326;
-- OLD subname : Juwelierskunstlehrer & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Forscherliga' WHERE `locale` = 'deDE' AND `entry` = 5388;
-- OLD name : Versklavter Ernter
-- Source : https://www.wowhead.com/wotlk/de/npc=5409
UPDATE `creature_template_locale` SET `Name` = 'Sammlerschwarm' WHERE `locale` = 'deDE' AND `entry` = 5409;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5497
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5497;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5498
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5498;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5507
UPDATE `creature_template_locale` SET `Title` = 'Weitschreiterausbilder' WHERE `locale` = 'deDE' AND `entry` = 5507;
-- OLD name : Grunzerin Mojka
-- Source : https://www.wowhead.com/wotlk/de/npc=5603
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Mojka' WHERE `locale` = 'deDE' AND `entry` = 5603;
-- OLD name : Trainingsattrappe von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=5652
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Unterstadt' WHERE `locale` = 'deDE' AND `entry` = 5652;
-- OLD name : Comar Villard
-- Source : https://www.wowhead.com/wotlk/de/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Corma Villard' WHERE `locale` = 'deDE' AND `entry` = 5683;
-- OLD name : Comar-Villard-Projektion
-- Source : https://www.wowhead.com/wotlk/de/npc=5692
UPDATE `creature_template_locale` SET `Name` = 'Corma-Villard-Projektion' WHERE `locale` = 'deDE' AND `entry` = 5692;
-- OLD subname : Gerards Gedankensklavin
-- Source : https://www.wowhead.com/wotlk/de/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Gerards Experiment' WHERE `locale` = 'deDE' AND `entry` = 5697;
-- OLD name : Wächter von Blizzard
-- Source : https://www.wowhead.com/wotlk/de/npc=5764
UPDATE `creature_template_locale` SET `Name` = 'Blizzardwächter' WHERE `locale` = 'deDE' AND `entry` = 5764;
-- OLD name : Unteroffizier Curtis
-- Source : https://www.wowhead.com/wotlk/de/npc=5809
UPDATE `creature_template_locale` SET `Name` = 'Wachkommandant Zalaphil' WHERE `locale` = 'deDE' AND `entry` = 5809;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5812
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5812;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5819
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 5819;
-- OLD name : Geofürst Sprenkel
-- Source : https://www.wowhead.com/wotlk/de/npc=5826
UPDATE `creature_template_locale` SET `Name` = 'Geolord Sprenkel' WHERE `locale` = 'deDE' AND `entry` = 5826;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5880
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 5880;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5882
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5882;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5883
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5883;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5884
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5884;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5885
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5885;
-- OLD name : Totem der Läuterung
-- Source : https://www.wowhead.com/wotlk/de/npc=5924
UPDATE `creature_template_locale` SET `Name` = 'Totem der Reinigung' WHERE `locale` = 'deDE' AND `entry` = 5924;
-- OLD name : Totem des Elementarwiderstands
-- Source : https://www.wowhead.com/wotlk/de/npc=5927
UPDATE `creature_template_locale` SET `Name` = 'Totem des Feuerwiderstands' WHERE `locale` = 'deDE' AND `entry` = 5927;
-- OLD name : Welt Gnom Männlich Magierlehrer, subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5961
UPDATE `creature_template_locale` SET `Name` = 'Welt Gnom Männlich Magielehrer',`Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 5961;
-- OLD name : Welt Gnom Magierlehrerin, subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5969
UPDATE `creature_template_locale` SET `Name` = 'Welt Gnom Magielehrerin',`Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 5969;
-- OLD name : Ritualist der Schattenanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Kultist der Schattenanbeter' WHERE `locale` = 'deDE' AND `entry` = 6004;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=6028
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 6028;
-- OLD name : Totem des Erdgriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=6066
UPDATE `creature_template_locale` SET `Name` = 'Totem des Erdengriffs' WHERE `locale` = 'deDE' AND `entry` = 6066;
-- OLD name : Drakonischer Magierlord
-- Source : https://www.wowhead.com/wotlk/de/npc=6129
UPDATE `creature_template_locale` SET `Name` = 'Drachischer Magierlord' WHERE `locale` = 'deDE' AND `entry` = 6129;
-- OLD name : Drakonischer Magiewirker
-- Source : https://www.wowhead.com/wotlk/de/npc=6131
UPDATE `creature_template_locale` SET `Name` = 'Drachischer Magiewirker' WHERE `locale` = 'deDE' AND `entry` = 6131;
-- OLD name : Arkkoranmatschwirbler
-- Source : https://www.wowhead.com/wotlk/de/npc=6136
UPDATE `creature_template_locale` SET `Name` = 'Arkkoranmatschkrabbler' WHERE `locale` = 'deDE' AND `entry` = 6136;
-- OLD name : Sohn von Arkkoroc
-- Source : https://www.wowhead.com/wotlk/de/npc=6144
UPDATE `creature_template_locale` SET `Name` = 'Arkkorocs Sohn' WHERE `locale` = 'deDE' AND `entry` = 6144;
-- OLD name : Zauberin der Grollflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=6197
UPDATE `creature_template_locale` SET `Name` = 'Zauberhexerin der Grollflossen' WHERE `locale` = 'deDE' AND `entry` = 6197;
-- OLD name : Akolythin Magaz
-- Source : https://www.wowhead.com/wotlk/de/npc=6252
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Magaz' WHERE `locale` = 'deDE' AND `entry` = 6252;
-- OLD name : Akolythin Wytula
-- Source : https://www.wowhead.com/wotlk/de/npc=6254
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Wytula' WHERE `locale` = 'deDE' AND `entry` = 6254;
-- OLD name : Akolythin Porena
-- Source : https://www.wowhead.com/wotlk/de/npc=6267
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Porena' WHERE `locale` = 'deDE' AND `entry` = 6267;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=6286
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 6286;
-- OLD name : Gefallener Champion
-- Source : https://www.wowhead.com/wotlk/de/npc=6488
UPDATE `creature_template_locale` SET `Name` = 'Gestürzter Held' WHERE `locale` = 'deDE' AND `entry` = 6488;
-- OLD name : "Hahnentritt" Johnson
-- Source : https://www.wowhead.com/wotlk/de/npc=6626
UPDATE `creature_template_locale` SET `Name` = 'Eisenherz Johnson' WHERE `locale` = 'deDE' AND `entry` = 6626;
-- OLD name : "Hahnentritt" Johnsons Menschengestalt
-- Source : https://www.wowhead.com/wotlk/de/npc=6666
UPDATE `creature_template_locale` SET `Name` = 'Eisenherz Johnsons Menschengestalt' WHERE `locale` = 'deDE' AND `entry` = 6666;
-- OLD name : Strandkrebs
-- Source : https://www.wowhead.com/wotlk/de/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Krebs' WHERE `locale` = 'deDE' AND `entry` = 6827;
-- OLD name : Dockmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Dockmeister der Defias' WHERE `locale` = 'deDE' AND `entry` = 6846;
-- OLD name : Leibwache
-- Source : https://www.wowhead.com/wotlk/de/npc=6866
UPDATE `creature_template_locale` SET `Name` = 'Leibwache der Defias' WHERE `locale` = 'deDE' AND `entry` = 6866;
-- OLD name : Dockarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Dockarbeiter der Defias' WHERE `locale` = 'deDE' AND `entry` = 6927;
-- OLD name : Wache des Schwarzfels
-- Source : https://www.wowhead.com/wotlk/de/npc=7013
UPDATE `creature_template_locale` SET `Name` = 'Amokläufer des Schwarzfels' WHERE `locale` = 'deDE' AND `entry` = 7013;
-- OLD name : Obsidianwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=7023
UPDATE `creature_template_locale` SET `Name` = 'Obsidianschildwache' WHERE `locale` = 'deDE' AND `entry` = 7023;
-- OLD name : Eisenwaldwanderer
-- Source : https://www.wowhead.com/wotlk/de/npc=7138
UPDATE `creature_template_locale` SET `Name` = 'Wanderer der Eisenstämme' WHERE `locale` = 'deDE' AND `entry` = 7138;
-- OLD name : Eisenwaldstampfer
-- Source : https://www.wowhead.com/wotlk/de/npc=7139
UPDATE `creature_template_locale` SET `Name` = 'Donnerstampfer der Eisenstämme' WHERE `locale` = 'deDE' AND `entry` = 7139;
-- OLD name : Siechender Treant
-- Source : https://www.wowhead.com/wotlk/de/npc=7144
UPDATE `creature_template_locale` SET `Name` = 'Welker Treant' WHERE `locale` = 'deDE' AND `entry` = 7144;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7174
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin' WHERE `locale` = 'deDE' AND `entry` = 7174;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7230
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin' WHERE `locale` = 'deDE' AND `entry` = 7230;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer' WHERE `locale` = 'deDE' AND `entry` = 7231;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7232
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer' WHERE `locale` = 'deDE' AND `entry` = 7232;
-- OLD name : Aufklärer der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=7307
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Venture Co.' WHERE `locale` = 'deDE' AND `entry` = 7307;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7311
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 7311;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7312
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 7312;
-- OLD name : Kakerlake von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Kakerlake' WHERE `locale` = 'deDE' AND `entry` = 7395;
-- OLD name : Junger Frostsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=7430
UPDATE `creature_template_locale` SET `Name` = 'Frostsäblerjunges' WHERE `locale` = 'deDE' AND `entry` = 7430;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7488
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 7488;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7525
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 7525;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7526
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 7526;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7528
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 7528;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/de/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'deDE','Waldkaninchen',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/de/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'deDE','Gefleckter Hase',NULL);
-- OLD name : Slims Testtodesritter
-- Source : https://www.wowhead.com/wotlk/de/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight' WHERE `locale` = 'deDE' AND `entry` = 7624;
-- OLD name : Leopard
-- Source : https://www.wowhead.com/wotlk/de/npc=7684
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Gelb)' WHERE `locale` = 'deDE' AND `entry` = 7684;
-- OLD name : Bengaltiger
-- Source : https://www.wowhead.com/wotlk/de/npc=7686
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Rot)' WHERE `locale` = 'deDE' AND `entry` = 7686;
-- OLD name : Gefleckter Nachtsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=7689
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Schwarz gepunktet)' WHERE `locale` = 'deDE' AND `entry` = 7689;
-- OLD name : Obsidianschwarzer Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7703
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Obsidianschwarz)' WHERE `locale` = 'deDE' AND `entry` = 7703;
-- OLD name : Scheckiger roter Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7704
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Purpurrot)' WHERE `locale` = 'deDE' AND `entry` = 7704;
-- OLD name : Elfenbeinfarbener Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7706
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Elfenbeinfarben)' WHERE `locale` = 'deDE' AND `entry` = 7706;
-- OLD name : Byula, subname : Ehemaliger Gastwirt
-- Source : https://www.wowhead.com/wotlk/de/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Gastwirt Byula',`Title` = 'Gastwirt' WHERE `locale` = 'deDE' AND `entry` = 7714;
-- OLD name : Hydromantin Velratha
-- Source : https://www.wowhead.com/wotlk/de/npc=7795
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörerin Velratha' WHERE `locale` = 'deDE' AND `entry` = 7795;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7866
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 7866;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7867
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 7867;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7868
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 7868;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7869
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 7869;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 7870;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 7871;
-- OLD subname : Reitlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Roboschreiterpilot' WHERE `locale` = 'deDE' AND `entry` = 7954;
-- OLD name : Kriegerheld von Camp Narache
-- Source : https://www.wowhead.com/wotlk/de/npc=7975
UPDATE `creature_template_locale` SET `Name` = 'Beschützer von Mulgore' WHERE `locale` = 'deDE' AND `entry` = 7975;
-- OLD name : Wache der Westfallbrigade, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/de/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Beschützer des Volks',`Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 8096;
-- OLD subname : Speis & Trank
-- Source : https://www.wowhead.com/wotlk/de/npc=8148
UPDATE `creature_template_locale` SET `Title` = 'Essen & Getränke' WHERE `locale` = 'deDE' AND `entry` = 8148;
-- OLD name : Glutschwinge
-- Source : https://www.wowhead.com/wotlk/de/npc=8207
UPDATE `creature_template_locale` SET `Name` = 'Großer Feuervogel' WHERE `locale` = 'deDE' AND `entry` = 8207;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=8306
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 8306;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=8360
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 8360;
-- OLD name : Hauptmann Vanessa Beltis
-- Source : https://www.wowhead.com/wotlk/de/npc=8380
UPDATE `creature_template_locale` SET `Name` = 'Kapitän Vanessa Beltis' WHERE `locale` = 'deDE' AND `entry` = 8380;
-- OLD name : Handwerksmeister Kovic
-- Source : https://www.wowhead.com/wotlk/de/npc=8444
UPDATE `creature_template_locale` SET `Name` = 'Handelsmeister Kovic' WHERE `locale` = 'deDE' AND `entry` = 8444;
-- OLD name : Kalaran Windklinge
-- Source : https://www.wowhead.com/wotlk/de/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Velarok Windklinge' WHERE `locale` = 'deDE' AND `entry` = 8479;
-- OLD name : Kalaran der Betrüger
-- Source : https://www.wowhead.com/wotlk/de/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Velarok der Betrüger' WHERE `locale` = 'deDE' AND `entry` = 8480;
-- OLD name : Todessängerin
-- Source : https://www.wowhead.com/wotlk/de/npc=8542
UPDATE `creature_template_locale` SET `Name` = 'Todessänger' WHERE `locale` = 'deDE' AND `entry` = 8542;
-- OLD name : Nekrolyt
-- Source : https://www.wowhead.com/wotlk/de/npc=8552
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth' WHERE `locale` = 'deDE' AND `entry` = 8552;
-- OLD name : Getriebener Waldmann
-- Source : https://www.wowhead.com/wotlk/de/npc=8563
UPDATE `creature_template_locale` SET `Name` = 'Waldhirte' WHERE `locale` = 'deDE' AND `entry` = 8563;
-- OLD name : Getriebener Waldläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=8564
UPDATE `creature_template_locale` SET `Name` = 'Waldläufer' WHERE `locale` = 'deDE' AND `entry` = 8564;
-- OLD name : Getriebener Pfadwanderer
-- Source : https://www.wowhead.com/wotlk/de/npc=8565
UPDATE `creature_template_locale` SET `Name` = 'Pfadwanderer' WHERE `locale` = 'deDE' AND `entry` = 8565;
-- OLD name : Aufklärer der Dunkeleisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=8566
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Dunkeleisenzwerge' WHERE `locale` = 'deDE' AND `entry` = 8566;
-- OLD name : Großer Seuchenhund
-- Source : https://www.wowhead.com/wotlk/de/npc=8599
UPDATE `creature_template_locale` SET `Name` = 'Seuchenmastiff' WHERE `locale` = 'deDE' AND `entry` = 8599;
-- OLD name : Sonnenläuferin Saern
-- Source : https://www.wowhead.com/wotlk/de/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Saern Stolzlauf' WHERE `locale` = 'deDE' AND `entry` = 8664;
-- OLD name : Folterer des Schattenhammers
-- Source : https://www.wowhead.com/wotlk/de/npc=8912
UPDATE `creature_template_locale` SET `Name` = 'Folterknecht des Schattenhammers' WHERE `locale` = 'deDE' AND `entry` = 8912;
-- OLD subname : Befrager des Schattenhammers
-- Source : https://www.wowhead.com/wotlk/de/npc=9018
UPDATE `creature_template_locale` SET `Title` = 'Befrager des Schattenhammerklans' WHERE `locale` = 'deDE' AND `entry` = 9018;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9116
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 9116;
-- OLD name : Wütender Wyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=9297
UPDATE `creature_template_locale` SET `Name` = 'Wütender Flügeldrache' WHERE `locale` = 'deDE' AND `entry` = 9297;
-- OLD name : Ausgegrabenes Fossil
-- Source : https://www.wowhead.com/wotlk/de/npc=9397
UPDATE `creature_template_locale` SET `Name` = 'Lebendiger Sturm' WHERE `locale` = 'deDE' AND `entry` = 9397;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9528
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 9528;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9529
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 9529;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=9566
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar' WHERE `locale` = 'deDE' AND `entry` = 9566;
-- OLD subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9578
UPDATE `creature_template_locale` SET `Title` = 'Talentmeisterin' WHERE `locale` = 'deDE' AND `entry` = 9578;
-- OLD name : Talentmeister von Darnassus, subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9579
UPDATE `creature_template_locale` SET `Name` = 'Talentmeisterin von Darnassus',`Title` = 'Talentmeisterin' WHERE `locale` = 'deDE' AND `entry` = 9579;
-- OLD subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9582
UPDATE `creature_template_locale` SET `Title` = 'Talentmeisterin' WHERE `locale` = 'deDE' AND `entry` = 9582;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=9584
UPDATE `creature_template_locale` SET `Title` = 'Schattengewebeschneidermeisterin' WHERE `locale` = 'deDE' AND `entry` = 9584;
-- OLD subname : Blutaxtlegion
-- Source : https://www.wowhead.com/wotlk/de/npc=9696
UPDATE `creature_template_locale` SET `Title` = 'Schmetterschildlegion' WHERE `locale` = 'deDE' AND `entry` = 9696;
-- OLD subname : Ehemaliger Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 9983;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=10046
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 10046;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=10053
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 10053;
-- OLD name : Leuchtend grüner Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=10178
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Leuchtendgrün)' WHERE `locale` = 'deDE' AND `entry` = 10178;
-- OLD name : Weißer Roboschreiter Mod. B
-- Source : https://www.wowhead.com/wotlk/de/npc=10179
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (schwarz)' WHERE `locale` = 'deDE' AND `entry` = 10179;
-- OLD subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10292
UPDATE `creature_template_locale` SET `Title` = 'Dolchlehrer' WHERE `locale` = 'deDE' AND `entry` = 10292;
-- OLD subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10294
UPDATE `creature_template_locale` SET `Title` = 'Faustwaffenlehrer' WHERE `locale` = 'deDE' AND `entry` = 10294;
-- OLD subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10297
UPDATE `creature_template_locale` SET `Title` = 'Bogenlehrer' WHERE `locale` = 'deDE' AND `entry` = 10297;
-- OLD name : Acride
-- Source : https://www.wowhead.com/wotlk/de/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Spitzel der Schmetterschilde' WHERE `locale` = 'deDE' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/de/npc=10301
UPDATE `creature_template_locale` SET `Title` = 'Forscherliga' WHERE `locale` = 'deDE' AND `entry` = 10301;
-- OLD name : Uralter Frostsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (weiß)' WHERE `locale` = 'deDE' AND `entry` = 10322;
-- OLD name : Urleopard
-- Source : https://www.wowhead.com/wotlk/de/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (getupft)' WHERE `locale` = 'deDE' AND `entry` = 10336;
-- OLD name : Lohfarbene Säblerkatze
-- Source : https://www.wowhead.com/wotlk/de/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (orange)' WHERE `locale` = 'deDE' AND `entry` = 10337;
-- OLD name : Goldfarbene Säblerkatze
-- Source : https://www.wowhead.com/wotlk/de/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (goldfarben)' WHERE `locale` = 'deDE' AND `entry` = 10338;
-- OLD name : Auferstandener Gardist
-- Source : https://www.wowhead.com/wotlk/de/npc=10418
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Gardist' WHERE `locale` = 'deDE' AND `entry` = 10418;
-- OLD name : Auferstandener Herbeizauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10419
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Herbeizauberer' WHERE `locale` = 'deDE' AND `entry` = 10419;
-- OLD name : Auferstandener Initiand
-- Source : https://www.wowhead.com/wotlk/de/npc=10420
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Initiand' WHERE `locale` = 'deDE' AND `entry` = 10420;
-- OLD name : Auferstandener Verteidiger
-- Source : https://www.wowhead.com/wotlk/de/npc=10421
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Verteidiger' WHERE `locale` = 'deDE' AND `entry` = 10421;
-- OLD name : Auferstandener Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10422
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Zauberer' WHERE `locale` = 'deDE' AND `entry` = 10422;
-- OLD name : Auferstandener Priester
-- Source : https://www.wowhead.com/wotlk/de/npc=10423
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Priester' WHERE `locale` = 'deDE' AND `entry` = 10423;
-- OLD name : Auferstandener Kavalier
-- Source : https://www.wowhead.com/wotlk/de/npc=10424
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Kavalier' WHERE `locale` = 'deDE' AND `entry` = 10424;
-- OLD name : Auferstandener Kampfmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=10425
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Kampfmagier' WHERE `locale` = 'deDE' AND `entry` = 10425;
-- OLD name : Auferstandener Inquisitor
-- Source : https://www.wowhead.com/wotlk/de/npc=10426
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Inquisitor' WHERE `locale` = 'deDE' AND `entry` = 10426;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10452
UPDATE `creature_template_locale` SET `Title` = 'Streitkolbenlehrer' WHERE `locale` = 'deDE' AND `entry` = 10452;
-- OLD subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10453
UPDATE `creature_template_locale` SET `Title` = 'Axtlehrer' WHERE `locale` = 'deDE' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10454
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer' WHERE `locale` = 'deDE' AND `entry` = 10454;
-- OLD name : Nekrolyt aus Scholomance
-- Source : https://www.wowhead.com/wotlk/de/npc=10476
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth aus Scholomance' WHERE `locale` = 'deDE' AND `entry` = 10476;
-- OLD name : Auferstandener Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=10484
UPDATE `creature_template_locale` SET `Name` = 'Auferstandener Schrecker' WHERE `locale` = 'deDE' AND `entry` = 10484;
-- OLD name : Auferstandener Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10493
UPDATE `creature_template_locale` SET `Name` = 'Auferstandener Zauberhexer' WHERE `locale` = 'deDE' AND `entry` = 10493;
-- OLD name : Verseuchter Schleim
-- Source : https://www.wowhead.com/wotlk/de/npc=10510
UPDATE `creature_template_locale` SET `Name` = 'Verseuchter Brühschleimer' WHERE `locale` = 'deDE' AND `entry` = 10510;
-- OLD name : Finkle Einhorn
-- Source : https://www.wowhead.com/wotlk/de/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Pip Flitzwitz' WHERE `locale` = 'deDE' AND `entry` = 10776;
-- OLD name : Instrukteur Galford
-- Source : https://www.wowhead.com/wotlk/de/npc=10811
UPDATE `creature_template_locale` SET `Name` = 'Archivar Galford' WHERE `locale` = 'deDE' AND `entry` = 10811;
-- OLD name : Todesjäger Falkenspeer
-- Source : https://www.wowhead.com/wotlk/de/npc=10824
UPDATE `creature_template_locale` SET `Name` = 'Waldläuferlord Falkenspeer' WHERE `locale` = 'deDE' AND `entry` = 10824;
-- OLD name : Lynnia Abbendis
-- Source : https://www.wowhead.com/wotlk/de/npc=10828
UPDATE `creature_template_locale` SET `Name` = 'Hochgeneral Abbendis' WHERE `locale` = 'deDE' AND `entry` = 10828;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10839
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 10839;
-- OLD name : Argentumoffizierin Reinherz, subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10840
UPDATE `creature_template_locale` SET `Name` = 'Argentumoffizier Reinherz',`Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 10840;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10857
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 10857;
-- OLD name : Wissenshüter Polkelt
-- Source : https://www.wowhead.com/wotlk/de/npc=10901
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Polkelt' WHERE `locale` = 'deDE' AND `entry` = 10901;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10920
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 10920;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10921
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 10921;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10922
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 10922;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10923
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 10923;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10924
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis' WHERE `locale` = 'deDE' AND `entry` = 10924;
-- OLD name : Jünger der Silbernen Hand
-- Source : https://www.wowhead.com/wotlk/de/npc=10949
UPDATE `creature_template_locale` SET `Name` = 'Silberhandjünger' WHERE `locale` = 'deDE' AND `entry` = 10949;
-- OLD name : Willey Hoffnungsbrecher
-- Source : https://www.wowhead.com/wotlk/de/npc=10997
UPDATE `creature_template_locale` SET `Name` = 'Kanonenmeister Willey' WHERE `locale` = 'deDE' AND `entry` = 10997;
-- OLD name : Kommandant Malor
-- Source : https://www.wowhead.com/wotlk/de/npc=11032
UPDATE `creature_template_locale` SET `Name` = 'Malor der Eifrige' WHERE `locale` = 'deDE' AND `entry` = 11032;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11034;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11036;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11039;
-- OLD name : Behüterin Braunell
-- Source : https://www.wowhead.com/wotlk/de/npc=11040
UPDATE `creature_template_locale` SET `Name` = 'Behüter Braunell' WHERE `locale` = 'deDE' AND `entry` = 11040;
-- OLD name : Auferstandener Mönch
-- Source : https://www.wowhead.com/wotlk/de/npc=11043
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Mönch' WHERE `locale` = 'deDE' AND `entry` = 11043;
-- OLD name : Auferstandener Scharfschütze
-- Source : https://www.wowhead.com/wotlk/de/npc=11054
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Scharfschütze' WHERE `locale` = 'deDE' AND `entry` = 11054;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/de/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'deDE' AND `entry` = 11058;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11063;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11102
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11102;
-- OLD name : Auferstandener Hammerschmied
-- Source : https://www.wowhead.com/wotlk/de/npc=11120
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Hammerschmied' WHERE `locale` = 'deDE' AND `entry` = 11120;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer' WHERE `locale` = 'deDE' AND `entry` = 11146;
-- OLD name : Lila Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Lila)' WHERE `locale` = 'deDE' AND `entry` = 11148;
-- OLD name : Rotblauer Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=11149
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Rot/Blau)' WHERE `locale` = 'deDE' AND `entry` = 11149;
-- OLD name : Eisblauer Roboschreiter Mod. A
-- Source : https://www.wowhead.com/wotlk/de/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Eisblau)' WHERE `locale` = 'deDE' AND `entry` = 11150;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied' WHERE `locale` = 'deDE' AND `entry` = 11177;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11178
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmied' WHERE `locale` = 'deDE' AND `entry` = 11178;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=11182
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 11182;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11194
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11194;
-- OLD name : Todesstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=11195
UPDATE `creature_template_locale` SET `Name` = 'Schwarzes Skelettschlachtross' WHERE `locale` = 'deDE' AND `entry` = 11195;
-- OLD name : Hochgeborener Beschwörer, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11466
UPDATE `creature_template_locale` SET `Name` = 'Hochgeborenenbeschwörer',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 11466;
-- OLD name : Versenger der Eldreth
-- Source : https://www.wowhead.com/wotlk/de/npc=11469
UPDATE `creature_template_locale` SET `Name` = 'Schnauber der Eldreth' WHERE `locale` = 'deDE' AND `entry` = 11469;
-- OLD subname : Gebieter der Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 11486;
-- OLD name : Skarr der Gebrochene
-- Source : https://www.wowhead.com/wotlk/de/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Skarr der Unbezwingbare' WHERE `locale` = 'deDE' AND `entry` = 11498;
-- OLD name : Rüstmeisterin Miranda Knackschloss, subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11536
UPDATE `creature_template_locale` SET `Name` = 'Rüstmeisterin Miranda Breechlock',`Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11536;
-- OLD name : Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11661
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppe' WHERE `locale` = 'deDE' AND `entry` = 11661;
-- OLD name : Priester der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11662
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenpriester' WHERE `locale` = 'deDE' AND `entry` = 11662;
-- OLD name : Heiler der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11663
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenheiler' WHERE `locale` = 'deDE' AND `entry` = 11663;
-- OLD name : Elite der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11664
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenelite' WHERE `locale` = 'deDE' AND `entry` = 11664;
-- OLD name : Kernhund
-- Source : https://www.wowhead.com/wotlk/de/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Uralter Kernhund' WHERE `locale` = 'deDE' AND `entry` = 11673;
-- OLD name : Holzarbeiter des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=11681
UPDATE `creature_template_locale` SET `Name` = 'Roder der Horde' WHERE `locale` = 'deDE' AND `entry` = 11681;
-- OLD name : Goblinroder
-- Source : https://www.wowhead.com/wotlk/de/npc=11684
UPDATE `creature_template_locale` SET `Name` = 'Schredder des Kriegshymnenklans' WHERE `locale` = 'deDE' AND `entry` = 11684;
-- OLD subname : Wintersäblerausbilderin
-- Source : https://www.wowhead.com/wotlk/de/npc=11696
UPDATE `creature_template_locale` SET `Title` = 'Wintersäblerausbilder' WHERE `locale` = 'deDE' AND `entry` = 11696;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=11703
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 11703;
-- OLD name : Zwielichtbewahrer Exeter, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11803
UPDATE `creature_template_locale` SET `Name` = 'Bewahrer des Schattenhammers Exeter',`Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11803;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11804
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11804;
-- OLD name : Scholli Klauengriff
-- Source : https://www.wowhead.com/wotlk/de/npc=11821
UPDATE `creature_template_locale` SET `Name` = 'Darn Klauengriff' WHERE `locale` = 'deDE' AND `entry` = 11821;
-- OLD name : Grundig Düsterwolke
-- Source : https://www.wowhead.com/wotlk/de/npc=11858
UPDATE `creature_template_locale` SET `Name` = 'Grundig Finsterwolke' WHERE `locale` = 'deDE' AND `entry` = 11858;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11880
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11880;
-- OLD name : Zwielichtgeofürst, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11881
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtgeolord',`Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11881;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11882
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11882;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11883
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 11883;
-- OLD name : Steinschlagfelsbewahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11915
UPDATE `creature_template_locale` SET `Name` = 'Felsbewahrer der Gogger' WHERE `locale` = 'deDE' AND `entry` = 11915;
-- OLD name : Steinschlaggeomant
-- Source : https://www.wowhead.com/wotlk/de/npc=11917
UPDATE `creature_template_locale` SET `Name` = 'Geomant der Gogger' WHERE `locale` = 'deDE' AND `entry` = 11917;
-- OLD name : Steinschlagsteinklopfer
-- Source : https://www.wowhead.com/wotlk/de/npc=11918
UPDATE `creature_template_locale` SET `Name` = 'Steinklopfer der Gogger' WHERE `locale` = 'deDE' AND `entry` = 11918;
-- OLD name : Alchemielehrer der Mondlichtung, subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=12020
UPDATE `creature_template_locale` SET `Name` = 'Alchimielehrer der Mondlichtung',`Title` = 'Alchimiefachmann' WHERE `locale` = 'deDE' AND `entry` = 12020;
-- OLD subname : Waffenschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=12024
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmied' WHERE `locale` = 'deDE' AND `entry` = 12024;
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=12029
UPDATE `creature_template_locale` SET `Title` = 'Bogenmacher' WHERE `locale` = 'deDE' AND `entry` = 12029;
-- OLD name : Grella Steinfaust
-- Source : https://www.wowhead.com/wotlk/de/npc=12036
UPDATE `creature_template_locale` SET `Name` = 'Gemischtwaren des Nistgipfels' WHERE `locale` = 'deDE' AND `entry` = 12036;
-- OLD name : Brannik Eisenbauch
-- Source : https://www.wowhead.com/wotlk/de/npc=12040
UPDATE `creature_template_locale` SET `Name` = 'Verkäufer für schwere Rüstungen des Nistgipfels' WHERE `locale` = 'deDE' AND `entry` = 12040;
-- OLD name : Schmiedekunstbedarf von Sonnenfels
-- Source : https://www.wowhead.com/wotlk/de/npc=12044
UPDATE `creature_template_locale` SET `Name` = 'Schmiedekunstgrundbedarf von Sonnenfels' WHERE `locale` = 'deDE' AND `entry` = 12044;
-- OLD name : Beschützer der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=12119
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenbeschützer' WHERE `locale` = 'deDE' AND `entry` = 12119;
-- OLD name : Wächter der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=12142
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenwächter' WHERE `locale` = 'deDE' AND `entry` = 12142;
-- OLD name : Graublauer Kodo
-- Source : https://www.wowhead.com/wotlk/de/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo (Graublau)' WHERE `locale` = 'deDE' AND `entry` = 12148;
-- OLD name : Grüner Kodo
-- Source : https://www.wowhead.com/wotlk/de/npc=12151
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo (Grün)' WHERE `locale` = 'deDE' AND `entry` = 12151;
-- OLD subname : Der Erste Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12240
UPDATE `creature_template_locale` SET `Title` = 'Der erste Khan' WHERE `locale` = 'deDE' AND `entry` = 12240;
-- OLD subname : Der Dritte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12241
UPDATE `creature_template_locale` SET `Title` = 'Der dritte Khan' WHERE `locale` = 'deDE' AND `entry` = 12241;
-- OLD subname : Der Vierte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12242
UPDATE `creature_template_locale` SET `Title` = 'Der vierte Khan' WHERE `locale` = 'deDE' AND `entry` = 12242;
-- OLD subname : Der Fünfte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12243
UPDATE `creature_template_locale` SET `Title` = 'Der fünfte Khan' WHERE `locale` = 'deDE' AND `entry` = 12243;
-- OLD name : Scheckiger scharlachroter Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12345
UPDATE `creature_template_locale` SET `Name` = 'Scheckiger roter Raptor' WHERE `locale` = 'deDE' AND `entry` = 12345;
-- OLD name : Smaragdgrüner Reitraptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12346
UPDATE `creature_template_locale` SET `Name` = 'Smaragdfarbener Raptor' WHERE `locale` = 'deDE' AND `entry` = 12346;
-- OLD name : Türkisfarbener Reitraptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12349
UPDATE `creature_template_locale` SET `Name` = 'Türkisfarbener Raptor' WHERE `locale` = 'deDE' AND `entry` = 12349;
-- OLD name : Großer übler Schleim
-- Source : https://www.wowhead.com/wotlk/de/npc=12387
UPDATE `creature_template_locale` SET `Name` = 'Großer böser Brühschleimer' WHERE `locale` = 'deDE' AND `entry` = 12387;
-- OLD name : Verdammniswachenkommandant
-- Source : https://www.wowhead.com/wotlk/de/npc=12396
UPDATE `creature_template_locale` SET `Name` = 'Kommandant der Verdammniswache' WHERE `locale` = 'deDE' AND `entry` = 12396;
-- OLD name : Hauptmann der Todeskrallen
-- Source : https://www.wowhead.com/wotlk/de/npc=12467
UPDATE `creature_template_locale` SET `Name` = 'Captain der Todeskrallen' WHERE `locale` = 'deDE' AND `entry` = 12467;
-- OLD subname : Windreitermeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=12616
UPDATE `creature_template_locale` SET `Title` = 'Windreitermeister' WHERE `locale` = 'deDE' AND `entry` = 12616;
-- OLD subname : Rüstmeister für Zubehör
-- Source : https://www.wowhead.com/wotlk/de/npc=12781
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Offizierszubehör' WHERE `locale` = 'deDE' AND `entry` = 12781;
-- OLD subname : Rüstmeisterin für Kriegsreittiere
-- Source : https://www.wowhead.com/wotlk/de/npc=12783
UPDATE `creature_template_locale` SET `Title` = 'Kriegsreittierverkäuferin' WHERE `locale` = 'deDE' AND `entry` = 12783;
-- OLD name : Häuptling Erdbinder
-- Source : https://www.wowhead.com/wotlk/de/npc=12791
UPDATE `creature_template_locale` SET `Name` = 'Häuptling Erdenbund' WHERE `locale` = 'deDE' AND `entry` = 12791;
-- OLD name : Grunzerin Bek'rah
-- Source : https://www.wowhead.com/wotlk/de/npc=12798
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Bek''rah' WHERE `locale` = 'deDE' AND `entry` = 12798;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Traumachirurg' WHERE `locale` = 'deDE' AND `entry` = 12939;
-- OLD name : Jagdhund der Gordok
-- Source : https://www.wowhead.com/wotlk/de/npc=13036
UPDATE `creature_template_locale` SET `Name` = 'Mastiff der Gordok' WHERE `locale` = 'deDE' AND `entry` = 13036;
-- OLD subname : Waffenmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeister' WHERE `locale` = 'deDE' AND `entry` = 13084;
-- OLD name : Schwadronskommandantin Guse
-- Source : https://www.wowhead.com/wotlk/de/npc=13179
UPDATE `creature_template_locale` SET `Name` = 'Schwadronskommandant Guse' WHERE `locale` = 'deDE' AND `entry` = 13179;
-- OLD name : Schwadronskommandantin Jeztor
-- Source : https://www.wowhead.com/wotlk/de/npc=13180
UPDATE `creature_template_locale` SET `Name` = 'Schwadronskommandant Jeztor' WHERE `locale` = 'deDE' AND `entry` = 13180;
-- OLD name : Kleiner Frosch
-- Source : https://www.wowhead.com/wotlk/de/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Frosch' WHERE `locale` = 'deDE' AND `entry` = 13321;
-- OLD name : Legionärsveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=13334
UPDATE `creature_template_locale` SET `Name` = 'Legionärveteran' WHERE `locale` = 'deDE' AND `entry` = 13334;
-- OLD name : Erzdruidin Renferal
-- Source : https://www.wowhead.com/wotlk/de/npc=13442
UPDATE `creature_template_locale` SET `Name` = 'Erzdruide Renferal' WHERE `locale` = 'deDE' AND `entry` = 13442;
-- OLD name : Stallmeister der Frostwölfe, subname : Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=13616
UPDATE `creature_template_locale` SET `Name` = 'Stallmeisterin der Frostwölfe',`Title` = 'Stallmeisterin' WHERE `locale` = 'deDE' AND `entry` = 13616;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=13656
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 13656;
-- OLD subname : Der Fünfte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13738
UPDATE `creature_template_locale` SET `Title` = 'Der fünfte Khan' WHERE `locale` = 'deDE' AND `entry` = 13738;
-- OLD subname : Der Vierte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13739
UPDATE `creature_template_locale` SET `Title` = 'Der vierte Khan' WHERE `locale` = 'deDE' AND `entry` = 13739;
-- OLD subname : Der Dritte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13740
UPDATE `creature_template_locale` SET `Title` = 'Der dritte Khan' WHERE `locale` = 'deDE' AND `entry` = 13740;
-- OLD subname : Der Zweite Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13741
UPDATE `creature_template_locale` SET `Title` = 'Der zweite Khan' WHERE `locale` = 'deDE' AND `entry` = 13741;
-- OLD subname : Der Erste Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13742
UPDATE `creature_template_locale` SET `Title` = 'Der erste Khan' WHERE `locale` = 'deDE' AND `entry` = 13742;
-- OLD name : Der Große Samras
-- Source : https://www.wowhead.com/wotlk/de/npc=14280
UPDATE `creature_template_locale` SET `Name` = 'Samras' WHERE `locale` = 'deDE' AND `entry` = 14280;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14358
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14358;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14364;
-- OLD name : Wissenshüter Lydros, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14368
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Lydros',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14368;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14369
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14369;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14371
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14371;
-- OLD name : Wissenshüter Javon, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14381
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Javon',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14381;
-- OLD name : Wissenshüterin Mykos, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14382
UPDATE `creature_template_locale` SET `Name` = 'Hüterin des Wissens Mykos',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14382;
-- OLD name : Wissenshüter Kildrath, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14383
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Kildrath',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 14383;
-- OLD name : Verdammniswachendiener
-- Source : https://www.wowhead.com/wotlk/de/npc=14385
UPDATE `creature_template_locale` SET `Name` = 'Diener der Verdammniswache' WHERE `locale` = 'deDE' AND `entry` = 14385;
-- OLD name : Hauptmann Wyrmak
-- Source : https://www.wowhead.com/wotlk/de/npc=14445
UPDATE `creature_template_locale` SET `Name` = 'Lordkommandant Wyrmak' WHERE `locale` = 'deDE' AND `entry` = 14445;
-- OLD name : Versklavter Verdammniswachenkommandant
-- Source : https://www.wowhead.com/wotlk/de/npc=14452
UPDATE `creature_template_locale` SET `Name` = 'Versklavter Kommandant der Verdammniswache' WHERE `locale` = 'deDE' AND `entry` = 14452;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=14479
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 14479;
-- OLD name : Schneller Dämmersäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=14557
UPDATE `creature_template_locale` SET `Name` = 'Schneller Dämmerungssäbler' WHERE `locale` = 'deDE' AND `entry` = 14557;
-- OLD name : Aufklärer der Thoriumbruderschaft
-- Source : https://www.wowhead.com/wotlk/de/npc=14622
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Thoriumbruderschaft' WHERE `locale` = 'deDE' AND `entry` = 14622;
-- OLD name : Aufklärerhauptmann Lolo Langhieb
-- Source : https://www.wowhead.com/wotlk/de/npc=14634
UPDATE `creature_template_locale` SET `Name` = 'Hauptmann des Ausgucks Lolo Langhieb' WHERE `locale` = 'deDE' AND `entry` = 14634;
-- OLD name : Verdorbenes Totem des heilendes Flusses V
-- Source : https://www.wowhead.com/wotlk/de/npc=14664
UPDATE `creature_template_locale` SET `Name` = 'Verderbtes Totem des heilenden Flusses V' WHERE `locale` = 'deDE' AND `entry` = 14664;
-- OLD name : Geflügelter Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=14714
UPDATE `creature_template_locale` SET `Name` = 'Geflügelter Horror' WHERE `locale` = 'deDE' AND `entry` = 14714;
-- OLD name : Feldmarschall Afrasiabi
-- Source : https://www.wowhead.com/wotlk/de/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Feldmarschall Steinsteg' WHERE `locale` = 'deDE' AND `entry` = 14721;
-- OLD subname : Stoffrüstmeisterin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=14723
UPDATE `creature_template_locale` SET `Title` = 'Stoffrüstmeister der Allianz' WHERE `locale` = 'deDE' AND `entry` = 14723;
-- OLD name : Entführer der Blutfratzen
-- Source : https://www.wowhead.com/wotlk/de/npc=14748
UPDATE `creature_template_locale` SET `Name` = 'Kidnapper der Blutfratzen' WHERE `locale` = 'deDE' AND `entry` = 14748;
-- OLD subname : Souvenir- & Spielzeuggewinne
-- Source : https://www.wowhead.com/wotlk/de/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Losverkauf des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 14828;
-- OLD subname : Der, der niemals vergisst!
-- Source : https://www.wowhead.com/wotlk/de/npc=14833
UPDATE `creature_template_locale` SET `Title` = 'Der der niemals vergisst!' WHERE `locale` = 'deDE' AND `entry` = 14833;
-- OLD subname : Getränkeverkäuferin des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Getränkeverkäufer des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 14844;
-- OLD subname : Lebensmittelverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=14845
UPDATE `creature_template_locale` SET `Title` = 'Lebensmittelverkäufer des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 14845;
-- OLD subname : Haus- & Reittiergewinne
-- Source : https://www.wowhead.com/wotlk/de/npc=14846
UPDATE `creature_template_locale` SET `Title` = 'Exotische Waren des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 14846;
-- OLD subname : Karten des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=14847
UPDATE `creature_template_locale` SET `Title` = 'Karten & Exotische Waren des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 14847;
-- OLD name : Blutdienerin von Kirtonos
-- Source : https://www.wowhead.com/wotlk/de/npc=14861
UPDATE `creature_template_locale` SET `Name` = 'Blutdiener von Kirtonos' WHERE `locale` = 'deDE' AND `entry` = 14861;
-- OLD name : Zwerg-Cockatrice
-- Source : https://www.wowhead.com/wotlk/de/npc=14869
UPDATE `creature_template_locale` SET `Name` = 'Zwerghühnchen' WHERE `locale` = 'deDE' AND `entry` = 14869;
-- OLD name : Gesandter der Entweihten
-- Source : https://www.wowhead.com/wotlk/de/npc=14990
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter der Entweihten' WHERE `locale` = 'deDE' AND `entry` = 14990;
-- OLD name : Gesandter des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=15105
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter des Kriegshymnenklans' WHERE `locale` = 'deDE' AND `entry` = 15105;
-- OLD name : Gesandter der Frostwölfe
-- Source : https://www.wowhead.com/wotlk/de/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter der Frostwölfe' WHERE `locale` = 'deDE' AND `entry` = 15106;
-- OLD name : Infanterist der Burg Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=15184
UPDATE `creature_template_locale` SET `Name` = 'Soldat der Burg Cenarius' WHERE `locale` = 'deDE' AND `entry` = 15184;
-- OLD name : Fürstin Sylvanas Windläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=15193
UPDATE `creature_template_locale` SET `Name` = 'Die Bansheekönigin' WHERE `locale` = 'deDE' AND `entry` = 15193;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15200
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15200;
-- OLD name : Zwielichtflammenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=15201
UPDATE `creature_template_locale` SET `Name` = 'Flammenhäscher des Schattenhammers' WHERE `locale` = 'deDE' AND `entry` = 15201;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15202
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15202;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15213
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15213;
-- OLD name : Trick - Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=15219
UPDATE `creature_template_locale` SET `Name` = 'Trick - Tierchen' WHERE `locale` = 'deDE' AND `entry` = 15219;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15279
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 15279;
-- OLD name : Pfadpirscher Kariel
-- Source : https://www.wowhead.com/wotlk/de/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Pfadpirscher Avokor' WHERE `locale` = 'deDE' AND `entry` = 15285;
-- OLD subname : Kanonierin des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=15303
UPDATE `creature_template_locale` SET `Title` = 'Kanonier des Dunkelmond-Jahrmarkts' WHERE `locale` = 'deDE' AND `entry` = 15303;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15308
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15308;
-- OLD name : Dunkelmond-Dampfpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=15328
UPDATE `creature_template_locale` SET `Name` = 'Dunkelmonddampfpanzer' WHERE `locale` = 'deDE' AND `entry` = 15328;
-- OLD name : RC Blimp <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'deDE' AND `entry` = 15349;
-- OLD name : RC Mörserpanzer, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'deDE' AND `entry` = 15364;
-- OLD name : Ayamiss die Jägerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15369
UPDATE `creature_template_locale` SET `Name` = 'Ayamiss der Jäger' WHERE `locale` = 'deDE' AND `entry` = 15369;
-- OLD name : Welt Juwelierskunstlehrer, subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15465
UPDATE `creature_template_locale` SET `Name` = 'Welt Juwelenschleiferlehrer',`Title` = 'Juwelenschleiferlehrerin' WHERE `locale` = 'deDE' AND `entry` = 15465;
-- OLD name : Skorpid
-- Source : https://www.wowhead.com/wotlk/de/npc=15476
UPDATE `creature_template_locale` SET `Name` = 'Skorpion' WHERE `locale` = 'deDE' AND `entry` = 15476;
-- OLD name : Totem der Feuernova
-- Source : https://www.wowhead.com/wotlk/de/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Totem der Feuernova VII' WHERE `locale` = 'deDE' AND `entry` = 15483;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15501
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin' WHERE `locale` = 'deDE' AND `entry` = 15501;
-- OLD name : Zwielichtmeister Xarvos, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15530
UPDATE `creature_template_locale` SET `Name` = 'Meister des Schattenhammers Xarvos',`Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15530;
-- OLD name : Steingardist Lehmhuf
-- Source : https://www.wowhead.com/wotlk/de/npc=15532
UPDATE `creature_template_locale` SET `Name` = 'Steinwache Lehmhuf' WHERE `locale` = 'deDE' AND `entry` = 15532;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15541
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15541;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15542
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 15542;
-- OLD name : Zwielichtverderber
-- Source : https://www.wowhead.com/wotlk/de/npc=15625
UPDATE `creature_template_locale` SET `Name` = 'Seelenverderber des Zwielichts' WHERE `locale` = 'deDE' AND `entry` = 15625;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/de/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'deDE','Blaue Qirajipanzerdrohne',NULL);
-- OLD subname : Träger des Gongs
-- Source : https://www.wowhead.com/wotlk/de/npc=15801
UPDATE `creature_template_locale` SET `Title` = 'TRÄGER DES GONGS' WHERE `locale` = 'deDE' AND `entry` = 15801;
-- OLD name : Infanterist der Macht von Kalimdor
-- Source : https://www.wowhead.com/wotlk/de/npc=15848
UPDATE `creature_template_locale` SET `Name` = 'Infanterie der Macht von Kalimdor' WHERE `locale` = 'deDE' AND `entry` = 15848;
-- OLD name : Hochlord Leoric von Zeldig (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=15868
UPDATE `creature_template_locale` SET `Name` = 'Hochlord Leoric Von Zeldig' WHERE `locale` = 'deDE' AND `entry` = 15868;
-- OLD name : Herzog August Feindhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15870
UPDATE `creature_template_locale` SET `Name` = 'Fürst August Feindhammer' WHERE `locale` = 'deDE' AND `entry` = 15870;
-- OLD subname : Sammlerin für Münzen der Urahnen
-- Source : https://www.wowhead.com/wotlk/de/npc=15909
UPDATE `creature_template_locale` SET `Title` = 'Sammler für Münzen der Urahnen' WHERE `locale` = 'deDE' AND `entry` = 15909;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 16032;
-- OLD name : Kreuzzugskommandant Korfax
-- Source : https://www.wowhead.com/wotlk/de/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Held des Lichts' WHERE `locale` = 'deDE' AND `entry` = 16112;
-- OLD name : Scharlachrote Kommandantin Marjhan
-- Source : https://www.wowhead.com/wotlk/de/npc=16114
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Kommandant Marjhan' WHERE `locale` = 'deDE' AND `entry` = 16114;
-- OLD name : Kreuzzugskommandant Eligor Morgenbringer
-- Source : https://www.wowhead.com/wotlk/de/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Eligor Morgenbringer' WHERE `locale` = 'deDE' AND `entry` = 16115;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=16185
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 16185;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16269
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 16269;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16277
UPDATE `creature_template_locale` SET `Title` = 'Kochkunstlehrer' WHERE `locale` = 'deDE' AND `entry` = 16277;
-- OLD subname : Schurkenlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Schurkenlehrer' WHERE `locale` = 'deDE' AND `entry` = 16279;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=16378
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 16378;
-- OLD name : Flickwerkschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=16382
UPDATE `creature_template_locale` SET `Name` = 'Flickwerkschrecker' WHERE `locale` = 'deDE' AND `entry` = 16382;
-- OLD name : Sie Nummer Eins, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16450
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Eins',`Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 16450;
-- OLD name : Sie Nummer Zwei, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16454
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Zwei',`Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 16454;
-- OLD name : Sie Nummer Drei, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16455
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Drei',`Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 16455;
-- OLD name : Konkubine
-- Source : https://www.wowhead.com/wotlk/de/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Eifrige Dienerin' WHERE `locale` = 'deDE' AND `entry` = 16461;
-- OLD name : Alchemiemeister
-- Source : https://www.wowhead.com/wotlk/de/npc=16487
UPDATE `creature_template_locale` SET `Name` = 'Alchimiemeister' WHERE `locale` = 'deDE' AND `entry` = 16487;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16500
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 16500;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16527
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 16527;
-- OLD name : Homunculus
-- Source : https://www.wowhead.com/wotlk/de/npc=16539
UPDATE `creature_template_locale` SET `Name` = 'Homonculus' WHERE `locale` = 'deDE' AND `entry` = 16539;
-- OLD name : Fungusbestie
-- Source : https://www.wowhead.com/wotlk/de/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)' WHERE `locale` = 'deDE' AND `entry` = 16565;
-- OLD name : Blutelfischer Pilger
-- Source : https://www.wowhead.com/wotlk/de/npc=16578
UPDATE `creature_template_locale` SET `Name` = 'Blutelfenpilger' WHERE `locale` = 'deDE' AND `entry` = 16578;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 16583;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16588
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 16588;
-- OLD name : Wolfsreiter von Thrallmar
-- Source : https://www.wowhead.com/wotlk/de/npc=16599
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter von Thrallmar' WHERE `locale` = 'deDE' AND `entry` = 16599;
-- OLD name : Bris Testcharakter
-- Source : https://www.wowhead.com/wotlk/de/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Brianna Schneider' WHERE `locale` = 'deDE' AND `entry` = 16605;
-- OLD subname : Waffenverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=16622
UPDATE `creature_template_locale` SET `Title` = 'Waffenhändler' WHERE `locale` = 'deDE' AND `entry` = 16622;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=16624
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 16624;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=16625
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 16625;
-- OLD subname : Hexenmeisterlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16647
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 16647;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16651
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 16651;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16652
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 16652;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16653
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 16653;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Köchin' WHERE `locale` = 'deDE' AND `entry` = 16676;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16702
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 16702;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16703
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 16703;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Köchin' WHERE `locale` = 'deDE' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=16720
UPDATE `creature_template_locale` SET `Title` = 'Dämonenausbilderin' WHERE `locale` = 'deDE' AND `entry` = 16720;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16727
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 16727;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16744
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 16744;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16749
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 16749;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=16750
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 16750;
-- OLD subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=16754
UPDATE `creature_template_locale` SET `Title` = 'Giftreagenzien' WHERE `locale` = 'deDE' AND `entry` = 16754;
-- OLD subname : Portallehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16755
UPDATE `creature_template_locale` SET `Title` = 'Portallehrer' WHERE `locale` = 'deDE' AND `entry` = 16755;
-- OLD subname : Angellehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16774
UPDATE `creature_template_locale` SET `Title` = 'Angellehrer' WHERE `locale` = 'deDE' AND `entry` = 16774;
-- OLD name : Blauer Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16783
UPDATE `creature_template_locale` SET `Name` = 'Blauer Seuchenbrühschleimer' WHERE `locale` = 'deDE' AND `entry` = 16783;
-- OLD name : Roter Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16784
UPDATE `creature_template_locale` SET `Name` = 'Roter Seuchenbrühschleimer' WHERE `locale` = 'deDE' AND `entry` = 16784;
-- OLD name : Grüner Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16785
UPDATE `creature_template_locale` SET `Name` = 'Grüner Seuchenbrühschleimer' WHERE `locale` = 'deDE' AND `entry` = 16785;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 16823;
-- OLD name : Winsum
-- Source : https://www.wowhead.com/wotlk/de/npc=16868
UPDATE `creature_template_locale` SET `Name` = 'Töter des Lachenden Schädels' WHERE `locale` = 'deDE' AND `entry` = 16868;
-- OLD name : Jising
-- Source : https://www.wowhead.com/wotlk/de/npc=16869
UPDATE `creature_template_locale` SET `Name` = 'Neophyt des Lachenden Schädels' WHERE `locale` = 'deDE' AND `entry` = 16869;
-- OLD name : Wolfsreiter der Knochenmalmer
-- Source : https://www.wowhead.com/wotlk/de/npc=16877
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter der Knochenmalmer' WHERE `locale` = 'deDE' AND `entry` = 16877;
-- OLD name : Sonnenwendhändlerkostüm der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=16986
UPDATE `creature_template_locale` SET `Name` = 'Sonnenwendhändlerkostüm der Alliant' WHERE `locale` = 'deDE' AND `entry` = 16986;
-- OLD name : Soldat des Schattenhammerklans
-- Source : https://www.wowhead.com/wotlk/de/npc=17022
UPDATE `creature_template_locale` SET `Name` = 'Soldat des Schattenhammers' WHERE `locale` = 'deDE' AND `entry` = 17022;
-- OLD name : Saphirons Flügelschlag
-- Source : https://www.wowhead.com/wotlk/de/npc=17025
UPDATE `creature_template_locale` SET `Name` = 'Saphirons Flügelstoß' WHERE `locale` = 'deDE' AND `entry` = 17025;
-- OLD name : Kleine Höllenfeuerkampfattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=17060
UPDATE `creature_template_locale` SET `Name` = 'kleine Höllenfeuerkamfattrappe' WHERE `locale` = 'deDE' AND `entry` = 17060;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=17105
UPDATE `creature_template_locale` SET `Title` = 'Magierlehrerin' WHERE `locale` = 'deDE' AND `entry` = 17105;
-- OLD name : Erdenruferin Ryga
-- Source : https://www.wowhead.com/wotlk/de/npc=17123
UPDATE `creature_template_locale` SET `Name` = 'Erdruferin Ryga' WHERE `locale` = 'deDE' AND `entry` = 17123;
-- OLD name : Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=17165
UPDATE `creature_template_locale` SET `Name` = '(NPC #17165)' WHERE `locale` = 'deDE' AND `entry` = 17165;
-- OLD name : Scharfseher Nobundo
-- Source : https://www.wowhead.com/wotlk/de/npc=17204
UPDATE `creature_template_locale` SET `Name` = 'Weissager Nobundo' WHERE `locale` = 'deDE' AND `entry` = 17204;
-- OLD subname : Spektralgreifenmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=17209
UPDATE `creature_template_locale` SET `Title` = 'Spektraler Greifenmeister' WHERE `locale` = 'deDE' AND `entry` = 17209;
-- OLD name : Slims untötbarer Testdummy
-- Source : https://www.wowhead.com/wotlk/de/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'deDE' AND `entry` = 17313;
-- OLD name : Zauberer des Schattenmondklans
-- Source : https://www.wowhead.com/wotlk/de/npc=17396
UPDATE `creature_template_locale` SET `Name` = 'Zauberhexer des Schattenmondklans' WHERE `locale` = 'deDE' AND `entry` = 17396;
-- OLD subname : Kriegerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17480
UPDATE `creature_template_locale` SET `Title` = 'Kriegerlehrer' WHERE `locale` = 'deDE' AND `entry` = 17480;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17481
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 17481;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=17485
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 17485;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=17512
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 17512;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17513
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 17513;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17514
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 17514;
-- OLD subname : Mistress of Breadcrumbs
-- Source : https://www.wowhead.com/wotlk/de/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17515, 'deDE',NULL,'Herrin der Brotkrumen');
-- OLD name : Testmonster
-- Source : https://www.wowhead.com/wotlk/de/npc=17582
UPDATE `creature_template_locale` SET `Name` = '(NPC #17582)' WHERE `locale` = 'deDE' AND `entry` = 17582;
-- OLD name : Junger Draenei
-- Source : https://www.wowhead.com/wotlk/de/npc=17587
UPDATE `creature_template_locale` SET `Name` = 'Draeneijüngling' WHERE `locale` = 'deDE' AND `entry` = 17587;
-- OLD name : Höllenfeuerwolfsreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=17593
UPDATE `creature_template_locale` SET `Name` = 'Höllenfeuerwolfreiter' WHERE `locale` = 'deDE' AND `entry` = 17593;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=17598
UPDATE `creature_template_locale` SET `Title` = 'Munitionsverkäufer' WHERE `locale` = 'deDE' AND `entry` = 17598;
-- OLD name : K. Lee Kleinkram, subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17634
UPDATE `creature_template_locale` SET `Name` = 'K. Lee Kleinfrey',`Title` = 'Meisteringenieurslehrerin' WHERE `locale` = 'deDE' AND `entry` = 17634;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17637
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 17637;
-- OLD name : Teufelsjägerdiener
-- Source : https://www.wowhead.com/wotlk/de/npc=17648
UPDATE `creature_template_locale` SET `Name` = 'Diener der Teufelsjäger' WHERE `locale` = 'deDE' AND `entry` = 17648;
-- OLD name : Schmiedin Frances
-- Source : https://www.wowhead.com/wotlk/de/npc=17655
UPDATE `creature_template_locale` SET `Name` = 'Schmied Frances' WHERE `locale` = 'deDE' AND `entry` = 17655;
-- OLD name : Jessera von Mac'Aree
-- Source : https://www.wowhead.com/wotlk/de/npc=17663
UPDATE `creature_template_locale` SET `Name` = 'Maatparm' WHERE `locale` = 'deDE' AND `entry` = 17663;
-- OLD name : Wyvernreiter von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=17720
UPDATE `creature_template_locale` SET `Name` = 'Flügeldrachenreiter von Orgrimmar' WHERE `locale` = 'deDE' AND `entry` = 17720;
-- OLD name : Tiefenseglerschwärmer
-- Source : https://www.wowhead.com/wotlk/de/npc=17736
UPDATE `creature_template_locale` SET `Name` = 'Tiefenschwärmer' WHERE `locale` = 'deDE' AND `entry` = 17736;
-- OLD name : Bergriese der Scherbenwelt, Zangarmarsch
-- Source : https://www.wowhead.com/wotlk/de/npc=17752
UPDATE `creature_template_locale` SET `Name` = 'Bergriese der Scherbenwelt, Zangarmarschen' WHERE `locale` = 'deDE' AND `entry` = 17752;
-- OLD name : Hydromantin Thespia
-- Source : https://www.wowhead.com/wotlk/de/npc=17797
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörerin Thespia' WHERE `locale` = 'deDE' AND `entry` = 17797;
-- OLD name : Wahnsinniger Worgen
-- Source : https://www.wowhead.com/wotlk/de/npc=17823
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Worgen' WHERE `locale` = 'deDE' AND `entry` = 17823;
-- OLD name : Kommandantin Sarannis
-- Source : https://www.wowhead.com/wotlk/de/npc=17976
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Sarannis' WHERE `locale` = 'deDE' AND `entry` = 17976;
-- OLD name : Wasserlementarwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=18001
UPDATE `creature_template_locale` SET `Name` = 'Wasserelementarwächter' WHERE `locale` = 'deDE' AND `entry` = 18001;
-- OLD name : Verdammniswachenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=18041
UPDATE `creature_template_locale` SET `Name` = 'Herr der Verdammniswache' WHERE `locale` = 'deDE' AND `entry` = 18041;
-- OLD name : Scharfseher Kurkush
-- Source : https://www.wowhead.com/wotlk/de/npc=18066
UPDATE `creature_template_locale` SET `Name` = 'Weissager Kurkush' WHERE `locale` = 'deDE' AND `entry` = 18066;
-- OLD name : Scharfseher Corhuk
-- Source : https://www.wowhead.com/wotlk/de/npc=18067
UPDATE `creature_template_locale` SET `Name` = 'Weissager Corhuk' WHERE `locale` = 'deDE' AND `entry` = 18067;
-- OLD name : Scharfseher Margadesh
-- Source : https://www.wowhead.com/wotlk/de/npc=18068
UPDATE `creature_template_locale` SET `Name` = 'Weissager Margadesh' WHERE `locale` = 'deDE' AND `entry` = 18068;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=18094
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle' WHERE `locale` = 'deDE' AND `entry` = 18094;
-- OLD name : Matschwirbler von Dolchfenn
-- Source : https://www.wowhead.com/wotlk/de/npc=18115
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler von Dolchfenn' WHERE `locale` = 'deDE' AND `entry` = 18115;
-- OLD name : Besudeltes Totem des Erdgriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=18176
UPDATE `creature_template_locale` SET `Name` = 'Besudeltes Totem des Erdengriffs' WHERE `locale` = 'deDE' AND `entry` = 18176;
-- OLD name : Kristine Denny
-- Source : https://www.wowhead.com/wotlk/de/npc=18190
UPDATE `creature_template_locale` SET `Name` = 'Krisine Denny' WHERE `locale` = 'deDE' AND `entry` = 18190;
-- OLD name : Verderber der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=18202
UPDATE `creature_template_locale` SET `Name` = 'Läuterer der Finsterblut' WHERE `locale` = 'deDE' AND `entry` = 18202;
-- OLD name : Scharfseher von Garadar
-- Source : https://www.wowhead.com/wotlk/de/npc=18228
UPDATE `creature_template_locale` SET `Name` = 'Ereignisaufseher von Garadar' WHERE `locale` = 'deDE' AND `entry` = 18228;
-- OLD name : Reitwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=18345
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache' WHERE `locale` = 'deDE' AND `entry` = 18345;
-- OLD name : Lohfarbener Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=18363
UPDATE `creature_template_locale` SET `Name` = 'Gelbbrauner Windreiter' WHERE `locale` = 'deDE' AND `entry` = 18363;
-- OLD name : Trainingsattrappe von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18504
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Silbermond' WHERE `locale` = 'deDE' AND `entry` = 18504;
-- OLD name : Weltenwanderer von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18507
UPDATE `creature_template_locale` SET `Name` = 'Silbermond Weltenwanderer' WHERE `locale` = 'deDE' AND `entry` = 18507;
-- OLD name : Orcischer Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=18598
UPDATE `creature_template_locale` SET `Name` = 'Orcgefangener' WHERE `locale` = 'deDE' AND `entry` = 18598;
-- OLD name : Ausbilderin Cel
-- Source : https://www.wowhead.com/wotlk/de/npc=18629
UPDATE `creature_template_locale` SET `Name` = 'Ausbilder Cel' WHERE `locale` = 'deDE' AND `entry` = 18629;
-- OLD name : Unterwerferin Vaz'shir
-- Source : https://www.wowhead.com/wotlk/de/npc=18660
UPDATE `creature_template_locale` SET `Name` = 'Unterwerfer Vaz''shir' WHERE `locale` = 'deDE' AND `entry` = 18660;
-- OLD name : Abgesandte des Echsenkessels
-- Source : https://www.wowhead.com/wotlk/de/npc=18681
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter des Echsenkessels' WHERE `locale` = 'deDE' AND `entry` = 18681;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18747;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18748
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18748;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 18749;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18751
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18751;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 18752;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 18753;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18754
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18754;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18755;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18771;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 18772;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18773;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 18774;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 18775;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18776;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 18777;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18779;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 18802;
-- OLD name : Botschafter Frasaboo der Tannenruhfeste
-- Source : https://www.wowhead.com/wotlk/de/npc=18803
UPDATE `creature_template_locale` SET `Name` = 'Botschafter Olorg der Tannenruhfeste' WHERE `locale` = 'deDE' AND `entry` = 18803;
-- OLD name : Leerenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=18871
UPDATE `creature_template_locale` SET `Name` = 'Lord der Leere' WHERE `locale` = 'deDE' AND `entry` = 18871;
-- OLD name : Wache des Sumpfrattenpostens
-- Source : https://www.wowhead.com/wotlk/de/npc=18910
UPDATE `creature_template_locale` SET `Name` = 'Sumpfrattenwache' WHERE `locale` = 'deDE' AND `entry` = 18910;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns' WHERE `locale` = 'deDE' AND `entry` = 18911;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18987
UPDATE `creature_template_locale` SET `Title` = 'Küchenchef' WHERE `locale` = 'deDE' AND `entry` = 18987;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18988
UPDATE `creature_template_locale` SET `Title` = 'Küchenchef' WHERE `locale` = 'deDE' AND `entry` = 18988;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Sanitäter' WHERE `locale` = 'deDE' AND `entry` = 18990;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Sanitäter' WHERE `locale` = 'deDE' AND `entry` = 18991;
-- OLD subname : Kochkunstlehrerin & -bedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Kochbedarf' WHERE `locale` = 'deDE' AND `entry` = 18993;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19052;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19063;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=19065
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 19065;
-- OLD name : Wolfsreiter von Garadar
-- Source : https://www.wowhead.com/wotlk/de/npc=19068
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter von Garadar' WHERE `locale` = 'deDE' AND `entry` = 19068;
-- OLD name : Wichtel der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=19136
UPDATE `creature_template_locale` SET `Name` = 'Flammenschürerwichtel' WHERE `locale` = 'deDE' AND `entry` = 19136;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=19145
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Pferde' WHERE `locale` = 'deDE' AND `entry` = 19145;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19180;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Heilerin' WHERE `locale` = 'deDE' AND `entry` = 19184;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 19185;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 19187;
-- OLD name : Leerenreisender
-- Source : https://www.wowhead.com/wotlk/de/npc=19226
UPDATE `creature_template_locale` SET `Name` = 'Leerreisender' WHERE `locale` = 'deDE' AND `entry` = 19226;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19252;
-- OLD name : Gepanzerter Wyvernzerstörer
-- Source : https://www.wowhead.com/wotlk/de/npc=19275
UPDATE `creature_template_locale` SET `Name` = 'Gepanzerter Flügeldrachenzerstörer' WHERE `locale` = 'deDE' AND `entry` = 19275;
-- OLD name : Unteroffizierin Altumus
-- Source : https://www.wowhead.com/wotlk/de/npc=19309
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Altumus' WHERE `locale` = 'deDE' AND `entry` = 19309;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/de/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'deDE','Barnu Schmetterfels','Stallmeister');
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19341;
-- OLD subname : Schusswaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=19351
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition' WHERE `locale` = 'deDE' AND `entry` = 19351;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Köchin' WHERE `locale` = 'deDE' AND `entry` = 19369;
-- OLD name : Nekrolyt des Blutenden Auges
-- Source : https://www.wowhead.com/wotlk/de/npc=19422
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth des Blutenden Auges' WHERE `locale` = 'deDE' AND `entry` = 19422;
-- OLD subname : Wurfwaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Wurfwaffen und Munition' WHERE `locale` = 'deDE' AND `entry` = 19473;
-- OLD name : Welt Ausbilder für fliegende Reittiere
-- Source : https://www.wowhead.com/wotlk/de/npc=19490
UPDATE `creature_template_locale` SET `Name` = 'Welt Ausblider für fliegende Reittiere' WHERE `locale` = 'deDE' AND `entry` = 19490;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=19491
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrer' WHERE `locale` = 'deDE' AND `entry` = 19491;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=19492
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrer' WHERE `locale` = 'deDE' AND `entry` = 19492;
-- OLD name : Agent des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=19501
UPDATE `creature_template_locale` SET `Name` = 'Agent des unteren Viertels' WHERE `locale` = 'deDE' AND `entry` = 19501;
-- OLD name : Heiler des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=19502
UPDATE `creature_template_locale` SET `Name` = 'Heiler des unteren Viertels' WHERE `locale` = 'deDE' AND `entry` = 19502;
-- OLD subname : Rüstungsschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=19517
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied' WHERE `locale` = 'deDE' AND `entry` = 19517;
-- OLD subname : Edelsteine & Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=19538
UPDATE `creature_template_locale` SET `Title` = 'Edelsteine & Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 19538;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19539;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19540;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 19576;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=19774
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 19774;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19775
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin' WHERE `locale` = 'deDE' AND `entry` = 19775;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=19777
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling' WHERE `locale` = 'deDE' AND `entry` = 19777;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19778
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin' WHERE `locale` = 'deDE' AND `entry` = 19778;
-- OLD name : Bild von Kommandantin Sarannis
-- Source : https://www.wowhead.com/wotlk/de/npc=19938
UPDATE `creature_template_locale` SET `Name` = 'Bild von Kommandant Sarannis' WHERE `locale` = 'deDE' AND `entry` = 19938;
-- OLD name : Astromantenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=20046
UPDATE `creature_template_locale` SET `Name` = 'Astromantenlord' WHERE `locale` = 'deDE' AND `entry` = 20046;
-- OLD name : Versuchsobjekt: Wachposten von Lodaeron
-- Source : https://www.wowhead.com/wotlk/de/npc=20053
UPDATE `creature_template_locale` SET `Name` = 'Versuchsobjekt: Wachposten von Lordaeron' WHERE `locale` = 'deDE' AND `entry` = 20053;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer' WHERE `locale` = 'deDE' AND `entry` = 20124;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin' WHERE `locale` = 'deDE' AND `entry` = 20125;
-- OLD name : Blutdürstiger Marschenfang
-- Source : https://www.wowhead.com/wotlk/de/npc=20196
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Marschenfänger' WHERE `locale` = 'deDE' AND `entry` = 20196;
-- OLD subname : Überholte Arenarüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Brutaler Arenaverkäufer' WHERE `locale` = 'deDE' AND `entry` = 20278;
-- OLD name : Käpt'n Sanders
-- Source : https://www.wowhead.com/wotlk/de/npc=20351
UPDATE `creature_template_locale` SET `Name` = 'Kapitän Sanders' WHERE `locale` = 'deDE' AND `entry` = 20351;
-- OLD name : Eingefangenes Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=20396
UPDATE `creature_template_locale` SET `Name` = 'Gefangenes Geschöpf' WHERE `locale` = 'deDE' AND `entry` = 20396;
-- OLD name : Wiedererwecktes Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=20398
UPDATE `creature_template_locale` SET `Name` = 'Wiedererwecktes Geschöpf' WHERE `locale` = 'deDE' AND `entry` = 20398;
-- OLD name : Scharfseherin Umbrua
-- Source : https://www.wowhead.com/wotlk/de/npc=20407
UPDATE `creature_template_locale` SET `Name` = 'Weissagerin Umbrua' WHERE `locale` = 'deDE' AND `entry` = 20407;
-- OLD name : Reitwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=20413
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache' WHERE `locale` = 'deDE' AND `entry` = 20413;
-- OLD name : Reitwyvern, gepanzert
-- Source : https://www.wowhead.com/wotlk/de/npc=20414
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache, gepanzert' WHERE `locale` = 'deDE' AND `entry` = 20414;
-- OLD name : Bürgerin des Hügellands
-- Source : https://www.wowhead.com/wotlk/de/npc=20429
UPDATE `creature_template_locale` SET `Name` = 'Bürger des Hügellands' WHERE `locale` = 'deDE' AND `entry` = 20429;
-- OLD name : Bürgerin des Hügellands
-- Source : https://www.wowhead.com/wotlk/de/npc=20430
UPDATE `creature_template_locale` SET `Name` = 'Bürger des Hügellands' WHERE `locale` = 'deDE' AND `entry` = 20430;
-- OLD name : Braunes Kaninchen
-- Source : https://www.wowhead.com/wotlk/de/npc=20472
UPDATE `creature_template_locale` SET `Name` = 'Brauner Hase' WHERE `locale` = 'deDE' AND `entry` = 20472;
-- OLD name : Lohfarbener Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=20488
UPDATE `creature_template_locale` SET `Name` = 'Gelbbrauner Windreiter' WHERE `locale` = 'deDE' AND `entry` = 20488;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer' WHERE `locale` = 'deDE' AND `entry` = 20500;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 20511;
-- OLD name : Aragas Junges
-- Source : https://www.wowhead.com/wotlk/de/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Dunkeltatzenjunges' WHERE `locale` = 'deDE' AND `entry` = 20615;
-- OLD name : Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=20713
UPDATE `creature_template_locale` SET `Name` = 'Siechdrache' WHERE `locale` = 'deDE' AND `entry` = 20713;
-- OLD name : Rek'tor
-- Source : https://www.wowhead.com/wotlk/de/npc=20716
UPDATE `creature_template_locale` SET `Name` = 'Scherbenweltraptor, Schwarz' WHERE `locale` = 'deDE' AND `entry` = 20716;
-- OLD name : Erstarrter Leerenschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=20779
UPDATE `creature_template_locale` SET `Name` = 'Erstarrter Schrecken der Leere' WHERE `locale` = 'deDE' AND `entry` = 20779;
-- OLD name : Akkiris-Blitzrufer
-- Source : https://www.wowhead.com/wotlk/de/npc=20908
UPDATE `creature_template_locale` SET `Name` = 'Akkiris Blitzrufer' WHERE `locale` = 'deDE' AND `entry` = 20908;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior' WHERE `locale` = 'deDE' AND `entry` = 21003;
-- OLD name : Verteidiger des Lebenden Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21072
UPDATE `creature_template_locale` SET `Name` = 'Verteidiger des lebenden Hains' WHERE `locale` = 'deDE' AND `entry` = 21072;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 21087;
-- OLD name : Wyvernreiter der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=21153
UPDATE `creature_template_locale` SET `Name` = 'Flügeldrachenreiter der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 21153;
-- OLD name : Gepanzerter Reitwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=21154
UPDATE `creature_template_locale` SET `Name` = 'Gepanzerter Reitflügeldrache der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 21154;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 21209;
-- OLD name : Hydromant der Gezeitenwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=21228
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörer der Gezeitenwandler' WHERE `locale` = 'deDE' AND `entry` = 21228;
-- OLD name : Sickernder Schlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=21264
UPDATE `creature_template_locale` SET `Name` = 'Sickernder Brühschlammer' WHERE `locale` = 'deDE' AND `entry` = 21264;
-- OLD name : Gesandter Icarius
-- Source : https://www.wowhead.com/wotlk/de/npc=21409
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Icarius' WHERE `locale` = 'deDE' AND `entry` = 21409;
-- OLD name : Tempixx Finagler
-- Source : https://www.wowhead.com/wotlk/de/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'deDE','Tempixx Feinagler',NULL);
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 21488;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/de/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21634, 'deDE','Waldschreiter',NULL);
-- OLD subname : Reagenzien & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=21642
UPDATE `creature_template_locale` SET `Title` = 'Reagenzien & Giftreagenzien' WHERE `locale` = 'deDE' AND `entry` = 21642;
-- OLD subname : Rüstmeister des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21655
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister des unteren Viertels' WHERE `locale` = 'deDE' AND `entry` = 21655;
-- OLD name : Orcnekrolyt
-- Source : https://www.wowhead.com/wotlk/de/npc=21747
UPDATE `creature_template_locale` SET `Name` = 'Orcnekrolyth' WHERE `locale` = 'deDE' AND `entry` = 21747;
-- OLD name : Sturm der Leere des Singenden Bergrückens (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21798
UPDATE `creature_template_locale` SET `Name` = 'Sturm der Leere des singenden Bergrückens' WHERE `locale` = 'deDE' AND `entry` = 21798;
-- OLD name : Massive Zephyriumladung
-- Source : https://www.wowhead.com/wotlk/de/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]' WHERE `locale` = 'deDE' AND `entry` = 21848;
-- OLD name : Gesandter vom Auge des Sturms
-- Source : https://www.wowhead.com/wotlk/de/npc=22015
UPDATE `creature_template_locale` SET `Name` = 'Entsandter vom Auge des Sturms' WHERE `locale` = 'deDE' AND `entry` = 22015;
-- OLD name : Arenawerber
-- Source : https://www.wowhead.com/wotlk/de/npc=22101
UPDATE `creature_template_locale` SET `Name` = 'Arenapromoter' WHERE `locale` = 'deDE' AND `entry` = 22101;
-- OLD name : Feuriger Brocken
-- Source : https://www.wowhead.com/wotlk/de/npc=22161
UPDATE `creature_template_locale` SET `Name` = 'Feuriger Felsen' WHERE `locale` = 'deDE' AND `entry` = 22161;
-- OLD subname : Spezialistin für Mondstoffschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Mondstoffspezialistin' WHERE `locale` = 'deDE' AND `entry` = 22208;
-- OLD subname : Spezialist für Schattenzwirnschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Schattenzwirnspezialist' WHERE `locale` = 'deDE' AND `entry` = 22212;
-- OLD subname : Spezialistin für Zauberfeuerschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Zauberfeuerspezialistin' WHERE `locale` = 'deDE' AND `entry` = 22213;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22247
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 22247;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22248
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 22248;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22249
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola' WHERE `locale` = 'deDE' AND `entry` = 22249;
-- OLD name : Schildwache der Thronwache
-- Source : https://www.wowhead.com/wotlk/de/npc=22301
UPDATE `creature_template_locale` SET `Name` = 'Späher der Thronwache' WHERE `locale` = 'deDE' AND `entry` = 22301;
-- OLD name : Herz der Bebenden Erde
-- Source : https://www.wowhead.com/wotlk/de/npc=22313
UPDATE `creature_template_locale` SET `Name` = 'Rumpelndes Erdherz' WHERE `locale` = 'deDE' AND `entry` = 22313;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22423
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22423;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22425
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22425;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22426
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22426;
-- OLD name : Urtum des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22478
UPDATE `creature_template_locale` SET `Name` = 'Urtum des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22478;
-- OLD subname : Forscherliga
-- Source : https://www.wowhead.com/wotlk/de/npc=22481
UPDATE `creature_template_locale` SET `Title` = 'Expeditionsleiter' WHERE `locale` = 'deDE' AND `entry` = 22481;
-- OLD name : Gorgolon der Allsehende
-- Source : https://www.wowhead.com/wotlk/de/npc=22827
UPDATE `creature_template_locale` SET `Name` = 'Gorgolon der Allessehende' WHERE `locale` = 'deDE' AND `entry` = 22827;
-- OLD name : Tempelkonkubine
-- Source : https://www.wowhead.com/wotlk/de/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Tempelakolyth' WHERE `locale` = 'deDE' AND `entry` = 22939;
-- OLD name : Bezaubernde Kurtisane
-- Source : https://www.wowhead.com/wotlk/de/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Bezaubernder Besucher' WHERE `locale` = 'deDE' AND `entry` = 22955;
-- OLD name : Schwester der Schmerzen
-- Source : https://www.wowhead.com/wotlk/de/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Priesterin der Qual' WHERE `locale` = 'deDE' AND `entry` = 22956;
-- OLD name : Priesterin des Deliriums
-- Source : https://www.wowhead.com/wotlk/de/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Herrin des Deliriums' WHERE `locale` = 'deDE' AND `entry` = 22957;
-- OLD name : Verzauberter Aufseher
-- Source : https://www.wowhead.com/wotlk/de/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Unermüdlicher Gastgeber' WHERE `locale` = 'deDE' AND `entry` = 22959;
-- OLD name : Priesterin der Lust
-- Source : https://www.wowhead.com/wotlk/de/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Herrin des Leidens' WHERE `locale` = 'deDE' AND `entry` = 22962;
-- OLD name : Schwester der Freuden
-- Source : https://www.wowhead.com/wotlk/de/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Priesterin der Wonne' WHERE `locale` = 'deDE' AND `entry` = 22964;
-- OLD name : Versklavter Diener
-- Source : https://www.wowhead.com/wotlk/de/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Ergebener Diener' WHERE `locale` = 'deDE' AND `entry` = 22965;
-- OLD name : Inselelekk
-- Source : https://www.wowhead.com/wotlk/de/npc=23013
UPDATE `creature_template_locale` SET `Name` = '[Designer Island Elekk]' WHERE `locale` = 'deDE' AND `entry` = 23013;
-- OLD name : Inselsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=23014
UPDATE `creature_template_locale` SET `Name` = '[Designer Island Sabercat]' WHERE `locale` = 'deDE' AND `entry` = 23014;
-- OLD name : TEST Iceberg
-- Source : https://www.wowhead.com/wotlk/de/npc=23041
UPDATE `creature_template_locale` SET `Name` = '[TEST Iceberg]' WHERE `locale` = 'deDE' AND `entry` = 23041;
-- OLD name : Zerrütter der Teufelwache
-- Source : https://www.wowhead.com/wotlk/de/npc=23055
UPDATE `creature_template_locale` SET `Name` = 'Zerrütter der Teufelswache' WHERE `locale` = 'deDE' AND `entry` = 23055;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=23103
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 23103;
-- OLD name : Verdammniswachenbestrafer
-- Source : https://www.wowhead.com/wotlk/de/npc=23113
UPDATE `creature_template_locale` SET `Name` = 'Bestrafer der Verdammniswache' WHERE `locale` = 'deDE' AND `entry` = 23113;
-- OLD name : Dunstschemen eines Gronns
-- Source : https://www.wowhead.com/wotlk/de/npc=23121
UPDATE `creature_template_locale` SET `Name` = 'Dunstschemen der Gronn' WHERE `locale` = 'deDE' AND `entry` = 23121;
-- OLD name : Scharfseher Javad
-- Source : https://www.wowhead.com/wotlk/de/npc=23127
UPDATE `creature_template_locale` SET `Name` = 'Weissager Javad' WHERE `locale` = 'deDE' AND `entry` = 23127;
-- OLD name : Manaschuldensklave
-- Source : https://www.wowhead.com/wotlk/de/npc=23154
UPDATE `creature_template_locale` SET `Name` = 'Manasüchtiger Sklave' WHERE `locale` = 'deDE' AND `entry` = 23154;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=23177
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle' WHERE `locale` = 'deDE' AND `entry` = 23177;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=23178
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle' WHERE `locale` = 'deDE' AND `entry` = 23178;
-- OLD name : Schwarzdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=23190
UPDATE `creature_template_locale` SET `Name` = 'Schwarzer Drache' WHERE `locale` = 'deDE' AND `entry` = 23190;
-- OLD name : Assassine der Shivarra
-- Source : https://www.wowhead.com/wotlk/de/npc=23220
UPDATE `creature_template_locale` SET `Name` = 'Assassine der Shivan' WHERE `locale` = 'deDE' AND `entry` = 23220;
-- OLD name : Wahnsinniger Vorarbeiter der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=23305
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Großknecht der Finsterblut' WHERE `locale` = 'deDE' AND `entry` = 23305;
-- OLD name : Wahnsinniger Minenarbeiter der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=23324
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Minenarbeiter der Finsterblut' WHERE `locale` = 'deDE' AND `entry` = 23324;
-- OLD name : Rächer von Bash'ir
-- Source : https://www.wowhead.com/wotlk/de/npc=23332
UPDATE `creature_template_locale` SET `Name` = 'Rechnungsführer von Bash''ir' WHERE `locale` = 'deDE' AND `entry` = 23332;
-- OLD name : Schwarzdrachenwelpe
-- Source : https://www.wowhead.com/wotlk/de/npc=23364
UPDATE `creature_template_locale` SET `Name` = 'Schwarzer Drachenwelpe' WHERE `locale` = 'deDE' AND `entry` = 23364;
-- OLD subname : Klassische Ketten- & Plattenrüstungen der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=23396
UPDATE `creature_template_locale` SET `Title` = 'Arenaverkäufer' WHERE `locale` = 'deDE' AND `entry` = 23396;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=23405
UPDATE `creature_template_locale` SET `Title` = 'PTR-Verbrauchsgüter' WHERE `locale` = 'deDE' AND `entry` = 23405;
-- OLD name : Stellvertreter der Gordunni
-- Source : https://www.wowhead.com/wotlk/de/npc=23450
UPDATE `creature_template_locale` SET `Name` = 'Fernmelder der Gordunni' WHERE `locale` = 'deDE' AND `entry` = 23450;
-- OLD name : Nordendyeti (blau)
-- Source : https://www.wowhead.com/wotlk/de/npc=23513
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Blue)]' WHERE `locale` = 'deDE' AND `entry` = 23513;
-- OLD name : Nordendyeti (braun)
-- Source : https://www.wowhead.com/wotlk/de/npc=23514
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Brown)]' WHERE `locale` = 'deDE' AND `entry` = 23514;
-- OLD name : Nordendyeti (gelb)
-- Source : https://www.wowhead.com/wotlk/de/npc=23516
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (Yellow)]' WHERE `locale` = 'deDE' AND `entry` = 23516;
-- OLD name : Nordendyeti (weiß)
-- Source : https://www.wowhead.com/wotlk/de/npc=23517
UPDATE `creature_template_locale` SET `Name` = '[Northrend Yeti (White)]' WHERE `locale` = 'deDE' AND `entry` = 23517;
-- OLD name : Taurenkanu
-- Source : https://www.wowhead.com/wotlk/de/npc=23518
UPDATE `creature_template_locale` SET `Name` = '[Tauren Canoe (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 23518;
-- OLD name : Jimmy Zweikanu
-- Source : https://www.wowhead.com/wotlk/de/npc=23520
UPDATE `creature_template_locale` SET `Name` = '[Jimmy Two-Canoes]' WHERE `locale` = 'deDE' AND `entry` = 23520;
-- OLD name : Roter Nordenddrache
-- Source : https://www.wowhead.com/wotlk/de/npc=23538
UPDATE `creature_template_locale` SET `Name` = '[Northrend Red Dragon]' WHERE `locale` = 'deDE' AND `entry` = 23538;
-- OLD name : Roter Nordendgroßdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=23539
UPDATE `creature_template_locale` SET `Name` = '[Northrend Red Drake]' WHERE `locale` = 'deDE' AND `entry` = 23539;
-- OLD name : Vrykul (Northrend Size Model)
-- Source : https://www.wowhead.com/wotlk/de/npc=23553
UPDATE `creature_template_locale` SET `Name` = '[Vrykul (Northrend Size Model)]' WHERE `locale` = 'deDE' AND `entry` = 23553;
-- OLD name : Protodrachenreittier der Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=23556
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount]' WHERE `locale` = 'deDE' AND `entry` = 23556;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/de/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Winterhäldler' WHERE `locale` = 'deDE' AND `entry` = 23559;
-- OLD name : Braufestwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=23588
UPDATE `creature_template_locale` SET `Name` = 'Widder des Braufests' WHERE `locale` = 'deDE' AND `entry` = 23588;
-- OLD name : Stammesangehöriger der Langhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=23639
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Tribesman]' WHERE `locale` = 'deDE' AND `entry` = 23639;
-- OLD name : Harpunierer der Langhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=23640
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Harpooner]' WHERE `locale` = 'deDE' AND `entry` = 23640;
-- OLD name : Meeresrufer der Langhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=23641
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Sea-caller]' WHERE `locale` = 'deDE' AND `entry` = 23641;
-- OLD name : Wegfinder der Langhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=23642
UPDATE `creature_template_locale` SET `Name` = '[Longtusk Wayfinder]' WHERE `locale` = 'deDE' AND `entry` = 23642;
-- OLD name : Nordmeerschmuggler
-- Source : https://www.wowhead.com/wotlk/de/npc=23646
UPDATE `creature_template_locale` SET `Name` = '[Northsea Smuggler]' WHERE `locale` = 'deDE' AND `entry` = 23646;
-- OLD name : Nordmeerbrigant
-- Source : https://www.wowhead.com/wotlk/de/npc=23647
UPDATE `creature_template_locale` SET `Name` = '[Northsea Brigand]' WHERE `locale` = 'deDE' AND `entry` = 23647;
-- OLD name : Nordmeerräuber
-- Source : https://www.wowhead.com/wotlk/de/npc=23648
UPDATE `creature_template_locale` SET `Name` = '[Northsea Raider]' WHERE `locale` = 'deDE' AND `entry` = 23648;
-- OLD name : Nordmeerschwadroneur
-- Source : https://www.wowhead.com/wotlk/de/npc=23649
UPDATE `creature_template_locale` SET `Name` = '[Northsea Swashbuckler]' WHERE `locale` = 'deDE' AND `entry` = 23649;
-- OLD name : Nordmeerpirat
-- Source : https://www.wowhead.com/wotlk/de/npc=23650
UPDATE `creature_template_locale` SET `Name` = '[Northsea Pirate]' WHERE `locale` = 'deDE' AND `entry` = 23650;
-- OLD name : Ältester der Drachenschinder
-- Source : https://www.wowhead.com/wotlk/de/npc=23659
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Elder]' WHERE `locale` = 'deDE' AND `entry` = 23659;
-- OLD name : Zottelfelleber
-- Source : https://www.wowhead.com/wotlk/de/npc=23692
UPDATE `creature_template_locale` SET `Name` = '[Shaghide Boar]' WHERE `locale` = 'deDE' AND `entry` = 23692;
-- OLD name : Tuskarr (Northrend Size Model)
-- Source : https://www.wowhead.com/wotlk/de/npc=23695
UPDATE `creature_template_locale` SET `Name` = '[Tuskarr (Northrend Size Model)]' WHERE `locale` = 'deDE' AND `entry` = 23695;
-- OLD name : Festagsfass der Gerstenbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23700
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gerstenbräus' WHERE `locale` = 'deDE' AND `entry` = 23700;
-- OLD name : Festagsfass der Donnerbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23702
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Donnerbräus' WHERE `locale` = 'deDE' AND `entry` = 23702;
-- OLD name : Festagsfass der Gordok
-- Source : https://www.wowhead.com/wotlk/de/npc=23706
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gordok' WHERE `locale` = 'deDE' AND `entry` = 23706;
-- OLD name : Claytons Testkreatur, subname : Geprüfte Qualität
-- Source : https://www.wowhead.com/wotlk/de/npc=23715
UPDATE `creature_template_locale` SET `Name` = '[Clayton''s Test Creature]',`Title` = '[Quality Assured]' WHERE `locale` = 'deDE' AND `entry` = 23715;
-- OLD name : Steinlord
-- Source : https://www.wowhead.com/wotlk/de/npc=23726
UPDATE `creature_template_locale` SET `Name` = '[Stone Lord]' WHERE `locale` = 'deDE' AND `entry` = 23726;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe' WHERE `locale` = 'deDE' AND `entry` = 23734;
-- OLD name : Eishöhlenyeti
-- Source : https://www.wowhead.com/wotlk/de/npc=23743
UPDATE `creature_template_locale` SET `Name` = '[Icehollow Yeti]' WHERE `locale` = 'deDE' AND `entry` = 23743;
-- OLD name : Dampfpanzer von Eisenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=23756
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Steam Tank]' WHERE `locale` = 'deDE' AND `entry` = 23756;
-- OLD name : Kapitän der Blockade
-- Source : https://www.wowhead.com/wotlk/de/npc=23767
UPDATE `creature_template_locale` SET `Name` = '[Blockade Captain]' WHERE `locale` = 'deDE' AND `entry` = 23767;
-- OLD name : Scharfschütze von Valgarde
-- Source : https://www.wowhead.com/wotlk/de/npc=23792
UPDATE `creature_template_locale` SET `Name` = '[Valgarde Rifleman]' WHERE `locale` = 'deDE' AND `entry` = 23792;
-- OLD name : Flamme der Drachenschinder
-- Source : https://www.wowhead.com/wotlk/de/npc=23806
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Blaze]' WHERE `locale` = 'deDE' AND `entry` = 23806;
-- OLD name : Unteroffizierin Amelyn
-- Source : https://www.wowhead.com/wotlk/de/npc=23835
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Amelyn' WHERE `locale` = 'deDE' AND `entry` = 23835;
-- OLD name : Holzfäller der Westwacht
-- Source : https://www.wowhead.com/wotlk/de/npc=23838
UPDATE `creature_template_locale` SET `Name` = '[Westguard Lumberjack (Wood)]' WHERE `locale` = 'deDE' AND `entry` = 23838;
-- OLD name : Kavallerist der Westwacht
-- Source : https://www.wowhead.com/wotlk/de/npc=23856
UPDATE `creature_template_locale` SET `Name` = '[Westguard Cavalryman Dwarf]' WHERE `locale` = 'deDE' AND `entry` = 23856;
-- OLD name : Kavallerist der Westwacht
-- Source : https://www.wowhead.com/wotlk/de/npc=23857
UPDATE `creature_template_locale` SET `Name` = '[Westguard Cavalryman Human]' WHERE `locale` = 'deDE' AND `entry` = 23857;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=23862
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 23862;
-- OLD name : Gezähmter Protowelpe
-- Source : https://www.wowhead.com/wotlk/de/npc=23882
UPDATE `creature_template_locale` SET `Name` = '[Tamed Proto-Whelp]' WHERE `locale` = 'deDE' AND `entry` = 23882;
-- OLD subname : Angellehrer & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Fischhändler' WHERE `locale` = 'deDE' AND `entry` = 23896;
-- OLD name : Invisible Giant Trigger
-- Source : https://www.wowhead.com/wotlk/de/npc=23901
UPDATE `creature_template_locale` SET `Name` = '[Invisible Giant Trigger]' WHERE `locale` = 'deDE' AND `entry` = 23901;
-- OLD name : Test Guy Brian
-- Source : https://www.wowhead.com/wotlk/de/npc=23925
UPDATE `creature_template_locale` SET `Name` = '[Test Guy Brian]' WHERE `locale` = 'deDE' AND `entry` = 23925;
-- OLD name : Verteidiger der Westwacht
-- Source : https://www.wowhead.com/wotlk/de/npc=23933
UPDATE `creature_template_locale` SET `Name` = '[Westguard Defender - Sleeping]' WHERE `locale` = 'deDE' AND `entry` = 23933;
-- OLD name : Gastwirtin Celeste Gutstall
-- Source : https://www.wowhead.com/wotlk/de/npc=23937
UPDATE `creature_template_locale` SET `Name` = 'Gastwirt Celeste Gutstall' WHERE `locale` = 'deDE' AND `entry` = 23937;
-- OLD name : Mogisu der Wanderer
-- Source : https://www.wowhead.com/wotlk/de/npc=23981
UPDATE `creature_template_locale` SET `Name` = '[Mogisu the Wayfarer]' WHERE `locale` = 'deDE' AND `entry` = 23981;
-- OLD name : Hungriger Seuchenhund
-- Source : https://www.wowhead.com/wotlk/de/npc=24000
UPDATE `creature_template_locale` SET `Name` = '[Hungry Plaguehound Counter]' WHERE `locale` = 'deDE' AND `entry` = 24000;
-- OLD name : Belagerungsarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Mühlenarbeiter' WHERE `locale` = 'deDE' AND `entry` = 24005;
-- OLD name : Aasfressende Made
-- Source : https://www.wowhead.com/wotlk/de/npc=24017
UPDATE `creature_template_locale` SET `Name` = '[Scavenging Maggot]' WHERE `locale` = 'deDE' AND `entry` = 24017;
-- OLD name : Reitpferd
-- Source : https://www.wowhead.com/wotlk/de/npc=24020
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Gjalerbron Felsteed) (scale x2)]' WHERE `locale` = 'deDE' AND `entry` = 24020;
-- OLD name : Test Faction Monster
-- Source : https://www.wowhead.com/wotlk/de/npc=24022
UPDATE `creature_template_locale` SET `Name` = '[Test Faction Monster]' WHERE `locale` = 'deDE' AND `entry` = 24022;
-- OLD name : Steinhornwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=24049
UPDATE `creature_template_locale` SET `Name` = '[Rockhorn Ram]' WHERE `locale` = 'deDE' AND `entry` = 24049;
-- OLD name : Protodrachenbrutmutter
-- Source : https://www.wowhead.com/wotlk/de/npc=24072
UPDATE `creature_template_locale` SET `Name` = '[Proto-Drake Broodmother]' WHERE `locale` = 'deDE' AND `entry` = 24072;
-- OLD name : Inspektor
-- Source : https://www.wowhead.com/wotlk/de/npc=24074
UPDATE `creature_template_locale` SET `Name` = '[Surveyor]' WHERE `locale` = 'deDE' AND `entry` = 24074;
-- OLD name : Späher von Valgarde
-- Source : https://www.wowhead.com/wotlk/de/npc=24075
UPDATE `creature_template_locale` SET `Name` = '[Valgarde Scout]' WHERE `locale` = 'deDE' AND `entry` = 24075;
-- OLD name : Gefangenes Kind von Valgarde
-- Source : https://www.wowhead.com/wotlk/de/npc=24091
UPDATE `creature_template_locale` SET `Name` = '[Captured Valgarde Child]' WHERE `locale` = 'deDE' AND `entry` = 24091;
-- OLD name : Winterskorn Vrykul Dismembering Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=24095
UPDATE `creature_template_locale` SET `Name` = '[Winterskorn Vrykul Dismembering Bunny]' WHERE `locale` = 'deDE' AND `entry` = 24095;
-- OLD name : Skorn Longhouse SW Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=24101
UPDATE `creature_template_locale` SET `Name` = '[Skorn Longhouse SW Bunny]' WHERE `locale` = 'deDE' AND `entry` = 24101;
-- OLD name : Protodrachenhimmelswache
-- Source : https://www.wowhead.com/wotlk/de/npc=24105
UPDATE `creature_template_locale` SET `Name` = '[Proto-Drake Skyguard]' WHERE `locale` = 'deDE' AND `entry` = 24105;
-- OLD name : Schildwache der Drachenschinder
-- Source : https://www.wowhead.com/wotlk/de/npc=24107
UPDATE `creature_template_locale` SET `Name` = '[Dragonflayer Sentinel]' WHERE `locale` = 'deDE' AND `entry` = 24107;
-- OLD name : Reservist der Nordflotte
-- Source : https://www.wowhead.com/wotlk/de/npc=24121
UPDATE `creature_template_locale` SET `Name` = '[North Fleet Reservist Credit]' WHERE `locale` = 'deDE' AND `entry` = 24121;
-- OLD name : Gefangener Einwohner Valgardes (PROXY)
-- Source : https://www.wowhead.com/wotlk/de/npc=24124
UPDATE `creature_template_locale` SET `Name` = '[Captured Valgarde Prisoner (PROXY)]' WHERE `locale` = 'deDE' AND `entry` = 24124;
-- OLD name : Kriegerheld der Winterhufe
-- Source : https://www.wowhead.com/wotlk/de/npc=24130
UPDATE `creature_template_locale` SET `Name` = 'Held der Winterhufe' WHERE `locale` = 'deDE' AND `entry` = 24130;
-- OLD name : Nebelsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=24134
UPDATE `creature_template_locale` SET `Name` = '[Mistsaber]' WHERE `locale` = 'deDE' AND `entry` = 24134;
-- OLD name : Leichnam der Nordflotte
-- Source : https://www.wowhead.com/wotlk/de/npc=24146
UPDATE `creature_template_locale` SET `Name` = '[North Fleet Corpse]' WHERE `locale` = 'deDE' AND `entry` = 24146;
-- OLD name : Ulf Credit Marker
-- Source : https://www.wowhead.com/wotlk/de/npc=24165
UPDATE `creature_template_locale` SET `Name` = '[Ulf Credit Marker]' WHERE `locale` = 'deDE' AND `entry` = 24165;
-- OLD name : Oric Credit Marker
-- Source : https://www.wowhead.com/wotlk/de/npc=24166
UPDATE `creature_template_locale` SET `Name` = '[Oric Credit Marker]' WHERE `locale` = 'deDE' AND `entry` = 24166;
-- OLD name : Gunnar Credit Marker
-- Source : https://www.wowhead.com/wotlk/de/npc=24167
UPDATE `creature_template_locale` SET `Name` = '[Gunnar Credit Marker]' WHERE `locale` = 'deDE' AND `entry` = 24167;
-- OLD name : Aufklärer der Amani'shi
-- Source : https://www.wowhead.com/wotlk/de/npc=24175
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Amani''shi' WHERE `locale` = 'deDE' AND `entry` = 24175;
-- OLD name : Diener des Lichts
-- Source : https://www.wowhead.com/wotlk/de/npc=24190
UPDATE `creature_template_locale` SET `Name` = '[Servitor of the Light]' WHERE `locale` = 'deDE' AND `entry` = 24190;
-- OLD name : Diener des Lichts
-- Source : https://www.wowhead.com/wotlk/de/npc=24192
UPDATE `creature_template_locale` SET `Name` = '[Servitor of the Light (Escort)]' WHERE `locale` = 'deDE' AND `entry` = 24192;
-- OLD name : Armee der Toten
-- Source : https://www.wowhead.com/wotlk/de/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Ghul aus der Armee der Toten' WHERE `locale` = 'deDE' AND `entry` = 24207;
-- OLD name : Quälheimer Massenmörder
-- Source : https://www.wowhead.com/wotlk/de/npc=24231
UPDATE `creature_template_locale` SET `Name` = '[Baleheim Bodycount]' WHERE `locale` = 'deDE' AND `entry` = 24231;
-- OLD name : Protodrachenreittier der Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=24237
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount (White)]' WHERE `locale` = 'deDE' AND `entry` = 24237;
-- OLD name : Kriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=24242
UPDATE `creature_template_locale` SET `Name` = 'Glibber' WHERE `locale` = 'deDE' AND `entry` = 24242;
-- OLD name : Arthas
-- Source : https://www.wowhead.com/wotlk/de/npc=24266
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Lich King]' WHERE `locale` = 'deDE' AND `entry` = 24266;
-- OLD name : Arthas
-- Source : https://www.wowhead.com/wotlk/de/npc=24267
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Dark]' WHERE `locale` = 'deDE' AND `entry` = 24267;
-- OLD name : Arthas
-- Source : https://www.wowhead.com/wotlk/de/npc=24268
UPDATE `creature_template_locale` SET `Name` = '[Arthas, Human]' WHERE `locale` = 'deDE' AND `entry` = 24268;
-- OLD name : The Cleansing Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=24269
UPDATE `creature_template_locale` SET `Name` = '[The Cleansing Bunny [reuse me]]' WHERE `locale` = 'deDE' AND `entry` = 24269;
-- OLD name : Plagued Dragonflayer Explode Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=24274
UPDATE `creature_template_locale` SET `Name` = '[Plagued Dragonflayer Explode Credit]' WHERE `locale` = 'deDE' AND `entry` = 24274;
-- OLD name : Björn Kill Credit, subname : Häuptling der Winterskorn
-- Source : https://www.wowhead.com/wotlk/de/npc=24275
UPDATE `creature_template_locale` SET `Name` = '[Bjorn Kill Credit]',`Title` = '[Winterskorn Chieftain]' WHERE `locale` = 'deDE' AND `entry` = 24275;
-- OLD name : Björn Insult Credit, subname : Häuptling der Winterskorn
-- Source : https://www.wowhead.com/wotlk/de/npc=24276
UPDATE `creature_template_locale` SET `Name` = '[Bjorn Insult Credit]',`Title` = '[Winterskorn Chieftain]' WHERE `locale` = 'deDE' AND `entry` = 24276;
-- OLD name : Garwal - Worgentransformation
-- Source : https://www.wowhead.com/wotlk/de/npc=24278
UPDATE `creature_template_locale` SET `Name` = '[Garwal - Worgen Transform]' WHERE `locale` = 'deDE' AND `entry` = 24278;
-- OLD name : Plagued Dragonflayer Spray Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=24281
UPDATE `creature_template_locale` SET `Name` = '[Plagued Dragonflayer Spray Credit]' WHERE `locale` = 'deDE' AND `entry` = 24281;
-- OLD name : Nifflevar Event Controller
-- Source : https://www.wowhead.com/wotlk/de/npc=24326
UPDATE `creature_template_locale` SET `Name` = '[Nifflevar Event Controller]' WHERE `locale` = 'deDE' AND `entry` = 24326;
-- OLD name : Nordendtransportmittel der Blizzcon
-- Source : https://www.wowhead.com/wotlk/de/npc=24331
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Northrend Transport]' WHERE `locale` = 'deDE' AND `entry` = 24331;
-- OLD name : Zul'Aman Transport
-- Source : https://www.wowhead.com/wotlk/de/npc=24332
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Zul''Aman Transport]' WHERE `locale` = 'deDE' AND `entry` = 24332;
-- OLD name : Jason Gutstall, subname : Barkeeper
-- Source : https://www.wowhead.com/wotlk/de/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Schankkellner Jason Gutstall',`Title` = 'Getränke' WHERE `locale` = 'deDE' AND `entry` = 24333;
-- OLD name : Scharlachroter Wuchs
-- Source : https://www.wowhead.com/wotlk/de/npc=24339
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Growth]' WHERE `locale` = 'deDE' AND `entry` = 24339;
-- OLD name : Eric Maloof Test Forsaken Male
-- Source : https://www.wowhead.com/wotlk/de/npc=24353
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Forsaken Male]' WHERE `locale` = 'deDE' AND `entry` = 24353;
-- OLD name : Eric Maloof Test Forsaken Female
-- Source : https://www.wowhead.com/wotlk/de/npc=24354
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Forsaken Female]' WHERE `locale` = 'deDE' AND `entry` = 24354;
-- OLD name : Eric Maloof Test Human Male
-- Source : https://www.wowhead.com/wotlk/de/npc=24355
UPDATE `creature_template_locale` SET `Name` = '[Eric Maloof Test Human Male]' WHERE `locale` = 'deDE' AND `entry` = 24355;
-- OLD name : Harrisons Leichnam
-- Source : https://www.wowhead.com/wotlk/de/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Willies Leichnam' WHERE `locale` = 'deDE' AND `entry` = 24365;
-- OLD name : Begrüßer der Blizzcon
-- Source : https://www.wowhead.com/wotlk/de/npc=24380
UPDATE `creature_template_locale` SET `Name` = '[Blizzcon Greeter]' WHERE `locale` = 'deDE' AND `entry` = 24380;
-- OLD name : Eisenrunendiener
-- Source : https://www.wowhead.com/wotlk/de/npc=24387
UPDATE `creature_template_locale` SET `Name` = '[Iron Rune Servant]' WHERE `locale` = 'deDE' AND `entry` = 24387;
-- OLD name : Alter Kutter
-- Source : https://www.wowhead.com/wotlk/de/npc=24391
UPDATE `creature_template_locale` SET `Name` = '[Speedboat]' WHERE `locale` = 'deDE' AND `entry` = 24391;
-- OLD subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 24395;
-- OLD name : Steel Gate - Grapple Target
-- Source : https://www.wowhead.com/wotlk/de/npc=24438
UPDATE `creature_template_locale` SET `Name` = '[Steel Gate - Grapple Target]' WHERE `locale` = 'deDE' AND `entry` = 24438;
-- OLD name : Der Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=24446
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'deDE' AND `entry` = 24446;
-- OLD name : Frostwyrm
-- Source : https://www.wowhead.com/wotlk/de/npc=24447
UPDATE `creature_template_locale` SET `Name` = '[Frostwyrm (Dragonblight)]' WHERE `locale` = 'deDE' AND `entry` = 24447;
-- OLD name : Invisible Charge Target 1
-- Source : https://www.wowhead.com/wotlk/de/npc=24449
UPDATE `creature_template_locale` SET `Name` = '[Invisible Charge Target 1]' WHERE `locale` = 'deDE' AND `entry` = 24449;
-- OLD name : Invisible Charge Target 2
-- Source : https://www.wowhead.com/wotlk/de/npc=24450
UPDATE `creature_template_locale` SET `Name` = '[Invisible Charge Target 2]' WHERE `locale` = 'deDE' AND `entry` = 24450;
-- OLD name : Blue Floating Rune Channel Bunny 01
-- Source : https://www.wowhead.com/wotlk/de/npc=24465
UPDATE `creature_template_locale` SET `Name` = '[Blue Floating Rune Channel Bunny 01]' WHERE `locale` = 'deDE' AND `entry` = 24465;
-- OLD name : Blue Floating Rune Channel Bunny 02
-- Source : https://www.wowhead.com/wotlk/de/npc=24466
UPDATE `creature_template_locale` SET `Name` = '[Blue Floating Rune Channel Bunny 02]' WHERE `locale` = 'deDE' AND `entry` = 24466;
-- OLD name : SP Test
-- Source : https://www.wowhead.com/wotlk/de/npc=24472
UPDATE `creature_template_locale` SET `Name` = '[SP Test]' WHERE `locale` = 'deDE' AND `entry` = 24472;
-- OLD name : Blutdürstiger Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=24475
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Worg' WHERE `locale` = 'deDE' AND `entry` = 24475;
-- OLD name : Eiskriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=24479
UPDATE `creature_template_locale` SET `Name` = '[Ice Crawler]' WHERE `locale` = 'deDE' AND `entry` = 24479;
-- OLD name : Froschtransformation
-- Source : https://www.wowhead.com/wotlk/de/npc=24483
UPDATE `creature_template_locale` SET `Name` = 'Transformation des Froschs' WHERE `locale` = 'deDE' AND `entry` = 24483;
-- OLD name : Harpunenkanone der Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=24512
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Gun (OLD)]' WHERE `locale` = 'deDE' AND `entry` = 24512;
-- OLD name : Vrykul Harpoon Controller 001 View
-- Source : https://www.wowhead.com/wotlk/de/npc=24513
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Controller 001 View]' WHERE `locale` = 'deDE' AND `entry` = 24513;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=24520
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 24520;
-- OLD name : Northsea Test1
-- Source : https://www.wowhead.com/wotlk/de/npc=24521
UPDATE `creature_template_locale` SET `Name` = '[Northsea Test1]' WHERE `locale` = 'deDE' AND `entry` = 24521;
-- OLD subname : Garaxxas Tier
-- Source : https://www.wowhead.com/wotlk/de/npc=24552
UPDATE `creature_template_locale` SET `Title` = 'Garaxxas'' Begleiter' WHERE `locale` = 'deDE' AND `entry` = 24552;
-- OLD name : Gespinstunhold der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=24564
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Webfiend]' WHERE `locale` = 'deDE' AND `entry` = 24564;
-- OLD name : Spinne der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=24565
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Spider]' WHERE `locale` = 'deDE' AND `entry` = 24565;
-- OLD name : Höhlenratte
-- Source : https://www.wowhead.com/wotlk/de/npc=24568
UPDATE `creature_template_locale` SET `Name` = '[Den Rat]' WHERE `locale` = 'deDE' AND `entry` = 24568;
-- OLD name : Höhlenkriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=24569
UPDATE `creature_template_locale` SET `Name` = '[Den Creeper]' WHERE `locale` = 'deDE' AND `entry` = 24569;
-- OLD name : Tundragezücht
-- Source : https://www.wowhead.com/wotlk/de/npc=24570
UPDATE `creature_template_locale` SET `Name` = '[Tundra Vermin]' WHERE `locale` = 'deDE' AND `entry` = 24570;
-- OLD name : Gezüchttyrann
-- Source : https://www.wowhead.com/wotlk/de/npc=24571
UPDATE `creature_template_locale` SET `Name` = '[Vermin Bully]' WHERE `locale` = 'deDE' AND `entry` = 24571;
-- OLD name : Gezüchthexling
-- Source : https://www.wowhead.com/wotlk/de/npc=24572
UPDATE `creature_template_locale` SET `Name` = '[Vermin Witchling]' WHERE `locale` = 'deDE' AND `entry` = 24572;
-- OLD name : Tundraroc
-- Source : https://www.wowhead.com/wotlk/de/npc=24573
UPDATE `creature_template_locale` SET `Name` = '[Tundra Roc]' WHERE `locale` = 'deDE' AND `entry` = 24573;
-- OLD name : Großer Tundraroc
-- Source : https://www.wowhead.com/wotlk/de/npc=24574
UPDATE `creature_template_locale` SET `Name` = '[Greater Tundra Roc]' WHERE `locale` = 'deDE' AND `entry` = 24574;
-- OLD name : Feldmesser der Eisenwoge
-- Source : https://www.wowhead.com/wotlk/de/npc=24581
UPDATE `creature_template_locale` SET `Name` = '[Irontide Surveyor]' WHERE `locale` = 'deDE' AND `entry` = 24581;
-- OLD name : Maschinenschmied der Eisenwoge
-- Source : https://www.wowhead.com/wotlk/de/npc=24582
UPDATE `creature_template_locale` SET `Name` = '[Irontide Machinesmith]' WHERE `locale` = 'deDE' AND `entry` = 24582;
-- OLD name : Ingenieur der Eisenwoge
-- Source : https://www.wowhead.com/wotlk/de/npc=24583
UPDATE `creature_template_locale` SET `Name` = '[Irontide Engineer]' WHERE `locale` = 'deDE' AND `entry` = 24583;
-- OLD name : Fischer der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24584
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Fisherman]' WHERE `locale` = 'deDE' AND `entry` = 24584;
-- OLD name : Stammesmitglied der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24585
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Clansman]' WHERE `locale` = 'deDE' AND `entry` = 24585;
-- OLD name : Harpunierer der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24586
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Harpooner]' WHERE `locale` = 'deDE' AND `entry` = 24586;
-- OLD name : Walfänger der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24587
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Whaler]' WHERE `locale` = 'deDE' AND `entry` = 24587;
-- OLD name : Meeresrufer der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24588
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Sea-caller]' WHERE `locale` = 'deDE' AND `entry` = 24588;
-- OLD name : Orcajäger der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24589
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Orca Hunter]' WHERE `locale` = 'deDE' AND `entry` = 24589;
-- OLD name : Wegfinder der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24590
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Wayfinder]' WHERE `locale` = 'deDE' AND `entry` = 24590;
-- OLD name : Götzenschnitzer der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24591
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Idol-Carver]' WHERE `locale` = 'deDE' AND `entry` = 24591;
-- OLD name : Ältester der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24592
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Elder]' WHERE `locale` = 'deDE' AND `entry` = 24592;
-- OLD name : Weiser Priester der Wahrhauer
-- Source : https://www.wowhead.com/wotlk/de/npc=24593
UPDATE `creature_template_locale` SET `Name` = '[Truetusk Sage-Priest]' WHERE `locale` = 'deDE' AND `entry` = 24593;
-- OLD name : Korallenbewachsene Schildkröte
-- Source : https://www.wowhead.com/wotlk/de/npc=24594
UPDATE `creature_template_locale` SET `Name` = '[Coral Shell Turtle]' WHERE `locale` = 'deDE' AND `entry` = 24594;
-- OLD name : Korallenbewachsener Schnapper
-- Source : https://www.wowhead.com/wotlk/de/npc=24595
UPDATE `creature_template_locale` SET `Name` = '[Coral Shell Snapper]' WHERE `locale` = 'deDE' AND `entry` = 24595;
-- OLD name : Korallenbewachsenes Urtum
-- Source : https://www.wowhead.com/wotlk/de/npc=24596
UPDATE `creature_template_locale` SET `Name` = '[Ancient Coral Shell]' WHERE `locale` = 'deDE' AND `entry` = 24596;
-- OLD name : Küstenwoger
-- Source : https://www.wowhead.com/wotlk/de/npc=24597
UPDATE `creature_template_locale` SET `Name` = '[Coast Surger]' WHERE `locale` = 'deDE' AND `entry` = 24597;
-- OLD name : Tidenwoger
-- Source : https://www.wowhead.com/wotlk/de/npc=24598
UPDATE `creature_template_locale` SET `Name` = '[Tide Surger]' WHERE `locale` = 'deDE' AND `entry` = 24598;
-- OLD name : Großer Tidenwoger
-- Source : https://www.wowhead.com/wotlk/de/npc=24599
UPDATE `creature_template_locale` SET `Name` = '[Greater Tide Surger]' WHERE `locale` = 'deDE' AND `entry` = 24599;
-- OLD name : Dampfreißer
-- Source : https://www.wowhead.com/wotlk/de/npc=24600
UPDATE `creature_template_locale` SET `Name` = '[Steam Ripper]' WHERE `locale` = 'deDE' AND `entry` = 24600;
-- OLD name : Lebendiger Geysir
-- Source : https://www.wowhead.com/wotlk/de/npc=24602
UPDATE `creature_template_locale` SET `Name` = '[Living Geyser]' WHERE `locale` = 'deDE' AND `entry` = 24602;
-- OLD name : Lebendiger Blizzard
-- Source : https://www.wowhead.com/wotlk/de/npc=24603
UPDATE `creature_template_locale` SET `Name` = '[Living Blizzard]' WHERE `locale` = 'deDE' AND `entry` = 24603;
-- OLD name : Eisfuror
-- Source : https://www.wowhead.com/wotlk/de/npc=24604
UPDATE `creature_template_locale` SET `Name` = '[Ice Fury]' WHERE `locale` = 'deDE' AND `entry` = 24604;
-- OLD name : Räuber der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24605
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Raider]' WHERE `locale` = 'deDE' AND `entry` = 24605;
-- OLD name : Brandschatzer der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24606
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Plunderer]' WHERE `locale` = 'deDE' AND `entry` = 24606;
-- OLD name : Schildmaid der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24607
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Shield-Maiden]' WHERE `locale` = 'deDE' AND `entry` = 24607;
-- OLD name : Ruderer der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24608
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Oar-man]' WHERE `locale` = 'deDE' AND `entry` = 24608;
-- OLD name : Plünderer der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24609
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Pillager]' WHERE `locale` = 'deDE' AND `entry` = 24609;
-- OLD name : Runenmagier der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24610
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Rune-caster]' WHERE `locale` = 'deDE' AND `entry` = 24610;
-- OLD name : Wogentürmer der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24611
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Sea-Waker]' WHERE `locale` = 'deDE' AND `entry` = 24611;
-- OLD name : Than der Voldskar
-- Source : https://www.wowhead.com/wotlk/de/npc=24612
UPDATE `creature_template_locale` SET `Name` = '[Voldskar Thane]' WHERE `locale` = 'deDE' AND `entry` = 24612;
-- OLD name : Einzelgängerisches Mammut
-- Source : https://www.wowhead.com/wotlk/de/npc=24615
UPDATE `creature_template_locale` SET `Name` = '[Solitary Mammoth]' WHERE `locale` = 'deDE' AND `entry` = 24615;
-- OLD name : Mammutpatriarch
-- Source : https://www.wowhead.com/wotlk/de/npc=24616
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Patriarch]' WHERE `locale` = 'deDE' AND `entry` = 24616;
-- OLD name : Verhungernder Tundrawolf
-- Source : https://www.wowhead.com/wotlk/de/npc=24618
UPDATE `creature_template_locale` SET `Name` = '[Starving Tundra Wolf]' WHERE `locale` = 'deDE' AND `entry` = 24618;
-- OLD name : Großer Tundrawolf
-- Source : https://www.wowhead.com/wotlk/de/npc=24619
UPDATE `creature_template_locale` SET `Name` = '[Greater Tundra Wolf]' WHERE `locale` = 'deDE' AND `entry` = 24619;
-- OLD name : Frostkäfigskelett
-- Source : https://www.wowhead.com/wotlk/de/npc=24621
UPDATE `creature_template_locale` SET `Name` = '[Frost Cage Skeleton]' WHERE `locale` = 'deDE' AND `entry` = 24621;
-- OLD name : Frostkäfigverheerer
-- Source : https://www.wowhead.com/wotlk/de/npc=24622
UPDATE `creature_template_locale` SET `Name` = '[Frost Cage Reaver]' WHERE `locale` = 'deDE' AND `entry` = 24622;
-- OLD name : Frostknochen
-- Source : https://www.wowhead.com/wotlk/de/npc=24623
UPDATE `creature_template_locale` SET `Name` = '[Frosty Bones]' WHERE `locale` = 'deDE' AND `entry` = 24623;
-- OLD name : Boralsteingargoyle
-- Source : https://www.wowhead.com/wotlk/de/npc=24624
UPDATE `creature_template_locale` SET `Name` = '[Boralstone Gargoyle]' WHERE `locale` = 'deDE' AND `entry` = 24624;
-- OLD name : Boralsteinhimmelsjäger
-- Source : https://www.wowhead.com/wotlk/de/npc=24625
UPDATE `creature_template_locale` SET `Name` = '[Boralstone Skyhunter]' WHERE `locale` = 'deDE' AND `entry` = 24625;
-- OLD name : Geißelhymnenkreischer
-- Source : https://www.wowhead.com/wotlk/de/npc=24626
UPDATE `creature_template_locale` SET `Name` = '[Scourgesong Shrieker]' WHERE `locale` = 'deDE' AND `entry` = 24626;
-- OLD name : Geißelhymnenheuler
-- Source : https://www.wowhead.com/wotlk/de/npc=24627
UPDATE `creature_template_locale` SET `Name` = '[Scourgesong Wailer]' WHERE `locale` = 'deDE' AND `entry` = 24627;
-- OLD name : Nordmeerfreibeuter
-- Source : https://www.wowhead.com/wotlk/de/npc=24636
UPDATE `creature_template_locale` SET `Name` = '[Northsea Freebooter]' WHERE `locale` = 'deDE' AND `entry` = 24636;
-- OLD name : Alliance Standard Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=24641
UPDATE `creature_template_locale` SET `Name` = '[Alliance Standard Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 24641;
-- OLD name : Mirror Frame
-- Source : https://www.wowhead.com/wotlk/de/npc=24645
UPDATE `creature_template_locale` SET `Name` = '[Mirror Frame]' WHERE `locale` = 'deDE' AND `entry` = 24645;
-- OLD name : Invisible Stalker (Scale x2)
-- Source : https://www.wowhead.com/wotlk/de/npc=24648
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Scale x2)]' WHERE `locale` = 'deDE' AND `entry` = 24648;
-- OLD name : Reflection of Flame
-- Source : https://www.wowhead.com/wotlk/de/npc=24651
UPDATE `creature_template_locale` SET `Name` = '[Reflection of Flame]' WHERE `locale` = 'deDE' AND `entry` = 24651;
-- OLD name : Wellenreiterbrett mit Harpune
-- Source : https://www.wowhead.com/wotlk/de/npc=24652
UPDATE `creature_template_locale` SET `Name` = '[Harpoon Surfboard]' WHERE `locale` = 'deDE' AND `entry` = 24652;
-- OLD name : Reflection Bounce Target
-- Source : https://www.wowhead.com/wotlk/de/npc=24655
UPDATE `creature_template_locale` SET `Name` = '[Reflection Bounce Target]' WHERE `locale` = 'deDE' AND `entry` = 24655;
-- OLD name : Gezeitenlord
-- Source : https://www.wowhead.com/wotlk/de/npc=24663
UPDATE `creature_template_locale` SET `Name` = '[Tidelord]' WHERE `locale` = 'deDE' AND `entry` = 24663;
-- OLD name : Harpunenkanone der Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=24682
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Harpoon Gun (OLD)]' WHERE `locale` = 'deDE' AND `entry` = 24682;
-- OLD name : Invisible Vehicle (Floating)
-- Source : https://www.wowhead.com/wotlk/de/npc=24704
UPDATE `creature_template_locale` SET `Name` = '[Invisible Vehicle (Floating)]' WHERE `locale` = 'deDE' AND `entry` = 24704;
-- OLD name : Test Scaling Bony Construct
-- Source : https://www.wowhead.com/wotlk/de/npc=24712
UPDATE `creature_template_locale` SET `Name` = '[Test Scaling Bony Construct]' WHERE `locale` = 'deDE' AND `entry` = 24712;
-- OLD name : Flugmaschinentaxi
-- Source : https://www.wowhead.com/wotlk/de/npc=24716
UPDATE `creature_template_locale` SET `Name` = '[Flying Machine Taxi]' WHERE `locale` = 'deDE' AND `entry` = 24716;
-- OLD name : Fliegender blauer Drache
-- Source : https://www.wowhead.com/wotlk/de/npc=24721
UPDATE `creature_template_locale` SET `Name` = '[Flying Blue Drake]' WHERE `locale` = 'deDE' AND `entry` = 24721;
-- OLD name : Gorloc Oracle Black
-- Source : https://www.wowhead.com/wotlk/de/npc=24724
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Black (Northrend Model)]' WHERE `locale` = 'deDE' AND `entry` = 24724;
-- OLD name : Hundeschlitten
-- Source : https://www.wowhead.com/wotlk/de/npc=24725
UPDATE `creature_template_locale` SET `Name` = '[Dog Sled]' WHERE `locale` = 'deDE' AND `entry` = 24725;
-- OLD name : Schlittenhund
-- Source : https://www.wowhead.com/wotlk/de/npc=24726
UPDATE `creature_template_locale` SET `Name` = '[Sled Dog]' WHERE `locale` = 'deDE' AND `entry` = 24726;
-- OLD name : Schlammwespe
-- Source : https://www.wowhead.com/wotlk/de/npc=24731
UPDATE `creature_template_locale` SET `Name` = '[Mud Wasp]' WHERE `locale` = 'deDE' AND `entry` = 24731;
-- OLD name : Schlammspringer
-- Source : https://www.wowhead.com/wotlk/de/npc=24732
UPDATE `creature_template_locale` SET `Name` = '[Mud Skipper]' WHERE `locale` = 'deDE' AND `entry` = 24732;
-- OLD name : Fjord Prey 03
-- Source : https://www.wowhead.com/wotlk/de/npc=24748
UPDATE `creature_template_locale` SET `Name` = '[Fjord Prey 03]' WHERE `locale` = 'deDE' AND `entry` = 24748;
-- OLD name : Fjord Prey 04
-- Source : https://www.wowhead.com/wotlk/de/npc=24749
UPDATE `creature_template_locale` SET `Name` = '[Fjord Prey 04]' WHERE `locale` = 'deDE' AND `entry` = 24749;
-- OLD name : Magiereflexion
-- Source : https://www.wowhead.com/wotlk/de/npc=24756
UPDATE `creature_template_locale` SET `Name` = '[Reflection of Magic]' WHERE `locale` = 'deDE' AND `entry` = 24756;
-- OLD name : Fjordfelsenschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=24757
UPDATE `creature_template_locale` SET `Name` = '[Fjord Rock Snake]' WHERE `locale` = 'deDE' AND `entry` = 24757;
-- OLD name : Spearfang Worg Totem Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=24758
UPDATE `creature_template_locale` SET `Name` = '[Spearfang Worg Totem Credit]' WHERE `locale` = 'deDE' AND `entry` = 24758;
-- OLD name : Gefangener Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=24759
UPDATE `creature_template_locale` SET `Name` = '[Captive Tuskarr]' WHERE `locale` = 'deDE' AND `entry` = 24759;
-- OLD name : Fjordmonarch
-- Source : https://www.wowhead.com/wotlk/de/npc=24760
UPDATE `creature_template_locale` SET `Name` = '[Fjord Monarch]' WHERE `locale` = 'deDE' AND `entry` = 24760;
-- OLD name : Suirut
-- Source : https://www.wowhead.com/wotlk/de/npc=24764
UPDATE `creature_template_locale` SET `Name` = '[Suirut]' WHERE `locale` = 'deDE' AND `entry` = 24764;
-- OLD name : Behüter des Nexus
-- Source : https://www.wowhead.com/wotlk/de/npc=24770
UPDATE `creature_template_locale` SET `Name` = 'Behüter des Nexus''' WHERE `locale` = 'deDE' AND `entry` = 24770;
-- OLD name : Roter Kaltarrawelpe
-- Source : https://www.wowhead.com/wotlk/de/npc=24775
UPDATE `creature_template_locale` SET `Name` = '[Coldarra Red Whelp]' WHERE `locale` = 'deDE' AND `entry` = 24775;
-- OLD name : Red-Breath Cannon (PH)
-- Source : https://www.wowhead.com/wotlk/de/npc=24776
UPDATE `creature_template_locale` SET `Name` = '[Red-Breath Cannon (PH)]' WHERE `locale` = 'deDE' AND `entry` = 24776;
-- OLD name : Missile Target Flare
-- Source : https://www.wowhead.com/wotlk/de/npc=24778
UPDATE `creature_template_locale` SET `Name` = '[Missile Target Flare]' WHERE `locale` = 'deDE' AND `entry` = 24778;
-- OLD name : Fjordwespe
-- Source : https://www.wowhead.com/wotlk/de/npc=24793
UPDATE `creature_template_locale` SET `Name` = '[Fjord Wasp]' WHERE `locale` = 'deDE' AND `entry` = 24793;
-- OLD name : Fjordkäfer
-- Source : https://www.wowhead.com/wotlk/de/npc=24794
UPDATE `creature_template_locale` SET `Name` = '[Fjord Beetle]' WHERE `locale` = 'deDE' AND `entry` = 24794;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24798
UPDATE `creature_template_locale` SET `Name` = '[Grell (Pink)]' WHERE `locale` = 'deDE' AND `entry` = 24798;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24799
UPDATE `creature_template_locale` SET `Name` = '[Grell (Blue)]' WHERE `locale` = 'deDE' AND `entry` = 24799;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24800
UPDATE `creature_template_locale` SET `Name` = '[Grell (Blanca)]' WHERE `locale` = 'deDE' AND `entry` = 24800;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24801
UPDATE `creature_template_locale` SET `Name` = '[Grell (Red)]' WHERE `locale` = 'deDE' AND `entry` = 24801;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24802
UPDATE `creature_template_locale` SET `Name` = '[Grell (Orange)]' WHERE `locale` = 'deDE' AND `entry` = 24802;
-- OLD name : Grell
-- Source : https://www.wowhead.com/wotlk/de/npc=24803
UPDATE `creature_template_locale` SET `Name` = '[Grell (White)]' WHERE `locale` = 'deDE' AND `entry` = 24803;
-- OLD name : Ross des kopflosen Reiters
-- Source : https://www.wowhead.com/wotlk/de/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Reittier des kopflosen Reiters' WHERE `locale` = 'deDE' AND `entry` = 24814;
-- OLD name : Fjordstachelschwein
-- Source : https://www.wowhead.com/wotlk/de/npc=24816
UPDATE `creature_template_locale` SET `Name` = '[Fjord Porcupine]' WHERE `locale` = 'deDE' AND `entry` = 24816;
-- OLD name : Schubkarre
-- Source : https://www.wowhead.com/wotlk/de/npc=24853
UPDATE `creature_template_locale` SET `Name` = '[Wheelbarrow]' WHERE `locale` = 'deDE' AND `entry` = 24853;
-- OLD name : Supererhitzter Elementar
-- Source : https://www.wowhead.com/wotlk/de/npc=24859
UPDATE `creature_template_locale` SET `Name` = '[Superheated Elemental]' WHERE `locale` = 'deDE' AND `entry` = 24859;
-- OLD name : Kristallstrahl
-- Source : https://www.wowhead.com/wotlk/de/npc=24861
UPDATE `creature_template_locale` SET `Name` = '[Crystal Beam]' WHERE `locale` = 'deDE' AND `entry` = 24861;
-- OLD name : Kristallstrahl
-- Source : https://www.wowhead.com/wotlk/de/npc=24865
UPDATE `creature_template_locale` SET `Name` = '[Crystal Beam Relay]' WHERE `locale` = 'deDE' AND `entry` = 24865;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrerin' WHERE `locale` = 'deDE' AND `entry` = 24868;
-- OLD name : Maschinenwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=24869
UPDATE `creature_template_locale` SET `Name` = '[Rig Guardian]' WHERE `locale` = 'deDE' AND `entry` = 24869;
-- OLD name : Maschinentechniker
-- Source : https://www.wowhead.com/wotlk/de/npc=24870
UPDATE `creature_template_locale` SET `Name` = '[Rig Technician]' WHERE `locale` = 'deDE' AND `entry` = 24870;
-- OLD name : Maschinenspäher
-- Source : https://www.wowhead.com/wotlk/de/npc=24878
UPDATE `creature_template_locale` SET `Name` = '[Rig Sentry]' WHERE `locale` = 'deDE' AND `entry` = 24878;
-- OLD name : Windan Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=24890
UPDATE `creature_template_locale` SET `Name` = '[Windan Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 24890;
-- OLD name : Klippenungetüm
-- Source : https://www.wowhead.com/wotlk/de/npc=24894
UPDATE `creature_template_locale` SET `Name` = '[Bluff Behemoth]' WHERE `locale` = 'deDE' AND `entry` = 24894;
-- OLD name : Lou der Kabinenjunge
-- Source : https://www.wowhead.com/wotlk/de/npc=24898
UPDATE `creature_template_locale` SET `Name` = '[Lou the Cabin Boy (Canoe)]' WHERE `locale` = 'deDE' AND `entry` = 24898;
-- OLD name : Snowball Stampede
-- Source : https://www.wowhead.com/wotlk/de/npc=24915
UPDATE `creature_template_locale` SET `Name` = '[Snowball Stampede]' WHERE `locale` = 'deDE' AND `entry` = 24915;
-- OLD name : Erste Offizierin Kupferbolz
-- Source : https://www.wowhead.com/wotlk/de/npc=24926
UPDATE `creature_template_locale` SET `Name` = 'Erster Offizier Kupferbolz' WHERE `locale` = 'deDE' AND `entry` = 24926;
-- OLD name : Madame Flaschatauren, subname : Gefährtin des Flaschatauren
-- Source : https://www.wowhead.com/wotlk/de/npc=24982
UPDATE `creature_template_locale` SET `Name` = 'Frau Flaschatauren',`Title` = 'PTR-Verzauberungen' WHERE `locale` = 'deDE' AND `entry` = 24982;
-- OLD name : Besudelter Magnataurengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=24983
UPDATE `creature_template_locale` SET `Name` = '[Tainted Magnataur Spirit]' WHERE `locale` = 'deDE' AND `entry` = 24983;
-- OLD name : Winterhauptmann Skarloc
-- Source : https://www.wowhead.com/wotlk/de/npc=24987
UPDATE `creature_template_locale` SET `Name` = 'Winterkapitän Skarloc' WHERE `locale` = 'deDE' AND `entry` = 24987;
-- OLD name : Dan's Test Vehicle
-- Source : https://www.wowhead.com/wotlk/de/npc=25006
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 25006;
-- OLD name : Schildwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25045
UPDATE `creature_template_locale` SET `Name` = 'Wächter' WHERE `locale` = 'deDE' AND `entry` = 25045;
-- OLD name : Erste Offizierin Kupfernuss
-- Source : https://www.wowhead.com/wotlk/de/npc=25070
UPDATE `creature_template_locale` SET `Name` = 'Erster Offizier Kupfernuss' WHERE `locale` = 'deDE' AND `entry` = 25070;
-- OLD name : Grunzerin Ounda
-- Source : https://www.wowhead.com/wotlk/de/npc=25081
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Ounda' WHERE `locale` = 'deDE' AND `entry` = 25081;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 25099;
-- OLD name : Frixi Messingkipper
-- Source : https://www.wowhead.com/wotlk/de/npc=25179
UPDATE `creature_template_locale` SET `Name` = 'Frixee Messingkipper' WHERE `locale` = 'deDE' AND `entry` = 25179;
-- OLD name : Moorbiss' Wyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=25185
UPDATE `creature_template_locale` SET `Name` = 'Moorbiss'' Flügeldrache' WHERE `locale` = 'deDE' AND `entry` = 25185;
-- OLD name : Skarlocs Schlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=25190
UPDATE `creature_template_locale` SET `Name` = 'Skarlocs Schlachtroß' WHERE `locale` = 'deDE' AND `entry` = 25190;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Händler für Spezialmunition' WHERE `locale` = 'deDE' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Händler für Spezialmunition' WHERE `locale` = 'deDE' AND `entry` = 25196;
-- OLD name : TEST - Clayton Dubin - TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=25221
UPDATE `creature_template_locale` SET `Name` = '[TEST - Clayton Dubin - TEST]' WHERE `locale` = 'deDE' AND `entry` = 25221;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=25225
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe' WHERE `locale` = 'deDE' AND `entry` = 25225;
-- OLD name : Grunzer der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=25252
UPDATE `creature_template_locale` SET `Name` = '[Horde Grunt (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25252;
-- OLD name : Soldat der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=25254
UPDATE `creature_template_locale` SET `Name` = '[Alliance Soldier (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25254;
-- OLD name : Soldat der Geißel
-- Source : https://www.wowhead.com/wotlk/de/npc=25255
UPDATE `creature_template_locale` SET `Name` = '[Scourge Soldier (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25255;
-- OLD name : Inschriftenkundelehrer, subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25263
UPDATE `creature_template_locale` SET `Name` = '[World Inscription Trainer]',`Title` = '[Inscription Trainer]' WHERE `locale` = 'deDE' AND `entry` = 25263;
-- OLD name : Zivilrekrut
-- Source : https://www.wowhead.com/wotlk/de/npc=25266
UPDATE `creature_template_locale` SET `Name` = '[Civilian Recruit]' WHERE `locale` = 'deDE' AND `entry` = 25266;
-- OLD name : Hordezeppelin (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25269
UPDATE `creature_template_locale` SET `Name` = 'Hordenzeppelin (Nordend)' WHERE `locale` = 'deDE' AND `entry` = 25269;
-- OLD subname : Ingenieurkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 25277;
-- OLD name : König Mrgl-Mrgls Reserveanzug
-- Source : https://www.wowhead.com/wotlk/de/npc=25283
UPDATE `creature_template_locale` SET `Name` = '[King Mrgl-Mrgl''s Spare Suit]' WHERE `locale` = 'deDE' AND `entry` = 25283;
-- OLD name : Wyvern des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=25287
UPDATE `creature_template_locale` SET `Name` = '[Warsong Wyvern]' WHERE `locale` = 'deDE' AND `entry` = 25287;
-- OLD name : Ay'mon, subname : To'bors Begleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=25290
UPDATE `creature_template_locale` SET `Name` = '[Ay''mon]',`Title` = '[To''bor''s Companion]' WHERE `locale` = 'deDE' AND `entry` = 25290;
-- OLD name : Eiersack der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=25293
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Egg Sac]' WHERE `locale` = 'deDE' AND `entry` = 25293;
-- OLD name : Larve der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=25296
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Larva]' WHERE `locale` = 'deDE' AND `entry` = 25296;
-- OLD name : Cel, subname : Reagenzien & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=25312
UPDATE `creature_template_locale` SET `Name` = '[Cel]',`Title` = '[Reagent and Poison Vendor]' WHERE `locale` = 'deDE' AND `entry` = 25312;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'deDE',NULL,'Softwareingenieur');
-- OLD name : Gortsch der Leichenmalmer
-- Source : https://www.wowhead.com/wotlk/de/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor' WHERE `locale` = 'deDE' AND `entry` = 25329;
-- OLD name : Scheusal der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=25330
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Behemoth]' WHERE `locale` = 'deDE' AND `entry` = 25330;
-- OLD name : Zerstörer der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=25331
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Destroyer]' WHERE `locale` = 'deDE' AND `entry` = 25331;
-- OLD name : Standartenträger des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=25337
UPDATE `creature_template_locale` SET `Name` = '[Warsong Standard Bearer]' WHERE `locale` = 'deDE' AND `entry` = 25337;
-- OLD name : Tote Karawanenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25340
UPDATE `creature_template_locale` SET `Name` = '[Dead Caravan Guard Transform]' WHERE `locale` = 'deDE' AND `entry` = 25340;
-- OLD name : Toter Karawanenarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=25341
UPDATE `creature_template_locale` SET `Name` = '[Dead Caravan Worker Transform]' WHERE `locale` = 'deDE' AND `entry` = 25341;
-- OLD name : Zwielichtspion Viktor, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25346
UPDATE `creature_template_locale` SET `Name` = 'Spion Viktor des Schattenhammers',`Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25346;
-- OLD name : Oberanführer der Geißel
-- Source : https://www.wowhead.com/wotlk/de/npc=25352
UPDATE `creature_template_locale` SET `Name` = '[Scourge Overlord]' WHERE `locale` = 'deDE' AND `entry` = 25352;
-- OLD name : Schreckenszwirnspinner
-- Source : https://www.wowhead.com/wotlk/de/npc=25365
UPDATE `creature_template_locale` SET `Name` = '[(PH) Dreadweave Spinner]' WHERE `locale` = 'deDE' AND `entry` = 25365;
-- OLD name : (PH) DEPRECATED
-- Source : https://www.wowhead.com/wotlk/de/npc=25366
UPDATE `creature_template_locale` SET `Name` = '[(PH) DEPRECATED]' WHERE `locale` = 'deDE' AND `entry` = 25366;
-- OLD name : Riesiger Skarabäus
-- Source : https://www.wowhead.com/wotlk/de/npc=25375
UPDATE `creature_template_locale` SET `Name` = '[Giant Scarab]' WHERE `locale` = 'deDE' AND `entry` = 25375;
-- OLD name : Stellvertreter der Nerub'ar
-- Source : https://www.wowhead.com/wotlk/de/npc=25382
UPDATE `creature_template_locale` SET `Name` = '[Nerub''ar Proxy]' WHERE `locale` = 'deDE' AND `entry` = 25382;
-- OLD name : Schlupfling von En'kilah
-- Source : https://www.wowhead.com/wotlk/de/npc=25388
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Hatchling (1)]' WHERE `locale` = 'deDE' AND `entry` = 25388;
-- OLD name : Schlupfling von En'kilah
-- Source : https://www.wowhead.com/wotlk/de/npc=25389
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Hatchling (2)]' WHERE `locale` = 'deDE' AND `entry` = 25389;
-- OLD name : Ältester Yakone
-- Source : https://www.wowhead.com/wotlk/de/npc=25400
UPDATE `creature_template_locale` SET `Name` = '[Elder Yakone]' WHERE `locale` = 'deDE' AND `entry` = 25400;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'deDE',NULL,'Softwareingenieur');
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'deDE',NULL,'Softwareingenieur');
-- OLD name : Vision von Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25424
UPDATE `creature_template_locale` SET `Name` = 'Vision des Weissagers Grimmläufer' WHERE `locale` = 'deDE' AND `entry` = 25424;
-- OLD name : Scharfseher Grimmläufers Geist
-- Source : https://www.wowhead.com/wotlk/de/npc=25425
UPDATE `creature_template_locale` SET `Name` = 'Weissager Grimmläufers Geist' WHERE `locale` = 'deDE' AND `entry` = 25425;
-- OLD name : Urahnengeist der Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=25436
UPDATE `creature_template_locale` SET `Name` = '[Elder Tuskarr Spirit]' WHERE `locale` = 'deDE' AND `entry` = 25436;
-- OLD name : Wolf des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=25447
UPDATE `creature_template_locale` SET `Name` = '[Warsong Wolf]' WHERE `locale` = 'deDE' AND `entry` = 25447;
-- OLD name : Vision des Geistes von Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25458
UPDATE `creature_template_locale` SET `Name` = 'Vision des Geistes von Weissager Grimmläufer' WHERE `locale` = 'deDE' AND `entry` = 25458;
-- OLD name : Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25461
UPDATE `creature_template_locale` SET `Name` = 'Weissager Grimmläufer' WHERE `locale` = 'deDE' AND `entry` = 25461;
-- OLD name : Soldat der Eisigen Weiten
-- Source : https://www.wowhead.com/wotlk/de/npc=25463
UPDATE `creature_template_locale` SET `Name` = '[Soldier of the Frozen Wastes]' WHERE `locale` = 'deDE' AND `entry` = 25463;
-- OLD name : Stellvertretende Geißeleinheit
-- Source : https://www.wowhead.com/wotlk/de/npc=25495
UPDATE `creature_template_locale` SET `Name` = '[Scourge Proxy Unit]' WHERE `locale` = 'deDE' AND `entry` = 25495;
-- OLD name : Orabus der Steuermann
-- Source : https://www.wowhead.com/wotlk/de/npc=25497
UPDATE `creature_template_locale` SET `Name` = '[Orabus the Helmsman]' WHERE `locale` = 'deDE' AND `entry` = 25497;
-- OLD name : Hah... You're Not So Big Now! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=25505
UPDATE `creature_template_locale` SET `Name` = '[Hah... You''re Not So Big Now! Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 25505;
-- OLD name : Caleb, subname : Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=25519
UPDATE `creature_template_locale` SET `Name` = '[Caleb]',`Title` = '[Stable Master]' WHERE `locale` = 'deDE' AND `entry` = 25519;
-- OLD name : Versklavte Priesterin der Peitschennarbe
-- Source : https://www.wowhead.com/wotlk/de/npc=25524
UPDATE `creature_template_locale` SET `Name` = '[Enslaved Riplash Priestess]' WHERE `locale` = 'deDE' AND `entry` = 25524;
-- OLD name : Orabus Spell Trigger
-- Source : https://www.wowhead.com/wotlk/de/npc=25525
UPDATE `creature_template_locale` SET `Name` = '[Orabus Spell Trigger]' WHERE `locale` = 'deDE' AND `entry` = 25525;
-- OLD name : Nackte Karawanenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25526
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Orc Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25526;
-- OLD name : Nackte Karawanenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25527
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Forsaken Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25527;
-- OLD name : Naked Caravan Guard - Orc Female Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25528
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Orc Female Transform]' WHERE `locale` = 'deDE' AND `entry` = 25528;
-- OLD name : Naked Caravan Guard - Tauren Male Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25529
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Guard - Tauren Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25529;
-- OLD name : Naked Caravan Worker - Orc Male Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25530
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Orc Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25530;
-- OLD name : Naked Caravan Worker - Forsaken Male Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25531
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Forsaken Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25531;
-- OLD name : Naked Caravan Worker - Orc Female Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25532
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Orc Female Transform]' WHERE `locale` = 'deDE' AND `entry` = 25532;
-- OLD name : Naked Caravan Worker - Troll Male Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25533
UPDATE `creature_template_locale` SET `Name` = '[Naked Caravan Worker - Troll Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25533;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/de/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'deDE','Craig''s Test Human',NULL);
-- OLD name : It Was The Orcs, Honest! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=25581
UPDATE `creature_template_locale` SET `Name` = '[It Was The Orcs, Honest! Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 25581;
-- OLD name : Landmine des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=25583
UPDATE `creature_template_locale` SET `Name` = '[Warsong Land Mine]' WHERE `locale` = 'deDE' AND `entry` = 25583;
-- OLD name : Warsong Orc Disguise Male Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25586
UPDATE `creature_template_locale` SET `Name` = '[Warsong Orc Disguise Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 25586;
-- OLD name : Warsong Orc Disguise Female Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=25587
UPDATE `creature_template_locale` SET `Name` = '[Warsong Orc Disguise Female Transform]' WHERE `locale` = 'deDE' AND `entry` = 25587;
-- OLD name : Ruderer der Skadir
-- Source : https://www.wowhead.com/wotlk/de/npc=25612
UPDATE `creature_template_locale` SET `Name` = '[Skadir Oarsman]' WHERE `locale` = 'deDE' AND `entry` = 25612;
-- OLD name : Boot der Skadir
-- Source : https://www.wowhead.com/wotlk/de/npc=25614
UPDATE `creature_template_locale` SET `Name` = '[Skadir Boat]' WHERE `locale` = 'deDE' AND `entry` = 25614;
-- OLD name : Verseuchter Schneebold
-- Source : https://www.wowhead.com/wotlk/de/npc=25616
UPDATE `creature_template_locale` SET `Name` = '[Plagued Snobold]' WHERE `locale` = 'deDE' AND `entry` = 25616;
-- OLD name : Stop the Plague Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=25654
UPDATE `creature_template_locale` SET `Name` = '[Stop the Plague Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 25654;
-- OLD name : Das Schiff des Steuermanns
-- Source : https://www.wowhead.com/wotlk/de/npc=25656
UPDATE `creature_template_locale` SET `Name` = '[The Helmsman''s Ship]' WHERE `locale` = 'deDE' AND `entry` = 25656;
-- OLD name : Besatzungsmitglied der Kvaldir
-- Source : https://www.wowhead.com/wotlk/de/npc=25659
UPDATE `creature_template_locale` SET `Name` = '[Kvaldir Crewman]' WHERE `locale` = 'deDE' AND `entry` = 25659;
-- OLD name : Verseuchtes Karibu
-- Source : https://www.wowhead.com/wotlk/de/npc=25667
UPDATE `creature_template_locale` SET `Name` = '[Plagued Caribou]' WHERE `locale` = 'deDE' AND `entry` = 25667;
-- OLD name : Reitmammut
-- Source : https://www.wowhead.com/wotlk/de/npc=25673
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Mount]' WHERE `locale` = 'deDE' AND `entry` = 25673;
-- OLD name : Mammutreiter der Taunka
-- Source : https://www.wowhead.com/wotlk/de/npc=25674
UPDATE `creature_template_locale` SET `Name` = '[Taunka Mammoth-rider]' WHERE `locale` = 'deDE' AND `entry` = 25674;
-- OLD name : Sturmwolke
-- Source : https://www.wowhead.com/wotlk/de/npc=25676
UPDATE `creature_template_locale` SET `Name` = '[Storm Cloud]' WHERE `locale` = 'deDE' AND `entry` = 25676;
-- OLD name : Wahnsinniger Überlebender der Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=25681
UPDATE `creature_template_locale` SET `Name` = '[Maddened Tuskarr Survivor]' WHERE `locale` = 'deDE' AND `entry` = 25681;
-- OLD name : Orakel der Gorlocs gelb (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25688
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Yellow (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25688;
-- OLD name : Orakel der Gorlocs rosa (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25689
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Pink (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25689;
-- OLD name : Orakel der Gorlocs rot (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25690
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Red (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25690;
-- OLD name : Orakel der Gorlocs grün (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25691
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Green (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25691;
-- OLD name : Orakel der Gorlocs kohlefarben (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25692
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Charcoal (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25692;
-- OLD name : Orakel der Gorlocs hellblau (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25693
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Light Blue (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25693;
-- OLD name : Orakel der Gorlocs blau (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25694
UPDATE `creature_template_locale` SET `Name` = '[Gorloc Oracle Blue (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25694;
-- OLD name : Kodo Saved Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=25698
UPDATE `creature_template_locale` SET `Name` = '[Kodo Saved Credit]' WHERE `locale` = 'deDE' AND `entry` = 25698;
-- OLD name : Sengender Flämmling
-- Source : https://www.wowhead.com/wotlk/de/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Flämmling' WHERE `locale` = 'deDE' AND `entry` = 25706;
-- OLD name : Leerenschildwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25772
UPDATE `creature_template_locale` SET `Name` = 'Leerenwache' WHERE `locale` = 'deDE' AND `entry` = 25772;
-- OLD name : Lastkodo der Flüchtlinge
-- Source : https://www.wowhead.com/wotlk/de/npc=25775
UPDATE `creature_template_locale` SET `Name` = '[Refugee Pack Kodo]' WHERE `locale` = 'deDE' AND `entry` = 25775;
-- OLD name : Flüchtlingsmutter
-- Source : https://www.wowhead.com/wotlk/de/npc=25776
UPDATE `creature_template_locale` SET `Name` = '[Refugee Wife]' WHERE `locale` = 'deDE' AND `entry` = 25776;
-- OLD name : Flüchtlingsvater
-- Source : https://www.wowhead.com/wotlk/de/npc=25777
UPDATE `creature_template_locale` SET `Name` = '[Refugee Father]' WHERE `locale` = 'deDE' AND `entry` = 25777;
-- OLD name : Einsamer Flüchtling
-- Source : https://www.wowhead.com/wotlk/de/npc=25778
UPDATE `creature_template_locale` SET `Name` = '[Refugee Loner]' WHERE `locale` = 'deDE' AND `entry` = 25778;
-- OLD name : X-42B
-- Source : https://www.wowhead.com/wotlk/de/npc=25787
UPDATE `creature_template_locale` SET `Name` = '[X-42B]' WHERE `locale` = 'deDE' AND `entry` = 25787;
-- OLD name : Nesingwarys Lakai
-- Source : https://www.wowhead.com/wotlk/de/npc=25805
UPDATE `creature_template_locale` SET `Name` = '[Nesingwary Lackey]' WHERE `locale` = 'deDE' AND `entry` = 25805;
-- OLD name : Sonnenbrunnen FX
-- Source : https://www.wowhead.com/wotlk/de/npc=25813
UPDATE `creature_template_locale` SET `Name` = '[(Deprecated) Sunwell FX]' WHERE `locale` = 'deDE' AND `entry` = 25813;
-- OLD name : Herr und Diener Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=25815
UPDATE `creature_template_locale` SET `Name` = '[Master and Servant Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 25815;
-- OLD name : Terrorfurbolg (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25842
UPDATE `creature_template_locale` SET `Name` = '[Dire Furbolg (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25842;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25863
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25863;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25866
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25866;
-- OLD name : Flammenwächter der Verwüsteten Lande (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25890
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der verwüsteten Lande' WHERE `locale` = 'deDE' AND `entry` = 25890;
-- OLD name : Flammenwächter der Brennenden Steppe (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25892
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der brennenden Steppe' WHERE `locale` = 'deDE' AND `entry` = 25892;
-- OLD name : Flammenwächter des Schlingendornkaps
-- Source : https://www.wowhead.com/wotlk/de/npc=25915
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter des Schlingendorntals' WHERE `locale` = 'deDE' AND `entry` = 25915;
-- OLD name : Flammenbewahrer des Schlingendornkaps
-- Source : https://www.wowhead.com/wotlk/de/npc=25920
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des Schlingendorntals' WHERE `locale` = 'deDE' AND `entry` = 25920;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25924
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25924;
-- OLD name : Flammenbewahrer der Brennenden Steppe (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25927
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer der brennenden Steppe' WHERE `locale` = 'deDE' AND `entry` = 25927;
-- OLD name : Flammenbewahrer der Höllenfeuerinsel
-- Source : https://www.wowhead.com/wotlk/de/npc=25934
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer der Höllenfeuerhalbinsel' WHERE `locale` = 'deDE' AND `entry` = 25934;
-- OLD name : Flammenbewahrer des Nördlichen Brachlands
-- Source : https://www.wowhead.com/wotlk/de/npc=25943
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des Brachlands' WHERE `locale` = 'deDE' AND `entry` = 25943;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25949
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25949;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=25950
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 25950;
-- OLD name : Arktischer Kondor
-- Source : https://www.wowhead.com/wotlk/de/npc=25963
UPDATE `creature_template_locale` SET `Name` = '[Arctic Condor (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 25963;
-- OLD name : Konvertierter Sammler
-- Source : https://www.wowhead.com/wotlk/de/npc=25993
UPDATE `creature_template_locale` SET `Name` = '[Converted Collector]' WHERE `locale` = 'deDE' AND `entry` = 25993;
-- OLD name : Craig's Test Human B
-- Source : https://www.wowhead.com/wotlk/de/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'deDE','[Craig''s Test Human B]',NULL);
-- OLD name : Hochadmiral "Shelly" Jorrik, subname : Pensionär
-- Source : https://www.wowhead.com/wotlk/de/npc=26081
UPDATE `creature_template_locale` SET `Name` = '[High Admiral "Shelly" Jorrik]',`Title` = '[Retiree]' WHERE `locale` = 'deDE' AND `entry` = 26081;
-- OLD name : Weakness to Lightning Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=26082
UPDATE `creature_template_locale` SET `Name` = '[Weakness to Lightning Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 26082;
-- OLD name : Transportkugel
-- Source : https://www.wowhead.com/wotlk/de/npc=26086
UPDATE `creature_template_locale` SET `Name` = '[Transport Orb]' WHERE `locale` = 'deDE' AND `entry` = 26086;
-- OLD name : Kurier der roten Drachen
-- Source : https://www.wowhead.com/wotlk/de/npc=26088
UPDATE `creature_template_locale` SET `Name` = '[Red Drake Courier]' WHERE `locale` = 'deDE' AND `entry` = 26088;
-- OLD name : Wagen mit Erz
-- Source : https://www.wowhead.com/wotlk/de/npc=26099
UPDATE `creature_template_locale` SET `Name` = '[Ore Cart (1)]' WHERE `locale` = 'deDE' AND `entry` = 26099;
-- OLD name : Plagued Grain Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=26114
UPDATE `creature_template_locale` SET `Name` = '[Plagued Grain Credit]' WHERE `locale` = 'deDE' AND `entry` = 26114;
-- OLD name : Worg des Kriegshymnenklans (Taxi)
-- Source : https://www.wowhead.com/wotlk/de/npc=26128
UPDATE `creature_template_locale` SET `Name` = '[Warsong Worg (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 26128;
-- OLD name : Quest InvisMan - Buying Time - Effect Caster
-- Source : https://www.wowhead.com/wotlk/de/npc=26129
UPDATE `creature_template_locale` SET `Name` = '[Quest InvisMan - Buying Time - Effect Caster]' WHERE `locale` = 'deDE' AND `entry` = 26129;
-- OLD name : Quest InvisMan - Buying Time - Effect Target
-- Source : https://www.wowhead.com/wotlk/de/npc=26130
UPDATE `creature_template_locale` SET `Name` = '[Quest InvisMan - Buying Time - Effect Target]' WHERE `locale` = 'deDE' AND `entry` = 26130;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=26183
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 26183;
-- OLD name : Nexus 70 - Buying Time - Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=26193
UPDATE `creature_template_locale` SET `Name` = '[Nexus 70 - Buying Time - Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 26193;
-- OLD name : Einheit von En'kilah
-- Source : https://www.wowhead.com/wotlk/de/npc=26195
UPDATE `creature_template_locale` SET `Name` = '[En''kilah Unit]' WHERE `locale` = 'deDE' AND `entry` = 26195;
-- OLD name : Krieger von Moa'ki
-- Source : https://www.wowhead.com/wotlk/de/npc=26220
UPDATE `creature_template_locale` SET `Name` = '[Moa''ki Warrior]' WHERE `locale` = 'deDE' AND `entry` = 26220;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26222
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 26222;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26223
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 26223;
-- OLD name : Slay Loguhn Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=26227
UPDATE `creature_template_locale` SET `Name` = '[Slay Loguhn Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 26227;
-- OLD name : Gischtalbatros
-- Source : https://www.wowhead.com/wotlk/de/npc=26240
UPDATE `creature_template_locale` SET `Name` = 'Gischtalbatross' WHERE `locale` = 'deDE' AND `entry` = 26240;
-- OLD name : Purpurschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=26243
UPDATE `creature_template_locale` SET `Name` = 'Scharlachrote Schlange' WHERE `locale` = 'deDE' AND `entry` = 26243;
-- OLD name : Farshire Bell Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=26256
UPDATE `creature_template_locale` SET `Name` = '[Farshire Bell Credit]' WHERE `locale` = 'deDE' AND `entry` = 26256;
-- OLD name : Roter Reitdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=26263
UPDATE `creature_template_locale` SET `Name` = '[Red Dragon Mount]' WHERE `locale` = 'deDE' AND `entry` = 26263;
-- OLD name : Pico, subname : Lederhändler
-- Source : https://www.wowhead.com/wotlk/de/npc=26269
UPDATE `creature_template_locale` SET `Name` = '[Pico]',`Title` = '[Leather Trader]' WHERE `locale` = 'deDE' AND `entry` = 26269;
-- OLD name : Roter Drache der Drachenöde
-- Source : https://www.wowhead.com/wotlk/de/npc=26279
UPDATE `creature_template_locale` SET `Name` = '[Dragonblight Red Dragon]' WHERE `locale` = 'deDE' AND `entry` = 26279;
-- OLD name : Risswirker der Zerschmetterten Sonne
-- Source : https://www.wowhead.com/wotlk/de/npc=26289
UPDATE `creature_template_locale` SET `Name` = 'Felsspalter der Zerschmetterten Sonne' WHERE `locale` = 'deDE' AND `entry` = 26289;
-- OLD name : Händler für Stoffrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26301
UPDATE `creature_template_locale` SET `Name` = 'Händler für Stoff- und Lederrüstungen' WHERE `locale` = 'deDE' AND `entry` = 26301;
-- OLD name : Gemischtwarenhändler
-- Source : https://www.wowhead.com/wotlk/de/npc=26304
UPDATE `creature_template_locale` SET `Name` = 'Händler für Gemischtwaren' WHERE `locale` = 'deDE' AND `entry` = 26304;
-- OLD name : Händler für Plattenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26305
UPDATE `creature_template_locale` SET `Name` = 'Händler für Ketten- und Plattenrüstungen' WHERE `locale` = 'deDE' AND `entry` = 26305;
-- OLD name : Händler für Lederrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26306
UPDATE `creature_template_locale` SET `Name` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 26306;
-- OLD name : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26308
UPDATE `creature_template_locale` SET `Name` = 'Händler für Plattenrüstungen' WHERE `locale` = 'deDE' AND `entry` = 26308;
-- OLD name : Zokk "Lulatsch" Drillzang
-- Source : https://www.wowhead.com/wotlk/de/npc=26352
UPDATE `creature_template_locale` SET `Name` = 'Bigzokk Drillzang' WHERE `locale` = 'deDE' AND `entry` = 26352;
-- OLD name : (PH) Wildlife Test Doe
-- Source : https://www.wowhead.com/wotlk/de/npc=26364
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Doe]' WHERE `locale` = 'deDE' AND `entry` = 26364;
-- OLD name : (PH) Wildlife Test Bear
-- Source : https://www.wowhead.com/wotlk/de/npc=26368
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Bear]' WHERE `locale` = 'deDE' AND `entry` = 26368;
-- OLD name : (PH) Grizzly Test Low Aggro Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=26372
UPDATE `creature_template_locale` SET `Name` = '[(PH) Grizzly Test Low Aggro Worg]' WHERE `locale` = 'deDE' AND `entry` = 26372;
-- OLD name : Test - Brutallus Craig
-- Source : https://www.wowhead.com/wotlk/de/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'deDE','[Test - Brutallus Craig]',NULL);
-- OLD name : Verwandelter Fallensteller
-- Source : https://www.wowhead.com/wotlk/de/npc=26390
UPDATE `creature_template_locale` SET `Name` = '[Transformed Trapper Male]' WHERE `locale` = 'deDE' AND `entry` = 26390;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26397
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 26397;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26398
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 26398;
-- OLD name : Aufklärer von Kaskala
-- Source : https://www.wowhead.com/wotlk/de/npc=26403
UPDATE `creature_template_locale` SET `Name` = 'Warte von Kaskala' WHERE `locale` = 'deDE' AND `entry` = 26403;
-- OLD name : Schwarzes Kriegsskelettpferd
-- Source : https://www.wowhead.com/wotlk/de/npc=26404
UPDATE `creature_template_locale` SET `Name` = '[Black Skeletal Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 26404;
-- OLD name : (PH) Wildlife Test Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=26412
UPDATE `creature_template_locale` SET `Name` = '[(PH) Wildlife Test Worg]' WHERE `locale` = 'deDE' AND `entry` = 26412;
-- OLD name : Verändertes Aussehen des Fallenstellers
-- Source : https://www.wowhead.com/wotlk/de/npc=26427
UPDATE `creature_template_locale` SET `Name` = '[Transformed Trapper Visual]' WHERE `locale` = 'deDE' AND `entry` = 26427;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/de/npc=26429
UPDATE `creature_template_locale` SET `Name` = '[Budd]' WHERE `locale` = 'deDE' AND `entry` = 26429;
-- OLD name : Ducals Beifahrersitz
-- Source : https://www.wowhead.com/wotlk/de/npc=26430
UPDATE `creature_template_locale` SET `Name` = '[Ducal''s Passenger Seat]' WHERE `locale` = 'deDE' AND `entry` = 26430;
-- OLD name : Flüchtling der Taunka'le
-- Source : https://www.wowhead.com/wotlk/de/npc=26432
UPDATE `creature_template_locale` SET `Name` = '[Taunka''le Refugee]' WHERE `locale` = 'deDE' AND `entry` = 26432;
-- OLD name : Flüchtling der Taunka'le
-- Source : https://www.wowhead.com/wotlk/de/npc=26433
UPDATE `creature_template_locale` SET `Name` = '[Taunka''le Refugee]' WHERE `locale` = 'deDE' AND `entry` = 26433;
-- OLD name : Gesandter Reißzahn
-- Source : https://www.wowhead.com/wotlk/de/npc=26441
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Reißzahn' WHERE `locale` = 'deDE' AND `entry` = 26441;
-- OLD name : Rak'la der Reisende, subname : Glücksspieler
-- Source : https://www.wowhead.com/wotlk/de/npc=26442
UPDATE `creature_template_locale` SET `Name` = '[Rak''la the Traveler]',`Title` = '[Gambler]' WHERE `locale` = 'deDE' AND `entry` = 26442;
-- OLD name : Quest Invisman - Filling the Cages
-- Source : https://www.wowhead.com/wotlk/de/npc=26444
UPDATE `creature_template_locale` SET `Name` = '[Quest Invisman - Filling the Cages]' WHERE `locale` = 'deDE' AND `entry` = 26444;
-- OLD name : Runenplatte
-- Source : https://www.wowhead.com/wotlk/de/npc=26445
UPDATE `creature_template_locale` SET `Name` = '[Rune Plate]' WHERE `locale` = 'deDE' AND `entry` = 26445;
-- OLD name : (PH) Duskhowl Stalker
-- Source : https://www.wowhead.com/wotlk/de/npc=26454
UPDATE `creature_template_locale` SET `Name` = '[(PH) Duskhowl Stalker]' WHERE `locale` = 'deDE' AND `entry` = 26454;
-- OLD name : Kranker Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=26457
UPDATE `creature_template_locale` SET `Name` = 'Verstorbener Drakkari' WHERE `locale` = 'deDE' AND `entry` = 26457;
-- OLD name : Lorn Todessprecher
-- Source : https://www.wowhead.com/wotlk/de/npc=26460
UPDATE `creature_template_locale` SET `Name` = '[Lorn Deathspeaker]' WHERE `locale` = 'deDE' AND `entry` = 26460;
-- OLD name : Testgreif
-- Source : https://www.wowhead.com/wotlk/de/npc=26462
UPDATE `creature_template_locale` SET `Name` = '[Test Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 26462;
-- OLD name : Transformation eines toten Magierjägers
-- Source : https://www.wowhead.com/wotlk/de/npc=26476
UPDATE `creature_template_locale` SET `Name` = '[Dead Mage Hunter Transform]' WHERE `locale` = 'deDE' AND `entry` = 26476;
-- OLD name : Krieger der Horde, subname : Söhne des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=26486
UPDATE `creature_template_locale` SET `Name` = '[Horde Warrior]',`Title` = '[Sons of Warsong]' WHERE `locale` = 'deDE' AND `entry` = 26486;
-- OLD name : Soldat der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=26487
UPDATE `creature_template_locale` SET `Name` = '[Alliance Soldier]' WHERE `locale` = 'deDE' AND `entry` = 26487;
-- OLD name : Testkatapult
-- Source : https://www.wowhead.com/wotlk/de/npc=26495
UPDATE `creature_template_locale` SET `Name` = '[Test Catapult]' WHERE `locale` = 'deDE' AND `entry` = 26495;
-- OLD name : Pestrufer der Verlassenen
-- Source : https://www.wowhead.com/wotlk/de/npc=26508
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Blightcaller]' WHERE `locale` = 'deDE' AND `entry` = 26508;
-- OLD name : Aasbeschwörer
-- Source : https://www.wowhead.com/wotlk/de/npc=26512
UPDATE `creature_template_locale` SET `Name` = '[Carrion Necromancer]' WHERE `locale` = 'deDE' AND `entry` = 26512;
-- OLD name : Aasghul
-- Source : https://www.wowhead.com/wotlk/de/npc=26515
UPDATE `creature_template_locale` SET `Name` = '[Carrion Ghoul]' WHERE `locale` = 'deDE' AND `entry` = 26515;
-- OLD name : Aasgargoyle
-- Source : https://www.wowhead.com/wotlk/de/npc=26517
UPDATE `creature_template_locale` SET `Name` = '[Carrion Gargoyle]' WHERE `locale` = 'deDE' AND `entry` = 26517;
-- OLD name : Aasmonstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=26518
UPDATE `creature_template_locale` SET `Name` = '[Carrion Abomination]' WHERE `locale` = 'deDE' AND `entry` = 26518;
-- OLD name : Scharlachroter Fußsoldat
-- Source : https://www.wowhead.com/wotlk/de/npc=26524
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Footman]' WHERE `locale` = 'deDE' AND `entry` = 26524;
-- OLD name : Verseuchter Scharlachroter Fußsoldat
-- Source : https://www.wowhead.com/wotlk/de/npc=26526
UPDATE `creature_template_locale` SET `Name` = '[Scourged Scarlet Footman]' WHERE `locale` = 'deDE' AND `entry` = 26526;
-- OLD subname : Zeppelinmeister, Boreanische Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26537
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, boreanische Tundra' WHERE `locale` = 'deDE' AND `entry` = 26537;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=26538
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar' WHERE `locale` = 'deDE' AND `entry` = 26538;
-- OLD subname : Zeppelinmeisterin, Heulender Fjord
-- Source : https://www.wowhead.com/wotlk/de/npc=26539
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, heulender Fjord' WHERE `locale` = 'deDE' AND `entry` = 26539;
-- OLD name : Zab Dampfbolz, subname : Zeppelinmeister, Heulender Fjord
-- Source : https://www.wowhead.com/wotlk/de/npc=26541
UPDATE `creature_template_locale` SET `Name` = '[Zab Steambolt]',`Title` = '[Howling Fjord Zeppelin Master]' WHERE `locale` = 'deDE' AND `entry` = 26541;
-- OLD name : Lini Laschenbolz, subname : Zeppelinmeister, Boreanische Tundra
-- Source : https://www.wowhead.com/wotlk/de/npc=26542
UPDATE `creature_template_locale` SET `Name` = '[Lini Lugbolt]',`Title` = '[Borean Tundra Zeppelin Master]' WHERE `locale` = 'deDE' AND `entry` = 26542;
-- OLD name : Hansrick Stämmig, subname : Dockmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=26551
UPDATE `creature_template_locale` SET `Name` = '[Hansric Stout]',`Title` = '[Dockmaster]' WHERE `locale` = 'deDE' AND `entry` = 26551;
-- OLD name : Maye Pfeifer, subname : Dockmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=26552
UPDATE `creature_template_locale` SET `Name` = '[Maye Piper]',`Title` = '[Dockmaster]' WHERE `locale` = 'deDE' AND `entry` = 26552;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26564;
-- OLD name : Eingekerkerter Affe
-- Source : https://www.wowhead.com/wotlk/de/npc=26571
UPDATE `creature_template_locale` SET `Name` = '[Imprisoned Monkey]' WHERE `locale` = 'deDE' AND `entry` = 26571;
-- OLD name : Verweilender Bewohner
-- Source : https://www.wowhead.com/wotlk/de/npc=26573
UPDATE `creature_template_locale` SET `Name` = '[Lingering Villager]' WHERE `locale` = 'deDE' AND `entry` = 26573;
-- OLD name : Hase der Grizzlyhügel
-- Source : https://www.wowhead.com/wotlk/de/npc=26587
UPDATE `creature_template_locale` SET `Name` = '[Grizzly Hills Rabbit]' WHERE `locale` = 'deDE' AND `entry` = 26587;
-- OLD name : Transformation der spirituellen Einsicht
-- Source : https://www.wowhead.com/wotlk/de/npc=26594
UPDATE `creature_template_locale` SET `Name` = '[Spiritual Insight Transform]' WHERE `locale` = 'deDE' AND `entry` = 26594;
-- OLD name : Burninate Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=26612
UPDATE `creature_template_locale` SET `Name` = '[Burninate Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 26612;
-- OLD name : Grunzer Tar'yug
-- Source : https://www.wowhead.com/wotlk/de/npc=26617
UPDATE `creature_template_locale` SET `Name` = '[Grunt Tar''yug]' WHERE `locale` = 'deDE' AND `entry` = 26617;
-- OLD name : Fallschirmjäger von Kurbelzisch
-- Source : https://www.wowhead.com/wotlk/de/npc=26619
UPDATE `creature_template_locale` SET `Name` = 'Fallschirmspringer von Kurbelzisch' WHERE `locale` = 'deDE' AND `entry` = 26619;
-- OLD name : Blutdürstiger Tundrawolf
-- Source : https://www.wowhead.com/wotlk/de/npc=26672
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Tundrawolf' WHERE `locale` = 'deDE' AND `entry` = 26672;
-- OLD name : Jormungarfleisch
-- Source : https://www.wowhead.com/wotlk/de/npc=26699
UPDATE `creature_template_locale` SET `Name` = '[Jormungar Meat]' WHERE `locale` = 'deDE' AND `entry` = 26699;
-- OLD name : Verseuchtes Orakel der Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=26702
UPDATE `creature_template_locale` SET `Name` = '[Scourged Drakkari Oracle]' WHERE `locale` = 'deDE' AND `entry` = 26702;
-- OLD name : Verseuchter Kriegshetzer der Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=26703
UPDATE `creature_template_locale` SET `Name` = '[Scourged Drakkari Warmonger]' WHERE `locale` = 'deDE' AND `entry` = 26703;
-- OLD name : Versuchsobjekt der Drachenöde
-- Source : https://www.wowhead.com/wotlk/de/npc=26713
UPDATE `creature_template_locale` SET `Name` = '[Dragonblight Test Subject]' WHERE `locale` = 'deDE' AND `entry` = 26713;
-- OLD name : Windelementar der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26726
UPDATE `creature_template_locale` SET `Name` = 'Windelementar der boreanischen Tundra' WHERE `locale` = 'deDE' AND `entry` = 26726;
-- OLD name : Kriegerheld Sturmhimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=26766
UPDATE `creature_template_locale` SET `Name` = 'Tapfer Sturmhimmel' WHERE `locale` = 'deDE' AND `entry` = 26766;
-- OLD name : The Focus on the Beach Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=26773
UPDATE `creature_template_locale` SET `Name` = '[The Focus on the Beach Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 26773;
-- OLD name : Klerikerin der 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=26780
UPDATE `creature_template_locale` SET `Name` = 'Kleriker der 7. Legion' WHERE `locale` = 'deDE' AND `entry` = 26780;
-- OLD name : Dan's Test Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=26784
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy]' WHERE `locale` = 'deDE' AND `entry` = 26784;
-- OLD subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/de/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'deDE',NULL,'Leben dieben');
-- OLD name : Waldläuferin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=26802
UPDATE `creature_template_locale` SET `Name` = 'Waldläufer der Allianz' WHERE `locale` = 'deDE' AND `entry` = 26802;
-- OLD name : Verwandelte Fallenstellerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26819
UPDATE `creature_template_locale` SET `Name` = '[Tranformed Trapper Female]' WHERE `locale` = 'deDE' AND `entry` = 26819;
-- OLD name : Gesandter Ducal
-- Source : https://www.wowhead.com/wotlk/de/npc=26821
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Ducal' WHERE `locale` = 'deDE' AND `entry` = 26821;
-- OLD name : Rasender Worgen
-- Source : https://www.wowhead.com/wotlk/de/npc=26829
UPDATE `creature_template_locale` SET `Name` = '[Frenzied Worgen]' WHERE `locale` = 'deDE' AND `entry` = 26829;
-- OLD name : Atop the Woodlands Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=26831
UPDATE `creature_template_locale` SET `Name` = '[Atop the Woodlands Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 26831;
-- OLD name : Aufgeschrecktes Schlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=26833
UPDATE `creature_template_locale` SET `Name` = '[Startled Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 26833;
-- OLD name : Kareg, subname : Windreitermeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=26846
UPDATE `creature_template_locale` SET `Name` = '[Kareg]',`Title` = '[Wind Rider Master]' WHERE `locale` = 'deDE' AND `entry` = 26846;
-- OLD name : Erdwächter Graif
-- Source : https://www.wowhead.com/wotlk/de/npc=26854
UPDATE `creature_template_locale` SET `Name` = 'Erdenwächter Graif' WHERE `locale` = 'deDE' AND `entry` = 26854;
-- OLD name : Arktischer Grizzly
-- Source : https://www.wowhead.com/wotlk/de/npc=26882
UPDATE `creature_template_locale` SET `Name` = '[Arctic Grizzly Credit]' WHERE `locale` = 'deDE' AND `entry` = 26882;
-- OLD name : The End of the Line Ley Line Focus Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=26887
UPDATE `creature_template_locale` SET `Name` = '[The End of the Line Ley Line Focus Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 26887;
-- OLD name : Kartograf Tobias
-- Source : https://www.wowhead.com/wotlk/de/npc=26888
UPDATE `creature_template_locale` SET `Name` = '[Cartographer Tobias]' WHERE `locale` = 'deDE' AND `entry` = 26888;
-- OLD name : TEST ESCORTEE - LAB
-- Source : https://www.wowhead.com/wotlk/de/npc=26894
UPDATE `creature_template_locale` SET `Name` = '[TEST ESCORTEE - LAB]' WHERE `locale` = 'deDE' AND `entry` = 26894;
-- OLD name : Schneewehenelch
-- Source : https://www.wowhead.com/wotlk/de/npc=26895
UPDATE `creature_template_locale` SET `Name` = '[Snowfall Elk Credit]' WHERE `locale` = 'deDE' AND `entry` = 26895;
-- OLD name : Gnom
-- Source : https://www.wowhead.com/wotlk/de/npc=26897
UPDATE `creature_template_locale` SET `Name` = '[Gnome, Clockwork (Northrend)]' WHERE `locale` = 'deDE' AND `entry` = 26897;
-- OLD name : Reitdrache, rot
-- Source : https://www.wowhead.com/wotlk/de/npc=26899
UPDATE `creature_template_locale` SET `Name` = '[Riding Drake, Red]' WHERE `locale` = 'deDE' AND `entry` = 26899;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=26901
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 26901;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26903
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 26903;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26904
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26904;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26905
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 26905;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26906
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 26906;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26907
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 26907;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26909
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns' WHERE `locale` = 'deDE' AND `entry` = 26909;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26910
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kräuterkunde' WHERE `locale` = 'deDE' AND `entry` = 26910;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26911
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 26911;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26912
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus' WHERE `locale` = 'deDE' AND `entry` = 26912;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26913
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei' WHERE `locale` = 'deDE' AND `entry` = 26913;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26914
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 26914;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26915
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 26915;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26916
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 26916;
-- OLD name : Warlord Jin'gom Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=26927
UPDATE `creature_template_locale` SET `Name` = '[Warlord Jin''gom Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 26927;
-- OLD name : Blutbanns Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=26931
UPDATE `creature_template_locale` SET `Name` = '[Bloodbane''s Mount]' WHERE `locale` = 'deDE' AND `entry` = 26931;
-- OLD name : Vix Chromblaster, subname : Händler für Selbsthilfebücher
-- Source : https://www.wowhead.com/wotlk/de/npc=26947
UPDATE `creature_template_locale` SET `Name` = '[Vix Chromeblaster]',`Title` = '[Self-Help Bookseller]' WHERE `locale` = 'deDE' AND `entry` = 26947;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26951
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 26951;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26952
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26952;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26953
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 26953;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26954
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 26954;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26955
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 26955;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe' WHERE `locale` = 'deDE' AND `entry` = 26956;
-- OLD subname : Angellehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26957
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Angelns' WHERE `locale` = 'deDE' AND `entry` = 26957;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26958
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde' WHERE `locale` = 'deDE' AND `entry` = 26958;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26959
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 26959;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26960
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 26960;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26961
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 26961;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26962
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus' WHERE `locale` = 'deDE' AND `entry` = 26962;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26963
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kürschnerei' WHERE `locale` = 'deDE' AND `entry` = 26963;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26964
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 26964;
-- OLD name : Frostbruttöter
-- Source : https://www.wowhead.com/wotlk/de/npc=26967
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Slayer]' WHERE `locale` = 'deDE' AND `entry` = 26967;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 26969;
-- OLD name : Kleintiertransformation von Großmagistrix Telestra
-- Source : https://www.wowhead.com/wotlk/de/npc=26970
UPDATE `creature_template_locale` SET `Name` = '[Grand Magus Telestra Critter Transform]' WHERE `locale` = 'deDE' AND `entry` = 26970;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26972
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 26972;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26974
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde' WHERE `locale` = 'deDE' AND `entry` = 26974;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26975
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 26975;
-- OLD subname : Bergbaulehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26976
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Bergbaus' WHERE `locale` = 'deDE' AND `entry` = 26976;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26977
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 26977;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26980
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 26980;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26981
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26981;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26982
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 26982;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26986
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 26986;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26987
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 26987;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26988
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26988;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26989
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 26989;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26990
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 26990;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26991
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 26991;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin für Erste Hilfe' WHERE `locale` = 'deDE' AND `entry` = 26992;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26993
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns' WHERE `locale` = 'deDE' AND `entry` = 26993;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26994
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde' WHERE `locale` = 'deDE' AND `entry` = 26994;
-- OLD name : Klimper Hellblitz, subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26995
UPDATE `creature_template_locale` SET `Name` = 'Bastel Hellblitz',`Title` = 'Großmeisterin der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 26995;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26996
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 26996;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26997
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 26997;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26998
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 26998;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26999
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus' WHERE `locale` = 'deDE' AND `entry` = 26999;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27000
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei' WHERE `locale` = 'deDE' AND `entry` = 27000;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27001
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 27001;
-- OLD name : Baumeister Stumpi
-- Source : https://www.wowhead.com/wotlk/de/npc=27014
UPDATE `creature_template_locale` SET `Name` = '[Builder Bezzle]' WHERE `locale` = 'deDE' AND `entry` = 27014;
-- OLD name : Baumeister Stümpi
-- Source : https://www.wowhead.com/wotlk/de/npc=27015
UPDATE `creature_template_locale` SET `Name` = '[Builder Bozzle]' WHERE `locale` = 'deDE' AND `entry` = 27015;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 27023;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 27029;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 27034;
-- OLD name : Schreckenslord
-- Source : https://www.wowhead.com/wotlk/de/npc=27036
UPDATE `creature_template_locale` SET `Name` = '[Dreadlord - Metamorphosis (Warlock)]' WHERE `locale` = 'deDE' AND `entry` = 27036;
-- OLD name : Aufgeladener Kriegsgolem
-- Source : https://www.wowhead.com/wotlk/de/npc=27049
UPDATE `creature_template_locale` SET `Name` = '[Charged War Golem]' WHERE `locale` = 'deDE' AND `entry` = 27049;
-- OLD name : Belagerungspanzer der Horde 2
-- Source : https://www.wowhead.com/wotlk/de/npc=27103
UPDATE `creature_template_locale` SET `Name` = '[Horde Siege Tank 2]' WHERE `locale` = 'deDE' AND `entry` = 27103;
-- OLD name : Belagerungspanzer der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=27104
UPDATE `creature_template_locale` SET `Name` = '[Horde Siege Tank 3]' WHERE `locale` = 'deDE' AND `entry` = 27104;
-- OLD name : Verletzter Stellvertreter des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=27109
UPDATE `creature_template_locale` SET `Name` = '[Injured Warsong Proxy]' WHERE `locale` = 'deDE' AND `entry` = 27109;
-- OLD name : Blighted Elk Liquid Fire of Elune Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27111
UPDATE `creature_template_locale` SET `Name` = '[Blighted Elk Liquid Fire of Elune Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27111;
-- OLD name : Rabid Grizzly Liquid Fire of Elune Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27112
UPDATE `creature_template_locale` SET `Name` = '[Rabid Grizzly Liquid Fire of Elune Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27112;
-- OLD name : Blackriver Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27121
UPDATE `creature_template_locale` SET `Name` = '[Blackriver Credit]' WHERE `locale` = 'deDE' AND `entry` = 27121;
-- OLD name : Kriegerheld von Oneqwah
-- Source : https://www.wowhead.com/wotlk/de/npc=27126
UPDATE `creature_template_locale` SET `Name` = 'Kriegsheld von Oneqwah' WHERE `locale` = 'deDE' AND `entry` = 27126;
-- OLD name : Hippogryphentaxi
-- Source : https://www.wowhead.com/wotlk/de/npc=27127
UPDATE `creature_template_locale` SET `Name` = '[Hippogryph Taxi (Dragonblight)]' WHERE `locale` = 'deDE' AND `entry` = 27127;
-- OLD subname : Rüstungsschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=27134
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied' WHERE `locale` = 'deDE' AND `entry` = 27134;
-- OLD name : Hochkommandant Halford Wyrmbann
-- Source : https://www.wowhead.com/wotlk/de/npc=27136
UPDATE `creature_template_locale` SET `Name` = 'Oberkommandant Halford Wyrmbann' WHERE `locale` = 'deDE' AND `entry` = 27136;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27142
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 27142;
-- OLD name : Test Faction NPC
-- Source : https://www.wowhead.com/wotlk/de/npc=27154
UPDATE `creature_template_locale` SET `Name` = '[Test Faction NPC]' WHERE `locale` = 'deDE' AND `entry` = 27154;
-- OLD name : Testeinheit der 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=27168
UPDATE `creature_template_locale` SET `Name` = '[7th Legion Test Unit]' WHERE `locale` = 'deDE' AND `entry` = 27168;
-- OLD name : Kriegsmagier von Bernsteinflöz
-- Source : https://www.wowhead.com/wotlk/de/npc=27170
UPDATE `creature_template_locale` SET `Name` = '[Amber Ledge Warmage]' WHERE `locale` = 'deDE' AND `entry` = 27170;
-- OLD name : Fledermaustaxi
-- Source : https://www.wowhead.com/wotlk/de/npc=27179
UPDATE `creature_template_locale` SET `Name` = '[Bat Taxi (Howling Fjord)]' WHERE `locale` = 'deDE' AND `entry` = 27179;
-- OLD name : Folterer LeCraft
-- Source : https://www.wowhead.com/wotlk/de/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Folterer Alphonse' WHERE `locale` = 'deDE' AND `entry` = 27209;
-- OLD name : Pferd des Ansturms
-- Source : https://www.wowhead.com/wotlk/de/npc=27214
UPDATE `creature_template_locale` SET `Name` = '[Onslaught Horse]' WHERE `locale` = 'deDE' AND `entry` = 27214;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27222
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel' WHERE `locale` = 'deDE' AND `entry` = 27222;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27223
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel' WHERE `locale` = 'deDE' AND `entry` = 27223;
-- OLD name : Clayton Dubin J, subname : Geprüfte Qualität
-- Source : https://www.wowhead.com/wotlk/de/npc=27231
UPDATE `creature_template_locale` SET `Name` = '[Clayton Dubin J]',`Title` = '[Assured Quality ]' WHERE `locale` = 'deDE' AND `entry` = 27231;
-- OLD name : Rogue Test Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=27239
UPDATE `creature_template_locale` SET `Name` = '[Rogue Test Dummy]' WHERE `locale` = 'deDE' AND `entry` = 27239;
-- OLD name : Vergessener Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=27240
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 27240;
-- OLD name : Schutzgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=27242
UPDATE `creature_template_locale` SET `Name` = '[Guardian Spirit]' WHERE `locale` = 'deDE' AND `entry` = 27242;
-- OLD name : Ergebener Leibwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=27247
UPDATE `creature_template_locale` SET `Name` = 'Andächtiger Leibwächter' WHERE `locale` = 'deDE' AND `entry` = 27247;
-- OLD name : Smaragdgrüner Irrwisch
-- Source : https://www.wowhead.com/wotlk/de/npc=27252
UPDATE `creature_template_locale` SET `Name` = '[Emerald Wisp]' WHERE `locale` = 'deDE' AND `entry` = 27252;
-- OLD name : Blighted Last Rites Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27253
UPDATE `creature_template_locale` SET `Name` = '[Blighted Last Rites Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27253;
-- OLD name : Seuchenverbreiter der Geißel (KLEIN)
-- Source : https://www.wowhead.com/wotlk/de/npc=27257
UPDATE `creature_template_locale` SET `Name` = '[Scourge Plague Spreader (SMALL)]' WHERE `locale` = 'deDE' AND `entry` = 27257;
-- OLD name : Smaragdsetzling
-- Source : https://www.wowhead.com/wotlk/de/npc=27261
UPDATE `creature_template_locale` SET `Name` = '[Emerald Seedling]' WHERE `locale` = 'deDE' AND `entry` = 27261;
-- OLD name : Forstmeister Anderhol
-- Source : https://www.wowhead.com/wotlk/de/npc=27277
UPDATE `creature_template_locale` SET `Name` = 'Förstermeister Anderhol' WHERE `locale` = 'deDE' AND `entry` = 27277;
-- OLD name : Let Them Not Rise! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27280
UPDATE `creature_template_locale` SET `Name` = '[Let Them Not Rise! Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27280;
-- OLD name : Begrabener Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=27282
UPDATE `creature_template_locale` SET `Name` = '[Buried Prisoner]' WHERE `locale` = 'deDE' AND `entry` = 27282;
-- OLD name : Fresh Remounts Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27296
UPDATE `creature_template_locale` SET `Name` = '[Fresh Remounts Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27296;
-- OLD name : König Björn
-- Source : https://www.wowhead.com/wotlk/de/npc=27304
UPDATE `creature_template_locale` SET `Name` = '[King Bjorn Visual]' WHERE `locale` = 'deDE' AND `entry` = 27304;
-- OLD name : König Haldor
-- Source : https://www.wowhead.com/wotlk/de/npc=27310
UPDATE `creature_template_locale` SET `Name` = '[King Haldor Visual]' WHERE `locale` = 'deDE' AND `entry` = 27310;
-- OLD name : König Ranulf
-- Source : https://www.wowhead.com/wotlk/de/npc=27311
UPDATE `creature_template_locale` SET `Name` = '[King Ranulf Visual]' WHERE `locale` = 'deDE' AND `entry` = 27311;
-- OLD name : König Tor
-- Source : https://www.wowhead.com/wotlk/de/npc=27312
UPDATE `creature_template_locale` SET `Name` = '[King Tor Visual]' WHERE `locale` = 'deDE' AND `entry` = 27312;
-- OLD name : Eisriese
-- Source : https://www.wowhead.com/wotlk/de/npc=27313
UPDATE `creature_template_locale` SET `Name` = '[Ice Giant, Northrend]' WHERE `locale` = 'deDE' AND `entry` = 27313;
-- OLD name : Outhouse Stalker
-- Source : https://www.wowhead.com/wotlk/de/npc=27323
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Stalker]' WHERE `locale` = 'deDE' AND `entry` = 27323;
-- OLD name : Outhouse Invisible Man
-- Source : https://www.wowhead.com/wotlk/de/npc=27324
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Invisible Man]' WHERE `locale` = 'deDE' AND `entry` = 27324;
-- OLD name : Spionagemeisterin Repine
-- Source : https://www.wowhead.com/wotlk/de/npc=27337
UPDATE `creature_template_locale` SET `Name` = 'Spionenmeisterin Repine' WHERE `locale` = 'deDE' AND `entry` = 27337;
-- OLD name : Dan's Test Vehicle 2
-- Source : https://www.wowhead.com/wotlk/de/npc=27338
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Vehicle 2]' WHERE `locale` = 'deDE' AND `entry` = 27338;
-- OLD name : Stellvertretender hilfloser Dorfbewohner
-- Source : https://www.wowhead.com/wotlk/de/npc=27341
UPDATE `creature_template_locale` SET `Name` = '[Helpless Villager Proxy]' WHERE `locale` = 'deDE' AND `entry` = 27341;
-- OLD name : Adeline Kammerer
-- Source : https://www.wowhead.com/wotlk/de/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Fledermausführerin Adeline' WHERE `locale` = 'deDE' AND `entry` = 27344;
-- OLD name : Hilfloser Dorfbauer von Wintergarde
-- Source : https://www.wowhead.com/wotlk/de/npc=27345
UPDATE `creature_template_locale` SET `Name` = '[Helpless Wintergarde Villager (Peasants)]' WHERE `locale` = 'deDE' AND `entry` = 27345;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=27360
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett' WHERE `locale` = 'deDE' AND `entry` = 27360;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=27362
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt' WHERE `locale` = 'deDE' AND `entry` = 27362;
-- OLD name : Schwelender Spuk
-- Source : https://www.wowhead.com/wotlk/de/npc=27363
UPDATE `creature_template_locale` SET `Name` = 'Glimmender Spuk' WHERE `locale` = 'deDE' AND `entry` = 27363;
-- OLD name : Vordrassil Sapling Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27366
UPDATE `creature_template_locale` SET `Name` = '[Vordrassil Sapling Credit]' WHERE `locale` = 'deDE' AND `entry` = 27366;
-- OLD name : Ursoc Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27372
UPDATE `creature_template_locale` SET `Name` = '[Ursoc Credit]' WHERE `locale` = 'deDE' AND `entry` = 27372;
-- OLD name : Chefschreiber Barriga
-- Source : https://www.wowhead.com/wotlk/de/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Chefschreiber Kinnedius' WHERE `locale` = 'deDE' AND `entry` = 27378;
-- OLD name : Torture the Torturer Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27394
UPDATE `creature_template_locale` SET `Name` = '[Torture the Torturer Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27394;
-- OLD name : Taifun
-- Source : https://www.wowhead.com/wotlk/de/npc=27395
UPDATE `creature_template_locale` SET `Name` = '[Typhoon]' WHERE `locale` = 'deDE' AND `entry` = 27395;
-- OLD name : Kill Credit Bunny - Shredder Delivery
-- Source : https://www.wowhead.com/wotlk/de/npc=27396
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Shredder Delivery]' WHERE `locale` = 'deDE' AND `entry` = 27396;
-- OLD name : Rocket Mount (Log Ride Test)
-- Source : https://www.wowhead.com/wotlk/de/npc=27397
UPDATE `creature_template_locale` SET `Name` = '[Rocket Mount (Log Ride Test)]' WHERE `locale` = 'deDE' AND `entry` = 27397;
-- OLD name : The Perfect Dissemblance Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27419
UPDATE `creature_template_locale` SET `Name` = '[The Perfect Dissemblance Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27419;
-- OLD name : Rothins nekromantisches Runenhäschen
-- Source : https://www.wowhead.com/wotlk/de/npc=27420
UPDATE `creature_template_locale` SET `Name` = '[Rothin''s Necromantic Rune Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27420;
-- OLD name : Commander Jordan Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27426
UPDATE `creature_template_locale` SET `Name` = '[Commander Jordan Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27426;
-- OLD name : Lead Cannoneer Zierhut Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27427
UPDATE `creature_template_locale` SET `Name` = '[Lead Cannoneer Zierhut Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27427;
-- OLD name : Blacksmith Goodman Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27428
UPDATE `creature_template_locale` SET `Name` = '[Blacksmith Goodman Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27428;
-- OLD name : Stable Master Mercer Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27429
UPDATE `creature_template_locale` SET `Name` = '[Stable Master Mercer Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27429;
-- OLD name : Bild eines Scharlachroten Rabenpriesters - Weibliche Transformation
-- Source : https://www.wowhead.com/wotlk/de/npc=27442
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Raven Priest Image - Female Transform]' WHERE `locale` = 'deDE' AND `entry` = 27442;
-- OLD name : Bild eines Scharlachroten Rabenpriesters - Männliche Transformation
-- Source : https://www.wowhead.com/wotlk/de/npc=27443
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Raven Priest Image - Male Transform]' WHERE `locale` = 'deDE' AND `entry` = 27443;
-- OLD name : A Fall from Grace High Abbot Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27444
UPDATE `creature_template_locale` SET `Name` = '[A Fall from Grace High Abbot Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27444;
-- OLD name : A Fall from Grace Bell Rung Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27445
UPDATE `creature_template_locale` SET `Name` = '[A Fall from Grace Bell Rung Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27445;
-- OLD name : Sprungvehikel des Hohen Abtes Landgren
-- Source : https://www.wowhead.com/wotlk/de/npc=27446
UPDATE `creature_template_locale` SET `Name` = '[High Abbot Landgren''s Jump Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 27446;
-- OLD name : Blue Sky Kill Credit Bunny - Grizzly Hills
-- Source : https://www.wowhead.com/wotlk/de/npc=27453
UPDATE `creature_template_locale` SET `Name` = '[Blue Sky Kill Credit Bunny - Grizzly Hills]' WHERE `locale` = 'deDE' AND `entry` = 27453;
-- OLD name : Kill Credit Bunny - Wounded Skirmishers
-- Source : https://www.wowhead.com/wotlk/de/npc=27466
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Wounded Skirmishers]' WHERE `locale` = 'deDE' AND `entry` = 27466;
-- OLD name : Forgotten Rifleman Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27471
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Rifleman Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 27471;
-- OLD name : Forgotten Peasant Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27472
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Peasant Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 27472;
-- OLD name : Forgotten Knight Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27473
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Knight Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 27473;
-- OLD name : Captain Luc D'Merud Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27474
UPDATE `creature_template_locale` SET `Name` = '[Captain Luc D''Merud Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 27474;
-- OLD name : Greifentaxi
-- Source : https://www.wowhead.com/wotlk/de/npc=27491
UPDATE `creature_template_locale` SET `Name` = '[Gryphon Taxi (Howling Fjord -> Dragonblight - DND)]' WHERE `locale` = 'deDE' AND `entry` = 27491;
-- OLD name : Greifenreiter von Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=27504
UPDATE `creature_template_locale` SET `Name` = '[Northrend Gryphon Rider]' WHERE `locale` = 'deDE' AND `entry` = 27504;
-- OLD name : Aufgezogener Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=27505
UPDATE `creature_template_locale` SET `Name` = '[Raised Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 27505;
-- OLD name : Gaststättenratte
-- Source : https://www.wowhead.com/wotlk/de/npc=27522
UPDATE `creature_template_locale` SET `Name` = '[Inn Rat]' WHERE `locale` = 'deDE' AND `entry` = 27522;
-- OLD name : Weißer gepanzerter Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=27526
UPDATE `creature_template_locale` SET `Name` = '[White Armored Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 27526;
-- OLD name : Clayton Dubin - TEST COPY DATA, subname : Quality Assured
-- Source : https://www.wowhead.com/wotlk/de/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'deDE','[Clayton Dubin - TEST COPY DATA]','[Quality Assured]');
-- OLD name : Pinguin
-- Source : https://www.wowhead.com/wotlk/de/npc=27548
UPDATE `creature_template_locale` SET `Name` = '[Penguin, Northrend]' WHERE `locale` = 'deDE' AND `entry` = 27548;
-- OLD name : Undead Miner Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27561
UPDATE `creature_template_locale` SET `Name` = '[Undead Miner Credit]' WHERE `locale` = 'deDE' AND `entry` = 27561;
-- OLD name : Zenturio Kaggrum
-- Source : https://www.wowhead.com/wotlk/de/npc=27563
UPDATE `creature_template_locale` SET `Name` = 'Zenturion Kaggrum' WHERE `locale` = 'deDE' AND `entry` = 27563;
-- OLD name : Ställe der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=27568
UPDATE `creature_template_locale` SET `Name` = '[Venture Co. Stables]' WHERE `locale` = 'deDE' AND `entry` = 27568;
-- OLD name : Lord Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/de/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Lord Devrestrasz' WHERE `locale` = 'deDE' AND `entry` = 27575;
-- OLD name : Beschwörungsziel von Novos
-- Source : https://www.wowhead.com/wotlk/de/npc=27583
UPDATE `creature_template_locale` SET `Name` = '[Novos Summon Target]' WHERE `locale` = 'deDE' AND `entry` = 27583;
-- OLD name : QA Testdummy 80 Normal, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27586
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Normal]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27586;
-- OLD name : QA Testdummy 80 Keine Rüstung, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27590
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 No Armor]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27590;
-- OLD name : QA Testdummy 80 Keine Rüstung, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27591
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 No Armor]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27591;
-- OLD name : QA Testdummy 83 Normal, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27592
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Normal]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27592;
-- OLD name : QA Testdummy 80 Hohe Magieresi, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27595
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 High Magic Resist]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27595;
-- OLD name : QA Testdummy 83 Hohe Magieresi, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27596
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 High Magic Resist]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27596;
-- OLD name : QA Testdummy 80 Statischer Schaden, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27599
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Fixed Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27599;
-- OLD name : QA Testdummy 83 Statischer Schaden, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27601
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Fixed Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27601;
-- OLD name : QA Testdummy 80 Zauberspammer, subname : QA Prügelknabe
-- Source : https://www.wowhead.com/wotlk/de/npc=27609
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Spell Spammer]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 27609;
-- OLD name : Totenbeschwörer von Jintha'kalar
-- Source : https://www.wowhead.com/wotlk/de/npc=27614
UPDATE `creature_template_locale` SET `Name` = '[Jintha''kalar Necromancer]' WHERE `locale` = 'deDE' AND `entry` = 27614;
-- OLD name : Abbild des Lichkönigs
-- Source : https://www.wowhead.com/wotlk/de/npc=27623
UPDATE `creature_template_locale` SET `Name` = '[Image of the Lich King]' WHERE `locale` = 'deDE' AND `entry` = 27623;
-- OLD name : Plague Wagon Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27625
UPDATE `creature_template_locale` SET `Name` = '[Plague Wagon Credit]' WHERE `locale` = 'deDE' AND `entry` = 27625;
-- OLD name : Tatjana, subname : Initiand des Wolfskults
-- Source : https://www.wowhead.com/wotlk/de/npc=27632
UPDATE `creature_template_locale` SET `Name` = '[Tatjana (Unconscious)]',`Title` = '[Wolfcult Initiate]' WHERE `locale` = 'deDE' AND `entry` = 27632;
-- OLD name : Wolfsgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=27634
UPDATE `creature_template_locale` SET `Name` = '[Wolf Spirit Visual (Ymirjar Dusk Shaman)]' WHERE `locale` = 'deDE' AND `entry` = 27634;
-- OLD name : Tempelrufer
-- Source : https://www.wowhead.com/wotlk/de/npc=27643
UPDATE `creature_template_locale` SET `Name` = '[Temple Caller]' WHERE `locale` = 'deDE' AND `entry` = 27643;
-- OLD name : Kill Credit Bunny - Venture Bay 01
-- Source : https://www.wowhead.com/wotlk/de/npc=27660
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Bunny - Venture Bay 01]' WHERE `locale` = 'deDE' AND `entry` = 27660;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27666
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 27666;
-- OLD name : Zauberatrappe von Novos
-- Source : https://www.wowhead.com/wotlk/de/npc=27669
UPDATE `creature_template_locale` SET `Name` = '[Novos Spell Dummy]' WHERE `locale` = 'deDE' AND `entry` = 27669;
-- OLD name : Annäherungsmine
-- Source : https://www.wowhead.com/wotlk/de/npc=27679
UPDATE `creature_template_locale` SET `Name` = '[Proximity Mine]' WHERE `locale` = 'deDE' AND `entry` = 27679;
-- OLD name : Verteidiger des Wyrmruhtempels
-- Source : https://www.wowhead.com/wotlk/de/npc=27690
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Defender]' WHERE `locale` = 'deDE' AND `entry` = 27690;
-- OLD name : Spielerskelett
-- Source : https://www.wowhead.com/wotlk/de/npc=27694
UPDATE `creature_template_locale` SET `Name` = '[Player Skeleton [PH]]' WHERE `locale` = 'deDE' AND `entry` = 27694;
-- OLD name : Der Prophet Tharon'ja
-- Source : https://www.wowhead.com/wotlk/de/npc=27696
UPDATE `creature_template_locale` SET `Name` = '[The Prophet Tharon''ja ]' WHERE `locale` = 'deDE' AND `entry` = 27696;
-- OLD name : Reitkodo des Braufests
-- Source : https://www.wowhead.com/wotlk/de/npc=27706
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo des Brausfests' WHERE `locale` = 'deDE' AND `entry` = 27706;
-- OLD name : Goblin Rocket Mount Test
-- Source : https://www.wowhead.com/wotlk/de/npc=27710
UPDATE `creature_template_locale` SET `Name` = '[Goblin Rocket Mount Test]' WHERE `locale` = 'deDE' AND `entry` = 27710;
-- OLD name : Reitfledermaus der Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=27724
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Bat Mount (For Drakkari Invaders)]' WHERE `locale` = 'deDE' AND `entry` = 27724;
-- OLD name : Gorgonna
-- Source : https://www.wowhead.com/wotlk/de/npc=27726
UPDATE `creature_template_locale` SET `Name` = '[Gorgonna]' WHERE `locale` = 'deDE' AND `entry` = 27726;
-- OLD name : Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=27731
UPDATE `creature_template_locale` SET `Name` = 'Akolyt' WHERE `locale` = 'deDE' AND `entry` = 27731;
-- OLD name : Frostsäbelvehikel
-- Source : https://www.wowhead.com/wotlk/de/npc=27738
UPDATE `creature_template_locale` SET `Name` = '[Frostsabre Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 27738;
-- OLD name : Vehikelversion des Wildelekks
-- Source : https://www.wowhead.com/wotlk/de/npc=27740
UPDATE `creature_template_locale` SET `Name` = '[Wild Elekk Vehicle Version]' WHERE `locale` = 'deDE' AND `entry` = 27740;
-- OLD name : Currency Token Test Wizard
-- Source : https://www.wowhead.com/wotlk/de/npc=27741
UPDATE `creature_template_locale` SET `Name` = '[Currency Token Test Wizard]' WHERE `locale` = 'deDE' AND `entry` = 27741;
-- OLD name : Eindringling der Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=27754
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Invader]' WHERE `locale` = 'deDE' AND `entry` = 27754;
-- OLD name : Greif von Wintergarde
-- Source : https://www.wowhead.com/wotlk/de/npc=27764
UPDATE `creature_template_locale` SET `Name` = '[Wintergarde Gryphon (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 27764;
-- OLD name : Späherhauptmann Carter
-- Source : https://www.wowhead.com/wotlk/de/npc=27783
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Carter' WHERE `locale` = 'deDE' AND `entry` = 27783;
-- OLD name : Imperial Eagle Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27786
UPDATE `creature_template_locale` SET `Name` = '[Imperial Eagle Credit]' WHERE `locale` = 'deDE' AND `entry` = 27786;
-- OLD name : Worg's Blood Elixir Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27796
UPDATE `creature_template_locale` SET `Name` = '[Worg''s Blood Elixir Credit]' WHERE `locale` = 'deDE' AND `entry` = 27796;
-- OLD name : Orb Target Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27802
UPDATE `creature_template_locale` SET `Name` = '[Orb Target Credit]' WHERE `locale` = 'deDE' AND `entry` = 27802;
-- OLD name : Bierschankwirtin
-- Source : https://www.wowhead.com/wotlk/de/npc=27819
UPDATE `creature_template_locale` SET `Name` = 'Bierschankwirt' WHERE `locale` = 'deDE' AND `entry` = 27819;
-- OLD name : Stellvertretende Mausoleumsgeißel
-- Source : https://www.wowhead.com/wotlk/de/npc=27825
UPDATE `creature_template_locale` SET `Name` = '[Mausoleum Scourge Proxy]' WHERE `locale` = 'deDE' AND `entry` = 27825;
-- OLD name : Glengarry Adams, subname : 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=27833
UPDATE `creature_template_locale` SET `Name` = '[Glengarry Adams]',`Title` = '[7th Legion]' WHERE `locale` = 'deDE' AND `entry` = 27833;
-- OLD name : Schattengeistwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=27834
UPDATE `creature_template_locale` SET `Name` = '[Shadowfiend Guardian]' WHERE `locale` = 'deDE' AND `entry` = 27834;
-- OLD name : Kampfflugzeug von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=27838
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Fighter Plane]' WHERE `locale` = 'deDE' AND `entry` = 27838;
-- OLD name : Greif von Wintergarde
-- Source : https://www.wowhead.com/wotlk/de/npc=27841
UPDATE `creature_template_locale` SET `Name` = '[Wintergarde Gryphon (NPC Mount)]' WHERE `locale` = 'deDE' AND `entry` = 27841;
-- OLD name : Schattenleere
-- Source : https://www.wowhead.com/wotlk/de/npc=27847
UPDATE `creature_template_locale` SET `Name` = '[Shadow Void]' WHERE `locale` = 'deDE' AND `entry` = 27847;
-- OLD name : Bomber von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=27850
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Bomber]' WHERE `locale` = 'deDE' AND `entry` = 27850;
-- OLD name : Fahrzeug der verpesteten Zombies
-- Source : https://www.wowhead.com/wotlk/de/npc=27854
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie Vehicle - TEST]' WHERE `locale` = 'deDE' AND `entry` = 27854;
-- OLD name : Patty's test vehicle TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=27862
UPDATE `creature_template_locale` SET `Name` = '[Patty''s test vehicle]' WHERE `locale` = 'deDE' AND `entry` = 27862;
-- OLD name : Rubinblüten
-- Source : https://www.wowhead.com/wotlk/de/npc=27863
UPDATE `creature_template_locale` SET `Name` = '[Ruby Flowers]' WHERE `locale` = 'deDE' AND `entry` = 27863;
-- OLD name : Fangkrallenworgverkleidung
-- Source : https://www.wowhead.com/wotlk/de/npc=27864
UPDATE `creature_template_locale` SET `Name` = '[Fanggore Worg Disguise]' WHERE `locale` = 'deDE' AND `entry` = 27864;
-- OLD name : Verseuchtes Haustier
-- Source : https://www.wowhead.com/wotlk/de/npc=27865
UPDATE `creature_template_locale` SET `Name` = '[Plagued Pet]' WHERE `locale` = 'deDE' AND `entry` = 27865;
-- OLD name : Reitwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=27873
UPDATE `creature_template_locale` SET `Name` = '[Kor''kron Wyvern Mount (Wrathgate)]' WHERE `locale` = 'deDE' AND `entry` = 27873;
-- OLD name : Onslaught Base Camp Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=27875
UPDATE `creature_template_locale` SET `Name` = '[Onslaught Base Camp Proxy]' WHERE `locale` = 'deDE' AND `entry` = 27875;
-- OLD name : Landmine von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=27878
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Land Mine]' WHERE `locale` = 'deDE' AND `entry` = 27878;
-- OLD name : Frostmourne Cavern Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=27879
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Cavern Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 27879;
-- OLD name : Waffenhalter von Frostgram
-- Source : https://www.wowhead.com/wotlk/de/npc=27880
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Weapon Holder]' WHERE `locale` = 'deDE' AND `entry` = 27880;
-- OLD name : Gebräublase
-- Source : https://www.wowhead.com/wotlk/de/npc=27882
UPDATE `creature_template_locale` SET `Name` = 'Bierblase' WHERE `locale` = 'deDE' AND `entry` = 27882;
-- OLD name : Schredder von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=27883
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Shredder]' WHERE `locale` = 'deDE' AND `entry` = 27883;
-- OLD name : Taking Wing Timer Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27889
UPDATE `creature_template_locale` SET `Name` = '[Taking Wing Timer Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27889;
-- OLD name : Feuerklagegeist
-- Source : https://www.wowhead.com/wotlk/de/npc=27895
UPDATE `creature_template_locale` SET `Name` = '[Fire Revenant, Northrend]' WHERE `locale` = 'deDE' AND `entry` = 27895;
-- OLD name : Bombercockpit von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=27905
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Bomber Cockpit]' WHERE `locale` = 'deDE' AND `entry` = 27905;
-- OLD name : World Death Knight Trainer, subname : Todesritterlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27916
UPDATE `creature_template_locale` SET `Name` = '[World Deathknight Trainer]',`Title` = '[Deathknight Trainer]' WHERE `locale` = 'deDE' AND `entry` = 27916;
-- OLD name : Rekrutierer der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=27917
UPDATE `creature_template_locale` SET `Name` = '[Alliance Recruiter]' WHERE `locale` = 'deDE' AND `entry` = 27917;
-- OLD name : Rekrutierer der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=27918
UPDATE `creature_template_locale` SET `Name` = '[Horde Recruiter]' WHERE `locale` = 'deDE' AND `entry` = 27918;
-- OLD name : Herold der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=27919
UPDATE `creature_template_locale` SET `Name` = '[Herald of the Horde]' WHERE `locale` = 'deDE' AND `entry` = 27919;
-- OLD name : Herold der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=27920
UPDATE `creature_template_locale` SET `Name` = '[Herald of the Alliance]' WHERE `locale` = 'deDE' AND `entry` = 27920;
-- OLD name : Drakuru Handshake KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27921
UPDATE `creature_template_locale` SET `Name` = '[Drakuru Handshake KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27921;
-- OLD name : Mummified Carcass KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27929
UPDATE `creature_template_locale` SET `Name` = '[Mummified Carcass KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27929;
-- OLD name : Orf der Steuermann
-- Source : https://www.wowhead.com/wotlk/de/npc=27937
UPDATE `creature_template_locale` SET `Name` = '[Orf the Helmsman]' WHERE `locale` = 'deDE' AND `entry` = 27937;
-- OLD name : Ice Spike Trigger
-- Source : https://www.wowhead.com/wotlk/de/npc=27942
UPDATE `creature_template_locale` SET `Name` = '[Ice Spike Trigger]' WHERE `locale` = 'deDE' AND `entry` = 27942;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (rot)
-- Source : https://www.wowhead.com/wotlk/de/npc=27952
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Red)]' WHERE `locale` = 'deDE' AND `entry` = 27952;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (grün)
-- Source : https://www.wowhead.com/wotlk/de/npc=27954
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Green)]' WHERE `locale` = 'deDE' AND `entry` = 27954;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (bronze)
-- Source : https://www.wowhead.com/wotlk/de/npc=27955
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Bronze)]' WHERE `locale` = 'deDE' AND `entry` = 27955;
-- OLD name : Dan's Test Turret
-- Source : https://www.wowhead.com/wotlk/de/npc=27956
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Turret]' WHERE `locale` = 'deDE' AND `entry` = 27956;
-- OLD name : Dunkler Runenbewahrer, subname : PH MODEL: TASK 17271
-- Source : https://www.wowhead.com/wotlk/de/npc=27968
UPDATE `creature_template_locale` SET `Name` = '[Dark Rune Keeper [PH]]',`Title` = '[PH MODEL: TASK 17271]' WHERE `locale` = 'deDE' AND `entry` = 27968;
-- OLD name : Prototyp der Flugscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27991
UPDATE `creature_template_locale` SET `Name` = '[Flying Disc Prototype]' WHERE `locale` = 'deDE' AND `entry` = 27991;
-- OLD name : The Gearmaster's Manual Researched Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=27995
UPDATE `creature_template_locale` SET `Name` = '[The Gearmaster''s Manual Researched Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 27995;
-- OLD name : Test-PvP-Questgeber
-- Source : https://www.wowhead.com/wotlk/de/npc=27997
UPDATE `creature_template_locale` SET `Name` = '[Test PvP Questgiver]' WHERE `locale` = 'deDE' AND `entry` = 27997;
-- OLD name : Antioks Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=28007
UPDATE `creature_template_locale` SET `Name` = '[Antiok''s Mount]' WHERE `locale` = 'deDE' AND `entry` = 28007;
-- OLD name : Fire Upon the Waters Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28013
UPDATE `creature_template_locale` SET `Name` = '[Fire Upon the Waters Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28013;
-- OLD name : Escape from Silverbrook Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28019
UPDATE `creature_template_locale` SET `Name` = '[Escape from Silverbrook Credit]' WHERE `locale` = 'deDE' AND `entry` = 28019;
-- OLD name : Bezwinger den Wyrmruhtempels (Knochen)
-- Source : https://www.wowhead.com/wotlk/de/npc=28021
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Vanquisher (Bones)]' WHERE `locale` = 'deDE' AND `entry` = 28021;
-- OLD name : Verrottende Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=28023
UPDATE `creature_template_locale` SET `Name` = 'Verrottende Montrosität' WHERE `locale` = 'deDE' AND `entry` = 28023;
-- OLD name : Die Geist von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=28037
UPDATE `creature_template_locale` SET `Name` = 'Die ''Geist von Gnomeregan''' WHERE `locale` = 'deDE' AND `entry` = 28037;
-- OLD subname : Geißel der Südlichen Meere (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=28048
UPDATE `creature_template_locale` SET `Title` = 'Geißel der südlichen Meere' WHERE `locale` = 'deDE' AND `entry` = 28048;
-- OLD name : Ol' Chumbucket
-- Source : https://www.wowhead.com/wotlk/de/npc=28050
UPDATE `creature_template_locale` SET `Name` = 'Der Alte Fischkübel' WHERE `locale` = 'deDE' AND `entry` = 28050;
-- OLD name : Cap'n Slappy
-- Source : https://www.wowhead.com/wotlk/de/npc=28051
UPDATE `creature_template_locale` SET `Name` = 'Käpt''n Slappy' WHERE `locale` = 'deDE' AND `entry` = 28051;
-- OLD name : Saphirblaue Schwarmdrohne
-- Source : https://www.wowhead.com/wotlk/de/npc=28085
UPDATE `creature_template_locale` SET `Name` = 'Saphirblaue Schwarmdrone' WHERE `locale` = 'deDE' AND `entry` = 28085;
-- OLD name : Moveto Test - Bewegungen, subname : Expeditionsleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=28088
UPDATE `creature_template_locale` SET `Name` = '[Moveto Test - Moves]',`Title` = '[Expedition Leader]' WHERE `locale` = 'deDE' AND `entry` = 28088;
-- OLD name : Theresas Frostsäblergefährt
-- Source : https://www.wowhead.com/wotlk/de/npc=28119
UPDATE `creature_template_locale` SET `Name` = '[TEST- Theresa''s frostsaber vehicle]' WHERE `locale` = 'deDE' AND `entry` = 28119;
-- OLD name : Nahrung der Grannenkiefer
-- Source : https://www.wowhead.com/wotlk/de/npc=28128
UPDATE `creature_template_locale` SET `Name` = '[Bristlepine Food Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28128;
-- OLD name : Hirnlose Entartung (nicht tötbar)
-- Source : https://www.wowhead.com/wotlk/de/npc=28144
UPDATE `creature_template_locale` SET `Name` = '[Mindless Aberration (Unkillable)]' WHERE `locale` = 'deDE' AND `entry` = 28144;
-- OLD name : Geißelherzdrakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=28159
UPDATE `creature_template_locale` SET `Name` = '[Scourgeheart Drakkari]' WHERE `locale` = 'deDE' AND `entry` = 28159;
-- OLD name : Kunz' Schlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=28172
UPDATE `creature_template_locale` SET `Name` = '[Kunz''s Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 28172;
-- OLD name : Trauerleere
-- Source : https://www.wowhead.com/wotlk/de/npc=28174
UPDATE `creature_template_locale` SET `Name` = '[Grief Void]' WHERE `locale` = 'deDE' AND `entry` = 28174;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=28177
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 28177;
-- OLD name : Venture Bay Kill Credit Bunny - Grizzly Hills
-- Source : https://www.wowhead.com/wotlk/de/npc=28190
UPDATE `creature_template_locale` SET `Name` = '[Venture Bay Kill Credit Bunny - Grizzly Hills]' WHERE `locale` = 'deDE' AND `entry` = 28190;
-- OLD name : Raketenwerfer
-- Source : https://www.wowhead.com/wotlk/de/npc=28198
UPDATE `creature_template_locale` SET `Name` = '[Rocket Launcher]' WHERE `locale` = 'deDE' AND `entry` = 28198;
-- OLD name : Hartknöchelmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=28213
UPDATE `creature_template_locale` SET `Name` = 'Hartknöchelmatriachin' WHERE `locale` = 'deDE' AND `entry` = 28213;
-- OLD name : Falltürkrabbler - Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28224
UPDATE `creature_template_locale` SET `Name` = '[Trapdoor Crawler Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28224;
-- OLD name : Blutgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=28232
UPDATE `creature_template_locale` SET `Name` = '[Sanguine Spirit]' WHERE `locale` = 'deDE' AND `entry` = 28232;
-- OLD name : Luftüberwachung der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=28241
UPDATE `creature_template_locale` SET `Name` = '[Venture Co. Air Patrol]' WHERE `locale` = 'deDE' AND `entry` = 28241;
-- OLD name : QA Test First Aid Trainer, subname : Sanitäter
-- Source : https://www.wowhead.com/wotlk/de/npc=28245
UPDATE `creature_template_locale` SET `Name` = '[QA Test First Aid Trainer]',`Title` = '[Medic]' WHERE `locale` = 'deDE' AND `entry` = 28245;
-- OLD name : Alchemist KC - Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28248
UPDATE `creature_template_locale` SET `Name` = '[Alchemist KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28248;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Schwarz)
-- Source : https://www.wowhead.com/wotlk/de/npc=28250
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Black)]' WHERE `locale` = 'deDE' AND `entry` = 28250;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Blau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28251
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Blue)]' WHERE `locale` = 'deDE' AND `entry` = 28251;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Nether)
-- Source : https://www.wowhead.com/wotlk/de/npc=28252
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Protector Visual (Nether)]' WHERE `locale` = 'deDE' AND `entry` = 28252;
-- OLD name : Besiegter Argentumfußsoldat (transformiert)
-- Source : https://www.wowhead.com/wotlk/de/npc=28259
UPDATE `creature_template_locale` SET `Name` = '[Defeated Argent Footman (Transform)]' WHERE `locale` = 'deDE' AND `entry` = 28259;
-- OLD name : Koyotengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=28267
UPDATE `creature_template_locale` SET `Name` = 'Kojotengeist' WHERE `locale` = 'deDE' AND `entry` = 28267;
-- OLD name : Flugmaschine
-- Source : https://www.wowhead.com/wotlk/de/npc=28269
UPDATE `creature_template_locale` SET `Name` = '[Flying Machine Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 28269;
-- OLD name : Geißel von Jintha'kalar (PROXY DO NOT SPAWN)
-- Source : https://www.wowhead.com/wotlk/de/npc=28270
UPDATE `creature_template_locale` SET `Name` = '[Jintha''kalar Scourge (PROXY DO NOT SPAWN)]' WHERE `locale` = 'deDE' AND `entry` = 28270;
-- OLD name : Glacial Breach Scourge Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28271
UPDATE `creature_template_locale` SET `Name` = '[Glacial Breach Scourge Credit]' WHERE `locale` = 'deDE' AND `entry` = 28271;
-- OLD name : Gefräßiger Seuchenhund
-- Source : https://www.wowhead.com/wotlk/de/npc=28278
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Plaguehound]' WHERE `locale` = 'deDE' AND `entry` = 28278;
-- OLD name : Belohnung für Seuchenspritzers Tod
-- Source : https://www.wowhead.com/wotlk/de/npc=28289
UPDATE `creature_template_locale` SET `Name` = '[Plague Sprayer Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28289;
-- OLD name : Schlammige Moormaden - KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28293
UPDATE `creature_template_locale` SET `Name` = '[Muddy Mire Maggot KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28293;
-- OLD name : Getrockneter Fledermausflügel
-- Source : https://www.wowhead.com/wotlk/de/npc=28294
UPDATE `creature_template_locale` SET `Name` = '[Withered Batwing KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28294;
-- OLD name : Bernsteinsamen - KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28295
UPDATE `creature_template_locale` SET `Name` = '[Amberseed KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28295;
-- OLD name : Gekühlter Schlangenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=28296
UPDATE `creature_template_locale` SET `Name` = '[Chilled Serpent Mucus KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28296;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=28306
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone' WHERE `locale` = 'deDE' AND `entry` = 28306;
-- OLD name : QA Test Dummy 80 Buff Spammer, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/de/npc=28310
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Buff Spammer]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 28310;
-- OLD name : QA Test Dummy 80 Spell Reflector, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/de/npc=28311
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Spell Reflector]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 28311;
-- OLD name : Besiegter Argentumfußsoldat
-- Source : https://www.wowhead.com/wotlk/de/npc=28316
UPDATE `creature_template_locale` SET `Name` = '[Defeated Argent Footman KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28316;
-- OLD name : Entflohener Gladiator
-- Source : https://www.wowhead.com/wotlk/de/npc=28322
UPDATE `creature_template_locale` SET `Name` = '[Escaped Gladiator]' WHERE `locale` = 'deDE' AND `entry` = 28322;
-- OLD name : Auferstandener Vrykulberserker
-- Source : https://www.wowhead.com/wotlk/de/npc=28349
UPDATE `creature_template_locale` SET `Name` = '[Risen Vrykul Berserker]' WHERE `locale` = 'deDE' AND `entry` = 28349;
-- OLD name : Auferstandener Vrykulmagus
-- Source : https://www.wowhead.com/wotlk/de/npc=28350
UPDATE `creature_template_locale` SET `Name` = '[Risen Vrykul Magus]' WHERE `locale` = 'deDE' AND `entry` = 28350;
-- OLD name : Seuchenverbreiter der Verlassenen (Rot)
-- Source : https://www.wowhead.com/wotlk/de/npc=28353
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Blightspreader (Red)]' WHERE `locale` = 'deDE' AND `entry` = 28353;
-- OLD name : Wissenschaftler der Verlassenen (Seuchenrucksack)
-- Source : https://www.wowhead.com/wotlk/de/npc=28354
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Scientist (Blight Backpack)]' WHERE `locale` = 'deDE' AND `entry` = 28354;
-- OLD name : Kurbelzischs Flugtaxi
-- Source : https://www.wowhead.com/wotlk/de/npc=28360
UPDATE `creature_template_locale` SET `Name` = '[Riding Fizzcrank Flyer Taxi]' WHERE `locale` = 'deDE' AND `entry` = 28360;
-- OLD name : Drachenfalke
-- Source : https://www.wowhead.com/wotlk/de/npc=28361
UPDATE `creature_template_locale` SET `Name` = '[Riding Dragonhawk (A)]' WHERE `locale` = 'deDE' AND `entry` = 28361;
-- OLD name : Großer Kampfbär
-- Source : https://www.wowhead.com/wotlk/de/npc=28363
UPDATE `creature_template_locale` SET `Name` = 'Großer Kriegsbär' WHERE `locale` = 'deDE' AND `entry` = 28363;
-- OLD name : Slims Testmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=28364
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Mage]' WHERE `locale` = 'deDE' AND `entry` = 28364;
-- OLD name : Slims Testhexenmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=28365
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Warlock]' WHERE `locale` = 'deDE' AND `entry` = 28365;
-- OLD name : Belagerungsingenieur der 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=28370
UPDATE `creature_template_locale` SET `Name` = '[7th Legion Siege Engineer (DVD)]' WHERE `locale` = 'deDE' AND `entry` = 28370;
-- OLD name : TR (Mensch, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28395
UPDATE `creature_template_locale` SET `Name` = '[DK (Human Male)]' WHERE `locale` = 'deDE' AND `entry` = 28395;
-- OLD name : Lederverarbeitungslehrer von Nordend, subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28400
UPDATE `creature_template_locale` SET `Name` = '[Northrend Leatherworking Trainer]',`Title` = '[Leatherworking Trainer]' WHERE `locale` = 'deDE' AND `entry` = 28400;
-- OLD name : TR (Mensch, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28420
UPDATE `creature_template_locale` SET `Name` = '[DK (Human Female)]' WHERE `locale` = 'deDE' AND `entry` = 28420;
-- OLD name : TR (Zwerg, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28421
UPDATE `creature_template_locale` SET `Name` = '[DK (Dwarf Female)]' WHERE `locale` = 'deDE' AND `entry` = 28421;
-- OLD name : TR (Gnom, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28422
UPDATE `creature_template_locale` SET `Name` = '[DK (Gnome Female)]' WHERE `locale` = 'deDE' AND `entry` = 28422;
-- OLD name : TR (Nachtelf, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28423
UPDATE `creature_template_locale` SET `Name` = '[DK (Night Elf Female)]' WHERE `locale` = 'deDE' AND `entry` = 28423;
-- OLD name : TR (Draenei, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28424
UPDATE `creature_template_locale` SET `Name` = '[DK (Draenei Female)]' WHERE `locale` = 'deDE' AND `entry` = 28424;
-- OLD name : TR (Zwerg, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28425
UPDATE `creature_template_locale` SET `Name` = '[DK (Dwarf Male)]' WHERE `locale` = 'deDE' AND `entry` = 28425;
-- OLD name : TR (Gnom, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28426
UPDATE `creature_template_locale` SET `Name` = '[DK (Gnome Male)]' WHERE `locale` = 'deDE' AND `entry` = 28426;
-- OLD name : TR (Nachtelf, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28427
UPDATE `creature_template_locale` SET `Name` = '[DK (Night Elf Male)]' WHERE `locale` = 'deDE' AND `entry` = 28427;
-- OLD name : TR (Draenei, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28428
UPDATE `creature_template_locale` SET `Name` = '[DK (Draenei Male)]' WHERE `locale` = 'deDE' AND `entry` = 28428;
-- OLD name : TR (Blutelf, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28429
UPDATE `creature_template_locale` SET `Name` = '[DK (Blood Elf Male)]' WHERE `locale` = 'deDE' AND `entry` = 28429;
-- OLD name : TR (Orc, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28430
UPDATE `creature_template_locale` SET `Name` = '[DK (Orc Male)]' WHERE `locale` = 'deDE' AND `entry` = 28430;
-- OLD name : TR (Verlassener, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28431
UPDATE `creature_template_locale` SET `Name` = '[DK (Forsaken Male)]' WHERE `locale` = 'deDE' AND `entry` = 28431;
-- OLD name : TR (Troll, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28432
UPDATE `creature_template_locale` SET `Name` = '[DK (Troll Male)]' WHERE `locale` = 'deDE' AND `entry` = 28432;
-- OLD name : TR (Tauren, Mann)
-- Source : https://www.wowhead.com/wotlk/de/npc=28433
UPDATE `creature_template_locale` SET `Name` = '[DK (Tauren Male)]' WHERE `locale` = 'deDE' AND `entry` = 28433;
-- OLD name : TR (Blutelf, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28434
UPDATE `creature_template_locale` SET `Name` = '[DK (Blood Elf Female)]' WHERE `locale` = 'deDE' AND `entry` = 28434;
-- OLD name : TR (Troll, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28435
UPDATE `creature_template_locale` SET `Name` = '[DK (Troll Female)]' WHERE `locale` = 'deDE' AND `entry` = 28435;
-- OLD name : TR (Orc, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28436
UPDATE `creature_template_locale` SET `Name` = '[DK (Orc Female)]' WHERE `locale` = 'deDE' AND `entry` = 28436;
-- OLD name : TR (Verlassener, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28437
UPDATE `creature_template_locale` SET `Name` = '[DK (Forsaken Female)]' WHERE `locale` = 'deDE' AND `entry` = 28437;
-- OLD name : TR (Tauren, Frau)
-- Source : https://www.wowhead.com/wotlk/de/npc=28438
UPDATE `creature_template_locale` SET `Name` = '[DK (Tauren Female)]' WHERE `locale` = 'deDE' AND `entry` = 28438;
-- OLD name : Großer Uhu
-- Source : https://www.wowhead.com/wotlk/de/npc=28441
UPDATE `creature_template_locale` SET `Name` = '[Great Horned Owl Hover Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28441;
-- OLD name : Entfesseltes Streitross
-- Source : https://www.wowhead.com/wotlk/de/npc=28450
UPDATE `creature_template_locale` SET `Name` = '[Unbound Charger]' WHERE `locale` = 'deDE' AND `entry` = 28450;
-- OLD name : Riding Horse (Vehicle Demo)
-- Source : https://www.wowhead.com/wotlk/de/npc=28453
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Vehicle Demo)]' WHERE `locale` = 'deDE' AND `entry` = 28453;
-- OLD name : Runenklingenaxt
-- Source : https://www.wowhead.com/wotlk/de/npc=28475
UPDATE `creature_template_locale` SET `Name` = '[Runebladed Axe]' WHERE `locale` = 'deDE' AND `entry` = 28475;
-- OLD name : Avatar von Freya
-- Source : https://www.wowhead.com/wotlk/de/npc=28482
UPDATE `creature_template_locale` SET `Name` = '[Avatar of Freya Conversation Credit]' WHERE `locale` = 'deDE' AND `entry` = 28482;
-- OLD name : Runenschmied
-- Source : https://www.wowhead.com/wotlk/de/npc=28483
UPDATE `creature_template_locale` SET `Name` = '[Runeforge (SW)]' WHERE `locale` = 'deDE' AND `entry` = 28483;
-- OLD name : Sindragosa, subname : Die Königin der Frostbrut
-- Source : https://www.wowhead.com/wotlk/de/npc=28499
UPDATE `creature_template_locale` SET `Name` = '[Sindragosa]',`Title` = '[Queen of the Frostbrood]' WHERE `locale` = 'deDE' AND `entry` = 28499;
-- OLD name : Ronakada, subname : Blademaster
-- Source : https://www.wowhead.com/wotlk/de/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'deDE','[Ronakada]','[Blademaster]');
-- OLD name : Summon Vision Test - LAB
-- Source : https://www.wowhead.com/wotlk/de/npc=28507
UPDATE `creature_template_locale` SET `Name` = '[Summon Vision Test - LAB]' WHERE `locale` = 'deDE' AND `entry` = 28507;
-- OLD name : Gebäude
-- Source : https://www.wowhead.com/wotlk/de/npc=28509
UPDATE `creature_template_locale` SET `Name` = '[Building (CoT Stratholme)]' WHERE `locale` = 'deDE' AND `entry` = 28509;
-- OLD name : Hair Sample KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28520
UPDATE `creature_template_locale` SET `Name` = '[Hair Sample KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28520;
-- OLD name : Frostwyrmreittier
-- Source : https://www.wowhead.com/wotlk/de/npc=28531
UPDATE `creature_template_locale` SET `Name` = '[Frost Wyrm Mount]' WHERE `locale` = 'deDE' AND `entry` = 28531;
-- OLD name : Reitpferd
-- Source : https://www.wowhead.com/wotlk/de/npc=28533
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Scarlet Commander)]' WHERE `locale` = 'deDE' AND `entry` = 28533;
-- OLD name : Destillo-matik 5000
-- Source : https://www.wowhead.com/wotlk/de/npc=28545
UPDATE `creature_template_locale` SET `Name` = '[Distillo-matic 5000]' WHERE `locale` = 'deDE' AND `entry` = 28545;
-- OLD name : Kapitän Shely
-- Source : https://www.wowhead.com/wotlk/de/npc=28549
UPDATE `creature_template_locale` SET `Name` = 'Hauptmann Shely' WHERE `locale` = 'deDE' AND `entry` = 28549;
-- OLD name : Großknecht Kaleiki
-- Source : https://www.wowhead.com/wotlk/de/npc=28552
UPDATE `creature_template_locale` SET `Name` = 'Großknecht Kaileki' WHERE `locale` = 'deDE' AND `entry` = 28552;
-- OLD name : Folterer LeCraft
-- Source : https://www.wowhead.com/wotlk/de/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Folterer Alphonse' WHERE `locale` = 'deDE' AND `entry` = 28554;
-- OLD name : Wasserfontäne
-- Source : https://www.wowhead.com/wotlk/de/npc=28567
UPDATE `creature_template_locale` SET `Name` = 'Wasserstrahl' WHERE `locale` = 'deDE' AND `entry` = 28567;
-- OLD name : Geißelverkleidung
-- Source : https://www.wowhead.com/wotlk/de/npc=28570
UPDATE `creature_template_locale` SET `Name` = '[Scourge Disguise]' WHERE `locale` = 'deDE' AND `entry` = 28570;
-- OLD name : Maurermeisterin van der Gülden
-- Source : https://www.wowhead.com/wotlk/de/npc=28572
UPDATE `creature_template_locale` SET `Name` = 'Maurermeister van der Gülden' WHERE `locale` = 'deDE' AND `entry` = 28572;
-- OLD name : Corpse Explosion Rubble
-- Source : https://www.wowhead.com/wotlk/de/npc=28590
UPDATE `creature_template_locale` SET `Name` = '[Corpse Explosion Rubble]' WHERE `locale` = 'deDE' AND `entry` = 28590;
-- OLD name : Freyas Horn Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28595
UPDATE `creature_template_locale` SET `Name` = '[Freya''s Horn Credit]' WHERE `locale` = 'deDE' AND `entry` = 28595;
-- OLD name : Akolyth der Todeshand
-- Source : https://www.wowhead.com/wotlk/de/npc=28602
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Todeshand' WHERE `locale` = 'deDE' AND `entry` = 28602;
-- OLD name : Wolfsreiter von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=28613
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Wolf Rider]' WHERE `locale` = 'deDE' AND `entry` = 28613;
-- OLD name : Reitpferd
-- Source : https://www.wowhead.com/wotlk/de/npc=28620
UPDATE `creature_template_locale` SET `Name` = '[Riding Horse (Charger, Default Run Speed)]' WHERE `locale` = 'deDE' AND `entry` = 28620;
-- OLD name : Grauson Eisenschwinge, subname : Flugmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=28621
UPDATE `creature_template_locale` SET `Name` = '[Grayson Ironwing]',`Title` = '[Flight Master]' WHERE `locale` = 'deDE' AND `entry` = 28621;
-- OLD name : Scalps! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28622
UPDATE `creature_template_locale` SET `Name` = '[Scalps! Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28622;
-- OLD name : Gyrokopter
-- Source : https://www.wowhead.com/wotlk/de/npc=28625
UPDATE `creature_template_locale` SET `Name` = '[Riding Gyrocopter (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 28625;
-- OLD name : Scharlachroter Arbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=28626
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Peasant (Logs Transform Visual)]' WHERE `locale` = 'deDE' AND `entry` = 28626;
-- OLD name : Slims Testpriester
-- Source : https://www.wowhead.com/wotlk/de/npc=28628
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Priest]' WHERE `locale` = 'deDE' AND `entry` = 28628;
-- OLD name : Slims Testkrieger
-- Source : https://www.wowhead.com/wotlk/de/npc=28629
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Test Warrior]' WHERE `locale` = 'deDE' AND `entry` = 28629;
-- OLD name : Drakuru KC Bunny 01
-- Source : https://www.wowhead.com/wotlk/de/npc=28631
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 01]' WHERE `locale` = 'deDE' AND `entry` = 28631;
-- OLD name : Geisterwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=28635
UPDATE `creature_template_locale` SET `Name` = '[Spirit Wolf]' WHERE `locale` = 'deDE' AND `entry` = 28635;
-- OLD name : Mosswalker Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28644
UPDATE `creature_template_locale` SET `Name` = '[Mosswalker Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 28644;
-- OLD name : Vics selbstreplizierende Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=28645
UPDATE `creature_template_locale` SET `Name` = '[Vic''s Self Replicating Abomination (DND)]' WHERE `locale` = 'deDE' AND `entry` = 28645;
-- OLD name : Mysteriöser Zigeuner
-- Source : https://www.wowhead.com/wotlk/de/npc=28652
UPDATE `creature_template_locale` SET `Name` = '[Mysterious Gypsy]' WHERE `locale` = 'deDE' AND `entry` = 28652;
-- OLD name : Gorebag KC Bunny 01
-- Source : https://www.wowhead.com/wotlk/de/npc=28663
UPDATE `creature_template_locale` SET `Name` = '[Gorebag KC Bunny 01]' WHERE `locale` = 'deDE' AND `entry` = 28663;
-- OLD name : Seat Squatter - LAB
-- Source : https://www.wowhead.com/wotlk/de/npc=28664
UPDATE `creature_template_locale` SET `Name` = '[Seat Squatter - LAB]' WHERE `locale` = 'deDE' AND `entry` = 28664;
-- OLD name : Kassiererin Halder, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=28678
UPDATE `creature_template_locale` SET `Name` = '[Teller Halder]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 28678;
-- OLD name : Kassiererin Duta, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=28679
UPDATE `creature_template_locale` SET `Name` = '[Teller Duta]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 28679;
-- OLD name : Kassierer Banner, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=28680
UPDATE `creature_template_locale` SET `Name` = '[Teller Banning]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 28680;
-- OLD name : Scharlachroter Stallknecht
-- Source : https://www.wowhead.com/wotlk/de/npc=28689
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Stablehand]' WHERE `locale` = 'deDE' AND `entry` = 28689;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 28693;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 28694;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28696
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei' WHERE `locale` = 'deDE' AND `entry` = 28696;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28697
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 28697;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus' WHERE `locale` = 'deDE' AND `entry` = 28698;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 28699;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28700
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 28700;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 28701;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 28702;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 28703;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde' WHERE `locale` = 'deDE' AND `entry` = 28704;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 28705;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin für Erste Hilfe' WHERE `locale` = 'deDE' AND `entry` = 28706;
-- OLD name : Untoter Adler
-- Source : https://www.wowhead.com/wotlk/de/npc=28711
UPDATE `creature_template_locale` SET `Name` = '[Undead Eagle]' WHERE `locale` = 'deDE' AND `entry` = 28711;
-- OLD name : Einfache Plünderpiñata, subname : Schlag mich!
-- Source : https://www.wowhead.com/wotlk/de/npc=28712
UPDATE `creature_template_locale` SET `Name` = '[Basic Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'deDE' AND `entry` = 28712;
-- OLD name : Quetz'lun Troll Worshipper Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28713
UPDATE `creature_template_locale` SET `Name` = '[Quetz''lun Troll Worshipper Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28713;
-- OLD name : Seelenbrunnenzone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=28719
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone des Seelenbrunnens' WHERE `locale` = 'deDE' AND `entry` = 28719;
-- OLD name : Plünderpiñata für Erste Hilfe, subname : Schlag mich!
-- Source : https://www.wowhead.com/wotlk/de/npc=28720
UPDATE `creature_template_locale` SET `Name` = '[First Aid Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'deDE' AND `entry` = 28720;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28721
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 28721;
-- OLD name : Alte Nelly
-- Source : https://www.wowhead.com/wotlk/de/npc=28737
UPDATE `creature_template_locale` SET `Name` = '[Ol'' Nelly]' WHERE `locale` = 'deDE' AND `entry` = 28737;
-- OLD name : Drakuru KC Bunny 00
-- Source : https://www.wowhead.com/wotlk/de/npc=28738
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 00]' WHERE `locale` = 'deDE' AND `entry` = 28738;
-- OLD name : Blight Crystal KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28740
UPDATE `creature_template_locale` SET `Name` = '[Blight Crystal KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28740;
-- OLD name : Blight Cauldron KC Bunny 02
-- Source : https://www.wowhead.com/wotlk/de/npc=28741
UPDATE `creature_template_locale` SET `Name` = '[Blight Cauldron KC Bunny 02]' WHERE `locale` = 'deDE' AND `entry` = 28741;
-- OLD subname : Angellehrerin & Angelbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Angelns & Angelbedarf' WHERE `locale` = 'deDE' AND `entry` = 28742;
-- OLD name : Slims untötbarer Boss
-- Source : https://www.wowhead.com/wotlk/de/npc=28744
UPDATE `creature_template_locale` SET `Name` = '[Slim''s Unkillable Boss]' WHERE `locale` = 'deDE' AND `entry` = 28744;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 28746;
-- OLD name : High Priest Mu'funu Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28753
UPDATE `creature_template_locale` SET `Name` = '[High Priest Mu''funu Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28753;
-- OLD name : High Priestess Tua-Tua Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28755
UPDATE `creature_template_locale` SET `Name` = '[High Priestess Tua-Tua Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28755;
-- OLD name : High Priest Hawinni Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28757
UPDATE `creature_template_locale` SET `Name` = '[High Priest Hawinni Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28757;
-- OLD name : Reconnaisaince Flight Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28758
UPDATE `creature_template_locale` SET `Name` = '[Reconnaisaince Flight Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 28758;
-- OLD name : Hargus der Krüppel
-- Source : https://www.wowhead.com/wotlk/de/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Hargus der Spuk' WHERE `locale` = 'deDE' AND `entry` = 28760;
-- OLD name : Drakuru KC Bunny 02
-- Source : https://www.wowhead.com/wotlk/de/npc=28762
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 02]' WHERE `locale` = 'deDE' AND `entry` = 28762;
-- OLD name : Schattenhafter Peiniger
-- Source : https://www.wowhead.com/wotlk/de/npc=28769
UPDATE `creature_template_locale` SET `Name` = 'Schattenhafter Foltermeister' WHERE `locale` = 'deDE' AND `entry` = 28769;
-- OLD name : High Priestess Tua-Tua Hex of Fire Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28770
UPDATE `creature_template_locale` SET `Name` = '[High Priestess Tua-Tua Hex of Fire Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28770;
-- OLD name : High Priest Hawinni Hex of Frost Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28773
UPDATE `creature_template_locale` SET `Name` = '[High Priest Hawinni Hex of Frost Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28773;
-- OLD name : Dunkler Reiter
-- Source : https://www.wowhead.com/wotlk/de/npc=28775
UPDATE `creature_template_locale` SET `Name` = '[Dark Rider Target]' WHERE `locale` = 'deDE' AND `entry` = 28775;
-- OLD name : Catapult KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28777
UPDATE `creature_template_locale` SET `Name` = '[Catapult KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28777;
-- OLD name : Reitgreif
-- Source : https://www.wowhead.com/wotlk/de/npc=28783
UPDATE `creature_template_locale` SET `Name` = '[Riding Gryphon, Amored, Neutral (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 28783;
-- OLD name : Drakuru KC Bunny 03
-- Source : https://www.wowhead.com/wotlk/de/npc=28786
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 03]' WHERE `locale` = 'deDE' AND `entry` = 28786;
-- OLD name : Ausgelaugter Prophet von Quetz'lun
-- Source : https://www.wowhead.com/wotlk/de/npc=28795
UPDATE `creature_template_locale` SET `Name` = 'Ausgelaugter Prophet von Quetz''lin' WHERE `locale` = 'deDE' AND `entry` = 28795;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28799
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 28799;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=28800
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 28800;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 28813;
-- OLD name : Destructive Ward Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=28820
UPDATE `creature_template_locale` SET `Name` = '[Destructive Ward Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 28820;
-- OLD name : Minenwagen
-- Source : https://www.wowhead.com/wotlk/de/npc=28842
UPDATE `creature_template_locale` SET `Name` = '[Mine Cart Test]' WHERE `locale` = 'deDE' AND `entry` = 28842;
-- OLD name : Scharlachrote Flotte
-- Source : https://www.wowhead.com/wotlk/de/npc=28849
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Fleet (PROXY)]' WHERE `locale` = 'deDE' AND `entry` = 28849;
-- OLD name : Toter Jünger von Mam'toth
-- Source : https://www.wowhead.com/wotlk/de/npc=28853
UPDATE `creature_template_locale` SET `Name` = '[Dead Mam''toth Disciple Transform]' WHERE `locale` = 'deDE' AND `entry` = 28853;
-- OLD name : Scharlachroter Flottenverteidiger
-- Source : https://www.wowhead.com/wotlk/de/npc=28856
UPDATE `creature_template_locale` SET `Name` = 'Wächter der Scharlachroten Flotte' WHERE `locale` = 'deDE' AND `entry` = 28856;
-- OLD name : Mam'toth Disciple Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28876
UPDATE `creature_template_locale` SET `Name` = '[Mam''toth Disciple Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28876;
-- OLD name : Testeisenzwerg
-- Source : https://www.wowhead.com/wotlk/de/npc=28880
UPDATE `creature_template_locale` SET `Name` = '[Test Iron Dwarf]' WHERE `locale` = 'deDE' AND `entry` = 28880;
-- OLD name : Scharlachrote Kanone
-- Source : https://www.wowhead.com/wotlk/de/npc=28887
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Cannon]' WHERE `locale` = 'deDE' AND `entry` = 28887;
-- OLD name : Scharlachroter Greifenreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=28894
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Gryphon Rider]' WHERE `locale` = 'deDE' AND `entry` = 28894;
-- OLD name : Scharlachroter Hauptmann
-- Source : https://www.wowhead.com/wotlk/de/npc=28898
UPDATE `creature_template_locale` SET `Name` = 'Schalachroter Hauptmann' WHERE `locale` = 'deDE' AND `entry` = 28898;
-- OLD name : Stute aus Havenau
-- Source : https://www.wowhead.com/wotlk/de/npc=28899
UPDATE `creature_template_locale` SET `Name` = '[Havenshire Mare]' WHERE `locale` = 'deDE' AND `entry` = 28899;
-- OLD name : Hengst aus Havenau
-- Source : https://www.wowhead.com/wotlk/de/npc=28900
UPDATE `creature_template_locale` SET `Name` = '[Havenshire Stallion]' WHERE `locale` = 'deDE' AND `entry` = 28900;
-- OLD name : Reittier des dunklen Reiters
-- Source : https://www.wowhead.com/wotlk/de/npc=28915
UPDATE `creature_template_locale` SET `Name` = '[Dark Rider Mount Fixed]' WHERE `locale` = 'deDE' AND `entry` = 28915;
-- OLD name : Drakuru KC Bunny 04
-- Source : https://www.wowhead.com/wotlk/de/npc=28928
UPDATE `creature_template_locale` SET `Name` = '[Drakuru KC Bunny 04]' WHERE `locale` = 'deDE' AND `entry` = 28928;
-- OLD name : Drakuru's Upper Chamber Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=28929
UPDATE `creature_template_locale` SET `Name` = '[Drakuru''s Upper Chamber Bunny]' WHERE `locale` = 'deDE' AND `entry` = 28929;
-- OLD name : Der Schreiber, subname : Designer extraordinaire
-- Source : https://www.wowhead.com/wotlk/de/npc=28944
UPDATE `creature_template_locale` SET `Name` = '[The Inscriber]',`Title` = '[Designer Extraordinaire]' WHERE `locale` = 'deDE' AND `entry` = 28944;
-- OLD name : Spell Performance Test Caster, subname : QA-Sandsack
-- Source : https://www.wowhead.com/wotlk/de/npc=28949
UPDATE `creature_template_locale` SET `Name` = '[Spell Performance Test Caster]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 28949;
-- OLD name : Spell Performance Test Target, subname : QA-Sandsack
-- Source : https://www.wowhead.com/wotlk/de/npc=28950
UPDATE `creature_template_locale` SET `Name` = '[Spell Performance Test Target]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 28950;
-- OLD name : Unkillable Test Dummy 70 Gnome
-- Source : https://www.wowhead.com/wotlk/de/npc=28953
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Gnome]' WHERE `locale` = 'deDE' AND `entry` = 28953;
-- OLD name : Unkillable Test Dummy 70 Tauren
-- Source : https://www.wowhead.com/wotlk/de/npc=28954
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Tauren]' WHERE `locale` = 'deDE' AND `entry` = 28954;
-- OLD name : Unkillable Test Dummy 70 Dwarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28955
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 70 Dwarf]' WHERE `locale` = 'deDE' AND `entry` = 28955;
-- OLD name : Scharlachroter Lord Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/de/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Lord Borugh' WHERE `locale` = 'deDE' AND `entry` = 28964;
-- OLD name : Stellvertretender Bürger von Neu-Avalon
-- Source : https://www.wowhead.com/wotlk/de/npc=28986
UPDATE `creature_template_locale` SET `Name` = '[Citizen of New Avalon Proxy]' WHERE `locale` = 'deDE' AND `entry` = 28986;
-- OLD name : Frostvrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=29002
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type A)]' WHERE `locale` = 'deDE' AND `entry` = 29002;
-- OLD name : Frostvrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=29003
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type B)]' WHERE `locale` = 'deDE' AND `entry` = 29003;
-- OLD name : Frostvrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=29004
UPDATE `creature_template_locale` SET `Name` = '[Frost Vrykul (Type C)]' WHERE `locale` = 'deDE' AND `entry` = 29004;
-- OLD name : Purpurroter Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=29007
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Akolyt' WHERE `locale` = 'deDE' AND `entry` = 29007;
-- OLD name : Monsoon Revenant Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=29008
UPDATE `creature_template_locale` SET `Name` = '[Monsoon Revenant Credit]' WHERE `locale` = 'deDE' AND `entry` = 29008;
-- OLD name : Storm Revenant Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=29009
UPDATE `creature_template_locale` SET `Name` = '[Storm Revenant Credit]' WHERE `locale` = 'deDE' AND `entry` = 29009;
-- OLD name : Antimagische Barriere
-- Source : https://www.wowhead.com/wotlk/de/npc=29010
UPDATE `creature_template_locale` SET `Name` = '[Anti-Magic Barrier (Quest)]' WHERE `locale` = 'deDE' AND `entry` = 29010;
-- OLD subname : Bogenmacher
-- Source : https://www.wowhead.com/wotlk/de/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacher' WHERE `locale` = 'deDE' AND `entry` = 29014;
-- OLD name : Blutklauenmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=29044
UPDATE `creature_template_locale` SET `Name` = 'Blutklauenmatriarch' WHERE `locale` = 'deDE' AND `entry` = 29044;
-- OLD name : Das ist'n Chopper, Baby (Horde), subname : Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29045
UPDATE `creature_template_locale` SET `Name` = '[It''s A Chopper, Baby (Horde)]',`Title` = '[Horde]' WHERE `locale` = 'deDE' AND `entry` = 29045;
-- OLD name : Das ist'n Chopper, Baby (Allianz), subname : Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29046
UPDATE `creature_template_locale` SET `Name` = '[It''s A Chopper, Baby (Alliance)]',`Title` = '[Horde]' WHERE `locale` = 'deDE' AND `entry` = 29046;
-- OLD name : Unsichtbare Plumsklofrau
-- Source : https://www.wowhead.com/wotlk/de/npc=29052
UPDATE `creature_template_locale` SET `Name` = '[Outhouse Invisible Woman]' WHERE `locale` = 'deDE' AND `entry` = 29052;
-- OLD name : Missile Test Mob
-- Source : https://www.wowhead.com/wotlk/de/npc=29054
UPDATE `creature_template_locale` SET `Name` = '[Missile Test Mob]' WHERE `locale` = 'deDE' AND `entry` = 29054;
-- OLD name : Horn of Fecundity Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=29055
UPDATE `creature_template_locale` SET `Name` = '[Horn of Fecundity Credit]' WHERE `locale` = 'deDE' AND `entry` = 29055;
-- OLD name : Craig - TEST - Iron Dwarf
-- Source : https://www.wowhead.com/wotlk/de/npc=29059
UPDATE `creature_template_locale` SET `Name` = '[Craig - TEST - Iron Dwarf]' WHERE `locale` = 'deDE' AND `entry` = 29059;
-- OLD name : Crusader Parachute Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29060
UPDATE `creature_template_locale` SET `Name` = '[Crusader Parachute Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29060;
-- OLD name : QA Test Dummy 73 Raid Debuff (Low Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=29075
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 73 Raid Debuff (Low Armor)]' WHERE `locale` = 'deDE' AND `entry` = 29075;
-- OLD name : PattyMacks The Duece
-- Source : https://www.wowhead.com/wotlk/de/npc=29083
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks The Duece]' WHERE `locale` = 'deDE' AND `entry` = 29083;
-- OLD name : Drakkari Skullcrusher KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29099
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Skullcrusher KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29099;
-- OLD name : Kriegsmaid der Val'kyr
-- Source : https://www.wowhead.com/wotlk/de/npc=29111
UPDATE `creature_template_locale` SET `Name` = '[Val''kyr Battle-maiden]' WHERE `locale` = 'deDE' AND `entry` = 29111;
-- OLD name : Hochkommandant Galvar Reinblut
-- Source : https://www.wowhead.com/wotlk/de/npc=29114
UPDATE `creature_template_locale` SET `Name` = '[High Commander Galvar Pureblood]' WHERE `locale` = 'deDE' AND `entry` = 29114;
-- OLD name : Klagende Drakkariseele
-- Source : https://www.wowhead.com/wotlk/de/npc=29135
UPDATE `creature_template_locale` SET `Name` = '[Wailing Drakkari Soul]' WHERE `locale` = 'deDE' AND `entry` = 29135;
-- OLD name : Camera Shaker - 20-40 seconds
-- Source : https://www.wowhead.com/wotlk/de/npc=29140
UPDATE `creature_template_locale` SET `Name` = '[Camera Shaker - 20-40 seconds]' WHERE `locale` = 'deDE' AND `entry` = 29140;
-- OLD name : Stellvertretender Scharlachroter Soldat
-- Source : https://www.wowhead.com/wotlk/de/npc=29150
UPDATE `creature_template_locale` SET `Name` = '[Scarlet Soldier Proxy]' WHERE `locale` = 'deDE' AND `entry` = 29150;
-- OLD name : Test Scaling Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=29163
UPDATE `creature_template_locale` SET `Name` = '[Test Scaling Vendor]' WHERE `locale` = 'deDE' AND `entry` = 29163;
-- OLD name : Teleporter der Hallen des Steins
-- Source : https://www.wowhead.com/wotlk/de/npc=29165
UPDATE `creature_template_locale` SET `Name` = '[Halls of Stone Teleporter]' WHERE `locale` = 'deDE' AND `entry` = 29165;
-- OLD name : Kunz Jr.
-- Source : https://www.wowhead.com/wotlk/de/npc=29171
UPDATE `creature_template_locale` SET `Name` = '[Kunz Jr.]' WHERE `locale` = 'deDE' AND `entry` = 29171;
-- OLD name : Seucheneruptor
-- Source : https://www.wowhead.com/wotlk/de/npc=29187
UPDATE `creature_template_locale` SET `Name` = '[Plague Eruptor]' WHERE `locale` = 'deDE' AND `entry` = 29187;
-- OLD name : Eisgespenst
-- Source : https://www.wowhead.com/wotlk/de/npc=29188
UPDATE `creature_template_locale` SET `Name` = '[Coldwraith]' WHERE `locale` = 'deDE' AND `entry` = 29188;
-- OLD name : Gefrorener Schemen, Höhepunkt
-- Source : https://www.wowhead.com/wotlk/de/npc=29197
UPDATE `creature_template_locale` SET `Name` = '[Frozen Shade, Climax]' WHERE `locale` = 'deDE' AND `entry` = 29197;
-- OLD name : Mograines Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=29198
UPDATE `creature_template_locale` SET `Name` = '[Mograine''s Mount]' WHERE `locale` = 'deDE' AND `entry` = 29198;
-- OLD name : Reittier eines Todesritters
-- Source : https://www.wowhead.com/wotlk/de/npc=29201
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Mount]' WHERE `locale` = 'deDE' AND `entry` = 29201;
-- OLD subname : Reagenzienverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Leichenstaubverkäufer' WHERE `locale` = 'deDE' AND `entry` = 29203;
-- OLD name : Jünger des unheiligen Häschens
-- Source : https://www.wowhead.com/wotlk/de/npc=29215
UPDATE `creature_template_locale` SET `Name` = '[Disciples of the Unholy Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29215;
-- OLD name : Cenarischer Späher
-- Source : https://www.wowhead.com/wotlk/de/npc=29220
UPDATE `creature_template_locale` SET `Name` = 'Aufklärer des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 29220;
-- OLD name : Reittier eines Todesritters
-- Source : https://www.wowhead.com/wotlk/de/npc=29221
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Mount, Ebon Hold]' WHERE `locale` = 'deDE' AND `entry` = 29221;
-- OLD name : Präsenz von Yogg-Saron
-- Source : https://www.wowhead.com/wotlk/de/npc=29224
UPDATE `creature_template_locale` SET `Name` = '[Presence of Yogg-Saron]' WHERE `locale` = 'deDE' AND `entry` = 29224;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=29225
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone' WHERE `locale` = 'deDE' AND `entry` = 29225;
-- OLD name : Niederes Schattenkonstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=29230
UPDATE `creature_template_locale` SET `Name` = '[Lesser Shadow Construct]' WHERE `locale` = 'deDE' AND `entry` = 29230;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe' WHERE `locale` = 'deDE' AND `entry` = 29233;
-- OLD name : Kampfmeister des Strands der Uralten
-- Source : https://www.wowhead.com/wotlk/de/npc=29234
UPDATE `creature_template_locale` SET `Name` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 29234;
-- OLD name : Omar the Test Dragon Gen2
-- Source : https://www.wowhead.com/wotlk/de/npc=29257
UPDATE `creature_template_locale` SET `Name` = '[Omar the Test Dragon Gen2]' WHERE `locale` = 'deDE' AND `entry` = 29257;
-- OLD name : Omar's accumulator bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29258
UPDATE `creature_template_locale` SET `Name` = '[Omar''s accumulator bunny]' WHERE `locale` = 'deDE' AND `entry` = 29258;
-- OLD name : PattyMacks schwebende Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=29263
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks Hovering Dummy]' WHERE `locale` = 'deDE' AND `entry` = 29263;
-- OLD name : Ballrückstoß, subname : <Schlag mich!>
-- Source : https://www.wowhead.com/wotlk/de/npc=29265
UPDATE `creature_template_locale` SET `Name` = '[Knockback Ball]',`Title` = '[<Hit Me!>]' WHERE `locale` = 'deDE' AND `entry` = 29265;
-- OLD name : Zwergischer Golem
-- Source : https://www.wowhead.com/wotlk/de/npc=29272
UPDATE `creature_template_locale` SET `Name` = '[Dwarven Golem]' WHERE `locale` = 'deDE' AND `entry` = 29272;
-- OLD name : Zahlmeister Habert, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=29283
UPDATE `creature_template_locale` SET `Name` = '[Paymaster Habert]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 29283;
-- OLD name : Lebensblutelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=29303
UPDATE `creature_template_locale` SET `Name` = '[Lifeblood Elemental Credit]' WHERE `locale` = 'deDE' AND `entry` = 29303;
-- OLD name : Cyanigosa
-- Source : https://www.wowhead.com/wotlk/de/npc=29317
UPDATE `creature_template_locale` SET `Name` = '[Cyanigosa (Dragon)]' WHERE `locale` = 'deDE' AND `entry` = 29317;
-- OLD name : Arenakampfmeister von Dalaran, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29318
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Arena Battlemaster]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29318;
-- OLD name : Sturmmaid
-- Source : https://www.wowhead.com/wotlk/de/npc=29320
UPDATE `creature_template_locale` SET `Name` = '[(PH) Storm Maiden]' WHERE `locale` = 'deDE' AND `entry` = 29320;
-- OLD name : Sturmmaid - Zauberin
-- Source : https://www.wowhead.com/wotlk/de/npc=29322
UPDATE `creature_template_locale` SET `Name` = '[(PH) Storm Maiden - Caster]' WHERE `locale` = 'deDE' AND `entry` = 29322;
-- OLD name : Argentumritter
-- Source : https://www.wowhead.com/wotlk/de/npc=29336
UPDATE `creature_template_locale` SET `Name` = '[Argent Knight]' WHERE `locale` = 'deDE' AND `entry` = 29336;
-- OLD name : Sybille (Bogenschützin)
-- Source : https://www.wowhead.com/wotlk/de/npc=29342
UPDATE `creature_template_locale` SET `Name` = '[Sybil (Archer) - Deprecated]' WHERE `locale` = 'deDE' AND `entry` = 29342;
-- OLD name : Banner der Argentumdämmerung
-- Source : https://www.wowhead.com/wotlk/de/npc=29345
UPDATE `creature_template_locale` SET `Name` = '[Argent Dawn Banner]' WHERE `locale` = 'deDE' AND `entry` = 29345;
-- OLD name : Apotheker Chaney, subname : Alchemiebedarf & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=29348
UPDATE `creature_template_locale` SET `Name` = '[Apothecary Chaney]',`Title` = '[Alchemy & Poison Supplies]' WHERE `locale` = 'deDE' AND `entry` = 29348;
-- OLD name : Sekretkugel
-- Source : https://www.wowhead.com/wotlk/de/npc=29367
UPDATE `creature_template_locale` SET `Name` = '[Ichor Globule (Transform)]' WHERE `locale` = 'deDE' AND `entry` = 29367;
-- OLD name : Zwielichtdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=29372
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake]' WHERE `locale` = 'deDE' AND `entry` = 29372;
-- OLD name : Beobachterin von Brunnhildar
-- Source : https://www.wowhead.com/wotlk/de/npc=29378
UPDATE `creature_template_locale` SET `Name` = '[Brunnhildar Observer]' WHERE `locale` = 'deDE' AND `entry` = 29378;
-- OLD name : QA Arena Master: Blade's Edge, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29381
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Blade''s Edge]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29381;
-- OLD name : QA Arena Master: Nagrand Arena, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29383
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Nagrand Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29383;
-- OLD name : QA Arena Master: Ruins of Lordaeron, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29385
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Ruins of Lordaeron]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29385;
-- OLD name : QA Arena Master: Orgrimmar Arena, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29386
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Orgrimmar Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29386;
-- OLD name : QA Arena Master: Dalaran Arena, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29387
UPDATE `creature_template_locale` SET `Name` = '[QA Arena Master: Dalaran Arena]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 29387;
-- OLD name : Ausgehungerter Hai
-- Source : https://www.wowhead.com/wotlk/de/npc=29391
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Jaws Blood Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29391;
-- OLD name : Land Mine Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29397
UPDATE `creature_template_locale` SET `Name` = 'Landminenhäschen' WHERE `locale` = 'deDE' AND `entry` = 29397;
-- OLD name : From Their Corpses, Rise! Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29398
UPDATE `creature_template_locale` SET `Name` = '[From Their Corpses, Rise! Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29398;
-- OLD name : Da brauchst du noch ein Greiftötungskredithäschen
-- Source : https://www.wowhead.com/wotlk/de/npc=29406
UPDATE `creature_template_locale` SET `Name` = '[You''ll Need a Gryphon Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29406;
-- OLD name : Garmräuber
-- Source : https://www.wowhead.com/wotlk/de/npc=29408
UPDATE `creature_template_locale` SET `Name` = '[Garm Raider]' WHERE `locale` = 'deDE' AND `entry` = 29408;
-- OLD name : Beschwörungstester
-- Source : https://www.wowhead.com/wotlk/de/npc=29423
UPDATE `creature_template_locale` SET `Name` = '[Summon Tester]' WHERE `locale` = 'deDE' AND `entry` = 29423;
-- OLD name : Sybille (Unbewaffnet)
-- Source : https://www.wowhead.com/wotlk/de/npc=29435
UPDATE `creature_template_locale` SET `Name` = '[Sybil (Unarmed) - Deprecated]' WHERE `locale` = 'deDE' AND `entry` = 29435;
-- OLD name : Leutnant Kregor, subname : Die Argentumdämmerung
-- Source : https://www.wowhead.com/wotlk/de/npc=29442
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Kregor]',`Title` = '[The Argent Dawn]' WHERE `locale` = 'deDE' AND `entry` = 29442;
-- OLD name : Troll der Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=29471
UPDATE `creature_template_locale` SET `Name` = '[Drakkari Troll]' WHERE `locale` = 'deDE' AND `entry` = 29471;
-- OLD name : Argentumkreuzfahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29472
UPDATE `creature_template_locale` SET `Name` = '[Argent Crusader]' WHERE `locale` = 'deDE' AND `entry` = 29472;
-- OLD name : Reitskelettgreif
-- Source : https://www.wowhead.com/wotlk/de/npc=29474
UPDATE `creature_template_locale` SET `Name` = '[Riding Skeletal Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 29474;
-- OLD name : Haustierskunk
-- Source : https://www.wowhead.com/wotlk/de/npc=29482
UPDATE `creature_template_locale` SET `Name` = '[Pet Skunk]' WHERE `locale` = 'deDE' AND `entry` = 29482;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Spezialmunition' WHERE `locale` = 'deDE' AND `entry` = 29493;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedekunstlehrerin' WHERE `locale` = 'deDE' AND `entry` = 29505;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedekunstlehrer' WHERE `locale` = 'deDE' AND `entry` = 29506;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 29507;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer' WHERE `locale` = 'deDE' AND `entry` = 29508;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin' WHERE `locale` = 'deDE' AND `entry` = 29509;
-- OLD subname : Gnomischer Ingenieurslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29514
UPDATE `creature_template_locale` SET `Title` = 'Gnomeningenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 29514;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=29523
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 29523;
-- OLD name : Mammutfleischhäschen
-- Source : https://www.wowhead.com/wotlk/de/npc=29524
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Meat Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29524;
-- OLD name : Sholazar Daily Test NPC
-- Source : https://www.wowhead.com/wotlk/de/npc=29526
UPDATE `creature_template_locale` SET `Name` = '[Sholazar Daily Test NPC]' WHERE `locale` = 'deDE' AND `entry` = 29526;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=29539
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 29539;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=29540
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 29540;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=29541
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 29541;
-- OLD name : Arete's Gate Summoned Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29550
UPDATE `creature_template_locale` SET `Name` = '[Arete''s Gate Summoned Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29550;
-- OLD name : Garmräuber
-- Source : https://www.wowhead.com/wotlk/de/npc=29552
UPDATE `creature_template_locale` SET `Name` = '[Garm Raider]' WHERE `locale` = 'deDE' AND `entry` = 29552;
-- OLD name : Drachenreiterin von Valkyrion
-- Source : https://www.wowhead.com/wotlk/de/npc=29591
UPDATE `creature_template_locale` SET `Name` = '[Valkyrion Drake-Rider]' WHERE `locale` = 'deDE' AND `entry` = 29591;
-- OLD name : Frostworg KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29595
UPDATE `creature_template_locale` SET `Name` = '[Frostworg KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29595;
-- OLD name : Frost Giant KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29597
UPDATE `creature_template_locale` SET `Name` = '[Frost Giant KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29597;
-- OLD name : Jorwyrgan
-- Source : https://www.wowhead.com/wotlk/de/npc=29610
UPDATE `creature_template_locale` SET `Name` = '[Jorwyrgan]' WHERE `locale` = 'deDE' AND `entry` = 29610;
-- OLD name : Eiszahn
-- Source : https://www.wowhead.com/wotlk/de/npc=29616
UPDATE `creature_template_locale` SET `Name` = '[Icefang TEST]' WHERE `locale` = 'deDE' AND `entry` = 29616;
-- OLD name : Grand Admiral Westwind Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29627
UPDATE `creature_template_locale` SET `Name` = '[Grand Admiral Westwind Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29627;
-- OLD name : Owen Testkreatur
-- Source : https://www.wowhead.com/wotlk/de/npc=29629
UPDATE `creature_template_locale` SET `Name` = '[Owen Test Creature]' WHERE `locale` = 'deDE' AND `entry` = 29629;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 29631;
-- OLD name : Mechanischer Anzug ZX-5103
-- Source : https://www.wowhead.com/wotlk/de/npc=29645
UPDATE `creature_template_locale` SET `Name` = '[Mechanical Suit ZX-5103]' WHERE `locale` = 'deDE' AND `entry` = 29645;
-- OLD name : Rhinozeros von Gal'darah, subname : Hochprophet von Akali
-- Source : https://www.wowhead.com/wotlk/de/npc=29681
UPDATE `creature_template_locale` SET `Name` = '[Gal''darah Rhino]',`Title` = '[High Prophet of Akali]' WHERE `locale` = 'deDE' AND `entry` = 29681;
-- OLD name : Mei
-- Source : https://www.wowhead.com/wotlk/de/npc=29711
UPDATE `creature_template_locale` SET `Name` = '[Mei]' WHERE `locale` = 'deDE' AND `entry` = 29711;
-- OLD name : Befreite Brunnhildar, subname : PH Textur
-- Source : https://www.wowhead.com/wotlk/de/npc=29734
UPDATE `creature_template_locale` SET `Name` = '[Liberated Brunnhildar]',`Title` = '[PH Texture]' WHERE `locale` = 'deDE' AND `entry` = 29734;
-- OLD name : Fass voller Spaß
-- Source : https://www.wowhead.com/wotlk/de/npc=29737
UPDATE `creature_template_locale` SET `Name` = '[Barrel o'' Fun]' WHERE `locale` = 'deDE' AND `entry` = 29737;
-- OLD name : Sichtbares Moorabimammut, subname : Hochprophet des Man'toth
-- Source : https://www.wowhead.com/wotlk/de/npc=29741
UPDATE `creature_template_locale` SET `Name` = '[Moorabi Mammoth Visual]',`Title` = '[High Prophet of Man''toth]' WHERE `locale` = 'deDE' AND `entry` = 29741;
-- OLD name : Morgana Tagesglanz, subname : Flugmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=29749
UPDATE `creature_template_locale` SET `Name` = '[Morgana Dayblaze]',`Title` = '[Flight Master]' WHERE `locale` = 'deDE' AND `entry` = 29749;
-- OLD name : Veranus
-- Source : https://www.wowhead.com/wotlk/de/npc=29756
UPDATE `creature_template_locale` SET `Name` = '[Veranus]' WHERE `locale` = 'deDE' AND `entry` = 29756;
-- OLD name : Kosmetisches Windtotem der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29758
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Air]' WHERE `locale` = 'deDE' AND `entry` = 29758;
-- OLD name : Kosmetisches Erdtotem der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29759
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Earth]' WHERE `locale` = 'deDE' AND `entry` = 29759;
-- OLD name : Kosmetisches Feuertotem der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29760
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Fire]' WHERE `locale` = 'deDE' AND `entry` = 29760;
-- OLD name : Kosmetisches Wassertotem der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29761
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Totem Horde Water]' WHERE `locale` = 'deDE' AND `entry` = 29761;
-- OLD name : Spektraler Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=29767
UPDATE `creature_template_locale` SET `Name` = '[Spectral Gryphon, Mount]' WHERE `locale` = 'deDE' AND `entry` = 29767;
-- OLD name : ELM General Purpose Bunny Large (Phase I)
-- Source : https://www.wowhead.com/wotlk/de/npc=29773
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Large (Phase I)]' WHERE `locale` = 'deDE' AND `entry` = 29773;
-- OLD name : Irrwisch
-- Source : https://www.wowhead.com/wotlk/de/npc=29776
UPDATE `creature_template_locale` SET `Name` = '[Wisp, Ghost Mount]' WHERE `locale` = 'deDE' AND `entry` = 29776;
-- OLD name : The Ocular - Eye of C'Thun Transform
-- Source : https://www.wowhead.com/wotlk/de/npc=29789
UPDATE `creature_template_locale` SET `Name` = '[The Ocular - Eye of C''Thun Transform]' WHERE `locale` = 'deDE' AND `entry` = 29789;
-- OLD name : Drachenreiter des Hildarthings
-- Source : https://www.wowhead.com/wotlk/de/npc=29800
UPDATE `creature_template_locale` SET `Name` = '[Hyldsmeet Drake-Rider Credit]' WHERE `locale` = 'deDE' AND `entry` = 29800;
-- OLD name : The Ocular Destroyed Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29803
UPDATE `creature_template_locale` SET `Name` = '[The Ocular Destroyed Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29803;
-- OLD name : Schilfs verbessertes Exoskelett
-- Source : https://www.wowhead.com/wotlk/de/npc=29810
UPDATE `creature_template_locale` SET `Name` = '[Reed''s Enhanced Exoskeleton]' WHERE `locale` = 'deDE' AND `entry` = 29810;
-- OLD name : Todesstreitross von Naxxramas
-- Source : https://www.wowhead.com/wotlk/de/npc=29814
UPDATE `creature_template_locale` SET `Name` = '[Naxxramas Deathcharger]' WHERE `locale` = 'deDE' AND `entry` = 29814;
-- OLD name : Chain Swing Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29815
UPDATE `creature_template_locale` SET `Name` = '[Chain Swing Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29815;
-- OLD name : Eagle Feeding Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=29816
UPDATE `creature_template_locale` SET `Name` = '[Eagle Feeding Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 29816;
-- OLD name : Merdel, subname : Funksockels Stolz und Freude
-- Source : https://www.wowhead.com/wotlk/de/npc=29841
UPDATE `creature_template_locale` SET `Name` = '[Merdle]',`Title` = '[Sparksocket''s Pride and Joy]' WHERE `locale` = 'deDE' AND `entry` = 29841;
-- OLD name : Vile Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29845
UPDATE `creature_template_locale` SET `Name` = '[Vile Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29845;
-- OLD name : Lady Nightswood Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29846
UPDATE `creature_template_locale` SET `Name` = '[Lady Nightswood Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29846;
-- OLD name : The Leaper Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29847
UPDATE `creature_template_locale` SET `Name` = '[The Leaper Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 29847;
-- OLD name : Lo'Gosh, subname : Der Geisterwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=29850
UPDATE `creature_template_locale` SET `Name` = '[Lo''Gosh]',`Title` = '[The Ghost Wolf]' WHERE `locale` = 'deDE' AND `entry` = 29850;
-- OLD name : Exemplar eines Ritters von Lordaeron
-- Source : https://www.wowhead.com/wotlk/de/npc=29864
UPDATE `creature_template_locale` SET `Name` = '[Lordaeron Knight Specimen]' WHERE `locale` = 'deDE' AND `entry` = 29864;
-- OLD name : Exemplar eines Jungen von Stratholme
-- Source : https://www.wowhead.com/wotlk/de/npc=29868
UPDATE `creature_template_locale` SET `Name` = 'Exemplar eines Kindes von Stratholme' WHERE `locale` = 'deDE' AND `entry` = 29868;
-- OLD name : Persistence Waypoint 00
-- Source : https://www.wowhead.com/wotlk/de/npc=29870
UPDATE `creature_template_locale` SET `Name` = '[Persistence Waypoint 00]' WHERE `locale` = 'deDE' AND `entry` = 29870;
-- OLD name : Persistence Waypoint 01
-- Source : https://www.wowhead.com/wotlk/de/npc=29871
UPDATE `creature_template_locale` SET `Name` = '[Persistence Waypoint 01]' WHERE `locale` = 'deDE' AND `entry` = 29871;
-- OLD name : ELM General Purpose Bunny (Phase I)
-- Source : https://www.wowhead.com/wotlk/de/npc=29876
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (Phase I)]' WHERE `locale` = 'deDE' AND `entry` = 29876;
-- OLD name : ELM General Purpose Bunny (scale x0.01 - Phase I) Large
-- Source : https://www.wowhead.com/wotlk/de/npc=29877
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (scale x0.01 - Phase I) Large]' WHERE `locale` = 'deDE' AND `entry` = 29877;
-- OLD name : Log Ride (Log A)
-- Source : https://www.wowhead.com/wotlk/de/npc=29878
UPDATE `creature_template_locale` SET `Name` = '[Log Ride (Log A)]' WHERE `locale` = 'deDE' AND `entry` = 29878;
-- OLD name : Log Ride (Log B)
-- Source : https://www.wowhead.com/wotlk/de/npc=29879
UPDATE `creature_template_locale` SET `Name` = '[Log Ride (Log B)]' WHERE `locale` = 'deDE' AND `entry` = 29879;
-- OLD name : Stellvertreter der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29882
UPDATE `creature_template_locale` SET `Name` = '[Vargul Proxy]' WHERE `locale` = 'deDE' AND `entry` = 29882;
-- OLD name : Kyles Testfahrzeug
-- Source : https://www.wowhead.com/wotlk/de/npc=29883
UPDATE `creature_template_locale` SET `Name` = '[Kyle''s Test Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 29883;
-- OLD name : Exhausted Vrykul Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=29886
UPDATE `creature_template_locale` SET `Name` = '[Exhausted Vrykul Credit]' WHERE `locale` = 'deDE' AND `entry` = 29886;
-- OLD name : Runenlord der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29891
UPDATE `creature_template_locale` SET `Name` = 'Runenlord' WHERE `locale` = 'deDE' AND `entry` = 29891;
-- OLD name : Seuchenklaue der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29894
UPDATE `creature_template_locale` SET `Name` = 'Vargul Seuchenklaue' WHERE `locale` = 'deDE' AND `entry` = 29894;
-- OLD name : Brüder des Sturms
-- Source : https://www.wowhead.com/wotlk/de/npc=29896
UPDATE `creature_template_locale` SET `Name` = '[Brothers of the Storm]' WHERE `locale` = 'deDE' AND `entry` = 29896;
-- OLD name : Kill Credit Test
-- Source : https://www.wowhead.com/wotlk/de/npc=29902
UPDATE `creature_template_locale` SET `Name` = '[Kill Credit Test]' WHERE `locale` = 'deDE' AND `entry` = 29902;
-- OLD name : Dan's Test Dummy (Large AOI)
-- Source : https://www.wowhead.com/wotlk/de/npc=29913
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy (Large AOI)]' WHERE `locale` = 'deDE' AND `entry` = 29913;
-- OLD name : GGOODMAN 2
-- Source : https://www.wowhead.com/wotlk/de/npc=29921
UPDATE `creature_template_locale` SET `Name` = '[GGOODMAN 2]' WHERE `locale` = 'deDE' AND `entry` = 29921;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 29924;
-- OLD name : Motorrad der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=29930
UPDATE `creature_template_locale` SET `Name` = '[Alliance Motorcycle]' WHERE `locale` = 'deDE' AND `entry` = 29930;
-- OLD name : Das Schwein, subname : PH: Name, Modell
-- Source : https://www.wowhead.com/wotlk/de/npc=29933
UPDATE `creature_template_locale` SET `Name` = '[The Hog]',`Title` = '[PH: Name, Model]' WHERE `locale` = 'deDE' AND `entry` = 29933;
-- OLD name : Akolyth der Pein
-- Source : https://www.wowhead.com/wotlk/de/npc=29934
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Pein' WHERE `locale` = 'deDE' AND `entry` = 29934;
-- OLD name : Akolyth des Schmerzes
-- Source : https://www.wowhead.com/wotlk/de/npc=29935
UPDATE `creature_template_locale` SET `Name` = 'Akolyt des Schmerzes' WHERE `locale` = 'deDE' AND `entry` = 29935;
-- OLD name : Algars Reitfrostwyrm
-- Source : https://www.wowhead.com/wotlk/de/npc=29936
UPDATE `creature_template_locale` SET `Name` = '[Algar''s Frost Wyrm Mount]' WHERE `locale` = 'deDE' AND `entry` = 29936;
-- OLD name : Bodenreittier der Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=29938
UPDATE `creature_template_locale` SET `Name` = '[Tuskarr Land Mount]' WHERE `locale` = 'deDE' AND `entry` = 29938;
-- OLD name : SCOURGE PROXY (PHASED)
-- Source : https://www.wowhead.com/wotlk/de/npc=29943
UPDATE `creature_template_locale` SET `Name` = '[SCOURGE PROXY (PHASED)]' WHERE `locale` = 'deDE' AND `entry` = 29943;
-- OLD name : Verteidiger von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=29949
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Defender]' WHERE `locale` = 'deDE' AND `entry` = 29949;
-- OLD name : Haylin
-- Source : https://www.wowhead.com/wotlk/de/npc=29977
UPDATE `creature_template_locale` SET `Name` = '[Haylin]' WHERE `locale` = 'deDE' AND `entry` = 29977;
-- OLD name : Der Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=29983
UPDATE `creature_template_locale` SET `Name` = '[The Lich King (Icecrown)]' WHERE `locale` = 'deDE' AND `entry` = 29983;
-- OLD name : Zone der Leere X
-- Source : https://www.wowhead.com/wotlk/de/npc=29992
UPDATE `creature_template_locale` SET `Name` = '[Void Zone X]' WHERE `locale` = 'deDE' AND `entry` = 29992;
-- OLD name : Beschwörer der Eisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=29995
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Summoner]' WHERE `locale` = 'deDE' AND `entry` = 29995;
-- OLD name : Entweihter Boden V
-- Source : https://www.wowhead.com/wotlk/de/npc=29998
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground V]' WHERE `locale` = 'deDE' AND `entry` = 29998;
-- OLD name : Ferngesteuerter Turbotriebgyrobomber des Todes
-- Source : https://www.wowhead.com/wotlk/de/npc=30004
UPDATE `creature_template_locale` SET `Name` = '[Turbo-propelled Remote-controlled Gyro Bomber of Death]' WHERE `locale` = 'deDE' AND `entry` = 30004;
-- OLD name : Verpesteter Zombie
-- Source : https://www.wowhead.com/wotlk/de/npc=30034
UPDATE `creature_template_locale` SET `Name` = '[Plague Zombie]' WHERE `locale` = 'deDE' AND `entry` = 30034;
-- OLD name : Mjordin Combatant Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30038
UPDATE `creature_template_locale` SET `Name` = '[Mjordin Combatant Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30038;
-- OLD name : Irdener Steinstatus
-- Source : https://www.wowhead.com/wotlk/de/npc=30050
UPDATE `creature_template_locale` SET `Name` = '[Earthen Stone State]' WHERE `locale` = 'deDE' AND `entry` = 30050;
-- OLD name : Bibliothekarin Tiare
-- Source : https://www.wowhead.com/wotlk/de/npc=30051
UPDATE `creature_template_locale` SET `Name` = 'Bibliothekar Tiare' WHERE `locale` = 'deDE' AND `entry` = 30051;
-- OLD name : Gefrorene Kugel
-- Source : https://www.wowhead.com/wotlk/de/npc=30054
UPDATE `creature_template_locale` SET `Name` = '[Frozen Orb]' WHERE `locale` = 'deDE' AND `entry` = 30054;
-- OLD name : Sturmgipfelwyrm
-- Source : https://www.wowhead.com/wotlk/de/npc=30055
UPDATE `creature_template_locale` SET `Name` = '[Stormpeak Wyrm]' WHERE `locale` = 'deDE' AND `entry` = 30055;
-- OLD name : Sichtbarer Wyrmruhwächter (Bronze)
-- Source : https://www.wowhead.com/wotlk/de/npc=30059
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Bronze)]' WHERE `locale` = 'deDE' AND `entry` = 30059;
-- OLD name : Sturmgeschmiedeter Verstärker
-- Source : https://www.wowhead.com/wotlk/de/npc=30062
UPDATE `creature_template_locale` SET `Name` = '[Stormforged Amplifier]' WHERE `locale` = 'deDE' AND `entry` = 30062;
-- OLD name : Initiandin Claget
-- Source : https://www.wowhead.com/wotlk/de/npc=30067
UPDATE `creature_template_locale` SET `Name` = 'Initiant Claget' WHERE `locale` = 'deDE' AND `entry` = 30067;
-- OLD name : Initiand Roderick
-- Source : https://www.wowhead.com/wotlk/de/npc=30069
UPDATE `creature_template_locale` SET `Name` = 'Initiant Roderick' WHERE `locale` = 'deDE' AND `entry` = 30069;
-- OLD name : Initiand Gahark
-- Source : https://www.wowhead.com/wotlk/de/npc=30070
UPDATE `creature_template_locale` SET `Name` = 'Initiant Gahark' WHERE `locale` = 'deDE' AND `entry` = 30070;
-- OLD name : Sichtbarer Wyrmruhwächter (Rot)
-- Source : https://www.wowhead.com/wotlk/de/npc=30072
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Red)]' WHERE `locale` = 'deDE' AND `entry` = 30072;
-- OLD name : Sichtbarer Wyrmruhwächter (Grün)
-- Source : https://www.wowhead.com/wotlk/de/npc=30073
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Green)]' WHERE `locale` = 'deDE' AND `entry` = 30073;
-- OLD name : Sichtbarer Wyrmruhwächter (Blau)
-- Source : https://www.wowhead.com/wotlk/de/npc=30076
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Blue)]' WHERE `locale` = 'deDE' AND `entry` = 30076;
-- OLD name : Sichtbarer Wyrmruhwächter (Schwarz)
-- Source : https://www.wowhead.com/wotlk/de/npc=30077
UPDATE `creature_template_locale` SET `Name` = '[Wyrmrest Warden Visual (Black)]' WHERE `locale` = 'deDE' AND `entry` = 30077;
-- OLD name : ELM General Purpose Bunny (Phase II)
-- Source : https://www.wowhead.com/wotlk/de/npc=30079
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny (Phase II)]' WHERE `locale` = 'deDE' AND `entry` = 30079;
-- OLD name : Willzyx
-- Source : https://www.wowhead.com/wotlk/de/npc=30080
UPDATE `creature_template_locale` SET `Name` = '[Willzyx]' WHERE `locale` = 'deDE' AND `entry` = 30080;
-- OLD name : Gebrochener Zeh
-- Source : https://www.wowhead.com/wotlk/de/npc=30088
UPDATE `creature_template_locale` SET `Name` = '[Brokentoe (Mount)]' WHERE `locale` = 'deDE' AND `entry` = 30088;
-- OLD name : Reitmammut
-- Source : https://www.wowhead.com/wotlk/de/npc=30089
UPDATE `creature_template_locale` SET `Name` = '[Mammoth Mount (Small)]' WHERE `locale` = 'deDE' AND `entry` = 30089;
-- OLD name : WotLK City Attacks Ice Block Bunny, Small
-- Source : https://www.wowhead.com/wotlk/de/npc=30101
UPDATE `creature_template_locale` SET `Name` = '[WotLK City Attacks Ice Block Bunny, Small]' WHERE `locale` = 'deDE' AND `entry` = 30101;
-- OLD subname : Waldläufergeneralin des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=30115
UPDATE `creature_template_locale` SET `Title` = 'Waldläufergeneral des Silberbunds' WHERE `locale` = 'deDE' AND `entry` = 30115;
-- OLD name : Vengeful Revenant KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30125
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Revenant KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30125;
-- OLD name : Njormeld KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30126
UPDATE `creature_template_locale` SET `Name` = '[Njormeld KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30126;
-- OLD name : Veranus Right Foot Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30130
UPDATE `creature_template_locale` SET `Name` = '[Veranus Right Foot Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30130;
-- OLD name : Veranus Left Foot Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30131
UPDATE `creature_template_locale` SET `Name` = '[Veranus Left Foot Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30131;
-- OLD name : Veranus Right Wing Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30132
UPDATE `creature_template_locale` SET `Name` = '[Veranus Right Wing Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30132;
-- OLD name : Veranus Left Wing Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30133
UPDATE `creature_template_locale` SET `Name` = '[Veranus Left Wing Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30133;
-- OLD name : Frostriesengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=30138
UPDATE `creature_template_locale` SET `Name` = '[Frost Giant Ghost KC]' WHERE `locale` = 'deDE' AND `entry` = 30138;
-- OLD name : Frostzwerggeist
-- Source : https://www.wowhead.com/wotlk/de/npc=30139
UPDATE `creature_template_locale` SET `Name` = '[Frost Dwarf Ghost KC]' WHERE `locale` = 'deDE' AND `entry` = 30139;
-- OLD name : Demo, Kultist der Eiskrone, subname : Kult der Verdammten
-- Source : https://www.wowhead.com/wotlk/de/npc=30149
UPDATE `creature_template_locale` SET `Name` = '[Demo, Icecrown Cultist]',`Title` = '[Cult of the Damned]' WHERE `locale` = 'deDE' AND `entry` = 30149;
-- OLD name : Frostbrutzerstörer
-- Source : https://www.wowhead.com/wotlk/de/npc=30150
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Destroyer]' WHERE `locale` = 'deDE' AND `entry` = 30150;
-- OLD name : Last Chapter Dialogue Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30153
UPDATE `creature_template_locale` SET `Name` = '[Last Chapter Dialogue Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30153;
-- OLD name : Himmelsklaue des Wyrmruhtempels
-- Source : https://www.wowhead.com/wotlk/de/npc=30161
UPDATE `creature_template_locale` SET `Name` = 'Himmelsklaue von Wyrmruh' WHERE `locale` = 'deDE' AND `entry` = 30161;
-- OLD name : Kampfmeister des Rings der Ehre, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=30171
UPDATE `creature_template_locale` SET `Name` = '[The Ring of Valor Battlemaster]',`Title` = '[Battle Master]' WHERE `locale` = 'deDE' AND `entry` = 30171;
-- OLD name : G'eras Test Vendor List
-- Source : https://www.wowhead.com/wotlk/de/npc=30201
UPDATE `creature_template_locale` SET `Name` = '[G''eras Test Vendor List]' WHERE `locale` = 'deDE' AND `entry` = 30201;
-- OLD name : Akolyth der Vergessenen Tiefen
-- Source : https://www.wowhead.com/wotlk/de/npc=30205
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Vergessenen Tiefen' WHERE `locale` = 'deDE' AND `entry` = 30205;
-- OLD name : Hodir's Helm KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30210
UPDATE `creature_template_locale` SET `Name` = '[Hodir''s Helm KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30210;
-- OLD name : Thrall's Big Hit, Lightning Bolt Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30214
UPDATE `creature_template_locale` SET `Name` = '[Thrall''s Big Hit, Lightning Bolt Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30214;
-- OLD name : Leave Our Mark Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30220
UPDATE `creature_template_locale` SET `Name` = '[Leave Our Mark Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30220;
-- OLD name : Kirgaraak Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=30221
UPDATE `creature_template_locale` SET `Name` = '[Kirgaraak Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 30221;
-- OLD name : Eisschlundbärenreittier
-- Source : https://www.wowhead.com/wotlk/de/npc=30229
UPDATE `creature_template_locale` SET `Name` = '[Icemaw Bear Mount]' WHERE `locale` = 'deDE' AND `entry` = 30229;
-- OLD name : Verletzter Späher der Sonnenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=30240
UPDATE `creature_template_locale` SET `Name` = '[Injured Sunreaver Scout]' WHERE `locale` = 'deDE' AND `entry` = 30240;
-- OLD name : Nexusfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=30245
UPDATE `creature_template_locale` SET `Name` = 'Nexuslord' WHERE `locale` = 'deDE' AND `entry` = 30245;
-- OLD name : Wissenshüter Randvir
-- Source : https://www.wowhead.com/wotlk/de/npc=30252
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Randvir' WHERE `locale` = 'deDE' AND `entry` = 30252;
-- OLD name : Späherhauptmann Daelin
-- Source : https://www.wowhead.com/wotlk/de/npc=30261
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Daelin' WHERE `locale` = 'deDE' AND `entry` = 30261;
-- OLD name : Verletzter Späher des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=30266
UPDATE `creature_template_locale` SET `Name` = '[Injured Silver Covenant Scout]' WHERE `locale` = 'deDE' AND `entry` = 30266;
-- OLD name : Wütender gepanzerter Hippogryph
-- Source : https://www.wowhead.com/wotlk/de/npc=30280
UPDATE `creature_template_locale` SET `Name` = '[Enraged Armored Hippogryph]' WHERE `locale` = 'deDE' AND `entry` = 30280;
-- OLD name : Verteidiger des Hafens von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=30289
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Harbor Defender]' WHERE `locale` = 'deDE' AND `entry` = 30289;
-- OLD name : Drachenfalke der Sonnenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=30290
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Dragonhawk]' WHERE `locale` = 'deDE' AND `entry` = 30290;
-- OLD name : Hauptmann des Hafens von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=30293
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Harbor Captain]' WHERE `locale` = 'deDE' AND `entry` = 30293;
-- OLD name : Iron Sentinel Credit, subname : Diener von Loken
-- Source : https://www.wowhead.com/wotlk/de/npc=30296
UPDATE `creature_template_locale` SET `Name` = '[Iron Sentinel Credit]',`Title` = '[Servant of Loken]' WHERE `locale` = 'deDE' AND `entry` = 30296;
-- OLD name : Iron Dwarf Assailant Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=30297
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Assailant Credit]' WHERE `locale` = 'deDE' AND `entry` = 30297;
-- OLD name : Schneller fliegender Besen
-- Source : https://www.wowhead.com/wotlk/de/npc=30305
UPDATE `creature_template_locale` SET `Name` = '[Swift Flying Broom]' WHERE `locale` = 'deDE' AND `entry` = 30305;
-- OLD name : Jokkum KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30327
UPDATE `creature_template_locale` SET `Name` = '[Jokkum KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30327;
-- OLD name : Thorim
-- Source : https://www.wowhead.com/wotlk/de/npc=30328
UPDATE `creature_template_locale` SET `Name` = '[Thorim]' WHERE `locale` = 'deDE' AND `entry` = 30328;
-- OLD name : Frigid Tomb Controller Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30339
UPDATE `creature_template_locale` SET `Name` = '[Frigid Tomb Controller Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30339;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/de/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorkuttar' WHERE `locale` = 'deDE' AND `entry` = 30340;
-- OLD name : Urahne Sardis
-- Source : https://www.wowhead.com/wotlk/de/npc=30348
UPDATE `creature_template_locale` SET `Name` = '[Elder Sardis]' WHERE `locale` = 'deDE' AND `entry` = 30348;
-- OLD name : Allianzwache von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=30354
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Alliance Melee Guard]' WHERE `locale` = 'deDE' AND `entry` = 30354;
-- OLD name : Allianzwache von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=30355
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Alliance Ranged Guard]' WHERE `locale` = 'deDE' AND `entry` = 30355;
-- OLD name : Urahne Beldak
-- Source : https://www.wowhead.com/wotlk/de/npc=30357
UPDATE `creature_template_locale` SET `Name` = '[Elder Beldak]' WHERE `locale` = 'deDE' AND `entry` = 30357;
-- OLD name : Urahne Morthie
-- Source : https://www.wowhead.com/wotlk/de/npc=30358
UPDATE `creature_template_locale` SET `Name` = '[Elder Morthie]' WHERE `locale` = 'deDE' AND `entry` = 30358;
-- OLD name : Urahne Fargal
-- Source : https://www.wowhead.com/wotlk/de/npc=30359
UPDATE `creature_template_locale` SET `Name` = '[Elder Fargal]' WHERE `locale` = 'deDE' AND `entry` = 30359;
-- OLD name : Urahne Northal
-- Source : https://www.wowhead.com/wotlk/de/npc=30360
UPDATE `creature_template_locale` SET `Name` = '[Elder Northal]' WHERE `locale` = 'deDE' AND `entry` = 30360;
-- OLD name : Urahne Sandrene
-- Source : https://www.wowhead.com/wotlk/de/npc=30362
UPDATE `creature_template_locale` SET `Name` = '[Elder Sandrene]' WHERE `locale` = 'deDE' AND `entry` = 30362;
-- OLD name : Urahne Thoim
-- Source : https://www.wowhead.com/wotlk/de/npc=30363
UPDATE `creature_template_locale` SET `Name` = '[Elder Thoim]' WHERE `locale` = 'deDE' AND `entry` = 30363;
-- OLD name : Urahne Arp
-- Source : https://www.wowhead.com/wotlk/de/npc=30364
UPDATE `creature_template_locale` SET `Name` = '[Elder Arp]' WHERE `locale` = 'deDE' AND `entry` = 30364;
-- OLD name : Urahne Wanikaya
-- Source : https://www.wowhead.com/wotlk/de/npc=30365
UPDATE `creature_template_locale` SET `Name` = '[Elder Wanikaya]' WHERE `locale` = 'deDE' AND `entry` = 30365;
-- OLD name : Urahne Lunaro
-- Source : https://www.wowhead.com/wotlk/de/npc=30367
UPDATE `creature_template_locale` SET `Name` = '[Elder Lunaro]' WHERE `locale` = 'deDE' AND `entry` = 30367;
-- OLD name : Urahne Blauwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=30368
UPDATE `creature_template_locale` SET `Name` = '[Elder Bluewolf]' WHERE `locale` = 'deDE' AND `entry` = 30368;
-- OLD name : Urahne Pamuya
-- Source : https://www.wowhead.com/wotlk/de/npc=30371
UPDATE `creature_template_locale` SET `Name` = '[Elder Pamuya]' WHERE `locale` = 'deDE' AND `entry` = 30371;
-- OLD name : Urahne Whurain
-- Source : https://www.wowhead.com/wotlk/de/npc=30372
UPDATE `creature_template_locale` SET `Name` = '[Elder Whurain]' WHERE `locale` = 'deDE' AND `entry` = 30372;
-- OLD name : Urahne Muraco
-- Source : https://www.wowhead.com/wotlk/de/npc=30374
UPDATE `creature_template_locale` SET `Name` = '[Elder Muraco]' WHERE `locale` = 'deDE' AND `entry` = 30374;
-- OLD name : Urahne Steinbart
-- Source : https://www.wowhead.com/wotlk/de/npc=30375
UPDATE `creature_template_locale` SET `Name` = '[Elder Stonebeard]' WHERE `locale` = 'deDE' AND `entry` = 30375;
-- OLD name : Ahne der Taunka
-- Source : https://www.wowhead.com/wotlk/de/npc=30386
UPDATE `creature_template_locale` SET `Name` = '[Taunka Ancestor]' WHERE `locale` = 'deDE' AND `entry` = 30386;
-- OLD subname : Verwüsteringenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30400
UPDATE `creature_template_locale` SET `Title` = 'Verwüstungsingenieur' WHERE `locale` = 'deDE' AND `entry` = 30400;
-- OLD name : Proxy der vergessenen Tiefen
-- Source : https://www.wowhead.com/wotlk/de/npc=30402
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Depths Proxy]' WHERE `locale` = 'deDE' AND `entry` = 30402;
-- OLD name : Deep in the Bowels of The Underhalls Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30412
UPDATE `creature_template_locale` SET `Name` = '[Deep in the Bowels of The Underhalls Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30412;
-- OLD name : Wild Wyrm KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30415
UPDATE `creature_template_locale` SET `Name` = '[Wild Wyrm KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30415;
-- OLD name : Lok'lira die Greisin
-- Source : https://www.wowhead.com/wotlk/de/npc=30417
UPDATE `creature_template_locale` SET `Name` = '[Lok''lira the Crone]' WHERE `locale` = 'deDE' AND `entry` = 30417;
-- OLD name : Roaming Jormungar KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30421
UPDATE `creature_template_locale` SET `Name` = '[Roaming Jormungar KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30421;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin
-- Source : https://www.wowhead.com/wotlk/de/npc=30426
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 01)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'deDE' AND `entry` = 30426;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin
-- Source : https://www.wowhead.com/wotlk/de/npc=30427
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 02)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'deDE' AND `entry` = 30427;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin
-- Source : https://www.wowhead.com/wotlk/de/npc=30428
UPDATE `creature_template_locale` SET `Name` = '[Lady Sylvanas Windrunner (Test 03)]',`Title` = '[Banshee Queen]' WHERE `locale` = 'deDE' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 30437;
-- OLD subname : Gifte, Reagenzien & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=30438
UPDATE `creature_template_locale` SET `Title` = 'Gifte, Reagenzien & Handelswaren' WHERE `locale` = 'deDE' AND `entry` = 30438;
-- OLD name : Hilfsarbeiter des Vorpostens
-- Source : https://www.wowhead.com/wotlk/de/npc=30440
UPDATE `creature_template_locale` SET `Name` = '[Vanguard Laborer]' WHERE `locale` = 'deDE' AND `entry` = 30440;
-- OLD name : Verbrannter Hilfsarbeiter des Vorpostens
-- Source : https://www.wowhead.com/wotlk/de/npc=30441
UPDATE `creature_template_locale` SET `Name` = '[Burdened Vanguard Laborer]' WHERE `locale` = 'deDE' AND `entry` = 30441;
-- OLD name : Zaks Flugmaschine
-- Source : https://www.wowhead.com/wotlk/de/npc=30463
UPDATE `creature_template_locale` SET `Name` = '[Zak''s Flying Machine]' WHERE `locale` = 'deDE' AND `entry` = 30463;
-- OLD name : Dans Testleerenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=30465
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Void Sentry]' WHERE `locale` = 'deDE' AND `entry` = 30465;
-- OLD name : Lok'lira the Crone's Conversation Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=30467
UPDATE `creature_template_locale` SET `Name` = '[Lok''lira the Crone''s Conversation Credit]' WHERE `locale` = 'deDE' AND `entry` = 30467;
-- OLD name : Ritssyn
-- Source : https://www.wowhead.com/wotlk/de/npc=30491
UPDATE `creature_template_locale` SET `Name` = '[Ritssyn]' WHERE `locale` = 'deDE' AND `entry` = 30491;
-- OLD name : Gnomeningenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30499
UPDATE `creature_template_locale` SET `Name` = 'Gnomingenieur' WHERE `locale` = 'deDE' AND `entry` = 30499;
-- OLD name : Sturmgeschmiedeter Dezimierer
-- Source : https://www.wowhead.com/wotlk/de/npc=30503
UPDATE `creature_template_locale` SET `Name` = '[Stormforged Decimator]' WHERE `locale` = 'deDE' AND `entry` = 30503;
-- OLD name : Sturmgeschmiedeter Kriegshetzer
-- Source : https://www.wowhead.com/wotlk/de/npc=30504
UPDATE `creature_template_locale` SET `Name` = 'Sturmgeschmiedeter Kriegstreiber' WHERE `locale` = 'deDE' AND `entry` = 30504;
-- OLD name : Braufestkodo
-- Source : https://www.wowhead.com/wotlk/de/npc=30507
UPDATE `creature_template_locale` SET `Name` = '[Brewfest Kodo]' WHERE `locale` = 'deDE' AND `entry` = 30507;
-- OLD name : Thorim Talk KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30514
UPDATE `creature_template_locale` SET `Name` = '[Thorim Talk KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30514;
-- OLD name : Witness the Reckoning Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=30515
UPDATE `creature_template_locale` SET `Name` = '[Witness the Reckoning Credit]' WHERE `locale` = 'deDE' AND `entry` = 30515;
-- OLD name : Training Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=30527
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (30527, 'deDE','[Training Dummy]',NULL);
-- OLD name : Urahne Jarten
-- Source : https://www.wowhead.com/wotlk/de/npc=30531
UPDATE `creature_template_locale` SET `Name` = '[Elder Jarten]' WHERE `locale` = 'deDE' AND `entry` = 30531;
-- OLD name : Urahne Nurgen
-- Source : https://www.wowhead.com/wotlk/de/npc=30533
UPDATE `creature_template_locale` SET `Name` = '[Elder Nurgen]' WHERE `locale` = 'deDE' AND `entry` = 30533;
-- OLD name : Urahne Yurauk
-- Source : https://www.wowhead.com/wotlk/de/npc=30535
UPDATE `creature_template_locale` SET `Name` = '[Elder Yurauk]' WHERE `locale` = 'deDE' AND `entry` = 30535;
-- OLD name : Urahne Igasho
-- Source : https://www.wowhead.com/wotlk/de/npc=30536
UPDATE `creature_template_locale` SET `Name` = '[Elder Igasho]' WHERE `locale` = 'deDE' AND `entry` = 30536;
-- OLD name : Urahne Ohanzee
-- Source : https://www.wowhead.com/wotlk/de/npc=30537
UPDATE `creature_template_locale` SET `Name` = '[Elder Ohanzee]' WHERE `locale` = 'deDE' AND `entry` = 30537;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/de/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'deDE' AND `entry` = 30552;
-- OLD name : Jessica Rotpfad
-- Source : https://www.wowhead.com/wotlk/de/npc=30558
UPDATE `creature_template_locale` SET `Name` = '[Jessica Redpath]' WHERE `locale` = 'deDE' AND `entry` = 30558;
-- OLD name : Kiste mit Landminen
-- Source : https://www.wowhead.com/wotlk/de/npc=30563
UPDATE `creature_template_locale` SET `Name` = '[Crate of Land Mines]' WHERE `locale` = 'deDE' AND `entry` = 30563;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=30570
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 30570;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 30572;
-- OLD name : Bethany Aldire, subname : Kampfmeisterin des Strands der Uralten
-- Source : https://www.wowhead.com/wotlk/de/npc=30578
UPDATE `creature_template_locale` SET `Name` = '[Bethany Aldire]',`Title` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 30578;
-- OLD name : Buhurda, subname : Kampfmeister des Strands der Uralten
-- Source : https://www.wowhead.com/wotlk/de/npc=30581
UPDATE `creature_template_locale` SET `Name` = '[Buhurda]',`Title` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 30581;
-- OLD name : Mabrian Morgenferne, subname : Kampfmeister des Strands der Uralten
-- Source : https://www.wowhead.com/wotlk/de/npc=30584
UPDATE `creature_template_locale` SET `Name` = '[Mabrian Fardawn]',`Title` = '[Strand of the Ancients Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 30584;
-- OLD name : Stachelziel
-- Source : https://www.wowhead.com/wotlk/de/npc=30598
UPDATE `creature_template_locale` SET `Name` = '[Spike Target]' WHERE `locale` = 'deDE' AND `entry` = 30598;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/de/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Arenaveranstalterin' WHERE `locale` = 'deDE' AND `entry` = 30611;
-- OLD name : Blutstachel, subname : Mologs Begleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=30613
UPDATE `creature_template_locale` SET `Name` = '[Bloodsting]',`Title` = '[Molog''s Pet]' WHERE `locale` = 'deDE' AND `entry` = 30613;
-- OLD name : Stachelziel 2
-- Source : https://www.wowhead.com/wotlk/de/npc=30614
UPDATE `creature_template_locale` SET `Name` = '[Spike Target 2]' WHERE `locale` = 'deDE' AND `entry` = 30614;
-- OLD name : Dans Testdummy (Non Vehicle)
-- Source : https://www.wowhead.com/wotlk/de/npc=30615
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Dummy (Non Vehicle)]' WHERE `locale` = 'deDE' AND `entry` = 30615;
-- OLD name : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=30618
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30618;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (30618, 'deDE','[]',NULL);
-- OLD name : Peon von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=30619
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Peon]' WHERE `locale` = 'deDE' AND `entry` = 30619;
-- OLD name : Arbeiter von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=30626
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Peasant]' WHERE `locale` = 'deDE' AND `entry` = 30626;
-- OLD name : Auge von Acherus (TR)
-- Source : https://www.wowhead.com/wotlk/de/npc=30628
UPDATE `creature_template_locale` SET `Name` = '[Eye of Acherus (DK)]' WHERE `locale` = 'deDE' AND `entry` = 30628;
-- OLD name : Sterbliche Essenz
-- Source : https://www.wowhead.com/wotlk/de/npc=30629
UPDATE `creature_template_locale` SET `Name` = '[Mortal Essence]' WHERE `locale` = 'deDE' AND `entry` = 30629;
-- OLD name : Zwielichtriss
-- Source : https://www.wowhead.com/wotlk/de/npc=30641
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtspalt' WHERE `locale` = 'deDE' AND `entry` = 30641;
-- OLD name : The Art of Being a Water Terror Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30644
UPDATE `creature_template_locale` SET `Name` = '[The Art of Being a Water Terror Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30644;
-- OLD name : Shadron Portal Visual
-- Source : https://www.wowhead.com/wotlk/de/npc=30650
UPDATE `creature_template_locale` SET `Name` = '[Shadron Portal Visual]' WHERE `locale` = 'deDE' AND `entry` = 30650;
-- OLD name : Azurblauer Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Azurblaue Zauberin' WHERE `locale` = 'deDE' AND `entry` = 30667;
-- OLD name : Scourge Proxy Chapter II
-- Source : https://www.wowhead.com/wotlk/de/npc=30670
UPDATE `creature_template_locale` SET `Name` = '[Scourge Proxy Chapter II]' WHERE `locale` = 'deDE' AND `entry` = 30670;
-- OLD name : Jonna Robertson, subname : Wegbeschreibungen
-- Source : https://www.wowhead.com/wotlk/de/npc=30678
UPDATE `creature_template_locale` SET `Name` = '[Jonna Robertson]',`Title` = '[Directions]' WHERE `locale` = 'deDE' AND `entry` = 30678;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 30721;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 30722;
-- OLD name : Stachelloser Ghul
-- Source : https://www.wowhead.com/wotlk/de/npc=30728
UPDATE `creature_template_locale` SET `Name` = '[Unspiked Ghoul]' WHERE `locale` = 'deDE' AND `entry` = 30728;
-- OLD name : Tabard Faction Tester
-- Source : https://www.wowhead.com/wotlk/de/npc=30738
UPDATE `creature_template_locale` SET `Name` = '[Tabard Faction Tester]' WHERE `locale` = 'deDE' AND `entry` = 30738;
-- OLD name : Shadronportal
-- Source : https://www.wowhead.com/wotlk/de/npc=30741
UPDATE `creature_template_locale` SET `Name` = '[Shadron Portal]' WHERE `locale` = 'deDE' AND `entry` = 30741;
-- OLD name : Succubus Transform 01
-- Source : https://www.wowhead.com/wotlk/de/npc=30743
UPDATE `creature_template_locale` SET `Name` = '[Succubus Transform 01]' WHERE `locale` = 'deDE' AND `entry` = 30743;
-- OLD name : Through the Eye Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30750
UPDATE `creature_template_locale` SET `Name` = '[Through the Eye Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30750;
-- OLD name : Teleporter in den Hallen der Blitze
-- Source : https://www.wowhead.com/wotlk/de/npc=30828
UPDATE `creature_template_locale` SET `Name` = '[Halls of Lightning Teleporter]' WHERE `locale` = 'deDE' AND `entry` = 30828;
-- OLD name : Abgetrennte Seele
-- Source : https://www.wowhead.com/wotlk/de/npc=30843
UPDATE `creature_template_locale` SET `Name` = '[Severed Soul]' WHERE `locale` = 'deDE' AND `entry` = 30843;
-- OLD name : Death Gate (Dummy)
-- Source : https://www.wowhead.com/wotlk/de/npc=30844
UPDATE `creature_template_locale` SET `Name` = '[Death Gate (Dummy)]' WHERE `locale` = 'deDE' AND `entry` = 30844;
-- OLD name : Gnomhubschrauber
-- Source : https://www.wowhead.com/wotlk/de/npc=30853
UPDATE `creature_template_locale` SET `Name` = '[Gnomish ''Chopper]' WHERE `locale` = 'deDE' AND `entry` = 30853;
-- OLD name : Ingenieur von Tausendwinter
-- Source : https://www.wowhead.com/wotlk/de/npc=30855
UPDATE `creature_template_locale` SET `Name` = '[Wintergrasp Engineer]' WHERE `locale` = 'deDE' AND `entry` = 30855;
-- OLD name : Aura der Unverwundbarkeit
-- Source : https://www.wowhead.com/wotlk/de/npc=30874
UPDATE `creature_template_locale` SET `Name` = '[Invulnerability Aura]' WHERE `locale` = 'deDE' AND `entry` = 30874;
-- OLD name : Find the Ancient Hero Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=30880
UPDATE `creature_template_locale` SET `Name` = '[Find the Ancient Hero Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30880;
-- OLD subname : Überholte Arenarüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Wasserverkäufer' WHERE `locale` = 'deDE' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/de/npc=30888
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Hostile Low Damage]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 30888;
-- OLD name : Ei der Tenebron
-- Source : https://www.wowhead.com/wotlk/de/npc=30948
UPDATE `creature_template_locale` SET `Name` = '[Tenebron Egg (Twilight)]' WHERE `locale` = 'deDE' AND `entry` = 30948;
-- OLD name : Azurblauer Magiertöter
-- Source : https://www.wowhead.com/wotlk/de/npc=30963
UPDATE `creature_template_locale` SET `Name` = 'Azurblauer Pirscher' WHERE `locale` = 'deDE' AND `entry` = 30963;
-- OLD name : Magistrat Barthilas
-- Source : https://www.wowhead.com/wotlk/de/npc=30994
UPDATE `creature_template_locale` SET `Name` = '[Magistrate Barthilas]' WHERE `locale` = 'deDE' AND `entry` = 30994;
-- OLD name : Kisten
-- Source : https://www.wowhead.com/wotlk/de/npc=30996
UPDATE `creature_template_locale` SET `Name` = '[CoT Stratholme - Crates KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 30996;
-- OLD name : Mal'Ganis
-- Source : https://www.wowhead.com/wotlk/de/npc=31006
UPDATE `creature_template_locale` SET `Name` = '[CoT Stratholme - Mal''Ganis KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31006;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=31017
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 31017;
-- OLD name : Olivia Zenith, subname : Schneiderin
-- Source : https://www.wowhead.com/wotlk/de/npc=31020
UPDATE `creature_template_locale` SET `Name` = '[Olivia Zenith]',`Title` = '[Tailor]' WHERE `locale` = 'deDE' AND `entry` = 31020;
-- OLD name : Sophie Aaren, subname : Floristin
-- Source : https://www.wowhead.com/wotlk/de/npc=31021
UPDATE `creature_template_locale` SET `Name` = '[Sophie Aaren]',`Title` = '[Florist]' WHERE `locale` = 'deDE' AND `entry` = 31021;
-- OLD name : George Gutmann, subname : Gemischtwaren
-- Source : https://www.wowhead.com/wotlk/de/npc=31022
UPDATE `creature_template_locale` SET `Name` = '[George Goodman]',`Title` = '[General Goods]' WHERE `locale` = 'deDE' AND `entry` = 31022;
-- OLD name : Robert Pierce, subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=31025
UPDATE `creature_template_locale` SET `Name` = '[Robert Pierce]',`Title` = '[Ammunition]' WHERE `locale` = 'deDE' AND `entry` = 31025;
-- OLD name : Anna Moony, subname : Kellnerin
-- Source : https://www.wowhead.com/wotlk/de/npc=31026
UPDATE `creature_template_locale` SET `Name` = '[Anna Moony]',`Title` = '[Waitress]' WHERE `locale` = 'deDE' AND `entry` = 31026;
-- OLD name : Patricia O'Reilly, subname : Magistratsassistentin
-- Source : https://www.wowhead.com/wotlk/de/npc=31028
UPDATE `creature_template_locale` SET `Name` = '[Patricia O''Reilly]',`Title` = '[Magistrate Assistant]' WHERE `locale` = 'deDE' AND `entry` = 31028;
-- OLD name : Töter der Vergessenen Tiefen
-- Source : https://www.wowhead.com/wotlk/de/npc=31038
UPDATE `creature_template_locale` SET `Name` = '[Forgotten Depths Slayer]' WHERE `locale` = 'deDE' AND `entry` = 31038;
-- OLD name : Entmutigter Ent
-- Source : https://www.wowhead.com/wotlk/de/npc=31041
UPDATE `creature_template_locale` SET `Name` = 'Zweigeistiger Ent' WHERE `locale` = 'deDE' AND `entry` = 31041;
-- OLD name : Packmuli
-- Source : https://www.wowhead.com/wotlk/de/npc=31046
UPDATE `creature_template_locale` SET `Name` = '[Pack Mule (Chapter IV)]' WHERE `locale` = 'deDE' AND `entry` = 31046;
-- OLD name : ELM General Purpose Bunny Gigantic
-- Source : https://www.wowhead.com/wotlk/de/npc=31047
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Gigantic]' WHERE `locale` = 'deDE' AND `entry` = 31047;
-- OLD name : Eliteprotodrache von Balagarde
-- Source : https://www.wowhead.com/wotlk/de/npc=31056
UPDATE `creature_template_locale` SET `Name` = '[Balargarde Elite Proto-Drake]' WHERE `locale` = 'deDE' AND `entry` = 31056;
-- OLD name : Kreuzzugsarchitekt Silas
-- Source : https://www.wowhead.com/wotlk/de/npc=31058
UPDATE `creature_template_locale` SET `Name` = '[Crusade Architect Silas (Chapter IV)]' WHERE `locale` = 'deDE' AND `entry` = 31058;
-- OLD name : Russell Bernau Test NPC
-- Source : https://www.wowhead.com/wotlk/de/npc=31060
UPDATE `creature_template_locale` SET `Name` = '[Russell Bernau Test NPC]' WHERE `locale` = 'deDE' AND `entry` = 31060;
-- OLD name : Kreuzzugsingenieur Spitzpatrick
-- Source : https://www.wowhead.com/wotlk/de/npc=31061
UPDATE `creature_template_locale` SET `Name` = '[Crusade Engineer Spitzpatrick (Chapter IV)]' WHERE `locale` = 'deDE' AND `entry` = 31061;
-- OLD name : Belagerungsmeister Fezzik
-- Source : https://www.wowhead.com/wotlk/de/npc=31062
UPDATE `creature_template_locale` SET `Name` = '[Siegemaster Fezzik (Chapter IV)]' WHERE `locale` = 'deDE' AND `entry` = 31062;
-- OLD name : Indalamars Nax-10-Verkäufer, subname : Tolles Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=31076
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Nax 10 Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 31076;
-- OLD name : Feiger Acherusspuk
-- Source : https://www.wowhead.com/wotlk/de/npc=31090
UPDATE `creature_template_locale` SET `Name` = '[Cowardly Acherus Geist]' WHERE `locale` = 'deDE' AND `entry` = 31090;
-- OLD name : Scourge Egg KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31092
UPDATE `creature_template_locale` SET `Name` = '[Scourge Egg KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31092;
-- OLD name : Verängstigter Ghul
-- Source : https://www.wowhead.com/wotlk/de/npc=31097
UPDATE `creature_template_locale` SET `Name` = '[Frightened Ghoul]' WHERE `locale` = 'deDE' AND `entry` = 31097;
-- OLD name : Geißelstellvertreter von Acherus
-- Source : https://www.wowhead.com/wotlk/de/npc=31100
UPDATE `creature_template_locale` SET `Name` = '[Acherus Scourge Proxy]' WHERE `locale` = 'deDE' AND `entry` = 31100;
-- OLD name : Nachtelfirokese
-- Source : https://www.wowhead.com/wotlk/de/npc=31111
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mohawk]' WHERE `locale` = 'deDE' AND `entry` = 31111;
-- OLD name : Indalamars Nax-25-Verkäufer, subname : Tolles Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=31116
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Nax 25 Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 31116;
-- OLD name : Verfallendes Geschöpf
-- Source : https://www.wowhead.com/wotlk/de/npc=31141
UPDATE `creature_template_locale` SET `Name` = '[Decaying Wight]' WHERE `locale` = 'deDE' AND `entry` = 31141;
-- OLD name : Reinforced Training Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'deDE','[Reinforced Training Dummy]',NULL);
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Großmeisters' WHERE `locale` = 'deDE' AND `entry` = 31144;
-- OLD name : Trainingsattrappe des Schlachtzuges
-- Source : https://www.wowhead.com/wotlk/de/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Heroische Trainingsattrappe' WHERE `locale` = 'deDE' AND `entry` = 31146;
-- OLD name : Portal des Tausendwintersees
-- Source : https://www.wowhead.com/wotlk/de/npc=31149
UPDATE `creature_template_locale` SET `Name` = '[Lake Wintergrasp Portal]' WHERE `locale` = 'deDE' AND `entry` = 31149;
-- OLD name : V
-- Source : https://www.wowhead.com/wotlk/de/npc=31168
UPDATE `creature_template_locale` SET `Name` = '[V]' WHERE `locale` = 'deDE' AND `entry` = 31168;
-- OLD name : Reitargentumhimmelsklaue
-- Source : https://www.wowhead.com/wotlk/de/npc=31209
UPDATE `creature_template_locale` SET `Name` = '[Riding Argent Skytalon, Neutral (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 31209;
-- OLD name : Akolyth von Shadron
-- Source : https://www.wowhead.com/wotlk/de/npc=31218
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Shadron' WHERE `locale` = 'deDE' AND `entry` = 31218;
-- OLD name : Akolyth von Vesperon
-- Source : https://www.wowhead.com/wotlk/de/npc=31219
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Vesperon' WHERE `locale` = 'deDE' AND `entry` = 31219;
-- OLD name : Unglückselige Dryade
-- Source : https://www.wowhead.com/wotlk/de/npc=31230
UPDATE `creature_template_locale` SET `Name` = '[Forlorn Dryad]' WHERE `locale` = 'deDE' AND `entry` = 31230;
-- OLD name : Indalamars Verkäufer für Embleme der Ehre, subname : Tolles Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=31234
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Valor Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 31234;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=31238
UPDATE `creature_template_locale` SET `Title` = 'Lehrerin für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 31238;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 31247;
-- OLD name : Rimi Kaltkurbel, subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=31248
UPDATE `creature_template_locale` SET `Name` = '[Rimi Coldcrank]',`Title` = '[Cold Weather Flying Trainer]' WHERE `locale` = 'deDE' AND `entry` = 31248;
-- OLD name : Sigrid Eiskinds Protodrache
-- Source : https://www.wowhead.com/wotlk/de/npc=31249
UPDATE `creature_template_locale` SET `Name` = '[Sigrid Iceborn''s Proto-Drake (mountable)]' WHERE `locale` = 'deDE' AND `entry` = 31249;
-- OLD name : Böser Fisch - Frosch
-- Source : https://www.wowhead.com/wotlk/de/npc=31252
UPDATE `creature_template_locale` SET `Name` = '[Bad Fish - Critter]' WHERE `locale` = 'deDE' AND `entry` = 31252;
-- OLD name : Böser Fisch - Hase
-- Source : https://www.wowhead.com/wotlk/de/npc=31256
UPDATE `creature_template_locale` SET `Name` = '[Bad Fish - Rabbits]' WHERE `locale` = 'deDE' AND `entry` = 31256;
-- OLD name : Eine geheimnisvolle Stimme
-- Source : https://www.wowhead.com/wotlk/de/npc=31264
UPDATE `creature_template_locale` SET `Name` = 'Eine mysteriöse Stimme' WHERE `locale` = 'deDE' AND `entry` = 31264;
-- OLD name : Kampfwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=31269
UPDATE `creature_template_locale` SET `Name` = 'Kampfflügeldrache der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 31269;
-- OLD name : Dying Berserker KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31272
UPDATE `creature_template_locale` SET `Name` = '[Dying Berserker KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31272;
-- OLD name : Aufseher der Todesritter
-- Source : https://www.wowhead.com/wotlk/de/npc=31274
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Overseer]' WHERE `locale` = 'deDE' AND `entry` = 31274;
-- OLD name : Gefräßiger Ghul
-- Source : https://www.wowhead.com/wotlk/de/npc=31278
UPDATE `creature_template_locale` SET `Name` = '[Ravenous Ghoul]' WHERE `locale` = 'deDE' AND `entry` = 31278;
-- OLD name : Arkanistin Ivrenne, subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31300
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Ivrenne]',`Title` = '[Emblem of Heroism Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31300;
-- OLD name : Magistrix Lambriesse, subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31302
UPDATE `creature_template_locale` SET `Name` = '[Magistrix Lambriesse]',`Title` = '[Emblem of Heroism Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31302;
-- OLD name : Arkanist Adurin, subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31305
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Adurin]',`Title` = '[Emblem of Valor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31305;
-- OLD name : Magister Brasael, subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31307
UPDATE `creature_template_locale` SET `Name` = '[Magister Brasael]',`Title` = '[Emblem of Valor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31307;
-- OLD name : Dying Soldier KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31312
UPDATE `creature_template_locale` SET `Name` = '[Dying Soldier KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31312;
-- OLD name : Reithippogryph
-- Source : https://www.wowhead.com/wotlk/de/npc=31315
UPDATE `creature_template_locale` SET `Name` = '[Riding Hippogryph (Armored)]' WHERE `locale` = 'deDE' AND `entry` = 31315;
-- OLD name : Großer Blizzardbär
-- Source : https://www.wowhead.com/wotlk/de/npc=31319
UPDATE `creature_template_locale` SET `Name` = '[Big Blizzard Bear]' WHERE `locale` = 'deDE' AND `entry` = 31319;
-- OLD name : Skeletal Footsoldier Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=31329
UPDATE `creature_template_locale` SET `Name` = '[Skeletal Footsoldier Credit]' WHERE `locale` = 'deDE' AND `entry` = 31329;
-- OLD name : Indalamars Verkäufer für Embleme des Heldentums, subname : Tolles Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=31331
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Heroism Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 31331;
-- OLD name : Frostbruthimmelsklaue KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31364
UPDATE `creature_template_locale` SET `Name` = '[Frostbrood Skytalon KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31364;
-- OLD name : Illidan Sturmgrimm
-- Source : https://www.wowhead.com/wotlk/de/npc=31395
UPDATE `creature_template_locale` SET `Name` = '[Illidan Stormrage]' WHERE `locale` = 'deDE' AND `entry` = 31395;
-- OLD name : Der auserwählte Held
-- Source : https://www.wowhead.com/wotlk/de/npc=31398
UPDATE `creature_template_locale` SET `Name` = '[The Chosen Champion]' WHERE `locale` = 'deDE' AND `entry` = 31398;
-- OLD name : Bomber von Eiskrone
-- Source : https://www.wowhead.com/wotlk/de/npc=31405
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber Beacon, Horde]' WHERE `locale` = 'deDE' AND `entry` = 31405;
-- OLD name : WotLK City Attacks Ice Block Bunny, BUG TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=31415
UPDATE `creature_template_locale` SET `Name` = '[WotLK City Attacks Ice Block Bunny, BUG TEST]' WHERE `locale` = 'deDE' AND `entry` = 31415;
-- OLD subname : Schusswaffenverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=31423
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition' WHERE `locale` = 'deDE' AND `entry` = 31423;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=31429
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 31429;
-- OLD name : Auktionator Thathung
-- Source : https://www.wowhead.com/wotlk/de/npc=31430
UPDATE `creature_template_locale` SET `Name` = 'Auktionator Thatung' WHERE `locale` = 'deDE' AND `entry` = 31430;
-- OLD name : Scourge Fight Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=31481
UPDATE `creature_template_locale` SET `Name` = '[Scourge Fight Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 31481;
-- OLD name : Freundlicher Zauberer aus Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=31522
UPDATE `creature_template_locale` SET `Name` = '[Friendly Dalaran Wizard]' WHERE `locale` = 'deDE' AND `entry` = 31522;
-- OLD name : Freundlicher Gladiator aus Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=31523
UPDATE `creature_template_locale` SET `Name` = '[Friendly Dalaran Gladiator]' WHERE `locale` = 'deDE' AND `entry` = 31523;
-- OLD name : Arkanist Peridris, subname : Rüstmeister für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31545
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Peridris]',`Title` = '[Honor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31545;
-- OLD name : Arkanistin Baladrialle, subname : Erfahrene Rüstmeisterin für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31549
UPDATE `creature_template_locale` SET `Name` = '[Arcanist Baladrialle]',`Title` = '[Veteran Honor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31549;
-- OLD name : Magistrix Feyrina, subname : Erfahrene Rüstmeisterin für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31551
UPDATE `creature_template_locale` SET `Name` = '[Magistrix Feyrina]',`Title` = '[Veteran Honor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31551;
-- OLD name : Magister Saremvir, subname : Rüstmeister für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=31552
UPDATE `creature_template_locale` SET `Name` = '[Magister Saremvir]',`Title` = '[Honor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 31552;
-- OLD name : Blight Wagon [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31566
UPDATE `creature_template_locale` SET `Name` = '[Blight Wagon [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31566;
-- OLD name : Forsaken Chemistry Set [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31567
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Chemistry Set [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31567;
-- OLD name : Forsaken Chemistry Set 02 [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31568
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Chemistry Set 02 [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31568;
-- OLD name : Plague Barrel [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31569
UPDATE `creature_template_locale` SET `Name` = '[Plague Barrel [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31569;
-- OLD name : Broken Plague Barrel  [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31570
UPDATE `creature_template_locale` SET `Name` = '[Broken Plague Barrel  [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31570;
-- OLD name : Broken Plague Barrel 2 [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31571
UPDATE `creature_template_locale` SET `Name` = '[Broken Plague Barrel 2 [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31571;
-- OLD name : Verseuchte Kakerlake
-- Source : https://www.wowhead.com/wotlk/de/npc=31572
UPDATE `creature_template_locale` SET `Name` = '[Blighted Cockroach]' WHERE `locale` = 'deDE' AND `entry` = 31572;
-- OLD name : Forsaken Fire [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31573
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Fire [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31573;
-- OLD name : Forsaken Fire Small [Wrath Gate Both] (UC)
-- Source : https://www.wowhead.com/wotlk/de/npc=31574
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Fire Small [Wrath Gate Both] (UC)]' WHERE `locale` = 'deDE' AND `entry` = 31574;
-- OLD subname : Emblem der Ehre Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Ehre' WHERE `locale` = 'deDE' AND `entry` = 31579;
-- OLD subname : Emblem des Heldentums Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Heldentums' WHERE `locale` = 'deDE' AND `entry` = 31580;
-- OLD subname : Emblem der Ehre Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Ehre' WHERE `locale` = 'deDE' AND `entry` = 31581;
-- OLD subname : Emblem des Heldentums Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Heldentums' WHERE `locale` = 'deDE' AND `entry` = 31582;
-- OLD name : Cosmetic Trigger - Phase 2 - LAB
-- Source : https://www.wowhead.com/wotlk/de/npc=31645
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Trigger - Phase 2 - LAB]' WHERE `locale` = 'deDE' AND `entry` = 31645;
-- OLD name : Wrath Gate Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=31683
UPDATE `creature_template_locale` SET `Name` = '[Wrath Gate Dummy]' WHERE `locale` = 'deDE' AND `entry` = 31683;
-- OLD name : Bronze Drake
-- Source : https://www.wowhead.com/wotlk/de/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'deDE','[Bronze Drake]',NULL);
-- OLD name : Zwielichtdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtreitdrache' WHERE `locale` = 'deDE' AND `entry` = 31698;
-- OLD name : Schwarzer Reiteisbär
-- Source : https://www.wowhead.com/wotlk/de/npc=31699
UPDATE `creature_template_locale` SET `Name` = '[Black Polar Bear Mount]' WHERE `locale` = 'deDE' AND `entry` = 31699;
-- OLD name : Brauner Reiteisbär
-- Source : https://www.wowhead.com/wotlk/de/npc=31700
UPDATE `creature_template_locale` SET `Name` = '[Brown Polar Bear Mount]' WHERE `locale` = 'deDE' AND `entry` = 31700;
-- OLD name : Schwares Reitmammut
-- Source : https://www.wowhead.com/wotlk/de/npc=31703
UPDATE `creature_template_locale` SET `Name` = '[Black Mammoth Mount]' WHERE `locale` = 'deDE' AND `entry` = 31703;
-- OLD name : Purpurne kosmetische Schlange
-- Source : https://www.wowhead.com/wotlk/de/npc=31712
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Crimson Snake]' WHERE `locale` = 'deDE' AND `entry` = 31712;
-- OLD name : Grüne kosmetische Wasserschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=31713
UPDATE `creature_template_locale` SET `Name` = '[Cosmetic Green Water Snake]' WHERE `locale` = 'deDE' AND `entry` = 31713;
-- OLD name : Grunzerin Grikee
-- Source : https://www.wowhead.com/wotlk/de/npc=31727
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Grikee' WHERE `locale` = 'deDE' AND `entry` = 31727;
-- OLD name : Icy Ghoul KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31743
UPDATE `creature_template_locale` SET `Name` = '[Icy Ghoul KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31743;
-- OLD name : Kosmetische Plünderpiñata, subname : Verhaut mich!
-- Source : https://www.wowhead.com/wotlk/de/npc=31744
UPDATE `creature_template_locale` SET `Name` = '[Cooking Loot Pinata]',`Title` = '[Hit Me!]' WHERE `locale` = 'deDE' AND `entry` = 31744;
-- OLD name : Icecrown Bomber - Bindsight Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31745
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber - Bindsight Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31745;
-- OLD name : King of the Mountain Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=31766
UPDATE `creature_template_locale` SET `Name` = '[King of the Mountain Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 31766;
-- OLD name : Plague Cauldron KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31767
UPDATE `creature_template_locale` SET `Name` = '[Plague Cauldron KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31767;
-- OLD name : Cloak Dome Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31777
UPDATE `creature_template_locale` SET `Name` = '[Cloak Dome Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31777;
-- OLD name : Im Stall abgestelltes Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=31799
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'deDE' AND `entry` = 31799;
-- OLD name : Im Stall abgestelltes Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=31800
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'deDE' AND `entry` = 31800;
-- OLD name : Treantverbündeter
-- Source : https://www.wowhead.com/wotlk/de/npc=31802
UPDATE `creature_template_locale` SET `Name` = '[Treant Ally]' WHERE `locale` = 'deDE' AND `entry` = 31802;
-- OLD name : Im Stall abgestelltes Reittier
-- Source : https://www.wowhead.com/wotlk/de/npc=31803
UPDATE `creature_template_locale` SET `Name` = '[Stabled Mount]' WHERE `locale` = 'deDE' AND `entry` = 31803;
-- OLD name : Schneller Hengst von Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=31809
UPDATE `creature_template_locale` SET `Name` = '[Swift Dalaran Steed]' WHERE `locale` = 'deDE' AND `entry` = 31809;
-- OLD name : Branns Flugmaschine
-- Source : https://www.wowhead.com/wotlk/de/npc=31827
UPDATE `creature_template_locale` SET `Name` = '[Brann''s Flying Machine]' WHERE `locale` = 'deDE' AND `entry` = 31827;
-- OLD name : Slaves to Saronite Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=31866
UPDATE `creature_template_locale` SET `Name` = '[Slaves to Saronite Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 31866;
-- OLD name : Schrottreifer Verwüster
-- Source : https://www.wowhead.com/wotlk/de/npc=31868
UPDATE `creature_template_locale` SET `Name` = 'Defekter Verwüster' WHERE `locale` = 'deDE' AND `entry` = 31868;
-- OLD name : Blitzwespe
-- Source : https://www.wowhead.com/wotlk/de/npc=31871
UPDATE `creature_template_locale` SET `Name` = '[Lighting Wasp (Underbelly Elixer Shapeshift)]' WHERE `locale` = 'deDE' AND `entry` = 31871;
-- OLD name : Indalamars Verkäufer für Splitter eines Steinbewahrers, subname : Tolles Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=31872
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Stone Keeper''s Shard Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 31872;
-- OLD name : Menschenmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=31879
UPDATE `creature_template_locale` SET `Name` = '[Human Mage (Underbelly Elixir Mirror Effect)]' WHERE `locale` = 'deDE' AND `entry` = 31879;
-- OLD name : Unsichtbarer Pirscher
-- Source : https://www.wowhead.com/wotlk/de/npc=31913
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Dispersion)]' WHERE `locale` = 'deDE' AND `entry` = 31913;
-- OLD name : Zollinger, Meister der Lehren
-- Source : https://www.wowhead.com/wotlk/de/npc=32150
UPDATE `creature_template_locale` SET `Name` = '[Loremaster Zollinger]' WHERE `locale` = 'deDE' AND `entry` = 32150;
-- OLD name : Zwielichtreitdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=32165
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake Mount (Red)]' WHERE `locale` = 'deDE' AND `entry` = 32165;
-- OLD name : Zwielichtreitdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=32166
UPDATE `creature_template_locale` SET `Name` = '[Twilight Drake Mount (Purple)]' WHERE `locale` = 'deDE' AND `entry` = 32166;
-- OLD name : Risen Skeleton KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32167
UPDATE `creature_template_locale` SET `Name` = '[Risen Skeleton KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32167;
-- OLD name : Vicious Geist KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32168
UPDATE `creature_template_locale` SET `Name` = '[Vicious Geist KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32168;
-- OLD name : Unkillable Test Dummy 80 Warrior
-- Source : https://www.wowhead.com/wotlk/de/npc=32171
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 Warrior]' WHERE `locale` = 'deDE' AND `entry` = 32171;
-- OLD name : Eiskronennekropole
-- Source : https://www.wowhead.com/wotlk/de/npc=32173
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Necropolis]' WHERE `locale` = 'deDE' AND `entry` = 32173;
-- OLD name : Teufelsfledermaus von Heb'Drakkar
-- Source : https://www.wowhead.com/wotlk/de/npc=32194
UPDATE `creature_template_locale` SET `Name` = '[Heb''Drakkar Felbat]' WHERE `locale` = 'deDE' AND `entry` = 32194;
-- OLD name : South Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32195
UPDATE `creature_template_locale` SET `Name` = '[South Gate KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32195;
-- OLD name : Central Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32196
UPDATE `creature_template_locale` SET `Name` = '[Central Gate KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32196;
-- OLD name : North Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32197
UPDATE `creature_template_locale` SET `Name` = '[North Gate KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32197;
-- OLD name : Geliehene Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=32198
UPDATE `creature_template_locale` SET `Name` = '[Loaned Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 32198;
-- OLD name : Northwest Gate KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32199
UPDATE `creature_template_locale` SET `Name` = '[Northwest Gate KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32199;
-- OLD name : Gemieteter Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=32208
UPDATE `creature_template_locale` SET `Name` = '[Loaned Wind Rider]' WHERE `locale` = 'deDE' AND `entry` = 32208;
-- OLD name : Großes Karawanenmammut
-- Source : https://www.wowhead.com/wotlk/de/npc=32212
UPDATE `creature_template_locale` SET `Name` = '[Grand Caravan Mammoth]' WHERE `locale` = 'deDE' AND `entry` = 32212;
-- OLD name : Großes Karawanenmammut
-- Source : https://www.wowhead.com/wotlk/de/npc=32213
UPDATE `creature_template_locale` SET `Name` = '[Grand Caravan Mammoth]' WHERE `locale` = 'deDE' AND `entry` = 32213;
-- OLD name : Drag Drop KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32229
UPDATE `creature_template_locale` SET `Name` = '[Drag Drop KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32229;
-- OLD name : Leerenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=32230
UPDATE `creature_template_locale` SET `Name` = 'Herr der Leere' WHERE `locale` = 'deDE' AND `entry` = 32230;
-- OLD name : Verkleideter Kreuzfahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32241
UPDATE `creature_template_locale` SET `Name` = 'Verkleideter Kreuzzügler' WHERE `locale` = 'deDE' AND `entry` = 32241;
-- OLD name : Heckenschützenkanone
-- Source : https://www.wowhead.com/wotlk/de/npc=32254
UPDATE `creature_template_locale` SET `Name` = '[Sniper Rifle]' WHERE `locale` = 'deDE' AND `entry` = 32254;
-- OLD name : Writhing Mass KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32266
UPDATE `creature_template_locale` SET `Name` = '[Writhing Mass KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32266;
-- OLD name : Unruhiges Fragment
-- Source : https://www.wowhead.com/wotlk/de/npc=32283
UPDATE `creature_template_locale` SET `Name` = '[Unquiet Remnant]' WHERE `locale` = 'deDE' AND `entry` = 32283;
-- OLD name : Befreites Fragment
-- Source : https://www.wowhead.com/wotlk/de/npc=32288
UPDATE `creature_template_locale` SET `Name` = '[Freed Remnant]' WHERE `locale` = 'deDE' AND `entry` = 32288;
-- OLD name : Wachposten der Aldur'thar
-- Source : https://www.wowhead.com/wotlk/de/npc=32292
UPDATE `creature_template_locale` SET `Name` = 'Späher von Aldur''thar' WHERE `locale` = 'deDE' AND `entry` = 32292;
-- OLD name : Transformation des dunklen Unterwerfers, subname : Kult der Verdammten
-- Source : https://www.wowhead.com/wotlk/de/npc=32293
UPDATE `creature_template_locale` SET `Name` = '[Dark Subjugator Transform]',`Title` = '[Cult of the Damned]' WHERE `locale` = 'deDE' AND `entry` = 32293;
-- OLD name : Testtotem
-- Source : https://www.wowhead.com/wotlk/de/npc=32304
UPDATE `creature_template_locale` SET `Name` = '[Test Totem]' WHERE `locale` = 'deDE' AND `entry` = 32304;
-- OLD name : Dark Messenger KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32314
UPDATE `creature_template_locale` SET `Name` = '[Dark Messenger KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32314;
-- OLD name : Raketenturm TF-Xplosiv
-- Source : https://www.wowhead.com/wotlk/de/npc=32350
UPDATE `creature_template_locale` SET `Name` = '[TF-Xplosive Rocket Turret]' WHERE `locale` = 'deDE' AND `entry` = 32350;
-- OLD name : Zokk "Lulatsch" Drillzang
-- Source : https://www.wowhead.com/wotlk/de/npc=32355
UPDATE `creature_template_locale` SET `Name` = 'Bigzokk Drillzang' WHERE `locale` = 'deDE' AND `entry` = 32355;
-- OLD name : Kezzik der Meuchler
-- Source : https://www.wowhead.com/wotlk/de/npc=32356
UPDATE `creature_template_locale` SET `Name` = 'Kezzik der Stürmer' WHERE `locale` = 'deDE' AND `entry` = 32356;
-- OLD subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=32379
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 32379;
-- OLD subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=32380
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterveteran für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 32380;
-- OLD subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=32382
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 32382;
-- OLD name : Unteroffizier Kien, subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=32384
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Kien]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 32384;
-- OLD subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=32385
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterveteran für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 32385;
-- OLD name : Kezzik der Meuchler
-- Source : https://www.wowhead.com/wotlk/de/npc=32405
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]' WHERE `locale` = 'deDE' AND `entry` = 32405;
-- OLD name : Argex Eisenmagen
-- Source : https://www.wowhead.com/wotlk/de/npc=32407
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]' WHERE `locale` = 'deDE' AND `entry` = 32407;
-- OLD name : Wahnsinniger Überlebender von Indu'le
-- Source : https://www.wowhead.com/wotlk/de/npc=32409
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Überlebender von Indu''le' WHERE `locale` = 'deDE' AND `entry` = 32409;
-- OLD name : Isirami Sanftwind
-- Source : https://www.wowhead.com/wotlk/de/npc=32413
UPDATE `creature_template_locale` SET `Name` = 'Isimari Sanftwind' WHERE `locale` = 'deDE' AND `entry` = 32413;
-- OLD subname : Schankkellnerin
-- Source : https://www.wowhead.com/wotlk/de/npc=32415
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 32415;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=32416
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 32416;
-- OLD name : Scharlachrote Hochfürstin Daion
-- Source : https://www.wowhead.com/wotlk/de/npc=32417
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Hochlord Daion' WHERE `locale` = 'deDE' AND `entry` = 32417;
-- OLD name : Iragos
-- Source : https://www.wowhead.com/wotlk/de/npc=32432
UPDATE `creature_template_locale` SET `Name` = '[Iragos]' WHERE `locale` = 'deDE' AND `entry` = 32432;
-- OLD name : Selagosa
-- Source : https://www.wowhead.com/wotlk/de/npc=32433
UPDATE `creature_template_locale` SET `Name` = '[Selagosa]' WHERE `locale` = 'deDE' AND `entry` = 32433;
-- OLD name : Anygos
-- Source : https://www.wowhead.com/wotlk/de/npc=32434
UPDATE `creature_template_locale` SET `Name` = '[Anygos]' WHERE `locale` = 'deDE' AND `entry` = 32434;
-- OLD name : Theragos
-- Source : https://www.wowhead.com/wotlk/de/npc=32436
UPDATE `creature_template_locale` SET `Name` = '[Theragos]' WHERE `locale` = 'deDE' AND `entry` = 32436;
-- OLD name : Myragosa
-- Source : https://www.wowhead.com/wotlk/de/npc=32437
UPDATE `creature_template_locale` SET `Name` = '[Myragosa]' WHERE `locale` = 'deDE' AND `entry` = 32437;
-- OLD name : Zyndragosa
-- Source : https://www.wowhead.com/wotlk/de/npc=32439
UPDATE `creature_template_locale` SET `Name` = '[Zyndragosa]' WHERE `locale` = 'deDE' AND `entry` = 32439;
-- OLD name : Corthegos
-- Source : https://www.wowhead.com/wotlk/de/npc=32440
UPDATE `creature_template_locale` SET `Name` = '[Corthegos]' WHERE `locale` = 'deDE' AND `entry` = 32440;
-- OLD name : Geborgter Besen
-- Source : https://www.wowhead.com/wotlk/de/npc=32449
UPDATE `creature_template_locale` SET `Name` = '[Borrowed Broom]' WHERE `locale` = 'deDE' AND `entry` = 32449;
-- OLD name : Fahrzeug des Tals der Verlorenen Hoffnung
-- Source : https://www.wowhead.com/wotlk/de/npc=32452
UPDATE `creature_template_locale` SET `Name` = '[Valley of Lost Hope Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 32452;
-- OLD name : Einwohner von Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=32453
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Citizen]' WHERE `locale` = 'deDE' AND `entry` = 32453;
-- OLD name : Einwohner von Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=32454
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Citizen]' WHERE `locale` = 'deDE' AND `entry` = 32454;
-- OLD name : Seuchenbringer der Geißel
-- Source : https://www.wowhead.com/wotlk/de/npc=32473
UPDATE `creature_template_locale` SET `Name` = '[Scourge Blightbringer]' WHERE `locale` = 'deDE' AND `entry` = 32473;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns' WHERE `locale` = 'deDE' AND `entry` = 32474;
-- OLD name : Nerubischer Unterkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=32480
UPDATE `creature_template_locale` SET `Name` = '[Nerubian Underking]' WHERE `locale` = 'deDE' AND `entry` = 32480;
-- OLD name : Vollgesogener Seuchenwurm
-- Source : https://www.wowhead.com/wotlk/de/npc=32483
UPDATE `creature_template_locale` SET `Name` = 'Verstopfter Seuchenwurm' WHERE `locale` = 'deDE' AND `entry` = 32483;
-- OLD name : Verwundeter Bürger von Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=32493
UPDATE `creature_template_locale` SET `Name` = '[Wounded Dalaran]' WHERE `locale` = 'deDE' AND `entry` = 32493;
-- OLD name : Kind aus Dalaran
-- Source : https://www.wowhead.com/wotlk/de/npc=32494
UPDATE `creature_template_locale` SET `Name` = '[Dalaran Child]' WHERE `locale` = 'deDE' AND `entry` = 32494;
-- OLD name : Torkelnder Zombie
-- Source : https://www.wowhead.com/wotlk/de/npc=32499
UPDATE `creature_template_locale` SET `Name` = '[Shambling Zombie]' WHERE `locale` = 'deDE' AND `entry` = 32499;
-- OLD name : Akolyth der Kultisten
-- Source : https://www.wowhead.com/wotlk/de/npc=32507
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Kultisten' WHERE `locale` = 'deDE' AND `entry` = 32507;
-- OLD name : Davids Testkreatur 1235
-- Source : https://www.wowhead.com/wotlk/de/npc=32508
UPDATE `creature_template_locale` SET `Name` = '[David Test Creature 1235]' WHERE `locale` = 'deDE' AND `entry` = 32508;
-- OLD name : Fehlgeschlagenes Experiment
-- Source : https://www.wowhead.com/wotlk/de/npc=32519
UPDATE `creature_template_locale` SET `Name` = 'Gescheitertes Experiment' WHERE `locale` = 'deDE' AND `entry` = 32519;
-- OLD name : Trainingsattrappe des Initianden
-- Source : https://www.wowhead.com/wotlk/de/npc=32541
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Initianden' WHERE `locale` = 'deDE' AND `entry` = 32541;
-- OLD name : Trainingsattrappe des Jüngers
-- Source : https://www.wowhead.com/wotlk/de/npc=32542
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Jüngers' WHERE `locale` = 'deDE' AND `entry` = 32542;
-- OLD name : Trainingsattrappe des Veteranen
-- Source : https://www.wowhead.com/wotlk/de/npc=32543
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Veteranen' WHERE `locale` = 'deDE' AND `entry` = 32543;
-- OLD name : Trainingsattrappe des Initianden
-- Source : https://www.wowhead.com/wotlk/de/npc=32545
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Initianden' WHERE `locale` = 'deDE' AND `entry` = 32545;
-- OLD name : Trainingsattrappe des Schwarzritters
-- Source : https://www.wowhead.com/wotlk/de/npc=32546
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Schwarzritters' WHERE `locale` = 'deDE' AND `entry` = 32546;
-- OLD name : Nemesislehrer des Hochlords
-- Source : https://www.wowhead.com/wotlk/de/npc=32547
UPDATE `creature_template_locale` SET `Name` = 'Nemesisattrappe des Hochlords' WHERE `locale` = 'deDE' AND `entry` = 32547;
-- OLD name : QA Test Dummy 80 Undead, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32556
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Undead]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32556;
-- OLD name : QA Test Dummy 80 Beast, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32557
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Beast]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32557;
-- OLD name : QA Test Dummy 80 Dragonkin, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32558
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Dragonkin]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32558;
-- OLD name : QA Test Dummy 80 Demon, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32559
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Demon]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32559;
-- OLD name : QA Test Dummy 80 Giant, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32560
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Giant]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32560;
-- OLD name : QA Test Dummy 80 Elemental, subname : Sandsack der QA
-- Source : https://www.wowhead.com/wotlk/de/npc=32561
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 80 Elemental]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32561;
-- OLD name : Roter Reitdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=32563
UPDATE `creature_template_locale` SET `Name` = '[Red Drake Mount]' WHERE `locale` = 'deDE' AND `entry` = 32563;
-- OLD name : Großartiger fliegender Teppich
-- Source : https://www.wowhead.com/wotlk/de/npc=32567
UPDATE `creature_template_locale` SET `Name` = '[Magnificent Flying Carpet]' WHERE `locale` = 'deDE' AND `entry` = 32567;
-- OLD name : Fliegende schwarze Qirajipanzerdrohne
-- Source : https://www.wowhead.com/wotlk/de/npc=32568
UPDATE `creature_template_locale` SET `Name` = '[Flying Black Qiraji Battle Tank]' WHERE `locale` = 'deDE' AND `entry` = 32568;
-- OLD name : Verwandelte schwarze Katze
-- Source : https://www.wowhead.com/wotlk/de/npc=32570
UPDATE `creature_template_locale` SET `Name` = '[Polymorphed Black Cat]' WHERE `locale` = 'deDE' AND `entry` = 32570;
-- OLD name : Testflugmaschine
-- Source : https://www.wowhead.com/wotlk/de/npc=32574
UPDATE `creature_template_locale` SET `Name` = '[Test Flying Machine]' WHERE `locale` = 'deDE' AND `entry` = 32574;
-- OLD name : Wolvarillusion
-- Source : https://www.wowhead.com/wotlk/de/npc=32584
UPDATE `creature_template_locale` SET `Name` = '[Wolvar Illusion]' WHERE `locale` = 'deDE' AND `entry` = 32584;
-- OLD name : Blauer Reitprotodrache
-- Source : https://www.wowhead.com/wotlk/de/npc=32585
UPDATE `creature_template_locale` SET `Name` = '[Riding Protodrake, Blue]' WHERE `locale` = 'deDE' AND `entry` = 32585;
-- OLD name : Bronzefarbener Protodrache
-- Source : https://www.wowhead.com/wotlk/de/npc=32586
UPDATE `creature_template_locale` SET `Name` = '[Riding Protodrake, Bronze]' WHERE `locale` = 'deDE' AND `entry` = 32586;
-- OLD name : Hordentestpilot des Bombers von Eiskrone
-- Source : https://www.wowhead.com/wotlk/de/npc=32607
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Bomber Horde Test Pilot (DND)]' WHERE `locale` = 'deDE' AND `entry` = 32607;
-- OLD name : Kriegshetzer der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=32615
UPDATE `creature_template_locale` SET `Name` = '[Horde Warbringer]' WHERE `locale` = 'deDE' AND `entry` = 32615;
-- OLD name : Brigadegeneral der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=32626
UPDATE `creature_template_locale` SET `Name` = '[Alliance Brigadier General]' WHERE `locale` = 'deDE' AND `entry` = 32626;
-- OLD name : Stubengast
-- Source : https://www.wowhead.com/wotlk/de/npc=32632
UPDATE `creature_template_locale` SET `Name` = '[Parlor Patron]' WHERE `locale` = 'deDE' AND `entry` = 32632;
-- OLD name : Schneller Mondgespinstteppich
-- Source : https://www.wowhead.com/wotlk/de/npc=32634
UPDATE `creature_template_locale` SET `Name` = '[Swift Mooncloth Carpet]' WHERE `locale` = 'deDE' AND `entry` = 32634;
-- OLD name : Schneller Schwarztuchteppich
-- Source : https://www.wowhead.com/wotlk/de/npc=32635
UPDATE `creature_template_locale` SET `Name` = '[Swift Shadoweave Carpet]' WHERE `locale` = 'deDE' AND `entry` = 32635;
-- OLD name : Schneller Zaubertuchteppich
-- Source : https://www.wowhead.com/wotlk/de/npc=32636
UPDATE `creature_template_locale` SET `Name` = '[Swift Spellfire Carpet]' WHERE `locale` = 'deDE' AND `entry` = 32636;
-- OLD name : Fliegender Teppich
-- Source : https://www.wowhead.com/wotlk/de/npc=32637
UPDATE `creature_template_locale` SET `Name` = '[Flying Carpet]' WHERE `locale` = 'deDE' AND `entry` = 32637;
-- OLD subname : Handelsreisender
-- Source : https://www.wowhead.com/wotlk/de/npc=32638
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender' WHERE `locale` = 'deDE' AND `entry` = 32638;
-- OLD subname : Handelsreisende
-- Source : https://www.wowhead.com/wotlk/de/npc=32642
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender' WHERE `locale` = 'deDE' AND `entry` = 32642;
-- OLD name : Trainingsattrappe der Kriegshymnenfeste
-- Source : https://www.wowhead.com/wotlk/de/npc=32647
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe der Kriegshymnenfeste' WHERE `locale` = 'deDE' AND `entry` = 32647;
-- OLD name : Tirion's Gambit Event Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=32648
UPDATE `creature_template_locale` SET `Name` = '[Tirion''s Gambit Event Credit]' WHERE `locale` = 'deDE' AND `entry` = 32648;
-- OLD name : Gorky, subname : Fliegender Händler
-- Source : https://www.wowhead.com/wotlk/de/npc=32649
UPDATE `creature_template_locale` SET `Name` = '[Gorky]',`Title` = '[Traveling Salesman]' WHERE `locale` = 'deDE' AND `entry` = 32649;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Experten' WHERE `locale` = 'deDE' AND `entry` = 32666;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Meisters' WHERE `locale` = 'deDE' AND `entry` = 32667;
-- OLD name : Garl Grimmsilber
-- Source : https://www.wowhead.com/wotlk/de/npc=32710
UPDATE `creature_template_locale` SET `Name` = 'Garl Grimgrizzel' WHERE `locale` = 'deDE' AND `entry` = 32710;
-- OLD name : Erzmagierin Rheaume
-- Source : https://www.wowhead.com/wotlk/de/npc=32740
UPDATE `creature_template_locale` SET `Name` = 'Erzmagier Rheaume' WHERE `locale` = 'deDE' AND `entry` = 32740;
-- OLD subname : Todesritterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32753
UPDATE `creature_template_locale` SET `Title` = 'Todesritterausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32753;
-- OLD subname : Druidenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32754
UPDATE `creature_template_locale` SET `Title` = 'Druidenausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32754;
-- OLD subname : Jägerglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32755
UPDATE `creature_template_locale` SET `Title` = 'Jägerausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32755;
-- OLD subname : Magierglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32756
UPDATE `creature_template_locale` SET `Title` = 'Magierausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32756;
-- OLD subname : Paladinglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32757
UPDATE `creature_template_locale` SET `Title` = 'Paladinausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32757;
-- OLD subname : Priesterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32758
UPDATE `creature_template_locale` SET `Title` = 'Priesterausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32758;
-- OLD subname : Schurkenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32759
UPDATE `creature_template_locale` SET `Title` = 'Schurkenausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32759;
-- OLD subname : Schamanenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32760
UPDATE `creature_template_locale` SET `Title` = 'Schamanenausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32760;
-- OLD subname : Hexenmeisterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32761
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeisterausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32761;
-- OLD subname : Kriegerglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32762
UPDATE `creature_template_locale` SET `Title` = 'Kriegerausrüstung' WHERE `locale` = 'deDE' AND `entry` = 32762;
-- OLD name : Totem der Feuernova IX
-- Source : https://www.wowhead.com/wotlk/de/npc=32775
UPDATE `creature_template_locale` SET `Name` = '[Fire Nova Totem IX]' WHERE `locale` = 'deDE' AND `entry` = 32775;
-- OLD name : Totem der Feuernova VIII
-- Source : https://www.wowhead.com/wotlk/de/npc=32776
UPDATE `creature_template_locale` SET `Name` = '[Fire Nova Totem VIII]' WHERE `locale` = 'deDE' AND `entry` = 32776;
-- OLD name : Gemeiner Dieb
-- Source : https://www.wowhead.com/wotlk/de/npc=32779
UPDATE `creature_template_locale` SET `Name` = '[Ignoble Thief]' WHERE `locale` = 'deDE' AND `entry` = 32779;
-- OLD name : Nobelgartenhase
-- Source : https://www.wowhead.com/wotlk/de/npc=32781
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Rabbit]' WHERE `locale` = 'deDE' AND `entry` = 32781;
-- OLD name : Nobelgartenhase
-- Source : https://www.wowhead.com/wotlk/de/npc=32782
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny Waypoint]' WHERE `locale` = 'deDE' AND `entry` = 32782;
-- OLD name : Nobelgartenhase
-- Source : https://www.wowhead.com/wotlk/de/npc=32784
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny Controller]' WHERE `locale` = 'deDE' AND `entry` = 32784;
-- OLD name : Verwandelter Hase
-- Source : https://www.wowhead.com/wotlk/de/npc=32789
UPDATE `creature_template_locale` SET `Name` = '[Polymorphed Rabbit]' WHERE `locale` = 'deDE' AND `entry` = 32789;
-- OLD name : Indalamars 83 Testdummy, subname : QA Punching Bag
-- Source : https://www.wowhead.com/wotlk/de/npc=32794
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s 83 Test Dummy]',`Title` = '[QA Punching Bag]' WHERE `locale` = 'deDE' AND `entry` = 32794;
-- OLD name : Illidan Sturmgrimm Kill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=32797
UPDATE `creature_template_locale` SET `Name` = '[Illidan Stormrage Kill Credit]' WHERE `locale` = 'deDE' AND `entry` = 32797;
-- OLD name : Frühlingsernter
-- Source : https://www.wowhead.com/wotlk/de/npc=32798
UPDATE `creature_template_locale` SET `Name` = '[Spring Gatherer]' WHERE `locale` = 'deDE' AND `entry` = 32798;
-- OLD name : Frühlingssammler
-- Source : https://www.wowhead.com/wotlk/de/npc=32799
UPDATE `creature_template_locale` SET `Name` = '[Spring Collector]' WHERE `locale` = 'deDE' AND `entry` = 32799;
-- OLD name : Flammenwächter der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32801
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der boreanischen Tundra' WHERE `locale` = 'deDE' AND `entry` = 32801;
-- OLD name : Flammenwächter des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32804
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter des heulenden Fjords' WHERE `locale` = 'deDE' AND `entry` = 32804;
-- OLD name : Flammenbewahrer der Boreanischen Tundra
-- Source : https://www.wowhead.com/wotlk/de/npc=32809
UPDATE `creature_template_locale` SET `Name` = '[Borean Tundra Flame Keeper]' WHERE `locale` = 'deDE' AND `entry` = 32809;
-- OLD name : Flammenbewahrer des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32812
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des heulenden Fjords' WHERE `locale` = 'deDE' AND `entry` = 32812;
-- OLD name : Fetter Truthahn
-- Source : https://www.wowhead.com/wotlk/de/npc=32818
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn' WHERE `locale` = 'deDE' AND `entry` = 32818;
-- OLD name : Plump Turkey Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32819
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn' WHERE `locale` = 'deDE' AND `entry` = 32819;
-- OLD name : Revenge for the Vargul Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32821
UPDATE `creature_template_locale` SET `Name` = '[Revenge for the Vargul Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32821;
-- OLD name : Großer Truthahn
-- Source : https://www.wowhead.com/wotlk/de/npc=32822
UPDATE `creature_template_locale` SET `Name` = '[Large Turkey (Polymorph)]' WHERE `locale` = 'deDE' AND `entry` = 32822;
-- OLD name : Rustikaler Hocker
-- Source : https://www.wowhead.com/wotlk/de/npc=32826
UPDATE `creature_template_locale` SET `Name` = '[Sturdy Seat]' WHERE `locale` = 'deDE' AND `entry` = 32826;
-- OLD name : Stuhlhalter
-- Source : https://www.wowhead.com/wotlk/de/npc=32828
UPDATE `creature_template_locale` SET `Name` = '[Chair Holder]' WHERE `locale` = 'deDE' AND `entry` = 32828;
-- OLD name : Späher Zar'shi
-- Source : https://www.wowhead.com/wotlk/de/npc=32833
UPDATE `creature_template_locale` SET `Name` = '[Scout Zar''shi]' WHERE `locale` = 'deDE' AND `entry` = 32833;
-- OLD name : Korporal Mondstreich
-- Source : https://www.wowhead.com/wotlk/de/npc=32835
UPDATE `creature_template_locale` SET `Name` = '[Corporal Moonstrike]' WHERE `locale` = 'deDE' AND `entry` = 32835;
-- OLD name : Unkillable Test Dummy 80 Warrior (Bonus Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=32847
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 Warrior (Bonus Armor)]' WHERE `locale` = 'deDE' AND `entry` = 32847;
-- OLD name : Untötbare Testdummy 80 S1 Resil-Priester, subname : Priester
-- Source : https://www.wowhead.com/wotlk/de/npc=32848
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 S1 Resil Priest]',`Title` = '[Priest]' WHERE `locale` = 'deDE' AND `entry` = 32848;
-- OLD name : Untötbare Testdummy 80 S1 Resil-Krieger, subname : Krieger
-- Source : https://www.wowhead.com/wotlk/de/npc=32849
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 80 S1 Resil Warrior]',`Title` = '[Warrior]' WHERE `locale` = 'deDE' AND `entry` = 32849;
-- OLD name : QA Test Dummy 83 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=32853
UPDATE `creature_template_locale` SET `Name` = '[QA Test Dummy 83 Raid Debuff (High Armor)]' WHERE `locale` = 'deDE' AND `entry` = 32853;
-- OLD name : Unkillable Test Dummy 83 Warrior (Bonus Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=32854
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Warrior (Bonus Armor)]' WHERE `locale` = 'deDE' AND `entry` = 32854;
-- OLD name : Ronakada, subname : Klingenmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=32870
UPDATE `creature_template_locale` SET `Name` = '[The Real Ronakada]',`Title` = '[Blademaster]' WHERE `locale` = 'deDE' AND `entry` = 32870;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32886
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 32886;
-- OLD name : Totem des glühenden Magmas TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=32887
UPDATE `creature_template_locale` SET `Name` = '[Magma Totem TEST]' WHERE `locale` = 'deDE' AND `entry` = 32887;
-- OLD name : Sarahs Schlachtfeldhaudrauf
-- Source : https://www.wowhead.com/wotlk/de/npc=32898
UPDATE `creature_template_locale` SET `Name` = '[Sarah''s Battleground Bruiser]' WHERE `locale` = 'deDE' AND `entry` = 32898;
-- OLD name : Tollwütiger Truthahn
-- Source : https://www.wowhead.com/wotlk/de/npc=32905
UPDATE `creature_template_locale` SET `Name` = '[Rabid Turkey]' WHERE `locale` = 'deDE' AND `entry` = 32905;
-- OLD name : Dans Testreittier
-- Source : https://www.wowhead.com/wotlk/de/npc=32931
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Mount]' WHERE `locale` = 'deDE' AND `entry` = 32931;
-- OLD name : Spektralreitgreif
-- Source : https://www.wowhead.com/wotlk/de/npc=32942
UPDATE `creature_template_locale` SET `Name` = '[Riding Spectral Gryphon (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 32942;
-- OLD name : Hungriger Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=32954
UPDATE `creature_template_locale` SET `Name` = '[Hungry Tuskarr]' WHERE `locale` = 'deDE' AND `entry` = 32954;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32957
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 32957;
-- OLD name : Treues Muli
-- Source : https://www.wowhead.com/wotlk/de/npc=32980
UPDATE `creature_template_locale` SET `Name` = '[Faithful Mule]' WHERE `locale` = 'deDE' AND `entry` = 32980;
-- OLD name : Reitgeißelgreif
-- Source : https://www.wowhead.com/wotlk/de/npc=32981
UPDATE `creature_template_locale` SET `Name` = '[Riding Scourge Gryphon (Taxi)]' WHERE `locale` = 'deDE' AND `entry` = 32981;
-- OLD name : Mietpackmuli
-- Source : https://www.wowhead.com/wotlk/de/npc=32983
UPDATE `creature_template_locale` SET `Name` = '[Rented Pack Mule]' WHERE `locale` = 'deDE' AND `entry` = 32983;
-- OLD name : Test der Stärke
-- Source : https://www.wowhead.com/wotlk/de/npc=32984
UPDATE `creature_template_locale` SET `Name` = '[Test of Strength Bunny]' WHERE `locale` = 'deDE' AND `entry` = 32984;
-- OLD name : Männchen oder Weibchen Frostleopard Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=33005
UPDATE `creature_template_locale` SET `Name` = '[Tails Up Frost Leopard Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 33005;
-- OLD name : Männchen oder Weibchen Eispfotenbär Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=33006
UPDATE `creature_template_locale` SET `Name` = '[Tails Up Icepaw Bear Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 33006;
-- OLD name : Justin Testfahrzeug A
-- Source : https://www.wowhead.com/wotlk/de/npc=33014
UPDATE `creature_template_locale` SET `Name` = '[Justin Test Vehicle A]' WHERE `locale` = 'deDE' AND `entry` = 33014;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=33016
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett' WHERE `locale` = 'deDE' AND `entry` = 33016;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=33017
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt' WHERE `locale` = 'deDE' AND `entry` = 33017;
-- OLD subname : Hochprozentiges
-- Source : https://www.wowhead.com/wotlk/de/npc=33026
UPDATE `creature_template_locale` SET `Title` = 'Alkohol' WHERE `locale` = 'deDE' AND `entry` = 33026;
-- OLD name : Glühwürmchen
-- Source : https://www.wowhead.com/wotlk/de/npc=33032
UPDATE `creature_template_locale` SET `Name` = '[Firefly (Purple)]' WHERE `locale` = 'deDE' AND `entry` = 33032;
-- OLD name : ELM General Purpose Bunny Large (scale x5)
-- Source : https://www.wowhead.com/wotlk/de/npc=33045
UPDATE `creature_template_locale` SET `Name` = '[ELM General Purpose Bunny Large (scale x5)]' WHERE `locale` = 'deDE' AND `entry` = 33045;
-- OLD name : Instabiler Sonnenstrahl
-- Source : https://www.wowhead.com/wotlk/de/npc=33050
UPDATE `creature_template_locale` SET `Name` = 'Unstabiler Sonnenstrahl' WHERE `locale` = 'deDE' AND `entry` = 33050;
-- OLD name : Schrottreifer Feuerstuhl
-- Source : https://www.wowhead.com/wotlk/de/npc=33061
UPDATE `creature_template_locale` SET `Name` = '[Wrecked Mechano-hog]' WHERE `locale` = 'deDE' AND `entry` = 33061;
-- OLD name : Frizzer
-- Source : https://www.wowhead.com/wotlk/de/npc=33064
UPDATE `creature_template_locale` SET `Name` = '[Frizzer]' WHERE `locale` = 'deDE' AND `entry` = 33064;
-- OLD name : Haudrauf von Dunkelmond
-- Source : https://www.wowhead.com/wotlk/de/npc=33069
UPDATE `creature_template_locale` SET `Name` = '[Darkmoon Bruiser]' WHERE `locale` = 'deDE' AND `entry` = 33069;
-- OLD name : Unkillable Test Dummy 87 Warrior Sessile
-- Source : https://www.wowhead.com/wotlk/de/npc=33073
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Warrior Sessile]' WHERE `locale` = 'deDE' AND `entry` = 33073;
-- OLD name : Belagerungsturm der Kriegshymnenschlucht
-- Source : https://www.wowhead.com/wotlk/de/npc=33080
UPDATE `creature_template_locale` SET `Name` = '[Warsong Siege Turret]' WHERE `locale` = 'deDE' AND `entry` = 33080;
-- OLD name : Panzerziel
-- Source : https://www.wowhead.com/wotlk/de/npc=33081
UPDATE `creature_template_locale` SET `Name` = '[Tonk Cannon Target]' WHERE `locale` = 'deDE' AND `entry` = 33081;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=33110
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 33110;
-- OLD name : Eisernes Konstrukt (Magma)
-- Source : https://www.wowhead.com/wotlk/de/npc=33122
UPDATE `creature_template_locale` SET `Name` = '[Iron Construct (Magma Visual)]' WHERE `locale` = 'deDE' AND `entry` = 33122;
-- OLD name : Puppenspieler
-- Source : https://www.wowhead.com/wotlk/de/npc=33128
UPDATE `creature_template_locale` SET `Name` = '[Puppeteer]' WHERE `locale` = 'deDE' AND `entry` = 33128;
-- OLD name : Gnompuppe
-- Source : https://www.wowhead.com/wotlk/de/npc=33129
UPDATE `creature_template_locale` SET `Name` = '[Gnome Puppet]' WHERE `locale` = 'deDE' AND `entry` = 33129;
-- OLD name : Puppenhand
-- Source : https://www.wowhead.com/wotlk/de/npc=33137
UPDATE `creature_template_locale` SET `Name` = '[Puppet Hand]' WHERE `locale` = 'deDE' AND `entry` = 33137;
-- OLD name : Verwüsterkontrollkonsole
-- Source : https://www.wowhead.com/wotlk/de/npc=33146
UPDATE `creature_template_locale` SET `Name` = '[Demolisher Engineering Console (Old)]' WHERE `locale` = 'deDE' AND `entry` = 33146;
-- OLD name : Granatenkiste
-- Source : https://www.wowhead.com/wotlk/de/npc=33185
UPDATE `creature_template_locale` SET `Name` = '[Grenade Crate]' WHERE `locale` = 'deDE' AND `entry` = 33185;
-- OLD name : Flüssiges Pyrit
-- Source : https://www.wowhead.com/wotlk/de/npc=33189
UPDATE `creature_template_locale` SET `Name` = 'Flüssiger Pyrit' WHERE `locale` = 'deDE' AND `entry` = 33189;
-- OLD name : Geißelmelder von Eiskrone
-- Source : https://www.wowhead.com/wotlk/de/npc=33192
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Scourge Proxy]' WHERE `locale` = 'deDE' AND `entry` = 33192;
-- OLD name : Schwarzer Knappe
-- Source : https://www.wowhead.com/wotlk/de/npc=33240
UPDATE `creature_template_locale` SET `Name` = '[Ebon Squire [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33240;
-- OLD name : Klingenschuppe-Spawner
-- Source : https://www.wowhead.com/wotlk/de/npc=33245
UPDATE `creature_template_locale` SET `Name` = 'Klingenschuppen Spawner' WHERE `locale` = 'deDE' AND `entry` = 33245;
-- OLD name : Krieger der Eisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=33246
UPDATE `creature_template_locale` SET `Name` = '[Iron Dwarf Warrior [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33246;
-- OLD name : Machtwort: Barriere
-- Source : https://www.wowhead.com/wotlk/de/npc=33248
UPDATE `creature_template_locale` SET `Name` = '[Power Word: Barrier]' WHERE `locale` = 'deDE' AND `entry` = 33248;
-- OLD name : Todesritterlehrer und Runenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=33251
UPDATE `creature_template_locale` SET `Name` = '[Death Knight Trainer and Runeforge]' WHERE `locale` = 'deDE' AND `entry` = 33251;
-- OLD name : Titansturmlord
-- Source : https://www.wowhead.com/wotlk/de/npc=33255
UPDATE `creature_template_locale` SET `Name` = '[Titanium Stormlord]' WHERE `locale` = 'deDE' AND `entry` = 33255;
-- OLD name : Jacqueline Aschebäscha, subname : Die süßeste aller Aschebäschas
-- Source : https://www.wowhead.com/wotlk/de/npc=33290
UPDATE `creature_template_locale` SET `Name` = '[Jillian McWeaksauce]',`Title` = '[The Cutest McWeaksauce]' WHERE `locale` = 'deDE' AND `entry` = 33290;
-- OLD name : Ross aus Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=33297
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Steed]' WHERE `locale` = 'deDE' AND `entry` = 33297;
-- OLD name : Roboschreiter aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=33301
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechanostrider]' WHERE `locale` = 'deDE' AND `entry` = 33301;
-- OLD name : Gerome der Gnom
-- Source : https://www.wowhead.com/wotlk/de/npc=33314
UPDATE `creature_template_locale` SET `Name` = '[Gerome the Gnome]' WHERE `locale` = 'deDE' AND `entry` = 33314;
-- OLD name : Morgan Test
-- Source : https://www.wowhead.com/wotlk/de/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'deDE','[Morgan Test]',NULL);
-- OLD name : "Spektraltiger"
-- Source : https://www.wowhead.com/wotlk/de/npc=33357
UPDATE `creature_template_locale` SET `Name` = '["Spectral Tiger"]' WHERE `locale` = 'deDE' AND `entry` = 33357;
-- OLD name : Hammervehikel
-- Source : https://www.wowhead.com/wotlk/de/npc=33380
UPDATE `creature_template_locale` SET `Name` = '[Hammer Vehicle [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33380;
-- OLD name : Widder aus Eisenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=33408
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Ram]' WHERE `locale` = 'deDE' AND `entry` = 33408;
-- OLD name : Falkenschreiter von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=33418
UPDATE `creature_template_locale` SET `Name` = 'Falkenschreiter aus Silbermond' WHERE `locale` = 'deDE' AND `entry` = 33418;
-- OLD name : Hordenmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=33425
UPDATE `creature_template_locale` SET `Name` = '[Horde Engineer [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33425;
-- OLD name : Drachenführer der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=33426
UPDATE `creature_template_locale` SET `Name` = '[Horde Dragon Handler [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33426;
-- OLD name : Streiter von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=33461
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33461;
-- OLD name : Streiter von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=33464
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33464;
-- OLD name : Streiter von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=33466
UPDATE `creature_template_locale` SET `Name` = '[Silvermoon Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33466;
-- OLD name : Streiter von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=33470
UPDATE `creature_template_locale` SET `Name` = '[Undercity Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33470;
-- OLD name : Champion von Donnerfels
-- Source : https://www.wowhead.com/wotlk/de/npc=33471
UPDATE `creature_template_locale` SET `Name` = '[Thunder Bluff Champion]' WHERE `locale` = 'deDE' AND `entry` = 33471;
-- OLD name : Streiter von Donnerfels
-- Source : https://www.wowhead.com/wotlk/de/npc=33472
UPDATE `creature_template_locale` SET `Name` = '[Thunder Bluff Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33472;
-- OLD name : Streiter von Sen'jin
-- Source : https://www.wowhead.com/wotlk/de/npc=33475
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33475;
-- OLD name : Streiter von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=33478
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33478;
-- OLD name : Streiter von Eisenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=33482
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Aspirant]' WHERE `locale` = 'deDE' AND `entry` = 33482;
-- OLD name : Zähmbarer Kernhund
-- Source : https://www.wowhead.com/wotlk/de/npc=33502
UPDATE `creature_template_locale` SET `Name` = '[Tamable Core Hound]' WHERE `locale` = 'deDE' AND `entry` = 33502;
-- OLD name : Kommandant der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=33503
UPDATE `creature_template_locale` SET `Name` = '[Horde Commander [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33503;
-- OLD name : Zähmbare Schimäre
-- Source : https://www.wowhead.com/wotlk/de/npc=33504
UPDATE `creature_template_locale` SET `Name` = '[Tamable Chimaera]' WHERE `locale` = 'deDE' AND `entry` = 33504;
-- OLD name : Zähmbarer Teufelssaurier
-- Source : https://www.wowhead.com/wotlk/de/npc=33505
UPDATE `creature_template_locale` SET `Name` = '[Tamable Devilsaur]' WHERE `locale` = 'deDE' AND `entry` = 33505;
-- OLD name : Zähmbares Rhinozeros
-- Source : https://www.wowhead.com/wotlk/de/npc=33506
UPDATE `creature_template_locale` SET `Name` = '[Tamable Rhino]' WHERE `locale` = 'deDE' AND `entry` = 33506;
-- OLD name : Zähmbarer Silithid
-- Source : https://www.wowhead.com/wotlk/de/npc=33508
UPDATE `creature_template_locale` SET `Name` = '[Tamable Silithid]' WHERE `locale` = 'deDE' AND `entry` = 33508;
-- OLD name : Zähmbare Geisterbestie
-- Source : https://www.wowhead.com/wotlk/de/npc=33510
UPDATE `creature_template_locale` SET `Name` = '[Tamable Spirit Beast]' WHERE `locale` = 'deDE' AND `entry` = 33510;
-- OLD name : Zähmbarer Wurm
-- Source : https://www.wowhead.com/wotlk/de/npc=33511
UPDATE `creature_template_locale` SET `Name` = '[Tamable Worm]' WHERE `locale` = 'deDE' AND `entry` = 33511;
-- OLD name : Gepanzerter schwarzer Greif
-- Source : https://www.wowhead.com/wotlk/de/npc=33517
UPDATE `creature_template_locale` SET `Name` = '[Armored Ebon Gryphon]' WHERE `locale` = 'deDE' AND `entry` = 33517;
-- OLD name : Neugieriges Gorlocjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=33530
UPDATE `creature_template_locale` SET `Name` = 'Neugieriges Orakeljunges' WHERE `locale` = 'deDE' AND `entry` = 33530;
-- OLD name : Wolvarwaisenkind
-- Source : https://www.wowhead.com/wotlk/de/npc=33532
UPDATE `creature_template_locale` SET `Name` = '[Wolvar Orphan]' WHERE `locale` = 'deDE' AND `entry` = 33532;
-- OLD name : Orakelwaisenkind
-- Source : https://www.wowhead.com/wotlk/de/npc=33533
UPDATE `creature_template_locale` SET `Name` = '[Oracle Orphan]' WHERE `locale` = 'deDE' AND `entry` = 33533;
-- OLD name : Zuverlässiges Streitross aus Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=33551
UPDATE `creature_template_locale` SET `Name` = '[Trusty Stormwind Charger [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33551;
-- OLD name : Champion von Darnassus
-- Source : https://www.wowhead.com/wotlk/de/npc=33563
UPDATE `creature_template_locale` SET `Name` = '[Darnassus Champion]' WHERE `locale` = 'deDE' AND `entry` = 33563;
-- OLD name : Fisch
-- Source : https://www.wowhead.com/wotlk/de/npc=33568
UPDATE `creature_template_locale` SET `Name` = '[Fish]' WHERE `locale` = 'deDE' AND `entry` = 33568;
-- OLD name : Bernau Test Dummy
-- Source : https://www.wowhead.com/wotlk/de/npc=33570
UPDATE `creature_template_locale` SET `Name` = '[Bernau Test Dummy]' WHERE `locale` = 'deDE' AND `entry` = 33570;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 33580;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung' WHERE `locale` = 'deDE' AND `entry` = 33581;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst' WHERE `locale` = 'deDE' AND `entry` = 33583;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 33586;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 33587;
-- OLD name : Krista Hellfunk, subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33588
UPDATE `creature_template_locale` SET `Name` = 'Christa Hellfunk',`Title` = 'Großmeisterin der Alchemie' WHERE `locale` = 'deDE' AND `entry` = 33588;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Großmeister für Erste Hilfe' WHERE `locale` = 'deDE' AND `entry` = 33589;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens' WHERE `locale` = 'deDE' AND `entry` = 33590;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 33591;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=33602
UPDATE `creature_template_locale` SET `Title` = 'Juweliersbedarf' WHERE `locale` = 'deDE' AND `entry` = 33602;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde' WHERE `locale` = 'deDE' AND `entry` = 33603;
-- OLD name : Hochlord Tirion Fordring
-- Source : https://www.wowhead.com/wotlk/de/npc=33628
UPDATE `creature_template_locale` SET `Name` = '[Highlord Tirion Fordring]' WHERE `locale` = 'deDE' AND `entry` = 33628;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33630;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33631;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33633;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 33634;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33635;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33636;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33637
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33637;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33638;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33639;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33640;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33641;
-- OLD name : Flickwerk
-- Source : https://www.wowhead.com/wotlk/de/npc=33663
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR DPS Test)]' WHERE `locale` = 'deDE' AND `entry` = 33663;
-- OLD name : Ursula Aschebäscha, subname : Händlerin für "Über"hemden
-- Source : https://www.wowhead.com/wotlk/de/npc=33665
UPDATE `creature_template_locale` SET `Name` = '[Ursula McWeaksauce]',`Title` = '[Shirt of Uber Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33665;
-- OLD name : Flickwerk
-- Source : https://www.wowhead.com/wotlk/de/npc=33667
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR Tank Test)]' WHERE `locale` = 'deDE' AND `entry` = 33667;
-- OLD name : Kriecherreittier
-- Source : https://www.wowhead.com/wotlk/de/npc=33671
UPDATE `creature_template_locale` SET `Name` = '[Crawler Mount]' WHERE `locale` = 'deDE' AND `entry` = 33671;
-- OLD name : Pengoro, subname : Prinz der Pinguine
-- Source : https://www.wowhead.com/wotlk/de/npc=33673
UPDATE `creature_template_locale` SET `Name` = '[Pengoro]',`Title` = '[Prince of Penguins]' WHERE `locale` = 'deDE' AND `entry` = 33673;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33674;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33675;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33676;
-- OLD name : Technikerin Mihila, subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33677
UPDATE `creature_template_locale` SET `Name` = 'Techniker Mihila',`Title` = 'Meisteringenieurslehrer' WHERE `locale` = 'deDE' AND `entry` = 33677;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33678;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33679;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33680;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33681;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33682;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33683;
-- OLD name : Weberin Aoa, subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33684
UPDATE `creature_template_locale` SET `Name` = 'Weber Aoa',`Title` = 'Schneidermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 33684;
-- OLD name : James Barlo, subname : Meister des Angelns
-- Source : https://www.wowhead.com/wotlk/de/npc=33685
UPDATE `creature_template_locale` SET `Name` = '[James Barlo]',`Title` = '[Master of Fishing]' WHERE `locale` = 'deDE' AND `entry` = 33685;
-- OLD name : Argent Champion Credit (Valiant Test), subname : A.L.K.
-- Source : https://www.wowhead.com/wotlk/de/npc=33708
UPDATE `creature_template_locale` SET `Name` = '[Argent Champion Credit (Valiant Test)]',`Title` = '[S.T.O.U.T.]' WHERE `locale` = 'deDE' AND `entry` = 33708;
-- OLD name : Bronzekonsort
-- Source : https://www.wowhead.com/wotlk/de/npc=33718
UPDATE `creature_template_locale` SET `Name` = '[Bronze Consort]' WHERE `locale` = 'deDE' AND `entry` = 33718;
-- OLD name : Entweihter Boden II
-- Source : https://www.wowhead.com/wotlk/de/npc=33751
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground II]' WHERE `locale` = 'deDE' AND `entry` = 33751;
-- OLD name : Entweihter Boden III
-- Source : https://www.wowhead.com/wotlk/de/npc=33752
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground III]' WHERE `locale` = 'deDE' AND `entry` = 33752;
-- OLD name : Entweihter Boden IV
-- Source : https://www.wowhead.com/wotlk/de/npc=33753
UPDATE `creature_template_locale` SET `Name` = '[Desecrated Ground IV]' WHERE `locale` = 'deDE' AND `entry` = 33753;
-- OLD name : Abbild des Ältesten Hellblatt
-- Source : https://www.wowhead.com/wotlk/de/npc=33761
UPDATE `creature_template_locale` SET `Name` = '[Elder Brightleaf Image]' WHERE `locale` = 'deDE' AND `entry` = 33761;
-- OLD name : OCL Testkreatur
-- Source : https://www.wowhead.com/wotlk/de/npc=33764
UPDATE `creature_template_locale` SET `Name` = '[OCL Test Creature]' WHERE `locale` = 'deDE' AND `entry` = 33764;
-- OLD name : Todesstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=33783
UPDATE `creature_template_locale` SET `Name` = '[Deathcharger]' WHERE `locale` = 'deDE' AND `entry` = 33783;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=33788
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 33788;
-- OLD name : Verteidiger der Horde
-- Source : https://www.wowhead.com/wotlk/de/npc=33805
UPDATE `creature_template_locale` SET `Name` = '[Horde Defender [PH]]' WHERE `locale` = 'deDE' AND `entry` = 33805;
-- OLD name : Rubble Stalker Kologarn
-- Source : https://www.wowhead.com/wotlk/de/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Geröllpirscher Kologarn' WHERE `locale` = 'deDE' AND `entry` = 33809;
-- OLD name : Streitross der Quel'dorei
-- Source : https://www.wowhead.com/wotlk/de/npc=33840
UPDATE `creature_template_locale` SET `Name` = 'Ross der Quel''dorei' WHERE `locale` = 'deDE' AND `entry` = 33840;
-- OLD name : Abbild des Ältesten Eisenast
-- Source : https://www.wowhead.com/wotlk/de/npc=33861
UPDATE `creature_template_locale` SET `Name` = '[Elder Ironbranch Image]' WHERE `locale` = 'deDE' AND `entry` = 33861;
-- OLD name : Abbild des Ältesten Steinrinde
-- Source : https://www.wowhead.com/wotlk/de/npc=33862
UPDATE `creature_template_locale` SET `Name` = '[Elder Stonebark Image]' WHERE `locale` = 'deDE' AND `entry` = 33862;
-- OLD name : Argentumschlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=33863
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 33863;
-- OLD name : Relga, subname : Erfrischungen
-- Source : https://www.wowhead.com/wotlk/de/npc=33867
UPDATE `creature_template_locale` SET `Name` = '[Relga]',`Title` = '[Refreshments]' WHERE `locale` = 'deDE' AND `entry` = 33867;
-- OLD name : Abbild von Freya
-- Source : https://www.wowhead.com/wotlk/de/npc=33876
UPDATE `creature_template_locale` SET `Name` = '[Freya Image]' WHERE `locale` = 'deDE' AND `entry` = 33876;
-- OLD name : Abbild von Sif
-- Source : https://www.wowhead.com/wotlk/de/npc=33877
UPDATE `creature_template_locale` SET `Name` = '[Sif Image]' WHERE `locale` = 'deDE' AND `entry` = 33877;
-- OLD name : Abbild von Thorim
-- Source : https://www.wowhead.com/wotlk/de/npc=33878
UPDATE `creature_template_locale` SET `Name` = '[Thorim Image]' WHERE `locale` = 'deDE' AND `entry` = 33878;
-- OLD name : Abbild von Hodir
-- Source : https://www.wowhead.com/wotlk/de/npc=33879
UPDATE `creature_template_locale` SET `Name` = '[Hodir Image]' WHERE `locale` = 'deDE' AND `entry` = 33879;
-- OLD name : Abbild von Mimiron
-- Source : https://www.wowhead.com/wotlk/de/npc=33880
UPDATE `creature_template_locale` SET `Name` = '[Mimiron Image]' WHERE `locale` = 'deDE' AND `entry` = 33880;
-- OLD name : Yogg-Saron (Nur Transformation)
-- Source : https://www.wowhead.com/wotlk/de/npc=33883
UPDATE `creature_template_locale` SET `Name` = '[Yogg-Saron (Transform Only)]' WHERE `locale` = 'deDE' AND `entry` = 33883;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33915
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33915;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=33916
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33916;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33917
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33917;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33918
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33918;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33919
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33919;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33920
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33920;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33921
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33921;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33922
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33922;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33923
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33923;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33924
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33924;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33925
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33925;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33926
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33926;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33927
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33927;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33928
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33928;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33929
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33929;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33930
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33930;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33931
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33931;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=33932
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33932;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=33933
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33933;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33934
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33934;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33935
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33935;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33936
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33936;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=33937
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33937;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33938
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33938;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33939
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33939;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=33940
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33940;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=33941
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 33941;
-- OLD name : Verkäufer von Indalamars Emblem der Eroberung, subname : Emporium des UNGLAUBLICHEN
-- Source : https://www.wowhead.com/wotlk/de/npc=33946
UPDATE `creature_template_locale` SET `Name` = '[Indalamar''s Emblem of Conquest Vendor]',`Title` = '[Emporium of AWESOME]' WHERE `locale` = 'deDE' AND `entry` = 33946;
-- OLD name : Gigantischer schwarzer Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=33949
UPDATE `creature_template_locale` SET `Name` = '[Giant Black Wolf]' WHERE `locale` = 'deDE' AND `entry` = 33949;
-- OLD name : Gigantischer weißer Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=33950
UPDATE `creature_template_locale` SET `Name` = '[Giant White Wolf]' WHERE `locale` = 'deDE' AND `entry` = 33950;
-- OLD name : Gigantischer grauer Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=33951
UPDATE `creature_template_locale` SET `Name` = '[Giant Grey Wolf]' WHERE `locale` = 'deDE' AND `entry` = 33951;
-- OLD name : Gigantischer roter Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=33952
UPDATE `creature_template_locale` SET `Name` = '[Giant Red Wolf]' WHERE `locale` = 'deDE' AND `entry` = 33952;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 33963;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 33964;
-- OLD subname : Meister des Sturmangriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=33972
UPDATE `creature_template_locale` SET `Title` = 'Meister des Anstürmens' WHERE `locale` = 'deDE' AND `entry` = 33972;
-- OLD name : Nobelgartenhase
-- Source : https://www.wowhead.com/wotlk/de/npc=33975
UPDATE `creature_template_locale` SET `Name` = '[Noblegarden Bunny]' WHERE `locale` = 'deDE' AND `entry` = 33975;
-- OLD name : Harry Reinwasser, subname : Angelmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33992
UPDATE `creature_template_locale` SET `Name` = '[Harry Clearwater]',`Title` = '[Fishmaster]' WHERE `locale` = 'deDE' AND `entry` = 33992;
-- OLD name : Zone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=34000
UPDATE `creature_template_locale` SET `Name` = '[Void Zone]' WHERE `locale` = 'deDE' AND `entry` = 34000;
-- OLD name : Zone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone' WHERE `locale` = 'deDE' AND `entry` = 34001;
-- OLD name : Algalon Test Creature
-- Source : https://www.wowhead.com/wotlk/de/npc=34002
UPDATE `creature_template_locale` SET `Name` = '[Algalon Test Creature]' WHERE `locale` = 'deDE' AND `entry` = 34002;
-- OLD name : Abbild des Knopfs
-- Source : https://www.wowhead.com/wotlk/de/npc=34011
UPDATE `creature_template_locale` SET `Name` = '[Button Image]' WHERE `locale` = 'deDE' AND `entry` = 34011;
-- OLD name : Schnelles graues Ross
-- Source : https://www.wowhead.com/wotlk/de/npc=34017
UPDATE `creature_template_locale` SET `Name` = '[Swift Gray Steed]' WHERE `locale` = 'deDE' AND `entry` = 34017;
-- OLD name : Zähmbarer Sporensegler
-- Source : https://www.wowhead.com/wotlk/de/npc=34018
UPDATE `creature_template_locale` SET `Name` = '[Tamable Sporebat]' WHERE `locale` = 'deDE' AND `entry` = 34018;
-- OLD name : Zähmbare Hyäne
-- Source : https://www.wowhead.com/wotlk/de/npc=34019
UPDATE `creature_template_locale` SET `Name` = '[Tamable Hyena]' WHERE `locale` = 'deDE' AND `entry` = 34019;
-- OLD name : Zähmbare Motte
-- Source : https://www.wowhead.com/wotlk/de/npc=34021
UPDATE `creature_template_locale` SET `Name` = '[Tamable Moth]' WHERE `locale` = 'deDE' AND `entry` = 34021;
-- OLD name : Zähmbarer Weitschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=34022
UPDATE `creature_template_locale` SET `Name` = '[Tamable Tallstrider]' WHERE `locale` = 'deDE' AND `entry` = 34022;
-- OLD name : Zähmbare Wespe
-- Source : https://www.wowhead.com/wotlk/de/npc=34024
UPDATE `creature_template_locale` SET `Name` = '[Tamable Wasp]' WHERE `locale` = 'deDE' AND `entry` = 34024;
-- OLD name : Zähmbarer Bär
-- Source : https://www.wowhead.com/wotlk/de/npc=34025
UPDATE `creature_template_locale` SET `Name` = '[Tamable Bear]' WHERE `locale` = 'deDE' AND `entry` = 34025;
-- OLD name : Zähmbarer Krebs
-- Source : https://www.wowhead.com/wotlk/de/npc=34026
UPDATE `creature_template_locale` SET `Name` = '[Tamable Crab]' WHERE `locale` = 'deDE' AND `entry` = 34026;
-- OLD name : Zähmbarer Krokilisk
-- Source : https://www.wowhead.com/wotlk/de/npc=34027
UPDATE `creature_template_locale` SET `Name` = '[Tamable Crocolisk]' WHERE `locale` = 'deDE' AND `entry` = 34027;
-- OLD name : Zähmbarer Gorilla
-- Source : https://www.wowhead.com/wotlk/de/npc=34028
UPDATE `creature_template_locale` SET `Name` = '[Tamable Gorilla]' WHERE `locale` = 'deDE' AND `entry` = 34028;
-- OLD name : Zähmbare Schildkröte
-- Source : https://www.wowhead.com/wotlk/de/npc=34029
UPDATE `creature_template_locale` SET `Name` = '[Tamable Turtle]' WHERE `locale` = 'deDE' AND `entry` = 34029;
-- OLD name : Abbild des Schreins
-- Source : https://www.wowhead.com/wotlk/de/npc=34032
UPDATE `creature_template_locale` SET `Name` = '[Cache Image]' WHERE `locale` = 'deDE' AND `entry` = 34032;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34036
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34036;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34037
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34037;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34038
UPDATE `creature_template_locale` SET `Name` = '[Sergeant Thunderhorn]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34038;
-- OLD name : Lady Palanseher, subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34039
UPDATE `creature_template_locale` SET `Name` = '[Lady Palanseer]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34039;
-- OLD name : Lady Palanseher, subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34040
UPDATE `creature_template_locale` SET `Name` = '[Lady Palanseer]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34040;
-- OLD name : Phantomgeisterfisch, subname : Außergewöhnlicher Designer
-- Source : https://www.wowhead.com/wotlk/de/npc=34042
UPDATE `creature_template_locale` SET `Name` = '[Phantom Ghostfish]',`Title` = '[Designer Extraordinaire]' WHERE `locale` = 'deDE' AND `entry` = 34042;
-- OLD subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34043
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 34043;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34058
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34058;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34059
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34059;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34060
UPDATE `creature_template_locale` SET `Name` = '[Doris Volanthius]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34060;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=34061
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34061;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=34062
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34062;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=34063
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Zar''shi]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34063;
-- OLD name : Urel Steinherz
-- Source : https://www.wowhead.com/wotlk/de/npc=34070
UPDATE `creature_template_locale` SET `Name` = '[Urel Stoneheart]' WHERE `locale` = 'deDE' AND `entry` = 34070;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34073
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34073;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34074
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34074;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34075
UPDATE `creature_template_locale` SET `Name` = '[Captain Dirgehammer]',`Title` = '[Apprentice Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34075;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34076
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34076;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34077
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34077;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34078
UPDATE `creature_template_locale` SET `Name` = '[Lieutenant Tristia]',`Title` = '[Veteran Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34078;
-- OLD subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34079
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 34079;
-- OLD name : Hauptmann O'Neal, subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34080
UPDATE `creature_template_locale` SET `Name` = '[Captain O''Neal]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34080;
-- OLD name : Hauptmann O'Neal, subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34081
UPDATE `creature_template_locale` SET `Name` = '[Captain O''Neal]',`Title` = '[Jewelcrafting Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34081;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=34082
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34082;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=34083
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34083;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=34084
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant Moonstrike]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 34084;
-- OLD name : Eisenfang Rüsti
-- Source : https://www.wowhead.com/wotlk/de/npc=34087
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix' WHERE `locale` = 'deDE' AND `entry` = 34087;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34088
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34088;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34089
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34089;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34090
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34090;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34091
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34091;
-- OLD name : Eisenfang Rüsti, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34092
UPDATE `creature_template_locale` SET `Name` = '[Trapjaw Rix]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34092;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34093
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34093;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34094
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34094;
-- OLD name : Eisenfang Rüsti, subname : Außergewöhnliche Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=34095
UPDATE `creature_template_locale` SET `Name` = '[Trapjaw Rix]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 34095;
-- OLD name : Der Schwarze Ritter
-- Source : https://www.wowhead.com/wotlk/de/npc=34104
UPDATE `creature_template_locale` SET `Name` = '[The Black Knight (No helmet)]' WHERE `locale` = 'deDE' AND `entry` = 34104;
-- OLD name : Argentumstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=34107
UPDATE `creature_template_locale` SET `Name` = '[Argent Charger (No abilities)]' WHERE `locale` = 'deDE' AND `entry` = 34107;
-- OLD name : Schattenfisch
-- Source : https://www.wowhead.com/wotlk/de/npc=34116
UPDATE `creature_template_locale` SET `Name` = '[Shadowy Fish]' WHERE `locale` = 'deDE' AND `entry` = 34116;
-- OLD name : Seuchenwagen der Knochenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=34128
UPDATE `creature_template_locale` SET `Name` = '[Boneguard Plague Wagon]' WHERE `locale` = 'deDE' AND `entry` = 34128;
-- OLD name : Blaues Skelettschlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=34154
UPDATE `creature_template_locale` SET `Name` = '[Blue Skeletal Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 34154;
-- OLD name : Toxic Tolerance Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=34157
UPDATE `creature_template_locale` SET `Name` = '[Toxic Tolerance Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 34157;
-- OLD name : Hannes Aschebäscha, subname : Fahrzeugtestausrüstung für Ulduar 10er
-- Source : https://www.wowhead.com/wotlk/de/npc=34168
UPDATE `creature_template_locale` SET `Name` = '[Jack McWeaksauce]',`Title` = '[Ulduar 10 Vehicle Test Gear]' WHERE `locale` = 'deDE' AND `entry` = 34168;
-- OLD name : Hauptmann Hermann Aschebäscha, subname : Der flammende Falke
-- Source : https://www.wowhead.com/wotlk/de/npc=34172
UPDATE `creature_template_locale` SET `Name` = '[Captain Julian McWeaksauce]',`Title` = '[The Flaming Falcon]' WHERE `locale` = 'deDE' AND `entry` = 34172;
-- OLD name : Großmutter Aschebäscha, subname : Verkäufer zukünftiger Rüstungssets
-- Source : https://www.wowhead.com/wotlk/de/npc=34173
UPDATE `creature_template_locale` SET `Name` = '[Granny McWeaksauce]',`Title` = '[Future Loot Tier Vendor]' WHERE `locale` = 'deDE' AND `entry` = 34173;
-- OLD name : Grylls
-- Source : https://www.wowhead.com/wotlk/de/npc=34178
UPDATE `creature_template_locale` SET `Name` = '[Grylls]' WHERE `locale` = 'deDE' AND `entry` = 34178;
-- OLD name : Fokussierter Laser
-- Source : https://www.wowhead.com/wotlk/de/npc=34181
UPDATE `creature_template_locale` SET `Name` = 'Fokuslaser' WHERE `locale` = 'deDE' AND `entry` = 34181;
-- OLD name : Sichtbares Einflusstentakel
-- Source : https://www.wowhead.com/wotlk/de/npc=34202
UPDATE `creature_template_locale` SET `Name` = '[Influence Tentacle Visual]' WHERE `locale` = 'deDE' AND `entry` = 34202;
-- OLD name : Brennende Rune
-- Source : https://www.wowhead.com/wotlk/de/npc=34213
UPDATE `creature_template_locale` SET `Name` = '[Flaming Rune]' WHERE `locale` = 'deDE' AND `entry` = 34213;
-- OLD name : Azerothplanetenpirscher
-- Source : https://www.wowhead.com/wotlk/de/npc=34250
UPDATE `creature_template_locale` SET `Name` = '[Azeroth Planet Stalker]' WHERE `locale` = 'deDE' AND `entry` = 34250;
-- OLD name : Recyclebotsägeblatt
-- Source : https://www.wowhead.com/wotlk/de/npc=34288
UPDATE `creature_template_locale` SET `Name` = 'Recyclebot Sägeblatt' WHERE `locale` = 'deDE' AND `entry` = 34288;
-- OLD name : Sara
-- Source : https://www.wowhead.com/wotlk/de/npc=34313
UPDATE `creature_template_locale` SET `Name` = '[Sara (Transform Only)]' WHERE `locale` = 'deDE' AND `entry` = 34313;
-- OLD name : Dino Meat Feeding Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=34327
UPDATE `creature_template_locale` SET `Name` = '[Dino Meat Feeding Credit]' WHERE `locale` = 'deDE' AND `entry` = 34327;
-- OLD name : Silithid Meat Feeding Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=34336
UPDATE `creature_template_locale` SET `Name` = '[Silithid Meat Feeding Credit]' WHERE `locale` = 'deDE' AND `entry` = 34336;
-- OLD name : Silithid Egg Feeding Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=34338
UPDATE `creature_template_locale` SET `Name` = '[Silithid Egg Feeding Credit]' WHERE `locale` = 'deDE' AND `entry` = 34338;
-- OLD name : Hasi
-- Source : https://www.wowhead.com/wotlk/de/npc=34360
UPDATE `creature_template_locale` SET `Name` = '[Wabbit]' WHERE `locale` = 'deDE' AND `entry` = 34360;
-- OLD name : Hochorakel Soo-roo
-- Source : https://www.wowhead.com/wotlk/de/npc=34386
UPDATE `creature_template_locale` SET `Name` = '[High-Oracle Soo-roo]' WHERE `locale` = 'deDE' AND `entry` = 34386;
-- OLD name : Ältester Kekek
-- Source : https://www.wowhead.com/wotlk/de/npc=34387
UPDATE `creature_template_locale` SET `Name` = '[Elder Kekek]' WHERE `locale` = 'deDE' AND `entry` = 34387;
-- OLD name : Testverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=34393
UPDATE `creature_template_locale` SET `Name` = '[Test Vendor]' WHERE `locale` = 'deDE' AND `entry` = 34393;
-- OLD name : MiniZep
-- Source : https://www.wowhead.com/wotlk/de/npc=34428
UPDATE `creature_template_locale` SET `Name` = '[MiniZep]' WHERE `locale` = 'deDE' AND `entry` = 34428;
-- OLD name : ELM Daze Target
-- Source : https://www.wowhead.com/wotlk/de/npc=34434
UPDATE `creature_template_locale` SET `Name` = '[ELM Daze Target]' WHERE `locale` = 'deDE' AND `entry` = 34434;
-- OLD name : ELM Attacker
-- Source : https://www.wowhead.com/wotlk/de/npc=34436
UPDATE `creature_template_locale` SET `Name` = '[ELM Attacker]' WHERE `locale` = 'deDE' AND `entry` = 34436;
-- OLD name : Kampfmeister der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=34437
UPDATE `creature_template_locale` SET `Name` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 34437;
-- OLD name : Heiterer Orcgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=34477
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Orc Spirit]' WHERE `locale` = 'deDE' AND `entry` = 34477;
-- OLD name : Heiterer Zwergengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=34478
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Dwarf Spirit]' WHERE `locale` = 'deDE' AND `entry` = 34478;
-- OLD name : Heiterer Gnomengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=34481
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Gnome Spirit]' WHERE `locale` = 'deDE' AND `entry` = 34481;
-- OLD name : Heiterer Trollgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=34482
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Troll Spirit]' WHERE `locale` = 'deDE' AND `entry` = 34482;
-- OLD name : Heiterer Draeneigeist
-- Source : https://www.wowhead.com/wotlk/de/npc=34484
UPDATE `creature_template_locale` SET `Name` = '[Cheerful Draenei Spirit]' WHERE `locale` = 'deDE' AND `entry` = 34484;
-- OLD name : Spielgefährte von den Winterflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=34489
UPDATE `creature_template_locale` SET `Name` = '[Winterfin Playmate]' WHERE `locale` = 'deDE' AND `entry` = 34489;
-- OLD name : Spielgefährte von der Schneewehenlichtung
-- Source : https://www.wowhead.com/wotlk/de/npc=34490
UPDATE `creature_template_locale` SET `Name` = '[Snowfall Glade Playmate]' WHERE `locale` = 'deDE' AND `entry` = 34490;
-- OLD name : Kupferkesselgoonie
-- Source : https://www.wowhead.com/wotlk/de/npc=34505
UPDATE `creature_template_locale` SET `Name` = '[Copperpot Goon]' WHERE `locale` = 'deDE' AND `entry` = 34505;
-- OLD name : XT-005 Debugger
-- Source : https://www.wowhead.com/wotlk/de/npc=34515
UPDATE `creature_template_locale` SET `Name` = '[XT-005 Debugger]' WHERE `locale` = 'deDE' AND `entry` = 34515;
-- OLD name : Roo
-- Source : https://www.wowhead.com/wotlk/de/npc=34531
UPDATE `creature_template_locale` SET `Name` = '[Roo]' WHERE `locale` = 'deDE' AND `entry` = 34531;
-- OLD name : Kekek
-- Source : https://www.wowhead.com/wotlk/de/npc=34532
UPDATE `creature_template_locale` SET `Name` = '[Kekek]' WHERE `locale` = 'deDE' AND `entry` = 34532;
-- OLD name : ScottM Test Creature
-- Source : https://www.wowhead.com/wotlk/de/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'deDE','[ScottM Test Creature]',NULL);
-- OLD name : Verlassener Witzbold
-- Source : https://www.wowhead.com/wotlk/de/npc=34561
UPDATE `creature_template_locale` SET `Name` = '[Forsaken Prankster]' WHERE `locale` = 'deDE' AND `entry` = 34561;
-- OLD name : Gifthautjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=34579
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.25)]' WHERE `locale` = 'deDE' AND `entry` = 34579;
-- OLD name : Gifthautjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=34580
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.50)]' WHERE `locale` = 'deDE' AND `entry` = 34580;
-- OLD name : Gifthautjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=34581
UPDATE `creature_template_locale` SET `Name` = '[Venomhide Hatchling (1.75)]' WHERE `locale` = 'deDE' AND `entry` = 34581;
-- OLD name : Danowe Donnerhorn
-- Source : https://www.wowhead.com/wotlk/de/npc=34612
UPDATE `creature_template_locale` SET `Name` = '[Danowe Thunderhorn]' WHERE `locale` = 'deDE' AND `entry` = 34612;
-- OLD name : Ogerpinata
-- Source : https://www.wowhead.com/wotlk/de/npc=34632
UPDATE `creature_template_locale` SET `Name` = '[Ogre Pinata]' WHERE `locale` = 'deDE' AND `entry` = 34632;
-- OLD name : Magischer Hahn
-- Source : https://www.wowhead.com/wotlk/de/npc=34655
UPDATE `creature_template_locale` SET `Name` = '[Magic Rooster]' WHERE `locale` = 'deDE' AND `entry` = 34655;
-- OLD name : Silberner Reitdrachenfalke
-- Source : https://www.wowhead.com/wotlk/de/npc=34709
UPDATE `creature_template_locale` SET `Name` = '[Silver Riding Dragonhawk]' WHERE `locale` = 'deDE' AND `entry` = 34709;
-- OLD name : Besatzungsmitglied Rohrschlüssel
-- Source : https://www.wowhead.com/wotlk/de/npc=34717
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Rohrschlüssel' WHERE `locale` = 'deDE' AND `entry` = 34717;
-- OLD name : Besatzungsmitglied Schlossriegel
-- Source : https://www.wowhead.com/wotlk/de/npc=34718
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schlossriegel' WHERE `locale` = 'deDE' AND `entry` = 34718;
-- OLD name : Besatzungsmitglied Schroter
-- Source : https://www.wowhead.com/wotlk/de/npc=34719
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schroter' WHERE `locale` = 'deDE' AND `entry` = 34719;
-- OLD name : Spice Bread Stuffing Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=34737
UPDATE `creature_template_locale` SET `Name` = '[Spice Bread Stuffing Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34737;
-- OLD name : Slow-roasted Turkey Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=34738
UPDATE `creature_template_locale` SET `Name` = '[Slow-roasted Turkey Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34738;
-- OLD name : Candied Sweet Potato Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=34739
UPDATE `creature_template_locale` SET `Name` = '[Candied Sweet Potato Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34739;
-- OLD name : Pumpkin Pie Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=34740
UPDATE `creature_template_locale` SET `Name` = '[Pumpkin Pie Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34740;
-- OLD name : Cranberry Chutney Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=34741
UPDATE `creature_template_locale` SET `Name` = '[Cranberry Chutney Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34741;
-- OLD name : Ätzschlund
-- Source : https://www.wowhead.com/wotlk/de/npc=34798
UPDATE `creature_template_locale` SET `Name` = '[Acidmaw (Mobile)]' WHERE `locale` = 'deDE' AND `entry` = 34798;
-- OLD name : Versengtes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=34801
UPDATE `creature_template_locale` SET `Name` = '[Incinerated Skeleton]' WHERE `locale` = 'deDE' AND `entry` = 34801;
-- OLD name : Bountiful Table Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=34806
UPDATE `creature_template_locale` SET `Name` = '[Bountiful Table Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 34806;
-- OLD name : Argent Coliseum PTR Beast Master
-- Source : https://www.wowhead.com/wotlk/de/npc=34827
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Beast Master]' WHERE `locale` = 'deDE' AND `entry` = 34827;
-- OLD name : Nachtelfischer Kolosseumszuschauer
-- Source : https://www.wowhead.com/wotlk/de/npc=34871
UPDATE `creature_template_locale` SET `Name` = 'Nachelfischer Kolosseumszuschauer' WHERE `locale` = 'deDE' AND `entry` = 34871;
-- OLD name : Jend Jow (Test), subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=34895
UPDATE `creature_template_locale` SET `Name` = '[Jend Jow (Test)]',`Title` = '[Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 34895;
-- OLD name : Schneeblinder Anhänger
-- Source : https://www.wowhead.com/wotlk/de/npc=34899
UPDATE `creature_template_locale` SET `Name` = '[Snowblind Follower Proxy]' WHERE `locale` = 'deDE' AND `entry` = 34899;
-- OLD name : Höllische Teufelsflammenkugel
-- Source : https://www.wowhead.com/wotlk/de/npc=34921
UPDATE `creature_template_locale` SET `Name` = '[Felflame Infernal Ball]' WHERE `locale` = 'deDE' AND `entry` = 34921;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=34929
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots' WHERE `locale` = 'deDE' AND `entry` = 34929;
-- OLD name : Erinnerung an Hogger
-- Source : https://www.wowhead.com/wotlk/de/npc=34942
UPDATE `creature_template_locale` SET `Name` = '[Memory of Hogger]' WHERE `locale` = 'deDE' AND `entry` = 34942;
-- OLD name : Abgesandter der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=34950
UPDATE `creature_template_locale` SET `Name` = 'Botschafter der Insel der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 34950;
-- OLD name : Luftschiffkapitän der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=34960
UPDATE `creature_template_locale` SET `Name` = 'Kanonenbootkapitän der Allianz' WHERE `locale` = 'deDE' AND `entry` = 34960;
-- OLD name : Hotoro, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=34971
UPDATE `creature_template_locale` SET `Name` = '[Hotoro]',`Title` = '[Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 34971;
-- OLD name : Aelus Goldmorgen, subname : Kampfmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=34972
UPDATE `creature_template_locale` SET `Name` = '[Aelus Goldmorn]',`Title` = '[Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 34972;
-- OLD name : Larina Herzschmiede, subname : Kampfmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=34993
UPDATE `creature_template_locale` SET `Name` = '[Larina Heartforge]',`Title` = '[Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 34993;
-- OLD name : Koralon
-- Source : https://www.wowhead.com/wotlk/de/npc=35018
UPDATE `creature_template_locale` SET `Name` = '[Stalker Koralon]' WHERE `locale` = 'deDE' AND `entry` = 35018;
-- OLD name : Bruka Trauerbringer, subname : Kampfmeisterin der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=35019
UPDATE `creature_template_locale` SET `Name` = '[Bruka Woebringer]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 35019;
-- OLD name : Terrance Matterly, subname : Kampfmeister der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=35023
UPDATE `creature_template_locale` SET `Name` = '[Terrance Matterly]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 35023;
-- OLD name : Dracien Flanning, subname : Kampfmeister der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=35024
UPDATE `creature_template_locale` SET `Name` = '[Dracien Flanning]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 35024;
-- OLD name : Lynette Hefter, subname : Kampfmeisterin der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=35025
UPDATE `creature_template_locale` SET `Name` = '[Lynette Bracer]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 35025;
-- OLD name : Erutor, subname : Kampfmeister der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=35027
UPDATE `creature_template_locale` SET `Name` = '[Erutor]',`Title` = '[Isle of Conquest Battlemaster]' WHERE `locale` = 'deDE' AND `entry` = 35027;
-- OLD name : Erinnerung an Lucifron
-- Source : https://www.wowhead.com/wotlk/de/npc=35031
UPDATE `creature_template_locale` SET `Name` = '[Memory of Lucifron]' WHERE `locale` = 'deDE' AND `entry` = 35031;
-- OLD name : Erinnerung an Donneraan
-- Source : https://www.wowhead.com/wotlk/de/npc=35032
UPDATE `creature_template_locale` SET `Name` = '[Memory of Thunderaan]' WHERE `locale` = 'deDE' AND `entry` = 35032;
-- OLD name : Erinnerung an Hakkar
-- Source : https://www.wowhead.com/wotlk/de/npc=35034
UPDATE `creature_template_locale` SET `Name` = '[Memory of Hakkar]' WHERE `locale` = 'deDE' AND `entry` = 35034;
-- OLD name : Geist eines gefallenen Helden
-- Source : https://www.wowhead.com/wotlk/de/npc=35055
UPDATE `creature_template_locale` SET `Name` = '[Fallen Hero''s Spirit Proxy]' WHERE `locale` = 'deDE' AND `entry` = 35055;
-- OLD name : Wichtel in der Kugel
-- Source : https://www.wowhead.com/wotlk/de/npc=35067
UPDATE `creature_template_locale` SET `Name` = '[Imp in a Bottle]' WHERE `locale` = 'deDE' AND `entry` = 35067;
-- OLD name : Scharfseher Eannu
-- Source : https://www.wowhead.com/wotlk/de/npc=35073
UPDATE `creature_template_locale` SET `Name` = 'Weitseher Eannu' WHERE `locale` = 'deDE' AND `entry` = 35073;
-- OLD name : Großmagd Fisk
-- Source : https://www.wowhead.com/wotlk/de/npc=35085
UPDATE `creature_template_locale` SET `Name` = '[Foreman Fisk]' WHERE `locale` = 'deDE' AND `entry` = 35085;
-- OLD name : Arbeitsaufseher Grabbit
-- Source : https://www.wowhead.com/wotlk/de/npc=35086
UPDATE `creature_template_locale` SET `Name` = '[Labor Captain Grabbit]' WHERE `locale` = 'deDE' AND `entry` = 35086;
-- OLD name : Malynea Himmelshäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=35087
UPDATE `creature_template_locale` SET `Name` = '[Malynea Skyreaver]' WHERE `locale` = 'deDE' AND `entry` = 35087;
-- OLD name : Custer Clubnik
-- Source : https://www.wowhead.com/wotlk/de/npc=35088
UPDATE `creature_template_locale` SET `Name` = '[Custer Clubnik]' WHERE `locale` = 'deDE' AND `entry` = 35088;
-- OLD name : Horzak Zignibbel
-- Source : https://www.wowhead.com/wotlk/de/npc=35091
UPDATE `creature_template_locale` SET `Name` = '[Horzak Zignibble]' WHERE `locale` = 'deDE' AND `entry` = 35091;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer' WHERE `locale` = 'deDE' AND `entry` = 35093;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer' WHERE `locale` = 'deDE' AND `entry` = 35100;
-- OLD name : Argent Coliseum PTR Eredar Master
-- Source : https://www.wowhead.com/wotlk/de/npc=35107
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Eredar Master]' WHERE `locale` = 'deDE' AND `entry` = 35107;
-- OLD name : Argent Coliseum PTR Faction Champion Master
-- Source : https://www.wowhead.com/wotlk/de/npc=35108
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Faction Champion Master]' WHERE `locale` = 'deDE' AND `entry` = 35108;
-- OLD name : Argent Coliseum PTR Val'kyr Master
-- Source : https://www.wowhead.com/wotlk/de/npc=35109
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Val''kyr Master]' WHERE `locale` = 'deDE' AND `entry` = 35109;
-- OLD name : Argent Coliseum PTR Anub'arak Master
-- Source : https://www.wowhead.com/wotlk/de/npc=35110
UPDATE `creature_template_locale` SET `Name` = '[Argent Coliseum PTR Anub''arak Master]' WHERE `locale` = 'deDE' AND `entry` = 35110;
-- OLD name : Assassine des Kults
-- Source : https://www.wowhead.com/wotlk/de/npc=35127
UPDATE `creature_template_locale` SET `Name` = 'Assassin des Kults' WHERE `locale` = 'deDE' AND `entry` = 35127;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 35133;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 35135;
-- OLD name : Schreckensmaul
-- Source : https://www.wowhead.com/wotlk/de/npc=35145
UPDATE `creature_template_locale` SET `Name` = '[Dreadscale (Sessile)]' WHERE `locale` = 'deDE' AND `entry` = 35145;
-- OLD name : Argentumhippogryph
-- Source : https://www.wowhead.com/wotlk/de/npc=35146
UPDATE `creature_template_locale` SET `Name` = '[Argent Hippogryph (Bombing Run)]' WHERE `locale` = 'deDE' AND `entry` = 35146;
-- OLD name : Manageist
-- Source : https://www.wowhead.com/wotlk/de/npc=35155
UPDATE `creature_template_locale` SET `Name` = '[Mana Spirit]' WHERE `locale` = 'deDE' AND `entry` = 35155;
-- OLD name : Jadepanda
-- Source : https://www.wowhead.com/wotlk/de/npc=35156
UPDATE `creature_template_locale` SET `Name` = '[Jade Panda]' WHERE `locale` = 'deDE' AND `entry` = 35156;
-- OLD name : Winziger Jadedrache
-- Source : https://www.wowhead.com/wotlk/de/npc=35157
UPDATE `creature_template_locale` SET `Name` = '[Tiny Jade Dragon]' WHERE `locale` = 'deDE' AND `entry` = 35157;
-- OLD name : Argentumstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=35179
UPDATE `creature_template_locale` SET `Name` = '[Argent Charger]' WHERE `locale` = 'deDE' AND `entry` = 35179;
-- OLD name : Argentumschlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=35180
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhorse]' WHERE `locale` = 'deDE' AND `entry` = 35180;
-- OLD name : Vergrabener Jormungar
-- Source : https://www.wowhead.com/wotlk/de/npc=35228
UPDATE `creature_template_locale` SET `Name` = '[Invisible Burrowed Jormungar]' WHERE `locale` = 'deDE' AND `entry` = 35228;
-- OLD name : Eindringling der Kvaldir
-- Source : https://www.wowhead.com/wotlk/de/npc=35242
UPDATE `creature_template_locale` SET `Name` = '[Kvaldir Invader]' WHERE `locale` = 'deDE' AND `entry` = 35242;
-- OLD name : Feiernder Draeneigeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35246
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Draenei Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35246;
-- OLD name : Feiernder Zwergengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35247
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Dwarf Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35247;
-- OLD name : Feiernder Gnomengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35248
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Gnome Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35248;
-- OLD name : Feiernder Nachtelfengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35250
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Night Elf Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35250;
-- OLD name : Feiernder Orcgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35251
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Orc Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35251;
-- OLD name : Feiernder Trollgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=35253
UPDATE `creature_template_locale` SET `Name` = '[Ghostly Troll Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 35253;
-- OLD name : Argentumfohlen
-- Source : https://www.wowhead.com/wotlk/de/npc=35285
UPDATE `creature_template_locale` SET `Name` = '[Argent Colt]' WHERE `locale` = 'deDE' AND `entry` = 35285;
-- OLD name : Kultist von Eiskrone
-- Source : https://www.wowhead.com/wotlk/de/npc=35297
UPDATE `creature_template_locale` SET `Name` = '[Icecrown Cultist Proxy]' WHERE `locale` = 'deDE' AND `entry` = 35297;
-- OLD subname : Oberanführer der Kriegshymnenoffensive
-- Source : https://www.wowhead.com/wotlk/de/npc=35372
UPDATE `creature_template_locale` SET `Title` = 'Hochlord der Kriegshymnenoffensive' WHERE `locale` = 'deDE' AND `entry` = 35372;
-- OLD name : Der Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=35459
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'deDE' AND `entry` = 35459;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=35460
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 35460;
-- OLD name : Rachsüchtige Val'kyr
-- Source : https://www.wowhead.com/wotlk/de/npc=35474
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Val''kyr]' WHERE `locale` = 'deDE' AND `entry` = 35474;
-- OLD name : Wache der Zephyr, subname : Die Zephyr
-- Source : https://www.wowhead.com/wotlk/de/npc=35492
UPDATE `creature_template_locale` SET `Name` = '[Zephyr Guard]',`Title` = '[The Zephyr]' WHERE `locale` = 'deDE' AND `entry` = 35492;
-- OLD name : Rachsüchtiger Frostwyrm
-- Source : https://www.wowhead.com/wotlk/de/npc=35493
UPDATE `creature_template_locale` SET `Name` = '[Vengeful Frostwyrm]' WHERE `locale` = 'deDE' AND `entry` = 35493;
-- OLD subname : Emblem des Triumph Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs' WHERE `locale` = 'deDE' AND `entry` = 35494;
-- OLD subname : Emblem des Triumph Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=35495
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs' WHERE `locale` = 'deDE' AND `entry` = 35495;
-- OLD subname : Stoffrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=35496
UPDATE `creature_template_locale` SET `Title` = 'Händler für Stoffrüstung' WHERE `locale` = 'deDE' AND `entry` = 35496;
-- OLD subname : Lederrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=35497
UPDATE `creature_template_locale` SET `Title` = 'Händler für Lederrüstung' WHERE `locale` = 'deDE' AND `entry` = 35497;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=35500
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für Schwere Rüstung' WHERE `locale` = 'deDE' AND `entry` = 35500;
-- OLD subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs' WHERE `locale` = 'deDE' AND `entry` = 35573;
-- OLD subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs' WHERE `locale` = 'deDE' AND `entry` = 35574;
-- OLD name : Argentumhippogryph
-- Source : https://www.wowhead.com/wotlk/de/npc=35586
UPDATE `creature_template_locale` SET `Name` = '[Argent Hippogryph (Herald Mount)]' WHERE `locale` = 'deDE' AND `entry` = 35586;
-- OLD name : Argentumfriedensbewahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35587
UPDATE `creature_template_locale` SET `Name` = '[Argent Peacekeeper]' WHERE `locale` = 'deDE' AND `entry` = 35587;
-- OLD name : Kolosseumsmeister der Flickwerke
-- Source : https://www.wowhead.com/wotlk/de/npc=35588
UPDATE `creature_template_locale` SET `Name` = '[Coliseum Master of Patchwerks]' WHERE `locale` = 'deDE' AND `entry` = 35588;
-- OLD name : Jaeren Sonnenschwur
-- Source : https://www.wowhead.com/wotlk/de/npc=35589
UPDATE `creature_template_locale` SET `Name` = '[Jaeren Sunsworn]' WHERE `locale` = 'deDE' AND `entry` = 35589;
-- OLD name : Arelas Hellstern
-- Source : https://www.wowhead.com/wotlk/de/npc=35604
UPDATE `creature_template_locale` SET `Name` = '[Arelas Brightstar]' WHERE `locale` = 'deDE' AND `entry` = 35604;
-- OLD name : Kaputte Festungskanone
-- Source : https://www.wowhead.com/wotlk/de/npc=35819
UPDATE `creature_template_locale` SET `Name` = '[Broken Keep Cannon]' WHERE `locale` = 'deDE' AND `entry` = 35819;
-- OLD name : Barrett Ramsey, subname : Zeremonienmeister des Argentumkolosseums
-- Source : https://www.wowhead.com/wotlk/de/npc=35895
UPDATE `creature_template_locale` SET `Name` = '[Barrett Ramsey]',`Title` = '[Argent Coliseum Master]' WHERE `locale` = 'deDE' AND `entry` = 35895;
-- OLD name : Barrett Ramsey, subname : Zeremonienmeister des Argentumkolosseums
-- Source : https://www.wowhead.com/wotlk/de/npc=35910
UPDATE `creature_template_locale` SET `Name` = '[Barrett Ramsey]',`Title` = '[Argent Coliseum Master]' WHERE `locale` = 'deDE' AND `entry` = 35910;
-- OLD name : Die Schwarze Schankmaid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=36024
UPDATE `creature_template_locale` SET `Name` = 'Die schwarze Schankmaid' WHERE `locale` = 'deDE' AND `entry` = 36024;
-- OLD name : Frostwyrmreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=36128
UPDATE `creature_template_locale` SET `Name` = '[Frostwyrm Rider]' WHERE `locale` = 'deDE' AND `entry` = 36128;
-- OLD name : Häscher der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Häscher der Kro''kron' WHERE `locale` = 'deDE' AND `entry` = 36164;
-- OLD name : Dan's Testkoloss
-- Source : https://www.wowhead.com/wotlk/de/npc=36168
UPDATE `creature_template_locale` SET `Name` = '[Dan''s Test Colossus]' WHERE `locale` = 'deDE' AND `entry` = 36168;
-- OLD name : Hardknuckle Charger Proxy
-- Source : https://www.wowhead.com/wotlk/de/npc=36189
UPDATE `creature_template_locale` SET `Name` = '[Hardknuckle Charger Proxy]' WHERE `locale` = 'deDE' AND `entry` = 36189;
-- OLD name : Aufseher der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=36213
UPDATE `creature_template_locale` SET `Name` = '[Kor''kron Overseer]' WHERE `locale` = 'deDE' AND `entry` = 36213;
-- OLD name : Schweitzermobil
-- Source : https://www.wowhead.com/wotlk/de/npc=36215
UPDATE `creature_template_locale` SET `Name` = '[Schweitzermobile]' WHERE `locale` = 'deDE' AND `entry` = 36215;
-- OLD name : Aufseher Kraggosh
-- Source : https://www.wowhead.com/wotlk/de/npc=36217
UPDATE `creature_template_locale` SET `Name` = '[Overseer Kraggosh]' WHERE `locale` = 'deDE' AND `entry` = 36217;
-- OLD name : Auktionator Felsknochen
-- Source : https://www.wowhead.com/wotlk/de/npc=36235
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Rockbone]' WHERE `locale` = 'deDE' AND `entry` = 36235;
-- OLD name : Flint Eisenhirsch, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=36284
UPDATE `creature_template_locale` SET `Name` = '[Flint Ironstag]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 36284;
-- OLD name : Honorable Defender Trigger, 25 yd (Horde)
-- Source : https://www.wowhead.com/wotlk/de/npc=36350
UPDATE `creature_template_locale` SET `Name` = '[Honorable Defender Trigger, 25 yd (Horde)]' WHERE `locale` = 'deDE' AND `entry` = 36350;
-- OLD name : Slab Schott, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=36351
UPDATE `creature_template_locale` SET `Name` = '[Slab Bulkhead]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 36351;
-- OLD name : Kister Truhendeckel, subname : Bankier
-- Source : https://www.wowhead.com/wotlk/de/npc=36352
UPDATE `creature_template_locale` SET `Name` = '[Trunk Slamchest]',`Title` = '[Banker]' WHERE `locale` = 'deDE' AND `entry` = 36352;
-- OLD name : Auktionator Plankkist
-- Source : https://www.wowhead.com/wotlk/de/npc=36359
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Plankchest]' WHERE `locale` = 'deDE' AND `entry` = 36359;
-- OLD name : Auktionator Flachstein
-- Source : https://www.wowhead.com/wotlk/de/npc=36360
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Slabrock]' WHERE `locale` = 'deDE' AND `entry` = 36360;
-- OLD name : Buff Hartrücken
-- Source : https://www.wowhead.com/wotlk/de/npc=36380
UPDATE `creature_template_locale` SET `Name` = '[Buff Hardback]' WHERE `locale` = 'deDE' AND `entry` = 36380;
-- OLD name : Blast Dicknacken
-- Source : https://www.wowhead.com/wotlk/de/npc=36390
UPDATE `creature_template_locale` SET `Name` = '[Blast Thickneck]' WHERE `locale` = 'deDE' AND `entry` = 36390;
-- OLD name : Wache der Dunkeleisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=36431
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Guard]' WHERE `locale` = 'deDE' AND `entry` = 36431;
-- OLD name : Kleiner Schimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=36483
UPDATE `creature_template_locale` SET `Name` = '[Little White Stallion]' WHERE `locale` = 'deDE' AND `entry` = 36483;
-- OLD name : Kleiner elfenbeinfarbener Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=36484
UPDATE `creature_template_locale` SET `Name` = '[Little Ivory Raptor]' WHERE `locale` = 'deDE' AND `entry` = 36484;
-- OLD name : Verschlinger der Seelen
-- Source : https://www.wowhead.com/wotlk/de/npc=36503
UPDATE `creature_template_locale` SET `Name` = '[Devourer of Souls]' WHERE `locale` = 'deDE' AND `entry` = 36503;
-- OLD name : Verschlinger der Seelen
-- Source : https://www.wowhead.com/wotlk/de/npc=36504
UPDATE `creature_template_locale` SET `Name` = '[Devourer of Souls]' WHERE `locale` = 'deDE' AND `entry` = 36504;
-- OLD name : Sandvortex von Durotar
-- Source : https://www.wowhead.com/wotlk/de/npc=36510
UPDATE `creature_template_locale` SET `Name` = '[Durotar Sand Vortex]' WHERE `locale` = 'deDE' AND `entry` = 36510;
-- OLD name : Instabiles Totem der Verbrennung
-- Source : https://www.wowhead.com/wotlk/de/npc=36532
UPDATE `creature_template_locale` SET `Name` = '[Unstable Searing Totem]' WHERE `locale` = 'deDE' AND `entry` = 36532;
-- OLD name : Instabiler Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36533
UPDATE `creature_template_locale` SET `Name` = '[Unstable Fire Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36533;
-- OLD name : Instabiler Erdelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36537
UPDATE `creature_template_locale` SET `Name` = '[Unstable Earth Elemental [mini]]' WHERE `locale` = 'deDE' AND `entry` = 36537;
-- OLD name : Instabiles Totem des heilenden Flusses
-- Source : https://www.wowhead.com/wotlk/de/npc=36542
UPDATE `creature_template_locale` SET `Name` = '[Unstable Healing Stream Totem]' WHERE `locale` = 'deDE' AND `entry` = 36542;
-- OLD name : Instabiler Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36543
UPDATE `creature_template_locale` SET `Name` = '[Unstable Water Elemental [mini]]' WHERE `locale` = 'deDE' AND `entry` = 36543;
-- OLD name : Nachtelfirokese
-- Source : https://www.wowhead.com/wotlk/de/npc=36544
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mohawk]' WHERE `locale` = 'deDE' AND `entry` = 36544;
-- OLD name : Instabiler Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36545
UPDATE `creature_template_locale` SET `Name` = '[Unstable Water Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36545;
-- OLD name : Instabiler Luftelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36546
UPDATE `creature_template_locale` SET `Name` = '[Unstable Air Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36546;
-- OLD name : Instabiler Luftelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36547
UPDATE `creature_template_locale` SET `Name` = '[Unstable Air Elemental [mini]]' WHERE `locale` = 'deDE' AND `entry` = 36547;
-- OLD name : Instabiles Totem der Steinhaut
-- Source : https://www.wowhead.com/wotlk/de/npc=36550
UPDATE `creature_template_locale` SET `Name` = '[Unstable Stoneskin Totem]' WHERE `locale` = 'deDE' AND `entry` = 36550;
-- OLD name : Instabiler Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36553
UPDATE `creature_template_locale` SET `Name` = '[Unstable Fire Elemental [mini] ]' WHERE `locale` = 'deDE' AND `entry` = 36553;
-- OLD name : Instabiler Erdelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36554
UPDATE `creature_template_locale` SET `Name` = '[Unstable Earth Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36554;
-- OLD name : Instabiles Totem des stürmischen Zorns
-- Source : https://www.wowhead.com/wotlk/de/npc=36556
UPDATE `creature_template_locale` SET `Name` = '[Unstable Wrath of Air Totem]' WHERE `locale` = 'deDE' AND `entry` = 36556;
-- OLD name : Justin's test Boss A
-- Source : https://www.wowhead.com/wotlk/de/npc=36573
UPDATE `creature_template_locale` SET `Name` = '[Justin''s test Boss A]' WHERE `locale` = 'deDE' AND `entry` = 36573;
-- OLD name : Justin's Test Boss B
-- Source : https://www.wowhead.com/wotlk/de/npc=36574
UPDATE `creature_template_locale` SET `Name` = '[Justin''s Test Boss B]' WHERE `locale` = 'deDE' AND `entry` = 36574;
-- OLD name : Instabiler Lichtbrunnen
-- Source : https://www.wowhead.com/wotlk/de/npc=36605
UPDATE `creature_template_locale` SET `Name` = '[Unstable Lightwell]' WHERE `locale` = 'deDE' AND `entry` = 36605;
-- OLD name : Adeptin der Seelenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=36620
UPDATE `creature_template_locale` SET `Name` = 'Adept der Seelenwache' WHERE `locale` = 'deDE' AND `entry` = 36620;
-- OLD name : Ahmo Donnerhorn
-- Source : https://www.wowhead.com/wotlk/de/npc=36644
UPDATE `creature_template_locale` SET `Name` = '[Ahmo Thunderhorn]' WHERE `locale` = 'deDE' AND `entry` = 36644;
-- OLD name : Baine Bluthuf, subname : Oberhäuptling
-- Source : https://www.wowhead.com/wotlk/de/npc=36648
UPDATE `creature_template_locale` SET `Name` = '[Baine Bloodhoof (Leader)]',`Title` = '[High Chieftain]' WHERE `locale` = 'deDE' AND `entry` = 36648;
-- OLD name : Schildwache des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36656
UPDATE `creature_template_locale` SET `Name` = 'Schildwache des Silberbundes' WHERE `locale` = 'deDE' AND `entry` = 36656;
-- OLD name : Skelettminenarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=36677
UPDATE `creature_template_locale` SET `Name` = '[Skeletal Miner (Cosmetic)]' WHERE `locale` = 'deDE' AND `entry` = 36677;
-- OLD name : Leutnant der Frostanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=36679
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Lieutenant]' WHERE `locale` = 'deDE' AND `entry` = 36679;
-- OLD name : Quel'Delar Krasus Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=36715
UPDATE `creature_template_locale` SET `Name` = '[Quel''Delar Krasus Credit]' WHERE `locale` = 'deDE' AND `entry` = 36715;
-- OLD name : Unsichtbarer Pirscher
-- Source : https://www.wowhead.com/wotlk/de/npc=36737
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker]' WHERE `locale` = 'deDE' AND `entry` = 36737;
-- OLD name : Berserker der Frostanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=36757
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Berserker]' WHERE `locale` = 'deDE' AND `entry` = 36757;
-- OLD name : Schlachtenmagier der Frostanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=36763
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Battle-Mage]' WHERE `locale` = 'deDE' AND `entry` = 36763;
-- OLD name : Schütze der Frostanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=36769
UPDATE `creature_template_locale` SET `Name` = '[Frostsworn Marksman]' WHERE `locale` = 'deDE' AND `entry` = 36769;
-- OLD name : Agent des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36774
UPDATE `creature_template_locale` SET `Name` = 'Agent des Silberbundes' WHERE `locale` = 'deDE' AND `entry` = 36774;
-- OLD name : Mächtiger Frostsäbler, subname : Begleiter des Nachtelfirokesen
-- Source : https://www.wowhead.com/wotlk/de/npc=36778
UPDATE `creature_template_locale` SET `Name` = '[Mighty Frostsaber]',`Title` = '[Night Elf Mohawk''s Companion]' WHERE `locale` = 'deDE' AND `entry` = 36778;
-- OLD name : Verderbter Champion
-- Source : https://www.wowhead.com/wotlk/de/npc=36796
UPDATE `creature_template_locale` SET `Name` = '[Corrupted Champion]' WHERE `locale` = 'deDE' AND `entry` = 36796;
-- OLD name : Matts Testpriester
-- Source : https://www.wowhead.com/wotlk/de/npc=36804
UPDATE `creature_template_locale` SET `Name` = '[Matt''s Test Priest]' WHERE `locale` = 'deDE' AND `entry` = 36804;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=36838
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots' WHERE `locale` = 'deDE' AND `entry` = 36838;
-- OLD name : Blutelfenkrieger
-- Source : https://www.wowhead.com/wotlk/de/npc=36857
UPDATE `creature_template_locale` SET `Name` = '[Blood Elf Warrior]' WHERE `locale` = 'deDE' AND `entry` = 36857;
-- OLD name : Zwergenmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=36858
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Mage]' WHERE `locale` = 'deDE' AND `entry` = 36858;
-- OLD name : Zwergenschamane
-- Source : https://www.wowhead.com/wotlk/de/npc=36859
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Shaman]' WHERE `locale` = 'deDE' AND `entry` = 36859;
-- OLD name : Gnomenpriester
-- Source : https://www.wowhead.com/wotlk/de/npc=36860
UPDATE `creature_template_locale` SET `Name` = '[Gnome Priest]' WHERE `locale` = 'deDE' AND `entry` = 36860;
-- OLD name : Menschlicher Jäger
-- Source : https://www.wowhead.com/wotlk/de/npc=36861
UPDATE `creature_template_locale` SET `Name` = '[Human Hunter]' WHERE `locale` = 'deDE' AND `entry` = 36861;
-- OLD name : Nachtelfenmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=36862
UPDATE `creature_template_locale` SET `Name` = '[Night Elf Mage]' WHERE `locale` = 'deDE' AND `entry` = 36862;
-- OLD name : Orcmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=36863
UPDATE `creature_template_locale` SET `Name` = '[Orc Mage]' WHERE `locale` = 'deDE' AND `entry` = 36863;
-- OLD name : Taurenpaladin
-- Source : https://www.wowhead.com/wotlk/de/npc=36864
UPDATE `creature_template_locale` SET `Name` = '[Tauren Paladin]' WHERE `locale` = 'deDE' AND `entry` = 36864;
-- OLD name : Taurenpriester
-- Source : https://www.wowhead.com/wotlk/de/npc=36865
UPDATE `creature_template_locale` SET `Name` = '[Tauren Priest]' WHERE `locale` = 'deDE' AND `entry` = 36865;
-- OLD name : Trolldruide
-- Source : https://www.wowhead.com/wotlk/de/npc=36866
UPDATE `creature_template_locale` SET `Name` = '[Troll Druid]' WHERE `locale` = 'deDE' AND `entry` = 36866;
-- OLD name : Untoter Jäger
-- Source : https://www.wowhead.com/wotlk/de/npc=36867
UPDATE `creature_template_locale` SET `Name` = '[Undead Hunter]' WHERE `locale` = 'deDE' AND `entry` = 36867;
-- OLD name : Gryphon Hatchling 3.3.0
-- Source : https://www.wowhead.com/wotlk/de/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'deDE','[Gryphon Hatchling 3.3.0]',NULL);
-- OLD name : Chen Sturmbräu
-- Source : https://www.wowhead.com/wotlk/de/npc=36912
UPDATE `creature_template_locale` SET `Name` = '[Chen Stormstout]' WHERE `locale` = 'deDE' AND `entry` = 36912;
-- OLD name : Wütender Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36965
UPDATE `creature_template_locale` SET `Name` = '[Furious Water Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36965;
-- OLD name : Seelengebundener Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=36977
UPDATE `creature_template_locale` SET `Name` = '[Soulbound Fire Elemental]' WHERE `locale` = 'deDE' AND `entry` = 36977;
-- OLD name : Wogender Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=37036
UPDATE `creature_template_locale` SET `Name` = '[Rippling Water Elemental]' WHERE `locale` = 'deDE' AND `entry` = 37036;
-- OLD name : Acanthurus
-- Source : https://www.wowhead.com/wotlk/de/npc=37037
UPDATE `creature_template_locale` SET `Name` = '[Acanthurus]' WHERE `locale` = 'deDE' AND `entry` = 37037;
-- OLD name : Stadtwache von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=37063
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Guard]' WHERE `locale` = 'deDE' AND `entry` = 37063;
-- OLD name : Argent Warhose TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=37074
UPDATE `creature_template_locale` SET `Name` = '[Argent Warhose TEST]' WHERE `locale` = 'deDE' AND `entry` = 37074;
-- OLD name : Brigadegeneral der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=37100
UPDATE `creature_template_locale` SET `Name` = '[Alliance Brigadier General (Stormwind Visual)]' WHERE `locale` = 'deDE' AND `entry` = 37100;
-- OLD name : Horde Warbringer - Orgrimmar Appearance (DND)
-- Source : https://www.wowhead.com/wotlk/de/npc=37101
UPDATE `creature_template_locale` SET `Name` = '[Horde Warbringer - Orgrimmar Appearance (DND)]' WHERE `locale` = 'deDE' AND `entry` = 37101;
-- OLD name : Elementarstein
-- Source : https://www.wowhead.com/wotlk/de/npc=37118
UPDATE `creature_template_locale` SET `Name` = '[Elemental Stone]' WHERE `locale` = 'deDE' AND `entry` = 37118;
-- OLD name : Spiegelbild
-- Source : https://www.wowhead.com/wotlk/de/npc=37130
UPDATE `creature_template_locale` SET `Name` = '[Mirror Image]' WHERE `locale` = 'deDE' AND `entry` = 37130;
-- OLD name : Spiegelbild
-- Source : https://www.wowhead.com/wotlk/de/npc=37131
UPDATE `creature_template_locale` SET `Name` = '[Mirror Image Bug Test]' WHERE `locale` = 'deDE' AND `entry` = 37131;
-- OLD name : Heckenschütze der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=37146
UPDATE `creature_template_locale` SET `Name` = 'Scharfschütze der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 37146;
-- OLD name : Balistoides
-- Source : https://www.wowhead.com/wotlk/de/npc=37193
UPDATE `creature_template_locale` SET `Name` = '[Balistoides]' WHERE `locale` = 'deDE' AND `entry` = 37193;
-- OLD name : Chaetodon
-- Source : https://www.wowhead.com/wotlk/de/npc=37194
UPDATE `creature_template_locale` SET `Name` = '[Chaetodon]' WHERE `locale` = 'deDE' AND `entry` = 37194;
-- OLD name : Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37205
UPDATE `creature_template_locale` SET `Name` = 'Thalorien Dämmersucher' WHERE `locale` = 'deDE' AND `entry` = 37205;
-- OLD name : Lakai der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=37214
UPDATE `creature_template_locale` SET `Name` = 'Lakei der Manufaktur Krone' WHERE `locale` = 'deDE' AND `entry` = 37214;
-- OLD name : Schleimiges Tentakel
-- Source : https://www.wowhead.com/wotlk/de/npc=37530
UPDATE `creature_template_locale` SET `Name` = '[Slimy Tentacle]' WHERE `locale` = 'deDE' AND `entry` = 37530;
-- OLD name : Schlammbedecktes Tentakel
-- Source : https://www.wowhead.com/wotlk/de/npc=37535
UPDATE `creature_template_locale` SET `Name` = '[Ooze Covered Tentacle]' WHERE `locale` = 'deDE' AND `entry` = 37535;
-- OLD name : Überreste von Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37552
UPDATE `creature_template_locale` SET `Name` = 'Überreste von Thalorien Dämmersucher' WHERE `locale` = 'deDE' AND `entry` = 37552;
-- OLD name : Thalorien Dawnseeker Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=37601
UPDATE `creature_template_locale` SET `Name` = '[Thalorien Dawnseeker Credit]' WHERE `locale` = 'deDE' AND `entry` = 37601;
-- OLD name : Mutierte Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=37672
UPDATE `creature_template_locale` SET `Name` = 'Mutierte Monströsität' WHERE `locale` = 'deDE' AND `entry` = 37672;
-- OLD name : Wächterschatten
-- Source : https://www.wowhead.com/wotlk/de/npc=37691
UPDATE `creature_template_locale` SET `Name` = '[Guardian Shade]' WHERE `locale` = 'deDE' AND `entry` = 37691;
-- OLD name : Kommandant Aliocha Segard, subname : Rüstmeisterin des Argentumkreuzzugs
-- Source : https://www.wowhead.com/wotlk/de/npc=37693
UPDATE `creature_template_locale` SET `Name` = '[Commander Aliocha Segard [Icecrown Raid]]',`Title` = '[Argent Crusade Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 37693;
-- OLD name : RN Test Honor Guard
-- Source : https://www.wowhead.com/wotlk/de/npc=37699
UPDATE `creature_template_locale` SET `Name` = '[RN Test Honor Guard]' WHERE `locale` = 'deDE' AND `entry` = 37699;
-- OLD name : RN Test Royal Guard
-- Source : https://www.wowhead.com/wotlk/de/npc=37700
UPDATE `creature_template_locale` SET `Name` = '[RN Test Royal Guard]' WHERE `locale` = 'deDE' AND `entry` = 37700;
-- OLD name : Strudelnder Wasserelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=37703
UPDATE `creature_template_locale` SET `Name` = '[Surging Water Elemental]' WHERE `locale` = 'deDE' AND `entry` = 37703;
-- OLD name : Evakuierungsportal
-- Source : https://www.wowhead.com/wotlk/de/npc=37734
UPDATE `creature_template_locale` SET `Name` = '[Evacuation Portal]' WHERE `locale` = 'deDE' AND `entry` = 37734;
-- OLD name : Zwergisches Lufttotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37749
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Air Totem]' WHERE `locale` = 'deDE' AND `entry` = 37749;
-- OLD name : Zwergisches Erdtotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37750
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Earth Totem]' WHERE `locale` = 'deDE' AND `entry` = 37750;
-- OLD name : Zwergisches Feuertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37751
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Fire Totem]' WHERE `locale` = 'deDE' AND `entry` = 37751;
-- OLD name : Zwergisches Wassertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37752
UPDATE `creature_template_locale` SET `Name` = '[Dwarf Water Totem]' WHERE `locale` = 'deDE' AND `entry` = 37752;
-- OLD name : Orcisches Lufttotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37766
UPDATE `creature_template_locale` SET `Name` = '[Orc Air Totem]' WHERE `locale` = 'deDE' AND `entry` = 37766;
-- OLD name : Orcisches Erdtotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37767
UPDATE `creature_template_locale` SET `Name` = '[Orc Earth Totem]' WHERE `locale` = 'deDE' AND `entry` = 37767;
-- OLD name : Trollisches Erdtotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37768
UPDATE `creature_template_locale` SET `Name` = '[Troll Earth Totem]' WHERE `locale` = 'deDE' AND `entry` = 37768;
-- OLD name : Trollisches Lufttotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37769
UPDATE `creature_template_locale` SET `Name` = '[Troll Air Totem]' WHERE `locale` = 'deDE' AND `entry` = 37769;
-- OLD name : Orcisches Feuertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37770
UPDATE `creature_template_locale` SET `Name` = '[Orc Fire Totem]' WHERE `locale` = 'deDE' AND `entry` = 37770;
-- OLD name : Trollisches Feuertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37771
UPDATE `creature_template_locale` SET `Name` = '[Troll Fire Totem]' WHERE `locale` = 'deDE' AND `entry` = 37771;
-- OLD name : Orcisches Wassertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37772
UPDATE `creature_template_locale` SET `Name` = '[Orc Water Totem]' WHERE `locale` = 'deDE' AND `entry` = 37772;
-- OLD name : Trollisches Wassertotem
-- Source : https://www.wowhead.com/wotlk/de/npc=37773
UPDATE `creature_template_locale` SET `Name` = '[Troll Water Totem]' WHERE `locale` = 'deDE' AND `entry` = 37773;
-- OLD name : Wache von Eisenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=37775
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Guard]' WHERE `locale` = 'deDE' AND `entry` = 37775;
-- OLD name : Schildwache von Darnassus
-- Source : https://www.wowhead.com/wotlk/de/npc=37790
UPDATE `creature_template_locale` SET `Name` = '[Darnassus Sentinel]' WHERE `locale` = 'deDE' AND `entry` = 37790;
-- OLD name : Friedensbewahrer der Exodar
-- Source : https://www.wowhead.com/wotlk/de/npc=37798
UPDATE `creature_template_locale` SET `Name` = '[Exodar Peacekeeper]' WHERE `locale` = 'deDE' AND `entry` = 37798;
-- OLD name : Stadtwache von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=37800
UPDATE `creature_template_locale` SET `Name` = '[Silvermoon City Guardian]' WHERE `locale` = 'deDE' AND `entry` = 37800;
-- OLD name : Aufseher der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=37825
UPDATE `creature_template_locale` SET `Name` = '[Kor''kron Overseer]' WHERE `locale` = 'deDE' AND `entry` = 37825;
-- OLD name : Lichträcher
-- Source : https://www.wowhead.com/wotlk/de/npc=37826
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance]' WHERE `locale` = 'deDE' AND `entry` = 37826;
-- OLD name : Light's Vengeance Vehicle Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=37827
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Vehicle Bunny]' WHERE `locale` = 'deDE' AND `entry` = 37827;
-- OLD name : Abbild von Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37828
UPDATE `creature_template_locale` SET `Name` = '[Image of Thalorien Dawnseeker]' WHERE `locale` = 'deDE' AND `entry` = 37828;
-- OLD name : Abbild von Alexstrasza, subname : Königin der Drachen
-- Source : https://www.wowhead.com/wotlk/de/npc=37829
UPDATE `creature_template_locale` SET `Name` = '[Image of Alexstrasza]',`Title` = '[Queen of the Dragons]' WHERE `locale` = 'deDE' AND `entry` = 37829;
-- OLD name : Lich King Stun Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=37832
UPDATE `creature_template_locale` SET `Name` = '[Lich King Stun Bunny]' WHERE `locale` = 'deDE' AND `entry` = 37832;
-- OLD name : Abbild von Anasterian
-- Source : https://www.wowhead.com/wotlk/de/npc=37844
UPDATE `creature_template_locale` SET `Name` = '[Image of Anasterian]' WHERE `locale` = 'deDE' AND `entry` = 37844;
-- OLD name : Abbild von Morlen Kaltfaust
-- Source : https://www.wowhead.com/wotlk/de/npc=37845
UPDATE `creature_template_locale` SET `Name` = '[Image of Morlen Coldgrip]' WHERE `locale` = 'deDE' AND `entry` = 37845;
-- OLD name : Blutkönigin Lana'thel, subname : Die San'layn
-- Source : https://www.wowhead.com/wotlk/de/npc=37846
UPDATE `creature_template_locale` SET `Name` = '[Blood-Queen Lana''thel]',`Title` = '[The San''layn]' WHERE `locale` = 'deDE' AND `entry` = 37846;
-- OLD name : Abbild von Anub'Rekhan
-- Source : https://www.wowhead.com/wotlk/de/npc=37850
UPDATE `creature_template_locale` SET `Name` = '[Anub''Rekhan Image]' WHERE `locale` = 'deDE' AND `entry` = 37850;
-- OLD name : Abbild von Noth dem Seuchenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=37851
UPDATE `creature_template_locale` SET `Name` = '[Noth the Plaguebringer Image]' WHERE `locale` = 'deDE' AND `entry` = 37851;
-- OLD name : Abbild von Instrukteur Razuvious
-- Source : https://www.wowhead.com/wotlk/de/npc=37853
UPDATE `creature_template_locale` SET `Name` = '[Instructor Razuvious Image]' WHERE `locale` = 'deDE' AND `entry` = 37853;
-- OLD name : Abbild von Malygos
-- Source : https://www.wowhead.com/wotlk/de/npc=37855
UPDATE `creature_template_locale` SET `Name` = '[Malygos Image]' WHERE `locale` = 'deDE' AND `entry` = 37855;
-- OLD name : Abbild des Flammenleviathans
-- Source : https://www.wowhead.com/wotlk/de/npc=37856
UPDATE `creature_template_locale` SET `Name` = '[Flame Leviathan Image]' WHERE `locale` = 'deDE' AND `entry` = 37856;
-- OLD name : Der Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=37857
UPDATE `creature_template_locale` SET `Name` = '[The Lich King]' WHERE `locale` = 'deDE' AND `entry` = 37857;
-- OLD name : Abbild von Klingenschuppe
-- Source : https://www.wowhead.com/wotlk/de/npc=37858
UPDATE `creature_template_locale` SET `Name` = '[Razorscale Image]' WHERE `locale` = 'deDE' AND `entry` = 37858;
-- OLD name : Abbild von Ignis, Meister des Eisenwerks
-- Source : https://www.wowhead.com/wotlk/de/npc=37859
UPDATE `creature_template_locale` SET `Name` = '[Ignis the Furnace Master Image]' WHERE `locale` = 'deDE' AND `entry` = 37859;
-- OLD name : Behüter von Donnerfels
-- Source : https://www.wowhead.com/wotlk/de/npc=37860
UPDATE `creature_template_locale` SET `Name` = '[Bluffwatcher]' WHERE `locale` = 'deDE' AND `entry` = 37860;
-- OLD name : Grunzer von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=37869
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Grunt]' WHERE `locale` = 'deDE' AND `entry` = 37869;
-- OLD name : Event Fail Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=37871
UPDATE `creature_template_locale` SET `Name` = '[Event Fail Bunny]' WHERE `locale` = 'deDE' AND `entry` = 37871;
-- OLD name : AoD Impact Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=37878
UPDATE `creature_template_locale` SET `Name` = '[AoD Impact Bunny]' WHERE `locale` = 'deDE' AND `entry` = 37878;
-- OLD name : Elender Ghul
-- Source : https://www.wowhead.com/wotlk/de/npc=37881
UPDATE `creature_template_locale` SET `Name` = '[Wretched Ghoul]' WHERE `locale` = 'deDE' AND `entry` = 37881;
-- OLD name : Der Frostthron
-- Source : https://www.wowhead.com/wotlk/de/npc=37882
UPDATE `creature_template_locale` SET `Name` = '[The Frozen Throne]' WHERE `locale` = 'deDE' AND `entry` = 37882;
-- OLD name : Bug 174037
-- Source : https://www.wowhead.com/wotlk/de/npc=37883
UPDATE `creature_template_locale` SET `Name` = '[Bug 174037]' WHERE `locale` = 'deDE' AND `entry` = 37883;
-- OLD name : Vegard der Unverziehene
-- Source : https://www.wowhead.com/wotlk/de/npc=37893
UPDATE `creature_template_locale` SET `Name` = '[Vegard the Unforgiven]' WHERE `locale` = 'deDE' AND `entry` = 37893;
-- OLD name : Vegard Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=37894
UPDATE `creature_template_locale` SET `Name` = '[Vegard Bunny]' WHERE `locale` = 'deDE' AND `entry` = 37894;
-- OLD name : Ingenieur der Himmelsbrecher
-- Source : https://www.wowhead.com/wotlk/de/npc=37898
UPDATE `creature_template_locale` SET `Name` = '[Skybreaker Engineer]' WHERE `locale` = 'deDE' AND `entry` = 37898;
-- OLD name : Rohling der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=37917
UPDATE `creature_template_locale` SET `Name` = '[Crown Thug]' WHERE `locale` = 'deDE' AND `entry` = 37917;
-- OLD name : Machterfülltes Vampirscheusal
-- Source : https://www.wowhead.com/wotlk/de/npc=37919
UPDATE `creature_template_locale` SET `Name` = '[Empowered Vampiric Fiend]' WHERE `locale` = 'deDE' AND `entry` = 37919;
-- OLD name : Belagerungsingenieur der Orgrims Hammer
-- Source : https://www.wowhead.com/wotlk/de/npc=37932
UPDATE `creature_template_locale` SET `Name` = '[Orgrim''s Hammer Siege Engineer]' WHERE `locale` = 'deDE' AND `entry` = 37932;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 37941;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 37942;
-- OLD name : Stadtpatrolleur von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=37944
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Patroller]' WHERE `locale` = 'deDE' AND `entry` = 37944;
-- OLD name : Light's Vengeance Vehicle Bunny 2
-- Source : https://www.wowhead.com/wotlk/de/npc=37952
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Vehicle Bunny 2]' WHERE `locale` = 'deDE' AND `entry` = 37952;
-- OLD name : Vegard der Unverziehene
-- Source : https://www.wowhead.com/wotlk/de/npc=37976
UPDATE `creature_template_locale` SET `Name` = '[Vegard the Unforgiven]' WHERE `locale` = 'deDE' AND `entry` = 37976;
-- OLD name : Liebesboot von Darnassus
-- Source : https://www.wowhead.com/wotlk/de/npc=37980
UPDATE `creature_template_locale` SET `Name` = '[Darnassus Love Boat]' WHERE `locale` = 'deDE' AND `entry` = 37980;
-- OLD name : Wütender Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=37982
UPDATE `creature_template_locale` SET `Name` = '[Furious Fire Elemental]' WHERE `locale` = 'deDE' AND `entry` = 37982;
-- OLD name : Sengender Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=37983
UPDATE `creature_template_locale` SET `Name` = '[Searing Fire Elemental]' WHERE `locale` = 'deDE' AND `entry` = 37983;
-- OLD name : Gauner der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=37984
UPDATE `creature_template_locale` SET `Name` = '[Crown Duster]' WHERE `locale` = 'deDE' AND `entry` = 37984;
-- OLD name : Light's Vengeance Bunny 2
-- Source : https://www.wowhead.com/wotlk/de/npc=38001
UPDATE `creature_template_locale` SET `Name` = '[Light''s Vengeance Bunny 2]' WHERE `locale` = 'deDE' AND `entry` = 38001;
-- OLD name : Gangster der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38006
UPDATE `creature_template_locale` SET `Name` = '[Crown Hoodlum]' WHERE `locale` = 'deDE' AND `entry` = 38006;
-- OLD name : Verkleidung als Mitglied der Sonnenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=38011
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Disguise (Male)]' WHERE `locale` = 'deDE' AND `entry` = 38011;
-- OLD name : Verkleidung als Mitglied der Sonnenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=38012
UPDATE `creature_template_locale` SET `Name` = '[Sunreaver Disguise (Female)]' WHERE `locale` = 'deDE' AND `entry` = 38012;
-- OLD name : Verkleidung als Mitglied des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=38013
UPDATE `creature_template_locale` SET `Name` = '[Silver Covenant Disguise (Female)]' WHERE `locale` = 'deDE' AND `entry` = 38013;
-- OLD name : Verkleidung als Mitglied des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=38014
UPDATE `creature_template_locale` SET `Name` = '[Silver Covenant Disguise (Male)]' WHERE `locale` = 'deDE' AND `entry` = 38014;
-- OLD name : Agent der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38016
UPDATE `creature_template_locale` SET `Name` = '[Crown Agent]' WHERE `locale` = 'deDE' AND `entry` = 38016;
-- OLD name : Anolis
-- Source : https://www.wowhead.com/wotlk/de/npc=38019
UPDATE `creature_template_locale` SET `Name` = '[Anolis]' WHERE `locale` = 'deDE' AND `entry` = 38019;
-- OLD name : Basiliscus
-- Source : https://www.wowhead.com/wotlk/de/npc=38020
UPDATE `creature_template_locale` SET `Name` = '[Basiliscus]' WHERE `locale` = 'deDE' AND `entry` = 38020;
-- OLD name : Conolophus
-- Source : https://www.wowhead.com/wotlk/de/npc=38021
UPDATE `creature_template_locale` SET `Name` = '[Conolophus]' WHERE `locale` = 'deDE' AND `entry` = 38021;
-- OLD name : Besprenkler der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38023
UPDATE `creature_template_locale` SET `Name` = '[Crown Sprinkler]' WHERE `locale` = 'deDE' AND `entry` = 38023;
-- OLD name : Untergebener der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38030
UPDATE `creature_template_locale` SET `Name` = '[Crown Underling]' WHERE `locale` = 'deDE' AND `entry` = 38030;
-- OLD name : Qixi Q. Pido, subname : Chemiemanufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38039
UPDATE `creature_template_locale` SET `Name` = '[Kwee Q. Peddlefeet]',`Title` = '[Crown Chemical Co.]' WHERE `locale` = 'deDE' AND `entry` = 38039;
-- OLD name : Qixi Q. Pido, subname : Chemiemanufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=38040
UPDATE `creature_template_locale` SET `Name` = '[Kwee Q. Peddlefeet]',`Title` = '[Crown Chemical Co.]' WHERE `locale` = 'deDE' AND `entry` = 38040;
-- OLD name : Junger Pilger
-- Source : https://www.wowhead.com/wotlk/de/npc=38049
UPDATE `creature_template_locale` SET `Name` = '[Young Pilgrim]' WHERE `locale` = 'deDE' AND `entry` = 38049;
-- OLD name : Grunzer von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=38050
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Grunt]' WHERE `locale` = 'deDE' AND `entry` = 38050;
-- OLD name : Abbild des Sonnenbrunnens
-- Source : https://www.wowhead.com/wotlk/de/npc=38116
UPDATE `creature_template_locale` SET `Name` = '[Image of the Sunwell]' WHERE `locale` = 'deDE' AND `entry` = 38116;
-- OLD name : Soul Feast Kill Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38121
UPDATE `creature_template_locale` SET `Name` = '[Soul Feast Kill Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38121;
-- OLD name : Gefangener Bürger
-- Source : https://www.wowhead.com/wotlk/de/npc=38162
UPDATE `creature_template_locale` SET `Name` = '[Trapped Citizen]' WHERE `locale` = 'deDE' AND `entry` = 38162;
-- OLD name : Entfesselndes Totem
-- Source : https://www.wowhead.com/wotlk/de/npc=38180
UPDATE `creature_template_locale` SET `Name` = '[Cleansing Totem]' WHERE `locale` = 'deDE' AND `entry` = 38180;
-- OLD name : Große Liebesrakete
-- Source : https://www.wowhead.com/wotlk/de/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Herzbrecher X-45' WHERE `locale` = 'deDE' AND `entry` = 38204;
-- OLD name : Große Liebesrakete
-- Source : https://www.wowhead.com/wotlk/de/npc=38207
UPDATE `creature_template_locale` SET `Name` = '[Flying Big Love Rocket]' WHERE `locale` = 'deDE' AND `entry` = 38207;
-- OLD name : Wrath of the Lich King Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=38211
UPDATE `creature_template_locale` SET `Name` = '[Wrath of the Lich King Credit]' WHERE `locale` = 'deDE' AND `entry` = 38211;
-- OLD name : Mutierter Professor Seuchenmord
-- Source : https://www.wowhead.com/wotlk/de/npc=38216
UPDATE `creature_template_locale` SET `Name` = '[Mutated Professor Putricide]' WHERE `locale` = 'deDE' AND `entry` = 38216;
-- OLD name : Unbesiegbar
-- Source : https://www.wowhead.com/wotlk/de/npc=38260
UPDATE `creature_template_locale` SET `Name` = '[Invincible]' WHERE `locale` = 'deDE' AND `entry` = 38260;
-- OLD name : Transformierter dunkler Runenriese
-- Source : https://www.wowhead.com/wotlk/de/npc=38264
UPDATE `creature_template_locale` SET `Name` = '[Dark Rune Giant Transform]' WHERE `locale` = 'deDE' AND `entry` = 38264;
-- OLD name : Illusion eines Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=38271
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Illusion]' WHERE `locale` = 'deDE' AND `entry` = 38271;
-- OLD name : Illusion eines Taunka
-- Source : https://www.wowhead.com/wotlk/de/npc=38273
UPDATE `creature_template_locale` SET `Name` = '[Taunka Illusion]' WHERE `locale` = 'deDE' AND `entry` = 38273;
-- OLD name : Unholy Infusion KC Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38289
UPDATE `creature_template_locale` SET `Name` = '[Unholy Infusion KC Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38289;
-- OLD name : Nahkampfschmuckstück - Tuskarr
-- Source : https://www.wowhead.com/wotlk/de/npc=38291
UPDATE `creature_template_locale` SET `Name` = '[Melee Trinket - Tuskarr]' WHERE `locale` = 'deDE' AND `entry` = 38291;
-- OLD name : Nahkampfschmuckstück - Taunka
-- Source : https://www.wowhead.com/wotlk/de/npc=38292
UPDATE `creature_template_locale` SET `Name` = '[Melee Trinket - Taunka]' WHERE `locale` = 'deDE' AND `entry` = 38292;
-- OLD name : Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00)
-- Source : https://www.wowhead.com/wotlk/de/npc=38310
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00)]' WHERE `locale` = 'deDE' AND `entry` = 38310;
-- OLD name : Kugel der Blutkönigin
-- Source : https://www.wowhead.com/wotlk/de/npc=38353
UPDATE `creature_template_locale` SET `Name` = '[Blood Queen Orb]' WHERE `locale` = 'deDE' AND `entry` = 38353;
-- OLD name : Teslaspule
-- Source : https://www.wowhead.com/wotlk/de/npc=38367
UPDATE `creature_template_locale` SET `Name` = '[Tesla Coil Stalker]' WHERE `locale` = 'deDE' AND `entry` = 38367;
-- OLD name : Flickwerk (PTR Rundum-Test)
-- Source : https://www.wowhead.com/wotlk/de/npc=38386
UPDATE `creature_template_locale` SET `Name` = '[Patchwerk (PTR All-Around Test)]' WHERE `locale` = 'deDE' AND `entry` = 38386;
-- OLD name : Darnavan
-- Source : https://www.wowhead.com/wotlk/de/npc=38472
UPDATE `creature_template_locale` SET `Name` = '[Darnavan]' WHERE `locale` = 'deDE' AND `entry` = 38472;
-- OLD name : Argentumkreuzfahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=38497
UPDATE `creature_template_locale` SET `Name` = '[Argent Crusader (Mounted)]' WHERE `locale` = 'deDE' AND `entry` = 38497;
-- OLD name : Blood Infusion Quest Credit Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38503
UPDATE `creature_template_locale` SET `Name` = '[Blood Infusion Quest Credit Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38503;
-- OLD name : Shadowmourne Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38527
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38527;
-- OLD name : Shadowmourne Axe Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38528
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne Axe Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38528;
-- OLD name : Schattengram
-- Source : https://www.wowhead.com/wotlk/de/npc=38529
UPDATE `creature_template_locale` SET `Name` = '[Shadowmourne]' WHERE `locale` = 'deDE' AND `entry` = 38529;
-- OLD name : Frost Infusion Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=38546
UPDATE `creature_template_locale` SET `Name` = '[Frost Infusion Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 38546;
-- OLD name : Sindragosa Quest Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=38547
UPDATE `creature_template_locale` SET `Name` = '[Sindragosa Quest Credit]' WHERE `locale` = 'deDE' AND `entry` = 38547;
-- OLD name : Phantomhafte Halluzination
-- Source : https://www.wowhead.com/wotlk/de/npc=38566
UPDATE `creature_template_locale` SET `Name` = '[Phantom Hallucination]' WHERE `locale` = 'deDE' AND `entry` = 38566;
-- OLD name : Bug 181860
-- Source : https://www.wowhead.com/wotlk/de/npc=38572
UPDATE `creature_template_locale` SET `Name` = '[Bug 181860]' WHERE `locale` = 'deDE' AND `entry` = 38572;
-- OLD name : Professor Seuchenmord Proxy Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38587
UPDATE `creature_template_locale` SET `Name` = '[Professor Putricide Proxy Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38587;
-- OLD name : Blood Queen Proxy Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=38588
UPDATE `creature_template_locale` SET `Name` = '[Blood Queen Proxy Bunny]' WHERE `locale` = 'deDE' AND `entry` = 38588;
-- OLD name : Argentumreckenverdienst (Streitertest), subname : A.L.K.
-- Source : https://www.wowhead.com/wotlk/de/npc=38595
UPDATE `creature_template_locale` SET `Name` = '[Argent Valiant Credit (Aspirant Test)]',`Title` = '[S.T.O.U.T.]' WHERE `locale` = 'deDE' AND `entry` = 38595;
-- OLD name : Fürstin Sylvanas Windläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=38609
UPDATE `creature_template_locale` SET `Name` = 'Lady Sylvanas Windläufer' WHERE `locale` = 'deDE' AND `entry` = 38609;
-- OLD name : Hochlord Alexandros Mograine, subname : Der Aschenbringer
-- Source : https://www.wowhead.com/wotlk/de/npc=38610
UPDATE `creature_template_locale` SET `Name` = '[Highlord Alexandros Mograine]',`Title` = '[The Ashbringer]' WHERE `locale` = 'deDE' AND `entry` = 38610;
-- OLD name : Frostmourne Soul Transform Visual
-- Source : https://www.wowhead.com/wotlk/de/npc=38710
UPDATE `creature_template_locale` SET `Name` = '[Frostmourne Soul Transform Visual]' WHERE `locale` = 'deDE' AND `entry` = 38710;
-- OLD name : Magister Thelos
-- Source : https://www.wowhead.com/wotlk/de/npc=38716
UPDATE `creature_template_locale` SET `Name` = '[Magister Thelos]' WHERE `locale` = 'deDE' AND `entry` = 38716;
-- OLD name : Aerin
-- Source : https://www.wowhead.com/wotlk/de/npc=38825
UPDATE `creature_template_locale` SET `Name` = '[Aerin]' WHERE `locale` = 'deDE' AND `entry` = 38825;
-- OLD name : Erschlagener Behüter von Donnerfels
-- Source : https://www.wowhead.com/wotlk/de/npc=38831
UPDATE `creature_template_locale` SET `Name` = '[Slain Bluffwatcher]' WHERE `locale` = 'deDE' AND `entry` = 38831;
-- OLD name : Wache der Dunkeleisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=38839
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Guard]' WHERE `locale` = 'deDE' AND `entry` = 38839;
-- OLD name : PattyMacks Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=38857
UPDATE `creature_template_locale` SET `Name` = '[PattyMacks LK]' WHERE `locale` = 'deDE' AND `entry` = 38857;
-- OLD subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 38858;
-- OLD name : Bug 184688
-- Source : https://www.wowhead.com/wotlk/de/npc=38860
UPDATE `creature_template_locale` SET `Name` = '[Bug 184688  ]' WHERE `locale` = 'deDE' AND `entry` = 38860;
-- OLD name : Unkillable Test Dummy 83 Rogue
-- Source : https://www.wowhead.com/wotlk/de/npc=38863
UPDATE `creature_template_locale` SET `Name` = '[Unkillable Test Dummy 83 Rogue]' WHERE `locale` = 'deDE' AND `entry` = 38863;
-- OLD name : Bürger der Dunkeleisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=38877
UPDATE `creature_template_locale` SET `Name` = '[Dark Iron Citizen]' WHERE `locale` = 'deDE' AND `entry` = 38877;
-- OLD name : ScottG Test
-- Source : https://www.wowhead.com/wotlk/de/npc=38883
UPDATE `creature_template_locale` SET `Name` = '[ScottG Test]' WHERE `locale` = 'deDE' AND `entry` = 38883;
-- OLD name : Auktionator Kavarn
-- Source : https://www.wowhead.com/wotlk/de/npc=38900
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Kavarn]' WHERE `locale` = 'deDE' AND `entry` = 38900;
-- OLD name : Zivilist aus Eisenschmiede
-- Source : https://www.wowhead.com/wotlk/de/npc=38901
UPDATE `creature_template_locale` SET `Name` = '[Ironforge Civilian]' WHERE `locale` = 'deDE' AND `entry` = 38901;
-- OLD name : Queue trigger
-- Source : https://www.wowhead.com/wotlk/de/npc=38903
UPDATE `creature_template_locale` SET `Name` = '[Queue trigger]' WHERE `locale` = 'deDE' AND `entry` = 38903;
-- OLD name : Auktionator Sarnkin
-- Source : https://www.wowhead.com/wotlk/de/npc=38906
UPDATE `creature_template_locale` SET `Name` = '[Auctioneer Sarnkin]' WHERE `locale` = 'deDE' AND `entry` = 38906;
-- OLD name : Queue Controller
-- Source : https://www.wowhead.com/wotlk/de/npc=38907
UPDATE `creature_template_locale` SET `Name` = '[Queue Controller]' WHERE `locale` = 'deDE' AND `entry` = 38907;
-- OLD name : Aufgebrachter Erdgeist
-- Source : https://www.wowhead.com/wotlk/de/npc=39021
UPDATE `creature_template_locale` SET `Name` = '[Agitated Earth Spirit]' WHERE `locale` = 'deDE' AND `entry` = 39021;
-- OLD name : Azurblaues Todesstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=39045
UPDATE `creature_template_locale` SET `Name` = '[Azure Deathcharger]' WHERE `locale` = 'deDE' AND `entry` = 39045;
-- OLD name : Aufgebrachter Feuergeist
-- Source : https://www.wowhead.com/wotlk/de/npc=39047
UPDATE `creature_template_locale` SET `Name` = '[Agitated Fire Spirit]' WHERE `locale` = 'deDE' AND `entry` = 39047;
-- OLD name : Gavan Graufeder
-- Source : https://www.wowhead.com/wotlk/de/npc=39055
UPDATE `creature_template_locale` SET `Name` = '[Gavan Grayfeather]' WHERE `locale` = 'deDE' AND `entry` = 39055;
-- OLD name : Brann Bronzebart
-- Source : https://www.wowhead.com/wotlk/de/npc=39060
UPDATE `creature_template_locale` SET `Name` = '[Brann Bronzebeard (Prologue)]' WHERE `locale` = 'deDE' AND `entry` = 39060;
-- OLD name : Gegenstand: Illusion der Frosterben
-- Source : https://www.wowhead.com/wotlk/de/npc=39089
UPDATE `creature_template_locale` SET `Name` = '[Item: Frostborn Illusion]' WHERE `locale` = 'deDE' AND `entry` = 39089;
-- OLD name : Durak Flammensprecher, subname : Der Irdene Ring
-- Source : https://www.wowhead.com/wotlk/de/npc=39090
UPDATE `creature_template_locale` SET `Name` = '[Durak Flamespeaker]',`Title` = '[The Earthen Ring]' WHERE `locale` = 'deDE' AND `entry` = 39090;
-- OLD name : Darnavan Kill Credit 10
-- Source : https://www.wowhead.com/wotlk/de/npc=39091
UPDATE `creature_template_locale` SET `Name` = '[Darnavan Kill Credit 10]' WHERE `locale` = 'deDE' AND `entry` = 39091;
-- OLD name : Darnavan Kill Credit 25
-- Source : https://www.wowhead.com/wotlk/de/npc=39092
UPDATE `creature_template_locale` SET `Name` = '[Darnavan Kill Credit 25]' WHERE `locale` = 'deDE' AND `entry` = 39092;
-- OLD name : Kurier Tormun, subname : Forscherliga
-- Source : https://www.wowhead.com/wotlk/de/npc=39101
UPDATE `creature_template_locale` SET `Name` = '[Courier Tormun]',`Title` = '[Explorer''s League]' WHERE `locale` = 'deDE' AND `entry` = 39101;
-- OLD name : Zwielichtsucher, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=39103
UPDATE `creature_template_locale` SET `Name` = '[Twilight Seeker]',`Title` = '[Twilight''s Hammer]' WHERE `locale` = 'deDE' AND `entry` = 39103;
-- OLD name : Blood Quickening Credit 25
-- Source : https://www.wowhead.com/wotlk/de/npc=39123
UPDATE `creature_template_locale` SET `Name` = '[Blood Quickening Credit 25]' WHERE `locale` = 'deDE' AND `entry` = 39123;
-- OLD name : Schattenwächterin der Val'kyr
-- Source : https://www.wowhead.com/wotlk/de/npc=39125
UPDATE `creature_template_locale` SET `Name` = '[Val''kyr Shadowguard (Hover Height 20 Visual)]' WHERE `locale` = 'deDE' AND `entry` = 39125;
-- OLD name : Flammender Diener
-- Source : https://www.wowhead.com/wotlk/de/npc=39130
UPDATE `creature_template_locale` SET `Name` = '[Blazing Servant]' WHERE `locale` = 'deDE' AND `entry` = 39130;
-- OLD name : Wässriger Diener
-- Source : https://www.wowhead.com/wotlk/de/npc=39131
UPDATE `creature_template_locale` SET `Name` = '[Watery Servant]' WHERE `locale` = 'deDE' AND `entry` = 39131;
-- OLD name : Irdener Diener
-- Source : https://www.wowhead.com/wotlk/de/npc=39132
UPDATE `creature_template_locale` SET `Name` = '[Earthen Servant]' WHERE `locale` = 'deDE' AND `entry` = 39132;
-- OLD name : Prologue Portal Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=39135
UPDATE `creature_template_locale` SET `Name` = '[Prologue Portal Bunny]' WHERE `locale` = 'deDE' AND `entry` = 39135;
-- OLD name : Phalanx 2.0
-- Source : https://www.wowhead.com/wotlk/de/npc=39158
UPDATE `creature_template_locale` SET `Name` = '[Phalanx 2.0]' WHERE `locale` = 'deDE' AND `entry` = 39158;
-- OLD name : Marschall Magruder
-- Source : https://www.wowhead.com/wotlk/de/npc=39172
UPDATE `creature_template_locale` SET `Name` = 'Marshall Magruder' WHERE `locale` = 'deDE' AND `entry` = 39172;
-- OLD name : Mechanopanzerpilot aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39230
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank Pilot]' WHERE `locale` = 'deDE' AND `entry` = 39230;
-- OLD name : Der Lichkönig
-- Source : https://www.wowhead.com/wotlk/de/npc=39231
UPDATE `creature_template_locale` SET `Name` = '[The Lich King (Temp)]' WHERE `locale` = 'deDE' AND `entry` = 39231;
-- OLD name : Infanterist aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39252
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Infantry]' WHERE `locale` = 'deDE' AND `entry` = 39252;
-- OLD name : Gnomenbürgerin
-- Source : https://www.wowhead.com/wotlk/de/npc=39253
UPDATE `creature_template_locale` SET `Name` = '[Gnome Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39253;
-- OLD name : Flugmaschine aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39259
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Flying Machine]' WHERE `locale` = 'deDE' AND `entry` = 39259;
-- OLD name : Zerlegter Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39263
UPDATE `creature_template_locale` SET `Name` = '[Disassembled Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39263;
-- OLD name : Mechanopanzerpilot von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39264
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank Pilot]' WHERE `locale` = 'deDE' AND `entry` = 39264;
-- OLD name : Geretterter Flüchtling aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39265
UPDATE `creature_template_locale` SET `Name` = '[Rescued Gnomeregan Evacuee]' WHERE `locale` = 'deDE' AND `entry` = 39265;
-- OLD name : Hochtüftler Mekkadrill, subname : König der Gnome
-- Source : https://www.wowhead.com/wotlk/de/npc=39271
UPDATE `creature_template_locale` SET `Name` = '[High Tinker Mekkatorque]',`Title` = '[King of Gnomes]' WHERE `locale` = 'deDE' AND `entry` = 39271;
-- OLD name : "Doc" Raddreh, subname : Generalärztin
-- Source : https://www.wowhead.com/wotlk/de/npc=39273
UPDATE `creature_template_locale` SET `Name` = '["Doc" Cogspin]',`Title` = '[Surgeon General]' WHERE `locale` = 'deDE' AND `entry` = 39273;
-- OLD name : Sanitäter aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39275
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Medic]' WHERE `locale` = 'deDE' AND `entry` = 39275;
-- OLD name : Erdheilerin Norsala, subname : Der Irdene Ring
-- Source : https://www.wowhead.com/wotlk/de/npc=39283
UPDATE `creature_template_locale` SET `Name` = '[Seer Bahura]',`Title` = '[The Earthen Ring]' WHERE `locale` = 'deDE' AND `entry` = 39283;
-- OLD name : Weltuntergangsverkünder
-- Source : https://www.wowhead.com/wotlk/de/npc=39328
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer]' WHERE `locale` = 'deDE' AND `entry` = 39328;
-- OLD name : Bürger von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=39343
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39343;
-- OLD name : Lehrling aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39349
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Trainee]' WHERE `locale` = 'deDE' AND `entry` = 39349;
-- OLD name : Ausbildungsoffizier Dampfkurbel
-- Source : https://www.wowhead.com/wotlk/de/npc=39368
UPDATE `creature_template_locale` SET `Name` = '[Drill Sergeant Steamcrank]' WHERE `locale` = 'deDE' AND `entry` = 39368;
-- OLD name : Pilot Sprossmündung
-- Source : https://www.wowhead.com/wotlk/de/npc=39386
UPDATE `creature_template_locale` SET `Name` = '[Pilot Muzzlesprock]' WHERE `locale` = 'deDE' AND `entry` = 39386;
-- OLD name : 'Donnerschlag'
-- Source : https://www.wowhead.com/wotlk/de/npc=39396
UPDATE `creature_template_locale` SET `Name` = '[''Thunderflash'']' WHERE `locale` = 'deDE' AND `entry` = 39396;
-- OLD name : Radiageigatron
-- Source : https://www.wowhead.com/wotlk/de/npc=39421
UPDATE `creature_template_locale` SET `Name` = '[Radiageigatron]' WHERE `locale` = 'deDE' AND `entry` = 39421;
-- OLD name : Blutwache Torek
-- Source : https://www.wowhead.com/wotlk/de/npc=39448
UPDATE `creature_template_locale` SET `Name` = '[Blood Guard Torek]' WHERE `locale` = 'deDE' AND `entry` = 39448;
-- OLD name : Doomsayer Speech Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39454
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer Speech Credit]' WHERE `locale` = 'deDE' AND `entry` = 39454;
-- OLD name : Owen Testverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=39462
UPDATE `creature_template_locale` SET `Name` = '[Owen Test Vendor]' WHERE `locale` = 'deDE' AND `entry` = 39462;
-- OLD name : Motivierter Bürger
-- Source : https://www.wowhead.com/wotlk/de/npc=39466
UPDATE `creature_template_locale` SET `Name` = '[Motivated Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39466;
-- OLD name : Hauptmann Anton
-- Source : https://www.wowhead.com/wotlk/de/npc=39508
UPDATE `creature_template_locale` SET `Name` = '[Captain Anton]' WHERE `locale` = 'deDE' AND `entry` = 39508;
-- OLD name : Poster Marker - Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=39581
UPDATE `creature_template_locale` SET `Name` = '[Poster Marker - Orgrimmar ]' WHERE `locale` = 'deDE' AND `entry` = 39581;
-- OLD name : Gnomenbürger
-- Source : https://www.wowhead.com/wotlk/de/npc=39623
UPDATE `creature_template_locale` SET `Name` = '[Gnome Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39623;
-- OLD name : Motivierte Bürgerin
-- Source : https://www.wowhead.com/wotlk/de/npc=39624
UPDATE `creature_template_locale` SET `Name` = '[Motivated Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39624;
-- OLD name : Bürger von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=39632
UPDATE `creature_template_locale` SET `Name` = '[Orgrimmar Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39632;
-- OLD name : Behüter von Sen'jin
-- Source : https://www.wowhead.com/wotlk/de/npc=39633
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Watcher]' WHERE `locale` = 'deDE' AND `entry` = 39633;
-- OLD name : Ruheloser Zombie
-- Source : https://www.wowhead.com/wotlk/de/npc=39639
UPDATE `creature_template_locale` SET `Name` = '[Restless Zombie]' WHERE `locale` = 'deDE' AND `entry` = 39639;
-- OLD name : Zalazane
-- Source : https://www.wowhead.com/wotlk/de/npc=39647
UPDATE `creature_template_locale` SET `Name` = '[Zalazane]' WHERE `locale` = 'deDE' AND `entry` = 39647;
-- OLD name : Weltuntergangskultist
-- Source : https://www.wowhead.com/wotlk/de/npc=39648
UPDATE `creature_template_locale` SET `Name` = '[Doomsday Cultist]' WHERE `locale` = 'deDE' AND `entry` = 39648;
-- OLD name : Vol'jin
-- Source : https://www.wowhead.com/wotlk/de/npc=39654
UPDATE `creature_template_locale` SET `Name` = '[Vol''jin]' WHERE `locale` = 'deDE' AND `entry` = 39654;
-- OLD name : Poster Marker - Stormwind
-- Source : https://www.wowhead.com/wotlk/de/npc=39672
UPDATE `creature_template_locale` SET `Name` = '[Poster Marker - Stormwind]' WHERE `locale` = 'deDE' AND `entry` = 39672;
-- OLD name : Hauptmann Tret Funkdüse
-- Source : https://www.wowhead.com/wotlk/de/npc=39675
UPDATE `creature_template_locale` SET `Name` = '[Captain Tread Sparknozzle]' WHERE `locale` = 'deDE' AND `entry` = 39675;
-- OLD name : Toby Zeigrad, subname : Redenschreiber
-- Source : https://www.wowhead.com/wotlk/de/npc=39678
UPDATE `creature_template_locale` SET `Name` = '[Toby Zeigear]',`Title` = '[Speechwriter]' WHERE `locale` = 'deDE' AND `entry` = 39678;
-- OLD name : Mechanopanzer mit Schleudersitzsystem
-- Source : https://www.wowhead.com/wotlk/de/npc=39682
UPDATE `creature_template_locale` SET `Name` = '[Ejector Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39682;
-- OLD name : Bürger von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=39686
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39686;
-- OLD name : Mechanopanzerangriffsziel
-- Source : https://www.wowhead.com/wotlk/de/npc=39711
UPDATE `creature_template_locale` SET `Name` = '[Mechano-Tank Attack Target]' WHERE `locale` = 'deDE' AND `entry` = 39711;
-- OLD name : Hochtüftler Mekkadrill, subname : König der Gnome
-- Source : https://www.wowhead.com/wotlk/de/npc=39712
UPDATE `creature_template_locale` SET `Name` = '[High Tinker Mekkatorque]',`Title` = '[King of Gnomes]' WHERE `locale` = 'deDE' AND `entry` = 39712;
-- OLD name : Krabbelnder Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39713
UPDATE `creature_template_locale` SET `Name` = '[Scuttling Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39713;
-- OLD name : Schießender Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39714
UPDATE `creature_template_locale` SET `Name` = '[Shooting Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39714;
-- OLD name : Mechanopanzer mit Schleudersitzsystem
-- Source : https://www.wowhead.com/wotlk/de/npc=39715
UPDATE `creature_template_locale` SET `Name` = '[Ejector Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39715;
-- OLD name : Krabbelnder Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39716
UPDATE `creature_template_locale` SET `Name` = '[Scuttling Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39716;
-- OLD name : Schießender Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39717
UPDATE `creature_template_locale` SET `Name` = '[Shooting Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39717;
-- OLD name : Multibomber von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39735
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Multi-Bomber]' WHERE `locale` = 'deDE' AND `entry` = 39735;
-- OLD name : Bestrahlter Infanterist
-- Source : https://www.wowhead.com/wotlk/de/npc=39755
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Infantry]' WHERE `locale` = 'deDE' AND `entry` = 39755;
-- OLD name : Kultist Kagarn
-- Source : https://www.wowhead.com/wotlk/de/npc=39757
UPDATE `creature_template_locale` SET `Name` = '[Cultist Kagarn]' WHERE `locale` = 'deDE' AND `entry` = 39757;
-- OLD name : Kultist Agtar
-- Source : https://www.wowhead.com/wotlk/de/npc=39758
UPDATE `creature_template_locale` SET `Name` = '[Cultist Agtar]' WHERE `locale` = 'deDE' AND `entry` = 39758;
-- OLD name : Panzerbrecherkanone
-- Source : https://www.wowhead.com/wotlk/de/npc=39759
UPDATE `creature_template_locale` SET `Name` = '[Tankbuster Cannon]' WHERE `locale` = 'deDE' AND `entry` = 39759;
-- OLD name : Kultistin Tokka
-- Source : https://www.wowhead.com/wotlk/de/npc=39760
UPDATE `creature_template_locale` SET `Name` = '[Cultist Tokka]' WHERE `locale` = 'deDE' AND `entry` = 39760;
-- OLD name : Kultistin Rokaga
-- Source : https://www.wowhead.com/wotlk/de/npc=39763
UPDATE `creature_template_locale` SET `Name` = '[Cultist Rokaga]' WHERE `locale` = 'deDE' AND `entry` = 39763;
-- OLD name : Gasherikk
-- Source : https://www.wowhead.com/wotlk/de/npc=39799
UPDATE `creature_template_locale` SET `Name` = '[Gasherikk]' WHERE `locale` = 'deDE' AND `entry` = 39799;
-- OLD name : Abbild von Cho'gall, subname : Anführer des Schattenhammers
-- Source : https://www.wowhead.com/wotlk/de/npc=39807
UPDATE `creature_template_locale` SET `Name` = '[Image of Cho''Gall]',`Title` = '[Leader of Twilight''s Hammer]' WHERE `locale` = 'deDE' AND `entry` = 39807;
-- OLD name : Bestrahlter Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39818
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39818;
-- OLD name : Bestrahlter Mechanopanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=39819
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39819;
-- OLD name : Raketenwerfer
-- Source : https://www.wowhead.com/wotlk/de/npc=39820
UPDATE `creature_template_locale` SET `Name` = '[Rocket Launcher]' WHERE `locale` = 'deDE' AND `entry` = 39820;
-- OLD name : Cho'Gall Speech Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39821
UPDATE `creature_template_locale` SET `Name` = '[Cho''Gall Speech Credit]' WHERE `locale` = 'deDE' AND `entry` = 39821;
-- OLD name : Aufseher Golbaz
-- Source : https://www.wowhead.com/wotlk/de/npc=39825
UPDATE `creature_template_locale` SET `Name` = '[Overseer Golbaz]' WHERE `locale` = 'deDE' AND `entry` = 39825;
-- OLD name : Bestrahlter Trogg
-- Source : https://www.wowhead.com/wotlk/de/npc=39826
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Trogg]' WHERE `locale` = 'deDE' AND `entry` = 39826;
-- OLD name : Aufseherin Jintak
-- Source : https://www.wowhead.com/wotlk/de/npc=39827
UPDATE `creature_template_locale` SET `Name` = '[Overseer Jintak]' WHERE `locale` = 'deDE' AND `entry` = 39827;
-- OLD name : Bestrahlte Kavallerie
-- Source : https://www.wowhead.com/wotlk/de/npc=39836
UPDATE `creature_template_locale` SET `Name` = '[Irradiated Cavalry]' WHERE `locale` = 'deDE' AND `entry` = 39836;
-- OLD name : Kommandant Bolzrad
-- Source : https://www.wowhead.com/wotlk/de/npc=39837
UPDATE `creature_template_locale` SET `Name` = '[Commander Boltcog]' WHERE `locale` = 'deDE' AND `entry` = 39837;
-- OLD name : Invisible Stalker (Hostile, Ignore Combat, Float, Uninteractible, Large AOI)
-- Source : https://www.wowhead.com/wotlk/de/npc=39842
UPDATE `creature_template_locale` SET `Name` = '[Invisible Stalker (Hostile, Ignore Combat, Float, Uninteractible, Large AOI)]' WHERE `locale` = 'deDE' AND `entry` = 39842;
-- OLD name : Tobender Feuerelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=39852
UPDATE `creature_template_locale` SET `Name` = '[Raging Fire Elemental]' WHERE `locale` = 'deDE' AND `entry` = 39852;
-- OLD name : Tobender Sturmelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=39856
UPDATE `creature_template_locale` SET `Name` = '[Raging Storm Elemental]' WHERE `locale` = 'deDE' AND `entry` = 39856;
-- OLD name : Mechanopanzer aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39860
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 39860;
-- OLD name : Besorgter Bürger
-- Source : https://www.wowhead.com/wotlk/de/npc=39861
UPDATE `creature_template_locale` SET `Name` = '[Worried Citizen]' WHERE `locale` = 'deDE' AND `entry` = 39861;
-- OLD name : Cult Recruitment Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39872
UPDATE `creature_template_locale` SET `Name` = '[Cult Recruitment Credit]' WHERE `locale` = 'deDE' AND `entry` = 39872;
-- OLD name : Sanitäter aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39888
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Medic]' WHERE `locale` = 'deDE' AND `entry` = 39888;
-- OLD name : Weltuntergangskultist
-- Source : https://www.wowhead.com/wotlk/de/npc=39891
UPDATE `creature_template_locale` SET `Name` = '[Doomsday Cultist]' WHERE `locale` = 'deDE' AND `entry` = 39891;
-- OLD name : Robogenieur Thermadrahts Prahlomat
-- Source : https://www.wowhead.com/wotlk/de/npc=39901
UPDATE `creature_template_locale` SET `Name` = '[Mekgineer Thermaplugg''s Brag-Bot]' WHERE `locale` = 'deDE' AND `entry` = 39901;
-- OLD name : Kampfanzug aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=39902
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Battle Suit]' WHERE `locale` = 'deDE' AND `entry` = 39902;
-- OLD name : Verstrahler 3000
-- Source : https://www.wowhead.com/wotlk/de/npc=39903
UPDATE `creature_template_locale` SET `Name` = '[Irradiator 3000]' WHERE `locale` = 'deDE' AND `entry` = 39903;
-- OLD name : Hinkels Schnellknall
-- Source : https://www.wowhead.com/wotlk/de/npc=39910
UPDATE `creature_template_locale` SET `Name` = '[Hinkles Fastblast]' WHERE `locale` = 'deDE' AND `entry` = 39910;
-- OLD name : Zeppelinwache
-- Source : https://www.wowhead.com/wotlk/de/npc=39934
UPDATE `creature_template_locale` SET `Name` = '[Zeppelin Sentry]' WHERE `locale` = 'deDE' AND `entry` = 39934;
-- OLD name : Reittier des Zwielichtsuchers
-- Source : https://www.wowhead.com/wotlk/de/npc=39938
UPDATE `creature_template_locale` SET `Name` = '[Twilight Seeker''s Mount]' WHERE `locale` = 'deDE' AND `entry` = 39938;
-- OLD name : Todessucher, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=39940
UPDATE `creature_template_locale` SET `Name` = '[Dead Seeker]',`Title` = '[Twilight''s Hammer]' WHERE `locale` = 'deDE' AND `entry` = 39940;
-- OLD name : Kultistin Lethelyn
-- Source : https://www.wowhead.com/wotlk/de/npc=39967
UPDATE `creature_template_locale` SET `Name` = '[Cultist Lethelyn]' WHERE `locale` = 'deDE' AND `entry` = 39967;
-- OLD name : Kultistin Kaima
-- Source : https://www.wowhead.com/wotlk/de/npc=39968
UPDATE `creature_template_locale` SET `Name` = '[Cultist Kaima]' WHERE `locale` = 'deDE' AND `entry` = 39968;
-- OLD name : Kultist Wyman
-- Source : https://www.wowhead.com/wotlk/de/npc=39969
UPDATE `creature_template_locale` SET `Name` = '[Cultist Wyman]' WHERE `locale` = 'deDE' AND `entry` = 39969;
-- OLD name : Kultist Orlunn
-- Source : https://www.wowhead.com/wotlk/de/npc=39970
UPDATE `creature_template_locale` SET `Name` = '[Cultist Orlunn]' WHERE `locale` = 'deDE' AND `entry` = 39970;
-- OLD name : Schneller orangefarbener Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=39973
UPDATE `creature_template_locale` SET `Name` = '[Swift Orange Mechanostrider]' WHERE `locale` = 'deDE' AND `entry` = 39973;
-- OLD name : East Zeppelin Tower Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39975
UPDATE `creature_template_locale` SET `Name` = '[East Zeppelin Tower Credit]' WHERE `locale` = 'deDE' AND `entry` = 39975;
-- OLD name : West Zeppelin Tower Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39976
UPDATE `creature_template_locale` SET `Name` = '[West Zeppelin Tower Credit]' WHERE `locale` = 'deDE' AND `entry` = 39976;
-- OLD name : Razor Hill Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=39977
UPDATE `creature_template_locale` SET `Name` = '[Razor Hill Credit]' WHERE `locale` = 'deDE' AND `entry` = 39977;
-- OLD name : Duraks Schild
-- Source : https://www.wowhead.com/wotlk/de/npc=40006
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield]' WHERE `locale` = 'deDE' AND `entry` = 40006;
-- OLD name : Mechanoanzug aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=40010
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Suit]' WHERE `locale` = 'deDE' AND `entry` = 40010;
-- OLD name : Duraks Schild
-- Source : https://www.wowhead.com/wotlk/de/npc=40037
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 2)]' WHERE `locale` = 'deDE' AND `entry` = 40037;
-- OLD name : Duraks Schild
-- Source : https://www.wowhead.com/wotlk/de/npc=40038
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 3)]' WHERE `locale` = 'deDE' AND `entry` = 40038;
-- OLD name : Duraks Schild
-- Source : https://www.wowhead.com/wotlk/de/npc=40039
UPDATE `creature_template_locale` SET `Name` = '[Durak''s Shield (stage 4)]' WHERE `locale` = 'deDE' AND `entry` = 40039;
-- OLD name : Mekkadrills Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=40057
UPDATE `creature_template_locale` SET `Name` = '[Mekkatorque''s Swift Blue Mechanostrider]' WHERE `locale` = 'deDE' AND `entry` = 40057;
-- OLD name : Aufseher Talathor
-- Source : https://www.wowhead.com/wotlk/de/npc=40097
UPDATE `creature_template_locale` SET `Name` = '[Overseer Talathor]' WHERE `locale` = 'deDE' AND `entry` = 40097;
-- OLD name : Aufseherin Sylandra
-- Source : https://www.wowhead.com/wotlk/de/npc=40098
UPDATE `creature_template_locale` SET `Name` = '[Overseer Sylandra]' WHERE `locale` = 'deDE' AND `entry` = 40098;
-- OLD name : Valley of Heroes Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40101
UPDATE `creature_template_locale` SET `Name` = '[Valley of Heroes Credit]' WHERE `locale` = 'deDE' AND `entry` = 40101;
-- OLD name : Westbrook Garrison Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40102
UPDATE `creature_template_locale` SET `Name` = '[Westbrook Garrison Credit]' WHERE `locale` = 'deDE' AND `entry` = 40102;
-- OLD name : Goldshire Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40103
UPDATE `creature_template_locale` SET `Name` = '[Goldshire Credit]' WHERE `locale` = 'deDE' AND `entry` = 40103;
-- OLD name : Tobender Windelementar
-- Source : https://www.wowhead.com/wotlk/de/npc=40104
UPDATE `creature_template_locale` SET `Name` = '[Raging Wind Elemental]' WHERE `locale` = 'deDE' AND `entry` = 40104;
-- OLD name : Besorgter Bürger
-- Source : https://www.wowhead.com/wotlk/de/npc=40110
UPDATE `creature_template_locale` SET `Name` = '[Worried Citizen]' WHERE `locale` = 'deDE' AND `entry` = 40110;
-- OLD name : Mechanopanzer aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=40120
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 40120;
-- OLD name : Infanterist aus Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=40122
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Infantry]' WHERE `locale` = 'deDE' AND `entry` = 40122;
-- OLD name : Weltuntergangsverkünder
-- Source : https://www.wowhead.com/wotlk/de/npc=40124
UPDATE `creature_template_locale` SET `Name` = '[Doomsayer]' WHERE `locale` = 'deDE' AND `entry` = 40124;
-- OLD name : Bürger von Sturmwind
-- Source : https://www.wowhead.com/wotlk/de/npc=40125
UPDATE `creature_template_locale` SET `Name` = '[Stormwind Citizen]' WHERE `locale` = 'deDE' AND `entry` = 40125;
-- OLD name : Stadtwache von Sturmwind (Leichnam)
-- Source : https://www.wowhead.com/wotlk/de/npc=40138
UPDATE `creature_template_locale` SET `Name` = '[Stormwind City Guard (Corpse)]' WHERE `locale` = 'deDE' AND `entry` = 40138;
-- OLD name : Tormuns Schild
-- Source : https://www.wowhead.com/wotlk/de/npc=40141
UPDATE `creature_template_locale` SET `Name` = '[Tormun''s Shield]' WHERE `locale` = 'deDE' AND `entry` = 40141;
-- OLD name : Flammender Hippogryph
-- Source : https://www.wowhead.com/wotlk/de/npc=40165
UPDATE `creature_template_locale` SET `Name` = '[Blazing Hippogryph]' WHERE `locale` = 'deDE' AND `entry` = 40165;
-- OLD name : Mechanopanzer von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=40175
UPDATE `creature_template_locale` SET `Name` = '[Gnomeregan Mechano-Tank]' WHERE `locale` = 'deDE' AND `entry` = 40175;
-- OLD name : Frosch aus Sen'jin
-- Source : https://www.wowhead.com/wotlk/de/npc=40176
UPDATE `creature_template_locale` SET `Name` = '[Sen''jin Frog]' WHERE `locale` = 'deDE' AND `entry` = 40176;
-- OLD name : Bwonsamdi
-- Source : https://www.wowhead.com/wotlk/de/npc=40182
UPDATE `creature_template_locale` SET `Name` = '[Bwonsamdi]' WHERE `locale` = 'deDE' AND `entry` = 40182;
-- OLD name : Vanira
-- Source : https://www.wowhead.com/wotlk/de/npc=40184
UPDATE `creature_template_locale` SET `Name` = '[Vanira]' WHERE `locale` = 'deDE' AND `entry` = 40184;
-- OLD name : Vaniras Totem des Wachens
-- Source : https://www.wowhead.com/wotlk/de/npc=40187
UPDATE `creature_template_locale` SET `Name` = '[Vanira''s Sentry Totem]' WHERE `locale` = 'deDE' AND `entry` = 40187;
-- OLD name : Abgestimmter Frosch
-- Source : https://www.wowhead.com/wotlk/de/npc=40188
UPDATE `creature_template_locale` SET `Name` = '[Attuned Frog]' WHERE `locale` = 'deDE' AND `entry` = 40188;
-- OLD name : Jun'do der Verräter
-- Source : https://www.wowhead.com/wotlk/de/npc=40189
UPDATE `creature_template_locale` SET `Name` = '[Jun''do the Traitor]' WHERE `locale` = 'deDE' AND `entry` = 40189;
-- OLD name : Weißes Wollrhinozeros
-- Source : https://www.wowhead.com/wotlk/de/npc=40191
UPDATE `creature_template_locale` SET `Name` = '[Wooly White Rhino]' WHERE `locale` = 'deDE' AND `entry` = 40191;
-- OLD name : Vanira
-- Source : https://www.wowhead.com/wotlk/de/npc=40192
UPDATE `creature_template_locale` SET `Name` = '[Vanira]' WHERE `locale` = 'deDE' AND `entry` = 40192;
-- OLD name : Geistloser Troll
-- Source : https://www.wowhead.com/wotlk/de/npc=40195
UPDATE `creature_template_locale` SET `Name` = '[Mindless Troll]' WHERE `locale` = 'deDE' AND `entry` = 40195;
-- OLD name : Zen'tabra
-- Source : https://www.wowhead.com/wotlk/de/npc=40196
UPDATE `creature_template_locale` SET `Name` = '[Zen''tabra]' WHERE `locale` = 'deDE' AND `entry` = 40196;
-- OLD name : Tikikrieger
-- Source : https://www.wowhead.com/wotlk/de/npc=40199
UPDATE `creature_template_locale` SET `Name` = '[Tiki Warrior]' WHERE `locale` = 'deDE' AND `entry` = 40199;
-- OLD name : Aufklärungsfledermaus
-- Source : https://www.wowhead.com/wotlk/de/npc=40203
UPDATE `creature_template_locale` SET `Name` = '[Recon Bat]' WHERE `locale` = 'deDE' AND `entry` = 40203;
-- OLD name : Tierführer Marnlek, subname : Fledermausführer
-- Source : https://www.wowhead.com/wotlk/de/npc=40204
UPDATE `creature_template_locale` SET `Name` = '[Handler Marnlek]',`Title` = '[Bat Handler]' WHERE `locale` = 'deDE' AND `entry` = 40204;
-- OLD name : Zom Bocom, subname : Rüstmeister für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40205
UPDATE `creature_template_locale` SET `Name` = '[Zom Bocom]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40205;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Rüstmeister für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40206
UPDATE `creature_template_locale` SET `Name` = '[Big Zokk Torquewrench]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40206;
-- OLD name : Kezzik der Meuchler, subname : Glorreicher Rüstmeister für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40207
UPDATE `creature_template_locale` SET `Name` = '[Kezzik the Striker]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40207;
-- OLD name : Leeni "Kicher" Erbse, subname : Rüstmeisterin für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40208
UPDATE `creature_template_locale` SET `Name` = '[Leeni "Smiley" Smalls]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40208;
-- OLD name : Grex Hirnkocher, subname : Klassische Stoff- & Lederrüstungen der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=40209
UPDATE `creature_template_locale` SET `Name` = '[Grex Brainboiler]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 40209;
-- OLD name : Xazi Schmauchpfeife, subname : Rüstmeisterin für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40210
UPDATE `creature_template_locale` SET `Name` = '[Xazi Smolderpipe]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40210;
-- OLD name : Nargel Peitschleine, subname : Glorreicher Rüstmeister für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40211
UPDATE `creature_template_locale` SET `Name` = '[Nargle Lashcord]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40211;
-- OLD name : Eisenfang Rüsti, subname : Überholte Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=40212
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix',`Title` = 'Außergewöhnliche Arenawaffen' WHERE `locale` = 'deDE' AND `entry` = 40212;
-- OLD name : Ecton Messingkipper, subname : Rüstmeister für Ehrenpunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40213
UPDATE `creature_template_locale` SET `Name` = '[Ecton Brasstumbler]',`Title` = '[Apprentice Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40213;
-- OLD name : Evee Kupferspule, subname : Rüstmeisterin für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40214
UPDATE `creature_template_locale` SET `Name` = '[Evee Copperspring]',`Title` = '[Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40214;
-- OLD name : Argex Eisenmagen, subname : Glorreicher Rüstmeister für Eroberungspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=40215
UPDATE `creature_template_locale` SET `Name` = '[Argex Irongut]',`Title` = '[Veteran Arena Vendor]' WHERE `locale` = 'deDE' AND `entry` = 40215;
-- OLD name : Blazzek der Beißer, subname : Überholte Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=40216
UPDATE `creature_template_locale` SET `Name` = '[Blazzek the Biter]',`Title` = '[Exceptional Arena Weaponry]' WHERE `locale` = 'deDE' AND `entry` = 40216;
-- OLD name : Tier von den Echoinseln
-- Source : https://www.wowhead.com/wotlk/de/npc=40217
UPDATE `creature_template_locale` SET `Name` = '[Echo Isle Animal]' WHERE `locale` = 'deDE' AND `entry` = 40217;
-- OLD name : Spy Frog Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40218
UPDATE `creature_template_locale` SET `Name` = '[Spy Frog Credit]' WHERE `locale` = 'deDE' AND `entry` = 40218;
-- OLD name : Spähfledermaus
-- Source : https://www.wowhead.com/wotlk/de/npc=40222
UPDATE `creature_template_locale` SET `Name` = '[Scout Bat]' WHERE `locale` = 'deDE' AND `entry` = 40222;
-- OLD name : Verhexter Terrortroll
-- Source : https://www.wowhead.com/wotlk/de/npc=40225
UPDATE `creature_template_locale` SET `Name` = '[Hexed Dire Troll]' WHERE `locale` = 'deDE' AND `entry` = 40225;
-- OLD name : Verhexter Troll
-- Source : https://www.wowhead.com/wotlk/de/npc=40231
UPDATE `creature_template_locale` SET `Name` = '[Hexed Troll]' WHERE `locale` = 'deDE' AND `entry` = 40231;
-- OLD name : Krieger der Dunkelspeere
-- Source : https://www.wowhead.com/wotlk/de/npc=40241
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Warrior]' WHERE `locale` = 'deDE' AND `entry` = 40241;
-- OLD name : Sockel der Instantstatue
-- Source : https://www.wowhead.com/wotlk/de/npc=40246
UPDATE `creature_template_locale` SET `Name` = '[Instant Statue Pedestal]' WHERE `locale` = 'deDE' AND `entry` = 40246;
-- OLD name : Champion Uru'zin
-- Source : https://www.wowhead.com/wotlk/de/npc=40253
UPDATE `creature_template_locale` SET `Name` = '[Champion Uru''zin]' WHERE `locale` = 'deDE' AND `entry` = 40253;
-- OLD name : Trollbürgerin
-- Source : https://www.wowhead.com/wotlk/de/npc=40256
UPDATE `creature_template_locale` SET `Name` = '[Troll Citizen]' WHERE `locale` = 'deDE' AND `entry` = 40256;
-- OLD name : Trollbürger
-- Source : https://www.wowhead.com/wotlk/de/npc=40257
UPDATE `creature_template_locale` SET `Name` = '[Troll Citizen]' WHERE `locale` = 'deDE' AND `entry` = 40257;
-- OLD name : Trollfreiwilliger
-- Source : https://www.wowhead.com/wotlk/de/npc=40260
UPDATE `creature_template_locale` SET `Name` = '[Troll Volunteer]' WHERE `locale` = 'deDE' AND `entry` = 40260;
-- OLD name : Tikikrieger
-- Source : https://www.wowhead.com/wotlk/de/npc=40263
UPDATE `creature_template_locale` SET `Name` = '[Tiki Warrior]' WHERE `locale` = 'deDE' AND `entry` = 40263;
-- OLD name : Trollfreiwilliger
-- Source : https://www.wowhead.com/wotlk/de/npc=40264
UPDATE `creature_template_locale` SET `Name` = '[Troll Volunteer]' WHERE `locale` = 'deDE' AND `entry` = 40264;
-- OLD name : Ruheloser Zombie
-- Source : https://www.wowhead.com/wotlk/de/npc=40274
UPDATE `creature_template_locale` SET `Name` = '[Restless Zombie]' WHERE `locale` = 'deDE' AND `entry` = 40274;
-- OLD name : Bwonsamdi
-- Source : https://www.wowhead.com/wotlk/de/npc=40279
UPDATE `creature_template_locale` SET `Name` = '[Bwonsamdi]' WHERE `locale` = 'deDE' AND `entry` = 40279;
-- OLD name : Blauer Aufziehraketenbot
-- Source : https://www.wowhead.com/wotlk/de/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Uhrwerkraketenbot' WHERE `locale` = 'deDE' AND `entry` = 40295;
-- OLD name : Tiger Matriarch Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40301
UPDATE `creature_template_locale` SET `Name` = '[Tiger Matriarch Credit]' WHERE `locale` = 'deDE' AND `entry` = 40301;
-- OLD name : Geist des Tigers
-- Source : https://www.wowhead.com/wotlk/de/npc=40305
UPDATE `creature_template_locale` SET `Name` = '[Spirit of the Tiger]' WHERE `locale` = 'deDE' AND `entry` = 40305;
-- OLD name : Tigermatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=40312
UPDATE `creature_template_locale` SET `Name` = '[Tiger Matriarch]' WHERE `locale` = 'deDE' AND `entry` = 40312;
-- OLD name : Zen'tabra
-- Source : https://www.wowhead.com/wotlk/de/npc=40329
UPDATE `creature_template_locale` SET `Name` = '[Zen''tabra]' WHERE `locale` = 'deDE' AND `entry` = 40329;
-- OLD name : Hexendoktor Hez'tok
-- Source : https://www.wowhead.com/wotlk/de/npc=40352
UPDATE `creature_template_locale` SET `Name` = '[Witch Doctor Hez''tok]' WHERE `locale` = 'deDE' AND `entry` = 40352;
-- OLD name : Ritualtänzer
-- Source : https://www.wowhead.com/wotlk/de/npc=40356
UPDATE `creature_template_locale` SET `Name` = '[Ritual Dancer]' WHERE `locale` = 'deDE' AND `entry` = 40356;
-- OLD name : Vortänzertroll
-- Source : https://www.wowhead.com/wotlk/de/npc=40361
UPDATE `creature_template_locale` SET `Name` = '[Troll Dance Leader]' WHERE `locale` = 'deDE' AND `entry` = 40361;
-- OLD name : Tänzer
-- Source : https://www.wowhead.com/wotlk/de/npc=40363
UPDATE `creature_template_locale` SET `Name` = '[Dance Participant]' WHERE `locale` = 'deDE' AND `entry` = 40363;
-- OLD name : Zalazanes Überreste
-- Source : https://www.wowhead.com/wotlk/de/npc=40368
UPDATE `creature_template_locale` SET `Name` = '[Zalazane''s Remains]' WHERE `locale` = 'deDE' AND `entry` = 40368;
-- OLD name : Ritualtrommler
-- Source : https://www.wowhead.com/wotlk/de/npc=40373
UPDATE `creature_template_locale` SET `Name` = '[Ritual Drummer]' WHERE `locale` = 'deDE' AND `entry` = 40373;
-- OLD name : Stimme der Geister
-- Source : https://www.wowhead.com/wotlk/de/npc=40374
UPDATE `creature_template_locale` SET `Name` = '[Voice of the Spirits]' WHERE `locale` = 'deDE' AND `entry` = 40374;
-- OLD name : Omen Event Credit
-- Source : https://www.wowhead.com/wotlk/de/npc=40387
UPDATE `creature_template_locale` SET `Name` = '[Omen Event Credit]' WHERE `locale` = 'deDE' AND `entry` = 40387;
-- OLD name : Vorfahre der Dunkelspeere
-- Source : https://www.wowhead.com/wotlk/de/npc=40388
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Ancestor]' WHERE `locale` = 'deDE' AND `entry` = 40388;
-- OLD name : Vol'jin
-- Source : https://www.wowhead.com/wotlk/de/npc=40391
UPDATE `creature_template_locale` SET `Name` = '[Vol''jin]' WHERE `locale` = 'deDE' AND `entry` = 40391;
-- OLD name : Krieger der Dunkelspeere
-- Source : https://www.wowhead.com/wotlk/de/npc=40392
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Warrior]' WHERE `locale` = 'deDE' AND `entry` = 40392;
-- OLD name : Tyrantus, subname : Kieupids Begleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=40404
UPDATE `creature_template_locale` SET `Name` = '[Tyrantus]',`Title` = '[Kieupid''s Pet]' WHERE `locale` = 'deDE' AND `entry` = 40404;
-- OLD name : Bwonsamdis Knochen
-- Source : https://www.wowhead.com/wotlk/de/npc=40414
UPDATE `creature_template_locale` SET `Name` = '[Bones of Bwonsamdi]' WHERE `locale` = 'deDE' AND `entry` = 40414;
-- OLD name : Fledermaus des Spähers
-- Source : https://www.wowhead.com/wotlk/de/npc=40415
UPDATE `creature_template_locale` SET `Name` = '[Scout''s Bat]' WHERE `locale` = 'deDE' AND `entry` = 40415;
-- OLD name : Späher der Dunkelspeere
-- Source : https://www.wowhead.com/wotlk/de/npc=40416
UPDATE `creature_template_locale` SET `Name` = '[Darkspear Scout]' WHERE `locale` = 'deDE' AND `entry` = 40416;
-- OLD name : Voodootroll
-- Source : https://www.wowhead.com/wotlk/de/npc=40425
UPDATE `creature_template_locale` SET `Name` = '[Voodoo Troll]' WHERE `locale` = 'deDE' AND `entry` = 40425;
-- OLD name : Winziger Mondstoffteppich
-- Source : https://www.wowhead.com/wotlk/de/npc=40426
UPDATE `creature_template_locale` SET `Name` = '[Tiny Mooncloth Carpet]' WHERE `locale` = 'deDE' AND `entry` = 40426;
-- OLD name : Winkeladvokat des Dampfdruckkartells, subname : Dungeonmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=40438
UPDATE `creature_template_locale` SET `Name` = '[Steamwheedle Shyster]',`Title` = '[Dungeonmaster]' WHERE `locale` = 'deDE' AND `entry` = 40438;
-- OLD name : Elgin Klicksprung, subname : Assistentin des Hochtüftlers
-- Source : https://www.wowhead.com/wotlk/de/npc=40478
UPDATE `creature_template_locale` SET `Name` = '[Elgin Clickspring]',`Title` = '[High Tinker''s Assistant]' WHERE `locale` = 'deDE' AND `entry` = 40478;
-- OLD name : Kamerafahrzeug
-- Source : https://www.wowhead.com/wotlk/de/npc=40479
UPDATE `creature_template_locale` SET `Name` = '[Camera Vehicle]' WHERE `locale` = 'deDE' AND `entry` = 40479;
-- OLD name : Feiernder Troll
-- Source : https://www.wowhead.com/wotlk/de/npc=40481
UPDATE `creature_template_locale` SET `Name` = '[Troll Celebrant]' WHERE `locale` = 'deDE' AND `entry` = 40481;
-- OLD name : Zild'jian, subname : Vol'jins Kriegstrommler
-- Source : https://www.wowhead.com/wotlk/de/npc=40492
UPDATE `creature_template_locale` SET `Name` = '[Zild''jian]',`Title` = '[Vol''jin''s Wardrummer]' WHERE `locale` = 'deDE' AND `entry` = 40492;
-- OLD name : Zalazane
-- Source : https://www.wowhead.com/wotlk/de/npc=40502
UPDATE `creature_template_locale` SET `Name` = '[Zalazane]' WHERE `locale` = 'deDE' AND `entry` = 40502;
-- OLD name : Explosion Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=40506
UPDATE `creature_template_locale` SET `Name` = '[Explosion Bunny]' WHERE `locale` = 'deDE' AND `entry` = 40506;
-- OLD name : Hauptmann T'Maire Sydes, subname : Rüstmeisterin für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=40606
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant T''Maire Sydes]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 40606;
-- OLD name : Hauptmann T'Maire Sydes, subname : Rüstmeisterin für Rüstungen aus Nordend
-- Source : https://www.wowhead.com/wotlk/de/npc=40607
UPDATE `creature_template_locale` SET `Name` = '[Knight-Lieutenant T''Maire Sydes]',`Title` = '[Northrend Armor Quartermaster]' WHERE `locale` = 'deDE' AND `entry` = 40607;
-- OLD name : Himmelsross
-- Source : https://www.wowhead.com/wotlk/de/npc=40625
UPDATE `creature_template_locale` SET `Name` = '[Celestial Steed]' WHERE `locale` = 'deDE' AND `entry` = 40625;
-- OLD name : Protodrachenreittier der Vrykul
-- Source : https://www.wowhead.com/wotlk/de/npc=40704
UPDATE `creature_template_locale` SET `Name` = '[Vrykul Proto-dragon Mount]' WHERE `locale` = 'deDE' AND `entry` = 40704;
-- OLD name : Crafticus Jones, subname : Nicht spawnen
-- Source : https://www.wowhead.com/wotlk/de/npc=40724
UPDATE `creature_template_locale` SET `Name` = '[Crafticus Jones]',`Title` = '[Do Not Spawn]' WHERE `locale` = 'deDE' AND `entry` = 40724;
-- OLD name : X-53 Reiserakete
-- Source : https://www.wowhead.com/wotlk/de/npc=40725
UPDATE `creature_template_locale` SET `Name` = '[X-53 Touring Rocket]' WHERE `locale` = 'deDE' AND `entry` = 40725;
-- OLD name : Rubindrache
-- Source : https://www.wowhead.com/wotlk/de/npc=40842
UPDATE `creature_template_locale` SET `Name` = '[Ruby Drake]' WHERE `locale` = 'deDE' AND `entry` = 40842;
