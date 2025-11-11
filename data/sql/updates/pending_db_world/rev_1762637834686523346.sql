-- Update deDE ; from WowHead WOTLK
-- OLD name : Schmalspurrohling
-- Source : https://www.wowhead.com/wotlk/de/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Rohling der Defias' WHERE `locale` = 'deDE' AND `entry` = 38;
-- OLD name : Niederer Sukkubus
-- Source : https://www.wowhead.com/wotlk/de/npc=49
UPDATE `creature_template_locale` SET `Name` = 'Geringer Sukkubus' WHERE `locale` = 'deDE' AND `entry` = 49;
-- OLD name : [UNUSED] Lower Class Citizen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 70;
-- OLD name : Level 20 Unkillable Test Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=72
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 72;
-- OLD name : [UNUSED] Vashaum Nightwither (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 75;
-- OLD name : [UNUSED] Luglar the Clogger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=81
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 81;
-- OLD name : Taschendieb
-- Source : https://www.wowhead.com/wotlk/de/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Taschendieb der Defias' WHERE `locale` = 'deDE' AND `entry` = 94;
-- OLD name : Kodowildtier
-- Source : https://www.wowhead.com/wotlk/de/npc=106
UPDATE `creature_template_locale` SET `Name` = 'Kodobestie' WHERE `locale` = 'deDE' AND `entry` = 106;
-- OLD name : Bandit
-- Source : https://www.wowhead.com/wotlk/de/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandit der Defias' WHERE `locale` = 'deDE' AND `entry` = 116;
-- OLD name : [UNUSED] Small Black Dragon Whelp (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 149;
-- OLD name : [UNUSED] Ander the Monk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 161;
-- OLD name : [UNUSED] Destitute Farmer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 163;
-- OLD name : [UNUSED] Small Child (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 165;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=198
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 198;
-- OLD name : Verrottender Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Skelettschrecken' WHERE `locale` = 'deDE' AND `entry` = 202;
-- OLD name : [UNUSED] Cackle Flamebone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 204;
-- OLD name : [UNUSED] Riverpaw Hideflayer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 207;
-- OLD name : [UNUSED] Riverpaw Pack Warder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 208;
-- OLD name : [UNUSED] Riverpaw Bone Chanter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 209;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/de/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'deDE','Theodor Teufelswald','Holzschnitzer');
-- OLD name : Marschall Gryan Starkmantel, subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Starkmantel',`Title` = 'Die Volksmiliz' WHERE `locale` = 'deDE' AND `entry` = 234;
-- OLD name : [UNUSED] Greeby Mudwhisker TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=243
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 243;
-- OLD name : [UNUSED] Elwynn Tower Guard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 260;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/de/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Ein halb aufgefressener Körper' WHERE `locale` = 'deDE' AND `entry` = 262;
-- OLD name : Koboldpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=281
UPDATE `creature_template_locale` SET `Name` = 'Koboldtank' WHERE `locale` = 'deDE' AND `entry` = 281;
-- OLD name : [UNUSED] Goodmother Jans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 296;
-- OLD name : Junger Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Erkrankter junger Wolf' WHERE `locale` = 'deDE' AND `entry` = 299;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 301;
-- OLD name : Schimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Schimmel)' WHERE `locale` = 'deDE' AND `entry` = 305;
-- OLD name : Palomino
-- Source : https://www.wowhead.com/wotlk/de/npc=306
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Palomino)' WHERE `locale` = 'deDE' AND `entry` = 306;
-- OLD name : "Buried Upside-Down" Vehicle
-- Source : https://www.wowhead.com/wotlk/de/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Rolfs Leichnam' WHERE `locale` = 'deDE' AND `entry` = 309;
-- OLD name : [UNUSED] Brother Akil (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 318;
-- OLD name : [UNUSED] Brother Benthas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 319;
-- OLD name : [UNUSED] Brother Cryus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 320;
-- OLD name : [UNUSED] Brother Deros (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 321;
-- OLD name : [UNUSED] Brother Enoch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 322;
-- OLD name : [UNUSED] Brother Heller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=323
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 323;
-- OLD name : [UNUSED] Brother Greishan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 324;
-- OLD name : [UNUSED] Brother Ictharin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 326;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=328
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 328;
-- OLD subname : Anführer des SI:7
-- Source : https://www.wowhead.com/wotlk/de/npc=332
UPDATE `creature_template_locale` SET `Title` = 'Anführer von SI:7' WHERE `locale` = 'deDE' AND `entry` = 332;
-- OLD name : [UNUSED] Edwardo the Jester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 333;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor the Pugilist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 339;
-- OLD name : Winterwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=359
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Winter)' WHERE `locale` = 'deDE' AND `entry` = 359;
-- OLD name : Murak Winterborn
-- Source : https://www.wowhead.com/wotlk/de/npc=373
UPDATE `creature_template_locale` SET `Name` = 'Marek Winterborn' WHERE `locale` = 'deDE' AND `entry` = 373;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/de/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Kellnerin' WHERE `locale` = 'deDE' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 380;
-- OLD name : Katie Weidmann
-- Source : https://www.wowhead.com/wotlk/de/npc=384
UPDATE `creature_template_locale` SET `Name` = 'Katie Waidmann' WHERE `locale` = 'deDE' AND `entry` = 384;
-- OLD name : Niederer Leerwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=418
UPDATE `creature_template_locale` SET `Name` = 'Geringer Leerwandler' WHERE `locale` = 'deDE' AND `entry` = 418;
-- OLD name : Champion des Schwarzfels
-- Source : https://www.wowhead.com/wotlk/de/npc=435
UPDATE `creature_template_locale` SET `Name` = 'Held des Schwarzfels' WHERE `locale` = 'deDE' AND `entry` = 435;
-- OLD name : Pausbacke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 444;
-- OLD name : Wachhauptmann Parker
-- Source : https://www.wowhead.com/wotlk/de/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Wache Parker' WHERE `locale` = 'deDE' AND `entry` = 464;
-- OLD name : [UNUSED] Scribe Colburg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 470;
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
-- OLD name : [UNUSED] Watcher Kleeman (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 496;
-- OLD name : [UNUSED] Watcher Benjamin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 497;
-- OLD name : [UNUSED] Watcher Larsen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 498;
-- OLD name : [UNUSED] Long Fang (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 509;
-- OLD name : [UNUSED] Riverpaw Hunter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 516;
-- OLD name : [UNUSED] Savar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 535;
-- OLD name : [UNUSED] Rhal'Del (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 536;
-- OLD name : [UNUSED] Buk'Cha (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 538;
-- OLD name : Wegelagerer
-- Source : https://www.wowhead.com/wotlk/de/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Wegelagerer der Defias' WHERE `locale` = 'deDE' AND `entry` = 583;
-- OLD name : [UNUSED] Watcher Kern (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 586;
-- OLD name : [UNUSED] Brandstifter der Defias (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=592
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 592;
-- OLD name : [UNUSED] Mr. Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=605
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 605;
-- OLD name : [UNUSED] Mrs. Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=606
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 606;
-- OLD name : [UNUSED] Johnny Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 607;
-- OLD name : [UNUSED] Grandpa Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=609
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 609;
-- OLD name : [UNUSED] Rabid Gina Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 610;
-- OLD name : [UNUSED] Rabid Mr. Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=611
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 611;
-- OLD name : [UNUSED] Rabid Mrs. Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 612;
-- OLD name : [UNUSED] Rabid Johnny Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 613;
-- OLD name : [UNUSED] Rabid Grandpa Whipple (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 614;
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
-- OLD name : [UNUSED] Skeletal Enforcer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=725
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 725;
-- OLD name : Unteroffizierin Yohwa
-- Source : https://www.wowhead.com/wotlk/de/npc=733
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Yohwa' WHERE `locale` = 'deDE' AND `entry` = 733;
-- OLD name : [UNUSED] Rebel Soldier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 753;
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
-- OLD name : Niederer Arachnid (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=924
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 924;
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
-- OLD name : [UNUSED] Truek (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=1058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1058;
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
-- OLD name : [UNUSED] Kern the Enforcer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=1361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1361;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Überragender Koch' WHERE `locale` = 'deDE' AND `entry` = 1382;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 1430;
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'deDE',NULL,'Pfeilmacherbedarf');
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
-- OLD name : [UNUSED] Elwynn Guard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1643;
-- OLD name : Wache des Rotkammgebirges (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=1644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1644;
-- OLD name : Novizin Elreth
-- Source : https://www.wowhead.com/wotlk/de/npc=1661
UPDATE `creature_template_locale` SET `Name` = 'Novize Elreth' WHERE `locale` = 'deDE' AND `entry` = 1661;
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/de/npc=1677
UPDATE `creature_template_locale` SET `Title` = 'Koch' WHERE `locale` = 'deDE' AND `entry` = 1677;
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
-- OLD name : Bürger von Mühlenbern (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2087
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2087;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2124
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin' WHERE `locale` = 'deDE' AND `entry` = 2124;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=2128
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer' WHERE `locale` = 'deDE' AND `entry` = 2128;
-- OLD name : [UNUSED] Crier Kirton (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2197;
-- OLD name : [UNUSED] Crier Backus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2199;
-- OLD name : [UNUSED] Crier Pierce (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2200;
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2220
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstlehrer' WHERE `locale` = 'deDE' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2223
UPDATE `creature_template_locale` SET `Title` = 'Kochkunstlehrer' WHERE `locale` = 'deDE' AND `entry` = 2223;
-- OLD name : Maggarrak
-- Source : https://www.wowhead.com/wotlk/de/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Steinwüter' WHERE `locale` = 'deDE' AND `entry` = 2258;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/de/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'deDE','Bogenträger',NULL);
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2313;
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
-- OLD name : Bürger von Süderstade (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2441
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2441;
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
-- OLD name : [UNUSED] Archmage Detrae (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2617;
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
-- OLD name : [PH] Weitschreiterausbilder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2871
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2871;
-- OLD name : [PH] Raptorenausbilder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2873
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2873;
-- OLD name : [PH] Pferdeausbilder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2874
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2874;
-- OLD name : [PH] Gorillaausbilder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2875
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2875;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Krokiliskenausbilder' WHERE `locale` = 'deDE' AND `entry` = 2876;
-- OLD name : [PH] Kriecherausbilder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=2877
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2877;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Fertigkeitenlehrer für Distanzwaffen' WHERE `locale` = 'deDE' AND `entry` = 2886;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=2935
UPDATE `creature_template_locale` SET `Title` = 'Dämonenausbilder' WHERE `locale` = 'deDE' AND `entry` = 2935;
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
-- OLD subname : Geselle des Alchemiehandwerks
-- Source : https://www.wowhead.com/wotlk/de/npc=3070
UPDATE `creature_template_locale` SET `Title` = 'Alchimist <Needs Model>' WHERE `locale` = 'deDE' AND `entry` = 3070;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3071
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundiger <Needs Model>' WHERE `locale` = 'deDE' AND `entry` = 3071;
-- OLD name : [UNUSED] Narache Guard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3082;
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
-- OLD name : [UNUSED] Ancestral Watcher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3420;
-- OLD name : [UNUSED] Kendur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3427;
-- OLD name : [UNUSED] Ancestral Sage (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3440
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3440;
-- OLD subname : Unabhängiger Vertragspartner
-- Source : https://www.wowhead.com/wotlk/de/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Tüftlerverband' WHERE `locale` = 'deDE' AND `entry` = 3442;
-- OLD subname : Händler für Leder- & Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3483
UPDATE `creature_template_locale` SET `Title` = 'Händler für Leder- & schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 3483;
-- OLD subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3558
UPDATE `creature_template_locale` SET `Title` = 'Giftreagenzien' WHERE `locale` = 'deDE' AND `entry` = 3558;
-- OLD name : Temp Giftmischereibedarfsverkäufer Zwerg, subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3559
UPDATE `creature_template_locale` SET `Name` = 'Temp Giftmischereibedarfverkäufer Zwerg',`Title` = 'Giftreagenzien' WHERE `locale` = 'deDE' AND `entry` = 3559;
-- OLD name : Braumeister von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Braumeister von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 3577;
-- OLD name : Minenarbeiter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Minenarbeiter von Dalaran' WHERE `locale` = 'deDE' AND `entry` = 3578;
-- OLD name : [UNUSED] Kolkar Observer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3651;
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
-- OLD name : Gezeitenprinzessin der Rächerflossen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=3718
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3718;
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
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'deDE' AND `entry` = 4045;
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
-- OLD name : [UNUSED] [PH] Ambassador Saylaton Grabeshuf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=4313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4313;
-- OLD name : [UNUSED] Guthrin Grabeshuf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=4315
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4315;
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
-- OLD name : Volieber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=4439
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4439;
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
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4579
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrer' WHERE `locale` = 'deDE' AND `entry` = 4579;
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
-- OLD name : Yuriv Adhem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5544
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5544;
-- OLD name : Minenboss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5548
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5548;
-- OLD name : Minenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5549
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5549;
-- OLD name : [PH] SGS Arbeiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5550
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5550;
-- OLD name : Karawanenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5551
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5551;
-- OLD name : [PH] SGS Peon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5552
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5552;
-- OLD name : Karawanenspäher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5553
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5553;
-- OLD name : [PH] SGS Tierwelt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5554
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5554;
-- OLD name : Packpferd einer Ogerkarawane (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5555
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5555;
-- OLD name : Kommandant der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5556
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5556;
-- OLD name : Kommandant der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5557
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5557;
-- OLD name : Wache der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5558;
-- OLD name : Wache der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5559;
-- OLD name : Räuber der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5560
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5560;
-- OLD name : Räuber der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5561
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5561;
-- OLD name : Bogenschütze der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5562
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5562;
-- OLD name : Bogenschütze der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5563
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5563;
-- OLD name : [PH] Minenboss der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5587;
-- OLD name : [PH] Minenwache der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5588;
-- OLD name : Minenboss der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5589;
-- OLD name : Minenwache der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5590
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5590;
-- OLD name : Grunzerin Mojka
-- Source : https://www.wowhead.com/wotlk/de/npc=5603
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Mojka' WHERE `locale` = 'deDE' AND `entry` = 5603;
-- OLD name : [UNUSED] [PH] Orcish Barfly (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5604;
-- OLD name : Trainingsattrappe von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=5652
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Unterstadt' WHERE `locale` = 'deDE' AND `entry` = 5652;
-- OLD name : [UNUSED] Lawrence Sägner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5671
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5671;
-- OLD name : [UNUSED] Charles Brewton (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5672
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5672;
-- OLD name : [UNUSED] Todespirscher Vincent DEBUGGEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5678
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5678;
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
-- OLD name : [PH] Party-Bot (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5801;
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
-- OLD name : [UNUSED] Hurll Kans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=5904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5904;
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
-- OLD name : [UNUSED] Gozwin Vilesprocket (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=6046
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6046;
-- OLD name : Totem des Erdgriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=6066
UPDATE `creature_template_locale` SET `Name` = 'Totem des Erdengriffs' WHERE `locale` = 'deDE' AND `entry` = 6066;
-- OLD name : [UNUSED] Meritt Herrion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=6067
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6067;
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
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6183;
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
-- OLD name : [UNUSED] Lorek Belm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=6783
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6783;
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
-- OLD name : [UNUSED] Drayl (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=7293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7293;
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
-- OLD name : Braune Natter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=7507
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7507;
-- OLD name : Schwarze Königsnatter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=7508
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7508;
-- OLD name : Purpurrote Natter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=7509
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7509;
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
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9557;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=9566
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar' WHERE `locale` = 'deDE' AND `entry` = 9566;
-- OLD name : [UNUSED] Gorilla Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=9577
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9577;
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
-- OLD name : [UNUSED] Eyan Mulcom (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=9617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9617;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9686;
-- OLD subname : Blutaxtlegion
-- Source : https://www.wowhead.com/wotlk/de/npc=9696
UPDATE `creature_template_locale` SET `Title` = 'Schmetterschildlegion' WHERE `locale` = 'deDE' AND `entry` = 9696;
-- OLD name : [UNUSED] [PH] Cheese Servant Floh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9820;
-- OLD subname : Ehemaliger Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 9983;
-- OLD name : [PH] Alex's Raid Testing Peon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10044;
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
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=10237
UPDATE `creature_template_locale` SET `Title` = 'UNUSED' WHERE `locale` = 'deDE' AND `entry` = 10237;
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
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10370;
-- OLD name : [UNUSED] Thuzadin Shadow Lord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10401;
-- OLD name : [UNUSED] Cannibal Wight (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10402;
-- OLD name : [UNUSED] Devouring Wight (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10403;
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
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10446
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer' WHERE `locale` = 'deDE' AND `entry` = 10446;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10450
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer' WHERE `locale` = 'deDE' AND `entry` = 10450;
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
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10607;
-- OLD name : Finkle Einhorn
-- Source : https://www.wowhead.com/wotlk/de/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Pip Flitzwitz' WHERE `locale` = 'deDE' AND `entry` = 10776;
-- OLD name : [UNUSED] Deathcaller Majestis (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10810;
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
-- OLD name : [PH[ Combat Tester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11080;
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
-- OLD name : Axtwerfer von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11337
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11337;
-- OLD name : Berserker von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11341;
-- OLD name : Krieger von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11342
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11342;
-- OLD name : Kriegsherr von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11343
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11343;
-- OLD name : Bluttrinker von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11344
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11344;
-- OLD name : Kopfjäger von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11345
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11345;
-- OLD name : Balgabzieher der Gurubashi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11349
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11349;
-- OLD name : Kriegsherr der Gurubashi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11354
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11354;
-- OLD name : Tochter von Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11358
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11358;
-- OLD name : Zulianische Tigerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11364
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11364;
-- OLD name : Zulianische Matriarchin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11366
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11366;
-- OLD name : Zulianischer Patriarch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11367
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11367;
-- OLD name : Verborgener Blutsucher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11369
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11369;
-- OLD name : Zath (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11375
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11375;
-- OLD name : Lor'khan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11376
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11376;
-- OLD name : Hak'tharr der Gehirnjäger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11377
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11377;
-- OLD name : Nik'reesh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11379
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11379;
-- OLD name : Älteste T'kashra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11384
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11384;
-- OLD name : Mogwhi der Ruchlose (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11385
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11385;
-- OLD name : Janook die Wutklinge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11386;
-- OLD name : Kampfmagier der Gordok (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11449
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11449;
-- OLD name : [UNUSED] Warpwood-Scharrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11463
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11463;
-- OLD name : Hochgeborener Beschwörer, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11466
UPDATE `creature_template_locale` SET `Name` = 'Hochgeborenenbeschwörer',`Title` = '' WHERE `locale` = 'deDE' AND `entry` = 11466;
-- OLD name : [UNUSED] Eldreth-Lichling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11468
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11468;
-- OLD name : Versenger der Eldreth
-- Source : https://www.wowhead.com/wotlk/de/npc=11469
UPDATE `creature_template_locale` SET `Name` = 'Schnauber der Eldreth' WHERE `locale` = 'deDE' AND `entry` = 11469;
-- OLD name : [UNUSED] Manabestie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11478
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11478;
-- OLD name : [UNUSED] Arkaner Schrecken (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11481
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11481;
-- OLD subname : Gebieter der Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 11486;
-- OLD name : [UNUSED] Sentius (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11493;
-- OLD name : [UNUSED] Avidus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11495
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11495;
-- OLD name : Skarr der Gebrochene
-- Source : https://www.wowhead.com/wotlk/de/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Skarr der Unbezwingbare' WHERE `locale` = 'deDE' AND `entry` = 11498;
-- OLD name : [UNUSED] Kommandant Gormaul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11499
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11499;
-- OLD name : [UNUSED] Majordomus Bagrosh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11500
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11500;
-- OLD name : Rüstmeisterin Miranda Knackschloss, subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11536
UPDATE `creature_template_locale` SET `Name` = 'Rüstmeisterin Miranda Breechlock',`Title` = 'Die Argentumdämmerung' WHERE `locale` = 'deDE' AND `entry` = 11536;
-- OLD name : [UNUSED] Molten Colossus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11660;
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
-- OLD name : [UNUSED] Flame Shrieker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11670;
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
-- OLD name : [PH] Northshire Gift Dispenser (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11926;
-- OLD name : Obsidianbehüter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11959
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11959;
-- OLD name : Neltharion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=11978
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11978;
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
-- OLD name : Todeskrallenwelpe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12417
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12417;
-- OLD name : Auftragsmörder der Pechschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12421
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12421;
-- OLD name : [NOT USED] Kriegsherr der Pechschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12462
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12462;
-- OLD name : Bannschuppe der Todeskrallen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12466
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12466;
-- OLD name : Hauptmann der Todeskrallen
-- Source : https://www.wowhead.com/wotlk/de/npc=12467
UPDATE `creature_template_locale` SET `Name` = 'Captain der Todeskrallen' WHERE `locale` = 'deDE' AND `entry` = 12467;
-- OLD name : Erderschütterer der Todeskrallen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12469
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12469;
-- OLD name : Feuerzunge der Todeskrallen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12470
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12470;
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
-- OLD name : [PH] TEST Feuergott (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=12804
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 12804;
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
-- OLD name : Friedhofsherold (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14181
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14181;
-- OLD name : [UNUSED] Sid Stuco (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14201;
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
-- OLD name : [PH] Horde spell thrower (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14641;
-- OLD name : [PH] Alliance Spell thrower (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14642;
-- OLD name : [PH] Alliance Herald (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14643;
-- OLD name : [PH] Horde Herald (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14644;
-- OLD name : Verdorbenes Totem des heilendes Flusses V
-- Source : https://www.wowhead.com/wotlk/de/npc=14664
UPDATE `creature_template_locale` SET `Name` = 'Verderbtes Totem des heilenden Flusses V' WHERE `locale` = 'deDE' AND `entry` = 14664;
-- OLD name : Geflügelter Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=14714
UPDATE `creature_template_locale` SET `Name` = 'Geflügelter Horror' WHERE `locale` = 'deDE' AND `entry` = 14714;
-- OLD name : [PH] Turmleutnant der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14719
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14719;
-- OLD name : Feldmarschall Afrasiabi
-- Source : https://www.wowhead.com/wotlk/de/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Feldmarschall Steinsteg' WHERE `locale` = 'deDE' AND `entry` = 14721;
-- OLD subname : Stoffrüstmeisterin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=14723
UPDATE `creature_template_locale` SET `Title` = 'Stoffrüstmeister der Allianz' WHERE `locale` = 'deDE' AND `entry` = 14723;
-- OLD name : [PH] Turmleutnant der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=14746
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14746;
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
-- OLD name : Luis Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15167
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15167;
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
-- OLD name : Erbauer der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15226
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15226;
-- OLD name : Schwarmformer der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15227
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15227;
-- OLD name : Tunnelgräber der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15228
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15228;
-- OLD name : Patrolleur der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15231
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15231;
-- OLD name : Vernichter der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15232
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15232;
-- OLD name : Schwärmer der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15234
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15234;
-- OLD name : Wutstachel der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15237
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15237;
-- OLD name : Schwarmhäscher der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15238
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15238;
-- OLD name : Schwarmlauerer der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15239
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15239;
-- OLD name : Wespenreiter der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15243
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15243;
-- OLD name : Schwarmräuber der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15244
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15244;
-- OLD name : Wespenwache der Vekniss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15245
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15245;
-- OLD name : Seelenbeuger der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15248
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15248;
-- OLD name : Schlächter der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15251
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15251;
-- OLD name : Champion der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15253
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15253;
-- OLD name : Hauptmann der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15254
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15254;
-- OLD name : Offizier der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15255
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15255;
-- OLD name : Kommandant der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15256
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15256;
-- OLD name : Ehrenwache der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15257
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15257;
-- OLD name : Prätorianer der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15258
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15258;
-- OLD name : Imperator der Qiraji Imperator (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15259
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15259;
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
-- OLD name : Wegelagerer des Zaraschwarms (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15322
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15322;
-- OLD name : Schwärmer des Zaraschwarms (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15326
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15326;
-- OLD name : Dunkelmond-Dampfpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=15328
UPDATE `creature_template_locale` SET `Name` = 'Dunkelmonddampfpanzer' WHERE `locale` = 'deDE' AND `entry` = 15328;
-- OLD name : Späher des Zaraschwarms (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15329
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15329;
-- OLD name : Sandbohrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15330
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15330;
-- OLD name : Dünentunnelgräber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15331
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15331;
-- OLD name : Kristallspeiser (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15332
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15332;
-- OLD name : Sandwandler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15337
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15337;
-- OLD name : Sphinx (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15342
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15342;
-- OLD name : Tochter von Hecate (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15345
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15345;
-- OLD name : Wespenreiter der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15346
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15346;
-- OLD name : Wespenlord der Qiraji (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15347
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15347;
-- OLD name : RC Blimp <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'deDE' AND `entry` = 15349;
-- OLD name : RC Mörserpanzer, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'deDE' AND `entry` = 15364;
-- OLD name : Ayamiss die Jägerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15369
UPDATE `creature_template_locale` SET `Name` = 'Ayamiss der Jäger' WHERE `locale` = 'deDE' AND `entry` = 15369;
-- OLD name : [UNUSED] Ruins Qiraji Gladiator Named 7 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15393
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15393;
-- OLD name : Welt Juwelierskunstlehrer, subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15465
UPDATE `creature_template_locale` SET `Name` = 'Welt Juwelenschleiferlehrer',`Title` = 'Juwelenschleiferlehrerin' WHERE `locale` = 'deDE' AND `entry` = 15465;
-- OLD name : Tiefenschlamm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15472;
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
-- OLD name : Manasauger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15646
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15646;
-- OLD name : Auktionator (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15672
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15672;
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
-- OLD name : Valentinsfeiernder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15982
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15982;
-- OLD name : Valentinsfeiernde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=15983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15983;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 16032;
-- OLD name : Sumpfbiest
-- Source : https://www.wowhead.com/wotlk/de/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]' WHERE `locale` = 'deDE' AND `entry` = 16035;
-- OLD name : Alex' Test DPS Mob (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16077
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16077;
-- OLD name : Kreuzzugskommandant Korfax
-- Source : https://www.wowhead.com/wotlk/de/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Held des Lichts' WHERE `locale` = 'deDE' AND `entry` = 16112;
-- OLD name : Scharlachrote Kommandantin Marjhan
-- Source : https://www.wowhead.com/wotlk/de/npc=16114
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Kommandant Marjhan' WHERE `locale` = 'deDE' AND `entry` = 16114;
-- OLD name : Kreuzzugskommandant Eligor Morgenbringer
-- Source : https://www.wowhead.com/wotlk/de/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Eligor Morgenbringer' WHERE `locale` = 'deDE' AND `entry` = 16115;
-- OLD name : Wächter der Geißel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16138
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16138;
-- OLD name : Nekropolenkristallsäule (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16140
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16140;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=16185
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister' WHERE `locale` = 'deDE' AND `entry` = 16185;
-- OLD name : Nekropolenkristallsäule (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16188
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16188;
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
-- OLD name : Verteidiger der Todesritter
-- Source : https://www.wowhead.com/wotlk/de/npc=16451
UPDATE `creature_template_locale` SET `Name` = 'Vollstrecker der Todesritter' WHERE `locale` = 'deDE' AND `entry` = 16451;
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
-- OLD name : Wilder Goblin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16608
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16608;
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
-- OLD name : Abbild eines plündernden Krustenbohrers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=16914
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 16914;
-- OLD name : Maid der Trauer
-- Source : https://www.wowhead.com/wotlk/de/npc=16961
UPDATE `creature_template_locale` SET `Name` = 'Maid der Seelenpein' WHERE `locale` = 'deDE' AND `entry` = 16961;
-- OLD name : Sonnenwendhändlerkostüm der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=16986
UPDATE `creature_template_locale` SET `Name` = 'Sonnenwendhändlerkostüm der Alliant' WHERE `locale` = 'deDE' AND `entry` = 16986;
-- OLD name : Abbild eines Krustenbohrers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17001
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17001;
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
-- OLD name : Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17165;
-- OLD name : Scharfseher Nobundo
-- Source : https://www.wowhead.com/wotlk/de/npc=17204
UPDATE `creature_template_locale` SET `Name` = 'Weissager Nobundo' WHERE `locale` = 'deDE' AND `entry` = 17204;
-- OLD subname : Spektralgreifenmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=17209
UPDATE `creature_template_locale` SET `Title` = 'Spektraler Greifenmeister' WHERE `locale` = 'deDE' AND `entry` = 17209;
-- OLD name : Tunnelgräber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17234
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17234;
-- OLD name : Herold der Pestländer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17239;
-- OLD name : Slims untötbarer Testdummy
-- Source : https://www.wowhead.com/wotlk/de/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'deDE' AND `entry` = 17313;
-- OLD name : Zauberer des Schattenmondklans
-- Source : https://www.wowhead.com/wotlk/de/npc=17396
UPDATE `creature_template_locale` SET `Name` = 'Zauberhexer des Schattenmondklans' WHERE `locale` = 'deDE' AND `entry` = 17396;
-- OLD name : Brandschatzer des Schattenmondklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17463
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17463;
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
-- OLD name : Testmonster (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17582
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17582;
-- OLD name : Junger Draenei
-- Source : https://www.wowhead.com/wotlk/de/npc=17587
UPDATE `creature_template_locale` SET `Name` = 'Draeneijüngling' WHERE `locale` = 'deDE' AND `entry` = 17587;
-- OLD name : Höllenfeuerwolfsreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=17593
UPDATE `creature_template_locale` SET `Name` = 'Höllenfeuerwolfreiter' WHERE `locale` = 'deDE' AND `entry` = 17593;
-- OLD name : Hauptmann Offensichtlich Jr. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17597
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17597;
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
-- OLD name : Verirrter Goblin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17813
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17813;
-- OLD name : Wahnsinniger Worgen
-- Source : https://www.wowhead.com/wotlk/de/npc=17823
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Worgen' WHERE `locale` = 'deDE' AND `entry` = 17823;
-- OLD name : Behüter des Echsenkessels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17939
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17939;
-- OLD name : Action Trigger Test Creature For Kyle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=17966
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17966;
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
-- OLD name : Magierlord der Sethekk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18329
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18329;
-- OLD name : Reitwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=18345
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache' WHERE `locale` = 'deDE' AND `entry` = 18345;
-- OLD name : [UNUSED] Dusty Skeleton [PH] (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18355;
-- OLD name : Lohfarbener Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=18363
UPDATE `creature_template_locale` SET `Name` = 'Gelbbrauner Windreiter' WHERE `locale` = 'deDE' AND `entry` = 18363;
-- OLD name : Draeneigeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18367
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18367;
-- OLD name : Trainingsattrappe von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18504
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Silbermond' WHERE `locale` = 'deDE' AND `entry` = 18504;
-- OLD name : Weltenwanderer von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18507
UPDATE `creature_template_locale` SET `Name` = 'Silbermond Weltenwanderer' WHERE `locale` = 'deDE' AND `entry` = 18507;
-- OLD name : Orcischer Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=18598
UPDATE `creature_template_locale` SET `Name` = 'Orcgefangener' WHERE `locale` = 'deDE' AND `entry` = 18598;
-- OLD name : Vernichter der Teufelswache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18604
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18604;
-- OLD name : Ausbilderin Cel
-- Source : https://www.wowhead.com/wotlk/de/npc=18629
UPDATE `creature_template_locale` SET `Name` = 'Ausbilder Cel' WHERE `locale` = 'deDE' AND `entry` = 18629;
-- OLD name : Unterwerferin Vaz'shir
-- Source : https://www.wowhead.com/wotlk/de/npc=18660
UPDATE `creature_template_locale` SET `Name` = 'Unterwerfer Vaz''shir' WHERE `locale` = 'deDE' AND `entry` = 18660;
-- OLD name : Anachoret Lyteera (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18674
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18674;
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
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18936;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18941;
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
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19060;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 19063;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=19065
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 19065;
-- OLD name : Wolfsreiter von Garadar
-- Source : https://www.wowhead.com/wotlk/de/npc=19068
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter von Garadar' WHERE `locale` = 'deDE' AND `entry` = 19068;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19132;
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
-- OLD name : Zauberer des Sonnenzorns - Sonnenzornposten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19650;
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
-- OLD name : Aufseher der Illidari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19819
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19819;
-- OLD name : Horngeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=19846
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19846;
-- OLD name : Bild von Kommandantin Sarannis
-- Source : https://www.wowhead.com/wotlk/de/npc=19938
UPDATE `creature_template_locale` SET `Name` = 'Bild von Kommandant Sarannis' WHERE `locale` = 'deDE' AND `entry` = 19938;
-- OLD name : Astromantenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=20046
UPDATE `creature_template_locale` SET `Name` = 'Astromantenlord' WHERE `locale` = 'deDE' AND `entry` = 20046;
-- OLD name : Versuchsobjekt: Wachposten von Lodaeron
-- Source : https://www.wowhead.com/wotlk/de/npc=20053
UPDATE `creature_template_locale` SET `Name` = 'Versuchsobjekt: Wachposten von Lordaeron' WHERE `locale` = 'deDE' AND `entry` = 20053;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20107;
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
-- OLD name : Mönch der Auchenai (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20299
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20299;
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
-- OLD name : Kapitän Skarloc (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20521
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20521;
-- OLD name : Epochenjäger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20531
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20531;
-- OLD name : Thrall (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20548
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20548;
-- OLD name : Aragas Junges
-- Source : https://www.wowhead.com/wotlk/de/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Dunkeltatzenjunges' WHERE `locale` = 'deDE' AND `entry` = 20615;
-- OLD name : Zauberhexerin des Echsenkessels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20625
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20625;
-- OLD name : Kriegsherr Kalithresh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20633
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20633;
-- OLD name : Botschafter Höllenschlund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20636
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20636;
-- OLD name : Dunkelfalke der Federschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20686
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20686;
-- OLD name : Kobaltblaue Schlange (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20688
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20688;
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
-- OLD name : Blutwache Porung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=20992
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20992;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior' WHERE `locale` = 'deDE' AND `entry` = 21003;
-- OLD name : Arkanwächter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21031
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21031;
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
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21333;
-- OLD name : Testnetherwelpe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21378
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21378;
-- OLD name : Gesandter Icarius
-- Source : https://www.wowhead.com/wotlk/de/npc=21409
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Icarius' WHERE `locale` = 'deDE' AND `entry` = 21409;
-- OLD name : Tempixx Finagler
-- Source : https://www.wowhead.com/wotlk/de/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'deDE','Tempixx Feinagler',NULL);
-- OLD name : Abbild eines großen Kurstenbohrers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21457
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21457;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 21488;
-- OLD name : Kaliriaura (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21511;
-- OLD name : Drakonaar der Pechschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21588;
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
-- OLD name : Rechte Hand des Todes (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21658
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21658;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21716;
-- OLD name : Orcnekrolyt
-- Source : https://www.wowhead.com/wotlk/de/npc=21747
UPDATE `creature_template_locale` SET `Name` = 'Orcnekrolyth' WHERE `locale` = 'deDE' AND `entry` = 21747;
-- OLD name : Sturm der Leere des Singenden Bergrückens (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21798
UPDATE `creature_template_locale` SET `Name` = 'Sturm der Leere des singenden Bergrückens' WHERE `locale` = 'deDE' AND `entry` = 21798;
-- OLD name : Massive Zephyriumladung
-- Source : https://www.wowhead.com/wotlk/de/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]' WHERE `locale` = 'deDE' AND `entry` = 21848;
-- OLD name : Reißer der Federschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21989
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21989;
-- OLD name : Kriegsfalke der Federschwingen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=21990
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21990;
-- OLD name : Gesandter vom Auge des Sturms
-- Source : https://www.wowhead.com/wotlk/de/npc=22015
UPDATE `creature_template_locale` SET `Name` = 'Entsandter vom Auge des Sturms' WHERE `locale` = 'deDE' AND `entry` = 22015;
-- OLD name : Bleiche Eidechse (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22039;
-- OLD name : Höhlenfledermaus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22040
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22040;
-- OLD name : Höhlenfledermaus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22046
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22046;
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
-- OLD name : Zorniger Grollhuf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22284
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22284;
-- OLD name : Schildwache der Thronwache
-- Source : https://www.wowhead.com/wotlk/de/npc=22301
UPDATE `creature_template_locale` SET `Name` = 'Späher der Thronwache' WHERE `locale` = 'deDE' AND `entry` = 22301;
-- OLD name : Herz der Bebenden Erde
-- Source : https://www.wowhead.com/wotlk/de/npc=22313
UPDATE `creature_template_locale` SET `Name` = 'Rumpelndes Erdherz' WHERE `locale` = 'deDE' AND `entry` = 22313;
-- OLD name : Fässchen mit Grüntröpfelgrog (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22356;
-- OLD name : Blutschlägergeschwätz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22383;
-- OLD name : Altar der Schatten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22395
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22395;
-- OLD name : Altar der Schatten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22417
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22417;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22423
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22423;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22425
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22425;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22426
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22426;
-- OLD name : Ogerlanze aufgestellt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22434;
-- OLD name : Rexxars Wyvern (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22435;
-- OLD name : Urtum des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22478
UPDATE `creature_template_locale` SET `Name` = 'Urtum des ewigen Hains' WHERE `locale` = 'deDE' AND `entry` = 22478;
-- OLD subname : Forscherliga
-- Source : https://www.wowhead.com/wotlk/de/npc=22481
UPDATE `creature_template_locale` SET `Title` = 'Expeditionsleiter' WHERE `locale` = 'deDE' AND `entry` = 22481;
-- OLD name : Schildwache der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22645
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22645;
-- OLD name : Leutnant Largent (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22702
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22702;
-- OLD name : Alteracwidder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22727
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22727;
-- OLD name : Unteroffizier Yazra Murrblut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22760
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22760;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22801;
-- OLD name : Gorgolon der Allsehende
-- Source : https://www.wowhead.com/wotlk/de/npc=22827
UPDATE `creature_template_locale` SET `Name` = 'Gorgolon der Allessehende' WHERE `locale` = 'deDE' AND `entry` = 22827;
-- OLD name : Tempelkonkubine
-- Source : https://www.wowhead.com/wotlk/de/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Tempelakolyth' WHERE `locale` = 'deDE' AND `entry` = 22939;
-- OLD name : Hund der Illidari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=22944
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22944;
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
-- OLD name : Inselelekk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23013
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23013;
-- OLD name : Inselsäbler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23014
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23014;
-- OLD name : TEST Iceberg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23041
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23041;
-- OLD name : Zerrütter der Teufelwache
-- Source : https://www.wowhead.com/wotlk/de/npc=23055
UPDATE `creature_template_locale` SET `Name` = 'Zerrütter der Teufelswache' WHERE `locale` = 'deDE' AND `entry` = 23055;
-- OLD name : [PH]Knockdown Fel Cannon Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23077;
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
-- OLD name : Teufelshund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23138
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23138;
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
-- OLD name : Mutantenkommandant (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23238
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23238;
-- OLD name : Wuthund der Eredar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23276
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23276;
-- OLD name : Wahnsinniger Vorarbeiter der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=23305
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Großknecht der Finsterblut' WHERE `locale` = 'deDE' AND `entry` = 23305;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23317;
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
-- OLD name : Zwergischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23479;
-- OLD name : Menschlicher Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23480;
-- OLD name : Nordendyeti (blau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23513
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23513;
-- OLD name : Nordendyeti (braun) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23514
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23514;
-- OLD name : UNUSED Nordendyeti (rot) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23515;
-- OLD name : Nordendyeti (gelb) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23516
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23516;
-- OLD name : Nordendyeti (weiß) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23517
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23517;
-- OLD name : Taurenkanu (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23518
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23518;
-- OLD name : Jimmy Zweikanu (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23520
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23520;
-- OLD name : Verkäufer des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23532;
-- OLD name : Roter Nordenddrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23538
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23538;
-- OLD name : Roter Nordendgroßdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23539
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23539;
-- OLD name : Goblinischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23540;
-- OLD name : Vrykul (Northrend Size Model) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23553
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23553;
-- OLD name : Protodrachenreittier der Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23556
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23556;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/de/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Winterhäldler' WHERE `locale` = 'deDE' AND `entry` = 23559;
-- OLD name : Braufestwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=23588
UPDATE `creature_template_locale` SET `Name` = 'Widder des Braufests' WHERE `locale` = 'deDE' AND `entry` = 23588;
-- OLD name : Neuer NSC des Hinterlands (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23599
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23599;
-- OLD name : Orcischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23607;
-- OLD name : Taurischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23608;
-- OLD name : Trollischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23609;
-- OLD name : Blutelfischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23610;
-- OLD name : Untoter Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23611;
-- OLD name : Draenischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23613;
-- OLD name : Gnomischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23614;
-- OLD name : Nachtelfischer Feiernder des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23615;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE A (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE B (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE C (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE D (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE E (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE F (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23634;
-- OLD name : Stammesangehöriger der Langhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23639
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23639;
-- OLD name : Harpunierer der Langhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23640
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23640;
-- OLD name : Meeresrufer der Langhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23641
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23641;
-- OLD name : Wegfinder der Langhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23642
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23642;
-- OLD name : Nordmeerschmuggler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23646
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23646;
-- OLD name : Nordmeerbrigant (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23647
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23647;
-- OLD name : Nordmeerräuber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23648
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23648;
-- OLD name : Nordmeerschwadroneur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23649
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23649;
-- OLD name : Nordmeerpirat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23650
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23650;
-- OLD name : Ältester der Drachenschinder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23659
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23659;
-- OLD name : Zottelfelleber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23692
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23692;
-- OLD name : Tuskarr (Northrend Size Model) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23695
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23695;
-- OLD name : Festagsfass der Gerstenbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23700
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gerstenbräus' WHERE `locale` = 'deDE' AND `entry` = 23700;
-- OLD name : Festagsfass der Donnerbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23702
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Donnerbräus' WHERE `locale` = 'deDE' AND `entry` = 23702;
-- OLD name : Festagsfass der Gordok
-- Source : https://www.wowhead.com/wotlk/de/npc=23706
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gordok' WHERE `locale` = 'deDE' AND `entry` = 23706;
-- OLD name : Claytons Testkreatur, subname : Geprüfte Qualität (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23715
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23715;
-- OLD name : Steinlord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23726
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23726;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe' WHERE `locale` = 'deDE' AND `entry` = 23734;
-- OLD name : Eishöhlenyeti (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23743;
-- OLD name : Dampfpanzer von Eisenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23756
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23756;
-- OLD name : Kapitän der Blockade (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23767;
-- OLD name : Scharfschütze von Valgarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23792
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23792;
-- OLD name : Flamme der Drachenschinder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23806
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23806;
-- OLD name : Fass des Braufests zum Ziel bewegen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23808
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23808;
-- OLD name : Feiernder Zwergenmann des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23819;
-- OLD name : Feiernde Zwergenfrau des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23820;
-- OLD name : Feiernde Goblinfrau des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23824;
-- OLD name : Feiernder Goblinmann des Braufests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23830;
-- OLD name : Unteroffizierin Amelyn
-- Source : https://www.wowhead.com/wotlk/de/npc=23835
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Amelyn' WHERE `locale` = 'deDE' AND `entry` = 23835;
-- OLD name : Holzfäller der Westwacht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23838
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23838;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23855;
-- OLD name : Kavallerist der Westwacht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23856
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23856;
-- OLD name : Kavallerist der Westwacht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23857
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23857;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=23862
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 23862;
-- OLD name : Gezähmter Protowelpe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23882;
-- OLD subname : Angellehrer & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Fischhändler' WHERE `locale` = 'deDE' AND `entry` = 23896;
-- OLD name : Wiedererweckter Berserker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23898
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23898;
-- OLD name : Invisible Giant Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23901
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23901;
-- OLD name : Test Guy Brian (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23925
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23925;
-- OLD name : Verteidiger der Westwacht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23933
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23933;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23936;
-- OLD name : Gastwirtin Celeste Gutstall
-- Source : https://www.wowhead.com/wotlk/de/npc=23937
UPDATE `creature_template_locale` SET `Name` = 'Gastwirt Celeste Gutstall' WHERE `locale` = 'deDE' AND `entry` = 23937;
-- OLD name : Mogisu der Wanderer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=23981
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23981;
-- OLD name : Hungriger Seuchenhund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24000
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24000;
-- OLD name : Belagerungsarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Mühlenarbeiter' WHERE `locale` = 'deDE' AND `entry` = 24005;
-- OLD name : Aasfressende Made (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24017
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24017;
-- OLD name : Reitpferd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24020
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24020;
-- OLD name : Test Faction Monster (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24022
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24022;
-- OLD name : Steinhornwidder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24049
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24049;
-- OLD name : Protodrachenbrutmutter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24072
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24072;
-- OLD name : Inspektor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24074
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24074;
-- OLD name : Späher von Valgarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24075
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24075;
-- OLD name : Gefangenes Kind von Valgarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24091;
-- OLD name : Winterskorn Vrykul Dismembering Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24095
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24095;
-- OLD name : Skorn Longhouse SW Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24101;
-- OLD name : Protodrachenhimmelswache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24105
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24105;
-- OLD name : Schildwache der Drachenschinder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24107;
-- OLD name : Zielattrappe des Braufests zum Ziel bewegen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24109
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24109;
-- OLD name : Reservist der Nordflotte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24121
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24121;
-- OLD name : Gefangener Einwohner Valgardes (PROXY) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24124
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24124;
-- OLD name : Kriegerheld der Winterhufe
-- Source : https://www.wowhead.com/wotlk/de/npc=24130
UPDATE `creature_template_locale` SET `Name` = 'Held der Winterhufe' WHERE `locale` = 'deDE' AND `entry` = 24130;
-- OLD name : Nebelsäbler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24134
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24134;
-- OLD name : Leichnam der Nordflotte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24146
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24146;
-- OLD name : Wiedererwecktes Orakel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24153
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24153;
-- OLD name : Ulf Credit Marker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24165;
-- OLD name : Oric Credit Marker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24166
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24166;
-- OLD name : Gunnar Credit Marker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24167
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24167;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24171;
-- OLD name : Aufklärer der Amani'shi
-- Source : https://www.wowhead.com/wotlk/de/npc=24175
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Amani''shi' WHERE `locale` = 'deDE' AND `entry` = 24175;
-- OLD name : Geist von Forscher Jaren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24181
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24181;
-- OLD name : Diener des Lichts (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24190
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24190;
-- OLD name : Diener des Lichts (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24192;
-- OLD name : Armee der Toten
-- Source : https://www.wowhead.com/wotlk/de/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Ghul aus der Armee der Toten' WHERE `locale` = 'deDE' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24220;
-- OLD name : Quälheimer Massenmörder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24231
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24231;
-- OLD name : Protodrachenreittier der Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24237
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24237;
-- OLD name : Kriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=24242
UPDATE `creature_template_locale` SET `Name` = 'Glibber' WHERE `locale` = 'deDE' AND `entry` = 24242;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24265;
-- OLD name : Arthas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24266
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24266;
-- OLD name : Arthas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24267
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24267;
-- OLD name : Arthas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24268
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24268;
-- OLD name : The Cleansing Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24269
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24269;
-- OLD name : Plagued Dragonflayer Explode Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24274
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24274;
-- OLD name : Björn Kill Credit, subname : Häuptling der Winterskorn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24275
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24275;
-- OLD name : Björn Insult Credit, subname : Häuptling der Winterskorn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24276
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24276;
-- OLD name : Garwal - Worgentransformation (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24278
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24278;
-- OLD name : Plagued Dragonflayer Spray Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24281
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24281;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24311;
-- OLD name : Gruselige Lumpenpuppe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24319;
-- OLD name : Nifflevar Event Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24326
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24326;
-- OLD name : Nordendtransportmittel der Blizzcon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24331
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24331;
-- OLD name : Zul'Aman Transport (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24332
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24332;
-- OLD name : Jason Gutstall, subname : Barkeeper
-- Source : https://www.wowhead.com/wotlk/de/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Schankkellner Jason Gutstall',`Title` = 'Getränke' WHERE `locale` = 'deDE' AND `entry` = 24333;
-- OLD name : Scharlachroter Wuchs (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24339;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24352;
-- OLD name : Eric Maloof Test Forsaken Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24353
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24353;
-- OLD name : Eric Maloof Test Forsaken Female (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24354
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24354;
-- OLD name : Eric Maloof Test Human Male (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24355;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24361;
-- OLD name : Harrisons Leichnam
-- Source : https://www.wowhead.com/wotlk/de/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Willies Leichnam' WHERE `locale` = 'deDE' AND `entry` = 24365;
-- OLD name : [UNUSED]Vazruden Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24377
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24378
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24378;
-- OLD name : Begrüßer der Blizzcon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24380;
-- OLD name : Eisenrunendiener (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24387
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24387;
-- OLD name : Alter Kutter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24391
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24391;
-- OLD subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'deDE' AND `entry` = 24395;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24417
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24417;
-- OLD name : Steel Gate - Grapple Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24438
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24438;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24446
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24446;
-- OLD name : Frostwyrm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24447
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24447;
-- OLD name : Invisible Charge Target 1 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24449
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24449;
-- OLD name : Invisible Charge Target 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24450
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24450;
-- OLD name : Blue Floating Rune Channel Bunny 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24465
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24465;
-- OLD name : Blue Floating Rune Channel Bunny 02 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24466
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24466;
-- OLD name : Maldonados Testkreatur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24470
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24470;
-- OLD name : Schmiedenfeuer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24471
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24471;
-- OLD name : SP Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24472;
-- OLD name : Blutdürstiger Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=24475
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Worg' WHERE `locale` = 'deDE' AND `entry` = 24475;
-- OLD name : Eiskriecher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24479
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24479;
-- OLD name : Froschtransformation
-- Source : https://www.wowhead.com/wotlk/de/npc=24483
UPDATE `creature_template_locale` SET `Name` = 'Transformation des Froschs' WHERE `locale` = 'deDE' AND `entry` = 24483;
-- OLD name : Harpunenkanone der Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24512
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24512;
-- OLD name : Vrykul Harpoon Controller 001 View (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24513
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24513;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=24520
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 24520;
-- OLD name : Northsea Test1 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24521
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24521;
-- OLD subname : Garaxxas Tier
-- Source : https://www.wowhead.com/wotlk/de/npc=24552
UPDATE `creature_template_locale` SET `Title` = 'Garaxxas'' Begleiter' WHERE `locale` = 'deDE' AND `entry` = 24552;
-- OLD name : Gespinstunhold der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24564
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24564;
-- OLD name : Spinne der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24565
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24565;
-- OLD name : Höhlenratte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24568
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24568;
-- OLD name : Höhlenkriecher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24569
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24569;
-- OLD name : Tundragezücht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24570
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24570;
-- OLD name : Gezüchttyrann (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24571
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24571;
-- OLD name : Gezüchthexling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24572
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24572;
-- OLD name : Tundraroc (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24573
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24573;
-- OLD name : Großer Tundraroc (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24574;
-- OLD name : Schinder der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24575
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24575;
-- OLD name : Gezeitenjäger der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24577
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24577;
-- OLD name : Schlangenwache der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24578
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24578;
-- OLD name : Gezeitenlord der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24579
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24579;
-- OLD name : Feldmesser der Eisenwoge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24581;
-- OLD name : Maschinenschmied der Eisenwoge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24582
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24582;
-- OLD name : Ingenieur der Eisenwoge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24583
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24583;
-- OLD name : Fischer der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24584
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24584;
-- OLD name : Stammesmitglied der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24585
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24585;
-- OLD name : Harpunierer der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24586;
-- OLD name : Walfänger der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24587;
-- OLD name : Meeresrufer der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24588;
-- OLD name : Orcajäger der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24589;
-- OLD name : Wegfinder der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24590
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24590;
-- OLD name : Götzenschnitzer der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24591
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24591;
-- OLD name : Ältester der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24592
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24592;
-- OLD name : Weiser Priester der Wahrhauer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24593
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24593;
-- OLD name : Korallenbewachsene Schildkröte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24594
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24594;
-- OLD name : Korallenbewachsener Schnapper (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24595
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24595;
-- OLD name : Korallenbewachsenes Urtum (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24596
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24596;
-- OLD name : Küstenwoger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24597
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24597;
-- OLD name : Tidenwoger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24598
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24598;
-- OLD name : Großer Tidenwoger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24599
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24599;
-- OLD name : Dampfreißer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24600
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24600;
-- OLD name : Lebendiger Geysir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24602
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24602;
-- OLD name : Lebendiger Blizzard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24603
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24603;
-- OLD name : Eisfuror (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24604
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24604;
-- OLD name : Räuber der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24605
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24605;
-- OLD name : Brandschatzer der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24606
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24606;
-- OLD name : Schildmaid der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24607;
-- OLD name : Ruderer der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24608
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24608;
-- OLD name : Plünderer der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24609
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24609;
-- OLD name : Runenmagier der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24610;
-- OLD name : Wogentürmer der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24611
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24611;
-- OLD name : Than der Voldskar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24612;
-- OLD name : Einzelgängerisches Mammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24615
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24615;
-- OLD name : Mammutpatriarch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24616
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24616;
-- OLD name : Tundrawolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24617;
-- OLD name : Verhungernder Tundrawolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24618
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24618;
-- OLD name : Großer Tundrawolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24619
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24619;
-- OLD name : Tundraleitwolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24620
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24620;
-- OLD name : Frostkäfigskelett (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24621
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24621;
-- OLD name : Frostkäfigverheerer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24622
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24622;
-- OLD name : Frostknochen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24623
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24623;
-- OLD name : Boralsteingargoyle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24624
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24624;
-- OLD name : Boralsteinhimmelsjäger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24625
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24625;
-- OLD name : Geißelhymnenkreischer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24626
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24626;
-- OLD name : Geißelhymnenheuler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24627
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24627;
-- OLD name : Nordmeerfreibeuter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24636
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24636;
-- OLD name : Alliance Standard Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24641
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24641;
-- OLD name : Mirror Frame (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24645
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24645;
-- OLD name : Invisible Stalker (Scale x2) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24648
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24648;
-- OLD name : Reflection of Flame (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24651
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24651;
-- OLD name : Wellenreiterbrett mit Harpune (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24652
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24652;
-- OLD name : Reflection Bounce Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24655
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24655;
-- OLD name : Blauer männlicher Blutelf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24658;
-- OLD name : Hydra der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24661
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24661;
-- OLD name : Gezeitenlord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24663
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24663;
-- OLD name : Leutnant Eishammer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24665
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24665;
-- OLD name : Harpunenkanone der Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24682
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24682;
-- OLD name : Invisible Vehicle (Floating) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24704
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24704;
-- OLD name : Test Scaling Bony Construct (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24712
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24712;
-- OLD name : Flugmaschinentaxi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24716
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24716;
-- OLD name : Fliegender blauer Drache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24721
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24721;
-- OLD name : Gorloc Oracle Black (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24724
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24724;
-- OLD name : Hundeschlitten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24725
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24725;
-- OLD name : Schlittenhund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24726
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24726;
-- OLD name : Schlammwespe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24731
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24731;
-- OLD name : Schlammspringer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24732;
-- OLD name : Fjord Prey 03 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24748
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24748;
-- OLD name : Fjord Prey 04 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24749;
-- OLD name : Magiereflexion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24756
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24756;
-- OLD name : Fjordfelsenschlange (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24757;
-- OLD name : Spearfang Worg Totem Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24758;
-- OLD name : Gefangener Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24759
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24759;
-- OLD name : Fjordmonarch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24760
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24760;
-- OLD name : Suirut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24764
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24764;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24766;
-- OLD name : Behüter des Nexus
-- Source : https://www.wowhead.com/wotlk/de/npc=24770
UPDATE `creature_template_locale` SET `Name` = 'Behüter des Nexus''' WHERE `locale` = 'deDE' AND `entry` = 24770;
-- OLD name : Roter Kaltarrawelpe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24775
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24775;
-- OLD name : Red-Breath Cannon (PH) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24776
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24776;
-- OLD name : Missile Target Flare (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24778
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24778;
-- OLD name : Fjordwespe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24793
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24793;
-- OLD name : Fjordkäfer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24794
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24794;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24798;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24799;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24800;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24801
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24801;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24802
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24802;
-- OLD name : Grell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24803
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24803;
-- OLD name : Ross des kopflosen Reiters
-- Source : https://www.wowhead.com/wotlk/de/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Reittier des kopflosen Reiters' WHERE `locale` = 'deDE' AND `entry` = 24814;
-- OLD name : Fjordstachelschwein (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24816
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24816;
-- OLD name : Schubkarre (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24853;
-- OLD name : Supererhitzter Elementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24859
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24859;
-- OLD name : Piratin der Defias (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24860
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24860;
-- OLD name : Kristallstrahl (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24861
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24861;
-- OLD name : Kristallstrahl (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24865
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24865;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrerin' WHERE `locale` = 'deDE' AND `entry` = 24868;
-- OLD name : Maschinenwächter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24869
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24869;
-- OLD name : Maschinentechniker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24870
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24870;
-- OLD name : Maschinenspäher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24878
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24878;
-- OLD name : Windan Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24890
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24890;
-- OLD name : Klippenungetüm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24894
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24894;
-- OLD name : Lou der Kabinenjunge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24898
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24898;
-- OLD name : Lawine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24912;
-- OLD name : Snowball Stampede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24915
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24915;
-- OLD name : Erste Offizierin Kupferbolz
-- Source : https://www.wowhead.com/wotlk/de/npc=24926
UPDATE `creature_template_locale` SET `Name` = 'Erster Offizier Kupferbolz' WHERE `locale` = 'deDE' AND `entry` = 24926;
-- OLD name : Madame Flaschatauren, subname : Gefährtin des Flaschatauren
-- Source : https://www.wowhead.com/wotlk/de/npc=24982
UPDATE `creature_template_locale` SET `Name` = 'Frau Flaschatauren',`Title` = 'PTR-Verzauberungen' WHERE `locale` = 'deDE' AND `entry` = 24982;
-- OLD name : Besudelter Magnataurengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=24983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24983;
-- OLD name : Winterhauptmann Skarloc
-- Source : https://www.wowhead.com/wotlk/de/npc=24987
UPDATE `creature_template_locale` SET `Name` = 'Winterkapitän Skarloc' WHERE `locale` = 'deDE' AND `entry` = 24987;
-- OLD name : Dan's Test Vehicle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25006
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25006;
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
-- OLD name : Brianna (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25139;
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
-- OLD name : Fackel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25218
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25218;
-- OLD name : TEST - Clayton Dubin - TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25221
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25221;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=25225
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe' WHERE `locale` = 'deDE' AND `entry` = 25225;
-- OLD name : Grunzer der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25252;
-- OLD name : Soldat der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25254
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25254;
-- OLD name : Soldat der Geißel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25255
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25255;
-- OLD name : Inschriftenkundelehrer, subname : Inschriftenkundelehrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25263;
-- OLD name : Zivilrekrut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25266
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25266;
-- OLD name : Hordezeppelin (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25269
UPDATE `creature_template_locale` SET `Name` = 'Hordenzeppelin (Nordend)' WHERE `locale` = 'deDE' AND `entry` = 25269;
-- OLD subname : Ingenieurkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst' WHERE `locale` = 'deDE' AND `entry` = 25277;
-- OLD name : König Mrgl-Mrgls Reserveanzug (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25283
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25283;
-- OLD name : Wyvern des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25287
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25287;
-- OLD name : Ay'mon, subname : To'bors Begleiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25290
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25290;
-- OLD name : Eiersack der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25293;
-- OLD name : Larve der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25296;
-- OLD name : Cel, subname : Reagenzien & Gifte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25312
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25312;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'deDE',NULL,'Softwareingenieur');
-- OLD name : Gortsch der Leichenmalmer
-- Source : https://www.wowhead.com/wotlk/de/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor' WHERE `locale` = 'deDE' AND `entry` = 25329;
-- OLD name : Scheusal der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25330
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25330;
-- OLD name : Zerstörer der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25331
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25331;
-- OLD name : Standartenträger des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25337
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25337;
-- OLD name : Tote Karawanenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25340
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25340;
-- OLD name : Toter Karawanenarbeiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25341;
-- OLD name : Zwielichtspion Viktor, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25346
UPDATE `creature_template_locale` SET `Name` = 'Spion Viktor des Schattenhammers',`Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 25346;
-- OLD name : Oberanführer der Geißel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25352
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25352;
-- OLD name : Schreckenszwirnspinner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25365
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25365;
-- OLD name : (PH) DEPRECATED (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25366
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25366;
-- OLD name : Riesiger Skarabäus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25375
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25375;
-- OLD name : Stellvertreter der Nerub'ar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25382
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25382;
-- OLD name : Schlupfling von En'kilah (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25388
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25388;
-- OLD name : Schlupfling von En'kilah (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25389
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25389;
-- OLD name : Ältester Yakone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25400
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25400;
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
-- OLD name : Urahnengeist der Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25436
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25436;
-- OLD name : Wolf des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25447
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25447;
-- OLD name : Vision des Geistes von Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25458
UPDATE `creature_template_locale` SET `Name` = 'Vision des Geistes von Weissager Grimmläufer' WHERE `locale` = 'deDE' AND `entry` = 25458;
-- OLD name : Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25461
UPDATE `creature_template_locale` SET `Name` = 'Weissager Grimmläufer' WHERE `locale` = 'deDE' AND `entry` = 25461;
-- OLD name : Soldat der Eisigen Weiten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25463
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25463;
-- OLD name : Stellvertretende Geißeleinheit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25495
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25495;
-- OLD name : Orabus der Steuermann (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25497
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25497;
-- OLD name : Hah... You're Not So Big Now! Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25505
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25505;
-- OLD name : [PH] Feuerjongleur des Sonnenwendfests (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25515;
-- OLD name : Caleb, subname : Stallmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25519
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25519;
-- OLD name : Versklavte Priesterin der Peitschennarbe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25524
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25524;
-- OLD name : Orabus Spell Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25525
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25525;
-- OLD name : Nackte Karawanenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25526
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25526;
-- OLD name : Nackte Karawanenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25527
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25527;
-- OLD name : Naked Caravan Guard - Orc Female Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25528
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25528;
-- OLD name : Naked Caravan Guard - Tauren Male Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25529
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25529;
-- OLD name : Naked Caravan Worker - Orc Male Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25530
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25530;
-- OLD name : Naked Caravan Worker - Forsaken Male Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25531
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25531;
-- OLD name : Naked Caravan Worker - Orc Female Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25532
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25532;
-- OLD name : Naked Caravan Worker - Troll Male Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25533;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/de/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'deDE','Craig''s Test Human',NULL);
-- OLD name : It Was The Orcs, Honest! Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25581;
-- OLD name : Landmine des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25583
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25583;
-- OLD name : Warsong Orc Disguise Male Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25586;
-- OLD name : Warsong Orc Disguise Female Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25587;
-- OLD name : Ruderer der Skadir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25612;
-- OLD name : Boot der Skadir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25614;
-- OLD name : Verseuchter Schneebold (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25616
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25616;
-- OLD name : Stop the Plague Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25654
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25654;
-- OLD name : Das Schiff des Steuermanns (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25656
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25656;
-- OLD name : Besatzungsmitglied der Kvaldir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25659
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25659;
-- OLD name : Verseuchtes Karibu (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25667
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25667;
-- OLD name : Reitmammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25673
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25673;
-- OLD name : Mammutreiter der Taunka (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25674
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25674;
-- OLD name : Sturmwolke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25676
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25676;
-- OLD name : Wahnsinniger Überlebender der Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25681
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25681;
-- OLD name : Orakel der Gorlocs gelb (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25688
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25688;
-- OLD name : Orakel der Gorlocs rosa (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25689
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25689;
-- OLD name : Orakel der Gorlocs rot (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25690
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25690;
-- OLD name : Orakel der Gorlocs grün (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25691
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25691;
-- OLD name : Orakel der Gorlocs kohlefarben (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25692
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25692;
-- OLD name : Orakel der Gorlocs hellblau (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25693
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25693;
-- OLD name : Orakel der Gorlocs blau (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25694
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25694;
-- OLD name : Kodo Saved Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25698
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25698;
-- OLD name : Sengender Flämmling
-- Source : https://www.wowhead.com/wotlk/de/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Flämmling' WHERE `locale` = 'deDE' AND `entry` = 25706;
-- OLD name : Blaudrachenpatrouille von Kaltarra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25723
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25723;
-- OLD name : Leylinienwart von Kaltarra, subname : PH MODEL: TASK 23362 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25734
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25734;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25746;
-- OLD name : Leerenschildwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25772
UPDATE `creature_template_locale` SET `Name` = 'Leerenwache' WHERE `locale` = 'deDE' AND `entry` = 25772;
-- OLD name : Lastkodo der Flüchtlinge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25775
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25775;
-- OLD name : Flüchtlingsmutter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25776
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25776;
-- OLD name : Flüchtlingsvater (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25777
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25777;
-- OLD name : Einsamer Flüchtling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25778
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25778;
-- OLD name : X-42B (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25787
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25787;
-- OLD name : Nesingwarys Lakai (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25805
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25805;
-- OLD name : Sonnenbrunnen FX (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25813
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25813;
-- OLD name : Herr und Diener Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25815
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25815;
-- OLD name : Terrorfurbolg (Nordend) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25842
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25842;
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
-- OLD name : Arktischer Kondor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25963
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25963;
-- OLD name : Konvertierter Sammler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=25993
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25993;
-- OLD name : Hochadmiral "Shelly" Jorrik, subname : Pensionär (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26081
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26081;
-- OLD name : Weakness to Lightning Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26082;
-- OLD name : Transportkugel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26086
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26086;
-- OLD name : Kurier der roten Drachen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26088;
-- OLD name : Wagen mit Erz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26099
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26099;
-- OLD name : Plagued Grain Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26114
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26114;
-- OLD name : Worg des Kriegshymnenklans (Taxi) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26128;
-- OLD name : Quest InvisMan - Buying Time - Effect Caster (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26129
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26129;
-- OLD name : Quest InvisMan - Buying Time - Effect Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26130;
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26176;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=26183
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 26183;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26190;
-- OLD name : Nexus 70 - Buying Time - Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26193
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26193;
-- OLD name : Einheit von En'kilah (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26195
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26195;
-- OLD name : Krieger von Moa'ki (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26220
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26220;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26222
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 26222;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26223
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan' WHERE `locale` = 'deDE' AND `entry` = 26223;
-- OLD name : Slay Loguhn Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26227
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26227;
-- OLD name : Gischtalbatros
-- Source : https://www.wowhead.com/wotlk/de/npc=26240
UPDATE `creature_template_locale` SET `Name` = 'Gischtalbatross' WHERE `locale` = 'deDE' AND `entry` = 26240;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26241;
-- OLD name : Purpurschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=26243
UPDATE `creature_template_locale` SET `Name` = 'Scharlachrote Schlange' WHERE `locale` = 'deDE' AND `entry` = 26243;
-- OLD name : Farshire Bell Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26256
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26256;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26258;
-- OLD name : Roter Reitdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26263;
-- OLD name : Pico, subname : Lederhändler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26269
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26269;
-- OLD name : Urtum der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26274
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26274;
-- OLD name : Schwarzdrache der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26275;
-- OLD name : Grüner Drache der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26278;
-- OLD name : Roter Drache der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26279
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26279;
-- OLD name : Elementarobsidiandrachenhain der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26285;
-- OLD name : Ereignisauslöser des Vergessenen Strands. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26288
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26288;
-- OLD name : Risswirker der Zerschmetterten Sonne
-- Source : https://www.wowhead.com/wotlk/de/npc=26289
UPDATE `creature_template_locale` SET `Name` = 'Felsspalter der Zerschmetterten Sonne' WHERE `locale` = 'deDE' AND `entry` = 26289;
-- OLD name : Aasfelder der Geißel in der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26292;
-- OLD name : Magmawyrm der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26294;
-- OLD name : Drachenöde; Scharlachroter Ansturm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26296;
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
-- OLD name : Taunka der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26311;
-- OLD name : Taunkageist der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26312;
-- OLD name : Treant der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26313;
-- OLD name : Galakronds Ruhestätte der Geißel in der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26317;
-- OLD name : Obsidiandrachenhain der Geißel in der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26318;
-- OLD name : Rubindrachenschrein der Geißel in der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26320;
-- OLD name : Zokk "Lulatsch" Drillzang
-- Source : https://www.wowhead.com/wotlk/de/npc=26352
UPDATE `creature_template_locale` SET `Name` = 'Bigzokk Drillzang' WHERE `locale` = 'deDE' AND `entry` = 26352;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26355;
-- OLD name : (PH) Wildlife Test Doe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26364
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26364;
-- OLD name : (PH) Wildlife Test Bear (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26368;
-- OLD name : (PH) Grizzly Test Low Aggro Worg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26372
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26372;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26378
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26378;
-- OLD name : Grikkin Kupferspule, subname : Arenaverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26383
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26383;
-- OLD name : Frixi Messingkipper, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26384
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26384;
-- OLD name : Verwandelter Fallensteller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26390
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26390;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26391;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26397
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 26397;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26398
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 26398;
-- OLD name : Aufklärer von Kaskala
-- Source : https://www.wowhead.com/wotlk/de/npc=26403
UPDATE `creature_template_locale` SET `Name` = 'Warte von Kaskala' WHERE `locale` = 'deDE' AND `entry` = 26403;
-- OLD name : Schwarzes Kriegsskelettpferd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26404
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26404;
-- OLD name : (PH) Wildlife Test Worg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26412
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26412;
-- OLD name : Verändertes Aussehen des Fallenstellers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26427;
-- OLD name : Budd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26429
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26429;
-- OLD name : Ducals Beifahrersitz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26430
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26430;
-- OLD name : Flüchtling der Taunka'le (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26432
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26432;
-- OLD name : Flüchtling der Taunka'le (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26433
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26433;
-- OLD name : Gesandter Reißzahn
-- Source : https://www.wowhead.com/wotlk/de/npc=26441
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Reißzahn' WHERE `locale` = 'deDE' AND `entry` = 26441;
-- OLD name : Rak'la der Reisende, subname : Glücksspieler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26442
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26442;
-- OLD name : Quest Invisman - Filling the Cages (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26444;
-- OLD name : Runenplatte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26445
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26445;
-- OLD name : (PH) Duskhowl Stalker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26454
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26454;
-- OLD name : Kranker Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=26457
UPDATE `creature_template_locale` SET `Name` = 'Verstorbener Drakkari' WHERE `locale` = 'deDE' AND `entry` = 26457;
-- OLD name : Lorn Todessprecher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26460
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26460;
-- OLD name : Testgreif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26462
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26462;
-- OLD name : Transformation eines toten Magierjägers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26476
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26476;
-- OLD name : Krieger der Horde, subname : Söhne des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26486
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26486;
-- OLD name : Soldat der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26487
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26487;
-- OLD name : Aasfeldtotenbeschwörer der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26489;
-- OLD name : Aasfeldzombie der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26490;
-- OLD name : Aasfeldgargoyle der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26491;
-- OLD name : Testkatapult (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26495
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26495;
-- OLD name : Pestrufer der Verlassenen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26508
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26508;
-- OLD name : Aasbeschwörer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26512
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26512;
-- OLD name : Aasghul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26515;
-- OLD name : Aasgargoyle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26517
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26517;
-- OLD name : Aasmonstrosität (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26518
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26518;
-- OLD name : Scharlachroter Fußsoldat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26524
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26524;
-- OLD name : Verseuchter Scharlachroter Fußsoldat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26526
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26526;
-- OLD name : Craig Amai (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26535;
-- OLD subname : Zeppelinmeister, Boreanische Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26537
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, boreanische Tundra' WHERE `locale` = 'deDE' AND `entry` = 26537;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=26538
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar' WHERE `locale` = 'deDE' AND `entry` = 26538;
-- OLD subname : Zeppelinmeisterin, Heulender Fjord
-- Source : https://www.wowhead.com/wotlk/de/npc=26539
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, heulender Fjord' WHERE `locale` = 'deDE' AND `entry` = 26539;
-- OLD name : Zab Dampfbolz, subname : Zeppelinmeister, Heulender Fjord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26541
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26541;
-- OLD name : Lini Laschenbolz, subname : Zeppelinmeister, Boreanische Tundra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26542
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26542;
-- OLD name : Hansrick Stämmig, subname : Dockmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26551
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26551;
-- OLD name : Maye Pfeifer, subname : Dockmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26552
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26552;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 26564;
-- OLD name : Eingekerkerter Affe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26571
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26571;
-- OLD name : Verweilender Bewohner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26573
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26573;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26576;
-- OLD name : Hase der Grizzlyhügel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26587;
-- OLD name : Transformation der spirituellen Einsicht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26594
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26594;
-- OLD name : Burninate Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26612;
-- OLD name : Grunzer Tar'yug (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26617;
-- OLD name : Fallschirmjäger von Kurbelzisch
-- Source : https://www.wowhead.com/wotlk/de/npc=26619
UPDATE `creature_template_locale` SET `Name` = 'Fallschirmspringer von Kurbelzisch' WHERE `locale` = 'deDE' AND `entry` = 26619;
-- OLD name : Kondor names Shirrak (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26665;
-- OLD name : Blutdürstiger Tundrawolf
-- Source : https://www.wowhead.com/wotlk/de/npc=26672
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Tundrawolf' WHERE `locale` = 'deDE' AND `entry` = 26672;
-- OLD name : Jormungarfleisch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26699
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26699;
-- OLD name : Verseuchtes Orakel der Drakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26702
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26702;
-- OLD name : Verseuchter Kriegshetzer der Drakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26703
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26703;
-- OLD name : Versuchsobjekt der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26713;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26724;
-- OLD name : Windelementar der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26726
UPDATE `creature_template_locale` SET `Name` = 'Windelementar der boreanischen Tundra' WHERE `locale` = 'deDE' AND `entry` = 26726;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26732;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26765;
-- OLD name : Kriegerheld Sturmhimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=26766
UPDATE `creature_template_locale` SET `Name` = 'Tapfer Sturmhimmel' WHERE `locale` = 'deDE' AND `entry` = 26766;
-- OLD name : The Focus on the Beach Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26773
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26773;
-- OLD name : Klerikerin der 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=26780
UPDATE `creature_template_locale` SET `Name` = 'Kleriker der 7. Legion' WHERE `locale` = 'deDE' AND `entry` = 26780;
-- OLD name : Dan's Test Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26784
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26784;
-- OLD subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/de/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'deDE',NULL,'Leben dieben');
-- OLD name : Waldläuferin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=26802
UPDATE `creature_template_locale` SET `Name` = 'Waldläufer der Allianz' WHERE `locale` = 'deDE' AND `entry` = 26802;
-- OLD name : Verwandelte Fallenstellerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26819
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26819;
-- OLD name : Gesandter Ducal
-- Source : https://www.wowhead.com/wotlk/de/npc=26821
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Ducal' WHERE `locale` = 'deDE' AND `entry` = 26821;
-- OLD name : Rasender Worgen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26829
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26829;
-- OLD name : Atop the Woodlands Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26831
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26831;
-- OLD name : Aufgeschrecktes Schlachtross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26833
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26833;
-- OLD name : Schaufelhaueraasfresser der Drachenöde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26835;
-- OLD name : Frostwyrm der Horde der Drachenöde mit Namen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26840;
-- OLD name : [PH] Vanguard Landing Flight Master, subname : Windreitermeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26842
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26842;
-- OLD name : Kareg, subname : Windreitermeisterin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26846
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26846;
-- OLD name : Erdwächter Graif
-- Source : https://www.wowhead.com/wotlk/de/npc=26854
UPDATE `creature_template_locale` SET `Name` = 'Erdenwächter Graif' WHERE `locale` = 'deDE' AND `entry` = 26854;
-- OLD name : Arktischer Grizzly (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26882;
-- OLD name : The End of the Line Ley Line Focus Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26887
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26887;
-- OLD name : Kartograf Tobias (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26888
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26888;
-- OLD name : TEST ESCORTEE - LAB (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26894
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26894;
-- OLD name : Schneewehenelch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26895
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26895;
-- OLD name : Gnom (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26897
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26897;
-- OLD name : Reitdrache, rot (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26899
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26899;
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
-- OLD name : Warlord Jin'gom Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26927
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26927;
-- OLD name : Blutbanns Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26931
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26931;
-- OLD name : Vix Chromblaster, subname : Händler für Selbsthilfebücher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26947
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26947;
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
-- OLD name : Frostbruttöter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26967
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26967;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schneiderei' WHERE `locale` = 'deDE' AND `entry` = 26969;
-- OLD name : Kleintiertransformation von Großmagistrix Telestra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=26970
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26970;
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
-- OLD name : Baumeister Stumpi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27014
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27014;
-- OLD name : Baumeister Stümpi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27015
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27015;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 27023;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 27029;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 27034;
-- OLD name : Schreckenslord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27036
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27036;
-- OLD name : Aufgeladener Kriegsgolem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27049
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27049;
-- OLD name : Belagerungspanzer der Horde 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27103;
-- OLD name : Belagerungspanzer der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27104;
-- OLD name : Verletzter Stellvertreter des Kriegshymnenklans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27109
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27109;
-- OLD name : Blighted Elk Liquid Fire of Elune Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27111
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27111;
-- OLD name : Rabid Grizzly Liquid Fire of Elune Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27112
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27112;
-- OLD name : Blackriver Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27121
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27121;
-- OLD name : Kriegerheld von Oneqwah
-- Source : https://www.wowhead.com/wotlk/de/npc=27126
UPDATE `creature_template_locale` SET `Name` = 'Kriegsheld von Oneqwah' WHERE `locale` = 'deDE' AND `entry` = 27126;
-- OLD name : Hippogryphentaxi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27127
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27127;
-- OLD subname : Rüstungsschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=27134
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied' WHERE `locale` = 'deDE' AND `entry` = 27134;
-- OLD name : Hochkommandant Halford Wyrmbann
-- Source : https://www.wowhead.com/wotlk/de/npc=27136
UPDATE `creature_template_locale` SET `Name` = 'Oberkommandant Halford Wyrmbann' WHERE `locale` = 'deDE' AND `entry` = 27136;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27142
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 27142;
-- OLD name : Test Faction NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27154
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27154;
-- OLD name : Testeinheit der 7. Legion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27168;
-- OLD name : Kriegsmagier von Bernsteinflöz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27170
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27170;
-- OLD name : Fledermaustaxi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27179
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27179;
-- OLD name : Scharlachroter Fußsoldat von Neuherdweiler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27205;
-- OLD name : Scharlachroter Kommandant von Neuherdweiler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27208;
-- OLD name : Folterer LeCraft
-- Source : https://www.wowhead.com/wotlk/de/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Folterer Alphonse' WHERE `locale` = 'deDE' AND `entry` = 27209;
-- OLD name : Pferd des Ansturms (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27214
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27214;
-- OLD name : Scharlachroter Späher von Neuherdweiler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27218;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27222
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel' WHERE `locale` = 'deDE' AND `entry` = 27222;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27223
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel' WHERE `locale` = 'deDE' AND `entry` = 27223;
-- OLD name : Clayton Dubin J, subname : Geprüfte Qualität (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27231
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27231;
-- OLD name : Rogue Test Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27239
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27239;
-- OLD name : Vergessener Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27240
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27240;
-- OLD name : Schutzgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27242
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27242;
-- OLD name : Ergebener Leibwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=27247
UPDATE `creature_template_locale` SET `Name` = 'Andächtiger Leibwächter' WHERE `locale` = 'deDE' AND `entry` = 27247;
-- OLD name : Smaragdgrüner Irrwisch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27252;
-- OLD name : Blighted Last Rites Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27253
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27253;
-- OLD name : Seuchenverbreiter der Geißel (KLEIN) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27257
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27257;
-- OLD name : Smaragdsetzling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27261
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27261;
-- OLD name : Forstmeister Anderhol
-- Source : https://www.wowhead.com/wotlk/de/npc=27277
UPDATE `creature_template_locale` SET `Name` = 'Förstermeister Anderhol' WHERE `locale` = 'deDE' AND `entry` = 27277;
-- OLD name : Let Them Not Rise! Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27280
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27280;
-- OLD name : Begrabener Gefangener (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27282
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27282;
-- OLD name : Fresh Remounts Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27296;
-- OLD name : König Björn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27304
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27304;
-- OLD name : König Haldor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27310
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27310;
-- OLD name : König Ranulf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27311
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27311;
-- OLD name : König Tor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27312
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27312;
-- OLD name : Eisriese (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27313;
-- OLD name : Outhouse Stalker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27323
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27323;
-- OLD name : Outhouse Invisible Man (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27324
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27324;
-- OLD name : Spionagemeisterin Repine
-- Source : https://www.wowhead.com/wotlk/de/npc=27337
UPDATE `creature_template_locale` SET `Name` = 'Spionenmeisterin Repine' WHERE `locale` = 'deDE' AND `entry` = 27337;
-- OLD name : Dan's Test Vehicle 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27338
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27338;
-- OLD name : Stellvertretender hilfloser Dorfbewohner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27341;
-- OLD name : Adeline Kammerer
-- Source : https://www.wowhead.com/wotlk/de/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Fledermausführerin Adeline' WHERE `locale` = 'deDE' AND `entry` = 27344;
-- OLD name : Hilfloser Dorfbauer von Wintergarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27345
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27345;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=27360
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett' WHERE `locale` = 'deDE' AND `entry` = 27360;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=27362
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt' WHERE `locale` = 'deDE' AND `entry` = 27362;
-- OLD name : Schwelender Spuk
-- Source : https://www.wowhead.com/wotlk/de/npc=27363
UPDATE `creature_template_locale` SET `Name` = 'Glimmender Spuk' WHERE `locale` = 'deDE' AND `entry` = 27363;
-- OLD name : Vordrassil Sapling Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27366
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27366;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27368;
-- OLD name : Ursoc Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27372
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27372;
-- OLD name : Chefschreiber Barriga
-- Source : https://www.wowhead.com/wotlk/de/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Chefschreiber Kinnedius' WHERE `locale` = 'deDE' AND `entry` = 27378;
-- OLD name : Angriffsauslöser des Inneren Tores von Wintergarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27380;
-- OLD name : Thel'zan der Dämmerbringer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27384
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27384;
-- OLD name : Fußsoldatenzuschauer der Valianzfeste (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27387;
-- OLD name : Torture the Torturer Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27394
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27394;
-- OLD name : Taifun (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27395
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27395;
-- OLD name : Kill Credit Bunny - Shredder Delivery (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27396
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27396;
-- OLD name : Rocket Mount (Log Ride Test) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27397
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27397;
-- OLD name : Utgarde Duo Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27404
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27404;
-- OLD name : The Perfect Dissemblance Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27419
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27419;
-- OLD name : Rothins nekromantisches Runenhäschen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27420;
-- OLD name : Commander Jordan Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27426
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27426;
-- OLD name : Lead Cannoneer Zierhut Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27427;
-- OLD name : Blacksmith Goodman Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27428;
-- OLD name : Stable Master Mercer Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27429
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27429;
-- OLD name : Bild eines Scharlachroten Rabenpriesters - Weibliche Transformation (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27442
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27442;
-- OLD name : Bild eines Scharlachroten Rabenpriesters - Männliche Transformation (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27443
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27443;
-- OLD name : A Fall from Grace High Abbot Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27444;
-- OLD name : A Fall from Grace Bell Rung Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27445
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27445;
-- OLD name : Sprungvehikel des Hohen Abtes Landgren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27446
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27446;
-- OLD name : Blue Sky Kill Credit Bunny - Grizzly Hills (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27453
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27453;
-- OLD name : Kill Credit Bunny - Wounded Skirmishers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27466
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27466;
-- OLD name : Forgotten Rifleman Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27471
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27471;
-- OLD name : Forgotten Peasant Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27472;
-- OLD name : Forgotten Knight Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27473
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27473;
-- OLD name : Captain Luc D'Merud Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27474
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27474;
-- OLD name : Greifentaxi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27491
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27491;
-- OLD name : Greifenreiter von Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27504
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27504;
-- OLD name : Aufgezogener Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27505
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27505;
-- OLD name : Gaststättenratte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27522
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27522;
-- OLD name : Weißer gepanzerter Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27526
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27526;
-- OLD name : Pinguin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27548
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27548;
-- OLD name : Undead Miner Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27561
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27561;
-- OLD name : Zenturio Kaggrum
-- Source : https://www.wowhead.com/wotlk/de/npc=27563
UPDATE `creature_template_locale` SET `Name` = 'Zenturion Kaggrum' WHERE `locale` = 'deDE' AND `entry` = 27563;
-- OLD name : Ställe der Venture Co. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27568
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27568;
-- OLD name : Lord Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/de/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Lord Devrestrasz' WHERE `locale` = 'deDE' AND `entry` = 27575;
-- OLD name : Beschwörungsziel von Novos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27583
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27583;
-- OLD name : QA Testdummy 80 Normal, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27586;
-- OLD name : QA Testdummy 80 Keine Rüstung, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27590
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27590;
-- OLD name : QA Testdummy 80 Keine Rüstung, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27591
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27591;
-- OLD name : QA Testdummy 83 Normal, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27592
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27592;
-- OLD name : QA Testdummy 80 Hohe Magieresi, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27595
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27595;
-- OLD name : QA Testdummy 83 Hohe Magieresi, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27596
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27596;
-- OLD name : QA Testdummy 80 Statischer Schaden, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27599
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27599;
-- OLD name : QA Testdummy 83 Statischer Schaden, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27601
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27601;
-- OLD name : QA Testdummy 80 Zauberspammer, subname : QA Prügelknabe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27609
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27609;
-- OLD name : Totenbeschwörer von Jintha'kalar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27614;
-- OLD name : Abbild des Lichkönigs (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27623
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27623;
-- OLD name : Plague Wagon Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27625
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27625;
-- OLD name : Gruftbestie der Pforte des Zorns (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27630
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27630;
-- OLD name : Tatjana, subname : Initiand des Wolfskults (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27632;
-- OLD name : Wolfsgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27634;
-- OLD name : Tempelrufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27643;
-- OLD name : Kill Credit Bunny - Venture Bay 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27660
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27660;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27666
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 27666;
-- OLD name : Zauberatrappe von Novos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27669
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27669;
-- OLD name : Annäherungsmine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27679
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27679;
-- OLD name : Verteidiger des Wyrmruhtempels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27690
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27690;
-- OLD name : Spielerskelett (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27694
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27694;
-- OLD name : Der Prophet Tharon'ja (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27696
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27696;
-- OLD name : Reitkodo des Braufests
-- Source : https://www.wowhead.com/wotlk/de/npc=27706
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo des Brausfests' WHERE `locale` = 'deDE' AND `entry` = 27706;
-- OLD name : Goblin Rocket Mount Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27710
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27710;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27723;
-- OLD name : Reitfledermaus der Drakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27724
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27724;
-- OLD name : Gorgonna (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27726
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27726;
-- OLD name : Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=27731
UPDATE `creature_template_locale` SET `Name` = 'Akolyt' WHERE `locale` = 'deDE' AND `entry` = 27731;
-- OLD name : Frostsäbelvehikel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27738;
-- OLD name : Vehikelversion des Wildelekks (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27740
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27740;
-- OLD name : Currency Token Test Wizard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27741;
-- OLD name : Eindringling der Drakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27754
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27754;
-- OLD name : Greif von Wintergarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27764
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27764;
-- OLD name : Späherhauptmann Carter
-- Source : https://www.wowhead.com/wotlk/de/npc=27783
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Carter' WHERE `locale` = 'deDE' AND `entry` = 27783;
-- OLD name : Imperial Eagle Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27786
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27786;
-- OLD name : Worg's Blood Elixir Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27796
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27796;
-- OLD name : Orb Target Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27802
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27802;
-- OLD name : Bierschankwirtin
-- Source : https://www.wowhead.com/wotlk/de/npc=27819
UPDATE `creature_template_locale` SET `Name` = 'Bierschankwirt' WHERE `locale` = 'deDE' AND `entry` = 27819;
-- OLD name : Stellvertretende Mausoleumsgeißel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27825
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27825;
-- OLD name : Glengarry Adams, subname : 7. Legion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27833
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27833;
-- OLD name : Schattengeistwächter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27834
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27834;
-- OLD name : Kampfflugzeug von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27838
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27838;
-- OLD name : Greif von Wintergarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27841;
-- OLD name : Schattenleere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27847
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27847;
-- OLD name : Bomber von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27850
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27850;
-- OLD name : Fahrzeug der verpesteten Zombies (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27854
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27854;
-- OLD name : Patty's test vehicle TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27862
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27862;
-- OLD name : Rubinblüten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27863
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27863;
-- OLD name : Fangkrallenworgverkleidung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27864
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27864;
-- OLD name : Verseuchtes Haustier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27865
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27865;
-- OLD name : Reitwyvern der Kor'kron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27873
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27873;
-- OLD name : Onslaught Base Camp Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27875
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27875;
-- OLD name : Landmine von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27878
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27878;
-- OLD name : Frostmourne Cavern Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27879
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27879;
-- OLD name : Waffenhalter von Frostgram (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27880
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27880;
-- OLD name : Gebräublase
-- Source : https://www.wowhead.com/wotlk/de/npc=27882
UPDATE `creature_template_locale` SET `Name` = 'Bierblase' WHERE `locale` = 'deDE' AND `entry` = 27882;
-- OLD name : Schredder von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27883;
-- OLD name : Taking Wing Timer Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27889
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27889;
-- OLD name : Feuerklagegeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27895
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27895;
-- OLD name : Bombercockpit von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27905
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27905;
-- OLD name : World Death Knight Trainer, subname : Todesritterlehrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27916
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27916;
-- OLD name : Rekrutierer der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27917
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27917;
-- OLD name : Rekrutierer der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27918
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27918;
-- OLD name : Herold der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27919
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27919;
-- OLD name : Herold der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27920
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27920;
-- OLD name : Drakuru Handshake KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27921
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27921;
-- OLD name : Mummified Carcass KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27929
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27929;
-- OLD name : Orf der Steuermann (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27937
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27937;
-- OLD name : Ice Spike Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27942
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27942;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (rot) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27952
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27952;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (grün) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27954
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27954;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (bronze) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27955
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27955;
-- OLD name : Dan's Test Turret (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27956
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27956;
-- OLD name : Dunkler Runenbewahrer, subname : PH MODEL: TASK 17271 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27968
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27968;
-- OLD name : Reittier des Sphärenjägers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27976;
-- OLD name : Prototyp der Flugscheibe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27991
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27991;
-- OLD name : Leutnant Eishammer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27994
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27994;
-- OLD name : The Gearmaster's Manual Researched Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27995
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27995;
-- OLD name : Test-PvP-Questgeber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=27997
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27997;
-- OLD name : Antioks Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28007
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28007;
-- OLD name : Fire Upon the Waters Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28013
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28013;
-- OLD name : Escape from Silverbrook Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28019
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28019;
-- OLD name : Bezwinger den Wyrmruhtempels (Knochen) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28021
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28021;
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
-- OLD name : Moveto Test - Bewegungen, subname : Expeditionsleiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28088;
-- OLD name : Theresas Frostsäblergefährt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28119
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28119;
-- OLD name : Nahrung der Grannenkiefer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28128;
-- OLD name : Hirnlose Entartung (nicht tötbar) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28144
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28144;
-- OLD name : Geißelherzdrakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28159
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28159;
-- OLD name : Kunz' Schlachtross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28172
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28172;
-- OLD name : Trauerleere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28174
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28174;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=28177
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 28177;
-- OLD name : Venture Bay Kill Credit Bunny - Grizzly Hills (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28190
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28190;
-- OLD name : Raketenwerfer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28198
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28198;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28206;
-- OLD name : Hartknöchelmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=28213
UPDATE `creature_template_locale` SET `Name` = 'Hartknöchelmatriachin' WHERE `locale` = 'deDE' AND `entry` = 28213;
-- OLD name : Falltürkrabbler - Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28224
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28224;
-- OLD name : Blutgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28232
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28232;
-- OLD name : Luftüberwachung der Venture Co. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28241
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28241;
-- OLD name : QA Test First Aid Trainer, subname : Sanitäter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28245
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28245;
-- OLD name : Alchemist KC - Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28248
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28248;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Schwarz) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28250
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28250;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Blau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28251
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28251;
-- OLD name : Bild eines Beschützers des Wyrmruhtempels (Nether) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28252;
-- OLD name : Besiegter Argentumfußsoldat (transformiert) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28259
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28259;
-- OLD name : Koyotengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=28267
UPDATE `creature_template_locale` SET `Name` = 'Kojotengeist' WHERE `locale` = 'deDE' AND `entry` = 28267;
-- OLD name : Flugmaschine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28269
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28269;
-- OLD name : Geißel von Jintha'kalar (PROXY DO NOT SPAWN) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28270
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28270;
-- OLD name : Glacial Breach Scourge Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28271
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28271;
-- OLD name : Gefräßiger Seuchenhund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28278
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28278;
-- OLD name : Belohnung für Seuchenspritzers Tod (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28289
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28289;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28292;
-- OLD name : Schlammige Moormaden - KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28293;
-- OLD name : Getrockneter Fledermausflügel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28294
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28294;
-- OLD name : Bernsteinsamen - KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28295
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28295;
-- OLD name : Gekühlter Schlangenschleim (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28296;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=28306
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone' WHERE `locale` = 'deDE' AND `entry` = 28306;
-- OLD name : QA Test Dummy 80 Buff Spammer, subname : QA Punching Bag (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28310
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28310;
-- OLD name : QA Test Dummy 80 Spell Reflector, subname : QA Punching Bag (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28311
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28311;
-- OLD name : Besiegter Argentumfußsoldat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28316
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28316;
-- OLD name : Entflohener Gladiator (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28322
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28322;
-- OLD name : Auferstandener Vrykulberserker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28349
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28349;
-- OLD name : Auferstandener Vrykulmagus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28350
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28350;
-- OLD name : Seuchenverbreiter der Verlassenen (Rot) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28353
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28353;
-- OLD name : Wissenschaftler der Verlassenen (Seuchenrucksack) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28354
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28354;
-- OLD name : Kurbelzischs Flugtaxi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28360;
-- OLD name : Drachenfalke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28361;
-- OLD name : Großer Kampfbär
-- Source : https://www.wowhead.com/wotlk/de/npc=28363
UPDATE `creature_template_locale` SET `Name` = 'Großer Kriegsbär' WHERE `locale` = 'deDE' AND `entry` = 28363;
-- OLD name : Slims Testmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28364
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28364;
-- OLD name : Slims Testhexenmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28365
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28365;
-- OLD name : Belagerungsingenieur der 7. Legion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28370
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28370;
-- OLD name : TR (Mensch, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28395
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28395;
-- OLD name : Lederverarbeitungslehrer von Nordend, subname : Lederverarbeitungslehrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28400
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28400;
-- OLD name : TR (Mensch, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28420;
-- OLD name : TR (Zwerg, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28421
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28421;
-- OLD name : TR (Gnom, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28422
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28422;
-- OLD name : TR (Nachtelf, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28423
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28423;
-- OLD name : TR (Draenei, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28424
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28424;
-- OLD name : TR (Zwerg, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28425
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28425;
-- OLD name : TR (Gnom, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28426
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28426;
-- OLD name : TR (Nachtelf, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28427;
-- OLD name : TR (Draenei, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28428;
-- OLD name : TR (Blutelf, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28429
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28429;
-- OLD name : TR (Orc, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28430
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28430;
-- OLD name : TR (Verlassener, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28431
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28431;
-- OLD name : TR (Troll, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28432
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28432;
-- OLD name : TR (Tauren, Mann) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28433
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28433;
-- OLD name : TR (Blutelf, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28434
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28434;
-- OLD name : TR (Troll, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28435
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28435;
-- OLD name : TR (Orc, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28436
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28436;
-- OLD name : TR (Verlassener, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28437
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28437;
-- OLD name : TR (Tauren, Frau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28438
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28438;
-- OLD name : Großer Uhu (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28441
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28441;
-- OLD name : Entfesseltes Streitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28450
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28450;
-- OLD name : Riding Horse (Vehicle Demo) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28453
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28453;
-- OLD name : Altar von Quetz'lun (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28469;
-- OLD name : Runenklingenaxt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28475
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28475;
-- OLD name : Avatar von Freya (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28482
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28482;
-- OLD name : Runenschmied (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28483
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28483;
-- OLD name : Sindragosa, subname : Die Königin der Frostbrut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28499
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28499;
-- OLD name : Summon Vision Test - LAB (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28507
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28507;
-- OLD name : Gebäude (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28509
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28509;
-- OLD name : Hair Sample KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28520
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28520;
-- OLD name : Frostwyrmreittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28531
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28531;
-- OLD name : Reitpferd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28533;
-- OLD name : Destillo-matik 5000 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28545
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28545;
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
-- OLD name : Geißelverkleidung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28570
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28570;
-- OLD name : Maurermeisterin van der Gülden
-- Source : https://www.wowhead.com/wotlk/de/npc=28572
UPDATE `creature_template_locale` SET `Name` = 'Maurermeister van der Gülden' WHERE `locale` = 'deDE' AND `entry` = 28572;
-- OLD name : Corpse Explosion Rubble (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28590
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28590;
-- OLD name : Freyas Horn Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28595
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28595;
-- OLD name : Akolyth der Todeshand
-- Source : https://www.wowhead.com/wotlk/de/npc=28602
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Todeshand' WHERE `locale` = 'deDE' AND `entry` = 28602;
-- OLD name : Wolfsreiter von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28613;
-- OLD name : Reitpferd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28620
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28620;
-- OLD name : Grauson Eisenschwinge, subname : Flugmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28621
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28621;
-- OLD name : Scalps! Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28622
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28622;
-- OLD name : Gyrokopter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28625
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28625;
-- OLD name : Scharlachroter Arbeiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28626
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28626;
-- OLD name : Slims Testpriester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28628
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28628;
-- OLD name : Slims Testkrieger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28629
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28629;
-- OLD name : Drakuru KC Bunny 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28631
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28631;
-- OLD name : Geisterwolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28635
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28635;
-- OLD name : Mosswalker Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28644;
-- OLD name : Vics selbstreplizierende Monstrosität (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28645
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28645;
-- OLD name : Mysteriöser Zigeuner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28652
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28652;
-- OLD name : Gorebag KC Bunny 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28663
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28663;
-- OLD name : Seat Squatter - LAB (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28664
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28664;
-- OLD name : Kassiererin Halder, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28678
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28678;
-- OLD name : Kassiererin Duta, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28679
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28679;
-- OLD name : Kassierer Banner, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28680
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28680;
-- OLD name : Scharlachroter Stallknecht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28689
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28689;
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
-- OLD name : Untoter Adler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28711
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28711;
-- OLD name : Einfache Plünderpiñata, subname : Schlag mich! (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28712
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28712;
-- OLD name : Quetz'lun Troll Worshipper Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28713;
-- OLD name : Seelenbrunnenzone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=28719
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone des Seelenbrunnens' WHERE `locale` = 'deDE' AND `entry` = 28719;
-- OLD name : Plünderpiñata für Erste Hilfe, subname : Schlag mich! (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28720
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28720;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28721
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf' WHERE `locale` = 'deDE' AND `entry` = 28721;
-- OLD name : Alte Nelly (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28737
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28737;
-- OLD name : Drakuru KC Bunny 00 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28738;
-- OLD name : Blight Crystal KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28740
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28740;
-- OLD name : Blight Cauldron KC Bunny 02 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28741;
-- OLD subname : Angellehrerin & Angelbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Angelns & Angelbedarf' WHERE `locale` = 'deDE' AND `entry` = 28742;
-- OLD name : Slims untötbarer Boss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28744;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 28746;
-- OLD name : Froststeingargoyle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28749;
-- OLD name : High Priest Mu'funu Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28753;
-- OLD name : High Priestess Tua-Tua Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28755
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28755;
-- OLD name : High Priest Hawinni Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28757;
-- OLD name : Reconnaisaince Flight Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28758;
-- OLD name : Hargus der Krüppel
-- Source : https://www.wowhead.com/wotlk/de/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Hargus der Spuk' WHERE `locale` = 'deDE' AND `entry` = 28760;
-- OLD name : Drakuru KC Bunny 02 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28762
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28762;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28767;
-- OLD name : Schattenhafter Peiniger
-- Source : https://www.wowhead.com/wotlk/de/npc=28769
UPDATE `creature_template_locale` SET `Name` = 'Schattenhafter Foltermeister' WHERE `locale` = 'deDE' AND `entry` = 28769;
-- OLD name : High Priestess Tua-Tua Hex of Fire Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28770
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28770;
-- OLD name : High Priest Hawinni Hex of Frost Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28773
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28773;
-- OLD name : Dunkler Reiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28775
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28775;
-- OLD name : Catapult KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28777
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28777;
-- OLD name : Reitgreif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28783
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28783;
-- OLD name : Drakuru KC Bunny 03 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28786
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28786;
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
-- OLD name : Destructive Ward Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28820;
-- OLD name : Minenwagen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28842
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28842;
-- OLD name : Scharlachrote Flotte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28849
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28849;
-- OLD name : Toter Jünger von Mam'toth (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28853;
-- OLD name : Scharlachroter Flottenverteidiger
-- Source : https://www.wowhead.com/wotlk/de/npc=28856
UPDATE `creature_template_locale` SET `Name` = 'Wächter der Scharlachroten Flotte' WHERE `locale` = 'deDE' AND `entry` = 28856;
-- OLD name : Mam'toth Disciple Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28876
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28876;
-- OLD name : Testeisenzwerg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28880
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28880;
-- OLD name : Scharlachrote Kanone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28887
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28887;
-- OLD name : Scharlachroter Greifenreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28894
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28894;
-- OLD name : Scharlachroter Hauptmann
-- Source : https://www.wowhead.com/wotlk/de/npc=28898
UPDATE `creature_template_locale` SET `Name` = 'Schalachroter Hauptmann' WHERE `locale` = 'deDE' AND `entry` = 28898;
-- OLD name : Stute aus Havenau (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28899
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28899;
-- OLD name : Hengst aus Havenau (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28900
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28900;
-- OLD name : Reittier des dunklen Reiters (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28915
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28915;
-- OLD name : Drakuru KC Bunny 04 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28928
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28928;
-- OLD name : Drakuru's Upper Chamber Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28929
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28929;
-- OLD name : Der Schreiber, subname : Designer extraordinaire (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28944
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28944;
-- OLD name : Spell Performance Test Caster, subname : QA-Sandsack (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28949
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28949;
-- OLD name : Spell Performance Test Target, subname : QA-Sandsack (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28950
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28950;
-- OLD name : Unkillable Test Dummy 70 Gnome (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28953
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28953;
-- OLD name : Unkillable Test Dummy 70 Tauren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28954
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28954;
-- OLD name : Unkillable Test Dummy 70 Dwarf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28955
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28955;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28957;
-- OLD name : Scharlachroter Lord Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/de/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Lord Borugh' WHERE `locale` = 'deDE' AND `entry` = 28964;
-- OLD name : Stellvertretender Scharlachroter Kreuzfahrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28984
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28984;
-- OLD name : Stellvertretender Bürger von Neu-Avalon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=28986
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28986;
-- OLD name : Frostvrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29002
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29002;
-- OLD name : Frostvrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29003
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29003;
-- OLD name : Frostvrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29004
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29004;
-- OLD name : Purpurroter Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=29007
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Akolyt' WHERE `locale` = 'deDE' AND `entry` = 29007;
-- OLD name : Monsoon Revenant Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29008
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29008;
-- OLD name : Storm Revenant Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29009
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29009;
-- OLD name : Antimagische Barriere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29010
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29010;
-- OLD subname : Bogenmacher
-- Source : https://www.wowhead.com/wotlk/de/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacher' WHERE `locale` = 'deDE' AND `entry` = 29014;
-- OLD name : Dockarbeiter mit Tasche (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29020;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29025;
-- OLD name : Greif von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29039;
-- OLD name : Blutklauenmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=29044
UPDATE `creature_template_locale` SET `Name` = 'Blutklauenmatriarch' WHERE `locale` = 'deDE' AND `entry` = 29044;
-- OLD name : Das ist'n Chopper, Baby (Horde), subname : Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29045
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29045;
-- OLD name : Das ist'n Chopper, Baby (Allianz), subname : Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29046
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29046;
-- OLD name : Unsichtbare Plumsklofrau (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29052
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29052;
-- OLD name : Missile Test Mob (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29054
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29054;
-- OLD name : Horn of Fecundity Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29055
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29055;
-- OLD name : Craig - TEST - Iron Dwarf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29059
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29059;
-- OLD name : Crusader Parachute Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29060;
-- OLD name : QA Test Dummy 73 Raid Debuff (Low Armor) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29075
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29075;
-- OLD name : PattyMacks The Duece (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29083
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29083;
-- OLD name : Drakkari Skullcrusher KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29099
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29099;
-- OLD name : Kriegsmaid der Val'kyr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29111
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29111;
-- OLD name : Hochkommandant Galvar Reinblut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29114
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29114;
-- OLD name : Klagende Drakkariseele (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29135
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29135;
-- OLD name : Camera Shaker - 20-40 seconds (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29140
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29140;
-- OLD name : Stellvertretender Scharlachroter Soldat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29150
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29150;
-- OLD name : Test Scaling Vendor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29163
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29163;
-- OLD name : Teleporter der Hallen des Steins (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29165;
-- OLD name : Kunz Jr. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29171
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29171;
-- OLD name : Seucheneruptor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29187
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29187;
-- OLD name : Eisgespenst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29188
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29188;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29192;
-- OLD name : Gefrorener Schemen, Höhepunkt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29197
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29197;
-- OLD name : Mograines Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29198
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29198;
-- OLD name : Reittier eines Todesritters (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29201;
-- OLD subname : Reagenzienverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Leichenstaubverkäufer' WHERE `locale` = 'deDE' AND `entry` = 29203;
-- OLD name : Jünger des unheiligen Häschens (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29215
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29215;
-- OLD name : Cenarischer Späher
-- Source : https://www.wowhead.com/wotlk/de/npc=29220
UPDATE `creature_template_locale` SET `Name` = 'Aufklärer des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 29220;
-- OLD name : Reittier eines Todesritters (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29221
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29221;
-- OLD name : Präsenz von Yogg-Saron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29224
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29224;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=29225
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone' WHERE `locale` = 'deDE' AND `entry` = 29225;
-- OLD name : Niederes Schattenkonstrukt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29230;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe' WHERE `locale` = 'deDE' AND `entry` = 29233;
-- OLD name : Kampfmeister des Strands der Uralten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29234
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29234;
-- OLD name : Licht der Morgendämmerung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29245;
-- OLD name : Omar the Test Dragon Gen2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29257
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29257;
-- OLD name : Omar's accumulator bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29258
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29258;
-- OLD name : PattyMacks schwebende Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29263;
-- OLD name : Ballrückstoß, subname : <Schlag mich!> (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29265;
-- OLD name : Zwergischer Golem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29272
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29272;
-- OLD name : Zahlmeister Habert, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29283
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29283;
-- OLD name : Lebensblutelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29303
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29303;
-- OLD name : Cyanigosa (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29317
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29317;
-- OLD name : Arenakampfmeister von Dalaran, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29318
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29318;
-- OLD name : Sturmmaid (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29320
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29320;
-- OLD name : Sturmmaid - Zauberin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29322
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29322;
-- OLD name : Argentumritter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29336
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29336;
-- OLD name : Sybille (Bogenschützin) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29342
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29342;
-- OLD name : Banner der Argentumdämmerung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29345
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29345;
-- OLD name : Apotheker Chaney, subname : Alchemiebedarf & Gifte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29348
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29348;
-- OLD name : Eisläufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29361;
-- OLD name : Sekretkugel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29367
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29367;
-- OLD name : Zwielichtdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29372
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29372;
-- OLD name : Beobachterin von Brunnhildar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29378
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29378;
-- OLD name : QA Arena Master: Blade's Edge, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29381
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29381;
-- OLD name : QA Arena Master: Nagrand Arena, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29383
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29383;
-- OLD name : QA Arena Master: Ruins of Lordaeron, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29385
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29385;
-- OLD name : QA Arena Master: Orgrimmar Arena, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29386;
-- OLD name : QA Arena Master: Dalaran Arena, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29387
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29387;
-- OLD name : Ausgehungerter Hai (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29391
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29391;
-- OLD name : Land Mine Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29397
UPDATE `creature_template_locale` SET `Name` = 'Landminenhäschen' WHERE `locale` = 'deDE' AND `entry` = 29397;
-- OLD name : From Their Corpses, Rise! Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29398
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29398;
-- OLD name : Da brauchst du noch ein Greiftötungskredithäschen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29406
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29406;
-- OLD name : Garmräuber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29408
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29408;
-- OLD name : Gluth (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29417
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29417;
-- OLD name : Beschwörungstester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29423
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29423;
-- OLD name : Sybille (Unbewaffnet) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29435
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29435;
-- OLD name : Leutnant Kregor, subname : Die Argentumdämmerung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29442
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29442;
-- OLD name : Troll der Drakkari (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29471
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29471;
-- OLD name : Argentumkreuzfahrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29472;
-- OLD name : Reitskelettgreif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29474
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29474;
-- OLD name : Haustierskunk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29482
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29482;
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
-- OLD name : Mammutfleischhäschen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29524
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29524;
-- OLD name : Sholazar Daily Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29526
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29526;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29539
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29539;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29540
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29540;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29541
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29541;
-- OLD name : Arete's Gate Summoned Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29550
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29550;
-- OLD name : Garmräuber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29552
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29552;
-- OLD name : Drachenreiterin von Valkyrion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29591
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29591;
-- OLD name : Frostworg KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29595
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29595;
-- OLD name : Frost Giant KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29597
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29597;
-- OLD name : Jorwyrgan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29610;
-- OLD name : Eiszahn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29616
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29616;
-- OLD name : Grand Admiral Westwind Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29627
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29627;
-- OLD name : Owen Testkreatur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29629
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29629;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst' WHERE `locale` = 'deDE' AND `entry` = 29631;
-- OLD name : Mechanischer Anzug ZX-5103 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29645
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29645;
-- OLD name : Rhinozeros von Gal'darah, subname : Hochprophet von Akali (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29681
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29681;
-- OLD name : Mei (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29711
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29711;
-- OLD name : Befreite Brunnhildar, subname : PH Textur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29734
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29734;
-- OLD name : Fass voller Spaß (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29737
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29737;
-- OLD name : Sichtbares Moorabimammut, subname : Hochprophet des Man'toth (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29741;
-- OLD name : Morgana Tagesglanz, subname : Flugmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29749;
-- OLD name : Veranus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29756
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29756;
-- OLD name : Kosmetisches Windtotem der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29758;
-- OLD name : Kosmetisches Erdtotem der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29759
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29759;
-- OLD name : Kosmetisches Feuertotem der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29760
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29760;
-- OLD name : Kosmetisches Wassertotem der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29761
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29761;
-- OLD name : Spektraler Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29767;
-- OLD name : ELM General Purpose Bunny Large (Phase I) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29773
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29773;
-- OLD name : Irrwisch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29776
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29776;
-- OLD name : The Ocular - Eye of C'Thun Transform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29789
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29789;
-- OLD name : Drachenreiter des Hildarthings (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29800;
-- OLD name : The Ocular Destroyed Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29803
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29803;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29807;
-- OLD name : Schilfs verbessertes Exoskelett (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29810
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29810;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29812;
-- OLD name : Todesstreitross von Naxxramas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29814
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29814;
-- OLD name : Chain Swing Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29815
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29815;
-- OLD name : Eagle Feeding Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29816
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29816;
-- OLD name : Merdel, subname : Funksockels Stolz und Freude (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29841;
-- OLD name : Vile Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29845
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29845;
-- OLD name : Lady Nightswood Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29846
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29846;
-- OLD name : The Leaper Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29847
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29847;
-- OLD name : Lo'Gosh, subname : Der Geisterwolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29850
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29850;
-- OLD name : Exemplar eines Ritters von Lordaeron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29864
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29864;
-- OLD name : Exemplar eines Jungen von Stratholme
-- Source : https://www.wowhead.com/wotlk/de/npc=29868
UPDATE `creature_template_locale` SET `Name` = 'Exemplar eines Kindes von Stratholme' WHERE `locale` = 'deDE' AND `entry` = 29868;
-- OLD name : Persistence Waypoint 00 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29870
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29870;
-- OLD name : Persistence Waypoint 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29871
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29871;
-- OLD name : ELM General Purpose Bunny (Phase I) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29876
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29876;
-- OLD name : ELM General Purpose Bunny (scale x0.01 - Phase I) Large (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29877
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29877;
-- OLD name : Log Ride (Log A) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29878
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29878;
-- OLD name : Log Ride (Log B) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29879
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29879;
-- OLD name : Stellvertreter der Vargul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29882;
-- OLD name : Kyles Testfahrzeug (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29883;
-- OLD name : Exhausted Vrykul Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29886
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29886;
-- OLD name : Runenlord der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29891
UPDATE `creature_template_locale` SET `Name` = 'Runenlord' WHERE `locale` = 'deDE' AND `entry` = 29891;
-- OLD name : Seuchenklaue der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29894
UPDATE `creature_template_locale` SET `Name` = 'Vargul Seuchenklaue' WHERE `locale` = 'deDE' AND `entry` = 29894;
-- OLD name : Brüder des Sturms (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29896
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29896;
-- OLD name : Kill Credit Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29902
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29902;
-- OLD name : Dan's Test Dummy (Large AOI) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29913
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29913;
-- OLD name : GGOODMAN 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29921
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29921;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst' WHERE `locale` = 'deDE' AND `entry` = 29924;
-- OLD name : Motorrad der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29930
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29930;
-- OLD name : Das Schwein, subname : PH: Name, Modell (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29933
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29933;
-- OLD name : Akolyth der Pein
-- Source : https://www.wowhead.com/wotlk/de/npc=29934
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Pein' WHERE `locale` = 'deDE' AND `entry` = 29934;
-- OLD name : Akolyth des Schmerzes
-- Source : https://www.wowhead.com/wotlk/de/npc=29935
UPDATE `creature_template_locale` SET `Name` = 'Akolyt des Schmerzes' WHERE `locale` = 'deDE' AND `entry` = 29935;
-- OLD name : Algars Reitfrostwyrm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29936;
-- OLD name : Bodenreittier der Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29938
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29938;
-- OLD name : SCOURGE PROXY (PHASED) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29943
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29943;
-- OLD name : Verteidiger von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29949
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29949;
-- OLD name : [UNUSED] [ph] Ulduar Camp (H) Flight Master, subname : Flugmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29952
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29952;
-- OLD name : Haylin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29977
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29977;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29983;
-- OLD name : Zone der Leere X (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29992
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29992;
-- OLD name : Beschwörer der Eisenzwerge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29995
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29995;
-- OLD name : Entweihter Boden V (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=29998
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29998;
-- OLD name : Ferngesteuerter Turbotriebgyrobomber des Todes (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30004
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30004;
-- OLD name : Verpesteter Zombie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30034
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30034;
-- OLD name : Mjordin Combatant Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30038
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30038;
-- OLD name : Irdener Steinstatus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30050
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30050;
-- OLD name : Bibliothekarin Tiare
-- Source : https://www.wowhead.com/wotlk/de/npc=30051
UPDATE `creature_template_locale` SET `Name` = 'Bibliothekar Tiare' WHERE `locale` = 'deDE' AND `entry` = 30051;
-- OLD name : Gefrorene Kugel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30054
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30054;
-- OLD name : Sturmgipfelwyrm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30055
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30055;
-- OLD name : Sichtbarer Wyrmruhwächter (Bronze) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30059
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30059;
-- OLD name : Kel''Thuzad (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30061
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30061;
-- OLD name : Sturmgeschmiedeter Verstärker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30062
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30062;
-- OLD name : Initiandin Claget
-- Source : https://www.wowhead.com/wotlk/de/npc=30067
UPDATE `creature_template_locale` SET `Name` = 'Initiant Claget' WHERE `locale` = 'deDE' AND `entry` = 30067;
-- OLD name : Initiand Roderick
-- Source : https://www.wowhead.com/wotlk/de/npc=30069
UPDATE `creature_template_locale` SET `Name` = 'Initiant Roderick' WHERE `locale` = 'deDE' AND `entry` = 30069;
-- OLD name : Initiand Gahark
-- Source : https://www.wowhead.com/wotlk/de/npc=30070
UPDATE `creature_template_locale` SET `Name` = 'Initiant Gahark' WHERE `locale` = 'deDE' AND `entry` = 30070;
-- OLD name : Sichtbarer Wyrmruhwächter (Rot) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30072
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30072;
-- OLD name : Sichtbarer Wyrmruhwächter (Grün) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30073
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30073;
-- OLD name : Sichtbarer Wyrmruhwächter (Blau) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30076
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30076;
-- OLD name : Sichtbarer Wyrmruhwächter (Schwarz) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30077
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30077;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30078;
-- OLD name : ELM General Purpose Bunny (Phase II) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30079
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30079;
-- OLD name : Willzyx (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30080;
-- OLD name : Gebrochener Zeh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30088;
-- OLD name : Reitmammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30089
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30089;
-- OLD name : WotLK City Attacks Ice Block Bunny, Small (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30101;
-- OLD subname : Waldläufergeneralin des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=30115
UPDATE `creature_template_locale` SET `Title` = 'Waldläufergeneral des Silberbunds' WHERE `locale` = 'deDE' AND `entry` = 30115;
-- OLD name : Vengeful Revenant KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30125
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30125;
-- OLD name : Njormeld KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30126
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30126;
-- OLD name : Veranus Right Foot Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30130;
-- OLD name : Veranus Left Foot Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30131
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30131;
-- OLD name : Veranus Right Wing Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30132
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30132;
-- OLD name : Veranus Left Wing Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30133
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30133;
-- OLD name : Frostriesengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30138
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30138;
-- OLD name : Frostzwerggeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30139
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30139;
-- OLD name : Demo, Kultist der Eiskrone, subname : Kult der Verdammten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30149
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30149;
-- OLD name : Frostbrutzerstörer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30150
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30150;
-- OLD name : Last Chapter Dialogue Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30153
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30153;
-- OLD name : Nicole Morris, subname : Stallmeisterin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30155
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30155;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30156;
-- OLD name : Himmelsklaue des Wyrmruhtempels
-- Source : https://www.wowhead.com/wotlk/de/npc=30161
UPDATE `creature_template_locale` SET `Name` = 'Himmelsklaue von Wyrmruh' WHERE `locale` = 'deDE' AND `entry` = 30161;
-- OLD name : Kampfmeister des Rings der Ehre, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30171
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30171;
-- OLD name : G'eras Test Vendor List (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30201;
-- OLD name : Akolyth der Vergessenen Tiefen
-- Source : https://www.wowhead.com/wotlk/de/npc=30205
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Vergessenen Tiefen' WHERE `locale` = 'deDE' AND `entry` = 30205;
-- OLD name : Hodir's Helm KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30210
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30210;
-- OLD name : Thrall's Big Hit, Lightning Bolt Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30214
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30214;
-- OLD name : Leave Our Mark Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30220
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30220;
-- OLD name : Kirgaraak Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30221
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30221;
-- OLD name : Eisschlundbärenreittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30229
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30229;
-- OLD name : Verletzter Späher der Sonnenhäscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30240
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30240;
-- OLD name : Nexusfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=30245
UPDATE `creature_template_locale` SET `Name` = 'Nexuslord' WHERE `locale` = 'deDE' AND `entry` = 30245;
-- OLD name : Wissenshüter Randvir
-- Source : https://www.wowhead.com/wotlk/de/npc=30252
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Randvir' WHERE `locale` = 'deDE' AND `entry` = 30252;
-- OLD name : Späherhauptmann Daelin
-- Source : https://www.wowhead.com/wotlk/de/npc=30261
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Daelin' WHERE `locale` = 'deDE' AND `entry` = 30261;
-- OLD name : Verletzter Späher des Silberbunds (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30266
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30266;
-- OLD name : Wütender gepanzerter Hippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30280
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30280;
-- OLD name : Verteidiger des Hafens von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30289
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30289;
-- OLD name : Drachenfalke der Sonnenhäscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30290
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30290;
-- OLD name : Hauptmann des Hafens von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30293;
-- OLD name : Iron Sentinel Credit, subname : Diener von Loken (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30296;
-- OLD name : Iron Dwarf Assailant Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30297
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30297;
-- OLD name : Schneller fliegender Besen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30305;
-- OLD name : Jokkum KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30327
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30327;
-- OLD name : Thorim (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30328
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30328;
-- OLD name : Frigid Tomb Controller Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30339;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/de/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorkuttar' WHERE `locale` = 'deDE' AND `entry` = 30340;
-- OLD name : Urahne Sardis (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30348
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30348;
-- OLD name : Allianzwache von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30354
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30354;
-- OLD name : Allianzwache von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30355;
-- OLD name : Urahne Beldak (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30357
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30357;
-- OLD name : Urahne Morthie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30358
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30358;
-- OLD name : Urahne Fargal (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30359
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30359;
-- OLD name : Urahne Northal (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30360;
-- OLD name : Urahne Sandrene (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30362
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30362;
-- OLD name : Urahne Thoim (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30363
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30363;
-- OLD name : Urahne Arp (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30364
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30364;
-- OLD name : Urahne Wanikaya (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30365
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30365;
-- OLD name : Urahne Lunaro (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30367
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30367;
-- OLD name : Urahne Blauwolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30368;
-- OLD name : Urahne Pamuya (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30371
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30371;
-- OLD name : Urahne Whurain (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30372
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30372;
-- OLD name : Urahne Muraco (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30374
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30374;
-- OLD name : Urahne Steinbart (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30375
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30375;
-- OLD name : Ahne der Taunka (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30386;
-- OLD subname : Verwüsteringenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30400
UPDATE `creature_template_locale` SET `Title` = 'Verwüstungsingenieur' WHERE `locale` = 'deDE' AND `entry` = 30400;
-- OLD name : Proxy der vergessenen Tiefen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30402
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30402;
-- OLD name : Deep in the Bowels of The Underhalls Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30412
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30412;
-- OLD name : Wild Wyrm KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30415
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30415;
-- OLD name : Lok'lira die Greisin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30417
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30417;
-- OLD name : Roaming Jormungar KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30421
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30421;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30426
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30426;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30427;
-- OLD name : Fürstin Sylvanas Windläufer, subname : Bansheekönigin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 30437;
-- OLD subname : Gifte, Reagenzien & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=30438
UPDATE `creature_template_locale` SET `Title` = 'Gifte, Reagenzien & Handelswaren' WHERE `locale` = 'deDE' AND `entry` = 30438;
-- OLD name : Hilfsarbeiter des Vorpostens (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30440
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30440;
-- OLD name : Verbrannter Hilfsarbeiter des Vorpostens (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30441
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30441;
-- OLD name : Zaks Flugmaschine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30463
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30463;
-- OLD name : Dans Testleerenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30465
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30465;
-- OLD name : Lok'lira the Crone's Conversation Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30467
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30467;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30476;
-- OLD name : Ritssyn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30491
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30491;
-- OLD name : Gnomeningenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30499
UPDATE `creature_template_locale` SET `Name` = 'Gnomingenieur' WHERE `locale` = 'deDE' AND `entry` = 30499;
-- OLD name : Sturmgeschmiedeter Dezimierer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30503
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30503;
-- OLD name : Sturmgeschmiedeter Kriegshetzer
-- Source : https://www.wowhead.com/wotlk/de/npc=30504
UPDATE `creature_template_locale` SET `Name` = 'Sturmgeschmiedeter Kriegstreiber' WHERE `locale` = 'deDE' AND `entry` = 30504;
-- OLD name : Braufestkodo (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30507
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30507;
-- OLD name : Großmagistrix Telestra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30510
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30510;
-- OLD name : Großmagistrix Telestra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30513
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30513;
-- OLD name : Thorim Talk KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30514
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30514;
-- OLD name : Witness the Reckoning Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30515;
-- OLD name : Urahne Jarten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30531
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30531;
-- OLD name : Urahne Nurgen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30533;
-- OLD name : Urahne Yurauk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30535;
-- OLD name : Urahne Igasho (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30536;
-- OLD name : Urahne Ohanzee (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30537
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30537;
-- OLD name : Zornstoßgargoyle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30545;
-- OLD name : Wiedererweckter Kreuzfahrer, subname : PH MODEL: Task 25946 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30546
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30546;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/de/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'deDE' AND `entry` = 30552;
-- OLD name : Jessica Rotpfad (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30558;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30559;
-- OLD name : Kiste mit Landminen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30563
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30563;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=30570
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 30570;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Munition' WHERE `locale` = 'deDE' AND `entry` = 30572;
-- OLD name : Bethany Aldire, subname : Kampfmeisterin des Strands der Uralten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30578
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30578;
-- OLD name : Buhurda, subname : Kampfmeister des Strands der Uralten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30581;
-- OLD name : Mabrian Morgenferne, subname : Kampfmeister des Strands der Uralten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30584
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30584;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30589;
-- OLD name : Hohepriester der Vergessenen Tiefen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30594;
-- OLD name : Stachelziel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30598
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30598;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/de/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Arenaveranstalterin' WHERE `locale` = 'deDE' AND `entry` = 30611;
-- OLD name : Blutstachel, subname : Mologs Begleiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30613;
-- OLD name : Stachelziel 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30614;
-- OLD name : Dans Testdummy (Non Vehicle) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30615
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30615;
-- OLD name : Peon von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30619
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30619;
-- OLD name : Arbeiter von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30626
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30626;
-- OLD name : Auge von Acherus (TR) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30628
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30628;
-- OLD name : Sterbliche Essenz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30629
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30629;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30640;
-- OLD name : Zwielichtriss
-- Source : https://www.wowhead.com/wotlk/de/npc=30641
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtspalt' WHERE `locale` = 'deDE' AND `entry` = 30641;
-- OLD name : The Art of Being a Water Terror Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30644;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30649;
-- OLD name : Shadron Portal Visual (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30650
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30650;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30655;
-- OLD name : Azurblauer Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Azurblaue Zauberin' WHERE `locale` = 'deDE' AND `entry` = 30667;
-- OLD name : Scourge Proxy Chapter II (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30670
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30670;
-- OLD name : Jonna Robertson, subname : Wegbeschreibungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30678
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30678;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30707;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer' WHERE `locale` = 'deDE' AND `entry` = 30721;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrerin' WHERE `locale` = 'deDE' AND `entry` = 30722;
-- OLD name : Stachelloser Ghul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30728
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30728;
-- OLD name : Tabard Faction Tester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30738;
-- OLD name : Shadronportal (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30741;
-- OLD name : Succubus Transform 01 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30743;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30749;
-- OLD name : Through the Eye Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30750
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30750;
-- OLD name : Teleporter in den Hallen der Blitze (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30828
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30828;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30832;
-- OLD name : Abgetrennte Seele (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30843
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30843;
-- OLD name : Death Gate (Dummy) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30844
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30844;
-- OLD name : Gnomhubschrauber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30853;
-- OLD name : Ingenieur von Tausendwinter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30855
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30855;
-- OLD name : Aura der Unverwundbarkeit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30874
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30874;
-- OLD name : Find the Ancient Hero Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30880
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30880;
-- OLD subname : Überholte Arenarüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Wasserverkäufer' WHERE `locale` = 'deDE' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage, subname : QA Punching Bag (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30888
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30888;
-- OLD name : Ei der Tenebron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30948
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30948;
-- OLD name : Azurblauer Magiertöter
-- Source : https://www.wowhead.com/wotlk/de/npc=30963
UPDATE `creature_template_locale` SET `Name` = 'Azurblauer Pirscher' WHERE `locale` = 'deDE' AND `entry` = 30963;
-- OLD name : Magistrat Barthilas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30994
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30994;
-- OLD name : Kisten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=30996
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30996;
-- OLD name : Mal'Ganis (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31006
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31006;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31014;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=31017
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper' WHERE `locale` = 'deDE' AND `entry` = 31017;
-- OLD name : Olivia Zenith, subname : Schneiderin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31020
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31020;
-- OLD name : Sophie Aaren, subname : Floristin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31021
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31021;
-- OLD name : George Gutmann, subname : Gemischtwaren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31022
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31022;
-- OLD name : Robert Pierce (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31025
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31025;
-- OLD name : Anna Moony, subname : Kellnerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31026
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31026;
-- OLD name : Patricia O'Reilly, subname : Magistratsassistentin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31028
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31028;
-- OLD name : Töter der Vergessenen Tiefen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31038
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31038;
-- OLD name : Entmutigter Ent
-- Source : https://www.wowhead.com/wotlk/de/npc=31041
UPDATE `creature_template_locale` SET `Name` = 'Zweigeistiger Ent' WHERE `locale` = 'deDE' AND `entry` = 31041;
-- OLD name : Packmuli (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31046
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31046;
-- OLD name : ELM General Purpose Bunny Gigantic (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31047
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31047;
-- OLD name : Eliteprotodrache von Balagarde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31056
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31056;
-- OLD name : Kreuzzugsarchitekt Silas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31058;
-- OLD name : Russell Bernau Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31060;
-- OLD name : Kreuzzugsingenieur Spitzpatrick (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31061
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31061;
-- OLD name : Belagerungsmeister Fezzik (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31062
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31062;
-- OLD name : Indalamars Nax-10-Verkäufer, subname : Tolles Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31076
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31076;
-- OLD name : Feiger Acherusspuk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31090
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31090;
-- OLD name : Scourge Egg KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31092
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31092;
-- OLD name : Verängstigter Ghul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31097
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31097;
-- OLD name : Geißelstellvertreter von Acherus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31100
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31100;
-- OLD name : Nachtelfirokese (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31111
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31111;
-- OLD name : Indalamars Nax-25-Verkäufer, subname : Tolles Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31116
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31116;
-- OLD name : Chilly (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31128;
-- OLD name : Verfallendes Geschöpf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31141
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31141;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Großmeisters' WHERE `locale` = 'deDE' AND `entry` = 31144;
-- OLD name : Trainingsattrappe des Schlachtzuges
-- Source : https://www.wowhead.com/wotlk/de/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Heroische Trainingsattrappe' WHERE `locale` = 'deDE' AND `entry` = 31146;
-- OLD name : Portal des Tausendwintersees (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31149
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31149;
-- OLD name : V (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31168;
-- OLD name : Ewiger Agent (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31203
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31203;
-- OLD name : Reitargentumhimmelsklaue (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31209;
-- OLD name : Akolyth von Shadron
-- Source : https://www.wowhead.com/wotlk/de/npc=31218
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Shadron' WHERE `locale` = 'deDE' AND `entry` = 31218;
-- OLD name : Akolyth von Vesperon
-- Source : https://www.wowhead.com/wotlk/de/npc=31219
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Vesperon' WHERE `locale` = 'deDE' AND `entry` = 31219;
-- OLD name : Unglückselige Dryade (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31230;
-- OLD name : Indalamars Verkäufer für Embleme der Ehre, subname : Tolles Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31234
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31234;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=31238
UPDATE `creature_template_locale` SET `Title` = 'Lehrerin für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 31238;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31246;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug' WHERE `locale` = 'deDE' AND `entry` = 31247;
-- OLD name : Rimi Kaltkurbel, subname : Fluglehrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31248
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31248;
-- OLD name : Sigrid Eiskinds Protodrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31249
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31249;
-- OLD name : Böser Fisch - Frosch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31252;
-- OLD name : Böser Fisch - Hase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31256
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31256;
-- OLD name : Eine geheimnisvolle Stimme
-- Source : https://www.wowhead.com/wotlk/de/npc=31264
UPDATE `creature_template_locale` SET `Name` = 'Eine mysteriöse Stimme' WHERE `locale` = 'deDE' AND `entry` = 31264;
-- OLD name : Kampfwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=31269
UPDATE `creature_template_locale` SET `Name` = 'Kampfflügeldrache der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 31269;
-- OLD name : Dying Berserker KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31272
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31272;
-- OLD name : Aufseher der Todesritter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31274
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31274;
-- OLD name : Gefräßiger Ghul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31278
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31278;
-- OLD name : Arkanistin Ivrenne, subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31300
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31300;
-- OLD name : Magistrix Lambriesse, subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31302
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31302;
-- OLD name : Arkanist Adurin, subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31305;
-- OLD name : Magister Brasael, subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31307
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31307;
-- OLD name : Dying Soldier KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31312
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31312;
-- OLD name : Reithippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31315
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31315;
-- OLD name : Großer Blizzardbär (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31319;
-- OLD name : Skeletal Footsoldier Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31329
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31329;
-- OLD name : Indalamars Verkäufer für Embleme des Heldentums, subname : Tolles Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31331
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31331;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31353;
-- OLD name : Frostbruthimmelsklaue KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31364
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31364;
-- OLD name : Illidan Sturmgrimm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31395
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31395;
-- OLD name : Der auserwählte Held (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31398
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31398;
-- OLD name : Bomber von Eiskrone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31405
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31405;
-- OLD name : WotLK City Attacks Ice Block Bunny, BUG TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31415
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31415;
-- OLD subname : Schusswaffenverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=31423
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition' WHERE `locale` = 'deDE' AND `entry` = 31423;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=31429
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 31429;
-- OLD name : Auktionator Thathung
-- Source : https://www.wowhead.com/wotlk/de/npc=31430
UPDATE `creature_template_locale` SET `Name` = 'Auktionator Thatung' WHERE `locale` = 'deDE' AND `entry` = 31430;
-- OLD name : Scourge Fight Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31481
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31481;
-- OLD name : Freundlicher Zauberer aus Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31522
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31522;
-- OLD name : Freundlicher Gladiator aus Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31523
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31523;
-- OLD name : Arkanist Peridris, subname : Rüstmeister für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31545
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31545;
-- OLD name : Arkanistin Baladrialle, subname : Erfahrene Rüstmeisterin für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31549
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31549;
-- OLD name : Magistrix Feyrina, subname : Erfahrene Rüstmeisterin für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31551
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31551;
-- OLD name : Magister Saremvir, subname : Rüstmeister für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31552
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31552;
-- OLD name : Blight Wagon [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31566
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31566;
-- OLD name : Forsaken Chemistry Set [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31567
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31567;
-- OLD name : Forsaken Chemistry Set 02 [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31568
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31568;
-- OLD name : Plague Barrel [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31569
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31569;
-- OLD name : Broken Plague Barrel  [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31570
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31570;
-- OLD name : Broken Plague Barrel 2 [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31571
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31571;
-- OLD name : Verseuchte Kakerlake (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31572
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31572;
-- OLD name : Forsaken Fire [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31573
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31573;
-- OLD name : Forsaken Fire Small [Wrath Gate Both] (UC) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31574;
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
-- OLD name : Cosmetic Trigger - Phase 2 - LAB (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31645
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31645;
-- OLD name : Wrath Gate Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31683
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31683;
-- OLD name : Zwielichtdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtreitdrache' WHERE `locale` = 'deDE' AND `entry` = 31698;
-- OLD name : Schwarzer Reiteisbär (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31699
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31699;
-- OLD name : Brauner Reiteisbär (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31700
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31700;
-- OLD name : Schwares Reitmammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31703
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31703;
-- OLD name : Purpurne kosmetische Schlange (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31712
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31712;
-- OLD name : Grüne kosmetische Wasserschlange (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31713;
-- OLD name : Grunzerin Grikee
-- Source : https://www.wowhead.com/wotlk/de/npc=31727
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Grikee' WHERE `locale` = 'deDE' AND `entry` = 31727;
-- OLD name : Malygos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31734
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31734;
-- OLD name : Icy Ghoul KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31743;
-- OLD name : Kosmetische Plünderpiñata, subname : Verhaut mich! (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31744;
-- OLD name : Icecrown Bomber - Bindsight Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31745
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31745;
-- OLD name : King of the Mountain Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31766
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31766;
-- OLD name : Plague Cauldron KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31767;
-- OLD name : Cloak Dome Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31777
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31777;
-- OLD name : Im Stall abgestelltes Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31799;
-- OLD name : Im Stall abgestelltes Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31800;
-- OLD name : Treantverbündeter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31802
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31802;
-- OLD name : Im Stall abgestelltes Reittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31803
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31803;
-- OLD name : Schneller Hengst von Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31809
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31809;
-- OLD name : Branns Flugmaschine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31827
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31827;
-- OLD name : Slaves to Saronite Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31866
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31866;
-- OLD name : Schrottreifer Verwüster
-- Source : https://www.wowhead.com/wotlk/de/npc=31868
UPDATE `creature_template_locale` SET `Name` = 'Defekter Verwüster' WHERE `locale` = 'deDE' AND `entry` = 31868;
-- OLD name : Blitzwespe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31871
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31871;
-- OLD name : Indalamars Verkäufer für Splitter eines Steinbewahrers, subname : Tolles Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31872
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31872;
-- OLD name : Menschenmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31879
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31879;
-- OLD name : Unsichtbarer Pirscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=31913
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31913;
-- OLD name : Zollinger, Meister der Lehren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32150
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32150;
-- OLD name : Zwielichtreitdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32165;
-- OLD name : Zwielichtreitdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32166
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32166;
-- OLD name : Risen Skeleton KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32167
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32167;
-- OLD name : Vicious Geist KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32168;
-- OLD name : Unkillable Test Dummy 80 Warrior (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32171
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32171;
-- OLD name : Eiskronennekropole (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32173
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32173;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32193;
-- OLD name : Teufelsfledermaus von Heb'Drakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32194
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32194;
-- OLD name : South Gate KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32195
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32195;
-- OLD name : Central Gate KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32196
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32196;
-- OLD name : North Gate KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32197
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32197;
-- OLD name : Geliehene Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32198
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32198;
-- OLD name : Northwest Gate KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32199
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32199;
-- OLD name : Gemieteter Windreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32208
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32208;
-- OLD name : Großes Karawanenmammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32212
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32212;
-- OLD name : Großes Karawanenmammut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32213
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32213;
-- OLD name : Drag Drop KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32229
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32229;
-- OLD name : Leerenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=32230
UPDATE `creature_template_locale` SET `Name` = 'Herr der Leere' WHERE `locale` = 'deDE' AND `entry` = 32230;
-- OLD name : Verkleideter Kreuzfahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32241
UPDATE `creature_template_locale` SET `Name` = 'Verkleideter Kreuzzügler' WHERE `locale` = 'deDE' AND `entry` = 32241;
-- OLD name : Heckenschützenkanone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32254
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32254;
-- OLD name : Writhing Mass KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32266
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32266;
-- OLD name : Unruhiges Fragment (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32283
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32283;
-- OLD name : Befreites Fragment (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32288
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32288;
-- OLD name : Wachposten der Aldur'thar
-- Source : https://www.wowhead.com/wotlk/de/npc=32292
UPDATE `creature_template_locale` SET `Name` = 'Späher von Aldur''thar' WHERE `locale` = 'deDE' AND `entry` = 32292;
-- OLD name : Transformation des dunklen Unterwerfers, subname : Kult der Verdammten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32293;
-- OLD name : Testtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32304
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32304;
-- OLD name : Dark Messenger KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32314
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32314;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32328;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32339;
-- OLD name : Raketenturm TF-Xplosiv (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32350
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32350;
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
-- OLD name : Unteroffizier Kien, subname : Rüstmeister für Juwelierskunst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32384
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32384;
-- OLD subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=32385
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterveteran für Rüstungen' WHERE `locale` = 'deDE' AND `entry` = 32385;
-- OLD name : Kezzik der Meuchler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32405
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32405;
-- OLD name : Argex Eisenmagen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32407
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32407;
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
-- OLD name : Iragos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32432
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32432;
-- OLD name : Selagosa (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32433
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32433;
-- OLD name : Anygos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32434
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32434;
-- OLD name : Theragos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32436
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32436;
-- OLD name : Myragosa (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32437
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32437;
-- OLD name : Zyndragosa (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32439
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32439;
-- OLD name : Corthegos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32440
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32440;
-- OLD name : Geborgter Besen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32449
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32449;
-- OLD name : Fahrzeug des Tals der Verlorenen Hoffnung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32452
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32452;
-- OLD name : Einwohner von Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32453
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32453;
-- OLD name : Einwohner von Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32454
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32454;
-- OLD name : Seuchenbringer der Geißel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32473
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32473;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns' WHERE `locale` = 'deDE' AND `entry` = 32474;
-- OLD name : Nerubischer Unterkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32480
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32480;
-- OLD name : Vollgesogener Seuchenwurm
-- Source : https://www.wowhead.com/wotlk/de/npc=32483
UPDATE `creature_template_locale` SET `Name` = 'Verstopfter Seuchenwurm' WHERE `locale` = 'deDE' AND `entry` = 32483;
-- OLD name : Verwundeter Bürger von Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32493;
-- OLD name : Kind aus Dalaran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32494
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32494;
-- OLD name : Torkelnder Zombie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32499
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32499;
-- OLD name : Akolyth der Kultisten
-- Source : https://www.wowhead.com/wotlk/de/npc=32507
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Kultisten' WHERE `locale` = 'deDE' AND `entry` = 32507;
-- OLD name : Davids Testkreatur 1235 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32508
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32508;
-- OLD name : Fehlgeschlagenes Experiment
-- Source : https://www.wowhead.com/wotlk/de/npc=32519
UPDATE `creature_template_locale` SET `Name` = 'Gescheitertes Experiment' WHERE `locale` = 'deDE' AND `entry` = 32519;
-- OLD name : Geistheiler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32536;
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
-- OLD name : QA Test Dummy 80 Undead, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32556
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32556;
-- OLD name : QA Test Dummy 80 Beast, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32557
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32557;
-- OLD name : QA Test Dummy 80 Dragonkin, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32558;
-- OLD name : QA Test Dummy 80 Demon, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32559;
-- OLD name : QA Test Dummy 80 Giant, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32560
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32560;
-- OLD name : QA Test Dummy 80 Elemental, subname : Sandsack der QA (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32561
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32561;
-- OLD name : Roter Reitdrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32563
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32563;
-- OLD name : Großartiger fliegender Teppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32567
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32567;
-- OLD name : Fliegende schwarze Qirajipanzerdrohne (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32568
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32568;
-- OLD name : Verwandelte schwarze Katze (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32570
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32570;
-- OLD name : Testflugmaschine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32574;
-- OLD name : Wolvarillusion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32584
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32584;
-- OLD name : Blauer Reitprotodrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32585
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32585;
-- OLD name : Bronzefarbener Protodrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32586;
-- OLD name : Hordentestpilot des Bombers von Eiskrone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32607;
-- OLD name : Kriegshetzer der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32615
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32615;
-- OLD name : Brigadegeneral der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32626
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32626;
-- OLD name : Stubengast (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32632;
-- OLD name : Schneller Mondgespinstteppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32634;
-- OLD name : Schneller Schwarztuchteppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32635
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32635;
-- OLD name : Schneller Zaubertuchteppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32636
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32636;
-- OLD name : Fliegender Teppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32637
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32637;
-- OLD subname : Handelsreisender
-- Source : https://www.wowhead.com/wotlk/de/npc=32638
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender' WHERE `locale` = 'deDE' AND `entry` = 32638;
-- OLD subname : Handelsreisende
-- Source : https://www.wowhead.com/wotlk/de/npc=32642
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender' WHERE `locale` = 'deDE' AND `entry` = 32642;
-- OLD name : Trainingsattrappe der Kriegshymnenfeste
-- Source : https://www.wowhead.com/wotlk/de/npc=32647
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe der Kriegshymnenfeste' WHERE `locale` = 'deDE' AND `entry` = 32647;
-- OLD name : Tirion's Gambit Event Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32648
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32648;
-- OLD name : Gorky, subname : Fliegender Händler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32649
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32649;
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
-- OLD name : Totem der Feuernova IX (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32775
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32775;
-- OLD name : Totem der Feuernova VIII (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32776
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32776;
-- OLD name : Gemeiner Dieb (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32779
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32779;
-- OLD name : Nobelgartenhase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32781
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32781;
-- OLD name : Nobelgartenhase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32782
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32782;
-- OLD name : Nobelgartenhase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32784
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32784;
-- OLD name : Web Wrap Visual (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32785
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32785;
-- OLD name : Verwandelter Hase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32789
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32789;
-- OLD name : Indalamars 83 Testdummy, subname : QA Punching Bag (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32794
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32794;
-- OLD name : Illidan Sturmgrimm Kill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32797
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32797;
-- OLD name : Frühlingsernter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32798;
-- OLD name : Frühlingssammler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32799;
-- OLD name : Flammenwächter der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32801
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der boreanischen Tundra' WHERE `locale` = 'deDE' AND `entry` = 32801;
-- OLD name : Flammenwächter des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32804
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter des heulenden Fjords' WHERE `locale` = 'deDE' AND `entry` = 32804;
-- OLD name : Flammenbewahrer der Boreanischen Tundra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32809
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32809;
-- OLD name : Flammenbewahrer des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32812
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des heulenden Fjords' WHERE `locale` = 'deDE' AND `entry` = 32812;
-- OLD name : Fetter Truthahn
-- Source : https://www.wowhead.com/wotlk/de/npc=32818
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn' WHERE `locale` = 'deDE' AND `entry` = 32818;
-- OLD name : Plump Turkey Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32819
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn' WHERE `locale` = 'deDE' AND `entry` = 32819;
-- OLD name : Revenge for the Vargul Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32821
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32821;
-- OLD name : Großer Truthahn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32822
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32822;
-- OLD name : Rustikaler Hocker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32826
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32826;
-- OLD name : Stuhlhalter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32828
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32828;
-- OLD name : Späher Zar'shi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32833
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32833;
-- OLD name : Korporal Mondstreich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32835
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32835;
-- OLD name : Unkillable Test Dummy 80 Warrior (Bonus Armor) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32847
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32847;
-- OLD name : Untötbare Testdummy 80 S1 Resil-Priester, subname : Priester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32848
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32848;
-- OLD name : Untötbare Testdummy 80 S1 Resil-Krieger, subname : Krieger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32849
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32849;
-- OLD name : QA Test Dummy 83 Raid Debuff (High Armor) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32853;
-- OLD name : Unkillable Test Dummy 83 Warrior (Bonus Armor) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32854
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32854;
-- OLD name : Ronakada, subname : Klingenmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32870
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32870;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32886
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 32886;
-- OLD name : Totem des glühenden Magmas TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32887
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32887;
-- OLD name : Sarahs Schlachtfeldhaudrauf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32898
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32898;
-- OLD name : Tollwütiger Truthahn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32905
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32905;
-- OLD name : Dans Testreittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32931
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32931;
-- OLD name : Spektralreitgreif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32942
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32942;
-- OLD name : Hungriger Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32954
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32954;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32957
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 32957;
-- OLD name : Treues Muli (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32980
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32980;
-- OLD name : Reitgeißelgreif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32981
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32981;
-- OLD name : Mietpackmuli (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32983;
-- OLD name : Test der Stärke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=32984
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32984;
-- OLD name : Männchen oder Weibchen Frostleopard Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33005
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33005;
-- OLD name : Männchen oder Weibchen Eispfotenbär Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33006
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33006;
-- OLD name : Justin Testfahrzeug A (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33014
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33014;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=33016
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett' WHERE `locale` = 'deDE' AND `entry` = 33016;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=33017
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt' WHERE `locale` = 'deDE' AND `entry` = 33017;
-- OLD subname : Hochprozentiges
-- Source : https://www.wowhead.com/wotlk/de/npc=33026
UPDATE `creature_template_locale` SET `Title` = 'Alkohol' WHERE `locale` = 'deDE' AND `entry` = 33026;
-- OLD name : Glühwürmchen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33032
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33032;
-- OLD name : ELM General Purpose Bunny Large (scale x5) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33045
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33045;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33049;
-- OLD name : Instabiler Sonnenstrahl
-- Source : https://www.wowhead.com/wotlk/de/npc=33050
UPDATE `creature_template_locale` SET `Name` = 'Unstabiler Sonnenstrahl' WHERE `locale` = 'deDE' AND `entry` = 33050;
-- OLD name : Schrottreifer Feuerstuhl (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33061
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33061;
-- OLD name : Frizzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33064
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33064;
-- OLD name : Haudrauf von Dunkelmond (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33069
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33069;
-- OLD name : Unkillable Test Dummy 87 Warrior Sessile (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33073
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33073;
-- OLD name : Belagerungsturm der Kriegshymnenschlucht (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33080;
-- OLD name : Panzerziel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33081
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33081;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=33110
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt' WHERE `locale` = 'deDE' AND `entry` = 33110;
-- OLD name : Eisernes Konstrukt (Magma) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33122
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33122;
-- OLD name : Puppenspieler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33128;
-- OLD name : Gnompuppe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33129
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33129;
-- OLD name : Tjostpferd (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33130;
-- OLD name : Tjostritter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33135
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33135;
-- OLD name : Puppenhand (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33137
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33137;
-- OLD name : Verwüsterkontrollkonsole (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33146
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33146;
-- OLD name : Klingenschuppenharpunenkanone (unbenutzt) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33184
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33184;
-- OLD name : Granatenkiste (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33185
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33185;
-- OLD name : Flüssiges Pyrit
-- Source : https://www.wowhead.com/wotlk/de/npc=33189
UPDATE `creature_template_locale` SET `Name` = 'Flüssiger Pyrit' WHERE `locale` = 'deDE' AND `entry` = 33189;
-- OLD name : Geißelmelder von Eiskrone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33192;
-- OLD name : Schwarzer Knappe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33240
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33240;
-- OLD name : Klingenschuppe-Spawner
-- Source : https://www.wowhead.com/wotlk/de/npc=33245
UPDATE `creature_template_locale` SET `Name` = 'Klingenschuppen Spawner' WHERE `locale` = 'deDE' AND `entry` = 33245;
-- OLD name : Krieger der Eisenzwerge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33246
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33246;
-- OLD name : Machtwort: Barriere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33248
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33248;
-- OLD name : Todesritterlehrer und Runenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33251
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33251;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33252;
-- OLD name : Titansturmlord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33255
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33255;
-- OLD name : Jacqueline Aschebäscha, subname : Die süßeste aller Aschebäschas (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33290
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33290;
-- OLD name : Ross aus Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33297
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33297;
-- OLD name : Roboschreiter aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33301;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33305;
-- OLD name : Gerome der Gnom (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33314
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33314;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33341;
-- OLD name : "Spektraltiger" (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33357
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33357;
-- OLD name : Hammervehikel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33380;
-- OLD name : Widder aus Eisenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33408
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33408;
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33415;
-- OLD name : Falkenschreiter von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=33418
UPDATE `creature_template_locale` SET `Name` = 'Falkenschreiter aus Silbermond' WHERE `locale` = 'deDE' AND `entry` = 33418;
-- OLD name : Hordenmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33425
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33425;
-- OLD name : Drachenführer der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33426
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33426;
-- OLD name : [ph] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33450;
-- OLD name : Streiter von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33461
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33461;
-- OLD name : Streiter von Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33464
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33464;
-- OLD name : Streiter von Silbermond (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33466
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33466;
-- OLD name : Streiter von Unterstadt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33470
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33470;
-- OLD name : Champion von Donnerfels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33471
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33471;
-- OLD name : Streiter von Donnerfels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33472;
-- OLD name : Streiter von Sen'jin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33475
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33475;
-- OLD name : Streiter von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33478
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33478;
-- OLD name : Streiter von Eisenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33482
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33482;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33501;
-- OLD name : Zähmbarer Kernhund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33502
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33502;
-- OLD name : Kommandant der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33503
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33503;
-- OLD name : Zähmbare Schimäre (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33504
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33504;
-- OLD name : Zähmbarer Teufelssaurier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33505
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33505;
-- OLD name : Zähmbares Rhinozeros (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33506
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33506;
-- OLD name : Zähmbarer Silithid (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33508
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33508;
-- OLD name : Zähmbare Geisterbestie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33510
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33510;
-- OLD name : Zähmbarer Wurm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33511
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33511;
-- OLD name : Gepanzerter schwarzer Greif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33517
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33517;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33521;
-- OLD name : Neugieriges Gorlocjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=33530
UPDATE `creature_template_locale` SET `Name` = 'Neugieriges Orakeljunges' WHERE `locale` = 'deDE' AND `entry` = 33530;
-- OLD name : Wolvarwaisenkind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33532
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33532;
-- OLD name : Orakelwaisenkind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33533;
-- OLD name : Zuverlässiges Streitross aus Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33551
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33551;
-- OLD name : Champion von Darnassus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33563
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33563;
-- OLD name : Fisch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33568
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33568;
-- OLD name : Bernau Test Dummy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33570
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33570;
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
-- OLD name : Hochlord Tirion Fordring (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33628
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33628;
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
-- OLD name : Flickwerk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33663
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33663;
-- OLD name : Ursula Aschebäscha, subname : Händlerin für "Über"hemden (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33665
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33665;
-- OLD name : Flickwerk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33667
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33667;
-- OLD name : Kriecherreittier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33671
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33671;
-- OLD name : Pengoro, subname : Prinz der Pinguine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33673
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33673;
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
-- OLD name : James Barlo, subname : Meister des Angelns (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33685
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33685;
-- OLD name : Argent Champion Credit (Valiant Test), subname : A.L.K. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33708
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33708;
-- OLD name : Bronzekonsort (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33718
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33718;
-- OLD name : Entweihter Boden II (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33751
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33751;
-- OLD name : Entweihter Boden III (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33752
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33752;
-- OLD name : Entweihter Boden IV (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33753;
-- OLD name : Abbild des Ältesten Hellblatt (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33761
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33761;
-- OLD name : OCL Testkreatur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33764
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33764;
-- OLD name : Todesstreitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33783
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33783;
-- OLD name : Testturnierstreitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33784;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=33788
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius' WHERE `locale` = 'deDE' AND `entry` = 33788;
-- OLD name : Verteidiger der Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33805
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33805;
-- OLD name : Rubble Stalker Kologarn
-- Source : https://www.wowhead.com/wotlk/de/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Geröllpirscher Kologarn' WHERE `locale` = 'deDE' AND `entry` = 33809;
-- OLD name : Mimiron Fokuspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33835
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33835;
-- OLD name : Streitross der Quel'dorei
-- Source : https://www.wowhead.com/wotlk/de/npc=33840
UPDATE `creature_template_locale` SET `Name` = 'Ross der Quel''dorei' WHERE `locale` = 'deDE' AND `entry` = 33840;
-- OLD name : Abbild des Ältesten Eisenast (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33861
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33861;
-- OLD name : Abbild des Ältesten Steinrinde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33862
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33862;
-- OLD name : Argentumschlachtross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33863
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33863;
-- OLD name : Relga, subname : Erfrischungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33867
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33867;
-- OLD name : Abbild von Freya (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33876
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33876;
-- OLD name : Abbild von Sif (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33877
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33877;
-- OLD name : Abbild von Thorim (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33878
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33878;
-- OLD name : Abbild von Hodir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33879
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33879;
-- OLD name : Abbild von Mimiron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33880
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33880;
-- OLD name : Yogg-Saron (Nur Transformation) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33883;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33915
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33915;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33916
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33916;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33917
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33917;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33918
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33918;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33919
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33919;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33920
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33920;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33921
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33921;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33922
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33922;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33923
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33923;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33924
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33924;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33925
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33925;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33926
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33926;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33927
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33927;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33928
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33928;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33929
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33929;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33930
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33930;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33931
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33931;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33932
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33932;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Arenaverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33933
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33933;
-- OLD name : Ecton Messingkipper, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33934
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33934;
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33935
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33935;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33936;
-- OLD name : Xazi Schmauchpfeife, subname : Arenaverkäuferin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33937
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33937;
-- OLD name : Zom Bocom, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33938
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33938;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33939
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33939;
-- OLD name : Kezzik der Meuchler, subname : Arenaverkäuferveteran (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33940
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33940;
-- OLD name : Leeni "Kicher" Erbse, subname : Arenaverkäuferlehrling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33941
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33941;
-- OLD name : Verkäufer von Indalamars Emblem der Eroberung, subname : Emporium des UNGLAUBLICHEN (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33946
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33946;
-- OLD name : Gigantischer schwarzer Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33949
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33949;
-- OLD name : Gigantischer weißer Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33950
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33950;
-- OLD name : Gigantischer grauer Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33951
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33951;
-- OLD name : Gigantischer roter Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33952
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33952;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 33963;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 33964;
-- OLD subname : Meister des Sturmangriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=33972
UPDATE `creature_template_locale` SET `Title` = 'Meister des Anstürmens' WHERE `locale` = 'deDE' AND `entry` = 33972;
-- OLD name : Nobelgartenhase (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33975
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33975;
-- OLD name : Harry Reinwasser, subname : Angelmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=33992
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33992;
-- OLD name : Zone der Leere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34000
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34000;
-- OLD name : Zone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone' WHERE `locale` = 'deDE' AND `entry` = 34001;
-- OLD name : Algalon Test Creature (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34002
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34002;
-- OLD name : Abbild des Knopfs (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34011
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34011;
-- OLD name : Schnelles graues Ross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34017
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34017;
-- OLD name : Zähmbarer Sporensegler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34018
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34018;
-- OLD name : Zähmbare Hyäne (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34019
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34019;
-- OLD name : Zähmbare Motte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34021
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34021;
-- OLD name : Zähmbarer Weitschreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34022
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34022;
-- OLD name : Zähmbare Wespe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34024
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34024;
-- OLD name : Zähmbarer Bär (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34025
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34025;
-- OLD name : Zähmbarer Krebs (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34026
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34026;
-- OLD name : Zähmbarer Krokilisk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34027
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34027;
-- OLD name : Zähmbarer Gorilla (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34028
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34028;
-- OLD name : Zähmbare Schildkröte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34029
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34029;
-- OLD name : Abbild des Schreins (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34032
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34032;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34036
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34036;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34037
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34037;
-- OLD name : Unteroffizier Donnerhorn, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34038
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34038;
-- OLD name : Lady Palanseher, subname : Rüstmeisterin für Juwelierskunst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34039;
-- OLD name : Lady Palanseher, subname : Rüstmeisterin für Juwelierskunst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34040
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34040;
-- OLD name : Phantomgeisterfisch, subname : Außergewöhnlicher Designer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34042
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34042;
-- OLD subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34043
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 34043;
-- OLD name : Euer Funkgerät erwacht knisternd zum Leben. Bronzebart (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34054
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34054;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34058;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34059
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34059;
-- OLD name : Doris Volanthius, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34060;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34061
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34061;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34062
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34062;
-- OLD name : Blutwache Zar'shi, subname : Rüstmeister für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34063
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34063;
-- OLD name : Urel Steinherz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34070
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34070;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34073
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34073;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34074
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34074;
-- OLD name : Hauptmann Klagehammer, subname : Rüstmeisterlehrling für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34075
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34075;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34076
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34076;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34077
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34077;
-- OLD name : Leutnant Tristia, subname : Rüstmeisterin für Veteranenrüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34078
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34078;
-- OLD subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34079
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Juwelenschleifen' WHERE `locale` = 'deDE' AND `entry` = 34079;
-- OLD name : Hauptmann O'Neal, subname : Rüstmeister für Juwelierskunst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34080;
-- OLD name : Hauptmann O'Neal, subname : Rüstmeister für Juwelierskunst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34081
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34081;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34082;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34083
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34083;
-- OLD name : Hauptmann Mondstreich, subname : Rüstmeister für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34084
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34084;
-- OLD name : Eisenfang Rüsti
-- Source : https://www.wowhead.com/wotlk/de/npc=34087
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix' WHERE `locale` = 'deDE' AND `entry` = 34087;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34088;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34089
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34089;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34090
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34090;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34091;
-- OLD name : Eisenfang Rüsti, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34092
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34092;
-- OLD name : Blazzek der Beißer, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34093
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34093;
-- OLD name : Grex Hirnkocher, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34094
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34094;
-- OLD name : Eisenfang Rüsti, subname : Außergewöhnliche Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34095
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34095;
-- OLD name : Der Schwarze Ritter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34104;
-- OLD name : Argentumstreitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34107;
-- OLD name : Schattenfisch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34116
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34116;
-- OLD name : Seuchenwagen der Knochenwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34128;
-- OLD name : Blaues Skelettschlachtross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34154
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34154;
-- OLD name : Toxic Tolerance Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34157
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34157;
-- OLD name : Hannes Aschebäscha, subname : Fahrzeugtestausrüstung für Ulduar 10er (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34168;
-- OLD name : Hauptmann Hermann Aschebäscha, subname : Der flammende Falke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34172
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34172;
-- OLD name : Großmutter Aschebäscha, subname : Verkäufer zukünftiger Rüstungssets (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34173
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34173;
-- OLD name : Grylls (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34178
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34178;
-- OLD name : Fokussierter Laser
-- Source : https://www.wowhead.com/wotlk/de/npc=34181
UPDATE `creature_template_locale` SET `Name` = 'Fokuslaser' WHERE `locale` = 'deDE' AND `entry` = 34181;
-- OLD name : Sichtbares Einflusstentakel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34202
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34202;
-- OLD name : Brennende Rune (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34213
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34213;
-- OLD name : Azerothplanetenpirscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34250
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34250;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34281;
-- OLD name : Recyclebotsägeblatt
-- Source : https://www.wowhead.com/wotlk/de/npc=34288
UPDATE `creature_template_locale` SET `Name` = 'Recyclebot Sägeblatt' WHERE `locale` = 'deDE' AND `entry` = 34288;
-- OLD name : Sara (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34313;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34319;
-- OLD name : Dino Meat Feeding Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34327
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34327;
-- OLD name : Silithid Meat Feeding Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34336
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34336;
-- OLD name : Silithid Egg Feeding Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34338
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34338;
-- OLD name : Hasi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34360;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34381;
-- OLD name : Hochorakel Soo-roo (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34386;
-- OLD name : Ältester Kekek (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34387
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34387;
-- OLD name : Testverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34393
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34393;
-- OLD name : MiniZep (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34428;
-- OLD name : ELM Daze Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34434
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34434;
-- OLD name : ELM Attacker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34436
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34436;
-- OLD name : Kampfmeister der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34437
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34437;
-- OLD name : Heiterer Orcgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34477
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34477;
-- OLD name : Heiterer Zwergengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34478
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34478;
-- OLD name : Heiterer Gnomengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34481
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34481;
-- OLD name : Heiterer Trollgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34482
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34482;
-- OLD name : Heiterer Draeneigeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34484
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34484;
-- OLD name : Spielgefährte von den Winterflossen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34489
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34489;
-- OLD name : Spielgefährte von der Schneewehenlichtung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34490
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34490;
-- OLD name : Kupferkesselgoonie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34505
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34505;
-- OLD name : XT-005 Debugger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34515;
-- OLD name : Roo (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34531
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34531;
-- OLD name : Kekek (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34532
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34532;
-- OLD name : Verlassener Witzbold (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34561
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34561;
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34562;
-- OLD name : Gifthautjunges (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34579
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34579;
-- OLD name : Gifthautjunges (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34580
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34580;
-- OLD name : Gifthautjunges (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34581;
-- OLD name : [DND] Warbot - Blue (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34588;
-- OLD name : [DND] Warbot - Red (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34589;
-- OLD name : Danowe Donnerhorn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34612;
-- OLD name : Ogerpinata (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34632;
-- OLD name : Magischer Hahn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34655
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34655;
-- OLD name : Silberner Reitdrachenfalke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34709
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34709;
-- OLD name : Besatzungsmitglied Rohrschlüssel
-- Source : https://www.wowhead.com/wotlk/de/npc=34717
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Rohrschlüssel' WHERE `locale` = 'deDE' AND `entry` = 34717;
-- OLD name : Besatzungsmitglied Schlossriegel
-- Source : https://www.wowhead.com/wotlk/de/npc=34718
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schlossriegel' WHERE `locale` = 'deDE' AND `entry` = 34718;
-- OLD name : Besatzungsmitglied Schroter
-- Source : https://www.wowhead.com/wotlk/de/npc=34719
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schroter' WHERE `locale` = 'deDE' AND `entry` = 34719;
-- OLD name : [DND] Magic Rooster (Draenei Male) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34731;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34732;
-- OLD name : Spice Bread Stuffing Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34737
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34737;
-- OLD name : Slow-roasted Turkey Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34738;
-- OLD name : Candied Sweet Potato Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34739
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34739;
-- OLD name : Pumpkin Pie Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34740
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34740;
-- OLD name : Cranberry Chutney Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34741;
-- OLD name : Ätzschlund (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34798;
-- OLD name : Versengtes Skelett (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34801
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34801;
-- OLD name : Bountiful Table Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34806
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34806;
-- OLD name : Argent Coliseum PTR Beast Master (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34827
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34827;
-- OLD name : Nachtelfischer Kolosseumszuschauer
-- Source : https://www.wowhead.com/wotlk/de/npc=34871
UPDATE `creature_template_locale` SET `Name` = 'Nachelfischer Kolosseumszuschauer' WHERE `locale` = 'deDE' AND `entry` = 34871;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34893;
-- OLD name : Jend Jow (Test), subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34895
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34895;
-- OLD name : Schneeblinder Anhänger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34899
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34899;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34910;
-- OLD name : Höllische Teufelsflammenkugel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34921
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34921;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=34929
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots' WHERE `locale` = 'deDE' AND `entry` = 34929;
-- OLD name : Erinnerung an Hogger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34942
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34942;
-- OLD name : Abgesandter der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=34950
UPDATE `creature_template_locale` SET `Name` = 'Botschafter der Insel der Eroberung' WHERE `locale` = 'deDE' AND `entry` = 34950;
-- OLD name : Luftschiffkapitän der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=34960
UPDATE `creature_template_locale` SET `Name` = 'Kanonenbootkapitän der Allianz' WHERE `locale` = 'deDE' AND `entry` = 34960;
-- OLD name : Hotoro, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34971
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34971;
-- OLD name : Aelus Goldmorgen, subname : Kampfmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34972
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34972;
-- OLD name : Larina Herzschmiede, subname : Kampfmeisterin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=34993
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34993;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35016;
-- OLD name : Koralon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35018
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35018;
-- OLD name : Bruka Trauerbringer, subname : Kampfmeisterin der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35019
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35019;
-- OLD name : Terrance Matterly, subname : Kampfmeister der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35023
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35023;
-- OLD name : Dracien Flanning, subname : Kampfmeister der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35024
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35024;
-- OLD name : Lynette Hefter, subname : Kampfmeisterin der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35025
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35025;
-- OLD name : Erutor, subname : Kampfmeister der Insel der Eroberung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35027
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35027;
-- OLD name : Erinnerung an Lucifron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35031
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35031;
-- OLD name : Erinnerung an Donneraan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35032
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35032;
-- OLD name : Erinnerung an Hakkar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35034
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35034;
-- OLD name : Geist eines gefallenen Helden (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35055
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35055;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35066;
-- OLD name : Wichtel in der Kugel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35067
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35067;
-- OLD name : Scharfseher Eannu
-- Source : https://www.wowhead.com/wotlk/de/npc=35073
UPDATE `creature_template_locale` SET `Name` = 'Weitseher Eannu' WHERE `locale` = 'deDE' AND `entry` = 35073;
-- OLD name : Großmagd Fisk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35085
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35085;
-- OLD name : Arbeitsaufseher Grabbit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35086
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35086;
-- OLD name : Malynea Himmelshäscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35087
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35087;
-- OLD name : Custer Clubnik (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35088;
-- OLD name : Horzak Zignibbel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35091;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer' WHERE `locale` = 'deDE' AND `entry` = 35093;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer' WHERE `locale` = 'deDE' AND `entry` = 35100;
-- OLD name : Argent Coliseum PTR Eredar Master (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35107;
-- OLD name : Argent Coliseum PTR Faction Champion Master (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35108
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35108;
-- OLD name : Argent Coliseum PTR Val'kyr Master (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35109
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35109;
-- OLD name : Argent Coliseum PTR Anub'arak Master (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35110
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35110;
-- OLD name : Assassine des Kults
-- Source : https://www.wowhead.com/wotlk/de/npc=35127
UPDATE `creature_template_locale` SET `Name` = 'Assassin des Kults' WHERE `locale` = 'deDE' AND `entry` = 35127;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 35133;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin' WHERE `locale` = 'deDE' AND `entry` = 35135;
-- OLD name : Schreckensmaul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35145
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35145;
-- OLD name : Argentumhippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35146
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35146;
-- OLD name : Manageist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35155
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35155;
-- OLD name : Jadepanda (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35156
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35156;
-- OLD name : Winziger Jadedrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35157
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35157;
-- OLD name : Argentumstreitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35179
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35179;
-- OLD name : Argentumschlachtross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35180
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35180;
-- OLD name : Vergrabener Jormungar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35228
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35228;
-- OLD name : Eindringling der Kvaldir (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35242
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35242;
-- OLD name : Feiernder Draeneigeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35246
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35246;
-- OLD name : Feiernder Zwergengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35247
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35247;
-- OLD name : Feiernder Gnomengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35248
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35248;
-- OLD name : Feiernder Nachtelfengeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35250
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35250;
-- OLD name : Feiernder Orcgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35251
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35251;
-- OLD name : Feiernder Trollgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35253
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35253;
-- OLD name : Argentumfohlen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35285
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35285;
-- OLD name : Kultist von Eiskrone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35297
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35297;
-- OLD subname : Oberanführer der Kriegshymnenoffensive
-- Source : https://www.wowhead.com/wotlk/de/npc=35372
UPDATE `creature_template_locale` SET `Title` = 'Hochlord der Kriegshymnenoffensive' WHERE `locale` = 'deDE' AND `entry` = 35372;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35459
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35459;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=35460
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 35460;
-- OLD name : Rachsüchtige Val'kyr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35474
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35474;
-- OLD name : Wache der Zephyr, subname : Die Zephyr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35492
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35492;
-- OLD name : Rachsüchtiger Frostwyrm (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35493;
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
-- OLD name : Argentumhippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35586;
-- OLD name : Argentumfriedensbewahrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35587;
-- OLD name : Kolosseumsmeister der Flickwerke (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35588;
-- OLD name : Jaeren Sonnenschwur (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35589;
-- OLD name : Arelas Hellstern (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35604
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35604;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35608;
-- OLD name : Kaputte Festungskanone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35819
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35819;
-- OLD name : Barrett Ramsey, subname : Zeremonienmeister des Argentumkolosseums (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35895
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35895;
-- OLD name : Barrett Ramsey, subname : Zeremonienmeister des Argentumkolosseums (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35910
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35910;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35983;
-- OLD name : Die Schwarze Schankmaid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=36024
UPDATE `creature_template_locale` SET `Name` = 'Die schwarze Schankmaid' WHERE `locale` = 'deDE' AND `entry` = 36024;
-- OLD name : [DND] Argent Charger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36071;
-- OLD name : [DND] Swift Burgundy Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36072;
-- OLD name : [DND] Swift Horde Wolf (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36074;
-- OLD name : [DND] White Stallion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36075;
-- OLD name : [DND] Swift Alliance Steed (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36076;
-- OLD name : Frostwyrmreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36128;
-- OLD name : Häscher der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Häscher der Kro''kron' WHERE `locale` = 'deDE' AND `entry` = 36164;
-- OLD name : Dan's Testkoloss (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36168;
-- OLD name : Hardknuckle Charger Proxy (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36189
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36189;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36212;
-- OLD name : Aufseher der Kor'kron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36213
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36213;
-- OLD name : Schweitzermobil (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36215
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36215;
-- OLD name : Aufseher Kraggosh (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36217
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36217;
-- OLD name : Auktionator Felsknochen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36235
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36235;
-- OLD name : Flint Eisenhirsch, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36284
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36284;
-- OLD name : Honorable Defender Trigger, 25 yd (Horde) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36350
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36350;
-- OLD name : Slab Schott, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36351
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36351;
-- OLD name : Kister Truhendeckel, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36352
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36352;
-- OLD name : Auktionator Plankkist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36359
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36359;
-- OLD name : Auktionator Flachstein (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36360;
-- OLD name : Buff Hartrücken (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36380;
-- OLD name : Blast Dicknacken (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36390
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36390;
-- OLD name : Wache der Dunkeleisenzwerge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36431
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36431;
-- OLD name : Kleiner Schimmel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36483
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36483;
-- OLD name : Kleiner elfenbeinfarbener Raptor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36484
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36484;
-- OLD name : Verschlinger der Seelen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36503
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36503;
-- OLD name : Verschlinger der Seelen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36504
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36504;
-- OLD name : Sandvortex von Durotar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36510
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36510;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36530;
-- OLD name : Instabiles Totem der Verbrennung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36532
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36532;
-- OLD name : Instabiler Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36533;
-- OLD name : Instabiler Erdelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36537
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36537;
-- OLD name : Instabiles Totem des heilenden Flusses (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36542
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36542;
-- OLD name : Instabiler Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36543
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36543;
-- OLD name : Nachtelfirokese (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36544
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36544;
-- OLD name : Instabiler Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36545
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36545;
-- OLD name : Instabiler Luftelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36546
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36546;
-- OLD name : Instabiler Luftelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36547
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36547;
-- OLD name : Instabiles Totem der Steinhaut (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36550
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36550;
-- OLD name : Instabiler Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36553
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36553;
-- OLD name : Instabiler Erdelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36554
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36554;
-- OLD name : Instabiles Totem des stürmischen Zorns (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36556
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36556;
-- OLD name : Justin's test Boss A (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36573
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36573;
-- OLD name : Justin's Test Boss B (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36574;
-- OLD name : Instabiler Lichtbrunnen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36605
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36605;
-- OLD name : Adeptin der Seelenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=36620
UPDATE `creature_template_locale` SET `Name` = 'Adept der Seelenwache' WHERE `locale` = 'deDE' AND `entry` = 36620;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36643;
-- OLD name : Ahmo Donnerhorn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36644;
-- OLD name : Baine Bluthuf, subname : Oberhäuptling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36648
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36648;
-- OLD name : Schildwache des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36656
UPDATE `creature_template_locale` SET `Name` = 'Schildwache des Silberbundes' WHERE `locale` = 'deDE' AND `entry` = 36656;
-- OLD name : Skelettminenarbeiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36677
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36677;
-- OLD name : Leutnant der Frostanbeter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36679
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36679;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36710;
-- OLD name : Quel'Delar Krasus Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36715
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36715;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36726;
-- OLD name : Unsichtbarer Pirscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36737
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36737;
-- OLD name : Berserker der Frostanbeter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36757;
-- OLD name : Schlachtenmagier der Frostanbeter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36763
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36763;
-- OLD name : Schütze der Frostanbeter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36769
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36769;
-- OLD name : Agent des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36774
UPDATE `creature_template_locale` SET `Name` = 'Agent des Silberbundes' WHERE `locale` = 'deDE' AND `entry` = 36774;
-- OLD name : Mächtiger Frostsäbler, subname : Begleiter des Nachtelfirokesen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36778
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36778;
-- OLD name : Verderbter Champion (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36796
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36796;
-- OLD name : Matts Testpriester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36804
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36804;
-- OLD name : [DND] Love Boat Summoner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36817;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=36838
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots' WHERE `locale` = 'deDE' AND `entry` = 36838;
-- OLD name : Blutelfenkrieger, subname : Kriegerlehrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36857
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36857;
-- OLD name : Zwergenmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36858
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36858;
-- OLD name : Zwergenschamane (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36859
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36859;
-- OLD name : Gnomenpriester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36860
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36860;
-- OLD name : Menschlicher Jäger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36861
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36861;
-- OLD name : Nachtelfenmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36862
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36862;
-- OLD name : Orcmagier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36863
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36863;
-- OLD name : Taurenpaladin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36864
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36864;
-- OLD name : Taurenpriester (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36865
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36865;
-- OLD name : Trolldruide (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36866
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36866;
-- OLD name : Untoter Jäger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36867
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36867;
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36875;
-- OLD name : Chen Sturmbräu (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36912
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36912;
-- OLD name : Sengender Elementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36949
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36949;
-- OLD name : Rumpelnder Elementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36963
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36963;
-- OLD name : Windstoßelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36964
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36964;
-- OLD name : Wütender Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36965
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36965;
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36966;
-- OLD name : Seelengebundener Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=36977
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36977;
-- OLD name : Wogender Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37036
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37036;
-- OLD name : Acanthurus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37037
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37037;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37039;
-- OLD name : Stadtwache von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37063
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37063;
-- OLD name : Argent Warhose TEST (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37074
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37074;
-- OLD name : Brigadegeneral der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37100
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37100;
-- OLD name : Horde Warbringer - Orgrimmar Appearance (DND) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37101;
-- OLD name : Elementarstein (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37118
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37118;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37128;
-- OLD name : Spiegelbild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37130;
-- OLD name : Spiegelbild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37131
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37131;
-- OLD name : Heckenschütze der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=37146
UPDATE `creature_template_locale` SET `Name` = 'Scharfschütze der Kor''kron' WHERE `locale` = 'deDE' AND `entry` = 37146;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37168;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37192;
-- OLD name : Balistoides (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37193
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37193;
-- OLD name : Chaetodon (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37194
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37194;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37202;
-- OLD name : Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37205
UPDATE `creature_template_locale` SET `Name` = 'Thalorien Dämmersucher' WHERE `locale` = 'deDE' AND `entry` = 37205;
-- OLD name : Lakai der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=37214
UPDATE `creature_template_locale` SET `Name` = 'Lakei der Manufaktur Krone' WHERE `locale` = 'deDE' AND `entry` = 37214;
-- OLD name : Schleimiges Tentakel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37530
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37530;
-- OLD name : Schlammbedecktes Tentakel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37535;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37543;
-- OLD name : Überreste von Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37552
UPDATE `creature_template_locale` SET `Name` = 'Überreste von Thalorien Dämmersucher' WHERE `locale` = 'deDE' AND `entry` = 37552;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37574;
-- OLD name : Thalorien Dawnseeker Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37601
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37601;
-- OLD name : Schmiedemeister Garfrost (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37613;
-- OLD name : Mutierte Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=37672
UPDATE `creature_template_locale` SET `Name` = 'Mutierte Monströsität' WHERE `locale` = 'deDE' AND `entry` = 37672;
-- OLD name : Wächterschatten (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37691
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37691;
-- OLD name : Kommandant Aliocha Segard, subname : Rüstmeisterin des Argentumkreuzzugs (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37693
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37693;
-- OLD name : RN Test Honor Guard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37699
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37699;
-- OLD name : RN Test Royal Guard (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37700
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37700;
-- OLD name : Strudelnder Wasserelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37703
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37703;
-- OLD name : Stadtmagier von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37732;
-- OLD name : Evakuierungsportal (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37734
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37734;
-- OLD name : Zwergisches Lufttotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37749;
-- OLD name : Zwergisches Erdtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37750
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37750;
-- OLD name : Zwergisches Feuertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37751
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37751;
-- OLD name : Zwergisches Wassertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37752
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37752;
-- OLD name : Orcisches Lufttotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37766
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37766;
-- OLD name : Orcisches Erdtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37767;
-- OLD name : Trollisches Erdtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37768
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37768;
-- OLD name : Trollisches Lufttotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37769
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37769;
-- OLD name : Orcisches Feuertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37770
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37770;
-- OLD name : Trollisches Feuertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37771
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37771;
-- OLD name : Orcisches Wassertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37772
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37772;
-- OLD name : Trollisches Wassertotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37773
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37773;
-- OLD name : Wache von Eisenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37775
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37775;
-- OLD name : Bürger von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37787
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37787;
-- OLD name : Runner Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37788;
-- OLD name : Schildwache von Darnassus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37790
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37790;
-- OLD name : Friedensbewahrer der Exodar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37798;
-- OLD name : Stadtwache von Silbermond (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37800;
-- OLD name : [TEST] High Overlord Omar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37820;
-- OLD name : Aufseher der Kor'kron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37825
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37825;
-- OLD name : Lichträcher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37826
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37826;
-- OLD name : Light's Vengeance Vehicle Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37827
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37827;
-- OLD name : Abbild von Thalorien Morgensucher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37828
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37828;
-- OLD name : Abbild von Alexstrasza, subname : Königin der Drachen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37829
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37829;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37831;
-- OLD name : Lich King Stun Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37832
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37832;
-- OLD name : Abbild von Anasterian (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37844
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37844;
-- OLD name : Abbild von Morlen Kaltfaust (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37845
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37845;
-- OLD name : Blutkönigin Lana'thel, subname : Die San'layn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37846
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37846;
-- OLD name : Abbild von Anub'Rekhan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37850
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37850;
-- OLD name : Abbild von Noth dem Seuchenfürst (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37851
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37851;
-- OLD name : Abbild von Instrukteur Razuvious (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37853;
-- OLD name : Abbild von Malygos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37855
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37855;
-- OLD name : Abbild des Flammenleviathans (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37856
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37856;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37857
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37857;
-- OLD name : Abbild von Klingenschuppe (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37858
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37858;
-- OLD name : Abbild von Ignis, Meister des Eisenwerks (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37859
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37859;
-- OLD name : Behüter von Donnerfels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37860
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37860;
-- OLD name : Grunzer von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37869
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37869;
-- OLD name : Event Fail Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37871
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37871;
-- OLD name : AoD Impact Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37878
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37878;
-- OLD name : Elender Ghul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37881
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37881;
-- OLD name : Der Frostthron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37882;
-- OLD name : Bug 174037 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37883;
-- OLD name : Vegard der Unverziehene (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37893
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37893;
-- OLD name : Vegard Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37894
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37894;
-- OLD name : Ingenieur der Himmelsbrecher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37898
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37898;
-- OLD name : Rohling der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37917
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37917;
-- OLD name : Machterfülltes Vampirscheusal (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37919
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37919;
-- OLD name : Belagerungsingenieur der Orgrims Hammer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37932
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37932;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 37941;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 37942;
-- OLD name : Stadtpatrolleur von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37944
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37944;
-- OLD name : Light's Vengeance Vehicle Bunny 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37952
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37952;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37964;
-- OLD name : Vegard der Unverziehene (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37976
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37976;
-- OLD name : Liebesboot von Darnassus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37980
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37980;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37981;
-- OLD name : Wütender Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37982
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37982;
-- OLD name : Sengender Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37983;
-- OLD name : Gauner der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37984
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37984;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37990;
-- OLD name : Light's Vengeance Bunny 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38001
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38001;
-- OLD name : Gangster der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38006
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38006;
-- OLD name : Verkleidung als Mitglied der Sonnenhäscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38011
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38011;
-- OLD name : Verkleidung als Mitglied der Sonnenhäscher (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38012
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38012;
-- OLD name : Verkleidung als Mitglied des Silberbunds (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38013
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38013;
-- OLD name : Verkleidung als Mitglied des Silberbunds (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38014
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38014;
-- OLD name : Agent der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38016
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38016;
-- OLD name : Anolis (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38019
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38019;
-- OLD name : Basiliscus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38020
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38020;
-- OLD name : Conolophus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38021
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38021;
-- OLD name : Besprenkler der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38023
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38023;
-- OLD name : Untergebener der Manufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38030
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38030;
-- OLD name : Qixi Q. Pido, subname : Chemiemanufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38039;
-- OLD name : Qixi Q. Pido, subname : Chemiemanufaktur Krone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38040
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38040;
-- OLD name : Junger Pilger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38049
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38049;
-- OLD name : Grunzer von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38050
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38050;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38053;
-- OLD name : Bürger von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38067
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38067;
-- OLD name : Abbild des Sonnenbrunnens (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38116
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38116;
-- OLD name : Soul Feast Kill Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38121
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38121;
-- OLD name : Magier von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38158
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38158;
-- OLD name : Gefangener Bürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38162
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38162;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38164;
-- OLD name : Entfesselndes Totem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38180
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38180;
-- OLD name : Große Liebesrakete
-- Source : https://www.wowhead.com/wotlk/de/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Herzbrecher X-45' WHERE `locale` = 'deDE' AND `entry` = 38204;
-- OLD name : Große Liebesrakete (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38207
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38207;
-- OLD name : Wrath of the Lich King Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38211
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38211;
-- OLD name : Mutierter Professor Seuchenmord (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38216
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38216;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38236;
-- OLD name : Unbesiegbar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38260
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38260;
-- OLD name : Transformierter dunkler Runenriese (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38264
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38264;
-- OLD name : Illusion eines Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38271
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38271;
-- OLD name : Illusion eines Taunka (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38273
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38273;
-- OLD name : Unholy Infusion KC Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38289
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38289;
-- OLD name : Nahkampfschmuckstück - Tuskarr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38291
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38291;
-- OLD name : Nahkampfschmuckstück - Taunka (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38292;
-- OLD name : Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38310
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38310;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38342;
-- OLD name : Kugel der Blutkönigin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38353
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38353;
-- OLD name : Teslaspule (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38367
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38367;
-- OLD name : Flickwerk (PTR Rundum-Test) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38386;
-- OLD name : Darnavan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38472
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38472;
-- OLD name : Argentumkreuzfahrer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38497
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38497;
-- OLD name : Blood Infusion Quest Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38503
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38503;
-- OLD name : Shadowmourne Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38527
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38527;
-- OLD name : Shadowmourne Axe Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38528
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38528;
-- OLD name : Schattengram (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38529
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38529;
-- OLD name : Frost Infusion Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38546
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38546;
-- OLD name : Sindragosa Quest Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38547
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38547;
-- OLD name : Phantomhafte Halluzination (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38566
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38566;
-- OLD name : Bug 181860 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38572
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38572;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38581;
-- OLD name : Todesbringer Saurfang (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38583
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38583;
-- OLD name : Professor Seuchenmord Proxy Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38587
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38587;
-- OLD name : Blood Queen Proxy Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38588;
-- OLD name : Argentumreckenverdienst (Streitertest), subname : A.L.K. (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38595
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38595;
-- OLD name : Fürstin Sylvanas Windläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=38609
UPDATE `creature_template_locale` SET `Name` = 'Lady Sylvanas Windläufer' WHERE `locale` = 'deDE' AND `entry` = 38609;
-- OLD name : Hochlord Alexandros Mograine, subname : Der Aschenbringer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38610;
-- OLD name : Frostmourne Soul Transform Visual (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38710
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38710;
-- OLD name : Magister Thelos (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38716
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38716;
-- OLD name : Aerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38825
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38825;
-- OLD name : Beschützer der Grimmtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38830;
-- OLD name : Erschlagener Behüter von Donnerfels (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38831
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38831;
-- OLD name : Wache der Dunkeleisenzwerge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38839
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38839;
-- OLD name : Sammler der Grimmtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38843;
-- OLD name : Erschlagener Drudie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38846;
-- OLD name : PattyMacks Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38857
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38857;
-- OLD subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts' WHERE `locale` = 'deDE' AND `entry` = 38858;
-- OLD name : Bug 184688 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38860
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38860;
-- OLD name : Unkillable Test Dummy 83 Rogue (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38863
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38863;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38870;
-- OLD name : Bürger der Dunkeleisenzwerge (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38877
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38877;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38882;
-- OLD name : ScottG Test (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38883;
-- OLD name : Auktionator Kavarn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38900
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38900;
-- OLD name : Zivilist aus Eisenschmiede (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38901
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38901;
-- OLD name : Queue trigger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38903
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38903;
-- OLD name : Händer der Grimmtotem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38905;
-- OLD name : Auktionator Sarnkin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38906
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38906;
-- OLD name : Queue Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38907
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38907;
-- OLD name : Bankier der Grimmtotem, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38919
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38919;
-- OLD name : Bankier der Grimmtotem, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38920
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38920;
-- OLD name : Bankier der Grimmtotem, subname : Bankier (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=38921
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38921;
-- OLD name : Aufgebrachter Erdgeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39021
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39021;
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39023;
-- OLD name : Azurblaues Todesstreitross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39045
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39045;
-- OLD name : Aufgebrachter Feuergeist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39047
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39047;
-- OLD name : Gavan Graufeder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39055
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39055;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39057;
-- OLD name : Orcische Feuerwehr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39058;
-- OLD name : Brann Bronzebart (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39060;
-- OLD name : Gegenstand: Illusion der Frosterben (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39089
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39089;
-- OLD name : Durak Flammensprecher, subname : Der Irdene Ring (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39090
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39090;
-- OLD name : Darnavan Kill Credit 10 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39091;
-- OLD name : Darnavan Kill Credit 25 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39092
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39092;
-- OLD name : Kurier Tormun, subname : Forscherliga (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39101;
-- OLD name : Zwielichtsucher, subname : Schattenhammer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39103;
-- OLD name : Blood Quickening Credit 25 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39123
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39123;
-- OLD name : Schattenwächterin der Val'kyr (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39125
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39125;
-- OLD name : Flammender Diener (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39130;
-- OLD name : Wässriger Diener (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39131
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39131;
-- OLD name : Irdener Diener (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39132
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39132;
-- OLD name : Prologue Portal Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39135
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39135;
-- OLD name : Phalanx 2.0 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39158
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39158;
-- OLD name : Marschall Magruder
-- Source : https://www.wowhead.com/wotlk/de/npc=39172
UPDATE `creature_template_locale` SET `Name` = 'Marshall Magruder' WHERE `locale` = 'deDE' AND `entry` = 39172;
-- OLD name : Flugmaschine (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39229;
-- OLD name : Mechanopanzerpilot aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39230;
-- OLD name : Der Lichkönig (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39231
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39231;
-- OLD name : Infanterist aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39252;
-- OLD name : Gnomenbürgerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39253
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39253;
-- OLD name : Flugmaschine aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39259
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39259;
-- OLD name : Zerlegter Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39263;
-- OLD name : Mechanopanzerpilot von Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39264
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39264;
-- OLD name : Geretterter Flüchtling aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39265;
-- OLD name : Hochtüftler Mekkadrill, subname : König der Gnome (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39271
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39271;
-- OLD name : "Doc" Raddreh, subname : Generalärztin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39273
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39273;
-- OLD name : Sanitäter aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39275
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39275;
-- OLD name : Erdheilerin Norsala, subname : Der Irdene Ring (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39283
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39283;
-- OLD name : Weltuntergangsverkünder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39328
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39328;
-- OLD name : Bürger von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39343
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39343;
-- OLD name : Lehrling aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39349
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39349;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39362;
-- OLD name : Ausbildungsoffizier Dampfkurbel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39368;
-- OLD name : Pilot Sprossmündung (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39386
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39386;
-- OLD name : 'Donnerschlag' (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39396
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39396;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39420;
-- OLD name : Radiageigatron (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39421
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39421;
-- OLD name : Blutwache Torek (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39448
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39448;
-- OLD name : Doomsayer Speech Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39454
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39454;
-- OLD name : Owen Testverkäufer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39462
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39462;
-- OLD name : Motivierter Bürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39466
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39466;
-- OLD name : Hauptmann Anton (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39508
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39508;
-- OLD name : Poster Marker - Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39581;
-- OLD name : Gnomenbürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39623
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39623;
-- OLD name : Motivierte Bürgerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39624
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39624;
-- OLD name : Bürger von Orgrimmar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39632;
-- OLD name : Behüter von Sen'jin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39633
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39633;
-- OLD name : Ruheloser Zombie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39639
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39639;
-- OLD name : Zalazane (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39647
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39647;
-- OLD name : Weltuntergangskultist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39648
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39648;
-- OLD name : Vol'jin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39654
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39654;
-- OLD name : Poster Marker - Stormwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39672
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39672;
-- OLD name : Hauptmann Tret Funkdüse (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39675
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39675;
-- OLD name : Toby Zeigrad, subname : Redenschreiber (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39678
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39678;
-- OLD name : Mechanopanzer mit Schleudersitzsystem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39682
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39682;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39683;
-- OLD name : Bürger von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39686
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39686;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39707;
-- OLD name : Mechanopanzerangriffsziel (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39711
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39711;
-- OLD name : Hochtüftler Mekkadrill, subname : König der Gnome (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39712
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39712;
-- OLD name : Krabbelnder Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39713;
-- OLD name : Schießender Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39714
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39714;
-- OLD name : Mechanopanzer mit Schleudersitzsystem (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39715
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39715;
-- OLD name : Krabbelnder Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39716
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39716;
-- OLD name : Schießender Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39717
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39717;
-- OLD name : Multibomber von Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39735
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39735;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39744;
-- OLD name : Bestrahlter Infanterist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39755
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39755;
-- OLD name : Kultist Kagarn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39757;
-- OLD name : Kultist Agtar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39758;
-- OLD name : Panzerbrecherkanone (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39759
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39759;
-- OLD name : Kultistin Tokka (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39760
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39760;
-- OLD name : Kultistin Rokaga (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39763
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39763;
-- OLD name : Muttertrogg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39798;
-- OLD name : Gasherikk (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39799;
-- OLD name : Abbild von Cho'gall, subname : Anführer des Schattenhammers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39807
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39807;
-- OLD name : [DND] Summoning Pad (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39817;
-- OLD name : Bestrahlter Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39818
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39818;
-- OLD name : Bestrahlter Mechanopanzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39819
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39819;
-- OLD name : Raketenwerfer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39820;
-- OLD name : Cho'Gall Speech Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39821
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39821;
-- OLD name : Aufseher Golbaz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39825
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39825;
-- OLD name : Bestrahlter Trogg (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39826
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39826;
-- OLD name : Aufseherin Jintak (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39827
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39827;
-- OLD name : Bestrahlte Kavallerie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39836
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39836;
-- OLD name : Kommandant Bolzrad (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39837
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39837;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39841;
-- OLD name : Invisible Stalker (Hostile, Ignore Combat, Float, Uninteractible, Large AOI) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39842
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39842;
-- OLD name : Tobender Feuerelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39852
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39852;
-- OLD name : Tobender Sturmelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39856
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39856;
-- OLD name : Mechanopanzer aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39860
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39860;
-- OLD name : Besorgter Bürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39861
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39861;
-- OLD name : Cult Recruitment Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39872
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39872;
-- OLD name : Sanitäter aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39888
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39888;
-- OLD name : Weltuntergangskultist (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39891
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39891;
-- OLD name : Robogenieur Thermadrahts Prahlomat (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39901
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39901;
-- OLD name : Kampfanzug aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39902
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39902;
-- OLD name : Verstrahler 3000 (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39903
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39903;
-- OLD name : Hinkels Schnellknall (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39910
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39910;
-- OLD name : Zeppelinwache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39934
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39934;
-- OLD name : Reittier des Zwielichtsuchers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39938
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39938;
-- OLD name : Todessucher, subname : Schattenhammer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39940
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39940;
-- OLD name : Kultistin Lethelyn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39967
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39967;
-- OLD name : Kultistin Kaima (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39968
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39968;
-- OLD name : Kultist Wyman (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39969
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39969;
-- OLD name : Kultist Orlunn (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39970
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39970;
-- OLD name : Schneller orangefarbener Roboschreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39973
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39973;
-- OLD name : East Zeppelin Tower Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39975
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39975;
-- OLD name : West Zeppelin Tower Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39976
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39976;
-- OLD name : Razor Hill Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=39977
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39977;
-- OLD name : Duraks Schild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40006
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40006;
-- OLD name : Mechanoanzug aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40010
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40010;
-- OLD name : Duraks Schild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40037
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40037;
-- OLD name : Duraks Schild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40038
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40038;
-- OLD name : Duraks Schild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40039;
-- OLD name : Mekkadrills Roboschreiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40057
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40057;
-- OLD name : Aufseher Talathor (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40097
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40097;
-- OLD name : Aufseherin Sylandra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40098
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40098;
-- OLD name : Valley of Heroes Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40101;
-- OLD name : Westbrook Garrison Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40102
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40102;
-- OLD name : Goldshire Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40103;
-- OLD name : Tobender Windelementar (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40104;
-- OLD name : Besorgter Bürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40110
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40110;
-- OLD name : Mechanopanzer aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40120
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40120;
-- OLD name : Infanterist aus Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40122
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40122;
-- OLD name : Weltuntergangsverkünder (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40124
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40124;
-- OLD name : Bürger von Sturmwind (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40125
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40125;
-- OLD name : Stadtwache von Sturmwind (Leichnam) (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40138
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40138;
-- OLD name : Tormuns Schild (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40141
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40141;
-- OLD name : Flammender Hippogryph (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40165;
-- OLD name : Mechanopanzer von Gnomeregan (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40175
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40175;
-- OLD name : Frosch aus Sen'jin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40176
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40176;
-- OLD name : Bwonsamdi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40182
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40182;
-- OLD name : Vanira (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40184
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40184;
-- OLD name : Vaniras Totem des Wachens (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40187
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40187;
-- OLD name : Abgestimmter Frosch (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40188
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40188;
-- OLD name : Jun'do der Verräter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40189
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40189;
-- OLD name : Weißes Wollrhinozeros (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40191
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40191;
-- OLD name : Vanira (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40192;
-- OLD name : Geistloser Troll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40195
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40195;
-- OLD name : Zen'tabra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40196
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40196;
-- OLD name : Tikikrieger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40199
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40199;
-- OLD name : Aufklärungsfledermaus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40203
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40203;
-- OLD name : Tierführer Marnlek, subname : Fledermausführer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40204
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40204;
-- OLD name : Zom Bocom, subname : Rüstmeister für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40205
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40205;
-- OLD name : Zokk "Lulatsch" Drillzang, subname : Rüstmeister für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40206
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40206;
-- OLD name : Kezzik der Meuchler, subname : Glorreicher Rüstmeister für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40207
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40207;
-- OLD name : Leeni "Kicher" Erbse, subname : Rüstmeisterin für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40208
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40208;
-- OLD name : Grex Hirnkocher, subname : Klassische Stoff- & Lederrüstungen der Allianz (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40209;
-- OLD name : Xazi Schmauchpfeife, subname : Rüstmeisterin für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40210
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40210;
-- OLD name : Nargel Peitschleine, subname : Glorreicher Rüstmeister für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40211
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40211;
-- OLD name : Eisenfang Rüsti, subname : Überholte Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=40212
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix',`Title` = 'Außergewöhnliche Arenawaffen' WHERE `locale` = 'deDE' AND `entry` = 40212;
-- OLD name : Ecton Messingkipper, subname : Rüstmeister für Ehrenpunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40213
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40213;
-- OLD name : Evee Kupferspule, subname : Rüstmeisterin für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40214
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40214;
-- OLD name : Argex Eisenmagen, subname : Glorreicher Rüstmeister für Eroberungspunkte (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40215
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40215;
-- OLD name : Blazzek der Beißer, subname : Überholte Arenawaffen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40216
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40216;
-- OLD name : Tier von den Echoinseln (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40217
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40217;
-- OLD name : Spy Frog Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40218
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40218;
-- OLD name : Mysteriöses Gerät (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40220
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40220;
-- OLD name : Spähfledermaus (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40222
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40222;
-- OLD name : Verhexter Terrortroll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40225
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40225;
-- OLD name : Verhexter Troll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40231
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40231;
-- OLD name : Krieger der Dunkelspeere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40241
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40241;
-- OLD name : Sockel der Instantstatue (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40246
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40246;
-- OLD name : Champion Uru'zin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40253
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40253;
-- OLD name : Trollbürgerin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40256
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40256;
-- OLD name : Trollbürger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40257
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40257;
-- OLD name : Trollfreiwilliger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40260
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40260;
-- OLD name : Tikikrieger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40263;
-- OLD name : Trollfreiwilliger (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40264
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40264;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40265;
-- OLD name : Ruheloser Zombie (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40274
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40274;
-- OLD name : Bwonsamdi (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40279
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40279;
-- OLD name : Blauer Aufziehraketenbot
-- Source : https://www.wowhead.com/wotlk/de/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Uhrwerkraketenbot' WHERE `locale` = 'deDE' AND `entry` = 40295;
-- OLD name : Tiger Matriarch Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40301;
-- OLD name : Geist des Tigers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40305;
-- OLD name : Tigermatriarchin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40312
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40312;
-- OLD name : Zen'tabra (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40329
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40329;
-- OLD name : Hexendoktor Hez'tok (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40352
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40352;
-- OLD name : Zen'tabras Reiseform (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40354;
-- OLD name : Ritualtänzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40356
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40356;
-- OLD name : Vortänzertroll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40361;
-- OLD name : Tänzer (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40363
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40363;
-- OLD name : Zalazanes Überreste (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40368;
-- OLD name : Ritualtrommler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40373
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40373;
-- OLD name : Stimme der Geister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40374
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40374;
-- OLD name : Omen Event Credit (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40387
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40387;
-- OLD name : Vorfahre der Dunkelspeere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40388
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40388;
-- OLD name : Vol'jin (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40391
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40391;
-- OLD name : Krieger der Dunkelspeere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40392
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40392;
-- OLD name : Tyrantus, subname : Kieupids Begleiter (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40404
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40404;
-- OLD name : Bwonsamdis Knochen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40414
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40414;
-- OLD name : Fledermaus des Spähers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40415
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40415;
-- OLD name : Späher der Dunkelspeere (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40416
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40416;
-- OLD name : Voodootroll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40425
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40425;
-- OLD name : Winziger Mondstoffteppich (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40426
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40426;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40428;
-- OLD name : Winkeladvokat des Dampfdruckkartells, subname : Dungeonmeister (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40438
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40438;
-- OLD name : Elgin Klicksprung, subname : Assistentin des Hochtüftlers (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40478
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40478;
-- OLD name : Kamerafahrzeug (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40479
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40479;
-- OLD name : Feiernder Troll (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40481
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40481;
-- OLD name : Zild'jian, subname : Vol'jins Kriegstrommler (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40492
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40492;
-- OLD name : Zalazane (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40502
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40502;
-- OLD name : Explosion Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40506
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40506;
-- OLD name : Hauptmann T'Maire Sydes, subname : Rüstmeisterin für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40606
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40606;
-- OLD name : Hauptmann T'Maire Sydes, subname : Rüstmeisterin für Rüstungen aus Nordend (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40607;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40617;
-- OLD name : Himmelsross (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40625
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40625;
-- OLD name : Protodrachenreittier der Vrykul (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40704
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40704;
-- OLD name : Crafticus Jones, subname : Nicht spawnen (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40724
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40724;
-- OLD name : X-53 Reiserakete (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40725
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40725;
-- OLD name : Rubindrache (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=40842
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40842;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST)
-- Source : https://www.wowhead.com/wotlk/de/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 41839;
