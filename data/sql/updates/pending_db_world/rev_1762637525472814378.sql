-- Update esES ; from WowHead WOTLK+ / Retail
-- OLD name : Asignador Benny
-- Source : https://www.wowhead.com/wotlk/es/npc=19
UPDATE `creature_template_locale` SET `Name` = 'Benny Asignador' WHERE `locale` = 'esES' AND `entry` = 19;
-- OLD name : Kanrethad, subname : Maestro de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=29
UPDATE `creature_template_locale` SET `Name` = 'Engendro de dragón',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 29;
-- OLD name : Matón sin cerebro
-- Source : https://www.wowhead.com/wotlk/es/npc=38
UPDATE `creature_template_locale` SET `Name` = 'Matón Defias' WHERE `locale` = 'esES' AND `entry` = 38;
-- OLD name : Guardia de la ciudad de Ventormenta (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=68
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la Ciudad de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 68;
-- OLD name : [UNUSED] Ciudadano de clase baja (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=70
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 70;
-- OLD subname : Personaje con misión
-- Source : https://www.wowhead.com/wotlk/es/npc=73
UPDATE `creature_template_locale` SET `Title` = 'Asignador de misión' WHERE `locale` = 'esES' AND `entry` = 73;
-- OLD name : [UNUSED] Vashaum Nochemustia (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=75
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 75;
-- OLD name : [UNUSED] Luglar el Obstructor (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=81
UPDATE `creature_template_locale` SET `Name` = 'Festividad - Halloween - Ciudadela - Elemental de cerveza espectral' WHERE `locale` = 'esES' AND `entry` = 81;
-- OLD name : Ratero
-- Source : https://www.wowhead.com/wotlk/es/npc=94
UPDATE `creature_template_locale` SET `Name` = 'Ratero Defias' WHERE `locale` = 'esES' AND `entry` = 94;
-- OLD name : Jabalí Colmipétreo
-- Source : https://www.wowhead.com/wotlk/es/npc=113
UPDATE `creature_template_locale` SET `Name` = 'Jabalí colmillopétreo' WHERE `locale` = 'esES' AND `entry` = 113;
-- OLD name : Bandido
-- Source : https://www.wowhead.com/wotlk/es/npc=116
UPDATE `creature_template_locale` SET `Name` = 'Bandido Defias' WHERE `locale` = 'esES' AND `entry` = 116;
-- OLD name : [UNUSED] Pequeña cría de dragón Negro (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=149
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 149;
-- OLD name : [UNUSED] Ander el Monje (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=161
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 161;
-- OLD name : [UNUSED] Granjero desposeído (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=163
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 163;
-- OLD name : [UNUSED] Niño pequeño (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=165
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 165;
-- OLD name : Horror en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=202
UPDATE `creature_template_locale` SET `Name` = 'Horror esquelético' WHERE `locale` = 'esES' AND `entry` = 202;
-- OLD name : [UNUSED] Risillas Fogóseo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=204
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 204;
-- OLD name : Sombracechador Penumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=205
UPDATE `creature_template_locale` SET `Name` = 'Correoscuro Nocturno' WHERE `locale` = 'esES' AND `entry` = 205;
-- OLD name : Colmillovil Penumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=206
UPDATE `creature_template_locale` SET `Name` = 'Colmillovil Nocturno' WHERE `locale` = 'esES' AND `entry` = 206;
-- OLD name : [UNUSED] Desollador Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=207
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 207;
-- OLD name : [UNUSED] Depositario Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=208
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 208;
-- OLD name : [UNUSED] Huesocorista Garrarío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=209
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 209;
-- OLD name : Rondanoches Defias
-- Source : https://www.wowhead.com/wotlk/es/npc=215
UPDATE `creature_template_locale` SET `Name` = 'Noctámbulo Defias' WHERE `locale` = 'esES' AND `entry` = 215;
-- OLD name : Thornton Fellwood, subname : Woodcrafter
-- Source : https://www.wowhead.com/wotlk/es/npc=230
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 230;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (230, 'esES','Thornton Bosquevil','Carpintero');
-- OLD name : Alguacil Gryan Mantorrecio, subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=234
UPDATE `creature_template_locale` SET `Name` = 'Gryan Mantorrecio',`Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 234;
-- OLD name : [UNUSED] Greeby Vellolodo TEST (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=243
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 243;
-- OLD name : [UNUSED] Guardia de Torre de Elwynn (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=260
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 260;
-- OLD name : [DND] Wounded Lion's Footman
-- Source : https://www.wowhead.com/wotlk/es/npc=262
UPDATE `creature_template_locale` SET `Name` = 'Cadáver medio comido' WHERE `locale` = 'esES' AND `entry` = 262;
-- OLD name : [UNUSED] Jans Buenamadre (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 296;
-- OLD name : Lobo joven
-- Source : https://www.wowhead.com/wotlk/es/npc=299
UPDATE `creature_template_locale` SET `Name` = 'Lobo joven malsano' WHERE `locale` = 'esES' AND `entry` = 299;
-- OLD name : [UNUSED] Brog'Mud (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=301
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 301;
-- OLD name : Semental blanco
-- Source : https://www.wowhead.com/wotlk/es/npc=305
UPDATE `creature_template_locale` SET `Name` = 'Caballo de montar (Semental nevado)' WHERE `locale` = 'esES' AND `entry` = 305;
-- OLD name : Palomino
-- Source : https://www.wowhead.com/wotlk/es/npc=306
UPDATE `creature_template_locale` SET `Name` = 'Caballo de montar (palomino)' WHERE `locale` = 'esES' AND `entry` = 306;
-- OLD name : Vehículo "enterrado boca abajo"
-- Source : https://www.wowhead.com/wotlk/es/npc=309
UPDATE `creature_template_locale` SET `Name` = 'Cadáver de Rolf' WHERE `locale` = 'esES' AND `entry` = 309;
-- OLD name : [UNUSED] Hermano Akil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=318
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 318;
-- OLD name : [UNUSED] Hermano Benthas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 319;
-- OLD name : [UNUSED] Hermano Cryus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=320
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 320;
-- OLD name : [UNUSED] Hermano Deros (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=321
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 321;
-- OLD name : [UNUSED] Hermano Enoch (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=322
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 322;
-- OLD name : [UNUSED] Hermano Lontananza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=323
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 323;
-- OLD name : [UNUSED] Hermano Greishan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=324
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 324;
-- OLD name : [UNUSED] Hermano Ictharin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=326
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 326;
-- OLD name : Dientes de Oro (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=327
UPDATE `creature_template_locale` SET `Name` = 'Dientes de oro' WHERE `locale` = 'esES' AND `entry` = 327;
-- OLD name : [UNUSED] Eduardo el Bufón (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=333
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 333;
-- OLD name : [UNUSED] Rin Tal'Vara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=336
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 336;
-- OLD name : [UNUSED] Helgor el Púgil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 339;
-- OLD name : Lobo invernal
-- Source : https://www.wowhead.com/wotlk/es/npc=359
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar (nevado)' WHERE `locale` = 'esES' AND `entry` = 359;
-- OLD subname : Waitress
-- Source : https://www.wowhead.com/wotlk/es/npc=379
UPDATE `creature_template_locale` SET `Title` = 'Camarera' WHERE `locale` = 'esES' AND `entry` = 379;
-- OLD name : [UNUSED] Waldin Thorbatt (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=380
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 380;
-- OLD name : Lobo domado
-- Source : https://www.wowhead.com/wotlk/es/npc=393
UPDATE `creature_template_locale` SET `Name` = 'Lobo de doma' WHERE `locale` = 'esES' AND `entry` = 393;
-- OLD name : Cría de dragón Negro (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=441
UPDATE `creature_template_locale` SET `Name` = 'Cría de dragón negro' WHERE `locale` = 'esES' AND `entry` = 441;
-- OLD name : Gocho (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=444
UPDATE `creature_template_locale` SET `Name` = 'Lord Cochinillo' WHERE `locale` = 'esES' AND `entry` = 444;
-- OLD name : Capitán de la Avanzada Parker
-- Source : https://www.wowhead.com/wotlk/es/npc=464
UPDATE `creature_template_locale` SET `Name` = 'Guardia Parker' WHERE `locale` = 'esES' AND `entry` = 464;
-- OLD name : [UNUSED] Escriba Colburg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 470;
-- OLD name : Zahorí bribón
-- Source : https://www.wowhead.com/wotlk/es/npc=474
UPDATE `creature_template_locale` SET `Name` = 'Zahorí bribón Defias' WHERE `locale` = 'esES' AND `entry` = 474;
-- OLD name : Gólem de la cosecha oxidado
-- Source : https://www.wowhead.com/wotlk/es/npc=480
UPDATE `creature_template_locale` SET `Name` = 'Gólem oxidado de la cosecha' WHERE `locale` = 'esES' AND `entry` = 480;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=487
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 487;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=488
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 488;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=489
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 489;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=490
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 490;
-- OLD name : [UNUSED] Vigía Kleeman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=496
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 496;
-- OLD name : [UNUSED] Vigía Benjamín (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=497
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 497;
-- OLD name : [UNUSED] Vigía Larsen (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=498
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 498;
-- OLD name : [UNUSED] Colmillolargo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=509
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 509;
-- OLD name : [UNUSED] Cazadir Zarparrío (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=516
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 516;
-- OLD name : Tejesombras Penumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=533
UPDATE `creature_template_locale` SET `Name` = 'Tejesombras Nocturno' WHERE `locale` = 'esES' AND `entry` = 533;
-- OLD name : [UNUSED] Savar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 535;
-- OLD name : [UNUSED] Rhal'Del (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 536;
-- OLD name : [UNUSED] Buk'Cha (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=538
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 538;
-- OLD name : Telarácnida venenosa pigmea
-- Source : https://www.wowhead.com/wotlk/es/npc=539
UPDATE `creature_template_locale` SET `Name` = 'Telarácnida pigmeovenenosa' WHERE `locale` = 'esES' AND `entry` = 539;
-- OLD subname : Maestra de establos
-- Source : https://www.wowhead.com/wotlk/es/npc=543
UPDATE `creature_template_locale` SET `Title` = 'Instructora de mascotas' WHERE `locale` = 'esES' AND `entry` = 543;
-- OLD name : Siegaenemigos 4000
-- Source : https://www.wowhead.com/wotlk/es/npc=573
UPDATE `creature_template_locale` SET `Name` = 'Revientaenemigos 4000' WHERE `locale` = 'esES' AND `entry` = 573;
-- OLD name : Emboscador
-- Source : https://www.wowhead.com/wotlk/es/npc=583
UPDATE `creature_template_locale` SET `Name` = 'Emboscador Defias' WHERE `locale` = 'esES' AND `entry` = 583;
-- OLD name : [UNUSED] Vigía Kern (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=586
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 586;
-- OLD name : [UNUSED] Pirómano Defias (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=592
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 592;
-- OLD name : Capo el Miserable [UNUSED]
-- Source : https://www.wowhead.com/wotlk/es/npc=601
UPDATE `creature_template_locale` SET `Name` = 'Capo el Miserable' WHERE `locale` = 'esES' AND `entry` = 601;
-- OLD name : [UNUSED] Sr. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=605
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 605;
-- OLD name : [UNUSED] Sra. Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=606
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 606;
-- OLD name : [UNUSED] Johnny Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 607;
-- OLD name : [UNUSED] Abuelo Whipple (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=609
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 609;
-- OLD name : [UNUSED] Gina Whipple rabiosa (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=610
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 610;
-- OLD name : [UNUSED] Sr. Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=611
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 611;
-- OLD name : [UNUSED] Sra.Whipple rabiosa (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=612
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 612;
-- OLD name : [UNUSED] Johnny Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=613
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 613;
-- OLD name : [UNUSED] Abuelo Whipple rabioso (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=614
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 614;
-- OLD name : Palabras escritas, subname : Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=693
UPDATE `creature_template_locale` SET `Name` = 'Instructor de habilidades secundarias',`Title` = 'Instructor' WHERE `locale` = 'esES' AND `entry` = 693;
-- OLD name : General Fangore
-- Source : https://www.wowhead.com/wotlk/es/npc=703
UPDATE `creature_template_locale` SET `Name` = 'Teniente Fangore' WHERE `locale` = 'esES' AND `entry` = 703;
-- OLD name : Lobo gris pulgoso
-- Source : https://www.wowhead.com/wotlk/es/npc=704
UPDATE `creature_template_locale` SET `Name` = 'Lobo gris andrajoso' WHERE `locale` = 'esES' AND `entry` = 704;
-- OLD name : Lobo joven pulgoso
-- Source : https://www.wowhead.com/wotlk/es/npc=705
UPDATE `creature_template_locale` SET `Name` = 'Lobo joven andrajoso' WHERE `locale` = 'esES' AND `entry` = 705;
-- OLD name : Descarnador de Crestagrana
-- Source : https://www.wowhead.com/wotlk/es/npc=712
UPDATE `creature_template_locale` SET `Name` = 'Vándalo de Crestagrana' WHERE `locale` = 'esES' AND `entry` = 712;
-- OLD name : Talin Ojo Ávido
-- Source : https://www.wowhead.com/wotlk/es/npc=714
UPDATE `creature_template_locale` SET `Name` = 'Talin Ojoagudo' WHERE `locale` = 'esES' AND `entry` = 714;
-- OLD name : [UNUSED] Déspota esquelético (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=725
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 725;
-- OLD name : Cría soñadora
-- Source : https://www.wowhead.com/wotlk/es/npc=741
UPDATE `creature_template_locale` SET `Name` = 'Cría dormida' WHERE `locale` = 'esES' AND `entry` = 741;
-- OLD name : [UNUSED] Soldado Rebelde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=753
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 753;
-- OLD name : Buscafallas Perdido
-- Source : https://www.wowhead.com/wotlk/es/npc=762
UPDATE `creature_template_locale` SET `Name` = 'Buscagujeros Perdido' WHERE `locale` = 'esES' AND `entry` = 762;
-- OLD subname : Fabricante de arcos
-- Source : https://www.wowhead.com/wotlk/es/npc=789
UPDATE `creature_template_locale` SET `Title` = 'Flechera' WHERE `locale` = 'esES' AND `entry` = 789;
-- OLD subname : Suministros de minería y herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=790
UPDATE `creature_template_locale` SET `Title` = 'Suministros de herrería y minería' WHERE `locale` = 'esES' AND `entry` = 790;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=820
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 820;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=821
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 821;
-- OLD name : Sargento Willem
-- Source : https://www.wowhead.com/wotlk/es/npc=823
UPDATE `creature_template_locale` SET `Name` = 'Ayudante de alguacil Willem' WHERE `locale` = 'esES' AND `entry` = 823;
-- OLD name : Ciclón desatado
-- Source : https://www.wowhead.com/wotlk/es/npc=832
UPDATE `creature_template_locale` SET `Name` = 'Diablo de polvo' WHERE `locale` = 'esES' AND `entry` = 832;
-- OLD name : Harl Cutter, subname : Woodcrafting Supplies
-- Source : https://www.wowhead.com/wotlk/es/npc=841
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 841;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (841, 'esES','Harl Corteno','Suministros de tallas en madera');
-- OLD name : Necrófago podrido
-- Source : https://www.wowhead.com/wotlk/es/npc=846
UPDATE `creature_template_locale` SET `Name` = 'Necrófago putrefacto' WHERE `locale` = 'esES' AND `entry` = 846;
-- OLD name : Hilapenas
-- Source : https://www.wowhead.com/wotlk/es/npc=858
UPDATE `creature_template_locale` SET `Name` = 'Girapenas' WHERE `locale` = 'esES' AND `entry` = 858;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=869
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 869;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=870
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 870;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=874
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 874;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=876
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 876;
-- OLD subname : La Brigada de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=878
UPDATE `creature_template_locale` SET `Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 878;
-- OLD name : Huargen Penumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=898
UPDATE `creature_template_locale` SET `Name` = 'Huargen Nocturno' WHERE `locale` = 'esES' AND `entry` = 898;
-- OLD name : Furia Dienteafilado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=905
UPDATE `creature_template_locale` SET `Name` = 'Furia dienteafilado' WHERE `locale` = 'esES' AND `entry` = 905;
-- OLD name : Keras Corazón de Lobo
-- Source : https://www.wowhead.com/wotlk/es/npc=907
UPDATE `creature_template_locale` SET `Name` = 'Keras Cuorelupo' WHERE `locale` = 'esES' AND `entry` = 907;
-- OLD name : Corrupto Penumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=920
UPDATE `creature_template_locale` SET `Name` = 'Corrupto Nocturno' WHERE `locale` = 'esES' AND `entry` = 920;
-- OLD name : [UNUSED] Arácnido inferior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=924
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 924;
-- OLD name : Lord Grisillo Quiebrasombras
-- Source : https://www.wowhead.com/wotlk/es/npc=928
UPDATE `creature_template_locale` SET `Name` = 'Lord Grayson Quiebrasombras' WHERE `locale` = 'esES' AND `entry` = 928;
-- OLD name : Jíbaro de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=937
UPDATE `creature_template_locale` SET `Name` = 'Jíbaro Kurzen' WHERE `locale` = 'esES' AND `entry` = 937;
-- OLD name : Élite de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=939
UPDATE `creature_template_locale` SET `Name` = 'Élite Kurzen' WHERE `locale` = 'esES' AND `entry` = 939;
-- OLD name : Auxiliador de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=940
UPDATE `creature_template_locale` SET `Name` = 'Auxiliador Kurzen' WHERE `locale` = 'esES' AND `entry` = 940;
-- OLD name : Reductor de cabezas de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=941
UPDATE `creature_template_locale` SET `Name` = 'Reductor de cabezas Kurzen' WHERE `locale` = 'esES' AND `entry` = 941;
-- OLD name : Médico brujo de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=942
UPDATE `creature_template_locale` SET `Name` = 'Médico brujo Kurzen' WHERE `locale` = 'esES' AND `entry` = 942;
-- OLD name : Retador de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=943
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Kurzen' WHERE `locale` = 'esES' AND `entry` = 943;
-- OLD name : Rybrad Riberahielo
-- Source : https://www.wowhead.com/wotlk/es/npc=945
UPDATE `creature_template_locale` SET `Name` = 'Rybrad Riberahiel' WHERE `locale` = 'esES' AND `entry` = 945;
-- OLD name : Tigre de guerra de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=976
UPDATE `creature_template_locale` SET `Name` = 'Tigre de guerra Kurzen' WHERE `locale` = 'esES' AND `entry` = 976;
-- OLD name : Pantera de guerra de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=977
UPDATE `creature_template_locale` SET `Name` = 'Pantera de guerra Kurzen' WHERE `locale` = 'esES' AND `entry` = 977;
-- OLD name : Subjefe de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=978
UPDATE `creature_template_locale` SET `Name` = 'Subjefe Kurzen' WHERE `locale` = 'esES' AND `entry` = 978;
-- OLD name : Cazador de las Sombras de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=979
UPDATE `creature_template_locale` SET `Name` = 'Cazador de las Sombras Kurzen' WHERE `locale` = 'esES' AND `entry` = 979;
-- OLD name : Eric Dodds el Tercero
-- Source : https://www.wowhead.com/wotlk/es/npc=996
UPDATE `creature_template_locale` SET `Name` = 'Maestro sastre' WHERE `locale` = 'esES' AND `entry` = 996;
-- OLD name : Unkillable Test Dummy, subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=1000
UPDATE `creature_template_locale` SET `Name` = 'Vigía Blomberg',`Title` = 'La Guardia Nocturna' WHERE `locale` = 'esES' AND `entry` = 1000;
-- OLD name : Correpantanos Pellejomusgo
-- Source : https://www.wowhead.com/wotlk/es/npc=1010
UPDATE `creature_template_locale` SET `Name` = 'Correcubil Pellejomusgo' WHERE `locale` = 'esES' AND `entry` = 1010;
-- OLD name : Tajobuche anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=1019
UPDATE `creature_template_locale` SET `Name` = 'Ancestro Tajobuche' WHERE `locale` = 'esES' AND `entry` = 1019;
-- OLD name : Moco carmesí (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=1031
UPDATE `creature_template_locale` SET `Name` = 'Moco Carmesí' WHERE `locale` = 'esES' AND `entry` = 1031;
-- OLD name : Habitante del pantano
-- Source : https://www.wowhead.com/wotlk/es/npc=1039
UPDATE `creature_template_locale` SET `Name` = 'Habitante del cubil' WHERE `locale` = 'esES' AND `entry` = 1039;
-- OLD name : Trepador del pantano
-- Source : https://www.wowhead.com/wotlk/es/npc=1040
UPDATE `creature_template_locale` SET `Name` = 'Trepador del cubil' WHERE `locale` = 'esES' AND `entry` = 1040;
-- OLD name : Señor del pantano
-- Source : https://www.wowhead.com/wotlk/es/npc=1041
UPDATE `creature_template_locale` SET `Name` = 'Señor del cubil' WHERE `locale` = 'esES' AND `entry` = 1041;
-- OLD name : Cría escupefuego (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=1044
UPDATE `creature_template_locale` SET `Name` = 'Cría Escupefuego' WHERE `locale` = 'esES' AND `entry` = 1044;
-- OLD name : [UNUSED] Truek (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=1058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 1058;
-- OLD name : Jabalí del risco grande
-- Source : https://www.wowhead.com/wotlk/es/npc=1126
UPDATE `creature_template_locale` SET `Name` = 'Gran jabalí del risco' WHERE `locale` = 'esES' AND `entry` = 1126;
-- OLD name : Jabalí del risco anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=1127
UPDATE `creature_template_locale` SET `Name` = 'Jabalí del risco mayor' WHERE `locale` = 'esES' AND `entry` = 1127;
-- OLD name : Lobo rastreador de las nieves
-- Source : https://www.wowhead.com/wotlk/es/npc=1138
UPDATE `creature_template_locale` SET `Name` = 'Lobo rastreador de nieve' WHERE `locale` = 'esES' AND `entry` = 1138;
-- OLD name : Oso negro
-- Source : https://www.wowhead.com/wotlk/es/npc=1186
UPDATE `creature_template_locale` SET `Name` = 'Oso negro viejo' WHERE `locale` = 'esES' AND `entry` = 1186;
-- OLD name : Rondadora del bosque
-- Source : https://www.wowhead.com/wotlk/es/npc=1195
UPDATE `creature_template_locale` SET `Name` = 'Rondador del bosque' WHERE `locale` = 'esES' AND `entry` = 1195;
-- OLD name : Leopardo de las nieves juvenil
-- Source : https://www.wowhead.com/wotlk/es/npc=1199
UPDATE `creature_template_locale` SET `Name` = 'Leopardo de la nieve juvenil' WHERE `locale` = 'esES' AND `entry` = 1199;
-- OLD name : Leopardo de las nieves
-- Source : https://www.wowhead.com/wotlk/es/npc=1201
UPDATE `creature_template_locale` SET `Name` = 'Leopardo de la nieve' WHERE `locale` = 'esES' AND `entry` = 1201;
-- OLD name : Pirófilo Puñastilla
-- Source : https://www.wowhead.com/wotlk/es/npc=1251
UPDATE `creature_template_locale` SET `Name` = 'Temófogo Puñastilla' WHERE `locale` = 'esES' AND `entry` = 1251;
-- OLD name : Mastín devastador negro
-- Source : https://www.wowhead.com/wotlk/es/npc=1258
UPDATE `creature_template_locale` SET `Name` = 'Devastador negro Masadura' WHERE `locale` = 'esES' AND `entry` = 1258;
-- OLD name : Carnero blanco X
-- Source : https://www.wowhead.com/wotlk/es/npc=1262
UPDATE `creature_template_locale` SET `Name` = 'Carnero blanco' WHERE `locale` = 'esES' AND `entry` = 1262;
-- OLD subname : Mercader de arcos
-- Source : https://www.wowhead.com/wotlk/es/npc=1298
UPDATE `creature_template_locale` SET `Title` = 'Mercader de arcos y flechas' WHERE `locale` = 'esES' AND `entry` = 1298;
-- OLD name : [UNUSED] Kern el Déspota (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=1361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 1361;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=1382
UPDATE `creature_template_locale` SET `Title` = 'Cocinero superior' WHERE `locale` = 'esES' AND `entry` = 1382;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=1430
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 1430;
-- OLD subname : Fletching Supplies
-- Source : https://www.wowhead.com/wotlk/es/npc=1455
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 1455;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (1455, 'esES',NULL,'Suministros de flechas');
-- OLD subname : Fabricante de arcos
-- Source : https://www.wowhead.com/wotlk/es/npc=1462
UPDATE `creature_template_locale` SET `Title` = 'Flechera' WHERE `locale` = 'esES' AND `entry` = 1462;
-- OLD name : Gunther Arcanus
-- Source : https://www.wowhead.com/wotlk/es/npc=1497
UPDATE `creature_template_locale` SET `Name` = 'Gunther Arcanos' WHERE `locale` = 'esES' AND `entry` = 1497;
-- OLD name : Necrófago desdichado
-- Source : https://www.wowhead.com/wotlk/es/npc=1502
UPDATE `creature_template_locale` SET `Name` = 'Zombi desdichado' WHERE `locale` = 'esES' AND `entry` = 1502;
-- OLD name : Carroñero pulgoso
-- Source : https://www.wowhead.com/wotlk/es/npc=1509
UPDATE `creature_template_locale` SET `Name` = 'Carroñero andrajoso' WHERE `locale` = 'esES' AND `entry` = 1509;
-- OLD name : Gorila Lomoblanco iracundo
-- Source : https://www.wowhead.com/wotlk/es/npc=1511
UPDATE `creature_template_locale` SET `Name` = 'Gorila Lomoplata iracundo' WHERE `locale` = 'esES' AND `entry` = 1511;
-- OLD name : Muerto hambriento
-- Source : https://www.wowhead.com/wotlk/es/npc=1527
UPDATE `creature_template_locale` SET `Name` = 'Muerte hambrienta' WHERE `locale` = 'esES' AND `entry` = 1527;
-- OLD name : Ancestro en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=1530
UPDATE `creature_template_locale` SET `Name` = 'Anciano en podredumbre' WHERE `locale` = 'esES' AND `entry` = 1530;
-- OLD name : Antepasado gemebundo
-- Source : https://www.wowhead.com/wotlk/es/npc=1534
UPDATE `creature_template_locale` SET `Name` = 'Ancestro de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 1534;
-- OLD name : Gorila Velo de Bruma anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=1557
UPDATE `creature_template_locale` SET `Name` = 'Gorila del Valle Velo de Bruma viejo' WHERE `locale` = 'esES' AND `entry` = 1557;
-- OLD name : Patriarca Lomoblanco
-- Source : https://www.wowhead.com/wotlk/es/npc=1558
UPDATE `creature_template_locale` SET `Name` = 'Patriarca Lomoplata' WHERE `locale` = 'esES' AND `entry` = 1558;
-- OLD name : Slim's Test Rogue
-- Source : https://www.wowhead.com/wotlk/es/npc=1601
UPDATE `creature_template_locale` SET `Name` = 'Rogue 40' WHERE `locale` = 'esES' AND `entry` = 1601;
-- OLD name : [UNUSED] Guardia de Elwynn (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=1643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 1643;
-- OLD name : [UNUSED] Guardia de Crestagrana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=1644
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 1644;
-- OLD subname : Cook
-- Source : https://www.wowhead.com/wotlk/es/npc=1677
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 1677;
-- OLD name : Targorr el Pavoroso
-- Source : https://www.wowhead.com/wotlk/es/npc=1696
UPDATE `creature_template_locale` SET `Name` = 'Targor el Pavoroso' WHERE `locale` = 'esES' AND `entry` = 1696;
-- OLD name : Prisionero
-- Source : https://www.wowhead.com/wotlk/es/npc=1706
UPDATE `creature_template_locale` SET `Name` = 'Prisionero Defias' WHERE `locale` = 'esES' AND `entry` = 1706;
-- OLD name : Presidiario
-- Source : https://www.wowhead.com/wotlk/es/npc=1711
UPDATE `creature_template_locale` SET `Name` = 'Presidiario Defias' WHERE `locale` = 'esES' AND `entry` = 1711;
-- OLD name : Insurgente
-- Source : https://www.wowhead.com/wotlk/es/npc=1715
UPDATE `creature_template_locale` SET `Name` = 'Insurgente Defias' WHERE `locale` = 'esES' AND `entry` = 1715;
-- OLD name : Ciudadana de Ventormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=1723
UPDATE `creature_template_locale` SET `Name` = 'Ciudadano de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 1723;
-- OLD name : Serrador goblin
-- Source : https://www.wowhead.com/wotlk/es/npc=1730
UPDATE `creature_template_locale` SET `Name` = 'Cortasilvo goblin' WHERE `locale` = 'esES' AND `entry` = 1730;
-- OLD name : Domaborrascas Defias
-- Source : https://www.wowhead.com/wotlk/es/npc=1732
UPDATE `creature_template_locale` SET `Name` = 'Formarrasca Defias' WHERE `locale` = 'esES' AND `entry` = 1732;
-- OLD name : Gran almirante Jes-Tereth (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=1750
UPDATE `creature_template_locale` SET `Name` = 'Gran Almirante Jes-Tereth' WHERE `locale` = 'esES' AND `entry` = 1750;
-- OLD name : Espíritu feral superior
-- Source : https://www.wowhead.com/wotlk/es/npc=1764
UPDATE `creature_template_locale` SET `Name` = 'Espíritu salvaje superior' WHERE `locale` = 'esES' AND `entry` = 1764;
-- OLD name : Huargo rabioso
-- Source : https://www.wowhead.com/wotlk/es/npc=1766
UPDATE `creature_template_locale` SET `Name` = 'Huargo jaspeado' WHERE `locale` = 'esES' AND `entry` = 1766;
-- OLD name : Asediadora Corretela
-- Source : https://www.wowhead.com/wotlk/es/npc=1780
UPDATE `creature_template_locale` SET `Name` = 'Acechamusgo' WHERE `locale` = 'esES' AND `entry` = 1780;
-- OLD name : Rondadora Corretela
-- Source : https://www.wowhead.com/wotlk/es/npc=1781
UPDATE `creature_template_locale` SET `Name` = 'Trepanieblas' WHERE `locale` = 'esES' AND `entry` = 1781;
-- OLD name : Necrófago congelado
-- Source : https://www.wowhead.com/wotlk/es/npc=1796
UPDATE `creature_template_locale` SET `Name` = 'Necrófago gélido' WHERE `locale` = 'esES' AND `entry` = 1796;
-- OLD name : Muerte gemebunda
-- Source : https://www.wowhead.com/wotlk/es/npc=1804
UPDATE `creature_template_locale` SET `Name` = 'Muerte de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 1804;
-- OLD name : Cóndor en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=1810
UPDATE `creature_template_locale` SET `Name` = 'Cóndor putrefacto' WHERE `locale` = 'esES' AND `entry` = 1810;
-- OLD name : Behemoth en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=1812
UPDATE `creature_template_locale` SET `Name` = 'Behemoth putrefacto' WHERE `locale` = 'esES' AND `entry` = 1812;
-- OLD name : Horror putrefacto
-- Source : https://www.wowhead.com/wotlk/es/npc=1813
UPDATE `creature_template_locale` SET `Name` = 'Horror en descomposición' WHERE `locale` = 'esES' AND `entry` = 1813;
-- OLD name : Oso pardo malsano
-- Source : https://www.wowhead.com/wotlk/es/npc=1816
UPDATE `creature_template_locale` SET `Name` = 'Pardo malsano' WHERE `locale` = 'esES' AND `entry` = 1816;
-- OLD name : Hidra Faucevil
-- Source : https://www.wowhead.com/wotlk/es/npc=1819
UPDATE `creature_template_locale` SET `Name` = 'Hidra Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 1819;
-- OLD name : Hidra Faucevil anciana
-- Source : https://www.wowhead.com/wotlk/es/npc=1820
UPDATE `creature_template_locale` SET `Name` = 'Hidra Fauzatroz mayor' WHERE `locale` = 'esES' AND `entry` = 1820;
-- OLD name : Rondador Brumatósigo
-- Source : https://www.wowhead.com/wotlk/es/npc=1822
UPDATE `creature_template_locale` SET `Name` = 'Rondador nebovenenoso' WHERE `locale` = 'esES' AND `entry` = 1822;
-- OLD subname : Alto señor de la Cruzada Escarlata (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=1842
UPDATE `creature_template_locale` SET `Title` = 'Alto Señor de la Cruzada Escarlata' WHERE `locale` = 'esES' AND `entry` = 1842;
-- OLD name : Vigía de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1888
UPDATE `creature_template_locale` SET `Name` = 'Vigía de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1888;
-- OLD name : Zahorí de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1889
UPDATE `creature_template_locale` SET `Name` = 'Zahorí de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1889;
-- OLD name : Protector de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1912
UPDATE `creature_template_locale` SET `Name` = 'Protector de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1912;
-- OLD name : Depositario de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1913
UPDATE `creature_template_locale` SET `Name` = 'Depositario de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1913;
-- OLD name : Magister de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1914
UPDATE `creature_template_locale` SET `Name` = 'Mago de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1914;
-- OLD name : Conjurador de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1915
UPDATE `creature_template_locale` SET `Name` = 'Conjurador de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1915;
-- OLD name : Escribachizo de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=1920
UPDATE `creature_template_locale` SET `Name` = 'Escribachizo de Dalaran' WHERE `locale` = 'esES' AND `entry` = 1920;
-- OLD subname : Inmune a la escarcha (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=1926
UPDATE `creature_template_locale` SET `Title` = 'Inmune a la Escarcha' WHERE `locale` = 'esES' AND `entry` = 1926;
-- OLD subname : Inmune a lo Sagrado
-- Source : https://www.wowhead.com/wotlk/es/npc=1927
UPDATE `creature_template_locale` SET `Title` = 'Inmune a Sagrado' WHERE `locale` = 'esES' AND `entry` = 1927;
-- OLD subname : Inmune a la sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=1928
UPDATE `creature_template_locale` SET `Title` = 'Inmune a las Sombras' WHERE `locale` = 'esES' AND `entry` = 1928;
-- OLD subname : Inmune a la Naturaleza
-- Source : https://www.wowhead.com/wotlk/es/npc=1929
UPDATE `creature_template_locale` SET `Title` = 'Inmune a Naturaleza' WHERE `locale` = 'esES' AND `entry` = 1929;
-- OLD subname : Inmune a lo Físico
-- Source : https://www.wowhead.com/wotlk/es/npc=1930
UPDATE `creature_template_locale` SET `Title` = 'Inmune al daño físico' WHERE `locale` = 'esES' AND `entry` = 1930;
-- OLD name : Clamamareas Anca Vil
-- Source : https://www.wowhead.com/wotlk/es/npc=1958
UPDATE `creature_template_locale` SET `Name` = 'Llamamareas Anca Vil' WHERE `locale` = 'esES' AND `entry` = 1958;
-- OLD name : Jabalí cardo joven
-- Source : https://www.wowhead.com/wotlk/es/npc=1984
UPDATE `creature_template_locale` SET `Name` = 'Joven jabalí Cardo' WHERE `locale` = 'esES' AND `entry` = 1984;
-- OLD name : Hilasedas Tejemadera
-- Source : https://www.wowhead.com/wotlk/es/npc=2000
UPDATE `creature_template_locale` SET `Name` = 'Virasedal Tejemadera' WHERE `locale` = 'esES' AND `entry` = 2000;
-- OLD name : Bestia de lodazal Brezomadera
-- Source : https://www.wowhead.com/wotlk/es/npc=2029
UPDATE `creature_template_locale` SET `Name` = 'Lodobestia Brezomadera' WHERE `locale` = 'esES' AND `entry` = 2029;
-- OLD name : Brezomadera anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=2030
UPDATE `creature_template_locale` SET `Name` = 'Ancestro Brezomadera' WHERE `locale` = 'esES' AND `entry` = 2030;
-- OLD name : Anciano protector
-- Source : https://www.wowhead.com/wotlk/es/npc=2041
UPDATE `creature_template_locale` SET `Name` = 'Ancestro protector' WHERE `locale` = 'esES' AND `entry` = 2041;
-- OLD name : Espíritu melancólico
-- Source : https://www.wowhead.com/wotlk/es/npc=2044
UPDATE `creature_template_locale` SET `Name` = 'Espíritu abandonado' WHERE `locale` = 'esES' AND `entry` = 2044;
-- OLD name : Aparecido Corvozarpa
-- Source : https://www.wowhead.com/wotlk/es/npc=2056
UPDATE `creature_template_locale` SET `Name` = 'Aparición Corvozarpa' WHERE `locale` = 'esES' AND `entry` = 2056;
-- OLD name : Consejero Wilhelm
-- Source : https://www.wowhead.com/wotlk/es/npc=2063
UPDATE `creature_template_locale` SET `Name` = 'Consejero Fijalontad' WHERE `locale` = 'esES' AND `entry` = 2063;
-- OLD name : Consejero Cooper
-- Source : https://www.wowhead.com/wotlk/es/npc=2065
UPDATE `creature_template_locale` SET `Name` = 'Consejero Copre' WHERE `locale` = 'esES' AND `entry` = 2065;
-- OLD name : Ilthalaine
-- Source : https://www.wowhead.com/wotlk/es/npc=2079
UPDATE `creature_template_locale` SET `Name` = 'Conservador Ilthalaine' WHERE `locale` = 'esES' AND `entry` = 2079;
-- OLD name : [UNUSED] Ciudadano de Molino Ámbar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2087
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2087;
-- OLD name : Gólem agrietado
-- Source : https://www.wowhead.com/wotlk/es/npc=2156
UPDATE `creature_template_locale` SET `Name` = 'Gólem partido' WHERE `locale` = 'esES' AND `entry` = 2156;
-- OLD name : Oso cardo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=2163
UPDATE `creature_template_locale` SET `Name` = 'Oso Cardo' WHERE `locale` = 'esES' AND `entry` = 2163;
-- OLD name : Oso cardo rabioso (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=2164
UPDATE `creature_template_locale` SET `Name` = 'Oso Cardo rabioso' WHERE `locale` = 'esES' AND `entry` = 2164;
-- OLD name : Zancador Madrezarpa
-- Source : https://www.wowhead.com/wotlk/es/npc=2172
UPDATE `creature_template_locale` SET `Name` = 'Zancador Pedalar' WHERE `locale` = 'esES' AND `entry` = 2172;
-- OLD name : Altonato gemebunda
-- Source : https://www.wowhead.com/wotlk/es/npc=2178
UPDATE `creature_template_locale` SET `Name` = 'Altonato de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 2178;
-- OLD name : Trillador de Costa Oscura
-- Source : https://www.wowhead.com/wotlk/es/npc=2185
UPDATE `creature_template_locale` SET `Name` = 'Trillador de la Costa Oscura' WHERE `locale` = 'esES' AND `entry` = 2185;
-- OLD name : Trillador de Costa Oscura anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=2187
UPDATE `creature_template_locale` SET `Name` = 'Trillador de la Costa Oscura mayor' WHERE `locale` = 'esES' AND `entry` = 2187;
-- OLD name : Trillanodonte de las profundidades
-- Source : https://www.wowhead.com/wotlk/es/npc=2188
UPDATE `creature_template_locale` SET `Name` = 'Trillanodonte del mar profundo' WHERE `locale` = 'esES' AND `entry` = 2188;
-- OLD name : Clamafuegos Radison
-- Source : https://www.wowhead.com/wotlk/es/npc=2192
UPDATE `creature_template_locale` SET `Name` = 'Radison Clamafuego' WHERE `locale` = 'esES' AND `entry` = 2192;
-- OLD name : [UNUSED] Pregonero Kirton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2197
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2197;
-- OLD name : [UNUSED] Pregonero Backus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2199
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2199;
-- OLD name : [UNUSED] Pregonero Pierce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2200
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2200;
-- OLD subname : Blacksmith Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2220
UPDATE `creature_template_locale` SET `Title` = 'Instructor de herreros' WHERE `locale` = 'esES' AND `entry` = 2220;
-- OLD subname : Cooking Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2223
UPDATE `creature_template_locale` SET `Title` = 'Instructor de cocina' WHERE `locale` = 'esES' AND `entry` = 2223;
-- OLD name : Yeti de las cuevas
-- Source : https://www.wowhead.com/wotlk/es/npc=2248
UPDATE `creature_template_locale` SET `Name` = 'Yeti de cuevas' WHERE `locale` = 'esES' AND `entry` = 2248;
-- OLD name : Maggarrak
-- Source : https://www.wowhead.com/wotlk/es/npc=2258
UPDATE `creature_template_locale` SET `Name` = 'Furia de piedra' WHERE `locale` = 'esES' AND `entry` = 2258;
-- OLD name : Bow Guy
-- Source : https://www.wowhead.com/wotlk/es/npc=2286
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2286;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2286, 'esES','Arquero',NULL);
-- OLD name : [UNUSED] Kir'Nazz (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2313;
-- OLD name : Maquell Ebonwood
-- Source : https://www.wowhead.com/wotlk/es/npc=2315
UPDATE `creature_template_locale` SET `Name` = 'Maquell Eboleño' WHERE `locale` = 'esES' AND `entry` = 2315;
-- OLD name : Volantón zancudo del bosque
-- Source : https://www.wowhead.com/wotlk/es/npc=2321
UPDATE `creature_template_locale` SET `Name` = 'Fugalante zancudo del bosque' WHERE `locale` = 'esES' AND `entry` = 2321;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=2326
UPDATE `creature_template_locale` SET `Title` = 'Médico' WHERE `locale` = 'esES' AND `entry` = 2326;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=2329
UPDATE `creature_template_locale` SET `Title` = 'Médico' WHERE `locale` = 'esES' AND `entry` = 2329;
-- OLD name : Trepamusgo anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=2348
UPDATE `creature_template_locale` SET `Name` = 'Trepamusgo mayor' WHERE `locale` = 'esES' AND `entry` = 2348;
-- OLD name : Trepador domesticado
-- Source : https://www.wowhead.com/wotlk/es/npc=2349
UPDATE `creature_template_locale` SET `Name` = 'Trepamusgo gigante' WHERE `locale` = 'esES' AND `entry` = 2349;
-- OLD name : Trepador del bosque
-- Source : https://www.wowhead.com/wotlk/es/npc=2350
UPDATE `creature_template_locale` SET `Name` = 'Trepamusgo del bosque' WHERE `locale` = 'esES' AND `entry` = 2350;
-- OLD name : Oso contagiado
-- Source : https://www.wowhead.com/wotlk/es/npc=2351
UPDATE `creature_template_locale` SET `Name` = 'Oso gris' WHERE `locale` = 'esES' AND `entry` = 2351;
-- OLD name : Acechador Trabaloma
-- Source : https://www.wowhead.com/wotlk/es/npc=2385
UPDATE `creature_template_locale` SET `Name` = 'León de montaña feral' WHERE `locale` = 'esES' AND `entry` = 2385;
-- OLD name : Guardia de la Alianza
-- Source : https://www.wowhead.com/wotlk/es/npc=2386
UPDATE `creature_template_locale` SET `Name` = 'Guardia de Costasur' WHERE `locale` = 'esES' AND `entry` = 2386;
-- OLD name : Sangreveneno Aranae
-- Source : https://www.wowhead.com/wotlk/es/npc=2390
UPDATE `creature_template_locale` SET `Name` = 'Aranae Sangreveneno' WHERE `locale` = 'esES' AND `entry` = 2390;
-- OLD name : Herrero Verringtan
-- Source : https://www.wowhead.com/wotlk/es/npc=2404
UPDATE `creature_template_locale` SET `Name` = 'Herrero Verrintan' WHERE `locale` = 'esES' AND `entry` = 2404;
-- OLD name : Guardia de la Muerte de Molino Tarren
-- Source : https://www.wowhead.com/wotlk/es/npc=2405
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la Muerte del Molino Tarren' WHERE `locale` = 'esES' AND `entry` = 2405;
-- OLD name : Banquero de hermandad
-- Source : https://www.wowhead.com/wotlk/es/npc=2424
UPDATE `creature_template_locale` SET `Name` = 'Banquero de la hermandad' WHERE `locale` = 'esES' AND `entry` = 2424;
-- OLD subname : Guardia de Ventormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=2439
UPDATE `creature_template_locale` SET `Title` = 'Guardia de la Ciudad de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 2439;
-- OLD name : [UNUSED] Ciudadano de Costasur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2441
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2441;
-- OLD name : Draco Flamaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=2472
UPDATE `creature_template_locale` SET `Name` = 'Draco flamascama' WHERE `locale` = 'esES' AND `entry` = 2472;
-- OLD name : Gosh-Haldir
-- Source : https://www.wowhead.com/wotlk/es/npc=2476
UPDATE `creature_template_locale` SET `Name` = 'Gran crocolisco del lago' WHERE `locale` = 'esES' AND `entry` = 2476;
-- OLD name : Haren Pezuña Presta
-- Source : https://www.wowhead.com/wotlk/es/npc=2478
UPDATE `creature_template_locale` SET `Name` = 'Haren Pezuñaveloz' WHERE `locale` = 'esES' AND `entry` = 2478;
-- OLD name : MacKinley "Lobo de Mar"
-- Source : https://www.wowhead.com/wotlk/es/npc=2501
UPDATE `creature_template_locale` SET `Name` = '"Lobo de Mar" MacKinley' WHERE `locale` = 'esES' AND `entry` = 2501;
-- OLD name : Phillipe el "Trémulo"
-- Source : https://www.wowhead.com/wotlk/es/npc=2502
UPDATE `creature_template_locale` SET `Name` = '"Trémulo" Phillipe' WHERE `locale` = 'esES' AND `entry` = 2502;
-- OLD name : Acechador de Jaguero
-- Source : https://www.wowhead.com/wotlk/es/npc=2522
UPDATE `creature_template_locale` SET `Name` = 'Acechador Jaguero' WHERE `locale` = 'esES' AND `entry` = 2522;
-- OLD subname : Enviado de Zanzil
-- Source : https://www.wowhead.com/wotlk/es/npc=2530
UPDATE `creature_template_locale` SET `Title` = 'Rehén Lanza Negra' WHERE `locale` = 'esES' AND `entry` = 2530;
-- OLD name : Esbirro de Doane
-- Source : https://www.wowhead.com/wotlk/es/npc=2531
UPDATE `creature_template_locale` SET `Name` = 'Esbirro de Morganth' WHERE `locale` = 'esES' AND `entry` = 2531;
-- OLD name : Serpiente de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=2540
UPDATE `creature_template_locale` SET `Name` = 'Serpiente de Dalaran' WHERE `locale` = 'esES' AND `entry` = 2540;
-- OLD name : Descarnador de las Tierras Altas
-- Source : https://www.wowhead.com/wotlk/es/npc=2560
UPDATE `creature_template_locale` SET `Name` = 'Vándalo de las Tierras Altas' WHERE `locale` = 'esES' AND `entry` = 2560;
-- OLD name : Águila ratonera de meseta joven
-- Source : https://www.wowhead.com/wotlk/es/npc=2578
UPDATE `creature_template_locale` SET `Name` = 'Águila ratonera de mesa joven' WHERE `locale` = 'esES' AND `entry` = 2578;
-- OLD name : Águila ratonera de meseta
-- Source : https://www.wowhead.com/wotlk/es/npc=2579
UPDATE `creature_template_locale` SET `Name` = 'Águila ratonera Mesa' WHERE `locale` = 'esES' AND `entry` = 2579;
-- OLD name : Águila ratonera de meseta anciana
-- Source : https://www.wowhead.com/wotlk/es/npc=2580
UPDATE `creature_template_locale` SET `Name` = 'Águila ratonera de mesa mayor' WHERE `locale` = 'esES' AND `entry` = 2580;
-- OLD name : Soldado de Stromgarde
-- Source : https://www.wowhead.com/wotlk/es/npc=2585
UPDATE `creature_template_locale` SET `Name` = 'Vindicador de Stromgarde' WHERE `locale` = 'esES' AND `entry` = 2585;
-- OLD name : Elemental de piedra férrea
-- Source : https://www.wowhead.com/wotlk/es/npc=2593
UPDATE `creature_template_locale` SET `Name` = 'Elemental de piedra sólida' WHERE `locale` = 'esES' AND `entry` = 2593;
-- OLD subname : Shadow Council Warlock
-- Source : https://www.wowhead.com/wotlk/es/npc=2598
UPDATE `creature_template_locale` SET `Title` = 'Bruja del Consejo de la Sombra' WHERE `locale` = 'esES' AND `entry` = 2598;
-- OLD name : [UNUSED] Archimago Detrae (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2617;
-- OLD name : Crocolisco Quijaforte mayor
-- Source : https://www.wowhead.com/wotlk/es/npc=2635
UPDATE `creature_template_locale` SET `Name` = 'Crocolisco marino mayor' WHERE `locale` = 'esES' AND `entry` = 2635;
-- OLD name : Taumaturgo umbrío Vilrama
-- Source : https://www.wowhead.com/wotlk/es/npc=2642
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro Vilrama' WHERE `locale` = 'esES' AND `entry` = 2642;
-- OLD name : Port Master Szik, subname : Boat Vendor
-- Source : https://www.wowhead.com/wotlk/es/npc=2662
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2662;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2662, 'esES','Maestro del Portal Szik','Vendedor de barcos');
-- OLD name : Lobo de asalto Vilrama
-- Source : https://www.wowhead.com/wotlk/es/npc=2681
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar Vilrama' WHERE `locale` = 'esES' AND `entry` = 2681;
-- OLD name : Guardia del linaje Secacorteza
-- Source : https://www.wowhead.com/wotlk/es/npc=2686
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la prole Secacorteza' WHERE `locale` = 'esES' AND `entry` = 2686;
-- OLD name : Ogro mago Rotapolvo
-- Source : https://www.wowhead.com/wotlk/es/npc=2720
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Rotapolvo' WHERE `locale` = 'esES' AND `entry` = 2720;
-- OLD name : Excavador de Forjatiniebla
-- Source : https://www.wowhead.com/wotlk/es/npc=2741
UPDATE `creature_template_locale` SET `Name` = 'Excavador Forjatiniebla' WHERE `locale` = 'esES' AND `entry` = 2741;
-- OLD name : Barricada
-- Source : https://www.wowhead.com/wotlk/es/npc=2749
UPDATE `creature_template_locale` SET `Name` = 'Gólem de asedio' WHERE `locale` = 'esES' AND `entry` = 2749;
-- OLD name : Latigoscuro
-- Source : https://www.wowhead.com/wotlk/es/npc=2757
UPDATE `creature_template_locale` SET `Name` = 'Cinchoscura' WHERE `locale` = 'esES' AND `entry` = 2757;
-- OLD name : Clamaolas Espinadaga
-- Source : https://www.wowhead.com/wotlk/es/npc=2807
UPDATE `creature_template_locale` SET `Name` = 'Clamarea Espinadaga' WHERE `locale` = 'esES' AND `entry` = 2807;
-- OLD subname : Suministros generales
-- Source : https://www.wowhead.com/wotlk/es/npc=2808
UPDATE `creature_template_locale` SET `Title` = 'Pertrechos' WHERE `locale` = 'esES' AND `entry` = 2808;
-- OLD name : Águila ratonera sedienta
-- Source : https://www.wowhead.com/wotlk/es/npc=2830
UPDATE `creature_template_locale` SET `Name` = 'Águila ratonera' WHERE `locale` = 'esES' AND `entry` = 2830;
-- OLD name : [PH] Instructor de zancaaltas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2871
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2871;
-- OLD name : [PH] Instructor de raptores (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2873
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2873;
-- OLD name : [PH] Domador de caballos (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2874
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2874;
-- OLD name : [PH] Instructor de gorilas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2875
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2875;
-- OLD subname : Crocilisk Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2876
UPDATE `creature_template_locale` SET `Title` = 'Instructor de crocoliscos' WHERE `locale` = 'esES' AND `entry` = 2876;
-- OLD name : [PH] Instructor de reptadores (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=2877
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2877;
-- OLD subname : Ranged Skills Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2886
UPDATE `creature_template_locale` SET `Title` = 'Instructor de habilidades de ataque a distancia' WHERE `locale` = 'esES' AND `entry` = 2886;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=2935
UPDATE `creature_template_locale` SET `Title` = 'Instructor de demonios' WHERE `locale` = 'esES' AND `entry` = 2935;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2938
UPDATE `creature_template_locale` SET `Title` = 'Instructor de osos' WHERE `locale` = 'esES' AND `entry` = 2938;
-- OLD subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2939
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 2939;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (2939, 'esES',NULL,'Instructor de jabalíes');
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=2942
UPDATE `creature_template_locale` SET `Title` = 'Instructor de lobos' WHERE `locale` = 'esES' AND `entry` = 2942;
-- OLD name : Marioneta de Helcular
-- Source : https://www.wowhead.com/wotlk/es/npc=2946
UPDATE `creature_template_locale` SET `Name` = 'Títere de Helcular' WHERE `locale` = 'esES' AND `entry` = 2946;
-- OLD name : Furtivo Crines Pálidas
-- Source : https://www.wowhead.com/wotlk/es/npc=2951
UPDATE `creature_template_locale` SET `Name` = 'Furtivo Crines Pálidos' WHERE `locale` = 'esES' AND `entry` = 2951;
-- OLD name : Invasores Erizapúas
-- Source : https://www.wowhead.com/wotlk/es/npc=2952
UPDATE `creature_template_locale` SET `Name` = 'Jabaespín Erizapúas' WHERE `locale` = 'esES' AND `entry` = 2952;
-- OLD name : Jabaguerrero joven
-- Source : https://www.wowhead.com/wotlk/es/npc=2966
UPDATE `creature_template_locale` SET `Name` = 'Jabaguerrero' WHERE `locale` = 'esES' AND `entry` = 2966;
-- OLD name : Cavador de Bael'dun
-- Source : https://www.wowhead.com/wotlk/es/npc=2989
UPDATE `creature_template_locale` SET `Name` = 'Cavador Bael''dun' WHERE `locale` = 'esES' AND `entry` = 2989;
-- OLD name : Tasador de Bael'dun
-- Source : https://www.wowhead.com/wotlk/es/npc=2990
UPDATE `creature_template_locale` SET `Name` = 'Tasador Bael''dun' WHERE `locale` = 'esES' AND `entry` = 2990;
-- OLD name : Abuela Viento de Halcón
-- Source : https://www.wowhead.com/wotlk/es/npc=2991
UPDATE `creature_template_locale` SET `Name` = 'Abuela Vientaguilar' WHERE `locale` = 'esES' AND `entry` = 2991;
-- OLD subname : Suministros de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=3005
UPDATE `creature_template_locale` SET `Title` = 'Suministros de peletería y sastrería' WHERE `locale` = 'esES' AND `entry` = 3005;
-- OLD subname : Suministros de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=3008
UPDATE `creature_template_locale` SET `Title` = 'Aprendiz peletero' WHERE `locale` = 'esES' AND `entry` = 3008;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=3067
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 3067;
-- OLD subname : Instructor de alquimia de caminos
-- Source : https://www.wowhead.com/wotlk/es/npc=3070
UPDATE `creature_template_locale` SET `Title` = 'Alquimista <necesita modelo>' WHERE `locale` = 'esES' AND `entry` = 3070;
-- OLD subname : Instructor de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=3071
UPDATE `creature_template_locale` SET `Title` = 'Herborista <necesita modelo>' WHERE `locale` = 'esES' AND `entry` = 3071;
-- OLD name : [UNUSED] Guardia Narache (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=3082
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3082;
-- OLD name : Oculto
-- Source : https://www.wowhead.com/wotlk/es/npc=3094
UPDATE `creature_template_locale` SET `Name` = 'No visto' WHERE `locale` = 'esES' AND `entry` = 3094;
-- OLD name : Fela
-- Source : https://www.wowhead.com/wotlk/es/npc=3095
UPDATE `creature_template_locale` SET `Name` = 'Feela' WHERE `locale` = 'esES' AND `entry` = 3095;
-- OLD name : Pinzador makrura (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3103
UPDATE `creature_template_locale` SET `Name` = 'Pinzador Makrura' WHERE `locale` = 'esES' AND `entry` = 3103;
-- OLD name : Caparapiel makrura (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3104
UPDATE `creature_template_locale` SET `Name` = 'Caparapiel Makrura' WHERE `locale` = 'esES' AND `entry` = 3104;
-- OLD name : Quebrador makrura (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3105
UPDATE `creature_template_locale` SET `Name` = 'Quebrador Makrura' WHERE `locale` = 'esES' AND `entry` = 3105;
-- OLD name : Reptador de espuma
-- Source : https://www.wowhead.com/wotlk/es/npc=3106
UPDATE `creature_template_locale` SET `Name` = 'Reptador de espuma pigmeo' WHERE `locale` = 'esES' AND `entry` = 3106;
-- OLD name : Reptador de espuma adulto
-- Source : https://www.wowhead.com/wotlk/es/npc=3107
UPDATE `creature_template_locale` SET `Name` = 'Reptador de espuma' WHERE `locale` = 'esES' AND `entry` = 3107;
-- OLD name : Polvoroso Crines de Acero
-- Source : https://www.wowhead.com/wotlk/es/npc=3113
UPDATE `creature_template_locale` SET `Name` = 'Correpolvo Crines de Acero' WHERE `locale` = 'esES' AND `entry` = 3113;
-- OLD name : Rojomorro Garrasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=3123
UPDATE `creature_template_locale` SET `Name` = 'Garrasangre Rojomorro' WHERE `locale` = 'esES' AND `entry` = 3123;
-- OLD name : Escórpido obrero
-- Source : https://www.wowhead.com/wotlk/es/npc=3124
UPDATE `creature_template_locale` SET `Name` = 'Trabajador escórpido' WHERE `locale` = 'esES' AND `entry` = 3124;
-- OLD name : Escórpido castañeteante
-- Source : https://www.wowhead.com/wotlk/es/npc=3125
UPDATE `creature_template_locale` SET `Name` = 'Escórpido castañeante' WHERE `locale` = 'esES' AND `entry` = 3125;
-- OLD name : Lomorrayo
-- Source : https://www.wowhead.com/wotlk/es/npc=3131
UPDATE `creature_template_locale` SET `Name` = 'Pellejo de relámpagos' WHERE `locale` = 'esES' AND `entry` = 3131;
-- OLD name : Anciano makrura
-- Source : https://www.wowhead.com/wotlk/es/npc=3141
UPDATE `creature_template_locale` SET `Name` = 'Viejo Makrura' WHERE `locale` = 'esES' AND `entry` = 3141;
-- OLD name : Cultor Filo Ardiente
-- Source : https://www.wowhead.com/wotlk/es/npc=3199
UPDATE `creature_template_locale` SET `Name` = 'Fiel Filo Ardiente' WHERE `locale` = 'esES' AND `entry` = 3199;
-- OLD name : Eric's AAA Special Vendor
-- Source : https://www.wowhead.com/wotlk/es/npc=3200
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3200;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3200, 'esES','Vendor especial AAA de Eric',NULL);
-- OLD name : Scott Mercer
-- Source : https://www.wowhead.com/wotlk/es/npc=3201
UPDATE `creature_template_locale` SET `Name` = 'SM Test Mob' WHERE `locale` = 'esES' AND `entry` = 3201;
-- OLD name : Fizzle Garra Oscura
-- Source : https://www.wowhead.com/wotlk/es/npc=3203
UPDATE `creature_template_locale` SET `Name` = 'Fizzle Tormenta Oscura' WHERE `locale` = 'esES' AND `entry` = 3203;
-- OLD name : Kodo de Los Baldíos perdido (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3234
UPDATE `creature_template_locale` SET `Name` = 'Kodo de los Baldíos perdido' WHERE `locale` = 'esES' AND `entry` = 3234;
-- OLD name : Kodo de Los Baldíos superior (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3235
UPDATE `creature_template_locale` SET `Name` = 'Kodo de los Baldíos superior' WHERE `locale` = 'esES' AND `entry` = 3235;
-- OLD name : Kodo de Los Baldíos (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3236
UPDATE `creature_template_locale` SET `Name` = 'Kodo de los Baldíos' WHERE `locale` = 'esES' AND `entry` = 3236;
-- OLD name : Zancudo de llanura ornario
-- Source : https://www.wowhead.com/wotlk/es/npc=3245
UPDATE `creature_template_locale` SET `Name` = 'Zancudo ornario de llanura' WHERE `locale` = 'esES' AND `entry` = 3245;
-- OLD name : Jirafa de Los Baldíos (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3248
UPDATE `creature_template_locale` SET `Name` = 'Jirafa de los Baldíos' WHERE `locale` = 'esES' AND `entry` = 3248;
-- OLD name : Colazote Solescama (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3254
UPDATE `creature_template_locale` SET `Name` = 'Colazote solescama' WHERE `locale` = 'esES' AND `entry` = 3254;
-- OLD name : Estridador Solescama (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3255
UPDATE `creature_template_locale` SET `Name` = 'Estridador solescama' WHERE `locale` = 'esES' AND `entry` = 3255;
-- OLD name : Segador Solescama (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3256
UPDATE `creature_template_locale` SET `Name` = 'Segador solescama' WHERE `locale` = 'esES' AND `entry` = 3256;
-- OLD name : Desvalijador Crines de Acero
-- Source : https://www.wowhead.com/wotlk/es/npc=3267
UPDATE `creature_template_locale` SET `Name` = 'Buscaqua Crines de Acero' WHERE `locale` = 'esES' AND `entry` = 3267;
-- OLD name : Retador Kolkar
-- Source : https://www.wowhead.com/wotlk/es/npc=3272
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Kolkar' WHERE `locale` = 'esES' AND `entry` = 3272;
-- OLD name : Anomalía de lodo
-- Source : https://www.wowhead.com/wotlk/es/npc=3295
UPDATE `creature_template_locale` SET `Name` = 'Bestia lodo' WHERE `locale` = 'esES' AND `entry` = 3295;
-- OLD subname : Mercader de armaduras de tela
-- Source : https://www.wowhead.com/wotlk/es/npc=3317
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armaduras ligeras' WHERE `locale` = 'esES' AND `entry` = 3317;
-- OLD subname : Vendedora de arcos y rifles
-- Source : https://www.wowhead.com/wotlk/es/npc=3322
UPDATE `creature_template_locale` SET `Title` = 'Armas de fuego y munición' WHERE `locale` = 'esES' AND `entry` = 3322;
-- OLD name : Mirket
-- Source : https://www.wowhead.com/wotlk/es/npc=3325
UPDATE `creature_template_locale` SET `Name` = 'Mirkat' WHERE `locale` = 'esES' AND `entry` = 3325;
-- OLD subname : Maestro de perrera
-- Source : https://www.wowhead.com/wotlk/es/npc=3362
UPDATE `creature_template_locale` SET `Title` = 'Maestro Kennel' WHERE `locale` = 'esES' AND `entry` = 3362;
-- OLD subname : Venenos y componentes
-- Source : https://www.wowhead.com/wotlk/es/npc=3405
UPDATE `creature_template_locale` SET `Title` = 'Suministros de herboristería' WHERE `locale` = 'esES' AND `entry` = 3405;
-- OLD name : [UNUSED] Vigía Ancestral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=3420
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3420;
-- OLD name : Feegly el Exiliado (Old)
-- Source : https://www.wowhead.com/wotlk/es/npc=3421
UPDATE `creature_template_locale` SET `Name` = 'Feegly el Exiliado' WHERE `locale` = 'esES' AND `entry` = 3421;
-- OLD name : [UNUSED] Kendur (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=3427
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3427;
-- OLD name : [UNUSED] Sabio Ancestral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=3440
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3440;
-- OLD subname : Contratista independiente
-- Source : https://www.wowhead.com/wotlk/es/npc=3442
UPDATE `creature_template_locale` SET `Title` = 'Gremio de manitas' WHERE `locale` = 'esES' AND `entry` = 3442;
-- OLD name : Quijaforte de oasis
-- Source : https://www.wowhead.com/wotlk/es/npc=3461
UPDATE `creature_template_locale` SET `Name` = 'Quijaforte oasis' WHERE `locale` = 'esES' AND `entry` = 3461;
-- OLD name : Jirafa de Los Baldíos anciana
-- Source : https://www.wowhead.com/wotlk/es/npc=3462
UPDATE `creature_template_locale` SET `Name` = 'Jirafa vieja de los Baldíos' WHERE `locale` = 'esES' AND `entry` = 3462;
-- OLD name : Jirafa de Los Baldíos deambulante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3463
UPDATE `creature_template_locale` SET `Name` = 'Jirafa de los Baldíos deambulante' WHERE `locale` = 'esES' AND `entry` = 3463;
-- OLD name : Ironzar
-- Source : https://www.wowhead.com/wotlk/es/npc=3491
UPDATE `creature_template_locale` SET `Name` = 'Hierrozar' WHERE `locale` = 'esES' AND `entry` = 3491;
-- OLD name : Peletera Piroleña
-- Source : https://www.wowhead.com/wotlk/es/npc=3532
UPDATE `creature_template_locale` SET `Name` = 'Peletero Piroleña' WHERE `locale` = 'esES' AND `entry` = 3532;
-- OLD name : Robovigilante, versión 1
-- Source : https://www.wowhead.com/wotlk/es/npc=3538
UPDATE `creature_template_locale` SET `Name` = 'Robovigilante Mark I' WHERE `locale` = 'esES' AND `entry` = 3538;
-- OLD subname : Suministros de venenos
-- Source : https://www.wowhead.com/wotlk/es/npc=3558
UPDATE `creature_template_locale` SET `Title` = 'Suministros para venenos' WHERE `locale` = 'esES' AND `entry` = 3558;
-- OLD subname : Suministros de venenos
-- Source : https://www.wowhead.com/wotlk/es/npc=3559
UPDATE `creature_template_locale` SET `Title` = 'Suministros para venenos' WHERE `locale` = 'esES' AND `entry` = 3559;
-- OLD name : Maestro cervecero de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=3577
UPDATE `creature_template_locale` SET `Name` = 'Maestro cervecero de Dalaran' WHERE `locale` = 'esES' AND `entry` = 3577;
-- OLD name : Minero de Molino Ámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=3578
UPDATE `creature_template_locale` SET `Name` = 'Minero de Dalaran' WHERE `locale` = 'esES' AND `entry` = 3578;
-- OLD name : [UNUSED] Observador Kolkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=3651
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3651;
-- OLD name : Tritesta el Azotador
-- Source : https://www.wowhead.com/wotlk/es/npc=3652
UPDATE `creature_template_locale` SET `Name` = 'Trigore el Azotador' WHERE `locale` = 'esES' AND `entry` = 3652;
-- OLD subname : Druida del Colmillo
-- Source : https://www.wowhead.com/wotlk/es/npc=3672
UPDATE `creature_template_locale` SET `Title` = 'Druidas del colmillo' WHERE `locale` = 'esES' AND `entry` = 3672;
-- OLD name : Muyoh
-- Source : https://www.wowhead.com/wotlk/es/npc=3678
UPDATE `creature_template_locale` SET `Name` = 'Discípulo de Naralex' WHERE `locale` = 'esES' AND `entry` = 3678;
-- OLD name : Kyln Longclaw, subname : Boar Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=3697
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 3697;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (3697, 'esES','Kyln Garralarga','Instructor de jabalíes');
-- OLD subname : Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=3698
UPDATE `creature_template_locale` SET `Title` = 'Instructor de mascotas' WHERE `locale` = 'esES' AND `entry` = 3698;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=3699
UPDATE `creature_template_locale` SET `Title` = 'Instructora de felinos' WHERE `locale` = 'esES' AND `entry` = 3699;
-- OLD name : Forsaken Seeker[UNUSED]
-- Source : https://www.wowhead.com/wotlk/es/npc=3732
UPDATE `creature_template_locale` SET `Name` = 'Buscador Renegado' WHERE `locale` = 'esES' AND `entry` = 3732;
-- OLD name : Sobrestante orco
-- Source : https://www.wowhead.com/wotlk/es/npc=3734
UPDATE `creature_template_locale` SET `Name` = 'Matón Renegado' WHERE `locale` = 'esES' AND `entry` = 3734;
-- OLD name : Destripador Oscuro Mordenthal
-- Source : https://www.wowhead.com/wotlk/es/npc=3736
UPDATE `creature_template_locale` SET `Name` = 'Destriposcuro Mordenthal' WHERE `locale` = 'esES' AND `entry` = 3736;
-- OLD name : Sátiro Almaumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=3765
UPDATE `creature_template_locale` SET `Name` = 'Sátiro Lobrecuore' WHERE `locale` = 'esES' AND `entry` = 3765;
-- OLD name : Tramposo Almaumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=3767
UPDATE `creature_template_locale` SET `Name` = 'Tramposo Lobrecuore' WHERE `locale` = 'esES' AND `entry` = 3767;
-- OLD name : Acechasombras Almaumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=3770
UPDATE `creature_template_locale` SET `Name` = 'Acechasombras Lobrecuore' WHERE `locale` = 'esES' AND `entry` = 3770;
-- OLD name : Clamainferno Almaumbría
-- Source : https://www.wowhead.com/wotlk/es/npc=3771
UPDATE `creature_template_locale` SET `Name` = 'Clamainferno Lobrecuore' WHERE `locale` = 'esES' AND `entry` = 3771;
-- OLD name : Arrastrapiés chamuscado
-- Source : https://www.wowhead.com/wotlk/es/npc=3780
UPDATE `creature_template_locale` SET `Name` = 'Comemusgo Sombramatorral' WHERE `locale` = 'esES' AND `entry` = 3780;
-- OLD name : Reptador castañeteante
-- Source : https://www.wowhead.com/wotlk/es/npc=3812
UPDATE `creature_template_locale` SET `Name` = 'Reptador castañeante' WHERE `locale` = 'esES' AND `entry` = 3812;
-- OLD name : Acechador Espina Salvaje (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3819
UPDATE `creature_template_locale` SET `Name` = 'Acechador espina salvaje' WHERE `locale` = 'esES' AND `entry` = 3819;
-- OLD name : Escupetósigo Espina Salvaje (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3820
UPDATE `creature_template_locale` SET `Name` = 'Escupetósigo espina salvaje' WHERE `locale` = 'esES' AND `entry` = 3820;
-- OLD name : Rondador Espina Salvaje (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3821
UPDATE `creature_template_locale` SET `Name` = 'Rondador espina salvaje' WHERE `locale` = 'esES' AND `entry` = 3821;
-- OLD name : Corredor Garraespectro
-- Source : https://www.wowhead.com/wotlk/es/npc=3823
UPDATE `creature_template_locale` SET `Name` = 'Corredor Fangarra' WHERE `locale` = 'esES' AND `entry` = 3823;
-- OLD name : Aullador Garraespectro
-- Source : https://www.wowhead.com/wotlk/es/npc=3824
UPDATE `creature_template_locale` SET `Name` = 'Aullador Fangarra' WHERE `locale` = 'esES' AND `entry` = 3824;
-- OLD name : Alfa Garraespectro
-- Source : https://www.wowhead.com/wotlk/es/npc=3825
UPDATE `creature_template_locale` SET `Name` = 'Alfa Fangarra' WHERE `locale` = 'esES' AND `entry` = 3825;
-- OLD name : Garraespectro rabioso
-- Source : https://www.wowhead.com/wotlk/es/npc=3826
UPDATE `creature_template_locale` SET `Name` = 'Patafantasma rabioso' WHERE `locale` = 'esES' AND `entry` = 3826;
-- OLD name : Druida del Colmillo
-- Source : https://www.wowhead.com/wotlk/es/npc=3840
UPDATE `creature_template_locale` SET `Name` = 'Druidas del Colmillo' WHERE `locale` = 'esES' AND `entry` = 3840;
-- OLD name : Teldira Plumalunar
-- Source : https://www.wowhead.com/wotlk/es/npc=3841
UPDATE `creature_template_locale` SET `Name` = 'Caylais Plumalunar' WHERE `locale` = 'esES' AND `entry` = 3841;
-- OLD name : [UNUSED] Aullasangre Colmillo Oscuro
-- Source : https://www.wowhead.com/wotlk/es/npc=3852
UPDATE `creature_template_locale` SET `Name` = 'Aullasangre Colmillo Oscuro' WHERE `locale` = 'esES' AND `entry` = 3852;
-- OLD name : [UNUSED] Corrupto Colmillo Oscuro
-- Source : https://www.wowhead.com/wotlk/es/npc=3860
UPDATE `creature_template_locale` SET `Name` = 'Corrupto Colmillo Oscuro' WHERE `locale` = 'esES' AND `entry` = 3860;
-- OLD name : Huargo babeante
-- Source : https://www.wowhead.com/wotlk/es/npc=3862
UPDATE `creature_template_locale` SET `Name` = 'Huargo esclavizante' WHERE `locale` = 'esES' AND `entry` = 3862;
-- OLD name : Horror lupino (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=3863
UPDATE `creature_template_locale` SET `Name` = 'Horror Lupino' WHERE `locale` = 'esES' AND `entry` = 3863;
-- OLD name : [UNUSED] Espíritu traumatizado
-- Source : https://www.wowhead.com/wotlk/es/npc=3876
UPDATE `creature_template_locale` SET `Name` = 'Espíritu traumatizado' WHERE `locale` = 'esES' AND `entry` = 3876;
-- OLD name : Custodio gemebundo
-- Source : https://www.wowhead.com/wotlk/es/npc=3877
UPDATE `creature_template_locale` SET `Name` = 'Custodio de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 3877;
-- OLD name : Caedakar el Sañoso
-- Source : https://www.wowhead.com/wotlk/es/npc=3900
UPDATE `creature_template_locale` SET `Name` = 'Caedakar el Vicioso' WHERE `locale` = 'esES' AND `entry` = 3900;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=3966
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 3966;
-- OLD subname : Vendedor de venenos
-- Source : https://www.wowhead.com/wotlk/es/npc=3969
UPDATE `creature_template_locale` SET `Title` = 'Herramientas y suministros' WHERE `locale` = 'esES' AND `entry` = 3969;
-- OLD name : Maderero de Ventura y Cía.
-- Source : https://www.wowhead.com/wotlk/es/npc=3989
UPDATE `creature_template_locale` SET `Name` = 'Leñador de Ventura y Cía.' WHERE `locale` = 'esES' AND `entry` = 3989;
-- OLD name : Resistente de Ventura y Cía.
-- Source : https://www.wowhead.com/wotlk/es/npc=3992
UPDATE `creature_template_locale` SET `Name` = 'Ingeniero de Ventura y Cía.' WHERE `locale` = 'esES' AND `entry` = 3992;
-- OLD name : Cantero Cortaviento
-- Source : https://www.wowhead.com/wotlk/es/npc=4002
UPDATE `creature_template_locale` SET `Name` = 'Cortapiedras Cortaviento' WHERE `locale` = 'esES' AND `entry` = 4002;
-- OLD name : Señor supremo Cortaviento (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4004
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo Cortaviento' WHERE `locale` = 'esES' AND `entry` = 4004;
-- OLD name : Alaorgullo joven
-- Source : https://www.wowhead.com/wotlk/es/npc=4011
UPDATE `creature_template_locale` SET `Name` = 'Alargullo joven' WHERE `locale` = 'esES' AND `entry` = 4011;
-- OLD name : Cazacielos Alaorgullo
-- Source : https://www.wowhead.com/wotlk/es/npc=4013
UPDATE `creature_template_locale` SET `Name` = 'Cazacielos Alargullo' WHERE `locale` = 'esES' AND `entry` = 4013;
-- OLD name : Dragón hada avispado
-- Source : https://www.wowhead.com/wotlk/es/npc=4017
UPDATE `creature_template_locale` SET `Name` = 'Dragón hada Wily' WHERE `locale` = 'esES' AND `entry` = 4017;
-- OLD name : Bestia de savia corrupta
-- Source : https://www.wowhead.com/wotlk/es/npc=4021
UPDATE `creature_template_locale` SET `Name` = 'Bestia de savia corrosiva' WHERE `locale` = 'esES' AND `entry` = 4021;
-- OLD name : Anciano vengativo
-- Source : https://www.wowhead.com/wotlk/es/npc=4030
UPDATE `creature_template_locale` SET `Name` = 'Ancestro vengativo' WHERE `locale` = 'esES' AND `entry` = 4030;
-- OLD name : Quimera volantona
-- Source : https://www.wowhead.com/wotlk/es/npc=4031
UPDATE `creature_template_locale` SET `Name` = 'Quimera emplumada' WHERE `locale` = 'esES' AND `entry` = 4031;
-- OLD name : Espíritu flameante huido
-- Source : https://www.wowhead.com/wotlk/es/npc=4036
UPDATE `creature_template_locale` SET `Name` = 'Pícaro espíritu flameante' WHERE `locale` = 'esES' AND `entry` = 4036;
-- OLD name : JEFF CHOW TEST
-- Source : https://www.wowhead.com/wotlk/es/npc=4045
UPDATE `creature_template_locale` SET `Name` = NULL WHERE `locale` = 'esES' AND `entry` = 4045;
-- OLD name : Seereth Petrajada
-- Source : https://www.wowhead.com/wotlk/es/npc=4049
UPDATE `creature_template_locale` SET `Name` = 'Seereth Rompepedras' WHERE `locale` = 'esES' AND `entry` = 4049;
-- OLD name : Botánico Cenarion
-- Source : https://www.wowhead.com/wotlk/es/npc=4051
UPDATE `creature_template_locale` SET `Name` = 'Botánica Cenarion' WHERE `locale` = 'esES' AND `entry` = 4051;
-- OLD name : Caminaclaros Mirkfallon
-- Source : https://www.wowhead.com/wotlk/es/npc=4055
UPDATE `creature_template_locale` SET `Name` = 'Claronduz Mirkfallon' WHERE `locale` = 'esES' AND `entry` = 4055;
-- OLD subname : Vendedor de armaduras de Ventura y Cía.
-- Source : https://www.wowhead.com/wotlk/es/npc=4085
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de armaduras de Venture y Cía.' WHERE `locale` = 'esES' AND `entry` = 4085;
-- OLD name : Arias'ta Rugefilo
-- Source : https://www.wowhead.com/wotlk/es/npc=4087
UPDATE `creature_template_locale` SET `Name` = 'Arias''ta Filovoz' WHERE `locale` = 'esES' AND `entry` = 4087;
-- OLD name : Retador Galak
-- Source : https://www.wowhead.com/wotlk/es/npc=4093
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Galak' WHERE `locale` = 'esES' AND `entry` = 4093;
-- OLD name : Dracoleón de Nido Alto
-- Source : https://www.wowhead.com/wotlk/es/npc=4107
UPDATE `creature_template_locale` SET `Name` = 'Dracoleón Nido Alto' WHERE `locale` = 'esES' AND `entry` = 4107;
-- OLD name : Consorte de Nido Alto
-- Source : https://www.wowhead.com/wotlk/es/npc=4109
UPDATE `creature_template_locale` SET `Name` = 'Consorte Nido Alto' WHERE `locale` = 'esES' AND `entry` = 4109;
-- OLD name : Patriarca de Nido Alto
-- Source : https://www.wowhead.com/wotlk/es/npc=4110
UPDATE `creature_template_locale` SET `Name` = 'Patriarca Nido Alto' WHERE `locale` = 'esES' AND `entry` = 4110;
-- OLD name : Supervisor Gravamorro
-- Source : https://www.wowhead.com/wotlk/es/npc=4116
UPDATE `creature_template_locale` SET `Name` = 'Vigilante Gravamorro' WHERE `locale` = 'esES' AND `entry` = 4116;
-- OLD name : Serpiente nubosa anciana
-- Source : https://www.wowhead.com/wotlk/es/npc=4119
UPDATE `creature_template_locale` SET `Name` = 'Serpiente nubosa vieja' WHERE `locale` = 'esES' AND `entry` = 4119;
-- OLD name : Krkk'kx
-- Source : https://www.wowhead.com/wotlk/es/npc=4132
UPDATE `creature_template_locale` SET `Name` = 'Devastador silítido' WHERE `locale` = 'esES' AND `entry` = 4132;
-- OLD name : Zángano de colmena silítido
-- Source : https://www.wowhead.com/wotlk/es/npc=4133
UPDATE `creature_template_locale` SET `Name` = 'Zángano de la Colmena silítida' WHERE `locale` = 'esES' AND `entry` = 4133;
-- OLD name : Tortuga Brillavalva
-- Source : https://www.wowhead.com/wotlk/es/npc=4142
UPDATE `creature_template_locale` SET `Name` = 'Tortuga caparallante' WHERE `locale` = 'esES' AND `entry` = 4142;
-- OLD name : Sacudidor Brillavalva
-- Source : https://www.wowhead.com/wotlk/es/npc=4143
UPDATE `creature_template_locale` SET `Name` = 'Sacudidor caparallante' WHERE `locale` = 'esES' AND `entry` = 4143;
-- OLD name : Cavapozos Brillavalva
-- Source : https://www.wowhead.com/wotlk/es/npc=4144
UPDATE `creature_template_locale` SET `Name` = 'Cavapozos caparallante' WHERE `locale` = 'esES' AND `entry` = 4144;
-- OLD subname : Foraging Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4149
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forrajes' WHERE `locale` = 'esES' AND `entry` = 4149;
-- OLD subname : Cat Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4153
UPDATE `creature_template_locale` SET `Title` = 'Instructora de felinos' WHERE `locale` = 'esES' AND `entry` = 4153;
-- OLD name : Carroñero del Desierto de Sal
-- Source : https://www.wowhead.com/wotlk/es/npc=4154
UPDATE `creature_template_locale` SET `Name` = 'Carroñero de los Llanos de Sal' WHERE `locale` = 'esES' AND `entry` = 4154;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4157
UPDATE `creature_template_locale` SET `Title` = 'Profesora de cartografía' WHERE `locale` = 'esES' AND `entry` = 4157;
-- OLD name : Buitre del Desierto de Sal
-- Source : https://www.wowhead.com/wotlk/es/npc=4158
UPDATE `creature_template_locale` SET `Name` = 'Buitre de los Llanos de Sal' WHERE `locale` = 'esES' AND `entry` = 4158;
-- OLD subname : Arrow Merchant
-- Source : https://www.wowhead.com/wotlk/es/npc=4174
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 4174;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4174, 'esES',NULL,'Mercader de flechas');
-- OLD subname : Mercader de armaduras de malla
-- Source : https://www.wowhead.com/wotlk/es/npc=4178
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armaduras' WHERE `locale` = 'esES' AND `entry` = 4178;
-- OLD subname : Bear Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4206
UPDATE `creature_template_locale` SET `Title` = 'Instructor de osos' WHERE `locale` = 'esES' AND `entry` = 4206;
-- OLD subname : Wolf Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4207
UPDATE `creature_template_locale` SET `Title` = 'Instructor de lobos' WHERE `locale` = 'esES' AND `entry` = 4207;
-- OLD subname : Cartography Supplies
-- Source : https://www.wowhead.com/wotlk/es/npc=4224
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 4224;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4224, 'esES',NULL,'Suministros de cartografía');
-- OLD name : Acompañante sable de hielo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4242
UPDATE `creature_template_locale` SET `Name` = 'Acompañante Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 4242;
-- OLD name : Hiena Pestillejo
-- Source : https://www.wowhead.com/wotlk/es/npc=4248
UPDATE `creature_template_locale` SET `Name` = 'Hiena Molestapiel' WHERE `locale` = 'esES' AND `entry` = 4248;
-- OLD name : Gruñidor Pestillejo
-- Source : https://www.wowhead.com/wotlk/es/npc=4249
UPDATE `creature_template_locale` SET `Name` = 'Gruñidor Irriculto' WHERE `locale` = 'esES' AND `entry` = 4249;
-- OLD name : Forma de oso (elfo de la noche druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=4253
UPDATE `creature_template_locale` SET `Name` = 'Forma de oso (druida elfo de la noche)' WHERE `locale` = 'esES' AND `entry` = 4253;
-- OLD name : Forma de oso (tauren druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=4261
UPDATE `creature_template_locale` SET `Name` = 'Forma de oso (druida tauren)' WHERE `locale` = 'esES' AND `entry` = 4261;
-- OLD name : Lobo grisáceo
-- Source : https://www.wowhead.com/wotlk/es/npc=4268
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar (grisáceo)' WHERE `locale` = 'esES' AND `entry` = 4268;
-- OLD name : Yegua zaina
-- Source : https://www.wowhead.com/wotlk/es/npc=4269
UPDATE `creature_template_locale` SET `Name` = 'Caballo de montar (zaino)' WHERE `locale` = 'esES' AND `entry` = 4269;
-- OLD name : Lobo rojo
-- Source : https://www.wowhead.com/wotlk/es/npc=4270
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar (rojo)' WHERE `locale` = 'esES' AND `entry` = 4270;
-- OLD name : Odo el Vigía Ciego (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4279
UPDATE `creature_template_locale` SET `Name` = 'Odo el vigía ciego' WHERE `locale` = 'esES' AND `entry` = 4279;
-- OLD name : [UNUSED] [PH] Embajador Saylaton Pezuñamorta (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=4313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 4313;
-- OLD subname : Maestro de jinetes del viento
-- Source : https://www.wowhead.com/wotlk/es/npc=4314
UPDATE `creature_template_locale` SET `Title` = 'Maestro de jinete del viento' WHERE `locale` = 'esES' AND `entry` = 4314;
-- OLD name : [UNUSED] Guthrin Pezuñamorta (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=4315
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 4315;
-- OLD name : Malafauce secorrón
-- Source : https://www.wowhead.com/wotlk/es/npc=4342
UPDATE `creature_template_locale` SET `Name` = 'Mentovilo secorrón' WHERE `locale` = 'esES' AND `entry` = 4342;
-- OLD name : Bestia de lodazal Parramustia
-- Source : https://www.wowhead.com/wotlk/es/npc=4387
UPDATE `creature_template_locale` SET `Name` = 'Lodobestia Parramustia' WHERE `locale` = 'esES' AND `entry` = 4387;
-- OLD name : Trillador de la oscuridad anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=4390
UPDATE `creature_template_locale` SET `Name` = 'Trillador de la oscuridad mayor' WHERE `locale` = 'esES' AND `entry` = 4390;
-- OLD name : Moco del pantano corrosivo
-- Source : https://www.wowhead.com/wotlk/es/npc=4392
UPDATE `creature_template_locale` SET `Name` = 'Moco corrosivo del pantano' WHERE `locale` = 'esES' AND `entry` = 4392;
-- OLD name : Moco del pantano ácido
-- Source : https://www.wowhead.com/wotlk/es/npc=4393
UPDATE `creature_template_locale` SET `Name` = 'Moco ácido del pantano' WHERE `locale` = 'esES' AND `entry` = 4393;
-- OLD name : Moco del pantano virulento
-- Source : https://www.wowhead.com/wotlk/es/npc=4395
UPDATE `creature_template_locale` SET `Name` = 'Moco de pantano virulento' WHERE `locale` = 'esES' AND `entry` = 4395;
-- OLD name : Forma acuática (elfo de la noche druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=4408
UPDATE `creature_template_locale` SET `Name` = 'Forma acuática (Druida elfo de la noche)' WHERE `locale` = 'esES' AND `entry` = 4408;
-- OLD name : Guardián Kordurus
-- Source : https://www.wowhead.com/wotlk/es/npc=4409
UPDATE `creature_template_locale` SET `Name` = 'Portero Kordurus' WHERE `locale` = 'esES' AND `entry` = 4409;
-- OLD name : Forma acuática (tauren druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=4410
UPDATE `creature_template_locale` SET `Name` = 'Forma acuática (Druida tauren)' WHERE `locale` = 'esES' AND `entry` = 4410;
-- OLD name : Rondador Colmiumbrío
-- Source : https://www.wowhead.com/wotlk/es/npc=4411
UPDATE `creature_template_locale` SET `Name` = 'Rondador Colmilloumbrío' WHERE `locale` = 'esES' AND `entry` = 4411;
-- OLD name : Trepador Colmiumbrío
-- Source : https://www.wowhead.com/wotlk/es/npc=4412
UPDATE `creature_template_locale` SET `Name` = 'Trepador Colmilloumbrío' WHERE `locale` = 'esES' AND `entry` = 4412;
-- OLD name : Araña Colmiumbrío
-- Source : https://www.wowhead.com/wotlk/es/npc=4413
UPDATE `creature_template_locale` SET `Name` = 'Araña Colmilloumbrío' WHERE `locale` = 'esES' AND `entry` = 4413;
-- OLD name : Escupetósigo Colmiumbrío
-- Source : https://www.wowhead.com/wotlk/es/npc=4414
UPDATE `creature_template_locale` SET `Name` = 'Escupetósigo Colmilloumbrío' WHERE `locale` = 'esES' AND `entry` = 4414;
-- OLD name : Araña Colmiumbrío gigante
-- Source : https://www.wowhead.com/wotlk/es/npc=4415
UPDATE `creature_template_locale` SET `Name` = 'Araña Colmilloumbrío gigante' WHERE `locale` = 'esES' AND `entry` = 4415;
-- OLD name : Race Master Kronkrider
-- Source : https://www.wowhead.com/wotlk/es/npc=4419
UPDATE `creature_template_locale` SET `Name` = 'Maestro del circuito Kronkpiloto' WHERE `locale` = 'esES' AND `entry` = 4419;
-- OLD subname : Totem Merchent
-- Source : https://www.wowhead.com/wotlk/es/npc=4443
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 4443;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (4443, 'esES',NULL,'Mercader de tótems');
-- OLD name : Crazzle Engranágil, subname : Canjeador de vales gnomo
-- Source : https://www.wowhead.com/wotlk/es/npc=4449
UPDATE `creature_template_locale` SET `Name` = 'Crazzle Energiodentado',`Title` = 'Canjeador de vales de gnomo' WHERE `locale` = 'esES' AND `entry` = 4449;
-- OLD subname : Canjeador de vales goblin
-- Source : https://www.wowhead.com/wotlk/es/npc=4450
UPDATE `creature_template_locale` SET `Title` = 'Canjeador de vales de goblin' WHERE `locale` = 'esES' AND `entry` = 4450;
-- OLD name : Gélido Ancaniebla
-- Source : https://www.wowhead.com/wotlk/es/npc=4460
UPDATE `creature_template_locale` SET `Name` = 'Señor Ancaniebla' WHERE `locale` = 'esES' AND `entry` = 4460;
-- OLD name : Moco esmeralda (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4469
UPDATE `creature_template_locale` SET `Name` = 'Moco Esmeralda' WHERE `locale` = 'esES' AND `entry` = 4469;
-- OLD name : Visión mortificadora
-- Source : https://www.wowhead.com/wotlk/es/npc=4472
UPDATE `creature_template_locale` SET `Name` = 'Visión encantada' WHERE `locale` = 'esES' AND `entry` = 4472;
-- OLD name : Cadáver en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=4474
UPDATE `creature_template_locale` SET `Name` = 'Cadáver putrefacto' WHERE `locale` = 'esES' AND `entry` = 4474;
-- OLD name : Braug Espíritu Tenue
-- Source : https://www.wowhead.com/wotlk/es/npc=4489
UPDATE `creature_template_locale` SET `Name` = 'Braug Espiritoscuro' WHERE `locale` = 'esES' AND `entry` = 4489;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=4578
UPDATE `creature_template_locale` SET `Title` = 'Maestra sastre de tejido de sombra' WHERE `locale` = 'esES' AND `entry` = 4578;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4579
UPDATE `creature_template_locale` SET `Title` = 'Profesor de cartografía' WHERE `locale` = 'esES' AND `entry` = 4579;
-- OLD subname : Raptor Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4621
UPDATE `creature_template_locale` SET `Title` = 'Instructor de raptores' WHERE `locale` = 'esES' AND `entry` = 4621;
-- OLD name : Aplastador Kolkar
-- Source : https://www.wowhead.com/wotlk/es/npc=4634
UPDATE `creature_template_locale` SET `Name` = 'Destructor Kolkar' WHERE `locale` = 'esES' AND `entry` = 4634;
-- OLD name : Retador Magram
-- Source : https://www.wowhead.com/wotlk/es/npc=4640
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Magram' WHERE `locale` = 'esES' AND `entry` = 4640;
-- OLD name : Coceador Gelkis
-- Source : https://www.wowhead.com/wotlk/es/npc=4648
UPDATE `creature_template_locale` SET `Name` = 'Timbrador Gelkis' WHERE `locale` = 'esES' AND `entry` = 4648;
-- OLD name : Clamatierras Gelkis
-- Source : https://www.wowhead.com/wotlk/es/npc=4651
UPDATE `creature_template_locale` SET `Name` = 'Clamor de Tierra Gelkis' WHERE `locale` = 'esES' AND `entry` = 4651;
-- OLD name : Retador Maraudine
-- Source : https://www.wowhead.com/wotlk/es/npc=4655
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Maraudine' WHERE `locale` = 'esES' AND `entry` = 4655;
-- OLD name : Capitán guardiavil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4680
UPDATE `creature_template_locale` SET `Name` = 'Capitán Guardiavil' WHERE `locale` = 'esES' AND `entry` = 4680;
-- OLD name : Zarpósea famélica
-- Source : https://www.wowhead.com/wotlk/es/npc=4689
UPDATE `creature_template_locale` SET `Name` = 'Zarpósea famélico' WHERE `locale` = 'esES' AND `entry` = 4689;
-- OLD name : Volador aterrador
-- Source : https://www.wowhead.com/wotlk/es/npc=4693
UPDATE `creature_template_locale` SET `Name` = 'Volater aterrador' WHERE `locale` = 'esES' AND `entry` = 4693;
-- OLD name : Truenagarto anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=4727
UPDATE `creature_template_locale` SET `Name` = 'Ancestro truenagarto' WHERE `locale` = 'esES' AND `entry` = 4727;
-- OLD name : Basilisco Faucegrava
-- Source : https://www.wowhead.com/wotlk/es/npc=4728
UPDATE `creature_template_locale` SET `Name` = 'Basilisco Gritfauces' WHERE `locale` = 'esES' AND `entry` = 4728;
-- OLD name : Basilisco Faucegrava descomunal
-- Source : https://www.wowhead.com/wotlk/es/npc=4729
UPDATE `creature_template_locale` SET `Name` = 'Basilisco gritfauces descomunal' WHERE `locale` = 'esES' AND `entry` = 4729;
-- OLD name : Ultham Ferrocorno
-- Source : https://www.wowhead.com/wotlk/es/npc=4772
UPDATE `creature_template_locale` SET `Name` = 'Ulthaan Ferrocorno' WHERE `locale` = 'esES' AND `entry` = 4772;
-- OLD name : Carnero blanco
-- Source : https://www.wowhead.com/wotlk/es/npc=4777
UPDATE `creature_template_locale` SET `Name` = 'Carnero de montar (blanco)' WHERE `locale` = 'esES' AND `entry` = 4777;
-- OLD name : Carnero de escarcha
-- Source : https://www.wowhead.com/wotlk/es/npc=4778
UPDATE `creature_template_locale` SET `Name` = 'Carnero de montar (azul)' WHERE `locale` = 'esES' AND `entry` = 4778;
-- OLD name : Carnero negro
-- Source : https://www.wowhead.com/wotlk/es/npc=4780
UPDATE `creature_template_locale` SET `Name` = 'Carnero de montar (negro)' WHERE `locale` = 'esES' AND `entry` = 4780;
-- OLD name : Clamatierras Halmgar
-- Source : https://www.wowhead.com/wotlk/es/npc=4842
UPDATE `creature_template_locale` SET `Name` = 'Clamor de Tierra Halmgar' WHERE `locale` = 'esES' AND `entry` = 4842;
-- OLD name : Gólem obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=4872
UPDATE `creature_template_locale` SET `Name` = 'Gólem Obsidiano' WHERE `locale` = 'esES' AND `entry` = 4872;
-- OLD subname : Turtle Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4881
UPDATE `creature_template_locale` SET `Title` = 'Instructor de tortugas' WHERE `locale` = 'esES' AND `entry` = 4881;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=4888
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armas' WHERE `locale` = 'esES' AND `entry` = 4888;
-- OLD subname : Instructor de cazadores y arquero
-- Source : https://www.wowhead.com/wotlk/es/npc=4892
UPDATE `creature_template_locale` SET `Title` = 'Fabricante de arcos' WHERE `locale` = 'esES' AND `entry` = 4892;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=4894
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 4894;
-- OLD subname : Pertrechos y componentes
-- Source : https://www.wowhead.com/wotlk/es/npc=4896
UPDATE `creature_template_locale` SET `Title` = 'Pertrechos' WHERE `locale` = 'esES' AND `entry` = 4896;
-- OLD name : Culebra de agua
-- Source : https://www.wowhead.com/wotlk/es/npc=4953
UPDATE `creature_template_locale` SET `Name` = 'Mocasín' WHERE `locale` = 'esES' AND `entry` = 4953;
-- OLD name : Espíritu mortificador
-- Source : https://www.wowhead.com/wotlk/es/npc=4958
UPDATE `creature_template_locale` SET `Name` = 'Espíritu encantado' WHERE `locale` = 'esES' AND `entry` = 4958;
-- OLD name : Matón del Casco Antiguo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=4969
UPDATE `creature_template_locale` SET `Name` = 'Matón del casco antiguo' WHERE `locale` = 'esES' AND `entry` = 4969;
-- OLD name : Conchablanda Sombroscura
-- Source : https://www.wowhead.com/wotlk/es/npc=4977
UPDATE `creature_template_locale` SET `Name` = 'Caparasuave Sombroscura' WHERE `locale` = 'esES' AND `entry` = 4977;
-- OLD name : Instructora mundial de lobos, subname : Wolf Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=4994
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de lobos de montar',`Title` = 'Instructora de lobos' WHERE `locale` = 'esES' AND `entry` = 4994;
-- OLD name : Guardia de las Mazmorras
-- Source : https://www.wowhead.com/wotlk/es/npc=4995
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la Empalizada' WHERE `locale` = 'esES' AND `entry` = 4995;
-- OLD subname : Bird Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5001
UPDATE `creature_template_locale` SET `Title` = 'Instructora de aves' WHERE `locale` = 'esES' AND `entry` = 5001;
-- OLD name : World Boar Trainer, subname : Boar Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5002
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5002;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (5002, 'esES','Instructora mundial de jabalíes','Instructora de jabalíes');
-- OLD subname : Cat Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5003
UPDATE `creature_template_locale` SET `Title` = 'Instructora de felinos' WHERE `locale` = 'esES' AND `entry` = 5003;
-- OLD subname : Crawler Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5004
UPDATE `creature_template_locale` SET `Title` = 'Instructora de reptadores' WHERE `locale` = 'esES' AND `entry` = 5004;
-- OLD subname : Crocodile Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5005
UPDATE `creature_template_locale` SET `Title` = 'Instructora de cocodrilos' WHERE `locale` = 'esES' AND `entry` = 5005;
-- OLD name : Instructora mundial de demonios -old, subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=5006
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de demonios',`Title` = 'Instructora de demonios' WHERE `locale` = 'esES' AND `entry` = 5006;
-- OLD subname : Gorilla Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5008
UPDATE `creature_template_locale` SET `Title` = 'Instructora de gorilas' WHERE `locale` = 'esES' AND `entry` = 5008;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5009
UPDATE `creature_template_locale` SET `Title` = 'Instructora de caballos' WHERE `locale` = 'esES' AND `entry` = 5009;
-- OLD subname : Raptor Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5011
UPDATE `creature_template_locale` SET `Title` = 'Instructora de raptores' WHERE `locale` = 'esES' AND `entry` = 5011;
-- OLD subname : Scorpid Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5012
UPDATE `creature_template_locale` SET `Title` = 'Instructora de escórpidos' WHERE `locale` = 'esES' AND `entry` = 5012;
-- OLD subname : Spider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5013
UPDATE `creature_template_locale` SET `Title` = 'Instructora de arañas' WHERE `locale` = 'esES' AND `entry` = 5013;
-- OLD subname : Tallstrider Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5015
UPDATE `creature_template_locale` SET `Title` = 'Instructora de zancaaltas' WHERE `locale` = 'esES' AND `entry` = 5015;
-- OLD subname : Turtle Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5017
UPDATE `creature_template_locale` SET `Title` = 'Instructora de tortugas' WHERE `locale` = 'esES' AND `entry` = 5017;
-- OLD name : Portal mundial: Instructora de Forjaz, subname : Portal: Instructora de Forjaz
-- Source : https://www.wowhead.com/wotlk/es/npc=5019
UPDATE `creature_template_locale` SET `Name` = 'Portal mundial: Instructor de Forjaz',`Title` = 'Portal: Instructor de Forjaz' WHERE `locale` = 'esES' AND `entry` = 5019;
-- OLD name : Portal mundial: Instructora de Ventormenta, subname : Portal: Instructora de Ventormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=5021
UPDATE `creature_template_locale` SET `Name` = 'Portal mundial: Instructor de Ventormenta',`Title` = 'Portal: Instructor de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 5021;
-- OLD name : Portal mundial: Instructora de Cima del Trueno, subname : Portal: Instructora de Cima del Trueno
-- Source : https://www.wowhead.com/wotlk/es/npc=5022
UPDATE `creature_template_locale` SET `Name` = 'Portal mundial: Instructor de Cima del Trueno',`Title` = 'Portal: Instructor de Cima del Trueno' WHERE `locale` = 'esES' AND `entry` = 5022;
-- OLD name : Portal mundial: Instructora de Entrañas, subname : Portal: Instructora de Entrañas
-- Source : https://www.wowhead.com/wotlk/es/npc=5023
UPDATE `creature_template_locale` SET `Name` = 'Portal mundial: Instructor de Entrañas',`Title` = 'Portal: Instructor de Entrañas' WHERE `locale` = 'esES' AND `entry` = 5023;
-- OLD subname : Horse Riding Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5026
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 5026;
-- OLD name : [PH] Barrera de dolor mogu, subname : Lockpicking Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5027
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de forzamiento de cerraduras',`Title` = 'Instructora en el arte de forzar cerraduras' WHERE `locale` = 'esES' AND `entry` = 5027;
-- OLD name : Jiming, subname : Survival Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5029
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de supervivencia',`Title` = 'Instructora de supervivencia' WHERE `locale` = 'esES' AND `entry` = 5029;
-- OLD subname : Tiger Riding Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5030
UPDATE `creature_template_locale` SET `Title` = 'Instructora de jinetes de tigre' WHERE `locale` = 'esES' AND `entry` = 5030;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=5033
UPDATE `creature_template_locale` SET `Title` = 'Instructora de herreros' WHERE `locale` = 'esES' AND `entry` = 5033;
-- OLD name : Winwa, subname : Brewing Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5034
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de elaboración de cerveza',`Title` = 'Instructora de elaboración de cerveza' WHERE `locale` = 'esES' AND `entry` = 5034;
-- OLD subname : Cartography Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5035
UPDATE `creature_template_locale` SET `Title` = 'Profesora de cartografía' WHERE `locale` = 'esES' AND `entry` = 5035;
-- OLD name : Instructora mundial de rastreadores DEPRECATED, subname : Instructora de brujos
-- Source : https://www.wowhead.com/wotlk/es/npc=5039
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de rastreadores',`Title` = 'Instructora de rastreo' WHERE `locale` = 'esES' AND `entry` = 5039;
-- OLD name : Alborotador
-- Source : https://www.wowhead.com/wotlk/es/npc=5043
UPDATE `creature_template_locale` SET `Name` = 'Alborotador Defias' WHERE `locale` = 'esES' AND `entry` = 5043;
-- OLD name : Hostigador de Theramore
-- Source : https://www.wowhead.com/wotlk/es/npc=5044
UPDATE `creature_template_locale` SET `Name` = 'Pendenciero de Theramonte' WHERE `locale` = 'esES' AND `entry` = 5044;
-- OLD name : Banquera mundial
-- Source : https://www.wowhead.com/wotlk/es/npc=5060
UPDATE `creature_template_locale` SET `Name` = 'Banquero mundial' WHERE `locale` = 'esES' AND `entry` = 5060;
-- OLD name : Pagador Lendry
-- Source : https://www.wowhead.com/wotlk/es/npc=5083
UPDATE `creature_template_locale` SET `Name` = 'Secretario Lendry' WHERE `locale` = 'esES' AND `entry` = 5083;
-- OLD name : Delusión lupina
-- Source : https://www.wowhead.com/wotlk/es/npc=5097
UPDATE `creature_template_locale` SET `Name` = 'Falsa ilusión Lupina' WHERE `locale` = 'esES' AND `entry` = 5097;
-- OLD subname : Gun Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5104
UPDATE `creature_template_locale` SET `Title` = 'Instructora de armas de fuego' WHERE `locale` = 'esES' AND `entry` = 5104;
-- OLD name : Raena Martílex
-- Source : https://www.wowhead.com/wotlk/es/npc=5108
UPDATE `creature_template_locale` SET `Name` = 'Raena Marquílex' WHERE `locale` = 'esES' AND `entry` = 5108;
-- OLD name : Dolkin Yelmorrisco
-- Source : https://www.wowhead.com/wotlk/es/npc=5125
UPDATE `creature_template_locale` SET `Name` = 'Dolkin Yelmorisco' WHERE `locale` = 'esES' AND `entry` = 5125;
-- OLD name : Olthran Yelmorrisco
-- Source : https://www.wowhead.com/wotlk/es/npc=5126
UPDATE `creature_template_locale` SET `Name` = 'Olthran Yelmorisco' WHERE `locale` = 'esES' AND `entry` = 5126;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=5164
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armaduras' WHERE `locale` = 'esES' AND `entry` = 5164;
-- OLD name : Ogro mago Gordunni
-- Source : https://www.wowhead.com/wotlk/es/npc=5237
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Gordunni' WHERE `locale` = 'esES' AND `entry` = 5237;
-- OLD name : Señor de la magia Gordunni (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5239
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Magia Gordunni' WHERE `locale` = 'esES' AND `entry` = 5239;
-- OLD name : Sumo sacerdote Atal'ai (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5273
UPDATE `creature_template_locale` SET `Name` = 'Sumo Sacerdote Atal''ai' WHERE `locale` = 'esES' AND `entry` = 5273;
-- OLD name : Yeti Cicatriz Feral
-- Source : https://www.wowhead.com/wotlk/es/npc=5292
UPDATE `creature_template_locale` SET `Name` = 'Yeti Fierescara' WHERE `locale` = 'esES' AND `entry` = 5292;
-- OLD name : Cicatriz Feral descomunal
-- Source : https://www.wowhead.com/wotlk/es/npc=5293
UPDATE `creature_template_locale` SET `Name` = 'Fierescara descomunal' WHERE `locale` = 'esES' AND `entry` = 5293;
-- OLD name : Cicatriz Feral iracundo
-- Source : https://www.wowhead.com/wotlk/es/npc=5295
UPDATE `creature_template_locale` SET `Name` = 'Fierescara iracundo' WHERE `locale` = 'esES' AND `entry` = 5295;
-- OLD name : Hipogrifo Plumavieja
-- Source : https://www.wowhead.com/wotlk/es/npc=5300
UPDATE `creature_template_locale` SET `Name` = 'Hipogrifo Rozapluma' WHERE `locale` = 'esES' AND `entry` = 5300;
-- OLD name : Alacervo Plumavieja
-- Source : https://www.wowhead.com/wotlk/es/npc=5304
UPDATE `creature_template_locale` SET `Name` = 'Alacervo Rozapluma' WHERE `locale` = 'esES' AND `entry` = 5304;
-- OLD name : Asaltacielo Plumavieja
-- Source : https://www.wowhead.com/wotlk/es/npc=5305
UPDATE `creature_template_locale` SET `Name` = 'Tormento Rozapluma' WHERE `locale` = 'esES' AND `entry` = 5305;
-- OLD name : Patriarca Plumavieja
-- Source : https://www.wowhead.com/wotlk/es/npc=5306
UPDATE `creature_template_locale` SET `Name` = 'Patriarca Rozapluma' WHERE `locale` = 'esES' AND `entry` = 5306;
-- OLD name : Estridador del valle huido
-- Source : https://www.wowhead.com/wotlk/es/npc=5308
UPDATE `creature_template_locale` SET `Name` = 'Pícaro estridador del valle' WHERE `locale` = 'esES' AND `entry` = 5308;
-- OLD name : depositario arbóreo Jademir
-- Source : https://www.wowhead.com/wotlk/es/npc=5319
UPDATE `creature_template_locale` SET `Name` = 'Guardia arbóreo Jademir' WHERE `locale` = 'esES' AND `entry` = 5319;
-- OLD name : Monstruo de prueba de Jeremy
-- Source : https://www.wowhead.com/wotlk/es/npc=5326
UPDATE `creature_template_locale` SET `Name` = 'Pinzador Reptacostas' WHERE `locale` = 'esES' AND `entry` = 5326;
-- OLD name : Guardia serpiente Crestafuria (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5333
UPDATE `creature_template_locale` SET `Name` = 'Guardia Serpiente Crestafuria' WHERE `locale` = 'esES' AND `entry` = 5333;
-- OLD name : Vociferadora Crestafuria
-- Source : https://www.wowhead.com/wotlk/es/npc=5335
UPDATE `creature_template_locale` SET `Name` = 'Gritona Crestafuria' WHERE `locale` = 'esES' AND `entry` = 5335;
-- OLD name : Vigía Mahar Ba
-- Source : https://www.wowhead.com/wotlk/es/npc=5385
UPDATE `creature_template_locale` SET `Name` = 'Vigilante Mahar Ba' WHERE `locale` = 'esES' AND `entry` = 5385;
-- OLD subname : Instructor de joyería y suministros
-- Source : https://www.wowhead.com/wotlk/es/npc=5388
UPDATE `creature_template_locale` SET `Title` = 'Liga de Expedicionarios' WHERE `locale` = 'esES' AND `entry` = 5388;
-- OLD name : Prospector Gunstan
-- Source : https://www.wowhead.com/wotlk/es/npc=5389
UPDATE `creature_template_locale` SET `Name` = 'Prospector Gustar' WHERE `locale` = 'esES' AND `entry` = 5389;
-- OLD name : Cosechador esclavizado
-- Source : https://www.wowhead.com/wotlk/es/npc=5409
UPDATE `creature_template_locale` SET `Name` = 'Cosechaenjambres' WHERE `locale` = 'esES' AND `entry` = 5409;
-- OLD name : Gurda Ferocrín
-- Source : https://www.wowhead.com/wotlk/es/npc=5412
UPDATE `creature_template_locale` SET `Name` = 'Gurda Bravacrín' WHERE `locale` = 'esES' AND `entry` = 5412;
-- OLD name : Llagapata famélica
-- Source : https://www.wowhead.com/wotlk/es/npc=5425
UPDATE `creature_template_locale` SET `Name` = 'Llagapata famélico' WHERE `locale` = 'esES' AND `entry` = 5425;
-- OLD name : Planoleador gigante
-- Source : https://www.wowhead.com/wotlk/es/npc=5432
UPDATE `creature_template_locale` SET `Name` = 'Planeolador gigante' WHERE `locale` = 'esES' AND `entry` = 5432;
-- OLD name : Tiburón de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=5435
UPDATE `creature_template_locale` SET `Name` = 'Tiburón de la arena' WHERE `locale` = 'esES' AND `entry` = 5435;
-- OLD name : Ogro mago Machacaduna
-- Source : https://www.wowhead.com/wotlk/es/npc=5473
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Machacaduna' WHERE `locale` = 'esES' AND `entry` = 5473;
-- OLD subname : Tallstrider Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=5507
UPDATE `creature_template_locale` SET `Title` = 'Instructor de zancaaltas' WHERE `locale` = 'esES' AND `entry` = 5507;
-- OLD name : [UNUSED] Yuriv Adhem (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5544
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5544;
-- OLD name : [PH] Capataz de mina (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5548
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5548;
-- OLD name : [PH] Guardia de mina (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5549
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5549;
-- OLD name : [PH] Campesino JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5550
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5550;
-- OLD name : [PH] Guardia de caravana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5551
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5551;
-- OLD name : [PH] Peón JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5552
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5552;
-- OLD name : [PH] Explorador de caravana (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5553
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5553;
-- OLD name : [PH] Fauna JcJ (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5554
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5554;
-- OLD name : [PH] Rocín de caravana ogra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5555
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5555;
-- OLD name : [PH] Comandante de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5556
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5556;
-- OLD name : [PH] Comandante de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5557
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5557;
-- OLD name : [PH] Guardia de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5558;
-- OLD name : [PH] Guardia de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5559;
-- OLD name : [PH] Asaltante de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5560
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5560;
-- OLD name : [PH] Asaltante de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5561
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5561;
-- OLD name : [PH] Arquero de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5562
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5562;
-- OLD name : [PH] Arquero de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5563
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5563;
-- OLD name : [PH] Capataz de mina de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5587
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5587;
-- OLD name : [PH] Guardia de mina de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5588;
-- OLD name : [PH] Capataz de mina de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5589;
-- OLD name : [PH] Guardia de mina de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5590
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5590;
-- OLD name : [UNUSED] [PH] Verbenero orco (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5604
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5604;
-- OLD name : Pícaro Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=5615
UPDATE `creature_template_locale` SET `Name` = 'Pícaro Deambulador' WHERE `locale` = 'esES' AND `entry` = 5615;
-- OLD name : Ladrón Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=5616
UPDATE `creature_template_locale` SET `Name` = 'Ladrón Deambulador' WHERE `locale` = 'esES' AND `entry` = 5616;
-- OLD name : Mago oscuro Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=5617
UPDATE `creature_template_locale` SET `Name` = 'Mago oscuro Deambulador' WHERE `locale` = 'esES' AND `entry` = 5617;
-- OLD name : Bandido Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=5618
UPDATE `creature_template_locale` SET `Name` = 'Bandido Deambulador' WHERE `locale` = 'esES' AND `entry` = 5618;
-- OLD name : Asesino Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=5623
UPDATE `creature_template_locale` SET `Name` = 'Asesino Deambulador' WHERE `locale` = 'esES' AND `entry` = 5623;
-- OLD name : Programa maestro de control, incursión en Theramore
-- Source : https://www.wowhead.com/wotlk/es/npc=5632
UPDATE `creature_template_locale` SET `Name` = 'Programa maestro de control, incursión en Theramonte' WHERE `locale` = 'esES' AND `entry` = 5632;
-- OLD name : Clamafuegos Furiarena
-- Source : https://www.wowhead.com/wotlk/es/npc=5647
UPDATE `creature_template_locale` SET `Name` = 'Clamafuego Furiarena' WHERE `locale` = 'esES' AND `entry` = 5647;
-- OLD name : Venya Marthand
-- Source : https://www.wowhead.com/wotlk/es/npc=5667
UPDATE `creature_template_locale` SET `Name` = 'Venya Martmani' WHERE `locale` = 'esES' AND `entry` = 5667;
-- OLD name : [UNUSED] Lawrence Sierra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5671
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5671;
-- OLD name : [UNUSED] Charles Brewton (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5672
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5672;
-- OLD name : [UNUSED] Mortacechador Vincent DEBUG (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5678
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5678;
-- OLD name : Comar Villardo
-- Source : https://www.wowhead.com/wotlk/es/npc=5683
UPDATE `creature_template_locale` SET `Name` = 'Corma Villardo' WHERE `locale` = 'esES' AND `entry` = 5683;
-- OLD name : Sumo hechicero Andromath (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5694
UPDATE `creature_template_locale` SET `Name` = 'Sumo Hechicero Andromath' WHERE `locale` = 'esES' AND `entry` = 5694;
-- OLD subname : Esclava mental de Gerard
-- Source : https://www.wowhead.com/wotlk/es/npc=5697
UPDATE `creature_template_locale` SET `Title` = 'Experimento de Gerard' WHERE `locale` = 'esES' AND `entry` = 5697;
-- OLD name : Segasueños
-- Source : https://www.wowhead.com/wotlk/es/npc=5721
UPDATE `creature_template_locale` SET `Name` = 'Guadañasueños' WHERE `locale` = 'esES' AND `entry` = 5721;
-- OLD name : Kayla Smithe
-- Source : https://www.wowhead.com/wotlk/es/npc=5749
UPDATE `creature_template_locale` SET `Name` = 'Kayla Herrera' WHERE `locale` = 'esES' AND `entry` = 5749;
-- OLD name : Arrastrapiés descarriado
-- Source : https://www.wowhead.com/wotlk/es/npc=5761
UPDATE `creature_template_locale` SET `Name` = 'Arrastrado descarriado' WHERE `locale` = 'esES' AND `entry` = 5761;
-- OLD subname : Druida del Colmillo
-- Source : https://www.wowhead.com/wotlk/es/npc=5791
UPDATE `creature_template_locale` SET `Title` = 'Druidas del colmillo' WHERE `locale` = 'esES' AND `entry` = 5791;
-- OLD name : [PH] Robot de grupo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5801
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5801;
-- OLD name : Aliado antárbol (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5806
UPDATE `creature_template_locale` SET `Name` = 'Aliado Antárbol' WHERE `locale` = 'esES' AND `entry` = 5806;
-- OLD name : Sargento Curtis
-- Source : https://www.wowhead.com/wotlk/es/npc=5809
UPDATE `creature_template_locale` SET `Name` = 'Comandante de vigilancia Zalafil' WHERE `locale` = 'esES' AND `entry` = 5809;
-- OLD name : Silenciatruenos
-- Source : https://www.wowhead.com/wotlk/es/npc=5832
UPDATE `creature_template_locale` SET `Name` = 'Tronavapuleus' WHERE `locale` = 'esES' AND `entry` = 5832;
-- OLD name : Chamán Oscuro Crepuscular (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5860
UPDATE `creature_template_locale` SET `Name` = 'Chamán oscuro Crepuscular' WHERE `locale` = 'esES' AND `entry` = 5860;
-- OLD name : Geomántico Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=5862
UPDATE `creature_template_locale` SET `Name` = 'Geomántico Crespuscular' WHERE `locale` = 'esES' AND `entry` = 5862;
-- OLD subname : Instructor de oteadores
-- Source : https://www.wowhead.com/wotlk/es/npc=5876
UPDATE `creature_template_locale` SET `Title` = 'Instructor del Puente' WHERE `locale` = 'esES' AND `entry` = 5876;
-- OLD subname : Instructor de oteadores
-- Source : https://www.wowhead.com/wotlk/es/npc=5877
UPDATE `creature_template_locale` SET `Title` = 'Instructor del Puente' WHERE `locale` = 'esES' AND `entry` = 5877;
-- OLD name : Canaga Clamatierras
-- Source : https://www.wowhead.com/wotlk/es/npc=5887
UPDATE `creature_template_locale` SET `Name` = 'Canaga Clamatierra' WHERE `locale` = 'esES' AND `entry` = 5887;
-- OLD name : [UNUSED] Hurll Kans (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=5904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 5904;
-- OLD name : Pesadilla descarriada
-- Source : https://www.wowhead.com/wotlk/es/npc=5914
UPDATE `creature_template_locale` SET `Name` = 'Pesadilla descarriado' WHERE `locale` = 'esES' AND `entry` = 5914;
-- OLD name : Tótem de limpieza contraveneno
-- Source : https://www.wowhead.com/wotlk/es/npc=5923
UPDATE `creature_template_locale` SET `Name` = 'Tótem contraveneno' WHERE `locale` = 'esES' AND `entry` = 5923;
-- OLD name : Tótem de resistencia elemental
-- Source : https://www.wowhead.com/wotlk/es/npc=5927
UPDATE `creature_template_locale` SET `Name` = 'Tótem de resistencia al fuego' WHERE `locale` = 'esES' AND `entry` = 5927;
-- OLD name : Tótem de Magma (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=5929
UPDATE `creature_template_locale` SET `Name` = 'Tótem de magma' WHERE `locale` = 'esES' AND `entry` = 5929;
-- OLD name : Ogro Machacamiedo
-- Source : https://www.wowhead.com/wotlk/es/npc=5974
UPDATE `creature_template_locale` SET `Name` = 'Ogro Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 5974;
-- OLD name : Ogro mago Machacamiedo
-- Source : https://www.wowhead.com/wotlk/es/npc=5975
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 5975;
-- OLD name : Tosco Machacamiedo
-- Source : https://www.wowhead.com/wotlk/es/npc=5976
UPDATE `creature_template_locale` SET `Name` = 'Tosco Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 5976;
-- OLD name : Aplastador Machacamiedo
-- Source : https://www.wowhead.com/wotlk/es/npc=5977
UPDATE `creature_template_locale` SET `Name` = 'Aplastador Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 5977;
-- OLD name : Brujo Machacamiedo
-- Source : https://www.wowhead.com/wotlk/es/npc=5978
UPDATE `creature_template_locale` SET `Name` = 'Brujo Fauzatroz' WHERE `locale` = 'esES' AND `entry` = 5978;
-- OLD name : Perdido desdichado
-- Source : https://www.wowhead.com/wotlk/es/npc=5979
UPDATE `creature_template_locale` SET `Name` = 'Desdichado Perdido' WHERE `locale` = 'esES' AND `entry` = 5979;
-- OLD name : Escarbador Alimentavil
-- Source : https://www.wowhead.com/wotlk/es/npc=5983
UPDATE `creature_template_locale` SET `Name` = 'Escarbueso' WHERE `locale` = 'esES' AND `entry` = 5983;
-- OLD name : Vigía de la falla de Nethergarde
-- Source : https://www.wowhead.com/wotlk/es/npc=6002
UPDATE `creature_template_locale` SET `Name` = 'Vigía de las grietas de Nethergarde' WHERE `locale` = 'esES' AND `entry` = 6002;
-- OLD name : Ritualista Sombra Jurada
-- Source : https://www.wowhead.com/wotlk/es/npc=6004
UPDATE `creature_template_locale` SET `Name` = 'Cultor Sombra Jurada' WHERE `locale` = 'esES' AND `entry` = 6004;
-- OLD name : Valvababosa makrura (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6020
UPDATE `creature_template_locale` SET `Name` = 'Valvababosa Makrura' WHERE `locale` = 'esES' AND `entry` = 6020;
-- OLD name : [UNUSED] Gozwin Dentovil (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=6046
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 6046;
-- OLD name : Guardián acuático
-- Source : https://www.wowhead.com/wotlk/es/npc=6047
UPDATE `creature_template_locale` SET `Name` = 'Guardián de Agua' WHERE `locale` = 'esES' AND `entry` = 6047;
-- OLD name : [UNUSED] Meritt Herrion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=6067
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 6067;
-- OLD name : Sable de hielo rayado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6074
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo rayado' WHERE `locale` = 'esES' AND `entry` = 6074;
-- OLD name : Raptor de esmeralda
-- Source : https://www.wowhead.com/wotlk/es/npc=6075
UPDATE `creature_template_locale` SET `Name` = 'Raptor esmeralda' WHERE `locale` = 'esES' AND `entry` = 6075;
-- OLD name : Tótem Viento Furioso (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6112
UPDATE `creature_template_locale` SET `Name` = 'Tótem Viento furioso' WHERE `locale` = 'esES' AND `entry` = 6112;
-- OLD name : Aparecida Altonato
-- Source : https://www.wowhead.com/wotlk/es/npc=6116
UPDATE `creature_template_locale` SET `Name` = 'Aparecido Altonato' WHERE `locale` = 'esES' AND `entry` = 6116;
-- OLD name : Rasante de Nido Alto
-- Source : https://www.wowhead.com/wotlk/es/npc=6139
UPDATE `creature_template_locale` SET `Name` = 'Rasante Nido Alto' WHERE `locale` = 'esES' AND `entry` = 6139;
-- OLD name : Caminarrisco
-- Source : https://www.wowhead.com/wotlk/es/npc=6148
UPDATE `creature_template_locale` SET `Name` = 'Caminarisco' WHERE `locale` = 'esES' AND `entry` = 6148;
-- OLD name : [UNUSED] Briton Kilras (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=6183
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 6183;
-- OLD name : Guardia serpiente Látigo de Ira (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6194
UPDATE `creature_template_locale` SET `Name` = 'Guardia Serpiente Látigo de Ira' WHERE `locale` = 'esES' AND `entry` = 6194;
-- OLD name : Arquero de las Mazmorras
-- Source : https://www.wowhead.com/wotlk/es/npc=6237
UPDATE `creature_template_locale` SET `Name` = 'Arquero de la Empalizada' WHERE `locale` = 'esES' AND `entry` = 6237;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=6286
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 6286;
-- OLD name : Descarnador marino joven
-- Source : https://www.wowhead.com/wotlk/es/npc=6347
UPDATE `creature_template_locale` SET `Name` = 'Vándalo marino joven' WHERE `locale` = 'esES' AND `entry` = 6347;
-- OLD name : Descarnador marino
-- Source : https://www.wowhead.com/wotlk/es/npc=6348
UPDATE `creature_template_locale` SET `Name` = 'Vándalo marino' WHERE `locale` = 'esES' AND `entry` = 6348;
-- OLD name : Gran descarnador marino
-- Source : https://www.wowhead.com/wotlk/es/npc=6349
UPDATE `creature_template_locale` SET `Name` = 'Gran vándalo marino' WHERE `locale` = 'esES' AND `entry` = 6349;
-- OLD name : Esclavo mental de Kurzen
-- Source : https://www.wowhead.com/wotlk/es/npc=6366
UPDATE `creature_template_locale` SET `Name` = 'Esclavo mental Kurzen' WHERE `locale` = 'esES' AND `entry` = 6366;
-- OLD name : Asaltacielo Tronatesta
-- Source : https://www.wowhead.com/wotlk/es/npc=6378
UPDATE `creature_template_locale` SET `Name` = 'Tormento Tronatesta' WHERE `locale` = 'esES' AND `entry` = 6378;
-- OLD name : Ulag el Cuchilla
-- Source : https://www.wowhead.com/wotlk/es/npc=6390
UPDATE `creature_template_locale` SET `Name` = 'Ulag el Cuchillero' WHERE `locale` = 'esES' AND `entry` = 6390;
-- OLD name : Muerto angustiado
-- Source : https://www.wowhead.com/wotlk/es/npc=6426
UPDATE `creature_template_locale` SET `Name` = 'Muerto angustioso' WHERE `locale` = 'esES' AND `entry` = 6426;
-- OLD name : Fantasma mortificador
-- Source : https://www.wowhead.com/wotlk/es/npc=6427
UPDATE `creature_template_locale` SET `Name` = 'Fantasma encantado' WHERE `locale` = 'esES' AND `entry` = 6427;
-- OLD name : Caballo esquelético negro
-- Source : https://www.wowhead.com/wotlk/es/npc=6486
UPDATE `creature_template_locale` SET `Name` = 'Caballo esquelético de montar (negro)' WHERE `locale` = 'esES' AND `entry` = 6486;
-- OLD name : Estegodón Silenciatruenos
-- Source : https://www.wowhead.com/wotlk/es/npc=6504
UPDATE `creature_template_locale` SET `Name` = 'Estegodón Tronavapuleus' WHERE `locale` = 'esES' AND `entry` = 6504;
-- OLD name : Ravasaurio Pellejo Venenoso (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6508
UPDATE `creature_template_locale` SET `Name` = 'Ravasaurio pellejo venenoso' WHERE `locale` = 'esES' AND `entry` = 6508;
-- OLD name : Azotador Sangrepétalo
-- Source : https://www.wowhead.com/wotlk/es/npc=6509
UPDATE `creature_template_locale` SET `Name` = 'Azotador pétalo de sangre' WHERE `locale` = 'esES' AND `entry` = 6509;
-- OLD name : Despellejador Sangrepétalo
-- Source : https://www.wowhead.com/wotlk/es/npc=6510
UPDATE `creature_template_locale` SET `Name` = 'Despellejador pétalo de sangre' WHERE `locale` = 'esES' AND `entry` = 6510;
-- OLD name : Trillador Sangrepétalo
-- Source : https://www.wowhead.com/wotlk/es/npc=6511
UPDATE `creature_template_locale` SET `Name` = 'Trillador pétalo de sangre' WHERE `locale` = 'esES' AND `entry` = 6511;
-- OLD name : Trampero Sangrepétalo
-- Source : https://www.wowhead.com/wotlk/es/npc=6512
UPDATE `creature_template_locale` SET `Name` = 'Trampero pétalo de sangre' WHERE `locale` = 'esES' AND `entry` = 6512;
-- OLD name : Moco primigenio
-- Source : https://www.wowhead.com/wotlk/es/npc=6557
UPDATE `creature_template_locale` SET `Name` = 'Moco primario' WHERE `locale` = 'esES' AND `entry` = 6557;
-- OLD name : Moco glutinoso
-- Source : https://www.wowhead.com/wotlk/es/npc=6559
UPDATE `creature_template_locale` SET `Name` = 'Moco pegajoso' WHERE `locale` = 'esES' AND `entry` = 6559;
-- OLD name : Forma felina (elfo de la noche druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=6571
UPDATE `creature_template_locale` SET `Name` = 'Forma felina (druida elfo de la noche)' WHERE `locale` = 'esES' AND `entry` = 6571;
-- OLD name : Forma felina (tauren druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=6572
UPDATE `creature_template_locale` SET `Name` = 'Forma felina (druida tauren)' WHERE `locale` = 'esES' AND `entry` = 6572;
-- OLD name : Forma de viaje (Druida)
-- Source : https://www.wowhead.com/wotlk/es/npc=6573
UPDATE `creature_template_locale` SET `Name` = 'Forma viajera (Druida)' WHERE `locale` = 'esES' AND `entry` = 6573;
-- OLD name : Guardián Gruñefuria
-- Source : https://www.wowhead.com/wotlk/es/npc=6651
UPDATE `creature_template_locale` SET `Name` = 'Portero Gruñefuria' WHERE `locale` = 'esES' AND `entry` = 6651;
-- OLD name : Borrón Truenedera, subname : Suministros de venenos
-- Source : https://www.wowhead.com/wotlk/es/npc=6779
UPDATE `creature_template_locale` SET `Name` = 'Smudge Truenedera',`Title` = 'Suministros para venenos' WHERE `locale` = 'esES' AND `entry` = 6779;
-- OLD name : Manit Piñomuelle
-- Source : https://www.wowhead.com/wotlk/es/npc=6782
UPDATE `creature_template_locale` SET `Name` = 'Manit Dentafonte' WHERE `locale` = 'esES' AND `entry` = 6782;
-- OLD name : [UNUSED] Lorek Belm (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=6783
UPDATE `creature_template_locale` SET `Name` = 'Gorgrond Smokebelcher Depot NPC Invisible Stalker "Our Gun''s Bigger" Quest Target ELM' WHERE `locale` = 'esES' AND `entry` = 6783;
-- OLD name : Cachorro cardo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6789
UPDATE `creature_template_locale` SET `Name` = 'Cachorro Cardo' WHERE `locale` = 'esES' AND `entry` = 6789;
-- OLD name : Cangrejo de playa
-- Source : https://www.wowhead.com/wotlk/es/npc=6827
UPDATE `creature_template_locale` SET `Name` = 'Cangrejo' WHERE `locale` = 'esES' AND `entry` = 6827;
-- OLD name : Maestro de embarcadero
-- Source : https://www.wowhead.com/wotlk/es/npc=6846
UPDATE `creature_template_locale` SET `Name` = 'Maestro de embarcadero Defias' WHERE `locale` = 'esES' AND `entry` = 6846;
-- OLD name : Guardaespaldas
-- Source : https://www.wowhead.com/wotlk/es/npc=6866
UPDATE `creature_template_locale` SET `Name` = 'Guardaespaldas Defias' WHERE `locale` = 'esES' AND `entry` = 6866;
-- OLD name : Eric "el Veloz" (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=6907
UPDATE `creature_template_locale` SET `Name` = 'Eric "El Veloz"' WHERE `locale` = 'esES' AND `entry` = 6907;
-- OLD name : Caminafallas Perdido
-- Source : https://www.wowhead.com/wotlk/es/npc=6913
UPDATE `creature_template_locale` SET `Name` = 'Viajagujeros Perdido' WHERE `locale` = 'esES' AND `entry` = 6913;
-- OLD name : Trabajador de embarcadero
-- Source : https://www.wowhead.com/wotlk/es/npc=6927
UPDATE `creature_template_locale` SET `Name` = 'Trabajador de embarcadero Defias' WHERE `locale` = 'esES' AND `entry` = 6927;
-- OLD name : Guardia Roca Negra
-- Source : https://www.wowhead.com/wotlk/es/npc=7013
UPDATE `creature_template_locale` SET `Name` = 'Gamberro Roca Negra' WHERE `locale` = 'esES' AND `entry` = 7013;
-- OLD name : Centinela obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=7023
UPDATE `creature_template_locale` SET `Name` = 'Centinela Obsidiano' WHERE `locale` = 'esES' AND `entry` = 7023;
-- OLD name : Elemental obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=7031
UPDATE `creature_template_locale` SET `Name` = 'Elemental Obsidiano' WHERE `locale` = 'esES' AND `entry` = 7031;
-- OLD name : Elemental obsidiano superior (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7032
UPDATE `creature_template_locale` SET `Name` = 'Elemental Obsidiano superior' WHERE `locale` = 'esES' AND `entry` = 7032;
-- OLD name : Ogro mago Pirontraña
-- Source : https://www.wowhead.com/wotlk/es/npc=7034
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Pirontraña' WHERE `locale` = 'esES' AND `entry` = 7034;
-- OLD name : Dragauro Flamaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=7042
UPDATE `creature_template_locale` SET `Name` = 'Dragauro flamascama' WHERE `locale` = 'esES' AND `entry` = 7042;
-- OLD name : Verminte Flamaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=7043
UPDATE `creature_template_locale` SET `Name` = 'Verminte flamascama' WHERE `locale` = 'esES' AND `entry` = 7043;
-- OLD name : Estirpe Flamaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=7049
UPDATE `creature_template_locale` SET `Name` = 'Estirpe de flamascama' WHERE `locale` = 'esES' AND `entry` = 7049;
-- OLD name : Avizor de torre Defias
-- Source : https://www.wowhead.com/wotlk/es/npc=7056
UPDATE `creature_template_locale` SET `Name` = 'Avizor torrero Defias' WHERE `locale` = 'esES' AND `entry` = 7056;
-- OLD name : Escórpido de risco
-- Source : https://www.wowhead.com/wotlk/es/npc=7078
UPDATE `creature_template_locale` SET `Name` = 'Escórpido de La Grieta' WHERE `locale` = 'esES' AND `entry` = 7078;
-- OLD name : Venado enajenado
-- Source : https://www.wowhead.com/wotlk/es/npc=7095
UPDATE `creature_template_locale` SET `Name` = 'Venado enloquecido' WHERE `locale` = 'esES' AND `entry` = 7095;
-- OLD name : Lechuza Picoférreo
-- Source : https://www.wowhead.com/wotlk/es/npc=7097
UPDATE `creature_template_locale` SET `Name` = 'Lechuza Cortezaférrea' WHERE `locale` = 'esES' AND `entry` = 7097;
-- OLD name : Estridador Picoférreo
-- Source : https://www.wowhead.com/wotlk/es/npc=7098
UPDATE `creature_template_locale` SET `Name` = 'Estridador Cortezaférrea' WHERE `locale` = 'esES' AND `entry` = 7098;
-- OLD name : Cazador Picoférreo
-- Source : https://www.wowhead.com/wotlk/es/npc=7099
UPDATE `creature_template_locale` SET `Name` = 'Cazador Cortezaférrea' WHERE `locale` = 'esES' AND `entry` = 7099;
-- OLD name : Arrancamusgo Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=7100
UPDATE `creature_template_locale` SET `Name` = 'Arrancamusgo Combadera' WHERE `locale` = 'esES' AND `entry` = 7100;
-- OLD name : Machacador Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=7101
UPDATE `creature_template_locale` SET `Name` = 'Machacador Combadera' WHERE `locale` = 'esES' AND `entry` = 7101;
-- OLD name : Campeón del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=7122
UPDATE `creature_template_locale` SET `Name` = 'Campeón del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 7122;
-- OLD name : Maestro del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=7123
UPDATE `creature_template_locale` SET `Name` = 'Maestro del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 7123;
-- OLD name : Alto señor del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=7124
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 7124;
-- OLD name : Horror nocivo
-- Source : https://www.wowhead.com/wotlk/es/npc=7133
UPDATE `creature_template_locale` SET `Name` = 'Horror tóxico' WHERE `locale` = 'esES' AND `entry` = 7133;
-- OLD name : Antárbol putrefacto
-- Source : https://www.wowhead.com/wotlk/es/npc=7143
UPDATE `creature_template_locale` SET `Name` = 'Antárbol en descomposición' WHERE `locale` = 'esES' AND `entry` = 7143;
-- OLD name : Protector antárbol (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7146
UPDATE `creature_template_locale` SET `Name` = 'Protector Antárbol' WHERE `locale` = 'esES' AND `entry` = 7146;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=7174
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forja de armaduras' WHERE `locale` = 'esES' AND `entry` = 7174;
-- OLD name : Fragmento de obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=7209
UPDATE `creature_template_locale` SET `Name` = 'Fragmento Obsidiano' WHERE `locale` = 'esES' AND `entry` = 7209;
-- OLD name : Sombre de Arantir
-- Source : https://www.wowhead.com/wotlk/es/npc=7229
UPDATE `creature_template_locale` SET `Name` = 'Sombra de Arantir' WHERE `locale` = 'esES' AND `entry` = 7229;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=7230
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forja de armaduras' WHERE `locale` = 'esES' AND `entry` = 7230;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=7231
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armas' WHERE `locale` = 'esES' AND `entry` = 7231;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=7232
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armas' WHERE `locale` = 'esES' AND `entry` = 7232;
-- OLD name : Cazasombras Furiarena
-- Source : https://www.wowhead.com/wotlk/es/npc=7246
UPDATE `creature_template_locale` SET `Name` = 'Cazador de las Sombras Furiarena' WHERE `locale` = 'esES' AND `entry` = 7246;
-- OLD name : Gran supervisor Puzik Gallywix (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7288
UPDATE `creature_template_locale` SET `Name` = 'Gran Supervisor Puzik Gallywix' WHERE `locale` = 'esES' AND `entry` = 7288;
-- OLD name : [UNUSED] Drayl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=7293
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 7293;
-- OLD name : Sable de la noche negro
-- Source : https://www.wowhead.com/wotlk/es/npc=7322
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (negro)' WHERE `locale` = 'esES' AND `entry` = 7322;
-- OLD name : Jabaguerrero marchito
-- Source : https://www.wowhead.com/wotlk/es/npc=7333
UPDATE `creature_template_locale` SET `Name` = 'Jabalí de batalla marchito' WHERE `locale` = 'esES' AND `entry` = 7333;
-- OLD name : Horror jabaguerrero
-- Source : https://www.wowhead.com/wotlk/es/npc=7334
UPDATE `creature_template_locale` SET `Name` = 'Horror jabalí de batalla' WHERE `locale` = 'esES' AND `entry` = 7334;
-- OLD name : Maligno de tumbas
-- Source : https://www.wowhead.com/wotlk/es/npc=7349
UPDATE `creature_template_locale` SET `Name` = 'Maligno de las tumbas' WHERE `locale` = 'esES' AND `entry` = 7349;
-- OLD name : Atracador de tumbas
-- Source : https://www.wowhead.com/wotlk/es/npc=7351
UPDATE `creature_template_locale` SET `Name` = 'Atracador de las tumbas' WHERE `locale` = 'esES' AND `entry` = 7351;
-- OLD name : Faucepeste el Podrido
-- Source : https://www.wowhead.com/wotlk/es/npc=7356
UPDATE `creature_template_locale` SET `Name` = 'Fauzpeste el Putrefacto' WHERE `locale` = 'esES' AND `entry` = 7356;
-- OLD name : Espíritu de la cólera
-- Source : https://www.wowhead.com/wotlk/es/npc=7375
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de la Ira' WHERE `locale` = 'esES' AND `entry` = 7375;
-- OLD name : Mastín can maldito
-- Source : https://www.wowhead.com/wotlk/es/npc=7378
UPDATE `creature_template_locale` SET `Name` = 'Masadura can maldito' WHERE `locale` = 'esES' AND `entry` = 7378;
-- OLD name : Ogro mago Vientomuerto
-- Source : https://www.wowhead.com/wotlk/es/npc=7379
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Vientomuerto' WHERE `locale` = 'esES' AND `entry` = 7379;
-- OLD name : Curiana de Entrañas
-- Source : https://www.wowhead.com/wotlk/es/npc=7395
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha' WHERE `locale` = 'esES' AND `entry` = 7395;
-- OLD name : Rompepedras terráneo
-- Source : https://www.wowhead.com/wotlk/es/npc=7396
UPDATE `creature_template_locale` SET `Name` = 'Rompepiedras terráneo' WHERE `locale` = 'esES' AND `entry` = 7396;
-- OLD name : Refugiado draenei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7401
UPDATE `creature_template_locale` SET `Name` = 'Refugiado Draenei' WHERE `locale` = 'esES' AND `entry` = 7401;
-- OLD name : Guardia de las llamas Galak
-- Source : https://www.wowhead.com/wotlk/es/npc=7404
UPDATE `creature_template_locale` SET `Name` = 'Guardia Flama Galak' WHERE `locale` = 'esES' AND `entry` = 7404;
-- OLD name : Escórpido de risco
-- Source : https://www.wowhead.com/wotlk/es/npc=7405
UPDATE `creature_template_locale` SET `Name` = 'Escórpido del Risco Mortal' WHERE `locale` = 'esES' AND `entry` = 7405;
-- OLD name : Sable de hielo joven
-- Source : https://www.wowhead.com/wotlk/es/npc=7430
UPDATE `creature_template_locale` SET `Name` = 'Cachorro Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 7430;
-- OLD name : Sable de hielo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7431
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 7431;
-- OLD name : Acechador sable de hielo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7432
UPDATE `creature_template_locale` SET `Name` = 'Acechador Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 7432;
-- OLD name : Cazadora sable de hielo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7433
UPDATE `creature_template_locale` SET `Name` = 'Cazadora Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 7433;
-- OLD name : Vigía de la manada sable de hielo
-- Source : https://www.wowhead.com/wotlk/es/npc=7434
UPDATE `creature_template_locale` SET `Name` = 'Vigía del orgullo Sable de Hielo' WHERE `locale` = 'esES' AND `entry` = 7434;
-- OLD name : Dentoesquirla anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=7445
UPDATE `creature_template_locale` SET `Name` = 'Ancestro Dentoesquirla' WHERE `locale` = 'esES' AND `entry` = 7445;
-- OLD name : Volantón Viento Gélido
-- Source : https://www.wowhead.com/wotlk/es/npc=7447
UPDATE `creature_template_locale` SET `Name` = 'Fugalante Viento Gélido' WHERE `locale` = 'esES' AND `entry` = 7447;
-- OLD name : Lechubestia pulgosa
-- Source : https://www.wowhead.com/wotlk/es/npc=7450
UPDATE `creature_template_locale` SET `Name` = 'Lechubestia andrajosa' WHERE `locale` = 'esES' AND `entry` = 7450;
-- OLD name : Cardo Nevado huido
-- Source : https://www.wowhead.com/wotlk/es/npc=7457
UPDATE `creature_template_locale` SET `Name` = 'Pícaro Cardo Nevado' WHERE `locale` = 'esES' AND `entry` = 7457;
-- OLD name : Altonato angustiada
-- Source : https://www.wowhead.com/wotlk/es/npc=7524
UPDATE `creature_template_locale` SET `Name` = 'Altonato angustioso' WHERE `locale` = 'esES' AND `entry` = 7524;
-- OLD name : Instructora mundial de peletería dragontina (NO LONGER IMPLEMENTED), subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7525
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de peletería de escamas de dragón',`Title` = 'Instructora de peletería de escamas de dragón' WHERE `locale` = 'esES' AND `entry` = 7525;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7526
UPDATE `creature_template_locale` SET `Title` = 'Instructora de peletería elemental' WHERE `locale` = 'esES' AND `entry` = 7526;
-- OLD name : Instructora mundial de peletería tribal (NO LONGER WORKING), subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7528
UPDATE `creature_template_locale` SET `Name` = 'Instructora mundial de peletería tribal',`Title` = 'Instructora de peletería tribal' WHERE `locale` = 'esES' AND `entry` = 7528;
-- OLD name : Cottontail Rabbit
-- Source : https://www.wowhead.com/wotlk/es/npc=7558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 7558;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7558, 'esES','Conejo cola de algodón',NULL);
-- OLD name : Spotted Rabbit
-- Source : https://www.wowhead.com/wotlk/es/npc=7559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 7559;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (7559, 'esES','Conejo moteado',NULL);
-- OLD name : Slim's Test Death Knight
-- Source : https://www.wowhead.com/wotlk/es/npc=7624
UPDATE `creature_template_locale` SET `Name` = 'Test Death Knight' WHERE `locale` = 'esES' AND `entry` = 7624;
-- OLD name : Leopardo
-- Source : https://www.wowhead.com/wotlk/es/npc=7684
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (amarillo)' WHERE `locale` = 'esES' AND `entry` = 7684;
-- OLD name : Tigre de bengala
-- Source : https://www.wowhead.com/wotlk/es/npc=7686
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (rojo)' WHERE `locale` = 'esES' AND `entry` = 7686;
-- OLD name : Sable de hielo moteado
-- Source : https://www.wowhead.com/wotlk/es/npc=7687
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (motas blancas)' WHERE `locale` = 'esES' AND `entry` = 7687;
-- OLD name : Sable de la noche moteado
-- Source : https://www.wowhead.com/wotlk/es/npc=7689
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (motas negras)' WHERE `locale` = 'esES' AND `entry` = 7689;
-- OLD name : Raptor obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=7703
UPDATE `creature_template_locale` SET `Name` = 'Raptor de montar (obsidiano)' WHERE `locale` = 'esES' AND `entry` = 7703;
-- OLD name : Raptor rojo jaspeado
-- Source : https://www.wowhead.com/wotlk/es/npc=7704
UPDATE `creature_template_locale` SET `Name` = 'Raptor de montar (carmesí)' WHERE `locale` = 'esES' AND `entry` = 7704;
-- OLD name : Raptor de marfil
-- Source : https://www.wowhead.com/wotlk/es/npc=7706
UPDATE `creature_template_locale` SET `Name` = 'Raptor de montar (marfil)' WHERE `locale` = 'esES' AND `entry` = 7706;
-- OLD name : Raptor de turquesa
-- Source : https://www.wowhead.com/wotlk/es/npc=7707
UPDATE `creature_template_locale` SET `Name` = 'Raptor turquesa' WHERE `locale` = 'esES' AND `entry` = 7707;
-- OLD name : Byula, subname : Antiguo tabernero
-- Source : https://www.wowhead.com/wotlk/es/npc=7714
UPDATE `creature_template_locale` SET `Name` = 'Tabernero Byula',`Title` = 'Tabernero' WHERE `locale` = 'esES' AND `entry` = 7714;
-- OLD name : Gregan Tirabirras
-- Source : https://www.wowhead.com/wotlk/es/npc=7775
UPDATE `creature_template_locale` SET `Name` = 'Gregan Vomitabrebaje' WHERE `locale` = 'esES' AND `entry` = 7775;
-- OLD name : Forajido Vagayermo
-- Source : https://www.wowhead.com/wotlk/es/npc=7805
UPDATE `creature_template_locale` SET `Name` = 'Revuelvebasura Deambulador' WHERE `locale` = 'esES' AND `entry` = 7805;
-- OLD name : Cicatriz Feral acechante
-- Source : https://www.wowhead.com/wotlk/es/npc=7848
UPDATE `creature_template_locale` SET `Name` = 'Fierescara acechante' WHERE `locale` = 'esES' AND `entry` = 7848;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7866
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería de escamas de dragón' WHERE `locale` = 'esES' AND `entry` = 7866;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7867
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería de escamas de dragón' WHERE `locale` = 'esES' AND `entry` = 7867;
-- OLD name : Sarah Peletera, subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7868
UPDATE `creature_template_locale` SET `Name` = 'Sarah Peletero',`Title` = 'Instructora de peletería elemental' WHERE `locale` = 'esES' AND `entry` = 7868;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7869
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería elemental' WHERE `locale` = 'esES' AND `entry` = 7869;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7870
UPDATE `creature_template_locale` SET `Title` = 'Instructora de peletería tribal' WHERE `locale` = 'esES' AND `entry` = 7870;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=7871
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería tribal' WHERE `locale` = 'esES' AND `entry` = 7871;
-- OLD name : Pirata cazatesoros (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7899
UPDATE `creature_template_locale` SET `Name` = 'Pirata Cazatesoros' WHERE `locale` = 'esES' AND `entry` = 7899;
-- OLD name : Ozzie irradiado
-- Source : https://www.wowhead.com/wotlk/es/npc=7935
UPDATE `creature_template_locale` SET `Name` = 'Moquillo irradiado' WHERE `locale` = 'esES' AND `entry` = 7935;
-- OLD subname : Instructor de equitación
-- Source : https://www.wowhead.com/wotlk/es/npc=7954
UPDATE `creature_template_locale` SET `Title` = 'Piloto de mecazancudo' WHERE `locale` = 'esES' AND `entry` = 7954;
-- OLD name : Valiente de Campamento Narache
-- Source : https://www.wowhead.com/wotlk/es/npc=7975
UPDATE `creature_template_locale` SET `Name` = 'Protector de Mulgore' WHERE `locale` = 'esES' AND `entry` = 7975;
-- OLD name : Sacerdotisa vil Hexx (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=7995
UPDATE `creature_template_locale` SET `Name` = 'Sacerdotisa Vil Hexx' WHERE `locale` = 'esES' AND `entry` = 7995;
-- OLD name : Guardia de Los Baldíos
-- Source : https://www.wowhead.com/wotlk/es/npc=8016
UPDATE `creature_template_locale` SET `Name` = 'Guarda de los Baldíos' WHERE `locale` = 'esES' AND `entry` = 8016;
-- OLD name : Guardián de Sen'jin
-- Source : https://www.wowhead.com/wotlk/es/npc=8017
UPDATE `creature_template_locale` SET `Name` = 'Guardián Sen''jin' WHERE `locale` = 'esES' AND `entry` = 8017;
-- OLD name : Edana Garfaodio
-- Source : https://www.wowhead.com/wotlk/es/npc=8075
UPDATE `creature_template_locale` SET `Name` = 'Edana Garraodio' WHERE `locale` = 'esES' AND `entry` = 8075;
-- OLD name : Guardia de la Brigada de los Páramos de Poniente, subname : The People's Militia
-- Source : https://www.wowhead.com/wotlk/es/npc=8096
UPDATE `creature_template_locale` SET `Name` = 'Protector del pueblo',`Title` = 'La Milicia Popular' WHERE `locale` = 'esES' AND `entry` = 8096;
-- OLD name : Depositario Sul'lithuz
-- Source : https://www.wowhead.com/wotlk/es/npc=8149
UPDATE `creature_template_locale` SET `Name` = 'Guarda Sul''lithuz' WHERE `locale` = 'esES' AND `entry` = 8149;
-- OLD name : Occulus
-- Source : https://www.wowhead.com/wotlk/es/npc=8196
UPDATE `creature_template_locale` SET `Name` = 'Oculus' WHERE `locale` = 'esES' AND `entry` = 8196;
-- OLD name : Alascuas
-- Source : https://www.wowhead.com/wotlk/es/npc=8207
UPDATE `creature_template_locale` SET `Name` = 'Pájaro de fuego superior' WHERE `locale` = 'esES' AND `entry` = 8207;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=8306
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 8306;
-- OLD name : Cresa de baba
-- Source : https://www.wowhead.com/wotlk/es/npc=8311
UPDATE `creature_template_locale` SET `Name` = 'Gusano-babosa' WHERE `locale` = 'esES' AND `entry` = 8311;
-- OLD name : Cría de la Pesadilla
-- Source : https://www.wowhead.com/wotlk/es/npc=8319
UPDATE `creature_template_locale` SET `Name` = 'Cría pesadilla' WHERE `locale` = 'esES' AND `entry` = 8319;
-- OLD name : Rondador de lo profundo
-- Source : https://www.wowhead.com/wotlk/es/npc=8384
UPDATE `creature_template_locale` SET `Name` = 'Rondador de las profundidades' WHERE `locale` = 'esES' AND `entry` = 8384;
-- OLD name : Piloto Xiggs Botafuego
-- Source : https://www.wowhead.com/wotlk/es/npc=8392
UPDATE `creature_template_locale` SET `Name` = 'Piloto Xiggs Luzfusil' WHERE `locale` = 'esES' AND `entry` = 8392;
-- OLD subname : Aprendiz de Xylem
-- Source : https://www.wowhead.com/wotlk/es/npc=8399
UPDATE `creature_template_locale` SET `Title` = 'Aprendiz Xylem' WHERE `locale` = 'esES' AND `entry` = 8399;
-- OLD name : Señor de la guerra Krellian (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=8408
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Guerra Krellian' WHERE `locale` = 'esES' AND `entry` = 8408;
-- OLD name : Fala Viento Sabio
-- Source : https://www.wowhead.com/wotlk/es/npc=8418
UPDATE `creature_template_locale` SET `Name` = 'Fala Ventsalvia' WHERE `locale` = 'esES' AND `entry` = 8418;
-- OLD name : Máquina voladora de Xiggs Botafuego
-- Source : https://www.wowhead.com/wotlk/es/npc=8446
UPDATE `creature_template_locale` SET `Name` = 'Máquina voladora de Xiggs Luzfusil' WHERE `locale` = 'esES' AND `entry` = 8446;
-- OLD name : Segunda de a bordo Shandril
-- Source : https://www.wowhead.com/wotlk/es/npc=8478
UPDATE `creature_template_locale` SET `Name` = 'Segunda de abordo Shandril' WHERE `locale` = 'esES' AND `entry` = 8478;
-- OLD name : Kalaran Espada del Viento
-- Source : https://www.wowhead.com/wotlk/es/npc=8479
UPDATE `creature_template_locale` SET `Name` = 'Velarok Espada del Viento' WHERE `locale` = 'esES' AND `entry` = 8479;
-- OLD name : Kalaran el Falsario
-- Source : https://www.wowhead.com/wotlk/es/npc=8480
UPDATE `creature_template_locale` SET `Name` = 'Velarok el Falsario' WHERE `locale` = 'esES' AND `entry` = 8480;
-- OLD name : Necrófago balbuceante
-- Source : https://www.wowhead.com/wotlk/es/npc=8531
UPDATE `creature_template_locale` SET `Name` = 'Necrófago tartamudo' WHERE `locale` = 'esES' AND `entry` = 8531;
-- OLD name : Trovamuerte
-- Source : https://www.wowhead.com/wotlk/es/npc=8542
UPDATE `creature_template_locale` SET `Name` = 'Recitador de muerte' WHERE `locale` = 'esES' AND `entry` = 8542;
-- OLD name : Gólem malformado
-- Source : https://www.wowhead.com/wotlk/es/npc=8544
UPDATE `creature_template_locale` SET `Name` = 'Gólem larguirucho' WHERE `locale` = 'esES' AND `entry` = 8544;
-- OLD name : Cultor de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=8547
UPDATE `creature_template_locale` SET `Name` = 'Fiel de la Muerte' WHERE `locale` = 'esES' AND `entry` = 8547;
-- OLD name : Cazasombras Fustamusgo
-- Source : https://www.wowhead.com/wotlk/es/npc=8561
UPDATE `creature_template_locale` SET `Name` = 'Cazador de las Sombras Fustamusgo' WHERE `locale` = 'esES' AND `entry` = 8561;
-- OLD name : Trabajador forestal desdichado
-- Source : https://www.wowhead.com/wotlk/es/npc=8563
UPDATE `creature_template_locale` SET `Name` = 'Leñador' WHERE `locale` = 'esES' AND `entry` = 8563;
-- OLD name : Forestal desdichado
-- Source : https://www.wowhead.com/wotlk/es/npc=8564
UPDATE `creature_template_locale` SET `Name` = 'Forestal' WHERE `locale` = 'esES' AND `entry` = 8564;
-- OLD name : Zancamino desdichado
-- Source : https://www.wowhead.com/wotlk/es/npc=8565
UPDATE `creature_template_locale` SET `Name` = 'Zancamino' WHERE `locale` = 'esES' AND `entry` = 8565;
-- OLD name : Magus Rimtori
-- Source : https://www.wowhead.com/wotlk/es/npc=8578
UPDATE `creature_template_locale` SET `Name` = 'Maga Rimtori' WHERE `locale` = 'esES' AND `entry` = 8578;
-- OLD name : Umbranse el Hablaalmas
-- Source : https://www.wowhead.com/wotlk/es/npc=8588
UPDATE `creature_template_locale` SET `Name` = 'Umbranse el Contacto Espiritual' WHERE `locale` = 'esES' AND `entry` = 8588;
-- OLD name : Can de peste superior
-- Source : https://www.wowhead.com/wotlk/es/npc=8599
UPDATE `creature_template_locale` SET `Name` = 'Masadura can de la Peste' WHERE `locale` = 'esES' AND `entry` = 8599;
-- OLD name : Ozzie
-- Source : https://www.wowhead.com/wotlk/es/npc=8613
UPDATE `creature_template_locale` SET `Name` = 'Oci' WHERE `locale` = 'esES' AND `entry` = 8613;
-- OLD name : El Evalcharr
-- Source : https://www.wowhead.com/wotlk/es/npc=8660
UPDATE `creature_template_locale` SET `Name` = 'Evalcharr' WHERE `locale` = 'esES' AND `entry` = 8660;
-- OLD name : Caminasol Saern
-- Source : https://www.wowhead.com/wotlk/es/npc=8664
UPDATE `creature_template_locale` SET `Name` = 'Saern Correorgullo' WHERE `locale` = 'esES' AND `entry` = 8664;
-- OLD name : Vórtice de ráfaga
-- Source : https://www.wowhead.com/wotlk/es/npc=8667
UPDATE `creature_template_locale` SET `Name` = 'Vórtice ráfaga' WHERE `locale` = 'esES' AND `entry` = 8667;
-- OLD name : Bestia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=8675
UPDATE `creature_template_locale` SET `Name` = 'Corrubestia' WHERE `locale` = 'esES' AND `entry` = 8675;
-- OLD name : Infernal inmenso
-- Source : https://www.wowhead.com/wotlk/es/npc=8680
UPDATE `creature_template_locale` SET `Name` = 'Infernal masivo' WHERE `locale` = 'esES' AND `entry` = 8680;
-- OLD name : Élite guardia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=8717
UPDATE `creature_template_locale` SET `Name` = 'Élite guarda vil' WHERE `locale` = 'esES' AND `entry` = 8717;
-- OLD name : Historiadora Real Archesonus
-- Source : https://www.wowhead.com/wotlk/es/npc=8879
UPDATE `creature_template_locale` SET `Name` = 'Historiador real Archesonus' WHERE `locale` = 'esES' AND `entry` = 8879;
-- OLD name : Ensamblaje belisario (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=8905
UPDATE `creature_template_locale` SET `Name` = 'Ensamblaje Belisario' WHERE `locale` = 'esES' AND `entry` = 8905;
-- OLD name : Guardia de fuego llameante
-- Source : https://www.wowhead.com/wotlk/es/npc=8910
UPDATE `creature_template_locale` SET `Name` = 'Llameante Piroguardia' WHERE `locale` = 'esES' AND `entry` = 8910;
-- OLD name : Destructor guardia de fuego
-- Source : https://www.wowhead.com/wotlk/es/npc=8911
UPDATE `creature_template_locale` SET `Name` = 'Destructor Piroguardia' WHERE `locale` = 'esES' AND `entry` = 8911;
-- OLD name : Cánido
-- Source : https://www.wowhead.com/wotlk/es/npc=8921
UPDATE `creature_template_locale` SET `Name` = 'Can de sangre' WHERE `locale` = 'esES' AND `entry` = 8921;
-- OLD name : Mastín cánido
-- Source : https://www.wowhead.com/wotlk/es/npc=8922
UPDATE `creature_template_locale` SET `Name` = 'Masadura can de sangre' WHERE `locale` = 'esES' AND `entry` = 8922;
-- OLD name : Gusano deslizante
-- Source : https://www.wowhead.com/wotlk/es/npc=8925
UPDATE `creature_template_locale` SET `Name` = 'Gusano de draga' WHERE `locale` = 'esES' AND `entry` = 8925;
-- OLD name : Morrotrueno cavador
-- Source : https://www.wowhead.com/wotlk/es/npc=8928
UPDATE `creature_template_locale` SET `Name` = 'Cavador Morrotrueno' WHERE `locale` = 'esES' AND `entry` = 8928;
-- OLD name : Alfazaque cavapozos
-- Source : https://www.wowhead.com/wotlk/es/npc=8932
UPDATE `creature_template_locale` SET `Name` = 'Escarabajo ambrosía' WHERE `locale` = 'esES' AND `entry` = 8932;
-- OLD name : Sha'ni Colmillo Orgulloso
-- Source : https://www.wowhead.com/wotlk/es/npc=9136
UPDATE `creature_template_locale` SET `Name` = 'Sha''ni Colmorgullo' WHERE `locale` = 'esES' AND `entry` = 9136;
-- OLD name : Peste Sangrepétalo
-- Source : https://www.wowhead.com/wotlk/es/npc=9157
UPDATE `creature_template_locale` SET `Name` = 'Peste pétalo de sangre' WHERE `locale` = 'esES' AND `entry` = 9157;
-- OLD name : Pterrordáctilo volantón
-- Source : https://www.wowhead.com/wotlk/es/npc=9165
UPDATE `creature_template_locale` SET `Name` = 'Pterrordáctilo Fugalante' WHERE `locale` = 'esES' AND `entry` = 9165;
-- OLD name : Señor de la guerra Cumbrerroca (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=9216
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Guerra Cumbrerroca' WHERE `locale` = 'esES' AND `entry` = 9216;
-- OLD name : Médico brujo Espina Ahumada
-- Source : https://www.wowhead.com/wotlk/es/npc=9266
UPDATE `creature_template_locale` SET `Name` = 'Médica brujo Espina Ahumada' WHERE `locale` = 'esES' AND `entry` = 9266;
-- OLD name : Chispik Minamal
-- Source : https://www.wowhead.com/wotlk/es/npc=9272
UPDATE `creature_template_locale` SET `Name` = 'Chispik Nilminer' WHERE `locale` = 'esES' AND `entry` = 9272;
-- OLD name : Dracoleón iracundo
-- Source : https://www.wowhead.com/wotlk/es/npc=9297
UPDATE `creature_template_locale` SET `Name` = 'Dracoleón enfurecido' WHERE `locale` = 'esES' AND `entry` = 9297;
-- OLD name : Fósil desenterrado
-- Source : https://www.wowhead.com/wotlk/es/npc=9397
UPDATE `creature_template_locale` SET `Name` = 'Tormenta viviente' WHERE `locale` = 'esES' AND `entry` = 9397;
-- OLD name : Señor de la guerra Krom'zar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=9456
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Guerra Krom''zar' WHERE `locale` = 'esES' AND `entry` = 9456;
-- OLD name : Señor supremo Ror (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=9464
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo Ror' WHERE `locale` = 'esES' AND `entry` = 9464;
-- OLD name : Maybess Brisa de Río
-- Source : https://www.wowhead.com/wotlk/es/npc=9529
UPDATE `creature_template_locale` SET `Name` = 'Maybess Brisafluvial' WHERE `locale` = 'esES' AND `entry` = 9529;
-- OLD name : [UNUSED] dun garok test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=9557
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 9557;
-- OLD name : Maestro de habilidades de Stowmwind
-- Source : https://www.wowhead.com/wotlk/es/npc=9576
UPDATE `creature_template_locale` SET `Name` = 'Maestro de talentos de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 9576;
-- OLD name : [UNUSED] Gorilla Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=9577
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 9577;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=9584
UPDATE `creature_template_locale` SET `Title` = 'Maestra sastre de tejido de sombra' WHERE `locale` = 'esES' AND `entry` = 9584;
-- OLD name : Arei transformado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=9599
UPDATE `creature_template_locale` SET `Name` = 'Arei Transformado' WHERE `locale` = 'esES' AND `entry` = 9599;
-- OLD name : Espíritu antárbol (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=9601
UPDATE `creature_template_locale` SET `Name` = 'Espíritu Antárbol' WHERE `locale` = 'esES' AND `entry` = 9601;
-- OLD name : [UNUSED] Eyan Mulcom (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=9617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 9617;
-- OLD name : Humillo
-- Source : https://www.wowhead.com/wotlk/es/npc=9657
UPDATE `creature_template_locale` SET `Name` = 'Pequeño Humillo' WHERE `locale` = 'esES' AND `entry` = 9657;
-- OLD name : [PH] TESTTAUREN (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=9686
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 9686;
-- OLD name : Huargo brasal babeante
-- Source : https://www.wowhead.com/wotlk/es/npc=9694
UPDATE `creature_template_locale` SET `Name` = 'Huargo brasal esclavizante' WHERE `locale` = 'esES' AND `entry` = 9694;
-- OLD name : Portal del Escudo del Estigma
-- Source : https://www.wowhead.com/wotlk/es/npc=9707
UPDATE `creature_template_locale` SET `Name` = 'Portal Escudo del Estigma' WHERE `locale` = 'esES' AND `entry` = 9707;
-- OLD name : Escupidor flamante
-- Source : https://www.wowhead.com/wotlk/es/npc=9776
UPDATE `creature_template_locale` SET `Name` = 'Flamante escupidor' WHERE `locale` = 'esES' AND `entry` = 9776;
-- OLD name : Duende flamante
-- Source : https://www.wowhead.com/wotlk/es/npc=9777
UPDATE `creature_template_locale` SET `Name` = 'Flamante duende' WHERE `locale` = 'esES' AND `entry` = 9777;
-- OLD name : Piroguardia Brasadivino
-- Source : https://www.wowhead.com/wotlk/es/npc=9816
UPDATE `creature_template_locale` SET `Name` = 'Piroguardián brasadivino' WHERE `locale` = 'esES' AND `entry` = 9816;
-- OLD name : [UNUSED] [PH] Sirviente del queso Floh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=9820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 9820;
-- OLD name : Vigilante de las llamas de Forjatiniebla
-- Source : https://www.wowhead.com/wotlk/es/npc=9956
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de la Llama Forjatiniebla' WHERE `locale` = 'esES' AND `entry` = 9956;
-- OLD subname : Antiguo maestro de establos
-- Source : https://www.wowhead.com/wotlk/es/npc=9983
UPDATE `creature_template_locale` SET `Title` = 'Maestro de establos' WHERE `locale` = 'esES' AND `entry` = 9983;
-- OLD name : Spraggle Frock
-- Source : https://www.wowhead.com/wotlk/es/npc=9997
UPDATE `creature_template_locale` SET `Name` = 'Spraggle Habitus' WHERE `locale` = 'esES' AND `entry` = 9997;
-- OLD name : Curiana corrupta
-- Source : https://www.wowhead.com/wotlk/es/npc=10017
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha corrupta' WHERE `locale` = 'esES' AND `entry` = 10017;
-- OLD name : Guardia de la colmena Gorishi
-- Source : https://www.wowhead.com/wotlk/es/npc=10040
UPDATE `creature_template_locale` SET `Name` = 'Guardián de la colmena Gorishi' WHERE `locale` = 'esES' AND `entry` = 10040;
-- OLD name : [PH] Alex's Raid Testing Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10044
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10044;
-- OLD name : Bethaine Martílex
-- Source : https://www.wowhead.com/wotlk/es/npc=10046
UPDATE `creature_template_locale` SET `Name` = 'Bethaine Hachílex' WHERE `locale` = 'esES' AND `entry` = 10046;
-- OLD name : Faucemuerte
-- Source : https://www.wowhead.com/wotlk/es/npc=10077
UPDATE `creature_template_locale` SET `Name` = 'Morifauces' WHERE `locale` = 'esES' AND `entry` = 10077;
-- OLD name : Flamaescama Garra de Furia
-- Source : https://www.wowhead.com/wotlk/es/npc=10083
UPDATE `creature_template_locale` SET `Name` = 'Flamascama Garra de Furia' WHERE `locale` = 'esES' AND `entry` = 10083;
-- OLD name : Mecazancudo verde fosforito
-- Source : https://www.wowhead.com/wotlk/es/npc=10178
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo de montar (verde fluorescente)' WHERE `locale` = 'esES' AND `entry` = 10178;
-- OLD name : Mecazancudo blanco modelo B
-- Source : https://www.wowhead.com/wotlk/es/npc=10179
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo de montar (negro)' WHERE `locale` = 'esES' AND `entry` = 10179;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=10237
UPDATE `creature_template_locale` SET `Title` = 'UNUSED' WHERE `locale` = 'esES' AND `entry` = 10237;
-- OLD name : Rombulus Luna Helada, subname : Dagger Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10292
UPDATE `creature_template_locale` SET `Name` = 'Rombulus Lunelada',`Title` = 'Instructor de puñales' WHERE `locale` = 'esES' AND `entry` = 10292;
-- OLD name : Malakar Luna Helada, subname : Fist Weapons Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10294
UPDATE `creature_template_locale` SET `Name` = 'Malakar Lunelada',`Title` = 'Instructor de armas de puño' WHERE `locale` = 'esES' AND `entry` = 10294;
-- OLD name : Gerratys Corredor de la Noche, subname : Bow Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10297
UPDATE `creature_template_locale` SET `Name` = 'Gerratys Noctámbulus',`Title` = 'Instructor de arco' WHERE `locale` = 'esES' AND `entry` = 10297;
-- OLD name : Acride
-- Source : https://www.wowhead.com/wotlk/es/npc=10299
UPDATE `creature_template_locale` SET `Name` = 'Infiltrado del Escudo del Estigma' WHERE `locale` = 'esES' AND `entry` = 10299;
-- OLD subname : Explorers' League
-- Source : https://www.wowhead.com/wotlk/es/npc=10301
UPDATE `creature_template_locale` SET `Title` = 'Liga de Expedicionarios' WHERE `locale` = 'esES' AND `entry` = 10301;
-- OLD name : Aurora Clamacielos
-- Source : https://www.wowhead.com/wotlk/es/npc=10304
UPDATE `creature_template_locale` SET `Name` = 'Aurora Llamacielo' WHERE `locale` = 'esES' AND `entry` = 10304;
-- OLD name : Sable de hielo anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=10322
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (blanco)' WHERE `locale` = 'esES' AND `entry` = 10322;
-- OLD name : Leopardo primigenio
-- Source : https://www.wowhead.com/wotlk/es/npc=10336
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (leopardo)' WHERE `locale` = 'esES' AND `entry` = 10336;
-- OLD name : Dientes de sable leonado
-- Source : https://www.wowhead.com/wotlk/es/npc=10337
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (naranja)' WHERE `locale` = 'esES' AND `entry` = 10337;
-- OLD name : Dientes de sable dorado
-- Source : https://www.wowhead.com/wotlk/es/npc=10338
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (dorado)' WHERE `locale` = 'esES' AND `entry` = 10338;
-- OLD name : [UNUSED] Xur'gyl (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10370
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10370;
-- OLD name : [UNUSED] Guerrero Guardia Negra
-- Source : https://www.wowhead.com/wotlk/es/npc=10395
UPDATE `creature_template_locale` SET `Name` = 'Guerrero Guardia Negra' WHERE `locale` = 'esES' AND `entry` = 10395;
-- OLD name : [UNUSED] Verdugo Guardia Negra
-- Source : https://www.wowhead.com/wotlk/es/npc=10397
UPDATE `creature_template_locale` SET `Name` = 'Verdugo Guardia Negra' WHERE `locale` = 'esES' AND `entry` = 10397;
-- OLD name : Taumaturgo umbrío Thuzadin
-- Source : https://www.wowhead.com/wotlk/es/npc=10398
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro Thuzadin' WHERE `locale` = 'esES' AND `entry` = 10398;
-- OLD name : [UNUSED] Señor de las Sombras Thuzadin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10401
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10401;
-- OLD name : [UNUSED] Wight el Caníbal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10402
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10402;
-- OLD name : [UNUSED] Ente devorador (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10403
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10403;
-- OLD name : Custodio resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10418
UPDATE `creature_template_locale` SET `Name` = 'Custodio Carmesí' WHERE `locale` = 'esES' AND `entry` = 10418;
-- OLD name : Conjurador resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10419
UPDATE `creature_template_locale` SET `Name` = 'Conjurador Carmesí' WHERE `locale` = 'esES' AND `entry` = 10419;
-- OLD name : Iniciado resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10420
UPDATE `creature_template_locale` SET `Name` = 'Iniciado Carmesí' WHERE `locale` = 'esES' AND `entry` = 10420;
-- OLD name : Defensor resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10421
UPDATE `creature_template_locale` SET `Name` = 'Defensor Carmesí' WHERE `locale` = 'esES' AND `entry` = 10421;
-- OLD name : Hechicero resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10422
UPDATE `creature_template_locale` SET `Name` = 'Hechicero Carmesí' WHERE `locale` = 'esES' AND `entry` = 10422;
-- OLD name : Sacerdote resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10423
UPDATE `creature_template_locale` SET `Name` = 'Sacerdote Carmesí' WHERE `locale` = 'esES' AND `entry` = 10423;
-- OLD name : Gallardo resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10424
UPDATE `creature_template_locale` SET `Name` = 'Gallardo Carmesí' WHERE `locale` = 'esES' AND `entry` = 10424;
-- OLD name : Mago de batalla resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10425
UPDATE `creature_template_locale` SET `Name` = 'Mago de batalla Carmesí' WHERE `locale` = 'esES' AND `entry` = 10425;
-- OLD name : Inquisidor resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=10426
UPDATE `creature_template_locale` SET `Name` = 'Inquisidor Carmesí' WHERE `locale` = 'esES' AND `entry` = 10426;
-- OLD name : Pao'ka Monte Presto
-- Source : https://www.wowhead.com/wotlk/es/npc=10427
UPDATE `creature_template_locale` SET `Name` = 'Pao''ka Velocimontés' WHERE `locale` = 'esES' AND `entry` = 10427;
-- OLD name : Gregor Petragris
-- Source : https://www.wowhead.com/wotlk/es/npc=10431
UPDATE `creature_template_locale` SET `Name` = 'Gregor Pedragris' WHERE `locale` = 'esES' AND `entry` = 10431;
-- OLD name : Marduk Pozonegro
-- Source : https://www.wowhead.com/wotlk/es/npc=10433
UPDATE `creature_template_locale` SET `Name` = 'Marduz Pozonegro' WHERE `locale` = 'esES' AND `entry` = 10433;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10446
UPDATE `creature_template_locale` SET `Title` = 'Instructor de ballesta' WHERE `locale` = 'esES' AND `entry` = 10446;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10450
UPDATE `creature_template_locale` SET `Title` = 'Instructor de ballesta' WHERE `locale` = 'esES' AND `entry` = 10450;
-- OLD subname : Mace Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10452
UPDATE `creature_template_locale` SET `Title` = 'Instructor de mazas' WHERE `locale` = 'esES' AND `entry` = 10452;
-- OLD subname : Axe Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10453
UPDATE `creature_template_locale` SET `Title` = 'Instructor de hachas' WHERE `locale` = 'esES' AND `entry` = 10453;
-- OLD subname : Crossbow Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=10454
UPDATE `creature_template_locale` SET `Title` = 'Instructor de ballesta' WHERE `locale` = 'esES' AND `entry` = 10454;
-- OLD name : Alma en pena gemebunda
-- Source : https://www.wowhead.com/wotlk/es/npc=10464
UPDATE `creature_template_locale` SET `Name` = 'Alma en pena de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 10464;
-- OLD name : Taumaturgo umbrío de Scholomance
-- Source : https://www.wowhead.com/wotlk/es/npc=10473
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro de Scholomance' WHERE `locale` = 'esES' AND `entry` = 10473;
-- OLD name : Ras Murmuhielo
-- Source : https://www.wowhead.com/wotlk/es/npc=10508
UPDATE `creature_template_locale` SET `Name` = 'Ras Levescarcha' WHERE `locale` = 'esES' AND `entry` = 10508;
-- OLD name : La Imperdonable
-- Source : https://www.wowhead.com/wotlk/es/npc=10516
UPDATE `creature_template_locale` SET `Name` = 'El Imperdonable' WHERE `locale` = 'esES' AND `entry` = 10516;
-- OLD name : Cresa apestada
-- Source : https://www.wowhead.com/wotlk/es/npc=10536
UPDATE `creature_template_locale` SET `Name` = 'Gusano apestado' WHERE `locale` = 'esES' AND `entry` = 10536;
-- OLD name : Urok Aullasino
-- Source : https://www.wowhead.com/wotlk/es/npc=10584
UPDATE `creature_template_locale` SET `Name` = 'Urok Aullapocalipsis' WHERE `locale` = 'esES' AND `entry` = 10584;
-- OLD name : [UNUSED] Siralnaya (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10607;
-- OLD subname : Instructor de sableinvernales (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=10618
UPDATE `creature_template_locale` SET `Title` = 'Instructor de Sableinvernales' WHERE `locale` = 'esES' AND `entry` = 10618;
-- OLD name : Thalia Ocultaámbar
-- Source : https://www.wowhead.com/wotlk/es/npc=10645
UPDATE `creature_template_locale` SET `Name` = 'Thalia Pellejo Ámbar' WHERE `locale` = 'esES' AND `entry` = 10645;
-- OLD name : Cría de dragón apestada
-- Source : https://www.wowhead.com/wotlk/es/npc=10678
UPDATE `creature_template_locale` SET `Name` = 'Crías de dragón apestadas' WHERE `locale` = 'esES' AND `entry` = 10678;
-- OLD name : Mulgris Río Hondo
-- Source : https://www.wowhead.com/wotlk/es/npc=10739
UPDATE `creature_template_locale` SET `Name` = 'Mulgris Riohondo' WHERE `locale` = 'esES' AND `entry` = 10739;
-- OLD name : Finkle Einhorn
-- Source : https://www.wowhead.com/wotlk/es/npc=10776
UPDATE `creature_template_locale` SET `Name` = 'Finkle Unicornín' WHERE `locale` = 'esES' AND `entry` = 10776;
-- OLD name : Orbe de engaño (orco, hombre)
-- Source : https://www.wowhead.com/wotlk/es/npc=10783
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (orco, hombre)' WHERE `locale` = 'esES' AND `entry` = 10783;
-- OLD name : Orbe de engaño (orco, mujer)
-- Source : https://www.wowhead.com/wotlk/es/npc=10784
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (orco, mujer)' WHERE `locale` = 'esES' AND `entry` = 10784;
-- OLD name : Orbe de engaño (tauren, hombre)
-- Source : https://www.wowhead.com/wotlk/es/npc=10785
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (tauren, hombre)' WHERE `locale` = 'esES' AND `entry` = 10785;
-- OLD name : Orbe de engaño (tauren, mujer)
-- Source : https://www.wowhead.com/wotlk/es/npc=10786
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (tauren, mujer)' WHERE `locale` = 'esES' AND `entry` = 10786;
-- OLD name : Orbe de engaño (trol, hombre)
-- Source : https://www.wowhead.com/wotlk/es/npc=10787
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (trol, hombre)' WHERE `locale` = 'esES' AND `entry` = 10787;
-- OLD name : Orbe de engaño (trol, mujer)
-- Source : https://www.wowhead.com/wotlk/es/npc=10788
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (trol, mujer)' WHERE `locale` = 'esES' AND `entry` = 10788;
-- OLD name : Orbe de engaño (no-muerto)
-- Source : https://www.wowhead.com/wotlk/es/npc=10789
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (no-muerto)' WHERE `locale` = 'esES' AND `entry` = 10789;
-- OLD name : Orbe de engaño (no-muerta)
-- Source : https://www.wowhead.com/wotlk/es/npc=10790
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (no-muerta)' WHERE `locale` = 'esES' AND `entry` = 10790;
-- OLD name : Orbe de engaño (enano)
-- Source : https://www.wowhead.com/wotlk/es/npc=10791
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (enano)' WHERE `locale` = 'esES' AND `entry` = 10791;
-- OLD name : Orbe de engaño (enana)
-- Source : https://www.wowhead.com/wotlk/es/npc=10792
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (enana)' WHERE `locale` = 'esES' AND `entry` = 10792;
-- OLD name : Orbe de engaño (gnomo, hombre)
-- Source : https://www.wowhead.com/wotlk/es/npc=10793
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (gnomo, hombre)' WHERE `locale` = 'esES' AND `entry` = 10793;
-- OLD name : Orbe de engaño (gnomo, mujer)
-- Source : https://www.wowhead.com/wotlk/es/npc=10794
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (gnomo, mujer)' WHERE `locale` = 'esES' AND `entry` = 10794;
-- OLD name : Orbe de engaño (humano)
-- Source : https://www.wowhead.com/wotlk/es/npc=10795
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (humana)' WHERE `locale` = 'esES' AND `entry` = 10795;
-- OLD name : Orbe de engaño (humana)
-- Source : https://www.wowhead.com/wotlk/es/npc=10796
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (humano)' WHERE `locale` = 'esES' AND `entry` = 10796;
-- OLD name : Orbe de engaño (elfo de la noche)
-- Source : https://www.wowhead.com/wotlk/es/npc=10797
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (elfo de la noche)' WHERE `locale` = 'esES' AND `entry` = 10797;
-- OLD name : Orbe de engaño (elfa de la noche)
-- Source : https://www.wowhead.com/wotlk/es/npc=10798
UPDATE `creature_template_locale` SET `Name` = 'Orbe de la decepción (elfa de la noche)' WHERE `locale` = 'esES' AND `entry` = 10798;
-- OLD name : [UNUSED] Hija de Majestis (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=10810
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 10810;
-- OLD name : Instructor Galford
-- Source : https://www.wowhead.com/wotlk/es/npc=10811
UPDATE `creature_template_locale` SET `Name` = 'Archivista Galford' WHERE `locale` = 'esES' AND `entry` = 10811;
-- OLD name : Gran cruzado Dathrohan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=10812
UPDATE `creature_template_locale` SET `Name` = 'Gran Cruzado Dathrohan' WHERE `locale` = 'esES' AND `entry` = 10812;
-- OLD name : Cazador letal Lanzalcón
-- Source : https://www.wowhead.com/wotlk/es/npc=10824
UPDATE `creature_template_locale` SET `Name` = 'Señor forestal Lanzalcón' WHERE `locale` = 'esES' AND `entry` = 10824;
-- OLD name : Lynnia Abbendis
-- Source : https://www.wowhead.com/wotlk/es/npc=10828
UPDATE `creature_template_locale` SET `Name` = 'Alta general Abbendis' WHERE `locale` = 'esES' AND `entry` = 10828;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=10839
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 10839;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=10840
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 10840;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=10857
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 10857;
-- OLD name : Gusano en podredumbre
-- Source : https://www.wowhead.com/wotlk/es/npc=10925
UPDATE `creature_template_locale` SET `Name` = 'Gusano putrefacto' WHERE `locale` = 'esES' AND `entry` = 10925;
-- OLD name : Cadáver merodeador
-- Source : https://www.wowhead.com/wotlk/es/npc=10951
UPDATE `creature_template_locale` SET `Name` = 'Cadáver Maraudine' WHERE `locale` = 'esES' AND `entry` = 10951;
-- OLD name : Esqueleto merodeador
-- Source : https://www.wowhead.com/wotlk/es/npc=10952
UPDATE `creature_template_locale` SET `Name` = 'Esqueleto Maraudine' WHERE `locale` = 'esES' AND `entry` = 10952;
-- OLD name : Flebotomista
-- Source : https://www.wowhead.com/wotlk/es/npc=10954
UPDATE `creature_template_locale` SET `Name` = 'Estampa de Sangre' WHERE `locale` = 'esES' AND `entry` = 10954;
-- OLD name : Espíritu de kodo
-- Source : https://www.wowhead.com/wotlk/es/npc=10988
UPDATE `creature_template_locale` SET `Name` = 'Espíritu Kodo' WHERE `locale` = 'esES' AND `entry` = 10988;
-- OLD name : Willey Rompeesperanzas
-- Source : https://www.wowhead.com/wotlk/es/npc=10997
UPDATE `creature_template_locale` SET `Name` = 'Cañonero Jefe Willey' WHERE `locale` = 'esES' AND `entry` = 10997;
-- OLD name : Sable de hielo de Cuna del Invierno
-- Source : https://www.wowhead.com/wotlk/es/npc=11021
UPDATE `creature_template_locale` SET `Name` = 'Tigre de montar (nevado)' WHERE `locale` = 'esES' AND `entry` = 11021;
-- OLD name : Comandante Malor
-- Source : https://www.wowhead.com/wotlk/es/npc=11032
UPDATE `creature_template_locale` SET `Name` = 'Malor el Entusiasta' WHERE `locale` = 'esES' AND `entry` = 11032;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11034
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11034;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11036
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11036;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11039
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11039;
-- OLD name : Monje resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=11043
UPDATE `creature_template_locale` SET `Name` = 'Monje Carmesí' WHERE `locale` = 'esES' AND `entry` = 11043;
-- OLD name : Fusilero resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=11054
UPDATE `creature_template_locale` SET `Name` = 'Fusilero Carmesí' WHERE `locale` = 'esES' AND `entry` = 11054;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/es/npc=11058
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'esES' AND `entry` = 11058;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11063
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11063;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=11073
UPDATE `creature_template_locale` SET `Title` = 'Instructora de encantamientos' WHERE `locale` = 'esES' AND `entry` = 11073;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=11074
UPDATE `creature_template_locale` SET `Title` = 'Instructor de encantamientos' WHERE `locale` = 'esES' AND `entry` = 11074;
-- OLD name : [PH[ Probador de combate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11080;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11102
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11102;
-- OLD name : Forjamartillos resucitado
-- Source : https://www.wowhead.com/wotlk/es/npc=11120
UPDATE `creature_template_locale` SET `Name` = 'Forjamartillos Carmesí' WHERE `locale` = 'esES' AND `entry` = 11120;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=11146
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armas' WHERE `locale` = 'esES' AND `entry` = 11146;
-- OLD name : Mecazancudo morado
-- Source : https://www.wowhead.com/wotlk/es/npc=11148
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo de montar (morado)' WHERE `locale` = 'esES' AND `entry` = 11148;
-- OLD name : Mecazancudo rojo y azul
-- Source : https://www.wowhead.com/wotlk/es/npc=11149
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo de montar (rojo/azul)' WHERE `locale` = 'esES' AND `entry` = 11149;
-- OLD name : Mecazancudo azul hielo modelo A
-- Source : https://www.wowhead.com/wotlk/es/npc=11150
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo de montar (azul hielo)' WHERE `locale` = 'esES' AND `entry` = 11150;
-- OLD name : Caballo esquelético marrón
-- Source : https://www.wowhead.com/wotlk/es/npc=11155
UPDATE `creature_template_locale` SET `Name` = 'Caballo esquelético de montar (marrón)' WHERE `locale` = 'esES' AND `entry` = 11155;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=11177
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armaduras' WHERE `locale` = 'esES' AND `entry` = 11177;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=11178
UPDATE `creature_template_locale` SET `Title` = 'Forjador de armas' WHERE `locale` = 'esES' AND `entry` = 11178;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11194
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11194;
-- OLD name : Destrero de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=11195
UPDATE `creature_template_locale` SET `Name` = 'Caballo de guerra esquelético negro' WHERE `locale` = 'esES' AND `entry` = 11195;
-- OLD name : Cañón carmesí (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=11199
UPDATE `creature_template_locale` SET `Name` = 'Cañón Carmesí' WHERE `locale` = 'esES' AND `entry` = 11199;
-- OLD name : Fustamusgo sin vida
-- Source : https://www.wowhead.com/wotlk/es/npc=11291
UPDATE `creature_template_locale` SET `Name` = 'Arrancamusgo sin vida' WHERE `locale` = 'esES' AND `entry` = 11291;
-- OLD name : Elemental de magma
-- Source : https://www.wowhead.com/wotlk/es/npc=11321
UPDATE `creature_template_locale` SET `Name` = 'Elemental fundido' WHERE `locale` = 'esES' AND `entry` = 11321;
-- OLD name : Cultor Hoja Abrasadora
-- Source : https://www.wowhead.com/wotlk/es/npc=11322
UPDATE `creature_template_locale` SET `Name` = 'Fiel Hoja abrasadora' WHERE `locale` = 'esES' AND `entry` = 11322;
-- OLD name : Déspota Hoja Abrasadora (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=11323
UPDATE `creature_template_locale` SET `Name` = 'Déspota Hoja abrasadora' WHERE `locale` = 'esES' AND `entry` = 11323;
-- OLD name : [UNUSED] Lanzahachas Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11337
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11337;
-- OLD name : Taumaturgo umbrío Hakkari
-- Source : https://www.wowhead.com/wotlk/es/npc=11338
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro Hakkari' WHERE `locale` = 'esES' AND `entry` = 11338;
-- OLD name : [UNUSED] Rabioso Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11341;
-- OLD name : [UNUSED] Guerrero Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11342
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11342;
-- OLD name : [UNUSED] Señor de la guerra Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11343
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11343;
-- OLD name : [UNUSED] Bebesangre Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11344
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11344;
-- OLD name : [UNUSED] Rebanacabezas Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11345
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11345;
-- OLD name : [UNUSED] Desollador Gurubashi (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11349
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11349;
-- OLD name : [UNUSED] Señor de la guerra Gurubashi (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11354
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11354;
-- OLD name : [UNUSED] Hija de Hakkar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11358
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11358;
-- OLD name : [UNUSED] Tigresa Zulian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11364
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11364;
-- OLD name : [UNUSED] Matriarca Zulian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11366
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11366;
-- OLD name : [UNUSED] Patriarca Zulian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11367
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11367;
-- OLD name : [UNUSED] buscasangre Oculto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11369
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11369;
-- OLD name : [UNUSED] Zath (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11375
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11375;
-- OLD name : [UNUSED] Lor'khan (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11376
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11376;
-- OLD name : [UNUSED] Hak'tharr el Cazamentes (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11377
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11377;
-- OLD name : [UNUSED] Nik'reesh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11379
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11379;
-- OLD name : [UNUSED] T'kashra viejo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11384
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11384;
-- OLD name : [UNUSED] Mogwhi el Implacable (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11385
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11385;
-- OLD name : [UNUSED] Janook el Furiafilada (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11386
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11386;
-- OLD name : Ogro mago Gordok
-- Source : https://www.wowhead.com/wotlk/es/npc=11443
UPDATE `creature_template_locale` SET `Name` = 'Mago ogro Gordok' WHERE `locale` = 'esES' AND `entry` = 11443;
-- OLD name : Señor de la magia Gordok (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=11444
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Magia Gordok' WHERE `locale` = 'esES' AND `entry` = 11444;
-- OLD name : [UNUSED] Mago de Batalla Gordok (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11449
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11449;
-- OLD name : Guardián Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=11461
UPDATE `creature_template_locale` SET `Name` = 'Guardián Combadera' WHERE `locale` = 'esES' AND `entry` = 11461;
-- OLD name : Antárbol Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=11462
UPDATE `creature_template_locale` SET `Name` = 'Antárbol Combadera' WHERE `locale` = 'esES' AND `entry` = 11462;
-- OLD name : [UNUSED] Escarbador Tuercemadera (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11463
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11463;
-- OLD name : Enmarañador Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=11464
UPDATE `creature_template_locale` SET `Name` = 'Enmarañador Combadera' WHERE `locale` = 'esES' AND `entry` = 11464;
-- OLD name : Vapuleador Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=11465
UPDATE `creature_template_locale` SET `Name` = 'Vapuleador Combadera' WHERE `locale` = 'esES' AND `entry` = 11465;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=11466
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 11466;
-- OLD name : [UNUSED] Eldreth Exanimato (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11468
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11468;
-- OLD name : [UNUSED] Bestia de maná (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11478
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11478;
-- OLD name : [UNUSED] Horror Arcano
-- Source : https://www.wowhead.com/wotlk/es/npc=11479
UPDATE `creature_template_locale` SET `Name` = 'Horror Arcano' WHERE `locale` = 'esES' AND `entry` = 11479;
-- OLD name : [UNUSED] Terror Arcano (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11481
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11481;
-- OLD subname : Gobernador de los Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=11486
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 11486;
-- OLD name : Tendris Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=11489
UPDATE `creature_template_locale` SET `Name` = 'Tendris Madeguerra' WHERE `locale` = 'esES' AND `entry` = 11489;
-- OLD name : [UNUSED] Sentius (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11493
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11493;
-- OLD name : [UNUSED] Avidus (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11495
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11495;
-- OLD name : Skarr el Roto
-- Source : https://www.wowhead.com/wotlk/es/npc=11498
UPDATE `creature_template_locale` SET `Name` = 'Skarr el Inquebrantable' WHERE `locale` = 'esES' AND `entry` = 11498;
-- OLD name : [UNUSED] Comandante Gormaul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11499
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11499;
-- OLD name : [UNUSED] Majordomo Bagrosh (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11500
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11500;
-- OLD name : Aparecido kodo
-- Source : https://www.wowhead.com/wotlk/es/npc=11521
UPDATE `creature_template_locale` SET `Name` = 'Aparición de kodo' WHERE `locale` = 'esES' AND `entry` = 11521;
-- OLD name : Intendente Miranda Cerrobrecha, subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=11536
UPDATE `creature_template_locale` SET `Name` = 'Intendente Cerrobrecha',`Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 11536;
-- OLD name : Cadáver putrefacto
-- Source : https://www.wowhead.com/wotlk/es/npc=11628
UPDATE `creature_template_locale` SET `Name` = 'Cadáver en descomposición' WHERE `locale` = 'esES' AND `entry` = 11628;
-- OLD name : Destructor de magma
-- Source : https://www.wowhead.com/wotlk/es/npc=11659
UPDATE `creature_template_locale` SET `Name` = 'Destructor fundido' WHERE `locale` = 'esES' AND `entry` = 11659;
-- OLD name : [UNUSED] Coloso fundido (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11660
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11660;
-- OLD name : [UNUSED] Escupefuego (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11670
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11670;
-- OLD name : Can del Núcleo
-- Source : https://www.wowhead.com/wotlk/es/npc=11673
UPDATE `creature_template_locale` SET `Name` = 'Can del Núcleo anciano' WHERE `locale` = 'esES' AND `entry` = 11673;
-- OLD name : Deforestador goblin
-- Source : https://www.wowhead.com/wotlk/es/npc=11684
UPDATE `creature_template_locale` SET `Name` = 'Machacador Grito de Guerra' WHERE `locale` = 'esES' AND `entry` = 11684;
-- OLD name : Kodo marrón
-- Source : https://www.wowhead.com/wotlk/es/npc=11689
UPDATE `creature_template_locale` SET `Name` = 'Kodo de montar (marrón)' WHERE `locale` = 'esES' AND `entry` = 11689;
-- OLD subname : Instructoras de sableinvernales (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=11696
UPDATE `creature_template_locale` SET `Title` = 'Instructoras de Sableinvernales' WHERE `locale` = 'esES' AND `entry` = 11696;
-- OLD subname : Mercader de armaduras de malla
-- Source : https://www.wowhead.com/wotlk/es/npc=11703
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armaduras' WHERE `locale` = 'esES' AND `entry` = 11703;
-- OLD name : Oteador de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=11725
UPDATE `creature_template_locale` SET `Name` = 'Oteador Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 11725;
-- OLD name : Tunelador de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=11726
UPDATE `creature_template_locale` SET `Name` = 'Tunelador Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 11726;
-- OLD name : Avispa de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=11727
UPDATE `creature_template_locale` SET `Name` = 'Avispa Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 11727;
-- OLD name : Atracador de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=11728
UPDATE `creature_template_locale` SET `Name` = 'Atracador Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 11728;
-- OLD name : Hermana de colmena de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=11729
UPDATE `creature_template_locale` SET `Name` = 'Hermana de colmena Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 11729;
-- OLD name : Escórpido Latipiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=11735
UPDATE `creature_template_locale` SET `Name` = 'Escórpido Latigosólido' WHERE `locale` = 'esES' AND `entry` = 11735;
-- OLD name : Tenazario Latipiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=11736
UPDATE `creature_template_locale` SET `Name` = 'Tenazario Latigosólido' WHERE `locale` = 'esES' AND `entry` = 11736;
-- OLD name : Despellejador Latipiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=11737
UPDATE `creature_template_locale` SET `Name` = 'Despellejador Latigosólido' WHERE `locale` = 'esES' AND `entry` = 11737;
-- OLD name : Acecharrocas
-- Source : https://www.wowhead.com/wotlk/es/npc=11739
UPDATE `creature_template_locale` SET `Name` = 'Acechador de piedra' WHERE `locale` = 'esES' AND `entry` = 11739;
-- OLD name : Triturador deslizante
-- Source : https://www.wowhead.com/wotlk/es/npc=11741
UPDATE `creature_template_locale` SET `Name` = 'Triturador de arrastre' WHERE `locale` = 'esES' AND `entry` = 11741;
-- OLD name : Larva de cieno
-- Source : https://www.wowhead.com/wotlk/es/npc=11742
UPDATE `creature_template_locale` SET `Name` = 'Larba de cieno' WHERE `locale` = 'esES' AND `entry` = 11742;
-- OLD name : Jarund Zancada Recia
-- Source : https://www.wowhead.com/wotlk/es/npc=11805
UPDATE `creature_template_locale` SET `Name` = 'Jarund Zancaforte' WHERE `locale` = 'esES' AND `entry` = 11805;
-- OLD subname : Maestra de Armas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=11866
UPDATE `creature_template_locale` SET `Title` = 'Maestra de armas' WHERE `locale` = 'esES' AND `entry` = 11866;
-- OLD name : Alaocaso
-- Source : https://www.wowhead.com/wotlk/es/npc=11897
UPDATE `creature_template_locale` SET `Name` = 'Alatardecer' WHERE `locale` = 'esES' AND `entry` = 11897;
-- OLD name : Penelope
-- Source : https://www.wowhead.com/wotlk/es/npc=11909
UPDATE `creature_template_locale` SET `Name` = 'Penélope' WHERE `locale` = 'esES' AND `entry` = 11909;
-- OLD name : Vigilapiedras del Alud
-- Source : https://www.wowhead.com/wotlk/es/npc=11915
UPDATE `creature_template_locale` SET `Name` = 'Vigilapedras Gogger' WHERE `locale` = 'esES' AND `entry` = 11915;
-- OLD name : Geomántico del Alud
-- Source : https://www.wowhead.com/wotlk/es/npc=11917
UPDATE `creature_template_locale` SET `Name` = 'Geomántico Gogger' WHERE `locale` = 'esES' AND `entry` = 11917;
-- OLD name : Machacapiedras del Alud
-- Source : https://www.wowhead.com/wotlk/es/npc=11918
UPDATE `creature_template_locale` SET `Name` = 'Machacapedras Gogger' WHERE `locale` = 'esES' AND `entry` = 11918;
-- OLD name : [PH] Dispensador de regalos de Villanorte (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11926
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11926;
-- OLD name : [UNUSED] Vigía obsidiano (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11959
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11959;
-- OLD name : [NOT USED] Neltharion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=11978
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 11978;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=12020
UPDATE `creature_template_locale` SET `Title` = 'Artesano alquimista' WHERE `locale` = 'esES' AND `entry` = 12020;
-- OLD name : Grella Puñopiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=12036
UPDATE `creature_template_locale` SET `Name` = 'Productos generales de Pico Nidal' WHERE `locale` = 'esES' AND `entry` = 12036;
-- OLD name : Brannik Panzahierro
-- Source : https://www.wowhead.com/wotlk/es/npc=12040
UPDATE `creature_template_locale` SET `Name` = 'Vendedor de armaduras de malla de Pico Nidal' WHERE `locale` = 'esES' AND `entry` = 12040;
-- OLD name : Presagista Sulfuron
-- Source : https://www.wowhead.com/wotlk/es/npc=12098
UPDATE `creature_template_locale` SET `Name` = 'Sulfuron Presagista' WHERE `locale` = 'esES' AND `entry` = 12098;
-- OLD name : Jurafuegos
-- Source : https://www.wowhead.com/wotlk/es/npc=12099
UPDATE `creature_template_locale` SET `Name` = 'Jurafuego' WHERE `locale` = 'esES' AND `entry` = 12099;
-- OLD name : Custodio Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=12127
UPDATE `creature_template_locale` SET `Name` = 'Guardia Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 12127;
-- OLD name : Hijo de la llama
-- Source : https://www.wowhead.com/wotlk/es/npc=12143
UPDATE `creature_template_locale` SET `Name` = 'Hijo de Flama' WHERE `locale` = 'esES' AND `entry` = 12143;
-- OLD name : Kodo azulado
-- Source : https://www.wowhead.com/wotlk/es/npc=12148
UPDATE `creature_template_locale` SET `Name` = 'Kodo de montar (ario)' WHERE `locale` = 'esES' AND `entry` = 12148;
-- OLD name : Kodo verde
-- Source : https://www.wowhead.com/wotlk/es/npc=12151
UPDATE `creature_template_locale` SET `Name` = 'Kodo de montar (verde)' WHERE `locale` = 'esES' AND `entry` = 12151;
-- OLD name : Kodo domado
-- Source : https://www.wowhead.com/wotlk/es/npc=12176
UPDATE `creature_template_locale` SET `Name` = 'Kodo de doma' WHERE `locale` = 'esES' AND `entry` = 12176;
-- OLD name : Centinela torturada
-- Source : https://www.wowhead.com/wotlk/es/npc=12179
UPDATE `creature_template_locale` SET `Name` = 'Centinela torturado' WHERE `locale` = 'esES' AND `entry` = 12179;
-- OLD name : Alma de Clamañublo conquistada
-- Source : https://www.wowhead.com/wotlk/es/npc=12208
UPDATE `creature_template_locale` SET `Name` = 'Alma invadida de Clamorinfecto' WHERE `locale` = 'esES' AND `entry` = 12208;
-- OLD name : Rondador de la Caverna
-- Source : https://www.wowhead.com/wotlk/es/npc=12223
UPDATE `creature_template_locale` SET `Name` = 'Rondador de cavernas' WHERE `locale` = 'esES' AND `entry` = 12223;
-- OLD name : Arrastrapiés de la Caverna
-- Source : https://www.wowhead.com/wotlk/es/npc=12224
UPDATE `creature_template_locale` SET `Name` = 'Arrastrado de la caverna' WHERE `locale` = 'esES' AND `entry` = 12224;
-- OLD subname : El Segundo Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=12239
UPDATE `creature_template_locale` SET `Title` = 'El Segundo kahn' WHERE `locale` = 'esES' AND `entry` = 12239;
-- OLD subname : El Primer Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=12240
UPDATE `creature_template_locale` SET `Title` = 'El Primer kahn' WHERE `locale` = 'esES' AND `entry` = 12240;
-- OLD subname : El Tercer Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=12241
UPDATE `creature_template_locale` SET `Title` = 'El Tercer kahn' WHERE `locale` = 'esES' AND `entry` = 12241;
-- OLD subname : El Cuarto Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=12242
UPDATE `creature_template_locale` SET `Title` = 'El Cuarto kahn' WHERE `locale` = 'esES' AND `entry` = 12242;
-- OLD subname : El Quinto Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=12243
UPDATE `creature_template_locale` SET `Title` = 'El Quinto kahn' WHERE `locale` = 'esES' AND `entry` = 12243;
-- OLD name : Marca de detonación (CRS)
-- Source : https://www.wowhead.com/wotlk/es/npc=12252
UPDATE `creature_template_locale` SET `Name` = 'Marca de detonación (CLS)' WHERE `locale` = 'esES' AND `entry` = 12252;
-- OLD name : Marca de detonación (CSH)
-- Source : https://www.wowhead.com/wotlk/es/npc=12253
UPDATE `creature_template_locale` SET `Name` = 'Marca de detonación (CLS)' WHERE `locale` = 'esES' AND `entry` = 12253;
-- OLD name : Marca de detonación (NESH)
-- Source : https://www.wowhead.com/wotlk/es/npc=12254
UPDATE `creature_template_locale` SET `Name` = 'Marca de detonación ()' WHERE `locale` = 'esES' AND `entry` = 12254;
-- OLD name : Marca de detonación (NE)
-- Source : https://www.wowhead.com/wotlk/es/npc=12255
UPDATE `creature_template_locale` SET `Name` = 'Marca de detonación (CLS)' WHERE `locale` = 'esES' AND `entry` = 12255;
-- OLD name : Fustamusgo infectado
-- Source : https://www.wowhead.com/wotlk/es/npc=12261
UPDATE `creature_template_locale` SET `Name` = 'Arrancamusgo infectado' WHERE `locale` = 'esES' AND `entry` = 12261;
-- OLD name : Huevo de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=12276
UPDATE `creature_template_locale` SET `Name` = 'Huevo Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 12276;
-- OLD name : Caballo esquelético verde presto
-- Source : https://www.wowhead.com/wotlk/es/npc=12344
UPDATE `creature_template_locale` SET `Name` = 'Caballo esquelético verde veloz' WHERE `locale` = 'esES' AND `entry` = 12344;
-- OLD name : Raptor carmesí jaspeado
-- Source : https://www.wowhead.com/wotlk/es/npc=12345
UPDATE `creature_template_locale` SET `Name` = 'Raptor rojo jaspeado' WHERE `locale` = 'esES' AND `entry` = 12345;
-- OLD name : Raptor de montar de esmeralda
-- Source : https://www.wowhead.com/wotlk/es/npc=12346
UPDATE `creature_template_locale` SET `Name` = 'Raptor de montar esmeralda' WHERE `locale` = 'esES' AND `entry` = 12346;
-- OLD name : Raptor de marfil
-- Source : https://www.wowhead.com/wotlk/es/npc=12348
UPDATE `creature_template_locale` SET `Name` = 'Raptor marfil' WHERE `locale` = 'esES' AND `entry` = 12348;
-- OLD name : Raptor de turquesa de montar
-- Source : https://www.wowhead.com/wotlk/es/npc=12349
UPDATE `creature_template_locale` SET `Name` = 'Raptor turquesa de montar' WHERE `locale` = 'esES' AND `entry` = 12349;
-- OLD name : Sable de hielo de montar rayado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=12358
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo de montar rayado' WHERE `locale` = 'esES' AND `entry` = 12358;
-- OLD name : Sable de hielo de montar moteado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=12359
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo de montar moteado' WHERE `locale` = 'esES' AND `entry` = 12359;
-- OLD name : Sable de hielo de montar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=12362
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo de montar' WHERE `locale` = 'esES' AND `entry` = 12362;
-- OLD name : Mecazancudo blanco modelo A (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=12368
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo blanco Modelo A' WHERE `locale` = 'esES' AND `entry` = 12368;
-- OLD name : Espectro gemebundo
-- Source : https://www.wowhead.com/wotlk/es/npc=12377
UPDATE `creature_template_locale` SET `Name` = 'Espectro de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 12377;
-- OLD name : [NOT USED] cría Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12417
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12417;
-- OLD name : [NOT USED] Asesino Alanegra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12421
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12421;
-- OLD name : Viejo Malafauce
-- Source : https://www.wowhead.com/wotlk/es/npc=12432
UPDATE `creature_template_locale` SET `Name` = 'Viejo mentovilo' WHERE `locale` = 'esES' AND `entry` = 12432;
-- OLD name : Krethis Tejeumbra
-- Source : https://www.wowhead.com/wotlk/es/npc=12433
UPDATE `creature_template_locale` SET `Name` = 'Krethis Sombravolta' WHERE `locale` = 'esES' AND `entry` = 12433;
-- OLD name : Vinculahechizos Alanegra
-- Source : https://www.wowhead.com/wotlk/es/npc=12457
UPDATE `creature_template_locale` SET `Name` = 'Vinculador de hechizos Alanegra' WHERE `locale` = 'esES' AND `entry` = 12457;
-- OLD name : [NOT USED] Señor de la guerra Alanegra (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12462
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12462;
-- OLD name : Flamaescama Garramortal
-- Source : https://www.wowhead.com/wotlk/es/npc=12463
UPDATE `creature_template_locale` SET `Name` = 'Flamascama Garramortal' WHERE `locale` = 'esES' AND `entry` = 12463;
-- OLD name : Verminte Garramortal
-- Source : https://www.wowhead.com/wotlk/es/npc=12465
UPDATE `creature_template_locale` SET `Name` = 'Vermis Garramortal' WHERE `locale` = 'esES' AND `entry` = 12465;
-- OLD name : [NOT USED] Horrocrusto Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12466
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12466;
-- OLD name : [NOT USED] Sacudetierra Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12469
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12469;
-- OLD name : [NOT USED] Lenguaflama Garraletal (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12470;
-- OLD subname : Reclutadora de Ventormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=12481
UPDATE `creature_template_locale` SET `Title` = 'Reclutador de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 12481;
-- OLD name : Garfafilada
-- Source : https://www.wowhead.com/wotlk/es/npc=12676
UPDATE `creature_template_locale` SET `Name` = 'Garrafilada' WHERE `locale` = 'esES' AND `entry` = 12676;
-- OLD name : Capitán Martillo de Endecha
-- Source : https://www.wowhead.com/wotlk/es/npc=12777
UPDATE `creature_template_locale` SET `Name` = 'Capitán Martillo Temible' WHERE `locale` = 'esES' AND `entry` = 12777;
-- OLD name : Devorador quimerok (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=12802
UPDATE `creature_template_locale` SET `Name` = 'Devorador Quimerok' WHERE `locale` = 'esES' AND `entry` = 12802;
-- OLD name : [PH] TEST Dios de fuego (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=12804
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 12804;
-- OLD name : Forma de oso de Ruul Pezuña Nevada
-- Source : https://www.wowhead.com/wotlk/es/npc=12819
UPDATE `creature_template_locale` SET `Name` = 'Forma de oso de Ruul Pezuñablanca' WHERE `locale` = 'esES' AND `entry` = 12819;
-- OLD name : Explorador Grito de Guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=12862
UPDATE `creature_template_locale` SET `Name` = 'Exploradora Grito de Guerra' WHERE `locale` = 'esES' AND `entry` = 12862;
-- OLD name : Espíritu de redención
-- Source : https://www.wowhead.com/wotlk/es/npc=12904
UPDATE `creature_template_locale` SET `Name` = 'Espíritu redentor' WHERE `locale` = 'esES' AND `entry` = 12904;
-- OLD name : Soldado con heridas leves
-- Source : https://www.wowhead.com/wotlk/es/npc=12923
UPDATE `creature_template_locale` SET `Name` = 'Soldado herido' WHERE `locale` = 'esES' AND `entry` = 12923;
-- OLD name : Soldado con heridas medias
-- Source : https://www.wowhead.com/wotlk/es/npc=12924
UPDATE `creature_template_locale` SET `Name` = 'Soldado malherido' WHERE `locale` = 'esES' AND `entry` = 12924;
-- OLD name : Soldado con heridas graves
-- Source : https://www.wowhead.com/wotlk/es/npc=12925
UPDATE `creature_template_locale` SET `Name` = 'Soldado gravemente herido' WHERE `locale` = 'esES' AND `entry` = 12925;
-- OLD name : Soldado con heridas medias
-- Source : https://www.wowhead.com/wotlk/es/npc=12936
UPDATE `creature_template_locale` SET `Name` = 'Soldado de la Alianza malherido' WHERE `locale` = 'esES' AND `entry` = 12936;
-- OLD name : Soldado con heridas graves
-- Source : https://www.wowhead.com/wotlk/es/npc=12937
UPDATE `creature_template_locale` SET `Name` = 'Soldado de la Alianza gravemente herido' WHERE `locale` = 'esES' AND `entry` = 12937;
-- OLD name : Soldado con heridas leves
-- Source : https://www.wowhead.com/wotlk/es/npc=12938
UPDATE `creature_template_locale` SET `Name` = 'Soldado de la Alianza malherido' WHERE `locale` = 'esES' AND `entry` = 12938;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=12939
UPDATE `creature_template_locale` SET `Title` = 'Cirujano del dispensario' WHERE `locale` = 'esES' AND `entry` = 12939;
-- OLD name : Triturador Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=13021
UPDATE `creature_template_locale` SET `Name` = 'Triturador Combadera' WHERE `locale` = 'esES' AND `entry` = 13021;
-- OLD name : Sabueso Gordok
-- Source : https://www.wowhead.com/wotlk/es/npc=13036
UPDATE `creature_template_locale` SET `Name` = 'Masadura Gordok' WHERE `locale` = 'esES' AND `entry` = 13036;
-- OLD subname : Maestra de Armas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=13084
UPDATE `creature_template_locale` SET `Title` = 'Maestra de armas' WHERE `locale` = 'esES' AND `entry` = 13084;
-- OLD name : Comandante Dardosh <old>
-- Source : https://www.wowhead.com/wotlk/es/npc=13140
UPDATE `creature_template_locale` SET `Name` = 'Comandante Dardosh' WHERE `locale` = 'esES' AND `entry` = 13140;
-- OLD name : Teniente Pezuña Fuerte
-- Source : https://www.wowhead.com/wotlk/es/npc=13143
UPDATE `creature_template_locale` SET `Name` = 'Teniente Pezuñaforte' WHERE `locale` = 'esES' AND `entry` = 13143;
-- OLD name : Teniente Murp <old>
-- Source : https://www.wowhead.com/wotlk/es/npc=13146
UPDATE `creature_template_locale` SET `Name` = 'Teniente Murp' WHERE `locale` = 'esES' AND `entry` = 13146;
-- OLD name : Comandante Luis Philips
-- Source : https://www.wowhead.com/wotlk/es/npc=13154
UPDATE `creature_template_locale` SET `Name` = 'Comandante Luis Filis' WHERE `locale` = 'esES' AND `entry` = 13154;
-- OLD name : Grifo nidal (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=13161
UPDATE `creature_template_locale` SET `Name` = 'Grifo Nidal' WHERE `locale` = 'esES' AND `entry` = 13161;
-- OLD name : Layo Golpe Estelar
-- Source : https://www.wowhead.com/wotlk/es/npc=13220
UPDATE `creature_template_locale` SET `Name` = 'Layo Estrella' WHERE `locale` = 'esES' AND `entry` = 13220;
-- OLD name : Teniente Varagris
-- Source : https://www.wowhead.com/wotlk/es/npc=13298
UPDATE `creature_template_locale` SET `Name` = 'Teniente Greywand' WHERE `locale` = 'esES' AND `entry` = 13298;
-- OLD name : Rana pequeña
-- Source : https://www.wowhead.com/wotlk/es/npc=13321
UPDATE `creature_template_locale` SET `Name` = 'Rana' WHERE `locale` = 'esES' AND `entry` = 13321;
-- OLD name : Centinela veterana
-- Source : https://www.wowhead.com/wotlk/es/npc=13336
UPDATE `creature_template_locale` SET `Name` = 'Centinela veterano' WHERE `locale` = 'esES' AND `entry` = 13336;
-- OLD name : Posaminas Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=13356
UPDATE `creature_template_locale` SET `Name` = 'Posaminas de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 13356;
-- OLD name : Unidad machacadora Lobo Gélido
-- Source : https://www.wowhead.com/wotlk/es/npc=13378
UPDATE `creature_template_locale` SET `Name` = 'Unidad machacadora de Lobo Gélido' WHERE `locale` = 'esES' AND `entry` = 13378;
-- OLD name : Unidad machacadora Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=13416
UPDATE `creature_template_locale` SET `Name` = 'Unidad machacadora de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 13416;
-- OLD name : Centinela Campeona
-- Source : https://www.wowhead.com/wotlk/es/npc=13427
UPDATE `creature_template_locale` SET `Name` = 'Centinela Campeón' WHERE `locale` = 'esES' AND `entry` = 13427;
-- OLD name : Forestal Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=13520
UPDATE `creature_template_locale` SET `Name` = 'Forestal de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 13520;
-- OLD name : Forestal avezada
-- Source : https://www.wowhead.com/wotlk/es/npc=13521
UPDATE `creature_template_locale` SET `Name` = 'Forestal avezado' WHERE `locale` = 'esES' AND `entry` = 13521;
-- OLD name : Forestal veterana
-- Source : https://www.wowhead.com/wotlk/es/npc=13522
UPDATE `creature_template_locale` SET `Name` = 'Forestal veterano' WHERE `locale` = 'esES' AND `entry` = 13522;
-- OLD name : Forestal Campeona
-- Source : https://www.wowhead.com/wotlk/es/npc=13523
UPDATE `creature_template_locale` SET `Name` = 'Forestal Campeón' WHERE `locale` = 'esES' AND `entry` = 13523;
-- OLD name : Guarda de Minafría avezado
-- Source : https://www.wowhead.com/wotlk/es/npc=13534
UPDATE `creature_template_locale` SET `Name` = 'Guarda Minafría avezado' WHERE `locale` = 'esES' AND `entry` = 13534;
-- OLD name : Perito de Minafría avezado
-- Source : https://www.wowhead.com/wotlk/es/npc=13537
UPDATE `creature_template_locale` SET `Name` = 'Perito Minafría avezado' WHERE `locale` = 'esES' AND `entry` = 13537;
-- OLD name : Expedicionario veterano Ferrohondo
-- Source : https://www.wowhead.com/wotlk/es/npc=13541
UPDATE `creature_template_locale` SET `Name` = 'Expedicionario veterano de Ferrohondo' WHERE `locale` = 'esES' AND `entry` = 13541;
-- OLD name : Expedicionario Campeón Ferrohondo
-- Source : https://www.wowhead.com/wotlk/es/npc=13542
UPDATE `creature_template_locale` SET `Name` = 'Expedicionario Campeona Ferrohondo' WHERE `locale` = 'esES' AND `entry` = 13542;
-- OLD name : Expedicionario de Minafría avezado
-- Source : https://www.wowhead.com/wotlk/es/npc=13546
UPDATE `creature_template_locale` SET `Name` = 'Expedicionario Minafría avezado' WHERE `locale` = 'esES' AND `entry` = 13546;
-- OLD name : Invasor de Minafría avezado
-- Source : https://www.wowhead.com/wotlk/es/npc=13549
UPDATE `creature_template_locale` SET `Name` = 'Invasor Minafría avezado' WHERE `locale` = 'esES' AND `entry` = 13549;
-- OLD name : Experto en explosivos Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=13598
UPDATE `creature_template_locale` SET `Name` = 'Experto de explosivos de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 13598;
-- OLD name : Muñeco de nieve extraño
-- Source : https://www.wowhead.com/wotlk/es/npc=13636
UPDATE `creature_template_locale` SET `Name` = 'Hombrenieve extraño' WHERE `locale` = 'esES' AND `entry` = 13636;
-- OLD name : Sucesor tóxico
-- Source : https://www.wowhead.com/wotlk/es/npc=13696
UPDATE `creature_template_locale` SET `Name` = 'Vástago tóxico' WHERE `locale` = 'esES' AND `entry` = 13696;
-- OLD subname : El Quinto Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=13738
UPDATE `creature_template_locale` SET `Title` = 'El Quinto kahn' WHERE `locale` = 'esES' AND `entry` = 13738;
-- OLD subname : El Cuarto Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=13739
UPDATE `creature_template_locale` SET `Title` = 'El Cuarto kahn' WHERE `locale` = 'esES' AND `entry` = 13739;
-- OLD subname : El Tercer Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=13740
UPDATE `creature_template_locale` SET `Title` = 'El Tercer kahn' WHERE `locale` = 'esES' AND `entry` = 13740;
-- OLD subname : El Segundo Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=13741
UPDATE `creature_template_locale` SET `Title` = 'El Segundo kahn' WHERE `locale` = 'esES' AND `entry` = 13741;
-- OLD subname : El Primer Khan
-- Source : https://www.wowhead.com/wotlk/es/npc=13742
UPDATE `creature_template_locale` SET `Title` = 'El Primer kahn' WHERE `locale` = 'esES' AND `entry` = 13742;
-- OLD name : Cabo Teeka Gruñido Sangriento
-- Source : https://www.wowhead.com/wotlk/es/npc=13776
UPDATE `creature_template_locale` SET `Name` = 'Cabo Teeka Gruñidosangriento' WHERE `locale` = 'esES' AND `entry` = 13776;
-- OLD name : Voggah Agarre Letal
-- Source : https://www.wowhead.com/wotlk/es/npc=13817
UPDATE `creature_template_locale` SET `Name` = 'Voggah Presaletal' WHERE `locale` = 'esES' AND `entry` = 13817;
-- OLD name : Ushalac, el Morador de la oscuridad
-- Source : https://www.wowhead.com/wotlk/es/npc=14016
UPDATE `creature_template_locale` SET `Name` = 'Ushalac el Morador de la Oscuridad' WHERE `locale` = 'esES' AND `entry` = 14016;
-- OLD name : Guardia vil iracundo
-- Source : https://www.wowhead.com/wotlk/es/npc=14101
UPDATE `creature_template_locale` SET `Name` = 'Guarda vil iracundo' WHERE `locale` = 'esES' AND `entry` = 14101;
-- OLD name : [PH] Heraldo del cementerio (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14181
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14181;
-- OLD name : [UNUSED] Sid Stuco (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14201
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14201;
-- OLD subname : Maestra de jinetes del viento
-- Source : https://www.wowhead.com/wotlk/es/npc=14242
UPDATE `creature_template_locale` SET `Title` = 'Maestra de jinete del viento' WHERE `locale` = 'esES' AND `entry` = 14242;
-- OLD name : Cánido Lobo Gélido
-- Source : https://www.wowhead.com/wotlk/es/npc=14282
UPDATE `creature_template_locale` SET `Name` = 'Can de sangre Lobo Gélido' WHERE `locale` = 'esES' AND `entry` = 14282;
-- OLD name : Tigre de guerra negro
-- Source : https://www.wowhead.com/wotlk/es/npc=14336
UPDATE `creature_template_locale` SET `Name` = 'Sable de guerra negro' WHERE `locale` = 'esES' AND `entry` = 14336;
-- OLD name : Alto señor Demitrian (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14347
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Demitrian' WHERE `locale` = 'esES' AND `entry` = 14347;
-- OLD name : Clamatierras Franzahl
-- Source : https://www.wowhead.com/wotlk/es/npc=14348
UPDATE `creature_template_locale` SET `Name` = 'Clamor de Tierra Franzahl' WHERE `locale` = 'esES' AND `entry` = 14348;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14358
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14358;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14364
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14364;
-- OLD name : Esporas Alabeo
-- Source : https://www.wowhead.com/wotlk/es/npc=14366
UPDATE `creature_template_locale` SET `Name` = 'Esporas Combadera' WHERE `locale` = 'esES' AND `entry` = 14366;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14368
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14368;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14369
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14369;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14371
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14371;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14381
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14381;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14382
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14382;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=14383
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 14383;
-- OLD name : Draco Negro huido
-- Source : https://www.wowhead.com/wotlk/es/npc=14388
UPDATE `creature_template_locale` SET `Name` = 'Pícaro Draco Negro' WHERE `locale` = 'esES' AND `entry` = 14388;
-- OLD name : Ráfaga de maná
-- Source : https://www.wowhead.com/wotlk/es/npc=14397
UPDATE `creature_template_locale` SET `Name` = 'Chorro de maná' WHERE `locale` = 'esES' AND `entry` = 14397;
-- OLD name : Buscador Cromwell
-- Source : https://www.wowhead.com/wotlk/es/npc=14402
UPDATE `creature_template_locale` SET `Name` = 'Fustigador Cromwell' WHERE `locale` = 'esES' AND `entry` = 14402;
-- OLD name : Buscador Nahr
-- Source : https://www.wowhead.com/wotlk/es/npc=14403
UPDATE `creature_template_locale` SET `Name` = 'Fustigador Nahr' WHERE `locale` = 'esES' AND `entry` = 14403;
-- OLD name : Buscadora Thompson
-- Source : https://www.wowhead.com/wotlk/es/npc=14404
UPDATE `creature_template_locale` SET `Name` = 'Fustigadora Thompson' WHERE `locale` = 'esES' AND `entry` = 14404;
-- OLD name : Lodonante
-- Source : https://www.wowhead.com/wotlk/es/npc=14424
UPDATE `creature_template_locale` SET `Name` = 'Lodalow' WHERE `locale` = 'esES' AND `entry` = 14424;
-- OLD name : Roehuesos
-- Source : https://www.wowhead.com/wotlk/es/npc=14425
UPDATE `creature_template_locale` SET `Name` = 'Osañicol' WHERE `locale` = 'esES' AND `entry` = 14425;
-- OLD name : Acechador nocturno
-- Source : https://www.wowhead.com/wotlk/es/npc=14430
UPDATE `creature_template_locale` SET `Name` = 'Acechapolvo' WHERE `locale` = 'esES' AND `entry` = 14430;
-- OLD name : Príncipe Truenoraan
-- Source : https://www.wowhead.com/wotlk/es/npc=14435
UPDATE `creature_template_locale` SET `Name` = 'Príncipe Thunderaan' WHERE `locale` = 'esES' AND `entry` = 14435;
-- OLD name : Capitán Wyrmak
-- Source : https://www.wowhead.com/wotlk/es/npc=14445
UPDATE `creature_template_locale` SET `Name` = 'Lord Capitán Wyrmak' WHERE `locale` = 'esES' AND `entry` = 14445;
-- OLD name : Campesino malherido
-- Source : https://www.wowhead.com/wotlk/es/npc=14484
UPDATE `creature_template_locale` SET `Name` = 'Campesino herido' WHERE `locale` = 'esES' AND `entry` = 14484;
-- OLD name : Sumo sacerdote Venoxis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14507
UPDATE `creature_template_locale` SET `Name` = 'Sumo Sacerdote Venoxis' WHERE `locale` = 'esES' AND `entry` = 14507;
-- OLD name : Sumo sacerdote Thekal (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14509
UPDATE `creature_template_locale` SET `Name` = 'Sumo Sacerdote Thekal' WHERE `locale` = 'esES' AND `entry` = 14509;
-- OLD name : Suma sacerdotisa Mar'li (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14510
UPDATE `creature_template_locale` SET `Name` = 'Suma Sacerdotisa Mar''li' WHERE `locale` = 'esES' AND `entry` = 14510;
-- OLD name : Espíritu ensombrecido
-- Source : https://www.wowhead.com/wotlk/es/npc=14511
UPDATE `creature_template_locale` SET `Name` = 'Espíritu sombrío' WHERE `locale` = 'esES' AND `entry` = 14511;
-- OLD name : Espíritu malicioso
-- Source : https://www.wowhead.com/wotlk/es/npc=14513
UPDATE `creature_template_locale` SET `Name` = 'Espíritu maligno' WHERE `locale` = 'esES' AND `entry` = 14513;
-- OLD name : Suma sacerdotisa Jeklik (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14517
UPDATE `creature_template_locale` SET `Name` = 'Suma Sacerdotisa Jeklik' WHERE `locale` = 'esES' AND `entry` = 14517;
-- OLD name : Mecazancudo a rayas presto
-- Source : https://www.wowhead.com/wotlk/es/npc=14554
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo rayado veloz' WHERE `locale` = 'esES' AND `entry` = 14554;
-- OLD name : Sable de la niebla presto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14555
UPDATE `creature_template_locale` SET `Name` = 'Sable de la Niebla presto' WHERE `locale` = 'esES' AND `entry` = 14555;
-- OLD name : Sable de hielo presto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14556
UPDATE `creature_template_locale` SET `Name` = 'Sable de Hielo presto' WHERE `locale` = 'esES' AND `entry` = 14556;
-- OLD name : Sable del alba presto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14557
UPDATE `creature_template_locale` SET `Name` = 'Sable del Alba presto' WHERE `locale` = 'esES' AND `entry` = 14557;
-- OLD name : Mecazancudo azul presto
-- Source : https://www.wowhead.com/wotlk/es/npc=14562
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo azul veloz' WHERE `locale` = 'esES' AND `entry` = 14562;
-- OLD name : Mecazancudo rojo presto
-- Source : https://www.wowhead.com/wotlk/es/npc=14563
UPDATE `creature_template_locale` SET `Name` = 'Mecazancudo rojo veloz' WHERE `locale` = 'esES' AND `entry` = 14563;
-- OLD name : Sable de la tempestad presto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14602
UPDATE `creature_template_locale` SET `Name` = 'Sable de la Tempestad presto' WHERE `locale` = 'esES' AND `entry` = 14602;
-- OLD name : Zancaorillas machacado
-- Source : https://www.wowhead.com/wotlk/es/npc=14603
UPDATE `creature_template_locale` SET `Name` = 'Zancacostas machacado' WHERE `locale` = 'esES' AND `entry` = 14603;
-- OLD name : Maestro de batalla de la Garganta Grito de Guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=14623
UPDATE `creature_template_locale` SET `Name` = 'Maestro de batalla de Garganta Grito de Guerra' WHERE `locale` = 'esES' AND `entry` = 14623;
-- OLD name : Herrero maestro Burninate
-- Source : https://www.wowhead.com/wotlk/es/npc=14624
UPDATE `creature_template_locale` SET `Name` = 'Maestro herrero Cremación' WHERE `locale` = 'esES' AND `entry` = 14624;
-- OLD name : Quijaforte albino
-- Source : https://www.wowhead.com/wotlk/es/npc=14633
UPDATE `creature_template_locale` SET `Name` = 'Quijaforte albina' WHERE `locale` = 'esES' AND `entry` = 14633;
-- OLD name : [PH] Taumaturgo de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14641
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14641;
-- OLD name : [PH] Taumaturgo de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14642
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14642;
-- OLD name : [PH] Heraldo de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14643;
-- OLD name : [PH] Heraldo de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14644
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14644;
-- OLD name : Heraldo de la Garganta Grito de Guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=14645
UPDATE `creature_template_locale` SET `Name` = 'Heraldo de Garganta Grito de Guerra' WHERE `locale` = 'esES' AND `entry` = 14645;
-- OLD name : Cercenador
-- Source : https://www.wowhead.com/wotlk/es/npc=14682
UPDATE `creature_template_locale` SET `Name` = 'Cercenar' WHERE `locale` = 'esES' AND `entry` = 14682;
-- OLD name : Ánima de fatalidad
-- Source : https://www.wowhead.com/wotlk/es/npc=14701
UPDATE `creature_template_locale` SET `Name` = 'Ánima maldita' WHERE `locale` = 'esES' AND `entry` = 14701;
-- OLD name : Viuda gemebunda
-- Source : https://www.wowhead.com/wotlk/es/npc=14702
UPDATE `creature_template_locale` SET `Name` = 'Viuda de los Lamentos' WHERE `locale` = 'esES' AND `entry` = 14702;
-- OLD name : Depositario osario
-- Source : https://www.wowhead.com/wotlk/es/npc=14707
UPDATE `creature_template_locale` SET `Name` = 'Pastor osario' WHERE `locale` = 'esES' AND `entry` = 14707;
-- OLD name : Guerrero putrefacto
-- Source : https://www.wowhead.com/wotlk/es/npc=14708
UPDATE `creature_template_locale` SET `Name` = 'Guerrero en descomposición' WHERE `locale` = 'esES' AND `entry` = 14708;
-- OLD name : Muerto contagiado
-- Source : https://www.wowhead.com/wotlk/es/npc=14709
UPDATE `creature_template_locale` SET `Name` = 'Muerto apestado' WHERE `locale` = 'esES' AND `entry` = 14709;
-- OLD name : Volador pútrido
-- Source : https://www.wowhead.com/wotlk/es/npc=14713
UPDATE `creature_template_locale` SET `Name` = 'Volater pútrido' WHERE `locale` = 'esES' AND `entry` = 14713;
-- OLD name : [PH] Lugarteniente de torre de la Alianza (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14719
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14719;
-- OLD name : Mariscal de campo Afrasiabi
-- Source : https://www.wowhead.com/wotlk/es/npc=14721
UPDATE `creature_template_locale` SET `Name` = 'Mariscal de campo Petraponte' WHERE `locale` = 'esES' AND `entry` = 14721;
-- OLD name : Tamborilero Sañadiente
-- Source : https://www.wowhead.com/wotlk/es/npc=14734
UPDATE `creature_template_locale` SET `Name` = 'Tamborillero Sañadiente' WHERE `locale` = 'esES' AND `entry` = 14734;
-- OLD name : Jhordy Lapforge
-- Source : https://www.wowhead.com/wotlk/es/npc=14743
UPDATE `creature_template_locale` SET `Name` = 'Jhordy Mantoforja' WHERE `locale` = 'esES' AND `entry` = 14743;
-- OLD name : Carnero de batalla Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=14745
UPDATE `creature_template_locale` SET `Name` = 'Carnero de montar de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 14745;
-- OLD name : [PH] Lugarteniente de torre de la Horda (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=14746
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 14746;
-- OLD name : Confalón de batalla Pico Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=14752
UPDATE `creature_template_locale` SET `Name` = 'Confalón de batalla de Pico Tormenta' WHERE `locale` = 'esES' AND `entry` = 14752;
-- OLD name : Pequeño dragón Verde (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=14755
UPDATE `creature_template_locale` SET `Name` = 'Pequeño dragón verde' WHERE `locale` = 'esES' AND `entry` = 14755;
-- OLD name : Dragón Rojo diminuto
-- Source : https://www.wowhead.com/wotlk/es/npc=14756
UPDATE `creature_template_locale` SET `Name` = 'Pequeño dragón rojo' WHERE `locale` = 'esES' AND `entry` = 14756;
-- OLD name : Fatalidad espeluznante
-- Source : https://www.wowhead.com/wotlk/es/npc=14761
UPDATE `creature_template_locale` SET `Name` = 'Condena espeluznante' WHERE `locale` = 'esES' AND `entry` = 14761;
-- OLD name : Alguacil Sangrehielo
-- Source : https://www.wowhead.com/wotlk/es/npc=14766
UPDATE `creature_template_locale` SET `Name` = 'Alguacil Sangre Fría' WHERE `locale` = 'esES' AND `entry` = 14766;
-- OLD subname : Recuerdos y juguetes
-- Source : https://www.wowhead.com/wotlk/es/npc=14828
UPDATE `creature_template_locale` SET `Title` = 'Canje de vales de la Feria de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 14828;
-- OLD subname : Vendedora de bebidas
-- Source : https://www.wowhead.com/wotlk/es/npc=14844
UPDATE `creature_template_locale` SET `Title` = 'Vendedora de bebidas de la Feria de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 14844;
-- OLD subname : Vendedor de alimentos
-- Source : https://www.wowhead.com/wotlk/es/npc=14845
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de alimentos de la Feria de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 14845;
-- OLD subname : Premios de mascotas y monturas
-- Source : https://www.wowhead.com/wotlk/es/npc=14846
UPDATE `creature_template_locale` SET `Title` = 'Vendedora de objetos exóticos de la Feria de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 14846;
-- OLD name : Profesor Thaddeus Paleo, subname : Cartas de la Luna Negra
-- Source : https://www.wowhead.com/wotlk/es/npc=14847
UPDATE `creature_template_locale` SET `Name` = 'Profesor Tadeo Paleo',`Title` = 'Cartas y objetos exóticos de la Feria de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 14847;
-- OLD name : Administradora de sangre de Kirtonos
-- Source : https://www.wowhead.com/wotlk/es/npc=14861
UPDATE `creature_template_locale` SET `Name` = 'Administrador de sangre de Kirtonos' WHERE `locale` = 'esES' AND `entry` = 14861;
-- OLD name : Al'tabim, El que todo lo ve
-- Source : https://www.wowhead.com/wotlk/es/npc=14903
UPDATE `creature_template_locale` SET `Name` = 'Al''tabim el que todo lo ve' WHERE `locale` = 'esES' AND `entry` = 14903;
-- OLD name : Enviado de los Rapiñadores
-- Source : https://www.wowhead.com/wotlk/es/npc=14990
UPDATE `creature_template_locale` SET `Name` = 'Emisario de los Rapiñadores' WHERE `locale` = 'esES' AND `entry` = 14990;
-- OLD name : Maestra de la Muerte Duire (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15021
UPDATE `creature_template_locale` SET `Name` = 'Maestra de la muerte Duire' WHERE `locale` = 'esES' AND `entry` = 15021;
-- OLD name : Tigre Zulian presto
-- Source : https://www.wowhead.com/wotlk/es/npc=15104
UPDATE `creature_template_locale` SET `Name` = 'Tigre Zulian veloz' WHERE `locale` = 'esES' AND `entry` = 15104;
-- OLD name : Enviado Grito de Guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=15105
UPDATE `creature_template_locale` SET `Name` = 'Emisario Grito de Guerra' WHERE `locale` = 'esES' AND `entry` = 15105;
-- OLD name : Enviado Lobo Gélido
-- Source : https://www.wowhead.com/wotlk/es/npc=15106
UPDATE `creature_template_locale` SET `Name` = 'Emisario Lobo Gélido' WHERE `locale` = 'esES' AND `entry` = 15106;
-- OLD name : Tótem Lavado de cerebro
-- Source : https://www.wowhead.com/wotlk/es/npc=15112
UPDATE `creature_template_locale` SET `Name` = 'Tótem de lavado de cerebro' WHERE `locale` = 'esES' AND `entry` = 15112;
-- OLD name : Draco cromático
-- Source : https://www.wowhead.com/wotlk/es/npc=15135
UPDATE `creature_template_locale` SET `Name` = 'Montura de draco cromática' WHERE `locale` = 'esES' AND `entry` = 15135;
-- OLD name : [PH] Luis Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15167
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15167;
-- OLD name : Emisario Cenarion Pezuñanegra
-- Source : https://www.wowhead.com/wotlk/es/npc=15188
UPDATE `creature_template_locale` SET `Name` = 'Emisario Cenarion Pezuña Negra' WHERE `locale` = 'esES' AND `entry` = 15188;
-- OLD name : Lady Sylvanas Brisaveloz
-- Source : https://www.wowhead.com/wotlk/es/npc=15193
UPDATE `creature_template_locale` SET `Name` = 'La Reina alma en pena' WHERE `locale` = 'esES' AND `entry` = 15193;
-- OLD name : Clamasombras Yanka
-- Source : https://www.wowhead.com/wotlk/es/npc=15197
UPDATE `creature_template_locale` SET `Name` = 'Llamasombra Yanka' WHERE `locale` = 'esES' AND `entry` = 15197;
-- OLD name : Guardiana Crepuscular Mayna
-- Source : https://www.wowhead.com/wotlk/es/npc=15200
UPDATE `creature_template_locale` SET `Name` = 'Guardián Crepuscular Mayna' WHERE `locale` = 'esES' AND `entry` = 15200;
-- OLD name : Alto mariscal Eje Torbellino (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15204
UPDATE `creature_template_locale` SET `Name` = 'Alto Mariscal Eje Torbellino' WHERE `locale` = 'esES' AND `entry` = 15204;
-- OLD name : Señor supremo Crepuscular (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15213
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo Crepuscular' WHERE `locale` = 'esES' AND `entry` = 15213;
-- OLD name : [UNUSED] Constructor Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15226
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15226;
-- OLD name : [UNUSED] Moldador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15227
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15227;
-- OLD name : [UNUSED] Cavaguas Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15228
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15228;
-- OLD name : [UNUSED] Patrulla Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15231
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15231;
-- OLD name : [UNUSED] Erradicador Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15232
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15232;
-- OLD name : [UNUSED] Enjambrista Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15234
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15234;
-- OLD name : [UNUSED] Picaira Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15237
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15237;
-- OLD name : [UNUSED] Atracador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15238
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15238;
-- OLD name : [UNUSED] Rondador de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15239
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15239;
-- OLD name : [UNUSED] Infrargullo Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15243
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15243;
-- OLD name : [UNUSED] Asaltante de la colmena Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15244
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15244;
-- OLD name : [UNUSED] Guardavispa Vekniss (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15245
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15245;
-- OLD name : [UNUSED] Doblegador de almas qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15248
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15248;
-- OLD name : [UNUSED] Asesino qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15251
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15251;
-- OLD name : [UNUSED] Campeón qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15253
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15253;
-- OLD name : [UNUSED] Capitán qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15254
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15254;
-- OLD name : [UNUSED] Oficial qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15255
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15255;
-- OLD name : [UNUSED] Comandante qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15256
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15256;
-- OLD name : [UNUSED] Guardia de Honor qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15257
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15257;
-- OLD name : [UNUSED] Pretoriano qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15258
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15258;
-- OLD name : [UNUSED] Emperador qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15259
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15259;
-- OLD name : Erradicador obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=15262
UPDATE `creature_template_locale` SET `Name` = 'Erradicador Obsidiano' WHERE `locale` = 'esES' AND `entry` = 15262;
-- OLD name : Acechacaminos Kariel
-- Source : https://www.wowhead.com/wotlk/es/npc=15285
UPDATE `creature_template_locale` SET `Name` = 'Acechacaminos Avokor' WHERE `locale` = 'esES' AND `entry` = 15285;
-- OLD subname : Señor supremo de Colmen’Regal
-- Source : https://www.wowhead.com/wotlk/es/npc=15286
UPDATE `creature_template_locale` SET `Title` = 'Señor Supremo de Colmen''Regal' WHERE `locale` = 'esES' AND `entry` = 15286;
-- OLD subname : Señor supremo de Colmen’Ashi
-- Source : https://www.wowhead.com/wotlk/es/npc=15288
UPDATE `creature_template_locale` SET `Title` = 'Señor Supremo de Colmen''Ashi' WHERE `locale` = 'esES' AND `entry` = 15288;
-- OLD subname : Señor supremo de Colmen’Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=15290
UPDATE `creature_template_locale` SET `Title` = 'Señor Supremo de Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 15290;
-- OLD name : Templario terráneo
-- Source : https://www.wowhead.com/wotlk/es/npc=15307
UPDATE `creature_template_locale` SET `Name` = 'Templario de tierra' WHERE `locale` = 'esES' AND `entry` = 15307;
-- OLD name : Depositario Anubisath
-- Source : https://www.wowhead.com/wotlk/es/npc=15311
UPDATE `creature_template_locale` SET `Name` = 'Pastor Anubisath' WHERE `locale` = 'esES' AND `entry` = 15311;
-- OLD name : Nulificador obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=15312
UPDATE `creature_template_locale` SET `Name` = 'Nulificador Obsidiano' WHERE `locale` = 'esES' AND `entry` = 15312;
-- OLD name : Mylini Luna Helada
-- Source : https://www.wowhead.com/wotlk/es/npc=15315
UPDATE `creature_template_locale` SET `Name` = 'Mylini Lunelada' WHERE `locale` = 'esES' AND `entry` = 15315;
-- OLD name : [UNUSED] Emboscador Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15322
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15322;
-- OLD name : [UNUSED] Enjambrista Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15326
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15326;
-- OLD name : Tonque de vapor de la Luna Negra
-- Source : https://www.wowhead.com/wotlk/es/npc=15328
UPDATE `creature_template_locale` SET `Name` = 'Tanquete de vapor' WHERE `locale` = 'esES' AND `entry` = 15328;
-- OLD name : [UNUSED] Explorador Colmen'Zara (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15329
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15329;
-- OLD name : [UNUSED] Cavarenas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15330
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15330;
-- OLD name : [UNUSED] Tunelador de las Dunas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15331
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15331;
-- OLD name : [UNUSED] Comecristales (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15332
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15332;
-- OLD name : [UNUSED] Moldearena (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15337
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15337;
-- OLD name : Destructor obsidiano (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15338
UPDATE `creature_template_locale` SET `Name` = 'Destructor Obsidiano' WHERE `locale` = 'esES' AND `entry` = 15338;
-- OLD name : [UNUSED] Esfinge (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15342
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15342;
-- OLD name : [UNUSED] Hija de Hecate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15345
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15345;
-- OLD name : [UNUSED] Infrargullo qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15346
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15346;
-- OLD name : [UNUSED] Avispón qiraji (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15347
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15347;
-- OLD name : Zeppelín teledirigido, subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=15349
UPDATE `creature_template_locale` SET `Name` = 'RC Blimp',`Title` = 'PH' WHERE `locale` = 'esES' AND `entry` = 15349;
-- OLD name : Tanque mortero teledirigido, subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=15364
UPDATE `creature_template_locale` SET `Name` = 'RC Mortar Tank',`Title` = 'PH' WHERE `locale` = 'esES' AND `entry` = 15364;
-- OLD name : [UNUSED] Ruinas del Gladiador qiraji nombrado 7 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15393
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15393;
-- OLD name : Infantería kaldorei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15423
UPDATE `creature_template_locale` SET `Name` = 'Infantería Kaldorei' WHERE `locale` = 'esES' AND `entry` = 15423;
-- OLD name : Tótem Elemental de Tierra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15430
UPDATE `creature_template_locale` SET `Name` = 'Tótem elemental de tierra' WHERE `locale` = 'esES' AND `entry` = 15430;
-- OLD subname : Capitán de La Brigada de Forjaz
-- Source : https://www.wowhead.com/wotlk/es/npc=15440
UPDATE `creature_template_locale` SET `Title` = 'Capitán de brigada de Forjaz' WHERE `locale` = 'esES' AND `entry` = 15440;
-- OLD name : Alférez Germaine
-- Source : https://www.wowhead.com/wotlk/es/npc=15445
UPDATE `creature_template_locale` SET `Name` = 'Sargento Mayor Germaine' WHERE `locale` = 'esES' AND `entry` = 15445;
-- OLD name : Abominación de Colmen'Zora
-- Source : https://www.wowhead.com/wotlk/es/npc=15449
UPDATE `creature_template_locale` SET `Name` = 'Abominación Colmen''Zora' WHERE `locale` = 'esES' AND `entry` = 15449;
-- OLD name : Centinela Cielargento
-- Source : https://www.wowhead.com/wotlk/es/npc=15451
UPDATE `creature_template_locale` SET `Name` = 'Centinela Cielargente' WHERE `locale` = 'esES' AND `entry` = 15451;
-- OLD name : Vigilante Sombra Lunar
-- Source : https://www.wowhead.com/wotlk/es/npc=15453
UPDATE `creature_template_locale` SET `Name` = 'Vigilante Sombraluna' WHERE `locale` = 'esES' AND `entry` = 15453;
-- OLD subname : Recolector de barras de estaño
-- Source : https://www.wowhead.com/wotlk/es/npc=15460
UPDATE `creature_template_locale` SET `Title` = 'Recolector de barras' WHERE `locale` = 'esES' AND `entry` = 15460;
-- OLD name : Capataz primera T'kelah
-- Source : https://www.wowhead.com/wotlk/es/npc=15469
UPDATE `creature_template_locale` SET `Name` = 'Sargento Jefe T''kelah' WHERE `locale` = 'esES' AND `entry` = 15469;
-- OLD name : Teniente general Andorov (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15471
UPDATE `creature_template_locale` SET `Name` = 'Teniente General Andorov' WHERE `locale` = 'esES' AND `entry` = 15471;
-- OLD name : [UNUSED] Mocohondo (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15472
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15472;
-- OLD name : Élite kaldorei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15473
UPDATE `creature_template_locale` SET `Name` = 'Élite Kaldorei' WHERE `locale` = 'esES' AND `entry` = 15473;
-- OLD name : Escórpido
-- Source : https://www.wowhead.com/wotlk/es/npc=15476
UPDATE `creature_template_locale` SET `Name` = 'Escorpión' WHERE `locale` = 'esES' AND `entry` = 15476;
-- OLD name : Herborista Pluma Digna
-- Source : https://www.wowhead.com/wotlk/es/npc=15477
UPDATE `creature_template_locale` SET `Name` = 'Herborista Plumorgullo' WHERE `locale` = 'esES' AND `entry` = 15477;
-- OLD name : Tótem Nova de Fuego
-- Source : https://www.wowhead.com/wotlk/es/npc=15483
UPDATE `creature_template_locale` SET `Name` = 'Tótem Nova de Fuego VII' WHERE `locale` = 'esES' AND `entry` = 15483;
-- OLD name :  Tótem Muro de viento IV
-- Source : https://www.wowhead.com/wotlk/es/npc=15492
UPDATE `creature_template_locale` SET `Name` = 'Tótem Muro de viento IV' WHERE `locale` = 'esES' AND `entry` = 15492;
-- OLD name : Defensor Amparo de la Noche
-- Source : https://www.wowhead.com/wotlk/es/npc=15495
UPDATE `creature_template_locale` SET `Name` = 'Defensor de Amparo de la Noche' WHERE `locale` = 'esES' AND `entry` = 15495;
-- OLD name : Desollador Jamani
-- Source : https://www.wowhead.com/wotlk/es/npc=15515
UPDATE `creature_template_locale` SET `Name` = 'Desolladora Jamani' WHERE `locale` = 'esES' AND `entry` = 15515;
-- OLD name : Sanador Largo Camino
-- Source : https://www.wowhead.com/wotlk/es/npc=15528
UPDATE `creature_template_locale` SET `Name` = 'Sanador Largocamino' WHERE `locale` = 'esES' AND `entry` = 15528;
-- OLD name : Guardia de piedra Pezuña de Barro
-- Source : https://www.wowhead.com/wotlk/es/npc=15532
UPDATE `creature_template_locale` SET `Name` = 'Pezuñarcilla Garrapetra' WHERE `locale` = 'esES' AND `entry` = 15532;
-- OLD name : Guardia de sangre Alquicrudo
-- Source : https://www.wowhead.com/wotlk/es/npc=15533
UPDATE `creature_template_locale` SET `Name` = 'Guardasangre Alquicrudo' WHERE `locale` = 'esES' AND `entry` = 15533;
-- OLD name : Jefe Garra Cortante
-- Source : https://www.wowhead.com/wotlk/es/npc=15535
UPDATE `creature_template_locale` SET `Name` = 'Jefe Garrafilo' WHERE `locale` = 'esES' AND `entry` = 15535;
-- OLD subname : Capitán de la Legión de Orgrimmar
-- Source : https://www.wowhead.com/wotlk/es/npc=15612
UPDATE `creature_template_locale` SET `Title` = 'Capitán de la Legión Orgrimmar' WHERE `locale` = 'esES' AND `entry` = 15612;
-- OLD name : Merok Zancada Larga
-- Source : https://www.wowhead.com/wotlk/es/npc=15613
UPDATE `creature_template_locale` SET `Name` = 'Merok Zancolargo' WHERE `locale` = 'esES' AND `entry` = 15613;
-- OLD name : Cazador-asesino Colmen'Regal
-- Source : https://www.wowhead.com/wotlk/es/npc=15620
UPDATE `creature_template_locale` SET `Name` = 'Matacazadores Colmen''Regal' WHERE `locale` = 'esES' AND `entry` = 15620;
-- OLD name : Linaje de Yauj
-- Source : https://www.wowhead.com/wotlk/es/npc=15621
UPDATE `creature_template_locale` SET `Name` = 'Linaje Yauj' WHERE `locale` = 'esES' AND `entry` = 15621;
-- OLD name : Corrupto Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=15625
UPDATE `creature_template_locale` SET `Name` = 'Corruptor Crepuscular' WHERE `locale` = 'esES' AND `entry` = 15625;
-- OLD name : Foco
-- Source : https://www.wowhead.com/wotlk/es/npc=15631
UPDATE `creature_template_locale` SET `Name` = 'Focoluz' WHERE `locale` = 'esES' AND `entry` = 15631;
-- OLD name : Tierno de Canción Eterna
-- Source : https://www.wowhead.com/wotlk/es/npc=15635
UPDATE `creature_template_locale` SET `Name` = 'Tierno Canción Eterna' WHERE `locale` = 'esES' AND `entry` = 15635;
-- OLD name : Guardaverdor de Canción Eterna
-- Source : https://www.wowhead.com/wotlk/es/npc=15636
UPDATE `creature_template_locale` SET `Name` = 'Jardinero Canción Eterna' WHERE `locale` = 'esES' AND `entry` = 15636;
-- OLD name : [Unused] Mana Leech (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15646
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15646;
-- OLD name : Garragil anciano
-- Source : https://www.wowhead.com/wotlk/es/npc=15652
UPDATE `creature_template_locale` SET `Name` = 'Garragil mayor' WHERE `locale` = 'esES' AND `entry` = 15652;
-- OLD name : Caníbal Carnepútrea
-- Source : https://www.wowhead.com/wotlk/es/npc=15655
UPDATE `creature_template_locale` SET `Name` = 'Caníbal de miembros putrefactos' WHERE `locale` = 'esES' AND `entry` = 15655;
-- OLD name : Merodeador Carnepútrea
-- Source : https://www.wowhead.com/wotlk/es/npc=15658
UPDATE `creature_template_locale` SET `Name` = 'Merodeador pataputrefacta' WHERE `locale` = 'esES' AND `entry` = 15658;
-- OLD name : [Unused] Auctioneer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15672
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15672;
-- OLD name : Señor de la guerra Gorchuk (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15700
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Guerra Gorchuk' WHERE `locale` = 'esES' AND `entry` = 15700;
-- OLD name : Capataz primera Taiga
-- Source : https://www.wowhead.com/wotlk/es/npc=15702
UPDATE `creature_template_locale` SET `Name` = 'Sargento Jefe Taiga' WHERE `locale` = 'esES' AND `entry` = 15702;
-- OLD name : Capataz primero Grimsford
-- Source : https://www.wowhead.com/wotlk/es/npc=15703
UPDATE `creature_template_locale` SET `Name` = 'Sargento Jefe Grimsford' WHERE `locale` = 'esES' AND `entry` = 15703;
-- OLD name : Capataz primera Kai'jin
-- Source : https://www.wowhead.com/wotlk/es/npc=15704
UPDATE `creature_template_locale` SET `Name` = 'Sargento Jefe Kai''jin' WHERE `locale` = 'esES' AND `entry` = 15704;
-- OLD name : Sargento primero Rayochirriante
-- Source : https://www.wowhead.com/wotlk/es/npc=15707
UPDATE `creature_template_locale` SET `Name` = 'Sargento maestro Rayochirriante' WHERE `locale` = 'esES' AND `entry` = 15707;
-- OLD name : Sargento primera Maclure
-- Source : https://www.wowhead.com/wotlk/es/npc=15708
UPDATE `creature_template_locale` SET `Name` = 'Sargento maestro Maclure' WHERE `locale` = 'esES' AND `entry` = 15708;
-- OLD name : Sargento primera Umbraluna
-- Source : https://www.wowhead.com/wotlk/es/npc=15709
UPDATE `creature_template_locale` SET `Name` = 'Sargento maestro Sombraluna' WHERE `locale` = 'esES' AND `entry` = 15709;
-- OLD name : Muñeco de nieve diminuto
-- Source : https://www.wowhead.com/wotlk/es/npc=15710
UPDATE `creature_template_locale` SET `Name` = 'Pequeño muñeco de nieve' WHERE `locale` = 'esES' AND `entry` = 15710;
-- OLD name : Blue Qiraji Battle Tank (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=15713
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15713;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (15713, 'esES','PNJs',NULL);
-- OLD name : General de brigada qiraji
-- Source : https://www.wowhead.com/wotlk/es/npc=15753
UPDATE `creature_template_locale` SET `Name` = 'Brigadier general qiraji' WHERE `locale` = 'esES' AND `entry` = 15753;
-- OLD name : Belisario Anubisath enorme
-- Source : https://www.wowhead.com/wotlk/es/npc=15754
UPDATE `creature_template_locale` SET `Name` = 'Belisario Anubisathenorme' WHERE `locale` = 'esES' AND `entry` = 15754;
-- OLD name : Teniente general qiraji (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15757
UPDATE `creature_template_locale` SET `Name` = 'Teniente General qiraji' WHERE `locale` = 'esES' AND `entry` = 15757;
-- OLD name : Oficial Zancada del Trueno
-- Source : https://www.wowhead.com/wotlk/es/npc=15767
UPDATE `creature_template_locale` SET `Name` = 'Oficial Tronazanco' WHERE `locale` = 'esES' AND `entry` = 15767;
-- OLD name : Cristal resonador superior
-- Source : https://www.wowhead.com/wotlk/es/npc=15770
UPDATE `creature_template_locale` SET `Name` = 'Cristal de resonancia superior' WHERE `locale` = 'esES' AND `entry` = 15770;
-- OLD name : Cristal resonador sublime
-- Source : https://www.wowhead.com/wotlk/es/npc=15771
UPDATE `creature_template_locale` SET `Name` = 'Mayor Resonating Crystal' WHERE `locale` = 'esES' AND `entry` = 15771;
-- OLD name : Príncipe navideño Tortheldrin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15774
UPDATE `creature_template_locale` SET `Name` = 'Príncipe Navideño Tortheldrin' WHERE `locale` = 'esES' AND `entry` = 15774;
-- OLD name : Emperador navideño Dagran Thaurissan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15775
UPDATE `creature_template_locale` SET `Name` = 'Emperador Navideño Dagran Thaurissan' WHERE `locale` = 'esES' AND `entry` = 15775;
-- OLD name : Juerguista invernal orco
-- Source : https://www.wowhead.com/wotlk/es/npc=15791
UPDATE `creature_template_locale` SET `Name` = 'Juerguista orco de invierno' WHERE `locale` = 'esES' AND `entry` = 15791;
-- OLD subname : CHICO QUE SUJETA EL GONG
-- Source : https://www.wowhead.com/wotlk/es/npc=15801
UPDATE `creature_template_locale` SET `Title` = 'PORTADOR DEL GONG' WHERE `locale` = 'esES' AND `entry` = 15801;
-- OLD name : Cristal resonador inferior
-- Source : https://www.wowhead.com/wotlk/es/npc=15804
UPDATE `creature_template_locale` SET `Name` = 'Cristal de resonancia inferior' WHERE `locale` = 'esES' AND `entry` = 15804;
-- OLD name : Cristal resonador menor
-- Source : https://www.wowhead.com/wotlk/es/npc=15805
UPDATE `creature_template_locale` SET `Name` = 'Cristal de resonancia menor' WHERE `locale` = 'esES' AND `entry` = 15805;
-- OLD name : General de brigada qiraji Pax-lish
-- Source : https://www.wowhead.com/wotlk/es/npc=15817
UPDATE `creature_template_locale` SET `Name` = 'Brigadier general qiraji Pax-lish' WHERE `locale` = 'esES' AND `entry` = 15817;
-- OLD name : Teniente general Nokhor (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15818
UPDATE `creature_template_locale` SET `Name` = 'Teniente General Nokhor' WHERE `locale` = 'esES' AND `entry` = 15818;
-- OLD name : Bruto del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15839
UPDATE `creature_template_locale` SET `Name` = 'Bruto Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15839;
-- OLD name : Sargento del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15840
UPDATE `creature_template_locale` SET `Name` = 'Sargento Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15840;
-- OLD name : Teniente del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15841
UPDATE `creature_template_locale` SET `Name` = 'Lugarteniente Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15841;
-- OLD name : Sacerdote del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15843
UPDATE `creature_template_locale` SET `Name` = 'Sacerdote Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15843;
-- OLD name : Restauradora del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15844
UPDATE `creature_template_locale` SET `Name` = 'Restaurador Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15844;
-- OLD name : Capitana del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15845
UPDATE `creature_template_locale` SET `Name` = 'Capitana Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15845;
-- OLD name : Arquera del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15846
UPDATE `creature_template_locale` SET `Name` = 'Arquero Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15846;
-- OLD name : Chamán del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15847
UPDATE `creature_template_locale` SET `Name` = 'Chamán Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15847;
-- OLD name : Infantería del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15848
UPDATE `creature_template_locale` SET `Name` = 'Infantería Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15848;
-- OLD name : Druida del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15849
UPDATE `creature_template_locale` SET `Name` = 'Druida Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15849;
-- OLD name : Hostigador del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15850
UPDATE `creature_template_locale` SET `Name` = 'Pendenciero Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15850;
-- OLD name : Alguacil del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15851
UPDATE `creature_template_locale` SET `Name` = 'Alguacil Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15851;
-- OLD name : Escudero élite de Orgrimmar
-- Source : https://www.wowhead.com/wotlk/es/npc=15852
UPDATE `creature_template_locale` SET `Name` = 'Escuderoélite de Orgrimmar' WHERE `locale` = 'esES' AND `entry` = 15852;
-- OLD name : Tauren primigenio
-- Source : https://www.wowhead.com/wotlk/es/npc=15856
UPDATE `creature_template_locale` SET `Name` = 'Primalista tauren' WHERE `locale` = 'esES' AND `entry` = 15856;
-- OLD name : Tirador kaldorei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15860
UPDATE `creature_template_locale` SET `Name` = 'Tirador Kaldorei' WHERE `locale` = 'esES' AND `entry` = 15860;
-- OLD name : Mayor del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15865
UPDATE `creature_template_locale` SET `Name` = 'Mayor Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15865;
-- OLD name : Alto comandante Lynore Ventostryke
-- Source : https://www.wowhead.com/wotlk/es/npc=15866
UPDATE `creature_template_locale` SET `Name` = 'Alta comandante Lynore Golpevento' WHERE `locale` = 'esES' AND `entry` = 15866;
-- OLD name : Archimago del Poder de Kalimdor
-- Source : https://www.wowhead.com/wotlk/es/npc=15867
UPDATE `creature_template_locale` SET `Name` = 'Archimago Poder de Kalimdor' WHERE `locale` = 'esES' AND `entry` = 15867;
-- OLD name : Alto señor Leoric Von Zeldig (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=15868
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Leoric Von Zeldig' WHERE `locale` = 'esES' AND `entry` = 15868;
-- OLD name : Portal de tentáculo
-- Source : https://www.wowhead.com/wotlk/es/npc=15904
UPDATE `creature_template_locale` SET `Name` = 'Portal tentáculo' WHERE `locale` = 'esES' AND `entry` = 15904;
-- OLD name : Portal de tentáculo gigante
-- Source : https://www.wowhead.com/wotlk/es/npc=15910
UPDATE `creature_template_locale` SET `Name` = 'Portal tentáculo gigante' WHERE `locale` = 'esES' AND `entry` = 15910;
-- OLD name : Aprendiza Veya
-- Source : https://www.wowhead.com/wotlk/es/npc=15946
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 15946;
-- OLD name : Guardés Wyllithen
-- Source : https://www.wowhead.com/wotlk/es/npc=15969
UPDATE `creature_template_locale` SET `Name` = 'Encargado Wyllithen' WHERE `locale` = 'esES' AND `entry` = 15969;
-- OLD name : Acechador venenoso
-- Source : https://www.wowhead.com/wotlk/es/npc=15976
UPDATE `creature_template_locale` SET `Name` = 'Acechadora venenoso' WHERE `locale` = 'esES' AND `entry` = 15976;
-- OLD name : Horror de tumbas
-- Source : https://www.wowhead.com/wotlk/es/npc=15979
UPDATE `creature_template_locale` SET `Name` = 'Horror de las tumbas' WHERE `locale` = 'esES' AND `entry` = 15979;
-- OLD name : [PH] Juerguista San Valentín, hombre (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15982
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15982;
-- OLD name : [PH] Juerguista de San Valentín, mujer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=15983
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 15983;
-- OLD name : Sapphiron
-- Source : https://www.wowhead.com/wotlk/es/npc=15989
UPDATE `creature_template_locale` SET `Name` = 'Safirón' WHERE `locale` = 'esES' AND `entry` = 15989;
-- OLD name : Orok Aterramuerte
-- Source : https://www.wowhead.com/wotlk/es/npc=16007
UPDATE `creature_template_locale` SET `Name` = 'Orok Morterror' WHERE `locale` = 'esES' AND `entry` = 16007;
-- OLD name : Allenya Umbraluna
-- Source : https://www.wowhead.com/wotlk/es/npc=16023
UPDATE `creature_template_locale` SET `Name` = 'Allenya Sombraluna' WHERE `locale` = 'esES' AND `entry` = 16023;
-- OLD subname : Casa de Shen'dralar
-- Source : https://www.wowhead.com/wotlk/es/npc=16032
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 16032;
-- OLD name : [UNUSED] Bog Beast B [PH]
-- Source : https://www.wowhead.com/wotlk/es/npc=16035
UPDATE `creature_template_locale` SET `Name` = 'Bog Beast B [PH]' WHERE `locale` = 'esES' AND `entry` = 16035;
-- OLD name : [UNUSED] Deathhound
-- Source : https://www.wowhead.com/wotlk/es/npc=16038
UPDATE `creature_template_locale` SET `Name` = 'Can de la Muerte' WHERE `locale` = 'esES' AND `entry` = 16038;
-- OLD name : Snokh Dorsalnegra
-- Source : https://www.wowhead.com/wotlk/es/npc=16051
UPDATE `creature_template_locale` SET `Name` = 'Esnoc Dorsalnegra' WHERE `locale` = 'esES' AND `entry` = 16051;
-- OLD name : Alto señor Mograine, subname : El portador de la Crematoria (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16062
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Mograine',`Title` = 'Crematoria' WHERE `locale` = 'esES' AND `entry` = 16062;
-- OLD name : Garel Piedrarroja
-- Source : https://www.wowhead.com/wotlk/es/npc=16070
UPDATE `creature_template_locale` SET `Name` = 'Garel Piedraroja' WHERE `locale` = 'esES' AND `entry` = 16070;
-- OLD name : Kwee Q. Pies Rápidos
-- Source : https://www.wowhead.com/wotlk/es/npc=16075
UPDATE `creature_template_locale` SET `Name` = 'Kwee Q. Mercachifle' WHERE `locale` = 'esES' AND `entry` = 16075;
-- OLD name : Tharl Sangrapiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=16076
UPDATE `creature_template_locale` SET `Name` = 'Tharl Sangrarroca' WHERE `locale` = 'esES' AND `entry` = 16076;
-- OLD name : [PH] Alex's Test DPS Mob (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16077
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16077;
-- OLD name : Mor Pezuña Gris
-- Source : https://www.wowhead.com/wotlk/es/npc=16080
UPDATE `creature_template_locale` SET `Name` = 'Mor Ruciapezuña' WHERE `locale` = 'esES' AND `entry` = 16080;
-- OLD name : Fenstad Argyle
-- Source : https://www.wowhead.com/wotlk/es/npc=16108
UPDATE `creature_template_locale` SET `Name` = 'Fenstad Argila' WHERE `locale` = 'esES' AND `entry` = 16108;
-- OLD name : Comandante de Cruzada Korfax
-- Source : https://www.wowhead.com/wotlk/es/npc=16112
UPDATE `creature_template_locale` SET `Name` = 'Korfax, Campeón de la Luz' WHERE `locale` = 'esES' AND `entry` = 16112;
-- OLD name : Comandante de Cruzada Eligor Albar
-- Source : https://www.wowhead.com/wotlk/es/npc=16115
UPDATE `creature_template_locale` SET `Name` = 'Comandante Eligor Albar' WHERE `locale` = 'esES' AND `entry` = 16115;
-- OLD name : [UNUSED] Guardián de la Invasión de la Plaga (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16138
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16138;
-- OLD name : [UNUSED] Necópolis de Cristal, Contrafuerte (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16140
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16140;
-- OLD name : Guerrero tocado por la oscuridad
-- Source : https://www.wowhead.com/wotlk/es/npc=16156
UPDATE `creature_template_locale` SET `Name` = 'Guerrero del toque oscuro' WHERE `locale` = 'esES' AND `entry` = 16156;
-- OLD name : Guerrero tocado por la fatalidad
-- Source : https://www.wowhead.com/wotlk/es/npc=16157
UPDATE `creature_template_locale` SET `Name` = 'Guerrero tocado por la maldición' WHERE `locale` = 'esES' AND `entry` = 16157;
-- OLD name : Fragmento necrótico dañado
-- Source : https://www.wowhead.com/wotlk/es/npc=16172
UPDATE `creature_template_locale` SET `Name` = 'Pedazo necrótico dañado' WHERE `locale` = 'esES' AND `entry` = 16172;
-- OLD name : Murciélago de las sombras superior (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16174
UPDATE `creature_template_locale` SET `Name` = 'Murciélago de las Sombras superior' WHERE `locale` = 'esES' AND `entry` = 16174;
-- OLD name : [UNUSED] Contrafuerte Arbotante (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16188
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16188;
-- OLD name : Instructora de encantamiento de expansión
-- Source : https://www.wowhead.com/wotlk/es/npc=16190
UPDATE `creature_template_locale` SET `Name` = 'Instructora de encantamientos de expansión' WHERE `locale` = 'esES' AND `entry` = 16190;
-- OLD name : Guardián de la Ciudad de Lunargenta
-- Source : https://www.wowhead.com/wotlk/es/npc=16222
UPDATE `creature_template_locale` SET `Name` = 'Guardián de Lunargenta' WHERE `locale` = 'esES' AND `entry` = 16222;
-- OLD name : Infantería de El Alba Argenta herido
-- Source : https://www.wowhead.com/wotlk/es/npc=16229
UPDATE `creature_template_locale` SET `Name` = 'Infantería malherido de El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 16229;
-- OLD name : Cultor ingeniero
-- Source : https://www.wowhead.com/wotlk/es/npc=16230
UPDATE `creature_template_locale` SET `Name` = 'Fiel ingeniero' WHERE `locale` = 'esES' AND `entry` = 16230;
-- OLD name : Oruga Alapeste
-- Source : https://www.wowhead.com/wotlk/es/npc=16233
UPDATE `creature_template_locale` SET `Name` = 'Babas Alapeste' WHERE `locale` = 'esES' AND `entry` = 16233;
-- OLD name : Tentáculo de carne de peste
-- Source : https://www.wowhead.com/wotlk/es/npc=16235
UPDATE `creature_template_locale` SET `Name` = 'Tentáculo de carne de la Peste' WHERE `locale` = 'esES' AND `entry` = 16235;
-- OLD name : Kanaria
-- Source : https://www.wowhead.com/wotlk/es/npc=16272
UPDATE `creature_template_locale` SET `Name` = 'Kandaar' WHERE `locale` = 'esES' AND `entry` = 16272;
-- OLD subname : Rogue Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=16279
UPDATE `creature_template_locale` SET `Title` = 'Instructora de pícaros' WHERE `locale` = 'esES' AND `entry` = 16279;
-- OLD name : Esqueleto Terroespina
-- Source : https://www.wowhead.com/wotlk/es/npc=16303
UPDATE `creature_template_locale` SET `Name` = 'Esqueleto Huesobravo' WHERE `locale` = 'esES' AND `entry` = 16303;
-- OLD name : Centinela Terroespina
-- Source : https://www.wowhead.com/wotlk/es/npc=16305
UPDATE `creature_template_locale` SET `Name` = 'Centinela Huesobravo' WHERE `locale` = 'esES' AND `entry` = 16305;
-- OLD name : Acólito de la Ciudad de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=16315
UPDATE `creature_template_locale` SET `Name` = 'Acólito de Muerthogar' WHERE `locale` = 'esES' AND `entry` = 16315;
-- OLD name : Rastreador Alapétrea
-- Source : https://www.wowhead.com/wotlk/es/npc=16316
UPDATE `creature_template_locale` SET `Name` = 'Rastreador Ala de piedra' WHERE `locale` = 'esES' AND `entry` = 16316;
-- OLD name : Nigromante de la Ciudad de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=16317
UPDATE `creature_template_locale` SET `Name` = 'Nigromante de Muerthogar' WHERE `locale` = 'esES' AND `entry` = 16317;
-- OLD name : Plañidera
-- Source : https://www.wowhead.com/wotlk/es/npc=16321
UPDATE `creature_template_locale` SET `Name` = 'Lamentador' WHERE `locale` = 'esES' AND `entry` = 16321;
-- OLD name : Destripador Alapétrea
-- Source : https://www.wowhead.com/wotlk/es/npc=16324
UPDATE `creature_template_locale` SET `Name` = 'Destripador Ala de piedra' WHERE `locale` = 'esES' AND `entry` = 16324;
-- OLD name : Curiana polimórfica
-- Source : https://www.wowhead.com/wotlk/es/npc=16374
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha polimórfica' WHERE `locale` = 'esES' AND `entry` = 16374;
-- OLD subname : La Cruzada Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=16378
UPDATE `creature_template_locale` SET `Title` = 'El Alba Argenta' WHERE `locale` = 'esES' AND `entry` = 16378;
-- OLD name : Apoderado de la Necrópolis
-- Source : https://www.wowhead.com/wotlk/es/npc=16398
UPDATE `creature_template_locale` SET `Name` = 'Representante de la Necrópolis' WHERE `locale` = 'esES' AND `entry` = 16398;
-- OLD name : Furia Coliblanca
-- Source : https://www.wowhead.com/wotlk/es/npc=16405
UPDATE `creature_template_locale` SET `Name` = 'Furia de cola blanca' WHERE `locale` = 'esES' AND `entry` = 16405;
-- OLD name : Aparecido espectral
-- Source : https://www.wowhead.com/wotlk/es/npc=16423
UPDATE `creature_template_locale` SET `Name` = 'Aparición espectral' WHERE `locale` = 'esES' AND `entry` = 16423;
-- OLD name : Soldado de los Baldíos Helados
-- Source : https://www.wowhead.com/wotlk/es/npc=16427
UPDATE `creature_template_locale` SET `Name` = 'Soldado de los Páramos Congelados' WHERE `locale` = 'esES' AND `entry` = 16427;
-- OLD name : Guardián de élite de Entrañas
-- Source : https://www.wowhead.com/wotlk/es/npc=16432
UPDATE `creature_template_locale` SET `Name` = 'Guardia de élite de Entrañas' WHERE `locale` = 'esES' AND `entry` = 16432;
-- OLD name : Alto señor Mograine transformado, subname : El portador de la Crematoria (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16440
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Mograine transformado',`Title` = 'Crematoria' WHERE `locale` = 'esES' AND `entry` = 16440;
-- OLD name : Ella número uno
-- Source : https://www.wowhead.com/wotlk/es/npc=16450
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. número uno' WHERE `locale` = 'esES' AND `entry` = 16450;
-- OLD name : [UNUSED] Death Knight Vindicator
-- Source : https://www.wowhead.com/wotlk/es/npc=16451
UPDATE `creature_template_locale` SET `Name` = 'Vindicador Caballero de la Muerte' WHERE `locale` = 'esES' AND `entry` = 16451;
-- OLD name : Ella número dos
-- Source : https://www.wowhead.com/wotlk/es/npc=16454
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. número dos' WHERE `locale` = 'esES' AND `entry` = 16454;
-- OLD name : Ella número tres
-- Source : https://www.wowhead.com/wotlk/es/npc=16455
UPDATE `creature_template_locale` SET `Name` = 'S.H.E. número tres' WHERE `locale` = 'esES' AND `entry` = 16455;
-- OLD name : Concubina
-- Source : https://www.wowhead.com/wotlk/es/npc=16461
UPDATE `creature_template_locale` SET `Name` = 'Amante entusiasta' WHERE `locale` = 'esES' AND `entry` = 16461;
-- OLD name : Taumaturgo umbrío Sombrapino
-- Source : https://www.wowhead.com/wotlk/es/npc=16469
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro Sombrapino' WHERE `locale` = 'esES' AND `entry` = 16469;
-- OLD name : Venerador de Naxxramas
-- Source : https://www.wowhead.com/wotlk/es/npc=16506
UPDATE `creature_template_locale` SET `Name` = 'Devoto de Naxxramas' WHERE `locale` = 'esES' AND `entry` = 16506;
-- OLD name : Azotador de raíces mutado
-- Source : https://www.wowhead.com/wotlk/es/npc=16517
UPDATE `creature_template_locale` SET `Name` = 'Azotador mutado' WHERE `locale` = 'esES' AND `entry` = 16517;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=16527
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de herboristería' WHERE `locale` = 'esES' AND `entry` = 16527;
-- OLD name : Azotador de raíces inoculado
-- Source : https://www.wowhead.com/wotlk/es/npc=16533
UPDATE `creature_template_locale` SET `Name` = 'Azotador inoculada' WHERE `locale` = 'esES' AND `entry` = 16533;
-- OLD name : Bestia fúngica
-- Source : https://www.wowhead.com/wotlk/es/npc=16565
UPDATE `creature_template_locale` SET `Name` = 'Myconite Warrior (PH)' WHERE `locale` = 'esES' AND `entry` = 16565;
-- OLD name : Cazador de sombras Ty'jin
-- Source : https://www.wowhead.com/wotlk/es/npc=16575
UPDATE `creature_template_locale` SET `Name` = 'Cazador de las Sombras Ty''jin' WHERE `locale` = 'esES' AND `entry` = 16575;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=16583
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 16583;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=16588
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 16588;
-- OLD name : Fogata del Solsticio de Verano (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16592
UPDATE `creature_template_locale` SET `Name` = 'Fogata del solsticio de verano' WHERE `locale` = 'esES' AND `entry` = 16592;
-- OLD name : Bri's Test Character
-- Source : https://www.wowhead.com/wotlk/es/npc=16605
UPDATE `creature_template_locale` SET `Name` = 'Brianna Schneider' WHERE `locale` = 'esES' AND `entry` = 16605;
-- OLD name : Fogata del Solsticio de Verano Desaparición (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16606
UPDATE `creature_template_locale` SET `Name` = 'Fogata del solsticio de verano Desaparición' WHERE `locale` = 'esES' AND `entry` = 16606;
-- OLD name : [PH] Goblin Savage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16608;
-- OLD subname : Maestra de Armas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16621
UPDATE `creature_template_locale` SET `Title` = 'Maestra de armas' WHERE `locale` = 'esES' AND `entry` = 16621;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=16676
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esES' AND `entry` = 16676;
-- OLD name : Espíritu de verano
-- Source : https://www.wowhead.com/wotlk/es/npc=16701
UPDATE `creature_template_locale` SET `Name` = 'Espíritu del Verano' WHERE `locale` = 'esES' AND `entry` = 16701;
-- OLD name : Vendedora de ropa de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=16717
UPDATE `creature_template_locale` SET `Name` = 'Vendedora de ropa de Exodar' WHERE `locale` = 'esES' AND `entry` = 16717;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=16719
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esES' AND `entry` = 16719;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=16720
UPDATE `creature_template_locale` SET `Title` = 'Instructora de demonios' WHERE `locale` = 'esES' AND `entry` = 16720;
-- OLD name : Vendedora de fuegos artificiales de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=16730
UPDATE `creature_template_locale` SET `Name` = 'Vendedora de fuegos de artificio de Exodar' WHERE `locale` = 'esES' AND `entry` = 16730;
-- OLD subname : Aprendiza joyera
-- Source : https://www.wowhead.com/wotlk/es/npc=16744
UPDATE `creature_template_locale` SET `Title` = 'Aprendiz joyero' WHERE `locale` = 'esES' AND `entry` = 16744;
-- OLD subname : Mercader de armaduras de malla
-- Source : https://www.wowhead.com/wotlk/es/npc=16750
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armaduras' WHERE `locale` = 'esES' AND `entry` = 16750;
-- OLD subname : Mercader de armaduras de placas
-- Source : https://www.wowhead.com/wotlk/es/npc=16753
UPDATE `creature_template_locale` SET `Title` = 'Mercader de armadura de placas' WHERE `locale` = 'esES' AND `entry` = 16753;
-- OLD subname : Suministros de venenos
-- Source : https://www.wowhead.com/wotlk/es/npc=16754
UPDATE `creature_template_locale` SET `Title` = 'Suministros para venenos' WHERE `locale` = 'esES' AND `entry` = 16754;
-- OLD name : Instructor de brujos de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=16770
UPDATE `creature_template_locale` SET `Name` = 'Instructor de brujos de Exodar' WHERE `locale` = 'esES' AND `entry` = 16770;
-- OLD subname : El portador de la Crematoria
-- Source : https://www.wowhead.com/wotlk/es/npc=16775
UPDATE `creature_template_locale` SET `Title` = 'Crematoria' WHERE `locale` = 'esES' AND `entry` = 16775;
-- OLD name : Celebrador del Solsticio de Verano (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16781
UPDATE `creature_template_locale` SET `Name` = 'Celebrador del solsticio de verano' WHERE `locale` = 'esES' AND `entry` = 16781;
-- OLD name : Babosa de peste (azul)
-- Source : https://www.wowhead.com/wotlk/es/npc=16783
UPDATE `creature_template_locale` SET `Name` = 'Babosa de la Peste (azul)' WHERE `locale` = 'esES' AND `entry` = 16783;
-- OLD name : Babosa de peste (roja)
-- Source : https://www.wowhead.com/wotlk/es/npc=16784
UPDATE `creature_template_locale` SET `Name` = 'Babosa de la Peste (roja)' WHERE `locale` = 'esES' AND `entry` = 16784;
-- OLD name : Babosa de peste (verde)
-- Source : https://www.wowhead.com/wotlk/es/npc=16785
UPDATE `creature_template_locale` SET `Name` = 'Babosa de la Peste (verde)' WHERE `locale` = 'esES' AND `entry` = 16785;
-- OLD subname : Señor regente de Quel'Thalas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16802
UPDATE `creature_template_locale` SET `Title` = 'Señor Regente de Quel''Thalas' WHERE `locale` = 'esES' AND `entry` = 16802;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=16823
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 16823;
-- OLD name : Comandante de operaciones Romus
-- Source : https://www.wowhead.com/wotlk/es/npc=16830
UPDATE `creature_template_locale` SET `Name` = 'Comandante de campo Romus' WHERE `locale` = 'esES' AND `entry` = 16830;
-- OLD name : [UNUSED] Death Lord
-- Source : https://www.wowhead.com/wotlk/es/npc=16861
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Muerte' WHERE `locale` = 'esES' AND `entry` = 16861;
-- OLD name : Winsum
-- Source : https://www.wowhead.com/wotlk/es/npc=16868
UPDATE `creature_template_locale` SET `Name` = 'Depositario Riecráneos' WHERE `locale` = 'esES' AND `entry` = 16868;
-- OLD name : Jising
-- Source : https://www.wowhead.com/wotlk/es/npc=16869
UPDATE `creature_template_locale` SET `Name` = 'Neófito Riecráneos' WHERE `locale` = 'esES' AND `entry` = 16869;
-- OLD name : Brujo Foso Sangrante
-- Source : https://www.wowhead.com/wotlk/es/npc=16872
UPDATE `creature_template_locale` SET `Name` = 'Guerrero Foso Sangrante' WHERE `locale` = 'esES' AND `entry` = 16872;
-- OLD name : Taumaturgo umbrío Foso Sangrante
-- Source : https://www.wowhead.com/wotlk/es/npc=16874
UPDATE `creature_template_locale` SET `Name` = 'Taumaturgo oscuro Foso Sangrante' WHERE `locale` = 'esES' AND `entry` = 16874;
-- OLD name : [Unused] Marauding Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=16914
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 16914;
-- OLD name : Errante Zarrapucha
-- Source : https://www.wowhead.com/wotlk/es/npc=16936
UPDATE `creature_template_locale` SET `Name` = 'Merodeador Zarrapucha' WHERE `locale` = 'esES' AND `entry` = 16936;
-- OLD name : Hermana de la pena
-- Source : https://www.wowhead.com/wotlk/es/npc=16960
UPDATE `creature_template_locale` SET `Name` = 'Hermana de dolor' WHERE `locale` = 'esES' AND `entry` = 16960;
-- OLD name : Doncella de Pena UNUSED
-- Source : https://www.wowhead.com/wotlk/es/npc=16961
UPDATE `creature_template_locale` SET `Name` = 'Doncella de Pena' WHERE `locale` = 'esES' AND `entry` = 16961;
-- OLD name : Surcavientos Haal'eshi
-- Source : https://www.wowhead.com/wotlk/es/npc=16966
UPDATE `creature_template_locale` SET `Name` = 'Surcador del viento Haal''eshi' WHERE `locale` = 'esES' AND `entry` = 16966;
-- OLD name : Guardagarra Haal'eshi
-- Source : https://www.wowhead.com/wotlk/es/npc=16967
UPDATE `creature_template_locale` SET `Name` = 'Garraguarda Haal''eshi' WHERE `locale` = 'esES' AND `entry` = 16967;
-- OLD name : Mago osario Warlor
-- Source : https://www.wowhead.com/wotlk/es/npc=16969
UPDATE `creature_template_locale` SET `Name` = 'Señor de la guerra mago osario' WHERE `locale` = 'esES' AND `entry` = 16969;
-- OLD name : Mercader del Solsticio de Verano (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=16979
UPDATE `creature_template_locale` SET `Name` = 'Mercader del solsticio de verano' WHERE `locale` = 'esES' AND `entry` = 16979;
-- OLD name : Guardián apestado
-- Source : https://www.wowhead.com/wotlk/es/npc=16981
UPDATE `creature_template_locale` SET `Name` = 'Guardián infestado' WHERE `locale` = 'esES' AND `entry` = 16981;
-- OLD name : Campeón apestado
-- Source : https://www.wowhead.com/wotlk/es/npc=16983
UPDATE `creature_template_locale` SET `Name` = 'Campeón infestado' WHERE `locale` = 'esES' AND `entry` = 16983;
-- OLD name : Guerrero apestado
-- Source : https://www.wowhead.com/wotlk/es/npc=16984
UPDATE `creature_template_locale` SET `Name` = 'Guerrero infestado' WHERE `locale` = 'esES' AND `entry` = 16984;
-- OLD name : Traje de mercader del Solsticio de Verano de la Horda
-- Source : https://www.wowhead.com/wotlk/es/npc=16985
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de mercader del solsticio de verano de la Horda' WHERE `locale` = 'esES' AND `entry` = 16985;
-- OLD name : Traje de mercader del Solsticio de Verano de la Alianza
-- Source : https://www.wowhead.com/wotlk/es/npc=16986
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de mercader del solsticio de verano de la Alianza' WHERE `locale` = 'esES' AND `entry` = 16986;
-- OLD name : [Unused] Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17001
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17001;
-- OLD name : Acólito del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=17024
UPDATE `creature_template_locale` SET `Name` = 'Acólito del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 17024;
-- OLD name : Buscador de la Ciudad de Lunargenta
-- Source : https://www.wowhead.com/wotlk/es/npc=17029
UPDATE `creature_template_locale` SET `Name` = 'Fustigador de Lunargenta' WHERE `locale` = 'esES' AND `entry` = 17029;
-- OLD name : Varel Piedrarroja
-- Source : https://www.wowhead.com/wotlk/es/npc=17031
UPDATE `creature_template_locale` SET `Name` = 'Varel Piedraroja' WHERE `locale` = 'esES' AND `entry` = 17031;
-- OLD name : Varl Sangrapiedra
-- Source : https://www.wowhead.com/wotlk/es/npc=17032
UPDATE `creature_template_locale` SET `Name` = 'Varl Sangrapedras' WHERE `locale` = 'esES' AND `entry` = 17032;
-- OLD name : Soplafuegos de Ventormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=17038
UPDATE `creature_template_locale` SET `Name` = 'Tragafuegos de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 17038;
-- OLD name : Soplafuegos de Forjaz
-- Source : https://www.wowhead.com/wotlk/es/npc=17048
UPDATE `creature_template_locale` SET `Name` = 'Tragafuegos de Forjaz' WHERE `locale` = 'esES' AND `entry` = 17048;
-- OLD name : Tragafuegos de Cima del Trueno
-- Source : https://www.wowhead.com/wotlk/es/npc=17050
UPDATE `creature_template_locale` SET `Name` = 'Comefuego de Cima del Trueno' WHERE `locale` = 'esES' AND `entry` = 17050;
-- OLD name : Tragafuegos de Entrañas
-- Source : https://www.wowhead.com/wotlk/es/npc=17051
UPDATE `creature_template_locale` SET `Name` = 'Comefuego de Entrañas' WHERE `locale` = 'esES' AND `entry` = 17051;
-- OLD name : Fiestero de Canción Eterna
-- Source : https://www.wowhead.com/wotlk/es/npc=17056
UPDATE `creature_template_locale` SET `Name` = 'Fiestero Canción Eterna' WHERE `locale` = 'esES' AND `entry` = 17056;
-- OLD name : Garfanegra la Indómita
-- Source : https://www.wowhead.com/wotlk/es/npc=17057
UPDATE `creature_template_locale` SET `Name` = 'Garranegra la Indómita' WHERE `locale` = 'esES' AND `entry` = 17057;
-- OLD name : Exploradora Cenarion
-- Source : https://www.wowhead.com/wotlk/es/npc=17074
UPDATE `creature_template_locale` SET `Name` = 'Explorador Cenarion' WHERE `locale` = 'esES' AND `entry` = 17074;
-- OLD subname : Mage Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=17105
UPDATE `creature_template_locale` SET `Title` = 'Instructora de magos' WHERE `locale` = 'esES' AND `entry` = 17105;
-- OLD name : Clamatierras Ryga
-- Source : https://www.wowhead.com/wotlk/es/npc=17123
UPDATE `creature_template_locale` SET `Name` = 'Clamor de Tierra Ryga' WHERE `locale` = 'esES' AND `entry` = 17123;
-- OLD name : Estruendor destrozado
-- Source : https://www.wowhead.com/wotlk/es/npc=17157
UPDATE `creature_template_locale` SET `Name` = 'Estruendor roto' WHERE `locale` = 'esES' AND `entry` = 17157;
-- OLD name : [Unused] Tunneler Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17234
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17234;
-- OLD name : Médico brujo Mai'jin (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=17235
UPDATE `creature_template_locale` SET `Name` = 'Médico Brujo Mai''jin' WHERE `locale` = 'esES' AND `entry` = 17235;
-- OLD name : [PH] Heraldo de las Tierras de la Peste (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17239
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17239;
-- OLD name : Traje de ogro morado
-- Source : https://www.wowhead.com/wotlk/es/npc=17258
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de ogro violeta' WHERE `locale` = 'esES' AND `entry` = 17258;
-- OLD name : Portal maligno
-- Source : https://www.wowhead.com/wotlk/es/npc=17265
UPDATE `creature_template_locale` SET `Name` = 'Portal endemoniado' WHERE `locale` = 'esES' AND `entry` = 17265;
-- OLD name : Ola de peste
-- Source : https://www.wowhead.com/wotlk/es/npc=17293
UPDATE `creature_template_locale` SET `Name` = 'Ola de la Peste' WHERE `locale` = 'esES' AND `entry` = 17293;
-- OLD name : Korag Crin Digna
-- Source : https://www.wowhead.com/wotlk/es/npc=17295
UPDATE `creature_template_locale` SET `Name` = 'Korag Crinorgullo' WHERE `locale` = 'esES' AND `entry` = 17295;
-- OLD name : Slim's Unkillable Test Dummy
-- Source : https://www.wowhead.com/wotlk/es/npc=17313
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy Spammer' WHERE `locale` = 'esES' AND `entry` = 17313;
-- OLD name : Lechúcico salvaje irradiado
-- Source : https://www.wowhead.com/wotlk/es/npc=17324
UPDATE `creature_template_locale` SET `Name` = 'Lechúcico salvaje radiactivo' WHERE `locale` = 'esES' AND `entry` = 17324;
-- OLD name : Clamamareas Cienonegro
-- Source : https://www.wowhead.com/wotlk/es/npc=17327
UPDATE `creature_template_locale` SET `Name` = 'Llamamareas Cienonegro' WHERE `locale` = 'esES' AND `entry` = 17327;
-- OLD name : Acechacostas Escama de Cólera
-- Source : https://www.wowhead.com/wotlk/es/npc=17331
UPDATE `creature_template_locale` SET `Name` = 'Acechador de orilla Escama de Cólera' WHERE `locale` = 'esES' AND `entry` = 17331;
-- OLD name : Vociferadora Escama de Cólera
-- Source : https://www.wowhead.com/wotlk/es/npc=17333
UPDATE `creature_template_locale` SET `Name` = 'Gritona Escama de Cólera' WHERE `locale` = 'esES' AND `entry` = 17333;
-- OLD name : Destripasaurio
-- Source : https://www.wowhead.com/wotlk/es/npc=17351
UPDATE `creature_template_locale` SET `Name` = 'Destripador saurio' WHERE `locale` = 'esES' AND `entry` = 17351;
-- OLD subname : Mano de Kil'jaeden
-- Source : https://www.wowhead.com/wotlk/es/npc=17354
UPDATE `creature_template_locale` SET `Title` = 'Mano de Kil''Jaedan' WHERE `locale` = 'esES' AND `entry` = 17354;
-- OLD name : Volantón Maderazancudo
-- Source : https://www.wowhead.com/wotlk/es/npc=17372
UPDATE `creature_template_locale` SET `Name` = 'Fugalante Maderazancudo' WHERE `locale` = 'esES' AND `entry` = 17372;
-- OLD name : [UNUSED] Shadowmoon Firestarter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17463
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17463;
-- OLD name : Monster Spar
-- Source : https://www.wowhead.com/wotlk/es/npc=17501
UPDATE `creature_template_locale` SET `Name` = 'Monstruo de entrenamiento' WHERE `locale` = 'esES' AND `entry` = 17501;
-- OLD name : Monster Spar Buddy
-- Source : https://www.wowhead.com/wotlk/es/npc=17502
UPDATE `creature_template_locale` SET `Name` = 'Compañero de monstruo de entrenamiento' WHERE `locale` = 'esES' AND `entry` = 17502;
-- OLD subname : Mistress of Breadcrumbs
-- Source : https://www.wowhead.com/wotlk/es/npc=17515
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17515;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17515, 'esES',NULL,'Maestra de las Migajas');
-- OLD name : Hiladora de bruma
-- Source : https://www.wowhead.com/wotlk/es/npc=17522
UPDATE `creature_template_locale` SET `Name` = 'Brumahiladora' WHERE `locale` = 'esES' AND `entry` = 17522;
-- OLD name : Parasitadora de bruma
-- Source : https://www.wowhead.com/wotlk/es/npc=17523
UPDATE `creature_template_locale` SET `Name` = 'Brumasanguijuela' WHERE `locale` = 'esES' AND `entry` = 17523;
-- OLD name : Prole Bruma de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=17525
UPDATE `creature_template_locale` SET `Name` = 'Prole de Bruma de Sangre' WHERE `locale` = 'esES' AND `entry` = 17525;
-- OLD name : [PH] Captain Obvious Jr. (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17597
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17597;
-- OLD subname : Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/es/npc=17598
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de munición' WHERE `locale` = 'esES' AND `entry` = 17598;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=17634
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 17634;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=17637
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 17637;
-- OLD name : Asediador cuernohediondo
-- Source : https://www.wowhead.com/wotlk/es/npc=17673
UPDATE `creature_template_locale` SET `Name` = 'Golpeador cuernohediondo' WHERE `locale` = 'esES' AND `entry` = 17673;
-- OLD name : Criatura enredada
-- Source : https://www.wowhead.com/wotlk/es/npc=17680
UPDATE `creature_template_locale` SET `Name` = 'Criatura tejida' WHERE `locale` = 'esES' AND `entry` = 17680;
-- OLD name : Jinete de dracoleones de Orgrimmar
-- Source : https://www.wowhead.com/wotlk/es/npc=17720
UPDATE `creature_template_locale` SET `Name` = 'Jinete de grifos de Orgrimmar' WHERE `locale` = 'esES' AND `entry` = 17720;
-- OLD name : [UNUSED] Lykul Larva (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=17733
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17733;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (17733, 'esES','PNJs',NULL);
-- OLD name : Centinela de silitista de la Alianza
-- Source : https://www.wowhead.com/wotlk/es/npc=17765
UPDATE `creature_template_locale` SET `Name` = 'Centinela silitista de la Alianza' WHERE `locale` = 'esES' AND `entry` = 17765;
-- OLD name : Centinela de silitista de la Horda
-- Source : https://www.wowhead.com/wotlk/es/npc=17766
UPDATE `creature_template_locale` SET `Name` = 'Centinela silitista de la Horda' WHERE `locale` = 'esES' AND `entry` = 17766;
-- OLD name : Campeón Rasgaluz
-- Source : https://www.wowhead.com/wotlk/es/npc=17810
UPDATE `creature_template_locale` SET `Name` = 'Campeón Pautaluz' WHERE `locale` = 'esES' AND `entry` = 17810;
-- OLD name : [UNUSED] Lost Goblin [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17813
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17813;
-- OLD name : [UNUSED] Huargen enloquecido
-- Source : https://www.wowhead.com/wotlk/es/npc=17823
UPDATE `creature_template_locale` SET `Name` = 'Ferocanis enloquecido' WHERE `locale` = 'esES' AND `entry` = 17823;
-- OLD name : Teniente Drake
-- Source : https://www.wowhead.com/wotlk/es/npc=17848
UPDATE `creature_template_locale` SET `Name` = 'Teniente Draco' WHERE `locale` = 'esES' AND `entry` = 17848;
-- OLD name : Arrastrapiés de la Sotiénaga
-- Source : https://www.wowhead.com/wotlk/es/npc=17871
UPDATE `creature_template_locale` SET `Name` = 'Arrastrado de la Sotiénaga' WHERE `locale` = 'esES' AND `entry` = 17871;
-- OLD subname : Criado de supervisor Sangreoscura (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=17873
UPDATE `creature_template_locale` SET `Title` = 'criado de supervisor Sangreoscura' WHERE `locale` = 'esES' AND `entry` = 17873;
-- OLD name : Vinculador terrestre Rayge (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=17885
UPDATE `creature_template_locale` SET `Name` = 'Vinculador Terrestre Rayge' WHERE `locale` = 'esES' AND `entry` = 17885;
-- OLD name : [DND]Sunhawk Portal Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17886
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17886;
-- OLD name : [UNUSED] Coilfang Watcher [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=17939
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 17939;
-- OLD name : Objetivo de portal abierto
-- Source : https://www.wowhead.com/wotlk/es/npc=17965
UPDATE `creature_template_locale` SET `Name` = 'Dark Portal Target UNUSED' WHERE `locale` = 'esES' AND `entry` = 17965;
-- OLD name : Espíritu de victoria
-- Source : https://www.wowhead.com/wotlk/es/npc=18039
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de la victoria' WHERE `locale` = 'esES' AND `entry` = 18039;
-- OLD name : Ligaesclavos de Umbropantano
-- Source : https://www.wowhead.com/wotlk/es/npc=18042
UPDATE `creature_template_locale` SET `Name` = 'Ligador de esclavos de Umbrapantano' WHERE `locale` = 'esES' AND `entry` = 18042;
-- OLD name : Guardia vil Tormenta Abisal
-- Source : https://www.wowhead.com/wotlk/es/npc=18061
UPDATE `creature_template_locale` SET `Name` = 'Guarda vil Tormenta Abisal' WHERE `locale` = 'esES' AND `entry` = 18061;
-- OLD name : Clamavientos Pezuñanegra
-- Source : https://www.wowhead.com/wotlk/es/npc=18070
UPDATE `creature_template_locale` SET `Name` = 'Clamavientos Pezuña Negra' WHERE `locale` = 'esES' AND `entry` = 18070;
-- OLD name : Oráculo de Umbropantano
-- Source : https://www.wowhead.com/wotlk/es/npc=18077
UPDATE `creature_template_locale` SET `Name` = 'Oráculo de Umbrapantano' WHERE `locale` = 'esES' AND `entry` = 18077;
-- OLD name : Vidente de Umbropantano
-- Source : https://www.wowhead.com/wotlk/es/npc=18079
UPDATE `creature_template_locale` SET `Name` = 'Vidente de Umbrapantano' WHERE `locale` = 'esES' AND `entry` = 18079;
-- OLD name : Cazador de Época
-- Source : https://www.wowhead.com/wotlk/es/npc=18096
UPDATE `creature_template_locale` SET `Name` = 'Cazador de eras' WHERE `locale` = 'esES' AND `entry` = 18096;
-- OLD name : Señor supremo Puño Sajante (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18160
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo Puño Sajante' WHERE `locale` = 'esES' AND `entry` = 18160;
-- OLD name : Ortur de Sangreoscura
-- Source : https://www.wowhead.com/wotlk/es/npc=18204
UPDATE `creature_template_locale` SET `Name` = 'Ortor de Sangreoscura' WHERE `locale` = 'esES' AND `entry` = 18204;
-- OLD name : Furia Aletalodo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18212
UPDATE `creature_template_locale` SET `Name` = 'Furia aletalodo' WHERE `locale` = 'esES' AND `entry` = 18212;
-- OLD name : Descarnador Zarpacieno
-- Source : https://www.wowhead.com/wotlk/es/npc=18214
UPDATE `creature_template_locale` SET `Name` = 'Vándalo Zarpacieno' WHERE `locale` = 'esES' AND `entry` = 18214;
-- OLD name : Objetivo de bomba de Fuego (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18225
UPDATE `creature_template_locale` SET `Name` = 'Objetivo de bomba de fuego' WHERE `locale` = 'esES' AND `entry` = 18225;
-- OLD name : Elementalista loki
-- Source : https://www.wowhead.com/wotlk/es/npc=18233
UPDATE `creature_template_locale` SET `Name` = 'Elementalista Ioki' WHERE `locale` = 'esES' AND `entry` = 18233;
-- OLD name : Tótem de aire corrupto
-- Source : https://www.wowhead.com/wotlk/es/npc=18236
UPDATE `creature_template_locale` SET `Name` = 'Tótem Aire corrupto' WHERE `locale` = 'esES' AND `entry` = 18236;
-- OLD name : Umbra de Aran
-- Source : https://www.wowhead.com/wotlk/es/npc=18254
UPDATE `creature_template_locale` SET `Name` = 'Sombra de Aran' WHERE `locale` = 'esES' AND `entry` = 18254;
-- OLD name : Branquifilo
-- Source : https://www.wowhead.com/wotlk/es/npc=18284
UPDATE `creature_template_locale` SET `Name` = 'Branquia Afilada' WHERE `locale` = 'esES' AND `entry` = 18284;
-- OLD name : Eburnia
-- Source : https://www.wowhead.com/wotlk/es/npc=18290
UPDATE `creature_template_locale` SET `Name` = 'Colmillo' WHERE `locale` = 'esES' AND `entry` = 18290;
-- OLD name : Kristen Mejunje
-- Source : https://www.wowhead.com/wotlk/es/npc=18294
UPDATE `creature_template_locale` SET `Name` = 'Kristen Brujacaída' WHERE `locale` = 'esES' AND `entry` = 18294;
-- OLD name : Abusón Puñoinfecto
-- Source : https://www.wowhead.com/wotlk/es/npc=18297
UPDATE `creature_template_locale` SET `Name` = 'Gankly Puñoinfecto' WHERE `locale` = 'esES' AND `entry` = 18297;
-- OLD name : [UNUSED] Sethekk Magelord (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18329
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18329;
-- OLD name : Alto señor Kruul (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18338
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Kruul' WHERE `locale` = 'esES' AND `entry` = 18338;
-- OLD name : [UNUSED] Dusty Skeleton [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18355;
-- OLD name : [UNUSED] Draenei Spirit [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18367
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18367;
-- OLD name : Investigador Buscasol
-- Source : https://www.wowhead.com/wotlk/es/npc=18421
UPDATE `creature_template_locale` SET `Name` = 'Investigadora Buscasol' WHERE `locale` = 'esES' AND `entry` = 18421;
-- OLD name : Vinculador terrestre Tavgren (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18446
UPDATE `creature_template_locale` SET `Name` = 'Vinculador Terrestre Tavgren' WHERE `locale` = 'esES' AND `entry` = 18446;
-- OLD name : Guardagarra Shalassi
-- Source : https://www.wowhead.com/wotlk/es/npc=18454
UPDATE `creature_template_locale` SET `Name` = 'Garraguarda Shalassi' WHERE `locale` = 'esES' AND `entry` = 18454;
-- OLD name : Basilisco Escama Húmeda (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18461
UPDATE `creature_template_locale` SET `Name` = 'Basilisco escama húmeda' WHERE `locale` = 'esES' AND `entry` = 18461;
-- OLD name : Devorador Escama Húmeda (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18463
UPDATE `creature_template_locale` SET `Name` = 'Devorador escama húmeda' WHERE `locale` = 'esES' AND `entry` = 18463;
-- OLD name : Cenizas de Al'ar
-- Source : https://www.wowhead.com/wotlk/es/npc=18545
UPDATE `creature_template_locale` SET `Name` = 'Peep the Outland Phoenix' WHERE `locale` = 'esES' AND `entry` = 18545;
-- OLD name : Rasgador
-- Source : https://www.wowhead.com/wotlk/es/npc=18587
UPDATE `creature_template_locale` SET `Name` = 'Rasgar' WHERE `locale` = 'esES' AND `entry` = 18587;
-- OLD name : Emisor de aura de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=18599
UPDATE `creature_template_locale` SET `Name` = 'Emisor de aura de Exodar' WHERE `locale` = 'esES' AND `entry` = 18599;
-- OLD name : Cultor de la Cábala
-- Source : https://www.wowhead.com/wotlk/es/npc=18631
UPDATE `creature_template_locale` SET `Name` = 'Fiel de la Cábala' WHERE `locale` = 'esES' AND `entry` = 18631;
-- OLD name : Can guardia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=18642
UPDATE `creature_template_locale` SET `Name` = 'Can guardián vil' WHERE `locale` = 'esES' AND `entry` = 18642;
-- OLD name : [UNUSED]Anchorite Lyteera (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=18674
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge A' WHERE `locale` = 'esES' AND `entry` = 18674;
-- OLD name : Nigromante Auchenai
-- Source : https://www.wowhead.com/wotlk/es/npc=18702
UPDATE `creature_template_locale` SET `Name` = 'Nigromante de Auchenai' WHERE `locale` = 'esES' AND `entry` = 18702;
-- OLD name : Señor de fatalidad Kazzak
-- Source : https://www.wowhead.com/wotlk/es/npc=18728
UPDATE `creature_template_locale` SET `Name` = 'Señor Apocalíptico Kazzak' WHERE `locale` = 'esES' AND `entry` = 18728;
-- OLD name : Huargen
-- Source : https://www.wowhead.com/wotlk/es/npc=18742
UPDATE `creature_template_locale` SET `Name` = 'Ferocanis' WHERE `locale` = 'esES' AND `entry` = 18742;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=18747
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 18747;
-- OLD subname : Instructor de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=18748
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herboristería' WHERE `locale` = 'esES' AND `entry` = 18748;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=18749
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de sastrería' WHERE `locale` = 'esES' AND `entry` = 18749;
-- OLD name : Anguila Brilloescama (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18750
UPDATE `creature_template_locale` SET `Name` = 'Anguila brilloescama' WHERE `locale` = 'esES' AND `entry` = 18750;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=18751
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 18751;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=18752
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 18752;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=18753
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de encantamiento' WHERE `locale` = 'esES' AND `entry` = 18753;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=18754
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 18754;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=18755
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 18755;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=18771
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 18771;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=18772
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de sastrería' WHERE `locale` = 'esES' AND `entry` = 18772;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=18773
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 18773;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=18774
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de joyería' WHERE `locale` = 'esES' AND `entry` = 18774;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=18775
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 18775;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=18776
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 18776;
-- OLD subname : Instructora de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=18777
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de desuello' WHERE `locale` = 'esES' AND `entry` = 18777;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=18779
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 18779;
-- OLD subname : Camarera
-- Source : https://www.wowhead.com/wotlk/es/npc=18783
UPDATE `creature_template_locale` SET `Title` = 'Camarero' WHERE `locale` = 'esES' AND `entry` = 18783;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=18802
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 18802;
-- OLD name : Gran astromante Solarian
-- Source : https://www.wowhead.com/wotlk/es/npc=18805
UPDATE `creature_template_locale` SET `Name` = 'Gran astromántica Solarian' WHERE `locale` = 'esES' AND `entry` = 18805;
-- OLD name : Líder de prosélitos de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=18819
UPDATE `creature_template_locale` SET `Name` = 'Líder de prosélitos de Exodar' WHERE `locale` = 'esES' AND `entry` = 18819;
-- OLD name : Líder de prosélitos de El Exodar 2
-- Source : https://www.wowhead.com/wotlk/es/npc=18820
UPDATE `creature_template_locale` SET `Name` = 'Líder de prosélitos de Exodar 2' WHERE `locale` = 'esES' AND `entry` = 18820;
-- OLD name : Depositaria Fuego Infernal
-- Source : https://www.wowhead.com/wotlk/es/npc=18829
UPDATE `creature_template_locale` SET `Name` = 'Celador Fuego Infernal' WHERE `locale` = 'esES' AND `entry` = 18829;
-- OLD name : Ingeniero de distorsión
-- Source : https://www.wowhead.com/wotlk/es/npc=18852
UPDATE `creature_template_locale` SET `Name` = 'Ingeniero de distorsión Furia del Sol' WHERE `locale` = 'esES' AND `entry` = 18852;
-- OLD name : Hija del destino
-- Source : https://www.wowhead.com/wotlk/es/npc=18860
UPDATE `creature_template_locale` SET `Name` = 'Hija de Destino' WHERE `locale` = 'esES' AND `entry` = 18860;
-- OLD name : Táctico eredar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18861
UPDATE `creature_template_locale` SET `Name` = 'Táctico Eredar' WHERE `locale` = 'esES' AND `entry` = 18861;
-- OLD name : Señor supremo aterrador (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18862
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo aterrador' WHERE `locale` = 'esES' AND `entry` = 18862;
-- OLD name : Explodyne Esfuerzovano, subname : Vendedora de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=18898
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 18898;
-- OLD subname : Instructor de pesca
-- Source : https://www.wowhead.com/wotlk/es/npc=18911
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de pesca' WHERE `locale` = 'esES' AND `entry` = 18911;
-- OLD subname : Vendedor de armas
-- Source : https://www.wowhead.com/wotlk/es/npc=18926
UPDATE `creature_template_locale` SET `Title` = 'Vendedora de armas' WHERE `locale` = 'esES' AND `entry` = 18926;
-- OLD name : [PH] Gossip NPC, Human Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18935
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18935;
-- OLD name : [PH] Gossip NPC, Human Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18936
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18936;
-- OLD name : Amerun Hojasombra
-- Source : https://www.wowhead.com/wotlk/es/npc=18937
UPDATE `creature_template_locale` SET `Name` = 'Amerun Formoja' WHERE `locale` = 'esES' AND `entry` = 18937;
-- OLD name : [PH] Gossip NPC, Human, Specific Look (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=18941
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 18941;
-- OLD name : Arquera darnassiana
-- Source : https://www.wowhead.com/wotlk/es/npc=18965
UPDATE `creature_template_locale` SET `Name` = 'Arquero darnassiano' WHERE `locale` = 'esES' AND `entry` = 18965;
-- OLD name : Guardia de cólera (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=18975
UPDATE `creature_template_locale` SET `Name` = 'Guardia de Cólera' WHERE `locale` = 'esES' AND `entry` = 18975;
-- OLD name : Duende dardo vil
-- Source : https://www.wowhead.com/wotlk/es/npc=18978
UPDATE `creature_template_locale` SET `Name` = 'Duente dardo vil' WHERE `locale` = 'esES' AND `entry` = 18978;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=18990
UPDATE `creature_template_locale` SET `Title` = 'Médico militar' WHERE `locale` = 'esES' AND `entry` = 18990;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=18991
UPDATE `creature_template_locale` SET `Title` = 'Médico militar' WHERE `locale` = 'esES' AND `entry` = 18991;
-- OLD subname : Instructora de cocina y suministros
-- Source : https://www.wowhead.com/wotlk/es/npc=18993
UPDATE `creature_template_locale` SET `Title` = 'Suministros de cocina' WHERE `locale` = 'esES' AND `entry` = 18993;
-- OLD name : Vencedor Infinito
-- Source : https://www.wowhead.com/wotlk/es/npc=18995
UPDATE `creature_template_locale` SET `Name` = 'Colonizador Infinito' WHERE `locale` = 'esES' AND `entry` = 18995;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=19052
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 19052;
-- OLD name : [PH] Gossip NPC Human Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19057
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19057;
-- OLD name : [PH] Gossip NPC Human Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19058;
-- OLD name : [PH] Gossip NPC Human Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19059
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19059;
-- OLD name : [PH] Gossip NPC Human Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19060
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19060;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=19063
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 19063;
-- OLD name : Montura de elekk Telaar
-- Source : https://www.wowhead.com/wotlk/es/npc=19072
UPDATE `creature_template_locale` SET `Name` = 'Montura elekk Telaar' WHERE `locale` = 'esES' AND `entry` = 19072;
-- OLD name : [PH] Gossip NPC Dwarf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19078
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19078;
-- OLD name : [PH] Gossip NPC Dwarf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19079
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19079;
-- OLD name : [PH] Gossip NPC Night Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19080;
-- OLD name : [PH] Gossip NPC Night Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19081
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19081;
-- OLD name : [PH] Gossip NPC Draenei Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19082
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19082;
-- OLD name : [PH] Gossip NPC Draenei Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19083
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19083;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19084
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19084;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19085
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19085;
-- OLD name : [PH] Gossip NPC Orc Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19086
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19086;
-- OLD name : [PH] Gossip NPC Orc Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19087
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19087;
-- OLD name : [PH] Gossip NPC Tauren Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19088
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19088;
-- OLD name : [PH] Gossip NPC Tauren Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19089
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19089;
-- OLD name : [PH] Gossip NPC Undead Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19090
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19090;
-- OLD name : [PH] Gossip NPC Undead Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19091
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19091;
-- OLD name : [PH] Gossip NPC Dwarf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19092
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19092;
-- OLD name : [PH] Gossip NPC Night Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19093
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19093;
-- OLD name : [PH] Gossip NPC Draenei Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19094
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19094;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19095
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19095;
-- OLD name : [PH] Gossip NPC Orc Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19096
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19096;
-- OLD name : [PH] Gossip NPC Tauren Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19097
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19097;
-- OLD name : [PH] Gossip NPC Undead Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19098
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19098;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19099
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19099;
-- OLD name : [PH] Gossip NPC Draenei Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19100
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19100;
-- OLD name : [PH] Gossip NPC Dwarf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19101
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19101;
-- OLD name : [PH] Gossip NPC Night Elf Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19102
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19102;
-- OLD name : [PH] Gossip NPC Orc Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19103
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19103;
-- OLD name : [PH] Gossip NPC Tauren Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19104
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19104;
-- OLD name : [PH] Gossip NPC Undead Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19105
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19105;
-- OLD name : [PH] Gossip NPC, Blood Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19106
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19106;
-- OLD name : [PH] Gossip NPC, Draenei Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19107
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19107;
-- OLD name : [PH] Gossip NPC, Dwarf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19108
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19108;
-- OLD name : [PH] Gossip NPC, Orc Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19109
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19109;
-- OLD name : [PH] Gossip NPC, Undead Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19110
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19110;
-- OLD name : [PH] Gossip NPC, Tauren Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19111
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19111;
-- OLD name : [PH] Gossip NPC, Night Elf Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19112
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19112;
-- OLD name : [PH] Gossip NPC, Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19113
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19113;
-- OLD name : [PH] Gossip NPC, Draenei Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19114
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19114;
-- OLD name : [PH] Gossip NPC, Dwarf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19115
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19115;
-- OLD name : [PH] Gossip NPC, Night Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19116
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19116;
-- OLD name : [PH] Gossip NPC, Orc Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19117
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19117;
-- OLD name : [PH] Gossip NPC, Tauren Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19118
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19118;
-- OLD name : [PH] Gossip NPC, Undead Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19119
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19119;
-- OLD name : [PH] Gossip NPC, Gnome Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19121
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19121;
-- OLD name : [PH] Gossip NPC, Gnome Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19122
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19122;
-- OLD name : [PH] Gossip NPC, Troll Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19123
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19123;
-- OLD name : [PH] Gossip NPC, Troll Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19124
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19124;
-- OLD name : [PH] Gossip NPC Gnome Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19125
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19125;
-- OLD name : [PH] Gossip NPC Gnome Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19126
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19126;
-- OLD name : [PH] Gossip NPC Troll Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19127
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19127;
-- OLD name : [PH] Gossip NPC Troll Male, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19128
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19128;
-- OLD name : [PH] Gossip NPC Gnome Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19129
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19129;
-- OLD name : [PH] Gossip NPC Troll Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19130
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19130;
-- OLD name : [PH] Gossip NPC Gnome Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19131
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19131;
-- OLD name : [PH] Gossip NPC Troll Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19132
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19132;
-- OLD subname : Horse Pet Trainer
-- Source : https://www.wowhead.com/wotlk/es/npc=19145
UPDATE `creature_template_locale` SET `Title` = 'Instructora de caballos' WHERE `locale` = 'esES' AND `entry` = 19145;
-- OLD name : Defensor Guardia de cólera (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19160
UPDATE `creature_template_locale` SET `Name` = 'Defensor Guardia de Cólera' WHERE `locale` = 'esES' AND `entry` = 19160;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=19180
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de desuello' WHERE `locale` = 'esES' AND `entry` = 19180;
-- OLD name : Cría de uñagrieta
-- Source : https://www.wowhead.com/wotlk/es/npc=19183
UPDATE `creature_template_locale` SET `Name` = 'Cachorro de uñagrieta' WHERE `locale` = 'esES' AND `entry` = 19183;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=19184
UPDATE `creature_template_locale` SET `Title` = 'Médico' WHERE `locale` = 'esES' AND `entry` = 19184;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=19185
UPDATE `creature_template_locale` SET `Title` = 'Cocinero' WHERE `locale` = 'esES' AND `entry` = 19185;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=19187
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de peletería' WHERE `locale` = 'esES' AND `entry` = 19187;
-- OLD subname : Aprendiz del Kirin Tor
-- Source : https://www.wowhead.com/wotlk/es/npc=19217
UPDATE `creature_template_locale` SET `Title` = 'Aprendiz Kirin Tor' WHERE `locale` = 'esES' AND `entry` = 19217;
-- OLD name : Tótem de flujo de magma
-- Source : https://www.wowhead.com/wotlk/es/npc=19222
UPDATE `creature_template_locale` SET `Name` = 'Tótem de corriente de maná' WHERE `locale` = 'esES' AND `entry` = 19222;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=19252
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 19252;
-- OLD name : Guardia vil incursor
-- Source : https://www.wowhead.com/wotlk/es/npc=19284
UPDATE `creature_template_locale` SET `Name` = 'Guarda vil incursor' WHERE `locale` = 'esES' AND `entry` = 19284;
-- OLD name : Caballero del Terror
-- Source : https://www.wowhead.com/wotlk/es/npc=19288
UPDATE `creature_template_locale` SET `Name` = 'Caballero temible' WHERE `locale` = 'esES' AND `entry` = 19288;
-- OLD name : Vinculadora terrestre Galandria Brisa Nocturna (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19294
UPDATE `creature_template_locale` SET `Name` = 'Vinculadora Terrestre Galandria Brisa Nocturna' WHERE `locale` = 'esES' AND `entry` = 19294;
-- OLD name : Barnu Cragcrush, subname : Stable Master
-- Source : https://www.wowhead.com/wotlk/es/npc=19325
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19325;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (19325, 'esES','Barnu Peñazo','Maestra de establos');
-- OLD name : Antena de Legión: Olvido
-- Source : https://www.wowhead.com/wotlk/es/npc=19326
UPDATE `creature_template_locale` SET `Name` = 'Antena de Legión: Oblivion' WHERE `locale` = 'esES' AND `entry` = 19326;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=19341
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 19341;
-- OLD name : Daggle Afilador, subname : Armas de fuego
-- Source : https://www.wowhead.com/wotlk/es/npc=19351
UPDATE `creature_template_locale` SET `Name` = 'Afilador Daggle',`Title` = 'Armas de fuego y munición' WHERE `locale` = 'esES' AND `entry` = 19351;
-- OLD name : Errante del vacío
-- Source : https://www.wowhead.com/wotlk/es/npc=19356
UPDATE `creature_template_locale` SET `Name` = 'Vagabundo del vacío' WHERE `locale` = 'esES' AND `entry` = 19356;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=19369
UPDATE `creature_template_locale` SET `Title` = 'Cocinera' WHERE `locale` = 'esES' AND `entry` = 19369;
-- OLD name : Teniente guardia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=19391
UPDATE `creature_template_locale` SET `Name` = 'Teniente guarda vil' WHERE `locale` = 'esES' AND `entry` = 19391;
-- OLD name : Halcón oscuro aviario
-- Source : https://www.wowhead.com/wotlk/es/npc=19429
UPDATE `creature_template_locale` SET `Name` = 'Halcón oscuro Avian' WHERE `locale` = 'esES' AND `entry` = 19429;
-- OLD name : Pol Pezuña Nevada
-- Source : https://www.wowhead.com/wotlk/es/npc=19450
UPDATE `creature_template_locale` SET `Name` = 'Pol Pezuñablanca' WHERE `locale` = 'esES' AND `entry` = 19450;
-- OLD subname : Armas arrojadizas
-- Source : https://www.wowhead.com/wotlk/es/npc=19473
UPDATE `creature_template_locale` SET `Title` = 'Armas arrojadizas y munición' WHERE `locale` = 'esES' AND `entry` = 19473;
-- OLD subname : Familiar de Ravandwyr
-- Source : https://www.wowhead.com/wotlk/es/npc=19482
UPDATE `creature_template_locale` SET `Title` = 'Pariente de Ravandwyr' WHERE `locale` = 'esES' AND `entry` = 19482;
-- OLD name : Montura de dracohalcón
-- Source : https://www.wowhead.com/wotlk/es/npc=19487
UPDATE `creature_template_locale` SET `Name` = 'Montura dracohalcón' WHERE `locale` = 'esES' AND `entry` = 19487;
-- OLD subname : Maestro de establos
-- Source : https://www.wowhead.com/wotlk/es/npc=19491
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 19491;
-- OLD subname : Maestro de establos
-- Source : https://www.wowhead.com/wotlk/es/npc=19492
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 19492;
-- OLD name : Centinela de Sylvanaar
-- Source : https://www.wowhead.com/wotlk/es/npc=19500
UPDATE `creature_template_locale` SET `Name` = 'Avizor de Sylvanaar' WHERE `locale` = 'esES' AND `entry` = 19500;
-- OLD name : Guardia-nexo de Flecha de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=19529
UPDATE `creature_template_locale` SET `Name` = 'Guardia nexo de Flecha de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 19529;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=19539
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de joyería' WHERE `locale` = 'esES' AND `entry` = 19539;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=19540
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de encantamientos' WHERE `locale` = 'esES' AND `entry` = 19540;
-- OLD name : Comandante de operaciones Mahfuun
-- Source : https://www.wowhead.com/wotlk/es/npc=19542
UPDATE `creature_template_locale` SET `Name` = 'Comandante de campo Mahfuun' WHERE `locale` = 'esES' AND `entry` = 19542;
-- OLD name : Cenizas de A'lar
-- Source : https://www.wowhead.com/wotlk/es/npc=19551
UPDATE `creature_template_locale` SET `Name` = 'Brasa de A''lar' WHERE `locale` = 'esES' AND `entry` = 19551;
-- OLD name : Rasgador superior
-- Source : https://www.wowhead.com/wotlk/es/npc=19557
UPDATE `creature_template_locale` SET `Name` = 'Rasgar superior' WHERE `locale` = 'esES' AND `entry` = 19557;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=19576
UPDATE `creature_template_locale` SET `Title` = 'Instructor maestro de ingeniería' WHERE `locale` = 'esES' AND `entry` = 19576;
-- OLD name : Maxx Y. Millón nº. I
-- Source : https://www.wowhead.com/wotlk/es/npc=19582
UPDATE `creature_template_locale` SET `Name` = 'Maxx Y. Millón Mk. I' WHERE `locale` = 'esES' AND `entry` = 19582;
-- OLD name : Rasgador (Arcano)
-- Source : https://www.wowhead.com/wotlk/es/npc=19584
UPDATE `creature_template_locale` SET `Name` = 'Rasgar (Arcano)' WHERE `locale` = 'esES' AND `entry` = 19584;
-- OLD name : Rasgador (Fuego)
-- Source : https://www.wowhead.com/wotlk/es/npc=19585
UPDATE `creature_template_locale` SET `Name` = 'Rasgar (Fuego)' WHERE `locale` = 'esES' AND `entry` = 19585;
-- OLD name : Rasgador (Escarcha)
-- Source : https://www.wowhead.com/wotlk/es/npc=19586
UPDATE `creature_template_locale` SET `Name` = 'Rasgar (Escarcha)' WHERE `locale` = 'esES' AND `entry` = 19586;
-- OLD name : Rasgador (Sombras)
-- Source : https://www.wowhead.com/wotlk/es/npc=19587
UPDATE `creature_template_locale` SET `Name` = 'Rasgar (Sombras)' WHERE `locale` = 'esES' AND `entry` = 19587;
-- OLD name : Maxx Y. Millón nº. II
-- Source : https://www.wowhead.com/wotlk/es/npc=19588
UPDATE `creature_template_locale` SET `Name` = 'Maxx Y. Millón Mk. II' WHERE `locale` = 'esES' AND `entry` = 19588;
-- OLD name : Maxx Y. Millón nº. V
-- Source : https://www.wowhead.com/wotlk/es/npc=19589
UPDATE `creature_template_locale` SET `Name` = 'Maxx Y. Millón Mk. V' WHERE `locale` = 'esES' AND `entry` = 19589;
-- OLD name : Cazador de fase extenuado
-- Source : https://www.wowhead.com/wotlk/es/npc=19595
UPDATE `creature_template_locale` SET `Name` = 'Cazador de fase drenado' WHERE `locale` = 'esES' AND `entry` = 19595;
-- OLD name : Tauren guerrero
-- Source : https://www.wowhead.com/wotlk/es/npc=19601
UPDATE `creature_template_locale` SET `Name` = 'Guerrero tauren' WHERE `locale` = 'esES' AND `entry` = 19601;
-- OLD name : Montura de tauren
-- Source : https://www.wowhead.com/wotlk/es/npc=19602
UPDATE `creature_template_locale` SET `Name` = 'Montura tauren' WHERE `locale` = 'esES' AND `entry` = 19602;
-- OLD name : Tauren chamán
-- Source : https://www.wowhead.com/wotlk/es/npc=19603
UPDATE `creature_template_locale` SET `Name` = 'Chamán tauren' WHERE `locale` = 'esES' AND `entry` = 19603;
-- OLD name : Cría de rasgador
-- Source : https://www.wowhead.com/wotlk/es/npc=19608
UPDATE `creature_template_locale` SET `Name` = 'Cría de Rasgar' WHERE `locale` = 'esES' AND `entry` = 19608;
-- OLD name : Tótem de fuego draenei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19636
UPDATE `creature_template_locale` SET `Name` = 'Tótem de Fuego draenei' WHERE `locale` = 'esES' AND `entry` = 19636;
-- OLD name : [PH]Sunfury Caster - Sunfury Hold (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19650
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19650;
-- OLD name : Gran elekk de élite
-- Source : https://www.wowhead.com/wotlk/es/npc=19659
UPDATE `creature_template_locale` SET `Name` = 'Gran elekk' WHERE `locale` = 'esES' AND `entry` = 19659;
-- OLD name : Pacificador de la ciudad de Shattrath (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19687
UPDATE `creature_template_locale` SET `Name` = 'Pacificador de la Ciudad de Shattrath' WHERE `locale` = 'esES' AND `entry` = 19687;
-- OLD name : Trillalisco Roca de Marisma
-- Source : https://www.wowhead.com/wotlk/es/npc=19706
UPDATE `creature_template_locale` SET `Name` = 'Treshalisco Roca de Marisma' WHERE `locale` = 'esES' AND `entry` = 19706;
-- OLD name : Asolador de Mechanar
-- Source : https://www.wowhead.com/wotlk/es/npc=19713
UPDATE `creature_template_locale` SET `Name` = 'Asolador Mechanar' WHERE `locale` = 'esES' AND `entry` = 19713;
-- OLD name : Manitas de Mechanar
-- Source : https://www.wowhead.com/wotlk/es/npc=19716
UPDATE `creature_template_locale` SET `Name` = 'Manitas Mechanar' WHERE `locale` = 'esES' AND `entry` = 19716;
-- OLD name : Trillalisco Dorsacerado
-- Source : https://www.wowhead.com/wotlk/es/npc=19729
UPDATE `creature_template_locale` SET `Name` = 'Treshalisco Dorsacerado' WHERE `locale` = 'esES' AND `entry` = 19729;
-- OLD name : Despellejador de cólera (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19739
UPDATE `creature_template_locale` SET `Name` = 'Despellejador de Cólera' WHERE `locale` = 'esES' AND `entry` = 19739;
-- OLD name : Bramadora de odio
-- Source : https://www.wowhead.com/wotlk/es/npc=19741
UPDATE `creature_template_locale` SET `Name` = 'Alarido Aterrador' WHERE `locale` = 'esES' AND `entry` = 19741;
-- OLD name : Incitadora despiadado
-- Source : https://www.wowhead.com/wotlk/es/npc=19742
UPDATE `creature_template_locale` SET `Name` = 'Incitador despiadado' WHERE `locale` = 'esES' AND `entry` = 19742;
-- OLD name : Retador infernal
-- Source : https://www.wowhead.com/wotlk/es/npc=19753
UPDATE `creature_template_locale` SET `Name` = 'Vaquero infernal' WHERE `locale` = 'esES' AND `entry` = 19753;
-- OLD name : Infernal Llama Infernal
-- Source : https://www.wowhead.com/wotlk/es/npc=19761
UPDATE `creature_template_locale` SET `Name` = 'Infernal chispa vil' WHERE `locale` = 'esES' AND `entry` = 19761;
-- OLD name : Cobra Venetesta
-- Source : https://www.wowhead.com/wotlk/es/npc=19785
UPDATE `creature_template_locale` SET `Name` = 'Cobra capucha venenosa' WHERE `locale` = 'esES' AND `entry` = 19785;
-- OLD name : Alto señor Illidari (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=19797
UPDATE `creature_template_locale` SET `Name` = 'Alto Señor Illidari' WHERE `locale` = 'esES' AND `entry` = 19797;
-- OLD name : Mortificadora Illidari
-- Source : https://www.wowhead.com/wotlk/es/npc=19800
UPDATE `creature_template_locale` SET `Name` = 'Mortificador Illidari' WHERE `locale` = 'esES' AND `entry` = 19800;
-- OLD name : Destripaorcos Corazón Gris
-- Source : https://www.wowhead.com/wotlk/es/npc=19808
UPDATE `creature_template_locale` SET `Name` = 'Destripador orco Corazón Gris' WHERE `locale` = 'esES' AND `entry` = 19808;
-- OLD name : Informadora Illidari
-- Source : https://www.wowhead.com/wotlk/es/npc=19812
UPDATE `creature_template_locale` SET `Name` = 'Informador Illidari' WHERE `locale` = 'esES' AND `entry` = 19812;
-- OLD name : Mutar Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19813
UPDATE `creature_template_locale` SET `Name` = 'Mutar Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19813;
-- OLD name : Bruto Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19814
UPDATE `creature_template_locale` SET `Name` = 'Bruto Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19814;
-- OLD name : Brujo Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19815
UPDATE `creature_template_locale` SET `Name` = 'Brujo Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19815;
-- OLD name : Rabioso Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19816
UPDATE `creature_template_locale` SET `Name` = 'Rabioso Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19816;
-- OLD name : Destructor Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19817
UPDATE `creature_template_locale` SET `Name` = 'Destructor Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19817;
-- OLD name : Señor de la guerra Piel de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19818
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Guerra Pieldesangre' WHERE `locale` = 'esES' AND `entry` = 19818;
-- OLD name : [PH] Illidari Overseer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19819
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19819;
-- OLD name : [PH] Horn Ghost (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=19846
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 19846;
-- OLD subname : Mascota de Su'ura Flechapresta
-- Source : https://www.wowhead.com/wotlk/es/npc=19914
UPDATE `creature_template_locale` SET `Title` = 'Mascota de Su''ura Flechaveloz' WHERE `locale` = 'esES' AND `entry` = 19914;
-- OLD name : Azotador espinoso
-- Source : https://www.wowhead.com/wotlk/es/npc=19919
UPDATE `creature_template_locale` SET `Name` = 'Azotador espina' WHERE `locale` = 'esES' AND `entry` = 19919;
-- OLD name : Despellejador espinoso
-- Source : https://www.wowhead.com/wotlk/es/npc=19920
UPDATE `creature_template_locale` SET `Name` = 'Despellejador espina' WHERE `locale` = 'esES' AND `entry` = 19920;
-- OLD name : Imagen de la comandante Sarannis
-- Source : https://www.wowhead.com/wotlk/es/npc=19938
UPDATE `creature_template_locale` SET `Name` = 'Imagen del comandante Sarannis' WHERE `locale` = 'esES' AND `entry` = 19938;
-- OLD subname : Familiar de Ravandwyr
-- Source : https://www.wowhead.com/wotlk/es/npc=19941
UPDATE `creature_template_locale` SET `Title` = 'Pariente de Ravandwyr' WHERE `locale` = 'esES' AND `entry` = 19941;
-- OLD name : Surcavientos Lashh'an
-- Source : https://www.wowhead.com/wotlk/es/npc=19945
UPDATE `creature_template_locale` SET `Name` = 'Surcador del viento Lashh''an' WHERE `locale` = 'esES' AND `entry` = 19945;
-- OLD name : Hostigador Machacasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=19948
UPDATE `creature_template_locale` SET `Name` = 'Pendenciero Machacasangre' WHERE `locale` = 'esES' AND `entry` = 19948;
-- OLD name : Protector rasgador
-- Source : https://www.wowhead.com/wotlk/es/npc=19953
UPDATE `creature_template_locale` SET `Name` = 'Protector de Rasgar' WHERE `locale` = 'esES' AND `entry` = 19953;
-- OLD name : Pregonera de fatalidad
-- Source : https://www.wowhead.com/wotlk/es/npc=19963
UPDATE `creature_template_locale` SET `Name` = 'Fatalidad' WHERE `locale` = 'esES' AND `entry` = 19963;
-- OLD name : Constructor de la Forja Maldita
-- Source : https://www.wowhead.com/wotlk/es/npc=19965
UPDATE `creature_template_locale` SET `Name` = 'Ensamblaje de la Forja Maldita' WHERE `locale` = 'esES' AND `entry` = 19965;
-- OLD name : Avizor de terror
-- Source : https://www.wowhead.com/wotlk/es/npc=19967
UPDATE `creature_template_locale` SET `Name` = 'Avizor terror' WHERE `locale` = 'esES' AND `entry` = 19967;
-- OLD name : Herrero de vapor Forjaterrible
-- Source : https://www.wowhead.com/wotlk/es/npc=19970
UPDATE `creature_template_locale` SET `Name` = 'Herrero de vapor temible' WHERE `locale` = 'esES' AND `entry` = 19970;
-- OLD name : Sirviente Forjaterrible
-- Source : https://www.wowhead.com/wotlk/es/npc=19971
UPDATE `creature_template_locale` SET `Name` = 'Sirviente temible' WHERE `locale` = 'esES' AND `entry` = 19971;
-- OLD name : Clamallamas abismal
-- Source : https://www.wowhead.com/wotlk/es/npc=19973
UPDATE `creature_template_locale` SET `Name` = 'Clamallamas abisal' WHERE `locale` = 'esES' AND `entry` = 19973;
-- OLD name : Maquinista Forjaterrible
-- Source : https://www.wowhead.com/wotlk/es/npc=19974
UPDATE `creature_template_locale` SET `Name` = 'Maquinista temible' WHERE `locale` = 'esES' AND `entry` = 19974;
-- OLD name : Trabajador Forjaterrible
-- Source : https://www.wowhead.com/wotlk/es/npc=19975
UPDATE `creature_template_locale` SET `Name` = 'Trabajador temible' WHERE `locale` = 'esES' AND `entry` = 19975;
-- OLD name : Señor vil eredar
-- Source : https://www.wowhead.com/wotlk/es/npc=19981
UPDATE `creature_template_locale` SET `Name` = 'Lord vil Eredar' WHERE `locale` = 'esES' AND `entry` = 19981;
-- OLD name : Astromante
-- Source : https://www.wowhead.com/wotlk/es/npc=20033
UPDATE `creature_template_locale` SET `Name` = 'Astromántico' WHERE `locale` = 'esES' AND `entry` = 20033;
-- OLD name : Devastador Núcleo de Cristal
-- Source : https://www.wowhead.com/wotlk/es/npc=20040
UPDATE `creature_template_locale` SET `Name` = 'Arrasador Núcleo de Cristal' WHERE `locale` = 'esES' AND `entry` = 20040;
-- OLD name : Centinela Núcleo de Cristal
-- Source : https://www.wowhead.com/wotlk/es/npc=20041
UPDATE `creature_template_locale` SET `Name` = 'Avizor Núcleo de Cristal' WHERE `locale` = 'esES' AND `entry` = 20041;
-- OLD name : Astromante novicio
-- Source : https://www.wowhead.com/wotlk/es/npc=20044
UPDATE `creature_template_locale` SET `Name` = 'Astromántico novicio' WHERE `locale` = 'esES' AND `entry` = 20044;
-- OLD name : Señor astromante
-- Source : https://www.wowhead.com/wotlk/es/npc=20046
UPDATE `creature_template_locale` SET `Name` = 'Lord astromántico' WHERE `locale` = 'esES' AND `entry` = 20046;
-- OLD name : Gran astromante Capernian
-- Source : https://www.wowhead.com/wotlk/es/npc=20062
UPDATE `creature_template_locale` SET `Name` = 'Gran astromántica Capernian' WHERE `locale` = 'esES' AND `entry` = 20062;
-- OLD name : [PH] Gossip NPC Goblin Female, Christmas (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=20103
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 20103;
-- OLD name : [PH] Gossip NPC, Goblin Female (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=20104
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 20104;
-- OLD name : [PH] Gossip NPC Goblin Female, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=20105
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 20105;
-- OLD name : [PH] Gossip NPC Goblin Male, Lunar Festival (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=20106
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 20106;
-- OLD name : [PH] Gossip NPC, Goblin Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=20107
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 20107;
-- OLD name : Médico brujo de Umbropantano
-- Source : https://www.wowhead.com/wotlk/es/npc=20115
UPDATE `creature_template_locale` SET `Name` = 'Médico brujo de Umbrapantano' WHERE `locale` = 'esES' AND `entry` = 20115;
-- OLD name : Bruja de mar Escamas de Sangre
-- Source : https://www.wowhead.com/wotlk/es/npc=20122
UPDATE `creature_template_locale` SET `Name` = 'Bruja del mar Escamas de Sangre' WHERE `locale` = 'esES' AND `entry` = 20122;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=20124
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armas' WHERE `locale` = 'esES' AND `entry` = 20124;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=20125
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forja de armaduras' WHERE `locale` = 'esES' AND `entry` = 20125;
-- OLD name : Kaliri domado
-- Source : https://www.wowhead.com/wotlk/es/npc=20127
UPDATE `creature_template_locale` SET `Name` = 'Kaliri de doma' WHERE `locale` = 'esES' AND `entry` = 20127;
-- OLD name : Colmillo de la Marisma sanguinario
-- Source : https://www.wowhead.com/wotlk/es/npc=20196
UPDATE `creature_template_locale` SET `Name` = 'Chupasangres Colmillo de la Marisma' WHERE `locale` = 'esES' AND `entry` = 20196;
-- OLD name : Guardia de honor del embajador
-- Source : https://www.wowhead.com/wotlk/es/npc=20199
UPDATE `creature_template_locale` SET `Name` = 'Guarda de honor del embajador' WHERE `locale` = 'esES' AND `entry` = 20199;
-- OLD name : Vigilante de las llamas Furia del Sol
-- Source : https://www.wowhead.com/wotlk/es/npc=20221
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de la llama Furia del Sol' WHERE `locale` = 'esES' AND `entry` = 20221;
-- OLD name : Oficial de suministros Pestle
-- Source : https://www.wowhead.com/wotlk/es/npc=20231
UPDATE `creature_template_locale` SET `Name` = 'Oficial Avituallador Pestle' WHERE `locale` = 'esES' AND `entry` = 20231;
-- OLD name : Comandante del aire Grifongar
-- Source : https://www.wowhead.com/wotlk/es/npc=20232
UPDATE `creature_template_locale` SET `Name` = 'Comandante del aire Gryphongar' WHERE `locale` = 'esES' AND `entry` = 20232;
-- OLD name : Rashere Pezuña Digna
-- Source : https://www.wowhead.com/wotlk/es/npc=20250
UPDATE `creature_template_locale` SET `Name` = 'Rashere Pezuñasolera' WHERE `locale` = 'esES' AND `entry` = 20250;
-- OLD name : Hermana loba Maka
-- Source : https://www.wowhead.com/wotlk/es/npc=20276
UPDATE `creature_template_locale` SET `Name` = 'Hermana lobo Maka' WHERE `locale` = 'esES' AND `entry` = 20276;
-- OLD name : Azotador de raíces
-- Source : https://www.wowhead.com/wotlk/es/npc=20277
UPDATE `creature_template_locale` SET `Name` = 'Azotador' WHERE `locale` = 'esES' AND `entry` = 20277;
-- OLD subname : Armadura de arena de legado
-- Source : https://www.wowhead.com/wotlk/es/npc=20278
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de arena brutal' WHERE `locale` = 'esES' AND `entry` = 20278;
-- OLD name : Trillalisco Piedra de ira
-- Source : https://www.wowhead.com/wotlk/es/npc=20279
UPDATE `creature_template_locale` SET `Name` = 'Treshalisco Piedra de ira' WHERE `locale` = 'esES' AND `entry` = 20279;
-- OLD name : Hidra mustia
-- Source : https://www.wowhead.com/wotlk/es/npc=20324
UPDATE `creature_template_locale` SET `Name` = 'Hidra sedienta' WHERE `locale` = 'esES' AND `entry` = 20324;
-- OLD name : Huarguerrero Machacasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=20330
UPDATE `creature_template_locale` SET `Name` = 'Huargo de batalla Machacasangre' WHERE `locale` = 'esES' AND `entry` = 20330;
-- OLD name : Buscatradición Dibbs
-- Source : https://www.wowhead.com/wotlk/es/npc=20369
UPDATE `creature_template_locale` SET `Name` = 'Buscador de cultura Dibbs' WHERE `locale` = 'esES' AND `entry` = 20369;
-- OLD subname : Maestro de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20374
UPDATE `creature_template_locale` SET `Title` = 'Maestro de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20374;
-- OLD subname : Maestro de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20381
UPDATE `creature_template_locale` SET `Title` = 'Maestro de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20381;
-- OLD subname : Maestra de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20382
UPDATE `creature_template_locale` SET `Title` = 'Maestra de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20382;
-- OLD subname : Maestra de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20383
UPDATE `creature_template_locale` SET `Title` = 'Maestra de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20383;
-- OLD subname : Maestra de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20386
UPDATE `creature_template_locale` SET `Title` = 'Maestra de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20386;
-- OLD subname : Maestro de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20388
UPDATE `creature_template_locale` SET `Title` = 'Maestro de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20388;
-- OLD subname : Maestro de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=20390
UPDATE `creature_template_locale` SET `Title` = 'Maestro de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 20390;
-- OLD name : Diablillo de terror
-- Source : https://www.wowhead.com/wotlk/es/npc=20399
UPDATE `creature_template_locale` SET `Name` = 'Diablillo terror' WHERE `locale` = 'esES' AND `entry` = 20399;
-- OLD name : Consola de control de Coruu
-- Source : https://www.wowhead.com/wotlk/es/npc=20417
UPDATE `creature_template_locale` SET `Name` = 'Consola de control Coruu' WHERE `locale` = 'esES' AND `entry` = 20417;
-- OLD name : Robovigilante, versión 0
-- Source : https://www.wowhead.com/wotlk/es/npc=20420
UPDATE `creature_template_locale` SET `Name` = 'Robovigilante Mark 0' WHERE `locale` = 'esES' AND `entry` = 20420;
-- OLD name : Mago del Kirin Tor
-- Source : https://www.wowhead.com/wotlk/es/npc=20422
UPDATE `creature_template_locale` SET `Name` = 'Mago Kirin Tor' WHERE `locale` = 'esES' AND `entry` = 20422;
-- OLD name : Asesino de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20452
UPDATE `creature_template_locale` SET `Name` = 'Asesino etereum' WHERE `locale` = 'esES' AND `entry` = 20452;
-- OLD name : Soldado de choque de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20453
UPDATE `creature_template_locale` SET `Name` = 'Soldado de choque etereum' WHERE `locale` = 'esES' AND `entry` = 20453;
-- OLD name : Investigador de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20456
UPDATE `creature_template_locale` SET `Name` = 'Investigador etereum' WHERE `locale` = 'esES' AND `entry` = 20456;
-- OLD name : Perturbador de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20457
UPDATE `creature_template_locale` SET `Name` = 'Perturbador etereum' WHERE `locale` = 'esES' AND `entry` = 20457;
-- OLD name : Arconte de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20458
UPDATE `creature_template_locale` SET `Name` = 'Arconte etereum' WHERE `locale` = 'esES' AND `entry` = 20458;
-- OLD name : Señor supremo de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20459
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo etereum' WHERE `locale` = 'esES' AND `entry` = 20459;
-- OLD name : Etéreo, El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20467
UPDATE `creature_template_locale` SET `Name` = 'Etéreo, etereum' WHERE `locale` = 'esES' AND `entry` = 20467;
-- OLD name : Acechador-nexo de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20474
UPDATE `creature_template_locale` SET `Name` = 'Acechador-nexo Etereum' WHERE `locale` = 'esES' AND `entry` = 20474;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=20500
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esES' AND `entry` = 20500;
-- OLD name : Montura de grifo nevado
-- Source : https://www.wowhead.com/wotlk/es/npc=20505
UPDATE `creature_template_locale` SET `Name` = 'Grifo nevado' WHERE `locale` = 'esES' AND `entry` = 20505;
-- OLD name : Grifo verde de montar presto
-- Source : https://www.wowhead.com/wotlk/es/npc=20506
UPDATE `creature_template_locale` SET `Name` = 'Grifo verde presto' WHERE `locale` = 'esES' AND `entry` = 20506;
-- OLD name : Grifo morado de montar presto
-- Source : https://www.wowhead.com/wotlk/es/npc=20507
UPDATE `creature_template_locale` SET `Name` = 'Grifo morado presto' WHERE `locale` = 'esES' AND `entry` = 20507;
-- OLD name : Grifo rojo de montar presto
-- Source : https://www.wowhead.com/wotlk/es/npc=20508
UPDATE `creature_template_locale` SET `Name` = 'Grifo rojo presto' WHERE `locale` = 'esES' AND `entry` = 20508;
-- OLD name : Grifo azul de montar presto
-- Source : https://www.wowhead.com/wotlk/es/npc=20509
UPDATE `creature_template_locale` SET `Name` = 'Grifo azul presto' WHERE `locale` = 'esES' AND `entry` = 20509;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=20511
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 20511;
-- OLD name : Gran comandante Ruusk (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=20563
UPDATE `creature_template_locale` SET `Name` = 'Gran Comandante Ruusk' WHERE `locale` = 'esES' AND `entry` = 20563;
-- OLD name : Acechador-nexo Razaani
-- Source : https://www.wowhead.com/wotlk/es/npc=20609
UPDATE `creature_template_locale` SET `Name` = 'Acechador nexo Razaani' WHERE `locale` = 'esES' AND `entry` = 20609;
-- OLD name : Cachorro de Araga
-- Source : https://www.wowhead.com/wotlk/es/npc=20615
UPDATE `creature_template_locale` SET `Name` = 'Cachorro Fauceoscura' WHERE `locale` = 'esES' AND `entry` = 20615;
-- OLD name : Repetidor de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20619
UPDATE `creature_template_locale` SET `Name` = 'Repetidor de etereum' WHERE `locale` = 'esES' AND `entry` = 20619;
-- OLD name : Bestia de carne maligna
-- Source : https://www.wowhead.com/wotlk/es/npc=20668
UPDATE `creature_template_locale` SET `Name` = 'Bestia de carne diablillo' WHERE `locale` = 'esES' AND `entry` = 20668;
-- OLD name : Muñeco de entrenamiento de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20676
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento de Etereum' WHERE `locale` = 'esES' AND `entry` = 20676;
-- OLD name : Akoru el Clamafuegos
-- Source : https://www.wowhead.com/wotlk/es/npc=20678
UPDATE `creature_template_locale` SET `Name` = 'Akoru el Clamafuego' WHERE `locale` = 'esES' AND `entry` = 20678;
-- OLD name : Rek'tor
-- Source : https://www.wowhead.com/wotlk/es/npc=20716
UPDATE `creature_template_locale` SET `Name` = 'Raptor de Terrallende, negro' WHERE `locale` = 'esES' AND `entry` = 20716;
-- OLD name : Objetivo de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20764
UPDATE `creature_template_locale` SET `Name` = 'Objetivo de Etereum' WHERE `locale` = 'esES' AND `entry` = 20764;
-- OLD name : Roca abisal (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=20772
UPDATE `creature_template_locale` SET `Name` = 'Roca Abisal' WHERE `locale` = 'esES' AND `entry` = 20772;
-- OLD name : Soberano talbuk
-- Source : https://www.wowhead.com/wotlk/es/npc=20777
UPDATE `creature_template_locale` SET `Name` = 'Padre talbuk' WHERE `locale` = 'esES' AND `entry` = 20777;
-- OLD subname : La madre del cubil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=20786
UPDATE `creature_template_locale` SET `Title` = 'La Madre del cubil' WHERE `locale` = 'esES' AND `entry` = 20786;
-- OLD subname : El Duque de los malignos
-- Source : https://www.wowhead.com/wotlk/es/npc=20788
UPDATE `creature_template_locale` SET `Title` = 'El Duque de malignos' WHERE `locale` = 'esES' AND `entry` = 20788;
-- OLD name : Prisionero de El Etereum (Tyralius)
-- Source : https://www.wowhead.com/wotlk/es/npc=20825
UPDATE `creature_template_locale` SET `Name` = 'Prisionero de los etereum' WHERE `locale` = 'esES' AND `entry` = 20825;
-- OLD name : Gladiador de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=20854
UPDATE `creature_template_locale` SET `Name` = 'Gladiador Etereum' WHERE `locale` = 'esES' AND `entry` = 20854;
-- OLD name : Refugiado de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=20874
UPDATE `creature_template_locale` SET `Name` = 'Refugiado Skettis' WHERE `locale` = 'esES' AND `entry` = 20874;
-- OLD name : Devoralmas eredar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=20879
UPDATE `creature_template_locale` SET `Name` = 'Devoralmas Eredar' WHERE `locale` = 'esES' AND `entry` = 20879;
-- OLD name : Libramorte eredar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=20880
UPDATE `creature_template_locale` SET `Name` = 'Libramorte Eredar' WHERE `locale` = 'esES' AND `entry` = 20880;
-- OLD name : Cultor Forja Muerta
-- Source : https://www.wowhead.com/wotlk/es/npc=20884
UPDATE `creature_template_locale` SET `Name` = 'Fiel Forja Muerta' WHERE `locale` = 'esES' AND `entry` = 20884;
-- OLD name : Prisionero de El Etereum (Bola de energía de grupo)
-- Source : https://www.wowhead.com/wotlk/es/npc=20889
UPDATE `creature_template_locale` SET `Name` = 'Prisionero de los etereum' WHERE `locale` = 'esES' AND `entry` = 20889;
-- OLD name : Lanzamagma Sulfuron
-- Source : https://www.wowhead.com/wotlk/es/npc=20909
UPDATE `creature_template_locale` SET `Name` = 'Sulfuron Lanzamagma' WHERE `locale` = 'esES' AND `entry` = 20909;
-- OLD name : Zinyen Zanco Veloz
-- Source : https://www.wowhead.com/wotlk/es/npc=20917
UPDATE `creature_template_locale` SET `Name` = 'Zinyen Zancoveloz' WHERE `locale` = 'esES' AND `entry` = 20917;
-- OLD name : Pregonera del miedo
-- Source : https://www.wowhead.com/wotlk/es/npc=20930
UPDATE `creature_template_locale` SET `Name` = 'Pregonero del miedo' WHERE `locale` = 'esES' AND `entry` = 20930;
-- OLD name : Basilisco de Foresta Ruuan
-- Source : https://www.wowhead.com/wotlk/es/npc=20987
UPDATE `creature_template_locale` SET `Name` = 'Basilisco de Foresta de Ruuan' WHERE `locale` = 'esES' AND `entry` = 20987;
-- OLD name : Rasante Alaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=20999
UPDATE `creature_template_locale` SET `Name` = 'Alaescama' WHERE `locale` = 'esES' AND `entry` = 20999;
-- OLD name : QA Test Dummy 73 Raid Debuff (High Armor)
-- Source : https://www.wowhead.com/wotlk/es/npc=21003
UPDATE `creature_template_locale` SET `Name` = 'Unkillable Test Dummy 73 Raid Debuffed Warrior' WHERE `locale` = 'esES' AND `entry` = 21003;
-- OLD name : [PH] Arcane Guardian (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21031
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21031;
-- OLD name : Pimpollo de Bosque del Cuervo indignado
-- Source : https://www.wowhead.com/wotlk/es/npc=21040
UPDATE `creature_template_locale` SET `Name` = 'Pimpollo de Bosque del cuervo fuera de sí' WHERE `locale` = 'esES' AND `entry` = 21040;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=21087
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de peletería' WHERE `locale` = 'esES' AND `entry` = 21087;
-- OLD name : Michael Razak
-- Source : https://www.wowhead.com/wotlk/es/npc=21118
UPDATE `creature_template_locale` SET `Name` = 'Razak Costados de Hierro' WHERE `locale` = 'esES' AND `entry` = 21118;
-- OLD name : Sierra de fatalidad
-- Source : https://www.wowhead.com/wotlk/es/npc=21119
UPDATE `creature_template_locale` SET `Name` = 'Sierra de condena' WHERE `locale` = 'esES' AND `entry` = 21119;
-- OLD name : Vencedor Infinito
-- Source : https://www.wowhead.com/wotlk/es/npc=21139
UPDATE `creature_template_locale` SET `Name` = 'Colonizador Infinito' WHERE `locale` = 'esES' AND `entry` = 21139;
-- OLD name : Pequeña Azimi
-- Source : https://www.wowhead.com/wotlk/es/npc=21145
UPDATE `creature_template_locale` SET `Name` = 'Pequeño Azimi' WHERE `locale` = 'esES' AND `entry` = 21145;
-- OLD name : Montura de dracoleón armada de Kor'kron
-- Source : https://www.wowhead.com/wotlk/es/npc=21154
UPDATE `creature_template_locale` SET `Name` = 'Montura dracoleón armada de Kor''kron' WHERE `locale` = 'esES' AND `entry` = 21154;
-- OLD name : Capataz primera Sombra del Atardecer, subname : Reclutadora para los preparativos de guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=21155
UPDATE `creature_template_locale` SET `Name` = 'Sargento Jefe Poniente',`Title` = 'Reclutadora para la campaña de guerra' WHERE `locale` = 'esES' AND `entry` = 21155;
-- OLD name : Sargento primera Thelaana, subname : Reclutadora para los preparativos de guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=21156
UPDATE `creature_template_locale` SET `Name` = 'Maestro sargento Thelaana',`Title` = 'Reclutadora para la campaña de guerra' WHERE `locale` = 'esES' AND `entry` = 21156;
-- OLD name : Suplicante cazademonios
-- Source : https://www.wowhead.com/wotlk/es/npc=21179
UPDATE `creature_template_locale` SET `Name` = 'Suplicante cazador de demonios' WHERE `locale` = 'esES' AND `entry` = 21179;
-- OLD name : Iniciado cazademonios
-- Source : https://www.wowhead.com/wotlk/es/npc=21180
UPDATE `creature_template_locale` SET `Name` = 'Iniciado cazador de demonios' WHERE `locale` = 'esES' AND `entry` = 21180;
-- OLD name : Espíritu Garramuerte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21198
UPDATE `creature_template_locale` SET `Name` = 'Espíritu garramuerte' WHERE `locale` = 'esES' AND `entry` = 21198;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=21209
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 21209;
-- OLD name : Guardia de honor de Vashj'ir
-- Source : https://www.wowhead.com/wotlk/es/npc=21218
UPDATE `creature_template_locale` SET `Name` = 'Guardia de honor Vashj''ir' WHERE `locale` = 'esES' AND `entry` = 21218;
-- OLD name : Clamamareas Corazón Gris
-- Source : https://www.wowhead.com/wotlk/es/npc=21229
UPDATE `creature_template_locale` SET `Name` = 'Llamamareas Corazón Gris' WHERE `locale` = 'esES' AND `entry` = 21229;
-- OLD name : Punzón
-- Source : https://www.wowhead.com/wotlk/es/npc=21248
UPDATE `creature_template_locale` SET `Name` = 'Clavija' WHERE `locale` = 'esES' AND `entry` = 21248;
-- OLD name : Dragador Dullgrom
-- Source : https://www.wowhead.com/wotlk/es/npc=21254
UPDATE `creature_template_locale` SET `Name` = 'Dullgrom Dragador' WHERE `locale` = 'esES' AND `entry` = 21254;
-- OLD name : Bastón de desintegración (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21274
UPDATE `creature_template_locale` SET `Name` = 'Bastón de Desintegración' WHERE `locale` = 'esES' AND `entry` = 21274;
-- OLD name : Orador del Sino Auchenai
-- Source : https://www.wowhead.com/wotlk/es/npc=21285
UPDATE `creature_template_locale` SET `Name` = 'Decidor del destino Auchenai' WHERE `locale` = 'esES' AND `entry` = 21285;
-- OLD name : Maza de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=21286
UPDATE `creature_template_locale` SET `Name` = 'Maza de Etereum' WHERE `locale` = 'esES' AND `entry` = 21286;
-- OLD name : Asesino a sueldo Machacasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=21294
UPDATE `creature_template_locale` SET `Name` = 'Goon Machacasangre' WHERE `locale` = 'esES' AND `entry` = 21294;
-- OLD name : Bruja de las profundidades Colmillo Torcido
-- Source : https://www.wowhead.com/wotlk/es/npc=21299
UPDATE `creature_template_locale` SET `Name` = 'Bruja braza Colmillo Torcido' WHERE `locale` = 'esES' AND `entry` = 21299;
-- OLD name : Despedazador Colmillo Torcido
-- Source : https://www.wowhead.com/wotlk/es/npc=21301
UPDATE `creature_template_locale` SET `Name` = 'Macarra Colmillo Torcido' WHERE `locale` = 'esES' AND `entry` = 21301;
-- OLD name : Brujo del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=21302
UPDATE `creature_template_locale` SET `Name` = 'Brujo del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 21302;
-- OLD name : Rokgah Agarre Sangriento
-- Source : https://www.wowhead.com/wotlk/es/npc=21311
UPDATE `creature_template_locale` SET `Name` = 'Rokgah Presasangre' WHERE `locale` = 'esES' AND `entry` = 21311;
-- OLD name : Derrumbador roca abisal (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21323
UPDATE `creature_template_locale` SET `Name` = 'Derrumbador Roca Abisal' WHERE `locale` = 'esES' AND `entry` = 21323;
-- OLD name : [PH]Test Skunk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21333
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21333;
-- OLD name : Tentáculo de Markaru
-- Source : https://www.wowhead.com/wotlk/es/npc=21335
UPDATE `creature_template_locale` SET `Name` = 'Tentácuilo de Markaru' WHERE `locale` = 'esES' AND `entry` = 21335;
-- OLD name : Paria Colmillo Torcido
-- Source : https://www.wowhead.com/wotlk/es/npc=21338
UPDATE `creature_template_locale` SET `Name` = 'Leproso Colmillo Torcido' WHERE `locale` = 'esES' AND `entry` = 21338;
-- OLD name : Vociferadora de odio Colmillo Torcido
-- Source : https://www.wowhead.com/wotlk/es/npc=21339
UPDATE `creature_template_locale` SET `Name` = 'Divulgadora de miedo Colmillo Torcido' WHERE `locale` = 'esES' AND `entry` = 21339;
-- OLD name : T'chali el médico brujo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21349
UPDATE `creature_template_locale` SET `Name` = 'T''chali el Médico Brujo' WHERE `locale` = 'esES' AND `entry` = 21349;
-- OLD name : [UNUSED]Test Nether Whelp (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21378
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21378;
-- OLD name : Revientacortezas joven
-- Source : https://www.wowhead.com/wotlk/es/npc=21381
UPDATE `creature_template_locale` SET `Name` = 'Revientacorteza joven' WHERE `locale` = 'esES' AND `entry` = 21381;
-- OLD name : Zelote Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21382
UPDATE `creature_template_locale` SET `Name` = 'Zelote culto vermis' WHERE `locale` = 'esES' AND `entry` = 21382;
-- OLD name : Acólito Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21383
UPDATE `creature_template_locale` SET `Name` = 'Acólito culto vermis' WHERE `locale` = 'esES' AND `entry` = 21383;
-- OLD subname : Patriarca del Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21389
UPDATE `creature_template_locale` SET `Title` = 'Patriarca del culto vermis' WHERE `locale` = 'esES' AND `entry` = 21389;
-- OLD name : Devastador Sangradaña
-- Source : https://www.wowhead.com/wotlk/es/npc=21423
UPDATE `creature_template_locale` SET `Name` = 'Devastador Guadañagore' WHERE `locale` = 'esES' AND `entry` = 21423;
-- OLD name : [Unused] Greater Crust Burster Visual (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21457
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21457;
-- OLD name : Huevo de dragón Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21459
UPDATE `creature_template_locale` SET `Name` = 'Huevo de dragón culto vermis' WHERE `locale` = 'esES' AND `entry` = 21459;
-- OLD name : Despellejador Uñarroca (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21477
UPDATE `creature_template_locale` SET `Name` = 'Despellejador uñarroca' WHERE `locale` = 'esES' AND `entry` = 21477;
-- OLD name : Desgarrador Uñarroca (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21478
UPDATE `creature_template_locale` SET `Name` = 'Desgarrador uñarroca' WHERE `locale` = 'esES' AND `entry` = 21478;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=21483
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 21483;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=21488
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 21488;
-- OLD name : Bendito Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21492
UPDATE `creature_template_locale` SET `Name` = 'Bendito culto vermis' WHERE `locale` = 'esES' AND `entry` = 21492;
-- OLD name : [DND]Kaliri Aura Dispel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21511
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21511;
-- OLD name : Ocelo de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=21516
UPDATE `creature_template_locale` SET `Name` = 'Ojo de la Muerte' WHERE `locale` = 'esES' AND `entry` = 21516;
-- OLD name : Forest Strider
-- Source : https://www.wowhead.com/wotlk/es/npc=21634
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21634;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (21634, 'esES','Zancudo del bosque',NULL);
-- OLD name : Zancudo del bosque
-- Source : https://www.wowhead.com/wotlk/es/npc=21635
UPDATE `creature_template_locale` SET `Name` = 'Zancudo del bosque Afrazi' WHERE `locale` = 'esES' AND `entry` = 21635;
-- OLD name : Explorador Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21637
UPDATE `creature_template_locale` SET `Name` = 'Explorador culto vermis' WHERE `locale` = 'esES' AND `entry` = 21637;
-- OLD name : Guardia del aire de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21644
UPDATE `creature_template_locale` SET `Name` = 'Guardia del aire Skettis' WHERE `locale` = 'esES' AND `entry` = 21644;
-- OLD name : Surcavientos de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21649
UPDATE `creature_template_locale` SET `Name` = 'Surcador del viento Skettis' WHERE `locale` = 'esES' AND `entry` = 21649;
-- OLD name : Garroso de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21650
UPDATE `creature_template_locale` SET `Name` = 'Garroso Skettis' WHERE `locale` = 'esES' AND `entry` = 21650;
-- OLD name : Atracador de Skettis Tiempo Perdido
-- Source : https://www.wowhead.com/wotlk/es/npc=21651
UPDATE `creature_template_locale` SET `Name` = 'Atracador Skettis Tiermpo Perdido' WHERE `locale` = 'esES' AND `entry` = 21651;
-- OLD name : Controlador del tiempo de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21652
UPDATE `creature_template_locale` SET `Name` = 'Controlador del tiempo Skettis' WHERE `locale` = 'esES' AND `entry` = 21652;
-- OLD name : [UNUSED]Death's Deliverer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21658
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21658;
-- OLD name : Atracador del Tiempo Infinito (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21698
UPDATE `creature_template_locale` SET `Name` = 'Atracador del tiempo Infinito' WHERE `locale` = 'esES' AND `entry` = 21698;
-- OLD name : Tótem de fuego corrupto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21703
UPDATE `creature_template_locale` SET `Name` = 'Tótem de Fuego corrupto' WHERE `locale` = 'esES' AND `entry` = 21703;
-- OLD name : [DND]Mok'Nathal Wand 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21713
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21713;
-- OLD name : [DND]Mok'Nathal Wand 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21714
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21714;
-- OLD name : [DND]Mok'Nathal Wand 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21715
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21715;
-- OLD name : [DND]Mok'Nathal Wand 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=21716
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 21716;
-- OLD name : Retador Faucedraco
-- Source : https://www.wowhead.com/wotlk/es/npc=21717
UPDATE `creature_template_locale` SET `Name` = 'Vaquero Faucedradco' WHERE `locale` = 'esES' AND `entry` = 21717;
-- OLD name : Dientes de sable Vientonegro
-- Source : https://www.wowhead.com/wotlk/es/npc=21723
UPDATE `creature_template_locale` SET `Name` = 'Dientes de sable viento negro' WHERE `locale` = 'esES' AND `entry` = 21723;
-- OLD name : Marea de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21728
UPDATE `creature_template_locale` SET `Name` = 'Marea Skettis' WHERE `locale` = 'esES' AND `entry` = 21728;
-- OLD name : Electromental encerrado
-- Source : https://www.wowhead.com/wotlk/es/npc=21731
UPDATE `creature_template_locale` SET `Name` = 'Electromental enfundado' WHERE `locale` = 'esES' AND `entry` = 21731;
-- OLD name : Orco brujo
-- Source : https://www.wowhead.com/wotlk/es/npc=21750
UPDATE `creature_template_locale` SET `Name` = 'Brujo orco' WHERE `locale` = 'esES' AND `entry` = 21750;
-- OLD name : Torturadora Illidari
-- Source : https://www.wowhead.com/wotlk/es/npc=21762
UPDATE `creature_template_locale` SET `Name` = 'Torturador Illidari' WHERE `locale` = 'esES' AND `entry` = 21762;
-- OLD name : Venerador de Skettis Tiempo Perdido
-- Source : https://www.wowhead.com/wotlk/es/npc=21763
UPDATE `creature_template_locale` SET `Name` = 'Beato Skettis Tiempo Perdido' WHERE `locale` = 'esES' AND `entry` = 21763;
-- OLD subname : Sobrestante del Consejo de la Sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=21778
UPDATE `creature_template_locale` SET `Title` = 'Sobrestante del Consejo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 21778;
-- OLD name : Sumo sacerdote de Skettis Tiempo Perdido
-- Source : https://www.wowhead.com/wotlk/es/npc=21787
UPDATE `creature_template_locale` SET `Name` = 'Sumo sacerdote Skettis Tiempo Perdido' WHERE `locale` = 'esES' AND `entry` = 21787;
-- OLD name : Furtivo Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21809
UPDATE `creature_template_locale` SET `Name` = 'Furtivo culto vermis' WHERE `locale` = 'esES' AND `entry` = 21809;
-- OLD name : Talador Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21810
UPDATE `creature_template_locale` SET `Name` = 'Talador culto vermis' WHERE `locale` = 'esES' AND `entry` = 21810;
-- OLD name : Estirpe Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21811
UPDATE `creature_template_locale` SET `Name` = 'Estirpe culto vermis' WHERE `locale` = 'esES' AND `entry` = 21811;
-- OLD name : Maderero de la Alianza con leña
-- Source : https://www.wowhead.com/wotlk/es/npc=21829
UPDATE `creature_template_locale` SET `Name` = 'Leñador de la Alianza con leña' WHERE `locale` = 'esES' AND `entry` = 21829;
-- OLD name : Carga de seforio enorme
-- Source : https://www.wowhead.com/wotlk/es/npc=21848
UPDATE `creature_template_locale` SET `Name` = 'ZZOLD - Bone Burster Visual[PH]' WHERE `locale` = 'esES' AND `entry` = 21848;
-- OLD name : Reptahuesos
-- Source : https://www.wowhead.com/wotlk/es/npc=21849
UPDATE `creature_template_locale` SET `Name` = 'Reptador osario' WHERE `locale` = 'esES' AND `entry` = 21849;
-- OLD name : Tenazario Caparafuego
-- Source : https://www.wowhead.com/wotlk/es/npc=21864
UPDATE `creature_template_locale` SET `Name` = 'Tenazario caparazón quemado' WHERE `locale` = 'esES' AND `entry` = 21864;
-- OLD name : Elemental caminaaguas
-- Source : https://www.wowhead.com/wotlk/es/npc=21874
UPDATE `creature_template_locale` SET `Name` = 'Elemental caminaguas' WHERE `locale` = 'esES' AND `entry` = 21874;
-- OLD name : Ilusión de goblin macho
-- Source : https://www.wowhead.com/wotlk/es/npc=21885
UPDATE `creature_template_locale` SET `Name` = 'Ilusión masculina de goblin' WHERE `locale` = 'esES' AND `entry` = 21885;
-- OLD name : Ilusión de goblin hembra
-- Source : https://www.wowhead.com/wotlk/es/npc=21886
UPDATE `creature_template_locale` SET `Name` = 'Ilusión femenina de goblin' WHERE `locale` = 'esES' AND `entry` = 21886;
-- OLD name : Desgarrador aviario
-- Source : https://www.wowhead.com/wotlk/es/npc=21891
UPDATE `creature_template_locale` SET `Name` = 'Desgarrador Avian' WHERE `locale` = 'esES' AND `entry` = 21891;
-- OLD name : Halcón de guerra aviario
-- Source : https://www.wowhead.com/wotlk/es/npc=21904
UPDATE `creature_template_locale` SET `Name` = 'Halcón de guerra Avian' WHERE `locale` = 'esES' AND `entry` = 21904;
-- OLD name : Conjurador de almas de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21911
UPDATE `creature_template_locale` SET `Name` = 'Conjurador de almas Skettis' WHERE `locale` = 'esES' AND `entry` = 21911;
-- OLD name : Centinela de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21912
UPDATE `creature_template_locale` SET `Name` = 'Centinela Skettis' WHERE `locale` = 'esES' AND `entry` = 21912;
-- OLD name : Volador aviario
-- Source : https://www.wowhead.com/wotlk/es/npc=21931
UPDATE `creature_template_locale` SET `Name` = 'Volater Avian' WHERE `locale` = 'esES' AND `entry` = 21931;
-- OLD name : Aparecido detestable
-- Source : https://www.wowhead.com/wotlk/es/npc=21941
UPDATE `creature_template_locale` SET `Name` = 'Aparición detestable' WHERE `locale` = 'esES' AND `entry` = 21941;
-- OLD name : Garm Hermano Lobo
-- Source : https://www.wowhead.com/wotlk/es/npc=21950
UPDATE `creature_template_locale` SET `Name` = 'Garm Hermanolobo' WHERE `locale` = 'esES' AND `entry` = 21950;
-- OLD subname : La madre del cubil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21956
UPDATE `creature_template_locale` SET `Title` = 'La Madre del cubil' WHERE `locale` = 'esES' AND `entry` = 21956;
-- OLD name : Elemental encantado
-- Source : https://www.wowhead.com/wotlk/es/npc=21958
UPDATE `creature_template_locale` SET `Name` = 'Electromental encantado' WHERE `locale` = 'esES' AND `entry` = 21958;
-- OLD name : Oficial de Honor de Lunargenta
-- Source : https://www.wowhead.com/wotlk/es/npc=21968
UPDATE `creature_template_locale` SET `Name` = 'Oficial de Honor de la Ciudad de Lunargenta' WHERE `locale` = 'esES' AND `entry` = 21968;
-- OLD subname : Mención de honor de El Exodar
-- Source : https://www.wowhead.com/wotlk/es/npc=21971
UPDATE `creature_template_locale` SET `Title` = 'Mención de honor de Exodar' WHERE `locale` = 'esES' AND `entry` = 21971;
-- OLD name : Fauna del Valle Sombraluna
-- Source : https://www.wowhead.com/wotlk/es/npc=21978
UPDATE `creature_template_locale` SET `Name` = 'Fauna y flora del Valle Sombraluna' WHERE `locale` = 'esES' AND `entry` = 21978;
-- OLD name : Emboscador Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21982
UPDATE `creature_template_locale` SET `Name` = 'Emboscador culto vermis' WHERE `locale` = 'esES' AND `entry` = 21982;
-- OLD name : Eviscerador de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=21985
UPDATE `creature_template_locale` SET `Name` = 'Eviscerador Skettis' WHERE `locale` = 'esES' AND `entry` = 21985;
-- OLD name : Tótem Piel de piedra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=21994
UPDATE `creature_template_locale` SET `Name` = 'Tótem piel de piedra' WHERE `locale` = 'esES' AND `entry` = 21994;
-- OLD name : Celador de árboles Chawn
-- Source : https://www.wowhead.com/wotlk/es/npc=22007
UPDATE `creature_template_locale` SET `Name` = 'Depositario de árboles Chawn' WHERE `locale` = 'esES' AND `entry` = 22007;
-- OLD name : Elemental corrupto
-- Source : https://www.wowhead.com/wotlk/es/npc=22009
UPDATE `creature_template_locale` SET `Name` = 'Elemental máculo' WHERE `locale` = 'esES' AND `entry` = 22009;
-- OLD name : Kolphis Rangoscuro
-- Source : https://www.wowhead.com/wotlk/es/npc=22019
UPDATE `creature_template_locale` SET `Name` = 'Kolphis Escamaoscura' WHERE `locale` = 'esES' AND `entry` = 22019;
-- OLD name : [DND]Spirit 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22023
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22023;
-- OLD name : [PH] bat target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22039
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22039;
-- OLD name : Jinete de grifos Kieran
-- Source : https://www.wowhead.com/wotlk/es/npc=22042
UPDATE `creature_template_locale` SET `Name` = 'Jinete de grifo Kieran' WHERE `locale` = 'esES' AND `entry` = 22042;
-- OLD name : Reptador de la Caverna
-- Source : https://www.wowhead.com/wotlk/es/npc=22044
UPDATE `creature_template_locale` SET `Name` = 'Reptador de cavernas' WHERE `locale` = 'esES' AND `entry` = 22044;
-- OLD name : Raquítico vengativo
-- Source : https://www.wowhead.com/wotlk/es/npc=22045
UPDATE `creature_template_locale` SET `Name` = 'Cáscara vengativa' WHERE `locale` = 'esES' AND `entry` = 22045;
-- OLD name : [ph] cave ant [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22048
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22048;
-- OLD name : Coilfang Raid Control Emote Stalker
-- Source : https://www.wowhead.com/wotlk/es/npc=22057
UPDATE `creature_template_locale` SET `Name` = 'Invisible Stalker Coilfang Raid Console Emotes' WHERE `locale` = 'esES' AND `entry` = 22057;
-- OLD name : Guardia en grifo de los Aldor
-- Source : https://www.wowhead.com/wotlk/es/npc=22077
UPDATE `creature_template_locale` SET `Name` = 'Guardia grifo Aldor' WHERE `locale` = 'esES' AND `entry` = 22077;
-- OLD name : Caminarraíces infectado
-- Source : https://www.wowhead.com/wotlk/es/npc=22095
UPDATE `creature_template_locale` SET `Name` = 'Caminante de las raíces infectado' WHERE `locale` = 'esES' AND `entry` = 22095;
-- OLD name : Proveedor Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22099
UPDATE `creature_template_locale` SET `Name` = 'Proveedor culto vermis' WHERE `locale` = 'esES' AND `entry` = 22099;
-- OLD name : [DND]Whisper Spying Credit Marker 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22116
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22116;
-- OLD name : [DND]Whisper Spying Credit Marker 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22117
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22117;
-- OLD name : [DND]Whisper Spying Credit Marker 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22118
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22118;
-- OLD name : Cría negra del Barón Sablecrín (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22130
UPDATE `creature_template_locale` SET `Name` = 'Cría negra del barón Sablecrín' WHERE `locale` = 'esES' AND `entry` = 22130;
-- OLD name : Reptador de la Caverna adulto
-- Source : https://www.wowhead.com/wotlk/es/npc=22132
UPDATE `creature_template_locale` SET `Name` = 'Reptador de cavernas adulto' WHERE `locale` = 'esES' AND `entry` = 22132;
-- OLD name : Ojo de Kilrogg de Sombraluna
-- Source : https://www.wowhead.com/wotlk/es/npc=22134
UPDATE `creature_template_locale` SET `Name` = 'Ojo de Kilrogg Sombraluna' WHERE `locale` = 'esES' AND `entry` = 22134;
-- OLD name : Uñagrieta domada
-- Source : https://www.wowhead.com/wotlk/es/npc=22135
UPDATE `creature_template_locale` SET `Name` = 'Uñagrieta de doma' WHERE `locale` = 'esES' AND `entry` = 22135;
-- OLD name : Hermana de Foresta Ruuan
-- Source : https://www.wowhead.com/wotlk/es/npc=22151
UPDATE `creature_template_locale` SET `Name` = 'Hermana de Foresta de Ruuan' WHERE `locale` = 'esES' AND `entry` = 22151;
-- OLD name : Fuego fatuo de Foresta Ruuan
-- Source : https://www.wowhead.com/wotlk/es/npc=22152
UPDATE `creature_template_locale` SET `Name` = 'Fuego fatuo de Foresta de Ruuan' WHERE `locale` = 'esES' AND `entry` = 22152;
-- OLD name : Jabalí de pellejo fragmentado
-- Source : https://www.wowhead.com/wotlk/es/npc=22180
UPDATE `creature_template_locale` SET `Name` = 'Jabalí pellejo de fragmento' WHERE `locale` = 'esES' AND `entry` = 22180;
-- OLD name : Raya de éter
-- Source : https://www.wowhead.com/wotlk/es/npc=22181
UPDATE `creature_template_locale` SET `Name` = 'Raya de aether' WHERE `locale` = 'esES' AND `entry` = 22181;
-- OLD name : Susurradora de miedo
-- Source : https://www.wowhead.com/wotlk/es/npc=22201
UPDATE `creature_template_locale` SET `Name` = 'Susurrador de miedo' WHERE `locale` = 'esES' AND `entry` = 22201;
-- OLD subname : Especialista en sastrería de tela lunar
-- Source : https://www.wowhead.com/wotlk/es/npc=22208
UPDATE `creature_template_locale` SET `Title` = 'Especialista en tela lunar' WHERE `locale` = 'esES' AND `entry` = 22208;
-- OLD subname : Especialista en sastrería de tejido de sombra
-- Source : https://www.wowhead.com/wotlk/es/npc=22212
UPDATE `creature_template_locale` SET `Title` = 'Especialista en tejido de sombra' WHERE `locale` = 'esES' AND `entry` = 22212;
-- OLD subname : Especialista en sastrería de fuego de hechizo
-- Source : https://www.wowhead.com/wotlk/es/npc=22213
UPDATE `creature_template_locale` SET `Title` = 'Especialista en fuego de hechizo' WHERE `locale` = 'esES' AND `entry` = 22213;
-- OLD name : Clamamareas del Santuario Serpiente
-- Source : https://www.wowhead.com/wotlk/es/npc=22238
UPDATE `creature_template_locale` SET `Name` = 'Llamamareas del Santuario Serpiente' WHERE `locale` = 'esES' AND `entry` = 22238;
-- OLD name : Testigo de fatalidad
-- Source : https://www.wowhead.com/wotlk/es/npc=22282
UPDATE `creature_template_locale` SET `Name` = 'Testigo del Destino' WHERE `locale` = 'esES' AND `entry` = 22282;
-- OLD name : Extiendetormentas eredar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22283
UPDATE `creature_template_locale` SET `Name` = 'Extiendetormentas Eredar' WHERE `locale` = 'esES' AND `entry` = 22283;
-- OLD name : [PH] Wrath Clefthoof [not used] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22284
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22284;
-- OLD name : Guardia de horno
-- Source : https://www.wowhead.com/wotlk/es/npc=22291
UPDATE `creature_template_locale` SET `Name` = 'Maligno de cólera' WHERE `locale` = 'esES' AND `entry` = 22291;
-- OLD name : Alma de fuego vil (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22298
UPDATE `creature_template_locale` SET `Name` = 'Alma de Fuego vil' WHERE `locale` = 'esES' AND `entry` = 22298;
-- OLD name : Reptador de la Caverna sigiloso
-- Source : https://www.wowhead.com/wotlk/es/npc=22306
UPDATE `creature_template_locale` SET `Name` = 'Reptador de cavernas sigiloso' WHERE `locale` = 'esES' AND `entry` = 22306;
-- OLD name : Cazador Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22308
UPDATE `creature_template_locale` SET `Name` = 'Cazador culto vermis' WHERE `locale` = 'esES' AND `entry` = 22308;
-- OLD name : Rasgavientos tormentoso
-- Source : https://www.wowhead.com/wotlk/es/npc=22310
UPDATE `creature_template_locale` SET `Name` = 'Rasgavientos en tormenta' WHERE `locale` = 'esES' AND `entry` = 22310;
-- OLD name : Chispavil incandescente
-- Source : https://www.wowhead.com/wotlk/es/npc=22323
UPDATE `creature_template_locale` SET `Name` = 'Chispa vil incandescente' WHERE `locale` = 'esES' AND `entry` = 22323;
-- OLD name : Tejedor de pesadillas
-- Source : https://www.wowhead.com/wotlk/es/npc=22325
UPDATE `creature_template_locale` SET `Name` = 'Tejedor pesadilla' WHERE `locale` = 'esES' AND `entry` = 22325;
-- OLD name : Aviario redimido
-- Source : https://www.wowhead.com/wotlk/es/npc=22326
UPDATE `creature_template_locale` SET `Name` = 'Avian redimido' WHERE `locale` = 'esES' AND `entry` = 22326;
-- OLD name : [DND]Green Spot Grog Keg Relay (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22349
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22349;
-- OLD name : [DND]Green Spot Grog Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22356
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22356;
-- OLD name : Aspirante Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22359
UPDATE `creature_template_locale` SET `Name` = 'Aspirante culto vermis' WHERE `locale` = 'esES' AND `entry` = 22359;
-- OLD subname : Gran patriarca del Culto Vermis (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22361
UPDATE `creature_template_locale` SET `Title` = 'Gran patriarca del culto vermis' WHERE `locale` = 'esES' AND `entry` = 22361;
-- OLD name : [DND]Ripe Moonshine Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22367
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22367;
-- OLD name : [DND]Fermented Seed Beer Keg Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22368
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22368;
-- OLD name : Ambiente de esbirro de Terokk
-- Source : https://www.wowhead.com/wotlk/es/npc=22380
UPDATE `creature_template_locale` SET `Name` = 'Esbirro de Terokk' WHERE `locale` = 'esES' AND `entry` = 22380;
-- OLD name : [DND]Bloodmaul Chatter Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22383
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22383;
-- OLD name : Vigía Sombra Lunar
-- Source : https://www.wowhead.com/wotlk/es/npc=22386
UPDATE `creature_template_locale` SET `Name` = 'Vigía Sombraluna' WHERE `locale` = 'esES' AND `entry` = 22386;
-- OLD name : Guardagarra lítico
-- Source : https://www.wowhead.com/wotlk/es/npc=22388
UPDATE `creature_template_locale` SET `Name` = 'Garraguarda lítico' WHERE `locale` = 'esES' AND `entry` = 22388;
-- OLD name : Señor supremo Sombra de Muerte (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22393
UPDATE `creature_template_locale` SET `Name` = 'Señor Supremo Sombra de Muerte' WHERE `locale` = 'esES' AND `entry` = 22393;
-- OLD name : [PH]Altar of Shadows target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22395
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22395;
-- OLD name : [PH]Altar of Shadows caster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22417
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22417;
-- OLD name : [DND]Ogre Pike Planted Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22434
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22434;
-- OLD name : [DND]Rexxar's Wyvern Freed Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22435
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22435;
-- OLD name : Remanente de corrupción
-- Source : https://www.wowhead.com/wotlk/es/npc=22439
UPDATE `creature_template_locale` SET `Name` = 'Remantente de corrupción' WHERE `locale` = 'esES' AND `entry` = 22439;
-- OLD name : [DND]Sablemane's Trap Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22447
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22447;
-- OLD name : Vindicador Sha'tar malherido
-- Source : https://www.wowhead.com/wotlk/es/npc=22453
UPDATE `creature_template_locale` SET `Name` = 'Vindicador Sha''tar herido' WHERE `locale` = 'esES' AND `entry` = 22453;
-- OLD name : Enaniski
-- Source : https://www.wowhead.com/wotlk/es/npc=22481
UPDATE `creature_template_locale` SET `Name` = 'Sesoenanof' WHERE `locale` = 'esES' AND `entry` = 22481;
-- OLD name : Tótem Nexo Terrestre superior (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=22486
UPDATE `creature_template_locale` SET `Name` = 'Tótem Nexo terrestre superior' WHERE `locale` = 'esES' AND `entry` = 22486;
-- OLD name : Tótem de limpieza contraveneno superior
-- Source : https://www.wowhead.com/wotlk/es/npc=22487
UPDATE `creature_template_locale` SET `Name` = 'Tótem contraveneno superior' WHERE `locale` = 'esES' AND `entry` = 22487;
-- OLD name : Death's Door Fel Cannon Target Bunny
-- Source : https://www.wowhead.com/wotlk/es/npc=22495
UPDATE `creature_template_locale` SET `Name` = 'Cañón vil de la Puerta de la Muerte' WHERE `locale` = 'esES' AND `entry` = 22495;
-- OLD name : Maestro de batalla del Ojo de la Tormenta
-- Source : https://www.wowhead.com/wotlk/es/npc=22516
UPDATE `creature_template_locale` SET `Name` = 'Maestro de batalla de El Ojo de la Tormenta' WHERE `locale` = 'esES' AND `entry` = 22516;
-- OLD name : [DND]Prophecy 1 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22798
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22798;
-- OLD name : [DND]Prophecy 2 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22799
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22799;
-- OLD name : [DND]Prophecy 3 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22800
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22800;
-- OLD name : [DND]Prophecy 4 Quest Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22801
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22801;
-- OLD name : Druida de expedición Cenarion rescatado
-- Source : https://www.wowhead.com/wotlk/es/npc=22810
UPDATE `creature_template_locale` SET `Name` = 'Druida de la Expedición Cenarion rescatado' WHERE `locale` = 'esES' AND `entry` = 22810;
-- OLD name : Vengador de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=22821
UPDATE `creature_template_locale` SET `Name` = 'Vengador de Etereum' WHERE `locale` = 'esES' AND `entry` = 22821;
-- OLD name : Nulificador de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=22822
UPDATE `creature_template_locale` SET `Name` = 'Nulificador de Etereum' WHERE `locale` = 'esES' AND `entry` = 22822;
-- OLD name : Guja de El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=22824
UPDATE `creature_template_locale` SET `Name` = 'Guja de Etereum' WHERE `locale` = 'esES' AND `entry` = 22824;
-- OLD subname : Druida de la Garfa
-- Source : https://www.wowhead.com/wotlk/es/npc=22832
UPDATE `creature_template_locale` SET `Title` = 'Druida de la Garra' WHERE `locale` = 'esES' AND `entry` = 22832;
-- OLD name : Asesino Pezuña Umbría
-- Source : https://www.wowhead.com/wotlk/es/npc=22858
UPDATE `creature_template_locale` SET `Name` = 'Asesino Pezumbría' WHERE `locale` = 'esES' AND `entry` = 22858;
-- OLD name : Retador Cicatriz Espiral
-- Source : https://www.wowhead.com/wotlk/es/npc=22877
UPDATE `creature_template_locale` SET `Name` = 'Domador Cicatriz Espiral' WHERE `locale` = 'esES' AND `entry` = 22877;
-- OLD name : Señor acuoso
-- Source : https://www.wowhead.com/wotlk/es/npc=22878
UPDATE `creature_template_locale` SET `Name` = 'Lord Aqueous' WHERE `locale` = 'esES' AND `entry` = 22878;
-- OLD name : Marea acuosa
-- Source : https://www.wowhead.com/wotlk/es/npc=22881
UPDATE `creature_template_locale` SET `Name` = 'Marea Aqueous' WHERE `locale` = 'esES' AND `entry` = 22881;
-- OLD name : Engendro acuoso
-- Source : https://www.wowhead.com/wotlk/es/npc=22883
UPDATE `creature_template_locale` SET `Name` = 'Engendro de Aqueous' WHERE `locale` = 'esES' AND `entry` = 22883;
-- OLD name : Wodin, el sirviente trol
-- Source : https://www.wowhead.com/wotlk/es/npc=22893
UPDATE `creature_template_locale` SET `Name` = 'Wodin el sirviente trol' WHERE `locale` = 'esES' AND `entry` = 22893;
-- OLD name : Prisionero de El Etereum (Stasis Chamber Alpha)
-- Source : https://www.wowhead.com/wotlk/es/npc=22921
UPDATE `creature_template_locale` SET `Name` = 'Prisionero de los etereum (Stasis Chamber Alpha)' WHERE `locale` = 'esES' AND `entry` = 22921;
-- OLD name : Arthorn Son del Viento
-- Source : https://www.wowhead.com/wotlk/es/npc=22924
UPDATE `creature_template_locale` SET `Name` = 'Arthorn Murmullo' WHERE `locale` = 'esES' AND `entry` = 22924;
-- OLD name : Prisionero de El Etereum (Dungeon Energy Ball)
-- Source : https://www.wowhead.com/wotlk/es/npc=22927
UPDATE `creature_template_locale` SET `Name` = 'Prisionero de los etereum (Dungeon Energy Ball)' WHERE `locale` = 'esES' AND `entry` = 22927;
-- OLD name : Concubina del templo
-- Source : https://www.wowhead.com/wotlk/es/npc=22939
UPDATE `creature_template_locale` SET `Name` = 'Acólito del templo' WHERE `locale` = 'esES' AND `entry` = 22939;
-- OLD name : [UNUSED] Illidari Hound [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22944
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22944;
-- OLD name : Cortesana encantadora
-- Source : https://www.wowhead.com/wotlk/es/npc=22955
UPDATE `creature_template_locale` SET `Name` = 'Parroquiano embelesador' WHERE `locale` = 'esES' AND `entry` = 22955;
-- OLD name : Hermana del dolor
-- Source : https://www.wowhead.com/wotlk/es/npc=22956
UPDATE `creature_template_locale` SET `Name` = 'Sacerdotisa del Tormento' WHERE `locale` = 'esES' AND `entry` = 22956;
-- OLD name : Sacerdotisa de la demencia
-- Source : https://www.wowhead.com/wotlk/es/npc=22957
UPDATE `creature_template_locale` SET `Name` = 'Maestra de la demencia' WHERE `locale` = 'esES' AND `entry` = 22957;
-- OLD name : Auxiliar vinculado a hechizo
-- Source : https://www.wowhead.com/wotlk/es/npc=22959
UPDATE `creature_template_locale` SET `Name` = 'Anfitrión candente' WHERE `locale` = 'esES' AND `entry` = 22959;
-- OLD name : [UNUSED] Harem Girl 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=22961
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 22961;
-- OLD name : Sacerdotisa de los placeres
-- Source : https://www.wowhead.com/wotlk/es/npc=22962
UPDATE `creature_template_locale` SET `Name` = 'Maestra de la tragedia' WHERE `locale` = 'esES' AND `entry` = 22962;
-- OLD name : Hermana del placer
-- Source : https://www.wowhead.com/wotlk/es/npc=22964
UPDATE `creature_template_locale` SET `Name` = 'Sacerdotisa de los placeres' WHERE `locale` = 'esES' AND `entry` = 22964;
-- OLD name : Siervo esclavizado
-- Source : https://www.wowhead.com/wotlk/es/npc=22965
UPDATE `creature_template_locale` SET `Name` = 'Administrador devoto' WHERE `locale` = 'esES' AND `entry` = 22965;
-- OLD name : Jinete de elekks Juraluz
-- Source : https://www.wowhead.com/wotlk/es/npc=22966
UPDATE `creature_template_locale` SET `Name` = 'Jinete de elekk Juraluz' WHERE `locale` = 'esES' AND `entry` = 22966;
-- OLD name : Rizzle Engranágil
-- Source : https://www.wowhead.com/wotlk/es/npc=23002
UPDATE `creature_template_locale` SET `Name` = 'Rizzle Energiodentado' WHERE `locale` = 'esES' AND `entry` = 23002;
-- OLD name : Carcelero El Etereum
-- Source : https://www.wowhead.com/wotlk/es/npc=23008
UPDATE `creature_template_locale` SET `Name` = 'Carcelero Etereum' WHERE `locale` = 'esES' AND `entry` = 23008;
-- OLD name : Consorte obsidiana
-- Source : https://www.wowhead.com/wotlk/es/npc=23062
UPDATE `creature_template_locale` SET `Name` = 'Consorte Obsidiano' WHERE `locale` = 'esES' AND `entry` = 23062;
-- OLD name : [PH]Knockdown Fel Cannon Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23077
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23077;
-- OLD name : Ensamblaje enigmático
-- Source : https://www.wowhead.com/wotlk/es/npc=23111
UPDATE `creature_template_locale` SET `Name` = 'Ensamblaje tenebroso' WHERE `locale` = 'esES' AND `entry` = 23111;
-- OLD name : [UNUSED] Jefe Teron Sanguino (montado) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23126
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23126;
-- OLD name : Espíritu de halcón
-- Source : https://www.wowhead.com/wotlk/es/npc=23134
UPDATE `creature_template_locale` SET `Name` = 'Espíritu halcón' WHERE `locale` = 'esES' AND `entry` = 23134;
-- OLD name : [PH]Fel Hound (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23138
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23138;
-- OLD name : Vakkiz, la Furia del Viento
-- Source : https://www.wowhead.com/wotlk/es/npc=23162
UPDATE `creature_template_locale` SET `Name` = 'Vakkiz la Furia del Viento' WHERE `locale` = 'esES' AND `entry` = 23162;
-- OLD name : Imagen de humo de dragón Negro (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23190
UPDATE `creature_template_locale` SET `Name` = 'Imagen de humo de dragón negro' WHERE `locale` = 'esES' AND `entry` = 23190;
-- OLD name : Trabajador de Ruta aérea
-- Source : https://www.wowhead.com/wotlk/es/npc=23194
UPDATE `creature_template_locale` SET `Name` = 'Obrero de Ruta aérea' WHERE `locale` = 'esES' AND `entry` = 23194;
-- OLD name : Vakkiz, la Furia del Viento
-- Source : https://www.wowhead.com/wotlk/es/npc=23204
UPDATE `creature_template_locale` SET `Name` = 'Vakkiz el Furibundo del Viento' WHERE `locale` = 'esES' AND `entry` = 23204;
-- OLD name : Asesino de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=23207
UPDATE `creature_template_locale` SET `Name` = 'Asesino Skettis' WHERE `locale` = 'esES' AND `entry` = 23207;
-- OLD name : Persecutor de distorsión Vientonegro
-- Source : https://www.wowhead.com/wotlk/es/npc=23219
UPDATE `creature_template_locale` SET `Name` = 'Persecutor de distorsión Alanegra' WHERE `locale` = 'esES' AND `entry` = 23219;
-- OLD name : Shivarra asesina
-- Source : https://www.wowhead.com/wotlk/es/npc=23220
UPDATE `creature_template_locale` SET `Name` = 'Asesina shivaísta' WHERE `locale` = 'esES' AND `entry` = 23220;
-- OLD name : [UNUSED] Mutant Commander [PH] (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23238
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23238;
-- OLD name : Técnico de éter de la Guardia del cielo
-- Source : https://www.wowhead.com/wotlk/es/npc=23241
UPDATE `creature_template_locale` SET `Name` = 'Técnico aether de la Guardia del cielo' WHERE `locale` = 'esES' AND `entry` = 23241;
-- OLD name : Ayudante técnico de éter
-- Source : https://www.wowhead.com/wotlk/es/npc=23243
UPDATE `creature_template_locale` SET `Name` = 'Ayudante técnico aether' WHERE `locale` = 'esES' AND `entry` = 23243;
-- OLD name : Adepto técnico de éter
-- Source : https://www.wowhead.com/wotlk/es/npc=23244
UPDATE `creature_template_locale` SET `Name` = 'Adepto técnico aether' WHERE `locale` = 'esES' AND `entry` = 23244;
-- OLD name : Maestro técnico de éter
-- Source : https://www.wowhead.com/wotlk/es/npc=23245
UPDATE `creature_template_locale` SET `Name` = 'Maestro técnico aether' WHERE `locale` = 'esES' AND `entry` = 23245;
-- OLD name : Imagen de humo de guardia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=23252
UPDATE `creature_template_locale` SET `Name` = 'Imagen de humo de guarda vil' WHERE `locale` = 'esES' AND `entry` = 23252;
-- OLD name : Barash, la madre del cubil
-- Source : https://www.wowhead.com/wotlk/es/npc=23269
UPDATE `creature_template_locale` SET `Name` = 'Barash la madre del Cubil' WHERE `locale` = 'esES' AND `entry` = 23269;
-- OLD name : [PH]Wrath Hound Transform (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23276
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23276;
-- OLD name : Vagón de mina
-- Source : https://www.wowhead.com/wotlk/es/npc=23289
UPDATE `creature_template_locale` SET `Name` = 'Vagoneta' WHERE `locale` = 'esES' AND `entry` = 23289;
-- OLD name : Terror de sangre de Draenor
-- Source : https://www.wowhead.com/wotlk/es/npc=23290
UPDATE `creature_template_locale` SET `Name` = 'Terror de sangre Draenor' WHERE `locale` = 'esES' AND `entry` = 23290;
-- OLD name : [PH] PvP Cannon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23314
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23314;
-- OLD name : [PH] PvP Cannon Shot Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23315
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23315;
-- OLD name : [PH] PvP Cannon Targetting Reticle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23317
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23317;
-- OLD name : Montura de polilla Faucedraco
-- Source : https://www.wowhead.com/wotlk/es/npc=23341
UPDATE `creature_template_locale` SET `Name` = 'Montura polilla Faucedraco' WHERE `locale` = 'esES' AND `entry` = 23341;
-- OLD name : Raya de éter enlazada
-- Source : https://www.wowhead.com/wotlk/es/npc=23343
UPDATE `creature_template_locale` SET `Name` = 'Raya de aether enlazada' WHERE `locale` = 'esES' AND `entry` = 23343;
-- OLD name : Draco abisal del Capitán Rompecielos
-- Source : https://www.wowhead.com/wotlk/es/npc=23349
UPDATE `creature_template_locale` SET `Name` = 'Draco abisal de Capitán Rompecielos' WHERE `locale` = 'esES' AND `entry` = 23349;
-- OLD name : Vástago de dragón Negro (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23364
UPDATE `creature_template_locale` SET `Name` = 'Vástago de dragón negro' WHERE `locale` = 'esES' AND `entry` = 23364;
-- OLD subname : Malla y placas clásicas de la Alianza
-- Source : https://www.wowhead.com/wotlk/es/npc=23396
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de arena' WHERE `locale` = 'esES' AND `entry` = 23396;
-- OLD subname : NONE
-- Source : https://www.wowhead.com/wotlk/es/npc=23405
UPDATE `creature_template_locale` SET `Title` = 'Consumibles del RPP' WHERE `locale` = 'esES' AND `entry` = 23405;
-- OLD name : Lord Cuervo
-- Source : https://www.wowhead.com/wotlk/es/npc=23408
UPDATE `creature_template_locale` SET `Name` = 'Montura de Lord Cuervo presta' WHERE `locale` = 'esES' AND `entry` = 23408;
-- OLD name : Esencia de sufrimiento (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23418
UPDATE `creature_template_locale` SET `Name` = 'Esencia de Sufrimiento' WHERE `locale` = 'esES' AND `entry` = 23418;
-- OLD name : Esencia de deseo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23419
UPDATE `creature_template_locale` SET `Name` = 'Esencia de Deseo' WHERE `locale` = 'esES' AND `entry` = 23419;
-- OLD name : Esencia de inquina (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23420
UPDATE `creature_template_locale` SET `Name` = 'Esencia de Inquina' WHERE `locale` = 'esES' AND `entry` = 23420;
-- OLD name : Draco Ala Abisal veridiana
-- Source : https://www.wowhead.com/wotlk/es/npc=23457
UPDATE `creature_template_locale` SET `Name` = 'Draco Ala Abisal veridiano' WHERE `locale` = 'esES' AND `entry` = 23457;
-- OLD name : Escolta de Skettis
-- Source : https://www.wowhead.com/wotlk/es/npc=23471
UPDATE `creature_template_locale` SET `Name` = 'Escolta Skettis' WHERE `locale` = 'esES' AND `entry` = 23471;
-- OLD name : Aprendiz técnico de éter
-- Source : https://www.wowhead.com/wotlk/es/npc=23473
UPDATE `creature_template_locale` SET `Name` = 'Aprendiz técnico aether' WHERE `locale` = 'esES' AND `entry` = 23473;
-- OLD name : [PH] Brewfest Dwarf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23479
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23479;
-- OLD name : [PH] Brewfest Human Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23480
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23480;
-- OLD name : Gentío de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23488
UPDATE `creature_template_locale` SET `Name` = 'Gentío de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 23488;
-- OLD name : Vórtice enigmático
-- Source : https://www.wowhead.com/wotlk/es/npc=23503
UPDATE `creature_template_locale` SET `Name` = 'Vórtice tenebroso' WHERE `locale` = 'esES' AND `entry` = 23503;
-- OLD name : Equipo de montaje de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23504
UPDATE `creature_template_locale` SET `Name` = 'Equipo de montaje de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 23504;
-- OLD name : [PH] Brewfest Garden D Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23532
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23532;
-- OLD name : [PH] Brewfest Goblin Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23540
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23540;
-- OLD name : Budd
-- Source : https://www.wowhead.com/wotlk/es/npc=23559
UPDATE `creature_template_locale` SET `Name` = 'Budd Magallenas' WHERE `locale` = 'esES' AND `entry` = 23559;
-- OLD name : Soldado de los Baldíos Helados
-- Source : https://www.wowhead.com/wotlk/es/npc=23561
UPDATE `creature_template_locale` SET `Name` = 'Soldado de los Páramos Congelados' WHERE `locale` = 'esES' AND `entry` = 23561;
-- OLD subname : Instructora de pícaros
-- Source : https://www.wowhead.com/wotlk/es/npc=23566
UPDATE `creature_template_locale` SET `Title` = 'IV:7' WHERE `locale` = 'esES' AND `entry` = 23566;
-- OLD subname : Buzo de salvamento del IV:7
-- Source : https://www.wowhead.com/wotlk/es/npc=23569
UPDATE `creature_template_locale` SET `Title` = 'Buzo de salvamento de IV:7' WHERE `locale` = 'esES' AND `entry` = 23569;
-- OLD name : Carnero de la Fiesta de la Cerveza
-- Source : https://www.wowhead.com/wotlk/es/npc=23588
UPDATE `creature_template_locale` SET `Name` = 'Carnero de carreras (Fiesta de la cerveza)' WHERE `locale` = 'esES' AND `entry` = 23588;
-- OLD name : Vinculador terrestre Tótem Siniestro (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23595
UPDATE `creature_template_locale` SET `Name` = 'Vinculador Terrestre Tótem Siniestro' WHERE `locale` = 'esES' AND `entry` = 23595;
-- OLD name : [PH] New Hinterlands NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23599
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23599;
-- OLD name : [PH] Brewfest Orc Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23607
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23607;
-- OLD name : [PH] Brewfest Tauren Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23608;
-- OLD name : [PH] Brewfest Troll Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23609
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23609;
-- OLD name : [PH] Brewfest Blood Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23610
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23610;
-- OLD name : [PH] Brewfest Undead Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23611
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23611;
-- OLD name : [PH] Brewfest Draenei Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23613
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23613;
-- OLD name : [PH] Brewfest Gnome Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23614
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23614;
-- OLD name : [PH] Brewfest Night Elf Reveler (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23615
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23615;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23629
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23629;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE B (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23630
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23630;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE C (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23631
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23631;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE D (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23632
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23632;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE E (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23633
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23633;
-- OLD name : [PH] Darkmoon Carnie APPEARANCE F (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23634
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23634;
-- OLD name : Voceador de cerveza Gordok
-- Source : https://www.wowhead.com/wotlk/es/npc=23685
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de cerveza Gordok' WHERE `locale` = 'esES' AND `entry` = 23685;
-- OLD name : Draco brasaescama
-- Source : https://www.wowhead.com/wotlk/es/npc=23687
UPDATE `creature_template_locale` SET `Name` = 'Draco escama agostadora' WHERE `locale` = 'esES' AND `entry` = 23687;
-- OLD name : Águila Alaocaso
-- Source : https://www.wowhead.com/wotlk/es/npc=23693
UPDATE `creature_template_locale` SET `Name` = 'Águila Alatardecer' WHERE `locale` = 'esES' AND `entry` = 23693;
-- OLD name : Juerguista de la Fiesta de la Cerveza borracho (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=23698
UPDATE `creature_template_locale` SET `Name` = 'Juerguista de la Fiesta de la cerveza borracho' WHERE `locale` = 'esES' AND `entry` = 23698;
-- OLD name : [DND] Brewfest Dark Iron Event Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23703
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23703;
-- OLD name : Huérfano ambulante
-- Source : https://www.wowhead.com/wotlk/es/npc=23712
UPDATE `creature_template_locale` SET `Name` = 'Húerfano ambulante' WHERE `locale` = 'esES' AND `entry` = 23712;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=23734
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 23734;
-- OLD name : [DND] Brewfest Keg Move to Target (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=23808
UPDATE `creature_template_locale` SET `Name` = 'Fiesta de la Cerveza hacia objetivo' WHERE `locale` = 'esES' AND `entry` = 23808;
-- OLD name : [PH] Brewfest Dwarf Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23819
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23819;
-- OLD name : [PH] Brewfest Dwarf Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23820;
-- OLD name : Guarda protector Amani
-- Source : https://www.wowhead.com/wotlk/es/npc=23822
UPDATE `creature_template_locale` SET `Name` = 'Guarda protectivo Amani' WHERE `locale` = 'esES' AND `entry` = 23822;
-- OLD name : [PH] Brewfest Goblin Female Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23824
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23824;
-- OLD name : [PH] Brewfest Goblin Male Celebrant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23825
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23825;
-- OLD name : [DND] L70ETC FX Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23830
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23830;
-- OLD name : Dracohalcón Amani
-- Source : https://www.wowhead.com/wotlk/es/npc=23834
UPDATE `creature_template_locale` SET `Name` = 'Dacohalcón Amani' WHERE `locale` = 'esES' AND `entry` = 23834;
-- OLD name : [DND] L70ETC Bergrisst Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23845
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23845;
-- OLD name : [DND] L70ETC Concert Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23850
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23850;
-- OLD name : [DND] L70ETC Mai'Kyl Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23852
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23852;
-- OLD name : [DND] L70ETC Samuro Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23853
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23853;
-- OLD name : [DND] L70ETC Sig Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23854
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23854;
-- OLD name : [DND] L70ETC Chief Thunder-Skins Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23855
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23855;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=23862
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 23862;
-- OLD name : Vigilante Almanegra
-- Source : https://www.wowhead.com/wotlk/es/npc=23875
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de alma negra' WHERE `locale` = 'esES' AND `entry` = 23875;
-- OLD name : [DND] Brewfest Dark Iron Spawn Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23894
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23894;
-- OLD subname : Instructor de pesca y suministros
-- Source : https://www.wowhead.com/wotlk/es/npc=23896
UPDATE `creature_template_locale` SET `Title` = 'Mercader de pescado' WHERE `locale` = 'esES' AND `entry` = 23896;
-- OLD name : [DNT]TEST Pet Moth (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=23936
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 23936;
-- OLD name : Tigre espectral
-- Source : https://www.wowhead.com/wotlk/es/npc=24003
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar (fantasma)' WHERE `locale` = 'esES' AND `entry` = 24003;
-- OLD name : Tigre espectral presto
-- Source : https://www.wowhead.com/wotlk/es/npc=24004
UPDATE `creature_template_locale` SET `Name` = 'Lobo de montar presto (fantasma)' WHERE `locale` = 'esES' AND `entry` = 24004;
-- OLD name : Carnero Petrasta (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=24049
UPDATE `creature_template_locale` SET `Name` = 'Carnero Cuerno Pétreo' WHERE `locale` = 'esES' AND `entry` = 24049;
-- OLD name : Sacerdotisa de Valgarde capturada
-- Source : https://www.wowhead.com/wotlk/es/npc=24086
UPDATE `creature_template_locale` SET `Name` = 'Sacerdote de Valgarde capturado' WHERE `locale` = 'esES' AND `entry` = 24086;
-- OLD name : Sacerdotisa de Valgarde
-- Source : https://www.wowhead.com/wotlk/es/npc=24099
UPDATE `creature_template_locale` SET `Name` = 'Sacerdote de Valgarde' WHERE `locale` = 'esES' AND `entry` = 24099;
-- OLD name : [DND] Brewfest Target Dummy Move To Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24109
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24109;
-- OLD name : [DND] Darkmoon Faire Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24171
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24171;
-- OLD name : Surcavientos Amani'shi
-- Source : https://www.wowhead.com/wotlk/es/npc=24179
UPDATE `creature_template_locale` SET `Name` = 'Surcador del viento Amani''shi' WHERE `locale` = 'esES' AND `entry` = 24179;
-- OLD name : [UNUSED]Fantasma de expedicionario Jaren (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=24181
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge B' WHERE `locale` = 'esES' AND `entry` = 24181;
-- OLD name : [DND] Brewfest Barker Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24202
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24202;
-- OLD name : [DND] Brewfest Barker Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24203
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24203;
-- OLD name : [DND] Brewfest Barker Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24204
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24204;
-- OLD name : [DND] Brewfest Barker Bunny 4 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24205
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24205;
-- OLD name : Ejército de muertos
-- Source : https://www.wowhead.com/wotlk/es/npc=24207
UPDATE `creature_template_locale` SET `Name` = 'Necrófago del Ejército de muertos' WHERE `locale` = 'esES' AND `entry` = 24207;
-- OLD name : [DND] Darkmoon Faire Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24220
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24220;
-- OLD name : [DND] Brewfest Speed Bunny Green (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24263
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24263;
-- OLD name : [DND] Brewfest Speed Bunny Yellow (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24264
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24264;
-- OLD name : [DND] Brewfest Speed Bunny Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24265
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24265;
-- OLD name : [PH] Gossip NPC Human Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24292;
-- OLD name : [PH] Gossip NPC Human Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24293
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24293;
-- OLD name : [PH] Gossip NPC Blood Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24294
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24294;
-- OLD name : [PH] Gossip NPC Blood Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24295
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24295;
-- OLD name : [PH] Gossip NPC Draenei Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24296;
-- OLD name : [PH] Gossip NPC Draenei Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24297
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24297;
-- OLD name : [PH] Gossip NPC Dwarf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24298
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24298;
-- OLD name : [PH] Gossip NPC Dwarf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24299
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24299;
-- OLD name : [PH] Gossip NPC Undead Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24300
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24300;
-- OLD name : [PH] Gossip NPC Undead Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24301
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24301;
-- OLD name : [PH] Gossip NPC Gnome Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24302
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24302;
-- OLD name : [PH] Gossip NPC Gnome Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24303
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24303;
-- OLD name : [PH] Gossip NPC Goblin Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24304
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24304;
-- OLD name : [PH] Gossip NPC Goblin Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24305
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24305;
-- OLD name : [PH] Gossip NPC Night Elf Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24306
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24306;
-- OLD name : [PH] Gossip NPC Night Elf Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24307
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24307;
-- OLD name : [PH] Gossip NPC Orc Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24308
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24308;
-- OLD name : [PH] Gossip NPC Orc Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24309
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24309;
-- OLD name : [PH] Gossip NPC Tauren Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24310
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24310;
-- OLD name : [PH] Gossip NPC Tauren Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24311
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24311;
-- OLD name : [PH] Creepy Rag Doll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24319;
-- OLD name : Jason Buencobijo, subname : Camarero
-- Source : https://www.wowhead.com/wotlk/es/npc=24333
UPDATE `creature_template_locale` SET `Name` = 'Posadero Jason Buencobijo',`Title` = 'Bebidas' WHERE `locale` = 'esES' AND `entry` = 24333;
-- OLD name : [DND] Brewfest Delivery Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24337
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24337;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24351
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24351;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24352
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24352;
-- OLD name : [PH] Gossip NPC Troll Female, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24360
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24360;
-- OLD name : [PH] Gossip NPC Troll Male, Halloween (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24361;
-- OLD name : Cadáver de Harrison
-- Source : https://www.wowhead.com/wotlk/es/npc=24365
UPDATE `creature_template_locale` SET `Name` = 'Cadáver de Willie' WHERE `locale` = 'esES' AND `entry` = 24365;
-- OLD name : Carnero de la Fiesta de la Cerveza presto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24368
UPDATE `creature_template_locale` SET `Name` = 'Carnero de la Fiesta de la cerveza presto' WHERE `locale` = 'esES' AND `entry` = 24368;
-- OLD name : [UNUSED]Vazruden Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=24377
UPDATE `creature_template_locale` SET `Name` = 'Summoned Satchel Charge C' WHERE `locale` = 'esES' AND `entry` = 24377;
-- OLD name : [UNUSED]Nazan Kill Credit (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=24378
UPDATE `creature_template_locale` SET `Name` = 'Back To Bladespire Fortress Flight Kill Credit' WHERE `locale` = 'esES' AND `entry` = 24378;
-- OLD name : [VO]Nalorakk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24382
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24382;
-- OLD name : [VO]Akil'Zon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24383
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24383;
-- OLD name : [VO]Halazzi (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24384
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24384;
-- OLD name : [VO]Jan'alai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24386
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24386;
-- OLD subname : Vendedor de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=24395
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 24395;
-- OLD name : Invisible Man - No Weapons (Server Only/Hide Body)
-- Source : https://www.wowhead.com/wotlk/es/npc=24417
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 24417;
-- OLD name : Imagen de la Acechadora Negra (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24420
UPDATE `creature_template_locale` SET `Name` = 'Imagen de la acechadora negra' WHERE `locale` = 'esES' AND `entry` = 24420;
-- OLD name : Imagen del príncipe-nexo Shaffar
-- Source : https://www.wowhead.com/wotlk/es/npc=24423
UPDATE `creature_template_locale` SET `Name` = 'Imagen de Príncipe-nexo Shaffar' WHERE `locale` = 'esES' AND `entry` = 24423;
-- OLD name : [PH] Maldonado's Test Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24470
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24470;
-- OLD name : Fuego de forja
-- Source : https://www.wowhead.com/wotlk/es/npc=24471
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 24471;
-- OLD name : Huargo sanguinario
-- Source : https://www.wowhead.com/wotlk/es/npc=24475
UPDATE `creature_template_locale` SET `Name` = 'Huargo sediento de sangre' WHERE `locale` = 'esES' AND `entry` = 24475;
-- OLD name : Juerguista de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24484
UPDATE `creature_template_locale` SET `Name` = 'Juerguista de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 24484;
-- OLD name : Voceador de la Destilería de Drohn
-- Source : https://www.wowhead.com/wotlk/es/npc=24492
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de destilería de Drohn' WHERE `locale` = 'esES' AND `entry` = 24492;
-- OLD name : Voceador de la Cervecería vudú de T'chali
-- Source : https://www.wowhead.com/wotlk/es/npc=24493
UPDATE `creature_template_locale` SET `Name` = 'Charlatán de cervecería vudú de T''chali' WHERE `locale` = 'esES' AND `entry` = 24493;
-- OLD name : Gafas de cerveza de mujer orco
-- Source : https://www.wowhead.com/wotlk/es/npc=24496
UPDATE `creature_template_locale` SET `Name` = 'Gafas de cerveza de orca' WHERE `locale` = 'esES' AND `entry` = 24496;
-- OLD name : Aprendiz de la Destilería de Drohn, subname : Vendedor de cerveza de la Destilería de Drohn (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24501
UPDATE `creature_template_locale` SET `Name` = 'Aprendiz de destilería de Drohn',`Title` = 'Vendedor de cerveza de la destilería de Drohn' WHERE `locale` = 'esES' AND `entry` = 24501;
-- OLD name : Supervisora de huérfanos disfrazada
-- Source : https://www.wowhead.com/wotlk/es/npc=24519
UPDATE `creature_template_locale` SET `Name` = 'Matrona de huérfanos disfrazada' WHERE `locale` = 'esES' AND `entry` = 24519;
-- OLD name : Equipo de montaje goblin de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24522
UPDATE `creature_template_locale` SET `Name` = 'Equipo de montaje goblin de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 24522;
-- OLD name : Ellrys Sacronoche
-- Source : https://www.wowhead.com/wotlk/es/npc=24558
UPDATE `creature_template_locale` SET `Name` = 'Ellrys Anochecher Santificado' WHERE `locale` = 'esES' AND `entry` = 24558;
-- OLD name : [PH] BLB Blue Blood Elf Male (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24658
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24658;
-- OLD name : Teniente Martillo de Hielo
-- Source : https://www.wowhead.com/wotlk/es/npc=24665
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 24665;
-- OLD name : Capitán Martillo de Endecha
-- Source : https://www.wowhead.com/wotlk/es/npc=24672
UPDATE `creature_template_locale` SET `Name` = 'Capitán Martillo Temible' WHERE `locale` = 'esES' AND `entry` = 24672;
-- OLD name : Hermana del tormento (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24697
UPDATE `creature_template_locale` SET `Name` = 'Hermana del Tormento' WHERE `locale` = 'esES' AND `entry` = 24697;
-- OLD name : Headless Horseman, friendly
-- Source : https://www.wowhead.com/wotlk/es/npc=24700
UPDATE `creature_template_locale` SET `Name` = 'Headless Horseman Flame Bunny' WHERE `locale` = 'esES' AND `entry` = 24700;
-- OLD subname : Organizador de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24710
UPDATE `creature_template_locale` SET `Title` = 'Organizador de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 24710;
-- OLD subname : Organizador de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24711
UPDATE `creature_template_locale` SET `Title` = 'Organizador de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 24711;
-- OLD name : [DND] Brewfest Face Me Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24766
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24766;
-- OLD name : Soldado dragón Rojo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24769
UPDATE `creature_template_locale` SET `Name` = 'Soldado dragón rojo' WHERE `locale` = 'esES' AND `entry` = 24769;
-- OLD name : Alma melancólica
-- Source : https://www.wowhead.com/wotlk/es/npc=24789
UPDATE `creature_template_locale` SET `Name` = 'Alma abandonada' WHERE `locale` = 'esES' AND `entry` = 24789;
-- OLD name : Montura de El Jinete decapitado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24814
UPDATE `creature_template_locale` SET `Name` = 'Montura de El Jinete Decapitado' WHERE `locale` = 'esES' AND `entry` = 24814;
-- OLD name : Imagen de hermana del tormento (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=24854
UPDATE `creature_template_locale` SET `Name` = 'Imagen de hermana del Tormento' WHERE `locale` = 'esES' AND `entry` = 24854;
-- OLD name : Pirata Defias, femenino
-- Source : https://www.wowhead.com/wotlk/es/npc=24860
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 24860;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=24868
UPDATE `creature_template_locale` SET `Title` = 'Instructora maestra de ingeniería' WHERE `locale` = 'esES' AND `entry` = 24868;
-- OLD name : [PH]Avalanche (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=24912
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 24912;
-- OLD name : Mecanojuguete azul de batalla
-- Source : https://www.wowhead.com/wotlk/es/npc=24970
UPDATE `creature_template_locale` SET `Name` = 'Guerrero de cuerda azul de batalla' WHERE `locale` = 'esES' AND `entry` = 24970;
-- OLD name : Mecanojuguete rojo pendenciero
-- Source : https://www.wowhead.com/wotlk/es/npc=24971
UPDATE `creature_template_locale` SET `Name` = 'Guerrero de cuerda rojo pendenciero' WHERE `locale` = 'esES' AND `entry` = 24971;
-- OLD name : Distorsi
-- Source : https://www.wowhead.com/wotlk/es/npc=24977
UPDATE `creature_template_locale` SET `Name` = 'Combao' WHERE `locale` = 'esES' AND `entry` = 24977;
-- OLD subname : Compañera de Frascotaur
-- Source : https://www.wowhead.com/wotlk/es/npc=24982
UPDATE `creature_template_locale` SET `Title` = 'Encantamientos del RPP' WHERE `locale` = 'esES' AND `entry` = 24982;
-- OLD name : Mercader Fallel Mirada Estelar
-- Source : https://www.wowhead.com/wotlk/es/npc=24995
UPDATE `creature_template_locale` SET `Name` = 'Ingeniero Fallel Mirada Estelar' WHERE `locale` = 'esES' AND `entry` = 24995;
-- OLD name : Caminallamas abismal
-- Source : https://www.wowhead.com/wotlk/es/npc=25001
UPDATE `creature_template_locale` SET `Name` = 'Caminallamas abisal' WHERE `locale` = 'esES' AND `entry` = 25001;
-- OLD name : Mercader Felegunne
-- Source : https://www.wowhead.com/wotlk/es/npc=25019
UPDATE `creature_template_locale` SET `Name` = 'Ingeniero Felegunne' WHERE `locale` = 'esES' AND `entry` = 25019;
-- OLD name : Hechicero eredar (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=25033
UPDATE `creature_template_locale` SET `Name` = 'Hechicero Eredar' WHERE `locale` = 'esES' AND `entry` = 25033;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=25099
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 25099;
-- OLD name : [PH] Bri's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25139
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25139;
-- OLD name : Draco abismal de Ruul
-- Source : https://www.wowhead.com/wotlk/es/npc=25193
UPDATE `creature_template_locale` SET `Name` = 'Draco abisal de Ruul' WHERE `locale` = 'esES' AND `entry` = 25193;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/es/npc=25195
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de munición especial' WHERE `locale` = 'esES' AND `entry` = 25195;
-- OLD subname : Specialty Ammunition Vendor
-- Source : https://www.wowhead.com/wotlk/es/npc=25196
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de munición especial' WHERE `locale` = 'esES' AND `entry` = 25196;
-- OLD name : [PH] Torch Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25218
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25218;
-- OLD name : Reptador de la cripta
-- Source : https://www.wowhead.com/wotlk/es/npc=25227
UPDATE `creature_template_locale` SET `Name` = 'Reptador de cripta' WHERE `locale` = 'esES' AND `entry` = 25227;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=25277
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro ingeniero' WHERE `locale` = 'esES' AND `entry` = 25277;
-- OLD name : Prisionera Arcana
-- Source : https://www.wowhead.com/wotlk/es/npc=25320
UPDATE `creature_template_locale` SET `Name` = 'Prisionero Arcano' WHERE `locale` = 'esES' AND `entry` = 25320;
-- OLD name : Craig Steele, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/es/npc=25323
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25323;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25323, 'esES','Craig Aceral','Ingeniero de software');
-- OLD name : Guía del Anillo de la Tierra
-- Source : https://www.wowhead.com/wotlk/es/npc=25324
UPDATE `creature_template_locale` SET `Name` = 'Guía Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 25324;
-- OLD name : Garganta el Moledor de Cadáveres
-- Source : https://www.wowhead.com/wotlk/es/npc=25329
UPDATE `creature_template_locale` SET `Name` = 'Annihilator Grek''lor' WHERE `locale` = 'esES' AND `entry` = 25329;
-- OLD subname : El Anillo de la Tierra
-- Source : https://www.wowhead.com/wotlk/es/npc=25344
UPDATE `creature_template_locale` SET `Title` = 'Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 25344;
-- OLD subname : El Anillo de la Tierra
-- Source : https://www.wowhead.com/wotlk/es/npc=25345
UPDATE `creature_template_locale` SET `Title` = 'Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 25345;
-- OLD subname : El Anillo de la Tierra
-- Source : https://www.wowhead.com/wotlk/es/npc=25360
UPDATE `creature_template_locale` SET `Title` = 'Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 25360;
-- OLD name : Draco guardián rojo
-- Source : https://www.wowhead.com/wotlk/es/npc=25364
UPDATE `creature_template_locale` SET `Name` = 'Draco rojo guardián' WHERE `locale` = 'esES' AND `entry` = 25364;
-- OLD name : Craig Steele2, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/es/npc=25406
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25406;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25406, 'esES','Craig Aceral2','Ingeniero de software');
-- OLD name : Craig Steele3, subname : Software Engineer
-- Source : https://www.wowhead.com/wotlk/es/npc=25411
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25411;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25411, 'esES','Craig Aceral3','Ingeniero de software');
-- OLD name : Espíritu del clarividente Caminante Siniestro
-- Source : https://www.wowhead.com/wotlk/es/npc=25425
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de clarividente Caminante Siniestro' WHERE `locale` = 'esES' AND `entry` = 25425;
-- OLD name : [DNT] Torch Tossing Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25535;
-- OLD name : [DNT] Torch Tossing Target Bunny Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25536;
-- OLD name : Craig's Test Human A
-- Source : https://www.wowhead.com/wotlk/es/npc=25537
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25537;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (25537, 'esES','Craig''s Test Human',NULL);
-- OLD name : Red Drake (Speed Mount)
-- Source : https://www.wowhead.com/wotlk/es/npc=25695
UPDATE `creature_template_locale` SET `Name` = 'Draco rojo' WHERE `locale` = 'esES' AND `entry` = 25695;
-- OLD name : Agostizo abrasador
-- Source : https://www.wowhead.com/wotlk/es/npc=25706
UPDATE `creature_template_locale` SET `Name` = 'Agostizo' WHERE `locale` = 'esES' AND `entry` = 25706;
-- OLD name : Ancestro vinculado a la magia
-- Source : https://www.wowhead.com/wotlk/es/npc=25707
UPDATE `creature_template_locale` SET `Name` = 'Ancestro vinculado a magia' WHERE `locale` = 'esES' AND `entry` = 25707;
-- OLD name : [ph] Coldarra Blue Dragon Patroller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25723
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25723;
-- OLD name : [PH] Ahune Summon Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25745
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25745;
-- OLD name : [PH] Ahune Loot Loc Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=25746
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 25746;
-- OLD name : Ahunita Viento Helado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=25757
UPDATE `creature_template_locale` SET `Name` = 'Ahunita viento helado' WHERE `locale` = 'esES' AND `entry` = 25757;
-- OLD name : Cazadora de magnatauros debilitada, subname : Compañera de Gammothra (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=25788
UPDATE `creature_template_locale` SET `Name` = 'Magnatauro cazador debilitado',`Title` = 'Compañero de Gammothra' WHERE `locale` = 'esES' AND `entry` = 25788;
-- OLD name : Jurafuegos Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=25863
UPDATE `creature_template_locale` SET `Name` = 'Jurafuego Crepuscular' WHERE `locale` = 'esES' AND `entry` = 25863;
-- OLD name : Destripador guardia vil
-- Source : https://www.wowhead.com/wotlk/es/npc=25864
UPDATE `creature_template_locale` SET `Name` = 'Destripador guarda vil' WHERE `locale` = 'esES' AND `entry` = 25864;
-- OLD name : Midsummer Celebrant Costume: Blood Elf
-- Source : https://www.wowhead.com/wotlk/es/npc=25868
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Elfo de sangre' WHERE `locale` = 'esES' AND `entry` = 25868;
-- OLD name : Midsummer Celebrant Costume: Draenei
-- Source : https://www.wowhead.com/wotlk/es/npc=25869
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Draenei' WHERE `locale` = 'esES' AND `entry` = 25869;
-- OLD name : Midsummer Celebrant Costume: Dwarf
-- Source : https://www.wowhead.com/wotlk/es/npc=25870
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Enano' WHERE `locale` = 'esES' AND `entry` = 25870;
-- OLD name : Midsummer Celebrant Costume: Gnome
-- Source : https://www.wowhead.com/wotlk/es/npc=25871
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Gnomo' WHERE `locale` = 'esES' AND `entry` = 25871;
-- OLD name : Midsummer Celebrant Costume: Goblin
-- Source : https://www.wowhead.com/wotlk/es/npc=25872
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Goblin' WHERE `locale` = 'esES' AND `entry` = 25872;
-- OLD name : Midsummer Celebrant Costume: Human
-- Source : https://www.wowhead.com/wotlk/es/npc=25873
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Humano' WHERE `locale` = 'esES' AND `entry` = 25873;
-- OLD name : Midsummer Celebrant Costume: Night Elf
-- Source : https://www.wowhead.com/wotlk/es/npc=25874
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Elfo de la noche' WHERE `locale` = 'esES' AND `entry` = 25874;
-- OLD name : Midsummer Celebrant Costume: Orc
-- Source : https://www.wowhead.com/wotlk/es/npc=25875
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Orco' WHERE `locale` = 'esES' AND `entry` = 25875;
-- OLD name : Midsummer Celebrant Costume: Tauren
-- Source : https://www.wowhead.com/wotlk/es/npc=25876
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Tauren' WHERE `locale` = 'esES' AND `entry` = 25876;
-- OLD name : Midsummer Celebrant Costume: Troll
-- Source : https://www.wowhead.com/wotlk/es/npc=25877
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: Trol' WHERE `locale` = 'esES' AND `entry` = 25877;
-- OLD name : Midsummer Celebrant Costume: Undead
-- Source : https://www.wowhead.com/wotlk/es/npc=25878
UPDATE `creature_template_locale` SET `Name` = 'Disfraz de celebrador del Solsticio de Verano: No-muerto' WHERE `locale` = 'esES' AND `entry` = 25878;
-- OLD name : Rata del día del Juicio Final
-- Source : https://www.wowhead.com/wotlk/es/npc=25886
UPDATE `creature_template_locale` SET `Name` = 'Rata del juicio final' WHERE `locale` = 'esES' AND `entry` = 25886;
-- OLD name : Celadora de las llamas del Bosque de Elwynn
-- Source : https://www.wowhead.com/wotlk/es/npc=25898
UPDATE `creature_template_locale` SET `Name` = 'Celadora de las llamas de Bosque de Elwynn' WHERE `locale` = 'esES' AND `entry` = 25898;
-- OLD name : Celador de las llamas de los Páramos de Poniente
-- Source : https://www.wowhead.com/wotlk/es/npc=25910
UPDATE `creature_template_locale` SET `Name` = 'Celador de las llamas de Páramos de Poniente' WHERE `locale` = 'esES' AND `entry` = 25910;
-- OLD name : Celador de las llamas de El Cabo de Tuercespina
-- Source : https://www.wowhead.com/wotlk/es/npc=25915
UPDATE `creature_template_locale` SET `Name` = 'Celador de las llamas de Vega de Tuercespina' WHERE `locale` = 'esES' AND `entry` = 25915;
-- OLD name : Vigilante de las llamas de El Cabo de Tuercespina
-- Source : https://www.wowhead.com/wotlk/es/npc=25920
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de las llamas de Vega de Tuercespina' WHERE `locale` = 'esES' AND `entry` = 25920;
-- OLD name : Vigilante de las llamas de Los Baldíos del Norte
-- Source : https://www.wowhead.com/wotlk/es/npc=25943
UPDATE `creature_template_locale` SET `Name` = 'Vigilante de las llamas de Los Baldíos' WHERE `locale` = 'esES' AND `entry` = 25943;
-- OLD subname : Transmutadora de reliquias sin'dorei (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=25977
UPDATE `creature_template_locale` SET `Title` = 'Transmutadora de reliquias Sin''dorei' WHERE `locale` = 'esES' AND `entry` = 25977;
-- OLD name : Ave de rapiña domesticable
-- Source : https://www.wowhead.com/wotlk/es/npc=26028
UPDATE `creature_template_locale` SET `Name` = 'Búho domesticable' WHERE `locale` = 'esES' AND `entry` = 26028;
-- OLD name : Acechador de distorsión domesticable
-- Source : https://www.wowhead.com/wotlk/es/npc=26037
UPDATE `creature_template_locale` SET `Name` = 'Acechador de distorsión' WHERE `locale` = 'esES' AND `entry` = 26037;
-- OLD name : Tempestad tormentosa
-- Source : https://www.wowhead.com/wotlk/es/npc=26045
UPDATE `creature_template_locale` SET `Name` = 'Tempestad de tormenta' WHERE `locale` = 'esES' AND `entry` = 26045;
-- OLD name : Craig's Test Human B (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26080
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26080;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26080, 'esES','PNJs',NULL);
-- OLD name : Proveedora del Solsticio de Verano
-- Source : https://www.wowhead.com/wotlk/es/npc=26123
UPDATE `creature_template_locale` SET `Name` = 'Proveedor del solsticio de verano' WHERE `locale` = 'esES' AND `entry` = 26123;
-- OLD name : Mercader del Solsticio de Verano (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=26124
UPDATE `creature_template_locale` SET `Name` = 'Mercader del solsticio de verano' WHERE `locale` = 'esES' AND `entry` = 26124;
-- OLD name : Guerrero osario
-- Source : https://www.wowhead.com/wotlk/es/npc=26126
UPDATE `creature_template_locale` SET `Name` = 'Guerrero óseo' WHERE `locale` = 'esES' AND `entry` = 26126;
-- OLD name : Cohete abisal X-51 X-TREMO
-- Source : https://www.wowhead.com/wotlk/es/npc=26164
UPDATE `creature_template_locale` SET `Name` = 'Montura cohete, roja' WHERE `locale` = 'esES' AND `entry` = 26164;
-- OLD name : [PH] Tom Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26176
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26176;
-- OLD name : [PH] Torch Catching Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26188
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26188;
-- OLD name : [PH] Spank Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26190
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26190;
-- OLD name : Cohete abisal X-51
-- Source : https://www.wowhead.com/wotlk/es/npc=26192
UPDATE `creature_template_locale` SET `Name` = 'Montura cohete, azul' WHERE `locale` = 'esES' AND `entry` = 26192;
-- OLD name : Templario glacial (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=26216
UPDATE `creature_template_locale` SET `Name` = 'Templario Glacial' WHERE `locale` = 'esES' AND `entry` = 26216;
-- OLD name : Filoescarcha Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=26223
UPDATE `creature_template_locale` SET `Name` = 'Filohelado Crepuscular' WHERE `locale` = 'esES' AND `entry` = 26223;
-- OLD name : [PH] Ghost of Ahune (Disguise) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26241
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26241;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - A (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26258
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26258;
-- OLD name : [PH] Dragonblight Ancient (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26274
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26274;
-- OLD name : [PH] Dragonblight Black Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26275
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26275;
-- OLD name : [PH] Dragonblight Green Dragon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26278
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26278;
-- OLD name : [PH] Dragonblight Elemental Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26285
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26285;
-- OLD name : Forgotten Shore Event Trigger
-- Source : https://www.wowhead.com/wotlk/es/npc=26288
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 26288;
-- OLD name : [PH] Dragonblight Scourge Carrion Fields (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26292;
-- OLD name : [PH] Dragonblight Magma Wyrm (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26294
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26294;
-- OLD name : [PH] Dragonblight Scarlet Onslaught (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26296
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26296;
-- OLD name : Vendedora de armaduras de placas
-- Source : https://www.wowhead.com/wotlk/es/npc=26305
UPDATE `creature_template_locale` SET `Name` = 'Vendedora de armaduras de piel' WHERE `locale` = 'esES' AND `entry` = 26305;
-- OLD name : Vendedora de armaduras de cuero
-- Source : https://www.wowhead.com/wotlk/es/npc=26306
UPDATE `creature_template_locale` SET `Name` = 'Vendedor de armaduras de malla' WHERE `locale` = 'esES' AND `entry` = 26306;
-- OLD name : Vendedor de armaduras de malla
-- Source : https://www.wowhead.com/wotlk/es/npc=26308
UPDATE `creature_template_locale` SET `Name` = 'Vendedora de armaduras de placas' WHERE `locale` = 'esES' AND `entry` = 26308;
-- OLD name : [PH] Dragonblight taunka (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26311
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26311;
-- OLD name : [PH] Dragonblight taunka Spirit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26312
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26312;
-- OLD name : [PH] Dragonblight Treant (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26313
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26313;
-- OLD name : [PH] Dragonblight Scourge Galakrond Rest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26317
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26317;
-- OLD name : [PH] Dragonblight Scourge Obsidian Dragonshire (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26318
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26318;
-- OLD name : [PH] Dragonblight Scourge Ruby Dragonshrine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26320
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26320;
-- OLD name : Instructora de magos
-- Source : https://www.wowhead.com/wotlk/es/npc=26326
UPDATE `creature_template_locale` SET `Name` = 'Instructor de magos' WHERE `locale` = 'esES' AND `entry` = 26326;
-- OLD name : [DND] Midsummer Bonfire Faction Bunny - H (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26355;
-- OLD name : Venado Cornalta
-- Source : https://www.wowhead.com/wotlk/es/npc=26363
UPDATE `creature_template_locale` SET `Name` = 'Venado Cornaalta' WHERE `locale` = 'esES' AND `entry` = 26363;
-- OLD name : Test - Brutallus Craig (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26376
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26376;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26376, 'esES','PNJs',NULL);
-- OLD name : Evee Muellecobre, subname : Vendedora de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=26378
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 26378;
-- OLD name : Grikkin Muellecobre, subname : Vendedor de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=26383
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 26383;
-- OLD name : Frixee Cabriolatón, subname : Vendedora de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=26384
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 26384;
-- OLD name : [PH] Ice Chest Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26391
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26391;
-- OLD name : Capitán Martillo de Endecha
-- Source : https://www.wowhead.com/wotlk/es/npc=26393
UPDATE `creature_template_locale` SET `Name` = 'Capitán Martillo Temible' WHERE `locale` = 'esES' AND `entry` = 26393;
-- OLD name : Rumiante Pezuña Larga
-- Source : https://www.wowhead.com/wotlk/es/npc=26418
UPDATE `creature_template_locale` SET `Name` = 'Pastador Pezuña Larga' WHERE `locale` = 'esES' AND `entry` = 26418;
-- OLD subname : Jugador (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26442
UPDATE `creature_template_locale` SET `Title` = 'Apostador' WHERE `locale` = 'esES' AND `entry` = 26442;
-- OLD name : Rajamuertos de la Plaga
-- Source : https://www.wowhead.com/wotlk/es/npc=26461
UPDATE `creature_template_locale` SET `Name` = 'Desgarrador de cadáveres de la Plaga' WHERE `locale` = 'esES' AND `entry` = 26461;
-- OLD name : [PH] Dragonblight Carrion Field Necromancer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26489
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26489;
-- OLD name : [PH] Dragonblight Carrion Field Zombie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26490
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26490;
-- OLD name : [PH] Dragonblight Carrion Field Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26491
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26491;
-- OLD name : Clamañublo Renegado (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26508
UPDATE `creature_template_locale` SET `Name` = 'Clamañublo renegado' WHERE `locale` = 'esES' AND `entry` = 26508;
-- OLD name : Sujeto de prueba lúcido
-- Source : https://www.wowhead.com/wotlk/es/npc=26509
UPDATE `creature_template_locale` SET `Name` = 'Sujeto de prueba lúcida' WHERE `locale` = 'esES' AND `entry` = 26509;
-- OLD name : Trillafondos Moa'ki
-- Source : https://www.wowhead.com/wotlk/es/npc=26511
UPDATE `creature_template_locale` SET `Name` = 'Trillador de fondo Moa''ki' WHERE `locale` = 'esES' AND `entry` = 26511;
-- OLD name : Curiana
-- Source : https://www.wowhead.com/wotlk/es/npc=26525
UPDATE `creature_template_locale` SET `Name` = 'Cucaracha' WHERE `locale` = 'esES' AND `entry` = 26525;
-- OLD name : [Demo] Craig Amai (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26535
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26535;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26564
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 26564;
-- OLD name : Rapiñadora Viento Helado
-- Source : https://www.wowhead.com/wotlk/es/npc=26575
UPDATE `creature_template_locale` SET `Name` = 'Cazadora de baldío de Viento Helado' WHERE `locale` = 'esES' AND `entry` = 26575;
-- OLD name : [PH] Justin's Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26576
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26576;
-- OLD name : Transformación de Percepción espiritual (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26594
UPDATE `creature_template_locale` SET `Name` = 'Percepción espiritual' WHERE `locale` = 'esES' AND `entry` = 26594;
-- OLD name : Mack Fearsen
-- Source : https://www.wowhead.com/wotlk/es/npc=26604
UPDATE `creature_template_locale` SET `Name` = 'Mack Miedosen' WHERE `locale` = 'esES' AND `entry` = 26604;
-- OLD name : [PH] Named Condor Shirrak (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26665
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26665;
-- OLD name : Rabid Dire Bear *Unused* (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=26671
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26671;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (26671, 'esES','PNJs',NULL);
-- OLD name : Lobo de tundra sanguinario
-- Source : https://www.wowhead.com/wotlk/es/npc=26672
UPDATE `creature_template_locale` SET `Name` = 'Lobo de tundra sediento de sangre' WHERE `locale` = 'esES' AND `entry` = 26672;
-- OLD name : Espía de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=26719
UPDATE `creature_template_locale` SET `Name` = 'Espía de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 26719;
-- OLD name : [DND] TAR Pedestal - Armor, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26724
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26724;
-- OLD name : [dnd] Fizzcrank Paratrooper Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26732
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26732;
-- OLD name : [DND] TAR Pedestal - Accessories (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26738
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26738;
-- OLD name : [DND] TAR Pedestal - Enchantments (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26739
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26739;
-- OLD name : [DND] TAR Pedestal - Gems (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26740
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26740;
-- OLD name : [DND] TAR Pedestal - General Goods (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26741
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26741;
-- OLD name : [DND] TAR Pedestal - Armor, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26742
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26742;
-- OLD name : [DND] TAR Pedestal - Glyph, Cloth & Leather (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26743
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26743;
-- OLD name : [DND] TAR Pedestal - Glyph, Mail & Plate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26744
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26744;
-- OLD name : [DND] TAR Pedestal - Weapons (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26745
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26745;
-- OLD name : [DND] TAR Pedestal - Arena Organizer (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26747
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26747;
-- OLD name : [DND] TAR Pedestal - Beastmaster (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26748
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26748;
-- OLD name : [DND] TAR Pedestal - Paymaster (-> Monk) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26749
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26749;
-- OLD name : [DND] TAR Pedestal - Teleporter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26750
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26750;
-- OLD name : [DND] TAR Pedestal - Trainer, Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26751
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26751;
-- OLD name : [DND] TAR Pedestal - Trainer, Hunter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26752
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26752;
-- OLD name : [DND] TAR Pedestal - Trainer, Mage (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26753
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26753;
-- OLD name : [DND] TAR Pedestal - Trainer, Paladin (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26754
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26754;
-- OLD name : [DND] TAR Pedestal - Trainer, Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26755
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26755;
-- OLD name : [DND] TAR Pedestal - Trainer, Rogue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26756
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26756;
-- OLD name : [DND] TAR Pedestal - Trainer, Shaman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26757
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26757;
-- OLD name : [DND] TAR Pedestal - Trainer, Warlock (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26758
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26758;
-- OLD name : [DND] TAR Pedestal - Trainer, Warrior (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26759
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26759;
-- OLD name : [DND] TAR Pedestal - Fight Promoter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26765
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26765;
-- OLD name : Sinok el Sombracundo
-- Source : https://www.wowhead.com/wotlk/es/npc=26771
UPDATE `creature_template_locale` SET `Name` = 'Sinok el Furibundo de las Sombras' WHERE `locale` = 'esES' AND `entry` = 26771;
-- OLD name : Rasgador cristalino
-- Source : https://www.wowhead.com/wotlk/es/npc=26793
UPDATE `creature_template_locale` SET `Name` = 'Rasgar cristalino' WHERE `locale` = 'esES' AND `entry` = 26793;
-- OLD name : Dragón guardián
-- Source : https://www.wowhead.com/wotlk/es/npc=26806
UPDATE `creature_template_locale` SET `Name` = 'Guardián serpiente' WHERE `locale` = 'esES' AND `entry` = 26806;
-- OLD name : Cabecilla wolvar aullador (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=26826
UPDATE `creature_template_locale` SET `Name` = 'Cabecilla wolvar Aullador' WHERE `locale` = 'esES' AND `entry` = 26826;
-- OLD name : [PH] Dragonblight Shoveltusk Scavenger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26835
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26835;
-- OLD name : [PH] Dragonblight Named Frost Wyrm Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=26840
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 26840;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=26901
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 26901;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=26903
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 26903;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26904
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herrería' WHERE `locale` = 'esES' AND `entry` = 26904;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=26905
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de cocina' WHERE `locale` = 'esES' AND `entry` = 26905;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=26906
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de encantamiento' WHERE `locale` = 'esES' AND `entry` = 26906;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=26907
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 26907;
-- OLD subname : Instructor de pesca
-- Source : https://www.wowhead.com/wotlk/es/npc=26909
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de pesca' WHERE `locale` = 'esES' AND `entry` = 26909;
-- OLD subname : Instructor de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=26910
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herboristería' WHERE `locale` = 'esES' AND `entry` = 26910;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=26911
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de peletería' WHERE `locale` = 'esES' AND `entry` = 26911;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=26912
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 26912;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=26913
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 26913;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26914
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esES' AND `entry` = 26914;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=26915
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 26915;
-- OLD subname : Instructora de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=26916
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de inscripción' WHERE `locale` = 'esES' AND `entry` = 26916;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=26951
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de alquimia' WHERE `locale` = 'esES' AND `entry` = 26951;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26952
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herrería' WHERE `locale` = 'esES' AND `entry` = 26952;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=26954
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 26954;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=26955
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 26955;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=26956
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 26956;
-- OLD subname : Instructora de pesca
-- Source : https://www.wowhead.com/wotlk/es/npc=26957
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de pesca' WHERE `locale` = 'esES' AND `entry` = 26957;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=26958
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 26958;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=26959
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 26959;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=26960
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 26960;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=26961
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 26961;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=26962
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 26962;
-- OLD subname : Instructora de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=26963
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de desuello' WHERE `locale` = 'esES' AND `entry` = 26963;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26964
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de sastrería' WHERE `locale` = 'esES' AND `entry` = 26964;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26969
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de sastrería' WHERE `locale` = 'esES' AND `entry` = 26969;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=26972
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de cocina' WHERE `locale` = 'esES' AND `entry` = 26972;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=26974
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 26974;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=26975
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 26975;
-- OLD subname : Instructora de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=26976
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de minería' WHERE `locale` = 'esES' AND `entry` = 26976;
-- OLD subname : Instructora de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=26977
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de inscripción' WHERE `locale` = 'esES' AND `entry` = 26977;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=26980
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 26980;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26981
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 26981;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=26982
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 26982;
-- OLD subname : Instructora de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=26986
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de desuello' WHERE `locale` = 'esES' AND `entry` = 26986;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=26987
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 26987;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=26988
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 26988;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=26989
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de cocina' WHERE `locale` = 'esES' AND `entry` = 26989;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=26990
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de encantamiento' WHERE `locale` = 'esES' AND `entry` = 26990;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=26991
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 26991;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=26992
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 26992;
-- OLD subname : Instructor de pesca
-- Source : https://www.wowhead.com/wotlk/es/npc=26993
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de pesca' WHERE `locale` = 'esES' AND `entry` = 26993;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=26994
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 26994;
-- OLD subname : Instructora de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=26995
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de inscripción' WHERE `locale` = 'esES' AND `entry` = 26995;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=26996
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro peletero' WHERE `locale` = 'esES' AND `entry` = 26996;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=26997
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 26997;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=26998
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de peletería' WHERE `locale` = 'esES' AND `entry` = 26998;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=26999
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 26999;
-- OLD subname : Instructora de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=27000
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 27000;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=27001
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esES' AND `entry` = 27001;
-- OLD name : Gólem de guerra mermado
-- Source : https://www.wowhead.com/wotlk/es/npc=27017
UPDATE `creature_template_locale` SET `Name` = 'Gólem de guerra agotado' WHERE `locale` = 'esES' AND `entry` = 27017;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=27023
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de alquimia' WHERE `locale` = 'esES' AND `entry` = 27023;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=27029
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 27029;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=27034
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 27034;
-- OLD name : Montura de El Jinete decapitado
-- Source : https://www.wowhead.com/wotlk/es/npc=27152
UPDATE `creature_template_locale` SET `Name` = 'Headless Horseman Mount, Player' WHERE `locale` = 'esES' AND `entry` = 27152;
-- OLD name : Montura de El Jinete decapitado
-- Source : https://www.wowhead.com/wotlk/es/npc=27153
UPDATE `creature_template_locale` SET `Name` = 'Montura del Jinete decapitado' WHERE `locale` = 'esES' AND `entry` = 27153;
-- OLD name : [PH] New Hearthglen Scarlet Footman (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27205
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27205;
-- OLD name : [PH] New Hearthglen Scarlet Commander (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27208
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27208;
-- OLD name : Torturador LeCraft
-- Source : https://www.wowhead.com/wotlk/es/npc=27209
UPDATE `creature_template_locale` SET `Name` = 'Torturador Alphonse' WHERE `locale` = 'esES' AND `entry` = 27209;
-- OLD name : [PH] New Hearthglen Scarlet Scout (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27218
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27218;
-- OLD subname : Calidad garantizada (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=27231
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 27231;
-- OLD name : Alystros el Guardaverde
-- Source : https://www.wowhead.com/wotlk/es/npc=27249
UPDATE `creature_template_locale` SET `Name` = 'Alystros el vigilante verdeante' WHERE `locale` = 'esES' AND `entry` = 27249;
-- OLD name : Invasor Terroespina
-- Source : https://www.wowhead.com/wotlk/es/npc=27286
UPDATE `creature_template_locale` SET `Name` = 'Invasor Huesobravo' WHERE `locale` = 'esES' AND `entry` = 27286;
-- OLD name : Cánido del Embate
-- Source : https://www.wowhead.com/wotlk/es/npc=27329
UPDATE `creature_template_locale` SET `Name` = 'Can de sangre del Embate' WHERE `locale` = 'esES' AND `entry` = 27329;
-- OLD name : Adeline Chambers
-- Source : https://www.wowhead.com/wotlk/es/npc=27344
UPDATE `creature_template_locale` SET `Name` = 'Cuidadora de murciélagos Adeline' WHERE `locale` = 'esES' AND `entry` = 27344;
-- OLD name : Esencia de competición
-- Source : https://www.wowhead.com/wotlk/es/npc=27346
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de competición' WHERE `locale` = 'esES' AND `entry` = 27346;
-- OLD name : [DND] Stabled Pet Appearance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27368
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27368;
-- OLD name : Escribano jefe Barriga
-- Source : https://www.wowhead.com/wotlk/es/npc=27378
UPDATE `creature_template_locale` SET `Name` = 'Escribano jefe Kinnedius' WHERE `locale` = 'esES' AND `entry` = 27378;
-- OLD name : Wintergarde Inner Gate Attack Trigger
-- Source : https://www.wowhead.com/wotlk/es/npc=27380
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 27380;
-- OLD name : Thel'zan el Portador del Ocaso
-- Source : https://www.wowhead.com/wotlk/es/npc=27384
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 27384;
-- OLD name : [DND] Valiance Keep Footman Spectator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27387
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27387;
-- OLD name : Utgarde Duo Trigger
-- Source : https://www.wowhead.com/wotlk/es/npc=27404
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 27404;
-- OLD name : Palomilla helechil
-- Source : https://www.wowhead.com/wotlk/es/npc=27421
UPDATE `creature_template_locale` SET `Name` = 'Palomilla come helechos' WHERE `locale` = 'esES' AND `entry` = 27421;
-- OLD name : Clayton Dubin - TEST COPY DATA (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=27527
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27527;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (27527, 'esES','PNJs',NULL);
-- OLD name : Lord Afrasastrasz
-- Source : https://www.wowhead.com/wotlk/es/npc=27575
UPDATE `creature_template_locale` SET `Name` = 'Lord Devrestrasz' WHERE `locale` = 'esES' AND `entry` = 27575;
-- OLD name : Señor de la magia Urom (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=27655
UPDATE `creature_template_locale` SET `Name` = 'Señor de la Magia Urom' WHERE `locale` = 'esES' AND `entry` = 27655;
-- OLD name : Kodo de montar de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=27706
UPDATE `creature_template_locale` SET `Name` = 'Kodo de montar de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 27706;
-- OLD name : Gran kodo de la Fiesta de la Cerveza (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=27707
UPDATE `creature_template_locale` SET `Name` = 'Gran kodo de la Fiesta de la cerveza' WHERE `locale` = 'esES' AND `entry` = 27707;
-- OLD name : [DND] Aldor Mailbox Malfunction Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27723
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27723;
-- OLD name : Agente infinito (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=27744
UPDATE `creature_template_locale` SET `Name` = 'Agente Infinito' WHERE `locale` = 'esES' AND `entry` = 27744;
-- OLD name : Imagen de Lady Blaumeux (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=27771
UPDATE `creature_template_locale` SET `Name` = 'Imagen de lady Blaumeux' WHERE `locale` = 'esES' AND `entry` = 27771;
-- OLD name : Ensamblaje Terroespina
-- Source : https://www.wowhead.com/wotlk/es/npc=27835
UPDATE `creature_template_locale` SET `Name` = 'Ensamblaje Huesobravo' WHERE `locale` = 'esES' AND `entry` = 27835;
-- OLD name : Boticario auxiliar Lawrence
-- Source : https://www.wowhead.com/wotlk/es/npc=27846
UPDATE `creature_template_locale` SET `Name` = 'Boticario principiante Lawrence' WHERE `locale` = 'esES' AND `entry` = 27846;
-- OLD name : Patty's test vehicle (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=27862
UPDATE `creature_template_locale` SET `Name` = 'PattyMack''s test vehicle TEST' WHERE `locale` = 'esES' AND `entry` = 27862;
-- OLD subname : Gran almirante de la Flota Escarlata (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=27951
UPDATE `creature_template_locale` SET `Title` = 'Gran Almirante de la Flota Escarlata' WHERE `locale` = 'esES' AND `entry` = 27951;
-- OLD name : [PH] Warp Stalker Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=27976
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 27976;
-- OLD name : Teniente Martillo de Hielo
-- Source : https://www.wowhead.com/wotlk/es/npc=27994
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 27994;
-- OLD name : Roc Alasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=28004
UPDATE `creature_template_locale` SET `Name` = 'Roc Garragore' WHERE `locale` = 'esES' AND `entry` = 28004;
-- OLD name : Mozo de armas Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=28028
UPDATE `creature_template_locale` SET `Name` = 'Escudero Argenta' WHERE `locale` = 'esES' AND `entry` = 28028;
-- OLD name : El Espíritu de Gnomeregan (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=28037
UPDATE `creature_template_locale` SET `Name` = 'El espíritu de Gnomeregan' WHERE `locale` = 'esES' AND `entry` = 28037;
-- OLD name : Capitana aterradora DeMeza
-- Source : https://www.wowhead.com/wotlk/es/npc=28048
UPDATE `creature_template_locale` SET `Name` = 'Aterradora capitana DeMeza' WHERE `locale` = 'esES' AND `entry` = 28048;
-- OLD name : Capitán Guantazo
-- Source : https://www.wowhead.com/wotlk/es/npc=28051
UPDATE `creature_template_locale` SET `Name` = 'Tapar''y Tirar' WHERE `locale` = 'esES' AND `entry` = 28051;
-- OLD name : Rumiante Cuellolargo
-- Source : https://www.wowhead.com/wotlk/es/npc=28129
UPDATE `creature_template_locale` SET `Name` = 'Raspa Cuellolargo' WHERE `locale` = 'esES' AND `entry` = 28129;
-- OLD name : [ph] exploding barrel (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28173
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28173;
-- OLD name : [ph] Goblin Construction Crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28180
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28180;
-- OLD name : [DND] under water construction crew (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28184
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28184;
-- OLD name : [DND] L70ETC Drums (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28206
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28206;
-- OLD name : Cabalgador Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=28264
UPDATE `creature_template_locale` SET `Name` = 'Jinete Argenta' WHERE `locale` = 'esES' AND `entry` = 28264;
-- OLD name : [DND] taxi flavor eagle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28292
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28292;
-- OLD subname : Banquera
-- Source : https://www.wowhead.com/wotlk/es/npc=28343
UPDATE `creature_template_locale` SET `Title` = 'Banquero' WHERE `locale` = 'esES' AND `entry` = 28343;
-- OLD name : Dentelladas
-- Source : https://www.wowhead.com/wotlk/es/npc=28346
UPDATE `creature_template_locale` SET `Name` = 'Crujiente' WHERE `locale` = 'esES' AND `entry` = 28346;
-- OLD name : Maestro de linaje Hath'ar
-- Source : https://www.wowhead.com/wotlk/es/npc=28412
UPDATE `creature_template_locale` SET `Name` = 'Mentor del linaje Hath''ar' WHERE `locale` = 'esES' AND `entry` = 28412;
-- OLD name : [UNUSED]Altar of Quetz'lun Gateway - Real World (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28469
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28469;
-- OLD name : Ronakada (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=28501
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28501;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (28501, 'esES','PNJs',NULL);
-- OLD name : Válvula vaporosa
-- Source : https://www.wowhead.com/wotlk/es/npc=28539
UPDATE `creature_template_locale` SET `Name` = 'Válvula de vapor' WHERE `locale` = 'esES' AND `entry` = 28539;
-- OLD name : Vórtice tormentoso
-- Source : https://www.wowhead.com/wotlk/es/npc=28547
UPDATE `creature_template_locale` SET `Name` = 'Vórtice en tormenta' WHERE `locale` = 'esES' AND `entry` = 28547;
-- OLD name : Torturador LeCraft
-- Source : https://www.wowhead.com/wotlk/es/npc=28554
UPDATE `creature_template_locale` SET `Name` = 'Torturador Alphonse' WHERE `locale` = 'esES' AND `entry` = 28554;
-- OLD name : Chorro de agua
-- Source : https://www.wowhead.com/wotlk/es/npc=28567
UPDATE `creature_template_locale` SET `Name` = 'Cañería de agua' WHERE `locale` = 'esES' AND `entry` = 28567;
-- OLD name : Tormenta de Fuego desatada (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=28584
UPDATE `creature_template_locale` SET `Name` = 'Tormenta de fuego desatada' WHERE `locale` = 'esES' AND `entry` = 28584;
-- OLD name : Acólito Manomuerte
-- Source : https://www.wowhead.com/wotlk/es/npc=28602
UPDATE `creature_template_locale` SET `Name` = 'Acólito de Mano de la Muerte' WHERE `locale` = 'esES' AND `entry` = 28602;
-- OLD name : Cíngara misteriosa (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=28652
UPDATE `creature_template_locale` SET `Name` = 'Trotamundos misteriosa' WHERE `locale` = 'esES' AND `entry` = 28652;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=28693
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 28693;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=28694
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 28694;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=28696
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 28696;
-- OLD subname : Instructor de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=28697
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de ingeniería' WHERE `locale` = 'esES' AND `entry` = 28697;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=28698
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 28698;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=28699
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esES' AND `entry` = 28699;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=28700
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de peletería' WHERE `locale` = 'esES' AND `entry` = 28700;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=28701
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 28701;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=28702
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 28702;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=28703
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de alquimia' WHERE `locale` = 'esES' AND `entry` = 28703;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=28704
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 28704;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=28705
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de cocina' WHERE `locale` = 'esES' AND `entry` = 28705;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=28706
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 28706;
-- OLD subname : Instructora de pesca y suministros
-- Source : https://www.wowhead.com/wotlk/es/npc=28742
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de pesca y suministros' WHERE `locale` = 'esES' AND `entry` = 28742;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=28746
UPDATE `creature_template_locale` SET `Title` = 'Instructor de vuelo en clima frío' WHERE `locale` = 'esES' AND `entry` = 28746;
-- OLD name : Venerador de Quetz'lun
-- Source : https://www.wowhead.com/wotlk/es/npc=28747
UPDATE `creature_template_locale` SET `Name` = 'Beato de Quetz''lun' WHERE `locale` = 'esES' AND `entry` = 28747;
-- OLD name : [Phase 1] Scarlet Crusade Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28763
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28763;
-- OLD name : [Phase 1] Citizen of Havenshire Proxy Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28764
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28764;
-- OLD name : [Phase 1] Havenshrie Horse Credit, Step 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28767
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28767;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=28800
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 28800;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=28813
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 28813;
-- OLD name : Vagón de mina
-- Source : https://www.wowhead.com/wotlk/es/npc=28817
UPDATE `creature_template_locale` SET `Name` = 'Vagoneta' WHERE `locale` = 'esES' AND `entry` = 28817;
-- OLD name : Vagón de mina
-- Source : https://www.wowhead.com/wotlk/es/npc=28821
UPDATE `creature_template_locale` SET `Name` = 'Vagoneta' WHERE `locale` = 'esES' AND `entry` = 28821;
-- OLD name : Avizor del Mirador
-- Source : https://www.wowhead.com/wotlk/es/npc=28840
UPDATE `creature_template_locale` SET `Name` = 'Centinela del Mirador' WHERE `locale` = 'esES' AND `entry` = 28840;
-- OLD name : Tótem avizor cargado
-- Source : https://www.wowhead.com/wotlk/es/npc=28938
UPDATE `creature_template_locale` SET `Name` = 'Tótem centinela cargado' WHERE `locale` = 'esES' AND `entry` = 28938;
-- OLD name : [Chapter II] Scarlet Crusader Test Dummy Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28957
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28957;
-- OLD name : Señor Escarlata Jesseriah McCree
-- Source : https://www.wowhead.com/wotlk/es/npc=28964
UPDATE `creature_template_locale` SET `Name` = 'Señor Escarlata Borugh' WHERE `locale` = 'esES' AND `entry` = 28964;
-- OLD name : [Chapter II] Scarlet Crusader Proxy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=28984
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 28984;
-- OLD subname : Fabricante de arcos
-- Source : https://www.wowhead.com/wotlk/es/npc=29014
UPDATE `creature_template_locale` SET `Title` = 'Flechero' WHERE `locale` = 'esES' AND `entry` = 29014;
-- OLD name : [DND] Dockhand w/Bag (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29020
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29020;
-- OLD name : [609] Ebon Hold Duel Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29025
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29025;
-- OLD name : [Chapter II] Torch Toss Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29038
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29038;
-- OLD name : [UNUSED] [ph] Stormwind Gryphon (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=29039
UPDATE `creature_template_locale` SET `Name` = 'REUSE' WHERE `locale` = 'esES' AND `entry` = 29039;
-- OLD name : Matriarca Alasangre
-- Source : https://www.wowhead.com/wotlk/es/npc=29044
UPDATE `creature_template_locale` SET `Name` = 'Matriarca Garragore' WHERE `locale` = 'esES' AND `entry` = 29044;
-- OLD name : Avizor titán
-- Source : https://www.wowhead.com/wotlk/es/npc=29066
UPDATE `creature_template_locale` SET `Name` = 'Centinela titán' WHERE `locale` = 'esES' AND `entry` = 29066;
-- OLD name : Jelinek Tijeras
-- Source : https://www.wowhead.com/wotlk/es/npc=29142
UPDATE `creature_template_locale` SET `Name` = 'Jalinek Tijeras' WHERE `locale` = 'esES' AND `entry` = 29142;
-- OLD name : Teletransportador a Las Cámaras de Piedra (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=29165
UPDATE `creature_template_locale` SET `Name` = 'Teletransportador a las Cámaras de Piedra' WHERE `locale` = 'esES' AND `entry` = 29165;
-- OLD name : [Chapter IV] Chapter IV Dummy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29192
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29192;
-- OLD subname : Vendedor de componentes
-- Source : https://www.wowhead.com/wotlk/es/npc=29203
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de polvo de cadáver' WHERE `locale` = 'esES' AND `entry` = 29203;
-- OLD name : Guerrero de los Baldíos Helados
-- Source : https://www.wowhead.com/wotlk/es/npc=29206
UPDATE `creature_template_locale` SET `Name` = 'Guerrero de los Páramos Congelados' WHERE `locale` = 'esES' AND `entry` = 29206;
-- OLD subname : Instructora de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=29233
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 29233;
-- OLD name : [Chapter IV] Light of Dawn Credit (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29245
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29245;
-- OLD name : [PH]TEST Skater (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29361;
-- OLD name : Avizor del vacío
-- Source : https://www.wowhead.com/wotlk/es/npc=29364
UPDATE `creature_template_locale` SET `Name` = 'Centinela del vacío' WHERE `locale` = 'esES' AND `entry` = 29364;
-- OLD name : Avizor del vacío
-- Source : https://www.wowhead.com/wotlk/es/npc=29365
UPDATE `creature_template_locale` SET `Name` = 'Centinela del vacío' WHERE `locale` = 'esES' AND `entry` = 29365;
-- OLD name : Venerador Veloneve
-- Source : https://www.wowhead.com/wotlk/es/npc=29407
UPDATE `creature_template_locale` SET `Name` = 'Devoto Veloneve' WHERE `locale` = 'esES' AND `entry` = 29407;
-- OLD name : Grifo osario
-- Source : https://www.wowhead.com/wotlk/es/npc=29414
UPDATE `creature_template_locale` SET `Name` = 'Grifo óseo' WHERE `locale` = 'esES' AND `entry` = 29414;
-- OLD name : Terracundo Toquehielo
-- Source : https://www.wowhead.com/wotlk/es/npc=29436
UPDATE `creature_template_locale` SET `Name` = 'Furibundo de tierra Toquehielo' WHERE `locale` = 'esES' AND `entry` = 29436;
-- OLD name : Reptador Hielopunta
-- Source : https://www.wowhead.com/wotlk/es/npc=29461
UPDATE `creature_template_locale` SET `Name` = 'Reptador de hielopunta' WHERE `locale` = 'esES' AND `entry` = 29461;
-- OLD subname : Specialty Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=29493
UPDATE `creature_template_locale` SET `Title` = 'Munición especial' WHERE `locale` = 'esES' AND `entry` = 29493;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=29505
UPDATE `creature_template_locale` SET `Title` = 'Instructora de forja de armas' WHERE `locale` = 'esES' AND `entry` = 29505;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=29506
UPDATE `creature_template_locale` SET `Title` = 'Instructor de forja de armaduras' WHERE `locale` = 'esES' AND `entry` = 29506;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=29507
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería elemental' WHERE `locale` = 'esES' AND `entry` = 29507;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=29508
UPDATE `creature_template_locale` SET `Title` = 'Instructor de peletería de escamas de dragón' WHERE `locale` = 'esES' AND `entry` = 29508;
-- OLD subname : Instructora de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=29509
UPDATE `creature_template_locale` SET `Title` = 'Instructora de peletería tribal' WHERE `locale` = 'esES' AND `entry` = 29509;
-- OLD subname : Especialista en sastrería de fuego de hechizo
-- Source : https://www.wowhead.com/wotlk/es/npc=29511
UPDATE `creature_template_locale` SET `Title` = 'Especialista en sastrería con fuego de hechizo' WHERE `locale` = 'esES' AND `entry` = 29511;
-- OLD name : Oso Faucehielo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=29562
UPDATE `creature_template_locale` SET `Name` = 'Oso faucehielo' WHERE `locale` = 'esES' AND `entry` = 29562;
-- OLD name : Matriarca Faucehielo herida (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=29563
UPDATE `creature_template_locale` SET `Name` = 'Matriarca faucehielo herida' WHERE `locale` = 'esES' AND `entry` = 29563;
-- OLD name : Gran almirante Viento Oeste (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=29621
UPDATE `creature_template_locale` SET `Name` = 'Gran Almirante Viento Oeste' WHERE `locale` = 'esES' AND `entry` = 29621;
-- OLD subname : Instructor de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=29631
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de cocina' WHERE `locale` = 'esES' AND `entry` = 29631;
-- OLD name : Grifo osario
-- Source : https://www.wowhead.com/wotlk/es/npc=29648
UPDATE `creature_template_locale` SET `Name` = 'Grifo óseo' WHERE `locale` = 'esES' AND `entry` = 29648;
-- OLD name : Alto arcanista Savor
-- Source : https://www.wowhead.com/wotlk/es/npc=29657
UPDATE `creature_template_locale` SET `Name` = 'Alto arcanista Sabor' WHERE `locale` = 'esES' AND `entry` = 29657;
-- OLD name : Espíritu de rinoceronte
-- Source : https://www.wowhead.com/wotlk/es/npc=29791
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de Rhino' WHERE `locale` = 'esES' AND `entry` = 29791;
-- OLD name : [DND] Dalaran Toy Store Plane String Hook (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29807
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29807;
-- OLD name : [DND] Dalaran Toy Store Plane String Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=29812
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 29812;
-- OLD name : Sacudetierra Drakkari
-- Source : https://www.wowhead.com/wotlk/es/npc=29829
UPDATE `creature_template_locale` SET `Name` = 'Tiemblatérrea Drakkari' WHERE `locale` = 'esES' AND `entry` = 29829;
-- OLD name : Matriarca oso de guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=29918
UPDATE `creature_template_locale` SET `Name` = 'Matriarca Osoguerra' WHERE `locale` = 'esES' AND `entry` = 29918;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=29924
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 29924;
-- OLD name : Zona de vacío X (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=29992
UPDATE `creature_template_locale` SET `Name` = 'Zona de Vacío X' WHERE `locale` = 'esES' AND `entry` = 29992;
-- OLD name : Wodin, el sirviente trol
-- Source : https://www.wowhead.com/wotlk/es/npc=30009
UPDATE `creature_template_locale` SET `Name` = 'Wodin el sirviente trol' WHERE `locale` = 'esES' AND `entry` = 30009;
-- OLD name : [DND]Wyrmrest Temple Beam Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30078
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30078;
-- OLD name : Vórtice
-- Source : https://www.wowhead.com/wotlk/es/npc=30090
UPDATE `creature_template_locale` SET `Name` = 'Vorágine' WHERE `locale` = 'esES' AND `entry` = 30090;
-- OLD name : Fardo de heno seco
-- Source : https://www.wowhead.com/wotlk/es/npc=30096
UPDATE `creature_template_locale` SET `Name` = 'Almiar seco' WHERE `locale` = 'esES' AND `entry` = 30096;
-- OLD name : Venerador Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=30111
UPDATE `creature_template_locale` SET `Name` = 'Beato Crepuscular' WHERE `locale` = 'esES' AND `entry` = 30111;
-- OLD name : Vrykul exhausto
-- Source : https://www.wowhead.com/wotlk/es/npc=30146
UPDATE `creature_template_locale` SET `Name` = 'Vrykul agotado' WHERE `locale` = 'esES' AND `entry` = 30146;
-- OLD name : [DND] Anguish Spectator Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30156
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30156;
-- OLD name : Sumo sacerdote de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30203
UPDATE `creature_template_locale` SET `Name` = 'Sumo sacerdote de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30203;
-- OLD name : Emboscador de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30204
UPDATE `creature_template_locale` SET `Name` = 'Emboscador de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30204;
-- OLD name : Acólito de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30205
UPDATE `creature_template_locale` SET `Name` = 'Acólito de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30205;
-- OLD name : Muñeco de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30207
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30207;
-- OLD name : Guardia de sangre Lorga
-- Source : https://www.wowhead.com/wotlk/es/npc=30247
UPDATE `creature_template_locale` SET `Name` = 'Guardasangre Lorga' WHERE `locale` = 'esES' AND `entry` = 30247;
-- OLD name : Oso Faucehielo muerto (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30292
UPDATE `creature_template_locale` SET `Name` = 'Oso faucehielo muerto' WHERE `locale` = 'esES' AND `entry` = 30292;
-- OLD name : Destripador de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30333
UPDATE `creature_template_locale` SET `Name` = 'Destripador de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30333;
-- OLD name : Jormuttar
-- Source : https://www.wowhead.com/wotlk/es/npc=30340
UPDATE `creature_template_locale` SET `Name` = 'Jorcuttar' WHERE `locale` = 'esES' AND `entry` = 30340;
-- OLD name : Olvidado
-- Source : https://www.wowhead.com/wotlk/es/npc=30414
UPDATE `creature_template_locale` SET `Name` = 'El Olvidado' WHERE `locale` = 'esES' AND `entry` = 30414;
-- OLD name : Lok'lira la Vieja Bruja (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=30417
UPDATE `creature_template_locale` SET `Name` = 'Lok''lira la vieja bruja' WHERE `locale` = 'esES' AND `entry` = 30417;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=30426
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 30426;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=30427
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 30427;
-- OLD subname : Reina alma en pena (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=30428
UPDATE `creature_template_locale` SET `Title` = '' WHERE `locale` = 'esES' AND `entry` = 30428;
-- OLD name : Sirviente Runaforjado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30429
UPDATE `creature_template_locale` SET `Name` = 'Sirviente runaforjado' WHERE `locale` = 'esES' AND `entry` = 30429;
-- OLD name : Huargo avizor
-- Source : https://www.wowhead.com/wotlk/es/npc=30430
UPDATE `creature_template_locale` SET `Name` = 'Centinela huargo' WHERE `locale` = 'esES' AND `entry` = 30430;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=30437
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 30437;
-- OLD name : Rinoceronte pisoteador
-- Source : https://www.wowhead.com/wotlk/es/npc=30447
UPDATE `creature_template_locale` SET `Name` = 'Rinoceronte juguetón' WHERE `locale` = 'esES' AND `entry` = 30447;
-- OLD name : Matriarca Faucehielo con arnés (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30468
UPDATE `creature_template_locale` SET `Name` = 'Matriarca faucehielo con arnés' WHERE `locale` = 'esES' AND `entry` = 30468;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30476
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30476;
-- OLD name : Infrarrey de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30541
UPDATE `creature_template_locale` SET `Name` = 'Infrarrey de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30541;
-- OLD name : Sumo sacerdote de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30543
UPDATE `creature_template_locale` SET `Name` = 'Sumo sacerdote de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30543;
-- OLD name : Infrarrey de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30544
UPDATE `creature_template_locale` SET `Name` = 'Infrarrey de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30544;
-- OLD name : [UNUSED] Wrathstrike Gargoyle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30545
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30545;
-- OLD name : Fras Siabi
-- Source : https://www.wowhead.com/wotlk/es/npc=30552
UPDATE `creature_template_locale` SET `Name` = 'Ezra Grimm' WHERE `locale` = 'esES' AND `entry` = 30552;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (A) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30559
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30559;
-- OLD subname : Ammunition
-- Source : https://www.wowhead.com/wotlk/es/npc=30572
UPDATE `creature_template_locale` SET `Title` = 'Munición' WHERE `locale` = 'esES' AND `entry` = 30572;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30588;
-- OLD name : [DND] Icecrown Flight To Airship Bunny (H) Teleport Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30589;
-- OLD name : Destripador de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30593
UPDATE `creature_template_locale` SET `Name` = 'Destripador de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30593;
-- OLD name : [UNUSED] Forgotten Depths High Priest (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30594
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30594;
-- OLD subname : Arena Organizer
-- Source : https://www.wowhead.com/wotlk/es/npc=30611
UPDATE `creature_template_locale` SET `Title` = 'Organizadora de arena' WHERE `locale` = 'esES' AND `entry` = 30611;
-- OLD name : Producto de la pesadilla
-- Source : https://www.wowhead.com/wotlk/es/npc=30627
UPDATE `creature_template_locale` SET `Name` = 'Imaginación pesadilla' WHERE `locale` = 'esES' AND `entry` = 30627;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30640
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30640;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30646
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30646;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30649
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30649;
-- OLD name : [DND] Icecrown Airship (A) - Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30651
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30651;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30655
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30655;
-- OLD name : Hechicero azur
-- Source : https://www.wowhead.com/wotlk/es/npc=30667
UPDATE `creature_template_locale` SET `Name` = 'Hechicera azur' WHERE `locale` = 'esES' AND `entry` = 30667;
-- OLD name : Destripador de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=30673
UPDATE `creature_template_locale` SET `Name` = 'Destripador de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 30673;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Odd (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30690
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30690;
-- OLD name : [DND] Icecrown Airship (H) - Flak Cannon, Even (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30699
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30699;
-- OLD name : [DND] Icecrown Airship (H) - Cannon, Neutral (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30700
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30700;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Controller 01 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30707
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30707;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=30721
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 30721;
-- OLD subname : Instructora de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=30722
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de inscripción' WHERE `locale` = 'esES' AND `entry` = 30722;
-- OLD name : [DND] Icecrown Airship (H) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30749
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30749;
-- OLD name : Tripulante del Martillo de Orgrim
-- Source : https://www.wowhead.com/wotlk/es/npc=30754
UPDATE `creature_template_locale` SET `Name` = 'Tripulación del Martillo de Orgrim' WHERE `locale` = 'esES' AND `entry` = 30754;
-- OLD name : [DND] Icecrown Airship (A) - Cannon Target, Shield (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=30832
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 30832;
-- OLD name : Aparecido de las Sombras
-- Source : https://www.wowhead.com/wotlk/es/npc=30872
UPDATE `creature_template_locale` SET `Name` = 'Aparecido de sombra' WHERE `locale` = 'esES' AND `entry` = 30872;
-- OLD subname : Armadura de arena de legado
-- Source : https://www.wowhead.com/wotlk/es/npc=30885
UPDATE `creature_template_locale` SET `Title` = 'Vendedor de agua' WHERE `locale` = 'esES' AND `entry` = 30885;
-- OLD subname : Anfitrión de sufrimiento
-- Source : https://www.wowhead.com/wotlk/es/npc=30957
UPDATE `creature_template_locale` SET `Title` = 'Anfitriona de sufrimiento' WHERE `locale` = 'esES' AND `entry` = 30957;
-- OLD name : Iniciada caballero de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=30958
UPDATE `creature_template_locale` SET `Name` = 'Iniciado caballero de la Muerte' WHERE `locale` = 'esES' AND `entry` = 30958;
-- OLD name : Avizor Piel de Hielo
-- Source : https://www.wowhead.com/wotlk/es/npc=31012
UPDATE `creature_template_locale` SET `Name` = 'Centinela Piel de Hielo' WHERE `locale` = 'esES' AND `entry` = 31012;
-- OLD name : [UNUSED] The Lich King (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=31014
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 31014;
-- OLD name : Sumo sacerdote de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31037
UPDATE `creature_template_locale` SET `Name` = 'Sumo sacerdote de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 31037;
-- OLD name : Infrarrey de Las Profundidades Olvidadas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31039
UPDATE `creature_template_locale` SET `Name` = 'Infrarrey de las Profundidades Olvidadas' WHERE `locale` = 'esES' AND `entry` = 31039;
-- OLD subname : Anfitrión de sufrimiento
-- Source : https://www.wowhead.com/wotlk/es/npc=31042
UPDATE `creature_template_locale` SET `Title` = 'Anfitriona de sufrimiento' WHERE `locale` = 'esES' AND `entry` = 31042;
-- OLD name : Russell Bernau Test NPC (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31060
UPDATE `creature_template_locale` SET `Name` = 'Ali Garchanter [TEST]' WHERE `locale` = 'esES' AND `entry` = 31060;
-- OLD name : Reinforced Training Dummy (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31143
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 31143;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31143, 'esES','PNJs',NULL);
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=31144
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento de maestro mayor' WHERE `locale` = 'esES' AND `entry` = 31144;
-- OLD name : Muñeco de entrenamiento de asaltante
-- Source : https://www.wowhead.com/wotlk/es/npc=31146
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento heroico' WHERE `locale` = 'esES' AND `entry` = 31146;
-- OLD name : Maligno apestado
-- Source : https://www.wowhead.com/wotlk/es/npc=31150
UPDATE `creature_template_locale` SET `Name` = 'Enemigo apestado' WHERE `locale` = 'esES' AND `entry` = 31150;
-- OLD name : V (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31168
UPDATE `creature_template_locale` SET `Name` = 'zzOLDV' WHERE `locale` = 'esES' AND `entry` = 31168;
-- OLD name : Tótem de resistencia al fuego V (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31169
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia al fuego V' WHERE `locale` = 'esES' AND `entry` = 31169;
-- OLD name : Tótem de resistencia a la escarcha V (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31171
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la escarcha V' WHERE `locale` = 'esES' AND `entry` = 31171;
-- OLD name : Tótem de resistencia a la Naturaleza V (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31173
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem de resistencia a la Naturaleza V' WHERE `locale` = 'esES' AND `entry` = 31173;
-- OLD name : Lobo fibroso
-- Source : https://www.wowhead.com/wotlk/es/npc=31233
UPDATE `creature_template_locale` SET `Name` = 'Lobo vigoroso' WHERE `locale` = 'esES' AND `entry` = 31233;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=31238
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vuelo en clima frío' WHERE `locale` = 'esES' AND `entry` = 31238;
-- OLD name : [DND] Icecrown Airship Cannon Explosion Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=31246
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 31246;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=31247
UPDATE `creature_template_locale` SET `Title` = 'Instructora de vuelo en clima frío' WHERE `locale` = 'esES' AND `entry` = 31247;
-- OLD subname : Anfitrión de sufrimiento
-- Source : https://www.wowhead.com/wotlk/es/npc=31318
UPDATE `creature_template_locale` SET `Title` = 'Anfitriona de sufrimiento' WHERE `locale` = 'esES' AND `entry` = 31318;
-- OLD name : Avizor Piel de Hielo
-- Source : https://www.wowhead.com/wotlk/es/npc=31324
UPDATE `creature_template_locale` SET `Name` = 'Centinela Piel de Hielo' WHERE `locale` = 'esES' AND `entry` = 31324;
-- OLD subname : Anfitrión de sufrimiento
-- Source : https://www.wowhead.com/wotlk/es/npc=31325
UPDATE `creature_template_locale` SET `Title` = 'Anfitriona de sufrimiento' WHERE `locale` = 'esES' AND `entry` = 31325;
-- OLD name : Iniciada caballero de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=31327
UPDATE `creature_template_locale` SET `Name` = 'Iniciado caballero de la Muerte' WHERE `locale` = 'esES' AND `entry` = 31327;
-- OLD name : Soldado de la Horda huido
-- Source : https://www.wowhead.com/wotlk/es/npc=31330
UPDATE `creature_template_locale` SET `Name` = 'Soldado de la Horda huida' WHERE `locale` = 'esES' AND `entry` = 31330;
-- OLD name : [DND] Icecrown Airship (N) - Attack Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=31353
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 31353;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31419
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 31419;
-- OLD name : Refugiado Renegado (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31437
UPDATE `creature_template_locale` SET `Name` = 'Refugiado renegado' WHERE `locale` = 'esES' AND `entry` = 31437;
-- OLD name : Refugiado Renegado (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31467
UPDATE `creature_template_locale` SET `Name` = 'Refugiado renegado' WHERE `locale` = 'esES' AND `entry` = 31467;
-- OLD subname : Emblema de intendente de honor
-- Source : https://www.wowhead.com/wotlk/es/npc=31579
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de valor' WHERE `locale` = 'esES' AND `entry` = 31579;
-- OLD subname : Emblema del heroísmo intendente
-- Source : https://www.wowhead.com/wotlk/es/npc=31580
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de heroísmo' WHERE `locale` = 'esES' AND `entry` = 31580;
-- OLD subname : Emblema de intendente de honor
-- Source : https://www.wowhead.com/wotlk/es/npc=31581
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de valor' WHERE `locale` = 'esES' AND `entry` = 31581;
-- OLD subname : Emblema del heroísmo intendente
-- Source : https://www.wowhead.com/wotlk/es/npc=31582
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de heroísmo' WHERE `locale` = 'esES' AND `entry` = 31582;
-- OLD name : Imagen de rey Ymiron
-- Source : https://www.wowhead.com/wotlk/es/npc=31620
UPDATE `creature_template_locale` SET `Name` = 'Imagen Rey Ymiron' WHERE `locale` = 'esES' AND `entry` = 31620;
-- OLD name : Imagen de heraldo Volazj (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31627
UPDATE `creature_template_locale` SET `Name` = 'Imagen de Heraldo Volazj' WHERE `locale` = 'esES' AND `entry` = 31627;
-- OLD subname : Bombardero (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31648
UPDATE `creature_template_locale` SET `Title` = 'Bombardera' WHERE `locale` = 'esES' AND `entry` = 31648;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31651
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 31651;
-- OLD name : Draco azur
-- Source : https://www.wowhead.com/wotlk/es/npc=31694
UPDATE `creature_template_locale` SET `Name` = 'Montura de draco azur' WHERE `locale` = 'esES' AND `entry` = 31694;
-- OLD name : Bronze Drake (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31696
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 31696;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (31696, 'esES','PNJs',NULL);
-- OLD name : Draco Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=31698
UPDATE `creature_template_locale` SET `Name` = 'Montura de draco Crepuscular' WHERE `locale` = 'esES' AND `entry` = 31698;
-- OLD name : Draco bronce
-- Source : https://www.wowhead.com/wotlk/es/npc=31717
UPDATE `creature_template_locale` SET `Name` = 'Montura de draco bronce' WHERE `locale` = 'esES' AND `entry` = 31717;
-- OLD name : Avizor Razaescarcha
-- Source : https://www.wowhead.com/wotlk/es/npc=31721
UPDATE `creature_template_locale` SET `Name` = 'Centinela Razaescarcha' WHERE `locale` = 'esES' AND `entry` = 31721;
-- OLD name : Saltarrobot de Cadenas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31736
UPDATE `creature_template_locale` SET `Name` = 'Saltarrobot de cadenas' WHERE `locale` = 'esES' AND `entry` = 31736;
-- OLD name : Draco negro
-- Source : https://www.wowhead.com/wotlk/es/npc=31778
UPDATE `creature_template_locale` SET `Name` = 'Montura de draco negro' WHERE `locale` = 'esES' AND `entry` = 31778;
-- OLD name : Señor de las arañas caído
-- Source : https://www.wowhead.com/wotlk/es/npc=31780
UPDATE `creature_template_locale` SET `Name` = 'Señor araña caído' WHERE `locale` = 'esES' AND `entry` = 31780;
-- OLD name : Saltarrobot de Cadenas (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31784
UPDATE `creature_template_locale` SET `Name` = 'Saltarrobot de cadenas' WHERE `locale` = 'esES' AND `entry` = 31784;
-- OLD name : Mancha de petróleo
-- Source : https://www.wowhead.com/wotlk/es/npc=31786
UPDATE `creature_template_locale` SET `Name` = 'Aceite resbaladizo' WHERE `locale` = 'esES' AND `entry` = 31786;
-- OLD name : Máquina de volar de Brann (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=31827
UPDATE `creature_template_locale` SET `Name` = 'Máquina voladora de Brann' WHERE `locale` = 'esES' AND `entry` = 31827;
-- OLD name : Huevo de dragón Azul (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=31836
UPDATE `creature_template_locale` SET `Name` = 'Huevo de dragón azul' WHERE `locale` = 'esES' AND `entry` = 31836;
-- OLD name : Nargle Trallacable, subname : Vendedor de arena experto
-- Source : https://www.wowhead.com/wotlk/es/npc=31863
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 31863;
-- OLD name : Ardilla parda
-- Source : https://www.wowhead.com/wotlk/es/npc=31889
UPDATE `creature_template_locale` SET `Name` = 'Ardilla de Colinas Pardas' WHERE `locale` = 'esES' AND `entry` = 31889;
-- OLD name : [DND] Icecrown Airship Bomb (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32193
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32193;
-- OLD name : Surcavientos Arakkoa (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32226
UPDATE `creature_template_locale` SET `Name` = 'Surcavientos arakkoa' WHERE `locale` = 'esES' AND `entry` = 32226;
-- OLD name : Guardia de garra Arakkoa (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32228
UPDATE `creature_template_locale` SET `Name` = 'Guardia de la garra arakkoa' WHERE `locale` = 'esES' AND `entry` = 32228;
-- OLD name : Señor del vacío (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32230
UPDATE `creature_template_locale` SET `Name` = 'Señor del Vacío' WHERE `locale` = 'esES' AND `entry` = 32230;
-- OLD name : Bomba de relojería que hace tic tac
-- Source : https://www.wowhead.com/wotlk/es/npc=32246
UPDATE `creature_template_locale` SET `Name` = 'Bomba que hace tic tac' WHERE `locale` = 'esES' AND `entry` = 32246;
-- OLD name : Avizor Aldur'thar
-- Source : https://www.wowhead.com/wotlk/es/npc=32292
UPDATE `creature_template_locale` SET `Name` = 'Centinela Aldur''thar' WHERE `locale` = 'esES' AND `entry` = 32292;
-- OLD name : Avizor Aldur'thar
-- Source : https://www.wowhead.com/wotlk/es/npc=32323
UPDATE `creature_template_locale` SET `Name` = 'Centinela Aldur''thar' WHERE `locale` = 'esES' AND `entry` = 32323;
-- OLD name : [DND] Dalaran Sewer Arena - Controller - Death (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32328
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32328;
-- OLD name : [DND] Dalaran Sewer Arena - Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32339;
-- OLD name : Ecton Cabriolatón, subname : Aprendiz de vendedor de arena
-- Source : https://www.wowhead.com/wotlk/es/npc=32360
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 32360;
-- OLD name : Bestia vil apestada
-- Source : https://www.wowhead.com/wotlk/es/npc=32392
UPDATE `creature_template_locale` SET `Name` = 'Corrubestia apestado' WHERE `locale` = 'esES' AND `entry` = 32392;
-- OLD name : Plague Cauldron Target 02
-- Source : https://www.wowhead.com/wotlk/es/npc=32442
UPDATE `creature_template_locale` SET `Name` = 'Plague Cauldron Target 03' WHERE `locale` = 'esES' AND `entry` = 32442;
-- OLD name : Summoned Plague Cauldron Bunny 02
-- Source : https://www.wowhead.com/wotlk/es/npc=32445
UPDATE `creature_template_locale` SET `Name` = 'Summoned Plague Cauldron Bunny 03' WHERE `locale` = 'esES' AND `entry` = 32445;
-- OLD name : Obsequio de Alexstrasza
-- Source : https://www.wowhead.com/wotlk/es/npc=32448
UPDATE `creature_template_locale` SET `Name` = 'Regalo de Alexstrasza' WHERE `locale` = 'esES' AND `entry` = 32448;
-- OLD subname : Instructor de pesca
-- Source : https://www.wowhead.com/wotlk/es/npc=32474
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de pesca' WHERE `locale` = 'esES' AND `entry` = 32474;
-- OLD name : Gusano de añublo atiborrado
-- Source : https://www.wowhead.com/wotlk/es/npc=32483
UPDATE `creature_template_locale` SET `Name` = 'Gusano de añublo devorado' WHERE `locale` = 'esES' AND `entry` = 32483;
-- OLD name : Experimento fallido
-- Source : https://www.wowhead.com/wotlk/es/npc=32519
UPDATE `creature_template_locale` SET `Name` = 'Experimento suspendido' WHERE `locale` = 'esES' AND `entry` = 32519;
-- OLD name : [UNUSED] Spirit Healer (WGA) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32536
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32536;
-- OLD name : Instructor de némesis de Alto Señor
-- Source : https://www.wowhead.com/wotlk/es/npc=32547
UPDATE `creature_template_locale` SET `Name` = 'Entrenador del alto señor Nemesis' WHERE `locale` = 'esES' AND `entry` = 32547;
-- OLD name : Protodraco de montar, azul (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32585
UPDATE `creature_template_locale` SET `Name` = 'Protodraco de montar azul' WHERE `locale` = 'esES' AND `entry` = 32585;
-- OLD name : Protodraco de montar, bronce (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32586
UPDATE `creature_template_locale` SET `Name` = 'Protodraco de montar bronce' WHERE `locale` = 'esES' AND `entry` = 32586;
-- OLD name : [DND] Cosmetic Book (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32606
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32606;
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=32666
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento para expertos' WHERE `locale` = 'esES' AND `entry` = 32666;
-- OLD name : Muñeco de entrenamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=32667
UPDATE `creature_template_locale` SET `Name` = 'Muñeco de entrenamiento de maestro' WHERE `locale` = 'esES' AND `entry` = 32667;
-- OLD name : Crafticus Dominomente
-- Source : https://www.wowhead.com/wotlk/es/npc=32686
UPDATE `creature_template_locale` SET `Name` = 'Tomas Riogain' WHERE `locale` = 'esES' AND `entry` = 32686;
-- OLD name : Garl Tremendollorica
-- Source : https://www.wowhead.com/wotlk/es/npc=32710
UPDATE `creature_template_locale` SET `Name` = 'Garl Tremedollorica' WHERE `locale` = 'esES' AND `entry` = 32710;
-- OLD name : Kat Girasol
-- Source : https://www.wowhead.com/wotlk/es/npc=32738
UPDATE `creature_template_locale` SET `Name` = 'Kat Solflor' WHERE `locale` = 'esES' AND `entry` = 32738;
-- OLD subname : Glifos de caballeros de la Muerte
-- Source : https://www.wowhead.com/wotlk/es/npc=32753
UPDATE `creature_template_locale` SET `Title` = 'Death Knight Supplies' WHERE `locale` = 'esES' AND `entry` = 32753;
-- OLD subname : Glifos de druidas
-- Source : https://www.wowhead.com/wotlk/es/npc=32754
UPDATE `creature_template_locale` SET `Title` = 'Druid Supplies' WHERE `locale` = 'esES' AND `entry` = 32754;
-- OLD subname : Glifos de cazadores
-- Source : https://www.wowhead.com/wotlk/es/npc=32755
UPDATE `creature_template_locale` SET `Title` = 'Hunter Supplies' WHERE `locale` = 'esES' AND `entry` = 32755;
-- OLD subname : Glifos de magos
-- Source : https://www.wowhead.com/wotlk/es/npc=32756
UPDATE `creature_template_locale` SET `Title` = 'Mage Supplies' WHERE `locale` = 'esES' AND `entry` = 32756;
-- OLD subname : Glifos de paladines
-- Source : https://www.wowhead.com/wotlk/es/npc=32757
UPDATE `creature_template_locale` SET `Title` = 'Paladin Supplies' WHERE `locale` = 'esES' AND `entry` = 32757;
-- OLD subname : Glifos de sacerdotes
-- Source : https://www.wowhead.com/wotlk/es/npc=32758
UPDATE `creature_template_locale` SET `Title` = 'Priest Supplies' WHERE `locale` = 'esES' AND `entry` = 32758;
-- OLD subname : Glifos de pícaros
-- Source : https://www.wowhead.com/wotlk/es/npc=32759
UPDATE `creature_template_locale` SET `Title` = 'Rogue Supplies' WHERE `locale` = 'esES' AND `entry` = 32759;
-- OLD subname : Glifos de chamanes
-- Source : https://www.wowhead.com/wotlk/es/npc=32760
UPDATE `creature_template_locale` SET `Title` = 'Shaman Supplies' WHERE `locale` = 'esES' AND `entry` = 32760;
-- OLD subname : Glifos de brujos
-- Source : https://www.wowhead.com/wotlk/es/npc=32761
UPDATE `creature_template_locale` SET `Title` = 'Warlock Supplies' WHERE `locale` = 'esES' AND `entry` = 32761;
-- OLD subname : Glifos de guerreros
-- Source : https://www.wowhead.com/wotlk/es/npc=32762
UPDATE `creature_template_locale` SET `Title` = 'Warrior Supplies' WHERE `locale` = 'esES' AND `entry` = 32762;
-- OLD name : Avizor Razaescarcha
-- Source : https://www.wowhead.com/wotlk/es/npc=32767
UPDATE `creature_template_locale` SET `Name` = 'Centinela Razaescarcha' WHERE `locale` = 'esES' AND `entry` = 32767;
-- OLD name : Tótem Nova de Fuego IX (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32775
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego IX' WHERE `locale` = 'esES' AND `entry` = 32775;
-- OLD name : Tótem Nova de Fuego VIII (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=32776
UPDATE `creature_template_locale` SET `Name` = 'zzOLDTótem Nova de Fuego VIII' WHERE `locale` = 'esES' AND `entry` = 32776;
-- OLD name : Trampa arácnida visual
-- Source : https://www.wowhead.com/wotlk/es/npc=32785
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 32785;
-- OLD name : [PH] Pilgrim's Bounty Table - Turkey (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32824
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32824;
-- OLD name : [PH] Pilgrim's Bounty Table - Yams (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32825
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32825;
-- OLD name : [PH] Pilgrim's Bounty Table - Cranberry Sauce (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32827
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32827;
-- OLD name : [PH] Pilgrim's Bounty Table - Pie (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32829
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32829;
-- OLD name : [PH] Pilgrim's Bounty Table - Stuffing (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=32831
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 32831;
-- OLD name : [ph] justin test backstab target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33049
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33049;
-- OLD name : Truhán de la Luna Negra (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33069
UPDATE `creature_template_locale` SET `Name` = 'Truhan de la Luna Negra' WHERE `locale` = 'esES' AND `entry` = 33069;
-- OLD name : [PH] Joust Horse (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33130
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33130;
-- OLD name : [PH] Joust Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33135
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33135;
-- OLD name : Rebrote de Teldrassil
-- Source : https://www.wowhead.com/wotlk/es/npc=33188
UPDATE `creature_template_locale` SET `Name` = 'Cogollito de Teldrassil' WHERE `locale` = 'esES' AND `entry` = 33188;
-- OLD name : Defensor de forja de acero (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33236
UPDATE `creature_template_locale` SET `Name` = 'Defensor de acero forjado' WHERE `locale` = 'esES' AND `entry` = 33236;
-- OLD name : [DND] TAR Pedestal - Trainer, Death Knight (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33252
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33252;
-- OLD name : [DND] Tournament - TEST NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33305
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33305;
-- OLD name : [DND] Tournament - Ranged Target Dummy - Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33339
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33339;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Charge Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33340
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33340;
-- OLD name : [DND] Tournament - Mounted Melee - Target Dummy - Block Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33341;
-- OLD name : Morgan Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33351
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33351;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (33351, 'esES','PNJs',NULL);
-- OLD name : Caballo de guerra Renegado (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33414
UPDATE `creature_template_locale` SET `Name` = 'Caballo de guerra renegado' WHERE `locale` = 'esES' AND `entry` = 33414;
-- OLD name : [ph] Tournament War Elekk - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33415
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33415;
-- OLD name : [ph] Tournament War Kodo - NPC Only (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33450
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33450;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 01 - Weak Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33489
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33489;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 02 -Speedy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33490
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33490;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 03 - Block Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33491
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33491;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 04 - Strong Guy (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33492
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33492;
-- OLD name : [DND] Tournament - Mounted Melee - Kill Credit - 05 - Ultimate (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33493
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33493;
-- OLD name : [ph] Tournament - Daily Combatant Summoner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33501
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33501;
-- OLD name : [ph] Tournament - Mounted Combatant - Valiant Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33520
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33520;
-- OLD name : [ph] Tournament - Mounted Combatant - Champion Test (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33521
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33521;
-- OLD name : Azotador Raíz Férrea (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=33526
UPDATE `creature_template_locale` SET `Name` = 'Azotador raíz férrea' WHERE `locale` = 'esES' AND `entry` = 33526;
-- OLD subname : Instructor de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33580
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de sastrería' WHERE `locale` = 'esES' AND `entry` = 33580;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=33581
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 33581;
-- OLD subname : Instructor de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=33583
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de encantamiento' WHERE `locale` = 'esES' AND `entry` = 33583;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=33586
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 33586;
-- OLD subname : Instructora de cocina
-- Source : https://www.wowhead.com/wotlk/es/npc=33587
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de cocina' WHERE `locale` = 'esES' AND `entry` = 33587;
-- OLD subname : Instructora de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=33588
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de alquimia' WHERE `locale` = 'esES' AND `entry` = 33588;
-- OLD subname : Instructor de primeros auxilios
-- Source : https://www.wowhead.com/wotlk/es/npc=33589
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de primeros auxilios' WHERE `locale` = 'esES' AND `entry` = 33589;
-- OLD subname : Instructor de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=33590
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de joyería' WHERE `locale` = 'esES' AND `entry` = 33590;
-- OLD subname : Instructora de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33591
UPDATE `creature_template_locale` SET `Title` = 'Gran maestra instructora de herrería' WHERE `locale` = 'esES' AND `entry` = 33591;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=33603
UPDATE `creature_template_locale` SET `Title` = 'Gran maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 33603;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=33630
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 33630;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33631
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 33631;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=33633
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de encantamiento' WHERE `locale` = 'esES' AND `entry` = 33633;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=33634
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 33634;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=33635
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 33635;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33636
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de sastrería' WHERE `locale` = 'esES' AND `entry` = 33636;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=33637
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de joyería' WHERE `locale` = 'esES' AND `entry` = 33637;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=33638
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 33638;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=33639
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 33639;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=33640
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 33640;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=33641
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 33641;
-- OLD subname : Instructor de alquimia
-- Source : https://www.wowhead.com/wotlk/es/npc=33674
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de alquimia' WHERE `locale` = 'esES' AND `entry` = 33674;
-- OLD subname : Instructor de herrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33675
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de herrería' WHERE `locale` = 'esES' AND `entry` = 33675;
-- OLD subname : Instructora de encantamiento
-- Source : https://www.wowhead.com/wotlk/es/npc=33676
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de encantamiento' WHERE `locale` = 'esES' AND `entry` = 33676;
-- OLD subname : Instructora de ingeniería
-- Source : https://www.wowhead.com/wotlk/es/npc=33677
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de ingeniería' WHERE `locale` = 'esES' AND `entry` = 33677;
-- OLD subname : Instructora de herboristería
-- Source : https://www.wowhead.com/wotlk/es/npc=33678
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de herboristería' WHERE `locale` = 'esES' AND `entry` = 33678;
-- OLD subname : Instructor de inscripción
-- Source : https://www.wowhead.com/wotlk/es/npc=33679
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de inscripción' WHERE `locale` = 'esES' AND `entry` = 33679;
-- OLD subname : Instructora de joyería
-- Source : https://www.wowhead.com/wotlk/es/npc=33680
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de joyería' WHERE `locale` = 'esES' AND `entry` = 33680;
-- OLD subname : Instructor de peletería
-- Source : https://www.wowhead.com/wotlk/es/npc=33681
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de peletería' WHERE `locale` = 'esES' AND `entry` = 33681;
-- OLD subname : Instructor de minería
-- Source : https://www.wowhead.com/wotlk/es/npc=33682
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de minería' WHERE `locale` = 'esES' AND `entry` = 33682;
-- OLD subname : Instructor de desuello
-- Source : https://www.wowhead.com/wotlk/es/npc=33683
UPDATE `creature_template_locale` SET `Title` = 'Maestro instructor de desuello' WHERE `locale` = 'esES' AND `entry` = 33683;
-- OLD subname : Instructora de sastrería
-- Source : https://www.wowhead.com/wotlk/es/npc=33684
UPDATE `creature_template_locale` SET `Title` = 'Maestra instructora de sastrería' WHERE `locale` = 'esES' AND `entry` = 33684;
-- OLD subname : G.U.A.O. (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33708
UPDATE `creature_template_locale` SET `Title` = 'DAME' WHERE `locale` = 'esES' AND `entry` = 33708;
-- OLD name : [ph] test tournament charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=33784
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 33784;
-- OLD name : Hoja de las Sombras Crepuscular
-- Source : https://www.wowhead.com/wotlk/es/npc=33824
UPDATE `creature_template_locale` SET `Name` = 'Sombrafilo Crepuscular' WHERE `locale` = 'esES' AND `entry` = 33824;
-- OLD name : Puntos de enfoque de Mimiron
-- Source : https://www.wowhead.com/wotlk/es/npc=33835
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 33835;
-- OLD name : Bombabot
-- Source : https://www.wowhead.com/wotlk/es/npc=33836
UPDATE `creature_template_locale` SET `Name` = 'Robot bum' WHERE `locale` = 'esES' AND `entry` = 33836;
-- OLD name : Corcel Quel'dorei (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=33840
UPDATE `creature_template_locale` SET `Name` = 'Corcel quel''dorei' WHERE `locale` = 'esES' AND `entry` = 33840;
-- OLD name : Cincel goblin detonante
-- Source : https://www.wowhead.com/wotlk/es/npc=33958
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 33958;
-- OLD name : Magister Sarien, subname : Emblema de intendencia de conquista
-- Source : https://www.wowhead.com/wotlk/es/npc=33963
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 33963;
-- OLD subname : Emblema de intendencia de conquista
-- Source : https://www.wowhead.com/wotlk/es/npc=33964
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de conquista' WHERE `locale` = 'esES' AND `entry` = 33964;
-- OLD name : Zona de vacío (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34000
UPDATE `creature_template_locale` SET `Name` = 'Zona de Vacío' WHERE `locale` = 'esES' AND `entry` = 34000;
-- OLD name : Zona de vacío (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34001
UPDATE `creature_template_locale` SET `Name` = 'Zona de Vacío' WHERE `locale` = 'esES' AND `entry` = 34001;
-- OLD name : Avizor del sagrario
-- Source : https://www.wowhead.com/wotlk/es/npc=34014
UPDATE `creature_template_locale` SET `Name` = 'Centinela del sagrario' WHERE `locale` = 'esES' AND `entry` = 34014;
-- OLD name : Radio de Barbabronce
-- Source : https://www.wowhead.com/wotlk/es/npc=34054
UPDATE `creature_template_locale` SET `Name` = '' WHERE `locale` = 'esES' AND `entry` = 34054;
-- OLD name : Máquina de volar de Brann (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34120
UPDATE `creature_template_locale` SET `Name` = 'Máquina voladora de Brann' WHERE `locale` = 'esES' AND `entry` = 34120;
-- OLD name : Vagón de peste Guardahuesos (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34128
UPDATE `creature_template_locale` SET `Name` = 'Vagón de peste guardahuesos' WHERE `locale` = 'esES' AND `entry` = 34128;
-- OLD name : Montículo de nieve (4)
-- Source : https://www.wowhead.com/wotlk/es/npc=34146
UPDATE `creature_template_locale` SET `Name` = 'Montículo de nieve' WHERE `locale` = 'esES' AND `entry` = 34146;
-- OLD name : Montículo de nieve (6)
-- Source : https://www.wowhead.com/wotlk/es/npc=34150
UPDATE `creature_template_locale` SET `Name` = 'Montículo de nieve' WHERE `locale` = 'esES' AND `entry` = 34150;
-- OLD name : Montículo de nieve (8)
-- Source : https://www.wowhead.com/wotlk/es/npc=34151
UPDATE `creature_template_locale` SET `Name` = 'Montículo de nieve' WHERE `locale` = 'esES' AND `entry` = 34151;
-- OLD name : Ravasaurio Pellejo Venenoso joven (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=34158
UPDATE `creature_template_locale` SET `Name` = 'Ravasaurio pellejo venenoso joven' WHERE `locale` = 'esES' AND `entry` = 34158;
-- OLD name : Avizor con runas grabadas
-- Source : https://www.wowhead.com/wotlk/es/npc=34196
UPDATE `creature_template_locale` SET `Name` = 'Centinela con runas grabadas' WHERE `locale` = 'esES' AND `entry` = 34196;
-- OLD name : [DND]Azeroth Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34281
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34281;
-- OLD name : [DND] Champion Go-To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34319
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34319;
-- OLD name : Prole de Pellejo Venenoso (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=34320
UPDATE `creature_template_locale` SET `Name` = 'Prole de pellejo venenoso' WHERE `locale` = 'esES' AND `entry` = 34320;
-- OLD name : [DND]Northrend Children's Week Trigger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34381
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34381;
-- OLD name : Espíritu de Renegado alegre (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34476
UPDATE `creature_template_locale` SET `Name` = 'Espíritu de renegado alegre' WHERE `locale` = 'esES' AND `entry` = 34476;
-- OLD name : ScottM Test Creature (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34533
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34533;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (34533, 'esES','PNJs',NULL);
-- OLD name : Bromista Renegado (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=34561
UPDATE `creature_template_locale` SET `Name` = 'Bromista renegado' WHERE `locale` = 'esES' AND `entry` = 34561;
-- OLD name : [DND] Stink Bomb Target (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34562
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34562;
-- OLD name : [DND] Warbot - Blue (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34588
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34588;
-- OLD name : [DND] Warbot - Red (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34589
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34589;
-- OLD name : [DND] Magic Rooster (Draenei Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34731
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34731;
-- OLD name : [DND] Magic Rooster (Tauren Male) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34732
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34732;
-- OLD name : [ph] Argent Raid Spectator - FX - Horde (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34883
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34883;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34887
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34887;
-- OLD name : [PH] Goss Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34889
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34889;
-- OLD name : [PH] Tournament Hippogryph Quest Mount (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34891
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34891;
-- OLD name : [PH] Stabled Argent Hippogryph (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34893
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34893;
-- OLD name : [ph] Argent Raid Spectator - FX - Human (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34900
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34900;
-- OLD name : [ph] Argent Raid Spectator - FX - Orc (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34901
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34901;
-- OLD name : [ph] Argent Raid Spectator - FX - Troll (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34902
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34902;
-- OLD name : [ph] Argent Raid Spectator - FX - Tauren (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34903
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34903;
-- OLD name : [ph] Argent Raid Spectator - FX - Blood Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34904;
-- OLD name : [ph] Argent Raid Spectator - FX - Undead (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34905
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34905;
-- OLD name : [ph] Argent Raid Spectator - FX - Dwarf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34906
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34906;
-- OLD name : [ph] Argent Raid Spectator - FX - Draenei (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34908
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34908;
-- OLD name : [ph] Argent Raid Spectator - FX - Night Elf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34909
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34909;
-- OLD name : [ph] Argent Raid Spectator - FX - Gnome (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=34910
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 34910;
-- OLD name : Ruk Embestida de Guerra
-- Source : https://www.wowhead.com/wotlk/es/npc=34976
UPDATE `creature_template_locale` SET `Name` = 'Vapuleador de guerra Ruk' WHERE `locale` = 'esES' AND `entry` = 34976;
-- OLD name : [ph] Argent Raid Spectator - Generic Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=35016
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 35016;
-- OLD name : Rememoración de Truenoraan (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=35032
UPDATE `creature_template_locale` SET `Name` = 'Rememoración de Thunderaan' WHERE `locale` = 'esES' AND `entry` = 35032;
-- OLD name : Rememoración de Cianigosa
-- Source : https://www.wowhead.com/wotlk/es/npc=35046
UPDATE `creature_template_locale` SET `Name` = 'Rememoración de Cyanigosa' WHERE `locale` = 'esES' AND `entry` = 35046;
-- OLD name : [ph] Argent Raid Spectator - FX - Alliance Fireworks NOT USED (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=35066
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 35066;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=35093
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esES' AND `entry` = 35093;
-- OLD subname : Instructor de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=35100
UPDATE `creature_template_locale` SET `Title` = 'Instructor de equitación' WHERE `locale` = 'esES' AND `entry` = 35100;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=35133
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 35133;
-- OLD subname : Instructora de vuelo
-- Source : https://www.wowhead.com/wotlk/es/npc=35135
UPDATE `creature_template_locale` SET `Title` = 'Instructora de equitación' WHERE `locale` = 'esES' AND `entry` = 35135;
-- OLD name : Sable del alba rayado (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=35168
UPDATE `creature_template_locale` SET `Name` = 'Sable del Alba rayado' WHERE `locale` = 'esES' AND `entry` = 35168;
-- OLD name : Celebrante Renegado fantasmal (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=35244
UPDATE `creature_template_locale` SET `Name` = 'Celebrante renegado fantasmal' WHERE `locale` = 'esES' AND `entry` = 35244;
-- OLD name : Campeón de Darnassus
-- Source : https://www.wowhead.com/wotlk/es/npc=35332
UPDATE `creature_template_locale` SET `Name` = 'Campeona de Darnassus' WHERE `locale` = 'esES' AND `entry` = 35332;
-- OLD subname : Emblema del intendente de triunfo
-- Source : https://www.wowhead.com/wotlk/es/npc=35494
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esES' AND `entry` = 35494;
-- OLD subname : Emblema del intendente de triunfo
-- Source : https://www.wowhead.com/wotlk/es/npc=35495
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esES' AND `entry` = 35495;
-- OLD name : Rueben Lauren, subname : Mercader de armaduras de tela
-- Source : https://www.wowhead.com/wotlk/es/npc=35496
UPDATE `creature_template_locale` SET `Name` = '',`Title` = '' WHERE `locale` = 'esES' AND `entry` = 35496;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/es/npc=35573
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esES' AND `entry` = 35573;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/es/npc=35574
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de triunfo' WHERE `locale` = 'esES' AND `entry` = 35574;
-- OLD name : [DND] Dalaran Argent Tournament Herald Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=35608
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 35608;
-- OLD name : [DNT] Test Dragonhawk (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=35983
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 35983;
-- OLD name : [DND] Argent Charger (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36071
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36071;
-- OLD name : [DND] Swift Burgundy Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36072
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36072;
-- OLD name : [DND] Swift Horde Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36074
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36074;
-- OLD name : [DND] White Stallion (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36075
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36075;
-- OLD name : [DND] Swift Alliance Steed (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36076
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36076;
-- OLD name : [DND] Forsaken Mariner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36148
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36148;
-- OLD name : [DND] Valgarde Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36154
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36154;
-- OLD name : [DND] Bor'gorok Wolf (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36167
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36167;
-- OLD name : [DND] Bor'gorok Peon (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36169
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36169;
-- OLD name : [DND]Northrend Children's Week Trigger 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36209
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36209;
-- OLD name : [DND] Crazed Apothecary Generator (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36212
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36212;
-- OLD name : Sobrestante Kor'kron (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36213
UPDATE `creature_template_locale` SET `Name` = 'Guardián de Entrañas' WHERE `locale` = 'esES' AND `entry` = 36213;
-- OLD name : Sobrestante Kraggosh (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36217
UPDATE `creature_template_locale` SET `Name` = 'Cuerpo mutilado' WHERE `locale` = 'esES' AND `entry` = 36217;
-- OLD name : Velador Guardaalma (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36478
UPDATE `creature_template_locale` SET `Name` = 'Velador guarda de almas' WHERE `locale` = 'esES' AND `entry` = 36478;
-- OLD name : Segador Guardaalma (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36499
UPDATE `creature_template_locale` SET `Name` = 'Segador guarda de almas' WHERE `locale` = 'esES' AND `entry` = 36499;
-- OLD name : Daros Picaluna
-- Source : https://www.wowhead.com/wotlk/es/npc=36506
UPDATE `creature_template_locale` SET `Name` = 'Daros Lanzaluna' WHERE `locale` = 'esES' AND `entry` = 36506;
-- OLD name : Alentador Guardaalma (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36516
UPDATE `creature_template_locale` SET `Name` = 'Alentador guarda de almas' WHERE `locale` = 'esES' AND `entry` = 36516;
-- OLD name : [DND] Valentine Boss - Vial Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36530
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36530;
-- OLD name : Huarguerrero Argenta
-- Source : https://www.wowhead.com/wotlk/es/npc=36558
UPDATE `creature_template_locale` SET `Name` = 'Huargo de batalla Argenta' WHERE `locale` = 'esES' AND `entry` = 36558;
-- OLD name : Tirahuesos Guardaalma (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36564
UPDATE `creature_template_locale` SET `Name` = 'Tirahuesos guarda de almas' WHERE `locale` = 'esES' AND `entry` = 36564;
-- OLD name : Púa ósea
-- Source : https://www.wowhead.com/wotlk/es/npc=36619
UPDATE `creature_template_locale` SET `Name` = 'Púa osaria' WHERE `locale` = 'esES' AND `entry` = 36619;
-- OLD name : Adepto Guardaalma (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36620
UPDATE `creature_template_locale` SET `Name` = 'Adepto guarda de almas' WHERE `locale` = 'esES' AND `entry` = 36620;
-- OLD name : [DND] Valentine Boss Manager (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36643
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36643;
-- OLD subname : Gran jefe (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36648
UPDATE `creature_template_locale` SET `Title` = 'Gran Jefe' WHERE `locale` = 'esES' AND `entry` = 36648;
-- OLD name : [DND] Apothecary Table (Spell Effect) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36710
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36710;
-- OLD name : [PH] Icecrown Reanimated Crusader (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36726
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36726;
-- OLD name : [PH] Unused Quarry Overseer (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36792
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36792;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36792, 'esES','PNJs',NULL);
-- OLD name : [PH] Icecrown Gauntlet Ghoul (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36875
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36875;
-- OLD name : Gryphon Hatchling 3.3.0 (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36904
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36904;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (36904, 'esES','PNJs',NULL);
-- OLD name : [DND] World Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=36966
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 36966;
-- OLD name : Tripulante del Martillo de Orgrim
-- Source : https://www.wowhead.com/wotlk/es/npc=36971
UPDATE `creature_template_locale` SET `Name` = 'Tripulación del Martillo de Orgrim' WHERE `locale` = 'esES' AND `entry` = 36971;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=36990
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 36990;
-- OLD name : Hoja terrorífica de El Rompecielos
-- Source : https://www.wowhead.com/wotlk/es/npc=37004
UPDATE `creature_template_locale` SET `Name` = 'Hoja de terror de El Rompecielos' WHERE `locale` = 'esES' AND `entry` = 37004;
-- OLD name : Moco pegajoso
-- Source : https://www.wowhead.com/wotlk/es/npc=37006
UPDATE `creature_template_locale` SET `Name` = 'Baba pegajosa' WHERE `locale` = 'esES' AND `entry` = 37006;
-- OLD name : [DND]Ground Cover Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37039
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37039;
-- OLD name : [PH] Icecrown Shade (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37128
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37128;
-- OLD name : [DND] Summon Bunny 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37168
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37168;
-- OLD name : [PH] Ice Stone 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37191
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37191;
-- OLD name : [PH] Ice Stone 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37192
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37192;
-- OLD name : [DND] Summon Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37201
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37201;
-- OLD name : [DND] Summon Bunny 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37202
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37202;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37223
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 37223;
-- OLD name : Guerrera Sol Devastado (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37512
UPDATE `creature_template_locale` SET `Name` = 'Guerrero Sol Devastado' WHERE `locale` = 'esES' AND `entry` = 37512;
-- OLD subname : General Forestal (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37527
UPDATE `creature_template_locale` SET `Title` = 'General Forestal de Lunargenta' WHERE `locale` = 'esES' AND `entry` = 37527;
-- OLD name : Vermis de escarcha de la Aguja (Ambient)
-- Source : https://www.wowhead.com/wotlk/es/npc=37528
UPDATE `creature_template_locale` SET `Name` = 'Vermis de escarcha de la Aguja' WHERE `locale` = 'esES' AND `entry` = 37528;
-- OLD name : [DND] Shaker (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37543
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37543;
-- OLD name : [DND]Something Stinks Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37558
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37558;
-- OLD name : [DND] Shaker - Small (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37574
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37574;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37596
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 37596;
-- OLD name : Ciudadana de Ventormenta (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37787
UPDATE `creature_template_locale` SET `Name` = 'Ciudadano de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 37787;
-- OLD name : [PH] Runner Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37788
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37788;
-- OLD name : [TEST] High Overlord Omar (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37820
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37820;
-- OLD name : [PH] Captain (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37831
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37831;
-- OLD name : Imagen de Ignis el Maestro de la Caldera (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37859
UPDATE `creature_template_locale` SET `Name` = 'Imagen de Ignis, el Maestro de la Caldera' WHERE `locale` = 'esES' AND `entry` = 37859;
-- OLD name : Imagen de Lord Jaraxxus (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37862
UPDATE `creature_template_locale` SET `Name` = 'Imagen de lord Jaraxxus' WHERE `locale` = 'esES' AND `entry` = 37862;
-- OLD name : Imagen de Lord Tuétano (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37864
UPDATE `creature_template_locale` SET `Name` = 'Imagen de lord Tuétano' WHERE `locale` = 'esES' AND `entry` = 37864;
-- OLD subname : Emblema del intendente de escarcha
-- Source : https://www.wowhead.com/wotlk/es/npc=37941
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esES' AND `entry` = 37941;
-- OLD subname : Emblema del intendente de escarcha
-- Source : https://www.wowhead.com/wotlk/es/npc=37942
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esES' AND `entry` = 37942;
-- OLD name : Portal onírico (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=37945
UPDATE `creature_template_locale` SET `Name` = 'Portal del Sueño' WHERE `locale` = 'esES' AND `entry` = 37945;
-- OLD name : [DND] Love Boat Summoner 02 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37964
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37964;
-- OLD name : [DND] Love Boat Summoner 03 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37981
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37981;
-- OLD name : [DND] Sample Quest Kill Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=37990
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 37990;
-- OLD name : [DND] Fire Creature (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38053
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38053;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38161
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 38161;
-- OLD name : [PH] Captain (Orgrimmar) (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38164
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38164;
-- OLD name : Portal onírico (preefecto) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38186
UPDATE `creature_template_locale` SET `Name` = 'Portal del Sueño (preefecto)' WHERE `locale` = 'esES' AND `entry` = 38186;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38189
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 38189;
-- OLD name : Gran cohete de amor (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38204
UPDATE `creature_template_locale` SET `Name` = 'Rompecorazones X-45' WHERE `locale` = 'esES' AND `entry` = 38204;
-- OLD name : Gran cohete de amor (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38207
UPDATE `creature_template_locale` SET `Name` = 'Rompecorazones X-45' WHERE `locale` = 'esES' AND `entry` = 38207;
-- OLD name : [DND] Fire Wall - No Scaling (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38226
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38226;
-- OLD name : [DND] Fire Wall (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38230
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38230;
-- OLD name : [DND] Fire Strat (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38236
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38236;
-- OLD name : [DND] Holiday - Love - Bank Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38340
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38340;
-- OLD name : [DND] Holiday - Love - AH Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38341
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38341;
-- OLD name : [DND] Holiday - Love - Barber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38342
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38342;
-- OLD name : Portal pesadilla (Pre-effect)
-- Source : https://www.wowhead.com/wotlk/es/npc=38429
UPDATE `creature_template_locale` SET `Name` = 'Portal pesadilla' WHERE `locale` = 'esES' AND `entry` = 38429;
-- OLD name : Acechador de gas inmundo
-- Source : https://www.wowhead.com/wotlk/es/npc=38548
UPDATE `creature_template_locale` SET `Name` = 'Acechador de gas vil' WHERE `locale` = 'esES' AND `entry` = 38548;
-- OLD name : [PH] Matt Test NPC (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38580
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38580;
-- OLD name : [PH] Matt Test NPC 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38581
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38581;
-- OLD subname : G.U.A.O. (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38595
UPDATE `creature_template_locale` SET `Title` = 'DAME' WHERE `locale` = 'esES' AND `entry` = 38595;
-- OLD subname : Reina alma en pena (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38609
UPDATE `creature_template_locale` SET `Title` = 'Reina Alma en Pena' WHERE `locale` = 'esES' AND `entry` = 38609;
-- OLD name : [PH] Grimtotem Protector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38830
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38830;
-- OLD name : [PH] Grimtotem Collector (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38843
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38843;
-- OLD name : [PH] Slain Druid (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38846
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38846;
-- OLD subname : Intendente de justicia de legado
-- Source : https://www.wowhead.com/wotlk/es/npc=38858
UPDATE `creature_template_locale` SET `Title` = 'Intendente de emblema de Escarcha' WHERE `locale` = 'esES' AND `entry` = 38858;
-- OLD name : Matón del Casco Antiguo (CASE ONLY)
-- Source : https://www.wowhead.com/wotlk/es/npc=38867
UPDATE `creature_template_locale` SET `Name` = 'Matón del casco antiguo' WHERE `locale` = 'esES' AND `entry` = 38867;
-- OLD name : [DND] Dark Iron Guard Move To Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38870
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38870;
-- OLD name : [DND] Mole Machine Spawner (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38882
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38882;
-- OLD name : ScottG Test (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=38883
UPDATE `creature_template_locale` SET `Name` = 'Idle Before Scaling' WHERE `locale` = 'esES' AND `entry` = 38883;
-- OLD name : [PH] Grimtotem Vendor (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=38905
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 38905;
-- OLD name : Martyr Stalker (Reputation)
-- Source : https://www.wowhead.com/wotlk/es/npc=39010
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39010;
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`) VALUES (39010, 'esES','Acechador mártir',NULL);
-- OLD name : [DND] TB Event Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39023
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39023;
-- OLD name : [DND] Fire Strat Auto (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39057
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39057;
-- OLD name : [PH] Orc Firefighter (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39058
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39058;
-- OLD subname : El Anillo de la Tierra (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=39090
UPDATE `creature_template_locale` SET `Title` = 'Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 39090;
-- OLD name : [DND] Flying Machine (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39229
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39229;
-- OLD name : Manitas Mayor Mekkatorque (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=39271
UPDATE `creature_template_locale` SET `Name` = 'Manitas mayor Mekkatorque' WHERE `locale` = 'esES' AND `entry` = 39271;
-- OLD subname : El Anillo de la Tierra (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=39283
UPDATE `creature_template_locale` SET `Title` = 'Anillo de la Tierra' WHERE `locale` = 'esES' AND `entry` = 39283;
-- OLD name : [DND] Salute Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39355
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39355;
-- OLD name : [DND] Roar Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39356
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39356;
-- OLD name : [DND] Dance Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39361
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39361;
-- OLD name : [DND] Cheer Quest Credit Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39362
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39362;
-- OLD name : [DND] Probe Target Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39420
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39420;
-- OLD name : [DND] Quest Credit Bunny - Eject (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39683
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39683;
-- OLD name : Ciudadana de Ventormenta (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=39686
UPDATE `creature_template_locale` SET `Name` = 'Ciudadano de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 39686;
-- OLD name : [DND] Quest Credit Bunny - Move 1 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39691
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39691;
-- OLD name : [DND] Quest Credit Bunny - Move 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39692
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39692;
-- OLD name : [DND] Quest Credit Bunny - Move 3 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39695
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39695;
-- OLD name : [DND] Quest Credit Bunny - Attack (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39703
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39703;
-- OLD name : [DND] Attack Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39707
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39707;
-- OLD name : Manitas Mayor Mekkatorque (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=39712
UPDATE `creature_template_locale` SET `Name` = 'Manitas mayor Mekkatorque' WHERE `locale` = 'esES' AND `entry` = 39712;
-- OLD name : [DND] GT Bomber Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39743
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39743;
-- OLD name : [DND] GT Bomber Bunny 2 (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39744
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39744;
-- OLD name : [PH] Mother Trogg (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39798
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39798;
-- OLD name : [DND] Summoning Pad (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39817
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39817;
-- OLD name : [DND] Boom Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=39841
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 39841;
-- OLD name : Ciudadana de Ventormenta (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40125
UPDATE `creature_template_locale` SET `Name` = 'Ciudadano de Ventormenta' WHERE `locale` = 'esES' AND `entry` = 40125;
-- OLD name : Guerrero Tiki (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40199
UPDATE `creature_template_locale` SET `Name` = 'Guerrero tiki' WHERE `locale` = 'esES' AND `entry` = 40199;
-- OLD subname : Armas de arena de legado (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40212
UPDATE `creature_template_locale` SET `Title` = 'Gladiador indómito' WHERE `locale` = 'esES' AND `entry` = 40212;
-- OLD subname : Armas de arena de legado (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40216
UPDATE `creature_template_locale` SET `Title` = 'Gladiador sañoso' WHERE `locale` = 'esES' AND `entry` = 40216;
-- OLD name : Guerrero Tiki (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40263
UPDATE `creature_template_locale` SET `Name` = 'Guerrero tiki' WHERE `locale` = 'esES' AND `entry` = 40263;
-- OLD name : [DND] Zen'tabra Cat Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=40265
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 40265;
-- OLD name : Robot cohete de cuerda azul
-- Source : https://www.wowhead.com/wotlk/es/npc=40295
UPDATE `creature_template_locale` SET `Name` = 'Robot cohete de cuerda' WHERE `locale` = 'esES' AND `entry` = 40295;
-- OLD name : [DND] Zen'tabra Travel Form (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=40354
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 40354;
-- OLD name : [DND] Quest Credit Bunny - ET Battle (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=40428
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 40428;
-- OLD subname : Asistente del Manitas Mayor (CASE ONLY) (RETAIL DATAS)
-- Source : https://www.wowhead.com/es/npc=40478
UPDATE `creature_template_locale` SET `Title` = 'Asistente del manitas mayor' WHERE `locale` = 'esES' AND `entry` = 40478;
-- OLD name : [DND] Bunny (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=40617
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 40617;
-- OLD name : [DND] Controller (NO TRANSLATION EXIST, EVEN ON RETAIL)
-- Source : https://www.wowhead.com/es/npc=41839
DELETE FROM `creature_template_locale` WHERE `locale` = 'esES' AND `entry` = 41839;

-- List of entries using retail datas :
-- 81,444,6783,15713,17733,18674,23808,24049,24181,24377,24378,25788,26080,26376,26442,26508,26594,26671,27231,27527,27771,27862,28501,28652,29039,29165,29992,30417,30426,30427,30428,31060,31143,31168,31169,31171,31173,31419,31437,31467,31648,31651,31696,31827,32226,32228,32230,32585,32586,32775,32776,33069,33236,33351,33414,33708,33840,34000,34001,34120,34128,34476,34533,34561,35032,35244,36213,36217,36478,36499,36516,36564,36620,36648,36792,36904,36990,37223,37512,37527,37596,37787,37859,37862,37864,37945,38161,38186,38189,38204,38207,38595,38609,38883,39090,39271,39283,39686,39712,40125,40199,40212,40216,40263,40478
-- END
