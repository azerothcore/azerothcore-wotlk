-- OLD name : Nervi de pacotille
-- Source : https://www.wowhead.com/wotlk/fr/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Nervi défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38;
-- OLD name : Le forgeron Ed le Méchant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=55
UPDATE `creature_template_locale` SET `Name` = 'Le forgeron Ed le méchant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 55;
-- OLD name : Gug Grosse-Bougie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=62
UPDATE `creature_template_locale` SET `Name` = 'Gug Grosse-bougie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 62;
-- OLD name : Garde de Hurlevent
-- Source : https://www.wowhead.com/wotlk/fr/npc=68
UPDATE `creature_template_locale` SET `Name` = 'Guet de Hurlevent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 68;
-- OLD name : [TEST] Level 20 Unkillable Test Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=72
UPDATE `creature_template_locale` SET `Name` = 'Level 20 Unkillable Test Dummy',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 72;
-- OLD name : [INUTILISÉ] Luglar le Sabotier (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Holiday - Halloween - Garrison - Spectral Alemental',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 81;
-- OLD name : Vide-gousset
-- Source : https://www.wowhead.com/wotlk/fr/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Vide-gousset défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 94;
-- OLD name : Sous-chef rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=98
UPDATE `creature_template_locale` SET `Name` = 'Sous-chef Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 98;
-- OLD name : Drake bronze
-- Source : https://www.wowhead.com/wotlk/fr/npc=102
UPDATE `creature_template_locale` SET `Name` = 'Draconide bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 102;
-- OLD name : Bête kodo
-- Source : https://www.wowhead.com/wotlk/fr/npc=106
UPDATE `creature_template_locale` SET `Name` = 'Kodo',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 106;
-- OLD name : Sanglier brocheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=113
UPDATE `creature_template_locale` SET `Name` = 'Sanglier Brocheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 113;
-- OLD name : Bandit
-- Source : https://www.wowhead.com/wotlk/fr/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandit défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 116;
-- OLD name : Gnoll rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=117
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 117;
-- OLD name : Bâtard rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=123
UPDATE `creature_template_locale` SET `Name` = 'Bâtard Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 123;
-- OLD name : Brute rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=124
UPDATE `creature_template_locale` SET `Name` = 'Brute Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 124;
-- OLD name : Surveillant rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=125
UPDATE `creature_template_locale` SET `Name` = 'Surveillant Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 125;
-- OLD name : Squelette os-vermoulus (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=201
UPDATE `creature_template_locale` SET `Name` = 'Squelette Os-vermoulus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 201;
-- OLD name : Horreur pourrissante
-- Source : https://www.wowhead.com/wotlk/fr/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Squelette infernal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 202;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/fr/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (230, 'frFR','Thornton Boichu','Charpentier',0);
-- OLD name : Maréchal Gryan Roidemantel, subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Roidemantel',`Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 234;
-- OLD name : [DND] Fantassin du Lion blessé
-- Source : https://www.wowhead.com/wotlk/fr/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Un corps à moitié dévoré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 262;
-- OLD name : Jeune loup
-- Source : https://www.wowhead.com/wotlk/fr/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Jeune loup malade',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 299;
-- OLD name : Etalon blanc
-- Source : https://www.wowhead.com/wotlk/fr/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Cheval (étalon blanc)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 305;
-- OLD name : Palomino
-- Source : https://www.wowhead.com/wotlk/fr/npc=306
UPDATE `creature_template_locale` SET `Name` = 'Cheval (palomino)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 306;
-- OLD name : Véhicule « enterré à l’envers »
-- Source : https://www.wowhead.com/wotlk/fr/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Cadavre de Rolf',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 309;
-- OLD subname : Fiancée de l'Embaumeur
-- Source : https://www.wowhead.com/wotlk/fr/npc=314
UPDATE `creature_template_locale` SET `Title` = 'La fiancée de l''Embaumeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 314;
-- OLD name : Loup blanc
-- Source : https://www.wowhead.com/wotlk/fr/npc=359
UPDATE `creature_template_locale` SET `Name` = 'Loup (blanc)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 359;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/fr/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Serveuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 379;
-- OLD subname : Eleveuse de chevaux
-- Source : https://www.wowhead.com/wotlk/fr/npc=384
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 384;
-- OLD name : Vieux Troublœil
-- Source : https://www.wowhead.com/wotlk/fr/npc=391
UPDATE `creature_template_locale` SET `Name` = 'Vieux Troubloeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 391;
-- OLD name : Tisseur d'ombre sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=429
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''ombre Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 429;
-- OLD name : Pourfendeur sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=431
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeur Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 431;
-- OLD name : Brute sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=432
UPDATE `creature_template_locale` SET `Name` = 'Brute Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 432;
-- OLD name : Gnoll sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=433
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 433;
-- OLD name : Gnoll sombrepoil enragé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=434
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Sombrepoil enragé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 434;
-- OLD name : Champion rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=435
UPDATE `creature_template_locale` SET `Name` = 'Champion Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 435;
-- OLD name : Exhalombre rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=436
UPDATE `creature_template_locale` SET `Name` = 'Exhalombre Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 436;
-- OLD name : Renégat rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=437
UPDATE `creature_template_locale` SET `Name` = 'Renégat Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 437;
-- OLD name : Grunt rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=440
UPDATE `creature_template_locale` SET `Name` = 'Grunt Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 440;
-- OLD name : Poupon (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Seigneur Porcinet',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 444;
-- OLD name : Bandit rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=452
UPDATE `creature_template_locale` SET `Name` = 'Bandit Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 452;
-- OLD name : Mystique rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=453
UPDATE `creature_template_locale` SET `Name` = 'Mystique Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 453;
-- OLD name : Capitaine de la garde Parker
-- Source : https://www.wowhead.com/wotlk/fr/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Garde Parker',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 464;
-- OLD name : Morgan le Collecteur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=473
UPDATE `creature_template_locale` SET `Name` = 'Morgan le collecteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 473;
-- OLD name : Sorcier voleur
-- Source : https://www.wowhead.com/wotlk/fr/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Sorcier-voleur défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 474;
-- OLD name : Estafette rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=478
UPDATE `creature_template_locale` SET `Name` = 'Estafette Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 478;
-- OLD name : Estafette rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=485
UPDATE `creature_template_locale` SET `Name` = 'Estafette Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 485;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=487
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 487;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=488
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 488;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=489
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 489;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=490
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 490;
-- OLD name : Eclaireur rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=500
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 500;
-- OLD name : Herboriste rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=501
UPDATE `creature_template_locale` SET `Name` = 'Herboriste Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 501;
-- OLD name : Elémentaire d’eau
-- Source : https://www.wowhead.com/wotlk/fr/npc=510
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 510;
-- OLD subname : Maître des écuries
-- Source : https://www.wowhead.com/wotlk/fr/npc=543
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 543;
-- OLD name : Guerrier sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=568
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 568;
-- OLD name : Faucheur 4000
-- Source : https://www.wowhead.com/wotlk/fr/npc=573
UPDATE `creature_template_locale` SET `Name` = 'Découpeur 4000',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 573;
-- OLD name : Assassin sombrepoil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=579
UPDATE `creature_template_locale` SET `Name` = 'Assassin Sombrepoil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 579;
-- OLD name : Embusqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Embusqué défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 583;
-- OLD name : [INUTILISÉ] Capo le mauvais
-- Source : https://www.wowhead.com/wotlk/fr/npc=601
UPDATE `creature_template_locale` SET `Name` = 'Capo le mauvais',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 601;
-- OLD name : Pisteur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=615
UPDATE `creature_template_locale` SET `Name` = 'Pisteur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 615;
-- OLD subname : Le second du navire
-- Source : https://www.wowhead.com/wotlk/fr/npc=646
UPDATE `creature_template_locale` SET `Title` = 'Le premier officier du navire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 646;
-- OLD name : Chasseur d’esprit casse-crâne
-- Source : https://www.wowhead.com/wotlk/fr/npc=672
UPDATE `creature_template_locale` SET `Name` = 'Chasseur d''esprit Casse-crâne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 672;
-- OLD name : Marteleur mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=678
UPDATE `creature_template_locale` SET `Name` = 'Marteleur mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 678;
-- OLD name : Chaman mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=679
UPDATE `creature_template_locale` SET `Name` = 'Chaman mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 679;
-- OLD name : Seigneur mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=680
UPDATE `creature_template_locale` SET `Name` = 'Seigneur mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 680;
-- OLD name : Panthère ombregueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=684
UPDATE `creature_template_locale` SET `Name` = 'Panthère Ombregueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 684;
-- OLD name : Elémentaire d’eau inférieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=691
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau inférieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 691;
-- OLD name : Mots écrits, subname : Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=693
UPDATE `creature_template_locale` SET `Name` = 'Maître de compétence secondaire',`Title` = 'Maître',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 693;
-- OLD name : Panthère scalp-rouge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=700
UPDATE `creature_template_locale` SET `Name` = 'Panthère Scalp-rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 700;
-- OLD name : Général Tripecroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Lieutenant Tripecroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 703;
-- OLD name : Jeune troll crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=706
UPDATE `creature_template_locale` SET `Name` = 'Jeune troll Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 706;
-- OLD name : Trogg mâcheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=707
UPDATE `creature_template_locale` SET `Name` = 'Trogg Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 707;
-- OLD name : Combattant mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=709
UPDATE `creature_template_locale` SET `Name` = 'Combattant mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 709;
-- OLD name : Magicien mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=710
UPDATE `creature_template_locale` SET `Name` = 'Magicien mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 710;
-- OLD name : Balir Martel-de-Givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=713
UPDATE `creature_template_locale` SET `Name` = 'Balir Martel-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 713;
-- OLD name : Talin Oeil-Perçant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=714
UPDATE `creature_template_locale` SET `Name` = 'Talin Oeil-perçant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 714;
-- OLD name : Boucher mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=723
UPDATE `creature_template_locale` SET `Name` = 'Boucher mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 723;
-- OLD name : Trogg mâcheroc mastoc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=724
UPDATE `creature_template_locale` SET `Name` = 'Trogg Mâcheroc mastoc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 724;
-- OLD name : Tigre casse-crâne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=758
UPDATE `creature_template_locale` SET `Name` = 'Tigre Casse-crâne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 758;
-- OLD name : Serviteur d’Ilgalar
-- Source : https://www.wowhead.com/wotlk/fr/npc=819
UPDATE `creature_template_locale` SET `Name` = 'Serviteur d''Ilgalar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 819;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=820
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 820;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=821
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 821;
-- OLD name : Sergent Willem
-- Source : https://www.wowhead.com/wotlk/fr/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Adjoint Willem',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 823;
-- OLD name : Cyclone délié
-- Source : https://www.wowhead.com/wotlk/fr/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Diable de poussière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 832;
-- OLD subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/fr/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (841, 'frFR',NULL,'Fournitures de charpentier',0);
-- OLD name : Jeune traqueur de la jungle (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=854
UPDATE `creature_template_locale` SET `Name` = 'Jeune Traqueur de la jungle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 854;
-- OLD subname : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=857
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 857;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=869
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 869;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=870
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 870;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=874
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 874;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=876
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 876;
-- OLD subname : Brigade de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=878
UPDATE `creature_template_locale` SET `Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 878;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=904
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 904;
-- OLD subname : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=907
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 907;
-- OLD name : Osborne l'Oiseau de nuit
-- Source : https://www.wowhead.com/wotlk/fr/npc=918
UPDATE `creature_template_locale` SET `Name` = 'Osborne l''homme de la nuit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 918;
-- OLD name : Jeune ravageur noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=923
UPDATE `creature_template_locale` SET `Name` = 'Jeune Ravageur noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 923;
-- OLD name : Homme-médecine de Kurzen
-- Source : https://www.wowhead.com/wotlk/fr/npc=940
UPDATE `creature_template_locale` SET `Name` = 'Guérisseur de Kurzen',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 940;
-- OLD name : Novice crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=946
UPDATE `creature_template_locale` SET `Name` = 'Novice Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 946;
-- OLD subname : Librarian
-- Source : https://www.wowhead.com/wotlk/fr/npc=951
UPDATE `creature_template_locale` SET `Title` = 'Bibliothécaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 951;
-- OLD name : Eric Dodds troisième du nom
-- Source : https://www.wowhead.com/wotlk/fr/npc=996
UPDATE `creature_template_locale` SET `Name` = 'Maître Tailleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 996;
-- OLD name : Mannequin de test intuable, subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=1000
UPDATE `creature_template_locale` SET `Name` = 'Gardien Blomberg',`Title` = 'Les Veilleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1000;
-- OLD name : Gnoll poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1007
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1007;
-- OLD name : Bâtard poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1008
UPDATE `creature_template_locale` SET `Name` = 'Bâtard Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1008;
-- OLD name : Tisseur de brumes poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1009
UPDATE `creature_template_locale` SET `Name` = 'Tisseur de brumes Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1009;
-- OLD name : Paludier poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1010
UPDATE `creature_template_locale` SET `Name` = 'Paludier Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1010;
-- OLD name : Trappeur poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1011
UPDATE `creature_template_locale` SET `Name` = 'Trappeur Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1011;
-- OLD name : Mystique poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1013
UPDATE `creature_template_locale` SET `Name` = 'Mystique Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1013;
-- OLD name : Alpha poil-moussu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1014
UPDATE `creature_template_locale` SET `Name` = 'Alpha Poil-moussu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1014;
-- OLD name : Murloc branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1024
UPDATE `creature_template_locale` SET `Name` = 'Murloc Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1024;
-- OLD name : Bondisseur branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1025
UPDATE `creature_template_locale` SET `Name` = 'Bondisseur Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1025;
-- OLD name : Fourrageur branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1026
UPDATE `creature_template_locale` SET `Name` = 'Fourrageur Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1026;
-- OLD name : Guerrier branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1027
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1027;
-- OLD name : Marche-boue branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1028
UPDATE `creature_template_locale` SET `Name` = 'Marche-boue Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1028;
-- OLD name : Oracle branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1029
UPDATE `creature_template_locale` SET `Name` = 'Oracle Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1029;
-- OLD name : Ecumeur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1034
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1034;
-- OLD name : Arpenteur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1035
UPDATE `creature_template_locale` SET `Name` = 'Arpenteur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1035;
-- OLD name : Centurion gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1036
UPDATE `creature_template_locale` SET `Name` = 'Centurion Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1036;
-- OLD name : Maître de guerre gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1037
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1037;
-- OLD name : Veilleur des ombres gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1038
UPDATE `creature_template_locale` SET `Name` = 'Veilleur des ombres Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1038;
-- OLD name : Nain sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1051
UPDATE `creature_template_locale` SET `Name` = 'Nain Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1051;
-- OLD name : Saboteur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1052
UPDATE `creature_template_locale` SET `Name` = 'Saboteur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1052;
-- OLD name : Tunnelier sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1053
UPDATE `creature_template_locale` SET `Name` = 'Tunnelier Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1053;
-- OLD name : Démolisseur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1054
UPDATE `creature_template_locale` SET `Name` = 'Démolisseur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1054;
-- OLD name : Sentinelle d’émeraude
-- Source : https://www.wowhead.com/wotlk/fr/npc=1056
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle d''émeraude',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1056;
-- OLD name : Gardien gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1057
UPDATE `creature_template_locale` SET `Name` = 'Gardien Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1057;
-- OLD subname : Chef des Casse-crânes
-- Source : https://www.wowhead.com/wotlk/fr/npc=1059
UPDATE `creature_template_locale` SET `Title` = 'Chef des Casse-crâne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1059;
-- OLD subname : Féticheur du clan casse-crâne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1060
UPDATE `creature_template_locale` SET `Title` = 'Féticheur du clan Casse-crâne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1060;
-- OLD name : Chaman rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1065
UPDATE `creature_template_locale` SET `Name` = 'Chaman Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1065;
-- OLD name : Charognard rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1067
UPDATE `creature_template_locale` SET `Name` = 'Charognard Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1067;
-- OLD name : Crocilisque dents-de-scie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1082
UPDATE `creature_template_locale` SET `Name` = 'Crocilisque Dents-de-scie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1082;
-- OLD name : Jeune crocilisque dents-de-scie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1084
UPDATE `creature_template_locale` SET `Name` = 'Jeune crocilisque Dents-de-scie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1084;
-- OLD name : Mordeur dents-de-scie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1087
UPDATE `creature_template_locale` SET `Name` = 'Mordeur Dents-de-scie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1087;
-- OLD name : Jern Casque-à-Cornes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1105
UPDATE `creature_template_locale` SET `Name` = 'Jern Casque-à-cornes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1105;
-- OLD name : Brise-crâne mâcheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1115
UPDATE `creature_template_locale` SET `Name` = 'Brise-crâne Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1115;
-- OLD name : Embusqué mâcheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1116
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1116;
-- OLD name : Briseur d’os mâcheroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=1117
UPDATE `creature_template_locale` SET `Name` = 'Briseur d''os Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1117;
-- OLD name : Brise-dos mâcheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1118
UPDATE `creature_template_locale` SET `Name` = 'Brise-dos Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1118;
-- OLD name : Troll crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1120
UPDATE `creature_template_locale` SET `Name` = 'Troll Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1120;
-- OLD name : Marche-neige crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1121
UPDATE `creature_template_locale` SET `Name` = 'Marche-neige Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1121;
-- OLD name : Ecorcheur crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1122
UPDATE `creature_template_locale` SET `Name` = 'Ecorcheur Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1122;
-- OLD name : Chasseur de têtes crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1123
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de têtes Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1123;
-- OLD name : Exhalombre crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1124
UPDATE `creature_template_locale` SET `Name` = 'Exhalombre Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1124;
-- OLD name : Brute mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1142
UPDATE `creature_template_locale` SET `Name` = 'Brute mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1142;
-- OLD name : Féticheur mosh'Ogg (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1144
UPDATE `creature_template_locale` SET `Name` = 'Féticheur mosh''ogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1144;
-- OLD name : Crocilisque gueule-d'acier
-- Source : https://www.wowhead.com/wotlk/fr/npc=1152
UPDATE `creature_template_locale` SET `Name` = 'Crocilisque gueule d''acier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1152;
-- OLD name : Briseur d’os Brisepierre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1164
UPDATE `creature_template_locale` SET `Name` = 'Briseur d''os Brisepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1164;
-- OLD name : Insurgé sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1169
UPDATE `creature_template_locale` SET `Name` = 'Insurgé Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1169;
-- OLD name : Partisan sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1171
UPDATE `creature_template_locale` SET `Name` = 'Partisan Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1171;
-- OLD name : Rat des tunnels vermine
-- Source : https://www.wowhead.com/wotlk/fr/npc=1172
UPDATE `creature_template_locale` SET `Name` = 'Vermine Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1172;
-- OLD name : Rat des tunnels éclaireur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1173
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1173;
-- OLD name : Rat des tunnels géomancien
-- Source : https://www.wowhead.com/wotlk/fr/npc=1174
UPDATE `creature_template_locale` SET `Name` = 'Géomancien Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1174;
-- OLD name : Rat des tunnels terrassier
-- Source : https://www.wowhead.com/wotlk/fr/npc=1175
UPDATE `creature_template_locale` SET `Name` = 'Terrassier Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1175;
-- OLD name : Rat des tunnels fourrageur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1176
UPDATE `creature_template_locale` SET `Name` = 'Fourrageur Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1176;
-- OLD name : Rat des tunnels géomètre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1177
UPDATE `creature_template_locale` SET `Name` = 'Géomètre Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1177;
-- OLD name : Ogre mo'grosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1178
UPDATE `creature_template_locale` SET `Name` = 'Ogre Mo''grosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1178;
-- OLD name : Massacreur mo'grosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1179
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Mo''grosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1179;
-- OLD name : Brute mo'grosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1180
UPDATE `creature_template_locale` SET `Name` = 'Brute Mo''grosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1180;
-- OLD name : Chaman mo'grosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1181
UPDATE `creature_template_locale` SET `Name` = 'Chaman Mo''grosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1181;
-- OLD name : Mystique mo'grosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1183
UPDATE `creature_template_locale` SET `Name` = 'Mystique Mo''grosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1183;
-- OLD name : Ours noir
-- Source : https://www.wowhead.com/wotlk/fr/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Ancien ours noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1186;
-- OLD name : Rat des tunnels kobold
-- Source : https://www.wowhead.com/wotlk/fr/npc=1202
UPDATE `creature_template_locale` SET `Name` = 'Kobold Rat des tunnels',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1202;
-- OLD name : Sapeur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1222
UPDATE `creature_template_locale` SET `Name` = 'Sapeur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1222;
-- OLD name : Jeune battrodon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1224
UPDATE `creature_template_locale` SET `Name` = 'Jeune Battrodon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1224;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=1243
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1243;
-- OLD name : Rethiel le Gardien vert
-- Source : https://www.wowhead.com/wotlk/fr/npc=1244
UPDATE `creature_template_locale` SET `Name` = 'Rethiel le Gouverneur vert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1244;
-- OLD subname : Eleveur de béliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=1261
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de béliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1261;
-- OLD name : Bélier blanc X
-- Source : https://www.wowhead.com/wotlk/fr/npc=1262
UPDATE `creature_template_locale` SET `Name` = 'Bélier blanc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1262;
-- OLD subname : Marchand d'arcs
-- Source : https://www.wowhead.com/wotlk/fr/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Marchand d''arcs et de flèches',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1298;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=1303
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1303;
-- OLD subname : Marchand de feux d’artifice
-- Source : https://www.wowhead.com/wotlk/fr/npc=1304
UPDATE `creature_template_locale` SET `Title` = 'Marchand de feux d''artifice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1304;
-- OLD subname : Marchande de robes
-- Source : https://www.wowhead.com/wotlk/fr/npc=1309
UPDATE `creature_template_locale` SET `Title` = 'Marchand de robes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1309;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1318
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1318;
-- OLD name : Montagnard Foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1343
UPDATE `creature_template_locale` SET `Name` = 'Montagnard foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1343;
-- OLD subname : Marchande de robes
-- Source : https://www.wowhead.com/wotlk/fr/npc=1350
UPDATE `creature_template_locale` SET `Title` = 'Marchand de robes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1350;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Excellent cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1382;
-- OLD name : Prophète crins-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1397
UPDATE `creature_template_locale` SET `Name` = 'Prophète Crins-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1397;
-- OLD name : Moorah Sabot-Tempête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1409
UPDATE `creature_template_locale` SET `Name` = 'Moorah Sabot-tempête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1409;
-- OLD name : Ecumeur branchie-bleue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1418
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Branchie-bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1418;
-- OLD name : Mineur rivepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1426
UPDATE `creature_template_locale` SET `Name` = 'Mineur Rivepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1426;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1430;
-- OLD subname : Fournitures générales & d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1448
UPDATE `creature_template_locale` SET `Title` = 'Fournitures générales & d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1448;
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/fr/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (1455, 'frFR',NULL,'Fournitures pour archers',0);
-- OLD subname : Eleveur de chevaux
-- Source : https://www.wowhead.com/wotlk/fr/npc=1460
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1460;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=1461
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1461;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=1469
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1469;
-- OLD name : Zombie de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=1488
UPDATE `creature_template_locale` SET `Name` = 'Zombie zanzil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1488;
-- OLD name : Chasseur de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=1489
UPDATE `creature_template_locale` SET `Name` = 'Chasseur zanzil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1489;
-- OLD name : Féticheur de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=1490
UPDATE `creature_template_locale` SET `Name` = 'Féticheur zanzil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1490;
-- OLD name : Naga de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=1491
UPDATE `creature_template_locale` SET `Name` = 'Naga zanzil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1491;
-- OLD name : Jeune tisse-nuit (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1504
UPDATE `creature_template_locale` SET `Name` = 'Jeune Tisse-nuit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1504;
-- OLD name : Araignée tisse-nuit (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1505
UPDATE `creature_template_locale` SET `Name` = 'Araignée Tisse-nuit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1505;
-- OLD name : Chauve-souris de la pénombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1512
UPDATE `creature_template_locale` SET `Name` = 'Chauve-souris du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1512;
-- OLD name : Chauve-souris de la pénombre galeuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=1513
UPDATE `creature_template_locale` SET `Name` = 'Chauve-souris du crépuscule galeuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1513;
-- OLD name : Ossomancien sombrœil
-- Source : https://www.wowhead.com/wotlk/fr/npc=1522
UPDATE `creature_template_locale` SET `Name` = 'Ossomancien Sombroeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1522;
-- OLD name : Soldat squelette (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1523
UPDATE `creature_template_locale` SET `Name` = 'Soldat Squelette',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1523;
-- OLD name : Mort efflanqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=1527
UPDATE `creature_template_locale` SET `Name` = 'Mort affamé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1527;
-- OLD name : Grande chauve-souris de la pénombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1553
UPDATE `creature_template_locale` SET `Name` = 'Grande chauve-souris du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1553;
-- OLD name : Chauve-souris de la pénombre vampirique
-- Source : https://www.wowhead.com/wotlk/fr/npc=1554
UPDATE `creature_template_locale` SET `Name` = 'Chauve-souris du crépuscule vampirique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1554;
-- OLD name : Patriarche dos-argenté
-- Source : https://www.wowhead.com/wotlk/fr/npc=1558
UPDATE `creature_template_locale` SET `Name` = 'Patriarche Dos argenté',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1558;
-- OLD name : Voleur test de Slim
-- Source : https://www.wowhead.com/wotlk/fr/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1601;
-- OLD name : Garde de Comté-du-Nord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1642
UPDATE `creature_template_locale` SET `Name` = 'Garde de Comté-du-nord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1642;
-- OLD name : Gnoll poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1674
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1674;
-- OLD name : Bâtard poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1675
UPDATE `creature_template_locale` SET `Name` = 'Bâtard Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1675;
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/fr/npc=1677
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1677;
-- OLD name : Yanni Rudecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1682
UPDATE `creature_template_locale` SET `Name` = 'Yanni Rudecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1682;
-- OLD subname : Fabricante d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=1686
UPDATE `creature_template_locale` SET `Title` = 'Fabricante d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1686;
-- OLD name : Matriarche tisse-nuit (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1688
UPDATE `creature_template_locale` SET `Name` = 'Matriarche Tisse-nuit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1688;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=1694
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1694;
-- OLD name : Prisonnier
-- Source : https://www.wowhead.com/wotlk/fr/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Prisonnier défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1706;
-- OLD name : Détenu
-- Source : https://www.wowhead.com/wotlk/fr/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Détenu défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1711;
-- OLD name : Ancienne panthère ombregueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1713
UPDATE `creature_template_locale` SET `Name` = 'Ancienne panthère Ombregueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1713;
-- OLD name : Insurgé
-- Source : https://www.wowhead.com/wotlk/fr/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Insurgé défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1715;
-- OLD name : Ecumeur mâcheroc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1718
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Mâcheroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1718;
-- OLD name : Bruegal Poing-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1720
UPDATE `creature_template_locale` SET `Name` = 'Bruegal Poing-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1720;
-- OLD name : Oeil-de-ver
-- Source : https://www.wowhead.com/wotlk/fr/npc=1753
UPDATE `creature_template_locale` SET `Name` = 'Œil-de-ver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1753;
-- OLD name : Worg enragé
-- Source : https://www.wowhead.com/wotlk/fr/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Worg chamarré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1766;
-- OLD name : Coureur des champs poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1772
UPDATE `creature_template_locale` SET `Name` = 'Coureur des champs Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1772;
-- OLD name : Mystique poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1773
UPDATE `creature_template_locale` SET `Name` = 'Mystique Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1773;
-- OLD name : Traqueuse Toile-grouillante
-- Source : https://www.wowhead.com/wotlk/fr/npc=1780
UPDATE `creature_template_locale` SET `Name` = 'Traqueuse des mousses',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1780;
-- OLD name : Rôdeuse Toile-grouillante
-- Source : https://www.wowhead.com/wotlk/fr/npc=1781
UPDATE `creature_template_locale` SET `Name` = 'Rampant des brumes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1781;
-- OLD name : Goule pourrissante
-- Source : https://www.wowhead.com/wotlk/fr/npc=1793
UPDATE `creature_template_locale` SET `Name` = 'Goule purulente',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1793;
-- OLD name : Ours géant enragé
-- Source : https://www.wowhead.com/wotlk/fr/npc=1797
UPDATE `creature_template_locale` SET `Name` = 'Vieil ours géant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1797;
-- OLD name : Horreur putréfiée
-- Source : https://www.wowhead.com/wotlk/fr/npc=1813
UPDATE `creature_template_locale` SET `Name` = 'Horreur décomposée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1813;
-- OLD name : Interrogateur écarlate
-- Source : https://www.wowhead.com/wotlk/fr/npc=1838
UPDATE `creature_template_locale` SET `Name` = 'Inquisiteur écarlate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1838;
-- OLD name : Garde d’Eliza
-- Source : https://www.wowhead.com/wotlk/fr/npc=1871
UPDATE `creature_template_locale` SET `Name` = 'Garde d''Eliza',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1871;
-- OLD name : Guetteur de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Guetteur de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1888;
-- OLD name : Magémoniste de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Sorcier de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1889;
-- OLD name : Squelette cliquethorax (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1890
UPDATE `creature_template_locale` SET `Name` = 'Squelette Cliquethorax',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1890;
-- OLD name : Factionnaire Ragelune
-- Source : https://www.wowhead.com/wotlk/fr/npc=1893
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Ragelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1893;
-- OLD name : Factionnaire de Bois-du-Bûcher
-- Source : https://www.wowhead.com/wotlk/fr/npc=1894
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle de Bois-du-Bûcher',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1894;
-- OLD name : Protecteur de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1912
UPDATE `creature_template_locale` SET `Name` = 'Protecteur de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1912;
-- OLD name : Garde de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1913
UPDATE `creature_template_locale` SET `Name` = 'Garde de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1913;
-- OLD name : Magistère de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1914
UPDATE `creature_template_locale` SET `Name` = 'Mage de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1914;
-- OLD name : Conjurateur de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1915
UPDATE `creature_template_locale` SET `Name` = 'Conjurateur de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1915;
-- OLD name : Copiste de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1920
UPDATE `creature_template_locale` SET `Name` = 'Copiste de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1920;
-- OLD subname : Insensible à la Glace
-- Source : https://www.wowhead.com/wotlk/fr/npc=1926
UPDATE `creature_template_locale` SET `Title` = 'Insensible au Givre.',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1926;
-- OLD subname : Insensible aux Ténèbres
-- Source : https://www.wowhead.com/wotlk/fr/npc=1928
UPDATE `creature_template_locale` SET `Title` = 'Insensible à l''Ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1928;
-- OLD name : Avare de terre
-- Source : https://www.wowhead.com/wotlk/fr/npc=1929
UPDATE `creature_template_locale` SET `Name` = 'Miser de terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1929;
-- OLD name : Avare d'acier
-- Source : https://www.wowhead.com/wotlk/fr/npc=1930
UPDATE `creature_template_locale` SET `Name` = 'Miser de fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1930;
-- OLD name : Brute poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1939
UPDATE `creature_template_locale` SET `Name` = 'Brute Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1939;
-- OLD name : Pestilentiel poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1940
UPDATE `creature_template_locale` SET `Name` = 'Pestilentiel Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1940;
-- OLD name : Profanateur poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1941
UPDATE `creature_template_locale` SET `Name` = 'Profanateur Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1941;
-- OLD name : Sauvage poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1942
UPDATE `creature_template_locale` SET `Name` = 'Sauvage Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1942;
-- OLD name : Déchaîné poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1943
UPDATE `creature_template_locale` SET `Name` = 'Déchaîné Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1943;
-- OLD name : Cogneur poil-putride (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1944
UPDATE `creature_template_locale` SET `Name` = 'Cogneur Poil-Putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1944;
-- OLD name : Serviteur d’’Azora
-- Source : https://www.wowhead.com/wotlk/fr/npc=1949
UPDATE `creature_template_locale` SET `Name` = 'Serviteur d''Azora',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1949;
-- OLD name : Embusqué sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=1981
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 1981;
-- OLD name : Ursa pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2006
UPDATE `creature_template_locale` SET `Name` = 'Ursa Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2006;
-- OLD name : Jardinier pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2007
UPDATE `creature_template_locale` SET `Name` = 'Jardinier Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2007;
-- OLD name : Guerrier pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2008
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2008;
-- OLD name : Chaman pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2009
UPDATE `creature_template_locale` SET `Name` = 'Chaman Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2009;
-- OLD name : Défenseur pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2010
UPDATE `creature_template_locale` SET `Name` = 'Défenseur Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2010;
-- OLD name : Augure pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2011
UPDATE `creature_template_locale` SET `Name` = 'Augure Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2011;
-- OLD name : Guide pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2012
UPDATE `creature_template_locale` SET `Name` = 'Guide Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2012;
-- OLD name : Vengeur pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2013
UPDATE `creature_template_locale` SET `Name` = 'Vengeur Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2013;
-- OLD name : Totémique pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2014
UPDATE `creature_template_locale` SET `Name` = 'Totémique Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2014;
-- OLD name : Esprit chagrin
-- Source : https://www.wowhead.com/wotlk/fr/npc=2044
UPDATE `creature_template_locale` SET `Name` = 'Esprit lugubre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2044;
-- OLD name : Ilthalaine
-- Source : https://www.wowhead.com/wotlk/fr/npc=2079
UPDATE `creature_template_locale` SET `Name` = 'Conservateur Ilthalaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2079;
-- OLD name : Grunt gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2102
UPDATE `creature_template_locale` SET `Name` = 'Grunt Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2102;
-- OLD name : Eclaireur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2103
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2103;
-- OLD name : Ecumeur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2149
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2149;
-- OLD name : Embusqué pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2152
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2152;
-- OLD name : Briseur d’os des Gravières
-- Source : https://www.wowhead.com/wotlk/fr/npc=2159
UPDATE `creature_template_locale` SET `Name` = 'Briseur d''os des Gravières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2159;
-- OLD name : Ecumeur grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2201
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2201;
-- OLD name : Cours-la-côte grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2202
UPDATE `creature_template_locale` SET `Name` = 'Cours-la-côte Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2202;
-- OLD name : Prophète grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2203
UPDATE `creature_template_locale` SET `Name` = 'Prophète Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2203;
-- OLD name : Pêcheur grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2204
UPDATE `creature_template_locale` SET `Name` = 'Pêcheur Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2204;
-- OLD name : Guerrier grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2205
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2205;
-- OLD name : Chasseur grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2206
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2206;
-- OLD name : Oracle grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2207
UPDATE `creature_template_locale` SET `Name` = 'Oracle Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2207;
-- OLD name : Chasse-marée grisebrume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2208
UPDATE `creature_template_locale` SET `Name` = 'Chasse-marée Grisebrume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2208;
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2220
UPDATE `creature_template_locale` SET `Title` = 'Maître des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2223
UPDATE `creature_template_locale` SET `Title` = 'Maître des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2223;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=2226
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2226;
-- OLD name : Factionnaire du Syndicat
-- Source : https://www.wowhead.com/wotlk/fr/npc=2243
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle du Syndicat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2243;
-- OLD name : Ogre cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2252
UPDATE `creature_template_locale` SET `Name` = 'Ogre Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2252;
-- OLD name : Brute cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2253
UPDATE `creature_template_locale` SET `Name` = 'Brute Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2253;
-- OLD name : Marteleur cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2254
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2254;
-- OLD name : Mage cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2255
UPDATE `creature_template_locale` SET `Name` = 'Mage Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2255;
-- OLD name : Massacreur cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2256
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2256;
-- OLD name : Maggarrak
-- Source : https://www.wowhead.com/wotlk/fr/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Furie-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2258;
-- OLD name : Factionnaire de Hautebrande
-- Source : https://www.wowhead.com/wotlk/fr/npc=2270
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle de Hautebrande',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2270;
-- OLD name : Régent Serres-de-Corbeau (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2283
UPDATE `creature_template_locale` SET `Name` = 'Régent Serres-de-corbeau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2283;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/fr/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2286, 'frFR','Archer',NULL,0);
-- OLD name : Combattant cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2287
UPDATE `creature_template_locale` SET `Name` = 'Combattant Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2287;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Médecin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2326;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Médecin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2329;
-- OLD name : Générateur d’événement 001
-- Source : https://www.wowhead.com/wotlk/fr/npc=2334
UPDATE `creature_template_locale` SET `Name` = 'Générateur d''événement 001',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2334;
-- OLD name : Magistrat Brûle-flanc
-- Source : https://www.wowhead.com/wotlk/fr/npc=2335
UPDATE `creature_template_locale` SET `Name` = 'Magistrat Burnside',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2335;
-- OLD name : Disciple du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2338
UPDATE `creature_template_locale` SET `Name` = 'Disciple du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2338;
-- OLD name : Nervi du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2339
UPDATE `creature_template_locale` SET `Name` = 'Nervi du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2339;
-- OLD name : Rampant domestiqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Rampemousse géante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2349;
-- OLD name : Rampant forestier
-- Source : https://www.wowhead.com/wotlk/fr/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Rampemousse forestière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2350;
-- OLD name : Ours chancreux
-- Source : https://www.wowhead.com/wotlk/fr/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Ours gris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2351;
-- OLD subname : Eleveuse de chevaux
-- Source : https://www.wowhead.com/wotlk/fr/npc=2357
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2357;
-- OLD name : Journalier de Hautebrande
-- Source : https://www.wowhead.com/wotlk/fr/npc=2360
UPDATE `creature_template_locale` SET `Name` = 'Ouvrier agricole de Hautebrande',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2360;
-- OLD name : Rôdeur du rivage daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2368
UPDATE `creature_template_locale` SET `Name` = 'Rôdeur du rivage Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2368;
-- OLD name : Chasseur du rivage daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2369
UPDATE `creature_template_locale` SET `Name` = 'Chasseur du rivage Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2369;
-- OLD name : Hurleuse daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2370
UPDATE `creature_template_locale` SET `Name` = 'Hurleuse Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2370;
-- OLD name : Sirène daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2371
UPDATE `creature_template_locale` SET `Name` = 'Sirène Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2371;
-- OLD name : Traqueur des contreforts
-- Source : https://www.wowhead.com/wotlk/fr/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'Lion des montagnes farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2385;
-- OLD name : Garde de l'Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Garde d''Austrivage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2386;
-- OLD subname : Eleveuse de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=2389
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2389;
-- OLD name : Derak Tombenuit
-- Source : https://www.wowhead.com/wotlk/fr/npc=2397
UPDATE `creature_template_locale` SET `Name` = 'Derak Crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2397;
-- OLD name : Pilleur cassecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2416
UPDATE `creature_template_locale` SET `Name` = 'Pilleur Cassecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2416;
-- OLD subname : Banquier des guildes
-- Source : https://www.wowhead.com/wotlk/fr/npc=2424
UPDATE `creature_template_locale` SET `Title` = 'Banquier de guilde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2424;
-- OLD name : Crieur d’Austrivage
-- Source : https://www.wowhead.com/wotlk/fr/npc=2435
UPDATE `creature_template_locale` SET `Name` = 'Crieur d''Austrivage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2435;
-- OLD name : Commandant Aggro’gosh
-- Source : https://www.wowhead.com/wotlk/fr/npc=2464
UPDATE `creature_template_locale` SET `Name` = 'Commandant Aggro''gosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2464;
-- OLD name : Long-voyant Mok'thardin
-- Source : https://www.wowhead.com/wotlk/fr/npc=2465
UPDATE `creature_template_locale` SET `Name` = 'Prophète Mok''thardin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2465;
-- OLD name : Gosh-Haldir
-- Source : https://www.wowhead.com/wotlk/fr/npc=2476
UPDATE `creature_template_locale` SET `Name` = 'Grand crocilisque du loch',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2476;
-- OLD name : Haren Sabot-Agile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2478
UPDATE `creature_template_locale` SET `Name` = 'Haren Sabot-agile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2478;
-- OLD name : Vase
-- Source : https://www.wowhead.com/wotlk/fr/npc=2479
UPDATE `creature_template_locale` SET `Name` = 'Limace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2479;
-- OLD name : Amiral Corne-de-Mer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2487
UPDATE `creature_template_locale` SET `Name` = 'Amiral Corne-de-mer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2487;
-- OLD name : Milituus Cyclonœil
-- Source : https://www.wowhead.com/wotlk/fr/npc=2489
UPDATE `creature_template_locale` SET `Name` = 'Milituus Cyclonoeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2489;
-- OLD name : Philippe « le Trembleur »
-- Source : https://www.wowhead.com/wotlk/fr/npc=2502
UPDATE `creature_template_locale` SET `Name` = 'Phillippe le Chancelant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2502;
-- OLD name : Gorille crins-de-ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2521
UPDATE `creature_template_locale` SET `Name` = 'Gorille Crins-de-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2521;
-- OLD subname : Envoyé de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Otage Sombrelance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2530;
-- OLD name : Serviteur de Doane
-- Source : https://www.wowhead.com/wotlk/fr/npc=2531
UPDATE `creature_template_locale` SET `Name` = 'Serviteur de Morganth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2531;
-- OLD name : Serpent de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=2540
UPDATE `creature_template_locale` SET `Name` = 'Serpent de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2540;
-- OLD name : Garr Sabot-de-Sel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2549
UPDATE `creature_template_locale` SET `Name` = 'Garr Sabot-de-sel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2549;
-- OLD name : Capitaine Eau-Plate (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2550
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Eau-plate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2550;
-- OLD name : Troll fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2552
UPDATE `creature_template_locale` SET `Name` = 'Troll fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2552;
-- OLD name : Exhalombre fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2553
UPDATE `creature_template_locale` SET `Name` = 'Exhalombre fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2553;
-- OLD name : Lanceur de haches fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2554
UPDATE `creature_template_locale` SET `Name` = 'Lanceur de haches fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2554;
-- OLD name : Féticheur fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2555
UPDATE `creature_template_locale` SET `Name` = 'Féticheur fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2555;
-- OLD name : Chasseur de têtes fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2556
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de têtes fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2556;
-- OLD name : Chasseur des ombres fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2557
UPDATE `creature_template_locale` SET `Name` = 'Chasseur des ombres fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2557;
-- OLD name : Berserker fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2558
UPDATE `creature_template_locale` SET `Name` = 'Berserker fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2558;
-- OLD name : Ogre rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2562
UPDATE `creature_template_locale` SET `Name` = 'Ogre Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2562;
-- OLD name : Massacreur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2564
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2564;
-- OLD name : Brute rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2566
UPDATE `creature_template_locale` SET `Name` = 'Brute Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2566;
-- OLD name : Magus rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2567
UPDATE `creature_template_locale` SET `Name` = 'Magus Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2567;
-- OLD name : Marteleur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2569
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2569;
-- OLD name : Chaman rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2570
UPDATE `creature_template_locale` SET `Name` = 'Chaman Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2570;
-- OLD name : Seigneur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2571
UPDATE `creature_template_locale` SET `Name` = 'Seigneur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2571;
-- OLD name : Kobold sèche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2572
UPDATE `creature_template_locale` SET `Name` = 'Kobold Sèche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2572;
-- OLD name : Géomètre sèche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2573
UPDATE `creature_template_locale` SET `Name` = 'Géomètre Sèche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2573;
-- OLD name : Terrassier sèche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2574
UPDATE `creature_template_locale` SET `Name` = 'Terrassier Sèche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2574;
-- OLD name : Fournisseur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2575
UPDATE `creature_template_locale` SET `Name` = 'Fournisseur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2575;
-- OLD name : Exhalombre sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2577
UPDATE `creature_template_locale` SET `Name` = 'Exhalombre Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2577;
-- OLD name : Milicien des Dabyrie
-- Source : https://www.wowhead.com/wotlk/fr/npc=2581
UPDATE `creature_template_locale` SET `Name` = 'Milice des Dabyrie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2581;
-- OLD name : Soldat de Stromgarde
-- Source : https://www.wowhead.com/wotlk/fr/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Redresseur de torts de Stromgarde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2585;
-- OLD name : Ecumeur daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2595
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2595;
-- OLD name : Sorcière daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2596
UPDATE `creature_template_locale` SET `Name` = 'Sorcière Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2596;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/fr/npc=2598
UPDATE `creature_template_locale` SET `Title` = 'Démoniste du Conseil des ombres',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2598;
-- OLD name : Molok l’Anéantisseur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2604
UPDATE `creature_template_locale` SET `Name` = 'Molok l''Anéantisseur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2604;
-- OLD name : Zalas fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2605
UPDATE `creature_template_locale` SET `Name` = 'Zalas Fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2605;
-- OLD name : Ancien crocilisque gueule-d'acier
-- Source : https://www.wowhead.com/wotlk/fr/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Ancien crocilisque marin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2635;
-- OLD name : Mangeur d’’âmes vilebranche
-- Source : https://www.wowhead.com/wotlk/fr/npc=2647
UPDATE `creature_template_locale` SET `Name` = 'Mangeur d''âmes Vilebranche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2647;
-- OLD name : Garde aman'zasi vilebranche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2648
UPDATE `creature_template_locale` SET `Name` = 'Garde Aman''zasi vilebranche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2648;
-- OLD name : Scalpeur fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2649
UPDATE `creature_template_locale` SET `Name` = 'Scalpeur fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2649;
-- OLD name : Zélote fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2650
UPDATE `creature_template_locale` SET `Name` = 'Zélote fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2650;
-- OLD name : Ecorcheur fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2651
UPDATE `creature_template_locale` SET `Name` = 'Ecorcheur fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2651;
-- OLD name : Sang-venin fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2652
UPDATE `creature_template_locale` SET `Name` = 'Sang-venin fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2652;
-- OLD name : Sadique fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2653
UPDATE `creature_template_locale` SET `Name` = 'Sadique fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2653;
-- OLD name : Implorateur fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2654
UPDATE `creature_template_locale` SET `Name` = 'Implorateur fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2654;
-- OLD name : Vase verte
-- Source : https://www.wowhead.com/wotlk/fr/npc=2655
UPDATE `creature_template_locale` SET `Name` = 'Limace verte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2655;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/fr/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2662, 'frFR','Maître portuaire Szik','Marchand de bateaux',0);
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2682
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2682;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2683
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2683;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2684
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2684;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2685
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2685;
-- OLD name : Garde du clan fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=2686
UPDATE `creature_template_locale` SET `Name` = 'Garde du clan fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2686;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2687
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2687;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=2688
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2688;
-- OLD name : Ogre crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2701
UPDATE `creature_template_locale` SET `Name` = 'Ogre Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2701;
-- OLD name : Brute crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2715
UPDATE `creature_template_locale` SET `Name` = 'Brute Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2715;
-- OLD name : Chasseur de wyrm crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2716
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de wyrm Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2716;
-- OLD name : Marteleur crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2717
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2717;
-- OLD name : Chaman crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2718
UPDATE `creature_template_locale` SET `Name` = 'Chaman Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2718;
-- OLD name : Seigneur crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2719
UPDATE `creature_template_locale` SET `Name` = 'Seigneur Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2719;
-- OLD name : Ogre-mage crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2720
UPDATE `creature_template_locale` SET `Name` = 'Ogre-mage Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2720;
-- OLD name : Tunnelier ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2739
UPDATE `creature_template_locale` SET `Name` = 'Tunnelier Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2739;
-- OLD name : Tisseur d’ombre ombreforge
-- Source : https://www.wowhead.com/wotlk/fr/npc=2740
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''ombre Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2740;
-- OLD name : Excavateur ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2741
UPDATE `creature_template_locale` SET `Name` = 'Excavateur Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2741;
-- OLD name : Psalmodieur ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2742
UPDATE `creature_template_locale` SET `Name` = 'Psalmodieur Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2742;
-- OLD name : Guerrier ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2743
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2743;
-- OLD name : Commandant ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2744
UPDATE `creature_template_locale` SET `Name` = 'Commandant Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2744;
-- OLD name : Garde cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2746
UPDATE `creature_template_locale` SET `Name` = 'Garde Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2746;
-- OLD name : Barricade
-- Source : https://www.wowhead.com/wotlk/fr/npc=2749
UPDATE `creature_template_locale` SET `Name` = 'Golem de siège',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2749;
-- OLD name : Maraudeur daguéchine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2775
UPDATE `creature_template_locale` SET `Name` = 'Maraudeur Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2775;
-- OLD name : Theldurin l’Egaré
-- Source : https://www.wowhead.com/wotlk/fr/npc=2785
UPDATE `creature_template_locale` SET `Name` = 'Theldurin l''Egaré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2785;
-- OLD name : Pand Lieur-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2798
UPDATE `creature_template_locale` SET `Name` = 'Pand Lieur-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2798;
-- OLD name : Implorateur d’ondes daguéchine
-- Source : https://www.wowhead.com/wotlk/fr/npc=2807
UPDATE `creature_template_locale` SET `Name` = 'Implorateur d''ondes Daguéchine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2807;
-- OLD name : Buse desséchée
-- Source : https://www.wowhead.com/wotlk/fr/npc=2830
UPDATE `creature_template_locale` SET `Name` = 'Busard',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2830;
-- OLD subname : Marchand de feux d’artifice
-- Source : https://www.wowhead.com/wotlk/fr/npc=2838
UPDATE `creature_template_locale` SET `Title` = 'Marchand de feux d''artifice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2838;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de crocilisques',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2876;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Maître des compétences de jet',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2886;
-- OLD name : Trogg cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2889
UPDATE `creature_template_locale` SET `Name` = 'Trogg Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2889;
-- OLD name : Eclaireur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2890
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2890;
-- OLD name : Brise-crâne cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2891
UPDATE `creature_template_locale` SET `Name` = 'Brise-crâne Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2891;
-- OLD name : Prophète cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2892
UPDATE `creature_template_locale` SET `Name` = 'Prophète Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2892;
-- OLD name : Briseur d’os cavepierre
-- Source : https://www.wowhead.com/wotlk/fr/npc=2893
UPDATE `creature_template_locale` SET `Name` = 'Briseur d''os Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2893;
-- OLD name : Chaman cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2894
UPDATE `creature_template_locale` SET `Name` = 'Chaman Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2894;
-- OLD name : Guerrier crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2906
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2906;
-- OLD name : Mystique crache-poussière
-- Source : https://www.wowhead.com/wotlk/fr/npc=2907
UPDATE `creature_template_locale` SET `Name` = 'Mystique Crache-poussières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2907;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=2935
UPDATE `creature_template_locale` SET `Title` = 'Maître des démons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2935;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2938
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur d''ours',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2938;
-- OLD subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (2939, 'frFR',NULL,'Entraîneur de sangliers',0);
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=2942
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de loups',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2942;
-- OLD name : Mull Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2948
UPDATE `creature_template_locale` SET `Name` = 'Mull Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2948;
-- OLD name : Envahisseurs dos-hirsute
-- Source : https://www.wowhead.com/wotlk/fr/npc=2952
UPDATE `creature_template_locale` SET `Name` = 'Huran Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2952;
-- OLD name : Chaman dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2953
UPDATE `creature_template_locale` SET `Name` = 'Chaman Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2953;
-- OLD name : Sanglier de guerre dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2954
UPDATE `creature_template_locale` SET `Name` = 'Sanglier de guerre Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2954;
-- OLD name : Jeune sanglier de guerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=2966
UPDATE `creature_template_locale` SET `Name` = 'Sanglier de guerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2966;
-- OLD name : Grull Vent-du-Faucon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2980
UPDATE `creature_template_locale` SET `Name` = 'Grull Vent-du-faucon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2980;
-- OLD name : Voyant Langue-Grise (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2982
UPDATE `creature_template_locale` SET `Name` = 'Voyant Langue-grise',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2982;
-- OLD name : Prophète Cours-avec-Sagesse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2984
UPDATE `creature_template_locale` SET `Name` = 'Prophète Cours-avec-sagesse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2984;
-- OLD name : Ruul Serre-d’Aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=2985
UPDATE `creature_template_locale` SET `Name` = 'Ruul Serre-d''aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2985;
-- OLD name : Eyahn Serre-d’Aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=2987
UPDATE `creature_template_locale` SET `Name` = 'Eyahn Serre-d''aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2987;
-- OLD name : Morin Traqueur-de-Nuage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2988
UPDATE `creature_template_locale` SET `Name` = 'Morin Traqueur-de-nuage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2988;
-- OLD name : Grande-mère Vent-du-Faucon
-- Source : https://www.wowhead.com/wotlk/fr/npc=2991
UPDATE `creature_template_locale` SET `Name` = 'Grand-mère Vent-du-faucon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2991;
-- OLD name : Baine Sabot-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2993
UPDATE `creature_template_locale` SET `Name` = 'Baine Sabot-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2993;
-- OLD name : Jyn Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2997
UPDATE `creature_template_locale` SET `Name` = 'Jyn Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2997;
-- OLD name : Karn Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2998
UPDATE `creature_template_locale` SET `Name` = 'Karn Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2998;
-- OLD name : Taur Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=2999
UPDATE `creature_template_locale` SET `Name` = 'Taur Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 2999;
-- OLD name : Brek Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3001
UPDATE `creature_template_locale` SET `Name` = 'Brek Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3001;
-- OLD name : Kurm Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3002
UPDATE `creature_template_locale` SET `Name` = 'Kurm Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3002;
-- OLD name : Fyr Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3003
UPDATE `creature_template_locale` SET `Name` = 'Fyr Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3003;
-- OLD subname : Fournitures de tailleur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de travailleur du cuir & de tailleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3005;
-- OLD subname : Fournitures de travailleur du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Apprenti travailleur du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3008;
-- OLD name : Bena Sabot-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=3009
UPDATE `creature_template_locale` SET `Name` = 'Bena Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3009;
-- OLD name : Mani Sabot-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=3010
UPDATE `creature_template_locale` SET `Name` = 'Mani Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3010;
-- OLD name : Teg Aube-Glorieuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3011
UPDATE `creature_template_locale` SET `Name` = 'Teg Aube-glorieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3011;
-- OLD name : Nata Aube-Glorieuse, subname : Fournitures d’enchanteur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3012
UPDATE `creature_template_locale` SET `Name` = 'Nata Aube-glorieuse',`Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3012;
-- OLD name : Komin Sabot-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=3013
UPDATE `creature_template_locale` SET `Name` = 'Komin Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3013;
-- OLD name : Nida Sabot-d’Hiver, subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=3014
UPDATE `creature_template_locale` SET `Name` = 'Nida Sabot-d''hiver',`Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3014;
-- OLD name : Kuna Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3015
UPDATE `creature_template_locale` SET `Name` = 'Kuna Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3015;
-- OLD name : Nan Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3017
UPDATE `creature_template_locale` SET `Name` = 'Nan Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3017;
-- OLD name : Hogor Sabot-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3018
UPDATE `creature_template_locale` SET `Name` = 'Hogor Sabot-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3018;
-- OLD name : Delgo Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3019
UPDATE `creature_template_locale` SET `Name` = 'Delgo Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3019;
-- OLD name : Etu Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3020
UPDATE `creature_template_locale` SET `Name` = 'Etu Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3020;
-- OLD name : Kard Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3021
UPDATE `creature_template_locale` SET `Name` = 'Kard Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3021;
-- OLD name : Sunn Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3022
UPDATE `creature_template_locale` SET `Name` = 'Sunn Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3022;
-- OLD name : Sura Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3023
UPDATE `creature_template_locale` SET `Name` = 'Sura Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3023;
-- OLD name : Tah Sabot-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=3024
UPDATE `creature_template_locale` SET `Name` = 'Tah Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3024;
-- OLD name : Kaga Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3025
UPDATE `creature_template_locale` SET `Name` = 'Kaga Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3025;
-- OLD name : Aska Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3026
UPDATE `creature_template_locale` SET `Name` = 'Aska Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3026;
-- OLD name : Naal Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3027
UPDATE `creature_template_locale` SET `Name` = 'Naal Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3027;
-- OLD name : Kah Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3028
UPDATE `creature_template_locale` SET `Name` = 'Kah Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3028;
-- OLD name : Sewa Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3029
UPDATE `creature_template_locale` SET `Name` = 'Sewa Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3029;
-- OLD name : Siln Chasse-le-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3030
UPDATE `creature_template_locale` SET `Name` = 'Siln Chasse-le-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3030;
-- OLD name : Tigor Chasse-le-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3031
UPDATE `creature_template_locale` SET `Name` = 'Tigor Chasse-le-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3031;
-- OLD name : Beram Chasse-le-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3032
UPDATE `creature_template_locale` SET `Name` = 'Beram Chasse-le-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3032;
-- OLD name : Turak Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3033
UPDATE `creature_template_locale` SET `Name` = 'Turak Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3033;
-- OLD name : Sheal Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3034
UPDATE `creature_template_locale` SET `Name` = 'Sheal Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3034;
-- OLD name : Kym Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3036
UPDATE `creature_template_locale` SET `Name` = 'Kym Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3036;
-- OLD name : Sheza Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3037
UPDATE `creature_template_locale` SET `Name` = 'Sheza Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3037;
-- OLD name : Kary Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3038
UPDATE `creature_template_locale` SET `Name` = 'Kary Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3038;
-- OLD name : Holt Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3039
UPDATE `creature_template_locale` SET `Name` = 'Holt Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3039;
-- OLD name : Urek Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3040
UPDATE `creature_template_locale` SET `Name` = 'Urek Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3040;
-- OLD name : Torm Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3041
UPDATE `creature_template_locale` SET `Name` = 'Torm Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3041;
-- OLD name : Sark Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3042
UPDATE `creature_template_locale` SET `Name` = 'Sark Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3042;
-- OLD name : Ker Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3043
UPDATE `creature_template_locale` SET `Name` = 'Ker Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3043;
-- OLD name : Veren Haut-Trotteur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3050
UPDATE `creature_template_locale` SET `Name` = 'Veren Haut-trotteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3050;
-- OLD name : Skorn Nuage-Blanc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3052
UPDATE `creature_template_locale` SET `Name` = 'Skorn Nuage-blanc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3052;
-- OLD name : Maur Mande-Pluie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3055
UPDATE `creature_template_locale` SET `Name` = 'Maur Mande-pluie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3055;
-- OLD name : Cairne Sabot-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3057
UPDATE `creature_template_locale` SET `Name` = 'Cairne Sabot-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3057;
-- OLD name : Harutt Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3059
UPDATE `creature_template_locale` SET `Name` = 'Harutt Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3059;
-- OLD name : Gart Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3060
UPDATE `creature_template_locale` SET `Name` = 'Gart Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3060;
-- OLD name : Lanka Vise-Loin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3061
UPDATE `creature_template_locale` SET `Name` = 'Lanka Vise-loin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3061;
-- OLD name : Meela Aube-Glorieuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3062
UPDATE `creature_template_locale` SET `Name` = 'Meela Aube-glorieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3062;
-- OLD name : Krang Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3063
UPDATE `creature_template_locale` SET `Name` = 'Krang Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3063;
-- OLD name : Gennia Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3064
UPDATE `creature_template_locale` SET `Name` = 'Gennia Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3064;
-- OLD name : Yaw Crin-Tranchant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3065
UPDATE `creature_template_locale` SET `Name` = 'Yaw Crin-tranchant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3065;
-- OLD name : Narm Chasse-le-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3066
UPDATE `creature_template_locale` SET `Name` = 'Narm Chasse-le-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3066;
-- OLD name : Pyall Sabots-Feutrés, subname : Maître des cuisiniers (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3067
UPDATE `creature_template_locale` SET `Name` = 'Pyall Sabots-feutrés',`Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3067;
-- OLD name : Chaw Cuir-Solide (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3069
UPDATE `creature_template_locale` SET `Name` = 'Chaw Cuir-solide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3069;
-- OLD subname : Compagnon alchimiste
-- Source : https://www.wowhead.com/wotlk/fr/npc=3070
UPDATE `creature_template_locale` SET `Title` = 'Alchimiste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3070;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=3071
UPDATE `creature_template_locale` SET `Title` = 'Herboriste <Modèle nécessaire>',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3071;
-- OLD name : Kawnie Douce-Brise (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3072
UPDATE `creature_template_locale` SET `Name` = 'Kawnie Douce-brise',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3072;
-- OLD name : Marjak Lame-Fougueuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3073
UPDATE `creature_template_locale` SET `Name` = 'Marjak Lame-fougueuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3073;
-- OLD name : Varia Cuir-Coriace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3074
UPDATE `creature_template_locale` SET `Name` = 'Varia Cuir-coriace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3074;
-- OLD name : Bronk Rage-d’Acier
-- Source : https://www.wowhead.com/wotlk/fr/npc=3075
UPDATE `creature_template_locale` SET `Name` = 'Bronk Rage-d''acier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3075;
-- OLD name : Moorat Long-Pas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3076
UPDATE `creature_template_locale` SET `Name` = 'Moorat Long-pas',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3076;
-- OLD name : Mahnott Rude-Blessure (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3077
UPDATE `creature_template_locale` SET `Name` = 'Mahnott Rude-blessure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3077;
-- OLD name : Kennah Oeil-des-Faucons, subname : Fabricant d’armes à feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3078
UPDATE `creature_template_locale` SET `Name` = 'Kennah Oeil-des-faucons',`Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3078;
-- OLD name : Varg Murmure-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3079
UPDATE `creature_template_locale` SET `Name` = 'Varg Murmure-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3079;
-- OLD name : Harant Poigne-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3080
UPDATE `creature_template_locale` SET `Name` = 'Harant Poigne-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3080;
-- OLD name : Wunna Sombre-Crin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3081
UPDATE `creature_template_locale` SET `Name` = 'Wunna Sombre-crin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3081;
-- OLD name : Garde d’honneur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3083
UPDATE `creature_template_locale` SET `Name` = 'Garde d''honneur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3083;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=3088
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3088;
-- OLD name : Serviteur d’Azora capturé
-- Source : https://www.wowhead.com/wotlk/fr/npc=3096
UPDATE `creature_template_locale` SET `Name` = 'Serviteur d''Azora capturé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3096;
-- OLD name : Clampant de l'écume
-- Source : https://www.wowhead.com/wotlk/fr/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Clampant de l''écume pygmée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3106;
-- OLD name : Clampant de l'écume adulte
-- Source : https://www.wowhead.com/wotlk/fr/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Clampant de l''écume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3107;
-- OLD name : Huran tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3111
UPDATE `creature_template_locale` SET `Name` = 'Huran Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3111;
-- OLD name : Eclaireur tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3112
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3112;
-- OLD name : Lève-poussière tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3113
UPDATE `creature_template_locale` SET `Name` = 'Lève-poussière Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3113;
-- OLD name : Garde de guerre tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3114
UPDATE `creature_template_locale` SET `Name` = 'Garde de guerre Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3114;
-- OLD name : Manœuvre kolkar
-- Source : https://www.wowhead.com/wotlk/fr/npc=3119
UPDATE `creature_template_locale` SET `Name` = 'Manoeuvre kolkar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3119;
-- OLD name : Fouette-queue griffesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3122
UPDATE `creature_template_locale` SET `Name` = 'Fouette-queue Griffesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3122;
-- OLD name : Tranche-gueule griffesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3123
UPDATE `creature_template_locale` SET `Name` = 'Tranche-gueule Griffesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3123;
-- OLD subname : Fournitures d’ingénieur et de mineur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3133
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur & de mineur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3133;
-- OLD subname : Grand maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=3148
UPDATE `creature_template_locale` SET `Title` = 'Pilote de zeppelin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3148;
-- OLD name : Entrepreneur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3180
UPDATE `creature_template_locale` SET `Name` = 'Entrepreneur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3180;
-- OLD name : Scott Mercer
-- Source : https://www.wowhead.com/wotlk/fr/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3201;
-- OLD name : Féplouf Sombregriffe
-- Source : https://www.wowhead.com/wotlk/fr/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Féplouf Sombrorage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3203;
-- OLD name : Brave Plume-des-Vents (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3209
UPDATE `creature_template_locale` SET `Name` = 'Brave Plume-des-vents',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3209;
-- OLD name : Brave Mufle-Fier (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3210
UPDATE `creature_template_locale` SET `Name` = 'Brave Mufle-fier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3210;
-- OLD name : Brave Corne-de-Foudre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3211
UPDATE `creature_template_locale` SET `Name` = 'Brave Corne-de-foudre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3211;
-- OLD name : Brave Corne-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3212
UPDATE `creature_template_locale` SET `Name` = 'Brave Corne-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3212;
-- OLD name : Brave Cours-comme-le-Loup (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3213
UPDATE `creature_template_locale` SET `Name` = 'Brave Cours-comme-le-loup',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3213;
-- OLD name : Brave Grand-Sabot (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3214
UPDATE `creature_template_locale` SET `Name` = 'Brave Grand-sabot',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3214;
-- OLD name : Brave Frappe-Fort (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3215
UPDATE `creature_template_locale` SET `Name` = 'Brave Frappe-fort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3215;
-- OLD name : Brave Aigle-de-l’Aube
-- Source : https://www.wowhead.com/wotlk/fr/npc=3217
UPDATE `creature_template_locale` SET `Name` = 'Brave Aigle-de-l''aube',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3217;
-- OLD name : Brave Vent-Vif (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3218
UPDATE `creature_template_locale` SET `Name` = 'Brave Vent-vif',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3218;
-- OLD name : Brave Biche-Bondissante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3219
UPDATE `creature_template_locale` SET `Name` = 'Brave Biche-bondissante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3219;
-- OLD name : Brave Sombre-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3220
UPDATE `creature_template_locale` SET `Name` = 'Brave Sombre-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3220;
-- OLD name : Brave Corne-de-Roc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3221
UPDATE `creature_template_locale` SET `Name` = 'Brave Corne-de-roc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3221;
-- OLD name : Brave Course-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3222
UPDATE `creature_template_locale` SET `Name` = 'Brave Course-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3222;
-- OLD name : Brave Chasseuse-de-Pluie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3223
UPDATE `creature_template_locale` SET `Name` = 'Brave Chasseuse-de-pluie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3223;
-- OLD name : Brave Crins-de-Nuage
-- Source : https://www.wowhead.com/wotlk/fr/npc=3224
UPDATE `creature_template_locale` SET `Name` = 'Brave Crin-de-nuage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3224;
-- OLD name : « Mouchard » Mantépine
-- Source : https://www.wowhead.com/wotlk/fr/npc=3229
UPDATE `creature_template_locale` SET `Name` = '"Mouchard" Mantépine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3229;
-- OLD name : Intrus dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3232
UPDATE `creature_template_locale` SET `Name` = 'Intrus Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3232;
-- OLD name : Gardien du savoir Totem-de-Pluie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3233
UPDATE `creature_template_locale` SET `Name` = 'Gardien du savoir Totem-de-pluie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3233;
-- OLD name : Chasseur dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3258
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3258;
-- OLD name : Défenseur dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3259
UPDATE `creature_template_locale` SET `Name` = 'Défenseur Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3259;
-- OLD name : Sourcier dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3260
UPDATE `creature_template_locale` SET `Name` = 'Sourcier Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3260;
-- OLD name : Tisseur d’épines dos-hirsute
-- Source : https://www.wowhead.com/wotlk/fr/npc=3261
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''épines Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3261;
-- OLD name : Mystique dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3262
UPDATE `creature_template_locale` SET `Name` = 'Mystique Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3262;
-- OLD name : Géomancienne dos-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3263
UPDATE `creature_template_locale` SET `Name` = 'Géomancienne Dos-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3263;
-- OLD name : Chasseur tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3265
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3265;
-- OLD name : Défenseur tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3266
UPDATE `creature_template_locale` SET `Name` = 'Défenseur Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3266;
-- OLD name : Pilleur tranchecrin
-- Source : https://www.wowhead.com/wotlk/fr/npc=3267
UPDATE `creature_template_locale` SET `Name` = 'Sourcier Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3267;
-- OLD name : Tisseuse d’épines tranchecrin
-- Source : https://www.wowhead.com/wotlk/fr/npc=3268
UPDATE `creature_template_locale` SET `Name` = 'Tisseuse d''épines Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3268;
-- OLD name : Géomancienne tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3269
UPDATE `creature_template_locale` SET `Name` = 'Géomancienne Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3269;
-- OLD name : Mystique tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3271
UPDATE `creature_template_locale` SET `Name` = 'Mystique Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3271;
-- OLD name : Anomalie de vase
-- Source : https://www.wowhead.com/wotlk/fr/npc=3295
UPDATE `creature_template_locale` SET `Name` = 'Limace bestiale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3295;
-- OLD name : Grunt d’Orgrimmar
-- Source : https://www.wowhead.com/wotlk/fr/npc=3296
UPDATE `creature_template_locale` SET `Name` = 'Grunt d''Orgrimmar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3296;
-- OLD subname : Nourriture & boissons
-- Source : https://www.wowhead.com/wotlk/fr/npc=3298
UPDATE `creature_template_locale` SET `Title` = 'Nourriture & boisson',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3298;
-- OLD subname : Marchand d'armures en étoffe
-- Source : https://www.wowhead.com/wotlk/fr/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Marchand d''armures légères',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3317;
-- OLD subname : Marchande d'arcs & d'armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Armes à feu & munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3322;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3346
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3346;
-- OLD name : Jorn Oeil-des-Cieux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3387
UPDATE `creature_template_locale` SET `Name` = 'Jorn Oeil-des-cieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3387;
-- OLD name : Mahren Oeil-des-Cieux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3388
UPDATE `creature_template_locale` SET `Name` = 'Mahren Oeil-des-cieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3388;
-- OLD name : Barak Plaie-des-Kodos (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3394
UPDATE `creature_template_locale` SET `Name` = 'Barak Plaie-des-kodos',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3394;
-- OLD subname : Composants et poisons
-- Source : https://www.wowhead.com/wotlk/fr/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3405;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3413
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3413;
-- OLD name : Feegly l’Exilé
-- Source : https://www.wowhead.com/wotlk/fr/npc=3421
UPDATE `creature_template_locale` SET `Name` = 'Feegly l''Exilé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3421;
-- OLD name : Melor Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3441
UPDATE `creature_template_locale` SET `Name` = 'Melor Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3441;
-- OLD subname : Entrepreneur indépendant
-- Source : https://www.wowhead.com/wotlk/fr/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Syndicat des artisans',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3442;
-- OLD name : Pawe Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3447
UPDATE `creature_template_locale` SET `Name` = 'Pawe Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3447;
-- OLD name : Tonga Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3448
UPDATE `creature_template_locale` SET `Name` = 'Tonga Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3448;
-- OLD name : Guide tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3456
UPDATE `creature_template_locale` SET `Name` = 'Guide Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3456;
-- OLD name : Traqueur tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3457
UPDATE `creature_template_locale` SET `Name` = 'Traqueur Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3457;
-- OLD name : Prophète tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3458
UPDATE `creature_template_locale` SET `Name` = 'Prophète Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3458;
-- OLD name : Frénétique tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3459
UPDATE `creature_template_locale` SET `Name` = 'Frénétique Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3459;
-- OLD subname : Flibustiers des mers du Sud (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3467
UPDATE `creature_template_locale` SET `Title` = 'Flibustiers des mers du sud',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3467;
-- OLD name : Moorane Blé-du-Foyer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3480
UPDATE `creature_template_locale` SET `Name` = 'Moorane Blé-du-foyer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3480;
-- OLD name : Jahan Aile-de-Faucon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3483
UPDATE `creature_template_locale` SET `Name` = 'Jahan Aile-de-faucon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3483;
-- OLD name : Halija Rôdeur-Blanc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3486
UPDATE `creature_template_locale` SET `Name` = 'Halija Rôdeur-blanc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3486;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3495
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3495;
-- OLD name : Wallace l’aveugle
-- Source : https://www.wowhead.com/wotlk/fr/npc=3534
UPDATE `creature_template_locale` SET `Name` = 'Wallace l''aveugle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3534;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=3575
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauve-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3575;
-- OLD name : Brasseur de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Brasseur de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3577;
-- OLD name : Mineur de Moulin-de-l'Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Mineur de Dalaran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3578;
-- OLD name : Alanna Oeil-de-Corbeau (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3606
UPDATE `creature_template_locale` SET `Name` = 'Alanna Oeil-de-corbeau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3606;
-- OLD name : Sentinelle Elissa Brise-Stellaire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3657
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Elissa Brise-stellaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3657;
-- OLD name : Muyoh
-- Source : https://www.wowhead.com/wotlk/fr/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Disciple de Naralex',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3678;
-- OLD name : Harb Sabot-Griffu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3685
UPDATE `creature_template_locale` SET `Name` = 'Harb Sabot-griffu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3685;
-- OLD name : Reban Cours-en-Liberté (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3688
UPDATE `creature_template_locale` SET `Name` = 'Reban Cours-en-liberté',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3688;
-- OLD name : Laer Cours-les-Steppes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3689
UPDATE `creature_template_locale` SET `Name` = 'Laer Cours-les-steppes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3689;
-- OLD name : Kar Chante-l’Orage
-- Source : https://www.wowhead.com/wotlk/fr/npc=3690
UPDATE `creature_template_locale` SET `Name` = 'Kar Chante-l''orage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3690;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (3697, 'frFR','Kyln Longuegriffe','Entraîneur de sangliers',0);
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=3698
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=3699
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de félins',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3699;
-- OLD name : Krulmoo Pleine-Lune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3703
UPDATE `creature_template_locale` SET `Name` = 'Krulmoo Pleine-lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3703;
-- OLD name : Myrmidon irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3711
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3711;
-- OLD name : Rasoir irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3712
UPDATE `creature_template_locale` SET `Name` = 'Rasoir Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3712;
-- OLD name : Chevaucheur des vagues irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3713
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur des vagues Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3713;
-- OLD name : Sorcière des mers irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3715
UPDATE `creature_template_locale` SET `Name` = 'Sorcière des mers Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3715;
-- OLD name : Ensorceleuse irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3717
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleuse Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3717;
-- OLD name : Surveillant orc
-- Source : https://www.wowhead.com/wotlk/fr/npc=3734
UPDATE `creature_template_locale` SET `Name` = 'Nervi réprouvé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3734;
-- OLD name : Implorateur de l’enfer de Xavian
-- Source : https://www.wowhead.com/wotlk/fr/npc=3757
UPDATE `creature_template_locale` SET `Name` = 'Implorateur de l''enfer de Xavian',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3757;
-- OLD name : Satyre mornecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3765
UPDATE `creature_template_locale` SET `Name` = 'Satyre Mornecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3765;
-- OLD name : Entourloupeur mornecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3767
UPDATE `creature_template_locale` SET `Name` = 'Entourloupeur Mornecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3767;
-- OLD name : Traqueur des ombres mornecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3770
UPDATE `creature_template_locale` SET `Name` = 'Traqueur des ombres Mornecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3770;
-- OLD name : Implorateur de l’enfer mornecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3771
UPDATE `creature_template_locale` SET `Name` = 'Implorateur de l’enfer Mornecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3771;
-- OLD name : Mange-mousse roussi
-- Source : https://www.wowhead.com/wotlk/fr/npc=3780
UPDATE `creature_template_locale` SET `Name` = 'Mange-mousse Sombretaillis',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3780;
-- OLD name : Ours d’Orneval
-- Source : https://www.wowhead.com/wotlk/fr/npc=3809
UPDATE `creature_template_locale` SET `Name` = 'Ours d''Orneval',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3809;
-- OLD name : Vieil ours d’Orneval
-- Source : https://www.wowhead.com/wotlk/fr/npc=3810
UPDATE `creature_template_locale` SET `Name` = 'Vieil ours d''Orneval',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3810;
-- OLD name : Ours d’Orneval géant
-- Source : https://www.wowhead.com/wotlk/fr/npc=3811
UPDATE `creature_template_locale` SET `Name` = 'Ours d''Orneval géant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3811;
-- OLD name : Teldira Plumelune
-- Source : https://www.wowhead.com/wotlk/fr/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Caylais Plumelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3841;
-- OLD name : [INUTILISÉ] Hurle-sang d'Ombrecroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=3852
UPDATE `creature_template_locale` SET `Name` = 'Hurle-sang d''Ombrecroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3852;
-- OLD name : [INUTILISÉ] Contaminé d'Ombrecroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=3860
UPDATE `creature_template_locale` SET `Name` = 'Contaminé d''Ombrecroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3860;
-- OLD name : Horreur lupine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3863
UPDATE `creature_template_locale` SET `Name` = 'Horreur Lupine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3863;
-- OLD name : [INUTILISÉ] Esprit traumatisé
-- Source : https://www.wowhead.com/wotlk/fr/npc=3876
UPDATE `creature_template_locale` SET `Name` = 'Esprit traumatisé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3876;
-- OLD name : Moodan Blé-du-Soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3883
UPDATE `creature_template_locale` SET `Name` = 'Moodan Blé-du-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3883;
-- OLD name : Jhawna Vent-d’Avoine
-- Source : https://www.wowhead.com/wotlk/fr/npc=3884
UPDATE `creature_template_locale` SET `Name` = 'Jhawna Vent-d''avoine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3884;
-- OLD name : Brakgul Porte-Mort (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3890
UPDATE `creature_template_locale` SET `Name` = 'Brakgul Porte-mort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3890;
-- OLD name : Balizar l’Ombrageux
-- Source : https://www.wowhead.com/wotlk/fr/npc=3899
UPDATE `creature_template_locale` SET `Name` = 'Balizar l''Ombrageux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3899;
-- OLD name : Searing Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=3902
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3902;
-- OLD name : Searing Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=3903
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3903;
-- OLD name : Searing Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=3904
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3904;
-- OLD name : Healing Stream Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=3906
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3906;
-- OLD name : Healing Stream Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=3907
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3907;
-- OLD name : Healing Stream Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=3908
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3908;
-- OLD name : Healing Stream Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=3909
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3909;
-- OLD name : Stoneclaw Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=3911
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3911;
-- OLD name : Stoneclaw Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=3912
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3912;
-- OLD name : Stoneclaw Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=3913
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3913;
-- OLD name : Elémentaire d’eau souillé
-- Source : https://www.wowhead.com/wotlk/fr/npc=3917
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau souillé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3917;
-- OLD name : Loup tranchecrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3939
UPDATE `creature_template_locale` SET `Name` = 'Loup Tranchecrin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3939;
-- OLD name : Prêtresse irequeue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3944
UPDATE `creature_template_locale` SET `Name` = 'Prêtresse Irequeue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3944;
-- OLD name : Haljan Chênecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=3962
UPDATE `creature_template_locale` SET `Name` = 'Haljan Chênecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3962;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=3966
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3966;
-- OLD subname : Vendeur de poison
-- Source : https://www.wowhead.com/wotlk/fr/npc=3969
UPDATE `creature_template_locale` SET `Title` = 'Outils & fournitures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3969;
-- OLD name : Sage Recherche-la-Vérité (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=3978
UPDATE `creature_template_locale` SET `Name` = 'Sage Recherche-la-vérité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3978;
-- OLD name : Irréductible de la KapitalRisk
-- Source : https://www.wowhead.com/wotlk/fr/npc=3992
UPDATE `creature_template_locale` SET `Name` = 'Ingénieur de la KapitalRisk',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 3992;
-- OLD name : Rampant mousse-profonde
-- Source : https://www.wowhead.com/wotlk/fr/npc=4005
UPDATE `creature_template_locale` SET `Name` = 'Rampant des mousses profondes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4005;
-- OLD name : Tisseuse mousse-profonde
-- Source : https://www.wowhead.com/wotlk/fr/npc=4006
UPDATE `creature_template_locale` SET `Name` = 'Tisseuse des mousses profondes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4006;
-- OLD name : Crache-venin mousse-profonde
-- Source : https://www.wowhead.com/wotlk/fr/npc=4007
UPDATE `creature_template_locale` SET `Name` = 'Venimeux des mousses profondes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4007;
-- OLD name : Wyverne aile-fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4012
UPDATE `creature_template_locale` SET `Name` = 'Wyverne Aile-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4012;
-- OLD name : Chasseresse céleste aile-fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4013
UPDATE `creature_template_locale` SET `Name` = 'Chasseresse céleste Aile-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4013;
-- OLD name : Concubine aile-fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4014
UPDATE `creature_template_locale` SET `Name` = 'Concubine Aile-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4014;
-- OLD name : Patriarche aile-fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4015
UPDATE `creature_template_locale` SET `Name` = 'Patriarche Aile-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4015;
-- OLD name : Bête de sève corrompue
-- Source : https://www.wowhead.com/wotlk/fr/npc=4021
UPDATE `creature_template_locale` SET `Name` = 'Bête de sève corrosive',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4021;
-- OLD name : Basilic incendié
-- Source : https://www.wowhead.com/wotlk/fr/npc=4041
UPDATE `creature_template_locale` SET `Name` = 'Basilic brûlé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4041;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/fr/npc=4045
UPDATE `creature_template_locale` SET `Name` = NULL,`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4045;
-- OLD name : Magatha Totem-Sinistre, subname : La Vieille mégère (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4046
UPDATE `creature_template_locale` SET `Name` = 'Magatha Totem-sinistre',`Title` = 'L''Ancienne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4046;
-- OLD name : Sœur rieuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=4054
UPDATE `creature_template_locale` SET `Name` = 'Soeur rieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4054;
-- OLD name : Bombardier sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4062
UPDATE `creature_template_locale` SET `Name` = 'Bombardier Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4062;
-- OLD name : Eclaireur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4064
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4064;
-- OLD name : Factionnaire rochenoire
-- Source : https://www.wowhead.com/wotlk/fr/npc=4065
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4065;
-- OLD name : Wyverne de Haut-Perchoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4107
UPDATE `creature_template_locale` SET `Name` = 'Wyverne de Haut-perchoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4107;
-- OLD name : Concubine de Haut-Perchoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4109
UPDATE `creature_template_locale` SET `Name` = 'Concubine de Haut-perchoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4109;
-- OLD name : Patriarche de Haut-Perchoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4110
UPDATE `creature_template_locale` SET `Name` = 'Patriarche de Haut-perchoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4110;
-- OLD name : Krkk'kx
-- Source : https://www.wowhead.com/wotlk/fr/npc=4132
UPDATE `creature_template_locale` SET `Name` = 'Ravageur silithide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4132;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4149
UPDATE `creature_template_locale` SET `Title` = 'Maître de la collecte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4153
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de félins',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4153;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4157
UPDATE `creature_template_locale` SET `Title` = 'Maître des cartographes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4157;
-- OLD subname : Marchande de robes
-- Source : https://www.wowhead.com/wotlk/fr/npc=4172
UPDATE `creature_template_locale` SET `Title` = 'Marchand de robes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4172;
-- OLD subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/fr/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4174, 'frFR',NULL,'Marchande de flèches',0);
-- OLD name : Essaim silithide
-- Source : https://www.wowhead.com/wotlk/fr/npc=4196
UPDATE `creature_template_locale` SET `Name` = 'Essaim de silithides',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4196;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4206
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur d''ours',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4207
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de loups',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4207;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=4216
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4216;
-- OLD subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/fr/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4224, 'frFR',NULL,'Fournitures de cartographe',0);
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=4228
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4228;
-- OLD name : Forme d’ours (druide elfe de la nuit)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4253
UPDATE `creature_template_locale` SET `Name` = 'Forme d''ours (druide elfe de la nuit)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4253;
-- OLD name : Bengus Forge-Profonde (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4258
UPDATE `creature_template_locale` SET `Name` = 'Bengus Forge-profonde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4258;
-- OLD name : Forme d’ours (druide tauren)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4261
UPDATE `creature_template_locale` SET `Name` = 'Forme d''ours (druide tauren)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4261;
-- OLD name : Jeune mousse-profonde
-- Source : https://www.wowhead.com/wotlk/fr/npc=4263
UPDATE `creature_template_locale` SET `Name` = 'Jeune des mousses profondes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4263;
-- OLD name : Matriarche mousse-profonde
-- Source : https://www.wowhead.com/wotlk/fr/npc=4264
UPDATE `creature_template_locale` SET `Name` = 'Matriarche des mousses profondes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4264;
-- OLD name : Loup gris
-- Source : https://www.wowhead.com/wotlk/fr/npc=4268
UPDATE `creature_template_locale` SET `Name` = 'Loup (gris)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4268;
-- OLD name : Loup rouge
-- Source : https://www.wowhead.com/wotlk/fr/npc=4270
UPDATE `creature_template_locale` SET `Name` = 'Loup (roux)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4270;
-- OLD name : Factionnaire écarlate
-- Source : https://www.wowhead.com/wotlk/fr/npc=4283
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle écarlate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4283;
-- OLD name : Garde écarlate
-- Source : https://www.wowhead.com/wotlk/fr/npc=4290
UPDATE `creature_template_locale` SET `Name` = 'Gardien écarlate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4290;
-- OLD name : Gorm Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4309
UPDATE `creature_template_locale` SET `Name` = 'Gorm Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4309;
-- OLD name : Cor Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4310
UPDATE `creature_template_locale` SET `Name` = 'Cor Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4310;
-- OLD name : Plaiedécaille crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4328
UPDATE `creature_template_locale` SET `Name` = 'Plaiedécaille Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4328;
-- OLD name : Eclaireur crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4329
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4329;
-- OLD name : Queue-cendrée crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4331
UPDATE `creature_template_locale` SET `Name` = 'Queue-cendrée Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4331;
-- OLD name : Dévoreur crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4333
UPDATE `creature_template_locale` SET `Name` = 'Dévoreur Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4333;
-- OLD name : Implorateur des flammes crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4334
UPDATE `creature_template_locale` SET `Name` = 'Implorateur des flammes Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4334;
-- OLD name : Crocilisque sèchefange (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4341
UPDATE `creature_template_locale` SET `Name` = 'Crocilisque Sèchefange',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4341;
-- OLD name : Vile Mâchoire sèchefange (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4342
UPDATE `creature_template_locale` SET `Name` = 'Vile Mâchoire Sèchefange',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4342;
-- OLD name : Mordeur sèchefange (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4343
UPDATE `creature_template_locale` SET `Name` = 'Mordeur Sèchefange',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4343;
-- OLD name : Crocs-lames sèchefange (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4345
UPDATE `creature_template_locale` SET `Name` = 'Crocs-lames Sèchefange',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4345;
-- OLD name : Gueule d’acier Rochefange
-- Source : https://www.wowhead.com/wotlk/fr/npc=4400
UPDATE `creature_template_locale` SET `Name` = 'Gueule d''acier Rochefange',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4400;
-- OLD name : Maître de course Kronkenfourche
-- Source : https://www.wowhead.com/wotlk/fr/npc=4419
UPDATE `creature_template_locale` SET `Name` = 'Maître des courses Kronkenfourche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4419;
-- OLD name : Protecteur darnassien
-- Source : https://www.wowhead.com/wotlk/fr/npc=4423
UPDATE `creature_template_locale` SET `Name` = 'Protecteur de Darnassus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4423;
-- OLD subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/fr/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (4443, 'frFR',NULL,'Marchande de totems',0);
-- OLD subname : Marchand de course
-- Source : https://www.wowhead.com/wotlk/fr/npc=4445
UPDATE `creature_template_locale` SET `Title` = 'Marchand associé à une race',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4445;
-- OLD subname : Marchand de course
-- Source : https://www.wowhead.com/wotlk/fr/npc=4446
UPDATE `creature_template_locale` SET `Title` = 'Marchand associé à une race',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4446;
-- OLD name : Cime-de-Pierre le Vieil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4451
UPDATE `creature_template_locale` SET `Name` = 'Cime-de-pierre le Vieil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4451;
-- OLD name : Porte-froid Branchie-bistre
-- Source : https://www.wowhead.com/wotlk/fr/npc=4460
UPDATE `creature_template_locale` SET `Name` = 'Seigneur Branchie-bistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4460;
-- OLD name : Chasseur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4462
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4462;
-- OLD name : Invocateur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4463
UPDATE `creature_template_locale` SET `Name` = 'Invocateur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4463;
-- OLD name : Gladiateur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4464
UPDATE `creature_template_locale` SET `Name` = 'Gladiateur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4464;
-- OLD name : Vase de jade
-- Source : https://www.wowhead.com/wotlk/fr/npc=4468
UPDATE `creature_template_locale` SET `Name` = 'Limace de jade',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4468;
-- OLD name : Loup vilebranche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4482
UPDATE `creature_template_locale` SET `Name` = 'Loup Vilebranche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4482;
-- OLD name : Braug Esprit-Troublé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4489
UPDATE `creature_template_locale` SET `Name` = 'Braug Esprit-troublé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4489;
-- OLD name : Gueule-Glacée (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4504
UPDATE `creature_template_locale` SET `Name` = 'Gueule-glacée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4504;
-- OLD name : Willix l’Importateur
-- Source : https://www.wowhead.com/wotlk/fr/npc=4508
UPDATE `creature_template_locale` SET `Name` = 'Willix l''Importateur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4508;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=4551
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4551;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Maître tailleur du tisse-ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4578;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4579
UPDATE `creature_template_locale` SET `Title` = 'Maître des cartographes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4579;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=4587
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4587;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=4615
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4615;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=4617
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4617;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4621
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de raptors',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4621;
-- OLD name : Marcheur du Vide d’Arugal
-- Source : https://www.wowhead.com/wotlk/fr/npc=4627
UPDATE `creature_template_locale` SET `Name` = 'Marcheur du Vide d''Arugal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4627;
-- OLD name : Traqueur des ombres Fielfurie
-- Source : https://www.wowhead.com/wotlk/fr/npc=4674
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4674;
-- OLD name : Implorateur de l’enfer Fielfurie
-- Source : https://www.wowhead.com/wotlk/fr/npc=4675
UPDATE `creature_template_locale` SET `Name` = 'Implorateur de l''enfer Fielfurie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4675;
-- OLD name : Infernal inférieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=4676
UPDATE `creature_template_locale` SET `Name` = 'Infernal mineur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4676;
-- OLD name : Sœur du Néant
-- Source : https://www.wowhead.com/wotlk/fr/npc=4682
UPDATE `creature_template_locale` SET `Name` = 'Soeur du Néant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4682;
-- OLD name : Géant arpentefonds (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4686
UPDATE `creature_template_locale` SET `Name` = 'Géant Arpentefonds',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4686;
-- OLD name : Chercheur arpentefonds (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4687
UPDATE `creature_template_locale` SET `Name` = 'Chercheur Arpentefonds',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4687;
-- OLD name : Déchiqueteur de l’effroi
-- Source : https://www.wowhead.com/wotlk/fr/npc=4694
UPDATE `creature_template_locale` SET `Name` = 'Déchiqueteur de l''effroi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4694;
-- OLD name : Naga ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4711
UPDATE `creature_template_locale` SET `Name` = 'Naga Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4711;
-- OLD name : Sorcière ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4712
UPDATE `creature_template_locale` SET `Name` = 'Sorcière Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4712;
-- OLD name : Guerrier ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4713
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4713;
-- OLD name : Myrmidon ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4714
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4714;
-- OLD name : Queue-rasoir ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4715
UPDATE `creature_template_locale` SET `Name` = 'Queue-rasoir Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4715;
-- OLD name : Chasse-marée ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4716
UPDATE `creature_template_locale` SET `Name` = 'Chasse-marée Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4716;
-- OLD name : Prêtresse des marées ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4717
UPDATE `creature_template_locale` SET `Name` = 'Prêtresse des marées Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4717;
-- OLD name : Oracle ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4718
UPDATE `creature_template_locale` SET `Name` = 'Oracle Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4718;
-- OLD name : Sorcière des mers ondulame (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4719
UPDATE `creature_template_locale` SET `Name` = 'Sorcière des mers Ondulame',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4719;
-- OLD name : Zangen Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4721
UPDATE `creature_template_locale` SET `Name` = 'Zangen Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4721;
-- OLD name : Bélier de givre
-- Source : https://www.wowhead.com/wotlk/fr/npc=4778
UPDATE `creature_template_locale` SET `Name` = 'Bélier (bleu)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4778;
-- OLD name : Bélier noir
-- Source : https://www.wowhead.com/wotlk/fr/npc=4780
UPDATE `creature_template_locale` SET `Name` = 'Bélier (noir)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4780;
-- OLD name : Truk Barbe-Hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4782
UPDATE `creature_template_locale` SET `Name` = 'Truk Barbe-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4782;
-- OLD name : Garde d’argent Thaelrid
-- Source : https://www.wowhead.com/wotlk/fr/npc=4787
UPDATE `creature_template_locale` SET `Name` = 'Garde d''argent Thaelrid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4787;
-- OLD name : Jarl « Oeil-des-Marais » (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4792
UPDATE `creature_template_locale` SET `Name` = 'Jarl « Oeil-des-marais »',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4792;
-- OLD name : Acolyte du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4809
UPDATE `creature_template_locale` SET `Name` = 'Acolyte du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4809;
-- OLD name : Saccageur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4810
UPDATE `creature_template_locale` SET `Name` = 'Saccageur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4810;
-- OLD name : Aquamancien du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4811
UPDATE `creature_template_locale` SET `Name` = 'Aquamancien du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4811;
-- OLD name : Erudit du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4812
UPDATE `creature_template_locale` SET `Name` = 'Erudit du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4812;
-- OLD name : Ombremage du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4813
UPDATE `creature_template_locale` SET `Name` = 'Ombremage du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4813;
-- OLD name : Elémentaliste du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4814
UPDATE `creature_template_locale` SET `Name` = 'Elémentaliste du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4814;
-- OLD name : Crustacé barbelé
-- Source : https://www.wowhead.com/wotlk/fr/npc=4823
UPDATE `creature_template_locale` SET `Name` = 'Crustacé épineux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4823;
-- OLD name : Seigneur du Crépuscule Kelris (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4832
UPDATE `creature_template_locale` SET `Name` = 'Seigneur du crépuscule Kelris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4832;
-- OLD name : Géomètre ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4844
UPDATE `creature_template_locale` SET `Name` = 'Géomètre Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4844;
-- OLD name : Ruffian ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4845
UPDATE `creature_template_locale` SET `Name` = 'Ruffian Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4845;
-- OLD name : Terrassier ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4846
UPDATE `creature_template_locale` SET `Name` = 'Terrassier Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4846;
-- OLD name : Chasseur de reliques ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4847
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de reliques Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4847;
-- OLD name : Invocateur noir ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4848
UPDATE `creature_template_locale` SET `Name` = 'Invocateur noir Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4848;
-- OLD name : Archéologue ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4849
UPDATE `creature_template_locale` SET `Name` = 'Archéologue Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4849;
-- OLD name : Rôdeur des cavernes cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4850
UPDATE `creature_template_locale` SET `Name` = 'Rôdeur des cavernes Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4850;
-- OLD name : Mange-roches cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4851
UPDATE `creature_template_locale` SET `Name` = 'Mange-roches Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4851;
-- OLD name : Oracle cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4852
UPDATE `creature_template_locale` SET `Name` = 'Oracle Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4852;
-- OLD name : Géomancien cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4853
UPDATE `creature_template_locale` SET `Name` = 'Géomancien Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4853;
-- OLD name : Bagarreur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4855
UPDATE `creature_template_locale` SET `Name` = 'Bagarreur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4855;
-- OLD name : Chasseur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4856
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4856;
-- OLD name : Golem d’obsidienne
-- Source : https://www.wowhead.com/wotlk/fr/npc=4872
UPDATE `creature_template_locale` SET `Name` = 'Golem d''obsidienne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4872;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4881
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de tortues',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4881;
-- OLD subname : Eleveur de chevaux
-- Source : https://www.wowhead.com/wotlk/fr/npc=4885
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4885;
-- OLD subname : Fabricant d'armes et armures
-- Source : https://www.wowhead.com/wotlk/fr/npc=4886
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armures et de boucliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4886;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Fabricante d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4888;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=4889
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4889;
-- OLD subname : Maître des chasseurs et fabricant d’arcs
-- Source : https://www.wowhead.com/wotlk/fr/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''arcs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4892;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4894;
-- OLD subname : Fournitures générales & composants
-- Source : https://www.wowhead.com/wotlk/fr/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Fournitures générales',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4896;
-- OLD subname : Fournitures d’herboriste et d’alchimiste
-- Source : https://www.wowhead.com/wotlk/fr/npc=4899
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste et d''alchimiste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4899;
-- OLD name : Maître de combat Criton
-- Source : https://www.wowhead.com/wotlk/fr/npc=4924
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre Criton',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4924;
-- OLD name : Caz Bi-Douille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4941
UPDATE `creature_template_locale` SET `Name` = 'Caz Bi-douille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4941;
-- OLD name : Serpent d'eau
-- Source : https://www.wowhead.com/wotlk/fr/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Mocassin d''eau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4953;
-- OLD name : Nervi de la Vieille ville (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=4969
UPDATE `creature_template_locale` SET `Name` = 'Nervi de la vieille ville',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4969;
-- OLD subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=4994
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers loups',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 4994;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5001
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers oiseaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5001;
-- OLD name : World Boar Trainer, subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (5002, 'frFR','Entraîneur de sangliers universel','Maître des familiers sangliers',0);
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5003
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers félins',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5004
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers clampants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5005
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers crocodiles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5005;
-- OLD name : Maître des démons universel - ancien, subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'Maître des démons universel',`Title` = 'Maître des démons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5008
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers gorilles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5008;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5009
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5011
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers raptors',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5012
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers scorpides',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5013
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers araignées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5013;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5015
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers haut-trotteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5015;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5017
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers tortues',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5017;
-- OLD name : Portail universel : Maître des Pitons-du-Tonnerre, subname : Portail : les Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=5022
UPDATE `creature_template_locale` SET `Name` = 'Portail universel : Maître des Pitons du Tonnerre',`Title` = 'Portail : les Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5022;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5026
UPDATE `creature_template_locale` SET `Title` = 'Maître d''équitation',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5026;
-- OLD name : [PH] Barrière de douleur mogu, subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5027
UPDATE `creature_template_locale` SET `Name` = 'Maître des crocheteurs universel',`Title` = 'Maître des Crocheteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5027;
-- OLD name : Jiming, subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5029
UPDATE `creature_template_locale` SET `Name` = 'Maître en survie universel',`Title` = 'Maître des experts en survie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5029;
-- OLD subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5030
UPDATE `creature_template_locale` SET `Title` = 'Instructrice de monte de tigre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5030;
-- OLD name : Winwa, subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5034
UPDATE `creature_template_locale` SET `Name` = 'Maître des brasseurs universel',`Title` = 'Maître des brasseurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5035
UPDATE `creature_template_locale` SET `Title` = 'Maître des cartographes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5035;
-- OLD name : [PÉRIMÉ] Maître des démonistes universel, subname : Maître des démonistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=5039
UPDATE `creature_template_locale` SET `Name` = 'Entraîneur de pistage universel',`Title` = 'Entraîneur en pistage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5039;
-- OLD name : Emeutier
-- Source : https://www.wowhead.com/wotlk/fr/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Emeutier défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5043;
-- OLD name : Trésorier Lendry
-- Source : https://www.wowhead.com/wotlk/fr/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Greffier Lendry',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5083;
-- OLD name : Maître de combat Szigeti (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5090
UPDATE `creature_template_locale` SET `Name` = 'Maître de Combat Szigeti',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5090;
-- OLD subname : Capitaine de l’équipe rouge
-- Source : https://www.wowhead.com/wotlk/fr/npc=5095
UPDATE `creature_template_locale` SET `Title` = 'Capitaine de l''équipe rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5095;
-- OLD subname : Capitaine de l’équipe bleue
-- Source : https://www.wowhead.com/wotlk/fr/npc=5096
UPDATE `creature_template_locale` SET `Title` = 'Capitaine de l''équipe bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5096;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5104
UPDATE `creature_template_locale` SET `Title` = 'Maître des fusils',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5104;
-- OLD name : Brogun Targe-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5118
UPDATE `creature_template_locale` SET `Name` = 'Brogun Targe-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5118;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=5138
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5138;
-- OLD name : Brandur Martel-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5149
UPDATE `creature_template_locale` SET `Name` = 'Brandur Martel-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5149;
-- OLD subname : Marchande de robes
-- Source : https://www.wowhead.com/wotlk/fr/npc=5156
UPDATE `creature_template_locale` SET `Title` = 'Marchand de robes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5156;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5158
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5158;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5164;
-- OLD name : Cœurdechardon
-- Source : https://www.wowhead.com/wotlk/fr/npc=5171
UPDATE `creature_template_locale` SET `Name` = 'Coeurdechardon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5171;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5175
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5175;
-- OLD name : Factionnaire de Theramore
-- Source : https://www.wowhead.com/wotlk/fr/npc=5184
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle de Theramore',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5184;
-- OLD name : Canon des mers du Sud (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5187
UPDATE `creature_template_locale` SET `Name` = 'Canon des Mers du sud',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5187;
-- OLD name : Cible de tir à l’arc
-- Source : https://www.wowhead.com/wotlk/fr/npc=5202
UPDATE `creature_template_locale` SET `Name` = 'Cible d''archer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5202;
-- OLD name : Ogre gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5229
UPDATE `creature_template_locale` SET `Name` = 'Ogre Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5229;
-- OLD name : Massacreur gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5231
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5231;
-- OLD name : Brute gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5232
UPDATE `creature_template_locale` SET `Name` = 'Brute Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5232;
-- OLD name : Marteleur gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5234
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5234;
-- OLD name : Chaman gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5236
UPDATE `creature_template_locale` SET `Name` = 'Chaman Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5236;
-- OLD name : Ogre-mage gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5237
UPDATE `creature_template_locale` SET `Name` = 'Ogre-mage Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5237;
-- OLD name : Maître de guerre gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5238
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5238;
-- OLD name : Seigneur-mage gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5239
UPDATE `creature_template_locale` SET `Name` = 'Seigneur-mage Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5239;
-- OLD name : Démoniste gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5240
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5240;
-- OLD name : Seigneur de guerre gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5241
UPDATE `creature_template_locale` SET `Name` = 'Seigneur de guerre Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5241;
-- OLD name : Aiguillonneuse zukk'ash (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5244
UPDATE `creature_template_locale` SET `Name` = 'Aiguillonneuse Zukk''ash',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5244;
-- OLD name : Guêpe zukk'ash (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5245
UPDATE `creature_template_locale` SET `Name` = 'Guêpe Zukk''ash',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5245;
-- OLD name : Ouvrière zukk'ash (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5246
UPDATE `creature_template_locale` SET `Name` = 'Ouvrière Zukk''ash',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5246;
-- OLD name : Tunnelière zukk'ash (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5247
UPDATE `creature_template_locale` SET `Name` = 'Tunnelière Zukk''ash',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5247;
-- OLD name : Bâtard griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5249
UPDATE `creature_template_locale` SET `Name` = 'Bâtard Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5249;
-- OLD name : Trappeur griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5251
UPDATE `creature_template_locale` SET `Name` = 'Trappeur Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5251;
-- OLD name : Brute griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5253
UPDATE `creature_template_locale` SET `Name` = 'Brute Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5253;
-- OLD name : Mystique griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5254
UPDATE `creature_template_locale` SET `Name` = 'Mystique Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5254;
-- OLD name : Saccageur griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5255
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5255;
-- OLD name : Alpha griffebois (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5258
UPDATE `creature_template_locale` SET `Name` = 'Alpha Griffebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5258;
-- OLD name : Yéti griffe farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5292
UPDATE `creature_template_locale` SET `Name` = 'Yéti Griffe farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5292;
-- OLD name : Enragé griffe farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5295
UPDATE `creature_template_locale` SET `Name` = 'Enragé Griffe farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5295;
-- OLD name : Yéti griffe féroce (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5296
UPDATE `creature_template_locale` SET `Name` = 'Yéti Griffe féroce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5296;
-- OLD name : Ancien griffe féroce (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5297
UPDATE `creature_template_locale` SET `Name` = 'Ancien Griffe féroce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5297;
-- OLD name : Hippogriffe aigreplume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5300
UPDATE `creature_template_locale` SET `Name` = 'Hippogriffe Aigreplume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5300;
-- OLD name : Cerf ailé aigreplume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5304
UPDATE `creature_template_locale` SET `Name` = 'Cerf ailé Aigreplume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5304;
-- OLD name : Tempétueux aigreplume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5305
UPDATE `creature_template_locale` SET `Name` = 'Tempétueux Aigreplume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5305;
-- OLD name : Patriarche aigreplume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5306
UPDATE `creature_template_locale` SET `Name` = 'Patriarche Aigreplume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5306;
-- OLD name : Draconide jademir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5315
UPDATE `creature_template_locale` SET `Name` = 'Draconide Jademir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5315;
-- OLD name : Oracle jademir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5317
UPDATE `creature_template_locale` SET `Name` = 'Oracle Jademir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5317;
-- OLD name : Gardien sylvestre jademir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5319
UPDATE `creature_template_locale` SET `Name` = 'Gardien sylvestre Jademir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5319;
-- OLD name : Gardien des marais jademir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5320
UPDATE `creature_template_locale` SET `Name` = 'Gardien des marais Jademir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5320;
-- OLD name : [Test] Monstre de Jeremy
-- Source : https://www.wowhead.com/wotlk/fr/npc=5326
UPDATE `creature_template_locale` SET `Name` = 'Claqueur côtier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5326;
-- OLD name : Guerrier hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5331
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5331;
-- OLD name : Chevaucheur des vagues hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5332
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur des vagues Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5332;
-- OLD name : Garde-serpent hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5333
UPDATE `creature_template_locale` SET `Name` = 'Garde-serpent Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5333;
-- OLD name : Myrmidon hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5334
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5334;
-- OLD name : Hurleuse hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5335
UPDATE `creature_template_locale` SET `Name` = 'Hurleuse Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5335;
-- OLD name : Ensorceleuse hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5336
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleuse Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5336;
-- OLD name : Sirène hainecrête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5337
UPDATE `creature_template_locale` SET `Name` = 'Sirène Hainecrête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5337;
-- OLD name : Gardien des rêves Langue-Fourchue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5348
UPDATE `creature_template_locale` SET `Name` = 'Gardien des rêves Langue-fourchue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5348;
-- OLD name : Harpie ruissenord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5362
UPDATE `creature_template_locale` SET `Name` = 'Harpie Ruissenord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5362;
-- OLD name : Volplume ruissenord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5363
UPDATE `creature_template_locale` SET `Name` = 'Volplume Ruissenord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5363;
-- OLD name : Pourfendeuse ruissenord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5364
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeuse Ruissenord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5364;
-- OLD name : Imploratrice céleste ruissenord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5366
UPDATE `creature_template_locale` SET `Name` = 'Imploratrice céleste Ruissenord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5366;
-- OLD subname : Maître des joailliers et fournitures
-- Source : https://www.wowhead.com/wotlk/fr/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Ligue des explorateurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5388;
-- OLD name : Sage Coureur-Pâle (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5390
UPDATE `creature_template_locale` SET `Name` = 'Sage Coureur-pâle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5390;
-- OLD name : Moissonneur asservi
-- Source : https://www.wowhead.com/wotlk/fr/npc=5409
UPDATE `creature_template_locale` SET `Name` = 'Nuée des moissons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5409;
-- OLD name : Gurda Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5412
UPDATE `creature_template_locale` SET `Name` = 'Gurda Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5412;
-- OLD name : Scorpide traquedune
-- Source : https://www.wowhead.com/wotlk/fr/npc=5424
UPDATE `creature_template_locale` SET `Name` = 'Scorpide des sables',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5424;
-- OLD name : Requin des sables
-- Source : https://www.wowhead.com/wotlk/fr/npc=5435
UPDATE `creature_template_locale` SET `Name` = 'Requin du sable',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5435;
-- OLD name : Grouillant Hazzali
-- Source : https://www.wowhead.com/wotlk/fr/npc=5451
UPDATE `creature_template_locale` SET `Name` = 'Traînard Hazzali',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5451;
-- OLD name : Ogre cognedune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5471
UPDATE `creature_template_locale` SET `Name` = 'Ogre Cognedune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5471;
-- OLD name : Massacreur cognedune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5472
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Cognedune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5472;
-- OLD name : Ogre-mage cognedune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5473
UPDATE `creature_template_locale` SET `Name` = 'Ogre-mage Cognedune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5473;
-- OLD name : Brute cognedune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5474
UPDATE `creature_template_locale` SET `Name` = 'Brute Cognedune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5474;
-- OLD name : Démoniste cognedune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5475
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Cognedune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5475;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=5503
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5503;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=5507
UPDATE `creature_template_locale` SET `Title` = 'Entraîneur de haut-trotteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5507;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5519
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5519;
-- OLD subname : Marchand de feux d’artifice
-- Source : https://www.wowhead.com/wotlk/fr/npc=5569
UPDATE `creature_template_locale` SET `Title` = 'Marchand de feux d''artifice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5569;
-- OLD name : Bruuk Barbe-d’Orge
-- Source : https://www.wowhead.com/wotlk/fr/npc=5570
UPDATE `creature_template_locale` SET `Name` = 'Bruuk Barbe-d''orge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5570;
-- OLD name : Kun Yeux-Jaunes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5599
UPDATE `creature_template_locale` SET `Name` = 'Kun Yeux-jaunes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5599;
-- OLD name : Voleur bat-le-désert (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5615
UPDATE `creature_template_locale` SET `Name` = 'Voleur Bat-le-désert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5615;
-- OLD name : Larron bat-le-désert (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5616
UPDATE `creature_template_locale` SET `Name` = 'Larron Bat-le-désert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5616;
-- OLD name : Mage de l'ombre bat-le-désert (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5617
UPDATE `creature_template_locale` SET `Name` = 'Mage de l''ombre Bat-le-désert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5617;
-- OLD name : Mannequin d’entraînement de Fossoyeuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=5652
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement de Fossoyeuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5652;
-- OLD name : Comar Villard
-- Source : https://www.wowhead.com/wotlk/fr/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Corma Villard',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5683;
-- OLD name : Projection de Comar Villard
-- Source : https://www.wowhead.com/wotlk/fr/npc=5692
UPDATE `creature_template_locale` SET `Name` = 'Projection de Corma Villard',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5692;
-- OLD subname : Esclave de Gerard
-- Source : https://www.wowhead.com/wotlk/fr/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Expérience de Gerard',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5697;
-- OLD name : Jammal'an le Prophète (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5710
UPDATE `creature_template_locale` SET `Name` = 'Jammal''an le prophète',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5710;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5757
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5757;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5758
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5758;
-- OLD name : Archidruide Hamuul Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5769
UPDATE `creature_template_locale` SET `Name` = 'Archidruide Hamuul Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5769;
-- OLD name : Nara Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5770
UPDATE `creature_template_locale` SET `Name` = 'Nara Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5770;
-- OLD name : Oeuf de rampant silithide
-- Source : https://www.wowhead.com/wotlk/fr/npc=5781
UPDATE `creature_template_locale` SET `Name` = 'Œuf de rampant silithide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5781;
-- OLD name : Maître de piste Miglen
-- Source : https://www.wowhead.com/wotlk/fr/npc=5792
UPDATE `creature_template_locale` SET `Name` = 'Maître Miglen',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5792;
-- OLD name : [PH] Party Bot (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 5801;
-- OLD name : Sergent Curtis
-- Source : https://www.wowhead.com/wotlk/fr/npc=5809
UPDATE `creature_template_locale` SET `Name` = 'Commandant de la garde Zalaphil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5809;
-- OLD name : Capitaine Plate-Défense (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5824
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Plate-défense',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5824;
-- OLD name : Margol l'Enragé
-- Source : https://www.wowhead.com/wotlk/fr/npc=5833
UPDATE `creature_template_locale` SET `Name` = 'Margol l''Enragée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5833;
-- OLD name : Brise-Epieu
-- Source : https://www.wowhead.com/wotlk/fr/npc=5838
UPDATE `creature_template_locale` SET `Name` = 'Brise-épieu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5838;
-- OLD name : Géologue sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5839
UPDATE `creature_template_locale` SET `Name` = 'Géologue Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5839;
-- OLD name : Forge-vapeur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5840
UPDATE `creature_template_locale` SET `Name` = 'Forge-vapeur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5840;
-- OLD name : Esclavagiste sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5844
UPDATE `creature_template_locale` SET `Name` = 'Esclavagiste Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5844;
-- OLD name : Sous-chef sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5846
UPDATE `creature_template_locale` SET `Name` = 'Sous-chef Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5846;
-- OLD name : Golem de guerre trempé
-- Source : https://www.wowhead.com/wotlk/fr/npc=5853
UPDATE `creature_template_locale` SET `Name` = 'Golem de guerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5853;
-- OLD name : Chaman noir du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5860
UPDATE `creature_template_locale` SET `Name` = 'Chaman noir du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5860;
-- OLD name : Gardefeu du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5861
UPDATE `creature_template_locale` SET `Name` = 'Gardefeu du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5861;
-- OLD name : Géomancien du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5862
UPDATE `creature_template_locale` SET `Name` = 'Géomancien du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5862;
-- OLD name : Totem de force de la terre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5874
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5874;
-- OLD name : Prophétesse Plume-de-Corbeau (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5888
UPDATE `creature_template_locale` SET `Name` = 'Prophétesse Plume-de-corbeau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5888;
-- OLD name : Islen Oeil-des-Rivières (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5901
UPDATE `creature_template_locale` SET `Name` = 'Islen Oeil-des-rivières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5901;
-- OLD name : Prate Oeil-des-Nuages (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5905
UPDATE `creature_template_locale` SET `Name` = 'Prate Oeil-des-nuages',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5905;
-- OLD name : Xanis Tisseur-de-Flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5906
UPDATE `creature_template_locale` SET `Name` = 'Xanis Tisseur-de-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5906;
-- OLD name : Stoneskin Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=5919
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5919;
-- OLD name : Stoneskin Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=5920
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5920;
-- OLD name : Strength of Earth Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=5921
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5921;
-- OLD name : Strength of Earth Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=5922
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5922;
-- OLD name : Totem de purification du poison (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5923
UPDATE `creature_template_locale` SET `Name` = 'Totem de Purification du poison',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5923;
-- OLD name : Totem de résistance élémentaire
-- Source : https://www.wowhead.com/wotlk/fr/npc=5927
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5927;
-- OLD name : Tranchecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5934
UPDATE `creature_template_locale` SET `Name` = 'Tranchecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5934;
-- OLD name : Ferregard l’Invincible
-- Source : https://www.wowhead.com/wotlk/fr/npc=5935
UPDATE `creature_template_locale` SET `Name` = 'Ferregard l''Invincible',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5935;
-- OLD name : Uthan Eau-Plate (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5938
UPDATE `creature_template_locale` SET `Name` = 'Uthan Eau-plate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5938;
-- OLD name : Vira Jeune-Sabot (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5939
UPDATE `creature_template_locale` SET `Name` = 'Vira Jeune-sabot',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5939;
-- OLD name : Harn Jette-Loin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5940
UPDATE `creature_template_locale` SET `Name` = 'Harn Jette-loin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5940;
-- OLD subname : Fournisseur de tailleurs et de travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=5944
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de tailleur et de travailleur du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5944;
-- OLD name : Ogre cognepeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5974
UPDATE `creature_template_locale` SET `Name` = 'Ogre Cognepeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5974;
-- OLD name : Ogre-mage cognepeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5975
UPDATE `creature_template_locale` SET `Name` = 'Ogre-mage Cognepeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5975;
-- OLD name : Brute cognepeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5976
UPDATE `creature_template_locale` SET `Name` = 'Brute Cognepeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5976;
-- OLD name : Marteleur cognepeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5977
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Cognepeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5977;
-- OLD name : Démoniste cognepeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=5978
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Cognepeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5978;
-- OLD name : Racleur-d'os gangre-nourrisseur
-- Source : https://www.wowhead.com/wotlk/fr/npc=5983
UPDATE `creature_template_locale` SET `Name` = 'Racleur-d''os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5983;
-- OLD name : Sanglier cendre-crin
-- Source : https://www.wowhead.com/wotlk/fr/npc=5992
UPDATE `creature_template_locale` SET `Name` = 'Sanglier cendré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 5992;
-- OLD name : Ritualiste lige d'ombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Sectateur lige d''ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6004;
-- OLD name : Lige d'ombre tisseur d’’effroi
-- Source : https://www.wowhead.com/wotlk/fr/npc=6009
UPDATE `creature_template_locale` SET `Name` = 'Lige d''ombre tisseur d''effroi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6009;
-- OLD name : Flametongue Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=6012
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6012;
-- OLD name : Totem de protection élémentaire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6016
UPDATE `creature_template_locale` SET `Name` = 'Totem de Protection élémentaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6016;
-- OLD name : Esprit de sanglier
-- Source : https://www.wowhead.com/wotlk/fr/npc=6021
UPDATE `creature_template_locale` SET `Name` = 'Esprit du Sanglier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6021;
-- OLD name : Demi-liche bien-née
-- Source : https://www.wowhead.com/wotlk/fr/npc=6117
UPDATE `creature_template_locale` SET `Name` = 'Jeune liche bien-née',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6117;
-- OLD name : Espion sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6123
UPDATE `creature_template_locale` SET `Name` = 'Espion Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6123;
-- OLD subname : Capitaine des Sombrefers
-- Source : https://www.wowhead.com/wotlk/fr/npc=6124
UPDATE `creature_template_locale` SET `Title` = 'Capitaine des Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6124;
-- OLD name : Claqueur arkkoran (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6135
UPDATE `creature_template_locale` SET `Name` = 'Claqueur Arkkoran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6135;
-- OLD name : Marche-boue arkkoran
-- Source : https://www.wowhead.com/wotlk/fr/npc=6136
UPDATE `creature_template_locale` SET `Name` = 'Habitant du bourbier Arkkoran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6136;
-- OLD name : Pinceur arkkoran (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6137
UPDATE `creature_template_locale` SET `Name` = 'Pinceur Arkkoran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6137;
-- OLD name : Oracle arkkoran (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6138
UPDATE `creature_template_locale` SET `Name` = 'Oracle Arkkoran',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6138;
-- OLD name : Planeur de Haut-Perchoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6139
UPDATE `creature_template_locale` SET `Name` = 'Planeur de Haut-perchoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6139;
-- OLD name : Planeur aile-fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6141
UPDATE `creature_template_locale` SET `Name` = 'Planeur Aile-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6141;
-- OLD name : Serviteur d’Arkkoroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=6143
UPDATE `creature_template_locale` SET `Name` = 'Servant d''Arkkoroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6143;
-- OLD name : Fils d’Arkkoroc
-- Source : https://www.wowhead.com/wotlk/fr/npc=6144
UPDATE `creature_template_locale` SET `Name` = 'Fils d''Arkkoroc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6144;
-- OLD name : Banc de poisson
-- Source : https://www.wowhead.com/wotlk/fr/npc=6145
UPDATE `creature_template_locale` SET `Name` = 'Banc de poissons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6145;
-- OLD name : Guide grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6184
UPDATE `creature_template_locale` SET `Name` = 'Guide Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6184;
-- OLD name : Guerrier grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6185
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6185;
-- OLD name : Totémique grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6186
UPDATE `creature_template_locale` SET `Name` = 'Totémique Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6186;
-- OLD name : Protecteur grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6187
UPDATE `creature_template_locale` SET `Name` = 'Protecteur Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6187;
-- OLD name : Chaman grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6188
UPDATE `creature_template_locale` SET `Name` = 'Chaman Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6188;
-- OLD name : Ursa grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6189
UPDATE `creature_template_locale` SET `Name` = 'Ursa Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6189;
-- OLD name : Guerrier fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6190
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6190;
-- OLD name : Hurleuse fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6193
UPDATE `creature_template_locale` SET `Name` = 'Hurleuse Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6193;
-- OLD name : Garde-serpent fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6194
UPDATE `creature_template_locale` SET `Name` = 'Garde-serpent Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6194;
-- OLD name : Sirène fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6195
UPDATE `creature_template_locale` SET `Name` = 'Sirène Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6195;
-- OLD name : Myrmidon fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6196
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6196;
-- OLD name : Ensorceleuse fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6197
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleuse Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6197;
-- OLD name : Implorateur de l’enfer Legashi
-- Source : https://www.wowhead.com/wotlk/fr/npc=6202
UPDATE `creature_template_locale` SET `Name` = 'Prêtre noir Legashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6202;
-- OLD name : Agent sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6212
UPDATE `creature_template_locale` SET `Name` = 'Agent Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6212;
-- OLD name : Ambassadeur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6228
UPDATE `creature_template_locale` SET `Name` = 'Ambassadeur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6228;
-- OLD name : Annulateur d’Arcane X-21
-- Source : https://www.wowhead.com/wotlk/fr/npc=6232
UPDATE `creature_template_locale` SET `Name` = 'Annulateur d''Arcane X-21',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6232;
-- OLD name : Bailor Main-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6241
UPDATE `creature_template_locale` SET `Name` = 'Bailor Main-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6241;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=6286
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6286;
-- OLD name : Yonn Entaille-Profonde (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6290
UPDATE `creature_template_locale` SET `Name` = 'Yonn Entaille-profonde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6290;
-- OLD name : Ecorchepierre Balthus
-- Source : https://www.wowhead.com/wotlk/fr/npc=6291
UPDATE `creature_template_locale` SET `Name` = 'Balthus Ecorchepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6291;
-- OLD name : Jeune vandale des flots (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6347
UPDATE `creature_template_locale` SET `Name` = 'Jeune Vandale des flots',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6347;
-- OLD name : Cylina Sombrecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=6374
UPDATE `creature_template_locale` SET `Name` = 'Cylina Sombrecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6374;
-- OLD name : Squelette de Zanzil
-- Source : https://www.wowhead.com/wotlk/fr/npc=6388
UPDATE `creature_template_locale` SET `Name` = 'Squelette zanzil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6388;
-- OLD name : Guerrier du hangar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6391
UPDATE `creature_template_locale` SET `Name` = 'Guerrier du Hangar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6391;
-- OLD name : Infirmier du hangar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6392
UPDATE `creature_template_locale` SET `Name` = 'Infirmier du Hangar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6392;
-- OLD name : Henen Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6393
UPDATE `creature_template_locale` SET `Name` = 'Henen Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6393;
-- OLD name : Ruga Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6394
UPDATE `creature_template_locale` SET `Name` = 'Ruga Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6394;
-- OLD name : Technicien du hangar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6407
UPDATE `creature_template_locale` SET `Name` = 'Technicien du Hangar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6407;
-- OLD name : Orm Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6410
UPDATE `creature_template_locale` SET `Name` = 'Orm Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6410;
-- OLD name : Azshir le Sans-Sommeil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6490
UPDATE `creature_template_locale` SET `Name` = 'Azshir le Sans-sommeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6490;
-- OLD name : Flagellant pétale-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6509
UPDATE `creature_template_locale` SET `Name` = 'Flagellant Pétale-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6509;
-- OLD name : Ecorcheur pétale-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6510
UPDATE `creature_template_locale` SET `Name` = 'Ecorcheur Pétale-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6510;
-- OLD name : Batteur pétale-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6511
UPDATE `creature_template_locale` SET `Name` = 'Batteur Pétale-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6511;
-- OLD name : Piégeur pétale-de-sang
-- Source : https://www.wowhead.com/wotlk/fr/npc=6512
UPDATE `creature_template_locale` SET `Name` = 'Trappeur Pétale-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6512;
-- OLD name : Ecrabouilleur d’Un’Goro
-- Source : https://www.wowhead.com/wotlk/fr/npc=6513
UPDATE `creature_template_locale` SET `Name` = 'Marteleur d''Un''Goro',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6513;
-- OLD name : Fusilier sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6523
UPDATE `creature_template_locale` SET `Name` = 'Fusilier Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6523;
-- OLD name : Monnos l’Ancien
-- Source : https://www.wowhead.com/wotlk/fr/npc=6646
UPDATE `creature_template_locale` SET `Name` = 'Monnos l''Ancien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6646;
-- OLD name : Johnson « le Brave » forme humaine
-- Source : https://www.wowhead.com/wotlk/fr/npc=6666
UPDATE `creature_template_locale` SET `Name` = 'Johnson "le Brave" forme humaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6666;
-- OLD subname : Second du navire
-- Source : https://www.wowhead.com/wotlk/fr/npc=6669
UPDATE `creature_template_locale` SET `Title` = 'Le premier officier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6669;
-- OLD name : Voltij Rafistépingle, subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=6730
UPDATE `creature_template_locale` SET `Name` = 'Jinky Rafistépingle',`Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6730;
-- OLD name : Cogneur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6733
UPDATE `creature_template_locale` SET `Name` = 'Cogneur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6733;
-- OLD name : Antur Terre-des-Friches (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6775
UPDATE `creature_template_locale` SET `Name` = 'Antur Terre-des-friches',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6775;
-- OLD name : Magrin Crin-des-Rivières (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=6776
UPDATE `creature_template_locale` SET `Name` = 'Magrin Crin-des-rivières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6776;
-- OLD subname : Aubergiste assistante
-- Source : https://www.wowhead.com/wotlk/fr/npc=6778
UPDATE `creature_template_locale` SET `Title` = 'Assistante de l''aubergiste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6778;
-- OLD name : [INUTILISÉ] Lorek Belm (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6783;
-- OLD name : Crabe des rivages
-- Source : https://www.wowhead.com/wotlk/fr/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Crabe',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6827;
-- OLD name : Maître des docks
-- Source : https://www.wowhead.com/wotlk/fr/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Maître des docks défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6846;
-- OLD name : Garde du corps
-- Source : https://www.wowhead.com/wotlk/fr/npc=6866
UPDATE `creature_template_locale` SET `Name` = 'Garde du corps défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6866;
-- OLD name : Sethir l’Ancien
-- Source : https://www.wowhead.com/wotlk/fr/npc=6909
UPDATE `creature_template_locale` SET `Name` = 'Sethir l''Ancien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6909;
-- OLD name : Restes d’un paladin
-- Source : https://www.wowhead.com/wotlk/fr/npc=6912
UPDATE `creature_template_locale` SET `Name` = 'Restes d''un paladin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6912;
-- OLD name : Portefaix
-- Source : https://www.wowhead.com/wotlk/fr/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Portefaix défias',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6927;
-- OLD name : Esprit des Marais
-- Source : https://www.wowhead.com/wotlk/fr/npc=6932
UPDATE `creature_template_locale` SET `Name` = 'Esprit du marais',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 6932;
-- OLD name : Assassin rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7006
UPDATE `creature_template_locale` SET `Name` = 'Assassin Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7006;
-- OLD name : Saccageur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7008
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7008;
-- OLD name : Garde rochenoire
-- Source : https://www.wowhead.com/wotlk/fr/npc=7013
UPDATE `creature_template_locale` SET `Name` = 'Déchaîné de Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7013;
-- OLD name : Soldat rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7025
UPDATE `creature_template_locale` SET `Name` = 'Soldat Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7025;
-- OLD name : Ensorceleur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7026
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7026;
-- OLD name : Pourfendeur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7027
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7027;
-- OLD name : Démoniste rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7028
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7028;
-- OLD name : Maître de guerre rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7029
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7029;
-- OLD name : Géologue ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7030
UPDATE `creature_template_locale` SET `Name` = 'Géologue Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7030;
-- OLD name : Ogre brûlentrailles (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7033
UPDATE `creature_template_locale` SET `Name` = 'Ogre Brûlentrailles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7033;
-- OLD name : Ogre-mage brûlentrailles (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7034
UPDATE `creature_template_locale` SET `Name` = 'Ogre-mage Brûlentrailles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7034;
-- OLD name : Brute brûlentrailles (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7035
UPDATE `creature_template_locale` SET `Name` = 'Brute Brûlentrailles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7035;
-- OLD name : Worg rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7055
UPDATE `creature_template_locale` SET `Name` = 'Worg Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7055;
-- OLD name : Factionnaire défias de la tour
-- Source : https://www.wowhead.com/wotlk/fr/npc=7056
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle défias de la tour',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7056;
-- OLD name : Embusqué ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7091
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7091;
-- OLD name : Satyre jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7105
UPDATE `creature_template_locale` SET `Name` = 'Satyre Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7105;
-- OLD name : Voleur jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7106
UPDATE `creature_template_locale` SET `Name` = 'Voleur Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7106;
-- OLD name : Entourloupeur jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7107
UPDATE `creature_template_locale` SET `Name` = 'Entourloupeur Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7107;
-- OLD name : Traître jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7108
UPDATE `creature_template_locale` SET `Name` = 'Traître Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7108;
-- OLD name : Gangrelige jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7109
UPDATE `creature_template_locale` SET `Name` = 'Gangrelige Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7109;
-- OLD name : Traqueur des ombres jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7110
UPDATE `creature_template_locale` SET `Name` = 'Traqueur des ombres Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7110;
-- OLD name : Implorateur de l'enfer jadefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7111
UPDATE `creature_template_locale` SET `Name` = 'Implorateur de l''enfer Jadefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7111;
-- OLD name : Horreur nocive
-- Source : https://www.wowhead.com/wotlk/fr/npc=7133
UPDATE `creature_template_locale` SET `Name` = 'Horreur venimeuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7133;
-- OLD name : Ecrabouilleur arbrefer
-- Source : https://www.wowhead.com/wotlk/fr/npc=7139
UPDATE `creature_template_locale` SET `Name` = 'Arbrefer marteleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7139;
-- OLD name : Guetteur flétri
-- Source : https://www.wowhead.com/wotlk/fr/npc=7151
UPDATE `creature_template_locale` SET `Name` = 'Gardien flétri',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7151;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=7174
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7174;
-- OLD name : Embusqué cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7175
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7175;
-- OLD name : Ancien gardien en pierre
-- Source : https://www.wowhead.com/wotlk/fr/npc=7206
UPDATE `creature_template_locale` SET `Name` = 'Ancien gardien des pierres',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7206;
-- OLD name : Shayis Furie-d’Acier, subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=7230
UPDATE `creature_template_locale` SET `Name` = 'Shayis Furie-d''acier',`Title` = 'Maître des fabricants d''armure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7230;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7231;
-- OLD name : Borgus Main-d’Acier, subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=7232
UPDATE `creature_template_locale` SET `Name` = 'Borgus Main-d''acier',`Title` = 'Maître des fabricants d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7232;
-- OLD name : Mystique pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7235
UPDATE `creature_template_locale` SET `Name` = 'Mystique Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7235;
-- OLD name : Zombie furie-des-sables (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7270
UPDATE `creature_template_locale` SET `Name` = 'Zombie Furie-des-sables',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7270;
-- OLD name : Héros de Zul'Farrak mort
-- Source : https://www.wowhead.com/wotlk/fr/npc=7276
UPDATE `creature_template_locale` SET `Name` = 'Héros mort de Zul''Farrak',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7276;
-- OLD name : Tireur de précision ombreforge
-- Source : https://www.wowhead.com/wotlk/fr/npc=7290
UPDATE `creature_template_locale` SET `Name` = 'Tireur d''élite Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7290;
-- OLD name : Marteleur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7320
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7320;
-- OLD name : Tisseur de flammes cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7321
UPDATE `creature_template_locale` SET `Name` = 'Tisseur de flammes Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7321;
-- OLD name : Sanglier de guerre horrifique
-- Source : https://www.wowhead.com/wotlk/fr/npc=7334
UPDATE `creature_template_locale` SET `Name` = 'Horreur sanglier de guerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7334;
-- OLD name : Amnennar le Porte-Froid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7358
UPDATE `creature_template_locale` SET `Name` = 'Amnennar le Porte-froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7358;
-- OLD name : Stoneskin Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=7366
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7366;
-- OLD name : Stoneskin Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=7367
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7367;
-- OLD name : Stoneskin Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=7368
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7368;
-- OLD name : Ombre sans repos
-- Source : https://www.wowhead.com/wotlk/fr/npc=7370
UPDATE `creature_template_locale` SET `Name` = 'Ame errante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7370;
-- OLD name : Esprit de courroux
-- Source : https://www.wowhead.com/wotlk/fr/npc=7375
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Colère',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7375;
-- OLD name : Chat tigré roux
-- Source : https://www.wowhead.com/wotlk/fr/npc=7382
UPDATE `creature_template_locale` SET `Name` = 'Chat tigré orangé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7382;
-- OLD name : Cafard de Fossoyeuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Cafard',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7395;
-- OLD name : Stoneclaw Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=7398
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7398;
-- OLD name : Stoneclaw Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=7399
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7399;
-- OLD name : Searing Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=7400
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7400;
-- OLD name : Searing Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=7402
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7402;
-- OLD name : Strength of Earth Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=7403
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7403;
-- OLD name : Frost Resistance Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7412
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Givre II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7412;
-- OLD name : Frost Resistance Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7413
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Givre III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7413;
-- OLD name : Mana Spring Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7414
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7414;
-- OLD name : Mana Spring Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7415
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7415;
-- OLD name : Mana Spring Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=7416
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7416;
-- OLD name : Flametongue Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7423
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7423;
-- OLD name : Fire Resistance Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7424
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7424;
-- OLD name : Fire Resistance Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7425
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7425;
-- OLD name : Taim Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7427
UPDATE `creature_template_locale` SET `Name` = 'Taim Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7427;
-- OLD name : Chouette de Berceau-de-l'Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=7455
UPDATE `creature_template_locale` SET `Name` = 'Chouette du Berceau-de-l''Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7455;
-- OLD name : Hurleuse de Berceau-de-l'Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=7456
UPDATE `creature_template_locale` SET `Name` = 'Hurleur du Berceau-de-l''Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7456;
-- OLD name : Yéti chardon de glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7458
UPDATE `creature_template_locale` SET `Name` = 'Yéti Chardon de glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7458;
-- OLD name : Matriarche chardon de glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7459
UPDATE `creature_template_locale` SET `Name` = 'Matriarche Chardon de glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7459;
-- OLD name : Patriarche chardon de glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7460
UPDATE `creature_template_locale` SET `Name` = 'Patriarche Chardon de glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7460;
-- OLD name : Magma Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7464
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7464;
-- OLD name : Magma Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7465
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7465;
-- OLD name : Magma Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=7466
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7466;
-- OLD name : Nature Resistance Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7468
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance à la Nature II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7468;
-- OLD name : Nature Resistance Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7469
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance à la Nature III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7469;
-- OLD name : Windfury Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7483
UPDATE `creature_template_locale` SET `Name` = 'Totem Furie-des-vents II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7483;
-- OLD name : Windfury Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=7484
UPDATE `creature_template_locale` SET `Name` = 'Totem Furie-des-vents III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7484;
-- OLD name : Grace of Air Totem
-- Source : https://www.wowhead.com/wotlk/fr/npc=7486
UPDATE `creature_template_locale` SET `Name` = 'Totem de Grâce aérienne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7486;
-- OLD name : Grace of Air Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=7487
UPDATE `creature_template_locale` SET `Name` = 'Totem de Grâce aérienne II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7487;
-- OLD name : Nécrogarde des Pins-Argentés
-- Source : https://www.wowhead.com/wotlk/fr/npc=7489
UPDATE `creature_template_locale` SET `Name` = 'Nécrogarde des Pins argentés',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7489;
-- OLD name : Maître des travailleurs du cuir de dragon universel, subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7525
UPDATE `creature_template_locale` SET `Name` = 'Maître des travailleurs du cuir de dragon',`Title` = 'Maître des travailleurs du cuir d''écailles de dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7525;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7526
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir élémentaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7526;
-- OLD name : Maître des travailleurs du cuir tribal universel, subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7528
UPDATE `creature_template_locale` SET `Name` = 'Maître des travailleurs du cuir tribal',`Title` = 'Maître des travailleurs du cuir tribal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7528;
-- OLD name : Jeune dragonnet émeraude
-- Source : https://www.wowhead.com/wotlk/fr/npc=7545
UPDATE `creature_template_locale` SET `Name` = 'Jeune dragonnet d''émeraude',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7545;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/fr/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (7558, 'frFR','Lapin',NULL,0);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/fr/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (7559, 'frFR','Lapin tacheté',NULL,0);
-- OLD name : Oro Crève-Oeil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7606
UPDATE `creature_template_locale` SET `Name` = 'Oro Crève-oeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7606;
-- OLD name : Chevalier de la mort test de Slim
-- Source : https://www.wowhead.com/wotlk/fr/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7624;
-- OLD name : Léopard
-- Source : https://www.wowhead.com/wotlk/fr/npc=7684
UPDATE `creature_template_locale` SET `Name` = 'Tigre (jaune)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7684;
-- OLD name : Tigre du Bengale
-- Source : https://www.wowhead.com/wotlk/fr/npc=7686
UPDATE `creature_template_locale` SET `Name` = 'Tigre (rouge)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7686;
-- OLD name : Sabre-de-nuit tacheté
-- Source : https://www.wowhead.com/wotlk/fr/npc=7689
UPDATE `creature_template_locale` SET `Name` = 'Tigre (tacheté noir)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7689;
-- OLD name : Raptor d'obsidienne
-- Source : https://www.wowhead.com/wotlk/fr/npc=7703
UPDATE `creature_template_locale` SET `Name` = 'Raptor (obsidienne)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7703;
-- OLD name : Raptor rouge tacheté
-- Source : https://www.wowhead.com/wotlk/fr/npc=7704
UPDATE `creature_template_locale` SET `Name` = 'Raptor (cramoisi)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7704;
-- OLD name : Raptor ivoire
-- Source : https://www.wowhead.com/wotlk/fr/npc=7706
UPDATE `creature_template_locale` SET `Name` = 'Raptor (ivoire)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7706;
-- OLD name : Byula, subname : Ancien aubergiste
-- Source : https://www.wowhead.com/wotlk/fr/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Aubergiste Byula',`Title` = 'Aubergiste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7714;
-- OLD name : Chasseur corrompu fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=7767
UPDATE `creature_template_locale` SET `Name` = 'Chasseur corrompu Fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7767;
-- OLD name : Sanglant fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=7768
UPDATE `creature_template_locale` SET `Name` = 'Sanglant fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7768;
-- OLD name : Talo Sabot-de-Ronce (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7776
UPDATE `creature_template_locale` SET `Name` = 'Talo Sabot-de-ronce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7776;
-- OLD subname : Troll fanécorce
-- Source : https://www.wowhead.com/wotlk/fr/npc=7780
UPDATE `creature_template_locale` SET `Title` = 'Troll Fânécorce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7780;
-- OLD name : Manœuvre furie-des-sables
-- Source : https://www.wowhead.com/wotlk/fr/npc=7788
UPDATE `creature_template_locale` SET `Name` = 'Manoeuvre furie-des-sables',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7788;
-- OLD name : Bœuf
-- Source : https://www.wowhead.com/wotlk/fr/npc=7793
UPDATE `creature_template_locale` SET `Name` = 'Boeuf',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7793;
-- OLD name : Embusqué vilebranche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7809
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Vilebranche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7809;
-- OLD name : Bera Martel-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7823
UPDATE `creature_template_locale` SET `Name` = 'Bera Martel-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7823;
-- OLD name : Caliph Dard-de-Scorpide (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7847
UPDATE `creature_template_locale` SET `Name` = 'Caliph Dard-de-scorpide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7847;
-- OLD name : Griffe farouche en maraude
-- Source : https://www.wowhead.com/wotlk/fr/npc=7848
UPDATE `creature_template_locale` SET `Name` = 'Griffe farouche patibulaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7848;
-- OLD name : Soldat d'élite de Rempart-du-Néant
-- Source : https://www.wowhead.com/wotlk/fr/npc=7851
UPDATE `creature_template_locale` SET `Name` = 'Elite de Rempart-du-Néant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7851;
-- OLD name : Jangdor Rôdeur-Agile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7854
UPDATE `creature_template_locale` SET `Name` = 'Jangdor Rôdeur-agile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7854;
-- OLD name : Factionnaire marteau-hardi
-- Source : https://www.wowhead.com/wotlk/fr/npc=7865
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle marteau-hardi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7865;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7866
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir d''écailles de dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7866;
-- OLD name : Thorkaf Oeil-de-Dragon, subname : Maître des travailleurs du cuir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7867
UPDATE `creature_template_locale` SET `Name` = 'Thorkaf Oeil-de-dragon',`Title` = 'Maître des travailleurs du cuir d''écailles de dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7867;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7868
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir élémentaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7868;
-- OLD name : Brumn Sabot-d’Hiver, subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7869
UPDATE `creature_template_locale` SET `Name` = 'Brumn Sabot-d''hiver',`Title` = 'Maître des travailleurs du cuir élémentaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7869;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir tribal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7870;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir tribal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7871;
-- OLD name : Hadoken Rôdeur-Agile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7875
UPDATE `creature_template_locale` SET `Name` = 'Hadoken Rôdeur-agile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7875;
-- OLD name : André Barbe-en-Feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7883
UPDATE `creature_template_locale` SET `Name` = 'André Barbe-en-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7883;
-- OLD name : Maître de guerre fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7885
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7885;
-- OLD name : Enchanteresse fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7886
UPDATE `creature_template_locale` SET `Name` = 'Enchanteresse Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7886;
-- OLD name : Boucanier des mers du Sud (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=7896
UPDATE `creature_template_locale` SET `Name` = 'Boucanier des Mers du sud',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7896;
-- OLD name : Pirate chasseur de trésors
-- Source : https://www.wowhead.com/wotlk/fr/npc=7899
UPDATE `creature_template_locale` SET `Name` = 'Pirate chasseur de trésor',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7899;
-- OLD name : Garde de Comté-de-l’Or
-- Source : https://www.wowhead.com/wotlk/fr/npc=7906
UPDATE `creature_template_locale` SET `Name` = 'Garde de Comté-de-l''or',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7906;
-- OLD name : Lyon Cœur-de-Montagne
-- Source : https://www.wowhead.com/wotlk/fr/npc=7936
UPDATE `creature_template_locale` SET `Name` = 'Lyon Coeur-de-montagne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7936;
-- OLD subname : Instructeur de monte
-- Source : https://www.wowhead.com/wotlk/fr/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Pilote de mécanotrotteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7954;
-- OLD name : Brave du camp Narache
-- Source : https://www.wowhead.com/wotlk/fr/npc=7975
UPDATE `creature_template_locale` SET `Name` = 'Protecteur de Mulgore',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 7975;
-- OLD name : Rampeur de Sul’lithuz
-- Source : https://www.wowhead.com/wotlk/fr/npc=8095
UPDATE `creature_template_locale` SET `Name` = 'Rampeur de Sul''lithuz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8095;
-- OLD name : Garde de la brigade de la marche de l'Ouest, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/fr/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Protecteur du Peuple',`Title` = 'Milice du peuple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8096;
-- OLD name : Abomination Sul’lithuz
-- Source : https://www.wowhead.com/wotlk/fr/npc=8120
UPDATE `creature_template_locale` SET `Name` = 'Abomination Sul''lithuz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8120;
-- OLD name : Jeune Sul’lithuz
-- Source : https://www.wowhead.com/wotlk/fr/npc=8130
UPDATE `creature_template_locale` SET `Name` = 'Jeune Sul''lithuz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8130;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=8131
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8131;
-- OLD name : Rejeton de Sul’lithuz
-- Source : https://www.wowhead.com/wotlk/fr/npc=8138
UPDATE `creature_template_locale` SET `Name` = 'Rejeton de Sul''lithuz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8138;
-- OLD name : Capitaine Cannelisse
-- Source : https://www.wowhead.com/wotlk/fr/npc=8141
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Evencane',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8141;
-- OLD name : Jannos Sabot-Léger (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8142
UPDATE `creature_template_locale` SET `Name` = 'Jannos Sabot-léger',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8142;
-- OLD name : Kulleg Corne-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8144
UPDATE `creature_template_locale` SET `Name` = 'Kulleg Corne-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8144;
-- OLD name : Sheendra Hautes-Herbes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8145
UPDATE `creature_template_locale` SET `Name` = 'Sheendra Hautes-herbes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8145;
-- OLD name : Brave du camp Mojache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8147
UPDATE `creature_template_locale` SET `Name` = 'Brave du Camp Mojache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8147;
-- OLD subname : Nourriture & boissons
-- Source : https://www.wowhead.com/wotlk/fr/npc=8148
UPDATE `creature_template_locale` SET `Title` = 'Nourriture & boisson',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8148;
-- OLD name : Gardien de Sul’lithuz
-- Source : https://www.wowhead.com/wotlk/fr/npc=8149
UPDATE `creature_template_locale` SET `Name` = 'Gardien de Sul''lithuz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8149;
-- OLD name : Narv Tanne-le-Cuir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8153
UPDATE `creature_template_locale` SET `Name` = 'Narv Tanne-le-cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8153;
-- OLD name : Worb Point-Solide (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8159
UPDATE `creature_template_locale` SET `Name` = 'Worb Point-solide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8159;
-- OLD name : Braisaile
-- Source : https://www.wowhead.com/wotlk/fr/npc=8207
UPDATE `creature_template_locale` SET `Name` = 'Grand oiseau de feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8207;
-- OLD name : Flétricœur le Traqueur
-- Source : https://www.wowhead.com/wotlk/fr/npc=8218
UPDATE `creature_template_locale` SET `Name` = 'Flétricoeur le Traqueur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8218;
-- OLD name : Maître des esclaves Cœur-Noir
-- Source : https://www.wowhead.com/wotlk/fr/npc=8283
UPDATE `creature_template_locale` SET `Name` = 'Maître des esclaves Coeur-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8283;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=8306
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8306;
-- OLD name : Tarban Blé-du-Foyer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8307
UPDATE `creature_template_locale` SET `Name` = 'Tarban Blé-du-foyer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8307;
-- OLD name : Trancheur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8337
UPDATE `creature_template_locale` SET `Name` = 'Trancheur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8337;
-- OLD name : Tireur d'élite sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8338
UPDATE `creature_template_locale` SET `Name` = 'Tireur d''élite Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8338;
-- OLD name : Shadi Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8363
UPDATE `creature_template_locale` SET `Name` = 'Shadi Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8363;
-- OLD name : Mura Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8385
UPDATE `creature_template_locale` SET `Name` = 'Mura Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8385;
-- OLD name : Thersa Chant-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8393
UPDATE `creature_template_locale` SET `Name` = 'Thersa Chant-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8393;
-- OLD name : Falla Vent-de-Sagesse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8418
UPDATE `creature_template_locale` SET `Name` = 'Falla Vent-de-sagesse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8418;
-- OLD name : Idolâtre du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8419
UPDATE `creature_template_locale` SET `Name` = 'Idolâtre du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8419;
-- OLD name : Sbire hakkari (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8437
UPDATE `creature_template_locale` SET `Name` = 'Sbire Hakkari',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8437;
-- OLD name : Garde de sang hakkari
-- Source : https://www.wowhead.com/wotlk/fr/npc=8438
UPDATE `creature_template_locale` SET `Name` = 'Garde de sang Hakkar''i',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8438;
-- OLD name : Braconnier ombresoie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8442
UPDATE `creature_template_locale` SET `Name` = 'Braconnier Ombresoie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8442;
-- OLD name : Kalaran Lamevent
-- Source : https://www.wowhead.com/wotlk/fr/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Velarok Lamevent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8479;
-- OLD name : Kalaran le Menteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Velarok le Menteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8480;
-- OLD name : Factionnaire sombrefer
-- Source : https://www.wowhead.com/wotlk/fr/npc=8504
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8504;
-- OLD name : Bûcheron déshérité
-- Source : https://www.wowhead.com/wotlk/fr/npc=8563
UPDATE `creature_template_locale` SET `Name` = 'Bûcheron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8563;
-- OLD name : Forestier déshérité
-- Source : https://www.wowhead.com/wotlk/fr/npc=8564
UPDATE `creature_template_locale` SET `Name` = 'Forestier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8564;
-- OLD name : Eclaireur déshérité
-- Source : https://www.wowhead.com/wotlk/fr/npc=8565
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8565;
-- OLD name : Guetteur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8566
UPDATE `creature_template_locale` SET `Name` = 'Guetteur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8566;
-- OLD name : Ag'tor Poing-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8576
UPDATE `creature_template_locale` SET `Name` = 'Ag''tor Poing-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8576;
-- OLD name : Grand mastiff pestiféré
-- Source : https://www.wowhead.com/wotlk/fr/npc=8599
UPDATE `creature_template_locale` SET `Name` = 'Mastiff pestiféré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8599;
-- OLD name : Esprit de hurleur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8612
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Hurleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8612;
-- OLD name : Veilleur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8637
UPDATE `creature_template_locale` SET `Name` = 'Veilleur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8637;
-- OLD name : Marche-soleil Saern
-- Source : https://www.wowhead.com/wotlk/fr/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Saern Cours-avec-fierté',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8664;
-- OLD name : Jeune Timmy
-- Source : https://www.wowhead.com/wotlk/fr/npc=8666
UPDATE `creature_template_locale` SET `Name` = 'P''tit Timmy',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8666;
-- OLD name : Entraîneur des Ingénieurs gobelin universel, subname : Entraîneur des ingénieurs gobelin
-- Source : https://www.wowhead.com/wotlk/fr/npc=8677
UPDATE `creature_template_locale` SET `Name` = 'Maître des Ingénieurs gobelin universel',`Title` = 'Maître des ingénieurs gobelin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8677;
-- OLD name : Jubie Gadgetaressort, subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=8678
UPDATE `creature_template_locale` SET `Name` = 'Jubie Gadgettaressort',`Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8678;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=8679
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8679;
-- OLD name : Ravageur brumaile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8764
UPDATE `creature_template_locale` SET `Name` = 'Ravageur Brumaile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8764;
-- OLD name : Monture squelette
-- Source : https://www.wowhead.com/wotlk/fr/npc=8884
UPDATE `creature_template_locale` SET `Name` = 'Cheval squelette',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8884;
-- OLD name : Surveillant ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8889
UPDATE `creature_template_locale` SET `Name` = 'Surveillant Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8889;
-- OLD name : Gardien ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8890
UPDATE `creature_template_locale` SET `Name` = 'Gardien Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8890;
-- OLD name : Garde ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8891
UPDATE `creature_template_locale` SET `Name` = 'Garde Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8891;
-- OLD name : Fantassin ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8892
UPDATE `creature_template_locale` SET `Name` = 'Fantassin Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8892;
-- OLD name : Soldat ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8893
UPDATE `creature_template_locale` SET `Name` = 'Soldat Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8893;
-- OLD name : Médecin ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8894
UPDATE `creature_template_locale` SET `Name` = 'Médecin Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8894;
-- OLD name : Officier ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8895
UPDATE `creature_template_locale` SET `Name` = 'Officier Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8895;
-- OLD name : Paysan ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8896
UPDATE `creature_template_locale` SET `Name` = 'Paysan Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8896;
-- OLD name : Maréchal ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8898
UPDATE `creature_template_locale` SET `Name` = 'Maréchal Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8898;
-- OLD name : Réserviste ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8901
UPDATE `creature_template_locale` SET `Name` = 'Réserviste Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8901;
-- OLD name : Citoyen ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8902
UPDATE `creature_template_locale` SET `Name` = 'Citoyen Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8902;
-- OLD name : Capitaine ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8903
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8903;
-- OLD name : Sénateur ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8904
UPDATE `creature_template_locale` SET `Name` = 'Sénateur Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8904;
-- OLD name : Emissaire du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8913
UPDATE `creature_template_locale` SET `Name` = 'Emissaire du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8913;
-- OLD name : Garde du corps du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8914
UPDATE `creature_template_locale` SET `Name` = 'Garde du corps du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8914;
-- OLD name : Drake rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8964
UPDATE `creature_template_locale` SET `Name` = 'Drake Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8964;
-- OLD name : Capitaine brûlentrailles (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=8980
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Brûlentrailles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 8980;
-- OLD name : Pyromancien Blé-du-Savoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9024
UPDATE `creature_template_locale` SET `Name` = 'Pyromancien Blé-du-savoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9024;
-- OLD name : Factionnaire du Bouclier balafré
-- Source : https://www.wowhead.com/wotlk/fr/npc=9044
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle du Bouclier balafré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9044;
-- OLD name : Bashana Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9087
UPDATE `creature_template_locale` SET `Name` = 'Bashana Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9087;
-- OLD name : Parasite pétale-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9157
UPDATE `creature_template_locale` SET `Name` = 'Parasite Pétale-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9157;
-- OLD name : Mage de bataille pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9197
UPDATE `creature_template_locale` SET `Name` = 'Mage de bataille Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9197;
-- OLD name : Mystique pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9198
UPDATE `creature_template_locale` SET `Name` = 'Mystique Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9198;
-- OLD name : Massacreur pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9199
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9199;
-- OLD name : Saccageur pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9200
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9200;
-- OLD name : Ogre-magus pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9201
UPDATE `creature_template_locale` SET `Name` = 'Ogre-magus Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9201;
-- OLD name : Chef de guerre pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9216
UPDATE `creature_template_locale` SET `Name` = 'Chef de guerre Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9216;
-- OLD name : Seigneur magus pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9217
UPDATE `creature_template_locale` SET `Name` = 'Seigneur magus Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9217;
-- OLD name : Seigneur de bataille pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9218
UPDATE `creature_template_locale` SET `Name` = 'Seigneur de bataille Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9218;
-- OLD name : Boucher pierre-du-pic (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9219
UPDATE `creature_template_locale` SET `Name` = 'Boucher Pierre-du-pic',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9219;
-- OLD name : Tisseur d’’ombre de Brandefeu
-- Source : https://www.wowhead.com/wotlk/fr/npc=9261
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''ombre de Brandefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9261;
-- OLD name : Tisseur d’’effroi de Brandefeu
-- Source : https://www.wowhead.com/wotlk/fr/npc=9263
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''effroi de Brandefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9263;
-- OLD name : Chasseur des ombres brûleronce
-- Source : https://www.wowhead.com/wotlk/fr/npc=9265
UPDATE `creature_template_locale` SET `Name` = 'Chasseur d''ombre brûleronce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9265;
-- OLD name : Fossile déterré
-- Source : https://www.wowhead.com/wotlk/fr/npc=9397
UPDATE `creature_template_locale` SET `Name` = 'Tempête vivante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9397;
-- OLD name : Seigneur de guerre Krom'zar
-- Source : https://www.wowhead.com/wotlk/fr/npc=9456
UPDATE `creature_template_locale` SET `Name` = 'Chef de guerre Krom''zar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9456;
-- OLD name : Soldat Rochenœud
-- Source : https://www.wowhead.com/wotlk/fr/npc=9503
UPDATE `creature_template_locale` SET `Name` = 'Soldat Rochenoeud',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9503;
-- OLD name : Embusqué rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9522
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9522;
-- OLD name : Maybess Brise-des-Rivières (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9529
UPDATE `creature_template_locale` SET `Name` = 'Maybess Brise-des-rivières',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9529;
-- OLD name : Cawind Trait-Précis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9548
UPDATE `creature_template_locale` SET `Name` = 'Cawind Trait-précis',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9548;
-- OLD name : Maître des talents des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=9581
UPDATE `creature_template_locale` SET `Name` = 'Maître des talents des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9581;
-- OLD name : Vétéran hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9583
UPDATE `creature_template_locale` SET `Name` = 'Vétéran Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9583;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=9584
UPDATE `creature_template_locale` SET `Title` = 'Maître tailleur du tisse-ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9584;
-- OLD name : Bannok Hache-Sinistre, subname : Champion de la légion Brandefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9596
UPDATE `creature_template_locale` SET `Name` = 'Bannok Hache-sinistre',`Title` = 'Champion de la légion de Brandefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9596;
-- OLD name : Ecumeur rochenoire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9605
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Rochenoire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9605;
-- OLD name : Jeune fée fléchetteuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9662
UPDATE `creature_template_locale` SET `Name` = 'Jeune Fée fléchetteuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9662;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=9676
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9676;
-- OLD name : Windwall Totem
-- Source : https://www.wowhead.com/wotlk/fr/npc=9687
UPDATE `creature_template_locale` SET `Name` = 'Totem de Mur des vents',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9687;
-- OLD name : Windwall Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=9688
UPDATE `creature_template_locale` SET `Name` = 'Totem de Mur des vents II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9688;
-- OLD name : Windwall Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=9689
UPDATE `creature_template_locale` SET `Name` = 'Totem de Mur des vents III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9689;
-- OLD name : Ecumeur hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9692
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9692;
-- OLD name : Evocateur hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9693
UPDATE `creature_template_locale` SET `Name` = 'Evocateur Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9693;
-- OLD name : Worg hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9696
UPDATE `creature_template_locale` SET `Name` = 'Worg Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9696;
-- OLD name : Combattant hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9716
UPDATE `creature_template_locale` SET `Name` = 'Combattant Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9716;
-- OLD name : Invocateur hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9717
UPDATE `creature_template_locale` SET `Name` = 'Invocateur Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9717;
-- OLD name : Tisseur d’effroi main-noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=9817
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''effroi Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9817;
-- OLD name : Invocateur main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9818
UPDATE `creature_template_locale` SET `Name` = 'Invocateur Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9818;
-- OLD name : Vétéran main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9819
UPDATE `creature_template_locale` SET `Name` = 'Vétéran Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9819;
-- OLD name : Garde-flammes ombreforge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9956
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes Ombreforge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9956;
-- OLD subname : Ancien maître des écuries
-- Source : https://www.wowhead.com/wotlk/fr/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Maître des écuries',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9983;
-- OLD name : Shyrka Mène-Loup (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=9986
UPDATE `creature_template_locale` SET `Name` = 'Shyrka Mène-loup',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 9986;
-- OLD name : Garde de Comté-du-Lac (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10037
UPDATE `creature_template_locale` SET `Name` = 'Garde de Comté-du-lac',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10037;
-- OLD name : Brave Corne-de-Lune (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10079
UPDATE `creature_template_locale` SET `Name` = 'Brave Corne-de-lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10079;
-- OLD name : Hesuwa Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10086
UPDATE `creature_template_locale` SET `Name` = 'Hesuwa Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10086;
-- OLD name : Mécanotrotteur vert fluo
-- Source : https://www.wowhead.com/wotlk/fr/npc=10178
UPDATE `creature_template_locale` SET `Name` = 'Mécatrotteur (vert fluo)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10178;
-- OLD name : Mécanotrotteur blanc modèle B
-- Source : https://www.wowhead.com/wotlk/fr/npc=10179
UPDATE `creature_template_locale` SET `Name` = 'Mécatrotteur (noir)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10179;
-- OLD name : Totem de feu lunaire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10183
UPDATE `creature_template_locale` SET `Name` = 'Totem de Feu lunaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10183;
-- OLD name : Jeune worg hache-sanglante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10221
UPDATE `creature_template_locale` SET `Name` = 'Jeune worg Hache-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10221;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=10237
UPDATE `creature_template_locale` SET `Title` = 'UNUSED',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10237;
-- OLD name : Rotgath Barbe-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10276
UPDATE `creature_template_locale` SET `Name` = 'Rotgath Barbe-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10276;
-- OLD name : Groum Barbe-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10277
UPDATE `creature_template_locale` SET `Name` = 'Groum Barbe-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10277;
-- OLD name : Thrag Sabot-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10278
UPDATE `creature_template_locale` SET `Name` = 'Thrag Sabot-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10278;
-- OLD subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10292
UPDATE `creature_template_locale` SET `Title` = 'Maître des combattants à la dague',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10292;
-- OLD subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10294
UPDATE `creature_template_locale` SET `Title` = 'Maître des armes de pugilat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10294;
-- OLD subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10297
UPDATE `creature_template_locale` SET `Title` = 'Maître des archers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10297;
-- OLD name : Acride
-- Source : https://www.wowhead.com/wotlk/fr/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Infiltrateur du Bouclier balafré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/fr/npc=10301
UPDATE `creature_template_locale` SET `Title` = 'Ligue des explorateurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10301;
-- OLD name : Orage Sabot-d’Ombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=10303
UPDATE `creature_template_locale` SET `Name` = 'Storm Sabot-d''ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10303;
-- OLD name : Geôlier main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10316
UPDATE `creature_template_locale` SET `Name` = 'Geôlier Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10316;
-- OLD name : Soldat d'élite main-noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=10317
UPDATE `creature_template_locale` SET `Name` = 'Elite Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10317;
-- OLD name : Assassin main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10318
UPDATE `creature_template_locale` SET `Name` = 'Assassin Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10318;
-- OLD name : Garde de fer main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10319
UPDATE `creature_template_locale` SET `Name` = 'Garde de fer Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10319;
-- OLD name : Ancien sabre-de-givre
-- Source : https://www.wowhead.com/wotlk/fr/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Tigre (blanc)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10322;
-- OLD name : Léopard primal
-- Source : https://www.wowhead.com/wotlk/fr/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Tigre (léopard)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10336;
-- OLD name : Tigre à dents de sabre fauve
-- Source : https://www.wowhead.com/wotlk/fr/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Tigre (orange)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10337;
-- OLD name : Tigre à dents de sabre doré
-- Source : https://www.wowhead.com/wotlk/fr/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Tigre (or)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10338;
-- OLD subname : Monture de Rend Main-Noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10339
UPDATE `creature_template_locale` SET `Title` = 'Monture de Rend Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10339;
-- OLD name : Omusa Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10378
UPDATE `creature_template_locale` SET `Name` = 'Omusa Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10378;
-- OLD name : Altsoba Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10379
UPDATE `creature_template_locale` SET `Name` = 'Altsoba Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10379;
-- OLD name : Sanuye Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10380
UPDATE `creature_template_locale` SET `Name` = 'Sanuye Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10380;
-- OLD name : Factionnaire de la Garde noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=10394
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle de la Garde noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10394;
-- OLD name : [INUTILISÉ] Guerrier de la Garde noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=10395
UPDATE `creature_template_locale` SET `Name` = 'Guerrier de la Garde noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10395;
-- OLD name : [INUTILISÉ] Bourreau de la Garde noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=10397
UPDATE `creature_template_locale` SET `Name` = 'Bourreau de la Garde noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10397;
-- OLD name : Exhalombre thuzadin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10398
UPDATE `creature_template_locale` SET `Name` = 'Exhalombre Thuzadin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10398;
-- OLD name : Acolyte thuzadin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10399
UPDATE `creature_template_locale` SET `Name` = 'Acolyte Thuzadin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10399;
-- OLD name : Nécromancien thuzadin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10400
UPDATE `creature_template_locale` SET `Name` = 'Nécromancien Thuzadin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10400;
-- OLD name : Goule avide
-- Source : https://www.wowhead.com/wotlk/fr/npc=10406
UPDATE `creature_template_locale` SET `Name` = 'Goule vorace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10406;
-- OLD name : Cristal Ash'ari
-- Source : https://www.wowhead.com/wotlk/fr/npc=10415
UPDATE `creature_template_locale` SET `Name` = 'Cristal d''Ash''ari',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10415;
-- OLD name : Garde ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10418
UPDATE `creature_template_locale` SET `Name` = 'Gardien cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10418;
-- OLD name : Conjurateur ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10419
UPDATE `creature_template_locale` SET `Name` = 'Conjurateur cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10419;
-- OLD name : Initié ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10420
UPDATE `creature_template_locale` SET `Name` = 'Initié cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10420;
-- OLD name : Défenseur ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10421
UPDATE `creature_template_locale` SET `Name` = 'Défenseur cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10421;
-- OLD name : Ensorceleur ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10422
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleur cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10422;
-- OLD name : Prêtre ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10423
UPDATE `creature_template_locale` SET `Name` = 'Prêtre cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10423;
-- OLD name : Vaillant ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10424
UPDATE `creature_template_locale` SET `Name` = 'Vaillant cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10424;
-- OLD name : Mage de bataille ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10425
UPDATE `creature_template_locale` SET `Name` = 'Mage de bataille cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10425;
-- OLD name : Inquisiteur ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=10426
UPDATE `creature_template_locale` SET `Name` = 'Inquisiteur cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10426;
-- OLD name : Pao'ka Montagne-Agile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10427
UPDATE `creature_template_locale` SET `Name` = 'Pao''ka Montagne-agile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10427;
-- OLD name : Motega Crin-de-Feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10428
UPDATE `creature_template_locale` SET `Name` = 'Motega Crin-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10428;
-- OLD name : Chef de guerre Rend Main-Noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10429
UPDATE `creature_template_locale` SET `Name` = 'Chef de guerre Rend Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10429;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10446
UPDATE `creature_template_locale` SET `Title` = 'Maître des arbalétriers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10446;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10450
UPDATE `creature_template_locale` SET `Title` = 'Maître des arbalétriers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10450;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10452
UPDATE `creature_template_locale` SET `Title` = 'Maître des combattants à la masse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10452;
-- OLD subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10453
UPDATE `creature_template_locale` SET `Title` = 'Maître des combattants à la hache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=10454
UPDATE `creature_template_locale` SET `Title` = 'Maître des arbalétriers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10454;
-- OLD name : Flametongue Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=10557
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10557;
-- OLD name : Hulfnar Totem-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10599
UPDATE `creature_template_locale` SET `Name` = 'Hulfnar Totem-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10599;
-- OLD name : Thontek Sabot-Grondeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10600
UPDATE `creature_template_locale` SET `Name` = 'Thontek Sabot-grondeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10600;
-- OLD subname : Eleveur de sabres-d'hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=10618
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de sabres-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10618;
-- OLD name : Kanati Nuage-Gris (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10638
UPDATE `creature_template_locale` SET `Name` = 'Kanati Nuage-gris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10638;
-- OLD name : Brise-Branche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10641
UPDATE `creature_template_locale` SET `Name` = 'Brise-branche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10641;
-- OLD name : Thalia Peau-d’Ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=10645
UPDATE `creature_template_locale` SET `Name` = 'Thalia Peau-d''ambre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10645;
-- OLD name : Lakota Chant-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10646
UPDATE `creature_template_locale` SET `Name` = 'Lakota Chant-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10646;
-- OLD name : Tisseur d’effroi Main-noire invoqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=10680
UPDATE `creature_template_locale` SET `Name` = 'Tisseur d''effroi Main-noire invoqué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10680;
-- OLD name : Vétéran Main-noire invoqué (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10681
UPDATE `creature_template_locale` SET `Name` = 'Vétéran main-noire invoqué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10681;
-- OLD name : Grand chef tombe-hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10738
UPDATE `creature_template_locale` SET `Name` = 'Grand chef Tombe-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10738;
-- OLD name : Mulgris Rivière-Profonde (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10739
UPDATE `creature_template_locale` SET `Name` = 'Mulgris Rivière-profonde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10739;
-- OLD name : Dresseur de dragons main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10742
UPDATE `creature_template_locale` SET `Name` = 'Dresseur de dragons Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10742;
-- OLD name : Ecrabouilleur du Totem-sinistre
-- Source : https://www.wowhead.com/wotlk/fr/npc=10759
UPDATE `creature_template_locale` SET `Name` = 'Marteleur du Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10759;
-- OLD name : Géomancien du Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10760
UPDATE `creature_template_locale` SET `Name` = 'Géomancien du Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10760;
-- OLD name : Nervi main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10762
UPDATE `creature_template_locale` SET `Name` = 'Nervi Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10762;
-- OLD name : Finkle Einhorn
-- Source : https://www.wowhead.com/wotlk/fr/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Pépin Preste-Jugeote',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10776;
-- OLD name : Instructeur Galford
-- Source : https://www.wowhead.com/wotlk/fr/npc=10811
UPDATE `creature_template_locale` SET `Name` = 'Archiviste Galford',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10811;
-- OLD name : Chasse-mort Eperlance
-- Source : https://www.wowhead.com/wotlk/fr/npc=10824
UPDATE `creature_template_locale` SET `Name` = 'Seigneur forestier Eperlance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10824;
-- OLD name : Lynnia Abbendis
-- Source : https://www.wowhead.com/wotlk/fr/npc=10828
UPDATE `creature_template_locale` SET `Name` = 'Grand général Abbendis',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10828;
-- OLD name : Officier d'argent Garush, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=10839
UPDATE `creature_template_locale` SET `Name` = 'Officier de l''Aube d''argent Garush',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10839;
-- OLD name : Officier d'argent Purecarde, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=10840
UPDATE `creature_template_locale` SET `Name` = 'Officier de l''Aube d''argent Purecarde',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10840;
-- OLD name : Intendant d'argent Feuzopoudre, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=10857
UPDATE `creature_template_locale` SET `Name` = 'Intendant de l''Aube d''argent Feuzopoudre',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10857;
-- OLD name : Messager des Pitons Rôdeur-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10881
UPDATE `creature_template_locale` SET `Name` = 'Messager des Pitons Rôdeur-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10881;
-- OLD name : Fabricant d'armures main-noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10898
UPDATE `creature_template_locale` SET `Name` = 'Fabricant d''armures Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10898;
-- OLD name : Troll briselance (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10919
UPDATE `creature_template_locale` SET `Name` = 'Troll Briselance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10919;
-- OLD name : Taronn Plume-Rouge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10921
UPDATE `creature_template_locale` SET `Name` = 'Taronn Plume-rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10921;
-- OLD name : Greta Sabot-de-Mousse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10922
UPDATE `creature_template_locale` SET `Name` = 'Greta Sabot-de-mousse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10922;
-- OLD name : Milicien de Senterouge
-- Source : https://www.wowhead.com/wotlk/fr/npc=10950
UPDATE `creature_template_locale` SET `Name` = 'Milice de Senterouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10950;
-- OLD name : Vermine blanche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10982
UPDATE `creature_template_locale` SET `Name` = 'Vermine Blanche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10982;
-- OLD name : Troll hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10983
UPDATE `creature_template_locale` SET `Name` = 'Troll Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10983;
-- OLD name : Berserker hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10984
UPDATE `creature_template_locale` SET `Name` = 'Berserker Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10984;
-- OLD name : Harpie brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10986
UPDATE `creature_template_locale` SET `Name` = 'Harpie Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10986;
-- OLD name : Gnoll follepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=10991
UPDATE `creature_template_locale` SET `Name` = 'Gnoll Follepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10991;
-- OLD name : Willey Mutilespoir
-- Source : https://www.wowhead.com/wotlk/fr/npc=10997
UPDATE `creature_template_locale` SET `Name` = 'Maître canonnier Willey',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 10997;
-- OLD name : Sabre-de-givre de Berceau-de-l'Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=11021
UPDATE `creature_template_locale` SET `Name` = 'Sabre-de-givre du Berceau-de-l''Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11021;
-- OLD name : Commandant Malor
-- Source : https://www.wowhead.com/wotlk/fr/npc=11032
UPDATE `creature_template_locale` SET `Name` = 'Malor le Zélé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11032;
-- OLD subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11034;
-- OLD subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11036;
-- OLD subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11039;
-- OLD name : Moine ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=11043
UPDATE `creature_template_locale` SET `Name` = 'Moine cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11043;
-- OLD name : Fusilier ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=11054
UPDATE `creature_template_locale` SET `Name` = 'Fusilier cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11054;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/fr/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11058;
-- OLD subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11063;
-- OLD name : Mot Aube-Glorieuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11071
UPDATE `creature_template_locale` SET `Name` = 'Mot Aube-glorieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11071;
-- OLD name : Mana Tide Totem II
-- Source : https://www.wowhead.com/wotlk/fr/npc=11100
UPDATE `creature_template_locale` SET `Name` = 'Totem de Vague de mana II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11100;
-- OLD name : Mana Tide Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=11101
UPDATE `creature_template_locale` SET `Name` = 'Totem de Vague de mana III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11101;
-- OLD name : Cavalier d'argent, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11102
UPDATE `creature_template_locale` SET `Name` = 'Cavalier de l''Aube d''argent',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11102;
-- OLD name : Forgeur de marteaux ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=11120
UPDATE `creature_template_locale` SET `Name` = 'Forgeur de marteaux cramoisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11120;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11146;
-- OLD name : Mécanotrotteur violet
-- Source : https://www.wowhead.com/wotlk/fr/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Mécatrotteur (violet)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11148;
-- OLD name : Mécanotrotteur rouge et bleu
-- Source : https://www.wowhead.com/wotlk/fr/npc=11149
UPDATE `creature_template_locale` SET `Name` = 'Mécatrotteur (rouge/bleu)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11149;
-- OLD name : Mécanotrotteur bleu clair modèle A
-- Source : https://www.wowhead.com/wotlk/fr/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Mécatrotteur (bleu clair)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11150;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11177;
-- OLD name : Borgosh Tord-Noyau, subname : Maître des forgerons (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11178
UPDATE `creature_template_locale` SET `Name` = 'Borgosh Tord-noyau',`Title` = 'Fabricant d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11178;
-- OLD name : Brave du poste de la Vénéneuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11180
UPDATE `creature_template_locale` SET `Name` = 'Brave du Poste de la Vénéneuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11180;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=11185
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11185;
-- OLD name : Cogneur de Long-Guet (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11190
UPDATE `creature_template_locale` SET `Name` = 'Cogneur de Long-guet',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11190;
-- OLD name : Défenseur d'argent, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11194
UPDATE `creature_template_locale` SET `Name` = 'Défenseur de l''Aube d''argent',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11194;
-- OLD name : Destrier de la mort
-- Source : https://www.wowhead.com/wotlk/fr/npc=11195
UPDATE `creature_template_locale` SET `Name` = 'Cheval de guerre squelette noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11195;
-- OLD name : Tambour briselance (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11196
UPDATE `creature_template_locale` SET `Name` = 'Tambour Briselance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11196;
-- OLD name : Perroquet de sang
-- Source : https://www.wowhead.com/wotlk/fr/npc=11236
UPDATE `creature_template_locale` SET `Name` = 'Perroquet sanglant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11236;
-- OLD name : Nataka Longue-Corne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11259
UPDATE `creature_template_locale` SET `Name` = 'Nataka Longue-corne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11259;
-- OLD name : Paysan de Comté-du-Nord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11260
UPDATE `creature_template_locale` SET `Name` = 'Paysan de Comté-du-nord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11260;
-- OLD name : Non-vivant écorchemousse
-- Source : https://www.wowhead.com/wotlk/fr/npc=11291
UPDATE `creature_template_locale` SET `Name` = 'Non-vivant Ecorchemousse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11291;
-- OLD name : Berserker écorchemousse
-- Source : https://www.wowhead.com/wotlk/fr/npc=11292
UPDATE `creature_template_locale` SET `Name` = 'Berserker Ecorchemousse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11292;
-- OLD name : Trogg ragefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11318
UPDATE `creature_template_locale` SET `Name` = 'Trogg Ragefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11318;
-- OLD name : Chaman ragefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11319
UPDATE `creature_template_locale` SET `Name` = 'Chaman Ragefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11319;
-- OLD name : Elémentaire du magma
-- Source : https://www.wowhead.com/wotlk/fr/npc=11321
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire de lave',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11321;
-- OLD name : Lanceur de haches gurubashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11350
UPDATE `creature_template_locale` SET `Name` = 'Lanceur de haches Gurubashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11350;
-- OLD name : Chasseur de têtes gurubashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11351
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de têtes Gurubashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11351;
-- OLD name : Buveur de sang gurubashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11353
UPDATE `creature_template_locale` SET `Name` = 'Buveur de sang Gurubashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11353;
-- OLD name : Guerrier gurubashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11355
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Gurubashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11355;
-- OLD name : Champion gurubashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11356
UPDATE `creature_template_locale` SET `Name` = 'Champion Gurubashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11356;
-- OLD name : Sombre-veuve razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11370
UPDATE `creature_template_locale` SET `Name` = 'Sombre-veuve Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11370;
-- OLD name : Serpent razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11371
UPDATE `creature_template_locale` SET `Name` = 'Serpent Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11371;
-- OLD name : Aspic razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11372
UPDATE `creature_template_locale` SET `Name` = 'Aspic Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11372;
-- OLD name : Cobra razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11373
UPDATE `creature_template_locale` SET `Name` = 'Cobra Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11373;
-- OLD subname : Ambassadeur des trolls furie-des-sables (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11387
UPDATE `creature_template_locale` SET `Title` = 'Ambassadeur des trolls Furie-des-sables',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11387;
-- OLD name : Porte-parole fanécorce, subname : Ambassadeur des trolls fanécorces
-- Source : https://www.wowhead.com/wotlk/fr/npc=11388
UPDATE `creature_template_locale` SET `Name` = 'Porte-parole fânécorce',`Title` = 'Ambassadeur des trolls Fânécorces',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11388;
-- OLD subname : Ambassadeur des trolls scalps-rouges
-- Source : https://www.wowhead.com/wotlk/fr/npc=11389
UPDATE `creature_template_locale` SET `Title` = 'Ambassadeur des trolls Scalp-rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11389;
-- OLD subname : Ambassadeur des trolls casse-crânes
-- Source : https://www.wowhead.com/wotlk/fr/npc=11390
UPDATE `creature_template_locale` SET `Title` = 'Ambassadeur des trolls casse-crâne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11390;
-- OLD subname : Ambassadeur des trolls vilebranches
-- Source : https://www.wowhead.com/wotlk/fr/npc=11391
UPDATE `creature_template_locale` SET `Title` = 'Ambassadeur des trolls Vilebranche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11391;
-- OLD name : Ecrabouilleur crochebois
-- Source : https://www.wowhead.com/wotlk/fr/npc=11465
UPDATE `creature_template_locale` SET `Name` = 'Ecraseur Crochebois',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11465;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=11466
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11466;
-- OLD name : Rongé eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11469
UPDATE `creature_template_locale` SET `Name` = 'Rongé Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11469;
-- OLD name : Ensorceleur eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11470
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleur Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11470;
-- OLD name : Fantôme eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11471
UPDATE `creature_template_locale` SET `Name` = 'Fantôme Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11471;
-- OLD name : Esprit eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11472
UPDATE `creature_template_locale` SET `Name` = 'Esprit Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11472;
-- OLD name : Spectre eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11473
UPDATE `creature_template_locale` SET `Name` = 'Spectre Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11473;
-- OLD name : Ame en peine eldreth
-- Source : https://www.wowhead.com/wotlk/fr/npc=11474
UPDATE `creature_template_locale` SET `Name` = 'Ame en peine d''Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11474;
-- OLD name : Fantasme eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11475
UPDATE `creature_template_locale` SET `Name` = 'Fantasme Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11475;
-- OLD name : [INUTILISÉ] Horreur des arcanes
-- Source : https://www.wowhead.com/wotlk/fr/npc=11479
UPDATE `creature_template_locale` SET `Name` = 'Horreur des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11479;
-- OLD subname : Dirigeant des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=11486
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11486;
-- OLD name : Zevrim Sabot-de-Ronce (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11490
UPDATE `creature_template_locale` SET `Name` = 'Zevrim Sabot-de-ronce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11490;
-- OLD name : Bâlhafr le Brisé
-- Source : https://www.wowhead.com/wotlk/fr/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Bâlhafr l''Invaincu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11498;
-- OLD name : Garde grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11516
UPDATE `creature_template_locale` SET `Name` = 'Garde Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11516;
-- OLD subname : Chef ragefeu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11517
UPDATE `creature_template_locale` SET `Title` = 'Chef Ragefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11517;
-- OLD name : Intendante Miranda Coinceculasse, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=11536
UPDATE `creature_template_locale` SET `Name` = 'Intendante Miranda Breechlock',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11536;
-- OLD name : Mystique grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11552
UPDATE `creature_template_locale` SET `Name` = 'Mystique Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11552;
-- OLD name : Pliebois grumegueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11553
UPDATE `creature_template_locale` SET `Name` = 'Pliebois Grumegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11553;
-- OLD name : Rampant claquesec (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11562
UPDATE `creature_template_locale` SET `Name` = 'Rampant Claquesec',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11562;
-- OLD name : Pinceur claquesec (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11563
UPDATE `creature_template_locale` SET `Name` = 'Pinceur Claquesec',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11563;
-- OLD name : Kelemis le Sans-Vie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11580
UPDATE `creature_template_locale` SET `Name` = 'Kelemis le Sans-vie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11580;
-- OLD name : Terrassier blanche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11603
UPDATE `creature_template_locale` SET `Name` = 'Terrassier Blanche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11603;
-- OLD name : Géomancien blanche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11604
UPDATE `creature_template_locale` SET `Name` = 'Géomancien Blanche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11604;
-- OLD name : Surveillant blanche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11605
UPDATE `creature_template_locale` SET `Name` = 'Surveillant Blanche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11605;
-- OLD name : Rat des tunnels blanche-moustache (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11606
UPDATE `creature_template_locale` SET `Name` = 'Rat des tunnels Blanche-moustache',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11606;
-- OLD name : Bardu Oeil-Vif (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11608
UPDATE `creature_template_locale` SET `Name` = 'Bardu Oeil-vif',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11608;
-- OLD name : Alexia Coutel-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11609
UPDATE `creature_template_locale` SET `Name` = 'Alexia Coutel-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11609;
-- OLD name : Terrassier « Clé à molette » Veriatus
-- Source : https://www.wowhead.com/wotlk/fr/npc=11617
UPDATE `creature_template_locale` SET `Name` = 'Terrassier "Clé à molette" Veriatus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11617;
-- OLD name : Cadavre putréfié
-- Source : https://www.wowhead.com/wotlk/fr/npc=11628
UPDATE `creature_template_locale` SET `Name` = 'Cadavre en décomposition',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11628;
-- OLD name : Prêtre attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11662
UPDATE `creature_template_locale` SET `Name` = 'Prêtre Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11662;
-- OLD name : Soigneur attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11663
UPDATE `creature_template_locale` SET `Name` = 'Soigneur Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11663;
-- OLD name : Elite attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11664
UPDATE `creature_template_locale` SET `Name` = 'Elite Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11664;
-- OLD name : Seigneur du Feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11668
UPDATE `creature_template_locale` SET `Name` = 'Seigneur du feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11668;
-- OLD name : Chien du Magma
-- Source : https://www.wowhead.com/wotlk/fr/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Ancien chien du Magma',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11673;
-- OLD name : Imploratrice céleste brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11675
UPDATE `creature_template_locale` SET `Name` = 'Imploratrice céleste Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11675;
-- OLD name : Féticheur hache-d'hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=11679
UPDATE `creature_template_locale` SET `Name` = 'Sorcier-docteur Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11679;
-- OLD name : Défricheur chanteguerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=11681
UPDATE `creature_template_locale` SET `Name` = 'Défricheur de la Horde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11681;
-- OLD name : Défricheur gobelin
-- Source : https://www.wowhead.com/wotlk/fr/npc=11684
UPDATE `creature_template_locale` SET `Name` = 'Déchireur chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11684;
-- OLD name : Instigateur pin-tordu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11690
UPDATE `creature_template_locale` SET `Name` = 'Instigateur Pin-tordu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11690;
-- OLD subname : Eleveurs de sabres-d'hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=11696
UPDATE `creature_template_locale` SET `Title` = 'Éleveurs de sabres-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11696;
-- OLD subname : Eleveurs de ravasaures
-- Source : https://www.wowhead.com/wotlk/fr/npc=11701
UPDATE `creature_template_locale` SET `Title` = 'Éleveurs de ravasaures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11701;
-- OLD subname : Eleveurs de ravasaures
-- Source : https://www.wowhead.com/wotlk/fr/npc=11702
UPDATE `creature_template_locale` SET `Title` = 'Éleveurs de ravasaures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11702;
-- OLD name : Navi Tir-Rapide (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11719
UPDATE `creature_template_locale` SET `Name` = 'Navi Tir-rapide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11719;
-- OLD name : Loruk Rôdeur-des-Forêts (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11720
UPDATE `creature_template_locale` SET `Name` = 'Loruk Rôdeur-des-forêts',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11720;
-- OLD name : Samantha Sabot-Agile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11748
UPDATE `creature_template_locale` SET `Name` = 'Samantha Sabot-agile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11748;
-- OLD name : Feran Vent-Violent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11749
UPDATE `creature_template_locale` SET `Name` = 'Feran Vent-violent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11749;
-- OLD name : Basilic œil-d’ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=11785
UPDATE `creature_template_locale` SET `Name` = 'Basilic Oeil-d''ambre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11785;
-- OLD name : Saccageur œil-d’ambre
-- Source : https://www.wowhead.com/wotlk/fr/npc=11786
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Oeil-d''ambre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11786;
-- OLD name : Dryade celebrienne
-- Source : https://www.wowhead.com/wotlk/fr/npc=11793
UPDATE `creature_template_locale` SET `Name` = 'Dryade de Celebrian',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11793;
-- OLD name : Sœur de Celebras
-- Source : https://www.wowhead.com/wotlk/fr/npc=11794
UPDATE `creature_template_locale` SET `Name` = 'Sœur de Celebrian',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11794;
-- OLD name : Mylentha Méandre-de-Rivière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11795
UPDATE `creature_template_locale` SET `Name` = 'Mylentha Méandre-de-rivière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11795;
-- OLD name : Bessany Vent-des-Plaines (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11796
UPDATE `creature_template_locale` SET `Name` = 'Bessany Vent-des-plaines',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11796;
-- OLD name : Moren Méandre-de-Rivière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11797
UPDATE `creature_template_locale` SET `Name` = 'Moren Méandre-de-rivière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11797;
-- OLD name : Bunthen Vent-des-Plaines, subname : Maître de vol des Pitons-du-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11798
UPDATE `creature_template_locale` SET `Name` = 'Bunthen Vent-des-plaines',`Title` = 'Maître de vol des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11798;
-- OLD name : Gardien du Crépuscule Exeter (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11803
UPDATE `creature_template_locale` SET `Name` = 'Gardien du crépuscule Exeter',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11803;
-- OLD name : Gardien du Crépuscule Havunth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11804
UPDATE `creature_template_locale` SET `Name` = 'Gardien du crépuscule Havunth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11804;
-- OLD name : Jarund Rôdeur-Vaillant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11805
UPDATE `creature_template_locale` SET `Name` = 'Jarund Rôdeur-vaillant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11805;
-- OLD name : Grum Barbe-Rouge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11808
UPDATE `creature_template_locale` SET `Name` = 'Grum Barbe-rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11808;
-- OLD name : Vark Balafre-Glorieuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11823
UPDATE `creature_template_locale` SET `Name` = 'Vark Balafre-glorieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11823;
-- OLD name : Maur Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11834
UPDATE `creature_template_locale` SET `Name` = 'Maur Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11834;
-- OLD name : Chaman follepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11837
UPDATE `creature_template_locale` SET `Name` = 'Chaman Follepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11837;
-- OLD name : Mystique follepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11838
UPDATE `creature_template_locale` SET `Name` = 'Mystique Follepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11838;
-- OLD name : Brute follepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11839
UPDATE `creature_template_locale` SET `Name` = 'Brute Follepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11839;
-- OLD name : Alpha follepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11840
UPDATE `creature_template_locale` SET `Name` = 'Alpha Follepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11840;
-- OLD name : Kaya Sabot-Plat (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11856
UPDATE `creature_template_locale` SET `Name` = 'Kaya Sabot-plat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11856;
-- OLD name : Makaba Sabot-Plat (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11857
UPDATE `creature_template_locale` SET `Name` = 'Makaba Sabot-plat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11857;
-- OLD name : Grundig Noir-Nuage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11858
UPDATE `creature_template_locale` SET `Name` = 'Grundig Noir-nuage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11858;
-- OLD name : Maggran Lieur-de-Terre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11860
UPDATE `creature_template_locale` SET `Name` = 'Maggran Lieur-de-terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11860;
-- OLD name : Tammra Champ-des-Vents (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11864
UPDATE `creature_template_locale` SET `Name` = 'Tammra Champ-des-vents',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11864;
-- OLD name : Buliwyf Main-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11865
UPDATE `creature_template_locale` SET `Name` = 'Buliwyf Main-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11865;
-- OLD subname : Champion d'armes
-- Source : https://www.wowhead.com/wotlk/fr/npc=11866
UPDATE `creature_template_locale` SET `Title` = 'Maître d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11866;
-- OLD name : Roon Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11877
UPDATE `creature_template_locale` SET `Name` = 'Roon Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11877;
-- OLD name : Vengeur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11880
UPDATE `creature_template_locale` SET `Name` = 'Vengeur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11880;
-- OLD name : Géoseigneur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11881
UPDATE `creature_template_locale` SET `Name` = 'Géoseigneur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11881;
-- OLD name : Invocateur de pierres du Crépuscule
-- Source : https://www.wowhead.com/wotlk/fr/npc=11882
UPDATE `creature_template_locale` SET `Name` = 'Invocateur des pierres du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11882;
-- OLD name : Maître du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11883
UPDATE `creature_template_locale` SET `Name` = 'Maître du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11883;
-- OLD name : Gardien des rochers des Eboulis
-- Source : https://www.wowhead.com/wotlk/fr/npc=11915
UPDATE `creature_template_locale` SET `Name` = 'Gardien des rochers de Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11915;
-- OLD name : Géomancien des Eboulis
-- Source : https://www.wowhead.com/wotlk/fr/npc=11917
UPDATE `creature_template_locale` SET `Name` = 'Géomancien de Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11917;
-- OLD name : Cassepierre des Eboulis
-- Source : https://www.wowhead.com/wotlk/fr/npc=11918
UPDATE `creature_template_locale` SET `Name` = 'Cassepierre de Gogger',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11918;
-- OLD name : Vorn Oeil-des-Cieux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=11944
UPDATE `creature_template_locale` SET `Name` = 'Vorn Oeil-des-cieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 11944;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=12020
UPDATE `creature_template_locale` SET `Title` = 'Alchimiste - Artisan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12020;
-- OLD name : Maître des mineurs de Nid-de-l’Aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=12035
UPDATE `creature_template_locale` SET `Name` = 'Maître des Mineurs du Nid-de-l''Aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12035;
-- OLD name : Grella Poing-de-pierre
-- Source : https://www.wowhead.com/wotlk/fr/npc=12036
UPDATE `creature_template_locale` SET `Name` = 'Fournitures générales du Nid-de-l''Aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12036;
-- OLD name : Vendeuse de viande de Nid-de-l’Aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=12039
UPDATE `creature_template_locale` SET `Name` = 'Vendeuse de viande du Nid-de-l''Aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12039;
-- OLD name : Brannik Bedaine-de-Fer
-- Source : https://www.wowhead.com/wotlk/fr/npc=12040
UPDATE `creature_template_locale` SET `Name` = 'Vendeur d''armures en mailles du Nid-de-l''Aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12040;
-- OLD name : Guerrier loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12052
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12052;
-- OLD name : Prêtresse d’Elune
-- Source : https://www.wowhead.com/wotlk/fr/npc=12116
UPDATE `creature_template_locale` SET `Name` = 'Prêtresse d''Elune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12116;
-- OLD name : Protecteur attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12119
UPDATE `creature_template_locale` SET `Name` = 'Protecteur Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12119;
-- OLD name : Soldat d'élite cramoisi
-- Source : https://www.wowhead.com/wotlk/fr/npc=12128
UPDATE `creature_template_locale` SET `Name` = 'Elite cramoisie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12128;
-- OLD name : Gardien d’Elune
-- Source : https://www.wowhead.com/wotlk/fr/npc=12140
UPDATE `creature_template_locale` SET `Name` = 'Gardien d''Elune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12140;
-- OLD name : Gardien attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12142
UPDATE `creature_template_locale` SET `Name` = 'Gardien Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12142;
-- OLD name : Kodo bleu
-- Source : https://www.wowhead.com/wotlk/fr/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Kodo (bleu)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12148;
-- OLD name : Kodo vert
-- Source : https://www.wowhead.com/wotlk/fr/npc=12151
UPDATE `creature_template_locale` SET `Name` = 'Kodo (vert)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12151;
-- OLD name : Voix d’Elune
-- Source : https://www.wowhead.com/wotlk/fr/npc=12152
UPDATE `creature_template_locale` SET `Name` = 'Voix d''Elune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12152;
-- OLD name : Lanceur de haches hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12156
UPDATE `creature_template_locale` SET `Name` = 'Lanceur de haches Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12156;
-- OLD name : Chasseur des ombres hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12157
UPDATE `creature_template_locale` SET `Name` = 'Chasseur des ombres Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12157;
-- OLD name : Chasseur hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12158
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12158;
-- OLD name : Ecumeur fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12204
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12204;
-- OLD name : Sorcière fouette-bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12205
UPDATE `creature_template_locale` SET `Name` = 'Sorcière Fouette-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12205;
-- OLD name : Gelée nocive
-- Source : https://www.wowhead.com/wotlk/fr/npc=12221
UPDATE `creature_template_locale` SET `Name` = 'Gelée nuisible',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12221;
-- OLD subname : Le deuxième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=12239
UPDATE `creature_template_locale` SET `Title` = 'Le deuxième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12239;
-- OLD subname : Le premier Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=12240
UPDATE `creature_template_locale` SET `Title` = 'Le premier Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12240;
-- OLD subname : Le troisième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=12241
UPDATE `creature_template_locale` SET `Title` = 'Le troisième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12241;
-- OLD subname : Le quatrième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=12242
UPDATE `creature_template_locale` SET `Title` = 'Le quatrième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12242;
-- OLD subname : Le cinquième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=12243
UPDATE `creature_template_locale` SET `Title` = 'Le cinquième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12243;
-- OLD name : Engeance de lave
-- Source : https://www.wowhead.com/wotlk/fr/npc=12265
UPDATE `creature_template_locale` SET `Name` = 'Rejeton de lave',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12265;
-- OLD name : Oeuf de la Ruche'Zora
-- Source : https://www.wowhead.com/wotlk/fr/npc=12276
UPDATE `creature_template_locale` SET `Name` = 'Œuf de la Ruche''Zora',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12276;
-- OLD name : Raptor tacheté rouge
-- Source : https://www.wowhead.com/wotlk/fr/npc=12345
UPDATE `creature_template_locale` SET `Name` = 'Raptor chamaré rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12345;
-- OLD name : Troupier écarlate
-- Source : https://www.wowhead.com/wotlk/fr/npc=12352
UPDATE `creature_template_locale` SET `Name` = 'Soldat écarlate',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12352;
-- OLD name : Krethis Tisse-l'ombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=12433
UPDATE `creature_template_locale` SET `Name` = 'Krethis Tissombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12433;
-- OLD name : Grish Long-Coureur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12576
UPDATE `creature_template_locale` SET `Name` = 'Grish Long-coureur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12576;
-- OLD subname : Eleveuse de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=12636
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12636;
-- OLD name : Senani Cœur-de-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12696
UPDATE `creature_template_locale` SET `Name` = 'Senani Cœur-de-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12696;
-- OLD name : Chef Lien-Terrestre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12791
UPDATE `creature_template_locale` SET `Name` = 'Chef Lien-terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12791;
-- OLD name : Brave Cuir-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12793
UPDATE `creature_template_locale` SET `Name` = 'Brave Cuir-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12793;
-- OLD name : Ruul Sabot-de-Neige (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12818
UPDATE `creature_template_locale` SET `Name` = 'Ruul Sabot-de-neige',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12818;
-- OLD name : Ruul Sabot-de-Neige en forme d'ours (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12819
UPDATE `creature_template_locale` SET `Name` = 'Ruul Sabot-de-neige en forme d''ours',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12819;
-- OLD name : Yama Sabot-de-Neige (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=12837
UPDATE `creature_template_locale` SET `Name` = 'Yama Sabot-de-neige',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12837;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Chirurgien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12939;
-- OLD name : Blimo Gadgetaressort
-- Source : https://www.wowhead.com/wotlk/fr/npc=12957
UPDATE `creature_template_locale` SET `Name` = 'Blimo Gadgettaressort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12957;
-- OLD name : Christi Galvanis, subname : Fournitures générales
-- Source : https://www.wowhead.com/wotlk/fr/npc=12960
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12960;
-- OLD name : Montagnard de Forgefer monté
-- Source : https://www.wowhead.com/wotlk/fr/npc=12996
UPDATE `creature_template_locale` SET `Name` = 'Montagnard monté de Forgefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 12996;
-- OLD name : Chien gordok
-- Source : https://www.wowhead.com/wotlk/fr/npc=13036
UPDATE `creature_template_locale` SET `Name` = 'Mastiff gordok',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13036;
-- OLD subname : Champion d'armes
-- Source : https://www.wowhead.com/wotlk/fr/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Maître d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13084;
-- OLD name : Guide spirituel de l’’Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=13116
UPDATE `creature_template_locale` SET `Name` = 'Guide spirituel de l''Alliance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13116;
-- OLD name : Ecrabouilleur sève-putride
-- Source : https://www.wowhead.com/wotlk/fr/npc=13141
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Sève-putride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13141;
-- OLD name : Lieutenant Sabot-Puissant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13143
UPDATE `creature_template_locale` SET `Name` = 'Lieutenant Sabot-puissant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13143;
-- OLD name : Griffon de Nid-de-l’Aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=13161
UPDATE `creature_template_locale` SET `Name` = 'Griffon du Nid-de-l''Aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13161;
-- OLD name : Grunnda Cœur-de-Loup
-- Source : https://www.wowhead.com/wotlk/fr/npc=13218
UPDATE `creature_template_locale` SET `Name` = 'Grunnda Coeur-de-loup',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13218;
-- OLD name : Oeil céleste de Ryson
-- Source : https://www.wowhead.com/wotlk/fr/npc=13221
UPDATE `creature_template_locale` SET `Name` = 'Oeil de Ryson',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13221;
-- OLD name : Lokholar le Seigneur de glace
-- Source : https://www.wowhead.com/wotlk/fr/npc=13256
UPDATE `creature_template_locale` SET `Name` = 'Lokholar le Seigneur des Glaces',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13256;
-- OLD name : Petite grenouille
-- Source : https://www.wowhead.com/wotlk/fr/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Grenouille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13321;
-- OLD name : Garde d’honneur hydraxien
-- Source : https://www.wowhead.com/wotlk/fr/npc=13322
UPDATE `creature_template_locale` SET `Name` = 'Garde d''honneur hydraxien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13322;
-- OLD name : Poseur de mines foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13356
UPDATE `creature_template_locale` SET `Name` = 'Poseur de mines Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13356;
-- OLD name : Poseur de mines loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13357
UPDATE `creature_template_locale` SET `Name` = 'Poseur de mines Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13357;
-- OLD name : Déchiqueteur loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13378
UPDATE `creature_template_locale` SET `Name` = 'Déchiqueteur Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13378;
-- OLD name : Déchiqueteur foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13416
UPDATE `creature_template_locale` SET `Name` = 'Déchiqueteur Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13416;
-- OLD name : Sagorne Rôdeur-des-Crêtes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13417
UPDATE `creature_template_locale` SET `Name` = 'Sagorne Rôdeur-des-crêtes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13417;
-- OLD name : Ivus le Seigneur de la forêt
-- Source : https://www.wowhead.com/wotlk/fr/npc=13419
UPDATE `creature_template_locale` SET `Name` = 'Ivus le Seigneur des forêts',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13419;
-- OLD name : Chevaucheur de loup loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13440
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de loup Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13440;
-- OLD name : Archidruidesse Ranfarouche
-- Source : https://www.wowhead.com/wotlk/fr/npc=13442
UPDATE `creature_template_locale` SET `Name` = 'Archidruide Ranfarouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13442;
-- OLD name : Grandpère Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=13444
UPDATE `creature_template_locale` SET `Name` = 'Grand-père Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13444;
-- OLD subname : Potions, parchemins et réactifs
-- Source : https://www.wowhead.com/wotlk/fr/npc=13476
UPDATE `creature_template_locale` SET `Title` = 'Potions, Parchemins & Composants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13476;
-- OLD name : Estafette loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13516
UPDATE `creature_template_locale` SET `Name` = 'Estafette Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13516;
-- OLD name : Estafette champion
-- Source : https://www.wowhead.com/wotlk/fr/npc=13519
UPDATE `creature_template_locale` SET `Name` = 'Champion estafette',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13519;
-- OLD name : Forestier foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13520
UPDATE `creature_template_locale` SET `Name` = 'Forestier Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13520;
-- OLD name : Commando foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13524
UPDATE `creature_template_locale` SET `Name` = 'Commando Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13524;
-- OLD name : Saccageur loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13528
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13528;
-- OLD name : Explorateur de Gouffrefer aguerri
-- Source : https://www.wowhead.com/wotlk/fr/npc=13540
UPDATE `creature_template_locale` SET `Name` = 'Explorateur aguerri de Gouffrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13540;
-- OLD name : Chevaucheur de bélier foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13576
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de bélier Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13576;
-- OLD name : Expert en explosifs loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13597
UPDATE `creature_template_locale` SET `Name` = 'Expert en explosifs Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13597;
-- OLD name : Expert en explosifs foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13598
UPDATE `creature_template_locale` SET `Name` = 'Expert en explosifs Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13598;
-- OLD name : Sœur de Marandis
-- Source : https://www.wowhead.com/wotlk/fr/npc=13737
UPDATE `creature_template_locale` SET `Name` = 'Soeur de Marandis',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13737;
-- OLD subname : Le cinquième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=13738
UPDATE `creature_template_locale` SET `Title` = 'Le cinquième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13738;
-- OLD subname : Le quatrième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=13739
UPDATE `creature_template_locale` SET `Title` = 'Le quatrième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13739;
-- OLD subname : Le troisième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=13740
UPDATE `creature_template_locale` SET `Title` = 'Le troisième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13740;
-- OLD subname : Le deuxième Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=13741
UPDATE `creature_template_locale` SET `Title` = 'Le deuxième Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13741;
-- OLD subname : Le premier Khan
-- Source : https://www.wowhead.com/wotlk/fr/npc=13742
UPDATE `creature_template_locale` SET `Title` = 'Le premier Kahn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13742;
-- OLD name : Totem de cristal de Hache-Tripes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13916
UPDATE `creature_template_locale` SET `Name` = 'Totem de cristal de Hache-tripes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13916;
-- OLD name : Mystique hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13956
UPDATE `creature_template_locale` SET `Name` = 'Mystique Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13956;
-- OLD name : Guerrier hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13957
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13957;
-- OLD name : Prophète hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=13958
UPDATE `creature_template_locale` SET `Name` = 'Prophète Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 13958;
-- OLD subname : Héros hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14018
UPDATE `creature_template_locale` SET `Title` = 'Héros Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14018;
-- OLD name : Factionnaire hache-d'hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=14021
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14021;
-- OLD name : Récupérateur foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14141
UPDATE `creature_template_locale` SET `Name` = 'Récupérateur Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14141;
-- OLD name : Récupérateur loup-de-givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14142
UPDATE `creature_template_locale` SET `Name` = 'Récupérateur Loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14142;
-- OLD name : Ravak Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14186
UPDATE `creature_template_locale` SET `Name` = 'Ravak Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14186;
-- OLD name : Pique-les-Yeux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14230
UPDATE `creature_template_locale` SET `Name` = 'Pique-les-yeux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14230;
-- OLD name : Rochecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=14273
UPDATE `creature_template_locale` SET `Name` = 'Rochecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14273;
-- OLD name : Traqueur hache-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14274
UPDATE `creature_template_locale` SET `Name` = 'Traqueur Hache-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14274;
-- OLD name : Soldat d’élite kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=14304
UPDATE `creature_template_locale` SET `Name` = 'Kor''kron d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14304;
-- OLD name : Générateur de drakônide bleu
-- Source : https://www.wowhead.com/wotlk/fr/npc=14307
UPDATE `creature_template_locale` SET `Name` = 'Générateur de drakônide noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14307;
-- OLD name : Capitaine Kromcrabouille
-- Source : https://www.wowhead.com/wotlk/fr/npc=14325
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Kromcrush',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14325;
-- OLD name : Garde Mol’dar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14326
UPDATE `creature_template_locale` SET `Name` = 'Garde Mol''dar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14326;
-- OLD name : Ancienne des Shen’dralar, subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14358
UPDATE `creature_template_locale` SET `Name` = 'Ancienne des Shen''Dralar',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14358;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14364
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14364;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14368
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14368;
-- OLD name : Zélote shen'dralar, subname : Maison des Shen’dralar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14369
UPDATE `creature_template_locale` SET `Name` = 'Zélote Shen''dralar',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14369;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14371
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14371;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14381
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14381;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14382
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14382;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14383
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14383;
-- OLD name : Oeil errant de Kilrogg
-- Source : https://www.wowhead.com/wotlk/fr/npc=14386
UPDATE `creature_template_locale` SET `Name` = 'Œil errant de Kilrogg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14386;
-- OLD name : Saccageur de Hache-Tripes (poste) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14391
UPDATE `creature_template_locale` SET `Name` = 'Saccageur de Hache-tripes (poste)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14391;
-- OLD name : Oeil d'Immol'thar
-- Source : https://www.wowhead.com/wotlk/fr/npc=14396
UPDATE `creature_template_locale` SET `Name` = 'Œil d''Immol''thar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14396;
-- OLD name : Fléchetteuse eldreth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14398
UPDATE `creature_template_locale` SET `Name` = 'Fléchetteuse Eldreth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14398;
-- OLD name : Harb Mont-Souillé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14426
UPDATE `creature_template_locale` SET `Name` = 'Harb Mont-souillé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14426;
-- OLD name : Traqueur de la pénombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=14430
UPDATE `creature_template_locale` SET `Name` = 'Traqueur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14430;
-- OLD name : Chasseur Vent-de-Sagesse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14440
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Vent-de-sagesse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14440;
-- OLD name : Chasseur Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14441
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14441;
-- OLD name : Chasseur Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14442
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14442;
-- OLD name : Capitaine Wyrmak
-- Source : https://www.wowhead.com/wotlk/fr/npc=14445
UPDATE `creature_template_locale` SET `Name` = 'Seigneur-capitaine Wyrmak',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14445;
-- OLD name : Envahisseur fulminant
-- Source : https://www.wowhead.com/wotlk/fr/npc=14462
UPDATE `creature_template_locale` SET `Name` = 'Envahisseur grondant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14462;
-- OLD name : Seigneur du Crépuscule Everun (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14479
UPDATE `creature_template_locale` SET `Name` = 'Seigneur du crépuscule Everun',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14479;
-- OLD name : Fils du venin razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14532
UPDATE `creature_template_locale` SET `Name` = 'Fils du venin Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14532;
-- OLD name : Sergent Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14581
UPDATE `creature_template_locale` SET `Name` = 'Sergent Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14581;
-- OLD name : Gueule d'acier imbriquée
-- Source : https://www.wowhead.com/wotlk/fr/npc=14632
UPDATE `creature_template_locale` SET `Name` = 'Gueule d''acier imbriqué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14632;
-- OLD name : Ouvrier sombrefer ensommeillé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14635
UPDATE `creature_template_locale` SET `Name` = 'Ouvrier Sombrefer ensommeillé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14635;
-- OLD name : Totem de peau de pierre VI corrompu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14663
UPDATE `creature_template_locale` SET `Name` = 'Totem de Peau de pierre VI corrompu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14663;
-- OLD name : Mort chancreux
-- Source : https://www.wowhead.com/wotlk/fr/npc=14709
UPDATE `creature_template_locale` SET `Name` = 'Mort ravagé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14709;
-- OLD name : Grand maréchal Afrasiabi
-- Source : https://www.wowhead.com/wotlk/fr/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Grand maréchal Pont-de-Pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14721;
-- OLD name : Rumstag Fier-Rôdeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14728
UPDATE `creature_template_locale` SET `Name` = 'Rumstag Fier-rôdeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14728;
-- OLD name : Gardien vengebroche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14730
UPDATE `creature_template_locale` SET `Name` = 'Gardien Vengebroche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14730;
-- OLD name : Tambour vengebroche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14734
UPDATE `creature_template_locale` SET `Name` = 'Tambour Vengebroche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14734;
-- OLD name : Aînée Brocherompue
-- Source : https://www.wowhead.com/wotlk/fr/npc=14736
UPDATE `creature_template_locale` SET `Name` = 'L''Aînée Brocherompue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14736;
-- OLD name : Chevaucheur de chauve-souris gurubashi
-- Source : https://www.wowhead.com/wotlk/fr/npc=14750
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de sanguinaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14750;
-- OLD name : Etendard de bataille foudrepique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14752
UPDATE `creature_template_locale` SET `Name` = 'Etendard de bataille Foudrepique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14752;
-- OLD name : Maréchal loup-de-givre est (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14768
UPDATE `creature_template_locale` SET `Name` = 'Maréchal Loup-de-givre est',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14768;
-- OLD name : Maréchal loup-de-givre ouest (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14769
UPDATE `creature_template_locale` SET `Name` = 'Maréchal Loup-de-givre ouest',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14769;
-- OLD name : Raptor razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14821
UPDATE `creature_template_locale` SET `Name` = 'Raptor Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14821;
-- OLD subname : Récompenses souvenirs et jouets
-- Source : https://www.wowhead.com/wotlk/fr/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Echange des bons de la foire de Sombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14828;
-- OLD subname : Marchande de boissons
-- Source : https://www.wowhead.com/wotlk/fr/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Marchande de boissons de la foire de Sombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14844;
-- OLD name : Stamp Corne-Tonnerre, subname : Vendeur de nourriture (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14845
UPDATE `creature_template_locale` SET `Name` = 'Stamp Corne-tonnerre',`Title` = 'Marchand de nourriture de la foire de Sombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14845;
-- OLD subname : Récompenses mascottes & montures
-- Source : https://www.wowhead.com/wotlk/fr/npc=14846
UPDATE `creature_template_locale` SET `Title` = 'Marchandises exotiques de la foire de Sombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14846;
-- OLD subname : Cartes de Sombrelune
-- Source : https://www.wowhead.com/wotlk/fr/npc=14847
UPDATE `creature_template_locale` SET `Title` = 'Foire de Sombrelune, Cartes & marchandises exotiques',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14847;
-- OLD name : Réducteur de têtes zandalar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14876
UPDATE `creature_template_locale` SET `Name` = 'Réducteur de têtes Zandalar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14876;
-- OLD name : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=14879
UPDATE `creature_template_locale` SET `Name` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14879;
-- OLD name : Glisseuse razzashi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14880
UPDATE `creature_template_locale` SET `Name` = 'Glisseuse Razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14880;
-- OLD name : Al'tabim Qui-Voit-Tout (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14903
UPDATE `creature_template_locale` SET `Name` = 'Al''tabim Qui-voit-tout',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14903;
-- OLD name : Kartra Gronde-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=14942
UPDATE `creature_template_locale` SET `Name` = 'Kartra Gronde-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14942;
-- OLD name : Envoyé des Profanateurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=14990
UPDATE `creature_template_locale` SET `Name` = 'Emissaire des Profanateurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 14990;
-- OLD name : Nécromaître Dwire
-- Source : https://www.wowhead.com/wotlk/fr/npc=15021
UPDATE `creature_template_locale` SET `Name` = 'Maître de la mort Dwire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15021;
-- OLD name : Fermier arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15045
UPDATE `creature_template_locale` SET `Name` = 'Fermier d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15045;
-- OLD name : Bûcheron arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15062
UPDATE `creature_template_locale` SET `Name` = 'Bûcheron d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15062;
-- OLD name : Forgeron arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15063
UPDATE `creature_template_locale` SET `Name` = 'Forgeron d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15063;
-- OLD name : Cœur d’Hakkar
-- Source : https://www.wowhead.com/wotlk/fr/npc=15069
UPDATE `creature_template_locale` SET `Name` = 'Coeur d''Hakkar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15069;
-- OLD name : Mineur arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15074
UPDATE `creature_template_locale` SET `Name` = 'Mineur d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15074;
-- OLD name : Palefrenier arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15086
UPDATE `creature_template_locale` SET `Name` = 'Palefrenier d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15086;
-- OLD name : Soldat d’élite de Baie-du-Butin
-- Source : https://www.wowhead.com/wotlk/fr/npc=15088
UPDATE `creature_template_locale` SET `Name` = 'Elite de Baie-du-Butin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15088;
-- OLD name : Raptor razzashi rapide (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15090
UPDATE `creature_template_locale` SET `Name` = 'Raptor Razzashi rapide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15090;
-- OLD name : Envoyé loup-de-givre
-- Source : https://www.wowhead.com/wotlk/fr/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Emissaire loup-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15106;
-- OLD name : Cheval arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=15107
UPDATE `creature_template_locale` SET `Name` = 'Cheval d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15107;
-- OLD name : Cheval des Réprouvés
-- Source : https://www.wowhead.com/wotlk/fr/npc=15108
UPDATE `creature_template_locale` SET `Name` = 'Cheval réprouvé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15108;
-- OLD name : Drake chromatique
-- Source : https://www.wowhead.com/wotlk/fr/npc=15135
UPDATE `creature_template_locale` SET `Name` = 'Monture drake chromatique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15135;
-- OLD name : Soldat d'élite de Trépas-d'Orgrim
-- Source : https://www.wowhead.com/wotlk/fr/npc=15136
UPDATE `creature_template_locale` SET `Name` = 'Elite de Trépas-d''Orgrim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15136;
-- OLD name : Elite des Pins-Argentés
-- Source : https://www.wowhead.com/wotlk/fr/npc=15138
UPDATE `creature_template_locale` SET `Name` = 'Elite des Pins argentés',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15138;
-- OLD name : Khur Sonneur-de-Corne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15175
UPDATE `creature_template_locale` SET `Name` = 'Khur Sonneur-de-corne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15175;
-- OLD name : Soldat d'infanterie du Fort cénarien
-- Source : https://www.wowhead.com/wotlk/fr/npc=15184
UPDATE `creature_template_locale` SET `Name` = 'Infanterie du Fort cénarien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15184;
-- OLD name : Emissaire cénarien Sabot-Noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15188
UPDATE `creature_template_locale` SET `Name` = 'Emissaire cénarien Sabot-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15188;
-- OLD name : Imploratrice céleste Corne-Fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15191
UPDATE `creature_template_locale` SET `Name` = 'Imploratrice céleste Corne-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15191;
-- OLD name : Dame Sylvanas Coursevent
-- Source : https://www.wowhead.com/wotlk/fr/npc=15193
UPDATE `creature_template_locale` SET `Name` = 'La reine banshee',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15193;
-- OLD name : Gardienne du Crépuscule Mayna (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15200
UPDATE `creature_template_locale` SET `Name` = 'Gardienne du crépuscule Mayna',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15200;
-- OLD name : Saccageur des flammes du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15201
UPDATE `creature_template_locale` SET `Name` = 'Saccageur des flammes du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15201;
-- OLD name : Suzerain du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15213
UPDATE `creature_template_locale` SET `Name` = 'Suzerain du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15213;
-- OLD name : Aiguillonneur vekniss
-- Source : https://www.wowhead.com/wotlk/fr/npc=15235
UPDATE `creature_template_locale` SET `Name` = 'Flagellant vekniss',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15235;
-- OLD name : Garde chevaucheur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=15242
UPDATE `creature_template_locale` SET `Name` = 'Garde chevaucheur de chauve-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15242;
-- OLD name : Huum Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15270
UPDATE `creature_template_locale` SET `Name` = 'Huum Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15270;
-- OLD name : Empereur Vek’nilash
-- Source : https://www.wowhead.com/wotlk/fr/npc=15275
UPDATE `creature_template_locale` SET `Name` = 'Empereur Vek''nilash',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15275;
-- OLD name : Empereur Vek’lor
-- Source : https://www.wowhead.com/wotlk/fr/npc=15276
UPDATE `creature_template_locale` SET `Name` = 'Empereur Vek''lor',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15276;
-- OLD name : Eclaireur Kariel
-- Source : https://www.wowhead.com/wotlk/fr/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Avokor',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15285;
-- OLD name : Ancien totem de fontaine de mana
-- Source : https://www.wowhead.com/wotlk/fr/npc=15304
UPDATE `creature_template_locale` SET `Name` = 'Ancien totem Fontaine de mana',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15304;
-- OLD name : Bor Crins-Sauvages
-- Source : https://www.wowhead.com/wotlk/fr/npc=15306
UPDATE `creature_template_locale` SET `Name` = 'Bor Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15306;
-- OLD name : Prophète du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15308
UPDATE `creature_template_locale` SET `Name` = 'Prophète du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15308;
-- OLD name : Dirigeable télécommandé, subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15349;
-- OLD name : Char mortier télécommandé, subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15364;
-- OLD name : Gardien de Haut-Soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15371
UPDATE `creature_template_locale` SET `Name` = 'Gardien de Haut-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15371;
-- OLD name : Sergent Front-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15383
UPDATE `creature_template_locale` SET `Name` = 'Sergent Front-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15383;
-- OLD name : Compteur de boules puantes d’Austrivage
-- Source : https://www.wowhead.com/wotlk/fr/npc=15415
UPDATE `creature_template_locale` SET `Name` = 'Compteur de boules puantes d''Austrivage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15415;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=15419
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15419;
-- OLD name : Totem d'élémentaire de terre
-- Source : https://www.wowhead.com/wotlk/fr/npc=15430
UPDATE `creature_template_locale` SET `Name` = 'Totem élémentaire de terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15430;
-- OLD name : Totem d'élémentaire de feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=15439
UPDATE `creature_template_locale` SET `Name` = 'Totem élementaire de feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15439;
-- OLD name : Grace of Air Totem III
-- Source : https://www.wowhead.com/wotlk/fr/npc=15463
UPDATE `creature_template_locale` SET `Name` = 'Totem de Grâce aérienne III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15463;
-- OLD name : Strength of Earth Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=15464
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15464;
-- OLD name : Compteur de ponctions de mana de Haut-Soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15468
UPDATE `creature_template_locale` SET `Name` = 'Compteur de ponctions de mana de Haut-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15468;
-- OLD name : Stoneskin Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=15470
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15470;
-- OLD name : Stoneskin Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=15474
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15474;
-- OLD name : Herboriste Plume-Fière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15477
UPDATE `creature_template_locale` SET `Name` = 'Herboriste Plume-fière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15477;
-- OLD name : Stoneclaw Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=15478
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15478;
-- OLD name : Strength of Earth Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=15479
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15479;
-- OLD name : Searing Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=15480
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15480;
-- OLD name : Totem Nova de feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Totem Nova de feu VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15483;
-- OLD name : Magma Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=15484
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15484;
-- OLD name : Flametongue Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=15485
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15485;
-- OLD name : Frost Resistance Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=15486
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Givre IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15486;
-- OLD name : Fire Resistance Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=15487
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15487;
-- OLD name : Healing Stream Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=15488
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15488;
-- OLD name : Mana Spring Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=15489
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15489;
-- OLD name : Nature Resistance Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=15490
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance à la Nature IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15490;
-- OLD name :  Windwall Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=15492
UPDATE `creature_template_locale` SET `Name` = 'Totem de Mur des vents IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15492;
-- OLD name : Windfury Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=15496
UPDATE `creature_template_locale` SET `Name` = 'Totem Furie-des-vents IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15496;
-- OLD name : Windfury Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=15497
UPDATE `creature_template_locale` SET `Name` = 'Totem Furie-des-vents V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15497;
-- OLD name : Oeuf de Buru
-- Source : https://www.wowhead.com/wotlk/fr/npc=15514
UPDATE `creature_template_locale` SET `Name` = 'Œuf de Buru',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15514;
-- OLD name : Guérisseur Long-Coureur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15528
UPDATE `creature_template_locale` SET `Name` = 'Guérisseur Long-coureur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15528;
-- OLD name : Maître du Crépuscule Xarvos (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15530
UPDATE `creature_template_locale` SET `Name` = 'Maître du crépuscule Xarvos',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15530;
-- OLD name : Garde de pierre Sabot-d’Argile
-- Source : https://www.wowhead.com/wotlk/fr/npc=15532
UPDATE `creature_template_locale` SET `Name` = 'Garde de pierre Sabot-d''argile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15532;
-- OLD name : Chef Griffe-Tranchante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15535
UPDATE `creature_template_locale` SET `Name` = 'Chef Griffe-tranchante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15535;
-- OLD name : Garde-essaim anubisath (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15538
UPDATE `creature_template_locale` SET `Name` = 'Garde-essaim Anubisath',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15538;
-- OLD name : Maraudeuse du Crépuscule Morna (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15541
UPDATE `creature_template_locale` SET `Name` = 'Maraudeuse du crépuscule Morna',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15541;
-- OLD name : Maraudeur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15542
UPDATE `creature_template_locale` SET `Name` = 'Maraudeur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15542;
-- OLD name : Ancienne Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15572
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15572;
-- OLD name : Ancienne Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15573
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15573;
-- OLD name : Ancien Cime-de-Pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15574
UPDATE `creature_template_locale` SET `Name` = 'Ancien Cime-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15574;
-- OLD name : Ancien Sabot-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15575
UPDATE `creature_template_locale` SET `Name` = 'Ancien Sabot-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15575;
-- OLD name : Ancien Sabot-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=15576
UPDATE `creature_template_locale` SET `Name` = 'Ancien Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15576;
-- OLD name : Ancienne Chasse-le-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15577
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Chasse-le-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15577;
-- OLD name : Ancienne Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15578
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15578;
-- OLD name : Ancienne Sombre-Corne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15579
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Sombre-corne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15579;
-- OLD name : Ancien Ezra Sabot-de-Blé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15580
UPDATE `creature_template_locale` SET `Name` = 'Ancien Ezra Sabot-de-blé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15580;
-- OLD name : Ancien Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15581
UPDATE `creature_template_locale` SET `Name` = 'Ancien Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15581;
-- OLD name : Ancienne Totem-de-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15582
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Totem-de-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15582;
-- OLD name : Ancien Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15583
UPDATE `creature_template_locale` SET `Name` = 'Ancien Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15583;
-- OLD name : Ancien Oeil-des-Cieux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15584
UPDATE `creature_template_locale` SET `Name` = 'Ancien Oeil-des-cieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15584;
-- OLD name : Ancienne Aube-Glorieuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15585
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Aube-glorieuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15585;
-- OLD name : Ancien Oeil-des-Rêves (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15586
UPDATE `creature_template_locale` SET `Name` = 'Ancien Oeil-des-rêves',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15586;
-- OLD name : Ancienne Marche-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15587
UPDATE `creature_template_locale` SET `Name` = 'Ancienne Marche-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15587;
-- OLD name : Ancien Haute-Montagne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15588
UPDATE `creature_template_locale` SET `Name` = 'Ancien Haute-montagne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15588;
-- OLD name : Oeil de C'Thun
-- Source : https://www.wowhead.com/wotlk/fr/npc=15589
UPDATE `creature_template_locale` SET `Name` = 'Œil de C''Thun',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15589;
-- OLD name : Corrupteur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15625
UPDATE `creature_template_locale` SET `Name` = 'Corrupteur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15625;
-- OLD name : Célestine Mandesigne
-- Source : https://www.wowhead.com/wotlk/fr/npc=15626
UPDATE `creature_template_locale` SET `Name` = 'Celestine Mandesigne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15626;
-- OLD name : Tache lumineuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=15631
UPDATE `creature_template_locale` SET `Name` = 'Tache de lumière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15631;
-- OLD name : Murloc sinistrécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15668
UPDATE `creature_template_locale` SET `Name` = 'Murloc Sinistrécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15668;
-- OLD name : Oracle sinistrécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15669
UPDATE `creature_template_locale` SET `Name` = 'Oracle Sinistrécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15669;
-- OLD name : Fourrageur sinistrécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15670
UPDATE `creature_template_locale` SET `Name` = 'Fourrageur Sinistrécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15670;
-- OLD name : Kidnappeur sombrefer
-- Source : https://www.wowhead.com/wotlk/fr/npc=15692
UPDATE `creature_template_locale` SET `Name` = 'Kindnappeur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15692;
-- OLD name : Renne de l’hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=15706
UPDATE `creature_template_locale` SET `Name` = 'Renne de l''Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15706;
-- OLD name : Blue Qiraji Battle Tank
-- Source : https://www.wowhead.com/wotlk/fr/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (15713, 'frFR','Char d''assaut qiraji bleu',NULL,0);
-- OLD name : Fêtard des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=15719
UPDATE `creature_template_locale` SET `Name` = 'Fêtard des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15719;
-- OLD name : Officier du mérite des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=15739
UPDATE `creature_template_locale` SET `Name` = 'Officier du mérite des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15739;
-- OLD name : Assistant de Grandpère Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=15745
UPDATE `creature_template_locale` SET `Name` = 'Assistant de Grand-père Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15745;
-- OLD name : Fêtard de l’hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=15760
UPDATE `creature_template_locale` SET `Name` = 'Fêtard de l''Hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15760;
-- OLD name : Officier Marche-sous-le-Tonnerre, subname : Mérite des Pitons-du-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15767
UPDATE `creature_template_locale` SET `Name` = 'Officier Marche-sous-le-tonnerre',`Title` = 'Mérite des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15767;
-- OLD name : Chef de guerre Rend Main-Noire de Noël (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15776
UPDATE `creature_template_locale` SET `Name` = 'Chef de guerre Rend Main-noire de Noël',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15776;
-- OLD name : Totem de tranquillité de l'air (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15803
UPDATE `creature_template_locale` SET `Name` = 'Totem de Tranquillité de l''air',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15803;
-- OLD name : Haut-commandant Lynore Frappevent
-- Source : https://www.wowhead.com/wotlk/fr/npc=15866
UPDATE `creature_template_locale` SET `Name` = 'Haut commandant Lynore Frappevent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15866;
-- OLD name : Type des chapelets de feux d'artifice de Pat (ROUGE)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15873
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (ROUGE)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15873;
-- OLD name : Type des chapelets de feux d'artifice de Pat (VERT)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15874
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (VERT)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15874;
-- OLD name : Type des chapelets de feux d'artifice de Pat (VIOLET)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15875
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (VIOLET)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15875;
-- OLD name : Type des chapelets de feux d'artifice de Pat (BLANC)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15876
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (BLANC)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15876;
-- OLD name : Type des chapelets de feux d'artifice de Pat (JAUNE)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15877
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (JAUNE)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15877;
-- OLD name : Type des chapelets de feux d'artifice de Pat (BLEU GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15911
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (BLEU GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15911;
-- OLD name : Type des chapelets de feux d'artifice de Pat (VERT GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15912
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (VERT GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15912;
-- OLD name : Type des chapelets de feux d'artifice de Pat (VIOLET GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15913
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (VIOLET GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15913;
-- OLD name : Type des chapelets de feux d'artifice de Pat (ROUGE GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15914
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (ROUGE GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15914;
-- OLD name : Type des chapelets de feux d'artifice de Pat (BLANC GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15915
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (BLANC GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15915;
-- OLD name : Type des chapelets de feux d'artifice de Pat (JAUNE GRAND)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15916
UPDATE `creature_template_locale` SET `Name` = 'Type des chapelets de fusées de Pat  (JAUNE GRAND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15916;
-- OLD name : Prophète sinistrécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=15950
UPDATE `creature_template_locale` SET `Name` = 'Prophète Sinistrécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 15950;
-- OLD name : Boorana Sabot-Tonnerre, subname : Eleveuse de bébés pandas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16019
UPDATE `creature_template_locale` SET `Name` = 'Boorana Sabot-tonnerre',`Title` = 'Éleveuse de bébés pandas',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16019;
-- OLD subname : Eleveuse de bébés pandas
-- Source : https://www.wowhead.com/wotlk/fr/npc=16023
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de bébés pandas',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16023;
-- OLD subname : Maison des Shen’dralar
-- Source : https://www.wowhead.com/wotlk/fr/npc=16032
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16032;
-- OLD name : [INUTILISE] Créature des marais B [PH]
-- Source : https://www.wowhead.com/wotlk/fr/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16035;
-- OLD name : [INUTILISÉ] Doguemort
-- Source : https://www.wowhead.com/wotlk/fr/npc=16038
UPDATE `creature_template_locale` SET `Name` = 'Doguemort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16038;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16075
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16075;
-- OLD name : Mor Sabot-Gris (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16080
UPDATE `creature_template_locale` SET `Name` = 'Mor Sabot-gris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16080;
-- OLD name : Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16085
UPDATE `creature_template_locale` SET `Name` = 'Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16085;
-- OLD name : Cœur d'artichaut
-- Source : https://www.wowhead.com/wotlk/fr/npc=16111
UPDATE `creature_template_locale` SET `Name` = 'Tourtereau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16111;
-- OLD name : Commandant de la croisade Korfax
-- Source : https://www.wowhead.com/wotlk/fr/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Champion de la Lumière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16112;
-- OLD name : Commandant de la croisade Eligor Portelaube
-- Source : https://www.wowhead.com/wotlk/fr/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Commandant Eligor Portelaube',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16115;
-- OLD name : Rimblat Brise-Terre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16134
UPDATE `creature_template_locale` SET `Name` = 'Rimblat Brise-terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16134;
-- OLD name : Gargouille peau de pierre
-- Source : https://www.wowhead.com/wotlk/fr/npc=16168
UPDATE `creature_template_locale` SET `Name` = 'Gargouille peau-de-pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16168;
-- OLD subname : Eleveuse de faucons-pérégrins
-- Source : https://www.wowhead.com/wotlk/fr/npc=16264
UPDATE `creature_template_locale` SET `Title` = 'Éleveuse de faucons-pérégrins',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16264;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Maître des voleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16279;
-- OLD name : Magistère Quallestris
-- Source : https://www.wowhead.com/wotlk/fr/npc=16291
UPDATE `creature_template_locale` SET `Name` = 'Magistère Quallestis',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16291;
-- OLD name : Cristal infusé
-- Source : https://www.wowhead.com/wotlk/fr/npc=16364
UPDATE `creature_template_locale` SET `Name` = 'Cristal imprégné',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16364;
-- OLD name : Factionnaire d'argent, subname : La Croisade d'argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=16378
UPDATE `creature_template_locale` SET `Name` = 'Factionnaire de l''Aube d''argent',`Title` = 'L''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16378;
-- OLD name : [FILM] Ame en peine froide
-- Source : https://www.wowhead.com/wotlk/fr/npc=16393
UPDATE `creature_template_locale` SET `Name` = 'Ame en peine froide [FILME]',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16393;
-- OLD subname : Ambassadeur de Coca-Cola
-- Source : https://www.wowhead.com/wotlk/fr/npc=16450
UPDATE `creature_template_locale` SET `Title` = 'Ambassadrice de Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16450;
-- OLD name : [UNUSED] Chevalier de la mort redresseur de tort
-- Source : https://www.wowhead.com/wotlk/fr/npc=16451
UPDATE `creature_template_locale` SET `Name` = 'Chevalier de la mort justicier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16451;
-- OLD subname : Ambassadeur de Coca-Cola
-- Source : https://www.wowhead.com/wotlk/fr/npc=16454
UPDATE `creature_template_locale` SET `Title` = 'Ambassadrice de Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16454;
-- OLD subname : Ambassadeur de Coca-Cola
-- Source : https://www.wowhead.com/wotlk/fr/npc=16455
UPDATE `creature_template_locale` SET `Title` = 'Ambassadrice de Coca-Cola',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16455;
-- OLD name : Concubine
-- Source : https://www.wowhead.com/wotlk/fr/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Prétendante zélée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16461;
-- OLD name : Factionnaire de la Main brisée
-- Source : https://www.wowhead.com/wotlk/fr/npc=16507
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle de la Main brisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16507;
-- OLD name : Destrier d'Argent
-- Source : https://www.wowhead.com/wotlk/fr/npc=16510
UPDATE `creature_template_locale` SET `Name` = 'Destrier de l''Aube d''argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16510;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=16527
UPDATE `creature_template_locale` SET `Title` = 'Grand maître des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16527;
-- OLD name : Gardien des terres Fantômes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16541
UPDATE `creature_template_locale` SET `Name` = 'Gardien des Terres fantômes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16541;
-- OLD name : Bête fongique
-- Source : https://www.wowhead.com/wotlk/fr/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16565;
-- OLD name : Long-voyante Regulkut
-- Source : https://www.wowhead.com/wotlk/fr/npc=16574
UPDATE `creature_template_locale` SET `Name` = 'Prophétesse Regulkut',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16574;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16583;
-- OLD name : Veneur Torf Sabot-de-Colère (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16586
UPDATE `creature_template_locale` SET `Name` = 'Veneur Torf Sabot-de-colère',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16586;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=16588
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16588;
-- OLD name : Personnage de test de Bri
-- Source : https://www.wowhead.com/wotlk/fr/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Brianna Schneider',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16605;
-- OLD subname : Fabricant d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=16620
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16620;
-- OLD subname : Champion d'armes
-- Source : https://www.wowhead.com/wotlk/fr/npc=16621
UPDATE `creature_template_locale` SET `Title` = 'Maître d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16621;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=16630
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16630;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16635
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16635;
-- OLD subname : Fournitures d'alchimie
-- Source : https://www.wowhead.com/wotlk/fr/npc=16641
UPDATE `creature_template_locale` SET `Title` = 'Alchimie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16641;
-- OLD subname : Marchand de feux d’artifice
-- Source : https://www.wowhead.com/wotlk/fr/npc=16650
UPDATE `creature_template_locale` SET `Title` = 'Marchand de feux d''artifice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16650;
-- OLD name : Harene Marche-sur-la-Plaine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16655
UPDATE `creature_template_locale` SET `Name` = 'Harene Marche-sur-la-plaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16655;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16657
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16657;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Cuisinière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16676;
-- OLD subname : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=16694
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16694;
-- OLD name : Tireur de précision de la Main brisée
-- Source : https://www.wowhead.com/wotlk/fr/npc=16704
UPDATE `creature_template_locale` SET `Name` = 'Tireur d''élite de la Main brisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16704;
-- OLD subname : Fournitures d'alchimie
-- Source : https://www.wowhead.com/wotlk/fr/npc=16705
UPDATE `creature_template_locale` SET `Title` = 'Alchimie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16705;
-- OLD subname : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=16711
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16711;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Cuisinière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=16720
UPDATE `creature_template_locale` SET `Title` = 'Maître des démons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16720;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16722
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16722;
-- OLD subname : Marchande de feux d’artifice
-- Source : https://www.wowhead.com/wotlk/fr/npc=16730
UPDATE `creature_template_locale` SET `Title` = 'Marchande de feux d''artifice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16730;
-- OLD subname : Fabricante d’armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=16735
UPDATE `creature_template_locale` SET `Title` = 'Fabricante d''armes à feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16735;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=16737
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16737;
-- OLD subname : Marchande de robes
-- Source : https://www.wowhead.com/wotlk/fr/npc=16758
UPDATE `creature_template_locale` SET `Title` = 'Marchand de robes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16758;
-- OLD subname : Marchande d'armes contondantes
-- Source : https://www.wowhead.com/wotlk/fr/npc=16765
UPDATE `creature_template_locale` SET `Title` = 'Marchand d''armes contondantes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16765;
-- OLD name : Dévastateur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16772
UPDATE `creature_template_locale` SET `Name` = 'Dévastateur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16772;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=16782
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16782;
-- OLD name : Brise-dos mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16810
UPDATE `creature_template_locale` SET `Name` = 'Brise-dos Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16810;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16823;
-- OLD name : [INUTILISE] Seigneur de la mort
-- Source : https://www.wowhead.com/wotlk/fr/npc=16861
UPDATE `creature_template_locale` SET `Name` = 'Seigneur de la mort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16861;
-- OLD name : Winsum
-- Source : https://www.wowhead.com/wotlk/fr/npc=16868
UPDATE `creature_template_locale` SET `Name` = 'Tueur du Crâne ricanant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16868;
-- OLD name : Jising
-- Source : https://www.wowhead.com/wotlk/fr/npc=16869
UPDATE `creature_template_locale` SET `Name` = 'Néophyte du Crâne ricanant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16869;
-- OLD name : Cannibale mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16875
UPDATE `creature_template_locale` SET `Name` = 'Cannibale Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16875;
-- OLD name : Mutant mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16876
UPDATE `creature_template_locale` SET `Name` = 'Mutant Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16876;
-- OLD name : Chevaucheur de loup mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16877
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de loup Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16877;
-- OLD name : Amythiel Marche-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16885
UPDATE `creature_template_locale` SET `Name` = 'Amythiel Marche-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16885;
-- OLD name : Mahuram Sabot-Robuste (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16888
UPDATE `creature_template_locale` SET `Name` = 'Mahuram Sabot-robuste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16888;
-- OLD name : Noceur des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=16894
UPDATE `creature_template_locale` SET `Name` = 'Noceur des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16894;
-- OLD name : Saccageur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16908
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16908;
-- OLD name : Sauvage mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16909
UPDATE `creature_template_locale` SET `Name` = 'Sauvage Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16909;
-- OLD name : Ecumeur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16925
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16925;
-- OLD name : Loup de guerre mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16926
UPDATE `creature_template_locale` SET `Name` = 'Loup de guerre Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16926;
-- OLD name : Porte-épieu crapuche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16935
UPDATE `creature_template_locale` SET `Name` = 'Porte-épieu Crapuche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16935;
-- OLD name : Géomancien crapuche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16937
UPDATE `creature_template_locale` SET `Name` = 'Géomancien Crapuche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16937;
-- OLD name : Brute crapuche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16938
UPDATE `creature_template_locale` SET `Name` = 'Brute Crapuche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16938;
-- OLD name : Marchande du solstice
-- Source : https://www.wowhead.com/wotlk/fr/npc=16979
UPDATE `creature_template_locale` SET `Name` = 'Marchand du solstice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16979;
-- OLD name : Thiah Crin-Rouge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=16991
UPDATE `creature_template_locale` SET `Name` = 'Thiah Crin-rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 16991;
-- OLD name : Soldat du clan gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17016
UPDATE `creature_template_locale` SET `Name` = 'Soldat du clan Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17016;
-- OLD name : Rend Main-Noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17027
UPDATE `creature_template_locale` SET `Name` = 'Rend Main-noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17027;
-- OLD name : Avaleur de feu des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=17050
UPDATE `creature_template_locale` SET `Name` = 'Avaleur de feu des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17050;
-- OLD name : Griffe-Noire la Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17057
UPDATE `creature_template_locale` SET `Name` = 'Griffe-noire la Sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17057;
-- OLD name : Mana Tide Totem IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=17061
UPDATE `creature_template_locale` SET `Name` = 'Totem de Vague de mana IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17061;
-- OLD name : Doodad de remise de quête Silitus
-- Source : https://www.wowhead.com/wotlk/fr/npc=17090
UPDATE `creature_template_locale` SET `Name` = 'Doodad de remise de quête Silithus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17090;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=17105
UPDATE `creature_template_locale` SET `Title` = 'Maître des mages',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17105;
-- OLD name : Talbuk mâle
-- Source : https://www.wowhead.com/wotlk/fr/npc=17130
UPDATE `creature_template_locale` SET `Name` = 'Cerf talbuk',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17130;
-- OLD name : Ecraseur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17134
UPDATE `creature_template_locale` SET `Name` = 'Ecraseur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17134;
-- OLD name : Mystique rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17135
UPDATE `creature_template_locale` SET `Name` = 'Mystique Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17135;
-- OLD name : Guerrier rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17136
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17136;
-- OLD name : Mage rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17137
UPDATE `creature_template_locale` SET `Name` = 'Mage Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17137;
-- OLD name : Saccageur cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17138
UPDATE `creature_template_locale` SET `Name` = 'Saccageur Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17138;
-- OLD name : Furbolg bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17183
UPDATE `creature_template_locale` SET `Name` = 'Furbolg Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17183;
-- OLD name : Imploratrice céleste bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17184
UPDATE `creature_template_locale` SET `Name` = 'Imploratrice céleste Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17184;
-- OLD name : Ursa bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17185
UPDATE `creature_template_locale` SET `Name` = 'Ursa Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17185;
-- OLD name : Naga irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17193
UPDATE `creature_template_locale` SET `Name` = 'Naga Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17193;
-- OLD name : Myrmidon irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17194
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17194;
-- OLD name : Sirène irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17195
UPDATE `creature_template_locale` SET `Name` = 'Sirène Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17195;
-- OLD name : [DND] Carré d'échecs, BLANC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=17208
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17208;
-- OLD name : [PH] Héraut des Maleterres (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17239;
-- OLD name : Archéologue Adamant Cœur-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17242
UPDATE `creature_template_locale` SET `Name` = 'Archéologue Adamant Cœur-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17242;
-- OLD name : Affameur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17259
UPDATE `creature_template_locale` SET `Name` = 'Affameur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17259;
-- OLD name : Vorace mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17264
UPDATE `creature_template_locale` SET `Name` = 'Vorace Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17264;
-- OLD name : Destructeur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17271
UPDATE `creature_template_locale` SET `Name` = 'Destructeur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17271;
-- OLD name : Eventreur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17281
UPDATE `creature_template_locale` SET `Name` = 'Eventreur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17281;
-- OLD name : [DND] Carré d'échecs, NOIR (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=17305
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17305;
-- OLD name : Mannequin de test intuable de Slim
-- Source : https://www.wowhead.com/wotlk/fr/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17313;
-- OLD name : [DND] Carré d'échecs, EXTERIEUR BLANC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=17317
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17317;
-- OLD name : Guide bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17319
UPDATE `creature_template_locale` SET `Name` = 'Guide Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17319;
-- OLD name : Chaman bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17320
UPDATE `creature_template_locale` SET `Name` = 'Chaman Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17320;
-- OLD name : Fourrageur vase noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17325
UPDATE `creature_template_locale` SET `Name` = 'Fourrageur Vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17325;
-- OLD name : Eclaireur vase noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17326
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17326;
-- OLD name : Maître des flots vase noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17327
UPDATE `creature_template_locale` SET `Name` = 'Maître des flots Vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17327;
-- OLD name : Guerrier des rivages vase noire
-- Source : https://www.wowhead.com/wotlk/fr/npc=17328
UPDATE `creature_template_locale` SET `Name` = 'Guerrier du rivage vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17328;
-- OLD name : Guerrier vase noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17329
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17329;
-- OLD name : Oracle vase noire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17330
UPDATE `creature_template_locale` SET `Name` = 'Oracle Vase noire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17330;
-- OLD name : Rôdeur du rivage irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17331
UPDATE `creature_template_locale` SET `Name` = 'Rôdeur du rivage Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17331;
-- OLD name : Ecumeur irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17332
UPDATE `creature_template_locale` SET `Name` = 'Ecumeur Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17332;
-- OLD name : Hurleuse irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17333
UPDATE `creature_template_locale` SET `Name` = 'Hurleuse Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17333;
-- OLD name : Maraudeur irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17334
UPDATE `creature_template_locale` SET `Name` = 'Maraudeur Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17334;
-- OLD name : Garde-serpent irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17335
UPDATE `creature_template_locale` SET `Name` = 'Garde-serpent Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17335;
-- OLD name : Ensorceleuse irécaille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17336
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleuse Irécaille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17336;
-- OLD name : Ecrabouilleur corrompu
-- Source : https://www.wowhead.com/wotlk/fr/npc=17353
UPDATE `creature_template_locale` SET `Name` = 'Marteleur corrompu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17353;
-- OLD subname : Main de Kil'Jaeden
-- Source : https://www.wowhead.com/wotlk/fr/npc=17354
UPDATE `creature_template_locale` SET `Title` = 'Main de Kil''Jaedan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17354;
-- OLD name : Elémentaire d’eau souillée
-- Source : https://www.wowhead.com/wotlk/fr/npc=17358
UPDATE `creature_template_locale` SET `Name` = 'Esprit de l''eau souillé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17358;
-- OLD name : Apprentie Boulian
-- Source : https://www.wowhead.com/wotlk/fr/npc=17409
UPDATE `creature_template_locale` SET `Name` = 'Apprenti Boulian',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17409;
-- OLD name : Transformation d'alpha ombregueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17411
UPDATE `creature_template_locale` SET `Name` = 'Transformation d''alpha Ombregueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17411;
-- OLD name : Transformation de l'ancêtre Calmepins Coo
-- Source : https://www.wowhead.com/wotlk/fr/npc=17422
UPDATE `creature_template_locale` SET `Name` = 'Transformation de l''ancêtre Calmepin Coo',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17422;
-- OLD name : Belluaire mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17455
UPDATE `creature_template_locale` SET `Name` = 'Belluaire Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17455;
-- OLD name : [DND] Salle d'attente échecs (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=17459
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17459;
-- OLD subname : Mistress of Breadcrumbs
-- Source : https://www.wowhead.com/wotlk/fr/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (17515, 'frFR',NULL,'Maîtresse des miettes de pain',0);
-- OLD name : Factionnaire des Flammes infernales
-- Source : https://www.wowhead.com/wotlk/fr/npc=17517
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle des Flammes infernales',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17517;
-- OLD name : Jeune ravageur de Brume-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17525
UPDATE `creature_template_locale` SET `Name` = 'Jeune ravageur de Brume-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17525;
-- OLD name : Ravageur de Brume-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17526
UPDATE `creature_template_locale` SET `Name` = 'Ravageur de Brume-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17526;
-- OLD subname : Eleveur d'elekk
-- Source : https://www.wowhead.com/wotlk/fr/npc=17584
UPDATE `creature_template_locale` SET `Title` = 'Éleveur d''elekk',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17584;
-- OLD name : Péon mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17595
UPDATE `creature_template_locale` SET `Name` = 'Péon Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17595;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/fr/npc=17598
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17598;
-- OLD name : Garde tireur de précision
-- Source : https://www.wowhead.com/wotlk/fr/npc=17622
UPDATE `creature_template_locale` SET `Name` = 'Garde tireur d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17622;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=17634
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17634;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=17637
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17637;
-- OLD name : Embusqué bras-hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17640
UPDATE `creature_template_locale` SET `Name` = 'Embusqué Bras-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17640;
-- OLD name : Eclaireur vase noire marqué (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17654
UPDATE `creature_template_locale` SET `Name` = 'Eclaireur Vase noire marqué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17654;
-- OLD name : Nuage de poison de Broggok
-- Source : https://www.wowhead.com/wotlk/fr/npc=17662
UPDATE `creature_template_locale` SET `Name` = 'Nuage empoisonné de Broggok',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17662;
-- OLD name : Jessera de Mac'Aree
-- Source : https://www.wowhead.com/wotlk/fr/npc=17663
UPDATE `creature_template_locale` SET `Name` = 'Maatparm',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17663;
-- OLD name : Flèche enflammée
-- Source : https://www.wowhead.com/wotlk/fr/npc=17687
UPDATE `creature_template_locale` SET `Name` = 'Flèche enflamée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17687;
-- OLD name : Doodad de prise du Col du Nord (Horde) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17697
UPDATE `creature_template_locale` SET `Name` = 'Doodad de prise du Col du nord (Horde)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17697;
-- OLD name : Panthère d’œil de nuit
-- Source : https://www.wowhead.com/wotlk/fr/npc=17710
UPDATE `creature_template_locale` SET `Name` = 'Panthère d''oeil de nuit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17710;
-- OLD name : Factionnaire Iraileron
-- Source : https://www.wowhead.com/wotlk/fr/npc=17727
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Iraileron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17727;
-- OLD name : Membre de la tribu bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17728
UPDATE `creature_template_locale` SET `Name` = 'Membre de la tribu Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17728;
-- OLD name : Porte-épieu bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17729
UPDATE `creature_template_locale` SET `Name` = 'Porte-épieu Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17729;
-- OLD name : Soigneur bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17730
UPDATE `creature_template_locale` SET `Name` = 'Soigneur Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17730;
-- OLD name : Oracle bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17771
UPDATE `creature_template_locale` SET `Name` = 'Oracle Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17771;
-- OLD name : Améliorateur, tour Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=17794
UPDATE `creature_template_locale` SET `Name` = 'Amélioratrice, tour Alliance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17794;
-- OLD name : Esclave crapuche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17799
UPDATE `creature_template_locale` SET `Name` = 'Esclave Crapuche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17799;
-- OLD name : [INUTILISÉ] Worgen affolé
-- Source : https://www.wowhead.com/wotlk/fr/npc=17823
UPDATE `creature_template_locale` SET `Name` = 'Worgen affolé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17823;
-- OLD name : Malfrat bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17873
UPDATE `creature_template_locale` SET `Name` = 'Malfrat Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17873;
-- OLD name : [DND]Contrôleur du portail Epervier du soleil
-- Source : https://www.wowhead.com/wotlk/fr/npc=17886
UPDATE `creature_template_locale` SET `Name` = 'Contrôleur du portail Epervier du soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17886;
-- OLD name : Kameel Long-Pas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17896
UPDATE `creature_template_locale` SET `Name` = 'Kameel Long-pas',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17896;
-- OLD name : Nemas le Médiateur
-- Source : https://www.wowhead.com/wotlk/fr/npc=17912
UPDATE `creature_template_locale` SET `Name` = 'Nemas l''Arbitre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17912;
-- OLD name : Paysan de l’Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=17931
UPDATE `creature_template_locale` SET `Name` = 'Paysan de l''Alliance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17931;
-- OLD name : Guerrier tauren (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17933
UPDATE `creature_template_locale` SET `Name` = 'Guerrier Tauren',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17933;
-- OLD name : Kayra Long-Crin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17969
UPDATE `creature_template_locale` SET `Name` = 'Kayra Long-crin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17969;
-- OLD name : Brise-Dimension (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17977
UPDATE `creature_template_locale` SET `Name` = 'Brise-dimension',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17977;
-- OLD name : Bobine de Tesla de Brume-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=17979
UPDATE `creature_template_locale` SET `Name` = 'Bobine de Tesla de Brume-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 17979;
-- OLD name : Elémentaire d’eau gardien
-- Source : https://www.wowhead.com/wotlk/fr/npc=18001
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau gardien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18001;
-- OLD name : Démoniste cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18037
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18037;
-- OLD name : Garde-paix de Brume-Azur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18038
UPDATE `creature_template_locale` SET `Name` = 'Garde-paix de Brume-azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18038;
-- OLD name : Chaman cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18064
UPDATE `creature_template_locale` SET `Name` = 'Chaman Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18064;
-- OLD name : Brute cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18065
UPDATE `creature_template_locale` SET `Name` = 'Brute Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18065;
-- OLD name : Imploratrice céleste Sabot-Noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18070
UPDATE `creature_template_locale` SET `Name` = 'Imploratrice céleste Sabot-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18070;
-- OLD name : Chasseur tourbe-farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18113
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Tourbe-farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18113;
-- OLD name : Mystique tourbe-farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18114
UPDATE `creature_template_locale` SET `Name` = 'Mystique Tourbe-farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18114;
-- OLD name : Ogre ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18117
UPDATE `creature_template_locale` SET `Name` = 'Ogre Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18117;
-- OLD name : Chaman ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18118
UPDATE `creature_template_locale` SET `Name` = 'Chaman Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18118;
-- OLD name : Brute ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18119
UPDATE `creature_template_locale` SET `Name` = 'Brute Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18119;
-- OLD name : Marteleur ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18120
UPDATE `creature_template_locale` SET `Name` = 'Marteleur Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18120;
-- OLD name : Mangeur-d'âmes ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18121
UPDATE `creature_template_locale` SET `Name` = 'Mangeur-d''âmes Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18121;
-- OLD name : Manœuvre crapuche
-- Source : https://www.wowhead.com/wotlk/fr/npc=18122
UPDATE `creature_template_locale` SET `Name` = 'Manoeuvre Crapuche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18122;
-- OLD name : Gardien des âmes
-- Source : https://www.wowhead.com/wotlk/fr/npc=18153
UPDATE `creature_template_locale` SET `Name` = 'Gardien des âmes (DND)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18153;
-- OLD name : Désarçonneur d'Elekk de Brume-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18173
UPDATE `creature_template_locale` SET `Name` = 'Désarçonneur d''Elekk de Brume-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18173;
-- OLD name : Esprit serpent tourbe-farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18185
UPDATE `creature_template_locale` SET `Name` = 'Esprit serpent Tourbe-farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18185;
-- OLD name : Totem tourbe-farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18186
UPDATE `creature_template_locale` SET `Name` = 'Totem Tourbe-farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18186;
-- OLD name : Dela Totem-Runique (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18189
UPDATE `creature_template_locale` SET `Name` = 'Dela Totem-runique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18189;
-- OLD name : Doodad de remise de quête Silitus Horde
-- Source : https://www.wowhead.com/wotlk/fr/npc=18199
UPDATE `creature_template_locale` SET `Name` = 'Doodad de remise de quête Silithus Horde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18199;
-- OLD name : Ortor de bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18204
UPDATE `creature_template_locale` SET `Name` = 'Ortor de Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18204;
-- OLD name : Contrôleur Evénement bourbesang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18208
UPDATE `creature_template_locale` SET `Name` = 'Contrôleur Evénement Bourbesang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18208;
-- OLD name : Villageois de Berceau-de-l’’Eté
-- Source : https://www.wowhead.com/wotlk/fr/npc=18240
UPDATE `creature_template_locale` SET `Name` = 'Villageois de Berceau-de-l''Été',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18240;
-- OLD name : Envahisseur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18260
UPDATE `creature_template_locale` SET `Name` = 'Envahisseur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18260;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=18278
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18278;
-- OLD name : Aiguillon-Noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18283
UPDATE `creature_template_locale` SET `Name` = 'Aiguillon-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18283;
-- OLD name : Réfugié du poste de Berceau-de-l’’Eté
-- Source : https://www.wowhead.com/wotlk/fr/npc=18293
UPDATE `creature_template_locale` SET `Name` = 'Réfugié du poste de Berceau-de-l''Été',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18293;
-- OLD name : Orphelin du poste de Berceau-de-l’’Eté
-- Source : https://www.wowhead.com/wotlk/fr/npc=18296
UPDATE `creature_template_locale` SET `Name` = 'Orphelin du poste de Berceau-de-l''Été',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18296;
-- OLD name : Chasseur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18352
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18352;
-- OLD name : Griffon violet rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=18362
UPDATE `creature_template_locale` SET `Name` = 'Griffon violet rapide de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18362;
-- OLD name : Fissue d'ombre sauvage
-- Source : https://www.wowhead.com/wotlk/fr/npc=18370
UPDATE `creature_template_locale` SET `Name` = 'Fissure d''ombre sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18370;
-- OLD name : Focalisation du feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=18374
UPDATE `creature_template_locale` SET `Name` = 'Feu de focus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18374;
-- OLD name : Griffon vert rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=18375
UPDATE `creature_template_locale` SET `Name` = 'Griffon vert rapide de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18375;
-- OLD name : Griffon rouge rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=18376
UPDATE `creature_template_locale` SET `Name` = 'Griffon rouge rapide de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18376;
-- OLD name : Marqueur de crédit des ogres cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18393
UPDATE `creature_template_locale` SET `Name` = 'Marqueur de crédit des ogres Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18393;
-- OLD name : Marqueur de crédit du bûcher cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18395
UPDATE `creature_template_locale` SET `Name` = 'Marqueur de crédit du bûcher Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18395;
-- OLD name : Saboteur rochepoing (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18396
UPDATE `creature_template_locale` SET `Name` = 'Saboteur Rochepoing',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18396;
-- OLD name : Champion cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18402
UPDATE `creature_template_locale` SET `Name` = 'Champion Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18402;
-- OLD name : Griffon bleu rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=18406
UPDATE `creature_template_locale` SET `Name` = 'Griffon bleu rapide de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18406;
-- OLD name : Géomancien cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18420
UPDATE `creature_template_locale` SET `Name` = 'Géomancien Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18420;
-- OLD name : Chercheur cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18421
UPDATE `creature_template_locale` SET `Name` = 'Chercheur Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18421;
-- OLD name : Démon des Arcanes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18429
UPDATE `creature_template_locale` SET `Name` = 'Démon des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18429;
-- OLD name : Chef Bufferlo des cogneguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18440
UPDATE `creature_template_locale` SET `Name` = 'Chef Bufferlo des Cogneguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18440;
-- OLD name : Ame rageuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=18506
UPDATE `creature_template_locale` SET `Name` = 'Âme déchaînée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18506;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=18667
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18667;
-- OLD name : [INUTILISÉ] Anachorète Lyteera (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge A',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18674;
-- OLD name : Bro'Gaz Sans-Clan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18684
UPDATE `creature_template_locale` SET `Name` = 'Bro''Gaz Sans-clan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18684;
-- OLD name : Collidus le Guetteur-Dimensionnel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18694
UPDATE `creature_template_locale` SET `Name` = 'Collidus le Guetteur-dimensionnel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18694;
-- OLD name : Permacœur le Punisseur
-- Source : https://www.wowhead.com/wotlk/fr/npc=18698
UPDATE `creature_template_locale` SET `Name` = 'Permacoeur le Punisseur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18698;
-- OLD name : Loup de monte mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18706
UPDATE `creature_template_locale` SET `Name` = 'Loup de monte Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18706;
-- OLD name : Ame déchaînée volante
-- Source : https://www.wowhead.com/wotlk/fr/npc=18726
UPDATE `creature_template_locale` SET `Name` = 'Âme déchaînée volante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18726;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18747;
-- OLD name : Ruak Forte-Corne, subname : Maître des herboristes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18748
UPDATE `creature_template_locale` SET `Name` = 'Ruak Forte-corne',`Title` = 'Maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18748;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18749;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=18751
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18751;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18752;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18753;
-- OLD name : Barim Sabot-Fendu, subname : Maître des travailleurs du cuir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18754
UPDATE `creature_template_locale` SET `Name` = 'Barim Sabot-fendu',`Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18754;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18755;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18771;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18772;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18773;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18774;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18775;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18776;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18777;
-- OLD name : Ame rageuse cosmétique
-- Source : https://www.wowhead.com/wotlk/fr/npc=18778
UPDATE `creature_template_locale` SET `Name` = 'Âme déchaînée cosmétique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18778;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18779;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18802;
-- OLD name : Ambassadeur calmepin Frasaboo
-- Source : https://www.wowhead.com/wotlk/fr/npc=18803
UPDATE `creature_template_locale` SET `Name` = 'Ambassadeur calmepin Olorg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18803;
-- OLD name : Marqueur du poste de Berceau-de-l’Eté
-- Source : https://www.wowhead.com/wotlk/fr/npc=18840
UPDATE `creature_template_locale` SET `Name` = 'Marqueur du poste de Berceau-de-l''Été',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18840;
-- OLD name : Le bienveillant M. Pince-Mi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18845
UPDATE `creature_template_locale` SET `Name` = 'Le bienveillant M. Pince-mi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18845;
-- OLD name : Mor-Zylœil
-- Source : https://www.wowhead.com/wotlk/fr/npc=18895
UPDATE `creature_template_locale` SET `Name` = 'Mor-Zyloeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18895;
-- OLD subname : Maître des pêcheurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des pêcheurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18911;
-- OLD name : Amish Marteau-Hardi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18931
UPDATE `creature_template_locale` SET `Name` = 'Amish Marteau-hardi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18931;
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 18936;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 18941;
-- OLD name : Grunt d’Orgrimmar
-- Source : https://www.wowhead.com/wotlk/fr/npc=18950
UPDATE `creature_template_locale` SET `Name` = 'Grunt d''Orgrimmar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18950;
-- OLD name : Charognard mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18952
UPDATE `creature_template_locale` SET `Name` = 'Charognard Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18952;
-- OLD name : Unoke Tendre-Sabot (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18953
UPDATE `creature_template_locale` SET `Name` = 'Unoke Tendre-sabot',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18953;
-- OLD name : Grunt brise-pierres (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18973
UPDATE `creature_template_locale` SET `Name` = 'Grunt Brise-pierres',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18973;
-- OLD name : Tarentule croc-noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=18983
UPDATE `creature_template_locale` SET `Name` = 'Tarentule Croc-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18983;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Médecin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18990;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Médecin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18991;
-- OLD subname : Maître des cuisiniers & fournitures
-- Source : https://www.wowhead.com/wotlk/fr/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 18993;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19052;
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19060;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19063;
-- OLD name : Réfugié nain
-- Source : https://www.wowhead.com/wotlk/fr/npc=19077
UPDATE `creature_template_locale` SET `Name` = 'Nain réfugié',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19077;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19132;
-- OLD name : Diablotin attise-flammes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19136
UPDATE `creature_template_locale` SET `Name` = 'Diablotin Attise-flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19136;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/fr/npc=19145
UPDATE `creature_template_locale` SET `Title` = 'Maître des familiers chevaux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19145;
-- OLD name : Réfugié orc
-- Source : https://www.wowhead.com/wotlk/fr/npc=19150
UPDATE `creature_template_locale` SET `Name` = 'Orc réfugié',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19150;
-- OLD name : Astromage cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19168
UPDATE `creature_template_locale` SET `Name` = 'Astromage Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19168;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19180;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Médecin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19184;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Cuisinier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19185;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19187;
-- OLD name : Elémentaire des Arcanes Syth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19205
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire des arcanes Syth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19205;
-- OLD name : Gangrecanon : cible de peur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19211
UPDATE `creature_template_locale` SET `Name` = 'Cible de Gangrecanon : Peur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19211;
-- OLD name : Gangrecanon : cible de haine
-- Source : https://www.wowhead.com/wotlk/fr/npc=19212
UPDATE `creature_template_locale` SET `Name` = 'Cible de Gangrecanon : Haine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19212;
-- OLD name : Mécanoseigneur Capacitus
-- Source : https://www.wowhead.com/wotlk/fr/npc=19219
UPDATE `creature_template_locale` SET `Name` = 'Mécano-seigneur Capacitus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19219;
-- OLD subname : Amulettes ahurissantes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19227
UPDATE `creature_template_locale` SET `Title` = 'Amulettes Ahurissantes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19227;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19234
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19234;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19252;
-- OLD name : Grunt mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19269
UPDATE `creature_template_locale` SET `Name` = 'Grunt Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19269;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=19300
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19300;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=19301
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19301;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=19302
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19302;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=19303
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19303;
-- OLD name : Cœur-Noir le Séditieux
-- Source : https://www.wowhead.com/wotlk/fr/npc=19304
UPDATE `creature_template_locale` SET `Name` = 'Coeur-noir le Séditieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19304;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/fr/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (19325, 'frFR','Barnu Cassecombe','Maître des écuries',0);
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19341;
-- OLD subname : Armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=19351
UPDATE `creature_template_locale` SET `Title` = 'Armes à feu & munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19351;
-- OLD name : Arzeth le Sans-Clémence (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19354
UPDATE `creature_template_locale` SET `Name` = 'Arzeth le Sans-clémence',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19354;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Cuisinière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19369;
-- OLD name : Barimoke Barbe-Hirsute (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19394
UPDATE `creature_template_locale` SET `Name` = 'Barimoke Barbe-hirsute',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19394;
-- OLD name : Bron Martel-d’Or
-- Source : https://www.wowhead.com/wotlk/fr/npc=19395
UPDATE `creature_template_locale` SET `Name` = 'Bron Martel-d''or',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19395;
-- OLD name : Veneur des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=19406
UPDATE `creature_template_locale` SET `Name` = 'Veneur des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19406;
-- OLD name : Redresseur de torts de Brume-Azur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19407
UPDATE `creature_template_locale` SET `Name` = 'Redresseur de torts de Brume-azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19407;
-- OLD name : Grunt sire-tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19449
UPDATE `creature_template_locale` SET `Name` = 'Grunt Sire-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19449;
-- OLD name : Pol Sabot-de-Neige (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19450
UPDATE `creature_template_locale` SET `Name` = 'Pol Sabot-de-neige',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19450;
-- OLD name : Grillok « Sombrœil »
-- Source : https://www.wowhead.com/wotlk/fr/npc=19457
UPDATE `creature_template_locale` SET `Name` = 'Grillok « Sombroeil »',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19457;
-- OLD name : Ame de l'Orbite-sanglante
-- Source : https://www.wowhead.com/wotlk/fr/npc=19464
UPDATE `creature_template_locale` SET `Name` = 'Âme de l''Orbite-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19464;
-- OLD subname : Armes de jet
-- Source : https://www.wowhead.com/wotlk/fr/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Armes de jet & munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19473;
-- OLD name : Fera Coureur-Pâle (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19478
UPDATE `creature_template_locale` SET `Name` = 'Fera Coureur-pâle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19478;
-- OLD name : Chimiste cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19486
UPDATE `creature_template_locale` SET `Name` = 'Chimiste Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19486;
-- OLD subname : Maître des écuries
-- Source : https://www.wowhead.com/wotlk/fr/npc=19491
UPDATE `creature_template_locale` SET `Title` = 'Maître d''équitation',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19491;
-- OLD subname : Maître des écuries
-- Source : https://www.wowhead.com/wotlk/fr/npc=19492
UPDATE `creature_template_locale` SET `Title` = 'Maître d''équitation',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19492;
-- OLD name : Canaliste cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19505
UPDATE `creature_template_locale` SET `Name` = 'Canaliste Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19505;
-- OLD name : Recombinateur génétique cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19507
UPDATE `creature_template_locale` SET `Name` = 'Recombinateur génétique Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19507;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19537
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19537;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19539;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19540;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19575
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19575;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19576;
-- OLD name : Cible de l'orbe arcanique
-- Source : https://www.wowhead.com/wotlk/fr/npc=19577
UPDATE `creature_template_locale` SET `Name` = 'Cible de l''orbe des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19577;
-- OLD name : Monture kor’kronne
-- Source : https://www.wowhead.com/wotlk/fr/npc=19596
UPDATE `creature_template_locale` SET `Name` = 'Monture kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19596;
-- OLD name : Image de l’archimage Vargoth
-- Source : https://www.wowhead.com/wotlk/fr/npc=19644
UPDATE `creature_template_locale` SET `Name` = 'Image de l''archimage Vargoth',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19644;
-- OLD name : [PH]Sunfury Caster - Sunfury Hold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 19650;
-- OLD name : [Bunny]Area 52 Analyzer Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=19654
UPDATE `creature_template_locale` SET `Name` = 'Lapin d''analyse de la zone 52',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19654;
-- OLD name : [Bunny]Area 52 Ethereal Technology Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=19655
UPDATE `creature_template_locale` SET `Name` = 'Lapin de technologie éthérienne de la zone 52',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19655;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19661
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19661;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19663
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19663;
-- OLD name : [Test] Saccageur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19691
UPDATE `creature_template_locale` SET `Name` = 'Saccageur de test',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19691;
-- OLD name : Evocateur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19701
UPDATE `creature_template_locale` SET `Name` = 'Evocateur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19701;
-- OLD name : Gardien de porte Main-en-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19710
UPDATE `creature_template_locale` SET `Name` = 'Gardien de porte Main-en-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19710;
-- OLD name : Démoniste ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19732
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19732;
-- OLD name : Baelmon le Maître chien
-- Source : https://www.wowhead.com/wotlk/fr/npc=19747
UPDATE `creature_template_locale` SET `Name` = 'Baelmon le Maître-chien',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19747;
-- OLD name : Ame en peine ombrelune vengeresse
-- Source : https://www.wowhead.com/wotlk/fr/npc=19751
UPDATE `creature_template_locale` SET `Name` = 'Ame en peine vengeresse d''Ombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19751;
-- OLD name : Pisteur griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19807
UPDATE `creature_template_locale` SET `Name` = 'Pisteur griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19807;
-- OLD name : Tueur-d'orc griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19808
UPDATE `creature_template_locale` SET `Name` = 'Tueur-d''orc griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19808;
-- OLD name : Chaman griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19809
UPDATE `creature_template_locale` SET `Name` = 'Chaman griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19809;
-- OLD name : Sage-du-Néant griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19810
UPDATE `creature_template_locale` SET `Name` = 'Sage-du-Néant griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19810;
-- OLD name : Maître-de-bataille griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19811
UPDATE `creature_template_locale` SET `Name` = 'Maître-de-bataille griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19811;
-- OLD name : Grunt peau-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19814
UPDATE `creature_template_locale` SET `Name` = 'Grunt Peau-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19814;
-- OLD name : Démoniste peau-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19815
UPDATE `creature_template_locale` SET `Name` = 'Démoniste Peau-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19815;
-- OLD name : Seigneur de guerre peau-de-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19818
UPDATE `creature_template_locale` SET `Name` = 'Seigneur de guerre Peau-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19818;
-- OLD name : Loni « Lunettes » Grincebraquet, subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=19835
UPDATE `creature_template_locale` SET `Name` = 'Loni "Lunettes" Grincebraquet',`Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19835;
-- OLD name : Géomètre nathrezim (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19854
UPDATE `creature_template_locale` SET `Name` = 'Géomètre Nathrezim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19854;
-- OLD subname : Maître de guerre du bassin Arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=19855
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre du bassin d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19855;
-- OLD subname : Vendeuse de l'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=19857
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de l''arène',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19857;
-- OLD name : « Fausse-Patte » Artagueule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19858
UPDATE `creature_template_locale` SET `Name` = '« Fausse-patte » Artagueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19858;
-- OLD name : Capitaine inflexible vengeur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19864
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Inflexible vengeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19864;
-- OLD name : Piège à serpents
-- Source : https://www.wowhead.com/wotlk/fr/npc=19869
UPDATE `creature_template_locale` SET `Name` = 'Piège à serpent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19869;
-- OLD name : Usha Crève-Oeil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19906
UPDATE `creature_template_locale` SET `Name` = 'Usha Crève-oeil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19906;
-- OLD name : Sagan (forme de mouffette)
-- Source : https://www.wowhead.com/wotlk/fr/npc=19941
UPDATE `creature_template_locale` SET `Name` = 'Sagan (forme de mouflette)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19941;
-- OLD name : Implorateur de tempête vekh’nir
-- Source : https://www.wowhead.com/wotlk/fr/npc=19983
UPDATE `creature_template_locale` SET `Name` = 'Implorateur de tempête vekh''nir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 19983;
-- OLD name : Spécimen de tarentule croc-noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20027
UPDATE `creature_template_locale` SET `Name` = 'Spécimen de tarentule Croc-noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20027;
-- OLD name : Légionnaire garde-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20031
UPDATE `creature_template_locale` SET `Name` = 'Légionnaire Garde-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20031;
-- OLD name : Maréchal garde-sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20035
UPDATE `creature_template_locale` SET `Name` = 'Maréchal Garde-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20035;
-- OLD name : Dévastateur Cœur-de-cristal
-- Source : https://www.wowhead.com/wotlk/fr/npc=20040
UPDATE `creature_template_locale` SET `Name` = 'Dévastateur Coeur-de-cristal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20040;
-- OLD name : Sentinelle cœur-de-cristal
-- Source : https://www.wowhead.com/wotlk/fr/npc=20041
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle Coeur-de-cristal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20041;
-- OLD name : Mécanicien cœur-de-cristal
-- Source : https://www.wowhead.com/wotlk/fr/npc=20052
UPDATE `creature_template_locale` SET `Name` = 'Mécanicien Coeur-de-cristal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20052;
-- OLD name : Lieur de Néant cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20059
UPDATE `creature_template_locale` SET `Name` = 'Lieur de Néant Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20059;
-- OLD name : Imploratrice d’ondes écaille-sanglante
-- Source : https://www.wowhead.com/wotlk/fr/npc=20089
UPDATE `creature_template_locale` SET `Name` = 'Implorateur d''ondes écaille-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20089;
-- OLD name : Myrmidon écaille-sanglante
-- Source : https://www.wowhead.com/wotlk/fr/npc=20091
UPDATE `creature_template_locale` SET `Name` = 'Myrmidon Ecaille-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20091;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 20107;
-- OLD name : Sorcière des mers écaille-sanglante
-- Source : https://www.wowhead.com/wotlk/fr/npc=20122
UPDATE `creature_template_locale` SET `Name` = 'Sorcière des mers Ecaille-sanglante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20122;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20124;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20125;
-- OLD name : Rashere Fier-Sabot (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20250
UPDATE `creature_template_locale` SET `Name` = 'Rashere Fier-sabot',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20250;
-- OLD name : Druide tourbe-farouche (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20270
UPDATE `creature_template_locale` SET `Name` = 'Druide Tourbe-farouche',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20270;
-- OLD name : Sœur-louve Maka
-- Source : https://www.wowhead.com/wotlk/fr/npc=20276
UPDATE `creature_template_locale` SET `Name` = 'Soeur-louve Maka',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20276;
-- OLD subname : Armures d’arène historiques
-- Source : https://www.wowhead.com/wotlk/fr/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de l''arène brutale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20278;
-- OLD name : Battralisque ragepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20279
UPDATE `creature_template_locale` SET `Name` = 'Battralisque Ragepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20279;
-- OLD name : Piétineur ragepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20280
UPDATE `creature_template_locale` SET `Name` = 'Piétineur Ragepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20280;
-- OLD name : Erudit Dibbs
-- Source : https://www.wowhead.com/wotlk/fr/npc=20369
UPDATE `creature_template_locale` SET `Name` = 'Maître des traditions Dibbs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20369;
-- OLD name : Andrissa Piquecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=20385
UPDATE `creature_template_locale` SET `Name` = 'Andrissa Piquecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20385;
-- OLD name : Générateur d’événement Hautebrande d'antan
-- Source : https://www.wowhead.com/wotlk/fr/npc=20391
UPDATE `creature_template_locale` SET `Name` = 'Générateur d''événement Hautebrande d''antan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20391;
-- OLD name : Console de contrôle coruu
-- Source : https://www.wowhead.com/wotlk/fr/npc=20417
UPDATE `creature_template_locale` SET `Name` = 'Console de contrôle de Coruu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20417;
-- OLD name : Console de contrôle ara
-- Source : https://www.wowhead.com/wotlk/fr/npc=20440
UPDATE `creature_template_locale` SET `Name` = 'Console de contrôle d''Ara',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20440;
-- OLD name : Factionnaire ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20443
UPDATE `creature_template_locale` SET `Name` = 'Factionnaire Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20443;
-- OLD name : Ombremage ango'rosh (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20444
UPDATE `creature_template_locale` SET `Name` = 'Ombremage Ango''rosh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20444;
-- OLD subname : Gardienne des coursiers du vent
-- Source : https://www.wowhead.com/wotlk/fr/npc=20494
UPDATE `creature_template_locale` SET `Title` = 'Gardien des coursiers du vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20494;
-- OLD name : Spectre de Kirin'Var
-- Source : https://www.wowhead.com/wotlk/fr/npc=20496
UPDATE `creature_template_locale` SET `Name` = 'Spectre Kirin''Var',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20496;
-- OLD subname : Instructeur de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Instructeur de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20500;
-- OLD name : Griffon vert rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=20506
UPDATE `creature_template_locale` SET `Name` = 'Griffon vert rapide de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20506;
-- OLD subname : Instructrice de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Instructrice de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20511;
-- OLD name : Gardien arakkoa (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20560
UPDATE `creature_template_locale` SET `Name` = 'Gardien Arakkoa',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20560;
-- OLD name : Petit d'Araga
-- Source : https://www.wowhead.com/wotlk/fr/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Jeune sombre-gueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20615;
-- OLD name : Arzeth le Sans-Puissance (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20680
UPDATE `creature_template_locale` SET `Name` = 'Arzeth le Sans-puissance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20680;
-- OLD name : Rek'tor
-- Source : https://www.wowhead.com/wotlk/fr/npc=20716
UPDATE `creature_template_locale` SET `Name` = 'Raptor d''Outreterre, noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20716;
-- OLD name : Crocilisque écailles-barbelées
-- Source : https://www.wowhead.com/wotlk/fr/npc=20773
UPDATE `creature_template_locale` SET `Name` = 'Crocilisque Ecailles-barbelées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20773;
-- OLD subname : Ingénieur en chef de l’Ecodôme
-- Source : https://www.wowhead.com/wotlk/fr/npc=20811
UPDATE `creature_template_locale` SET `Title` = 'Ingénieur en chef de l''Écodôme',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20811;
-- OLD name : Dalliah l'Auspice-Funeste (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20885
UPDATE `creature_template_locale` SET `Name` = 'Dalliah l''Auspice-funeste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20885;
-- OLD name : Solus l’Eternel
-- Source : https://www.wowhead.com/wotlk/fr/npc=20888
UPDATE `creature_template_locale` SET `Name` = 'Solus l''Éternel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20888;
-- OLD name : Drakonyâr du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20910
UPDATE `creature_template_locale` SET `Name` = 'Drakonyâr du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20910;
-- OLD name : Zinyen Rôdeur-Agile, subname : Fabricant d'armes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20917
UPDATE `creature_template_locale` SET `Name` = 'Zinyen Rôdeur-agile',`Title` = 'Vendeur d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20917;
-- OLD name : Milhouse Tempête-de-Mana (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20977
UPDATE `creature_template_locale` SET `Name` = 'Milhouse Tempête-de-mana',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20977;
-- OLD name : Ingénieur cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=20988
UPDATE `creature_template_locale` SET `Name` = 'Ingénieur Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20988;
-- OLD name : Soldat d'élite solfurie
-- Source : https://www.wowhead.com/wotlk/fr/npc=20994
UPDATE `creature_template_locale` SET `Name` = 'Solfurie d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 20994;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21003;
-- OLD name : Bec-Azur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21005
UPDATE `creature_template_locale` SET `Name` = 'Bec-azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21005;
-- OLD name : Saigneur aile-rasoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21033
UPDATE `creature_template_locale` SET `Name` = 'Saigneur Aile-rasoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21033;
-- OLD name : Ame terrestre enragée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21073
UPDATE `creature_template_locale` SET `Name` = 'Âme terrestre enragée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21073;
-- OLD name : Chasseur mok'Nathal (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21081
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Mok''Nathal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21081;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21087;
-- OLD name : Bâton de mesure du conduit du Vide
-- Source : https://www.wowhead.com/wotlk/fr/npc=21091
UPDATE `creature_template_locale` SET `Name` = 'Bâton de mesure du conduits du Vide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21091;
-- OLD name : Ame flamboyante enragée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21097
UPDATE `creature_template_locale` SET `Name` = 'Âme flamboyante enragée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21097;
-- OLD name : Zone de Vide déliée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21101
UPDATE `creature_template_locale` SET `Name` = 'Zone de Vide délié',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21101;
-- OLD name : Ame aquatique enragée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21109
UPDATE `creature_template_locale` SET `Name` = 'Âme aquatique enragée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21109;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21112
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21112;
-- OLD name : Ame aérienne enragée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21116
UPDATE `creature_template_locale` SET `Name` = 'Âme aérienne enragée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21116;
-- OLD name : Chevaucheur de wyverne kor'kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=21153
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de wyvernes kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21153;
-- OLD name : Wyverne de monte kor'kronne caparaçonnée
-- Source : https://www.wowhead.com/wotlk/fr/npc=21154
UPDATE `creature_template_locale` SET `Name` = 'Wyverne de monte kor''kron caparaçonnée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21154;
-- OLD name : Orc mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21161
UPDATE `creature_template_locale` SET `Name` = 'Orc Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21161;
-- OLD name : Cyrukh le seigneur du Feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21181
UPDATE `creature_template_locale` SET `Name` = 'Cyrukh le Seigneur du feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21181;
-- OLD name : Oronok Cœur-Fendu
-- Source : https://www.wowhead.com/wotlk/fr/npc=21183
UPDATE `creature_template_locale` SET `Name` = 'Oronok Coeur-fendu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21183;
-- OLD name : Arakkoa marche-sur-les-os (Rouge) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21184
UPDATE `creature_template_locale` SET `Name` = 'Arakkoa Marche-sur-les-os (Rouge)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21184;
-- OLD name : Arakkoa marche-sur-les-os (Vert) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21199
UPDATE `creature_template_locale` SET `Name` = 'Arakkoa Marche-sur-les-os (Vert)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21199;
-- OLD name : Arakkoa marche-sur-les-os (Jaune) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21201
UPDATE `creature_template_locale` SET `Name` = 'Arakkoa Marche-sur-les-os (Jaune)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21201;
-- OLD name : Arakkoa marche-sur-les-os (Noir) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21202
UPDATE `creature_template_locale` SET `Name` = 'Arakkoa Marche-sur-les-os (Noir)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21202;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21209;
-- OLD name : Maître des flots griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21229
UPDATE `creature_template_locale` SET `Name` = 'Maître des flots griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21229;
-- OLD name : Mage-du-Néant griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21230
UPDATE `creature_template_locale` SET `Name` = 'Mage-du-Néant griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21230;
-- OLD name : Porte-bouclier griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21231
UPDATE `creature_template_locale` SET `Name` = 'Porte-bouclier griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21231;
-- OLD name : Furtif griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21232
UPDATE `creature_template_locale` SET `Name` = 'Furtif griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21232;
-- OLD name : Messager mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21244
UPDATE `creature_template_locale` SET `Name` = 'Messager Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21244;
-- OLD name : Maraudeur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21245
UPDATE `creature_template_locale` SET `Name` = 'Maraudeur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21245;
-- OLD name : Elémentaire d’eau purifié
-- Source : https://www.wowhead.com/wotlk/fr/npc=21260
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau purifié',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21260;
-- OLD name : Technicien griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21263
UPDATE `creature_template_locale` SET `Name` = 'Technicien griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21263;
-- OLD name : Redresseur de torts Vuleen
-- Source : https://www.wowhead.com/wotlk/fr/npc=21277
UPDATE `creature_template_locale` SET `Name` = 'Redresseur de torts Vuuleen',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21277;
-- OLD name : Explosion des Arcanes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21290
UPDATE `creature_template_locale` SET `Name` = 'Explosion des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21290;
-- OLD name : Kurdran Marteau-Hardi (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21330
UPDATE `creature_template_locale` SET `Name` = 'Kurdran Marteau-hardi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21330;
-- OLD name : Nœud d'apparition de Veneratus
-- Source : https://www.wowhead.com/wotlk/fr/npc=21334
UPDATE `creature_template_locale` SET `Name` = 'Noeud d''apparition de Veneratus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21334;
-- OLD name : Nœud de tubercule de la vallée d'Ombrelune
-- Source : https://www.wowhead.com/wotlk/fr/npc=21347
UPDATE `creature_template_locale` SET `Name` = 'Noeud de tubercule de la vallée d''Ombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21347;
-- OLD name : Tireur de précision du poste
-- Source : https://www.wowhead.com/wotlk/fr/npc=21441
UPDATE `creature_template_locale` SET `Name` = 'Tireur d''élite du poste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21441;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21488;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/fr/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (21634, 'frFR','Trotteur des forêts',NULL,0);
-- OLD name : Oronok Cœur-Fendu
-- Source : https://www.wowhead.com/wotlk/fr/npc=21685
UPDATE `creature_template_locale` SET `Name` = 'Oronok Coeur-fendu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21685;
-- OLD name : Querelleur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21717
UPDATE `creature_template_locale` SET `Name` = 'Querelleur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21717;
-- OLD name : Subjugateur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21718
UPDATE `creature_template_locale` SET `Name` = 'Subjugateur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21718;
-- OLD name : Monteur de drake gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21719
UPDATE `creature_template_locale` SET `Name` = 'Monteur de drake Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21719;
-- OLD name : Chaman gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21720
UPDATE `creature_template_locale` SET `Name` = 'Chaman Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21720;
-- OLD name : Zorus le Judicateur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21774
UPDATE `creature_template_locale` SET `Name` = 'Zorus le judicateur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21774;
-- OLD name : Lieur de sort griscœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=21806
UPDATE `creature_template_locale` SET `Name` = 'Lieur de sort griscoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21806;
-- OLD name : Charge d'hydroglycérine massive
-- Source : https://www.wowhead.com/wotlk/fr/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21848;
-- OLD name : Illusion d'un gobelin
-- Source : https://www.wowhead.com/wotlk/fr/npc=21885
UPDATE `creature_template_locale` SET `Name` = 'Illusion d''un gnome',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21885;
-- OLD name : Illusion d'une gobeline
-- Source : https://www.wowhead.com/wotlk/fr/npc=21886
UPDATE `creature_template_locale` SET `Name` = 'Illusion d''une gnome',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21886;
-- OLD name : Pourfendeur sethekk (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21889
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeur Sethekk',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21889;
-- OLD name : Soigneterre Sabot-Cagneux (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21938
UPDATE `creature_template_locale` SET `Name` = 'Soigneterre Sabot-cagneux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21938;
-- OLD name : Larissa Frappesoleil
-- Source : https://www.wowhead.com/wotlk/fr/npc=21954
UPDATE `creature_template_locale` SET `Name` = 'Larissa Heurtesoleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21954;
-- OLD name : Totem de force de la terre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21992
UPDATE `creature_template_locale` SET `Name` = 'Totem de Force de la Terre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21992;
-- OLD name : Totem de peau de pierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=21994
UPDATE `creature_template_locale` SET `Name` = 'Totem de Peau de pierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 21994;
-- OLD name : Drake du Néant gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22000
UPDATE `creature_template_locale` SET `Name` = 'Drake du Néant Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22000;
-- OLD name : Jaillissement des Arcanes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22022
UPDATE `creature_template_locale` SET `Name` = 'Jaillissement des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22022;
-- OLD name : [DND]Esprit 1
-- Source : https://www.wowhead.com/wotlk/fr/npc=22023
UPDATE `creature_template_locale` SET `Name` = 'Esprit 1',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22023;
-- OLD name : Docteur Gâtemembre
-- Source : https://www.wowhead.com/wotlk/fr/npc=22062
UPDATE `creature_template_locale` SET `Name` = 'Dr Gâtemembre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22062;
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22118;
-- OLD name : Brise-dos gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22143
UPDATE `creature_template_locale` SET `Name` = 'Brise-dos Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22143;
-- OLD name : Elémentaliste gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22144
UPDATE `creature_template_locale` SET `Name` = 'Elémentaliste Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22144;
-- OLD name : Casse-tête gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22148
UPDATE `creature_template_locale` SET `Name` = 'Casse-tête Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22148;
-- OLD name : Sœur de la sylve Ruuan
-- Source : https://www.wowhead.com/wotlk/fr/npc=22151
UPDATE `creature_template_locale` SET `Name` = 'Soeur de la sylve Ruuan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22151;
-- OLD name : Rocher embrasé
-- Source : https://www.wowhead.com/wotlk/fr/npc=22161
UPDATE `creature_template_locale` SET `Name` = 'Rocher enflammé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22161;
-- OLD name : Orc gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22197
UPDATE `creature_template_locale` SET `Name` = 'Orc Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22197;
-- OLD subname : Spécialiste de couture de l'étoffe lunaire
-- Source : https://www.wowhead.com/wotlk/fr/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Spécialiste de l''étoffe lunaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22208;
-- OLD subname : Spécialiste de couture de tisse-ombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Spécialiste du tisse-ombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22212;
-- OLD subname : Spécialiste de couture de feu-sorcier
-- Source : https://www.wowhead.com/wotlk/fr/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Spécialiste du feu-sorcier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22213;
-- OLD name : Archer gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22251
UPDATE `creature_template_locale` SET `Name` = 'Archer Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22251;
-- OLD name : Péon gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22252
UPDATE `creature_template_locale` SET `Name` = 'Péon Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22252;
-- OLD name : Ascendant gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22253
UPDATE `creature_template_locale` SET `Name` = 'Ascendant Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22253;
-- OLD name : Brise-ciel gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22274
UPDATE `creature_template_locale` SET `Name` = 'Brise-ciel Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22274;
-- OLD name : Cœur-de-terre grondant
-- Source : https://www.wowhead.com/wotlk/fr/npc=22313
UPDATE `creature_template_locale` SET `Name` = 'Coeur-de-terre grondant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22313;
-- OLD name : Cible kil'jaeden
-- Source : https://www.wowhead.com/wotlk/fr/npc=22320
UPDATE `creature_template_locale` SET `Name` = 'Cible kil''jaedan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22320;
-- OLD name : Elite gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22331
UPDATE `creature_template_locale` SET `Name` = 'Elite Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22331;
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22356;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22368;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22383;
-- OLD name : [PH]Altar of Shadows target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22395
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22395;
-- OLD name : [PH]Altar of Shadows caster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22417
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22417;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22435;
-- OLD name : [Bunny]Anchorite Relic Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=22444
UPDATE `creature_template_locale` SET `Name` = 'Lapin de relique d''anachorète',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22444;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22447;
-- OLD name : Transformation du diablotin gangrené instable
-- Source : https://www.wowhead.com/wotlk/fr/npc=22475
UPDATE `creature_template_locale` SET `Name` = 'Transformation de diablotin gangrené instable',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22475;
-- OLD subname : Vol draconique noir
-- Source : https://www.wowhead.com/wotlk/fr/npc=22496
UPDATE `creature_template_locale` SET `Title` = 'Vol noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22496;
-- OLD name : Ténèbre délivrée
-- Source : https://www.wowhead.com/wotlk/fr/npc=22507
UPDATE `creature_template_locale` SET `Name` = 'Ténèbre libérée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22507;
-- OLD name : Transformation de saccageur gangrené en morceaux
-- Source : https://www.wowhead.com/wotlk/fr/npc=22509
UPDATE `creature_template_locale` SET `Name` = 'Saccageur gangrené en morceaux transformé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22509;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 22801;
-- OLD name : Brute de la Ville basse secourue (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22811
UPDATE `creature_template_locale` SET `Name` = 'Brute de la ville Basse secourue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22811;
-- OLD name : Arthorn Chant-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22924
UPDATE `creature_template_locale` SET `Name` = 'Arthorn Chant-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22924;
-- OLD name : Concubine du temple
-- Source : https://www.wowhead.com/wotlk/fr/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Acolyte du temple',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22939;
-- OLD name : Charmante courtisane
-- Source : https://www.wowhead.com/wotlk/fr/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Client séduisant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22955;
-- OLD name : Sœur de la douleur
-- Source : https://www.wowhead.com/wotlk/fr/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Prêtresse du tourment',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22956;
-- OLD name : Prêtresse de la démence
-- Source : https://www.wowhead.com/wotlk/fr/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Maîtresse de la démence',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22957;
-- OLD name : Raie du Néant verte
-- Source : https://www.wowhead.com/wotlk/fr/npc=22958
UPDATE `creature_template_locale` SET `Name` = 'Raie du Néant de monte verte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22958;
-- OLD name : Domestique envoûté
-- Source : https://www.wowhead.com/wotlk/fr/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Hôte fervent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22959;
-- OLD name : Mande-wyrm gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22960
UPDATE `creature_template_locale` SET `Name` = 'Mande-wyrm Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22960;
-- OLD name : Prêtresse du délice
-- Source : https://www.wowhead.com/wotlk/fr/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Maîtresse du malheur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22962;
-- OLD name : Ouvrier mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22963
UPDATE `creature_template_locale` SET `Name` = 'Ouvrier Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22963;
-- OLD name : Sœur du plaisir
-- Source : https://www.wowhead.com/wotlk/fr/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Prêtresse du délice',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22964;
-- OLD name : Serviteur asservi
-- Source : https://www.wowhead.com/wotlk/fr/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Régisseur dévoué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22965;
-- OLD name : Chevaucheur d'elekk ligelumière (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=22966
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur d''elekk Ligelumière',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22966;
-- OLD name : [VIEUX]Totem de courroux II
-- Source : https://www.wowhead.com/wotlk/fr/npc=22970
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTotem de courroux II',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22970;
-- OLD name : [VIEUX]Totem de courroux III
-- Source : https://www.wowhead.com/wotlk/fr/npc=22971
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTotem de courroux III',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22971;
-- OLD name : Raie du Néant violette
-- Source : https://www.wowhead.com/wotlk/fr/npc=22975
UPDATE `creature_template_locale` SET `Name` = 'Raie du Néant de monte violette',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22975;
-- OLD name : Raie du Néant rouge
-- Source : https://www.wowhead.com/wotlk/fr/npc=22976
UPDATE `creature_template_locale` SET `Name` = 'Raie du Néant de monte rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22976;
-- OLD name : Raie du Néant argentée
-- Source : https://www.wowhead.com/wotlk/fr/npc=22977
UPDATE `creature_template_locale` SET `Name` = 'Raie du Néant de monte argentée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 22977;
-- OLD name : Fauche-l'âme gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23022
UPDATE `creature_template_locale` SET `Name` = 'Fauche-l''âme Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23022;
-- OLD name : Serpent crépusculaire
-- Source : https://www.wowhead.com/wotlk/fr/npc=23026
UPDATE `creature_template_locale` SET `Name` = 'Serpent du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23026;
-- OLD name : Sous-chef mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23028
UPDATE `creature_template_locale` SET `Name` = 'Sous-chef Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23028;
-- OLD name : Traqueur du ciel gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23030
UPDATE `creature_template_locale` SET `Name` = 'Traqueur du ciel Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23030;
-- OLD name : Maître d'arme ombrelune
-- Source : https://www.wowhead.com/wotlk/fr/npc=23049
UPDATE `creature_template_locale` SET `Name` = 'Maître d''armes ombrelune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23049;
-- OLD name : Elémentaire des Arcanes sans défaut (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23100
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire des arcanes sans défaut',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23100;
-- OLD name : Garde-paix d'Ogrila
-- Source : https://www.wowhead.com/wotlk/fr/npc=23115
UPDATE `creature_template_locale` SET `Name` = 'Garde-paix d''Ogri''la',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23115;
-- OLD name : Illusion de gangr'orc (male)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23129
UPDATE `creature_template_locale` SET `Name` = 'Illusion gangr''orc (male)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23129;
-- OLD name : Illusion de gangr'orc (alternatif)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23130
UPDATE `creature_template_locale` SET `Name` = 'Illusion gangr''orc (alternatif)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23130;
-- OLD name : Massacreur gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23146
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23146;
-- OLD name : Combattant d'arène gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23150
UPDATE `creature_template_locale` SET `Name` = 'Combattant d''arène Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23150;
-- OLD subname : Intendant des Ligemorts cendrelangues (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23159
UPDATE `creature_template_locale` SET `Title` = 'Intendant des ligemorts cendrelangues',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23159;
-- OLD name : Transport gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23188
UPDATE `creature_template_locale` SET `Name` = 'Transport Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23188;
-- OLD name : Béhémoth mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23196
UPDATE `creature_template_locale` SET `Name` = 'Béhémoth Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23196;
-- OLD subname : Apprenti féticheur
-- Source : https://www.wowhead.com/wotlk/fr/npc=23201
UPDATE `creature_template_locale` SET `Title` = 'Apprenti sorcier-docteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23201;
-- OLD name : Crédit de mort de péon gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23209
UPDATE `creature_template_locale` SET `Name` = 'Crédit de mort de péon Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23209;
-- OLD name : Péon mouton gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23213
UPDATE `creature_template_locale` SET `Name` = 'Péon mouton Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23213;
-- OLD name : Assassin shivarra
-- Source : https://www.wowhead.com/wotlk/fr/npc=23220
UPDATE `creature_template_locale` SET `Name` = 'Assassin shivan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23220;
-- OLD name : Bagarreur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23222
UPDATE `creature_template_locale` SET `Name` = 'Bagarreur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23222;
-- OLD name : Spectateur mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23223
UPDATE `creature_template_locale` SET `Name` = 'Spectateur Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23223;
-- OLD name : Soldat d'élite illidari
-- Source : https://www.wowhead.com/wotlk/fr/npc=23226
UPDATE `creature_template_locale` SET `Name` = 'Elite illidari',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23226;
-- OLD name : Lames-furieuses mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23235
UPDATE `creature_template_locale` SET `Name` = 'Lames-furieuses Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23235;
-- OLD name : Disciple du bouclier mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23236
UPDATE `creature_template_locale` SET `Name` = 'Disciple du bouclier Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23236;
-- OLD name : Prophète de sang mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23237
UPDATE `creature_template_locale` SET `Name` = 'Prophète de sang Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23237;
-- OLD name : Combattant mâche-les-os (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23239
UPDATE `creature_template_locale` SET `Name` = 'Combattant Mâche-les-os',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23239;
-- OLD name : Image de gangregarde en fumée
-- Source : https://www.wowhead.com/wotlk/fr/npc=23252
UPDATE `creature_template_locale` SET `Name` = 'Image en fumée de gangregarde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23252;
-- OLD name : Point de travail de péon gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23308
UPDATE `creature_template_locale` SET `Name` = 'Point de travail de péon Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23308;
-- OLD name : Péon gueule-de-dragon désobéissant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23311
UPDATE `creature_template_locale` SET `Name` = 'Péon Gueule-de-dragon désobéissant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23311;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23317;
-- OLD name : Instructeur de vol gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23321
UPDATE `creature_template_locale` SET `Name` = 'Instructeur de vol Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23321;
-- OLD name : Cible instructeur de vol gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23325
UPDATE `creature_template_locale` SET `Name` = 'Cible instructeur de vol Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23325;
-- OLD name : Saccageur des vents gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23330
UPDATE `creature_template_locale` SET `Name` = 'Saccageur des vents Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23330;
-- OLD name : Ray Etoile-du-Matin
-- Source : https://www.wowhead.com/wotlk/fr/npc=23331
UPDATE `creature_template_locale` SET `Name` = 'Ray Étoile-du-matin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23331;
-- OLD name : Phalène de monte gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23341
UPDATE `creature_template_locale` SET `Name` = 'Phalène de monte Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23341;
-- OLD name : Course gueule-de-dragon : Cible de Vieillot (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23356
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible de Vieillot',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23356;
-- OLD name : Course gueule-de-dragon : Cible de Trope (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23357
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible de Trope',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23357;
-- OLD name : Course gueule-de-dragon : Cible de Corlok (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23358
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible de Corlok',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23358;
-- OLD name : Course gueule-de-dragon : Cible d'Ichman (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23359
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible d''Ichman',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23359;
-- OLD name : Course gueule-de-dragon : Cible de Mulverick (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23360
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible de Mulverick',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23360;
-- OLD name : Course gueule-de-dragon : Cible de Fracasse-ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23361
UPDATE `creature_template_locale` SET `Name` = 'Course Gueule-de-dragon : Cible de Fracasse-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23361;
-- OLD name : [Test] Champ
-- Source : https://www.wowhead.com/wotlk/fr/npc=23366
UPDATE `creature_template_locale` SET `Name` = 'Champi test',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23366;
-- OLD name : Contrôleur de la tour gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23370
UPDATE `creature_template_locale` SET `Name` = 'Contrôleur de la tour Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23370;
-- OLD name : Contremaître gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23376
UPDATE `creature_template_locale` SET `Name` = 'Contremaître Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23376;
-- OLD subname : Mailles et plaques classiques de l’Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=23396
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de l''arène',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23396;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/fr/npc=23405
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de consommables du RPT',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23405;
-- OLD name : Brise-ciel gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23440
UPDATE `creature_template_locale` SET `Name` = 'Brise-ciel Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23440;
-- OLD name : Brise-ciel gueule-de-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23441
UPDATE `creature_template_locale` SET `Name` = 'Brise-ciel Gueule-de-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23441;
-- OLD name : Marqueur de crédit de raid gueule-de-dragon (Clairvoyants) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23443
UPDATE `creature_template_locale` SET `Name` = 'Marqueur de crédit de raid Gueule-de-dragon (Clairvoyants)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23443;
-- OLD name : Mandataire gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23450
UPDATE `creature_template_locale` SET `Name` = 'Mandataire Gordunni',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23450;
-- OLD name : Marqueur de crédit de raid gueule-de-dragon (Aldor) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23454
UPDATE `creature_template_locale` SET `Name` = 'Marqueur de crédit de raid Gueule-de-dragon (Aldor)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23454;
-- OLD name : Drake de l’Aile-du-Néant viride
-- Source : https://www.wowhead.com/wotlk/fr/npc=23457
UPDATE `creature_template_locale` SET `Name` = 'Drake de l''Aile-du-Néant viride',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23457;
-- OLD name : Ame asservie
-- Source : https://www.wowhead.com/wotlk/fr/npc=23469
UPDATE `creature_template_locale` SET `Name` = 'Âme asservie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23469;
-- OLD name : [PH] Brewfest Dwarf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23479;
-- OLD name : [PH] Brewfest Human Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23480;
-- OLD name : Elekk rose de Brume-Azur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23528
UPDATE `creature_template_locale` SET `Name` = 'Elekk rose de Brume-azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23528;
-- OLD name : [PH] Brewfest Garden D Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23532;
-- OLD name : Dragon rouge de Norfendre (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=23538
UPDATE `creature_template_locale` SET `Name` = 'Dragon rouge du Norfendre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23538;
-- OLD name : Drake rouge de Norfendre (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=23539
UPDATE `creature_template_locale` SET `Name` = 'Drake rouge du Norfendre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23539;
-- OLD name : [PH] Brewfest Goblin Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23540;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/fr/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Truducou',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23559;
-- OLD subname : Avatar de faucon-dragon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23578
UPDATE `creature_template_locale` SET `Title` = 'Avatar de Faucon-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23578;
-- OLD name : Déserteur agitateur
-- Source : https://www.wowhead.com/wotlk/fr/npc=23602
UPDATE `creature_template_locale` SET `Name` = 'Agitateur des déserteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23602;
-- OLD name : Agnes Faneloin
-- Source : https://www.wowhead.com/wotlk/fr/npc=23604
UPDATE `creature_template_locale` SET `Name` = 'Agnes Fâneloin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23604;
-- OLD name : [PH] Brewfest Orc Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23607;
-- OLD name : [PH] Brewfest Tauren Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23608;
-- OLD name : [PH] Brewfest Troll Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23609;
-- OLD name : [PH] Brewfest Blood Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23610;
-- OLD name : [PH] Brewfest Undead Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23611;
-- OLD name : [PH] Brewfest Draenei Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23613;
-- OLD name : [PH] Brewfest Gnome Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23614;
-- OLD name : [PH] Brewfest Night Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23615;
-- OLD name : Ahab Sabot-de-Blé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23618
UPDATE `creature_template_locale` SET `Name` = 'Ahab Sabot-de-blé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23618;
-- OLD name : Chef Peaux-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23623
UPDATE `creature_template_locale` SET `Name` = 'Chef Peaux-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23623;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23634;
-- OLD name : Mande-flot longue-défense (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=23641
UPDATE `creature_template_locale` SET `Name` = 'Mande-mers longue-défense',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23641;
-- OLD name : Membre de la tribu Ecorche-dragon
-- Source : https://www.wowhead.com/wotlk/fr/npc=23651
UPDATE `creature_template_locale` SET `Name` = 'Membre de la tribu Écorche-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23651;
-- OLD name : Halfdan au Cœur de glace
-- Source : https://www.wowhead.com/wotlk/fr/npc=23671
UPDATE `creature_template_locale` SET `Name` = 'Halfdan au Coeur de glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23671;
-- OLD name : Gnome mâle des lunettes Cul-de-Bouteille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23697
UPDATE `creature_template_locale` SET `Name` = 'Gnome mâle des lunettes Cul-de-bouteille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23697;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23703;
-- OLD name : Ecluseur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23709
UPDATE `creature_template_locale` SET `Name` = 'Ecluseur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23709;
-- OLD subname : Echange de jetons
-- Source : https://www.wowhead.com/wotlk/fr/npc=23710
UPDATE `creature_template_locale` SET `Title` = 'Échange de jetons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23710;
-- OLD name : Créature de test de Clayton (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=23715
UPDATE `creature_template_locale` SET `Name` = 'Clayton''s Test Creature (2)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23715;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23734;
-- OLD name : Canonnier Ely
-- Source : https://www.wowhead.com/wotlk/fr/npc=23770
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23770;
-- OLD name : Infirmier de la flotte du Nord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23794
UPDATE `creature_template_locale` SET `Name` = 'Infirmier de la flotte du nord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23794;
-- OLD name : Antagoniste sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23795
UPDATE `creature_template_locale` SET `Name` = 'Antagoniste Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23795;
-- OLD name : [DND] Brewfest Keg Move to Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Tonneau de la fête des Brasseurs se déplace vers la cible',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23808;
-- OLD name : Eleveuse de chauves-souris Camille, subname : Eleveuse de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=23816
UPDATE `creature_template_locale` SET `Name` = 'Éleveuse de chauve-souris Camille',`Title` = 'Éleveuse de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23816;
-- OLD name : [PH] Brewfest Dwarf Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23819;
-- OLD name : [PH] Brewfest Dwarf Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23820;
-- OLD name : [PH] Brewfest Goblin Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23824;
-- OLD name : [PH] Brewfest Goblin Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23830;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23855;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=23862
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23862;
-- OLD name : Ancien de l’Etreinte de braise
-- Source : https://www.wowhead.com/wotlk/fr/npc=23870
UPDATE `creature_template_locale` SET `Name` = 'Ancien de l''Étreinte de braise',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23870;
-- OLD name : Esprit lynx amani
-- Source : https://www.wowhead.com/wotlk/fr/npc=23877
UPDATE `creature_template_locale` SET `Name` = 'Esprit de lynx amani',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23877;
-- OLD name : Esprit aigle amani
-- Source : https://www.wowhead.com/wotlk/fr/npc=23880
UPDATE `creature_template_locale` SET `Name` = 'Esprit d''aigle amani',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23880;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23894;
-- OLD subname : Maître des pêcheurs & fournitures
-- Source : https://www.wowhead.com/wotlk/fr/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Marchand de poissons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23896;
-- OLD name : Visuel de transformation d'esprit aigle
-- Source : https://www.wowhead.com/wotlk/fr/npc=23913
UPDATE `creature_template_locale` SET `Name` = 'Visuel de transformation d''esprit d''aigle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23913;
-- OLD name : Récupérateur de la flotte du Nord (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23934
UPDATE `creature_template_locale` SET `Name` = 'Récupérateur de la flotte du nord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23934;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 23936;
-- OLD name : Drake crins-de-feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=23969
UPDATE `creature_template_locale` SET `Name` = 'Drake Crins-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 23969;
-- OLD name : Tigre spectral
-- Source : https://www.wowhead.com/wotlk/fr/npc=24003
UPDATE `creature_template_locale` SET `Name` = 'Tigre (fantôme)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24003;
-- OLD name : Tigre spectral rapide
-- Source : https://www.wowhead.com/wotlk/fr/npc=24004
UPDATE `creature_template_locale` SET `Name` = 'Tigre rapide (fantôme)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24004;
-- OLD name : Ouvrier de siège
-- Source : https://www.wowhead.com/wotlk/fr/npc=24005
UPDATE `creature_template_locale` SET `Name` = 'Ouvrier de la scierie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24005;
-- OLD name : Talu Sabot-de-Givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24028
UPDATE `creature_template_locale` SET `Name` = 'Talu Sabot-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24028;
-- OLD name : Brave du camp Sabot-d'Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24031
UPDATE `creature_template_locale` SET `Name` = 'Brave du camp Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24031;
-- OLD name : Celea Crin-Gelé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24032
UPDATE `creature_template_locale` SET `Name` = 'Celea Crin-gelé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24032;
-- OLD name : Bori Totem-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=24033
UPDATE `creature_template_locale` SET `Name` = 'Bori Totem-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24033;
-- OLD name : Headless Horseman - Wisp Invis
-- Source : https://www.wowhead.com/wotlk/fr/npc=24034
UPDATE `creature_template_locale` SET `Name` = 'Cavalier sans tête - Feu follet invisible',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24034;
-- OLD name : Balar Plaie-du-Rhum (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24054
UPDATE `creature_template_locale` SET `Name` = 'Balar Plaie-du-rhum',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24054;
-- OLD name : Mahana Sabot-de-Givre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24067
UPDATE `creature_template_locale` SET `Name` = 'Mahana Sabot-de-givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24067;
-- OLD name : Maître-forge écorche-dragon
-- Source : https://www.wowhead.com/wotlk/fr/npc=24079
UPDATE `creature_template_locale` SET `Name` = 'Maître de forge écorche-dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24079;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24109
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Target Dummy Move To Target',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24109;
-- OLD name : Ame d'Halfdan
-- Source : https://www.wowhead.com/wotlk/fr/npc=24119
UPDATE `creature_template_locale` SET `Name` = 'Âme d''Halfdan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24119;
-- OLD name : Nokoma Oeil-des-Neiges (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24123
UPDATE `creature_template_locale` SET `Name` = 'Nokoma Oeil-des-neiges',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24123;
-- OLD name : Ahota Givre-Blanc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24127
UPDATE `creature_template_locale` SET `Name` = 'Ahota Givre-blanc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24127;
-- OLD name : Chef Totem-de-Frêne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24129
UPDATE `creature_template_locale` SET `Name` = 'Chef Totem-de-frêne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24129;
-- OLD name : Coursier du vent Sabot-d’’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=24132
UPDATE `creature_template_locale` SET `Name` = 'Coursier du vent Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24132;
-- OLD name : Ancien guide spirituel du Totem-Sinistre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24133
UPDATE `creature_template_locale` SET `Name` = 'Ancien guide spirituel du Totem-sinistre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24133;
-- OLD name : Coursier du vent du camp Sabot-d’’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=24142
UPDATE `creature_template_locale` SET `Name` = 'Coursier du vent du camp Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24142;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=24155
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24155;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24171;
-- OLD name : [INUTILISÉ] Ghost of Explorer Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24181;
-- OLD name : Sage Marche-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24186
UPDATE `creature_template_locale` SET `Name` = 'Sage Marche-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24186;
-- OLD name : Long-coureur sabot-d'hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24195
UPDATE `creature_template_locale` SET `Name` = 'Long-coureur Sabot-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24195;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24205;
-- OLD name : Armée des morts
-- Source : https://www.wowhead.com/wotlk/fr/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Goule de l''armée des morts',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24207;
-- OLD name : Long-coureur Nuage-du-Ciel (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24209
UPDATE `creature_template_locale` SET `Name` = 'Long-coureur Nuage-du-ciel',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24209;
-- OLD name : Long-coureur sabot-d'hiver libéré (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24211
UPDATE `creature_template_locale` SET `Name` = 'Long-coureur Sabot-d''hiver libéré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24211;
-- OLD name : Firjus l’Ecraseur d'âmes
-- Source : https://www.wowhead.com/wotlk/fr/npc=24213
UPDATE `creature_template_locale` SET `Name` = 'Firjus l''Écraseur d''âmes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24213;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24220;
-- OLD name : Sombrecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=24246
UPDATE `creature_template_locale` SET `Name` = 'Sombrecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24246;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24265;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24311;
-- OLD name : Jason Bonbuffet, subname : Tavernier
-- Source : https://www.wowhead.com/wotlk/fr/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Tavernier Jason Bonbuffet',`Title` = 'Boissons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24333;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24337;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24352;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24361;
-- OLD name : Cadavre de Harrison
-- Source : https://www.wowhead.com/wotlk/fr/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Cadavre de Willie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24365;
-- OLD name : [INUTILISÉ] Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24377;
-- OLD name : [INUTILISÉ] Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24378;
-- OLD name : Leeni « Sourire » Smalls
-- Source : https://www.wowhead.com/wotlk/fr/npc=24392
UPDATE `creature_template_locale` SET `Name` = 'Leeni "Sourire" Smalls',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24392;
-- OLD subname : Vendeur de l'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=24395
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24395;
-- OLD name : Fudgerick
-- Source : https://www.wowhead.com/wotlk/fr/npc=24406
UPDATE `creature_template_locale` SET `Name` = 'Caramelkicolle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24406;
-- OLD name : Homme invisible - sans armes (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24417
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24417;
-- OLD name : Image de seigneur des failles (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24429
UPDATE `creature_template_locale` SET `Name` = 'Image de Seigneur des failles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24429;
-- OLD name : Image de Canaliste cherche-soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24430
UPDATE `creature_template_locale` SET `Name` = 'Image de Canaliste Cherche-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24430;
-- OLD name : Image de Brise-Dimension (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24431
UPDATE `creature_template_locale` SET `Name` = 'Image de Brise-dimension',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24431;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24456
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24456;
-- OLD name : Feu de forge
-- Source : https://www.wowhead.com/wotlk/fr/npc=24471
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24471;
-- OLD subname : Echange de jetons
-- Source : https://www.wowhead.com/wotlk/fr/npc=24495
UPDATE `creature_template_locale` SET `Title` = 'Échange de jetons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24495;
-- OLD name : Orque des lunettes Cul-de-Bouteille (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24496
UPDATE `creature_template_locale` SET `Name` = 'Orque des lunettes Cul-de-bouteille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24496;
-- OLD subname : Intendante des armures
-- Source : https://www.wowhead.com/wotlk/fr/npc=24520
UPDATE `creature_template_locale` SET `Title` = 'Intendant des armures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24520;
-- OLD name : Héraut sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24536
UPDATE `creature_template_locale` SET `Name` = 'Héraut Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24536;
-- OLD name : Harry « Lune-d’Argent »
-- Source : https://www.wowhead.com/wotlk/fr/npc=24539
UPDATE `creature_template_locale` SET `Name` = 'Harry « Lune-d''argent »',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24539;
-- OLD name : Mande-flot vraie-défense (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24588
UPDATE `creature_template_locale` SET `Name` = 'Mande-mers vraie-défense',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24588;
-- OLD name : Surgisseur de marée supérieur (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24599
UPDATE `creature_template_locale` SET `Name` = 'Surgisseur des marées supérieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24599;
-- OLD name : Furie des glace (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24604
UPDATE `creature_template_locale` SET `Name` = 'Furie des glaces',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24604;
-- OLD name : Gardien Fanefeuille
-- Source : https://www.wowhead.com/wotlk/fr/npc=24638
UPDATE `creature_template_locale` SET `Name` = 'Gardien Fânefeuille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24638;
-- OLD name : Bannière de l’Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=24640
UPDATE `creature_template_locale` SET `Name` = 'Bannière de l''Alliance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24640;
-- OLD name : Totem élémentaire de terre roué
-- Source : https://www.wowhead.com/wotlk/fr/npc=24649
UPDATE `creature_template_locale` SET `Name` = 'Totem d''élémentaire de terre roué',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24649;
-- OLD name : [PH] BLB Blue Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24658;
-- OLD name : Lieutenant Martel-de-glace
-- Source : https://www.wowhead.com/wotlk/fr/npc=24665
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24665;
-- OLD name : Flame Strike Trigger (Kael - 5Man)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24666
UPDATE `creature_template_locale` SET `Name` = 'Déclencheur de Choc de flammes (Kael - 5pers.)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24666;
-- OLD name : Sergent Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24667
UPDATE `creature_template_locale` SET `Name` = 'Sergent Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24667;
-- OLD name : Chef Trombe-de-l’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=24703
UPDATE `creature_template_locale` SET `Name` = 'Chef Trombe-de-l''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24703;
-- OLD name : Dan « Patte-de-Corbeau » (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24713
UPDATE `creature_template_locale` SET `Name` = 'Dan « Patte-de-corbeau »',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24713;
-- OLD name : Selin Cœur-de-Feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=24723
UPDATE `creature_template_locale` SET `Name` = 'Selin Coeur-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24723;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24766;
-- OLD name : Epervier des roches apprivoisé
-- Source : https://www.wowhead.com/wotlk/fr/npc=24783
UPDATE `creature_template_locale` SET `Name` = 'Epervier des rochers apprivoisé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24783;
-- OLD name : Sous-chef ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24818
UPDATE `creature_template_locale` SET `Name` = 'Sous-chef Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24818;
-- OLD name : Massacreur ragenclume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24819
UPDATE `creature_template_locale` SET `Name` = 'Massacreur Ragenclume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24819;
-- OLD name : Pilleur cavepierre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=24830
UPDATE `creature_template_locale` SET `Name` = 'Pilleur Cavepierre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24830;
-- OLD name : Pirate défias
-- Source : https://www.wowhead.com/wotlk/fr/npc=24860
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24860;
-- OLD name : Relai du rayon de cristal (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24865
UPDATE `creature_template_locale` SET `Name` = 'Relais du rayon de cristal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24865;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24868;
-- OLD name : [PH]Avalanche (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 24912;
-- OLD name : Canon de Sœur Miséricorde
-- Source : https://www.wowhead.com/wotlk/fr/npc=24913
UPDATE `creature_template_locale` SET `Name` = 'Canon de Soeur Miséricorde',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24913;
-- OLD subname : Compagne du Flaconosaure
-- Source : https://www.wowhead.com/wotlk/fr/npc=24982
UPDATE `creature_template_locale` SET `Title` = 'Vendeuse d’enchantements du RPT',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24982;
-- OLD name : Esprit de magnataure souillé (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=24983
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Magnataure souillé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24983;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24993
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24993;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24995
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24995;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24996
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24996;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24997
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24997;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=24998
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 24998;
-- OLD subname : L’Ecume de lune
-- Source : https://www.wowhead.com/wotlk/fr/npc=25007
UPDATE `creature_template_locale` SET `Title` = 'L''Écume de lune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25007;
-- OLD name : Seraphina Cœur-de-Sang
-- Source : https://www.wowhead.com/wotlk/fr/npc=25037
UPDATE `creature_template_locale` SET `Name` = 'Seraphina Coeur-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25037;
-- OLD name : Elémentaire d’eau supérieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=25040
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau supérieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25040;
-- OLD subname : La Bénédiction d’Elune
-- Source : https://www.wowhead.com/wotlk/fr/npc=25050
UPDATE `creature_template_locale` SET `Title` = 'La Bénédiction d''Elune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25050;
-- OLD subname : La Bénédiction d’Elune
-- Source : https://www.wowhead.com/wotlk/fr/npc=25052
UPDATE `creature_template_locale` SET `Title` = 'La Bénédiction d''Elune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25052;
-- OLD name : Emissary of Hate Credit
-- Source : https://www.wowhead.com/wotlk/fr/npc=25065
UPDATE `creature_template_locale` SET `Name` = 'Crédit de l''émissaire de haine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25065;
-- OLD name : Emissary of Dread Credit
-- Source : https://www.wowhead.com/wotlk/fr/npc=25066
UPDATE `creature_template_locale` SET `Name` = 'Crédit de l''émissaire d''Effroi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25066;
-- OLD name : Emissary of Despair Credit
-- Source : https://www.wowhead.com/wotlk/fr/npc=25067
UPDATE `creature_template_locale` SET `Name` = 'Crédit de l''émissaire de Désespoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25067;
-- OLD name : Crédit chasselaube
-- Source : https://www.wowhead.com/wotlk/fr/npc=25092
UPDATE `creature_template_locale` SET `Name` = 'Crédit de Chasse-aurore',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25092;
-- OLD name : Bosco Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25098
UPDATE `creature_template_locale` SET `Name` = 'Bosco Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25098;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25099;
-- OLD name : Navigateur Ecoutille
-- Source : https://www.wowhead.com/wotlk/fr/npc=25104
UPDATE `creature_template_locale` SET `Name` = 'Navigateur Écoutille',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25104;
-- OLD name : [PH] Bri's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25139;
-- OLD name : Chef Peaux-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25149
UPDATE `creature_template_locale` SET `Name` = 'Chef Peaux-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25149;
-- OLD name : Drake de l’Aile-du-Néant asservi de Corlok
-- Source : https://www.wowhead.com/wotlk/fr/npc=25182
UPDATE `creature_template_locale` SET `Name` = 'Drake du Néant asservi de Corlok',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25182;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/fr/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de munitions spécialisées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/fr/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de munitions spécialisées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25196;
-- OLD name : Mannequin d’entraînement
-- Source : https://www.wowhead.com/wotlk/fr/npc=25225
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25225;
-- OLD subname : Suzerain de l'offensive chanteguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25237
UPDATE `creature_template_locale` SET `Title` = 'Suzerain de l''Offensive chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25237;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Grand maître ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25277;
-- OLD name : Turida Vent-Froid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25288
UPDATE `creature_template_locale` SET `Name` = 'Turida Vent-froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25288;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/fr/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25323, 'frFR',NULL,'Ingénieur logiciel',0);
-- OLD name : Gorge le Broyeur de cadavres
-- Source : https://www.wowhead.com/wotlk/fr/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25329;
-- OLD name : Long-coureur Sabot-Fier (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25335
UPDATE `creature_template_locale` SET `Name` = 'Long-coureur Sabot-fier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25335;
-- OLD subname : Le Cercle terrestre
-- Source : https://www.wowhead.com/wotlk/fr/npc=25344
UPDATE `creature_template_locale` SET `Title` = 'Cercle terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25344;
-- OLD subname : Le Cercle terrestre
-- Source : https://www.wowhead.com/wotlk/fr/npc=25345
UPDATE `creature_template_locale` SET `Title` = 'Cercle terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25345;
-- OLD name : Viktor, espion du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25346
UPDATE `creature_template_locale` SET `Name` = 'Viktor, espion du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25346;
-- OLD name : Chasseur de trésors de Béryl
-- Source : https://www.wowhead.com/wotlk/fr/npc=25353
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de trésor de Béryl',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25353;
-- OLD subname : Le Cercle terrestre
-- Source : https://www.wowhead.com/wotlk/fr/npc=25360
UPDATE `creature_template_locale` SET `Title` = 'Cercle terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25360;
-- OLD name : L'Aîné Corne-de-Pouvoir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25380
UPDATE `creature_template_locale` SET `Name` = 'L''Aîné Corne-de-pouvoir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25380;
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/fr/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25406, 'frFR',NULL,'Ingénieur logiciel',0);
-- OLD subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/fr/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25411, 'frFR',NULL,'Ingénieur logiciel',0);
-- OLD name : [Deuxième vaisseau kvaldir (Le drakkar de Kur)] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25511
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25511;
-- OLD name : [Troisième vaisseau kvaldir (Le marteau de Bor)] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25512
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25512;
-- OLD name : [PH] Festival Fire Juggler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25515
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25515;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/fr/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (25537, 'frFR','Craig''s Test Human',NULL,0);
-- OLD name : Douloureuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=25591
UPDATE `creature_template_locale` SET `Name` = 'Tortionnaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25591;
-- OLD name : Milicien de Comté-Lointaine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25617
UPDATE `creature_template_locale` SET `Name` = 'Milicien de Comté-lointaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25617;
-- OLD name : Drake rouge (monture rapide)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25695
UPDATE `creature_template_locale` SET `Name` = 'Drake rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25695;
-- OLD name : Brûletin incendiaire
-- Source : https://www.wowhead.com/wotlk/fr/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Brûletin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25706;
-- OLD subname : Seigneur-azur du Vol draconique bleu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25712
UPDATE `creature_template_locale` SET `Title` = 'Seigneur-azur du vol draconique bleu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25712;
-- OLD name : Chasseur de mages rehaussé
-- Source : https://www.wowhead.com/wotlk/fr/npc=25724
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de mages réhaussé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25724;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 25746;
-- OLD name : Chasseresse magnataure affaiblie (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25788
UPDATE `creature_template_locale` SET `Name` = 'Chasseresse Magnataure affaiblie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25788;
-- OLD name : Lige du feu du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25863
UPDATE `creature_template_locale` SET `Name` = 'Lige du feu du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25863;
-- OLD name : Garde des flammes du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25866
UPDATE `creature_template_locale` SET `Name` = 'Garde des flammes du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25866;
-- OLD name : Gardien des flammes arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=25887
UPDATE `creature_template_locale` SET `Name` = 'Gardien des flammes d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25887;
-- OLD name : Gardien des flammes de Brume-Azur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25888
UPDATE `creature_template_locale` SET `Name` = 'Gardien des flammes de Brume-azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25888;
-- OLD name : Gardienne des flammes des terres Foudroyées (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25890
UPDATE `creature_template_locale` SET `Name` = 'Gardienne des flammes des Terres foudroyées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25890;
-- OLD name : Gardien des flammes de Brume-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25891
UPDATE `creature_template_locale` SET `Name` = 'Gardien des flammes de Brume-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25891;
-- OLD name : Gardienne des flammes des steppes Ardentes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25892
UPDATE `creature_template_locale` SET `Name` = 'Gardienne des flammes des Steppes ardentes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25892;
-- OLD name : Gardien des flammes des Maleterres de l'Ouest (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25909
UPDATE `creature_template_locale` SET `Name` = 'Gardien des flammes des Maleterres de l''ouest',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25909;
-- OLD name : Gardien des flammes du cap Strangleronce
-- Source : https://www.wowhead.com/wotlk/fr/npc=25915
UPDATE `creature_template_locale` SET `Name` = 'Gardienne des flammes de la vallée de Strangleronce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25915;
-- OLD name : Garde-flammes du cap Strangleronce
-- Source : https://www.wowhead.com/wotlk/fr/npc=25920
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes de la vallée de Strangleronce',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25920;
-- OLD name : Garde-flammes arathi
-- Source : https://www.wowhead.com/wotlk/fr/npc=25923
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes d''Arathi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25923;
-- OLD name : Viktor, porte-parole du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25924
UPDATE `creature_template_locale` SET `Name` = 'Viktor, porte-parole du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25924;
-- OLD name : Garde-flammes des terres Ingrates (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25925
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes des Terres ingrates',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25925;
-- OLD name : Garde-flammes des steppes Ardentes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=25927
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes des Steppes ardentes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25927;
-- OLD name : Garde-flammes de la forêt des Pins-Argentés
-- Source : https://www.wowhead.com/wotlk/fr/npc=25939
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes de la forêt des Pins argentés',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25939;
-- OLD name : Le garde-flammes des Tarides du Nord
-- Source : https://www.wowhead.com/wotlk/fr/npc=25943
UPDATE `creature_template_locale` SET `Name` = 'Garde-flammes des Tarides',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25943;
-- OLD name : Cracheur de feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=25962
UPDATE `creature_template_locale` SET `Name` = 'Mangeur de feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25962;
-- OLD name : Maître cracheur de feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=25975
UPDATE `creature_template_locale` SET `Name` = 'Maître mangeur de feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25975;
-- OLD name : [Bunny]Ahune Ice Spear Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=25985
UPDATE `creature_template_locale` SET `Name` = 'Lapin lance de glace Ahune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 25985;
-- OLD name : Oiseau de proie dressable
-- Source : https://www.wowhead.com/wotlk/fr/npc=26028
UPDATE `creature_template_locale` SET `Name` = 'Chouette dressable',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26028;
-- OLD name : Déguisement masculin du solstice du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26042
UPDATE `creature_template_locale` SET `Name` = 'Déguisement masculin du solstice du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26042;
-- OLD name : Trésorier
-- Source : https://www.wowhead.com/wotlk/fr/npc=26075
UPDATE `creature_template_locale` SET `Name` = 'Trésorier-payeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26075;
-- OLD name : Ame de gnome
-- Source : https://www.wowhead.com/wotlk/fr/npc=26096
UPDATE `creature_template_locale` SET `Name` = 'Âme de gnome',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26096;
-- OLD name : Crédit de céréales de Comté-Lointaine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26161
UPDATE `creature_template_locale` SET `Name` = 'Crédit de céréales de Comté-lointaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26161;
-- OLD name : Fusée-de-néant X-51 X-TREME
-- Source : https://www.wowhead.com/wotlk/fr/npc=26164
UPDATE `creature_template_locale` SET `Name` = 'Monture fusée, rouge',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26164;
-- OLD name : Evacué de Taunka'le
-- Source : https://www.wowhead.com/wotlk/fr/npc=26167
UPDATE `creature_template_locale` SET `Name` = 'Evacuée de Taunka''le',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26167;
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26176;
-- OLD subname : Emissaire taurène
-- Source : https://www.wowhead.com/wotlk/fr/npc=26181
UPDATE `creature_template_locale` SET `Title` = 'Émissaire taurène',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26181;
-- OLD name : Soldat d’élite kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=26183
UPDATE `creature_template_locale` SET `Name` = 'Kor''kron d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26183;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26190;
-- OLD name : Fusée-de-néant X-51
-- Source : https://www.wowhead.com/wotlk/fr/npc=26192
UPDATE `creature_template_locale` SET `Name` = 'Monture fusée, bleue',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26192;
-- OLD name : Cryomancien du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26222
UPDATE `creature_template_locale` SET `Name` = 'Cryomancien du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26222;
-- OLD name : Givrelame du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26223
UPDATE `creature_template_locale` SET `Name` = 'Givrelame du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26223;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26241;
-- OLD name : Panthère chantelombre
-- Source : https://www.wowhead.com/wotlk/fr/npc=26244
UPDATE `creature_template_locale` SET `Name` = 'Panthère de chantelombre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26244;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26258;
-- OLD name : Le Cœur d'Entropius
-- Source : https://www.wowhead.com/wotlk/fr/npc=26262
UPDATE `creature_template_locale` SET `Name` = 'Le Coeur d''Entropius',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26262;
-- OLD name : [PH] Dragonblight Ancient (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26274
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26274;
-- OLD name : [PH] Dragonblight Black Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26275;
-- OLD name : [PH] Dragonblight Green Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26278;
-- OLD name : Chasseur de mages de la Désolation des dragons (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26280
UPDATE `creature_template_locale` SET `Name` = 'Chasseur de mages de la désolation des dragons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26280;
-- OLD name : [PH] Dragonblight Elemental Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26285;
-- OLD name : Déclencheur d'évènement de la côte Oubliée
-- Source : https://www.wowhead.com/wotlk/fr/npc=26288
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26288;
-- OLD name : [PH] Dragonblight Scourge Carrion Fields (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26292;
-- OLD name : [PH] Dragonblight Magma Wyrm (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26294;
-- OLD name : [PH] Dragonblight Scarlet Onslaught (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26296;
-- OLD name : Vendeur d'armure en étoffe
-- Source : https://www.wowhead.com/wotlk/fr/npc=26301
UPDATE `creature_template_locale` SET `Name` = 'Vendeur d''armure étoffe et cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26301;
-- OLD name : Vendeur de fournitures générales
-- Source : https://www.wowhead.com/wotlk/fr/npc=26304
UPDATE `creature_template_locale` SET `Name` = 'Vendeuses de fournitures générales',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26304;
-- OLD name : Vendeuse d'armures en plaques
-- Source : https://www.wowhead.com/wotlk/fr/npc=26305
UPDATE `creature_template_locale` SET `Name` = 'Vendeuse d''armures mailles & plaques',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26305;
-- OLD name : Vendeuse d'armures en cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=26306
UPDATE `creature_template_locale` SET `Name` = 'Vendeur d''armures en mailles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26306;
-- OLD name : Vendeur d'armures en mailles
-- Source : https://www.wowhead.com/wotlk/fr/npc=26308
UPDATE `creature_template_locale` SET `Name` = 'Vendeuse d''armures en plaques',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26308;
-- OLD name : [PH] Dragonblight Taunka (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26311;
-- OLD name : [PH] Dragonblight Taunka Spirit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26312;
-- OLD name : [PH] Dragonblight Treant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26313;
-- OLD name : [PH] Dragonblight Scourge Galakrond Rest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26317;
-- OLD name : [PH] Dragonblight Scourge Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26318;
-- OLD name : [PH] Dragonblight Scourge Ruby Dragonshrine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26320;
-- OLD name : Ver des Arcanes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26322
UPDATE `creature_template_locale` SET `Name` = 'Ver des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26322;
-- OLD name : Maître des démoniste
-- Source : https://www.wowhead.com/wotlk/fr/npc=26331
UPDATE `creature_template_locale` SET `Name` = 'Maître des démonistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26331;
-- OLD name : [Bunny]Ahune's Bottle Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=26346
UPDATE `creature_template_locale` SET `Name` = 'Lapin bouteille d''Ahune',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26346;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26355;
-- OLD name : Evee Cuivressort, subname : Vendeuse de l'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26378;
-- OLD name : Grikkin Cuivressort, subname : Vendeur de l'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26383;
-- OLD name : Frixee Briquedouille, subname : Vendeuse de l'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26391;
-- OLD name : Sergent Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26396
UPDATE `creature_template_locale` SET `Name` = 'Sergent Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26396;
-- OLD subname : Fils de Chanteguerre (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=26486
UPDATE `creature_template_locale` SET `Title` = 'Les Fils de Chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26486;
-- OLD name : [PH] Dragonblight Carrion Field Necromancer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26489;
-- OLD name : [PH] Dragonblight Carrion Field Zombie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26490;
-- OLD name : [PH] Dragonblight Carrion Field Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26491;
-- OLD name : Essor Fureur-du-Faucon (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26504
UPDATE `creature_template_locale` SET `Name` = 'Essor Fureur-du-faucon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26504;
-- OLD name : Epandeur de chancre des Réprouvés
-- Source : https://www.wowhead.com/wotlk/fr/npc=26523
UPDATE `creature_template_locale` SET `Name` = 'Épandeur de chancre réprouvé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26523;
-- OLD name : [Demo] Craig Amai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26535;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26564;
-- OLD subname : Fournitures d’herboriste et poisons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26568
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste et poisons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26568;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26576;
-- OLD name : Brume-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26585
UPDATE `creature_template_locale` SET `Name` = 'Brume-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26585;
-- OLD name : Transformation de clairvoyance spirituelle (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=26594
UPDATE `creature_template_locale` SET `Name` = 'Clairvoyance spirituelle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26594;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=26600
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26600;
-- OLD name : Horreur de saronite
-- Source : https://www.wowhead.com/wotlk/fr/npc=26646
UPDATE `creature_template_locale` SET `Name` = 'Horreur saronite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26646;
-- OLD name : Grande-mère Brume-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26652
UPDATE `creature_template_locale` SET `Name` = 'Grande-mère Brume-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26652;
-- OLD name : Roanauk Brume-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26654
UPDATE `creature_template_locale` SET `Name` = 'Roanauk Brume-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26654;
-- OLD name : Garde de guerre azjol-anak (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26662
UPDATE `creature_template_locale` SET `Name` = 'Garde de guerre Azjol-anak',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26662;
-- OLD name : [PH] Named Condor Shirrak (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26665;
-- OLD name : Cible d'invocation d'araignées
-- Source : https://www.wowhead.com/wotlk/fr/npc=26675
UPDATE `creature_template_locale` SET `Name` = 'Cible d''invocation d''araignée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26675;
-- OLD name : Aiyan Vent-Froid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26680
UPDATE `creature_template_locale` SET `Name` = 'Aiyan Vent-froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26680;
-- OLD name : Litoko Totem-de-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26707
UPDATE `creature_template_locale` SET `Name` = 'Litoko Totem-de-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26707;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26724;
-- OLD name : Banthok Brume-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26733
UPDATE `creature_template_locale` SET `Name` = 'Banthok Brume-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26733;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26765;
-- OLD name : Brave Ciel-de-Tempête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26766
UPDATE `creature_template_locale` SET `Name` = 'Brave Ciel-de-tempête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26766;
-- OLD subname : Thug Life
-- Source : https://www.wowhead.com/wotlk/fr/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (26791, 'frFR',NULL,'Vie de nervi',0);
-- OLD name : Ormorok le Sculpte-Arbre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26794
UPDATE `creature_template_locale` SET `Name` = 'Ormorok le Sculpte-arbre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26794;
-- OLD name : Roanauk Brume-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26810
UPDATE `creature_template_locale` SET `Name` = 'Roanauk Brume-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26810;
-- OLD name : [PH] Dragonblight Shoveltusk Scavenger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26835;
-- OLD name : [PH] Dragonblight Named Frost Wyrm Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 26840;
-- OLD subname : Eleveuse de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=26844
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26844;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=26845
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26845;
-- OLD name : Makki Trombe-de-l’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=26853
UPDATE `creature_template_locale` SET `Name` = 'Makki Trombe-de-l''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26853;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=26901
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26901;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26903
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26903;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26904
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26904;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26905
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26905;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26906
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26906;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26907
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26907;
-- OLD subname : Maître des pêcheurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26909
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des pêcheurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26909;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26910
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26910;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=26911
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26911;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26912
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26912;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26913
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26913;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26914
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26914;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26915
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26915;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26916
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26916;
-- OLD name : Brokkan Bras-d’Ours
-- Source : https://www.wowhead.com/wotlk/fr/npc=26941
UPDATE `creature_template_locale` SET `Name` = 'Brokkan Bras-d''ours',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26941;
-- OLD subname : Chambellan du Conseil régnant
-- Source : https://www.wowhead.com/wotlk/fr/npc=26949
UPDATE `creature_template_locale` SET `Title` = 'Majordome du Conseil régnant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26949;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26951
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26951;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26952
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26952;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26953
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26953;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26954
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26954;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26955
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26955;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26956;
-- OLD subname : Maître des pêcheurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26957
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des pêcheurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26957;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26958
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26958;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26959
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26959;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26960
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26960;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=26961
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26961;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26962
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26962;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26963
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26963;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26964
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26964;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26969;
-- OLD name : Orn Tendre-Sabot, subname : Maître des cuisiniers (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26972
UPDATE `creature_template_locale` SET `Name` = 'Orn Tendre-sabot',`Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26972;
-- OLD name : Tansy Crin-Sauvage, subname : Maître des herboristes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26974
UPDATE `creature_template_locale` SET `Name` = 'Tansy Crin-sauvage',`Title` = 'Grand maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26974;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26975
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26975;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26976
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26976;
-- OLD name : Adelene Lance-Solaire, subname : Maître des calligraphes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26977
UPDATE `creature_template_locale` SET `Name` = 'Adelene Lance-solaire',`Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26977;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26980
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26980;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26981
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26981;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26982
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26982;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26986
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26986;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26987
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26987;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=26988
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26988;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26989
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26989;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26990
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26990;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26991
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26991;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26992;
-- OLD subname : Maître des pêcheurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=26993
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des pêcheurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26993;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26994
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26994;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=26995
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26995;
-- OLD name : Awan Né-de-Glace, subname : Maître des travailleurs du cuir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26996
UPDATE `creature_template_locale` SET `Name` = 'Awan Né-de-glace',`Title` = 'Grand maître travailleur du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26996;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=26997
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26997;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=26998
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26998;
-- OLD name : Fendrig Barbe-Rouge, subname : Maître des mineurs (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=26999
UPDATE `creature_template_locale` SET `Name` = 'Fendrig Barbe-rouge',`Title` = 'Grand maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 26999;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=27000
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27000;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=27001
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27001;
-- OLD name : Festin-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27008
UPDATE `creature_template_locale` SET `Name` = 'Festin-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27008;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27023;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27029;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27034;
-- OLD subname : Fournitures d’herboriste et poisons
-- Source : https://www.wowhead.com/wotlk/fr/npc=27053
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste et poisons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27053;
-- OLD subname : Fabricante d'arcs
-- Source : https://www.wowhead.com/wotlk/fr/npc=27055
UPDATE `creature_template_locale` SET `Title` = 'Fabricant d''arcs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27055;
-- OLD name : Breka Sœur-Louve (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27065
UPDATE `creature_template_locale` SET `Name` = 'Breka Sœur-louve',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27065;
-- OLD name : Brave du camp Oneqwah (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27126
UPDATE `creature_template_locale` SET `Name` = 'Brave du Camp Oneqwah',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27126;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=27141
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27141;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=27147
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27147;
-- OLD name : [PH] New Hearthglen Scarlet Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27208;
-- OLD name : Tortionnaire LeCraft
-- Source : https://www.wowhead.com/wotlk/fr/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Tortionnaire Alphonse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27209;
-- OLD name : [PH] New Hearthglen Scarlet Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27218;
-- OLD name : Cible de tir à l’arc
-- Source : https://www.wowhead.com/wotlk/fr/npc=27222
UPDATE `creature_template_locale` SET `Name` = 'Cible de tir à l''arc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27222;
-- OLD name : Cible de tir à l’arc
-- Source : https://www.wowhead.com/wotlk/fr/npc=27223
UPDATE `creature_template_locale` SET `Name` = 'Cible de tir à l''arc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27223;
-- OLD subname : Qualité assurée (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=27231
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27231;
-- OLD name : Garde du corps dévot
-- Source : https://www.wowhead.com/wotlk/fr/npc=27247
UPDATE `creature_template_locale` SET `Name` = 'Garde du corps dévôt',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27247;
-- OLD name : Griffon de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27258
UPDATE `creature_template_locale` SET `Name` = 'Griffon de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27258;
-- OLD name : Voyante des vents Corne-Grise (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27262
UPDATE `creature_template_locale` SET `Name` = 'Voyante des vents Corne-grise',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27262;
-- OLD name : Mage de Garde-Hiver ressuscité (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27283
UPDATE `creature_template_locale` SET `Name` = 'Mage de Garde-hiver ressuscité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27283;
-- OLD name : Défenseur de Garde-Hiver ressuscité (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27284
UPDATE `creature_template_locale` SET `Name` = 'Défenseur de Garde-hiver ressuscité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27284;
-- OLD name : Mort efflanqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=27290
UPDATE `creature_template_locale` SET `Name` = 'Mort affamé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27290;
-- OLD name : Chaîne de Porte-flamme
-- Source : https://www.wowhead.com/wotlk/fr/npc=27297
UPDATE `creature_template_locale` SET `Name` = 'Chaine de Porte-flamme',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27297;
-- OLD name : Villageoise de Garde-Hiver sans défense (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27315
UPDATE `creature_template_locale` SET `Name` = 'Villageoise de Garde-hiver sans défense',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27315;
-- OLD name : Mort efflanqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=27335
UPDATE `creature_template_locale` SET `Name` = 'Mort affamé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27335;
-- OLD name : Villageois de Garde-Hiver sans défense (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27336
UPDATE `creature_template_locale` SET `Name` = 'Villageois de Garde-hiver sans défense',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27336;
-- OLD name : Adeline Chambers, subname : Eleveuse de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Éleveuse de chauve-souris Adeline',`Title` = 'Éleveuse de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27344;
-- OLD name : Essence de compétition (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27346
UPDATE `creature_template_locale` SET `Name` = 'Essence de Compétition',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27346;
-- OLD name : Orik Cœur-Vrai
-- Source : https://www.wowhead.com/wotlk/fr/npc=27347
UPDATE `creature_template_locale` SET `Name` = 'Orik Coeur-vrai',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27347;
-- OLD name : Villageois de Garde-Hiver piégé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27359
UPDATE `creature_template_locale` SET `Name` = 'Villageois de Garde-hiver piégé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27359;
-- OLD name : Forgeron de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27361
UPDATE `creature_template_locale` SET `Name` = 'Forgeron de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27361;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27368;
-- OLD name : Copiste en chef Barriga
-- Source : https://www.wowhead.com/wotlk/fr/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Copiste en chef Kinnedius',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27378;
-- OLD name : Déclencheur d'attaque de la porte intérieure de Garde-Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=27380
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27380;
-- OLD name : Thel'zan le Portebrune
-- Source : https://www.wowhead.com/wotlk/fr/npc=27384
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27384;
-- OLD name : [DND] Valiance Keep Footman Spectator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27387;
-- OLD name : Mineur de Garde-Hiver ressuscité (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27401
UPDATE `creature_template_locale` SET `Name` = 'Mineur de Garde-hiver ressuscité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27401;
-- OLD name : Déclencheur duo d'Utgarde
-- Source : https://www.wowhead.com/wotlk/fr/npc=27404
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27404;
-- OLD name : Bombe de la mine de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27435
UPDATE `creature_template_locale` SET `Name` = 'Bombe de la mine de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27435;
-- OLD name : Puits de mine supérieur de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27436
UPDATE `creature_template_locale` SET `Name` = 'Puits de mine supérieur de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27436;
-- OLD name : Puits de mine inférieur de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27437
UPDATE `creature_template_locale` SET `Name` = 'Puits de mine inférieur de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27437;
-- OLD subname : Seigneur-azur du Vol draconique bleu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27447
UPDATE `creature_template_locale` SET `Title` = 'Seigneur-azur du vol draconique bleu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27447;
-- OLD name : Chasseur ambrepin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27467
UPDATE `creature_template_locale` SET `Name` = 'Chasseur Ambrepin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27467;
-- OLD name : Cadavre de soldat d'infanterie de la marche de l'Ouest
-- Source : https://www.wowhead.com/wotlk/fr/npc=27481
UPDATE `creature_template_locale` SET `Name` = 'Cadavre de soldat d''infanterie de la marche de Ouest',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27481;
-- OLD name : Chevaucheur de griffon de Fordragon
-- Source : https://www.wowhead.com/wotlk/fr/npc=27521
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de griffons de Fordragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27521;
-- OLD name : Seigneur Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/fr/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Seigneur Devrestrasz',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27575;
-- OLD name : Garde de pierre Totem-de-Rage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27606
UPDATE `creature_template_locale` SET `Name` = 'Garde de pierre Totem-de-rage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27606;
-- OLD name : [Bunny]Arugal Rotation Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=27622
UPDATE `creature_template_locale` SET `Name` = 'Lapin de rotation d''Arugal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27622;
-- OLD name : Griffon de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27661
UPDATE `creature_template_locale` SET `Name` = 'Griffon de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27661;
-- OLD name : Chevaucheur de griffon de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27662
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de griffon de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27662;
-- OLD name : Ontok Brise-Corne (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27668
UPDATE `creature_template_locale` SET `Name` = 'Ontok Brise-corne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27668;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=27711
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27711;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27723;
-- OLD name : Friselis Sabot-Brûlé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27750
UPDATE `creature_template_locale` SET `Name` = 'Friselis Sabot-brûlé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27750;
-- OLD name : Grand chaman Sangrepatte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27762
UPDATE `creature_template_locale` SET `Name` = 'Grand chaman sangrepatte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27762;
-- OLD subname : Ambassadrice du Vol draconique noir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27765
UPDATE `creature_template_locale` SET `Title` = 'Ambassadrice du vol draconique noir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27765;
-- OLD subname : Ambassadeur du Vol draconique vert (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27785
UPDATE `creature_template_locale` SET `Title` = 'Ambassadeur du vol draconique vert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27785;
-- OLD subname : La Rêveuse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27789
UPDATE `creature_template_locale` SET `Title` = 'La rêveuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27789;
-- OLD name : Aide des caisses de céréales
-- Source : https://www.wowhead.com/wotlk/fr/npc=27827
UPDATE `creature_template_locale` SET `Name` = 'Aide des caisse de céréale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27827;
-- OLD name : Sablier de l'éternité
-- Source : https://www.wowhead.com/wotlk/fr/npc=27840
UPDATE `creature_template_locale` SET `Name` = 'Sablier de l''Éternité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27840;
-- OLD name : « Appât-à-Wyrm » (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=27843
UPDATE `creature_template_locale` SET `Name` = '« Appât-à-wyrm »',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27843;
-- OLD name : Leviers de contrôle de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=27852
UPDATE `creature_template_locale` SET `Name` = 'Leviers de contrôle de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27852;
-- OLD subname : Ambassadrice du Vol draconique bronze
-- Source : https://www.wowhead.com/wotlk/fr/npc=27856
UPDATE `creature_template_locale` SET `Title` = 'Ambassadrice du vol draconique de bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27856;
-- OLD name : [TEST] Véhicule de test de Patty (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - vehicle',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27862;
-- OLD name : Unité de détection de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=27869
UPDATE `creature_template_locale` SET `Name` = 'Unité de détection de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27869;
-- OLD name : Catapulte de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=27881
UPDATE `creature_template_locale` SET `Name` = 'Catapulte de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27881;
-- OLD name : Maître des chevaliers de la mort universel (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=27916
UPDATE `creature_template_locale` SET `Name` = 'World Death Knight Trainer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27916;
-- OLD name : [PH] Warp Stalker Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 27976;
-- OLD name : Lieutenant Martel-de-glace
-- Source : https://www.wowhead.com/wotlk/fr/npc=27994
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 27994;
-- OLD name : Mardan Sabot-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28040
UPDATE `creature_template_locale` SET `Name` = 'Mardan Sabot-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28040;
-- OLD name : Membre d'équipage de l'effroi
-- Source : https://www.wowhead.com/wotlk/fr/npc=28052
UPDATE `creature_template_locale` SET `Name` = 'Equipage de l''effroi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28052;
-- OLD name : Griffon de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28061
UPDATE `creature_template_locale` SET `Name` = 'Griffon de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28061;
-- OLD name : Chevaucheur de griffon de Garde-Hiver (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28065
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de griffon de Garde-hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28065;
-- OLD name : Brasseur sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28067
UPDATE `creature_template_locale` SET `Name` = 'Brasseur Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28067;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28070
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28070;
-- OLD name : Démolisseur de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=28094
UPDATE `creature_template_locale` SET `Name` = 'Démolisseur de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28094;
-- OLD name : [PH] Baril explosif
-- Source : https://www.wowhead.com/wotlk/fr/npc=28173
UPDATE `creature_template_locale` SET `Name` = 'Baril explosif',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28173;
-- OLD name : [DND] under water construction crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28184;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28206;
-- OLD name : Bythius le Sculpte-Chair (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28212
UPDATE `creature_template_locale` SET `Name` = 'Bythius le Sculpte-chair',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28212;
-- OLD name : Goule brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28218
UPDATE `creature_template_locale` SET `Name` = 'Goule Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28218;
-- OLD name : Griz Canebide
-- Source : https://www.wowhead.com/wotlk/fr/npc=28225
UPDATE `creature_template_locale` SET `Name` = 'Griz Cannebide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28225;
-- OLD name : Rayon des Arcanes (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28239
UPDATE `creature_template_locale` SET `Name` = 'Rayon des arcanes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28239;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28292;
-- OLD name : Engin de siège de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=28312
UPDATE `creature_template_locale` SET `Name` = 'Engin de siège de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28312;
-- OLD name : Tourelle de siège de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=28319
UPDATE `creature_template_locale` SET `Name` = 'Tourelle de siège de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28319;
-- OLD name : Terre luisante
-- Source : https://www.wowhead.com/wotlk/fr/npc=28362
UPDATE `creature_template_locale` SET `Name` = 'Poussière luisante',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28362;
-- OLD name : Grand ours de bataille
-- Source : https://www.wowhead.com/wotlk/fr/npc=28363
UPDATE `creature_template_locale` SET `Name` = 'Gros ours de combat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28363;
-- OLD name : Tour-canon de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=28366
UPDATE `creature_template_locale` SET `Name` = 'Tour-canon de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28366;
-- OLD name : Drak'Tharon - Drakuru Event Invisman 00
-- Source : https://www.wowhead.com/wotlk/fr/npc=28492
UPDATE `creature_template_locale` SET `Name` = 'Drak''Tharon - Drakuru Event Invisman 01',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28492;
-- OLD name : Oeil d'Achérus
-- Source : https://www.wowhead.com/wotlk/fr/npc=28511
UPDATE `creature_template_locale` SET `Name` = 'Œil d''Achérus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28511;
-- OLD name : Rejeton de Har'koa délivré
-- Source : https://www.wowhead.com/wotlk/fr/npc=28526
UPDATE `creature_template_locale` SET `Name` = 'Rejeton de Har''koa relâché',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28526;
-- OLD name : Datura Rose-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28532
UPDATE `creature_template_locale` SET `Name` = 'Datura Rose-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28532;
-- OLD name : Vortex tempétueux
-- Source : https://www.wowhead.com/wotlk/fr/npc=28547
UPDATE `creature_template_locale` SET `Name` = 'Vortex orageux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28547;
-- OLD name : Tortionnaire LeCraft
-- Source : https://www.wowhead.com/wotlk/fr/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Tortionnaire Alphonse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28554;
-- OLD name : Maçonne Plaquéor
-- Source : https://www.wowhead.com/wotlk/fr/npc=28572
UPDATE `creature_template_locale` SET `Name` = 'Maçon Plaquéor',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28572;
-- OLD name : Plaie-en-Vol (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28615
UPDATE `creature_template_locale` SET `Name` = 'Plaie-en-vol',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28615;
-- OLD name : Gitan mystérieux (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=28652
UPDATE `creature_template_locale` SET `Name` = 'Marchand mystérieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28652;
-- OLD name : Artruis le Sans-Cœur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28659
UPDATE `creature_template_locale` SET `Name` = 'Artruis le Sans-cœur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28659;
-- OLD name : Aludane Nuage-Blanc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28674
UPDATE `creature_template_locale` SET `Name` = 'Aludane Nuage-blanc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28674;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28693;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28694;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=28696
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28696;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=28697
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28697;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28698;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28699;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=28700
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28700;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28701;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28702;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28703;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28704;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28705;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28706;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=28714
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28714;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=28722
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28722;
-- OLD name : Patricia Egan
-- Source : https://www.wowhead.com/wotlk/fr/npc=28725
UPDATE `creature_template_locale` SET `Name` = 'Patrica Egan',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28725;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=28727
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28727;
-- OLD name : Blight Cauldron Bunny 00
-- Source : https://www.wowhead.com/wotlk/fr/npc=28739
UPDATE `creature_template_locale` SET `Name` = 'Blight Cauldron Bunny 01',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28739;
-- OLD subname : Maître des pêcheurs & fournitures
-- Source : https://www.wowhead.com/wotlk/fr/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Grand maître des pêcheurs & fournitures',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28742;
-- OLD subname : Instructeur de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Maître de vol par temps froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28746;
-- OLD name : Hargus le Bancal
-- Source : https://www.wowhead.com/wotlk/fr/npc=28760
UPDATE `creature_template_locale` SET `Name` = 'Hargus le Geist',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28760;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 28767;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=28797
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28797;
-- OLD name : Aidan Oeil-d’Acier, subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=28800
UPDATE `creature_template_locale` SET `Name` = 'Aidan Oeil-d''acier',`Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28800;
-- OLD name : Brady Pot-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=28811
UPDATE `creature_template_locale` SET `Name` = 'Brady Pot-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28811;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28813;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=28828
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28828;
-- OLD name : Gardien du guet d’’Ebène
-- Source : https://www.wowhead.com/wotlk/fr/npc=28865
UPDATE `creature_template_locale` SET `Name` = 'Gardien du guet d''Ébène',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28865;
-- OLD subname : Fournitures d’herboriste
-- Source : https://www.wowhead.com/wotlk/fr/npc=28868
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''herboriste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28868;
-- OLD name : Seigneur écarlate Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/fr/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Seigneur écarlate Borugh',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 28964;
-- OLD name : [DND] Dockhand w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 29020;
-- OLD name : [INUTILISÉ] [PH] Stormwind Gryphon (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUSE',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29039;
-- OLD subname : Vendeur de composants
-- Source : https://www.wowhead.com/wotlk/fr/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Vendeur de poussière de cadavre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29203;
-- OLD name : Manœuvre ressuscité
-- Source : https://www.wowhead.com/wotlk/fr/npc=29212
UPDATE `creature_template_locale` SET `Name` = 'Manoeuvre ressuscité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29212;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29233;
-- OLD name : Chevaucheur de griffon de l'Assaut
-- Source : https://www.wowhead.com/wotlk/fr/npc=29333
UPDATE `creature_template_locale` SET `Name` = 'Chevaucheur de griffons de l''Assaut',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29333;
-- OLD subname : Fournitures d'alchimie & poisons (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=29348
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''alchimie et poisons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29348;
-- OLD name : [PH]TEST Skater (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 29361;
-- OLD name : Adorateur brûleglace
-- Source : https://www.wowhead.com/wotlk/fr/npc=29407
UPDATE `creature_template_locale` SET `Name` = 'Fidèle Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29407;
-- OLD name : Terrassier brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29413
UPDATE `creature_template_locale` SET `Name` = 'Terrassier Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29413;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Munitions spécialisées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29493;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Maître de la fabrication d''armes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29505;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Maître des fabricants d''armure',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29506;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir élémentaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29507;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir d''écailles de dragon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29508;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Maître des travailleurs du cuir tribal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29509;
-- OLD name : Ainderu Feuille-d’Eté
-- Source : https://www.wowhead.com/wotlk/fr/npc=29512
UPDATE `creature_template_locale` SET `Name` = 'Ainderu Feuille-d''été',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29512;
-- OLD name : Bragund Maillon-Brillant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29523
UPDATE `creature_template_locale` SET `Name` = 'Bragund Maillon-brillant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29523;
-- OLD name : Fidèle brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29554
UPDATE `creature_template_locale` SET `Name` = 'Fidèle Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29554;
-- OLD name : Ame de Langrain
-- Source : https://www.wowhead.com/wotlk/fr/npc=29572
UPDATE `creature_template_locale` SET `Name` = 'Âme de Langrain',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29572;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29579
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29579;
-- OLD name : Yorg Foudrecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=29593
UPDATE `creature_template_locale` SET `Name` = 'Yorg Foudrecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29593;
-- OLD name : Suivant brûleglace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29618
UPDATE `creature_template_locale` SET `Name` = 'Suivant Brûleglace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29618;
-- OLD subname : Matériel de secourisme
-- Source : https://www.wowhead.com/wotlk/fr/npc=29628
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de secourisme',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29628;
-- OLD name : Vipère de la fosse à crochets
-- Source : https://www.wowhead.com/wotlk/fr/npc=29630
UPDATE `creature_template_locale` SET `Name` = 'Crotale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29630;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29631;
-- OLD name : Nigo Sabot-Plat (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29642
UPDATE `creature_template_locale` SET `Name` = 'Nigo Sabot-plat',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29642;
-- OLD subname : Mascotte de Jepetto
-- Source : https://www.wowhead.com/wotlk/fr/npc=29716
UPDATE `creature_template_locale` SET `Title` = 'Compagnon de Jepetto',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29716;
-- OLD name : Nœud de serpents
-- Source : https://www.wowhead.com/wotlk/fr/npc=29742
UPDATE `creature_template_locale` SET `Name` = 'Noeud de serpents',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29742;
-- OLD name : Veranus (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=29756
UPDATE `creature_template_locale` SET `Name` = 'Veranas',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29756;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 29812;
-- OLD name : Algar l’Elu
-- Source : https://www.wowhead.com/wotlk/fr/npc=29872
UPDATE `creature_template_locale` SET `Name` = 'Algar l''Élu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29872;
-- OLD name : Guerrier de Jotunheim
-- Source : https://www.wowhead.com/wotlk/fr/npc=29880
UPDATE `creature_template_locale` SET `Name` = 'Guerrier jotunheim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29880;
-- OLD subname : Fournitures d'ingénieur & de forgeron
-- Source : https://www.wowhead.com/wotlk/fr/npc=29907
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénierie & de forgeron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29907;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29924;
-- OLD name : Moteha Né-du-Vent (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29937
UPDATE `creature_template_locale` SET `Name` = 'Moteha Né-du-vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29937;
-- OLD name : Breck Front-de-Roc (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29950
UPDATE `creature_template_locale` SET `Name` = 'Breck Front-de-roc',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29950;
-- OLD name : Shavalius l’Elégant
-- Source : https://www.wowhead.com/wotlk/fr/npc=29951
UPDATE `creature_template_locale` SET `Name` = 'Shavalius l''Élégant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29951;
-- OLD name : Andurg Coffre-d’Ardoise
-- Source : https://www.wowhead.com/wotlk/fr/npc=29959
UPDATE `creature_template_locale` SET `Name` = 'Andurg Coffre-d''ardoise',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29959;
-- OLD name : Udoho Cours-la-Glace (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29967
UPDATE `creature_template_locale` SET `Name` = 'Udoho Cours-la-glace',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29967;
-- OLD name : Hapanu Vent-Froid (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29968
UPDATE `creature_template_locale` SET `Name` = 'Hapanu Vent-froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29968;
-- OLD name : Danho Nuage-Lointain (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29970
UPDATE `creature_template_locale` SET `Name` = 'Danho Nuage-lointain',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29970;
-- OLD name : Wabada Blanche-Fleur (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=29971
UPDATE `creature_template_locale` SET `Name` = 'Wabada Blanche-fleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29971;
-- OLD name : Croc acéré
-- Source : https://www.wowhead.com/wotlk/fr/npc=29994
UPDATE `creature_template_locale` SET `Name` = 'Croc-acéré',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 29994;
-- OLD name : Vaelen l’Ecorché
-- Source : https://www.wowhead.com/wotlk/fr/npc=30056
UPDATE `creature_template_locale` SET `Name` = 'Vaelen l''Écorché',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30056;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30078;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30107
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30107;
-- OLD name : Adorateur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30111
UPDATE `creature_template_locale` SET `Name` = 'Adorateur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30111;
-- OLD name : Initié du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30114
UPDATE `creature_template_locale` SET `Name` = 'Initié du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30114;
-- OLD name : Archimage Aethas Saccage-Soleil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30116
UPDATE `creature_template_locale` SET `Name` = 'Archimage Aethas Saccage-soleil',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30116;
-- OLD name : Bruor Plaie-du-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30152
UPDATE `creature_template_locale` SET `Name` = 'Bruor Plaie-du-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30152;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30156;
-- OLD name : Apôtre du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30179
UPDATE `creature_template_locale` SET `Name` = 'Apôtre du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30179;
-- OLD name : Yorg Foudrecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=30182
UPDATE `creature_template_locale` SET `Name` = 'Yorg Foudrecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30182;
-- OLD name : Serpent crépusculaire profond
-- Source : https://www.wowhead.com/wotlk/fr/npc=30191
UPDATE `creature_template_locale` SET `Name` = 'Serpent du crépuscule profond',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30191;
-- OLD name : Embusqué des profondeurs oubliées
-- Source : https://www.wowhead.com/wotlk/fr/npc=30204
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeur des profondeurs oubliées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30204;
-- OLD name : Forge du tonnerre du nord
-- Source : https://www.wowhead.com/wotlk/fr/npc=30209
UPDATE `creature_template_locale` SET `Name` = 'Forge de foudre du nord',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30209;
-- OLD name : Forge du tonnerre centrale
-- Source : https://www.wowhead.com/wotlk/fr/npc=30211
UPDATE `creature_template_locale` SET `Name` = 'Forge de foudre centrale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30211;
-- OLD name : Forge du tonnerre du sud
-- Source : https://www.wowhead.com/wotlk/fr/npc=30212
UPDATE `creature_template_locale` SET `Name` = 'Forge de foudre du sud',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30212;
-- OLD name : Vaelen l’Ecorché
-- Source : https://www.wowhead.com/wotlk/fr/npc=30218
UPDATE `creature_template_locale` SET `Name` = 'Vaelen l''Écorché',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30218;
-- OLD name : Alanura Nuage-de-Feu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30239
UPDATE `creature_template_locale` SET `Name` = 'Alanura Nuage-de-feu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30239;
-- OLD name : Sœur-de-lance njorndar
-- Source : https://www.wowhead.com/wotlk/fr/npc=30243
UPDATE `creature_template_locale` SET `Name` = 'Sœur-de-lance de Njorndar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30243;
-- OLD name : Scion de l’Eternité
-- Source : https://www.wowhead.com/wotlk/fr/npc=30249
UPDATE `creature_template_locale` SET `Name` = 'Scion de l''Éternité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30249;
-- OLD name : Proto-drake njorndar
-- Source : https://www.wowhead.com/wotlk/fr/npc=30272
UPDATE `creature_template_locale` SET `Name` = 'Proto-drake de Njorndar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30272;
-- OLD name : Coup-de-Bile (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30306
UPDATE `creature_template_locale` SET `Name` = 'Coup-de-bile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30306;
-- OLD name : Invocateur noir du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30319
UPDATE `creature_template_locale` SET `Name` = 'Invocateur noir du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30319;
-- OLD name : Pourfendeur des profondeurs oubliées
-- Source : https://www.wowhead.com/wotlk/fr/npc=30333
UPDATE `creature_template_locale` SET `Name` = 'Tueur des profondeurs oubliées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30333;
-- OLD name : Harpon à tir rapide de Jotunheim
-- Source : https://www.wowhead.com/wotlk/fr/npc=30337
UPDATE `creature_template_locale` SET `Name` = 'Harpon à tir rapide jotunheim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30337;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/fr/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorcuttar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30340;
-- OLD name : Ancien Loup-bleu (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=30368
UPDATE `creature_template_locale` SET `Name` = 'Ancien Loup-Bleu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30368;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30382
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30382;
-- OLD name : Volontaire du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30385
UPDATE `creature_template_locale` SET `Name` = 'Volontaire du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30385;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30405
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30405;
-- OLD name : Yorg Foudrecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=30408
UPDATE `creature_template_locale` SET `Name` = 'Yorg Foudrecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30408;
-- OLD subname : Reine banshee (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=30426
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30426;
-- OLD subname : Reine banshee (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=30427
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30427;
-- OLD subname : Reine banshee (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=30428
UPDATE `creature_template_locale` SET `Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30428;
-- OLD name : Factionnaire worg
-- Source : https://www.wowhead.com/wotlk/fr/npc=30430
UPDATE `creature_template_locale` SET `Name` = 'Sentinelle worg',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30430;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=30434
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénierie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30434;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30437;
-- OLD name : Vents gémissants
-- Source : https://www.wowhead.com/wotlk/fr/npc=30450
UPDATE `creature_template_locale` SET `Name` = 'Les Vents gémissants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30450;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30476;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/fr/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30559;
-- OLD name : Proto-drake njorndar
-- Source : https://www.wowhead.com/wotlk/fr/npc=30564
UPDATE `creature_template_locale` SET `Name` = 'Proto-drake de Njorndar',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30564;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/fr/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30572;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30589;
-- OLD name : Pourfendeur des profondeurs oubliées
-- Source : https://www.wowhead.com/wotlk/fr/npc=30593
UPDATE `creature_template_locale` SET `Name` = 'Tueur des profondeurs oubliées',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30593;
-- OLD subname : Maître de guerre d'arène
-- Source : https://www.wowhead.com/wotlk/fr/npc=30610
UPDATE `creature_template_locale` SET `Title` = 'Maître de guerre de l''arène',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30610;
-- OLD name : Greela « la Grunt » Remontechaîne, subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/fr/npc=30611
UPDATE `creature_template_locale` SET `Name` = 'Greela « la Grunt » Remontechaine',`Title` = 'Organisatrice de combats',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30611;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30640;
-- OLD name : Fissure du Crépuscule
-- Source : https://www.wowhead.com/wotlk/fr/npc=30641
UPDATE `creature_template_locale` SET `Name` = 'Fissure crépusculaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30641;
-- OLD name : Strength of Earth Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=30647
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30647;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30651;
-- OLD name : Totem of Wrath IV
-- Source : https://www.wowhead.com/wotlk/fr/npc=30654
UPDATE `creature_template_locale` SET `Name` = 'Totem de courroux IV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30654;
-- OLD name : Ensorceleur azur
-- Source : https://www.wowhead.com/wotlk/fr/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Ensorceleuse azur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30667;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30690
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30690;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30707;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30721;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30722;
-- OLD name : Gardien du sommeil de Jotunheim
-- Source : https://www.wowhead.com/wotlk/fr/npc=30725
UPDATE `creature_template_locale` SET `Name` = 'Gardien du sommeil jotunheim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30725;
-- OLD name : Ame délivrée
-- Source : https://www.wowhead.com/wotlk/fr/npc=30736
UPDATE `creature_template_locale` SET `Name` = 'Ame libérée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30736;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30749;
-- OLD name : Membre d'équipage du Marteau d'Orgrim
-- Source : https://www.wowhead.com/wotlk/fr/npc=30754
UPDATE `creature_template_locale` SET `Name` = 'Equipage du Marteau d''Orgrim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30754;
-- OLD name : Saccageur kor’’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=30755
UPDATE `creature_template_locale` SET `Name` = 'Saccageur kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30755;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 30832;
-- OLD name : Brazik Griffe-de-Feu, subname : Armures d’arène historiques (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=30885
UPDATE `creature_template_locale` SET `Name` = 'Brazik Griffe-de-feu',`Title` = 'Vendeur d''eau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=30888
UPDATE `creature_template_locale` SET `Name` = 'Andrew Test Dummy 80 Hostile Low Damage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30888;
-- OLD name : Dragonnet du Crépuscule
-- Source : https://www.wowhead.com/wotlk/fr/npc=30890
UPDATE `creature_template_locale` SET `Name` = 'Drakonnet crépusculaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30890;
-- OLD name : Brute ombreuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=30922
UPDATE `creature_template_locale` SET `Name` = 'Brute umbrale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30922;
-- OLD name : Chien pestiféré efflanqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=30952
UPDATE `creature_template_locale` SET `Name` = 'Chien pestiféré affamé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30952;
-- OLD name : Manœuvre du Fléau
-- Source : https://www.wowhead.com/wotlk/fr/npc=30984
UPDATE `creature_template_locale` SET `Name` = 'Manoeuvre du Fléau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 30984;
-- OLD name : PNJ test Russel Bernau (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31060;
-- OLD name : [Bunny]Ahn'kahet Brazier KC Bunny
-- Source : https://www.wowhead.com/wotlk/fr/npc=31105
UPDATE `creature_template_locale` SET `Name` = 'Lapin KC de Brazier Ahn''kahet',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31105;
-- OLD name : Stoneclaw Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31120
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31120;
-- OLD name : Stoneclaw Totem IX
-- Source : https://www.wowhead.com/wotlk/fr/npc=31121
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre IX',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31121;
-- OLD name : Stoneclaw Totem X
-- Source : https://www.wowhead.com/wotlk/fr/npc=31122
UPDATE `creature_template_locale` SET `Name` = 'Totem de griffes de pierre X',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31122;
-- OLD name : Strength of Earth Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31129
UPDATE `creature_template_locale` SET `Name` = 'Totem de force de la Terre VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31129;
-- OLD name : Flametongue Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31132
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31132;
-- OLD name : Flametongue Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31133
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31133;
-- OLD name : Mannequin d'entraînement
-- Source : https://www.wowhead.com/wotlk/fr/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement de grand maître',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31144;
-- OLD name : Mannequin d'entraînement d'écumeur de raids
-- Source : https://www.wowhead.com/wotlk/fr/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement héroïque',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31146;
-- OLD name : Flametongue Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31158
UPDATE `creature_template_locale` SET `Name` = 'Totem Langue de feu VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31158;
-- OLD name : Searing Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31162
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31162;
-- OLD name : Searing Totem IX
-- Source : https://www.wowhead.com/wotlk/fr/npc=31164
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire IX',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31164;
-- OLD name : Searing Totem X
-- Source : https://www.wowhead.com/wotlk/fr/npc=31165
UPDATE `creature_template_locale` SET `Name` = 'Totem incendiaire X',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31165;
-- OLD name : Magma Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31166
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31166;
-- OLD name : Magma Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31167
UPDATE `creature_template_locale` SET `Name` = 'Totem de magma VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31167;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31168;
-- OLD name : Fire Resistance Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=31169
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31169;
-- OLD name : Fire Resistance Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31170
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Feu VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31170;
-- OLD name : Frost Resistance Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=31171
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Givre V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31171;
-- OLD name : Frost Resistance Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31172
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance au Givre VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31172;
-- OLD name : Nature Resistance Totem V
-- Source : https://www.wowhead.com/wotlk/fr/npc=31173
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance à la Nature V',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31173;
-- OLD name : Nature Resistance Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31174
UPDATE `creature_template_locale` SET `Name` = 'Totem de résistance à la Nature VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31174;
-- OLD name : Stoneskin Totem IX
-- Source : https://www.wowhead.com/wotlk/fr/npc=31175
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre IX',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31175;
-- OLD name : Stoneskin Totem X
-- Source : https://www.wowhead.com/wotlk/fr/npc=31176
UPDATE `creature_template_locale` SET `Name` = 'Totem de peau de pierre X',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31176;
-- OLD name : Healing Stream Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31181
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31181;
-- OLD name : Healing Stream Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31182
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31182;
-- OLD name : Healing Stream Totem IX
-- Source : https://www.wowhead.com/wotlk/fr/npc=31185
UPDATE `creature_template_locale` SET `Name` = 'Totem guérisseur IX',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31185;
-- OLD name : Mana Spring Totem VI
-- Source : https://www.wowhead.com/wotlk/fr/npc=31186
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana VI',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31186;
-- OLD name : Mana Spring Totem VII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31189
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana VII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31189;
-- OLD name : Mana Spring Totem VIII
-- Source : https://www.wowhead.com/wotlk/fr/npc=31190
UPDATE `creature_template_locale` SET `Name` = 'Totem Fontaine de mana VIII',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31190;
-- OLD name : Scinde-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=31221
UPDATE `creature_template_locale` SET `Name` = 'Scinde-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31221;
-- OLD name : Scinde-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=31223
UPDATE `creature_template_locale` SET `Name` = 'Scinde-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31223;
-- OLD subname : Instructrice de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=31238
UPDATE `creature_template_locale` SET `Title` = 'Maître de vol par temps froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31238;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 31246;
-- OLD subname : Instructrice de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Maître de vol par temps froid',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31247;
-- OLD name : Fantassin de Lordaeron
-- Source : https://www.wowhead.com/wotlk/fr/npc=31254
UPDATE `creature_template_locale` SET `Name` = 'Soldat de pied de Lordaeron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31254;
-- OLD name : Brute ombreuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=31320
UPDATE `creature_template_locale` SET `Name` = 'Brute umbrale',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31320;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 31353;
-- OLD name : Soldat d’élite kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=31417
UPDATE `creature_template_locale` SET `Name` = 'Kor''kron d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31417;
-- OLD subname : Marchande d'armes à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=31423
UPDATE `creature_template_locale` SET `Title` = 'Armes à feu & munitions',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31423;
-- OLD name : Chien pestiféré efflanqué
-- Source : https://www.wowhead.com/wotlk/fr/npc=31556
UPDATE `creature_template_locale` SET `Name` = 'Chien pestiféré affamé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31556;
-- OLD subname : Emblème d'honneur quartier-maître
-- Source : https://www.wowhead.com/wotlk/fr/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de vaillance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31579;
-- OLD subname : Emblème de l'héroïsme quartier-maître
-- Source : https://www.wowhead.com/wotlk/fr/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes d''héroïsme',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31580;
-- OLD subname : Emblème d'honneur quartier-maître
-- Source : https://www.wowhead.com/wotlk/fr/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de vaillance',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31581;
-- OLD subname : Emblème de l'héroïsme quartier-maître
-- Source : https://www.wowhead.com/wotlk/fr/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes d''héroïsme',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31582;
-- OLD name : Image de Gal’darah
-- Source : https://www.wowhead.com/wotlk/fr/npc=31622
UPDATE `creature_template_locale` SET `Name` = 'Image de Gal''darah',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31622;
-- OLD name : Rôdeur sans-visage
-- Source : https://www.wowhead.com/wotlk/fr/npc=31691
UPDATE `creature_template_locale` SET `Name` = 'Rôdeur sans visage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31691;
-- OLD name : Drake du Crépuscule
-- Source : https://www.wowhead.com/wotlk/fr/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Drake crépusculaire',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31698;
-- OLD name : Drake bronze
-- Source : https://www.wowhead.com/wotlk/fr/npc=31717
UPDATE `creature_template_locale` SET `Name` = 'Drake de bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31717;
-- OLD name : Réanimateur de wyrm
-- Source : https://www.wowhead.com/wotlk/fr/npc=31731
UPDATE `creature_template_locale` SET `Name` = 'Réanimateur de wyrms',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31731;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=31776
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31776;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=31781
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31781;
-- OLD name : Second Fitzgerald
-- Source : https://www.wowhead.com/wotlk/fr/npc=31789
UPDATE `creature_template_locale` SET `Name` = 'Second Edgar Fitzgerald',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31789;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=31810
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31810;
-- OLD name : Répandeur de chancre
-- Source : https://www.wowhead.com/wotlk/fr/npc=31831
UPDATE `creature_template_locale` SET `Name` = 'Épandeur de chancre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31831;
-- OLD name : Infiltrateur kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=31882
UPDATE `creature_template_locale` SET `Name` = 'Infiltrateur kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 31882;
-- OLD name : Zélote élu
-- Source : https://www.wowhead.com/wotlk/fr/npc=32175
UPDATE `creature_template_locale` SET `Name` = 'Zélote choisi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32175;
-- OLD name : Fantassin squelettique
-- Source : https://www.wowhead.com/wotlk/fr/npc=32183
UPDATE `creature_template_locale` SET `Name` = 'Soldat de pied squelettique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32183;
-- OLD name : Rune fantôme de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=32282
UPDATE `creature_template_locale` SET `Name` = 'Rune fantôme de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32282;
-- OLD name : Sablier de l'éternité
-- Source : https://www.wowhead.com/wotlk/fr/npc=32327
UPDATE `creature_template_locale` SET `Name` = 'Sablier de l''Éternité',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32327;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32328;
-- OLD name : Coursier du vent bleu cuirassé
-- Source : https://www.wowhead.com/wotlk/fr/npc=32336
UPDATE `creature_template_locale` SET `Name` = 'Coursier du vent bleu caparaçonné',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32336;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32339;
-- OLD name : Vieil Ecorce-de-Cristal
-- Source : https://www.wowhead.com/wotlk/fr/npc=32357
UPDATE `creature_template_locale` SET `Name` = 'Vieil Écorce-de-cristal',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32357;
-- OLD name : Soldat d’élite kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=32367
UPDATE `creature_template_locale` SET `Name` = 'Kor''kron d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32367;
-- OLD name : Sergent Corne-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=32383
UPDATE `creature_template_locale` SET `Name` = 'Sergent Corne-tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32383;
-- OLD subname : Maître des pêcheurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des pêcheurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32474;
-- OLD name : Hildana Voleuse-de-Mort (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=32495
UPDATE `creature_template_locale` SET `Name` = 'Hildana Voleuse-de-mort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32495;
-- OLD name : Proto-drake bleu (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=32585
UPDATE `creature_template_locale` SET `Name` = 'Proto-drake de monte bleu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32585;
-- OLD name : Proto-drake bronze (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=32586
UPDATE `creature_template_locale` SET `Name` = 'Proto-drake de monte bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32586;
-- OLD name : [DND] Cosmetic Book (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32606;
-- OLD name : Engin de siège de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=32627
UPDATE `creature_template_locale` SET `Name` = 'Engin de siège de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32627;
-- OLD name : Tourelle de siège de Joug-d’Hiver
-- Source : https://www.wowhead.com/wotlk/fr/npc=32629
UPDATE `creature_template_locale` SET `Name` = 'Tourelle de siège de Joug-d''hiver',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32629;
-- OLD name : Capitaine Nadeux « la Moisie » de l'effroi
-- Source : https://www.wowhead.com/wotlk/fr/npc=32660
UPDATE `creature_template_locale` SET `Name` = 'Capitaine Nadeux « le Moisi » de l''effroi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32660;
-- OLD name : Mannequin d'entraînement
-- Source : https://www.wowhead.com/wotlk/fr/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement d''expert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32666;
-- OLD name : Mannequin d'entraînement
-- Source : https://www.wowhead.com/wotlk/fr/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Mannequin d''entraînement de maître',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32667;
-- OLD name : Grindle Etincefeu
-- Source : https://www.wowhead.com/wotlk/fr/npc=32676
UPDATE `creature_template_locale` SET `Name` = 'Grindle Étincefeu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32676;
-- OLD name : Artificius Torciboulot
-- Source : https://www.wowhead.com/wotlk/fr/npc=32686
UPDATE `creature_template_locale` SET `Name` = 'Tomas Riogain',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32686;
-- OLD name : Hunaka Sabot-Vert (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=32709
UPDATE `creature_template_locale` SET `Name` = 'Hunaka Sabot-vert',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32709;
-- OLD name : Illusionniste Karina
-- Source : https://www.wowhead.com/wotlk/fr/npc=32728
UPDATE `creature_template_locale` SET `Name` = 'Illusioniste Karina',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32728;
-- OLD name : Adjuratrice Weinhaus
-- Source : https://www.wowhead.com/wotlk/fr/npc=32741
UPDATE `creature_template_locale` SET `Name` = 'Adjurateur Weinhaus',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32741;
-- OLD subname : Glyphes de chevalier de la mort
-- Source : https://www.wowhead.com/wotlk/fr/npc=32753
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de chevalier de la mort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32753;
-- OLD subname : Glyphes de druide
-- Source : https://www.wowhead.com/wotlk/fr/npc=32754
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de druide',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32754;
-- OLD subname : Glyphes de chasseur
-- Source : https://www.wowhead.com/wotlk/fr/npc=32755
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de chasseur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32755;
-- OLD subname : Glyphes de mage
-- Source : https://www.wowhead.com/wotlk/fr/npc=32756
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de mage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32756;
-- OLD subname : Glyphes de paladin
-- Source : https://www.wowhead.com/wotlk/fr/npc=32757
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de paladin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32757;
-- OLD subname : Glyphe de prêtre
-- Source : https://www.wowhead.com/wotlk/fr/npc=32758
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de prêtre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32758;
-- OLD subname : Glyphes de voleur
-- Source : https://www.wowhead.com/wotlk/fr/npc=32759
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de voleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32759;
-- OLD subname : Glyphes de chaman
-- Source : https://www.wowhead.com/wotlk/fr/npc=32760
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de chaman',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32760;
-- OLD subname : Glyphes de démoniste
-- Source : https://www.wowhead.com/wotlk/fr/npc=32761
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de démoniste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32761;
-- OLD subname : Glyphes de guerrier
-- Source : https://www.wowhead.com/wotlk/fr/npc=32762
UPDATE `creature_template_locale` SET `Title` = 'Fournitures de guerrier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32762;
-- OLD name : Fantassin squelettique
-- Source : https://www.wowhead.com/wotlk/fr/npc=32772
UPDATE `creature_template_locale` SET `Name` = 'Soldat de pied squelettique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32772;
-- OLD name : Totem Nova de feu IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=32775
UPDATE `creature_template_locale` SET `Name` = NULL,`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32775;
-- OLD name : Totem Nova de feu VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=32776
UPDATE `creature_template_locale` SET `Name` = NULL,`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32776;
-- OLD name : Visuel d'entoilage
-- Source : https://www.wowhead.com/wotlk/fr/npc=32785
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32785;
-- OLD name : [PH] Pilgrim's Bounty Table - Turkey (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32824;
-- OLD name : [PH] Pilgrim's Bounty Table - Yams (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32825;
-- OLD name : [PH] Pilgrim's Bounty Table - Cranberry Sauce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32827;
-- OLD name : [PH] Pilgrim's Bounty Table - Pie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32829;
-- OLD name : [PH] Pilgrim's Bounty Table - Stuffing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 32831;
-- OLD name : Effondrement d'étoile
-- Source : https://www.wowhead.com/wotlk/fr/npc=32955
UPDATE `creature_template_locale` SET `Name` = 'Étoile s''effondrant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 32955;
-- OLD name : Epave de démolisseur
-- Source : https://www.wowhead.com/wotlk/fr/npc=33059
UPDATE `creature_template_locale` SET `Name` = 'Épave de démolisseur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33059;
-- OLD name : Epave d'engin de siège
-- Source : https://www.wowhead.com/wotlk/fr/npc=33063
UPDATE `creature_template_locale` SET `Name` = 'Épave d''engin de siège',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33063;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33235
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33235;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33252;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33305;
-- OLD name : Gérome le gnome (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=33314
UPDATE `creature_template_locale` SET `Name` = 'Gérome le Gnome',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33314;
-- OLD name : Kodo des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=33322
UPDATE `creature_template_locale` SET `Name` = 'Kodo des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33322;
-- OLD name : Cœur du déconstructeur
-- Source : https://www.wowhead.com/wotlk/fr/npc=33329
UPDATE `creature_template_locale` SET `Name` = 'Coeur du déconstructeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33329;
-- OLD name : Ambrose Etinceboulon
-- Source : https://www.wowhead.com/wotlk/fr/npc=33335
UPDATE `creature_template_locale` SET `Name` = 'Ambrose Étinceboulon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33335;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33341;
-- OLD name : Vaillant des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=33383
UPDATE `creature_template_locale` SET `Name` = 'Vaillant des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33383;
-- OLD subname : Grand champion des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=33403
UPDATE `creature_template_locale` SET `Title` = 'Grand champion des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33403;
-- OLD name : Faucon-pérégrin de Lune-d'argent (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=33418
UPDATE `creature_template_locale` SET `Name` = 'Faucon-pérégrin de Lune-d’Argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33418;
-- OLD name : [PH] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33450;
-- OLD name : Aspirant de Lune-d'argent (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=33466
UPDATE `creature_template_locale` SET `Name` = 'Aspirant de Lune-d’Argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33466;
-- OLD name : Vaillant des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=33473
UPDATE `creature_template_locale` SET `Name` = 'Vaillant des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33473;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 33493;
-- OLD subname : La Lieuse-de-vie (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=33536
UPDATE `creature_template_locale` SET `Title` = 'La Lieuse-de-Vie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33536;
-- OLD name : Anka Sabot-Griffu (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33549
UPDATE `creature_template_locale` SET `Name` = 'Anka Sabot-griffu',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33549;
-- OLD name : Doru Corne-Tonnerre, subname : Intendant des Pitons-du-Tonnerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33556
UPDATE `creature_template_locale` SET `Name` = 'Doru Corne-tonnerre',`Title` = 'Intendant des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33556;
-- OLD name : Zélote ligemort (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33567
UPDATE `creature_template_locale` SET `Name` = 'Zélote Ligemort',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33567;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33579
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33579;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33580;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33581;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33583;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33586;
-- OLD subname : Maître des cuisiniers
-- Source : https://www.wowhead.com/wotlk/fr/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des cuisiniers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33587;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33588
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33588;
-- OLD subname : Maître des secouristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des secouristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33589;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33590;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33591;
-- OLD subname : Fournitures d’ingénieur
-- Source : https://www.wowhead.com/wotlk/fr/npc=33594
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''ingénieur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33594;
-- OLD name : Mera Cours-la-Brume (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33595
UPDATE `creature_template_locale` SET `Name` = 'Mera Cours-la-brume',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33595;
-- OLD subname : Fournitures d’enchanteur
-- Source : https://www.wowhead.com/wotlk/fr/npc=33597
UPDATE `creature_template_locale` SET `Title` = 'Fournitures d''enchanteur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33597;
-- OLD name : Brollen Barbe-de-Blé (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33599
UPDATE `creature_template_locale` SET `Name` = 'Brollen Barbe-de-blé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33599;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Grand maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33603;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33630;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33631;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33633;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33634;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33635;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33636;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=33637
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33637;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33638;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33639;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33640;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33641;
-- OLD subname : Maître des alchimistes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des alchimistes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33674;
-- OLD subname : Maître des forgerons
-- Source : https://www.wowhead.com/wotlk/fr/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des forgerons',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33675;
-- OLD subname : Maître des enchanteurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des enchanteurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33676;
-- OLD subname : Maître des ingénieurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33677
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des ingénieurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33677;
-- OLD subname : Maître des herboristes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des herboristes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33678;
-- OLD subname : Maître des calligraphes
-- Source : https://www.wowhead.com/wotlk/fr/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des calligraphes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33679;
-- OLD subname : Maître des joailliers
-- Source : https://www.wowhead.com/wotlk/fr/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des joailliers',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33680;
-- OLD subname : Maître des travailleurs du cuir
-- Source : https://www.wowhead.com/wotlk/fr/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des travailleurs du cuir',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33681;
-- OLD subname : Maître des mineurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des mineurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33682;
-- OLD subname : Maître des dépeceurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des dépeceurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33683;
-- OLD subname : Maître des tailleurs
-- Source : https://www.wowhead.com/wotlk/fr/npc=33684
UPDATE `creature_template_locale` SET `Title` = 'Maître émérite des tailleurs',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33684;
-- OLD name : Champion des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=33748
UPDATE `creature_template_locale` SET `Name` = 'Champion des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33748;
-- OLD name : Illyrie Tombenuit
-- Source : https://www.wowhead.com/wotlk/fr/npc=33770
UPDATE `creature_template_locale` SET `Name` = 'Illyrie Crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33770;
-- OLD name : Kodo des Pitons-du-Tonnerre à l'écurie
-- Source : https://www.wowhead.com/wotlk/fr/npc=33792
UPDATE `creature_template_locale` SET `Name` = 'Kodo des Pitons du Tonnerre à l''écurie',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33792;
-- OLD name : Traqueur de débris de Kologarn
-- Source : https://www.wowhead.com/wotlk/fr/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Traqueur de débris Kologarn',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33809;
-- OLD name : Justicière Mariel Cœur-Vrai
-- Source : https://www.wowhead.com/wotlk/fr/npc=33817
UPDATE `creature_template_locale` SET `Name` = 'Justicière Mariel Coeur-vrai',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33817;
-- OLD name : Adhérent du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33818
UPDATE `creature_template_locale` SET `Name` = 'Adhérent du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33818;
-- OLD name : Mage de givre du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33819
UPDATE `creature_template_locale` SET `Name` = 'Mage de givre du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33819;
-- OLD name : Pyromancien du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33820
UPDATE `creature_template_locale` SET `Name` = 'Pyromancien du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33820;
-- OLD name : Gardien du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33822
UPDATE `creature_template_locale` SET `Name` = 'Gardien du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33822;
-- OLD name : Pourfendeur du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33823
UPDATE `creature_template_locale` SET `Name` = 'Pourfendeur du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33823;
-- OLD name : Lame de l'ombre du Crépuscule (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=33824
UPDATE `creature_template_locale` SET `Name` = 'Lame de l''ombre du crépuscule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33824;
-- OLD name : Points de focalisation de Mimiron
-- Source : https://www.wowhead.com/wotlk/fr/npc=33835
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33835;
-- OLD subname : Quartier-maître de l'emblème de la conquête
-- Source : https://www.wowhead.com/wotlk/fr/npc=33963
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de conquête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33963;
-- OLD subname : Quartier-maître de l'emblème de la conquête
-- Source : https://www.wowhead.com/wotlk/fr/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de conquête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 33964;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34044
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34044;
-- OLD name : Radio de Barbe-de-Bronze
-- Source : https://www.wowhead.com/wotlk/fr/npc=34054
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34054;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34064
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34064;
-- OLD name : Brann Barbe-de-Bronze (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34119
UPDATE `creature_template_locale` SET `Name` = 'Brann Barbe-de-bronze',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34119;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34281;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34319;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34381;
-- OLD name : Birana Sabot-Tempête (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34451
UPDATE `creature_template_locale` SET `Name` = 'Birana Sabot-tempête',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34451;
-- OLD subname : Voleuse
-- Source : https://www.wowhead.com/wotlk/fr/npc=34454
UPDATE `creature_template_locale` SET `Title` = 'Voleur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34454;
-- OLD name : Broln Corne-Rude (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34455
UPDATE `creature_template_locale` SET `Name` = 'Broln Corne-rude',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34455;
-- OLD subname : Prêtresse
-- Source : https://www.wowhead.com/wotlk/fr/npc=34473
UPDATE `creature_template_locale` SET `Title` = 'Prêtre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34473;
-- OLD name : Esprit de nain joyeux (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=34478
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Nain joyeux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34478;
-- OLD name : Esprit d'elfe de la nuit joyeux (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=34479
UPDATE `creature_template_locale` SET `Name` = 'Esprit d''Elfe de la nuit joyeux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34479;
-- OLD name : Esprit de tauren joyeux (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=34480
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Tauren joyeux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34480;
-- OLD name : Esprit de gnome joyeux (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=34481
UPDATE `creature_template_locale` SET `Name` = 'Esprit de Gnome joyeux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34481;
-- OLD name : Aponi Crin-Brillant (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34526
UPDATE `creature_template_locale` SET `Name` = 'Aponi Crin-brillant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34526;
-- OLD name : Tahu Vent-de-Sagesse (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34528
UPDATE `creature_template_locale` SET `Name` = 'Tahu Vent-de-sagesse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34528;
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34562;
-- OLD name : Laha Plaine-Lointaine (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34684
UPDATE `creature_template_locale` SET `Name` = 'Laha Plaine-lointaine',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34684;
-- OLD name : Ambrose Etinceboulon
-- Source : https://www.wowhead.com/wotlk/fr/npc=34702
UPDATE `creature_template_locale` SET `Name` = 'Ambrose Étinceboulon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34702;
-- OLD name : [DND] Poulet magique (draeneï mâle) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34731;
-- OLD subname : Maître des zeppelins des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=34765
UPDATE `creature_template_locale` SET `Title` = 'Maître des zeppelins des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34765;
-- OLD name : Tourelle à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=34778
UPDATE `creature_template_locale` SET `Name` = 'Tourelle de flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34778;
-- OLD name : Portail de Néant
-- Source : https://www.wowhead.com/wotlk/fr/npc=34825
UPDATE `creature_template_locale` SET `Name` = 'Portail du Néant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34825;
-- OLD name : Spectateur du colisée tauren
-- Source : https://www.wowhead.com/wotlk/fr/npc=34858
UPDATE `creature_template_locale` SET `Name` = 'Spectateur tauren du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34858;
-- OLD name : Spectateur du colisée orc
-- Source : https://www.wowhead.com/wotlk/fr/npc=34859
UPDATE `creature_template_locale` SET `Name` = 'Spectateur orc du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34859;
-- OLD name : Spectateur du colisée elfe de sang
-- Source : https://www.wowhead.com/wotlk/fr/npc=34861
UPDATE `creature_template_locale` SET `Name` = 'Spectateur elfe de sang du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34861;
-- OLD name : Spectateur du colisée draeneï
-- Source : https://www.wowhead.com/wotlk/fr/npc=34868
UPDATE `creature_template_locale` SET `Name` = 'Spectateur draeneï du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34868;
-- OLD name : Spectateur du colisée gnome
-- Source : https://www.wowhead.com/wotlk/fr/npc=34869
UPDATE `creature_template_locale` SET `Name` = 'Spectateur gnome du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34869;
-- OLD name : Spectateur du colisée humain
-- Source : https://www.wowhead.com/wotlk/fr/npc=34870
UPDATE `creature_template_locale` SET `Name` = 'Spectateur humain du colisée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34870;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34891;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 34910;
-- OLD name : Haut-commandant Halford Verroctone
-- Source : https://www.wowhead.com/wotlk/fr/npc=34924
UPDATE `creature_template_locale` SET `Name` = 'Haut commandant Halford Verroctone',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34924;
-- OLD name : Emissaire de l'île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34948
UPDATE `creature_template_locale` SET `Name` = 'Emissaire de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34948;
-- OLD name : Envoyé de l'île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34949
UPDATE `creature_template_locale` SET `Name` = 'Envoyé de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34949;
-- OLD name : Emissaire de l'île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34950
UPDATE `creature_template_locale` SET `Name` = 'Emissaire de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34950;
-- OLD name : Envoyé de l’’île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34951
UPDATE `creature_template_locale` SET `Name` = 'Envoyée de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34951;
-- OLD name : Portail de l’île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34952
UPDATE `creature_template_locale` SET `Name` = 'Portail de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34952;
-- OLD name : Portail de l’île des Conquérants
-- Source : https://www.wowhead.com/wotlk/fr/npc=34953
UPDATE `creature_template_locale` SET `Name` = 'Portail de l''Île des Conquérants',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34953;
-- OLD name : Ruk Choqueur-Martial (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34976
UPDATE `creature_template_locale` SET `Name` = 'Ruk Choqueur-martial',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34976;
-- OLD name : Mosha Corne-d’Étoile
-- Source : https://www.wowhead.com/wotlk/fr/npc=34978
UPDATE `creature_template_locale` SET `Name` = 'Mosha Corne-d''étoile',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34978;
-- OLD name : Borim Martel-d’Or
-- Source : https://www.wowhead.com/wotlk/fr/npc=34991
UPDATE `creature_template_locale` SET `Name` = 'Borim Martel-d''or',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34991;
-- OLD subname : Suzerain de l'offensive chanteguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=34995
UPDATE `creature_template_locale` SET `Title` = 'Suzerain de l''Offensive chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 34995;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 35066;
-- OLD name : Marinière du Faucon-de-feu (mort) (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35079
UPDATE `creature_template_locale` SET `Name` = 'Marinière du faucon-de-feu (mort)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35079;
-- OLD name : Marinier du Faucon-de-feu (mort)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35083
UPDATE `creature_template_locale` SET `Name` = 'Marinière du Faucon-de-feu (morte)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35083;
-- OLD subname : Instructeur de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Maître de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35093;
-- OLD name : Bana Crin-Sauvage (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35099
UPDATE `creature_template_locale` SET `Name` = 'Bana Crin-sauvage',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35099;
-- OLD subname : Instructeur de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Maître de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35100;
-- OLD subname : Instructrice de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Maître de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35133;
-- OLD subname : Instructrice de vol
-- Source : https://www.wowhead.com/wotlk/fr/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Maître de monte',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35135;
-- OLD name : Champion des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=35325
UPDATE `creature_template_locale` SET `Name` = 'Champion des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35325;
-- OLD name : Bognar Pied-de-Fer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35344
UPDATE `creature_template_locale` SET `Name` = 'Bognar Pied-de-fer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35344;
-- OLD subname : Suzerain de l'offensive chanteguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35372
UPDATE `creature_template_locale` SET `Title` = 'Suzerain de l''Offensive chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35372;
-- OLD name : Jeune raptor razzashi
-- Source : https://www.wowhead.com/wotlk/fr/npc=35394
UPDATE `creature_template_locale` SET `Name` = 'Jeune razzashi',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35394;
-- OLD name : Jeune raptor tranchegueule
-- Source : https://www.wowhead.com/wotlk/fr/npc=35398
UPDATE `creature_template_locale` SET `Name` = 'Jeune tranchegueule',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35398;
-- OLD name : Soldat d’élite kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=35460
UPDATE `creature_template_locale` SET `Name` = 'Kor''kron d''élite',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35460;
-- OLD name : Trag Haute-Montagne
-- Source : https://www.wowhead.com/wotlk/fr/npc=35462
UPDATE `creature_template_locale` SET `Name` = 'Trag Hautemontagne',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35462;
-- OLD name : Panthère en onyx
-- Source : https://www.wowhead.com/wotlk/fr/npc=35468
UPDATE `creature_template_locale` SET `Name` = 'Panthère onyx',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35468;
-- OLD name : Sorn Crin-Fier (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=35471
UPDATE `creature_template_locale` SET `Name` = 'Sorn Crin-fier',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35471;
-- OLD subname : Emblème du quartier-maître du triomphe
-- Source : https://www.wowhead.com/wotlk/fr/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes de triomphe',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35494;
-- OLD subname : Emblème du quartier-maître du triomphe
-- Source : https://www.wowhead.com/wotlk/fr/npc=35495
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes de triomphe',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35495;
-- OLD subname : Grand champion des Pitons-du-Tonnerre
-- Source : https://www.wowhead.com/wotlk/fr/npc=35571
UPDATE `creature_template_locale` SET `Title` = 'Grand champion des Pitons du Tonnerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35571;
-- OLD subname : Intendante des héritages de justice
-- Source : https://www.wowhead.com/wotlk/fr/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes de triomphe',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35573;
-- OLD subname : Intendante des héritages de justice
-- Source : https://www.wowhead.com/wotlk/fr/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Intendante des emblèmes de triomphe',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35574;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 35608;
-- OLD name : Monture d'Ambrose Etinceboulon
-- Source : https://www.wowhead.com/wotlk/fr/npc=35633
UPDATE `creature_template_locale` SET `Name` = 'Monture d''Ambrose Étinceboulon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35633;
-- OLD name : Monture de Zul’Tore
-- Source : https://www.wowhead.com/wotlk/fr/npc=35641
UPDATE `creature_template_locale` SET `Name` = 'Monture de Zul''tore',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 35641;
-- OLD name : [TEST] Destrier d'Argent (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36071;
-- OLD name : [TEST] Loup bordeaux rapide (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36072;
-- OLD name : [TEST] Loup rapide de la Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36074;
-- OLD name : [TEST] Etalon blanc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36075;
-- OLD name : [TEST] Palefroi rapide de l'Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36076;
-- OLD name : [DND] Forsaken Mariner
-- Source : https://www.wowhead.com/wotlk/fr/npc=36148
UPDATE `creature_template_locale` SET `Name` = 'Marinier réprouvé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36148;
-- OLD name : Saccageur kor’’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=36164
UPDATE `creature_template_locale` SET `Name` = 'Saccageur kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36164;
-- OLD name : Soldat de marine de la 7e Légion
-- Source : https://www.wowhead.com/wotlk/fr/npc=36166
UPDATE `creature_template_locale` SET `Name` = 'Soldat de marine de la 7e Legion',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36166;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36212;
-- OLD name : Surveillant kor’’kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=36213
UPDATE `creature_template_locale` SET `Name` = 'Garde de Fossoyeuse',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36213;
-- OLD name : Surveillant Kraggosh (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=36217
UPDATE `creature_template_locale` SET `Name` = 'Corps mutilé',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36217;
-- OLD name : Bragor Poing-de-Sang (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=36273
UPDATE `creature_template_locale` SET `Name` = 'Bragor Poing-de-sang',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36273;
-- OLD name : Tourelle à feu
-- Source : https://www.wowhead.com/wotlk/fr/npc=36356
UPDATE `creature_template_locale` SET `Name` = 'Tourelle de flammes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36356;
-- OLD subname : Les Bien-nés
-- Source : https://www.wowhead.com/wotlk/fr/npc=36479
UPDATE `creature_template_locale` SET `Title` = 'Le Bien-né',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36479;
-- OLD name : Daros Vougelune, subname : Les Bien-nés
-- Source : https://www.wowhead.com/wotlk/fr/npc=36506
UPDATE `creature_template_locale` SET `Name` = 'Daros Pieutelune',`Title` = 'Le Bien-né',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36506;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36530;
-- OLD name : [mini] Elémentaire de feu instable (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36553
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36553;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36643;
-- OLD name : Arcaniste Tybalin
-- Source : https://www.wowhead.com/wotlk/fr/npc=36669
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36669;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36710;
-- OLD name : Esclave de l'Alliance
-- Source : https://www.wowhead.com/wotlk/fr/npc=36766
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36766;
-- OLD name : [DND] Love Boat Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36817
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36817;
-- OLD name : Effondrement de stalagtite
-- Source : https://www.wowhead.com/wotlk/fr/npc=36847
UPDATE `creature_template_locale` SET `Name` = 'Stalagtite s''effondrant',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36847;
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36875;
-- OLD name : Bébé griffon
-- Source : https://www.wowhead.com/wotlk/fr/npc=36908
UPDATE `creature_template_locale` SET `Name` = 'Jeune griffon',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36908;
-- OLD name : Bébé coursier du vent
-- Source : https://www.wowhead.com/wotlk/fr/npc=36909
UPDATE `creature_template_locale` SET `Name` = 'Jeune coursier du vent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36909;
-- OLD name : Saccageur kor’’kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=36957
UPDATE `creature_template_locale` SET `Name` = 'Saccageur kor’kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36957;
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 36966;
-- OLD name : Lanceur de hache kor'kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=36968
UPDATE `creature_template_locale` SET `Name` = 'Lanceur de haches kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36968;
-- OLD name : Membre d'équipage du Marteau d'Orgrim
-- Source : https://www.wowhead.com/wotlk/fr/npc=36971
UPDATE `creature_template_locale` SET `Name` = 'Equipage du Marteau d''Orgrim',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 36971;
-- OLD name : Saccageur kor’’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=37029
UPDATE `creature_template_locale` SET `Name` = 'Saccageur kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37029;
-- OLD name : Oracle kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=37031
UPDATE `creature_template_locale` SET `Name` = 'Oracle kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37031;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37039;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37128;
-- OLD name : Nécrolyte kor’’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=37149
UPDATE `creature_template_locale` SET `Name` = 'Nécrolyte kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37149;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37168;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37202;
-- OLD subname : Général des Forestiers (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=37527
UPDATE `creature_template_locale` SET `Title` = 'Général des forestiers de Lune-d’Argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37527;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37543;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37574;
-- OLD name : Furie
-- Source : https://www.wowhead.com/wotlk/fr/npc=37586
UPDATE `creature_template_locale` SET `Name` = 'Furia',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37586;
-- OLD name : Bâtisseur de Lune-d'argent (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=37707
UPDATE `creature_template_locale` SET `Name` = 'Bâtisseur de Lune-d’Argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37707;
-- OLD name : Goule efflanquée
-- Source : https://www.wowhead.com/wotlk/fr/npc=37711
UPDATE `creature_template_locale` SET `Name` = 'Goule affamée',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37711;
-- OLD name : [PH] Runner Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37788;
-- OLD name : Guet de Lune-d'argent (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=37800
UPDATE `creature_template_locale` SET `Name` = 'Guet de Lune-d’Argent',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37800;
-- OLD name : [TEST] Haut seigneur Omar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37820;
-- OLD name : Surveillant kor’’kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=37825
UPDATE `creature_template_locale` SET `Name` = 'Surveillant kor’kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37825;
-- OLD name : Image de Noth le Porte-peste (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=37851
UPDATE `creature_template_locale` SET `Name` = 'Image de Noth le Porte-Peste',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37851;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=37887
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37887;
-- OLD subname : Eleveur de chauves-souris
-- Source : https://www.wowhead.com/wotlk/fr/npc=37915
UPDATE `creature_template_locale` SET `Title` = 'Éleveur de chauves-souris',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37915;
-- OLD name : Saccageur kor’’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=37920
UPDATE `creature_template_locale` SET `Name` = 'Saccageur kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37920;
-- OLD name : Fauteur de troubles sombrefer (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=37937
UPDATE `creature_template_locale` SET `Name` = 'Fauteur de troubles Sombrefer',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37937;
-- OLD subname : Emblème du quartier-maître de givre
-- Source : https://www.wowhead.com/wotlk/fr/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37941;
-- OLD subname : Emblème du quartier-maître de givre
-- Source : https://www.wowhead.com/wotlk/fr/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37942;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 37990;
-- OLD name : Elémentaire d’eau
-- Source : https://www.wowhead.com/wotlk/fr/npc=37994
UPDATE `creature_template_locale` SET `Name` = 'Elémentaire d''eau',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 37994;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=38041
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38041;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=38042
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38042;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=38044
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38044;
-- OLD name : Kalin Colportecœur
-- Source : https://www.wowhead.com/wotlk/fr/npc=38045
UPDATE `creature_template_locale` SET `Name` = 'Kalin Colportecoeur',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38045;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38053;
-- OLD name : Grande fusée d'amour (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Brise-coeur X-45',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38204;
-- OLD name : Grande fusée d'amour (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'Brise-coeur X-45',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38207;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38236;
-- OLD name : Traqueur invisible (flotte, aucune interaction, grande AOI) (3.00) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=38310
UPDATE `creature_template_locale` SET `Name` = 'Invisible Stalker (Float, Uninteractible, LargeAOI) (3.00)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38310;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38342;
-- OLD name : Lieutenant kor’kron
-- Source : https://www.wowhead.com/wotlk/fr/npc=38491
UPDATE `creature_template_locale` SET `Name` = 'Lieutenant kor''kron',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38491;
-- OLD name : Traqueur de martyr
-- Source : https://www.wowhead.com/wotlk/fr/npc=38569
UPDATE `creature_template_locale` SET `Name` = 'Traqueur de martyr (IGB/Saurcroc)',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38569;
-- OLD subname : Le Porte-cendres (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=38610
UPDATE `creature_template_locale` SET `Title` = 'Le Porte-Cendres',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38610;
-- OLD subname : Intendant des héritages de justice
-- Source : https://www.wowhead.com/wotlk/fr/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Intendant des emblèmes de givre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38858;
-- OLD name : Nervi de la Vieille ville (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=38867
UPDATE `creature_template_locale` SET `Name` = 'Nervi de la vieille ville',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38867;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 38883;
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39023;
-- OLD name : Gavan Griseplume
-- Source : https://www.wowhead.com/wotlk/fr/npc=39055
UPDATE `creature_template_locale` SET `Name` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39055;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39057;
-- OLD subname : Le Cercle terrestre (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=39090
UPDATE `creature_template_locale` SET `Title` = 'Cercle terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39090;
-- OLD subname : Roi des gnomes (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=39271
UPDATE `creature_template_locale` SET `Title` = 'Roi des Gnomes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39271;
-- OLD subname : Le Cercle terrestre (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=39283
UPDATE `creature_template_locale` SET `Title` = 'Cercle terrestre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39283;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39362;
-- OLD subname : Suzerain de l'offensive chanteguerre (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/fr/npc=39372
UPDATE `creature_template_locale` SET `Title` = 'Suzerain de l''Offensive chanteguerre',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39372;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39420;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39683;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39707;
-- OLD subname : Roi des gnomes (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=39712
UPDATE `creature_template_locale` SET `Title` = 'Roi des Gnomes',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39712;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39744;
-- OLD name : Image de Cho'Gall (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=39807
UPDATE `creature_template_locale` SET `Name` = 'Image de Cho’gall',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 39807;
-- OLD name : [DND] Plate-forme d'invocation (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39817;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 39841;
-- OLD subname : Armes d’arène historiques
-- Source : https://www.wowhead.com/wotlk/fr/npc=40212
UPDATE `creature_template_locale` SET `Title` = 'Armes d''arène exceptionnelles',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 40212;
-- OLD name : Evee Cuivressort, subname : Intendante de conquête
-- Source : https://www.wowhead.com/wotlk/fr/npc=40214
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 40214;
-- OLD subname : Armes d’arène historiques (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=40216
UPDATE `creature_template_locale` SET `Title` = 'Gladiateur vicieux',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 40216;
-- OLD name : Rob-fusée mécanique bleu
-- Source : https://www.wowhead.com/wotlk/fr/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Rob-fusée mécanique',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 40295;
-- OLD name : [DND] Forme de voyage de Zen'tabra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 40354;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 40428;
-- OLD subname : Tambour de guerre de Vol'jin (RETAIL DATAS)
-- Source : https://www.wowhead.com/fr/npc=40492
UPDATE `creature_template_locale` SET `Title` = 'Tambour de guerre de Vol’jin',`VerifiedBuild` = 0 WHERE `locale` = 'frFR' AND `entry` = 40492;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 40617;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/fr/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'frFR' AND `entry` = 41839;

-- List of entries using retail datas :
-- 72,81,444,6783,18674,23538,23539,23641,23715,23808,24109,24181,24377,24378,24588,24599,24604,24865,24983,26486,26594,27231,27862,27916,28652,29039,29348,29756,30368,30426,30427,30428,30888,31060,31168,32585,32586,32775,32776,33314,33418,33466,33536,34478,34479,34480,34481,36213,36217,36957,36968,37527,37707,37800,37825,37851,38204,38207,38310,38610,38883,39090,39271,39283,39712,39807,40216,40492
-- END
