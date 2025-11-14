-- Update esMX ; from WowHead WOTLK+ / Retail
-- OLD name : Matón sin cerebro
-- Source : https://www.wowhead.com/wotlk/mx/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Matón Defias' WHERE `locale` = 'esMX' AND `entry` = 38;
-- OLD name : [UNUSED] Ciudadano de clase baja (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 70;
-- OLD name : [UNUSED] Vashaum Nochemustia (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 75;
-- OLD name : [UNUSED] Luglar el Obstructor (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Vacaciones - Halloween - Fortaleza - Elemental espectral' WHERE `locale` = 'esMX' AND `entry` = 81;
-- OLD name : Ratero
-- Source : https://www.wowhead.com/wotlk/mx/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Ratero Defias' WHERE `locale` = 'esMX' AND `entry` = 94;
-- OLD name : Bandido
-- Source : https://www.wowhead.com/wotlk/mx/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandido Defias' WHERE `locale` = 'esMX' AND `entry` = 116;
-- OLD name : [UNUSED] Pequeña cría de dragón Negro (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 149;
-- OLD name : [UNUSED] Ander el Monje (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 161;
-- OLD name : [UNUSED] Granjero desposeído (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 163;
-- OLD name : [UNUSED] Niño pequeño (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 165;
-- OLD name : Horror en podredumbre
-- Source : https://www.wowhead.com/wotlk/mx/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Horror esquelético' WHERE `locale` = 'esMX' AND `entry` = 202;
-- OLD name : [UNUSED] Risillas Fogóseo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 204;
-- OLD name : [UNUSED] Desollador Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 207;
-- OLD name : [UNUSED] Depositario Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 208;
-- OLD name : [UNUSED] Huesocorista Garrarío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 209;
-- OLD name : Thornton Fellwood (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'esMX','PNJs',NULL);
-- OLD name : Alguacil Gryan Mantorrecio, subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Mantorrecio',`Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 234;
-- OLD name : [UNUSED] Greeby Vellolodo TEST (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=243
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 243;
-- OLD name : [UNUSED] Guardia de Torre de Elwynn (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 260;
-- OLD name : [DND] Wounded Lion's Footman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=262
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 262;
-- OLD name : [UNUSED] Jans Buenamadre (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 296;
-- OLD name : Lobo joven
-- Source : https://www.wowhead.com/wotlk/mx/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Lobo joven malsano' WHERE `locale` = 'esMX' AND `entry` = 299;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 301;
-- OLD name : [UNUSED] Hermano Akil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 318;
-- OLD name : [UNUSED] Hermano Benthas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 319;
-- OLD name : [UNUSED] Hermano Cryus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 320;
-- OLD name : [UNUSED] Hermano Deros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 321;
-- OLD name : [UNUSED] Hermano Enoch (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 322;
-- OLD name : [UNUSED] Hermano Lontananza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=323
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 323;
-- OLD name : [UNUSED] Hermano Greishan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 324;
-- OLD name : [UNUSED] Hermano Ictharin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 326;
-- OLD name : [UNUSED] Eduardo el Bufón (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 333;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor el Púgil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 339;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/mx/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Camarera' WHERE `locale` = 'esMX' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 380;
-- OLD name : Niño - placeholder 05 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=399
UPDATE `creature_template_locale` SET `Name` = 'Tipo de la patrulla' WHERE `locale` = 'esMX' AND `entry` = 399;
-- OLD name : Niño - placeholder 06 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=400
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 400;
-- OLD name : Niño - placeholder 07 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=401
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 401;
-- OLD name : Niño - placeholder 08 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=402
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 402;
-- OLD name : Niño - placeholder 09 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=403
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 403;
-- OLD name : Gocho (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Lord Cerdito' WHERE `locale` = 'esMX' AND `entry` = 444;
-- OLD subname : Instructora de brujos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=461
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 461;
-- OLD name : Capitán de la Avanzada Parker
-- Source : https://www.wowhead.com/wotlk/mx/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Guardia Parker' WHERE `locale` = 'esMX' AND `entry` = 464;
-- OLD name : [UNUSED] Escriba Colburg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 470;
-- OLD name : Zahorí bribón
-- Source : https://www.wowhead.com/wotlk/mx/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Zahorí bribón de Defias' WHERE `locale` = 'esMX' AND `entry` = 474;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=487
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 487;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=488
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 488;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=489
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 489;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=490
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 490;
-- OLD name : [UNUSED] Vigía Kleeman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 496;
-- OLD name : [UNUSED] Vigía Benjamín (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 497;
-- OLD name : [UNUSED] Vigía Larsen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 498;
-- OLD name : [UNUSED] Colmillolargo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 509;
-- OLD name : [UNUSED] Cazadir Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 516;
-- OLD name : [UNUSED] Savar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 535;
-- OLD name : [UNUSED] Rhal'Del (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 536;
-- OLD name : [UNUSED] Buk'Cha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 538;
-- OLD name : Califex del Bosque profundo, subname : Instructor de druidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=542
UPDATE `creature_template_locale` SET `Name` = 'PNJs',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 542;
-- OLD name : Emboscador
-- Source : https://www.wowhead.com/wotlk/mx/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Emboscador Defias' WHERE `locale` = 'esMX' AND `entry` = 583;
-- OLD name : [UNUSED] Vigía Kern (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 586;
-- OLD name : [UNUSED] Pirómano Defias (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=592
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 592;
-- OLD name : [UNUSED] Sr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=605
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 605;
-- OLD name : [UNUSED] Sra. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=606
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 606;
-- OLD name : [UNUSED] Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 607;
-- OLD name : [UNUSED] Abuelo Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=609
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 609;
-- OLD name : [UNUSED] Gina Whipple rabiosa (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 610;
-- OLD name : [UNUSED] Sr. Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=611
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 611;
-- OLD name : [UNUSED] Sra.Whipple rabiosa (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=612
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 612;
-- OLD name : [UNUSED] Johnny Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=613
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 613;
-- OLD name : [UNUSED] Abuelo Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=614
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 614;
-- OLD name : Tío de prueba de pnagle (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=631
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 631;
-- OLD name : General Fangore
-- Source : https://www.wowhead.com/wotlk/mx/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Teniente Fangore' WHERE `locale` = 'esMX' AND `entry` = 703;
-- OLD name : [UNUSED] Déspota esquelético (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=725
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 725;
-- OLD name : [UNUSED] Soldado Rebelde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 753;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=820
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 820;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=821
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 821;
-- OLD name : Sargento Willem
-- Source : https://www.wowhead.com/wotlk/mx/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Ayudante de alguacil Willem' WHERE `locale` = 'esMX' AND `entry` = 823;
-- OLD name : Ciclón desatado
-- Source : https://www.wowhead.com/wotlk/mx/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Diablo de polvo' WHERE `locale` = 'esMX' AND `entry` = 832;
-- OLD name : Harl Cutter (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'esMX','PNJs',NULL);
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=869
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 869;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=870
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 870;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=874
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 874;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=876
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 876;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/mx/npc=878
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 878;
-- OLD name : [UNUSED] Arácnido inferior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=924
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 924;
-- OLD name : [UNUSED] Truek (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=1058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 1058;
-- OLD subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=1156
UPDATE `creature_template_locale` SET `Title` = 'Tabernera' WHERE `locale` = 'esMX' AND `entry` = 1156;
-- OLD name : Déspota Mo'grosh (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=1179
UPDATE `creature_template_locale` SET `Name` = 'Agente Mo''grosh' WHERE `locale` = 'esMX' AND `entry` = 1179;
-- OLD name : Oso negro
-- Source : https://www.wowhead.com/wotlk/mx/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Oso negro mayor' WHERE `locale` = 'esMX' AND `entry` = 1186;
-- OLD subname : Mercader de arcos
-- Source : https://www.wowhead.com/wotlk/mx/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Mercader de arcos y flechas' WHERE `locale` = 'esMX' AND `entry` = 1298;
-- OLD name : [UNUSED] Kern el Déspota (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=1361
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 1361;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Cocinero superior' WHERE `locale` = 'esMX' AND `entry` = 1382;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esMX' AND `entry` = 1430;
-- OLD name : [UNUSED] Grummar Thunk (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'esMX','PNJs',NULL);
-- OLD name : Gorila Lomoblanco iracundo
-- Source : https://www.wowhead.com/wotlk/mx/npc=1511
UPDATE `creature_template_locale` SET `Name` = 'Gorila Lomoplata iracundo' WHERE `locale` = 'esMX' AND `entry` = 1511;
-- OLD name : Patriarca Lomoblanco
-- Source : https://www.wowhead.com/wotlk/mx/npc=1558
UPDATE `creature_template_locale` SET `Name` = 'Patriarca Lomoplata' WHERE `locale` = 'esMX' AND `entry` = 1558;
-- OLD name : [UNUSED] Guardia de Elwynn (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 1643;
-- OLD name : [UNUSED] Guardia de Crestagrana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=1644
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 1644;
-- OLD name : [UNUSED] Curtis Cierreniza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=1677
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 1677;
-- OLD name : Prisionero
-- Source : https://www.wowhead.com/wotlk/mx/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Prisionero Defias' WHERE `locale` = 'esMX' AND `entry` = 1706;
-- OLD name : Presidiario
-- Source : https://www.wowhead.com/wotlk/mx/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Presidiario Defias' WHERE `locale` = 'esMX' AND `entry` = 1711;
-- OLD name : Insurgente
-- Source : https://www.wowhead.com/wotlk/mx/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Insurgente Defias' WHERE `locale` = 'esMX' AND `entry` = 1715;
-- OLD name : Gran almirante Jes-Tereth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=1750
UPDATE `creature_template_locale` SET `Name` = 'Gran Almirante Jes-Tereth' WHERE `locale` = 'esMX' AND `entry` = 1750;
-- OLD name : Huargo rabioso
-- Source : https://www.wowhead.com/wotlk/mx/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Huargo jaspeado' WHERE `locale` = 'esMX' AND `entry` = 1766;
-- OLD name : Vigía de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/mx/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Vigía de Dalaran' WHERE `locale` = 'esMX' AND `entry` = 1888;
-- OLD name : Zahorí de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/mx/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Zahorí de Dalaran' WHERE `locale` = 'esMX' AND `entry` = 1889;
-- OLD name : [UNUSED] Ciudadano de Molino Ámbar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2087
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2087;
-- OLD name : [UNUSED] Pregonero Kirton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2197;
-- OLD name : [UNUSED] Pregonero Backus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2199;
-- OLD name : [UNUSED] Pregonero Pierce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2200;
-- OLD name : [UNUSED] Instructor no-muerto de herreros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2220
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2220;
-- OLD name : [UNUSED] Instructor no-muerto de cocineros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2223
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2223;
-- OLD name : Bow Guy (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'esMX','PNJs',NULL);
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2313;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Médico' WHERE `locale` = 'esMX' AND `entry` = 2326;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Médica' WHERE `locale` = 'esMX' AND `entry` = 2329;
-- OLD name : Trepador domesticado
-- Source : https://www.wowhead.com/wotlk/mx/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Trepamusgo gigante' WHERE `locale` = 'esMX' AND `entry` = 2349;
-- OLD name : Trepador del bosque
-- Source : https://www.wowhead.com/wotlk/mx/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Trepamusgo del bosque' WHERE `locale` = 'esMX' AND `entry` = 2350;
-- OLD name : Oso contagiado
-- Source : https://www.wowhead.com/wotlk/mx/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Oso gris' WHERE `locale` = 'esMX' AND `entry` = 2351;
-- OLD name : Acechador Trabaloma
-- Source : https://www.wowhead.com/wotlk/mx/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'León de montaña feral' WHERE `locale` = 'esMX' AND `entry` = 2385;
-- OLD name : Guardia de la Alianza
-- Source : https://www.wowhead.com/wotlk/mx/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Guardia de Costasur' WHERE `locale` = 'esMX' AND `entry` = 2386;
-- OLD name : Guardia de la Muerte de Molino Tarren
-- Source : https://www.wowhead.com/wotlk/mx/npc=2405
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la Muerte del Molino Tarren' WHERE `locale` = 'esMX' AND `entry` = 2405;
-- OLD name : [UNUSED] Ciudadano de Costasur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2441
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2441;
-- OLD subname : Enviado de Zanzil
-- Source : https://www.wowhead.com/wotlk/mx/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Rehén Lanza Negra' WHERE `locale` = 'esMX' AND `entry` = 2530;
-- OLD name : Soldado de Stromgarde
-- Source : https://www.wowhead.com/wotlk/mx/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Vindicador de Stromgarde' WHERE `locale` = 'esMX' AND `entry` = 2585;
-- OLD name : [UNUSED] Archimago Detrae (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2617;
-- OLD name : Crocolisco Quijaforte mayor
-- Source : https://www.wowhead.com/wotlk/mx/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Crocolisco marino mayor' WHERE `locale` = 'esMX' AND `entry` = 2635;
-- OLD name : Port Master Szik (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'esMX','PNJs',NULL);
-- OLD subname : Suministros generales
-- Source : https://www.wowhead.com/wotlk/mx/npc=2808
UPDATE `creature_template_locale` SET `Title` = 'Pertrechos' WHERE `locale` = 'esMX' AND `entry` = 2808;
-- OLD name : [PH] Instructor de zancaaltas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2871
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2871;
-- OLD name : [PH] Instructor de raptores (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2873
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2873;
-- OLD name : [PH] Domador de caballos (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2874
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2874;
-- OLD name : [PH] Instructor de gorilas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2875
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2875;
-- OLD name : Grunenstur Balindom (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2876
UPDATE `creature_template_locale` SET `Name` = 'PNJs' WHERE `locale` = 'esMX' AND `entry` = 2876;
-- OLD name : [PH] Instructor de reptadores (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2877
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2877;
-- OLD name : Trogg Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2889
UPDATE `creature_template_locale` SET `Name` = 'Trogg grutacanto' WHERE `locale` = 'esMX' AND `entry` = 2889;
-- OLD name : [PH] Instructora de poderes mágicos de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2896
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2896;
-- OLD name : [PH] Instructor de resistencia de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2899
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2899;
-- OLD name : Arqueóloga Hollee (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2913
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 2913;
-- OLD name : [PH] Maestro de demonios (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=2935
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2935;
-- OLD name : Jackson Bayne (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'esMX','PNJs',NULL);
-- OLD subname : Suministros de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Suministros de sastrería y peletería' WHERE `locale` = 'esMX' AND `entry` = 3005;
-- OLD subname : Suministros de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Oficial peletero' WHERE `locale` = 'esMX' AND `entry` = 3008;
-- OLD name : [UNUSED] Guardia Narache (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3082
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3082;
-- OLD name : Reptador de espuma
-- Source : https://www.wowhead.com/wotlk/mx/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Reptador de espuma pigmeo' WHERE `locale` = 'esMX' AND `entry` = 3106;
-- OLD name : Reptador de espuma adulto
-- Source : https://www.wowhead.com/wotlk/mx/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Reptador de espuma' WHERE `locale` = 'esMX' AND `entry` = 3107;
-- OLD name : Eric's AAA Special Vendor (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3200
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3200;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3200, 'esMX','PNJs',NULL);
-- OLD name : Fizzle Garra Oscura
-- Source : https://www.wowhead.com/wotlk/mx/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Fizzle Tormenta Oscura' WHERE `locale` = 'esMX' AND `entry` = 3203;
-- OLD name : Desvalijador Crines de Acero
-- Source : https://www.wowhead.com/wotlk/mx/npc=3267
UPDATE `creature_template_locale` SET `Name` = 'Buscaqua Crines de Acero' WHERE `locale` = 'esMX' AND `entry` = 3267;
-- OLD name : Anomalía de lodo
-- Source : https://www.wowhead.com/wotlk/mx/npc=3295
UPDATE `creature_template_locale` SET `Name` = 'Bestia de lodo' WHERE `locale` = 'esMX' AND `entry` = 3295;
-- OLD subname : Mercader de armaduras de tela
-- Source : https://www.wowhead.com/wotlk/mx/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armaduras ligeras' WHERE `locale` = 'esMX' AND `entry` = 3317;
-- OLD subname : Vendedora de arcos y rifles
-- Source : https://www.wowhead.com/wotlk/mx/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armas de fuego y municiones' WHERE `locale` = 'esMX' AND `entry` = 3322;
-- OLD subname : Venenos y componentes
-- Source : https://www.wowhead.com/wotlk/mx/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Suministros de herboristería' WHERE `locale` = 'esMX' AND `entry` = 3405;
-- OLD name : [UNUSED] Vigía Ancestral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3420
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3420;
-- OLD name : [UNUSED] Kendur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3427
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3427;
-- OLD name : [UNUSED] Sabio Ancestral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3440
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3440;
-- OLD subname : Contratista independiente
-- Source : https://www.wowhead.com/wotlk/mx/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Gremio de manitas' WHERE `locale` = 'esMX' AND `entry` = 3442;
-- OLD name : Robovigilante, versión 1
-- Source : https://www.wowhead.com/wotlk/mx/npc=3538
UPDATE `creature_template_locale` SET `Name` = 'Robovigilante Mark I' WHERE `locale` = 'esMX' AND `entry` = 3538;
-- OLD name : [UNUSED] Observador Kolkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3651;
-- OLD name : Centinela Elissa Brisa Estelar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3657
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 3657;
-- OLD name : Delgren el Purificador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3663
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 3663;
-- OLD name : Ilkrud Magthrull (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3664
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 3664;
-- OLD name : Muyoh
-- Source : https://www.wowhead.com/wotlk/mx/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Discípulo de Naralex' WHERE `locale` = 'esMX' AND `entry` = 3678;
-- OLD name : Kyln Longclaw (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'esMX','PNJs',NULL);
-- OLD name : Déspota de la Facción Oscura (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3727
UPDATE `creature_template_locale` SET `Name` = 'Agente de la Facción Oscura' WHERE `locale` = 'esMX' AND `entry` = 3727;
-- OLD name : Teldira Plumalunar
-- Source : https://www.wowhead.com/wotlk/mx/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Caylais Plumalunar' WHERE `locale` = 'esMX' AND `entry` = 3841;
-- OLD name : [UNUSED] Aullasangre Colmillo Oscuro (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3852
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3852;
-- OLD name : [UNUSED] Corrupto Colmillo Oscuro (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3860
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3860;
-- OLD name : [UNUSED] Espíritu traumatizado (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=3876
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 3876;
-- OLD name : Tótem abrasador IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3904
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem abrasador IV' WHERE `locale` = 'esMX' AND `entry` = 3904;
-- OLD name : Tótem Corriente de sanación III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3907
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Corriente de sanación III' WHERE `locale` = 'esMX' AND `entry` = 3907;
-- OLD subname : General del ejército de los centinelas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3936
UPDATE `creature_template_locale` SET `Title` = 'General del ejército centinela' WHERE `locale` = 'esMX' AND `entry` = 3936;
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=3961
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 3961;
-- OLD name : Corremanadas Galak (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4098
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4098;
-- OLD name : Maleante Galak
-- Source : https://www.wowhead.com/wotlk/mx/npc=4099
UPDATE `creature_template_locale` SET `Name` = 'Merodeador Galak' WHERE `locale` = 'esMX' AND `entry` = 4099;
-- OLD name : Emboscador Gravamorro (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4115
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4115;
-- OLD name : Invasor silítido (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4131
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4131;
-- OLD name : Tortuga Brillavalva (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=4142
UPDATE `creature_template_locale` SET `Name` = 'Tortuga brillavalva' WHERE `locale` = 'esMX' AND `entry` = 4142;
-- OLD name : Sacudidor Brillavalva
-- Source : https://www.wowhead.com/wotlk/mx/npc=4143
UPDATE `creature_template_locale` SET `Name` = 'Mordedor brillavalva' WHERE `locale` = 'esMX' AND `entry` = 4143;
-- OLD name : Cavapozos Brillavalva
-- Source : https://www.wowhead.com/wotlk/mx/npc=4144
UPDATE `creature_template_locale` SET `Name` = 'Cazapozos brillavalva' WHERE `locale` = 'esMX' AND `entry` = 4144;
-- OLD name : Basilisco Gapo Salino
-- Source : https://www.wowhead.com/wotlk/mx/npc=4147
UPDATE `creature_template_locale` SET `Name` = 'Basilisco Piedra de sal' WHERE `locale` = 'esMX' AND `entry` = 4147;
-- OLD name : Observador Gapo Salino
-- Source : https://www.wowhead.com/wotlk/mx/npc=4150
UPDATE `creature_template_locale` SET `Name` = 'Observador Piedra de sal' WHERE `locale` = 'esMX' AND `entry` = 4150;
-- OLD name : Vitropiel Gapo Salino
-- Source : https://www.wowhead.com/wotlk/mx/npc=4151
UPDATE `creature_template_locale` SET `Name` = 'Vitropiel Piedra de sal' WHERE `locale` = 'esMX' AND `entry` = 4151;
-- OLD name : Kitari Buscalongo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4157
UPDATE `creature_template_locale` SET `Name` = 'zzOLDKitari Buscalongo' WHERE `locale` = 'esMX' AND `entry` = 4157;
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4167
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 4167;
-- OLD name : Siannai (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'esMX','PNJs',NULL);
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4181
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 4181;
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4191
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 4191;
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4195
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 4195;
-- OLD subname : Instructor de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4211
UPDATE `creature_template_locale` SET `Title` = 'Instructor de vendajes' WHERE `locale` = 'esMX' AND `entry` = 4211;
-- OLD name : Talegon (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'esMX','PNJs',NULL);
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4266
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 4266;
-- OLD name : Adivino Escarlata
-- Source : https://www.wowhead.com/wotlk/mx/npc=4291
UPDATE `creature_template_locale` SET `Name` = 'Adivinador Escarlata' WHERE `locale` = 'esMX' AND `entry` = 4291;
-- OLD name : [UNUSED] [PH] Embajador Saylaton Pezuñamorta (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=4313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 4313;
-- OLD name : [UNUSED] Guthrin Pezuñamorta (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=4315
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 4315;
-- OLD name : Delyka (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4318
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4318;
-- OLD name : Bestia de lodazal Parramustia
-- Source : https://www.wowhead.com/wotlk/mx/npc=4387
UPDATE `creature_template_locale` SET `Name` = 'Lodobestia Parramustia' WHERE `locale` = 'esMX' AND `entry` = 4387;
-- OLD name : Rondador Colmiumbrío (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4411
UPDATE `creature_template_locale` SET `Name` = 'Rondador Colmillo umbrío' WHERE `locale` = 'esMX' AND `entry` = 4411;
-- OLD name : Araña Colmiumbrío (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4413
UPDATE `creature_template_locale` SET `Name` = 'Araña Colmillo umbrío' WHERE `locale` = 'esMX' AND `entry` = 4413;
-- OLD name : Race Master Kronkrider
-- Source : https://www.wowhead.com/wotlk/mx/npc=4419
UPDATE `creature_template_locale` SET `Name` = 'Maestro del circuito Kronkpiloto' WHERE `locale` = 'esMX' AND `entry` = 4419;
-- OLD name : Wazza (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'esMX','PNJs',NULL);
-- OLD name : Griznak (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4445
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4445;
-- OLD name : Mazzer Quitaclavos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4446
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4446;
-- OLD name : Crazzle Engranágil (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4449
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4449;
-- OLD name : Alfombriz (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4450
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 4450;
-- OLD name : Visión mortificadora
-- Source : https://www.wowhead.com/wotlk/mx/npc=4472
UPDATE `creature_template_locale` SET `Name` = 'Visión encantada' WHERE `locale` = 'esMX' AND `entry` = 4472;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Sastre de tejido de sombra maestra' WHERE `locale` = 'esMX' AND `entry` = 4578;
-- OLD name : Alexander Lister (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4579
UPDATE `creature_template_locale` SET `Name` = 'zzOLDAlexander Lister' WHERE `locale` = 'esMX' AND `entry` = 4579;
-- OLD name : Guardia Argenta Thaelrid, subname : El Alba Argenta (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4787
UPDATE `creature_template_locale` SET `Name` = 'Explorador Thaelrid',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 4787;
-- OLD name : Rondador Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4850
UPDATE `creature_template_locale` SET `Name` = 'Rondador grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4850;
-- OLD name : Masticapiedras Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4851
UPDATE `creature_template_locale` SET `Name` = 'Masticapiedras grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4851;
-- OLD name : Oráculo Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4852
UPDATE `creature_template_locale` SET `Name` = 'Oráculo grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4852;
-- OLD name : Geomántico Grutacanto (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4853
UPDATE `creature_template_locale` SET `Name` = 'Geomante grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4853;
-- OLD subname : Jefe Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4854
UPDATE `creature_template_locale` SET `Title` = 'Jefe grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4854;
-- OLD name : Camorrista Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4855
UPDATE `creature_template_locale` SET `Name` = 'Camorrista grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4855;
-- OLD name : Cazador de las cuevas Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=4856
UPDATE `creature_template_locale` SET `Name` = 'Cazador de las cuevas grutacanto' WHERE `locale` = 'esMX' AND `entry` = 4856;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Forjadora de armas' WHERE `locale` = 'esMX' AND `entry` = 4888;
-- OLD subname : Instructor de cazadores y arquero
-- Source : https://www.wowhead.com/wotlk/mx/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Fabricante de arcos' WHERE `locale` = 'esMX' AND `entry` = 4892;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esMX' AND `entry` = 4894;
-- OLD subname : Pertrechos y componentes
-- Source : https://www.wowhead.com/wotlk/mx/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Pertrechos' WHERE `locale` = 'esMX' AND `entry` = 4896;
-- OLD name : Culebra de agua
-- Source : https://www.wowhead.com/wotlk/mx/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Mocasín' WHERE `locale` = 'esMX' AND `entry` = 4953;
-- OLD name : World Boar Trainer (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'esMX','PNJs',NULL);
-- OLD name : [PH] Barrera de dolor mogu (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5027
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5027;
-- OLD name : Instructora mundial de cartografía (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5035
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWorld Cartography Trainer' WHERE `locale` = 'esMX' AND `entry` = 5035;
-- OLD name : Alborotador
-- Source : https://www.wowhead.com/wotlk/mx/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Alborotador Defias' WHERE `locale` = 'esMX' AND `entry` = 5043;
-- OLD subname : Diseñadora de tabardos de hermandad (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5047
UPDATE `creature_template_locale` SET `Title` = 'Diseñadora de tabardos' WHERE `locale` = 'esMX' AND `entry` = 5047;
-- OLD name : Pagador Lendry
-- Source : https://www.wowhead.com/wotlk/mx/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Secretario Lendry' WHERE `locale` = 'esMX' AND `entry` = 5083;
-- OLD name : Dolkin Yelmorrisco
-- Source : https://www.wowhead.com/wotlk/mx/npc=5125
UPDATE `creature_template_locale` SET `Name` = 'Dolkin Yelmorisco' WHERE `locale` = 'esMX' AND `entry` = 5125;
-- OLD name : Olthran Yelmorrisco
-- Source : https://www.wowhead.com/wotlk/mx/npc=5126
UPDATE `creature_template_locale` SET `Name` = 'Olthran Yelmorisco' WHERE `locale` = 'esMX' AND `entry` = 5126;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armaduras' WHERE `locale` = 'esMX' AND `entry` = 5164;
-- OLD name : Déspota Gordunni (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5231
UPDATE `creature_template_locale` SET `Name` = 'Agente Gordunni' WHERE `locale` = 'esMX' AND `entry` = 5231;
-- OLD name : depositario arbóreo Jademir (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=5319
UPDATE `creature_template_locale` SET `Name` = 'Depositario arbóreo Jademir' WHERE `locale` = 'esMX' AND `entry` = 5319;
-- OLD subname : Instructor de joyería y suministros
-- Source : https://www.wowhead.com/wotlk/mx/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Liga de Expedicionarios' WHERE `locale` = 'esMX' AND `entry` = 5388;
-- OLD name : Déspota Machacaduna (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5472
UPDATE `creature_template_locale` SET `Name` = 'Agente Machacaduna' WHERE `locale` = 'esMX' AND `entry` = 5472;
-- OLD subname : Instructora de brujos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5495
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 5495;
-- OLD subname : Instructor de brujos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5496
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 5496;
-- OLD subname : Instructor de druidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5504
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 5504;
-- OLD subname : Instructor de druidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5505
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 5505;
-- OLD subname : Instructor de druidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5506
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 5506;
-- OLD name : [UNUSED] Yuriv Adhem (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5544
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5544;
-- OLD name : [PH] Capataz de mina (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5548
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5548;
-- OLD name : [PH] Guardia de mina (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5549
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5549;
-- OLD name : [PH] Campesino JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5550
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5550;
-- OLD name : [PH] Guardia de caravana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5551
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5551;
-- OLD name : [PH] Peón JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5552
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5552;
-- OLD name : [PH] Explorador de caravana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5553
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5553;
-- OLD name : [PH] Fauna JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5554
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5554;
-- OLD name : [PH] Rocín de caravana ogra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5555
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5555;
-- OLD name : [PH] Comandante de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5556
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5556;
-- OLD name : [PH] Comandante de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5557
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5557;
-- OLD name : [PH] Guardia de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5558;
-- OLD name : [PH] Guardia de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5559;
-- OLD name : [PH] Asaltante de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5560
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5560;
-- OLD name : [PH] Asaltante de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5561
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5561;
-- OLD name : [PH] Arquero de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5562
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5562;
-- OLD name : [PH] Arquero de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5563
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5563;
-- OLD name : [PH] Capataz de mina de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5587
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5587;
-- OLD name : [PH] Guardia de mina de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5588;
-- OLD name : [PH] Capataz de mina de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5589;
-- OLD name : [PH] Guardia de mina de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5590
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5590;
-- OLD name : [UNUSED] [PH] Verbenero orco (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5604;
-- OLD name : [UNUSED] Lawrence Sierra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5671
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5671;
-- OLD name : [UNUSED] Charles Brewton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5672
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5672;
-- OLD name : [UNUSED] Mortacechador Vincent DEBUG (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5678
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5678;
-- OLD name : Comar Villardo
-- Source : https://www.wowhead.com/wotlk/mx/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Corma Villardo' WHERE `locale` = 'esMX' AND `entry` = 5683;
-- OLD name : Sumo hechicero Andromath (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=5694
UPDATE `creature_template_locale` SET `Name` = 'Sumo Hechicero Andromath' WHERE `locale` = 'esMX' AND `entry` = 5694;
-- OLD subname : Esclava mental de Gerard
-- Source : https://www.wowhead.com/wotlk/mx/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Experimento de Gerard' WHERE `locale` = 'esMX' AND `entry` = 5697;
-- OLD name : Déspota Emilgund (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5787
UPDATE `creature_template_locale` SET `Name` = 'Agente Emilgund' WHERE `locale` = 'esMX' AND `entry` = 5787;
-- OLD name : [PH] Robot de grupo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5801;
-- OLD name : Tótem Nova de Fuego (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5879
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego' WHERE `locale` = 'esMX' AND `entry` = 5879;
-- OLD name : [UNUSED] Hurll Kans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=5904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 5904;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=5939
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 5939;
-- OLD name : Escarbador Alimentavil
-- Source : https://www.wowhead.com/wotlk/mx/npc=5983
UPDATE `creature_template_locale` SET `Name` = 'Escarbador' WHERE `locale` = 'esMX' AND `entry` = 5983;
-- OLD name : Ritualista Sombra Jurada
-- Source : https://www.wowhead.com/wotlk/mx/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Cultor Sombra Jurada' WHERE `locale` = 'esMX' AND `entry` = 6004;
-- OLD name : Déspota Sombra Jurada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6007
UPDATE `creature_template_locale` SET `Name` = 'Agente jurasombras' WHERE `locale` = 'esMX' AND `entry` = 6007;
-- OLD name : Brujo Sombra Jurada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6008
UPDATE `creature_template_locale` SET `Name` = 'Brujo jurasombras' WHERE `locale` = 'esMX' AND `entry` = 6008;
-- OLD name : Tejetinieblas Sombra Jurada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6009
UPDATE `creature_template_locale` SET `Name` = 'Tejetinieblas jurasombras' WHERE `locale` = 'esMX' AND `entry` = 6009;
-- OLD name : Tótem Lengua de Fuego II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6012
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Lengua de Fuego II' WHERE `locale` = 'esMX' AND `entry` = 6012;
-- OLD name : [UNUSED] Gozwin Dentovil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=6046
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 6046;
-- OLD name : [UNUSED] Meritt Herrion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=6067
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 6067;
-- OLD subname : Vendedora de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6091
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 6091;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6094
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 6094;
-- OLD name : Tótem Nova de Fuego II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6110
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego II' WHERE `locale` = 'esMX' AND `entry` = 6110;
-- OLD name : Tótem Nova de Fuego III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6111
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego III' WHERE `locale` = 'esMX' AND `entry` = 6111;
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 6183;
-- OLD name : Fantasma mortificador
-- Source : https://www.wowhead.com/wotlk/mx/npc=6427
UPDATE `creature_template_locale` SET `Name` = 'Fantasma encantado' WHERE `locale` = 'esMX' AND `entry` = 6427;
-- OLD subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6566
UPDATE `creature_template_locale` SET `Title` = '"Conservador" de reliquias' WHERE `locale` = 'esMX' AND `entry` = 6566;
-- OLD name : Forma felina (elfo de la noche druida) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6571
UPDATE `creature_template_locale` SET `Name` = 'Forma felina' WHERE `locale` = 'esMX' AND `entry` = 6571;
-- OLD name : Forma felina (tauren druida) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6572
UPDATE `creature_template_locale` SET `Name` = 'Forma felina' WHERE `locale` = 'esMX' AND `entry` = 6572;
-- OLD name : Brienna Brillastrella
-- Source : https://www.wowhead.com/wotlk/mx/npc=6576
UPDATE `creature_template_locale` SET `Name` = 'Brienna Brillaestrella' WHERE `locale` = 'esMX' AND `entry` = 6576;
-- OLD name : Campesino (bosque) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6578
UPDATE `creature_template_locale` SET `Name` = 'Campesino (madera)' WHERE `locale` = 'esMX' AND `entry` = 6578;
-- OLD name : "Desplumado" Johnson
-- Source : https://www.wowhead.com/wotlk/mx/npc=6626
UPDATE `creature_template_locale` SET `Name` = 'Johnson el "Desplumado"' WHERE `locale` = 'esMX' AND `entry` = 6626;
-- OLD name : "Desplumado" Forma humana de Johnson (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6666
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 6666;
-- OLD name : [UNUSED] Lorek Belm (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM' WHERE `locale` = 'esMX' AND `entry` = 6783;
-- OLD name : Cangrejo de playa
-- Source : https://www.wowhead.com/wotlk/mx/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Cangrejo' WHERE `locale` = 'esMX' AND `entry` = 6827;
-- OLD name : Maestro de embarcadero
-- Source : https://www.wowhead.com/wotlk/mx/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Maestro de embarcadero Defias' WHERE `locale` = 'esMX' AND `entry` = 6846;
-- OLD name : Trabajador de embarcadero
-- Source : https://www.wowhead.com/wotlk/mx/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Trabajador de embarcadero Defias' WHERE `locale` = 'esMX' AND `entry` = 6927;
-- OLD name : Comandante Kartak Profanenanos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7014
UPDATE `creature_template_locale` SET `Name` = 'Comandante Marzuk Machacaenanos' WHERE `locale` = 'esMX' AND `entry` = 7014;
-- OLD name : Lechuza Picoférreo
-- Source : https://www.wowhead.com/wotlk/mx/npc=7097
UPDATE `creature_template_locale` SET `Name` = 'Lechuza Cortezaférrea' WHERE `locale` = 'esMX' AND `entry` = 7097;
-- OLD name : Déspota Jaedenar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7114
UPDATE `creature_template_locale` SET `Name` = 'Agente Jaedenar' WHERE `locale` = 'esMX' AND `entry` = 7114;
-- OLD name : Emboscador Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7175
UPDATE `creature_template_locale` SET `Name` = 'Emboscador grutacanto' WHERE `locale` = 'esMX' AND `entry` = 7175;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7230
UPDATE `creature_template_locale` SET `Title` = 'Forjadora de armaduras' WHERE `locale` = 'esMX' AND `entry` = 7230;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Artesano de armas' WHERE `locale` = 'esMX' AND `entry` = 7231;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7232
UPDATE `creature_template_locale` SET `Title` = 'Artesano de armas' WHERE `locale` = 'esMX' AND `entry` = 7232;
-- OLD name : [UNUSED] Drayl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=7293
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 7293;
-- OLD name : Aplastador Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7320
UPDATE `creature_template_locale` SET `Name` = 'Aplastador grutacanto' WHERE `locale` = 'esMX' AND `entry` = 7320;
-- OLD name : Tejedor de fuego Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7321
UPDATE `creature_template_locale` SET `Name` = 'Tejedor de fuego grutacanto' WHERE `locale` = 'esMX' AND `entry` = 7321;
-- OLD name : Déspota Vientomuerto (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7373
UPDATE `creature_template_locale` SET `Name` = 'Agente Vientomuerto' WHERE `locale` = 'esMX' AND `entry` = 7373;
-- OLD name : Curiana de Entrañas
-- Source : https://www.wowhead.com/wotlk/mx/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha' WHERE `locale` = 'esMX' AND `entry` = 7395;
-- OLD name : Rompepedras terráneo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7396
UPDATE `creature_template_locale` SET `Name` = 'Rompepiedras terráneo' WHERE `locale` = 'esMX' AND `entry` = 7396;
-- OLD name : Tótem Garra de piedra V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7398
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Garra de piedra V' WHERE `locale` = 'esMX' AND `entry` = 7398;
-- OLD name : Guardia de las llamas Galak
-- Source : https://www.wowhead.com/wotlk/mx/npc=7404
UPDATE `creature_template_locale` SET `Name` = 'Guardia Flama Galak' WHERE `locale` = 'esMX' AND `entry` = 7404;
-- OLD name : Tótem de resistencia a la escarcha II (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=7412
UPDATE `creature_template_locale` SET `Name` = 'Tótem de resistencia a la Escarcha II' WHERE `locale` = 'esMX' AND `entry` = 7412;
-- OLD name : Tótem de resistencia a la escarcha III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7413
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la escarcha III' WHERE `locale` = 'esMX' AND `entry` = 7413;
-- OLD name : Tótem Lengua de Fuego III (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=7423
UPDATE `creature_template_locale` SET `Name` = 'Tótem Lengua de fuego III' WHERE `locale` = 'esMX' AND `entry` = 7423;
-- OLD name : Tótem de resistencia al fuego II (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=7424
UPDATE `creature_template_locale` SET `Name` = 'Tótem de resistencia al Fuego II' WHERE `locale` = 'esMX' AND `entry` = 7424;
-- OLD name : Tótem de resistencia al fuego III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7425
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia al fuego III' WHERE `locale` = 'esMX' AND `entry` = 7425;
-- OLD name : Tótem de resistencia a la Naturaleza II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7468
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la Naturaleza II' WHERE `locale` = 'esMX' AND `entry` = 7468;
-- OLD name : Tótem de resistencia a la Naturaleza III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7469
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la Naturaleza III' WHERE `locale` = 'esMX' AND `entry` = 7469;
-- OLD name : Tótem Viento furioso II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7483
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindfury Totem II' WHERE `locale` = 'esMX' AND `entry` = 7483;
-- OLD name : Tótem Viento furioso III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7484
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindfury Totem III' WHERE `locale` = 'esMX' AND `entry` = 7484;
-- OLD name : Tótem Gracia del Aire (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7486
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Gracia del Aire' WHERE `locale` = 'esMX' AND `entry` = 7486;
-- OLD name : Tótem Gracia del Aire II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7487
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Gracia del Aire II' WHERE `locale` = 'esMX' AND `entry` = 7487;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/mx/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'esMX','Conejo cola de algodón',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/mx/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'esMX','Conejo moteado',NULL);
-- OLD name : Byula, subname : Antiguo tabernero
-- Source : https://www.wowhead.com/wotlk/mx/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Tabernero Byula',`Title` = 'Tabernero' WHERE `locale` = 'esMX' AND `entry` = 7714;
-- OLD name : Forajido Vagayermo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7805
UPDATE `creature_template_locale` SET `Name` = 'Forajido Vagayermos' WHERE `locale` = 'esMX' AND `entry` = 7805;
-- OLD name : Tótem Nova de Fuego IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7844
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego IV' WHERE `locale` = 'esMX' AND `entry` = 7844;
-- OLD name : Tótem Nova de Fuego V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=7845
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego V' WHERE `locale` = 'esMX' AND `entry` = 7845;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7868
UPDATE `creature_template_locale` SET `Title` = 'Peletera elemental maestra' WHERE `locale` = 'esMX' AND `entry` = 7868;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7869
UPDATE `creature_template_locale` SET `Title` = 'Peletero elemental maestro' WHERE `locale` = 'esMX' AND `entry` = 7869;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Instructora de peletería tribal' WHERE `locale` = 'esMX' AND `entry` = 7870;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Peletero tribal maestro' WHERE `locale` = 'esMX' AND `entry` = 7871;
-- OLD subname : Instructor de equitación
-- Source : https://www.wowhead.com/wotlk/mx/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Piloto de mecazancudo' WHERE `locale` = 'esMX' AND `entry` = 7954;
-- OLD name : Guardia de Los Baldíos
-- Source : https://www.wowhead.com/wotlk/mx/npc=8016
UPDATE `creature_template_locale` SET `Name` = 'Guarda de Los Baldíos' WHERE `locale` = 'esMX' AND `entry` = 8016;
-- OLD name : Guardia de la Brigada de los Páramos de Poniente, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/mx/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Protector del pueblo',`Title` = 'La Milicia Popular' WHERE `locale` = 'esMX' AND `entry` = 8096;
-- OLD name : Kalaran Espada del Viento
-- Source : https://www.wowhead.com/wotlk/mx/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Velarok Espada del Viento' WHERE `locale` = 'esMX' AND `entry` = 8479;
-- OLD name : Kalaran el Falsario (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Velarok, el Falsario' WHERE `locale` = 'esMX' AND `entry` = 8480;
-- OLD name : Caminasol Saern
-- Source : https://www.wowhead.com/wotlk/mx/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Saern Correorgullo' WHERE `locale` = 'esMX' AND `entry` = 8664;
-- OLD name : Ensamblaje belisario (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=8905
UPDATE `creature_template_locale` SET `Name` = 'Ensamblaje Belisario' WHERE `locale` = 'esMX' AND `entry` = 8905;
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9557;
-- OLD name : [UNUSED] Gorilla Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9577
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9577;
-- OLD name : [UNUSED] Eyan Mulcom (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9617;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9686;
-- OLD name : Tótem Muro de viento (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=9687
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindwall Totem' WHERE `locale` = 'esMX' AND `entry` = 9687;
-- OLD name : Tótem Muro de viento II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=9688
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindwall Totem II' WHERE `locale` = 'esMX' AND `entry` = 9688;
-- OLD name : Tótem Muro de viento III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=9689
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindwall Totem III' WHERE `locale` = 'esMX' AND `entry` = 9689;
-- OLD name : [UNUSED] Grurk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9702
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9702;
-- OLD name : [UNUSED] Il'thurk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9703
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9703;
-- OLD name : [UNUSED] Lumurk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9704
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9704;
-- OLD name : Duende flamante
-- Source : https://www.wowhead.com/wotlk/mx/npc=9777
UPDATE `creature_template_locale` SET `Name` = 'Duente flamante' WHERE `locale` = 'esMX' AND `entry` = 9777;
-- OLD name : [UNUSED] [PH] Sirviente del queso Floh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 9820;
-- OLD subname : Antiguo maestro de establos
-- Source : https://www.wowhead.com/wotlk/mx/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Maestro de establos' WHERE `locale` = 'esMX' AND `entry` = 9983;
-- OLD name : [PH] Alex's Raid Testing Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10044;
-- OLD name : Acride
-- Source : https://www.wowhead.com/wotlk/mx/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Infiltrado del Escudo del Estigma' WHERE `locale` = 'esMX' AND `entry` = 10299;
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10370;
-- OLD name : [UNUSED] Guerrero Guardia Negra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10395
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10395;
-- OLD name : [UNUSED] Verdugo Guardia Negra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10397
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10397;
-- OLD name : [UNUSED] Señor de las Sombras Thuzadin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10401;
-- OLD name : [UNUSED] Wight el Caníbal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10402;
-- OLD name : [UNUSED] Ente devorador (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10403;
-- OLD name : [UNUSED] Elliott Jacks (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10446
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10446;
-- OLD name : [UNUSED] Paul Burges (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10450
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10450;
-- OLD name : Tótem Lengua de Fuego IV (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=10557
UPDATE `creature_template_locale` SET `Name` = 'Tótem Lengua de fuego IV' WHERE `locale` = 'esMX' AND `entry` = 10557;
-- OLD name : Arikara joven (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=10581
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 10581;
-- OLD name : Déspota Urok (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=10601
UPDATE `creature_template_locale` SET `Name` = 'Agente Urok' WHERE `locale` = 'esMX' AND `entry` = 10601;
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10607;
-- OLD name : Finkle Einhorn (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Pip Perspicaz' WHERE `locale` = 'esMX' AND `entry` = 10776;
-- OLD name : [UNUSED] Hija de Majestis (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 10810;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=10839
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 10839;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=10840
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 10840;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=10857
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 10857;
-- OLD name : Discípulo de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=10949
UPDATE `creature_template_locale` SET `Name` = 'Discípulo de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 10949;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11034;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11036;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11039;
-- OLD name : Fras Siabi (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'esMX' AND `entry` = 11058;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11063;
-- OLD name : [PH[ Probador de combate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11080;
-- OLD name : Tótem Marea de maná II (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11100
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Marea de maná II' WHERE `locale` = 'esMX' AND `entry` = 11100;
-- OLD name : Tótem Marea de maná III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11101
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Marea de maná III' WHERE `locale` = 'esMX' AND `entry` = 11101;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11102
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11102;
-- OLD name : Alma inquieta (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11122
UPDATE `creature_template_locale` SET `Name` = 'Alma sin descanso' WHERE `locale` = 'esMX' AND `entry` = 11122;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Artesano de armas especiales' WHERE `locale` = 'esMX' AND `entry` = 11146;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armaduras' WHERE `locale` = 'esMX' AND `entry` = 11177;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=11178
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armas' WHERE `locale` = 'esMX' AND `entry` = 11178;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11194
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11194;
-- OLD name : Déspota Hoja Abrasadora (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11323
UPDATE `creature_template_locale` SET `Name` = 'Agente Hoja Abrasadora' WHERE `locale` = 'esMX' AND `entry` = 11323;
-- OLD name : [UNUSED] Rabioso Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11341;
-- OLD name : [UNUSED] Hija de Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11358
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11358;
-- OLD name : Cachorro Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11360
UPDATE `creature_template_locale` SET `Name` = 'Cachorro zulian' WHERE `locale` = 'esMX' AND `entry` = 11360;
-- OLD name : [UNUSED] Tigresa Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11364
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 11364;
-- OLD name : Pantera Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11365
UPDATE `creature_template_locale` SET `Name` = 'Pantera zulian' WHERE `locale` = 'esMX' AND `entry` = 11365;
-- OLD name : [UNUSED] Matriarca Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11366
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 11366;
-- OLD name : [UNUSED] Patriarca Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11367
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 11367;
-- OLD name : [UNUSED] buscasangre Oculto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11369
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11369;
-- OLD name : [UNUSED] Zath (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11375
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11375;
-- OLD name : [UNUSED] Lor'khan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11376
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11376;
-- OLD name : [UNUSED] Hak'tharr el Cazamentes (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11377
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11377;
-- OLD name : [UNUSED] Nik'reesh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11379
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11379;
-- OLD name : [UNUSED] T'kashra viejo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11384
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11384;
-- OLD name : [UNUSED] Mogwhi el Implacable (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11385
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11385;
-- OLD name : [UNUSED] Janook el Furiafilada (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11386
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11386;
-- OLD subname : Instructora de sacerdotes (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11397
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 11397;
-- OLD name : Déspota Gordok (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11440
UPDATE `creature_template_locale` SET `Name` = 'Agente Gordok' WHERE `locale` = 'esMX' AND `entry` = 11440;
-- OLD name : [UNUSED] Mago de Batalla Gordok (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11449
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11449;
-- OLD name : [UNUSED] Escarbador Tuercemadera (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11463
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11463;
-- OLD name : [UNUSED] Eldreth Exanimato (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11468
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11468;
-- OLD name : [UNUSED] Bestia de maná (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11478
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11478;
-- OLD name : [UNUSED] Horror Arcano (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11479
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11479;
-- OLD name : [UNUSED] Terror Arcano (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11481
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11481;
-- OLD name : [UNUSED] Sentius (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11493
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11493;
-- OLD name : [UNUSED] Avidus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11495
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11495;
-- OLD name : [UNUSED] Comandante Gormaul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11499
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11499;
-- OLD name : [UNUSED] Majordomo Bagrosh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11500
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11500;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=11536
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 11536;
-- OLD name : [UNUSED] Coloso fundido (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11660;
-- OLD name : [UNUSED] Escupefuego (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11670;
-- OLD name : Can del Núcleo
-- Source : https://www.wowhead.com/wotlk/mx/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Can del Núcleo anciano' WHERE `locale` = 'esMX' AND `entry` = 11673;
-- OLD subname : Maestra de Armas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=11866
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 11866;
-- OLD name : [PH] Dispensador de regalos de Villanorte (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11926;
-- OLD name : [UNUSED] Vigía obsidiano (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11959
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11959;
-- OLD name : [NOT USED] Neltharion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=11978
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 11978;
-- OLD subname : Mercader de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=12019
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 12019;
-- OLD name : Instructor de alquimia de Claro de la Luna (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=12020
UPDATE `creature_template_locale` SET `Name` = 'Alquimista de Claro de la Luna' WHERE `locale` = 'esMX' AND `entry` = 12020;
-- OLD subname : Mercader de alimentos y bebidas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=12026
UPDATE `creature_template_locale` SET `Title` = 'Comida y bebida' WHERE `locale` = 'esMX' AND `entry` = 12026;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=12126
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 12126;
-- OLD name : Raptor de montar de esmeralda
-- Source : https://www.wowhead.com/wotlk/mx/npc=12346
UPDATE `creature_template_locale` SET `Name` = 'Raptor de montar esmeralda' WHERE `locale` = 'esMX' AND `entry` = 12346;
-- OLD name : Raptor de turquesa de montar
-- Source : https://www.wowhead.com/wotlk/mx/npc=12349
UPDATE `creature_template_locale` SET `Name` = 'Raptor turquesa de montar' WHERE `locale` = 'esMX' AND `entry` = 12349;
-- OLD name : [NOT USED] cría Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12417
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12417;
-- OLD name : [NOT USED] Señor de la guerra Alanegra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12462
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12462;
-- OLD name : [NOT USED] Horrocrusto Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12466
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12466;
-- OLD name : [NOT USED] Sacudetierra Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12469
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12469;
-- OLD name : [NOT USED] Lenguaflama Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12470;
-- OLD name : [PH] TEST Dios de fuego (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=12804
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 12804;
-- OLD name : Espíritu de redención (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=12904
UPDATE `creature_template_locale` SET `Name` = 'Espíritu redentor' WHERE `locale` = 'esMX' AND `entry` = 12904;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Cirujano del dispensario' WHERE `locale` = 'esMX' AND `entry` = 12939;
-- OLD subname : Maestra de Armas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Maestra de armas' WHERE `locale` = 'esMX' AND `entry` = 13084;
-- OLD name : Comandante Dardosh <old> (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=13140
UPDATE `creature_template_locale` SET `Name` = 'Comandante Dardosh' WHERE `locale` = 'esMX' AND `entry` = 13140;
-- OLD name : Teniente Murp <old> (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=13146
UPDATE `creature_template_locale` SET `Name` = 'Teniente Murp' WHERE `locale` = 'esMX' AND `entry` = 13146;
-- OLD name : Rana pequeña
-- Source : https://www.wowhead.com/wotlk/mx/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Rana' WHERE `locale` = 'esMX' AND `entry` = 13321;
-- OLD name : Grinch el Abominable (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=13602
UPDATE `creature_template_locale` SET `Name` = 'Rancun Pelele' WHERE `locale` = 'esMX' AND `entry` = 13602;
-- OLD name : Lobo Gélido de establo (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=13618
UPDATE `creature_template_locale` SET `Name` = 'Lobo gélido de establo' WHERE `locale` = 'esMX' AND `entry` = 13618;
-- OLD name : [PH] Heraldo del cementerio (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14181
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14181;
-- OLD name : [UNUSED] Sid Stuco (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14201
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14201;
-- OLD name : Príncipe Truenoraan (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14435
UPDATE `creature_template_locale` SET `Name` = 'Príncipe Thunderaan' WHERE `locale` = 'esMX' AND `entry` = 14435;
-- OLD name : Ayudante de cámara Pilaprieta (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14636
UPDATE `creature_template_locale` SET `Name` = 'Almohadestro Hierro Negro' WHERE `locale` = 'esMX' AND `entry` = 14636;
-- OLD name : [PH] Taumaturgo de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14641;
-- OLD name : [PH] Taumaturgo de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14642;
-- OLD name : [PH] Heraldo de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14643;
-- OLD name : [PH] Heraldo de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14644;
-- OLD name : [PH] Lugarteniente de torre de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14719
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14719;
-- OLD name : Mariscal de campo Afrasiabi
-- Source : https://www.wowhead.com/wotlk/mx/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Mariscal de campo Petraponte' WHERE `locale` = 'esMX' AND `entry` = 14721;
-- OLD name : Bandera de prueba de Ggoodman (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14735
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 14735;
-- OLD name : Aullador Lobo Gélido (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14744
UPDATE `creature_template_locale` SET `Name` = 'Aullador lobo gélido' WHERE `locale` = 'esMX' AND `entry` = 14744;
-- OLD name : [PH] Lugarteniente de torre de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=14746
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 14746;
-- OLD subname : Recuerdos y juguetes
-- Source : https://www.wowhead.com/wotlk/mx/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Canje de vales de la Feria de la Luna Negra' WHERE `locale` = 'esMX' AND `entry` = 14828;
-- OLD name : Muñeco-diana Guerrero 60 invencible (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14830
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Warrior' WHERE `locale` = 'esMX' AND `entry` = 14830;
-- OLD subname : Vendedora de bebidas
-- Source : https://www.wowhead.com/wotlk/mx/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Vendedora de bebidas de la Feria de la Luna Negra' WHERE `locale` = 'esMX' AND `entry` = 14844;
-- OLD subname : Vendedor de alimentos
-- Source : https://www.wowhead.com/wotlk/mx/npc=14845
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de alimentos de la Feria de la Luna Negra' WHERE `locale` = 'esMX' AND `entry` = 14845;
-- OLD subname : Premios de mascotas y monturas
-- Source : https://www.wowhead.com/wotlk/mx/npc=14846
UPDATE `creature_template_locale` SET `Title` = 'Objetos exóticos de la Feria de la Luna Negra' WHERE `locale` = 'esMX' AND `entry` = 14846;
-- OLD subname : Cartas de la Luna Negra
-- Source : https://www.wowhead.com/wotlk/mx/npc=14847
UPDATE `creature_template_locale` SET `Title` = 'Cartas de la Feria de la Luna Negra y objetos exóticos' WHERE `locale` = 'esMX' AND `entry` = 14847;
-- OLD name : Feriante de la Luna Negra
-- Source : https://www.wowhead.com/wotlk/mx/npc=14849
UPDATE `creature_template_locale` SET `Name` = 'Feriante de la Feria de la Luna Negra' WHERE `locale` = 'esMX' AND `entry` = 14849;
-- OLD name : Déspota Zandalar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=14911
UPDATE `creature_template_locale` SET `Name` = 'Agente Zandalar' WHERE `locale` = 'esMX' AND `entry` = 14911;
-- OLD name : Acechador Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15067
UPDATE `creature_template_locale` SET `Name` = 'Acechador zulian' WHERE `locale` = 'esMX' AND `entry` = 15067;
-- OLD name : Guardián Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15068
UPDATE `creature_template_locale` SET `Name` = 'Guardián zulian' WHERE `locale` = 'esMX' AND `entry` = 15068;
-- OLD name : Merodeador Zulian (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15101
UPDATE `creature_template_locale` SET `Name` = 'Merodeador zulian' WHERE `locale` = 'esMX' AND `entry` = 15101;
-- OLD name : Tigre Zulian presto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15104
UPDATE `creature_template_locale` SET `Name` = 'Tigre zulian presto' WHERE `locale` = 'esMX' AND `entry` = 15104;
-- OLD name : Enviado Grito de Guerra
-- Source : https://www.wowhead.com/wotlk/mx/npc=15105
UPDATE `creature_template_locale` SET `Name` = 'Emisario Grito de Guerra' WHERE `locale` = 'esMX' AND `entry` = 15105;
-- OLD name : Enviado Lobo Gélido
-- Source : https://www.wowhead.com/wotlk/mx/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Emisaria Lobo Gélido' WHERE `locale` = 'esMX' AND `entry` = 15106;
-- OLD name : Luis Barriga (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15166
UPDATE `creature_template_locale` SET `Name` = 'Wayneth Antonius' WHERE `locale` = 'esMX' AND `entry` = 15166;
-- OLD name : [PH] Luis Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15167
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15167;
-- OLD name : Alto mariscal Eje Torbellino (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15204
UPDATE `creature_template_locale` SET `Name` = 'Alto mariscal Whirlaxis' WHERE `locale` = 'esMX' AND `entry` = 15204;
-- OLD name : [UNUSED] Constructor Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15226
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15226;
-- OLD name : [UNUSED] Moldador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15227
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15227;
-- OLD name : [UNUSED] Cavaguas Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15228
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15228;
-- OLD name : [UNUSED] Patrulla Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15231
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15231;
-- OLD name : [UNUSED] Erradicador Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15232
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15232;
-- OLD name : [UNUSED] Enjambrista Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15234
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15234;
-- OLD name : [UNUSED] Picaira Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15237
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15237;
-- OLD name : [UNUSED] Atracador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15238
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15238;
-- OLD name : [UNUSED] Rondador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15239
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15239;
-- OLD name : [UNUSED] Infrargullo Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15243
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15243;
-- OLD name : [UNUSED] Asaltante de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15244
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15244;
-- OLD name : [UNUSED] Guardavispa Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15245
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15245;
-- OLD name : [UNUSED] Doblegador de almas qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15248
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15248;
-- OLD name : [UNUSED] Asesino qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15251
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15251;
-- OLD name : [UNUSED] Campeón qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15253
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15253;
-- OLD name : [UNUSED] Capitán qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15254
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15254;
-- OLD name : [UNUSED] Oficial qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15255
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15255;
-- OLD name : [UNUSED] Comandante qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15256
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15256;
-- OLD name : [UNUSED] Guardia de Honor qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15257
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15257;
-- OLD name : [UNUSED] Pretoriano qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15258
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15258;
-- OLD name : [UNUSED] Emperador qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15259
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15259;
-- OLD name : Acechacaminos Kariel
-- Source : https://www.wowhead.com/wotlk/mx/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Acechacaminos Avokor' WHERE `locale` = 'esMX' AND `entry` = 15285;
-- OLD name : [UNUSED] Emboscador Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15322
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15322;
-- OLD name : [UNUSED] Enjambrista Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15326
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15326;
-- OLD name : [UNUSED] Explorador Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15329
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15329;
-- OLD name : [UNUSED] Cavarenas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15330
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15330;
-- OLD name : [UNUSED] Tunelador de las Dunas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15331
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15331;
-- OLD name : [UNUSED] Comecristales (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15332
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15332;
-- OLD name : [UNUSED] Moldearena (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15337
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15337;
-- OLD name : [UNUSED] Esfinge (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15342
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15342;
-- OLD name : [UNUSED] Hija de Hecate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15345
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15345;
-- OLD name : [UNUSED] Infrargullo qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15346
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15346;
-- OLD name : [UNUSED] Avispón qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15347
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15347;
-- OLD name : Capitana Pirata de Halloween (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15375
UPDATE `creature_template_locale` SET `Name` = 'Pirata de Halloween' WHERE `locale` = 'esMX' AND `entry` = 15375;
-- OLD name : [UNUSED] Ruinas del Gladiador qiraji nombrado 7 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15393
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15393;
-- OLD name : Tótem Gracia del Aire III (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15463
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Gracia del Aire III' WHERE `locale` = 'esMX' AND `entry` = 15463;
-- OLD name : Tótem Fuerza de la tierra V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15464
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Fuerza de la tierra V' WHERE `locale` = 'esMX' AND `entry` = 15464;
-- OLD name : Tótem Piel de piedra VII (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=15470
UPDATE `creature_template_locale` SET `Name` = 'Tótem piel de piedra VII' WHERE `locale` = 'esMX' AND `entry` = 15470;
-- OLD name : [UNUSED] Mocohondo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15472
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15472;
-- OLD name : Tótem Piel de piedra VIII (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=15474
UPDATE `creature_template_locale` SET `Name` = 'Tótem piel de piedra VIII' WHERE `locale` = 'esMX' AND `entry` = 15474;
-- OLD name : Escórpido
-- Source : https://www.wowhead.com/wotlk/mx/npc=15476
UPDATE `creature_template_locale` SET `Name` = 'Escorpión' WHERE `locale` = 'esMX' AND `entry` = 15476;
-- OLD name : Tótem Nova de Fuego VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15482
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego VI' WHERE `locale` = 'esMX' AND `entry` = 15482;
-- OLD name : Tótem Nova de Fuego
-- Source : https://www.wowhead.com/wotlk/mx/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Tótem Nova de Fuego VII' WHERE `locale` = 'esMX' AND `entry` = 15483;
-- OLD name : Tótem de resistencia a la escarcha IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15486
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la escarcha IV' WHERE `locale` = 'esMX' AND `entry` = 15486;
-- OLD name : Tótem de resistencia al fuego IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15487
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia al fuego IV' WHERE `locale` = 'esMX' AND `entry` = 15487;
-- OLD name : Tótem de resistencia a la Naturaleza IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15490
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la Naturaleza IV' WHERE `locale` = 'esMX' AND `entry` = 15490;
-- OLD name :  Tótem Muro de viento IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15492
UPDATE `creature_template_locale` SET `Name` = 'zzOLD Tótem Muro de viento IV' WHERE `locale` = 'esMX' AND `entry` = 15492;
-- OLD name : Tótem Viento furioso IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15496
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindfury Totem IV' WHERE `locale` = 'esMX' AND `entry` = 15496;
-- OLD name : Tótem Viento furioso V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15497
UPDATE `creature_template_locale` SET `Name` = 'zzOLDWindfury Totem V' WHERE `locale` = 'esMX' AND `entry` = 15497;
-- OLD name : Déspota Arcano (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15640
UPDATE `creature_template_locale` SET `Name` = 'Agente Arcano' WHERE `locale` = 'esMX' AND `entry` = 15640;
-- OLD name : [Unused] Mana Leech (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15646
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15646;
-- OLD name : [Unused] Auctioneer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15672
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15672;
-- OLD name : Blue Qiraji Battle Tank (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'esMX','PNJs',NULL);
-- OLD name : Alto comandante Lynore Ventostryke (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15866
UPDATE `creature_template_locale` SET `Name` = 'Alta comandante Lynore Ventostryke' WHERE `locale` = 'esMX' AND `entry` = 15866;
-- OLD name : Avispón Colmen'Zara (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15934
UPDATE `creature_template_locale` SET `Name` = 'Zumbador Colmen''Zara' WHERE `locale` = 'esMX' AND `entry` = 15934;
-- OLD name : Guardés Wyllithen
-- Source : https://www.wowhead.com/wotlk/mx/npc=15969
UPDATE `creature_template_locale` SET `Name` = 'Encargado Wyllithen' WHERE `locale` = 'esMX' AND `entry` = 15969;
-- OLD name : [PH] Juerguista San Valentín, hombre (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15982
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15982;
-- OLD name : [PH] Juerguista de San Valentín, mujer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=15983
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15983;
-- OLD name : Sam's Test Dummy 1 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15992
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15992;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15992, 'esMX','PNJs',NULL);
-- OLD name : Sam's Test Dummy 2 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15993
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15993;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15993, 'esMX','PNJs',NULL);
-- OLD name : Sam's Test Dummy 1 (1) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15996
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15996;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15996, 'esMX','PNJs',NULL);
-- OLD name : Sam's Test Dummy 2 (1) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15997
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15997;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15997, 'esMX','PNJs',NULL);
-- OLD name : Sam's Test Dummy 1 (2) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15998
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15998;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15998, 'esMX','PNJs',NULL);
-- OLD name : Sam's Test Dummy 2 (2) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=15999
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 15999;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15999, 'esMX','PNJs',NULL);
-- OLD name : [UNUSED] Bog Beast B [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16035
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16035;
-- OLD name : [UNUSED] Deathhound (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16038
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16038;
-- OLD name : [PH] Alex's Test DPS Mob (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16077
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16077;
-- OLD name : Comandante de Cruzada Korfax
-- Source : https://www.wowhead.com/wotlk/mx/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Campeón de la Luz' WHERE `locale` = 'esMX' AND `entry` = 16112;
-- OLD name : Comandante de Cruzada Eligor Albar
-- Source : https://www.wowhead.com/wotlk/mx/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Comandante Eligor Albar' WHERE `locale` = 'esMX' AND `entry` = 16115;
-- OLD name : [UNUSED] Guardián de la Invasión de la Plaga (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16138
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16138;
-- OLD name : [UNUSED] Necópolis de Cristal, Contrafuerte (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16140
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16140;
-- OLD name : [UNUSED] Contrafuerte Arbotante (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16188
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16188;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/mx/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Instructora de pícaros' WHERE `locale` = 'esMX' AND `entry` = 16279;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/mx/npc=16378
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esMX' AND `entry` = 16378;
-- OLD name : [UNUSED] Death Knight Vindicator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16451
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16451;
-- OLD name : Concubina nocturna (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16460
UPDATE `creature_template_locale` SET `Name` = 'Dueña de la noche' WHERE `locale` = 'esMX' AND `entry` = 16460;
-- OLD name : Concubina (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Amante ferviente' WHERE `locale` = 'esMX' AND `entry` = 16461;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro herrero' WHERE `locale` = 'esMX' AND `entry` = 16583;
-- OLD name : Boticario Antonivich, subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=16588
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 16588;
-- OLD name : [PH] Goblin Savage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16608;
-- OLD subname : Maestra de Armas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=16621
UPDATE `creature_template_locale` SET `Title` = 'Maestra de armas' WHERE `locale` = 'esMX' AND `entry` = 16621;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esMX' AND `entry` = 16676;
-- OLD name : Espíritu de verano
-- Source : https://www.wowhead.com/wotlk/mx/npc=16701
UPDATE `creature_template_locale` SET `Name` = 'Espíritu del Verano' WHERE `locale` = 'esMX' AND `entry` = 16701;
-- OLD name : Eoch, subname : Subastador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16707
UPDATE `creature_template_locale` SET `Name` = 'Subastador Eoch',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 16707;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esMX' AND `entry` = 16719;
-- OLD subname : Maestro de armas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16773
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 16773;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro herrero' WHERE `locale` = 'esMX' AND `entry` = 16823;
-- OLD name : [UNUSED] Death Lord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16861
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16861;
-- OLD name : Brujo Foso Sangrante (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16872
UPDATE `creature_template_locale` SET `Name` = 'Alajet' WHERE `locale` = 'esMX' AND `entry` = 16872;
-- OLD name : Taumaturgo umbrío Foso Sangrante (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16874
UPDATE `creature_template_locale` SET `Name` = 'Velonieve' WHERE `locale` = 'esMX' AND `entry` = 16874;
-- OLD name : Caníbal Mascahuesos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16875
UPDATE `creature_template_locale` SET `Name` = 'Picoabisal' WHERE `locale` = 'esMX' AND `entry` = 16875;
-- OLD name : Depellejador sangrevil (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16882
UPDATE `creature_template_locale` SET `Name` = 'Consola numérica' WHERE `locale` = 'esMX' AND `entry` = 16882;
-- OLD name : Hambriento sangrevil (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16883
UPDATE `creature_template_locale` SET `Name` = 'Montura de Silas' WHERE `locale` = 'esMX' AND `entry` = 16883;
-- OLD name : Atracador Mascahuesos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16908
UPDATE `creature_template_locale` SET `Name` = 'Arielle Azoterraudo' WHERE `locale` = 'esMX' AND `entry` = 16908;
-- OLD name : Salvaje Mascahuesos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16909
UPDATE `creature_template_locale` SET `Name` = 'Niko' WHERE `locale` = 'esMX' AND `entry` = 16909;
-- OLD name : [Unused] Marauding Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=16914
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 16914;
-- OLD name : Lobo de guerra Mascahuesos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16926
UPDATE `creature_template_locale` SET `Name` = 'Vívica Salvaestelar' WHERE `locale` = 'esMX' AND `entry` = 16926;
-- OLD name : Uñagrieta enfurecido (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=16930
UPDATE `creature_template_locale` SET `Name` = 'Rata gigante' WHERE `locale` = 'esMX' AND `entry` = 16930;
-- OLD name : [Unused] Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17001
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17001;
-- OLD name : Déspota del Consejo de la Sombra (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17023
UPDATE `creature_template_locale` SET `Name` = 'Agente del Consejo de la Sombra' WHERE `locale` = 'esMX' AND `entry` = 17023;
-- OLD name : Tótem Marea de maná IV (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17061
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Marea de maná IV' WHERE `locale` = 'esMX' AND `entry` = 17061;
-- OLD name : Concubine Transform Visual (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17065
UPDATE `creature_template_locale` SET `Name` = 'Zealous Paramour Transform Visual' WHERE `locale` = 'esMX' AND `entry` = 17065;
-- OLD name : Magistrix Elosai desdichada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17162
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 17162;
-- OLD subname : Caballero de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17233
UPDATE `creature_template_locale` SET `Title` = 'Caballero de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17233;
-- OLD name : [Unused] Tunneler Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17234
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17234;
-- OLD name : [PH] Heraldo de las Tierras de la Peste (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17239;
-- OLD name : Robot triturador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17299
UPDATE `creature_template_locale` SET `Name` = 'Robotito chocón' WHERE `locale` = 'esMX' AND `entry` = 17299;
-- OLD subname : Instructor de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17424
UPDATE `creature_template_locale` SET `Title` = 'Instructor de vendajes' WHERE `locale` = 'esMX' AND `entry` = 17424;
-- OLD name : [UNUSED] Shadowmoon Firestarter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17463
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17463;
-- OLD name : Samantha LeCraft (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17515, 'esMX','PNJs',NULL);
-- OLD name : Jinete de lobos Fuego Infernal
-- Source : https://www.wowhead.com/wotlk/mx/npc=17593
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 17593;
-- OLD name : [PH] Captain Obvious Jr. (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17597
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17597;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=17634
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 17634;
-- OLD name : Jessera de Mac'Aree (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17663
UPDATE `creature_template_locale` SET `Name` = 'Maatparm' WHERE `locale` = 'esMX' AND `entry` = 17663;
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17733, 'esMX','PNJs',NULL);
-- OLD name : [UNUSED] Lost Goblin [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17813
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17813;
-- OLD name : [UNUSED] Huargen enloquecido (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17823
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17823;
-- OLD name : [DND]Sunhawk Portal Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17886
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17886;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17910
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17910;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17911
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17911;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17912
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17912;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17913
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17913;
-- OLD subname : Orden de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=17914
UPDATE `creature_template_locale` SET `Title` = 'Orden de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 17914;
-- OLD name : [UNUSED] Coilfang Watcher [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=17939
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 17939;
-- OLD name : Grom Grito Infernal (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18076
UPDATE `creature_template_locale` SET `Name` = 'Grommash Grito Infernal' WHERE `locale` = 'esMX' AND `entry` = 18076;
-- OLD name : [UNUSED] Sethekk Magelord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18329
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18329;
-- OLD name : Fanin, subname : Subastador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18348
UPDATE `creature_template_locale` SET `Name` = 'Subastador Fanin',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 18348;
-- OLD name : Iressa, subname : Subastadora (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18349
UPDATE `creature_template_locale` SET `Name` = 'Subastadora Iressa',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 18349;
-- OLD name : [UNUSED] Dusty Skeleton [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18355;
-- OLD name : UNUSED Outland Wyvern Mount (Armored) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18366
UPDATE `creature_template_locale` SET `Name` = 'Sigilo de prueba' WHERE `locale` = 'esMX' AND `entry` = 18366;
-- OLD name : [UNUSED] Draenei Spirit [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18367
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18367;
-- OLD name : [UNUSED]Anchorite Lyteera (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge A' WHERE `locale` = 'esMX' AND `entry` = 18674;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de minería' WHERE `locale` = 'esMX' AND `entry` = 18747;
-- OLD subname : Instructor de herboristería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18748
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de herboristería' WHERE `locale` = 'esMX' AND `entry` = 18748;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra sastre' WHERE `locale` = 'esMX' AND `entry` = 18749;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18751
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de joyería' WHERE `locale` = 'esMX' AND `entry` = 18751;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 18752;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de encantamientos' WHERE `locale` = 'esMX' AND `entry` = 18753;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18754
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de peletería' WHERE `locale` = 'esMX' AND `entry` = 18754;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de desuello' WHERE `locale` = 'esMX' AND `entry` = 18755;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de peletería' WHERE `locale` = 'esMX' AND `entry` = 18771;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de sastrería' WHERE `locale` = 'esMX' AND `entry` = 18772;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de encantamientos' WHERE `locale` = 'esMX' AND `entry` = 18773;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de joyería' WHERE `locale` = 'esMX' AND `entry` = 18774;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 18775;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de herboristería' WHERE `locale` = 'esMX' AND `entry` = 18776;
-- OLD subname : Instructora de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de desuello' WHERE `locale` = 'esMX' AND `entry` = 18777;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/mx/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de minería' WHERE `locale` = 'esMX' AND `entry` = 18779;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de alquimia' WHERE `locale` = 'esMX' AND `entry` = 18802;
-- OLD name : Embajador Semprepino Frasaboo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18803
UPDATE `creature_template_locale` SET `Name` = 'Embajador Semprepino Olorg' WHERE `locale` = 'esMX' AND `entry` = 18803;
-- OLD subname : Instructor de pesca
-- Source : https://www.wowhead.com/wotlk/mx/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de pesca' WHERE `locale` = 'esMX' AND `entry` = 18911;
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18936;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 18941;
-- OLD name : Bruto Rompepedras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=18973
UPDATE `creature_template_locale` SET `Name` = 'Bruto Rompepiedras' WHERE `locale` = 'esMX' AND `entry` = 18973;
-- OLD name : Guardia de cólera (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=18975
UPDATE `creature_template_locale` SET `Name` = 'Guardia de Cólera' WHERE `locale` = 'esMX' AND `entry` = 18975;
-- OLD name : Duende dardo vil
-- Source : https://www.wowhead.com/wotlk/mx/npc=18978
UPDATE `creature_template_locale` SET `Name` = 'Duente dardo vil' WHERE `locale` = 'esMX' AND `entry` = 18978;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Médico militar' WHERE `locale` = 'esMX' AND `entry` = 18990;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Médico militar' WHERE `locale` = 'esMX' AND `entry` = 18991;
-- OLD subname : Instructora de cocina y suministros
-- Source : https://www.wowhead.com/wotlk/mx/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Suministros de cocina' WHERE `locale` = 'esMX' AND `entry` = 18993;
-- OLD name : Peón Rompepedras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19048
UPDATE `creature_template_locale` SET `Name` = 'Peón Rompepiedras' WHERE `locale` = 'esMX' AND `entry` = 19048;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de alquimia' WHERE `locale` = 'esMX' AND `entry` = 19052;
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19060;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de joyería' WHERE `locale` = 'esMX' AND `entry` = 19063;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19132;
-- OLD name : Defensor Guardia de cólera (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19160
UPDATE `creature_template_locale` SET `Name` = 'Vigía diligente' WHERE `locale` = 'esMX' AND `entry` = 19160;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esMX' AND `entry` = 19180;
-- OLD name : Cría de uñagrieta
-- Source : https://www.wowhead.com/wotlk/mx/npc=19183
UPDATE `creature_template_locale` SET `Name` = 'Cachorro de uñagrieta' WHERE `locale` = 'esMX' AND `entry` = 19183;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Médico' WHERE `locale` = 'esMX' AND `entry` = 19184;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esMX' AND `entry` = 19185;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de peletería' WHERE `locale` = 'esMX' AND `entry` = 19187;
-- OLD name : Berudan Jurallave, subname : Banquero
-- Source : https://www.wowhead.com/wotlk/mx/npc=19246
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 19246;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de encantamientos' WHERE `locale` = 'esMX' AND `entry` = 19252;
-- OLD name : Bruto Mascahuesos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19269
UPDATE `creature_template_locale` SET `Name` = 'Insectógrafo' WHERE `locale` = 'esMX' AND `entry` = 19269;
-- OLD name : Barnu Cragcrush (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'esMX','PNJs',NULL);
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro herrero' WHERE `locale` = 'esMX' AND `entry` = 19341;
-- OLD subname : Armas de fuego
-- Source : https://www.wowhead.com/wotlk/mx/npc=19351
UPDATE `creature_template_locale` SET `Title` = 'Armas de fuego y munición' WHERE `locale` = 'esMX' AND `entry` = 19351;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esMX' AND `entry` = 19369;
-- OLD subname : Armas arrojadizas
-- Source : https://www.wowhead.com/wotlk/mx/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Armas arrojadizas y munición' WHERE `locale` = 'esMX' AND `entry` = 19473;
-- OLD subname : Familiar de Ravandwyr
-- Source : https://www.wowhead.com/wotlk/mx/npc=19482
UPDATE `creature_template_locale` SET `Title` = 'Pariente de Ravandwyr' WHERE `locale` = 'esMX' AND `entry` = 19482;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de joyería' WHERE `locale` = 'esMX' AND `entry` = 19539;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de encantamientos' WHERE `locale` = 'esMX' AND `entry` = 19540;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 19576;
-- OLD name : [PH]Sunfury Caster - Sunfury Hold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19650;
-- OLD name : Príncipe-nexo Haramad (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19675
UPDATE `creature_template_locale` SET `Name` = 'Príncipe del Nexo Haramad' WHERE `locale` = 'esMX' AND `entry` = 19675;
-- OLD name : Mechanar Ripper (UNUSED) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19711
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19711;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19711, 'esMX','PNJs',NULL);
-- OLD name : Mechanar Pulverizer (UNUSED) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19714
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19714;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19714, 'esMX','PNJs',NULL);
-- OLD name : Centurión eclipsiano
-- Source : https://www.wowhead.com/wotlk/mx/npc=19792
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 19792;
-- OLD name : Extiendepavor Illidari (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19799
UPDATE `creature_template_locale` SET `Name` = 'Clamaterror illidari' WHERE `locale` = 'esMX' AND `entry` = 19799;
-- OLD name : [PH] Illidari Overseer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19819
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19819;
-- OLD name : [PH] Horn Ghost (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=19846
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 19846;
-- OLD name : Clamallamas abismal (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=19973
UPDATE `creature_template_locale` SET `Name` = 'Evocallamas abismal' WHERE `locale` = 'esMX' AND `entry` = 19973;
-- OLD name : Espécimen de Avizor de Lordaeron (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=20053
UPDATE `creature_template_locale` SET `Name` = 'Espécimen de avizor de Lordaeron' WHERE `locale` = 'esMX' AND `entry` = 20053;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 20107;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Instructor forjador de armas' WHERE `locale` = 'esMX' AND `entry` = 20124;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Instructora forjadora de armaduras' WHERE `locale` = 'esMX' AND `entry` = 20125;
-- OLD name : Kaliri domado
-- Source : https://www.wowhead.com/wotlk/mx/npc=20127
UPDATE `creature_template_locale` SET `Name` = 'Kaliri de doma' WHERE `locale` = 'esMX' AND `entry` = 20127;
-- OLD name : Hermana loba Maka
-- Source : https://www.wowhead.com/wotlk/mx/npc=20276
UPDATE `creature_template_locale` SET `Name` = 'Hermana lobo Maka' WHERE `locale` = 'esMX' AND `entry` = 20276;
-- OLD subname : Armadura de arena de legado
-- Source : https://www.wowhead.com/wotlk/mx/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de arena brutal' WHERE `locale` = 'esMX' AND `entry` = 20278;
-- OLD name : Hidra mustia
-- Source : https://www.wowhead.com/wotlk/mx/npc=20324
UPDATE `creature_template_locale` SET `Name` = 'Hidra sedienta' WHERE `locale` = 'esMX' AND `entry` = 20324;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esMX' AND `entry` = 20500;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esMX' AND `entry` = 20511;
-- OLD name : [PH] Arcane Guardian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21031
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21031;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de peletería' WHERE `locale` = 'esMX' AND `entry` = 21087;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro herrero' WHERE `locale` = 'esMX' AND `entry` = 21209;
-- OLD name : Transformación de guía de visión (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=21320
UPDATE `creature_template_locale` SET `Name` = 'Guía de visión' WHERE `locale` = 'esMX' AND `entry` = 21320;
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21333;
-- OLD name : [UNUSED]Test Nether Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21378
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21378;
-- OLD name : Rey-nexo Salhadaar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=21425
UPDATE `creature_template_locale` SET `Name` = 'Rey del Nexo Salhadaar' WHERE `locale` = 'esMX' AND `entry` = 21425;
-- OLD name : Tempixx Finagler (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=21444
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21444;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21444, 'esMX','PNJs',NULL);
-- OLD name : [Unused] Greater Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21457
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21457;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/mx/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esMX' AND `entry` = 21488;
-- OLD name : [DND]Kaliri Aura Dispel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21511;
-- OLD name : Forest Strider (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21634, 'esMX','PNJs',NULL);
-- OLD name : [UNUSED]Death's Deliverer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21658
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21658;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 21716;
-- OLD name : [DND]Spirit 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22023
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22023;
-- OLD name : [PH] bat target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22039
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22039;
-- OLD name : [ph] cave ant [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22048
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22048;
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22118;
-- OLD name : Cría negra del Barón Sablecrín (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=22130
UPDATE `creature_template_locale` SET `Name` = 'Cría negra del barón Sablecrín' WHERE `locale` = 'esMX' AND `entry` = 22130;
-- OLD name : Uñagrieta domada
-- Source : https://www.wowhead.com/wotlk/mx/npc=22135
UPDATE `creature_template_locale` SET `Name` = 'Uñagrieta de doma' WHERE `locale` = 'esMX' AND `entry` = 22135;
-- OLD subname : Especialista en sastrería de tela lunar
-- Source : https://www.wowhead.com/wotlk/mx/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Especialista en tela lunar' WHERE `locale` = 'esMX' AND `entry` = 22208;
-- OLD subname : Especialista en sastrería de tejido de sombra
-- Source : https://www.wowhead.com/wotlk/mx/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Especialista en tejido de sombra' WHERE `locale` = 'esMX' AND `entry` = 22212;
-- OLD subname : Especialista en sastrería de fuego de hechizo
-- Source : https://www.wowhead.com/wotlk/mx/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Especialista en fuego de hechizo' WHERE `locale` = 'esMX' AND `entry` = 22213;
-- OLD name : [PH] Wrath Clefthoof [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22284
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22284;
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22356;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22368;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22383;
-- OLD name : [PH]Altar of Shadows target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22395
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22395;
-- OLD name : [PH]Altar of Shadows caster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22417
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22417;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22435;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22447;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22801;
-- OLD name : Wodin, el sirviente trol
-- Source : https://www.wowhead.com/wotlk/mx/npc=22893
UPDATE `creature_template_locale` SET `Name` = 'Wodin el sirviente trol' WHERE `locale` = 'esMX' AND `entry` = 22893;
-- OLD name : Prisionero de El Etereum (Dungeon Energy Ball) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22927
UPDATE `creature_template_locale` SET `Name` = 'Prisionero de El Etereum' WHERE `locale` = 'esMX' AND `entry` = 22927;
-- OLD name : Concubina del templo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Acólito del templo' WHERE `locale` = 'esMX' AND `entry` = 22939;
-- OLD name : [UNUSED] Illidari Hound [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22944
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22944;
-- OLD name : Cortesana encantadora (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Parroquiano encantador' WHERE `locale` = 'esMX' AND `entry` = 22955;
-- OLD name : Hermana del dolor (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Sacerdotisa del tormento' WHERE `locale` = 'esMX' AND `entry` = 22956;
-- OLD name : Sacerdotisa de la demencia (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Señora de la demencia' WHERE `locale` = 'esMX' AND `entry` = 22957;
-- OLD name : Auxiliar vinculado a hechizo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Anfitrión ardiente' WHERE `locale` = 'esMX' AND `entry` = 22959;
-- OLD name : [UNUSED] Harem Girl 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=22961
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 22961;
-- OLD name : Sacerdotisa de los placeres (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Señora del infortunio' WHERE `locale` = 'esMX' AND `entry` = 22962;
-- OLD name : Hermana del placer (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Sacerdotisa de los placeres' WHERE `locale` = 'esMX' AND `entry` = 22964;
-- OLD name : Siervo esclavizado (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Administrador devoto' WHERE `locale` = 'esMX' AND `entry` = 22965;
-- OLD name : Sacerdote de la garra Ishaal (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23066
UPDATE `creature_template_locale` SET `Name` = 'Sacerdote de la Garra Ishaal' WHERE `locale` = 'esMX' AND `entry` = 23066;
-- OLD name : [PH]Knockdown Fel Cannon Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23077;
-- OLD name : [UNUSED] Jefe Teron Sanguino (montado) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23126
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23126;
-- OLD name : [PH]Fel Hound (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23138
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23138;
-- OLD subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23151
UPDATE `creature_template_locale` SET `Title` = 'SPAWNING IS INCOMPLETE HERE, BROTHER!' WHERE `locale` = 'esMX' AND `entry` = 23151;
-- OLD name : [UNUSED] Mutant Commander [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23238
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23238;
-- OLD name : [PH]Wrath Hound Transform (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23276
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23276;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23317;
-- OLD name : Carga Arcana (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23429
UPDATE `creature_template_locale` SET `Name` = 'Carga arcana' WHERE `locale` = 'esMX' AND `entry` = 23429;
-- OLD name : [PH] Brewfest Dwarf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23479;
-- OLD name : [PH] Brewfest Human Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23480;
-- OLD name : Gentío de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=23488
UPDATE `creature_template_locale` SET `Name` = 'Gentío de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 23488;
-- OLD name : Equipo de montaje de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=23504
UPDATE `creature_template_locale` SET `Name` = 'Equipo de montaje de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 23504;
-- OLD name : [PH] Brewfest Garden D Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23532;
-- OLD name : [PH] Brewfest Goblin Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23540;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/mx/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Magallenas' WHERE `locale` = 'esMX' AND `entry` = 23559;
-- OLD subname : Instructora de pícaros
-- Source : https://www.wowhead.com/wotlk/mx/npc=23566
UPDATE `creature_template_locale` SET `Title` = 'IV:7' WHERE `locale` = 'esMX' AND `entry` = 23566;
-- OLD name : [PH] New Hinterlands NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23599
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23599;
-- OLD name : [PH] Brewfest Orc Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23607;
-- OLD name : [PH] Brewfest Tauren Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23608;
-- OLD name : [PH] Brewfest Troll Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23609;
-- OLD name : [PH] Brewfest Blood Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23610;
-- OLD name : [PH] Brewfest Undead Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23611;
-- OLD name : [PH] Brewfest Draenei Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23613;
-- OLD name : [PH] Brewfest Gnome Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23614;
-- OLD name : [PH] Brewfest Night Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23615;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23634;
-- OLD name : Voceador de cerveza Gordok
-- Source : https://www.wowhead.com/wotlk/mx/npc=23685
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de cerveza Gordok' WHERE `locale` = 'esMX' AND `entry` = 23685;
-- OLD name : Águila Alaocaso (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23693
UPDATE `creature_template_locale` SET `Name` = 'Águila alaocaso' WHERE `locale` = 'esMX' AND `entry` = 23693;
-- OLD name : Juerguista de la Fiesta de la Cerveza borracho (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=23698
UPDATE `creature_template_locale` SET `Name` = 'Juerguista de la Fiesta de la cerveza borracho' WHERE `locale` = 'esMX' AND `entry` = 23698;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23703;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 23734;
-- OLD name : [DND] Brewfest Keg Move to Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Keg Move to Target' WHERE `locale` = 'esMX' AND `entry` = 23808;
-- OLD name : [PH] Brewfest Dwarf Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23819;
-- OLD name : [PH] Brewfest Dwarf Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23820;
-- OLD name : [PH] Brewfest Goblin Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23824;
-- OLD name : [PH] Brewfest Goblin Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23830;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23855;
-- OLD name : Zul'jin, subname : NONE (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=23863
UPDATE `creature_template_locale` SET `Name` = 'Daakara',`Title` = 'El Invencible' WHERE `locale` = 'esMX' AND `entry` = 23863;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23894;
-- OLD subname : Instructor de pesca y suministros
-- Source : https://www.wowhead.com/wotlk/mx/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Mercader de pescado' WHERE `locale` = 'esMX' AND `entry` = 23896;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 23936;
-- OLD subname : G.U.A.O.
-- Source : https://www.wowhead.com/wotlk/mx/npc=24108
UPDATE `creature_template_locale` SET `Title` = 'G.U.A.O' WHERE `locale` = 'esMX' AND `entry` = 24108;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24109
UPDATE `creature_template_locale` SET `Name` = 'Brewfest Target Dummy Move To Target' WHERE `locale` = 'esMX' AND `entry` = 24109;
-- OLD name : Micah Rompepedras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24168
UPDATE `creature_template_locale` SET `Name` = 'Micah Rompepiedras' WHERE `locale` = 'esMX' AND `entry` = 24168;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24171;
-- OLD name : [UNUSED]Fantasma de expedicionario Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B' WHERE `locale` = 'esMX' AND `entry` = 24181;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24205;
-- OLD name : Ejército de muertos
-- Source : https://www.wowhead.com/wotlk/mx/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Necrófago del Ejército de muertos' WHERE `locale` = 'esMX' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24220;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24265;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24311;
-- OLD name : [PH] Creepy Rag Doll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24319;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24337;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24352;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24361;
-- OLD name : Barril festivo de la Destilería de Drohn
-- Source : https://www.wowhead.com/wotlk/mx/npc=24372
UPDATE `creature_template_locale` SET `Name` = 'Barril festivo de destilería de Drohn' WHERE `locale` = 'esMX' AND `entry` = 24372;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C' WHERE `locale` = 'esMX' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24378
UPDATE `creature_template_locale` SET `Name` = '"Back To Bladespire Fortress" Flight Kill Credit' WHERE `locale` = 'esMX' AND `entry` = 24378;
-- OLD name : [VO]Nalorakk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24382
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24382;
-- OLD name : [VO]Akil'Zon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24383
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24383;
-- OLD name : [VO]Halazzi (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24384
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24384;
-- OLD name : [VO]Jan'alai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24386
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24386;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/mx/npc=24417
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 24417;
-- OLD name : Imagen del príncipe-nexo Shaffar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24423
UPDATE `creature_template_locale` SET `Name` = 'Imagen del Príncipe del Nexo Shaffar' WHERE `locale` = 'esMX' AND `entry` = 24423;
-- OLD name : [PH] Maldonado's Test Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24470;
-- OLD name : Fuego de forja
-- Source : https://www.wowhead.com/wotlk/mx/npc=24471
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 24471;
-- OLD name : Juerguista de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=24484
UPDATE `creature_template_locale` SET `Name` = 'Juerguista de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 24484;
-- OLD name : Voceador de la Destilería de Drohn
-- Source : https://www.wowhead.com/wotlk/mx/npc=24492
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de destilería de Drohn' WHERE `locale` = 'esMX' AND `entry` = 24492;
-- OLD name : Voceador de la Cervecería vudú de T'chali
-- Source : https://www.wowhead.com/wotlk/mx/npc=24493
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de cervecería vudú de T''chali' WHERE `locale` = 'esMX' AND `entry` = 24493;
-- OLD name : Aprendiz de la Destilería de Drohn, subname : Vendedor de cerveza de la Destilería de Drohn (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=24501
UPDATE `creature_template_locale` SET `Name` = 'Aprendiz de destilería de Drohn',`Title` = 'Vendedor de cerveza de la destilería de Drohn' WHERE `locale` = 'esMX' AND `entry` = 24501;
-- OLD name : Perito Marea de Hierro (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24581
UPDATE `creature_template_locale` SET `Name` = 'Perito mareaférrea' WHERE `locale` = 'esMX' AND `entry` = 24581;
-- OLD name : Maquinista Marea de Hierro (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24582
UPDATE `creature_template_locale` SET `Name` = 'Maquinista mareaférrea' WHERE `locale` = 'esMX' AND `entry` = 24582;
-- OLD name : Ingeniero Marea de Hierro (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24583
UPDATE `creature_template_locale` SET `Name` = 'Ingeniero mareaférrea' WHERE `locale` = 'esMX' AND `entry` = 24583;
-- OLD name : [PH] BLB Blue Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24658;
-- OLD name : Teniente Martillo de Hielo
-- Source : https://www.wowhead.com/wotlk/mx/npc=24665
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 24665;
-- OLD subname : Organizador de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=24710
UPDATE `creature_template_locale` SET `Title` = 'Organizador de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 24710;
-- OLD subname : Organizador de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=24711
UPDATE `creature_template_locale` SET `Title` = 'Organizador de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 24711;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24766;
-- OLD name : Saqueador Grutacanto (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=24830
UPDATE `creature_template_locale` SET `Name` = 'Saqueador grutacanto' WHERE `locale` = 'esMX' AND `entry` = 24830;
-- OLD name : Pirata Defias, femenino
-- Source : https://www.wowhead.com/wotlk/mx/npc=24860
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 24860;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 24868;
-- OLD name : [PH]Avalanche (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 24912;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 25099;
-- OLD name : [PH] Bri's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25139;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/mx/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de munición especial' WHERE `locale` = 'esMX' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/mx/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de munición especial' WHERE `locale` = 'esMX' AND `entry` = 25196;
-- OLD name : [PH] Torch Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25218
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25218;
-- OLD subname : Matriarca Caballero de sangre (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25246
UPDATE `creature_template_locale` SET `Title` = 'Matriarca de los Caballeros de sangre' WHERE `locale` = 'esMX' AND `entry` = 25246;
-- OLD name : Craig Steele (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'esMX','PNJs',NULL);
-- OLD name : Garganta el Moledor de Cadáveres (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Aniquilador Grek''lor' WHERE `locale` = 'esMX' AND `entry` = 25329;
-- OLD name : Draco guardián rojo
-- Source : https://www.wowhead.com/wotlk/mx/npc=25364
UPDATE `creature_template_locale` SET `Name` = 'Draco rojo guardián' WHERE `locale` = 'esMX' AND `entry` = 25364;
-- OLD name : Craig Steele2 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'esMX','PNJs',NULL);
-- OLD name : Craig Steele3 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'esMX','PNJs',NULL);
-- OLD name : Espíritu del clarividente Caminante Siniestro
-- Source : https://www.wowhead.com/wotlk/mx/npc=25425
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de clarividente Caminante Siniestro' WHERE `locale` = 'esMX' AND `entry` = 25425;
-- OLD name : PattyMack: La Muñeco (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25499
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - The Dummy' WHERE `locale` = 'esMX' AND `entry` = 25499;
-- OLD name : PattyMack - Flying Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25500
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - Flying Dummy' WHERE `locale` = 'esMX' AND `entry` = 25500;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25536;
-- OLD name : Craig's Test Human A (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'esMX','Craig''s Test Human',NULL);
-- OLD name : Enviado Cornopúa (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25658
UPDATE `creature_template_locale` SET `Name` = 'Enviado cuernopúa' WHERE `locale` = 'esMX' AND `entry` = 25658;
-- OLD name : Agostizo abrasador
-- Source : https://www.wowhead.com/wotlk/mx/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Agostizo' WHERE `locale` = 'esMX' AND `entry` = 25706;
-- OLD name : [ph] Coldarra Blue Dragon Patroller (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25723
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 25723;
-- OLD name : [PH] Coldarra Leyliner (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25734
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esMX' AND `entry` = 25734;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 25746;
-- OLD name : Engendro de vacío (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=25824
UPDATE `creature_template_locale` SET `Name` = 'Engendro del vacío' WHERE `locale` = 'esMX' AND `entry` = 25824;
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'esMX','PNJs',NULL);
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26176;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26190;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26241;
-- OLD subname : Matriarca Caballero de sangre (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26247
UPDATE `creature_template_locale` SET `Title` = 'Matriarca de los Caballeros de sangre' WHERE `locale` = 'esMX' AND `entry` = 26247;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26258;
-- OLD name : [PH] Dragonblight Ancient (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26274
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26274;
-- OLD name : [PH] Dragonblight Black Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26275;
-- OLD name : [PH] Dragonblight Green Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26278;
-- OLD name : [PH] Dragonblight Elemental Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26285;
-- OLD name : Forgotten Shore Event Trigger
-- Source : https://www.wowhead.com/wotlk/mx/npc=26288
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 26288;
-- OLD name : [PH] Dragonblight Scourge Carrion Fields (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26292;
-- OLD name : [PH] Dragonblight Magma Wyrm (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26294;
-- OLD name : [PH] Dragonblight Scarlet Onslaught (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26296;
-- OLD name : [PH] Dragonblight taunka (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26311;
-- OLD name : [PH] Dragonblight taunka Spirit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26312;
-- OLD name : [PH] Dragonblight Treant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26313;
-- OLD name : [PH] Dragonblight Scourge Galakrond Rest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26317;
-- OLD name : [PH] Dragonblight Scourge Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26318;
-- OLD name : [PH] Dragonblight Scourge Ruby Dragonshrine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26320;
-- OLD name : Instructora de brujos (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26331
UPDATE `creature_template_locale` SET `Name` = 'Instructor de brujos' WHERE `locale` = 'esMX' AND `entry` = 26331;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26355;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'esMX','PNJs',NULL);
-- OLD name : Evee Muellecobre, subname : Vendedora de arena
-- Source : https://www.wowhead.com/wotlk/mx/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 26378;
-- OLD name : Grikkin Muellecobre, subname : Vendedor de arena
-- Source : https://www.wowhead.com/wotlk/mx/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 26383;
-- OLD name : Frixee Cabriolatón, subname : Vendedora de arena
-- Source : https://www.wowhead.com/wotlk/mx/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26391;
-- OLD name : [PH] Dragonblight Carrion Field Necromancer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26489;
-- OLD name : [PH] Dragonblight Carrion Field Zombie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26490;
-- OLD name : [PH] Dragonblight Carrion Field Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26491;
-- OLD name : Curiana
-- Source : https://www.wowhead.com/wotlk/mx/npc=26525
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha' WHERE `locale` = 'esMX' AND `entry` = 26525;
-- OLD subname : Caballero de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26528
UPDATE `creature_template_locale` SET `Title` = 'Caballero de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 26528;
-- OLD name : [Demo] Craig Amai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26535;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26576;
-- OLD name : Transformación de Percepción espiritual (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26594
UPDATE `creature_template_locale` SET `Name` = 'Visión espiritual' WHERE `locale` = 'esMX' AND `entry` = 26594;
-- OLD name : [PH] Named Condor Shirrak (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26665;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26671, 'esMX','PNJs',NULL);
-- OLD name : Habitante de Arroyoplata (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26708
UPDATE `creature_template_locale` SET `Name` = 'Habitante de Arroyoplata recordado' WHERE `locale` = 'esMX' AND `entry` = 26708;
-- OLD name : Espía de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=26719
UPDATE `creature_template_locale` SET `Name` = 'Espía de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 26719;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26724;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26732;
-- OLD name : Déspota azur (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26734
UPDATE `creature_template_locale` SET `Name` = 'Agente azur' WHERE `locale` = 'esMX' AND `entry` = 26734;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26765;
-- OLD name : Scott Keenan (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26791
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26791;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26791, 'esMX','PNJs',NULL);
-- OLD name : [PH] Dragonblight Shoveltusk Scavenger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26835;
-- OLD name : [PH] Dragonblight Named Frost Wyrm Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 26840;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 26956;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 26992;
-- OLD name : Tonraq, subname : Fabricante de lanzas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27188
UPDATE `creature_template_locale` SET `Name` = 'Kah''chu',`Title` = 'Reparaciones' WHERE `locale` = 'esMX' AND `entry` = 27188;
-- OLD name : [PH] New Hearthglen Scarlet Footman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27205;
-- OLD name : [PH] New Hearthglen Scarlet Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27208;
-- OLD name : Torturador LeCraft (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Torturador Alphonse' WHERE `locale` = 'esMX' AND `entry` = 27209;
-- OLD name : [PH] New Hearthglen Scarlet Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27218;
-- OLD name : Clayton Dubin J, subname : Calidad garantizada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27231
UPDATE `creature_template_locale` SET `Name` = 'Clayton Dubin Test J',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 27231;
-- OLD name : Clamallamas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27292
UPDATE `creature_template_locale` SET `Name` = 'Evocallamas' WHERE `locale` = 'esMX' AND `entry` = 27292;
-- OLD name : Cadena de Clamallamas (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27297
UPDATE `creature_template_locale` SET `Name` = 'Cadena de Evocallamas' WHERE `locale` = 'esMX' AND `entry` = 27297;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27368;
-- OLD name : Escribano jefe Barriga (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Escribano jefe Kinnedius' WHERE `locale` = 'esMX' AND `entry` = 27378;
-- OLD name : Wintergarde Inner Gate Attack Trigger
-- Source : https://www.wowhead.com/wotlk/mx/npc=27380
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 27380;
-- OLD name : Thel'zan el Portador del Ocaso
-- Source : https://www.wowhead.com/wotlk/mx/npc=27384
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 27384;
-- OLD name : [DND] Valiance Keep Footman Spectator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27387;
-- OLD name : Utgarde Duo Trigger
-- Source : https://www.wowhead.com/wotlk/mx/npc=27404
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 27404;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'esMX','PNJs',NULL);
-- OLD name : Lord Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/mx/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Lord Devrestrasz' WHERE `locale` = 'esMX' AND `entry` = 27575;
-- OLD name : Coche de carreras triturador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27664
UPDATE `creature_template_locale` SET `Name` = 'Autito chocón' WHERE `locale` = 'esMX' AND `entry` = 27664;
-- OLD name : Piloto de coche de carreras triturador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27697
UPDATE `creature_template_locale` SET `Name` = 'Piloto de autito chocón' WHERE `locale` = 'esMX' AND `entry` = 27697;
-- OLD name : Gran kodo de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/mx/npc=27707
UPDATE `creature_template_locale` SET `Name` = 'Gran kodo de la Fiesta de la cerveza' WHERE `locale` = 'esMX' AND `entry` = 27707;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27723;
-- OLD name : Patty's test vehicle (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - vehicle' WHERE `locale` = 'esMX' AND `entry` = 27862;
-- OLD name : [PH] Warp Stalker Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 27976;
-- OLD name : Teniente Martillo de Hielo
-- Source : https://www.wowhead.com/wotlk/mx/npc=27994
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 27994;
-- OLD name : [ph] exploding barrel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28173
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28173;
-- OLD name : [ph] Goblin Construction Crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28180
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28180;
-- OLD name : [DND] under water construction crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28184;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28206;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28292;
-- OLD name : [UNUSED]Altar of Quetz'lun Gateway - Real World (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28469;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'esMX','PNJs',NULL);
-- OLD name : Torturador LeCraft
-- Source : https://www.wowhead.com/wotlk/mx/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Torturador Alphonse' WHERE `locale` = 'esMX' AND `entry` = 28554;
-- OLD name : Caballero de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=28612
UPDATE `creature_template_locale` SET `Name` = 'Caballero de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 28612;
-- OLD name : Cíngara misteriosa (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=28652
UPDATE `creature_template_locale` SET `Name` = 'Comerciante misterioso' WHERE `locale` = 'esMX' AND `entry` = 28652;
-- OLD name : Profeta de Quetz'lun
-- Source : https://www.wowhead.com/wotlk/mx/npc=28671
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 28671;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esMX' AND `entry` = 28693;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esMX' AND `entry` = 28694;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=28696
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de desuello' WHERE `locale` = 'esMX' AND `entry` = 28696;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28697
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 28697;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de minería' WHERE `locale` = 'esMX' AND `entry` = 28698;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esMX' AND `entry` = 28699;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28700
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de peletería' WHERE `locale` = 'esMX' AND `entry` = 28700;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esMX' AND `entry` = 28701;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de inscripción' WHERE `locale` = 'esMX' AND `entry` = 28702;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de alquimia' WHERE `locale` = 'esMX' AND `entry` = 28703;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/mx/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herboristería' WHERE `locale` = 'esMX' AND `entry` = 28704;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de cocina' WHERE `locale` = 'esMX' AND `entry` = 28705;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esMX' AND `entry` = 28706;
-- OLD subname : Instructora de pesca y suministros
-- Source : https://www.wowhead.com/wotlk/mx/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de pesca y suministros' WHERE `locale` = 'esMX' AND `entry` = 28742;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Instructor de vuelo en clima frío' WHERE `locale` = 'esMX' AND `entry` = 28746;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28767;
-- OLD name : Vaino (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=28871
UPDATE `creature_template_locale` SET `Name` = 'Vaina' WHERE `locale` = 'esMX' AND `entry` = 28871;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28957;
-- OLD name : Señor Escarlata Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/mx/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Señor Escarlata Borugh' WHERE `locale` = 'esMX' AND `entry` = 28964;
-- OLD name : [Chapter II] Scarlet Crusader Proxy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=28984
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 28984;
-- OLD subname : Fabricante de arcos
-- Source : https://www.wowhead.com/wotlk/mx/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Flechero' WHERE `locale` = 'esMX' AND `entry` = 29014;
-- OLD name : [DND] Dockhand w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29020;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29025;
-- OLD name : [Chapter II] Torch Toss Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29038
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29038;
-- OLD name : [UNUSED] [ph] Stormwind Gryphon (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUTILIZAR' WHERE `locale` = 'esMX' AND `entry` = 29039;
-- OLD name : PattyMacks La Doble (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29083
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - The Duece' WHERE `locale` = 'esMX' AND `entry` = 29083;
-- OLD name : Totally Generic Bunny x8.0 (JSB) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29100
UPDATE `creature_template_locale` SET `Name` = 'Universal Bunny - DNT' WHERE `locale` = 'esMX' AND `entry` = 29100;
-- OLD name : Dama de batalla Val'kyr (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29111
UPDATE `creature_template_locale` SET `Name` = 'Doncella de batalla Val''kyr' WHERE `locale` = 'esMX' AND `entry` = 29111;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29192;
-- OLD subname : Vendedor de componentes
-- Source : https://www.wowhead.com/wotlk/mx/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de polvo de cadáver' WHERE `locale` = 'esMX' AND `entry` = 29203;
-- OLD name : Guerrero de los Baldíos Helados
-- Source : https://www.wowhead.com/wotlk/mx/npc=29206
UPDATE `creature_template_locale` SET `Name` = 'Guerrero de los Páramos Congelados' WHERE `locale` = 'esMX' AND `entry` = 29206;
-- OLD subname : Instructora de primeros auxilios (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vendajes' WHERE `locale` = 'esMX' AND `entry` = 29233;
-- OLD name : [Chapter IV] Light of Dawn Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29245;
-- OLD name : PattyMacks Hovering Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29263
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - Hovering Dummy' WHERE `locale` = 'esMX' AND `entry` = 29263;
-- OLD name : [PH]TEST Skater (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29361;
-- OLD name : Venerador Veloneve
-- Source : https://www.wowhead.com/wotlk/mx/npc=29407
UPDATE `creature_template_locale` SET `Name` = 'Devoto Veloneve' WHERE `locale` = 'esMX' AND `entry` = 29407;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/mx/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Munición especial' WHERE `locale` = 'esMX' AND `entry` = 29493;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forja de armas' WHERE `locale` = 'esMX' AND `entry` = 29505;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armaduras' WHERE `locale` = 'esMX' AND `entry` = 29506;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería elemental' WHERE `locale` = 'esMX' AND `entry` = 29507;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería de escamas de dragón' WHERE `locale` = 'esMX' AND `entry` = 29508;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Instructora de peletería tribal' WHERE `locale` = 'esMX' AND `entry` = 29509;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de cocina' WHERE `locale` = 'esMX' AND `entry` = 29631;
-- OLD name : Alto arcanista Savor
-- Source : https://www.wowhead.com/wotlk/mx/npc=29657
UPDATE `creature_template_locale` SET `Name` = 'Alto arcanista Sabor' WHERE `locale` = 'esMX' AND `entry` = 29657;
-- OLD subname : Maestro de vuelo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=29749
UPDATE `creature_template_locale` SET `Title` = 'Maestra de vuelo' WHERE `locale` = 'esMX' AND `entry` = 29749;
-- OLD name : Espíritu de rinoceronte
-- Source : https://www.wowhead.com/wotlk/mx/npc=29791
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de Rhino' WHERE `locale` = 'esMX' AND `entry` = 29791;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 29812;
-- OLD name : Sacudetierra Drakkari
-- Source : https://www.wowhead.com/wotlk/mx/npc=29829
UPDATE `creature_template_locale` SET `Name` = 'Tiemblatérrea Drakkari' WHERE `locale` = 'esMX' AND `entry` = 29829;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30078;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30156;
-- OLD name : Lanudal Cornoplata (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30241
UPDATE `creature_template_locale` SET `Name` = 'Lanudal cuernoplata' WHERE `locale` = 'esMX' AND `entry` = 30241;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/mx/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorcuttar' WHERE `locale` = 'esMX' AND `entry` = 30340;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30426
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 30426;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30427
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 30427;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30428
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esMX' AND `entry` = 30428;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/mx/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esMX' AND `entry` = 30437;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30476;
-- OLD name : [UNUSED] Wrathstrike Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30545;
-- OLD name : Fras Siabi (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'esMX' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30559;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30589;
-- OLD name : [UNUSED] Forgotten Depths High Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30594;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30640;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30649;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30655;
-- OLD name : Hechicero azur (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Hechicera azur' WHERE `locale` = 'esMX' AND `entry` = 30667;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30690
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30690;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30707;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esMX' AND `entry` = 30721;
-- OLD subname : Instructora de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de inscripción' WHERE `locale` = 'esMX' AND `entry` = 30722;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30749;
-- OLD name : Tripulante del Martillo de Orgrim
-- Source : https://www.wowhead.com/wotlk/mx/npc=30754
UPDATE `creature_template_locale` SET `Name` = 'Tripulación del Martillo de Orgrim' WHERE `locale` = 'esMX' AND `entry` = 30754;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 30832;
-- OLD subname : Armadura de arena de legado
-- Source : https://www.wowhead.com/wotlk/mx/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de agua' WHERE `locale` = 'esMX' AND `entry` = 30885;
-- OLD name : QA Test Dummy 80 Hostile Low Damage (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=30888
UPDATE `creature_template_locale` SET `Name` = 'Andrew Test Dummy 80 Hostile Low Damage' WHERE `locale` = 'esMX' AND `entry` = 30888;
-- OLD name : Iniciada caballero de la Muerte, subname : Anfitriona de sufrimiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=30958
UPDATE `creature_template_locale` SET `Name` = 'Iniciado caballero de la Muerte',`Title` = 'Anfitrión de sufrimiento' WHERE `locale` = 'esMX' AND `entry` = 30958;
-- OLD name : [UNUSED] The Lich King (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 31014;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]' WHERE `locale` = 'esMX' AND `entry` = 31060;
-- OLD name : Tótem Garra de piedra VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31120
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Garra de piedra VIII' WHERE `locale` = 'esMX' AND `entry` = 31120;
-- OLD name : Tótem Lengua de Fuego VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31132
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Lengua de Fuego VI' WHERE `locale` = 'esMX' AND `entry` = 31132;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'esMX','PNJs',NULL);
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento de maestro mayor' WHERE `locale` = 'esMX' AND `entry` = 31144;
-- OLD name : Muñeco de entrenamiento de asaltante
-- Source : https://www.wowhead.com/wotlk/mx/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento heroico' WHERE `locale` = 'esMX' AND `entry` = 31146;
-- OLD name : Tótem Lengua de Fuego VII (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31158
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Lengua de Fuego VII' WHERE `locale` = 'esMX' AND `entry` = 31158;
-- OLD name : Tótem abrasador VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31162
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem abrasador VIII' WHERE `locale` = 'esMX' AND `entry` = 31162;
-- OLD name : Tótem abrasador IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31164
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem abrasador IX' WHERE `locale` = 'esMX' AND `entry` = 31164;
-- OLD name : Tótem de magma VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31166
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de magma VI' WHERE `locale` = 'esMX' AND `entry` = 31166;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV' WHERE `locale` = 'esMX' AND `entry` = 31168;
-- OLD name : Tótem de resistencia al fuego V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31169
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia al fuego V' WHERE `locale` = 'esMX' AND `entry` = 31169;
-- OLD name : Tótem de resistencia al fuego VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31170
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia al fuego VI' WHERE `locale` = 'esMX' AND `entry` = 31170;
-- OLD name : Tótem de resistencia a la escarcha V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31171
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la escarcha V' WHERE `locale` = 'esMX' AND `entry` = 31171;
-- OLD name : Tótem de resistencia a la Naturaleza V (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31173
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la Naturaleza V' WHERE `locale` = 'esMX' AND `entry` = 31173;
-- OLD name : Tótem Piel de piedra IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31175
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Piel de piedra IX' WHERE `locale` = 'esMX' AND `entry` = 31175;
-- OLD name : Tótem Corriente de sanación VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31182
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Corriente de sanación VIII' WHERE `locale` = 'esMX' AND `entry` = 31182;
-- OLD name : Tótem Fuente de maná VI (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31186
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Fuente de maná VI' WHERE `locale` = 'esMX' AND `entry` = 31186;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 31246;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vuelo en clima frío' WHERE `locale` = 'esMX' AND `entry` = 31247;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 31353;
-- OLD name : Refugiado Renegado (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31467
UPDATE `creature_template_locale` SET `Name` = 'Refugiada Renegada' WHERE `locale` = 'esMX' AND `entry` = 31467;
-- OLD subname : Emblema de intendente de honor
-- Source : https://www.wowhead.com/wotlk/mx/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de valor' WHERE `locale` = 'esMX' AND `entry` = 31579;
-- OLD subname : Emblema del heroísmo intendente
-- Source : https://www.wowhead.com/wotlk/mx/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de heroísmo' WHERE `locale` = 'esMX' AND `entry` = 31580;
-- OLD subname : Emblema de intendente de honor
-- Source : https://www.wowhead.com/wotlk/mx/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de valor' WHERE `locale` = 'esMX' AND `entry` = 31581;
-- OLD subname : Emblema del heroísmo intendente
-- Source : https://www.wowhead.com/wotlk/mx/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de heroísmo' WHERE `locale` = 'esMX' AND `entry` = 31582;
-- OLD name : Imagen de profeta Tharon'ja
-- Source : https://www.wowhead.com/wotlk/mx/npc=31621
UPDATE `creature_template_locale` SET `Name` = 'Imagen del profeta Tharon''ja' WHERE `locale` = 'esMX' AND `entry` = 31621;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'esMX','PNJs',NULL);
-- OLD name : Mancha de petróleo
-- Source : https://www.wowhead.com/wotlk/mx/npc=31786
UPDATE `creature_template_locale` SET `Name` = 'Aceite resbaladizo' WHERE `locale` = 'esMX' AND `entry` = 31786;
-- OLD subname : Bombardero (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=31839
UPDATE `creature_template_locale` SET `Title` = 'Bombardera' WHERE `locale` = 'esMX' AND `entry` = 31839;
-- OLD name : Nargle Trallacable, subname : Vendedor de arena experto
-- Source : https://www.wowhead.com/wotlk/mx/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 31863;
-- OLD name : Zom Bocom, subname : Aprendiz de vendedor de arena
-- Source : https://www.wowhead.com/wotlk/mx/npc=31865
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 31865;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32193;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32328;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32339;
-- OLD name : Ecton Cabriolatón, subname : Aprendiz de vendedor de arena
-- Source : https://www.wowhead.com/wotlk/mx/npc=32360
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 32360;
-- OLD name : Doris Volanthius, subname : Intendente experta de armaduras
-- Source : https://www.wowhead.com/wotlk/mx/npc=32385
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 32385;
-- OLD name : [UNUSED] Spirit Healer (WGA) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32536;
-- OLD name : [DND] Cosmetic Book (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32606;
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento para expertos' WHERE `locale` = 'esMX' AND `entry` = 32666;
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento de maestro' WHERE `locale` = 'esMX' AND `entry` = 32667;
-- OLD name : Crafticus Dominomente
-- Source : https://www.wowhead.com/wotlk/mx/npc=32686
UPDATE `creature_template_locale` SET `Name` = 'Tomas Riogain' WHERE `locale` = 'esMX' AND `entry` = 32686;
-- OLD name : Tótem Nova de Fuego IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=32775
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego IX' WHERE `locale` = 'esMX' AND `entry` = 32775;
-- OLD name : Tótem Nova de Fuego VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=32776
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego VIII' WHERE `locale` = 'esMX' AND `entry` = 32776;
-- OLD name : Trampa arácnida visual
-- Source : https://www.wowhead.com/wotlk/mx/npc=32785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 32785;
-- OLD name : [PH] Pilgrim's Bounty Table - Turkey (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32824;
-- OLD name : [PH] Pilgrim's Bounty Table - Yams (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32825;
-- OLD name : [PH] Pilgrim's Bounty Table - Cranberry Sauce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32827;
-- OLD name : [PH] Pilgrim's Bounty Table - Pie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32829;
-- OLD name : [PH] Pilgrim's Bounty Table - Stuffing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 32831;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33049;
-- OLD name : [PH] Joust Horse (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33130
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33130;
-- OLD name : [PH] Joust Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33135
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33135;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33252;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33305;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'esMX','PNJs',NULL);
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33415;
-- OLD name : Mk II de leviatán (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33432
UPDATE `creature_template_locale` SET `Name` = 'Leviatán Mk II' WHERE `locale` = 'esMX' AND `entry` = 33432;
-- OLD name : [ph] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33450;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33501;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33521;
-- OLD name : Animus de saronita (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33524
UPDATE `creature_template_locale` SET `Name` = 'Ánimus de saronita' WHERE `locale` = 'esMX' AND `entry` = 33524;
-- OLD name : Channel Stalker Freya (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33575
UPDATE `creature_template_locale` SET `Name` = 'Acechadora de canales Freya' WHERE `locale` = 'esMX' AND `entry` = 33575;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esMX' AND `entry` = 33580;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de peletería' WHERE `locale` = 'esMX' AND `entry` = 33581;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esMX' AND `entry` = 33583;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 33586;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/mx/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de cocina' WHERE `locale` = 'esMX' AND `entry` = 33587;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=33588
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de alquimia' WHERE `locale` = 'esMX' AND `entry` = 33588;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/mx/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de primeros auxilios' WHERE `locale` = 'esMX' AND `entry` = 33589;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esMX' AND `entry` = 33590;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herrería' WHERE `locale` = 'esMX' AND `entry` = 33591;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de inscripción' WHERE `locale` = 'esMX' AND `entry` = 33603;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esMX' AND `entry` = 33630;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esMX' AND `entry` = 33631;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de encantamiento' WHERE `locale` = 'esMX' AND `entry` = 33633;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 33634;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esMX' AND `entry` = 33635;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de sastrería' WHERE `locale` = 'esMX' AND `entry` = 33636;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33637
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de joyería' WHERE `locale` = 'esMX' AND `entry` = 33637;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esMX' AND `entry` = 33638;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de herboristería' WHERE `locale` = 'esMX' AND `entry` = 33639;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esMX' AND `entry` = 33640;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esMX' AND `entry` = 33641;
-- OLD name : Acechador de Barrido con brazo de Kologarn (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33661
UPDATE `creature_template_locale` SET `Name` = 'Kologarn acechador barrebrazos' WHERE `locale` = 'esMX' AND `entry` = 33661;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/mx/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esMX' AND `entry` = 33674;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esMX' AND `entry` = 33675;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/mx/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de encantamiento' WHERE `locale` = 'esMX' AND `entry` = 33676;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33677
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de ingeniería' WHERE `locale` = 'esMX' AND `entry` = 33677;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de herboristería' WHERE `locale` = 'esMX' AND `entry` = 33678;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/mx/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esMX' AND `entry` = 33679;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de joyería' WHERE `locale` = 'esMX' AND `entry` = 33680;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esMX' AND `entry` = 33681;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esMX' AND `entry` = 33682;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/mx/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esMX' AND `entry` = 33683;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/mx/npc=33684
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de sastrería' WHERE `locale` = 'esMX' AND `entry` = 33684;
-- OLD name : Vigilante de tormenta templado (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33722
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de tormenta templada' WHERE `locale` = 'esMX' AND `entry` = 33722;
-- OLD name : [ph] test tournament charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 33784;
-- OLD name : Acechador de escombros de Kologarn (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=33809
UPDATE `creature_template_locale` SET `Name` = 'Acechador de escombros Kologarn' WHERE `locale` = 'esMX' AND `entry` = 33809;
-- OLD name : Puntos de enfoque de Mimiron
-- Source : https://www.wowhead.com/wotlk/mx/npc=33835
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 33835;
-- OLD name : Cincel goblin detonante
-- Source : https://www.wowhead.com/wotlk/mx/npc=33958
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 33958;
-- OLD name : Magister Sarien, subname : Emblema de intendencia de conquista
-- Source : https://www.wowhead.com/wotlk/mx/npc=33963
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 33963;
-- OLD subname : Emblema de intendencia de conquista
-- Source : https://www.wowhead.com/wotlk/mx/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de conquista' WHERE `locale` = 'esMX' AND `entry` = 33964;
-- OLD name : Radio de Barbabronce
-- Source : https://www.wowhead.com/wotlk/mx/npc=34054
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esMX' AND `entry` = 34054;
-- OLD name : Mk II de leviatán (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=34071
UPDATE `creature_template_locale` SET `Name` = 'Leviatán Mk II' WHERE `locale` = 'esMX' AND `entry` = 34071;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34281;
-- OLD name : Bomba de tiempo
-- Source : https://www.wowhead.com/wotlk/mx/npc=34307
UPDATE `creature_template_locale` SET `Name` = 'Bomba de relojería' WHERE `locale` = 'esMX' AND `entry` = 34307;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34319;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34381;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'esMX','PNJs',NULL);
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34562;
-- OLD name : [DND] Warbot - Blue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34588;
-- OLD name : [DND] Warbot - Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34589;
-- OLD name : [DND] Magic Rooster (Draenei Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34731;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34732;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34893;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 34910;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 35016;
-- OLD name : Rememoración de Truenoraan (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=35032
UPDATE `creature_template_locale` SET `Name` = 'Rememoración de Thunderaan' WHERE `locale` = 'esMX' AND `entry` = 35032;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 35066;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esMX' AND `entry` = 35093;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esMX' AND `entry` = 35100;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esMX' AND `entry` = 35133;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esMX' AND `entry` = 35135;
-- OLD subname : Emblema del intendente de triunfo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esMX' AND `entry` = 35494;
-- OLD name : Magistrix Vesara, subname : Emblema del intendente de triunfo
-- Source : https://www.wowhead.com/wotlk/mx/npc=35495
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esMX' AND `entry` = 35495;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/mx/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esMX' AND `entry` = 35573;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/mx/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esMX' AND `entry` = 35574;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 35608;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 35983;
-- OLD name : [DND] Argent Charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36071;
-- OLD name : [DND] Swift Burgundy Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36072;
-- OLD name : [DND] Swift Horde Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36074;
-- OLD name : [DND] White Stallion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36075;
-- OLD name : [DND] Swift Alliance Steed (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36076;
-- OLD name : [DND] Forsaken Mariner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36148
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36148;
-- OLD name : [DND] Valgarde Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36154
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36154;
-- OLD name : [DND] Bor'gorok Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36167
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36167;
-- OLD name : [DND] Bor'gorok Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36169
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36169;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36212;
-- OLD name : Sobrestante Kor'kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36213
UPDATE `creature_template_locale` SET `Name` = 'Guardián de Entrañas' WHERE `locale` = 'esMX' AND `entry` = 36213;
-- OLD name : Sobrestante Kraggosh (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36217
UPDATE `creature_template_locale` SET `Name` = 'Cuerpo mutilado' WHERE `locale` = 'esMX' AND `entry` = 36217;
-- OLD subname : Capitán Kor'kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36273
UPDATE `creature_template_locale` SET `Title` = 'Mano del Jefe de Guerra' WHERE `locale` = 'esMX' AND `entry` = 36273;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36530;
-- OLD name : Unstable Fire Elemental [mini] (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36553
UPDATE `creature_template_locale` SET `Name` = 'Elemental de fuego inestable [mini]' WHERE `locale` = 'esMX' AND `entry` = 36553;
-- OLD name : Púa ósea
-- Source : https://www.wowhead.com/wotlk/mx/npc=36619
UPDATE `creature_template_locale` SET `Name` = 'Púa osaria' WHERE `locale` = 'esMX' AND `entry` = 36619;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36643;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36710;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36726;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36792, 'esMX','PNJs',NULL);
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'esMX','PNJs',NULL);
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 36966;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37039;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37128;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37168;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37202;
-- OLD subname : Caballero de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=37225
UPDATE `creature_template_locale` SET `Title` = 'Caballero de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 37225;
-- OLD subname : General Forestal (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=37527
UPDATE `creature_template_locale` SET `Title` = 'General forestal de Lunargenta' WHERE `locale` = 'esMX' AND `entry` = 37527;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37543;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37574;
-- OLD name : [PH] Runner Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37788;
-- OLD name : Pacificador de El Exodar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=37798
UPDATE `creature_template_locale` SET `Name` = 'Pacificador del Exodar' WHERE `locale` = 'esMX' AND `entry` = 37798;
-- OLD name : [TEST] High Overlord Omar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37820;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37831;
-- OLD subname : Emblema del intendente de escarcha
-- Source : https://www.wowhead.com/wotlk/mx/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esMX' AND `entry` = 37941;
-- OLD subname : Emblema del intendente de escarcha
-- Source : https://www.wowhead.com/wotlk/mx/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esMX' AND `entry` = 37942;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 37990;
-- OLD subname : Matriarca Caballero de sangre (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38052
UPDATE `creature_template_locale` SET `Title` = 'Matriarca de los Caballeros de sangre' WHERE `locale` = 'esMX' AND `entry` = 38052;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38053;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38164;
-- OLD name : Gran cohete de amor (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Rompecorazones X-45' WHERE `locale` = 'esMX' AND `entry` = 38204;
-- OLD name : Gran cohete de amor (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'Rompecorazones X-45' WHERE `locale` = 'esMX' AND `entry` = 38207;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38236;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38342;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38581;
-- OLD subname : Caballero de la Mano de Plata (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38608
UPDATE `creature_template_locale` SET `Title` = 'Caballero de la Mano de plata' WHERE `locale` = 'esMX' AND `entry` = 38608;
-- OLD name : Vencedor Razaescarcha vinculado al hielo (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38695
UPDATE `creature_template_locale` SET `Name` = 'Vencedor Razaescarcha vínculado al hielo' WHERE `locale` = 'esMX' AND `entry` = 38695;
-- OLD name : Púa ósea
-- Source : https://www.wowhead.com/wotlk/mx/npc=38711
UPDATE `creature_template_locale` SET `Name` = 'Púa osaria' WHERE `locale` = 'esMX' AND `entry` = 38711;
-- OLD name : Púa ósea
-- Source : https://www.wowhead.com/wotlk/mx/npc=38712
UPDATE `creature_template_locale` SET `Name` = 'Púa osaria' WHERE `locale` = 'esMX' AND `entry` = 38712;
-- OLD name : [PH] Grimtotem Protector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38830;
-- OLD name : [PH] Grimtotem Collector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38843;
-- OLD name : [PH] Slain Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38846;
-- OLD name : PattyMacks LK (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38857
UPDATE `creature_template_locale` SET `Name` = 'PattyMack - Test - LK' WHERE `locale` = 'esMX' AND `entry` = 38857;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/mx/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esMX' AND `entry` = 38858;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Parado antes de ascender' WHERE `locale` = 'esMX' AND `entry` = 38883;
-- OLD name : [PH] Grimtotem Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 38905;
-- OLD name : Martyr Stalker (Reputation)
-- Source : https://www.wowhead.com/wotlk/mx/npc=39010
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39010;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (39010, 'esMX','Acechador mártir',NULL);
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39057;
-- OLD name : [PH] Orc Firefighter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39058;
-- OLD name : [DND] Flying Machine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39229;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39362;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39420;
-- OLD name : Póster: Orgrimmar (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=39581
UPDATE `creature_template_locale` SET `Name` = 'Marcador de cartel: Orgrimmar' WHERE `locale` = 'esMX' AND `entry` = 39581;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39683;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39707;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39744;
-- OLD name : [PH] Mother Trogg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39798;
-- OLD name : [DND] Summoning Pad (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39817;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 39841;
-- OLD subname : Armas de arena de legado (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40212
UPDATE `creature_template_locale` SET `Title` = 'Gladiador indómito' WHERE `locale` = 'esMX' AND `entry` = 40212;
-- OLD subname : Armas de arena de legado (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40216
UPDATE `creature_template_locale` SET `Title` = 'Gladiador sañoso' WHERE `locale` = 'esMX' AND `entry` = 40216;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 40265;
-- OLD name : Coche de carreras triturador (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40281
UPDATE `creature_template_locale` SET `Name` = 'Autito chocón' WHERE `locale` = 'esMX' AND `entry` = 40281;
-- OLD name : Robot cohete de cuerda azul
-- Source : https://www.wowhead.com/wotlk/mx/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Robot cohete de cuerda' WHERE `locale` = 'esMX' AND `entry` = 40295;
-- OLD name : [DND] Zen'tabra Travel Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 40354;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 40428;
-- OLD subname : Maestro de mazmorras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40435
UPDATE `creature_template_locale` SET `Title` = 'Maestro de calabozos' WHERE `locale` = 'esMX' AND `entry` = 40435;
-- OLD subname : Maestro de mazmorras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40436
UPDATE `creature_template_locale` SET `Title` = 'Maestra de calabozos' WHERE `locale` = 'esMX' AND `entry` = 40436;
-- OLD subname : Maestro de mazmorras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40438
UPDATE `creature_template_locale` SET `Title` = 'Maestro de calabozos' WHERE `locale` = 'esMX' AND `entry` = 40438;
-- OLD subname : Maestra de mazmorras (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40443
UPDATE `creature_template_locale` SET `Title` = 'Maestra de calabozos' WHERE `locale` = 'esMX' AND `entry` = 40443;
-- OLD subname : Tambor de guerra de Vol'jin (RETAIL DATAS)
-- Source : https://www.wowhead.com/mx/npc=40492
UPDATE `creature_template_locale` SET `Title` = 'Tamborilero bélico de Vol''jin' WHERE `locale` = 'esMX' AND `entry` = 40492;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 40617;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/mx/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'esMX' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,230,399,400,401,402,403,444,461,542,631,725,841,1156,1179,1361,1455,2286,2662,2876,2889,2913,2939,3200,3657,3663,3664,3697,3727,3904,3907,3936,3961,4098,4115,4131,4157,4167,4174,4181,4191,4195,4211,4224,4266,4318,4411,4413,4443,4445,4446,4449,4450,4579,4787,4850,4851,4852,4853,4854,4855,4856,5002,5035,5047,5231,5472,5495,5496,5504,5505,5506,5787,5879,5939,6007,6008,6009,6012,6091,6094,6110,6111,6566,6571,6572,6578,6666,6783,7014,7114,7175,7320,7321,7373,7396,7398,7413,7425,7468,7469,7483,7484,7486,7487,7805,7844,7845,8480,9687,9688,9689,10581,10601,10776,10949,11058,11100,11101,11122,11323,11360,11364,11365,11366,11367,11397,11440,11866,12019,12020,12026,12126,12904,13140,13146,13602,13618,14435,14636,14735,14744,14830,14911,15067,15068,15101,15104,15166,15204,15375,15463,15464,15482,15486,15487,15490,15492,15496,15497,15640,15713,15866,15934,15992,15993,15996,15997,15998,15999,16460,16461,16707,16773,16872,16874,16875,16882,16883,16908,16909,16926,16930,17023,17061,17065,17162,17233,17299,17424,17515,17663,17733,17910,17911,17912,17913,17914,18076,18348,18349,18366,18674,18803,18973,19048,19160,19269,19325,19675,19711,19714,19799,19973,20053,21320,21425,21444,21634,22927,22939,22955,22956,22957,22959,22962,22964,22965,23066,23151,23429,23693,23734,23808,23863,24109,24168,24181,24377,24378,24423,24581,24582,24583,24830,25246,25323,25329,25406,25411,25499,25500,25537,25658,25723,25734,25824,26080,26247,26331,26376,26528,26594,26671,26708,26734,26791,26956,26992,27188,27209,27231,27292,27297,27378,27527,27664,27697,27862,28501,28612,28652,28871,29039,29083,29100,29111,29233,29263,29749,30241,30426,30427,30428,30552,30667,30888,31060,31120,31132,31143,31158,31162,31164,31166,31168,31169,31170,31171,31173,31175,31182,31186,31467,31696,31839,32775,32776,33351,33432,33524,33575,33661,33722,33809,34071,34533,35032,36213,36217,36273,36553,36792,36904,37225,37527,37798,38052,38204,38207,38608,38695,38857,38883,39581,40212,40216,40281,40435,40436,40438,40443,40492
-- END
