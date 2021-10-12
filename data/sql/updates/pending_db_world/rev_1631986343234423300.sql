INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631986343234423300');

UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x80000000 WHERE `entry` IN (
28684, /* Krik'thir the Gatewatcher */
36502, /* Devourer of Souls */
36658, /* Scourgelord Tyrannus */
32871, /* Algalon */
39863, /* Halion */
33186, /* Razorscale */
36626, /* Festergut */
32867, /* Steelbreaker - Assembly of Iron */
32927, /* Runemaster Molgeim - Assembly of Iron */
32857, /* Stormcaller Brundir - Assembly of Iron */
33350, /* Mimiron */
16060, /* Gothik the Harvester */
36678, /* Professor Putricide */
15990, /* Kel'Thuzad */
33993, /* Emalon the Storm Watcher */
17257, /* Magtheridon */
25315, /* Kil'jaeden */
15928, /* Thaddius */
32930, /* Kologarn */
32906, /* Freya */
36597, /* The Lich King */
36853, /* Sindragosa */
36855, /* Lady Deathwhisper */
37955 /* Blood-Queen Lana'thel */);
