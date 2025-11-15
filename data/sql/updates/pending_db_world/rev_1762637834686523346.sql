-- Update deDE ; from WowHead WOTLK+ / Retail
-- OLD name : Schmalspurrohling
-- Source : https://www.wowhead.com/wotlk/de/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Rohling der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38;
-- OLD name : Niederer Sukkubus
-- Source : https://www.wowhead.com/wotlk/de/npc=49
UPDATE `creature_template_locale` SET `Name` = 'Geringer Sukkubus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 49;
-- OLD name : [UNUSED] Lower Class Citizen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 70;
-- OLD name : [UNUSED] Vashaum Nightwither (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 75;
-- OLD name : [UNUSED] Luglar the Clogger (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Holiday - Halloween - Garrison - Spectral Alemental',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 81;
-- OLD name : Taschendieb
-- Source : https://www.wowhead.com/wotlk/de/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Taschendieb der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 94;
-- OLD name : Kodowildtier
-- Source : https://www.wowhead.com/wotlk/de/npc=106
UPDATE `creature_template_locale` SET `Name` = 'Kodobestie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 106;
-- OLD name : Bandit
-- Source : https://www.wowhead.com/wotlk/de/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandit der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 116;
-- OLD name : [UNUSED] Small Black Dragon Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 149;
-- OLD name : [UNUSED] Ander the Monk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 161;
-- OLD name : [UNUSED] Destitute Farmer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 163;
-- OLD name : [UNUSED] Small Child (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 165;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=198
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 198;
-- OLD name : Verrottender Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Skelettschrecken',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 202;
-- OLD name : [UNUSED] Cackle Flamebone (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 204;
-- OLD name : [UNUSED] Riverpaw Hideflayer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 207;
-- OLD name : [UNUSED] Riverpaw Pack Warder (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 208;
-- OLD name : [UNUSED] Riverpaw Bone Chanter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 209;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/de/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (230, 'deDE','Theodor Teufelswald','Holzschnitzer',0);
-- OLD name : Marschall Gryan Starkmantel, subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Starkmantel',`Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 234;
-- OLD name : [UNUSED] Greeby Mudwhisker TEST (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=243
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 243;
-- OLD name : [UNUSED] Elwynn Tower Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 260;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/de/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Ein halb aufgefressener Körper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 262;
-- OLD name : Koboldpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=281
UPDATE `creature_template_locale` SET `Name` = 'Koboldtank',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 281;
-- OLD name : [UNUSED] Goodmother Jans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 296;
-- OLD name : Junger Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Erkrankter junger Wolf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 299;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 301;
-- OLD name : Schimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Schimmel)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 305;
-- OLD name : Palomino
-- Source : https://www.wowhead.com/wotlk/de/npc=306
UPDATE `creature_template_locale` SET `Name` = 'Reitpferd (Palomino)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 306;
-- OLD name : "Buried Upside-Down" Vehicle
-- Source : https://www.wowhead.com/wotlk/de/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Rolfs Leichnam',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 309;
-- OLD name : [UNUSED] Brother Akil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 318;
-- OLD name : [UNUSED] Brother Benthas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 319;
-- OLD name : [UNUSED] Brother Cryus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 320;
-- OLD name : [UNUSED] Brother Deros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 321;
-- OLD name : [UNUSED] Brother Enoch (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 322;
-- OLD name : [UNUSED] Brother Greishan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 324;
-- OLD name : [UNUSED] Brother Ictharin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 326;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=328
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 328;
-- OLD subname : Anführer des SI:7
-- Source : https://www.wowhead.com/wotlk/de/npc=332
UPDATE `creature_template_locale` SET `Title` = 'Anführer von SI:7',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 332;
-- OLD name : [UNUSED] Edwardo the Jester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 333;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor the Pugilist (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 339;
-- OLD name : Winterwolf
-- Source : https://www.wowhead.com/wotlk/de/npc=359
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Winter)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 359;
-- OLD name : Murak Winterborn
-- Source : https://www.wowhead.com/wotlk/de/npc=373
UPDATE `creature_template_locale` SET `Name` = 'Marek Winterborn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 373;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/de/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Kellnerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 380;
-- OLD name : Katie Weidmann
-- Source : https://www.wowhead.com/wotlk/de/npc=384
UPDATE `creature_template_locale` SET `Name` = 'Katie Waidmann',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 384;
-- OLD name : Niederer Leerwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=418
UPDATE `creature_template_locale` SET `Name` = 'Geringer Leerwandler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 418;
-- OLD name : Champion des Schwarzfels
-- Source : https://www.wowhead.com/wotlk/de/npc=435
UPDATE `creature_template_locale` SET `Name` = 'Held des Schwarzfels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 435;
-- OLD name : Pausbacke (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Graf Ferkel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 444;
-- OLD name : Wachhauptmann Parker
-- Source : https://www.wowhead.com/wotlk/de/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Wache Parker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 464;
-- OLD name : [UNUSED] Scribe Colburg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 470;
-- OLD name : Abtrünniger Hexer
-- Source : https://www.wowhead.com/wotlk/de/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Abtrünniger Hexer der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 474;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=487
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 487;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=488
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 488;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=489
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 489;
-- OLD name : Beschützerin Gariel, subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=490
UPDATE `creature_template_locale` SET `Name` = 'Beschützer Gariel',`Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 490;
-- OLD name : [UNUSED] Watcher Kleeman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 496;
-- OLD name : [UNUSED] Watcher Benjamin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 497;
-- OLD name : [UNUSED] Watcher Larsen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 498;
-- OLD name : [UNUSED] Long Fang (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 509;
-- OLD name : [UNUSED] Riverpaw Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 516;
-- OLD name : [UNUSED] Savar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 535;
-- OLD name : [UNUSED] Rhal'Del (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 536;
-- OLD name : [UNUSED] Buk'Cha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 538;
-- OLD name : Wegelagerer
-- Source : https://www.wowhead.com/wotlk/de/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Wegelagerer der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 583;
-- OLD name : [UNUSED] Watcher Kern (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 586;
-- OLD name : [UNUSED] Mr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=605
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 605;
-- OLD name : [UNUSED] Mrs. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=606
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 606;
-- OLD name : [UNUSED] Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 607;
-- OLD name : [UNUSED] Grandpa Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=609
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 609;
-- OLD name : [UNUSED] Rabid Gina Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 610;
-- OLD name : [UNUSED] Rabid Mr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=611
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 611;
-- OLD name : [UNUSED] Rabid Mrs. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=612
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 612;
-- OLD name : [UNUSED] Rabid Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=613
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 613;
-- OLD name : [UNUSED] Rabid Grandpa Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=614
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 614;
-- OLD name : Geschriebene Worte, subname : Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=693
UPDATE `creature_template_locale` SET `Name` = 'Lehrer für sekundäre Fertigkeiten',`Title` = 'Lehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 693;
-- OLD name : General Fangor
-- Source : https://www.wowhead.com/wotlk/de/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Leutnant Fangor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 703;
-- OLD name : Felsenkiefertrogg
-- Source : https://www.wowhead.com/wotlk/de/npc=707
UPDATE `creature_template_locale` SET `Name` = 'Trogg der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 707;
-- OLD name : Bulliger Felsenkiefertrogg
-- Source : https://www.wowhead.com/wotlk/de/npc=724
UPDATE `creature_template_locale` SET `Name` = 'Bulliger Trogg der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 724;
-- OLD name : [UNUSED] Skeletal Enforcer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=725
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 725;
-- OLD name : Unteroffizierin Yohwa
-- Source : https://www.wowhead.com/wotlk/de/npc=733
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Yohwa',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 733;
-- OLD name : [UNUSED] Rebel Soldier (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 753;
-- OLD name : Matschwirbler der Verirrten
-- Source : https://www.wowhead.com/wotlk/de/npc=760
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Verirrten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 760;
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=789
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacherin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 789;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=820
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 820;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=821
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 821;
-- OLD name : Unteroffizier Willem
-- Source : https://www.wowhead.com/wotlk/de/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Stellvertreter Willem',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 823;
-- OLD name : Entfesselter Zyklon
-- Source : https://www.wowhead.com/wotlk/de/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Staubteufel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 832;
-- OLD name : Harl Cutter, subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (841, 'deDE','Harl Scherer','Holzschnitzbedarf',0);
-- OLD name : Wolfsbegleiter
-- Source : https://www.wowhead.com/wotlk/de/npc=860
UPDATE `creature_template_locale` SET `Name` = 'Wolfstier',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 860;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=869
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 869;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=870
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 870;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=874
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 874;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=876
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 876;
-- OLD subname : Die Westfallbrigade
-- Source : https://www.wowhead.com/wotlk/de/npc=878
UPDATE `creature_template_locale` SET `Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 878;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=944
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 944;
-- OLD subname : Librarian
-- Source : https://www.wowhead.com/wotlk/de/npc=951
UPDATE `creature_template_locale` SET `Title` = 'Bibliothekar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 951;
-- OLD name : Erik Dodds der Dritte
-- Source : https://www.wowhead.com/wotlk/de/npc=996
UPDATE `creature_template_locale` SET `Name` = 'Schneidermeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 996;
-- OLD name : Unkillable Test Dummy, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=1000
UPDATE `creature_template_locale` SET `Name` = 'Behüter Blomberg',`Title` = 'Die Nachtwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1000;
-- OLD name : Matschwirbler der Blaukiemen
-- Source : https://www.wowhead.com/wotlk/de/npc=1028
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Blaukiemen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1028;
-- OLD name : [UNUSED] Truek (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=1058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1058;
-- OLD name : Schädelhauer der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1115
UPDATE `creature_template_locale` SET `Name` = 'Schädelhauer der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1115;
-- OLD name : Wegelagerer der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1116
UPDATE `creature_template_locale` SET `Name` = 'Wegelagerer der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1116;
-- OLD name : Knochenknacker der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1117
UPDATE `creature_template_locale` SET `Name` = 'Knochenknacker der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1117;
-- OLD name : Kreuzbrecher der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1118
UPDATE `creature_template_locale` SET `Name` = 'Kreuzbrecher der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1118;
-- OLD name : Schwarzbär
-- Source : https://www.wowhead.com/wotlk/de/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Alter Schwarzbär',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1186;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1228
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1228;
-- OLD name : Weißer Widder X
-- Source : https://www.wowhead.com/wotlk/de/npc=1262
UPDATE `creature_template_locale` SET `Name` = 'Weißer Widder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1262;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1294
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1294;
-- OLD subname : Bogenhändler
-- Source : https://www.wowhead.com/wotlk/de/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Bogen- & Pfeilhändler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1298;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1322
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1322;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1323
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1323;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1341
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1341;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=1349
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1349;
-- OLD name : [UNUSED] Kern the Enforcer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=1361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1361;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Überragender Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1382;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1430;
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (1455, 'deDE',NULL,'Pfeilmacherbedarf',0);
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=1462
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacherin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1462;
-- OLD name : Todeswache Simmer
-- Source : https://www.wowhead.com/wotlk/de/npc=1519
UPDATE `creature_template_locale` SET `Name` = 'Todeswache Brodler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1519;
-- OLD name : Matschwirbler der Finsterflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=1545
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Finsterflossen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1545;
-- OLD name : Slims Testschurke
-- Source : https://www.wowhead.com/wotlk/de/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1601;
-- OLD name : [UNUSED] Elwynn Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 1643;
-- OLD name : Novizin Elreth
-- Source : https://www.wowhead.com/wotlk/de/npc=1661
UPDATE `creature_template_locale` SET `Name` = 'Novize Elreth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1661;
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/de/npc=1677
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1677;
-- OLD subname : Lederrüstungshändlerin
-- Source : https://www.wowhead.com/wotlk/de/npc=1695
UPDATE `creature_template_locale` SET `Title` = 'Lederrüstungshändler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1695;
-- OLD name : Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Gefangener Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1706;
-- OLD name : Eingekerkerter
-- Source : https://www.wowhead.com/wotlk/de/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Eingekerkerter Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1711;
-- OLD name : Aufrührer
-- Source : https://www.wowhead.com/wotlk/de/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Aufrührer der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1715;
-- OLD name : Räuber der Felsenkiefertroggs
-- Source : https://www.wowhead.com/wotlk/de/npc=1718
UPDATE `creature_template_locale` SET `Name` = 'Räuber der Felsenkiefer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1718;
-- OLD name : Großadmiralin Jes-Tereth
-- Source : https://www.wowhead.com/wotlk/de/npc=1750
UPDATE `creature_template_locale` SET `Name` = 'Großadmiral Jes-Tereth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1750;
-- OLD name : Tollwütiger Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Scheckiger Worg',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1766;
-- OLD name : Netzhuscherhetzer
-- Source : https://www.wowhead.com/wotlk/de/npc=1780
UPDATE `creature_template_locale` SET `Name` = 'Moospirscher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1780;
-- OLD name : Netzhuscherlauerer
-- Source : https://www.wowhead.com/wotlk/de/npc=1781
UPDATE `creature_template_locale` SET `Name` = 'Nebelkrabbler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1781;
-- OLD name : Skelettschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=1785
UPDATE `creature_template_locale` SET `Name` = 'Skelettschrecker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1785;
-- OLD name : Tollwütiger Riesenbär
-- Source : https://www.wowhead.com/wotlk/de/npc=1797
UPDATE `creature_template_locale` SET `Name` = 'Ergrauter Riesenbär',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1797;
-- OLD name : Niederer Netherwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=1862
UPDATE `creature_template_locale` SET `Name` = 'Geringer Netherwandler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1862;
-- OLD name : Behüter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Behüter von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1888;
-- OLD name : Hexer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Hexer von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1889;
-- OLD name : Beschützer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1912
UPDATE `creature_template_locale` SET `Name` = 'Beschützer von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1912;
-- OLD name : Wärter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1913
UPDATE `creature_template_locale` SET `Name` = 'Wärter von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1913;
-- OLD name : Magister von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1914
UPDATE `creature_template_locale` SET `Name` = 'Magier von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1914;
-- OLD name : Herbeizauberer von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1915
UPDATE `creature_template_locale` SET `Name` = 'Herbeizauberer von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1915;
-- OLD name : Zauberschreiber von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=1920
UPDATE `creature_template_locale` SET `Name` = 'Zauberschreiber von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1920;
-- OLD subname : Immun gegen Körperliches
-- Source : https://www.wowhead.com/wotlk/de/npc=1930
UPDATE `creature_template_locale` SET `Title` = 'Immun gegen Körperschäden',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 1930;
-- OLD name : Uralter Beschützer
-- Source : https://www.wowhead.com/wotlk/de/npc=2041
UPDATE `creature_template_locale` SET `Name` = 'Urtumbeschützer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2041;
-- OLD name : Athridas Bärenfell
-- Source : https://www.wowhead.com/wotlk/de/npc=2078
UPDATE `creature_template_locale` SET `Name` = 'Athridas Bärenpelz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2078;
-- OLD name : Ilthalaine
-- Source : https://www.wowhead.com/wotlk/de/npc=2079
UPDATE `creature_template_locale` SET `Name` = 'Konservator Ilthalaine',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2079;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2124
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2124;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=2128
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2128;
-- OLD name : [UNUSED] Crier Kirton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2197;
-- OLD name : [UNUSED] Crier Backus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2199;
-- OLD name : [UNUSED] Crier Pierce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2200;
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2220
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2223
UPDATE `creature_template_locale` SET `Title` = 'Kochkunstlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2223;
-- OLD name : Maggarrak
-- Source : https://www.wowhead.com/wotlk/de/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Steinwüter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2258;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/de/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2286, 'deDE','Bogenträger',NULL,0);
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2313;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Arzt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2326;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Ärztin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2329;
-- OLD name : Fanatikerin des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=2336
UPDATE `creature_template_locale` SET `Name` = 'Fanatikerin des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2336;
-- OLD name : Leerruferin des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=2337
UPDATE `creature_template_locale` SET `Name` = 'Leerruferin des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2337;
-- OLD name : Domestizierter Krabbler
-- Source : https://www.wowhead.com/wotlk/de/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Riesiger Mooskrabbler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2349;
-- OLD name : Waldkrabbler
-- Source : https://www.wowhead.com/wotlk/de/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Waldmooskrabbler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2350;
-- OLD name : Verseuchter Bär
-- Source : https://www.wowhead.com/wotlk/de/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Graubär',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2351;
-- OLD name : Matschwirbler der Fetzenflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=2374
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Fetzenflossen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2374;
-- OLD name : Hügellandpirscher
-- Source : https://www.wowhead.com/wotlk/de/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'Wilder Berglöwe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2385;
-- OLD name : Wächter der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Wache von Süderstade',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2386;
-- OLD name : Gosh-Haldir
-- Source : https://www.wowhead.com/wotlk/de/npc=2476
UPDATE `creature_template_locale` SET `Name` = 'Großer Lochkrokilisk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2476;
-- OLD name : Himmelsmähnengorilla
-- Source : https://www.wowhead.com/wotlk/de/npc=2521
UPDATE `creature_template_locale` SET `Name` = 'Blaumähnengorilla',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2521;
-- OLD subname : Gesandter von Zanzil
-- Source : https://www.wowhead.com/wotlk/de/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Geisel der Dunkelspeere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2530;
-- OLD name : Diener von Doane
-- Source : https://www.wowhead.com/wotlk/de/npc=2531
UPDATE `creature_template_locale` SET `Name` = 'Diener von Morganth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2531;
-- OLD name : Schlange von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=2540
UPDATE `creature_template_locale` SET `Name` = 'Schlange von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2540;
-- OLD name : Soldat von Stromgarde
-- Source : https://www.wowhead.com/wotlk/de/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Verteidiger von Stromgarde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2585;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/de/npc=2598
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeister des Schattenrats',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2598;
-- OLD name : Sängerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2600
UPDATE `creature_template_locale` SET `Name` = 'Sänger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2600;
-- OLD name : Kommandantin Amaren
-- Source : https://www.wowhead.com/wotlk/de/npc=2608
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Amaren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2608;
-- OLD name : [UNUSED] Archmage Detrae (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2617;
-- OLD name : Alter Schnappkieferkrokilisk
-- Source : https://www.wowhead.com/wotlk/de/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Alter Salzwasserkrokilisk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2635;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2662, 'deDE','Hafenmeister Szik','Bootsverkäufer',0);
-- OLD name : Barrikade
-- Source : https://www.wowhead.com/wotlk/de/npc=2749
UPDATE `creature_template_locale` SET `Name` = 'Belagerungsgolem',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2749;
-- OLD name : Ausgedörrter Bussard
-- Source : https://www.wowhead.com/wotlk/de/npc=2830
UPDATE `creature_template_locale` SET `Name` = 'Bussard',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2830;
-- OLD subname : Klingenhändlerin
-- Source : https://www.wowhead.com/wotlk/de/npc=2843
UPDATE `creature_template_locale` SET `Title` = 'Klingentrödlerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2843;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Krokiliskenausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2876;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Fertigkeitenlehrer für Distanzwaffen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2886;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=2935
UPDATE `creature_template_locale` SET `Title` = 'Dämonenausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2935;
-- OLD name : Aldric Weidmann, subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2938
UPDATE `creature_template_locale` SET `Name` = 'Aldric Waidmann',`Title` = 'Bärenausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2938;
-- OLD subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2939, 'deDE',NULL,'Eberausbilder',0);
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=2942
UPDATE `creature_template_locale` SET `Title` = 'Wolfausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2942;
-- OLD name : Eindringling der Borstennacken
-- Source : https://www.wowhead.com/wotlk/de/npc=2952
UPDATE `creature_template_locale` SET `Name` = 'Stacheleber der Borstennacken',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2952;
-- OLD name : Junger Kampfeber
-- Source : https://www.wowhead.com/wotlk/de/npc=2966
UPDATE `creature_template_locale` SET `Name` = 'Kampfeber',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2966;
-- OLD name : Geist der Ahnen
-- Source : https://www.wowhead.com/wotlk/de/npc=2994
UPDATE `creature_template_locale` SET `Name` = 'Vorfahrengeist',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 2994;
-- OLD subname : Schneiderbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungs- & Schneiderbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3005;
-- OLD subname : Lederverarbeitungsbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungslehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3008;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3047
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3047;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=3048
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3048;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3049
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3049;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3067
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3067;
-- OLD subname : Geselle des Alchemiehandwerks
-- Source : https://www.wowhead.com/wotlk/de/npc=3070
UPDATE `creature_template_locale` SET `Title` = 'Alchimist <Needs Model>',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3070;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3071
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundiger <Needs Model>',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3071;
-- OLD name : [UNUSED] Narache Guard (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=3082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3082;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3095
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3095;
-- OLD name : Brandungskriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Zwergbrandungskriecher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3106;
-- OLD name : Ausgewachsener Brandungskriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Brandungskriecher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3107;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=3149
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3149;
-- OLD name : Neeru Fireblade
-- Source : https://www.wowhead.com/wotlk/de/npc=3200
UPDATE `creature_template_locale` SET `Name` = 'Erics Superspezialbedarfverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3200;
-- OLD name : Scott Mercer
-- Source : https://www.wowhead.com/wotlk/de/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3201;
-- OLD name : Zischel Dunkelklaue
-- Source : https://www.wowhead.com/wotlk/de/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Zischel Düstersturm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3203;
-- OLD name : Wissenshüter Regentotem
-- Source : https://www.wowhead.com/wotlk/de/npc=3233
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Regentotem',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3233;
-- OLD name : Sonnenschuppenschmetterschwanz
-- Source : https://www.wowhead.com/wotlk/de/npc=3254
UPDATE `creature_template_locale` SET `Name` = 'Bluthornschmetterschwanz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3254;
-- OLD name : Sonnenschuppenkreischer
-- Source : https://www.wowhead.com/wotlk/de/npc=3255
UPDATE `creature_template_locale` SET `Name` = 'Bluthornkreischer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3255;
-- OLD name : Sonnenschuppensensenklaue
-- Source : https://www.wowhead.com/wotlk/de/npc=3256
UPDATE `creature_template_locale` SET `Name` = 'Bluthornsensenklaue',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3256;
-- OLD name : Brandschatzer der Klingenmähnen
-- Source : https://www.wowhead.com/wotlk/de/npc=3267
UPDATE `creature_template_locale` SET `Name` = 'Wassersucher der Klingenmähnen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3267;
-- OLD name : Schlickanomalie
-- Source : https://www.wowhead.com/wotlk/de/npc=3295
UPDATE `creature_template_locale` SET `Name` = 'Schlickbestie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3295;
-- OLD subname : Stoffrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Händler für leichte Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3317;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3319
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3319;
-- OLD subname : Verkäuferin für Bögen & Gewehre
-- Source : https://www.wowhead.com/wotlk/de/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3322;
-- OLD subname : Reagenzien & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundebedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3405;
-- OLD name : Lebende Flamme
-- Source : https://www.wowhead.com/wotlk/de/npc=3417
UPDATE `creature_template_locale` SET `Name` = 'Lebendige Flamme',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3417;
-- OLD name : [UNUSED] Ancestral Watcher (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=3420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3420;
-- OLD name : [UNUSED] Kendur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=3427
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3427;
-- OLD name : [UNUSED] Ancestral Sage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=3440
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3440;
-- OLD subname : Unabhängiger Vertragspartner
-- Source : https://www.wowhead.com/wotlk/de/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Tüftlerverband',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3442;
-- OLD subname : Händler für Leder- & Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=3483
UPDATE `creature_template_locale` SET `Title` = 'Händler für Leder- & schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3483;
-- OLD subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3558
UPDATE `creature_template_locale` SET `Title` = 'Giftreagenzien',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3558;
-- OLD name : Temp Giftmischereibedarfsverkäufer Zwerg, subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=3559
UPDATE `creature_template_locale` SET `Name` = 'Temp Giftmischereibedarfverkäufer Zwerg',`Title` = 'Giftreagenzien',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3559;
-- OLD name : Braumeister von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Braumeister von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3577;
-- OLD name : Minenarbeiter von Mühlenbern
-- Source : https://www.wowhead.com/wotlk/de/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Minenarbeiter von Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3578;
-- OLD name : [UNUSED] Kolkar Observer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3651;
-- OLD subname : Kult des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3660
UPDATE `creature_template_locale` SET `Title` = 'Kult des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3660;
-- OLD name : Muyoh
-- Source : https://www.wowhead.com/wotlk/de/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Jünger von Naralex',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3678;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (3697, 'deDE','Kyln Langklaue','Eberausbilder',0);
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3698
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=3699
UPDATE `creature_template_locale` SET `Title` = 'Katzenausbilderin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3699;
-- OLD name : Nebelpeitscherhydra
-- Source : https://www.wowhead.com/wotlk/de/npc=3721
UPDATE `creature_template_locale` SET `Name` = 'Mythosschuppenhydra',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3721;
-- OLD name : Nebelpeitscherschinder
-- Source : https://www.wowhead.com/wotlk/de/npc=3722
UPDATE `creature_template_locale` SET `Name` = 'Mythosschuppenschinder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3722;
-- OLD name : Kultist des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3725
UPDATE `creature_template_locale` SET `Name` = 'Kultist des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3725;
-- OLD name : Vollstrecker des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3727
UPDATE `creature_template_locale` SET `Name` = 'Vollstrecker des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3727;
-- OLD name : Adept des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3728
UPDATE `creature_template_locale` SET `Name` = 'Adept des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3728;
-- OLD name : Ausgräber des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3730
UPDATE `creature_template_locale` SET `Name` = 'Ausgräber des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3730;
-- OLD name : Orcischer Aufseher
-- Source : https://www.wowhead.com/wotlk/de/npc=3734
UPDATE `creature_template_locale` SET `Name` = 'Rohling der Verlassenen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3734;
-- OLD name : Matschwirbler der Salzflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=3740
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Salzflossen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3740;
-- OLD name : Angesengter Schlurfer
-- Source : https://www.wowhead.com/wotlk/de/npc=3780
UPDATE `creature_template_locale` SET `Name` = 'Schattendickichtmoosfresser',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3780;
-- OLD name : Flimmerdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=3815
UPDATE `creature_template_locale` SET `Name` = 'Beflügelter Großdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3815;
-- OLD name : Teldira Mondfeder
-- Source : https://www.wowhead.com/wotlk/de/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Caylais Mondfeder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3841;
-- OLD name : Niederer Gargoyle
-- Source : https://www.wowhead.com/wotlk/de/npc=3869
UPDATE `creature_template_locale` SET `Name` = 'Geringer Gargoyle',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3869;
-- OLD name : Auftragsmörder des Dunklen Strangs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=3879
UPDATE `creature_template_locale` SET `Name` = 'Auftragsmörder des dunklen Strangs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3879;
-- OLD name : Siechendes Urtum
-- Source : https://www.wowhead.com/wotlk/de/npc=3919
UPDATE `creature_template_locale` SET `Name` = 'Welkes Urtum',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3919;
-- OLD subname : Generalin der Schildwachenarmee
-- Source : https://www.wowhead.com/wotlk/de/npc=3936
UPDATE `creature_template_locale` SET `Title` = 'General der Schildwachenarmee',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3936;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=3966
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3966;
-- OLD subname : Giftverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=3969
UPDATE `creature_template_locale` SET `Title` = 'Werkzeuge und Bedarfsartikel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3969;
-- OLD name : Bewacher der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=3992
UPDATE `creature_template_locale` SET `Name` = 'Ingenieur der Venture Co.',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 3992;
-- OLD name : Prachtschwingenwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=4012
UPDATE `creature_template_locale` SET `Name` = 'Prachtschwingenflügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4012;
-- OLD name : Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=4016
UPDATE `creature_template_locale` SET `Name` = 'Siechdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4016;
-- OLD name : Verschlagener Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=4017
UPDATE `creature_template_locale` SET `Name` = 'Verschlagener Siechdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4017;
-- OLD name : Verderbte Blutsaftbestie
-- Source : https://www.wowhead.com/wotlk/de/npc=4021
UPDATE `creature_template_locale` SET `Name` = 'Ätzblutsaftbestie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4021;
-- OLD name : Schwarzgebratener Basilisk
-- Source : https://www.wowhead.com/wotlk/de/npc=4044
UPDATE `creature_template_locale` SET `Name` = 'Geschwärzter Basilisk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4044;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/de/npc=4045
UPDATE `creature_template_locale` SET `Name` = NULL,`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4045;
-- OLD name : Steilhangwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=4107
UPDATE `creature_template_locale` SET `Name` = 'Steilhangflügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4107;
-- OLD name : Krkk'kx
-- Source : https://www.wowhead.com/wotlk/de/npc=4132
UPDATE `creature_template_locale` SET `Name` = 'Silithidverheerer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4132;
-- OLD name : Skorpidschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=4139
UPDATE `creature_template_locale` SET `Name` = 'Skorpidschrecker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4139;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4149
UPDATE `creature_template_locale` SET `Title` = 'Nahrungssuchelehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4153
UPDATE `creature_template_locale` SET `Title` = 'Katzenausbilderin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4153;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4157
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4157;
-- OLD subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/de/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4174, 'deDE',NULL,'Pfeilhändlerin',0);
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4177
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4177;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4178
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4178;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4206
UPDATE `creature_template_locale` SET `Title` = 'Bärenausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4207
UPDATE `creature_template_locale` SET `Title` = 'Wolfausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4207;
-- OLD subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/de/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4224, 'deDE',NULL,'Kartografiebedarf',0);
-- OLD name : Grauer Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=4268
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Grau)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4268;
-- OLD name : Roter Wolf
-- Source : https://www.wowhead.com/wotlk/de/npc=4270
UPDATE `creature_template_locale` SET `Name` = 'Reitwolf (Rot)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4270;
-- OLD name : Scharlachroter Champion
-- Source : https://www.wowhead.com/wotlk/de/npc=4302
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Held',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4302;
-- OLD name : Scharlachroter Folterer
-- Source : https://www.wowhead.com/wotlk/de/npc=4306
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Folterknecht',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4306;
-- OLD name : Matschwirbler der Schlammflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=4361
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Schlammflossen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4361;
-- OLD name : Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4391
UPDATE `creature_template_locale` SET `Name` = 'Sumpfbrühschlammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4391;
-- OLD name : Ätzender Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4392
UPDATE `creature_template_locale` SET `Name` = 'Ätzender Sumpfbrühschlammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4392;
-- OLD name : Wallender Sumpfschlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=4395
UPDATE `creature_template_locale` SET `Name` = 'Wallender Sumpfbrühschlammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4395;
-- OLD name : Rennmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=4419
UPDATE `creature_template_locale` SET `Name` = 'Rennmeister Kronkreiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4419;
-- OLD subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/de/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4443, 'deDE',NULL,'Totemverkäuferin',0);
-- OLD name : Blut von Agamaggan
-- Source : https://www.wowhead.com/wotlk/de/npc=4541
UPDATE `creature_template_locale` SET `Name` = 'Blut von Agammagan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4541;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4559
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4559;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=4560
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4560;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4566
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4566;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=4567
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4567;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4568
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4568;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Schattengewebeschneidermeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4578;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4579
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4579;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4621
UPDATE `creature_template_locale` SET `Title` = 'Raptorausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4621;
-- OLD name : Kolkarzentaure
-- Source : https://www.wowhead.com/wotlk/de/npc=4632
UPDATE `creature_template_locale` SET `Name` = 'Zentaur der Kolkar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4632;
-- OLD name : Randal Weidmann
-- Source : https://www.wowhead.com/wotlk/de/npc=4732
UPDATE `creature_template_locale` SET `Name` = 'Randal Waidmann',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4732;
-- OLD name : Frostwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=4778
UPDATE `creature_template_locale` SET `Name` = 'Reitwidder (Blau)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4778;
-- OLD name : Schwarzer Widder
-- Source : https://www.wowhead.com/wotlk/de/npc=4780
UPDATE `creature_template_locale` SET `Name` = 'Reitwidder (Schwarz)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4780;
-- OLD name : Zwielichtakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=4809
UPDATE `creature_template_locale` SET `Name` = 'Akolyth des Schattenhammers',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4809;
-- OLD name : Matschwirbler der Nachtaugen
-- Source : https://www.wowhead.com/wotlk/de/npc=4819
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler der Nachtaugen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4819;
-- OLD subname : Wissenshüter
-- Source : https://www.wowhead.com/wotlk/de/npc=4878
UPDATE `creature_template_locale` SET `Title` = 'Bewahrer der Lehren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4878;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4881
UPDATE `creature_template_locale` SET `Title` = 'Schildkrötenausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4881;
-- OLD subname : Rüstungs- & Waffenschmied
-- Source : https://www.wowhead.com/wotlk/de/npc=4886
UPDATE `creature_template_locale` SET `Title` = 'Rüstungs- & Schildschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4886;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4888;
-- OLD subname : Jägerlehrer & Bogenmacher
-- Source : https://www.wowhead.com/wotlk/de/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Bogenmacher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4892;
-- OLD subname : Kochlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4894;
-- OLD subname : Gemischtwaren & Reagenzien
-- Source : https://www.wowhead.com/wotlk/de/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Gemischtwaren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4896;
-- OLD name : Wasserschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Mokassin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4953;
-- OLD subname : Herrscherin über Theramore
-- Source : https://www.wowhead.com/wotlk/de/npc=4968
UPDATE `creature_template_locale` SET `Title` = 'Herrscherin von Theramore',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4968;
-- OLD name : Welt Magierlehrerin, subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=4987
UPDATE `creature_template_locale` SET `Name` = 'Welt Magielehrerin',`Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4987;
-- OLD subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=4994
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Wölfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 4994;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5001
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Vögel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5001;
-- OLD name : World Boar Trainer, subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (5002, 'deDE','Welt Eberausbilderin','Tierausbilderin für Eber',0);
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5003
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Katzen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5004
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Kriecher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5005
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Krokodile',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5005;
-- OLD name : Weltdämonenausbilderin, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'Welt Dämonenausbilderin',`Title` = 'Dämonenausbilderin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5008
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Gorillas',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5008;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5009
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Pferde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5011
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Raptoren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5012
UPDATE `creature_template_locale` SET `Title` = 'Skorpidtierausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5013
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Spinnen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5013;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5015
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Weitschreiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5015;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5017
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilder für Schildkröten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5017;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5026
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5026;
-- OLD name : [PH] Schmerzbanner der Mogu, subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5027
UPDATE `creature_template_locale` SET `Name` = 'Welt Schlossknackenlehrerin',`Title` = 'Schlossknackenlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5027;
-- OLD name : Jiming, subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5029
UPDATE `creature_template_locale` SET `Name` = 'Welt Überlebenskunstlehrerin',`Title` = 'Überlebenskunstlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5029;
-- OLD subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5030
UPDATE `creature_template_locale` SET `Title` = 'Tigerreitlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5030;
-- OLD name : Welt-Alchemielehrerin, subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5032
UPDATE `creature_template_locale` SET `Name` = 'Welt Alchimielehrerin',`Title` = 'Alchimielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5032;
-- OLD name : Winwa, subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5034
UPDATE `creature_template_locale` SET `Name` = 'Welt Braukunstlehrerin',`Title` = 'Brauskunstlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5035
UPDATE `creature_template_locale` SET `Title` = 'Kartografielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5035;
-- OLD subname : Hexenmeisterlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5039
UPDATE `creature_template_locale` SET `Title` = 'Fährtenlesekunstlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5039;
-- OLD name : Rabauke
-- Source : https://www.wowhead.com/wotlk/de/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Rabauke der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5043;
-- OLD name : Zahlmeister Lendry
-- Source : https://www.wowhead.com/wotlk/de/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Amtmann Lendry',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5083;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5104
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffenlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5104;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5106
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5106;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5107
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5107;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5125
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5125;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5126
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5126;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5144
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5144;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5145
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5145;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5146
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5146;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5164;
-- OLD name : Jeremys Testmonster
-- Source : https://www.wowhead.com/wotlk/de/npc=5326
UPDATE `creature_template_locale` SET `Name` = 'Küstenkriecherklacker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5326;
-- OLD subname : Juwelierskunstlehrer & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Forscherliga',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5388;
-- OLD name : Versklavter Ernter
-- Source : https://www.wowhead.com/wotlk/de/npc=5409
UPDATE `creature_template_locale` SET `Name` = 'Sammlerschwarm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5409;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5497
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5497;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5498
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5498;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=5507
UPDATE `creature_template_locale` SET `Title` = 'Weitschreiterausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5507;
-- OLD name : Grunzerin Mojka
-- Source : https://www.wowhead.com/wotlk/de/npc=5603
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Mojka',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5603;
-- OLD name : [UNUSED] [PH] Orcish Barfly (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5604;
-- OLD name : Trainingsattrappe von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=5652
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Unterstadt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5652;
-- OLD name : [UNUSED] Charles Brewton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=5672
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5672;
-- OLD name : Comar Villard
-- Source : https://www.wowhead.com/wotlk/de/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Corma Villard',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5683;
-- OLD name : Comar-Villard-Projektion
-- Source : https://www.wowhead.com/wotlk/de/npc=5692
UPDATE `creature_template_locale` SET `Name` = 'Corma-Villard-Projektion',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5692;
-- OLD subname : Gerards Gedankensklavin
-- Source : https://www.wowhead.com/wotlk/de/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Gerards Experiment',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5697;
-- OLD name : Wächter von Blizzard
-- Source : https://www.wowhead.com/wotlk/de/npc=5764
UPDATE `creature_template_locale` SET `Name` = 'Blizzardwächter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5764;
-- OLD name : Unteroffizier Curtis
-- Source : https://www.wowhead.com/wotlk/de/npc=5809
UPDATE `creature_template_locale` SET `Name` = 'Wachkommandant Zalaphil',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5809;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5812
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5812;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=5819
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5819;
-- OLD name : Geofürst Sprenkel
-- Source : https://www.wowhead.com/wotlk/de/npc=5826
UPDATE `creature_template_locale` SET `Name` = 'Geolord Sprenkel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5826;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5880
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5880;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5882
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5882;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5883
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5883;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5884
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5884;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5885
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5885;
-- OLD name : [UNUSED] Hurll Kans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=5904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 5904;
-- OLD name : Totem der Läuterung
-- Source : https://www.wowhead.com/wotlk/de/npc=5924
UPDATE `creature_template_locale` SET `Name` = 'Totem der Reinigung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5924;
-- OLD name : Totem des Elementarwiderstands
-- Source : https://www.wowhead.com/wotlk/de/npc=5927
UPDATE `creature_template_locale` SET `Name` = 'Totem des Feuerwiderstands',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5927;
-- OLD name : Welt Gnom Männlich Magierlehrer, subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=5961
UPDATE `creature_template_locale` SET `Name` = 'Welt Gnom Männlich Magielehrer',`Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5961;
-- OLD name : Welt Gnom Magierlehrerin, subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=5969
UPDATE `creature_template_locale` SET `Name` = 'Welt Gnom Magielehrerin',`Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 5969;
-- OLD name : Ritualist der Schattenanbeter
-- Source : https://www.wowhead.com/wotlk/de/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Kultist der Schattenanbeter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6004;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=6028
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6028;
-- OLD name : [UNUSED] Gozwin Vilesprocket (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=6046
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6046;
-- OLD name : Totem des Erdgriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=6066
UPDATE `creature_template_locale` SET `Name` = 'Totem des Erdengriffs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6066;
-- OLD name : [UNUSED] Meritt Herrion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=6067
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6067;
-- OLD name : Drakonischer Magierlord
-- Source : https://www.wowhead.com/wotlk/de/npc=6129
UPDATE `creature_template_locale` SET `Name` = 'Drachischer Magierlord',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6129;
-- OLD name : Drakonischer Magiewirker
-- Source : https://www.wowhead.com/wotlk/de/npc=6131
UPDATE `creature_template_locale` SET `Name` = 'Drachischer Magiewirker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6131;
-- OLD name : Arkkoranmatschwirbler
-- Source : https://www.wowhead.com/wotlk/de/npc=6136
UPDATE `creature_template_locale` SET `Name` = 'Arkkoranmatschkrabbler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6136;
-- OLD name : Sohn von Arkkoroc
-- Source : https://www.wowhead.com/wotlk/de/npc=6144
UPDATE `creature_template_locale` SET `Name` = 'Arkkorocs Sohn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6144;
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 6183;
-- OLD name : Zauberin der Grollflossen
-- Source : https://www.wowhead.com/wotlk/de/npc=6197
UPDATE `creature_template_locale` SET `Name` = 'Zauberhexerin der Grollflossen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6197;
-- OLD name : Akolythin Magaz
-- Source : https://www.wowhead.com/wotlk/de/npc=6252
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Magaz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6252;
-- OLD name : Akolythin Wytula
-- Source : https://www.wowhead.com/wotlk/de/npc=6254
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Wytula',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6254;
-- OLD name : Akolythin Porena
-- Source : https://www.wowhead.com/wotlk/de/npc=6267
UPDATE `creature_template_locale` SET `Name` = 'Akolyth Porena',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6267;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=6286
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6286;
-- OLD name : Gefallener Champion
-- Source : https://www.wowhead.com/wotlk/de/npc=6488
UPDATE `creature_template_locale` SET `Name` = 'Gestürzter Held',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6488;
-- OLD name : "Hahnentritt" Johnson
-- Source : https://www.wowhead.com/wotlk/de/npc=6626
UPDATE `creature_template_locale` SET `Name` = 'Eisenherz Johnson',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6626;
-- OLD name : "Hahnentritt" Johnsons Menschengestalt
-- Source : https://www.wowhead.com/wotlk/de/npc=6666
UPDATE `creature_template_locale` SET `Name` = 'Eisenherz Johnsons Menschengestalt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6666;
-- OLD name : [UNUSED] Lorek Belm (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6783;
-- OLD name : Strandkrebs
-- Source : https://www.wowhead.com/wotlk/de/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Krebs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6827;
-- OLD name : Dockmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Dockmeister der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6846;
-- OLD name : Leibwache
-- Source : https://www.wowhead.com/wotlk/de/npc=6866
UPDATE `creature_template_locale` SET `Name` = 'Leibwache der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6866;
-- OLD name : Dockarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Dockarbeiter der Defias',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 6927;
-- OLD name : Wache des Schwarzfels
-- Source : https://www.wowhead.com/wotlk/de/npc=7013
UPDATE `creature_template_locale` SET `Name` = 'Amokläufer des Schwarzfels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7013;
-- OLD name : Obsidianwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=7023
UPDATE `creature_template_locale` SET `Name` = 'Obsidianschildwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7023;
-- OLD name : Eisenwaldwanderer
-- Source : https://www.wowhead.com/wotlk/de/npc=7138
UPDATE `creature_template_locale` SET `Name` = 'Wanderer der Eisenstämme',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7138;
-- OLD name : Eisenwaldstampfer
-- Source : https://www.wowhead.com/wotlk/de/npc=7139
UPDATE `creature_template_locale` SET `Name` = 'Donnerstampfer der Eisenstämme',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7139;
-- OLD name : Siechender Treant
-- Source : https://www.wowhead.com/wotlk/de/npc=7144
UPDATE `creature_template_locale` SET `Name` = 'Welker Treant',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7144;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7174
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7174;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7230
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7230;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7231;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7232
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7232;
-- OLD name : [UNUSED] Drayl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=7293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7293;
-- OLD name : Aufklärer der Venture Co.
-- Source : https://www.wowhead.com/wotlk/de/npc=7307
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Venture Co.',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7307;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7311
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7311;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7312
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7312;
-- OLD name : Kakerlake von Unterstadt
-- Source : https://www.wowhead.com/wotlk/de/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Kakerlake',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7395;
-- OLD name : Junger Frostsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=7430
UPDATE `creature_template_locale` SET `Name` = 'Frostsäblerjunges',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7430;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7488
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7488;
-- OLD name : Braune Natter
-- Source : https://www.wowhead.com/wotlk/de/npc=7507
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7507;
-- OLD name : Schwarze Königsnatter
-- Source : https://www.wowhead.com/wotlk/de/npc=7508
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7508;
-- OLD name : Purpurrote Natter
-- Source : https://www.wowhead.com/wotlk/de/npc=7509
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7509;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7525
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7525;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7526
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7526;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7528
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7528;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/de/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (7558, 'deDE','Waldkaninchen',NULL,0);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/de/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (7559, 'deDE','Gefleckter Hase',NULL,0);
-- OLD name : Slims Testtodesritter
-- Source : https://www.wowhead.com/wotlk/de/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7624;
-- OLD name : Leopard
-- Source : https://www.wowhead.com/wotlk/de/npc=7684
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Gelb)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7684;
-- OLD name : Bengaltiger
-- Source : https://www.wowhead.com/wotlk/de/npc=7686
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Rot)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7686;
-- OLD name : Gefleckter Nachtsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=7689
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (Schwarz gepunktet)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7689;
-- OLD name : Obsidianschwarzer Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7703
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Obsidianschwarz)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7703;
-- OLD name : Scheckiger roter Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7704
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Purpurrot)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7704;
-- OLD name : Elfenbeinfarbener Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=7706
UPDATE `creature_template_locale` SET `Name` = 'Reitraptor (Elfenbeinfarben)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7706;
-- OLD name : Byula, subname : Ehemaliger Gastwirt
-- Source : https://www.wowhead.com/wotlk/de/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Gastwirt Byula',`Title` = 'Gastwirt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7714;
-- OLD name : Hydromantin Velratha
-- Source : https://www.wowhead.com/wotlk/de/npc=7795
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörerin Velratha',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7795;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7866
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7866;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7867
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7867;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7868
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7868;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7869
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7869;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7870;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7871;
-- OLD subname : Reitlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Roboschreiterpilot',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7954;
-- OLD name : Kriegerheld von Camp Narache
-- Source : https://www.wowhead.com/wotlk/de/npc=7975
UPDATE `creature_template_locale` SET `Name` = 'Beschützer von Mulgore',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 7975;
-- OLD name : Wache der Westfallbrigade, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/de/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Beschützer des Volks',`Title` = 'Die Volksmiliz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8096;
-- OLD subname : Speis & Trank
-- Source : https://www.wowhead.com/wotlk/de/npc=8148
UPDATE `creature_template_locale` SET `Title` = 'Essen & Getränke',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8148;
-- OLD name : Glutschwinge
-- Source : https://www.wowhead.com/wotlk/de/npc=8207
UPDATE `creature_template_locale` SET `Name` = 'Großer Feuervogel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8207;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=8306
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8306;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=8360
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8360;
-- OLD name : Hauptmann Vanessa Beltis
-- Source : https://www.wowhead.com/wotlk/de/npc=8380
UPDATE `creature_template_locale` SET `Name` = 'Kapitän Vanessa Beltis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8380;
-- OLD name : Handwerksmeister Kovic
-- Source : https://www.wowhead.com/wotlk/de/npc=8444
UPDATE `creature_template_locale` SET `Name` = 'Handelsmeister Kovic',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8444;
-- OLD name : Kalaran Windklinge
-- Source : https://www.wowhead.com/wotlk/de/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Velarok Windklinge',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8479;
-- OLD name : Kalaran der Betrüger
-- Source : https://www.wowhead.com/wotlk/de/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Velarok der Betrüger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8480;
-- OLD name : Todessängerin
-- Source : https://www.wowhead.com/wotlk/de/npc=8542
UPDATE `creature_template_locale` SET `Name` = 'Todessänger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8542;
-- OLD name : Nekrolyt
-- Source : https://www.wowhead.com/wotlk/de/npc=8552
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8552;
-- OLD name : Getriebener Waldmann
-- Source : https://www.wowhead.com/wotlk/de/npc=8563
UPDATE `creature_template_locale` SET `Name` = 'Waldhirte',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8563;
-- OLD name : Getriebener Waldläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=8564
UPDATE `creature_template_locale` SET `Name` = 'Waldläufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8564;
-- OLD name : Getriebener Pfadwanderer
-- Source : https://www.wowhead.com/wotlk/de/npc=8565
UPDATE `creature_template_locale` SET `Name` = 'Pfadwanderer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8565;
-- OLD name : Aufklärer der Dunkeleisenzwerge
-- Source : https://www.wowhead.com/wotlk/de/npc=8566
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Dunkeleisenzwerge',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8566;
-- OLD name : Großer Seuchenhund
-- Source : https://www.wowhead.com/wotlk/de/npc=8599
UPDATE `creature_template_locale` SET `Name` = 'Seuchenmastiff',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8599;
-- OLD name : Sonnenläuferin Saern
-- Source : https://www.wowhead.com/wotlk/de/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Saern Stolzlauf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8664;
-- OLD name : Folterer des Schattenhammers
-- Source : https://www.wowhead.com/wotlk/de/npc=8912
UPDATE `creature_template_locale` SET `Name` = 'Folterknecht des Schattenhammers',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 8912;
-- OLD subname : Befrager des Schattenhammers
-- Source : https://www.wowhead.com/wotlk/de/npc=9018
UPDATE `creature_template_locale` SET `Title` = 'Befrager des Schattenhammerklans',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9018;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9116
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9116;
-- OLD name : Wütender Wyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=9297
UPDATE `creature_template_locale` SET `Name` = 'Wütender Flügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9297;
-- OLD name : Ausgegrabenes Fossil
-- Source : https://www.wowhead.com/wotlk/de/npc=9397
UPDATE `creature_template_locale` SET `Name` = 'Lebendiger Sturm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9397;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9528
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9528;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=9529
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9529;
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9557;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=9566
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9566;
-- OLD name : [UNUSED] Gorilla Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=9577
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9577;
-- OLD subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9578
UPDATE `creature_template_locale` SET `Title` = 'Talentmeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9578;
-- OLD name : Talentmeister von Darnassus, subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9579
UPDATE `creature_template_locale` SET `Name` = 'Talentmeisterin von Darnassus',`Title` = 'Talentmeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9579;
-- OLD subname : Talentmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9582
UPDATE `creature_template_locale` SET `Title` = 'Talentmeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9582;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=9584
UPDATE `creature_template_locale` SET `Title` = 'Schattengewebeschneidermeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9584;
-- OLD name : [UNUSED] Eyan Mulcom (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=9617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9617;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9686;
-- OLD subname : Blutaxtlegion
-- Source : https://www.wowhead.com/wotlk/de/npc=9696
UPDATE `creature_template_locale` SET `Title` = 'Schmetterschildlegion',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9696;
-- OLD name : [UNUSED] [PH] Cheese Servant Floh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 9820;
-- OLD subname : Ehemaliger Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 9983;
-- OLD name : [PH] Alex's Raid Testing Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10044;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=10046
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10046;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=10053
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10053;
-- OLD name : Leuchtend grüner Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=10178
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Leuchtendgrün)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10178;
-- OLD name : Weißer Roboschreiter Mod. B
-- Source : https://www.wowhead.com/wotlk/de/npc=10179
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (schwarz)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10179;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=10237
UPDATE `creature_template_locale` SET `Title` = 'UNUSED',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10237;
-- OLD subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10292
UPDATE `creature_template_locale` SET `Title` = 'Dolchlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10292;
-- OLD subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10294
UPDATE `creature_template_locale` SET `Title` = 'Faustwaffenlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10294;
-- OLD subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10297
UPDATE `creature_template_locale` SET `Title` = 'Bogenlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10297;
-- OLD name : Acride
-- Source : https://www.wowhead.com/wotlk/de/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Spitzel der Schmetterschilde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/de/npc=10301
UPDATE `creature_template_locale` SET `Title` = 'Forscherliga',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10301;
-- OLD name : Uralter Frostsäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (weiß)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10322;
-- OLD name : Urleopard
-- Source : https://www.wowhead.com/wotlk/de/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (getupft)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10336;
-- OLD name : Lohfarbene Säblerkatze
-- Source : https://www.wowhead.com/wotlk/de/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (orange)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10337;
-- OLD name : Goldfarbene Säblerkatze
-- Source : https://www.wowhead.com/wotlk/de/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Reittiger (goldfarben)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10338;
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10370;
-- OLD name : [UNUSED] Thuzadin Shadow Lord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10401;
-- OLD name : [UNUSED] Cannibal Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10402;
-- OLD name : [UNUSED] Devouring Wight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10403;
-- OLD name : Auferstandener Gardist
-- Source : https://www.wowhead.com/wotlk/de/npc=10418
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Gardist',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10418;
-- OLD name : Auferstandener Herbeizauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10419
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Herbeizauberer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10419;
-- OLD name : Auferstandener Initiand
-- Source : https://www.wowhead.com/wotlk/de/npc=10420
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Initiand',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10420;
-- OLD name : Auferstandener Verteidiger
-- Source : https://www.wowhead.com/wotlk/de/npc=10421
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Verteidiger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10421;
-- OLD name : Auferstandener Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10422
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Zauberer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10422;
-- OLD name : Auferstandener Priester
-- Source : https://www.wowhead.com/wotlk/de/npc=10423
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Priester',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10423;
-- OLD name : Auferstandener Kavalier
-- Source : https://www.wowhead.com/wotlk/de/npc=10424
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Kavalier',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10424;
-- OLD name : Auferstandener Kampfmagier
-- Source : https://www.wowhead.com/wotlk/de/npc=10425
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Kampfmagier',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10425;
-- OLD name : Auferstandener Inquisitor
-- Source : https://www.wowhead.com/wotlk/de/npc=10426
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Inquisitor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10426;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10446
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10446;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10450
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10450;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10452
UPDATE `creature_template_locale` SET `Title` = 'Streitkolbenlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10452;
-- OLD subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10453
UPDATE `creature_template_locale` SET `Title` = 'Axtlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=10454
UPDATE `creature_template_locale` SET `Title` = 'Armbrustlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10454;
-- OLD name : Nekrolyt aus Scholomance
-- Source : https://www.wowhead.com/wotlk/de/npc=10476
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth aus Scholomance',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10476;
-- OLD name : Auferstandener Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=10484
UPDATE `creature_template_locale` SET `Name` = 'Auferstandener Schrecker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10484;
-- OLD name : Auferstandener Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=10493
UPDATE `creature_template_locale` SET `Name` = 'Auferstandener Zauberhexer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10493;
-- OLD name : Verseuchter Schleim
-- Source : https://www.wowhead.com/wotlk/de/npc=10510
UPDATE `creature_template_locale` SET `Name` = 'Verseuchter Brühschleimer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10510;
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10607;
-- OLD name : Finkle Einhorn
-- Source : https://www.wowhead.com/wotlk/de/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Pip Flitzwitz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10776;
-- OLD name : [UNUSED] Deathcaller Majestis (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 10810;
-- OLD name : Instrukteur Galford
-- Source : https://www.wowhead.com/wotlk/de/npc=10811
UPDATE `creature_template_locale` SET `Name` = 'Archivar Galford',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10811;
-- OLD name : Todesjäger Falkenspeer
-- Source : https://www.wowhead.com/wotlk/de/npc=10824
UPDATE `creature_template_locale` SET `Name` = 'Waldläuferlord Falkenspeer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10824;
-- OLD name : Lynnia Abbendis
-- Source : https://www.wowhead.com/wotlk/de/npc=10828
UPDATE `creature_template_locale` SET `Name` = 'Hochgeneral Abbendis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10828;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10839
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10839;
-- OLD name : Argentumoffizierin Reinherz, subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10840
UPDATE `creature_template_locale` SET `Name` = 'Argentumoffizier Reinherz',`Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10840;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=10857
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10857;
-- OLD name : Wissenshüter Polkelt
-- Source : https://www.wowhead.com/wotlk/de/npc=10901
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Polkelt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10901;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10920
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10920;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10921
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10921;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10922
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10922;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10923
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10923;
-- OLD subname : Der Smaragdkreis
-- Source : https://www.wowhead.com/wotlk/de/npc=10924
UPDATE `creature_template_locale` SET `Title` = 'Smaragdkreis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10924;
-- OLD name : Jünger der Silbernen Hand
-- Source : https://www.wowhead.com/wotlk/de/npc=10949
UPDATE `creature_template_locale` SET `Name` = 'Silberhandjünger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10949;
-- OLD name : Willey Hoffnungsbrecher
-- Source : https://www.wowhead.com/wotlk/de/npc=10997
UPDATE `creature_template_locale` SET `Name` = 'Kanonenmeister Willey',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 10997;
-- OLD name : Kommandant Malor
-- Source : https://www.wowhead.com/wotlk/de/npc=11032
UPDATE `creature_template_locale` SET `Name` = 'Malor der Eifrige',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11032;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11034;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11036;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11039;
-- OLD name : Behüterin Braunell
-- Source : https://www.wowhead.com/wotlk/de/npc=11040
UPDATE `creature_template_locale` SET `Name` = 'Behüter Braunell',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11040;
-- OLD name : Auferstandener Mönch
-- Source : https://www.wowhead.com/wotlk/de/npc=11043
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Mönch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11043;
-- OLD name : Auferstandener Scharfschütze
-- Source : https://www.wowhead.com/wotlk/de/npc=11054
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Scharfschütze',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11054;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/de/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11058;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11063;
-- OLD name : [PH[ Combat Tester (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11080;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11102
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11102;
-- OLD name : Auferstandener Hammerschmied
-- Source : https://www.wowhead.com/wotlk/de/npc=11120
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Hammerschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11120;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11146;
-- OLD name : Lila Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Lila)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11148;
-- OLD name : Rotblauer Roboschreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=11149
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Rot/Blau)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11149;
-- OLD name : Eisblauer Roboschreiter Mod. A
-- Source : https://www.wowhead.com/wotlk/de/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Reitroboschreiter (Eisblau)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11150;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11177;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11178
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11178;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=11182
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11182;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11194
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11194;
-- OLD name : Todesstreitross
-- Source : https://www.wowhead.com/wotlk/de/npc=11195
UPDATE `creature_template_locale` SET `Name` = 'Schwarzes Skelettschlachtross',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11195;
-- OLD name : Hochgeborener Beschwörer, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11466
UPDATE `creature_template_locale` SET `Name` = 'Hochgeborenenbeschwörer',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11466;
-- OLD name : Versenger der Eldreth
-- Source : https://www.wowhead.com/wotlk/de/npc=11469
UPDATE `creature_template_locale` SET `Name` = 'Schnauber der Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11469;
-- OLD subname : Gebieter der Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=11486
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11486;
-- OLD name : [UNUSED] Sentius (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11493;
-- OLD name : [UNUSED] Avidus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11495
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11495;
-- OLD name : Skarr der Gebrochene
-- Source : https://www.wowhead.com/wotlk/de/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Skarr der Unbezwingbare',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11498;
-- OLD name : Rüstmeisterin Miranda Knackschloss, subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=11536
UPDATE `creature_template_locale` SET `Name` = 'Rüstmeisterin Miranda Breechlock',`Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11536;
-- OLD name : [UNUSED] Molten Colossus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11660;
-- OLD name : Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11661
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11661;
-- OLD name : Priester der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11662
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenpriester',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11662;
-- OLD name : Heiler der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11663
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenheiler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11663;
-- OLD name : Elite der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=11664
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenelite',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11664;
-- OLD name : [UNUSED] Flame Shrieker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11670;
-- OLD name : Kernhund
-- Source : https://www.wowhead.com/wotlk/de/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Uralter Kernhund',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11673;
-- OLD name : Holzarbeiter des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=11681
UPDATE `creature_template_locale` SET `Name` = 'Roder der Horde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11681;
-- OLD name : Goblinroder
-- Source : https://www.wowhead.com/wotlk/de/npc=11684
UPDATE `creature_template_locale` SET `Name` = 'Schredder des Kriegshymnenklans',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11684;
-- OLD subname : Wintersäblerausbilderin
-- Source : https://www.wowhead.com/wotlk/de/npc=11696
UPDATE `creature_template_locale` SET `Title` = 'Wintersäblerausbilder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11696;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=11703
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11703;
-- OLD name : Zwielichtbewahrer Exeter, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11803
UPDATE `creature_template_locale` SET `Name` = 'Bewahrer des Schattenhammers Exeter',`Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11803;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11804
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11804;
-- OLD name : Scholli Klauengriff
-- Source : https://www.wowhead.com/wotlk/de/npc=11821
UPDATE `creature_template_locale` SET `Name` = 'Darn Klauengriff',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11821;
-- OLD name : Grundig Düsterwolke
-- Source : https://www.wowhead.com/wotlk/de/npc=11858
UPDATE `creature_template_locale` SET `Name` = 'Grundig Finsterwolke',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11858;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11880
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11880;
-- OLD name : Zwielichtgeofürst, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11881
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtgeolord',`Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11881;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11882
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11882;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=11883
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11883;
-- OLD name : Steinschlagfelsbewahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=11915
UPDATE `creature_template_locale` SET `Name` = 'Felsbewahrer der Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11915;
-- OLD name : Steinschlaggeomant
-- Source : https://www.wowhead.com/wotlk/de/npc=11917
UPDATE `creature_template_locale` SET `Name` = 'Geomant der Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11917;
-- OLD name : Steinschlagsteinklopfer
-- Source : https://www.wowhead.com/wotlk/de/npc=11918
UPDATE `creature_template_locale` SET `Name` = 'Steinklopfer der Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 11918;
-- OLD name : [PH] Northshire Gift Dispenser (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 11926;
-- OLD name : Alchemielehrer der Mondlichtung, subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=12020
UPDATE `creature_template_locale` SET `Name` = 'Alchimielehrer der Mondlichtung',`Title` = 'Alchimiefachmann',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12020;
-- OLD subname : Waffenschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=12024
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12024;
-- OLD subname : Bogenmacherin
-- Source : https://www.wowhead.com/wotlk/de/npc=12029
UPDATE `creature_template_locale` SET `Title` = 'Bogenmacher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12029;
-- OLD name : Grella Steinfaust
-- Source : https://www.wowhead.com/wotlk/de/npc=12036
UPDATE `creature_template_locale` SET `Name` = 'Gemischtwaren des Nistgipfels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12036;
-- OLD name : Brannik Eisenbauch
-- Source : https://www.wowhead.com/wotlk/de/npc=12040
UPDATE `creature_template_locale` SET `Name` = 'Verkäufer für schwere Rüstungen des Nistgipfels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12040;
-- OLD name : Schmiedekunstbedarf von Sonnenfels
-- Source : https://www.wowhead.com/wotlk/de/npc=12044
UPDATE `creature_template_locale` SET `Name` = 'Schmiedekunstgrundbedarf von Sonnenfels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12044;
-- OLD name : Beschützer der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=12119
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenbeschützer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12119;
-- OLD name : Wächter der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=12142
UPDATE `creature_template_locale` SET `Name` = 'Feuerschuppenwächter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12142;
-- OLD name : Graublauer Kodo
-- Source : https://www.wowhead.com/wotlk/de/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo (Graublau)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12148;
-- OLD name : Grüner Kodo
-- Source : https://www.wowhead.com/wotlk/de/npc=12151
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo (Grün)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12151;
-- OLD subname : Der Erste Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12240
UPDATE `creature_template_locale` SET `Title` = 'Der erste Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12240;
-- OLD subname : Der Dritte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12241
UPDATE `creature_template_locale` SET `Title` = 'Der dritte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12241;
-- OLD subname : Der Vierte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12242
UPDATE `creature_template_locale` SET `Title` = 'Der vierte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12242;
-- OLD subname : Der Fünfte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=12243
UPDATE `creature_template_locale` SET `Title` = 'Der fünfte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12243;
-- OLD name : Scheckiger scharlachroter Raptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12345
UPDATE `creature_template_locale` SET `Name` = 'Scheckiger roter Raptor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12345;
-- OLD name : Smaragdgrüner Reitraptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12346
UPDATE `creature_template_locale` SET `Name` = 'Smaragdfarbener Raptor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12346;
-- OLD name : Türkisfarbener Reitraptor
-- Source : https://www.wowhead.com/wotlk/de/npc=12349
UPDATE `creature_template_locale` SET `Name` = 'Türkisfarbener Raptor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12349;
-- OLD name : Großer übler Schleim
-- Source : https://www.wowhead.com/wotlk/de/npc=12387
UPDATE `creature_template_locale` SET `Name` = 'Großer böser Brühschleimer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12387;
-- OLD name : Verdammniswachenkommandant
-- Source : https://www.wowhead.com/wotlk/de/npc=12396
UPDATE `creature_template_locale` SET `Name` = 'Kommandant der Verdammniswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12396;
-- OLD name : Hauptmann der Todeskrallen
-- Source : https://www.wowhead.com/wotlk/de/npc=12467
UPDATE `creature_template_locale` SET `Name` = 'Captain der Todeskrallen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12467;
-- OLD subname : Windreitermeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=12616
UPDATE `creature_template_locale` SET `Title` = 'Windreitermeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12616;
-- OLD subname : Rüstmeister für Zubehör
-- Source : https://www.wowhead.com/wotlk/de/npc=12781
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Offizierszubehör',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12781;
-- OLD subname : Rüstmeisterin für Kriegsreittiere
-- Source : https://www.wowhead.com/wotlk/de/npc=12783
UPDATE `creature_template_locale` SET `Title` = 'Kriegsreittierverkäuferin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12783;
-- OLD name : Häuptling Erdbinder
-- Source : https://www.wowhead.com/wotlk/de/npc=12791
UPDATE `creature_template_locale` SET `Name` = 'Häuptling Erdenbund',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12791;
-- OLD name : Grunzerin Bek'rah
-- Source : https://www.wowhead.com/wotlk/de/npc=12798
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Bek''rah',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12798;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Traumachirurg',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 12939;
-- OLD name : Jagdhund der Gordok
-- Source : https://www.wowhead.com/wotlk/de/npc=13036
UPDATE `creature_template_locale` SET `Name` = 'Mastiff der Gordok',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13036;
-- OLD subname : Waffenmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Waffenmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13084;
-- OLD name : Schwadronskommandantin Guse
-- Source : https://www.wowhead.com/wotlk/de/npc=13179
UPDATE `creature_template_locale` SET `Name` = 'Schwadronskommandant Guse',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13179;
-- OLD name : Schwadronskommandantin Jeztor
-- Source : https://www.wowhead.com/wotlk/de/npc=13180
UPDATE `creature_template_locale` SET `Name` = 'Schwadronskommandant Jeztor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13180;
-- OLD name : Kleiner Frosch
-- Source : https://www.wowhead.com/wotlk/de/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Frosch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13321;
-- OLD name : Legionärsveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=13334
UPDATE `creature_template_locale` SET `Name` = 'Legionärveteran',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13334;
-- OLD name : Erzdruidin Renferal
-- Source : https://www.wowhead.com/wotlk/de/npc=13442
UPDATE `creature_template_locale` SET `Name` = 'Erzdruide Renferal',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13442;
-- OLD name : Stallmeister der Frostwölfe, subname : Stallmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=13616
UPDATE `creature_template_locale` SET `Name` = 'Stallmeisterin der Frostwölfe',`Title` = 'Stallmeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13616;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=13656
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13656;
-- OLD subname : Der Fünfte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13738
UPDATE `creature_template_locale` SET `Title` = 'Der fünfte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13738;
-- OLD subname : Der Vierte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13739
UPDATE `creature_template_locale` SET `Title` = 'Der vierte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13739;
-- OLD subname : Der Dritte Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13740
UPDATE `creature_template_locale` SET `Title` = 'Der dritte Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13740;
-- OLD subname : Der Zweite Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13741
UPDATE `creature_template_locale` SET `Title` = 'Der zweite Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13741;
-- OLD subname : Der Erste Khan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=13742
UPDATE `creature_template_locale` SET `Title` = 'Der erste Khan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 13742;
-- OLD name : [UNUSED] Sid Stuco (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=14201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14201;
-- OLD name : Der Große Samras
-- Source : https://www.wowhead.com/wotlk/de/npc=14280
UPDATE `creature_template_locale` SET `Name` = 'Samras',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14280;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14358
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14358;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14364
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14364;
-- OLD name : Wissenshüter Lydros, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14368
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Lydros',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14368;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14369
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14369;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14371
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14371;
-- OLD name : Wissenshüter Javon, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14381
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Javon',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14381;
-- OLD name : Wissenshüterin Mykos, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14382
UPDATE `creature_template_locale` SET `Name` = 'Hüterin des Wissens Mykos',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14382;
-- OLD name : Wissenshüter Kildrath, subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=14383
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Kildrath',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14383;
-- OLD name : Verdammniswachendiener
-- Source : https://www.wowhead.com/wotlk/de/npc=14385
UPDATE `creature_template_locale` SET `Name` = 'Diener der Verdammniswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14385;
-- OLD name : Hauptmann Wyrmak
-- Source : https://www.wowhead.com/wotlk/de/npc=14445
UPDATE `creature_template_locale` SET `Name` = 'Lordkommandant Wyrmak',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14445;
-- OLD name : Versklavter Verdammniswachenkommandant
-- Source : https://www.wowhead.com/wotlk/de/npc=14452
UPDATE `creature_template_locale` SET `Name` = 'Versklavter Kommandant der Verdammniswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14452;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=14479
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14479;
-- OLD name : Schneller Dämmersäbler
-- Source : https://www.wowhead.com/wotlk/de/npc=14557
UPDATE `creature_template_locale` SET `Name` = 'Schneller Dämmerungssäbler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14557;
-- OLD name : Aufklärer der Thoriumbruderschaft
-- Source : https://www.wowhead.com/wotlk/de/npc=14622
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Thoriumbruderschaft',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14622;
-- OLD name : Aufklärerhauptmann Lolo Langhieb
-- Source : https://www.wowhead.com/wotlk/de/npc=14634
UPDATE `creature_template_locale` SET `Name` = 'Hauptmann des Ausgucks Lolo Langhieb',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14634;
-- OLD name : [PH] Horde spell thrower (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14641;
-- OLD name : [PH] Alliance Spell thrower (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14642;
-- OLD name : [PH] Alliance Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14643;
-- OLD name : [PH] Horde Herald (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 14644;
-- OLD name : Verdorbenes Totem des heilendes Flusses V
-- Source : https://www.wowhead.com/wotlk/de/npc=14664
UPDATE `creature_template_locale` SET `Name` = 'Verderbtes Totem des heilenden Flusses V',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14664;
-- OLD name : Geflügelter Schrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=14714
UPDATE `creature_template_locale` SET `Name` = 'Geflügelter Horror',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14714;
-- OLD name : Feldmarschall Afrasiabi
-- Source : https://www.wowhead.com/wotlk/de/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Feldmarschall Steinsteg',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14721;
-- OLD subname : Stoffrüstmeisterin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=14723
UPDATE `creature_template_locale` SET `Title` = 'Stoffrüstmeister der Allianz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14723;
-- OLD name : Entführer der Blutfratzen
-- Source : https://www.wowhead.com/wotlk/de/npc=14748
UPDATE `creature_template_locale` SET `Name` = 'Kidnapper der Blutfratzen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14748;
-- OLD subname : Souvenir- & Spielzeuggewinne
-- Source : https://www.wowhead.com/wotlk/de/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Losverkauf des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14828;
-- OLD subname : Der, der niemals vergisst!
-- Source : https://www.wowhead.com/wotlk/de/npc=14833
UPDATE `creature_template_locale` SET `Title` = 'Der der niemals vergisst!',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14833;
-- OLD subname : Getränkeverkäuferin des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Getränkeverkäufer des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14844;
-- OLD subname : Lebensmittelverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=14845
UPDATE `creature_template_locale` SET `Title` = 'Lebensmittelverkäufer des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14845;
-- OLD subname : Haus- & Reittiergewinne
-- Source : https://www.wowhead.com/wotlk/de/npc=14846
UPDATE `creature_template_locale` SET `Title` = 'Exotische Waren des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14846;
-- OLD subname : Karten des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=14847
UPDATE `creature_template_locale` SET `Title` = 'Karten & Exotische Waren des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14847;
-- OLD name : Blutdienerin von Kirtonos
-- Source : https://www.wowhead.com/wotlk/de/npc=14861
UPDATE `creature_template_locale` SET `Name` = 'Blutdiener von Kirtonos',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14861;
-- OLD name : Zwerg-Cockatrice
-- Source : https://www.wowhead.com/wotlk/de/npc=14869
UPDATE `creature_template_locale` SET `Name` = 'Zwerghühnchen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14869;
-- OLD name : Gesandter der Entweihten
-- Source : https://www.wowhead.com/wotlk/de/npc=14990
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter der Entweihten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 14990;
-- OLD name : Gesandter des Kriegshymnenklans
-- Source : https://www.wowhead.com/wotlk/de/npc=15105
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter des Kriegshymnenklans',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15105;
-- OLD name : Gesandter der Frostwölfe
-- Source : https://www.wowhead.com/wotlk/de/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter der Frostwölfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15106;
-- OLD name : Infanterist der Burg Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=15184
UPDATE `creature_template_locale` SET `Name` = 'Soldat der Burg Cenarius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15184;
-- OLD name : Fürstin Sylvanas Windläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=15193
UPDATE `creature_template_locale` SET `Name` = 'Die Bansheekönigin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15193;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15200
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15200;
-- OLD name : Zwielichtflammenhäscher
-- Source : https://www.wowhead.com/wotlk/de/npc=15201
UPDATE `creature_template_locale` SET `Name` = 'Flammenhäscher des Schattenhammers',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15201;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15202
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15202;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15213
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15213;
-- OLD name : Trick - Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=15219
UPDATE `creature_template_locale` SET `Name` = 'Trick - Tierchen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15219;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15279
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15279;
-- OLD name : Pfadpirscher Kariel
-- Source : https://www.wowhead.com/wotlk/de/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Pfadpirscher Avokor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15285;
-- OLD subname : Kanonierin des Dunkelmond-Jahrmarkts
-- Source : https://www.wowhead.com/wotlk/de/npc=15303
UPDATE `creature_template_locale` SET `Title` = 'Kanonier des Dunkelmond-Jahrmarkts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15303;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15308
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15308;
-- OLD name : Dunkelmond-Dampfpanzer
-- Source : https://www.wowhead.com/wotlk/de/npc=15328
UPDATE `creature_template_locale` SET `Name` = 'Dunkelmonddampfpanzer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15328;
-- OLD name : RC Blimp <PH>, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15349;
-- OLD name : RC Mörserpanzer, subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15364;
-- OLD name : Ayamiss die Jägerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15369
UPDATE `creature_template_locale` SET `Name` = 'Ayamiss der Jäger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15369;
-- OLD name : [UNUSED] Ruins Qiraji Gladiator Named 7 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=15393
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15393;
-- OLD name : Welt Juwelierskunstlehrer, subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15465
UPDATE `creature_template_locale` SET `Name` = 'Welt Juwelenschleiferlehrer',`Title` = 'Juwelenschleiferlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15465;
-- OLD name : Skorpid
-- Source : https://www.wowhead.com/wotlk/de/npc=15476
UPDATE `creature_template_locale` SET `Name` = 'Skorpion',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15476;
-- OLD name : Totem der Feuernova
-- Source : https://www.wowhead.com/wotlk/de/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Totem der Feuernova VII',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15483;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=15501
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15501;
-- OLD name : Zwielichtmeister Xarvos, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15530
UPDATE `creature_template_locale` SET `Name` = 'Meister des Schattenhammers Xarvos',`Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15530;
-- OLD name : Steingardist Lehmhuf
-- Source : https://www.wowhead.com/wotlk/de/npc=15532
UPDATE `creature_template_locale` SET `Name` = 'Steinwache Lehmhuf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15532;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15541
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15541;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15542
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15542;
-- OLD name : Zwielichtverderber
-- Source : https://www.wowhead.com/wotlk/de/npc=15625
UPDATE `creature_template_locale` SET `Name` = 'Seelenverderber des Zwielichts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15625;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/de/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (15713, 'deDE','Blaue Qirajipanzerdrohne',NULL,0);
-- OLD subname : Träger des Gongs
-- Source : https://www.wowhead.com/wotlk/de/npc=15801
UPDATE `creature_template_locale` SET `Title` = 'TRÄGER DES GONGS',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15801;
-- OLD name : Infanterist der Macht von Kalimdor
-- Source : https://www.wowhead.com/wotlk/de/npc=15848
UPDATE `creature_template_locale` SET `Name` = 'Infanterie der Macht von Kalimdor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15848;
-- OLD name : Hochlord Leoric von Zeldig (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=15868
UPDATE `creature_template_locale` SET `Name` = 'Hochlord Leoric Von Zeldig',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15868;
-- OLD name : Herzog August Feindhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=15870
UPDATE `creature_template_locale` SET `Name` = 'Fürst August Feindhammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15870;
-- OLD subname : Sammlerin für Münzen der Urahnen
-- Source : https://www.wowhead.com/wotlk/de/npc=15909
UPDATE `creature_template_locale` SET `Title` = 'Sammler für Münzen der Urahnen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 15909;
-- OLD subname : Haus Shen'dralar
-- Source : https://www.wowhead.com/wotlk/de/npc=16032
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16032;
-- OLD name : Sumpfbiest
-- Source : https://www.wowhead.com/wotlk/de/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16035;
-- OLD name : Kreuzzugskommandant Korfax
-- Source : https://www.wowhead.com/wotlk/de/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Held des Lichts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16112;
-- OLD name : Scharlachrote Kommandantin Marjhan
-- Source : https://www.wowhead.com/wotlk/de/npc=16114
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Kommandant Marjhan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16114;
-- OLD name : Kreuzzugskommandant Eligor Morgenbringer
-- Source : https://www.wowhead.com/wotlk/de/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Eligor Morgenbringer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16115;
-- OLD name : Anathos, subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=16185
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16185;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16269
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16269;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16277
UPDATE `creature_template_locale` SET `Title` = 'Kochkunstlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16277;
-- OLD subname : Schurkenlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Schurkenlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16279;
-- OLD subname : Der Argentumkreuzzug
-- Source : https://www.wowhead.com/wotlk/de/npc=16378
UPDATE `creature_template_locale` SET `Title` = 'Die Argentumdämmerung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16378;
-- OLD name : Flickwerkschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=16382
UPDATE `creature_template_locale` SET `Name` = 'Flickwerkschrecker',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16382;
-- OLD name : Sie Nummer Eins, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16450
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Eins',`Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16450;
-- OLD name : Verteidiger der Todesritter
-- Source : https://www.wowhead.com/wotlk/de/npc=16451
UPDATE `creature_template_locale` SET `Name` = 'Vollstrecker der Todesritter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16451;
-- OLD name : Sie Nummer Zwei, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16454
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Zwei',`Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16454;
-- OLD name : Sie Nummer Drei, subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=16455
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. Nummer Drei',`Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16455;
-- OLD name : Konkubine
-- Source : https://www.wowhead.com/wotlk/de/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Eifrige Dienerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16461;
-- OLD name : Alchemiemeister
-- Source : https://www.wowhead.com/wotlk/de/npc=16487
UPDATE `creature_template_locale` SET `Name` = 'Alchimiemeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16487;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16500
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16500;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16527
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16527;
-- OLD name : Homunculus
-- Source : https://www.wowhead.com/wotlk/de/npc=16539
UPDATE `creature_template_locale` SET `Name` = 'Homonculus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16539;
-- OLD name : Fungusbestie
-- Source : https://www.wowhead.com/wotlk/de/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16565;
-- OLD name : Blutelfischer Pilger
-- Source : https://www.wowhead.com/wotlk/de/npc=16578
UPDATE `creature_template_locale` SET `Name` = 'Blutelfenpilger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16578;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16583;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16588
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16588;
-- OLD name : Wolfsreiter von Thrallmar
-- Source : https://www.wowhead.com/wotlk/de/npc=16599
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter von Thrallmar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16599;
-- OLD name : Bris Testcharakter
-- Source : https://www.wowhead.com/wotlk/de/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Brianna Schneider',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16605;
-- OLD subname : Waffenverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=16622
UPDATE `creature_template_locale` SET `Title` = 'Waffenhändler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16622;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=16624
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16624;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=16625
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16625;
-- OLD subname : Hexenmeisterlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16647
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16647;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16651
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16651;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16652
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16652;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16653
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16653;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Köchin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16676;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16702
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16702;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16703
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16703;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Köchin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=16720
UPDATE `creature_template_locale` SET `Title` = 'Dämonenausbilderin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16720;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16727
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16727;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=16744
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16744;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16749
UPDATE `creature_template_locale` SET `Title` = 'Magielehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16749;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=16750
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16750;
-- OLD subname : Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=16754
UPDATE `creature_template_locale` SET `Title` = 'Giftreagenzien',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16754;
-- OLD subname : Portallehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16755
UPDATE `creature_template_locale` SET `Title` = 'Portallehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16755;
-- OLD subname : Angellehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=16774
UPDATE `creature_template_locale` SET `Title` = 'Angellehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16774;
-- OLD name : Blauer Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16783
UPDATE `creature_template_locale` SET `Name` = 'Blauer Seuchenbrühschleimer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16783;
-- OLD name : Roter Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16784
UPDATE `creature_template_locale` SET `Name` = 'Roter Seuchenbrühschleimer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16784;
-- OLD name : Grüner Seuchenschleim
-- Source : https://www.wowhead.com/wotlk/de/npc=16785
UPDATE `creature_template_locale` SET `Name` = 'Grüner Seuchenbrühschleimer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16785;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16823;
-- OLD name : Winsum
-- Source : https://www.wowhead.com/wotlk/de/npc=16868
UPDATE `creature_template_locale` SET `Name` = 'Töter des Lachenden Schädels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16868;
-- OLD name : Jising
-- Source : https://www.wowhead.com/wotlk/de/npc=16869
UPDATE `creature_template_locale` SET `Name` = 'Neophyt des Lachenden Schädels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16869;
-- OLD name : Wolfsreiter der Knochenmalmer
-- Source : https://www.wowhead.com/wotlk/de/npc=16877
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter der Knochenmalmer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16877;
-- OLD name : Maid der Trauer
-- Source : https://www.wowhead.com/wotlk/de/npc=16961
UPDATE `creature_template_locale` SET `Name` = 'Maid der Seelenpein',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16961;
-- OLD name : Sonnenwendhändlerkostüm der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=16986
UPDATE `creature_template_locale` SET `Name` = 'Sonnenwendhändlerkostüm der Alliant',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 16986;
-- OLD name : Soldat des Schattenhammerklans
-- Source : https://www.wowhead.com/wotlk/de/npc=17022
UPDATE `creature_template_locale` SET `Name` = 'Soldat des Schattenhammers',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17022;
-- OLD name : Saphirons Flügelschlag
-- Source : https://www.wowhead.com/wotlk/de/npc=17025
UPDATE `creature_template_locale` SET `Name` = 'Saphirons Flügelstoß',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17025;
-- OLD name : Kleine Höllenfeuerkampfattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=17060
UPDATE `creature_template_locale` SET `Name` = 'kleine Höllenfeuerkamfattrappe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17060;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=17105
UPDATE `creature_template_locale` SET `Title` = 'Magierlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17105;
-- OLD name : Erdenruferin Ryga
-- Source : https://www.wowhead.com/wotlk/de/npc=17123
UPDATE `creature_template_locale` SET `Name` = 'Erdruferin Ryga',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17123;
-- OLD name : Scharfseher Nobundo
-- Source : https://www.wowhead.com/wotlk/de/npc=17204
UPDATE `creature_template_locale` SET `Name` = 'Weissager Nobundo',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17204;
-- OLD subname : Spektralgreifenmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=17209
UPDATE `creature_template_locale` SET `Title` = 'Spektraler Greifenmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17209;
-- OLD name : Samtpfote
-- Source : https://www.wowhead.com/wotlk/de/npc=17230
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17230;
-- OLD name : Slims untötbarer Testdummy
-- Source : https://www.wowhead.com/wotlk/de/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17313;
-- OLD name : Zauberer des Schattenmondklans
-- Source : https://www.wowhead.com/wotlk/de/npc=17396
UPDATE `creature_template_locale` SET `Name` = 'Zauberhexer des Schattenmondklans',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17396;
-- OLD subname : Kriegerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17480
UPDATE `creature_template_locale` SET `Title` = 'Kriegerlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17480;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17481
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17481;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=17485
UPDATE `creature_template_locale` SET `Title` = 'Stallmeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17485;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=17512
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17512;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17513
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17513;
-- OLD subname : Magierlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17514
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17514;
-- OLD subname : Mistress of Breadcrumbs
-- Source : https://www.wowhead.com/wotlk/de/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (17515, 'deDE',NULL,'Herrin der Brotkrumen',0);
-- OLD name : Junger Draenei
-- Source : https://www.wowhead.com/wotlk/de/npc=17587
UPDATE `creature_template_locale` SET `Name` = 'Draeneijüngling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17587;
-- OLD name : Höllenfeuerwolfsreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=17593
UPDATE `creature_template_locale` SET `Name` = 'Höllenfeuerwolfreiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17593;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=17598
UPDATE `creature_template_locale` SET `Title` = 'Munitionsverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17598;
-- OLD name : K. Lee Kleinkram, subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=17634
UPDATE `creature_template_locale` SET `Name` = 'K. Lee Kleinfrey',`Title` = 'Meisteringenieurslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17634;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=17637
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17637;
-- OLD name : Teufelsjägerdiener
-- Source : https://www.wowhead.com/wotlk/de/npc=17648
UPDATE `creature_template_locale` SET `Name` = 'Diener der Teufelsjäger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17648;
-- OLD name : Schmiedin Frances
-- Source : https://www.wowhead.com/wotlk/de/npc=17655
UPDATE `creature_template_locale` SET `Name` = 'Schmied Frances',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17655;
-- OLD name : Jessera von Mac'Aree
-- Source : https://www.wowhead.com/wotlk/de/npc=17663
UPDATE `creature_template_locale` SET `Name` = 'Maatparm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17663;
-- OLD name : Wyvernreiter von Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=17720
UPDATE `creature_template_locale` SET `Name` = 'Flügeldrachenreiter von Orgrimmar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17720;
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (17733, 'deDE','NPCs',NULL,0);
-- OLD name : Tiefenseglerschwärmer
-- Source : https://www.wowhead.com/wotlk/de/npc=17736
UPDATE `creature_template_locale` SET `Name` = 'Tiefenschwärmer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17736;
-- OLD name : Bergriese der Scherbenwelt, Zangarmarsch
-- Source : https://www.wowhead.com/wotlk/de/npc=17752
UPDATE `creature_template_locale` SET `Name` = 'Bergriese der Scherbenwelt, Zangarmarschen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17752;
-- OLD name : Hydromantin Thespia
-- Source : https://www.wowhead.com/wotlk/de/npc=17797
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörerin Thespia',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17797;
-- OLD name : Wahnsinniger Worgen
-- Source : https://www.wowhead.com/wotlk/de/npc=17823
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Worgen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17823;
-- OLD name : Kommandantin Sarannis
-- Source : https://www.wowhead.com/wotlk/de/npc=17976
UPDATE `creature_template_locale` SET `Name` = 'Kommandant Sarannis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 17976;
-- OLD name : Wasserlementarwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=18001
UPDATE `creature_template_locale` SET `Name` = 'Wasserelementarwächter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18001;
-- OLD name : Verdammniswachenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=18041
UPDATE `creature_template_locale` SET `Name` = 'Herr der Verdammniswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18041;
-- OLD name : Scharfseher Kurkush
-- Source : https://www.wowhead.com/wotlk/de/npc=18066
UPDATE `creature_template_locale` SET `Name` = 'Weissager Kurkush',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18066;
-- OLD name : Scharfseher Corhuk
-- Source : https://www.wowhead.com/wotlk/de/npc=18067
UPDATE `creature_template_locale` SET `Name` = 'Weissager Corhuk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18067;
-- OLD name : Scharfseher Margadesh
-- Source : https://www.wowhead.com/wotlk/de/npc=18068
UPDATE `creature_template_locale` SET `Name` = 'Weissager Margadesh',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18068;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=18094
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18094;
-- OLD name : Matschwirbler von Dolchfenn
-- Source : https://www.wowhead.com/wotlk/de/npc=18115
UPDATE `creature_template_locale` SET `Name` = 'Matschkrabbler von Dolchfenn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18115;
-- OLD name : Besudeltes Totem des Erdgriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=18176
UPDATE `creature_template_locale` SET `Name` = 'Besudeltes Totem des Erdengriffs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18176;
-- OLD name : Kristine Denny
-- Source : https://www.wowhead.com/wotlk/de/npc=18190
UPDATE `creature_template_locale` SET `Name` = 'Krisine Denny',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18190;
-- OLD name : Verderber der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=18202
UPDATE `creature_template_locale` SET `Name` = 'Läuterer der Finsterblut',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18202;
-- OLD name : Scharfseher von Garadar
-- Source : https://www.wowhead.com/wotlk/de/npc=18228
UPDATE `creature_template_locale` SET `Name` = 'Ereignisaufseher von Garadar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18228;
-- OLD name : Reitwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=18345
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18345;
-- OLD name : [UNUSED] Dusty Skeleton [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18355;
-- OLD name : Lohfarbener Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=18363
UPDATE `creature_template_locale` SET `Name` = 'Gelbbrauner Windreiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18363;
-- OLD name : Trainingsattrappe von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18504
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe von Silbermond',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18504;
-- OLD name : Weltenwanderer von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=18507
UPDATE `creature_template_locale` SET `Name` = 'Silbermond Weltenwanderer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18507;
-- OLD name : Orcischer Gefangener
-- Source : https://www.wowhead.com/wotlk/de/npc=18598
UPDATE `creature_template_locale` SET `Name` = 'Orcgefangener',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18598;
-- OLD name : Vernichter der Teufelswache
-- Source : https://www.wowhead.com/wotlk/de/npc=18604
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18604;
-- OLD name : Ausbilderin Cel
-- Source : https://www.wowhead.com/wotlk/de/npc=18629
UPDATE `creature_template_locale` SET `Name` = 'Ausbilder Cel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18629;
-- OLD name : Unterwerferin Vaz'shir
-- Source : https://www.wowhead.com/wotlk/de/npc=18660
UPDATE `creature_template_locale` SET `Name` = 'Unterwerfer Vaz''shir',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18660;
-- OLD name : Anachoret Lyteera (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge A',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18674;
-- OLD name : Abgesandte des Echsenkessels
-- Source : https://www.wowhead.com/wotlk/de/npc=18681
UPDATE `creature_template_locale` SET `Name` = 'Abgesandter des Echsenkessels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18681;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18747;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18748
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18748;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18749;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18751
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18751;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18752;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18753;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18754
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18754;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18755;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18771;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18772;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18773;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18774;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18775;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18776;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18777;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18779;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18802;
-- OLD name : Botschafter Frasaboo der Tannenruhfeste
-- Source : https://www.wowhead.com/wotlk/de/npc=18803
UPDATE `creature_template_locale` SET `Name` = 'Botschafter Olorg der Tannenruhfeste',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18803;
-- OLD name : Leerenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=18871
UPDATE `creature_template_locale` SET `Name` = 'Lord der Leere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18871;
-- OLD name : Wache des Sumpfrattenpostens
-- Source : https://www.wowhead.com/wotlk/de/npc=18910
UPDATE `creature_template_locale` SET `Name` = 'Sumpfrattenwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18910;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18911;
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18936;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 18941;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18987
UPDATE `creature_template_locale` SET `Title` = 'Küchenchef',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18987;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=18988
UPDATE `creature_template_locale` SET `Title` = 'Küchenchef',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18988;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Sanitäter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18990;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Sanitäter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18991;
-- OLD subname : Kochkunstlehrerin & -bedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Kochbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 18993;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19052;
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19060;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19063;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=19065
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19065;
-- OLD name : Wolfsreiter von Garadar
-- Source : https://www.wowhead.com/wotlk/de/npc=19068
UPDATE `creature_template_locale` SET `Name` = 'Wolfreiter von Garadar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19068;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19132;
-- OLD name : Wichtel der Flammenschürer
-- Source : https://www.wowhead.com/wotlk/de/npc=19136
UPDATE `creature_template_locale` SET `Name` = 'Flammenschürerwichtel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19136;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/de/npc=19145
UPDATE `creature_template_locale` SET `Title` = 'Tierausbilderin für Pferde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19145;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19180;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Heilerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19184;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Koch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19185;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19187;
-- OLD name : Leerenreisender
-- Source : https://www.wowhead.com/wotlk/de/npc=19226
UPDATE `creature_template_locale` SET `Name` = 'Leerreisender',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19226;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19252;
-- OLD name : Gepanzerter Wyvernzerstörer
-- Source : https://www.wowhead.com/wotlk/de/npc=19275
UPDATE `creature_template_locale` SET `Name` = 'Gepanzerter Flügeldrachenzerstörer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19275;
-- OLD name : Unteroffizierin Altumus
-- Source : https://www.wowhead.com/wotlk/de/npc=19309
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Altumus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19309;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/de/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (19325, 'deDE','Barnu Schmetterfels','Stallmeister',0);
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19341;
-- OLD subname : Schusswaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=19351
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19351;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Köchin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19369;
-- OLD name : Nekrolyt des Blutenden Auges
-- Source : https://www.wowhead.com/wotlk/de/npc=19422
UPDATE `creature_template_locale` SET `Name` = 'Nekrolyth des Blutenden Auges',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19422;
-- OLD subname : Wurfwaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Wurfwaffen und Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19473;
-- OLD name : Welt Ausbilder für fliegende Reittiere
-- Source : https://www.wowhead.com/wotlk/de/npc=19490
UPDATE `creature_template_locale` SET `Name` = 'Welt Ausblider für fliegende Reittiere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19490;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=19491
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19491;
-- OLD subname : Stallmeisterin
-- Source : https://www.wowhead.com/wotlk/de/npc=19492
UPDATE `creature_template_locale` SET `Title` = 'Pferdereitlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19492;
-- OLD name : Agent des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=19501
UPDATE `creature_template_locale` SET `Name` = 'Agent des unteren Viertels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19501;
-- OLD name : Heiler des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=19502
UPDATE `creature_template_locale` SET `Name` = 'Heiler des unteren Viertels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19502;
-- OLD subname : Rüstungsschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=19517
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19517;
-- OLD subname : Edelsteine & Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=19538
UPDATE `creature_template_locale` SET `Title` = 'Edelsteine & Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19538;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19539;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19540;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19576;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=19774
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19774;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19775
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19775;
-- OLD subname : Juwelierskunstlehrling
-- Source : https://www.wowhead.com/wotlk/de/npc=19777
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19777;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=19778
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19778;
-- OLD name : Bild von Kommandantin Sarannis
-- Source : https://www.wowhead.com/wotlk/de/npc=19938
UPDATE `creature_template_locale` SET `Name` = 'Bild von Kommandant Sarannis',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 19938;
-- OLD name : Astromantenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=20046
UPDATE `creature_template_locale` SET `Name` = 'Astromantenlord',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20046;
-- OLD name : Versuchsobjekt: Wachposten von Lodaeron
-- Source : https://www.wowhead.com/wotlk/de/npc=20053
UPDATE `creature_template_locale` SET `Name` = 'Versuchsobjekt: Wachposten von Lordaeron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20053;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 20107;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedelehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20124;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedelehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20125;
-- OLD name : Blutdürstiger Marschenfang
-- Source : https://www.wowhead.com/wotlk/de/npc=20196
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Marschenfänger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20196;
-- OLD subname : Überholte Arenarüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Brutaler Arenaverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20278;
-- OLD name : Mönch der Auchenai
-- Source : https://www.wowhead.com/wotlk/de/npc=20299
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20299;
-- OLD name : Käpt'n Sanders
-- Source : https://www.wowhead.com/wotlk/de/npc=20351
UPDATE `creature_template_locale` SET `Name` = 'Kapitän Sanders',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20351;
-- OLD name : Eingefangenes Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=20396
UPDATE `creature_template_locale` SET `Name` = 'Gefangenes Geschöpf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20396;
-- OLD name : Wiedererwecktes Kleintier
-- Source : https://www.wowhead.com/wotlk/de/npc=20398
UPDATE `creature_template_locale` SET `Name` = 'Wiedererwecktes Geschöpf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20398;
-- OLD name : Scharfseherin Umbrua
-- Source : https://www.wowhead.com/wotlk/de/npc=20407
UPDATE `creature_template_locale` SET `Name` = 'Weissagerin Umbrua',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20407;
-- OLD name : Reitwyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=20413
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20413;
-- OLD name : Reitwyvern, gepanzert
-- Source : https://www.wowhead.com/wotlk/de/npc=20414
UPDATE `creature_template_locale` SET `Name` = 'Reitflügeldrache, gepanzert',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20414;
-- OLD name : Bürgerin des Hügellands
-- Source : https://www.wowhead.com/wotlk/de/npc=20429
UPDATE `creature_template_locale` SET `Name` = 'Bürger des Hügellands',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20429;
-- OLD name : Bürgerin des Hügellands
-- Source : https://www.wowhead.com/wotlk/de/npc=20430
UPDATE `creature_template_locale` SET `Name` = 'Bürger des Hügellands',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20430;
-- OLD name : Braunes Kaninchen
-- Source : https://www.wowhead.com/wotlk/de/npc=20472
UPDATE `creature_template_locale` SET `Name` = 'Brauner Hase',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20472;
-- OLD name : Lohfarbener Windreiter
-- Source : https://www.wowhead.com/wotlk/de/npc=20488
UPDATE `creature_template_locale` SET `Name` = 'Gelbbrauner Windreiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20488;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20500;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20511;
-- OLD name : Kapitän Skarloc
-- Source : https://www.wowhead.com/wotlk/de/npc=20521
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20521;
-- OLD name : Epochenjäger
-- Source : https://www.wowhead.com/wotlk/de/npc=20531
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20531;
-- OLD name : Thrall
-- Source : https://www.wowhead.com/wotlk/de/npc=20548
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20548;
-- OLD name : Aragas Junges
-- Source : https://www.wowhead.com/wotlk/de/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Dunkeltatzenjunges',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20615;
-- OLD name : Zauberhexerin des Echsenkessels
-- Source : https://www.wowhead.com/wotlk/de/npc=20625
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20625;
-- OLD name : Kriegsherr Kalithresh
-- Source : https://www.wowhead.com/wotlk/de/npc=20633
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20633;
-- OLD name : Botschafter Höllenschlund
-- Source : https://www.wowhead.com/wotlk/de/npc=20636
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20636;
-- OLD name : Dunkelfalke der Federschwingen
-- Source : https://www.wowhead.com/wotlk/de/npc=20686
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20686;
-- OLD name : Kobaltblaue Schlange
-- Source : https://www.wowhead.com/wotlk/de/npc=20688
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20688;
-- OLD name : Feendrache
-- Source : https://www.wowhead.com/wotlk/de/npc=20713
UPDATE `creature_template_locale` SET `Name` = 'Siechdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20713;
-- OLD name : Rek'tor
-- Source : https://www.wowhead.com/wotlk/de/npc=20716
UPDATE `creature_template_locale` SET `Name` = 'Scherbenweltraptor, Schwarz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20716;
-- OLD name : Erstarrter Leerenschrecken
-- Source : https://www.wowhead.com/wotlk/de/npc=20779
UPDATE `creature_template_locale` SET `Name` = 'Erstarrter Schrecken der Leere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20779;
-- OLD name : Akkiris-Blitzrufer
-- Source : https://www.wowhead.com/wotlk/de/npc=20908
UPDATE `creature_template_locale` SET `Name` = 'Akkiris Blitzrufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20908;
-- OLD name : Blutwache Porung
-- Source : https://www.wowhead.com/wotlk/de/npc=20992
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 20992;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/de/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21003;
-- OLD name : Verteidiger des Lebenden Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21072
UPDATE `creature_template_locale` SET `Name` = 'Verteidiger des lebenden Hains',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21072;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21087;
-- OLD name : Wyvernreiter der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=21153
UPDATE `creature_template_locale` SET `Name` = 'Flügeldrachenreiter der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21153;
-- OLD name : Gepanzerter Reitwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=21154
UPDATE `creature_template_locale` SET `Name` = 'Gepanzerter Reitflügeldrache der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21154;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21209;
-- OLD name : Hydromant der Gezeitenwandler
-- Source : https://www.wowhead.com/wotlk/de/npc=21228
UPDATE `creature_template_locale` SET `Name` = 'Wasserbeschwörer der Gezeitenwandler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21228;
-- OLD name : Sickernder Schlamm
-- Source : https://www.wowhead.com/wotlk/de/npc=21264
UPDATE `creature_template_locale` SET `Name` = 'Sickernder Brühschlammer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21264;
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21333;
-- OLD name : Gesandter Icarius
-- Source : https://www.wowhead.com/wotlk/de/npc=21409
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Icarius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21409;
-- OLD name : Tempixx Finagler
-- Source : https://www.wowhead.com/wotlk/de/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (21444, 'deDE','Tempixx Feinagler',NULL,0);
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21488;
-- OLD name : Drakonaar der Pechschwingen
-- Source : https://www.wowhead.com/wotlk/de/npc=21588
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21588;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/de/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (21634, 'deDE','Waldschreiter',NULL,0);
-- OLD subname : Reagenzien & Gifte
-- Source : https://www.wowhead.com/wotlk/de/npc=21642
UPDATE `creature_template_locale` SET `Title` = 'Reagenzien & Giftreagenzien',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21642;
-- OLD subname : Rüstmeister des Unteren Viertels (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21655
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister des unteren Viertels',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21655;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 21716;
-- OLD name : Orcnekrolyt
-- Source : https://www.wowhead.com/wotlk/de/npc=21747
UPDATE `creature_template_locale` SET `Name` = 'Orcnekrolyth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21747;
-- OLD name : Sturm der Leere des Singenden Bergrückens (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=21798
UPDATE `creature_template_locale` SET `Name` = 'Sturm der Leere des singenden Bergrückens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21798;
-- OLD name : Massive Zephyriumladung
-- Source : https://www.wowhead.com/wotlk/de/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21848;
-- OLD name : Reißer der Federschwingen
-- Source : https://www.wowhead.com/wotlk/de/npc=21989
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21989;
-- OLD name : Kriegsfalke der Federschwingen
-- Source : https://www.wowhead.com/wotlk/de/npc=21990
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 21990;
-- OLD name : Gesandter vom Auge des Sturms
-- Source : https://www.wowhead.com/wotlk/de/npc=22015
UPDATE `creature_template_locale` SET `Name` = 'Entsandter vom Auge des Sturms',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22015;
-- OLD name : Arenawerber
-- Source : https://www.wowhead.com/wotlk/de/npc=22101
UPDATE `creature_template_locale` SET `Name` = 'Arenapromoter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22101;
-- OLD name : Feuriger Brocken
-- Source : https://www.wowhead.com/wotlk/de/npc=22161
UPDATE `creature_template_locale` SET `Name` = 'Feuriger Felsen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22161;
-- OLD subname : Spezialistin für Mondstoffschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Mondstoffspezialistin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22208;
-- OLD subname : Spezialist für Schattenzwirnschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Schattenzwirnspezialist',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22212;
-- OLD subname : Spezialistin für Zauberfeuerschneiderei
-- Source : https://www.wowhead.com/wotlk/de/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Zauberfeuerspezialistin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22213;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22247
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22247;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22248
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22248;
-- OLD subname : Botschafterin von CocaCola
-- Source : https://www.wowhead.com/wotlk/de/npc=22249
UPDATE `creature_template_locale` SET `Title` = 'Botschafterin von Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22249;
-- OLD name : Schildwache der Thronwache
-- Source : https://www.wowhead.com/wotlk/de/npc=22301
UPDATE `creature_template_locale` SET `Name` = 'Späher der Thronwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22301;
-- OLD name : Herz der Bebenden Erde
-- Source : https://www.wowhead.com/wotlk/de/npc=22313
UPDATE `creature_template_locale` SET `Name` = 'Rumpelndes Erdherz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22313;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22423
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22423;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22425
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22425;
-- OLD name : Druide des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22426
UPDATE `creature_template_locale` SET `Name` = 'Druide des ewigen Hains',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22426;
-- OLD name : Urtum des Ewigen Hains (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=22478
UPDATE `creature_template_locale` SET `Name` = 'Urtum des ewigen Hains',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22478;
-- OLD subname : Forscherliga
-- Source : https://www.wowhead.com/wotlk/de/npc=22481
UPDATE `creature_template_locale` SET `Title` = 'Expeditionsleiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22481;
-- OLD name : Schildwache der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=22645
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22645;
-- OLD name : Leutnant Largent
-- Source : https://www.wowhead.com/wotlk/de/npc=22702
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22702;
-- OLD name : Alteracwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=22727
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22727;
-- OLD name : Unteroffizier Yazra Murrblut
-- Source : https://www.wowhead.com/wotlk/de/npc=22760
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22760;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 22801;
-- OLD name : Gorgolon der Allsehende
-- Source : https://www.wowhead.com/wotlk/de/npc=22827
UPDATE `creature_template_locale` SET `Name` = 'Gorgolon der Allessehende',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22827;
-- OLD name : Tempelkonkubine
-- Source : https://www.wowhead.com/wotlk/de/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Tempelakolyth',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22939;
-- OLD name : Bezaubernde Kurtisane
-- Source : https://www.wowhead.com/wotlk/de/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Bezaubernder Besucher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22955;
-- OLD name : Schwester der Schmerzen
-- Source : https://www.wowhead.com/wotlk/de/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Priesterin der Qual',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22956;
-- OLD name : Priesterin des Deliriums
-- Source : https://www.wowhead.com/wotlk/de/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Herrin des Deliriums',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22957;
-- OLD name : Verzauberter Aufseher
-- Source : https://www.wowhead.com/wotlk/de/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Unermüdlicher Gastgeber',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22959;
-- OLD name : Priesterin der Lust
-- Source : https://www.wowhead.com/wotlk/de/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Herrin des Leidens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22962;
-- OLD name : Schwester der Freuden
-- Source : https://www.wowhead.com/wotlk/de/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Priesterin der Wonne',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22964;
-- OLD name : Versklavter Diener
-- Source : https://www.wowhead.com/wotlk/de/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Ergebener Diener',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 22965;
-- OLD name : Zerrütter der Teufelwache
-- Source : https://www.wowhead.com/wotlk/de/npc=23055
UPDATE `creature_template_locale` SET `Name` = 'Zerrütter der Teufelswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23055;
-- OLD name : [PH]Knockdown Fel Cannon Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23077;
-- OLD subname : Magierlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=23103
UPDATE `creature_template_locale` SET `Title` = 'Magielehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23103;
-- OLD name : Verdammniswachenbestrafer
-- Source : https://www.wowhead.com/wotlk/de/npc=23113
UPDATE `creature_template_locale` SET `Name` = 'Bestrafer der Verdammniswache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23113;
-- OLD name : Dunstschemen eines Gronns
-- Source : https://www.wowhead.com/wotlk/de/npc=23121
UPDATE `creature_template_locale` SET `Name` = 'Dunstschemen der Gronn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23121;
-- OLD name : Scharfseher Javad
-- Source : https://www.wowhead.com/wotlk/de/npc=23127
UPDATE `creature_template_locale` SET `Name` = 'Weissager Javad',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23127;
-- OLD name : Manaschuldensklave
-- Source : https://www.wowhead.com/wotlk/de/npc=23154
UPDATE `creature_template_locale` SET `Name` = 'Manasüchtiger Sklave',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23154;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=23177
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23177;
-- OLD name : Aufklärer von Tarrens Mühle
-- Source : https://www.wowhead.com/wotlk/de/npc=23178
UPDATE `creature_template_locale` SET `Name` = 'Ausguck von Tarrens Mühle',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23178;
-- OLD name : Schwarzdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=23190
UPDATE `creature_template_locale` SET `Name` = 'Schwarzer Drache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23190;
-- OLD name : Assassine der Shivarra
-- Source : https://www.wowhead.com/wotlk/de/npc=23220
UPDATE `creature_template_locale` SET `Name` = 'Assassine der Shivan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23220;
-- OLD name : Wahnsinniger Vorarbeiter der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=23305
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Großknecht der Finsterblut',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23305;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23317;
-- OLD name : Wahnsinniger Minenarbeiter der Finsterblut
-- Source : https://www.wowhead.com/wotlk/de/npc=23324
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Minenarbeiter der Finsterblut',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23324;
-- OLD name : Rächer von Bash'ir
-- Source : https://www.wowhead.com/wotlk/de/npc=23332
UPDATE `creature_template_locale` SET `Name` = 'Rechnungsführer von Bash''ir',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23332;
-- OLD name : Schwarzdrachenwelpe
-- Source : https://www.wowhead.com/wotlk/de/npc=23364
UPDATE `creature_template_locale` SET `Name` = 'Schwarzer Drachenwelpe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23364;
-- OLD subname : Klassische Ketten- & Plattenrüstungen der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=23396
UPDATE `creature_template_locale` SET `Title` = 'Arenaverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23396;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/de/npc=23405
UPDATE `creature_template_locale` SET `Title` = 'PTR-Verbrauchsgüter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23405;
-- OLD name : Stellvertreter der Gordunni
-- Source : https://www.wowhead.com/wotlk/de/npc=23450
UPDATE `creature_template_locale` SET `Name` = 'Fernmelder der Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23450;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/de/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Winterhäldler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23559;
-- OLD name : Braufestwidder
-- Source : https://www.wowhead.com/wotlk/de/npc=23588
UPDATE `creature_template_locale` SET `Name` = 'Widder des Braufests',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23588;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23634;
-- OLD name : Festagsfass der Gerstenbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23700
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gerstenbräus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23700;
-- OLD name : Festagsfass der Donnerbräus
-- Source : https://www.wowhead.com/wotlk/de/npc=23702
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Donnerbräus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23702;
-- OLD name : Festagsfass der Gordok
-- Source : https://www.wowhead.com/wotlk/de/npc=23706
UPDATE `creature_template_locale` SET `Name` = 'Festtagsfass der Gordok',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23706;
-- OLD name : Claytons Testkreatur (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=23715
UPDATE `creature_template_locale` SET `Name` = 'Clayton''s Test Creature (2)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23715;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23734;
-- OLD name : Fass des Braufests zum Ziel bewegen (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Braufest: Bierfässchen zum Ziel bewegen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23808;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23830;
-- OLD name : Unteroffizierin Amelyn
-- Source : https://www.wowhead.com/wotlk/de/npc=23835
UPDATE `creature_template_locale` SET `Name` = 'Unteroffizier Amelyn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23835;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23855;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=23862
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23862;
-- OLD subname : Angellehrer & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Fischhändler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23896;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 23936;
-- OLD name : Gastwirtin Celeste Gutstall
-- Source : https://www.wowhead.com/wotlk/de/npc=23937
UPDATE `creature_template_locale` SET `Name` = 'Gastwirt Celeste Gutstall',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 23937;
-- OLD name : Belagerungsarbeiter
-- Source : https://www.wowhead.com/wotlk/de/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Mühlenarbeiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24005;
-- OLD name : Zielattrappe des Braufests zum Ziel bewegen (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24109
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Target Dummy Move To Target',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24109;
-- OLD name : Kriegerheld der Winterhufe
-- Source : https://www.wowhead.com/wotlk/de/npc=24130
UPDATE `creature_template_locale` SET `Name` = 'Held der Winterhufe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24130;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24171;
-- OLD name : Aufklärer der Amani'shi
-- Source : https://www.wowhead.com/wotlk/de/npc=24175
UPDATE `creature_template_locale` SET `Name` = 'Ausguck der Amani''shi',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24175;
-- OLD name : Geist von Forscher Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24181;
-- OLD name : Armee der Toten
-- Source : https://www.wowhead.com/wotlk/de/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Ghul aus der Armee der Toten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24220;
-- OLD name : Kriecher
-- Source : https://www.wowhead.com/wotlk/de/npc=24242
UPDATE `creature_template_locale` SET `Name` = 'Glibber',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24242;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24265;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24311;
-- OLD name : Nordendtransportmittel der Blizzcon (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24331
UPDATE `creature_template_locale` SET `Name` = 'Nordendtransportmittel der BlizzCon',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24331;
-- OLD name : Jason Gutstall, subname : Barkeeper
-- Source : https://www.wowhead.com/wotlk/de/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Schankkellner Jason Gutstall',`Title` = 'Getränke',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24333;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24352;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24361;
-- OLD name : Harrisons Leichnam
-- Source : https://www.wowhead.com/wotlk/de/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Willies Leichnam',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24365;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24378;
-- OLD name : Begrüßer der Blizzcon (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=24380
UPDATE `creature_template_locale` SET `Name` = 'Begrüßer der BlizzCon',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24380;
-- OLD subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=24395
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24395;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/de/npc=24417
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24417;
-- OLD name : Schmiedenfeuer
-- Source : https://www.wowhead.com/wotlk/de/npc=24471
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24471;
-- OLD name : Blutdürstiger Worg
-- Source : https://www.wowhead.com/wotlk/de/npc=24475
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Worg',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24475;
-- OLD name : Froschtransformation
-- Source : https://www.wowhead.com/wotlk/de/npc=24483
UPDATE `creature_template_locale` SET `Name` = 'Transformation des Froschs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24483;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=24520
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24520;
-- OLD subname : Garaxxas Tier
-- Source : https://www.wowhead.com/wotlk/de/npc=24552
UPDATE `creature_template_locale` SET `Title` = 'Garaxxas'' Begleiter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24552;
-- OLD name : Leutnant Eishammer
-- Source : https://www.wowhead.com/wotlk/de/npc=24665
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24665;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 24766;
-- OLD name : Behüter des Nexus
-- Source : https://www.wowhead.com/wotlk/de/npc=24770
UPDATE `creature_template_locale` SET `Name` = 'Behüter des Nexus''',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24770;
-- OLD name : Ross des kopflosen Reiters
-- Source : https://www.wowhead.com/wotlk/de/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Reittier des kopflosen Reiters',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24814;
-- OLD name : Piratin der Defias
-- Source : https://www.wowhead.com/wotlk/de/npc=24860
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24860;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24868;
-- OLD name : Erste Offizierin Kupferbolz
-- Source : https://www.wowhead.com/wotlk/de/npc=24926
UPDATE `creature_template_locale` SET `Name` = 'Erster Offizier Kupferbolz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24926;
-- OLD name : Madame Flaschatauren, subname : Gefährtin des Flaschatauren
-- Source : https://www.wowhead.com/wotlk/de/npc=24982
UPDATE `creature_template_locale` SET `Name` = 'Frau Flaschatauren',`Title` = 'PTR-Verzauberungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24982;
-- OLD name : Winterhauptmann Skarloc
-- Source : https://www.wowhead.com/wotlk/de/npc=24987
UPDATE `creature_template_locale` SET `Name` = 'Winterkapitän Skarloc',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 24987;
-- OLD name : Schildwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25045
UPDATE `creature_template_locale` SET `Name` = 'Wächter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25045;
-- OLD name : Erste Offizierin Kupfernuss
-- Source : https://www.wowhead.com/wotlk/de/npc=25070
UPDATE `creature_template_locale` SET `Name` = 'Erster Offizier Kupfernuss',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25070;
-- OLD name : Grunzerin Ounda
-- Source : https://www.wowhead.com/wotlk/de/npc=25081
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Ounda',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25081;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25099;
-- OLD name : Frixi Messingkipper
-- Source : https://www.wowhead.com/wotlk/de/npc=25179
UPDATE `creature_template_locale` SET `Name` = 'Frixee Messingkipper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25179;
-- OLD name : Moorbiss' Wyvern
-- Source : https://www.wowhead.com/wotlk/de/npc=25185
UPDATE `creature_template_locale` SET `Name` = 'Moorbiss'' Flügeldrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25185;
-- OLD name : Skarlocs Schlachtross
-- Source : https://www.wowhead.com/wotlk/de/npc=25190
UPDATE `creature_template_locale` SET `Name` = 'Skarlocs Schlachtroß',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25190;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Händler für Spezialmunition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/de/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Händler für Spezialmunition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25196;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=25225
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25225;
-- OLD name : Hordezeppelin (Nordend)
-- Source : https://www.wowhead.com/wotlk/de/npc=25269
UPDATE `creature_template_locale` SET `Name` = 'Hordenzeppelin (Nordend)',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25269;
-- OLD subname : Ingenieurkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25277;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25323, 'deDE',NULL,'Softwareingenieur',0);
-- OLD name : Gortsch der Leichenmalmer
-- Source : https://www.wowhead.com/wotlk/de/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25329;
-- OLD name : Zwielichtspion Viktor, subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25346
UPDATE `creature_template_locale` SET `Name` = 'Spion Viktor des Schattenhammers',`Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25346;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25406, 'deDE',NULL,'Softwareingenieur',0);
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/de/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25411, 'deDE',NULL,'Softwareingenieur',0);
-- OLD name : Vision von Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25424
UPDATE `creature_template_locale` SET `Name` = 'Vision des Weissagers Grimmläufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25424;
-- OLD name : Scharfseher Grimmläufers Geist
-- Source : https://www.wowhead.com/wotlk/de/npc=25425
UPDATE `creature_template_locale` SET `Name` = 'Weissager Grimmläufers Geist',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25425;
-- OLD name : Vision des Geistes von Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25458
UPDATE `creature_template_locale` SET `Name` = 'Vision des Geistes von Weissager Grimmläufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25458;
-- OLD name : Scharfseher Grimmläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=25461
UPDATE `creature_template_locale` SET `Name` = 'Weissager Grimmläufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25461;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/de/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25537, 'deDE','Craig''s Test Human',NULL,0);
-- OLD name : Sengender Flämmling
-- Source : https://www.wowhead.com/wotlk/de/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Flämmling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25706;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 25746;
-- OLD name : Leerenschildwache
-- Source : https://www.wowhead.com/wotlk/de/npc=25772
UPDATE `creature_template_locale` SET `Name` = 'Leerenwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25772;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25863
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25863;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25866
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25866;
-- OLD name : Flammenwächter der Verwüsteten Lande (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25890
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der verwüsteten Lande',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25890;
-- OLD name : Flammenwächter der Brennenden Steppe (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25892
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der brennenden Steppe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25892;
-- OLD name : Flammenwächter des Schlingendornkaps
-- Source : https://www.wowhead.com/wotlk/de/npc=25915
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter des Schlingendorntals',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25915;
-- OLD name : Flammenbewahrer des Schlingendornkaps
-- Source : https://www.wowhead.com/wotlk/de/npc=25920
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des Schlingendorntals',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25920;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25924
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25924;
-- OLD name : Flammenbewahrer der Brennenden Steppe (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=25927
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer der brennenden Steppe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25927;
-- OLD name : Flammenbewahrer der Höllenfeuerinsel
-- Source : https://www.wowhead.com/wotlk/de/npc=25934
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer der Höllenfeuerhalbinsel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25934;
-- OLD name : Flammenbewahrer des Nördlichen Brachlands
-- Source : https://www.wowhead.com/wotlk/de/npc=25943
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des Brachlands',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25943;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=25949
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25949;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=25950
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 25950;
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (26080, 'deDE','NPCs',NULL,0);
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26176;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=26183
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26183;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26190;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26222
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26222;
-- OLD subname : Schattenhammer
-- Source : https://www.wowhead.com/wotlk/de/npc=26223
UPDATE `creature_template_locale` SET `Title` = 'Schattenhammerklan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26223;
-- OLD name : Gischtalbatros
-- Source : https://www.wowhead.com/wotlk/de/npc=26240
UPDATE `creature_template_locale` SET `Name` = 'Gischtalbatross',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26240;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26241;
-- OLD name : Purpurschlange
-- Source : https://www.wowhead.com/wotlk/de/npc=26243
UPDATE `creature_template_locale` SET `Name` = 'Scharlachrote Schlange',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26243;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26258;
-- OLD name : Ereignisauslöser des Vergessenen Strands.
-- Source : https://www.wowhead.com/wotlk/de/npc=26288
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26288;
-- OLD name : Risswirker der Zerschmetterten Sonne
-- Source : https://www.wowhead.com/wotlk/de/npc=26289
UPDATE `creature_template_locale` SET `Name` = 'Felsspalter der Zerschmetterten Sonne',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26289;
-- OLD name : Händler für Stoffrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26301
UPDATE `creature_template_locale` SET `Name` = 'Händler für Stoff- und Lederrüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26301;
-- OLD name : Gemischtwarenhändler
-- Source : https://www.wowhead.com/wotlk/de/npc=26304
UPDATE `creature_template_locale` SET `Name` = 'Händler für Gemischtwaren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26304;
-- OLD name : Händler für Plattenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26305
UPDATE `creature_template_locale` SET `Name` = 'Händler für Ketten- und Plattenrüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26305;
-- OLD name : Händler für Lederrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26306
UPDATE `creature_template_locale` SET `Name` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26306;
-- OLD name : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26308
UPDATE `creature_template_locale` SET `Name` = 'Händler für Plattenrüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26308;
-- OLD name : Zokk "Lulatsch" Drillzang
-- Source : https://www.wowhead.com/wotlk/de/npc=26352
UPDATE `creature_template_locale` SET `Name` = 'Bigzokk Drillzang',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26352;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26355;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (26376, 'deDE','NPCs',NULL,0);
-- OLD name : Evee Kupferspule, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26378;
-- OLD name : Grikkin Kupferspule, subname : Arenaverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26383;
-- OLD name : Frixi Messingkipper, subname : Arenaverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26391;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26397
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26397;
-- OLD subname : Rüstmeisterin für Rüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=26398
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26398;
-- OLD name : Aufklärer von Kaskala
-- Source : https://www.wowhead.com/wotlk/de/npc=26403
UPDATE `creature_template_locale` SET `Name` = 'Warte von Kaskala',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26403;
-- OLD name : Gesandter Reißzahn
-- Source : https://www.wowhead.com/wotlk/de/npc=26441
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Reißzahn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26441;
-- OLD name : Kranker Drakkari
-- Source : https://www.wowhead.com/wotlk/de/npc=26457
UPDATE `creature_template_locale` SET `Name` = 'Verstorbener Drakkari',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26457;
-- OLD name : Krieger der Horde (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26486
UPDATE `creature_template_locale` SET `Name` = 'Hordekrieger',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26486;
-- OLD subname : Zeppelinmeister, Boreanische Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26537
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, boreanische Tundra',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26537;
-- OLD subname : Zeppelinmeister, Orgrimmar
-- Source : https://www.wowhead.com/wotlk/de/npc=26538
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, Durotar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26538;
-- OLD subname : Zeppelinmeisterin, Heulender Fjord
-- Source : https://www.wowhead.com/wotlk/de/npc=26539
UPDATE `creature_template_locale` SET `Title` = 'Zeppelinmeister, heulender Fjord',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26539;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26564;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26576;
-- OLD name : Transformation der spirituellen Einsicht (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26594
UPDATE `creature_template_locale` SET `Name` = 'Spirituelle Eingebung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26594;
-- OLD name : Fallschirmjäger von Kurbelzisch
-- Source : https://www.wowhead.com/wotlk/de/npc=26619
UPDATE `creature_template_locale` SET `Name` = 'Fallschirmspringer von Kurbelzisch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26619;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (26671, 'deDE','NPCs',NULL,0);
-- OLD name : Blutdürstiger Tundrawolf
-- Source : https://www.wowhead.com/wotlk/de/npc=26672
UPDATE `creature_template_locale` SET `Name` = 'Blutdurstiger Tundrawolf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26672;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26724;
-- OLD name : Windelementar der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=26726
UPDATE `creature_template_locale` SET `Name` = 'Windelementar der boreanischen Tundra',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26726;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26732;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26765;
-- OLD name : Kriegerheld Sturmhimmel
-- Source : https://www.wowhead.com/wotlk/de/npc=26766
UPDATE `creature_template_locale` SET `Name` = 'Tapfer Sturmhimmel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26766;
-- OLD name : Klerikerin der 7. Legion
-- Source : https://www.wowhead.com/wotlk/de/npc=26780
UPDATE `creature_template_locale` SET `Name` = 'Kleriker der 7. Legion',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26780;
-- OLD subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/de/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (26791, 'deDE',NULL,'Leben dieben',0);
-- OLD name : Waldläuferin der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=26802
UPDATE `creature_template_locale` SET `Name` = 'Waldläufer der Allianz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26802;
-- OLD name : Gesandter Ducal
-- Source : https://www.wowhead.com/wotlk/de/npc=26821
UPDATE `creature_template_locale` SET `Name` = 'Entsandter Ducal',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26821;
-- OLD subname : Windreitermeister (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=26842
UPDATE `creature_template_locale` SET `Title` = 'Windreitermeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26842;
-- OLD name : Erdwächter Graif
-- Source : https://www.wowhead.com/wotlk/de/npc=26854
UPDATE `creature_template_locale` SET `Name` = 'Erdenwächter Graif',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26854;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=26901
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26901;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26903
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26903;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26904
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26904;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26905
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26905;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26906
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26906;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26907
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26907;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26909
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26909;
-- OLD subname : Kräuterkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26910
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kräuterkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26910;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26911
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26911;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26912
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26912;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26913
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26913;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26914
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26914;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26915
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26915;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26916
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26916;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26951
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26951;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26952
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26952;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26953
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26953;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26954
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26954;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26955
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26955;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26956;
-- OLD subname : Angellehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26957
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Angelns',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26957;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26958
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26958;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26959
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26959;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26960
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26960;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26961
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26961;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26962
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26962;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26963
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kürschnerei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26963;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26964
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26964;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26969;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26972
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26972;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26974
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26974;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26975
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26975;
-- OLD subname : Bergbaulehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26976
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Bergbaus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26976;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26977
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26977;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26980
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26980;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26981
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26981;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26982
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26982;
-- OLD subname : Kürschnerlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26986
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26986;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26987
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26987;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26988
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26988;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26989
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26989;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26990
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26990;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26991
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26991;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin für Erste Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26992;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26993
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26993;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26994
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26994;
-- OLD name : Klimper Hellblitz, subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26995
UPDATE `creature_template_locale` SET `Name` = 'Bastel Hellblitz',`Title` = 'Großmeisterin der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26995;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26996
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26996;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26997
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26997;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=26998
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26998;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=26999
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 26999;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27000
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27000;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27001
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27001;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27023;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27029;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27034;
-- OLD name : Kriegerheld von Oneqwah
-- Source : https://www.wowhead.com/wotlk/de/npc=27126
UPDATE `creature_template_locale` SET `Name` = 'Kriegsheld von Oneqwah',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27126;
-- OLD subname : Rüstungsschmiedin
-- Source : https://www.wowhead.com/wotlk/de/npc=27134
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmied',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27134;
-- OLD name : Hochkommandant Halford Wyrmbann
-- Source : https://www.wowhead.com/wotlk/de/npc=27136
UPDATE `creature_template_locale` SET `Name` = 'Oberkommandant Halford Wyrmbann',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27136;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27142
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27142;
-- OLD name : Folterer LeCraft
-- Source : https://www.wowhead.com/wotlk/de/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Folterer Alphonse',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27209;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27222
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27222;
-- OLD name : Zielscheibe
-- Source : https://www.wowhead.com/wotlk/de/npc=27223
UPDATE `creature_template_locale` SET `Name` = 'Pfeil-und-Bogen-Ziel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27223;
-- OLD subname : Geprüfte Qualität (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=27231
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27231;
-- OLD name : Ergebener Leibwächter
-- Source : https://www.wowhead.com/wotlk/de/npc=27247
UPDATE `creature_template_locale` SET `Name` = 'Andächtiger Leibwächter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27247;
-- OLD name : Forstmeister Anderhol
-- Source : https://www.wowhead.com/wotlk/de/npc=27277
UPDATE `creature_template_locale` SET `Name` = 'Förstermeister Anderhol',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27277;
-- OLD name : Spionagemeisterin Repine
-- Source : https://www.wowhead.com/wotlk/de/npc=27337
UPDATE `creature_template_locale` SET `Name` = 'Spionenmeisterin Repine',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27337;
-- OLD name : Adeline Kammerer
-- Source : https://www.wowhead.com/wotlk/de/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Fledermausführerin Adeline',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27344;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=27360
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27360;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=27362
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27362;
-- OLD name : Schwelender Spuk
-- Source : https://www.wowhead.com/wotlk/de/npc=27363
UPDATE `creature_template_locale` SET `Name` = 'Glimmender Spuk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27363;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27368;
-- OLD name : Chefschreiber Barriga
-- Source : https://www.wowhead.com/wotlk/de/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Chefschreiber Kinnedius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27378;
-- OLD name : Angriffsauslöser des Inneren Tores von Wintergarde
-- Source : https://www.wowhead.com/wotlk/de/npc=27380
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27380;
-- OLD name : Thel'zan der Dämmerbringer
-- Source : https://www.wowhead.com/wotlk/de/npc=27384
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27384;
-- OLD name : Utgarde Duo Trigger
-- Source : https://www.wowhead.com/wotlk/de/npc=27404
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27404;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (27527, 'deDE','NPCs',NULL,0);
-- OLD name : Zenturio Kaggrum
-- Source : https://www.wowhead.com/wotlk/de/npc=27563
UPDATE `creature_template_locale` SET `Name` = 'Zenturion Kaggrum',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27563;
-- OLD name : Lord Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/de/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Lord Devrestrasz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27575;
-- OLD subname : Initiand des Wolfskults (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=27632
UPDATE `creature_template_locale` SET `Title` = 'Initiandin des Wolfskults',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27632;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=27666
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27666;
-- OLD name : Reitkodo des Braufests
-- Source : https://www.wowhead.com/wotlk/de/npc=27706
UPDATE `creature_template_locale` SET `Name` = 'Reitkodo des Brausfests',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27706;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 27723;
-- OLD name : Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=27731
UPDATE `creature_template_locale` SET `Name` = 'Akolyt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27731;
-- OLD name : Späherhauptmann Carter
-- Source : https://www.wowhead.com/wotlk/de/npc=27783
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Carter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27783;
-- OLD name : Bierschankwirtin
-- Source : https://www.wowhead.com/wotlk/de/npc=27819
UPDATE `creature_template_locale` SET `Name` = 'Bierschankwirt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27819;
-- OLD name : Patty's test vehicle TEST (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - vehicle',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27862;
-- OLD name : Gebräublase
-- Source : https://www.wowhead.com/wotlk/de/npc=27882
UPDATE `creature_template_locale` SET `Name` = 'Bierblase',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27882;
-- OLD name : Leutnant Eishammer
-- Source : https://www.wowhead.com/wotlk/de/npc=27994
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 27994;
-- OLD name : Verrottende Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=28023
UPDATE `creature_template_locale` SET `Name` = 'Verrottende Montrosität',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28023;
-- OLD name : Die Geist von Gnomeregan
-- Source : https://www.wowhead.com/wotlk/de/npc=28037
UPDATE `creature_template_locale` SET `Name` = 'Die ''Geist von Gnomeregan''',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28037;
-- OLD subname : Geißel der Südlichen Meere (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=28048
UPDATE `creature_template_locale` SET `Title` = 'Geißel der südlichen Meere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28048;
-- OLD name : Ol' Chumbucket
-- Source : https://www.wowhead.com/wotlk/de/npc=28050
UPDATE `creature_template_locale` SET `Name` = 'Der Alte Fischkübel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28050;
-- OLD name : Cap'n Slappy
-- Source : https://www.wowhead.com/wotlk/de/npc=28051
UPDATE `creature_template_locale` SET `Name` = 'Käpt''n Slappy',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28051;
-- OLD name : Saphirblaue Schwarmdrohne
-- Source : https://www.wowhead.com/wotlk/de/npc=28085
UPDATE `creature_template_locale` SET `Name` = 'Saphirblaue Schwarmdrone',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28085;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=28177
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28177;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28206;
-- OLD name : Hartknöchelmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=28213
UPDATE `creature_template_locale` SET `Name` = 'Hartknöchelmatriachin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28213;
-- OLD name : Koyotengeist
-- Source : https://www.wowhead.com/wotlk/de/npc=28267
UPDATE `creature_template_locale` SET `Name` = 'Kojotengeist',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28267;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28292;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=28306
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28306;
-- OLD name : Großer Kampfbär
-- Source : https://www.wowhead.com/wotlk/de/npc=28363
UPDATE `creature_template_locale` SET `Name` = 'Großer Kriegsbär',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28363;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (28501, 'deDE','NPCs',NULL,0);
-- OLD name : Kapitän Shely
-- Source : https://www.wowhead.com/wotlk/de/npc=28549
UPDATE `creature_template_locale` SET `Name` = 'Hauptmann Shely',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28549;
-- OLD name : Großknecht Kaleiki
-- Source : https://www.wowhead.com/wotlk/de/npc=28552
UPDATE `creature_template_locale` SET `Name` = 'Großknecht Kaileki',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28552;
-- OLD name : Folterer LeCraft
-- Source : https://www.wowhead.com/wotlk/de/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Folterer Alphonse',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28554;
-- OLD name : Wasserfontäne
-- Source : https://www.wowhead.com/wotlk/de/npc=28567
UPDATE `creature_template_locale` SET `Name` = 'Wasserstrahl',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28567;
-- OLD name : Maurermeisterin van der Gülden
-- Source : https://www.wowhead.com/wotlk/de/npc=28572
UPDATE `creature_template_locale` SET `Name` = 'Maurermeister van der Gülden',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28572;
-- OLD name : Akolyth der Todeshand
-- Source : https://www.wowhead.com/wotlk/de/npc=28602
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Todeshand',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28602;
-- OLD name : Mysteriöser Zigeuner (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=28652
UPDATE `creature_template_locale` SET `Name` = 'Mysteriöser Händler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28652;
-- OLD name : Prophet von Quetz'lun
-- Source : https://www.wowhead.com/wotlk/de/npc=28671
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28671;
-- OLD subname : Bankier (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=28678
UPDATE `creature_template_locale` SET `Title` = 'Bankierin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28678;
-- OLD subname : Bankier (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=28679
UPDATE `creature_template_locale` SET `Title` = 'Bankierin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28679;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28693;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28694;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28696
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kürschnerei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28696;
-- OLD subname : Ingenieurskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28697
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28697;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Bergbaus',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28698;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28699;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28700
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28700;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28701;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28702;
-- OLD subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28703;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kräuterkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28704;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28705;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin für Erste Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28706;
-- OLD name : Seelenbrunnenzone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=28719
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone des Seelenbrunnens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28719;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28721
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28721;
-- OLD subname : Angellehrerin & Angelbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin des Angelns & Angelbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28742;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28746;
-- OLD name : Hargus der Krüppel
-- Source : https://www.wowhead.com/wotlk/de/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Hargus der Spuk',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28760;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28767;
-- OLD name : Schattenhafter Peiniger
-- Source : https://www.wowhead.com/wotlk/de/npc=28769
UPDATE `creature_template_locale` SET `Name` = 'Schattenhafter Foltermeister',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28769;
-- OLD name : Ausgelaugter Prophet von Quetz'lun
-- Source : https://www.wowhead.com/wotlk/de/npc=28795
UPDATE `creature_template_locale` SET `Name` = 'Ausgelaugter Prophet von Quetz''lin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28795;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=28799
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleiferbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28799;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=28800
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28800;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28813;
-- OLD name : Scharlachroter Flottenverteidiger
-- Source : https://www.wowhead.com/wotlk/de/npc=28856
UPDATE `creature_template_locale` SET `Name` = 'Wächter der Scharlachroten Flotte',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28856;
-- OLD name : Scharlachroter Hauptmann
-- Source : https://www.wowhead.com/wotlk/de/npc=28898
UPDATE `creature_template_locale` SET `Name` = 'Schalachroter Hauptmann',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28898;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 28957;
-- OLD name : Scharlachroter Lord Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/de/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Lord Borugh',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 28964;
-- OLD name : Purpurroter Akolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=29007
UPDATE `creature_template_locale` SET `Name` = 'Purpurroter Akolyt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29007;
-- OLD subname : Bogenmacher
-- Source : https://www.wowhead.com/wotlk/de/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Pfeilmacher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29014;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29025;
-- OLD name : Greif von Sturmwind (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUSE',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29039;
-- OLD name : Blutklauenmatriarchin
-- Source : https://www.wowhead.com/wotlk/de/npc=29044
UPDATE `creature_template_locale` SET `Name` = 'Blutklauenmatriarch',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29044;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29192;
-- OLD subname : Reagenzienverkäufer
-- Source : https://www.wowhead.com/wotlk/de/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Leichenstaubverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29203;
-- OLD name : Cenarischer Späher
-- Source : https://www.wowhead.com/wotlk/de/npc=29220
UPDATE `creature_template_locale` SET `Name` = 'Aufklärer des Cenarius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29220;
-- OLD name : Antimagisches Feld
-- Source : https://www.wowhead.com/wotlk/de/npc=29225
UPDATE `creature_template_locale` SET `Name` = 'Antimagiezone',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29225;
-- OLD subname : Lehrerin für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ersten Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29233;
-- OLD name : Land Mine Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=29397
UPDATE `creature_template_locale` SET `Name` = 'Landminenhäschen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29397;
-- OLD name : Gluth
-- Source : https://www.wowhead.com/wotlk/de/npc=29417
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29417;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Spezialmunition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29493;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Waffenschmiedekunstlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29505;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Rüstungsschmiedekunstlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29506;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Elementarlederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29507;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Drachenlederverarbeitungslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29508;
-- OLD subname : Lederverarbeitungslehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Stammeslederverarbeitungslehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29509;
-- OLD subname : Gnomischer Ingenieurslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29514
UPDATE `creature_template_locale` SET `Title` = 'Gnomeningenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29514;
-- OLD subname : Händler für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=29523
UPDATE `creature_template_locale` SET `Title` = 'Händler für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29523;
-- OLD subname : Kochkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29631;
-- OLD subname : Flugmeister (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=29749
UPDATE `creature_template_locale` SET `Title` = 'Flugmeisterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29749;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 29812;
-- OLD name : Exemplar eines Jungen von Stratholme
-- Source : https://www.wowhead.com/wotlk/de/npc=29868
UPDATE `creature_template_locale` SET `Name` = 'Exemplar eines Kindes von Stratholme',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29868;
-- OLD name : Runenlord der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29891
UPDATE `creature_template_locale` SET `Name` = 'Runenlord',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29891;
-- OLD name : Seuchenklaue der Vargul
-- Source : https://www.wowhead.com/wotlk/de/npc=29894
UPDATE `creature_template_locale` SET `Name` = 'Vargul Seuchenklaue',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29894;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29924;
-- OLD name : Motorrad der Horde (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=29930
UPDATE `creature_template_locale` SET `Name` = 'Motorrad der Allianz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29930;
-- OLD name : Akolyth der Pein
-- Source : https://www.wowhead.com/wotlk/de/npc=29934
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Pein',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29934;
-- OLD name : Akolyth des Schmerzes
-- Source : https://www.wowhead.com/wotlk/de/npc=29935
UPDATE `creature_template_locale` SET `Name` = 'Akolyt des Schmerzes',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 29935;
-- OLD name : Bibliothekarin Tiare
-- Source : https://www.wowhead.com/wotlk/de/npc=30051
UPDATE `creature_template_locale` SET `Name` = 'Bibliothekar Tiare',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30051;
-- OLD name : Kel''Thuzad
-- Source : https://www.wowhead.com/wotlk/de/npc=30061
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30061;
-- OLD name : Initiandin Claget
-- Source : https://www.wowhead.com/wotlk/de/npc=30067
UPDATE `creature_template_locale` SET `Name` = 'Initiant Claget',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30067;
-- OLD name : Initiand Roderick
-- Source : https://www.wowhead.com/wotlk/de/npc=30069
UPDATE `creature_template_locale` SET `Name` = 'Initiant Roderick',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30069;
-- OLD name : Initiand Gahark
-- Source : https://www.wowhead.com/wotlk/de/npc=30070
UPDATE `creature_template_locale` SET `Name` = 'Initiant Gahark',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30070;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30078;
-- OLD subname : Waldläufergeneralin des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=30115
UPDATE `creature_template_locale` SET `Title` = 'Waldläufergeneral des Silberbunds',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30115;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30156;
-- OLD name : Himmelsklaue des Wyrmruhtempels
-- Source : https://www.wowhead.com/wotlk/de/npc=30161
UPDATE `creature_template_locale` SET `Name` = 'Himmelsklaue von Wyrmruh',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30161;
-- OLD name : Akolyth der Vergessenen Tiefen
-- Source : https://www.wowhead.com/wotlk/de/npc=30205
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Vergessenen Tiefen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30205;
-- OLD name : Nexusfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=30245
UPDATE `creature_template_locale` SET `Name` = 'Nexuslord',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30245;
-- OLD name : Wissenshüter Randvir
-- Source : https://www.wowhead.com/wotlk/de/npc=30252
UPDATE `creature_template_locale` SET `Name` = 'Hüter des Wissens Randvir',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30252;
-- OLD name : Späherhauptmann Daelin
-- Source : https://www.wowhead.com/wotlk/de/npc=30261
UPDATE `creature_template_locale` SET `Name` = 'Feldspäherhauptmann Daelin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30261;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/de/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorkuttar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30340;
-- OLD subname : Verwüsteringenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30400
UPDATE `creature_template_locale` SET `Title` = 'Verwüstungsingenieur',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30400;
-- OLD subname : Bansheekönigin (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=30426
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30426;
-- OLD subname : Bansheekönigin (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=30427
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30427;
-- OLD subname : Bansheekönigin (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=30428
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30437;
-- OLD subname : Gifte, Reagenzien & Handwerkswaren
-- Source : https://www.wowhead.com/wotlk/de/npc=30438
UPDATE `creature_template_locale` SET `Title` = 'Gifte, Reagenzien & Handelswaren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30438;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30476;
-- OLD name : Gnomeningenieur
-- Source : https://www.wowhead.com/wotlk/de/npc=30499
UPDATE `creature_template_locale` SET `Name` = 'Gnomingenieur',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30499;
-- OLD name : Sturmgeschmiedeter Kriegshetzer
-- Source : https://www.wowhead.com/wotlk/de/npc=30504
UPDATE `creature_template_locale` SET `Name` = 'Sturmgeschmiedeter Kriegstreiber',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30504;
-- OLD name : Großmagistrix Telestra
-- Source : https://www.wowhead.com/wotlk/de/npc=30510
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30510;
-- OLD name : Großmagistrix Telestra
-- Source : https://www.wowhead.com/wotlk/de/npc=30513
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30513;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/de/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30559;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=30570
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30570;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/de/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30572;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30589;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/de/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Arenaveranstalterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30611;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30640;
-- OLD name : Zwielichtriss
-- Source : https://www.wowhead.com/wotlk/de/npc=30641
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtspalt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30641;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30649;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30655;
-- OLD name : Azurblauer Zauberer
-- Source : https://www.wowhead.com/wotlk/de/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Azurblaue Zauberin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30667;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30707;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30721;
-- OLD subname : Inschriftenkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30722;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30749;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 30832;
-- OLD subname : Überholte Arenarüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Wasserverkäufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=30888
UPDATE `creature_template_locale` SET `Name` = 'Andrew Test Dummy 80 Hostile Low Damage',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30888;
-- OLD name : Azurblauer Magiertöter
-- Source : https://www.wowhead.com/wotlk/de/npc=30963
UPDATE `creature_template_locale` SET `Name` = 'Azurblauer Pirscher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 30963;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=31017
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31017;
-- OLD name : Entmutigter Ent
-- Source : https://www.wowhead.com/wotlk/de/npc=31041
UPDATE `creature_template_locale` SET `Name` = 'Zweigeistiger Ent',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31041;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31060;
-- OLD name : Chilly
-- Source : https://www.wowhead.com/wotlk/de/npc=31128
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31128;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (31143, 'deDE','NPCs',NULL,0);
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Großmeisters',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31144;
-- OLD name : Trainingsattrappe des Schlachtzuges
-- Source : https://www.wowhead.com/wotlk/de/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Heroische Trainingsattrappe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31146;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31168;
-- OLD name : Ewiger Agent
-- Source : https://www.wowhead.com/wotlk/de/npc=31203
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31203;
-- OLD name : Akolyth von Shadron
-- Source : https://www.wowhead.com/wotlk/de/npc=31218
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Shadron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31218;
-- OLD name : Akolyth von Vesperon
-- Source : https://www.wowhead.com/wotlk/de/npc=31219
UPDATE `creature_template_locale` SET `Name` = 'Akolyt von Vesperon',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31219;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=31238
UPDATE `creature_template_locale` SET `Title` = 'Lehrerin für Kaltwetterflug',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31238;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31246;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Lehrer für Kaltwetterflug',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31247;
-- OLD name : Eine geheimnisvolle Stimme
-- Source : https://www.wowhead.com/wotlk/de/npc=31264
UPDATE `creature_template_locale` SET `Name` = 'Eine mysteriöse Stimme',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31264;
-- OLD name : Kampfwyvern der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=31269
UPDATE `creature_template_locale` SET `Name` = 'Kampfflügeldrache der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31269;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31353;
-- OLD subname : Schusswaffenverkäuferin
-- Source : https://www.wowhead.com/wotlk/de/npc=31423
UPDATE `creature_template_locale` SET `Title` = 'Schusswaffen & Munition',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31423;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=31429
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für schwere Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31429;
-- OLD name : Auktionator Thathung
-- Source : https://www.wowhead.com/wotlk/de/npc=31430
UPDATE `creature_template_locale` SET `Name` = 'Auktionator Thatung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31430;
-- OLD subname : Emblem der Ehre Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Ehre',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31579;
-- OLD subname : Emblem des Heldentums Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Heldentums',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31580;
-- OLD subname : Emblem der Ehre Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Ehre',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31581;
-- OLD subname : Emblem des Heldentums Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Heldentums',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31582;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (31696, 'deDE','NPCs',NULL,0);
-- OLD name : Zwielichtdrache
-- Source : https://www.wowhead.com/wotlk/de/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Zwielichtreitdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31698;
-- OLD name : Grunzerin Grikee
-- Source : https://www.wowhead.com/wotlk/de/npc=31727
UPDATE `creature_template_locale` SET `Name` = 'Grunzer Grikee',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31727;
-- OLD name : Malygos
-- Source : https://www.wowhead.com/wotlk/de/npc=31734
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31734;
-- OLD name : Nargel Peitschleine, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31863;
-- OLD name : Schrottreifer Verwüster
-- Source : https://www.wowhead.com/wotlk/de/npc=31868
UPDATE `creature_template_locale` SET `Name` = 'Defekter Verwüster',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 31868;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32193;
-- OLD name : Leerenfürst
-- Source : https://www.wowhead.com/wotlk/de/npc=32230
UPDATE `creature_template_locale` SET `Name` = 'Herr der Leere',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32230;
-- OLD name : Verkleideter Kreuzfahrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32241
UPDATE `creature_template_locale` SET `Name` = 'Verkleideter Kreuzzügler',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32241;
-- OLD name : Wachposten der Aldur'thar
-- Source : https://www.wowhead.com/wotlk/de/npc=32292
UPDATE `creature_template_locale` SET `Name` = 'Späher von Aldur''thar',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32292;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32328;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 32339;
-- OLD name : Zokk "Lulatsch" Drillzang
-- Source : https://www.wowhead.com/wotlk/de/npc=32355
UPDATE `creature_template_locale` SET `Name` = 'Bigzokk Drillzang',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32355;
-- OLD name : Kezzik der Meuchler
-- Source : https://www.wowhead.com/wotlk/de/npc=32356
UPDATE `creature_template_locale` SET `Name` = 'Kezzik der Stürmer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32356;
-- OLD name : Argex Eisenmagen, subname : Arenaverkäuferveteran
-- Source : https://www.wowhead.com/wotlk/de/npc=32359
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32359;
-- OLD subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=32379
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Juwelenschleifen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32379;
-- OLD subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=32380
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterveteran für Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32380;
-- OLD subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=32382
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Juwelenschleifen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32382;
-- OLD subname : Rüstmeisterin für Veteranenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=32385
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterveteran für Rüstungen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32385;
-- OLD name : Wahnsinniger Überlebender von Indu'le
-- Source : https://www.wowhead.com/wotlk/de/npc=32409
UPDATE `creature_template_locale` SET `Name` = 'Verrückter Überlebender von Indu''le',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32409;
-- OLD name : Isirami Sanftwind
-- Source : https://www.wowhead.com/wotlk/de/npc=32413
UPDATE `creature_template_locale` SET `Name` = 'Isimari Sanftwind',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32413;
-- OLD subname : Schankkellnerin
-- Source : https://www.wowhead.com/wotlk/de/npc=32415
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32415;
-- OLD subname : Schankkellner
-- Source : https://www.wowhead.com/wotlk/de/npc=32416
UPDATE `creature_template_locale` SET `Title` = 'Barkeeper',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32416;
-- OLD name : Scharlachrote Hochfürstin Daion
-- Source : https://www.wowhead.com/wotlk/de/npc=32417
UPDATE `creature_template_locale` SET `Name` = 'Scharlachroter Hochlord Daion',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32417;
-- OLD subname : Angellehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Angelns',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32474;
-- OLD name : Vollgesogener Seuchenwurm
-- Source : https://www.wowhead.com/wotlk/de/npc=32483
UPDATE `creature_template_locale` SET `Name` = 'Verstopfter Seuchenwurm',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32483;
-- OLD name : Akolyth der Kultisten
-- Source : https://www.wowhead.com/wotlk/de/npc=32507
UPDATE `creature_template_locale` SET `Name` = 'Akolyt der Kultisten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32507;
-- OLD name : Fehlgeschlagenes Experiment
-- Source : https://www.wowhead.com/wotlk/de/npc=32519
UPDATE `creature_template_locale` SET `Name` = 'Gescheitertes Experiment',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32519;
-- OLD name : Trainingsattrappe des Initianden
-- Source : https://www.wowhead.com/wotlk/de/npc=32541
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Initianden',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32541;
-- OLD name : Trainingsattrappe des Jüngers
-- Source : https://www.wowhead.com/wotlk/de/npc=32542
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Jüngers',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32542;
-- OLD name : Trainingsattrappe des Veteranen
-- Source : https://www.wowhead.com/wotlk/de/npc=32543
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Veteranen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32543;
-- OLD name : Trainingsattrappe des Initianden
-- Source : https://www.wowhead.com/wotlk/de/npc=32545
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Initianden',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32545;
-- OLD name : Trainingsattrappe des Schwarzritters
-- Source : https://www.wowhead.com/wotlk/de/npc=32546
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Schwarzritters',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32546;
-- OLD name : Nemesislehrer des Hochlords
-- Source : https://www.wowhead.com/wotlk/de/npc=32547
UPDATE `creature_template_locale` SET `Name` = 'Nemesisattrappe des Hochlords',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32547;
-- OLD name : Blauer Reitprotodrache (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=32585
UPDATE `creature_template_locale` SET `Name` = 'Blauer Protoreitdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32585;
-- OLD name : Bronzefarbener Protodrache (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=32586
UPDATE `creature_template_locale` SET `Name` = 'Bronzefarbener Protoreitdrache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32586;
-- OLD subname : Handelsreisender
-- Source : https://www.wowhead.com/wotlk/de/npc=32638
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32638;
-- OLD subname : Handelsreisende
-- Source : https://www.wowhead.com/wotlk/de/npc=32642
UPDATE `creature_template_locale` SET `Title` = 'Handlungsreisender',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32642;
-- OLD name : Trainingsattrappe der Kriegshymnenfeste
-- Source : https://www.wowhead.com/wotlk/de/npc=32647
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe der Kriegshymnenfeste',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32647;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Experten',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32666;
-- OLD name : Trainingsattrappe
-- Source : https://www.wowhead.com/wotlk/de/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Übungsattrappe des Meisters',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32667;
-- OLD name : Garl Grimmsilber
-- Source : https://www.wowhead.com/wotlk/de/npc=32710
UPDATE `creature_template_locale` SET `Name` = 'Garl Grimgrizzel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32710;
-- OLD name : Erzmagierin Rheaume
-- Source : https://www.wowhead.com/wotlk/de/npc=32740
UPDATE `creature_template_locale` SET `Name` = 'Erzmagier Rheaume',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32740;
-- OLD subname : Todesritterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32753
UPDATE `creature_template_locale` SET `Title` = 'Todesritterausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32753;
-- OLD subname : Druidenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32754
UPDATE `creature_template_locale` SET `Title` = 'Druidenausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32754;
-- OLD subname : Jägerglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32755
UPDATE `creature_template_locale` SET `Title` = 'Jägerausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32755;
-- OLD subname : Magierglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32756
UPDATE `creature_template_locale` SET `Title` = 'Magierausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32756;
-- OLD subname : Paladinglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32757
UPDATE `creature_template_locale` SET `Title` = 'Paladinausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32757;
-- OLD subname : Priesterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32758
UPDATE `creature_template_locale` SET `Title` = 'Priesterausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32758;
-- OLD subname : Schurkenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32759
UPDATE `creature_template_locale` SET `Title` = 'Schurkenausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32759;
-- OLD subname : Schamanenglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32760
UPDATE `creature_template_locale` SET `Title` = 'Schamanenausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32760;
-- OLD subname : Hexenmeisterglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32761
UPDATE `creature_template_locale` SET `Title` = 'Hexenmeisterausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32761;
-- OLD subname : Kriegerglyphen
-- Source : https://www.wowhead.com/wotlk/de/npc=32762
UPDATE `creature_template_locale` SET `Title` = 'Kriegerausrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32762;
-- OLD name : Web Wrap Visual
-- Source : https://www.wowhead.com/wotlk/de/npc=32785
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32785;
-- OLD name : Flammenwächter der Boreanischen Tundra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32801
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter der boreanischen Tundra',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32801;
-- OLD name : Flammenwächter des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32804
UPDATE `creature_template_locale` SET `Name` = 'Flammenwächter des heulenden Fjords',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32804;
-- OLD name : Flammenbewahrer des Heulenden Fjords (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=32812
UPDATE `creature_template_locale` SET `Name` = 'Flammenbewahrer des heulenden Fjords',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32812;
-- OLD name : Fetter Truthahn
-- Source : https://www.wowhead.com/wotlk/de/npc=32818
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32818;
-- OLD name : Plump Turkey Bunny
-- Source : https://www.wowhead.com/wotlk/de/npc=32819
UPDATE `creature_template_locale` SET `Name` = 'Plumper Truthahn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32819;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32886
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32886;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=32957
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 32957;
-- OLD name : Schwelendes Skelett
-- Source : https://www.wowhead.com/wotlk/de/npc=33016
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Skelett',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33016;
-- OLD name : Schwelendes Konstrukt
-- Source : https://www.wowhead.com/wotlk/de/npc=33017
UPDATE `creature_template_locale` SET `Name` = 'Glimmendes Konstrukt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33017;
-- OLD subname : Hochprozentiges
-- Source : https://www.wowhead.com/wotlk/de/npc=33026
UPDATE `creature_template_locale` SET `Title` = 'Alkohol',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33026;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33049;
-- OLD name : Instabiler Sonnenstrahl
-- Source : https://www.wowhead.com/wotlk/de/npc=33050
UPDATE `creature_template_locale` SET `Name` = 'Unstabiler Sonnenstrahl',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33050;
-- OLD name : Dunkler Runenakolyth
-- Source : https://www.wowhead.com/wotlk/de/npc=33110
UPDATE `creature_template_locale` SET `Name` = 'Dunkler Runenakolyt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33110;
-- OLD name : Flüssiges Pyrit
-- Source : https://www.wowhead.com/wotlk/de/npc=33189
UPDATE `creature_template_locale` SET `Name` = 'Flüssiger Pyrit',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33189;
-- OLD name : Klingenschuppe-Spawner
-- Source : https://www.wowhead.com/wotlk/de/npc=33245
UPDATE `creature_template_locale` SET `Name` = 'Klingenschuppen Spawner',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33245;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33252;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33305;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (33351, 'deDE','NPCs',NULL,0);
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33415;
-- OLD name : Falkenschreiter von Silbermond
-- Source : https://www.wowhead.com/wotlk/de/npc=33418
UPDATE `creature_template_locale` SET `Name` = 'Falkenschreiter aus Silbermond',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33418;
-- OLD name : [ph] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33450;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33501;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 33521;
-- OLD name : Neugieriges Gorlocjunges
-- Source : https://www.wowhead.com/wotlk/de/npc=33530
UPDATE `creature_template_locale` SET `Name` = 'Neugieriges Orakeljunges',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33530;
-- OLD subname : Schneiderlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Schneiderei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33580;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Lederverarbeitung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33581;
-- OLD subname : Verzauberkunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Verzauberkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33583;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Ingenieurskunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33586;
-- OLD subname : Kochkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Kochkunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33587;
-- OLD name : Krista Hellfunk, subname : Alchemielehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33588
UPDATE `creature_template_locale` SET `Name` = 'Christa Hellfunk',`Title` = 'Großmeisterin der Alchemie',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33588;
-- OLD subname : Lehrer für Erste Hilfe
-- Source : https://www.wowhead.com/wotlk/de/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Großmeister für Erste Hilfe',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33589;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Großmeister des Juwelenschleifens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33590;
-- OLD subname : Schmiedekunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Großmeisterin der Schmiedekunst',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33591;
-- OLD subname : Juwelierskunstbedarf
-- Source : https://www.wowhead.com/wotlk/de/npc=33602
UPDATE `creature_template_locale` SET `Title` = 'Juweliersbedarf',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33602;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Großmeister der Inschriftenkunde',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33603;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33630;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33631;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33633;
-- OLD subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33634;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33635;
-- OLD subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Schneidermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33636;
-- OLD subname : Juwelierskunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33637
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33637;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33638;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33639;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33640;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33641;
-- OLD subname : Alchemielehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Alchemiemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33674;
-- OLD subname : Schmiedekunstlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Schmiedekunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33675;
-- OLD subname : Verzauberkunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Verzauberkunstmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33676;
-- OLD name : Technikerin Mihila, subname : Ingenieurskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33677
UPDATE `creature_template_locale` SET `Name` = 'Techniker Mihila',`Title` = 'Meisteringenieurslehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33677;
-- OLD subname : Kräuterkundelehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Kräuterkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33678;
-- OLD subname : Inschriftenkundelehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Inschriftenkundemeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33679;
-- OLD subname : Juwelierskunstlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Juwelenschleifermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33680;
-- OLD subname : Lederverarbeitungslehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Lederverarbeitungsmeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33681;
-- OLD subname : Bergbaulehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Bergbaumeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33682;
-- OLD subname : Kürschnerlehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Kürschnermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33683;
-- OLD name : Weberin Aoa, subname : Schneiderlehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=33684
UPDATE `creature_template_locale` SET `Name` = 'Weber Aoa',`Title` = 'Schneidermeisterlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33684;
-- OLD subname : Der Zirkel des Cenarius
-- Source : https://www.wowhead.com/wotlk/de/npc=33788
UPDATE `creature_template_locale` SET `Title` = 'Zirkel des Cenarius',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33788;
-- OLD name : Rubble Stalker Kologarn
-- Source : https://www.wowhead.com/wotlk/de/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Geröllpirscher Kologarn',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33809;
-- OLD name : Mimiron Fokuspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=33835
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33835;
-- OLD name : Streitross der Quel'dorei
-- Source : https://www.wowhead.com/wotlk/de/npc=33840
UPDATE `creature_template_locale` SET `Name` = 'Ross der Quel''dorei',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33840;
-- OLD subname : Emporium des UNGLAUBLICHEN (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=33946
UPDATE `creature_template_locale` SET `Title` = 'Tolles Emporium des UNGLAUBLICHEN',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33946;
-- OLD name : Explodierender Goblinmeißel
-- Source : https://www.wowhead.com/wotlk/de/npc=33958
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33958;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33963;
-- OLD subname : Emblem der Eroberung Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme der Eroberung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33964;
-- OLD subname : Meister des Sturmangriffs
-- Source : https://www.wowhead.com/wotlk/de/npc=33972
UPDATE `creature_template_locale` SET `Title` = 'Meister des Anstürmens',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 33972;
-- OLD name : Zone der Leere
-- Source : https://www.wowhead.com/wotlk/de/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Leerenzone',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34001;
-- OLD subname : Rüstmeisterin für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34043
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Juwelenschleifen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34043;
-- OLD name : Euer Funkgerät erwacht knisternd zum Leben. Bronzebart
-- Source : https://www.wowhead.com/wotlk/de/npc=34054
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34054;
-- OLD subname : Rüstmeister für Juwelierskunst
-- Source : https://www.wowhead.com/wotlk/de/npc=34079
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Juwelenschleifen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34079;
-- OLD name : Eisenfang Rüsti
-- Source : https://www.wowhead.com/wotlk/de/npc=34087
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34087;
-- OLD name : Fokussierter Laser
-- Source : https://www.wowhead.com/wotlk/de/npc=34181
UPDATE `creature_template_locale` SET `Name` = 'Fokuslaser',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34181;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34281;
-- OLD name : Recyclebotsägeblatt
-- Source : https://www.wowhead.com/wotlk/de/npc=34288
UPDATE `creature_template_locale` SET `Name` = 'Recyclebot Sägeblatt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34288;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34319;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34381;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (34533, 'deDE','NPCs',NULL,0);
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34562;
-- OLD name : [DND] Warbot - Blue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34588;
-- OLD name : [DND] Warbot - Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34589;
-- OLD name : Ogerpinata (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=34632
UPDATE `creature_template_locale` SET `Name` = 'Ogerpiñata',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34632;
-- OLD name : Besatzungsmitglied Rohrschlüssel
-- Source : https://www.wowhead.com/wotlk/de/npc=34717
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Rohrschlüssel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34717;
-- OLD name : Besatzungsmitglied Schlossriegel
-- Source : https://www.wowhead.com/wotlk/de/npc=34718
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schlossriegel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34718;
-- OLD name : Besatzungsmitglied Schroter
-- Source : https://www.wowhead.com/wotlk/de/npc=34719
UPDATE `creature_template_locale` SET `Name` = 'Crewmitglied Schroter',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34719;
-- OLD name : [DND] Magic Rooster (Draenei Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34731;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34732;
-- OLD name : Nachtelfischer Kolosseumszuschauer
-- Source : https://www.wowhead.com/wotlk/de/npc=34871
UPDATE `creature_template_locale` SET `Name` = 'Nachelfischer Kolosseumszuschauer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34871;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34893;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 34910;
-- OLD name : Höllische Teufelsflammenkugel (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=34921
UPDATE `creature_template_locale` SET `Name` = 'Teufelsflammenhöllenbestienkugel',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34921;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=34929
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34929;
-- OLD name : Abgesandter der Insel der Eroberung
-- Source : https://www.wowhead.com/wotlk/de/npc=34950
UPDATE `creature_template_locale` SET `Name` = 'Botschafter der Insel der Eroberung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34950;
-- OLD name : Luftschiffkapitän der Allianz
-- Source : https://www.wowhead.com/wotlk/de/npc=34960
UPDATE `creature_template_locale` SET `Name` = 'Kanonenbootkapitän der Allianz',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 34960;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35016;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35066;
-- OLD name : Scharfseher Eannu
-- Source : https://www.wowhead.com/wotlk/de/npc=35073
UPDATE `creature_template_locale` SET `Name` = 'Weitseher Eannu',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35073;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35093;
-- OLD subname : Fluglehrer
-- Source : https://www.wowhead.com/wotlk/de/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35100;
-- OLD name : Assassine des Kults
-- Source : https://www.wowhead.com/wotlk/de/npc=35127
UPDATE `creature_template_locale` SET `Name` = 'Assassin des Kults',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35127;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35133;
-- OLD subname : Fluglehrerin
-- Source : https://www.wowhead.com/wotlk/de/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Reitlehrerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35135;
-- OLD subname : Oberanführer der Kriegshymnenoffensive
-- Source : https://www.wowhead.com/wotlk/de/npc=35372
UPDATE `creature_template_locale` SET `Title` = 'Hochlord der Kriegshymnenoffensive',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35372;
-- OLD name : Elitesoldat der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=35460
UPDATE `creature_template_locale` SET `Name` = 'Elite der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35460;
-- OLD subname : Emblem des Triumph Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35494;
-- OLD subname : Emblem des Triumph Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=35495
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35495;
-- OLD subname : Stoffrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=35496
UPDATE `creature_template_locale` SET `Title` = 'Händler für Stoffrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35496;
-- OLD subname : Lederrüstungshändler
-- Source : https://www.wowhead.com/wotlk/de/npc=35497
UPDATE `creature_template_locale` SET `Title` = 'Händler für Lederrüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35497;
-- OLD subname : Händlerin für Kettenrüstungen
-- Source : https://www.wowhead.com/wotlk/de/npc=35500
UPDATE `creature_template_locale` SET `Title` = 'Händlerin für Schwere Rüstung',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35500;
-- OLD subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35573;
-- OLD subname : Antiquitätenrüstmeisterin für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeisterin für Embleme des Triumphs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 35574;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35608;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 35983;
-- OLD name : Die Schwarze Schankmaid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/de/npc=36024
UPDATE `creature_template_locale` SET `Name` = 'Die schwarze Schankmaid',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36024;
-- OLD name : [DND] Argent Charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36071;
-- OLD name : [DND] Swift Burgundy Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36072;
-- OLD name : [DND] Swift Horde Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36074;
-- OLD name : [DND] White Stallion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36075;
-- OLD name : [DND] Swift Alliance Steed (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36076;
-- OLD name : Häscher der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Häscher der Kro''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36164;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36212;
-- OLD name : Aufseher der Kor'kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36213
UPDATE `creature_template_locale` SET `Name` = 'Wächter von Unterstadt',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36213;
-- OLD name : Aufseher Kraggosh (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36217
UPDATE `creature_template_locale` SET `Name` = 'Verstümmelte Leiche',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36217;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36530;
-- OLD name : Adeptin der Seelenwache
-- Source : https://www.wowhead.com/wotlk/de/npc=36620
UPDATE `creature_template_locale` SET `Name` = 'Adept der Seelenwache',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36620;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36643;
-- OLD name : Schildwache des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36656
UPDATE `creature_template_locale` SET `Name` = 'Schildwache des Silberbundes',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36656;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36710;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36726;
-- OLD name : Agent des Silberbunds
-- Source : https://www.wowhead.com/wotlk/de/npc=36774
UPDATE `creature_template_locale` SET `Name` = 'Agent des Silberbundes',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36774;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (36792, 'deDE','NPCs',NULL,0);
-- OLD name : [DND] Love Boat Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36817;
-- OLD name : Kanone des Allianzluftschiffs
-- Source : https://www.wowhead.com/wotlk/de/npc=36838
UPDATE `creature_template_locale` SET `Name` = 'Kanone des Allianzkanonenboots',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36838;
-- OLD name : Zwergenmagier (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36858
UPDATE `creature_template_locale` SET `Name` = 'Zwergenmagierin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36858;
-- OLD name : Gnomenpriester (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36860
UPDATE `creature_template_locale` SET `Name` = 'Gnomenpriesterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36860;
-- OLD name : Menschlicher Jäger (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36861
UPDATE `creature_template_locale` SET `Name` = 'Menschliche Jägerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36861;
-- OLD name : Orcmagier (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36863
UPDATE `creature_template_locale` SET `Name` = 'Orcmagierin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36863;
-- OLD name : Taurenpriester (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36865
UPDATE `creature_template_locale` SET `Name` = 'Taurenpriesterin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36865;
-- OLD name : Trolldruide (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36866
UPDATE `creature_template_locale` SET `Name` = 'Trolldruidin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36866;
-- OLD name : Untoter Jäger (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36867
UPDATE `creature_template_locale` SET `Name` = 'Untote Jägerin',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 36867;
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (36904, 'deDE','NPCs',NULL,0);
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 36966;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37039;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37128;
-- OLD name : Heckenschütze der Kor'kron
-- Source : https://www.wowhead.com/wotlk/de/npc=37146
UPDATE `creature_template_locale` SET `Name` = 'Scharfschütze der Kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37146;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37168;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37202;
-- OLD name : Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37205
UPDATE `creature_template_locale` SET `Name` = 'Thalorien Dämmersucher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37205;
-- OLD name : Lakai der Manufaktur Krone
-- Source : https://www.wowhead.com/wotlk/de/npc=37214
UPDATE `creature_template_locale` SET `Name` = 'Lakei der Manufaktur Krone',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37214;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37543;
-- OLD name : Überreste von Thalorien Morgensucher
-- Source : https://www.wowhead.com/wotlk/de/npc=37552
UPDATE `creature_template_locale` SET `Name` = 'Überreste von Thalorien Dämmersucher',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37552;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37574;
-- OLD name : Schmiedemeister Garfrost
-- Source : https://www.wowhead.com/wotlk/de/npc=37613
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37613;
-- OLD name : Mutierte Monstrosität
-- Source : https://www.wowhead.com/wotlk/de/npc=37672
UPDATE `creature_template_locale` SET `Name` = 'Mutierte Monströsität',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37672;
-- OLD subname : Rüstmeisterin des Argentumkreuzzugs (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=37693
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister des Argentumkreuzzugs',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37693;
-- OLD name : [TEST] High Overlord Omar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37820;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37831;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37941;
-- OLD subname : Emblem des Frost Rüstmeister
-- Source : https://www.wowhead.com/wotlk/de/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 37942;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 37990;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38053;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38164;
-- OLD name : Große Liebesrakete
-- Source : https://www.wowhead.com/wotlk/de/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Herzbrecher X-45',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38204;
-- OLD name : Große Liebesrakete (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'Herzbrecher X-45',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38207;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38236;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38342;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38581;
-- OLD name : Todesbringer Saurfang
-- Source : https://www.wowhead.com/wotlk/de/npc=38583
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38583;
-- OLD name : Fürstin Sylvanas Windläufer
-- Source : https://www.wowhead.com/wotlk/de/npc=38609
UPDATE `creature_template_locale` SET `Name` = 'Lady Sylvanas Windläufer',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38609;
-- OLD subname : Antiquitätenrüstmeister für Gerechtigkeitspunkte
-- Source : https://www.wowhead.com/wotlk/de/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für Embleme des Frosts',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38858;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 38883;
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39057;
-- OLD name : Marschall Magruder
-- Source : https://www.wowhead.com/wotlk/de/npc=39172
UPDATE `creature_template_locale` SET `Name` = 'Marshall Magruder',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 39172;
-- OLD name : Mechanopanzerpilot aus Gnomeregan (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=39230
UPDATE `creature_template_locale` SET `Name` = 'Mechanopanzerpilot von Gnomeregan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 39230;
-- OLD name : Geretterter Flüchtling aus Gnomeregan (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=39265
UPDATE `creature_template_locale` SET `Name` = 'Geretteter Flüchtling aus Gnomeregan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 39265;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39362;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39420;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39683;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39707;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39744;
-- OLD name : [DND] Summoning Pad (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39817;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 39841;
-- OLD name : Mechanopanzer aus Gnomeregan (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=39860
UPDATE `creature_template_locale` SET `Name` = 'Mechanopanzer von Gnomeregan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 39860;
-- OLD name : Mechanopanzer aus Gnomeregan (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=40120
UPDATE `creature_template_locale` SET `Name` = 'Mechanopanzer von Gnomeregan',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 40120;
-- OLD name : Eisenfang Rüsti, subname : Überholte Arenawaffen
-- Source : https://www.wowhead.com/wotlk/de/npc=40212
UPDATE `creature_template_locale` SET `Name` = 'Eisenfang Rix',`Title` = 'Außergewöhnliche Arenawaffen',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 40212;
-- OLD subname : Überholte Arenawaffen (RETAIL DATAS)
-- Source : https://www.wowhead.com/de/npc=40216
UPDATE `creature_template_locale` SET `Title` = 'Rüstmeister für boshafte Gladiatoren',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 40216;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40265;
-- OLD name : Blauer Aufziehraketenbot
-- Source : https://www.wowhead.com/wotlk/de/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Uhrwerkraketenbot',`VerifiedBuild` = 0 WHERE `locale` = 'deDE' AND `entry` = 40295;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40428;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 40617;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/de/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'deDE' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,444,6783,17733,18674,23715,23808,24109,24181,24331,24377,24378,24380,26080,26376,26486,26594,26671,26842,27231,27527,27632,27862,28501,28652,28678,28679,29039,29749,29930,30426,30427,30428,30888,31060,31143,31168,31696,32585,32586,33351,33946,34533,34632,34921,36213,36217,36792,36858,36860,36861,36863,36865,36866,36867,36904,37693,38207,38883,39230,39265,39860,40120,40216
-- END
