INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583667245426891200');

-- --------------------------------------------------------------------------------------------------------
-- All DMG Values gathered from the official WoW Beastiary - If these are not listed, the source is given
-- Not all bosses are in the instance itself! These are separated with (Entrance)
-- Bosses compared with Atlas Loot Enhanced ingame Addon & Online research sources:
-- --------------------------------------------------------------------------------------------------------
-- https://de.classic.wowhead.com/
-- https://wotlk.evowow.com/
-- https://db.rising-gods.de/
-- --------------------------------------------------------------------------------------------------------

-- Ragefire Chasm (13-18)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Oggleflint
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 68, `DamageModifier` = 1 WHERE `entry` = 11517;
-- Jergosh the Invoker
UPDATE `creature_template` SET `mindmg` = 40, `maxdmg` = 53, `DamageModifier` = 1 WHERE `entry` = 11518;
-- Bazzalan
UPDATE `creature_template` SET `mindmg` = 51, `maxdmg` = 68, `DamageModifier` = 1 WHERE `entry` = 11519;
-- Taragaman the Hungerer
UPDATE `creature_template` SET `mindmg` = 56, `maxdmg` = 74, `DamageModifier` = 1 WHERE `entry` = 11520;
-- Zelemar the Wrathful
UPDATE `creature_template` SET `mindmg` = 89, `maxdmg` = 113, `DamageModifier` = 1 WHERE `entry` = 17830;

-- Wailing Caverns (15-25)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Kresh
UPDATE `creature_template` SET `mindmg` = 50, `maxdmg` = 66, `DamageModifier` = 1 WHERE `entry` = 3653;
-- Mutanus the Devourer
UPDATE `creature_template` SET `mindmg` = 70, `maxdmg` = 94, `DamageModifier` = 1 WHERE `entry` = 3654;
-- Lord Cobrahn
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 91, `DamageModifier` = 1 WHERE `entry` = 3669;
-- Lord Pythas
UPDATE `creature_template` SET `mindmg` = 78, `maxdmg` = 104, `DamageModifier` = 1 WHERE `entry` = 3670;
-- Lady Anacondra
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 91, `DamageModifier` = 1 WHERE `entry` = 3671;
-- Lord Serpentis
UPDATE `creature_template` SET `mindmg` = 78, `maxdmg` = 104, `DamageModifier` = 1 WHERE `entry` = 3673;
-- Skum
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 78, `DamageModifier` = 1 WHERE `entry` = 3674;
-- Verdan the Everliving
UPDATE `creature_template` SET `mindmg` = 277, `maxdmg` = 369, `DamageModifier` = 1 WHERE `entry` = 5775;
-- Deviate Faerie Dragon
UPDATE `creature_template` SET `mindmg` = 47, `maxdmg` = 63, `DamageModifier` = 1 WHERE `entry` = 5912;

-- The Deadmines (18-23)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Brainwashed Noble (Entrance) (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=596 / https://db.rising-gods.de/?npc=596
UPDATE `creature_template` SET `mindmg` = 19, `maxdmg` = 26, `DamageModifier` = 1 WHERE `entry` = 596;
-- Marisa du'Paige (Entrance)
UPDATE `creature_template` SET `mindmg` = 23, `maxdmg` = 33, `DamageModifier` = 1 WHERE `entry` = 599;
-- Foreman Thistlenettle (Entrance)
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 42, `DamageModifier` = 1 WHERE `entry` = 626;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Edwin VanCleef
UPDATE `creature_template` SET `mindmg` = 54, `maxdmg` = 72, `DamageModifier` = 1 WHERE `entry` = 639;
-- Sneed's Shredder
UPDATE `creature_template` SET `mindmg` = 97, `maxdmg` = 129, `DamageModifier` = 1 WHERE `entry` = 642;
-- Sneed
UPDATE `creature_template` SET `mindmg` = 97, `maxdmg` = 129, `DamageModifier` = 1 WHERE `entry` = 643;
-- Rhahk'Zor
UPDATE `creature_template` SET `mindmg` = 119, `maxdmg` = 158, `DamageModifier` = 1 WHERE `entry` = 644;
-- Cookie
UPDATE `creature_template` SET `mindmg` = 72, `maxdmg` = 96, `DamageModifier` = 1 WHERE `entry` = 645;
-- Mr. Smite
UPDATE `creature_template` SET `mindmg` = 72, `maxdmg` = 96, `DamageModifier` = 1 WHERE `entry` = 646;
-- Captain Greenskin
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 120, `DamageModifier` = 1 WHERE `entry` = 647;
-- Gilnid
UPDATE `creature_template` SET `mindmg` = 72, `maxdmg` = 96, `DamageModifier` = 1 WHERE `entry` = 1763;
-- Miner Johnson
UPDATE `creature_template` SET `mindmg` = 47, `maxdmg` = 63, `DamageModifier` = 1 WHERE `entry` = 3586;

-- Shadowfang Keep (22-30)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Fel Steed (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=3864 / https://db.rising-gods.de/?npc=3864
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1 WHERE `entry` = 3864;
-- Shadow Charger (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=3865 / https://db.rising-gods.de/?npc=3865
UPDATE `creature_template` SET `mindmg` = 203, `maxdmg` = 288, `DamageModifier` = 1 WHERE `entry` = 3865;
-- Deathsworn Captain
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1 WHERE `entry` = 3872;
-- Razorclaw the Butcher
UPDATE `creature_template` SET `mindmg` = 115, `maxdmg` = 153, `DamageModifier` = 1 WHERE `entry` = 3886;
-- Baron Silverlaine
UPDATE `creature_template` SET `mindmg` = 50, `maxdmg` = 66, `DamageModifier` = 1 WHERE `entry` = 3887;
-- Rethilgore
UPDATE `creature_template` SET `mindmg` = 54, `maxdmg` = 62, `DamageModifier` = 1 WHERE `entry` = 3914;
-- Wolf Master Nandos
UPDATE `creature_template` SET `mindmg` = 101, `maxdmg` = 134, `DamageModifier` = 1 WHERE `entry` = 3927;
-- Fenrus the Devourer
UPDATE `creature_template` SET `mindmg` = 101, `maxdmg` = 134, `DamageModifier` = 1 WHERE `entry` = 4274;
-- Archmage Arugal
UPDATE `creature_template` SET `mindmg` = 162, `maxdmg` = 215, `DamageModifier` = 1 WHERE `entry` = 4275;
-- Commander Springvale
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 91, `DamageModifier` = 1 WHERE `entry` = 4278;
-- Odo the Blindwatcher
UPDATE `creature_template` SET `mindmg` = 66, `maxdmg` = 76, `DamageModifier` = 1 WHERE `entry` = 4279;

-- The Stockade (22-30)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Dextren Ward
UPDATE `creature_template` SET `mindmg` = 73, `maxdmg` = 97, `DamageModifier` = 1 WHERE `entry` = 1663;
-- Kam Deepfury (Not listed in beastiary) Src: https://wotlk.evowow.com/?npc=1666 / https://db.rising-gods.de/?npc=1666
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 88, `DamageModifier` = 1 WHERE `entry` = 1666;
-- Targorr the Dread
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 78, `DamageModifier` = 1 WHERE `entry` = 1696;
-- Bazil Thredd
UPDATE `creature_template` SET `mindmg` = 86, `maxdmg` = 114, `DamageModifier` = 1 WHERE `entry` = 1716;
-- Hamhock
UPDATE `creature_template` SET `mindmg` = 83, `maxdmg` = 111, `DamageModifier` = 1 WHERE `entry` = 1717;
-- Bruegal Ironknuckle
UPDATE `creature_template` SET `mindmg` = 86, `maxdmg` = 114, `DamageModifier` = 1 WHERE `entry` = 1720;

-- Blackfathom Deeps (24-32)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Aku'mai
UPDATE `creature_template` SET `mindmg` = 157, `maxdmg` = 208, `DamageModifier` = 1 WHERE `entry` = 4829;
-- Old Serra'kis
UPDATE `creature_template` SET `mindmg` = 59, `maxdmg` = 78, `DamageModifier` = 1 WHERE `entry` = 4830;
-- Lady Sarevess
UPDATE `creature_template` SET `mindmg` = 52, `maxdmg` = 69, `DamageModifier` = 1 WHERE `entry` = 4831;
-- Twilight Lord Kelris
UPDATE `creature_template` SET `mindmg` = 55, `maxdmg` = 72, `DamageModifier` = 1 WHERE `entry` = 4832;
-- Ghamoo-ra
UPDATE `creature_template` SET `mindmg` = 56, `maxdmg` = 75, `DamageModifier` = 1 WHERE `entry` = 4887;
-- Gelihast
UPDATE `creature_template` SET `mindmg` = 50, `maxdmg` = 66, `DamageModifier` = 1 WHERE `entry` = 6243;
-- Baron Aquanis
UPDATE `creature_template` SET `mindmg` = 69, `maxdmg` = 80, `DamageModifier` = 1 WHERE `entry` = 12876;
-- Lorgus Jett
UPDATE `creature_template` SET `mindmg` = 55, `maxdmg` = 72, `DamageModifier` = 1 WHERE `entry` = 12902;

-- Gnomeregan (29-38)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Namdo Bizzfizzle (Entrance) (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=2683 / https://db.rising-gods.de/?npc=2683
UPDATE `creature_template` SET `mindmg` = 33, `maxdmg` = 44, `DamageModifier` = 1 WHERE `entry` = 2683;
-- Techbot (Entrance)
UPDATE `creature_template` SET `mindmg` = 37, `maxdmg` = 49, `DamageModifier` = 1 WHERE `entry` = 6231;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Dark Iron Ambassador
UPDATE `creature_template` SET `mindmg` = 94, `maxdmg` = 124, `DamageModifier` = 1 WHERE `entry` = 6228;
-- Crowd Pummeler 9-60 (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=6229 / https://db.rising-gods.de/?npc=6229
UPDATE `creature_template` SET `mindmg` = 74, `maxdmg` = 99, `DamageModifier` = 1 WHERE `entry` = 6229;
-- Electrocutioner 6000
UPDATE `creature_template` SET `mindmg` = 95, `maxdmg` = 126, `DamageModifier` = 1 WHERE `entry` = 6235;
-- Viscous Fallout
UPDATE `creature_template` SET `mindmg` = 67, `maxdmg` = 89, `DamageModifier` = 1 WHERE `entry` = 7079;
-- Grubbis
UPDATE `creature_template` SET `mindmg` = 95, `maxdmg` = 126, `DamageModifier` = 1 WHERE `entry` = 7361;
-- Mekgineer Thermaplugg
UPDATE `creature_template` SET `mindmg` = 95, `maxdmg` = 126, `DamageModifier` = 1 WHERE `entry` = 7800;

-- Razorfen Kraul (30-40)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Overlord Ramtusk
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 87, `DamageModifier` = 1 WHERE `entry` = 4420;
-- Charlga Razorflank
UPDATE `creature_template` SET `mindmg` = 61, `maxdmg` = 81, `DamageModifier` = 1 WHERE `entry` = 4421;
-- Agathelos the Raging
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 87, `DamageModifier` = 1 WHERE `entry` = 4422;
-- Aggem Thorncurse
UPDATE `creature_template` SET `mindmg` = 61, `maxdmg` = 81, `DamageModifier` = 1 WHERE `entry` = 4424;
-- Blind Hunter 
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 87, `DamageModifier` = 1 WHERE `entry` = 4425;
-- Death Speaker Jargba
UPDATE `creature_template` SET `mindmg` = 61, `maxdmg` = 81, `DamageModifier` = 1 WHERE `entry` = 4428;
-- Razorfen Spearhide
UPDATE `creature_template` SET `mindmg` = 61, `maxdmg` = 83, `DamageModifier` = 1 WHERE `entry` = 4438;
-- Earthcaller Halmgar
UPDATE `creature_template` SET `mindmg` = 61, `maxdmg` = 81, `DamageModifier` = 1 WHERE `entry` = 4842;
-- Roogug
UPDATE `creature_template` SET `mindmg` = 58, `maxdmg` = 77, `DamageModifier` = 1 WHERE `entry` = 6168;

-- Scarlet Monastery: Graveyard (28-38)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Interrogator Vishas
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 104, `DamageModifier` = 1 WHERE `entry` = 3983;
-- Bloodmage Thalnos
UPDATE `creature_template` SET `mindmg` = 71, `maxdmg` = 94, `DamageModifier` = 1 WHERE `entry` = 4543;
-- Fallen Champion (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=6488 / https://db.rising-gods.de/?npc=6488
UPDATE `creature_template` SET `mindmg` = 120, `maxdmg` = 161, `DamageModifier` = 1 WHERE `entry` = 6488;
-- Ironspine
UPDATE `creature_template` SET `mindmg` = 76, `maxdmg` = 101, `DamageModifier` = 1 WHERE `entry` = 6489;
-- Azshir the Sleepless
UPDATE `creature_template` SET `mindmg` = 71, `maxdmg` = 94, `DamageModifier` = 1 WHERE `entry` = 6490;

-- Scarlet Monastery: Library (29-39)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Houndmaster Loksey
UPDATE `creature_template` SET `mindmg` = 121, `maxdmg` = 140, `DamageModifier` = 1 WHERE `entry` = 3974;
-- Arcanist Doan
UPDATE `creature_template` SET `mindmg` = 77, `maxdmg` = 88, `DamageModifier` = 1 WHERE `entry` = 6487;

-- Scarlet Monastery: Armory (32-42)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Herod 
UPDATE `creature_template` SET `mindmg` = 243, `maxdmg` = 280, `DamageModifier` = 1 WHERE `entry` = 3975;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Scarlet Trainee (Not a Boss at all but had wrong values)
UPDATE `creature_template` SET `mindmg` = 36, `maxdmg` = 48, `DamageModifier` = 1 WHERE `entry` = 6575;

-- Scarlet Monastery: Cathedral (35-45)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Scarlet Commander Mograine
UPDATE `creature_template` SET `mindmg` = 161, `maxdmg` = 185, `DamageModifier` = 1 WHERE `entry` = 3976;
-- High Inquisitor Whitemane
UPDATE `creature_template` SET `mindmg` = 124, `maxdmg` = 143, `DamageModifier` = 1 WHERE `entry` = 3977;
-- High Inquisitor Fairbanks
UPDATE `creature_template` SET `mindmg` = 149, `maxdmg` = 197, `DamageModifier` = 1 WHERE `entry` = 4542;

-- Razorfen Downs (40-50)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Ragglesnout
UPDATE `creature_template` SET `mindmg` = 72, `maxdmg` = 101, `DamageModifier` = 1 WHERE `entry` = 7354;
-- Tuten'kash
UPDATE `creature_template` SET `mindmg` = 128, `maxdmg` = 170, `DamageModifier` = 1 WHERE `entry` = 7355;
-- Plaguemaw the Rotting
UPDATE `creature_template` SET `mindmg` = 103, `maxdmg` = 136, `DamageModifier` = 1 WHERE `entry` = 7356;
-- Mordresh Fire Eye
UPDATE `creature_template` SET `mindmg` = 88, `maxdmg` = 117, `DamageModifier` = 1 WHERE `entry` = 7357;
-- Amnennar the Coldbringer
UPDATE `creature_template` SET `mindmg` = 191, `maxdmg` = 253, `DamageModifier` = 1 WHERE `entry` = 7358;
-- Glutton 
UPDATE `creature_template` SET `mindmg` = 215, `maxdmg` = 286, `DamageModifier` = 1 WHERE `entry` = 8567;

-- Uldaman (42-52)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Archaedas
UPDATE `creature_template` SET `mindmg` = 197, `maxdmg` = 261, `DamageModifier` = 1 WHERE `entry` = 2748;
-- Grimlok
UPDATE `creature_template` SET `mindmg` = 130, `maxdmg` = 173, `DamageModifier` = 1 WHERE `entry` = 4854;
-- Baelog (Not listed in beastiary) Src: https://wotlk.evowow.com/?npc=6906 / https://db.rising-gods.de/?npc=6906
UPDATE `creature_template` SET `mindmg` = 148, `maxdmg` = 199, `DamageModifier` = 1 WHERE `entry` = 6906;
-- Revelosh
UPDATE `creature_template` SET `mindmg` = 101, `maxdmg` = 134, `DamageModifier` = 1 WHERE `entry` = 6910;
-- Obsidian Sentinel
UPDATE `creature_template` SET `mindmg` = 196, `maxdmg` = 260, `DamageModifier` = 1 WHERE `entry` = 7023;
-- Digmaster Shovelphlange
UPDATE `creature_template` SET `mindmg` = 158, `maxdmg` = 210, `DamageModifier` = 1 WHERE `entry` = 7057;
-- Ancient Stone Keeper
UPDATE `creature_template` SET `mindmg` = 235, `maxdmg` = 312, `DamageModifier` = 1 WHERE `entry` = 7206;
-- Ironaya 
UPDATE `creature_template` SET `mindmg` = 354, `maxdmg` = 470, `DamageModifier` = 1 WHERE `entry` = 7228;
-- Galgann Firehammer (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=7291 / https://db.rising-gods.de/?npc=7291
UPDATE `creature_template` SET `mindmg` = 125, `maxdmg` = 166, `DamageModifier` = 1 WHERE `entry` = 7291;

-- Zul'Farrak (44-54)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Chief Ukorz Sandscalp
UPDATE `creature_template` SET `mindmg` = 247, `maxdmg` = 328, `DamageModifier` = 1 WHERE `entry` = 7267;
-- Witch Doctor Zum'rah 
UPDATE `creature_template` SET `mindmg` = 187, `maxdmg` = 247, `DamageModifier` = 1 WHERE `entry` = 7271;
-- Theka the Martyr
UPDATE `creature_template` SET `mindmg` = 251, `maxdmg` = 333, `DamageModifier` = 1 WHERE `entry` = 7272;
-- Gahz'rilla
UPDATE `creature_template` SET `mindmg` = 270, `maxdmg` = 358, `DamageModifier` = 1 WHERE `entry` = 7273;
-- Sandfury Executioner
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 426, `DamageModifier` = 1 WHERE `entry` = 7274;
-- Shadowpriest Sezz'ziz
UPDATE `creature_template` SET `mindmg` = 194, `maxdmg` = 257, `DamageModifier` = 1 WHERE `entry` = 7275;
-- Sergeant Bly
UPDATE `creature_template` SET `mindmg` = 95, `maxdmg` = 125, `DamageModifier` = 1 WHERE `entry` = 7604;
-- Hydromancer Velratha
UPDATE `creature_template` SET `mindmg` = 173, `maxdmg` = 229, `DamageModifier` = 1 WHERE `entry` = 7795;
-- Nekrum Gutchewer
UPDATE `creature_template` SET `mindmg` = 246, `maxdmg` = 326, `DamageModifier` = 1 WHERE `entry` = 7796;
-- Ruuzlu
UPDATE `creature_template` SET `mindmg` = 354, `maxdmg` = 470, `DamageModifier` = 1 WHERE `entry` = 7797;
-- Antu'sul
UPDATE `creature_template` SET `mindmg` = 305, `maxdmg` = 405, `DamageModifier` = 1 WHERE `entry` = 8127;
-- Sandarr Dunereaver
UPDATE `creature_template` SET `mindmg` = 189, `maxdmg` = 251, `DamageModifier` = 1 WHERE `entry` = 10080;
-- Dustwraith (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=10081 / https://db.rising-gods.de/?npc=10081
UPDATE `creature_template` SET `mindmg` = 583, `maxdmg` = 774, `DamageModifier` = 1 WHERE `entry` = 10081;
-- Zerillis
UPDATE `creature_template` SET `mindmg` = 189, `maxdmg` = 251, `DamageModifier` = 1 WHERE `entry` = 10082;

-- Maraudon: Foulspore Cavern (Orange) (45-53)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Razorlash
UPDATE `creature_template` SET `mindmg` = 232, `maxdmg` = 307, `DamageModifier` = 1 WHERE `entry` = 12258;
-- Noxxion
UPDATE `creature_template` SET `mindmg` = 270, `maxdmg` = 358, `DamageModifier` = 1 WHERE `entry` = 13282;

-- Maraudon: Wicked Grotto (Purple) (45-53)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Celebras the Cursed
UPDATE `creature_template` SET `mindmg` = 323, `maxdmg` = 428, `DamageModifier` = 1 WHERE `entry` = 12225;
-- Lord Vyletongue 
UPDATE `creature_template` SET `mindmg` = 288, `maxdmg` = 382, `DamageModifier` = 1 WHERE `entry` = 12236;
-- Meshlok the Harvester
UPDATE `creature_template` SET `mindmg` = 290, `maxdmg` = 384, `DamageModifier` = 1 WHERE `entry` = 12237;

-- Maraudon: Earth Song Falls (Inner) (48-57)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Princess Theradras
UPDATE `creature_template` SET `mindmg` = 403, `maxdmg` = 535, `DamageModifier` = 1 WHERE `entry` = 12201;
-- Landslide
UPDATE `creature_template` SET `mindmg` = 403, `maxdmg` = 535, `DamageModifier` = 1 WHERE `entry` = 12203;
-- Rotgrip
UPDATE `creature_template` SET `mindmg` = 541, `maxdmg` = 717, `DamageModifier` = 1 WHERE `entry` = 13596;
-- Tinkerer Gizlock
UPDATE `creature_template` SET `mindmg` = 363, `maxdmg` = 482, `DamageModifier` = 1 WHERE `entry` = 13601;

-- The Temple of Atal'Hakkar (50-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Spawn of Hakkar
UPDATE `creature_template` SET `mindmg` = 256, `maxdmg` = 340, `DamageModifier` = 1 WHERE `entry` = 5708;
-- Shade of Eranikus
UPDATE `creature_template` SET `mindmg` = 508, `maxdmg` = 673, `DamageModifier` = 1 WHERE `entry` = 5709;
-- Jammal'an the Prophet
UPDATE `creature_template` SET `mindmg` = 268, `maxdmg` = 355, `DamageModifier` = 1 WHERE `entry` = 5710;
-- Ogom the Wretched
UPDATE `creature_template` SET `mindmg` = 254, `maxdmg` = 336, `DamageModifier` = 1 WHERE `entry` = 5711;
-- Zolo
UPDATE `creature_template` SET `mindmg` = 154, `maxdmg` = 204, `DamageModifier` = 1 WHERE `entry` = 5712;
-- Gasher
UPDATE `creature_template` SET `mindmg` = 289, `maxdmg` = 383, `DamageModifier` = 1 WHERE `entry` = 5713;
-- Loro
UPDATE `creature_template` SET `mindmg` = 330, `maxdmg` = 438, `DamageModifier` = 1 WHERE `entry` = 5714;
-- Hukku
UPDATE `creature_template` SET `mindmg` = 227, `maxdmg` = 301, `DamageModifier` = 1 WHERE `entry` = 5715;
-- Zul'Lor
UPDATE `creature_template` SET `mindmg` = 116, `maxdmg` = 153, `DamageModifier` = 1 WHERE `entry` = 5716;
-- Mijan
UPDATE `creature_template` SET `mindmg` = 246, `maxdmg` = 326, `DamageModifier` = 1 WHERE `entry` = 5717;
-- Morphaz
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 393, `DamageModifier` = 1 WHERE `entry` = 5719;
-- Weaver
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 224, `DamageModifier` = 1 WHERE `entry` = 5720;
-- Dreamscythe
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 393, `DamageModifier` = 1 WHERE `entry` = 5721;
-- Hazzas
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 393, `DamageModifier` = 1 WHERE `entry` = 5722;
-- Avatar of Hakkar (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=8443 / https://db.rising-gods.de/?npc=8443
UPDATE `creature_template` SET `mindmg` = 381, `maxdmg` = 518, `DamageModifier` = 1 WHERE `entry` = 8443;
-- Atal'alarion
UPDATE `creature_template` SET `mindmg` = 743, `maxdmg` = 986, `DamageModifier` = 1 WHERE `entry` = 8580;

-- Blackrock Depths (52-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Panzor the Invincible
UPDATE `creature_template` SET `mindmg` = 575, `maxdmg` = 763, `DamageModifier` = 1 WHERE `entry` = 8923;
-- Princess Moira Bronzebeard
UPDATE `creature_template` SET `mindmg` = 394, `maxdmg` = 522, `DamageModifier` = 1 WHERE `entry` = 8929;
-- Golem Lord Argelmach
UPDATE `creature_template` SET `mindmg` = 547, `maxdmg` = 725, `DamageModifier` = 1 WHERE `entry` = 8983;
-- Bael'Gar
UPDATE `creature_template` SET `mindmg` = 636, `maxdmg` = 844, `DamageModifier` = 1 WHERE `entry` = 9016;
-- Lord Incendius
UPDATE `creature_template` SET `mindmg` = 450, `maxdmg` = 597, `DamageModifier` = 1 WHERE `entry` = 9017;
-- High Interrogator Gerstahn
UPDATE `creature_template` SET `mindmg` = 271, `maxdmg` = 359, `DamageModifier` = 1 WHERE `entry` = 9018;
-- Emperor Dagran Thaurissan
UPDATE `creature_template` SET `mindmg` = 695, `maxdmg` = 922, `DamageModifier` = 1 WHERE `entry` = 9019;
-- Pyromancer Loregrain
UPDATE `creature_template` SET `mindmg` = 266, `maxdmg` = 352, `DamageModifier` = 1 WHERE `entry` = 9024;
-- Lord Roccor
UPDATE `creature_template` SET `mindmg` = 311, `maxdmg` = 412, `DamageModifier` = 1 WHERE `entry` = 9025;
-- Overmaster Pyron
UPDATE `creature_template` SET `mindmg` = 257, `maxdmg` = 340, `DamageModifier` = 1 WHERE `entry` = 9026;
-- Gorosh the Dervish
UPDATE `creature_template` SET `mindmg` = 477, `maxdmg` = 633, `DamageModifier` = 1 WHERE `entry` = 9027;
-- Grizzle
UPDATE `creature_template` SET `mindmg` = 530, `maxdmg` = 703, `DamageModifier` = 1 WHERE `entry` = 9028;
-- Eviscerator
UPDATE `creature_template` SET `mindmg` = 401, `maxdmg` = 531, `DamageModifier` = 1 WHERE `entry` = 9029;
-- Ok'thor the Breaker
UPDATE `creature_template` SET `mindmg` = 349, `maxdmg` = 463, `DamageModifier` = 1 WHERE `entry` = 9030;
-- Anub'shiah
UPDATE `creature_template` SET `mindmg` = 444, `maxdmg` = 588, `DamageModifier` = 1 WHERE `entry` = 9031;
-- Hedrum the Creeper
UPDATE `creature_template` SET `mindmg` = 583, `maxdmg` = 774, `DamageModifier` = 1 WHERE `entry` = 9032;
-- General Angerforge
UPDATE `creature_template` SET `mindmg` = 550, `maxdmg` = 730, `DamageModifier` = 1 WHERE `entry` = 9033;
-- Hate'rel
UPDATE `creature_template` SET `mindmg` = 350, `maxdmg` = 464, `DamageModifier` = 1 WHERE `entry` = 9034;
-- Anger'rel
UPDATE `creature_template` SET `mindmg` = 376, `maxdmg` = 499, `DamageModifier` = 1 WHERE `entry` = 9035;
-- Vile'rel
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 425, `DamageModifier` = 1 WHERE `entry` = 9036;
-- Gloom'rel
UPDATE `creature_template` SET `mindmg` = 537, `maxdmg` = 712, `DamageModifier` = 1 WHERE `entry` = 9037;
-- Seeth'rel
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 425, `DamageModifier` = 1 WHERE `entry` = 9038;
-- Doom'rel
UPDATE `creature_template` SET `mindmg` = 330, `maxdmg` = 437, `DamageModifier` = 1 WHERE `entry` = 9039;
-- Dope'rel
UPDATE `creature_template` SET `mindmg` = 384, `maxdmg` = 509, `DamageModifier` = 1 WHERE `entry` = 9040;
-- Warder Stilgiss
UPDATE `creature_template` SET `mindmg` = 300, `maxdmg` = 397, `DamageModifier` = 1 WHERE `entry` = 9041;
-- Verek
UPDATE `creature_template` SET `mindmg` = 405, `maxdmg` = 538, `DamageModifier` = 1 WHERE `entry` = 9042;
-- Fineous Darkvire
UPDATE `creature_template` SET `mindmg` = 638, `maxdmg` = 788, `DamageModifier` = 1 WHERE `entry` = 9056;
-- Ambassador Flamelash
UPDATE `creature_template` SET `mindmg` = 470, `maxdmg` = 624, `DamageModifier` = 1 WHERE `entry` = 9156;
-- Houndmaster Grebmar
UPDATE `creature_template` SET `mindmg` = 327, `maxdmg` = 434, `DamageModifier` = 1 WHERE `entry` = 9319;
-- Plugger Spazzring
UPDATE `creature_template` SET `mindmg` = 331, `maxdmg` = 381, `DamageModifier` = 1 WHERE `entry` = 9499;
-- Phalanx
UPDATE `creature_template` SET `mindmg` = 658, `maxdmg` = 873, `DamageModifier` = 1 WHERE `entry` = 9502;
-- Hurley Blackbreath (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=9537 / https://db.rising-gods.de/?npc=9537
UPDATE `creature_template` SET `mindmg` = 705, `maxdmg` = 935, `DamageModifier` = 1 WHERE `entry` = 9537; 
-- Ribbly Screwspigot
UPDATE `creature_template` SET `mindmg` = 297, `maxdmg` = 394, `DamageModifier` = 1 WHERE `entry` = 9543; 
-- Magmus
UPDATE `creature_template` SET `mindmg` = 806, `maxdmg` = 1068, `DamageModifier` = 1 WHERE `entry` = 9938; 
-- Theldren
UPDATE `creature_template` SET `mindmg` = 403, `maxdmg` = 514, `DamageModifier` = 1 WHERE `entry` = 16059; 

-- Blackrock Spire: Lower (55-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Highlord Omokk
UPDATE `creature_template` SET `mindmg` = 783, `maxdmg` = 1039, `DamageModifier` = 1 WHERE `entry` = 9196; 
-- Spirestone Lord Magus
UPDATE `creature_template` SET `mindmg` = 557, `maxdmg` = 738, `DamageModifier` = 1 WHERE `entry` = 9217; 
-- Spirestone Battle Lord
UPDATE `creature_template` SET `mindmg` = 599, `maxdmg` = 794, `DamageModifier` = 1 WHERE `entry` = 9218; 
-- Spirestone Butcher
UPDATE `creature_template` SET `mindmg` = 587, `maxdmg` = 779, `DamageModifier` = 1 WHERE `entry` = 9219; 
-- Shadow Hunter Vosh'gajin
UPDATE `creature_template` SET `mindmg` = 483, `maxdmg` = 640, `DamageModifier` = 1 WHERE `entry` = 9236; 
-- War Master Voone
UPDATE `creature_template` SET `mindmg` = 748, `maxdmg` = 992, `DamageModifier` = 1 WHERE `entry` = 9237; 
-- Overlord Wyrmthalak
UPDATE `creature_template` SET `mindmg` = 727, `maxdmg` = 965, `DamageModifier` = 1 WHERE `entry` = 9568; 
-- Bannok Grimaxe
UPDATE `creature_template` SET `mindmg` = 153, `maxdmg` = 203, `DamageModifier` = 1 WHERE `entry` = 9596; 
-- Ghok Bashguud
UPDATE `creature_template` SET `mindmg` = 397, `maxdmg` = 527, `DamageModifier` = 1 WHERE `entry` = 9718; 
-- Quartermaster Zigris
UPDATE `creature_template` SET `mindmg` = 509, `maxdmg` = 675, `DamageModifier` = 1 WHERE `entry` = 9736; 
-- Halycon
UPDATE `creature_template` SET `mindmg` = 364, `maxdmg` = 483, `DamageModifier` = 1 WHERE `entry` = 10220; 
-- Burning Felguard
UPDATE `creature_template` SET `mindmg` = 496, `maxdmg` = 672, `DamageModifier` = 1 WHERE `entry` = 10263; 
-- Gizrul the Slavener
UPDATE `creature_template` SET `mindmg` = 676, `maxdmg` = 896, `DamageModifier` = 1 WHERE `entry` = 10268; 
-- Crystal Fang
UPDATE `creature_template` SET `mindmg` = 288, `maxdmg` = 383, `DamageModifier` = 1 WHERE `entry` = 10376; 
-- Urok Doomhowl
UPDATE `creature_template` SET `mindmg` = 774, `maxdmg` = 1025, `DamageModifier` = 1 WHERE `entry` = 10584; 
-- Mother Smolderweb
UPDATE `creature_template` SET `mindmg` = 435, `maxdmg` = 577, `DamageModifier` = 1 WHERE `entry` = 10596;
-- Mor Grayhoof
UPDATE `creature_template` SET `mindmg` = 813, `maxdmg` = 1076, `DamageModifier` = 1 WHERE `entry` = 16080;

-- Blackrock Spire: Upper (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Pyroguard Emberseer
UPDATE `creature_template` SET `mindmg` = 624, `maxdmg` = 827, `DamageModifier` = 1 WHERE `entry` = 9816;
-- Solakar Flamewreath
UPDATE `creature_template` SET `mindmg` = 624, `maxdmg` = 827, `DamageModifier` = 1 WHERE `entry` = 10264;
-- Gyth
UPDATE `creature_template` SET `mindmg` = 539, `maxdmg` = 716, `DamageModifier` = 1 WHERE `entry` = 10339;
-- General Drakkisath
UPDATE `creature_template` SET `mindmg` = 1079, `maxdmg` = 1431, `DamageModifier` = 1 WHERE `entry` = 10363;
-- Warchief Rend Blackhand
UPDATE `creature_template` SET `mindmg` = 842, `maxdmg` = 1116, `DamageModifier` = 1 WHERE `entry` = 10429;
-- The Beast 
UPDATE `creature_template` SET `mindmg` = 1079, `maxdmg` = 1431, `DamageModifier` = 1 WHERE `entry` = 10430;
-- Jed Runewatcher (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=10509 / https://db.rising-gods.de/?npc=10509
UPDATE `creature_template` SET `mindmg` = 762, `maxdmg` = 1010, `DamageModifier` = 1 WHERE `entry` = 10509;
-- Goraluk Anvilcrack
UPDATE `creature_template` SET `mindmg` = 635, `maxdmg` = 842, `DamageModifier` = 1 WHERE `entry` = 10899;
-- Lord Valthalak
UPDATE `creature_template` SET `mindmg` = 1329, `maxdmg` = 1759, `DamageModifier` = 1 WHERE `entry` = 16042;

-- Scholomance (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Darkmaster Gandling
UPDATE `creature_template` SET `mindmg` = 246, `maxdmg` = 326, `DamageModifier` = 1 WHERE `entry` = 1853;
-- Vectus
UPDATE `creature_template` SET `mindmg` = 435, `maxdmg` = 577, `DamageModifier` = 1 WHERE `entry` = 10432;
-- Marduk Blackpool
UPDATE `creature_template` SET `mindmg` = 580, `maxdmg` = 769, `DamageModifier` = 1 WHERE `entry` = 10433;
-- Lady Illucia Barov
UPDATE `creature_template` SET `mindmg` = 629, `maxdmg` = 833, `DamageModifier` = 1 WHERE `entry` = 10502;
-- Jandice Barov
UPDATE `creature_template` SET `mindmg` = 493, `maxdmg` = 652, `DamageModifier` = 1 WHERE `entry` = 10503;
-- Lord Alexei Barov
UPDATE `creature_template` SET `mindmg` = 624, `maxdmg` = 827, `DamageModifier` = 1 WHERE `entry` = 10504;
-- Instructor Malicia
UPDATE `creature_template` SET `mindmg` = 484, `maxdmg` = 641, `DamageModifier` = 1 WHERE `entry` = 10505;
-- Kirtonos the Herald
UPDATE `creature_template` SET `mindmg` = 1161, `maxdmg` = 1538, `DamageModifier` = 1 WHERE `entry` = 10506;
-- The Ravenian (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=10507 / https://db.rising-gods.de/?npc=10507
UPDATE `creature_template` SET `mindmg` = 362, `maxdmg` = 479, `DamageModifier` = 1 WHERE `entry` = 10507;
-- Ras Frostwhisper
UPDATE `creature_template` SET `mindmg` = 402, `maxdmg` = 532, `DamageModifier` = 1 WHERE `entry` = 10508;
-- Lorekeeper Polkelt
UPDATE `creature_template` SET `mindmg` = 416, `maxdmg` = 552, `DamageModifier` = 1 WHERE `entry` = 10901;
-- Doctor Theolen Krastinov
UPDATE `creature_template` SET `mindmg` = 857, `maxdmg` = 1138, `DamageModifier` = 1 WHERE `entry` = 11261;
-- Rattlegore
UPDATE `creature_template` SET `mindmg` = 690, `maxdmg` = 913, `DamageModifier` = 1 WHERE `entry` = 11622;
-- Death Knight Darkreaver
UPDATE `creature_template` SET `mindmg` = 903, `maxdmg` = 1197, `DamageModifier` = 1 WHERE `entry` = 14516;
-- Blood Steward of Kirtonos
UPDATE `creature_template` SET `mindmg` = 443, `maxdmg` = 587, `DamageModifier` = 1 WHERE `entry` = 14861;
-- Kormok
UPDATE `creature_template` SET `mindmg` = 813, `maxdmg` = 1076, `DamageModifier` = 1 WHERE `entry` = 16118;

-- Stratholme (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Skul
UPDATE `creature_template` SET `mindmg` = 387, `maxdmg` = 511, `DamageModifier` = 1 WHERE `entry` = 10393;
-- Magistrate Barthilas
UPDATE `creature_template` SET `mindmg` = 898, `maxdmg` = 1191, `DamageModifier` = 1 WHERE `entry` = 10435;
-- Baroness Anastari
UPDATE `creature_template` SET `mindmg` = 687, `maxdmg` = 910, `DamageModifier` = 1 WHERE `entry` = 10436;
-- Nerub'enkan
UPDATE `creature_template` SET `mindmg` = 779, `maxdmg` = 1034, `DamageModifier` = 1 WHERE `entry` = 10437;
-- Maleki the Pallid
UPDATE `creature_template` SET `mindmg` = 448, `maxdmg` = 624, `DamageModifier` = 1 WHERE `entry` = 10438;
-- Ramstein the Gorger
UPDATE `creature_template` SET `mindmg` = 1190, `maxdmg` = 1578, `DamageModifier` = 1 WHERE `entry` = 10439;
-- Baron Rivendare (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=10440 / https://db.rising-gods.de/?npc=10440 
UPDATE `creature_template` SET `mindmg` = 351, `maxdmg` = 465, `DamageModifier` = 1 WHERE `entry` = 10440;
-- The Unforgiven
UPDATE `creature_template` SET `mindmg` = 362, `maxdmg` = 480, `DamageModifier` = 1 WHERE `entry` = 10516;
-- Hearthsinger Forresten
UPDATE `creature_template` SET `mindmg` = 392, `maxdmg` = 519, `DamageModifier` = 1 WHERE `entry` = 10558;
-- Timmy the Cruel
UPDATE `creature_template` SET `mindmg` = 908, `maxdmg` = 1204, `DamageModifier` = 1 WHERE `entry` = 10808;
-- Stonespine
UPDATE `creature_template` SET `mindmg` = 520, `maxdmg` = 689, `DamageModifier` = 1 WHERE `entry` = 10809;
-- Archivist Galford
UPDATE `creature_template` SET `mindmg` = 629, `maxdmg` = 833, `DamageModifier` = 1 WHERE `entry` = 10811;
-- Balnazzar
UPDATE `creature_template` SET `mindmg` = 904, `maxdmg` = 1197, `DamageModifier` = 1 WHERE `entry` = 10813;
-- Cannon Master Willey
UPDATE `creature_template` SET `mindmg` = 727, `maxdmg` = 965, `DamageModifier` = 1 WHERE `entry` = 10997;
-- Malor the Zealous
UPDATE `creature_template` SET `mindmg` = 653, `maxdmg` = 865, `DamageModifier` = 1 WHERE `entry` = 11032;
-- Fras Siabi
UPDATE `creature_template` SET `mindmg` = 899, `maxdmg` = 1193, `DamageModifier` = 1 WHERE `entry` = 11058;
-- Crimson Hammersmith
UPDATE `creature_template` SET `mindmg` = 624, `maxdmg` = 827, `DamageModifier` = 1 WHERE `entry` = 11120;
-- Black Guard Swordsmith (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=11121 / https://db.rising-gods.de/?npc=11121
UPDATE `creature_template` SET `mindmg` = 448, `maxdmg` = 603, `DamageModifier` = 1 WHERE `entry` = 11121;
-- Postmaster Malown
UPDATE `creature_template` SET `mindmg` = 878, `maxdmg` = 1163, `DamageModifier` = 1 WHERE `entry` = 11143;
-- Jarien
UPDATE `creature_template` SET `mindmg` = 503, `maxdmg` = 666, `DamageModifier` = 1 WHERE `entry` = 16101;
-- Sothos
UPDATE `creature_template` SET `mindmg` = 503, `maxdmg` = 666, `DamageModifier` = 1 WHERE `entry` = 16102;
-- Atiesh
UPDATE `creature_template` SET `mindmg` = 4572, `maxdmg` = 5646, `DamageModifier` = 1 WHERE `entry` = 16387;

-- Dire Maul East (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Zevrim Thornhoof
UPDATE `creature_template` SET `mindmg` = 636, `maxdmg` = 844, `DamageModifier` = 1 WHERE `entry` = 11490;
-- Alzzin the Wildshaper
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 440, `DamageModifier` = 1 WHERE `entry` = 11492;
-- Hydrospawn
UPDATE `creature_template` SET `mindmg` = 592, `maxdmg` = 785, `DamageModifier` = 1 WHERE `entry` = 13280;
-- Lethtendris
UPDATE `creature_template` SET `mindmg` = 547, `maxdmg` = 724, `DamageModifier` = 1 WHERE `entry` = 14327;
-- Pimgib
UPDATE `creature_template` SET `mindmg` = 357, `maxdmg` = 473, `DamageModifier` = 1 WHERE `entry` = 14349;
-- Pusillin
UPDATE `creature_template` SET `mindmg` = 365, `maxdmg` = 483, `DamageModifier` = 1 WHERE `entry` = 14354;
-- Isalien
UPDATE `creature_template` SET `mindmg` = 755, `maxdmg` = 1000, `DamageModifier` = 1 WHERE `entry` = 16097;

-- Dire Maul West (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Tsu'zee
UPDATE `creature_template` SET `mindmg` = 652, `maxdmg` = 864, `DamageModifier` = 1 WHERE `entry` = 11467;
-- Prince Tortheldrin (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=11486 / https://db.rising-gods.de/?npc=11486
UPDATE `creature_template` SET `mindmg` = 395, `maxdmg` = 523, `DamageModifier` = 1 WHERE `entry` = 11486;
-- Magister Kalendris
UPDATE `creature_template` SET `mindmg` = 677, `maxdmg` = 897, `DamageModifier` = 1 WHERE `entry` = 11487;
-- Illyanna Ravenoak
UPDATE `creature_template` SET `mindmg` = 581, `maxdmg` = 769, `DamageModifier` = 1 WHERE `entry` = 11488;
-- Tendris Warpwood
UPDATE `creature_template` SET `mindmg` = 831, `maxdmg` = 1103, `DamageModifier` = 1 WHERE `entry` = 11489;
-- Immol'thar
UPDATE `creature_template` SET `mindmg` = 847, `maxdmg` = 1122, `DamageModifier` = 1 WHERE `entry` = 11496;
-- Lord Hel'nurath
UPDATE `creature_template` SET `mindmg` = 964, `maxdmg` = 1277, `DamageModifier` = 1 WHERE `entry` = 14506;

-- Dire Maul North (58-60)
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- King Gordok
UPDATE `creature_template` SET `mindmg` = 647, `maxdmg` = 859, `DamageModifier` = 1 WHERE `entry` = 11501;
-- Guard Fengus
UPDATE `creature_template` SET `mindmg` = 713, `maxdmg` = 945, `DamageModifier` = 1 WHERE `entry` = 14321;
-- Stomper Kreeg
UPDATE `creature_template` SET `mindmg` = 815, `maxdmg` = 1080, `DamageModifier` = 1 WHERE `entry` = 14322;
-- Guard Slip'kik
UPDATE `creature_template` SET `mindmg` = 713, `maxdmg` = 945, `DamageModifier` = 1 WHERE `entry` = 14323;
-- Cho'Rush the Observer
UPDATE `creature_template` SET `mindmg` = 242, `maxdmg` = 320, `DamageModifier` = 1 WHERE `entry` = 14324;
-- Captain Kromcrush
UPDATE `creature_template` SET `mindmg` = 847, `maxdmg` = 1122, `DamageModifier` = 1 WHERE `entry` = 14325;
-- Guard Mol'dar
UPDATE `creature_template` SET `mindmg` = 713, `maxdmg` = 945, `DamageModifier` = 1 WHERE `entry` = 14326;
-- Knot Thimblejack (Not listed in Beastiary) Src: https://wotlk.evowow.com/?npc=14338 / https://db.rising-gods.de/?npc=14338
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 426, `DamageModifier` = 1 WHERE `entry` = 14338;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE rangedmg values based on the factor of increasing / decreasing `mindmg` and` maxdmg`
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- EXAMPLE: Oggleflint (11517) `mindmg` = 23
-- increasing value from `mindmg` to 51 results an increase in % 121,74
-- new_`minrangedmg` = `minrangedmg` 16 * (100 + 121,74) / 100 = 35,4784 ~ `minrangedmg`= 35
-- -------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE `creature_template` SET `minrangedmg` = 17, `maxrangedmg` = 24 WHERE `entry` = 596;
UPDATE `creature_template` SET `minrangedmg` = 21, `maxrangedmg` = 29 WHERE `entry` = 599;
UPDATE `creature_template` SET `minrangedmg` = 21, `maxrangedmg` = 31 WHERE `entry` = 626;
UPDATE `creature_template` SET `minrangedmg` = 37, `maxrangedmg` = 56 WHERE `entry` = 639;
UPDATE `creature_template` SET `minrangedmg` = 67, `maxrangedmg` = 100 WHERE `entry` = 642;
UPDATE `creature_template` SET `minrangedmg` = 67, `maxrangedmg` = 100 WHERE `entry` = 643;
UPDATE `creature_template` SET `minrangedmg` = 84, `maxrangedmg` = 119 WHERE `entry` = 644;
UPDATE `creature_template` SET `minrangedmg` = 50, `maxrangedmg` = 74 WHERE `entry` = 645;
UPDATE `creature_template` SET `minrangedmg` = 50, `maxrangedmg` = 74 WHERE `entry` = 646;
UPDATE `creature_template` SET `minrangedmg` = 62, `maxrangedmg` = 93 WHERE `entry` = 647;
UPDATE `creature_template` SET `minrangedmg` = 50, `maxrangedmg` = 75 WHERE `entry` = 1663;
UPDATE `creature_template` SET `minrangedmg` = 45, `maxrangedmg` = 67 WHERE `entry` = 1666;
UPDATE `creature_template` SET `minrangedmg` = 40, `maxrangedmg` = 59 WHERE `entry` = 1696;
UPDATE `creature_template` SET `minrangedmg` = 59, `maxrangedmg` = 88 WHERE `entry` = 1716;
UPDATE `creature_template` SET `minrangedmg` = 58, `maxrangedmg` = 78 WHERE `entry` = 1717;
UPDATE `creature_template` SET `minrangedmg` = 59, `maxrangedmg` = 88 WHERE `entry` = 1720;
UPDATE `creature_template` SET `minrangedmg` = 50, `maxrangedmg` = 74 WHERE `entry` = 1763;
UPDATE `creature_template` SET `minrangedmg` = 194, `maxrangedmg` = 290 WHERE `entry` = 1853;
UPDATE `creature_template` SET `minrangedmg` = 22, `maxrangedmg` = 33 WHERE `entry` = 2683;
UPDATE `creature_template` SET `minrangedmg` = 137, `maxrangedmg` = 201 WHERE `entry` = 2748;
UPDATE `creature_template` SET `minrangedmg` = 33, `maxrangedmg` = 47 WHERE `entry` = 3586;
UPDATE `creature_template` SET `minrangedmg` = 34, `maxrangedmg` = 52 WHERE `entry` = 3653;
UPDATE `creature_template` SET `minrangedmg` = 48, `maxrangedmg` = 72 WHERE `entry` = 3654;
UPDATE `creature_template` SET `minrangedmg` = 48, `maxrangedmg` = 71 WHERE `entry` = 3669;
UPDATE `creature_template` SET `minrangedmg` = 55, `maxrangedmg` = 81 WHERE `entry` = 3670;
UPDATE `creature_template` SET `minrangedmg` = 48, `maxrangedmg` = 71 WHERE `entry` = 3671;
UPDATE `creature_template` SET `minrangedmg` = 55, `maxrangedmg` = 81 WHERE `entry` = 3673;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 3674;
UPDATE `creature_template` SET `minrangedmg` = 34, `maxrangedmg` = 49 WHERE `entry` = 3864;
UPDATE `creature_template` SET `minrangedmg` = 143, `maxrangedmg` = 203 WHERE `entry` = 3865;
UPDATE `creature_template` SET `minrangedmg` = 33, `maxrangedmg` = 47 WHERE `entry` = 3872;
UPDATE `creature_template` SET `minrangedmg` = 79, `maxrangedmg` = 119 WHERE `entry` = 3886;
UPDATE `creature_template` SET `minrangedmg` = 34, `maxrangedmg` = 52 WHERE `entry` = 3887;
UPDATE `creature_template` SET `minrangedmg` = 37, `maxrangedmg` = 56 WHERE `entry` = 3914;
UPDATE `creature_template` SET `minrangedmg` = 68, `maxrangedmg` = 98 WHERE `entry` = 3927;
UPDATE `creature_template` SET `minrangedmg` = 107, `maxrangedmg` = 124 WHERE `entry` = 3974;
UPDATE `creature_template` SET `minrangedmg` = 167, `maxrangedmg` = 248 WHERE `entry` = 3975;
UPDATE `creature_template` SET `minrangedmg` = 111, `maxrangedmg` = 164 WHERE `entry` = 3976;
UPDATE `creature_template` SET `minrangedmg` = 86, `maxrangedmg` = 126 WHERE `entry` = 3977;
UPDATE `creature_template` SET `minrangedmg` = 62, `maxrangedmg` = 90 WHERE `entry` = 3983;
UPDATE `creature_template` SET `minrangedmg` = 68, `maxrangedmg` = 98 WHERE `entry` = 4274;
UPDATE `creature_template` SET `minrangedmg` = 110, `maxrangedmg` = 168 WHERE `entry` = 4275;
UPDATE `creature_template` SET `minrangedmg` = 48, `maxrangedmg` = 71 WHERE `entry` = 4278;
UPDATE `creature_template` SET `minrangedmg` = 45, `maxrangedmg` = 64 WHERE `entry` = 4279;
UPDATE `creature_template` SET `minrangedmg` = 44, `maxrangedmg` = 67 WHERE `entry` = 4420;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 4421;
UPDATE `creature_template` SET `minrangedmg` = 44, `maxrangedmg` = 67 WHERE `entry` = 4422;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 4424;
UPDATE `creature_template` SET `minrangedmg` = 44, `maxrangedmg` = 67 WHERE `entry` = 4425;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 4428;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 4438;
UPDATE `creature_template` SET `minrangedmg` = 103, `maxrangedmg` = 152 WHERE `entry` = 4542;
UPDATE `creature_template` SET `minrangedmg` = 49, `maxrangedmg` = 71 WHERE `entry` = 4543;
UPDATE `creature_template` SET `minrangedmg` = 106, `maxrangedmg` = 157 WHERE `entry` = 4829;
UPDATE `creature_template` SET `minrangedmg` = 40, `maxrangedmg` = 59 WHERE `entry` = 4830;
UPDATE `creature_template` SET `minrangedmg` = 35, `maxrangedmg` = 52 WHERE `entry` = 4831;
UPDATE `creature_template` SET `minrangedmg` = 38, `maxrangedmg` = 55 WHERE `entry` = 4832;
UPDATE `creature_template` SET `minrangedmg` = 41, `maxrangedmg` = 61 WHERE `entry` = 4842;
UPDATE `creature_template` SET `minrangedmg` = 90, `maxrangedmg` = 133 WHERE `entry` = 4854;
UPDATE `creature_template` SET `minrangedmg` = 37, `maxrangedmg` = 56 WHERE `entry` = 4887;
UPDATE `creature_template` SET `minrangedmg` = 176, `maxrangedmg` = 259 WHERE `entry` = 5708;
UPDATE `creature_template` SET `minrangedmg` = 347, `maxrangedmg` = 514 WHERE `entry` = 5709;
UPDATE `creature_template` SET `minrangedmg` = 183, `maxrangedmg` = 268 WHERE `entry` = 5710;
UPDATE `creature_template` SET `minrangedmg` = 172, `maxrangedmg` = 254 WHERE `entry` = 5711;
UPDATE `creature_template` SET `minrangedmg` = 104, `maxrangedmg` = 154 WHERE `entry` = 5712;
UPDATE `creature_template` SET `minrangedmg` = 198, `maxrangedmg` = 292 WHERE `entry` = 5713;
UPDATE `creature_template` SET `minrangedmg` = 227, `maxrangedmg` = 334 WHERE `entry` = 5714;
UPDATE `creature_template` SET `minrangedmg` = 192, `maxrangedmg` = 282 WHERE `entry` = 5715;
UPDATE `creature_template` SET `minrangedmg` = 80, `maxrangedmg` = 117 WHERE `entry` = 5716;
UPDATE `creature_template` SET `minrangedmg` = 166, `maxrangedmg` = 246 WHERE `entry` = 5717;
UPDATE `creature_template` SET `minrangedmg` = 202, `maxrangedmg` = 299 WHERE `entry` = 5719;
UPDATE `creature_template` SET `minrangedmg` = 115, `maxrangedmg` = 171 WHERE `entry` = 5720;
UPDATE `creature_template` SET `minrangedmg` = 202, `maxrangedmg` = 299 WHERE `entry` = 5721;
UPDATE `creature_template` SET `minrangedmg` = 202, `maxrangedmg` = 299 WHERE `entry` = 5722;
UPDATE `creature_template` SET `minrangedmg` = 191, `maxrangedmg` = 287 WHERE `entry` = 5775;
UPDATE `creature_template` SET `minrangedmg` = 33, `maxrangedmg` = 47 WHERE `entry` = 5912;
UPDATE `creature_template` SET `minrangedmg` = 39, `maxrangedmg` = 58 WHERE `entry` = 6168;
UPDATE `creature_template` SET `minrangedmg` = 64, `maxrangedmg` = 94 WHERE `entry` = 6228;
UPDATE `creature_template` SET `minrangedmg` = 51, `maxrangedmg` = 76 WHERE `entry` = 6229;
UPDATE `creature_template` SET `minrangedmg` = 25, `maxrangedmg` = 37 WHERE `entry` = 6231;
UPDATE `creature_template` SET `minrangedmg` = 66, `maxrangedmg` = 97 WHERE `entry` = 6235;
UPDATE `creature_template` SET `minrangedmg` = 34, `maxrangedmg` = 50 WHERE `entry` = 6243;
UPDATE `creature_template` SET `minrangedmg` = 66, `maxrangedmg` = 97 WHERE `entry` = 6487;
UPDATE `creature_template` SET `minrangedmg` = 83, `maxrangedmg` = 123 WHERE `entry` = 6488;
UPDATE `creature_template` SET `minrangedmg` = 52, `maxrangedmg` = 78 WHERE `entry` = 6489;
UPDATE `creature_template` SET `minrangedmg` = 49, `maxrangedmg` = 71 WHERE `entry` = 6490;
UPDATE `creature_template` SET `minrangedmg` = 31, `maxrangedmg` = 46 WHERE `entry` = 6575;
UPDATE `creature_template` SET `minrangedmg` = 101, `maxrangedmg` = 151 WHERE `entry` = 6906;
UPDATE `creature_template` SET `minrangedmg` = 69, `maxrangedmg` = 101 WHERE `entry` = 6910;
UPDATE `creature_template` SET `minrangedmg` = 137, `maxrangedmg` = 200 WHERE `entry` = 7023;
UPDATE `creature_template` SET `minrangedmg` = 107, `maxrangedmg` = 158 WHERE `entry` = 7057;
UPDATE `creature_template` SET `minrangedmg` = 46, `maxrangedmg` = 69 WHERE `entry` = 7079;
UPDATE `creature_template` SET `minrangedmg` = 164, `maxrangedmg` = 239 WHERE `entry` = 7206;
UPDATE `creature_template` SET `minrangedmg` = 243, `maxrangedmg` = 361 WHERE `entry` = 7228;
UPDATE `creature_template` SET `minrangedmg` = 170, `maxrangedmg` = 250 WHERE `entry` = 7267;
UPDATE `creature_template` SET `minrangedmg` = 127, `maxrangedmg` = 187 WHERE `entry` = 7271;
UPDATE `creature_template` SET `minrangedmg` = 173, `maxrangedmg` = 254 WHERE `entry` = 7272;
UPDATE `creature_template` SET `minrangedmg` = 186, `maxrangedmg` = 274 WHERE `entry` = 7273;
UPDATE `creature_template` SET `minrangedmg` = 221, `maxrangedmg` = 325 WHERE `entry` = 7274;
UPDATE `creature_template` SET `minrangedmg` = 132, `maxrangedmg` = 194 WHERE `entry` = 7275;
UPDATE `creature_template` SET `minrangedmg` = 87, `maxrangedmg` = 127 WHERE `entry` = 7291;
UPDATE `creature_template` SET `minrangedmg` = 62, `maxrangedmg` = 92 WHERE `entry` = 7354;
UPDATE `creature_template` SET `minrangedmg` = 88, `maxrangedmg` = 131 WHERE `entry` = 7355;
UPDATE `creature_template` SET `minrangedmg` = 71, `maxrangedmg` = 105 WHERE `entry` = 7356;
UPDATE `creature_template` SET `minrangedmg` = 76, `maxrangedmg` = 112 WHERE `entry` = 7357;
UPDATE `creature_template` SET `minrangedmg` = 131, `maxrangedmg` = 191 WHERE `entry` = 7358;
UPDATE `creature_template` SET `minrangedmg` = 66, `maxrangedmg` = 97 WHERE `entry` = 7361;
UPDATE `creature_template` SET `minrangedmg` = 65, `maxrangedmg` = 95 WHERE `entry` = 7604;
UPDATE `creature_template` SET `minrangedmg` = 145, `maxrangedmg` = 211 WHERE `entry` = 7795;
UPDATE `creature_template` SET `minrangedmg` = 168, `maxrangedmg` = 246 WHERE `entry` = 7796;
UPDATE `creature_template` SET `minrangedmg` = 242, `maxrangedmg` = 354 WHERE `entry` = 7797;
UPDATE `creature_template` SET `minrangedmg` = 66, `maxrangedmg` = 97 WHERE `entry` = 7800;
UPDATE `creature_template` SET `minrangedmg` = 208, `maxrangedmg` = 305 WHERE `entry` = 8127;
UPDATE `creature_template` SET `minrangedmg` = 260, `maxrangedmg` = 385 WHERE `entry` = 8443;
UPDATE `creature_template` SET `minrangedmg` = 148, `maxrangedmg` = 219 WHERE `entry` = 8567;
UPDATE `creature_template` SET `minrangedmg` = 510, `maxrangedmg` = 752 WHERE `entry` = 8580;
UPDATE `creature_template` SET `minrangedmg` = 401, `maxrangedmg` = 581 WHERE `entry` = 8923;
UPDATE `creature_template` SET `minrangedmg` = 272, `maxrangedmg` = 399 WHERE `entry` = 8929;
UPDATE `creature_template` SET `minrangedmg` = 377, `maxrangedmg` = 553 WHERE `entry` = 8983;
UPDATE `creature_template` SET `minrangedmg` = 446, `maxrangedmg` = 658 WHERE `entry` = 9016;
UPDATE `creature_template` SET `minrangedmg` = 313, `maxrangedmg` = 460 WHERE `entry` = 9017;
UPDATE `creature_template` SET `minrangedmg` = 185, `maxrangedmg` = 274 WHERE `entry` = 9018;
UPDATE `creature_template` SET `minrangedmg` = 485, `maxrangedmg` = 702 WHERE `entry` = 9019;
UPDATE `creature_template` SET `minrangedmg` = 220, `maxrangedmg` = 325 WHERE `entry` = 9024;
UPDATE `creature_template` SET `minrangedmg` = 213, `maxrangedmg` = 315 WHERE `entry` = 9025;
UPDATE `creature_template` SET `minrangedmg` = 177, `maxrangedmg` = 260 WHERE `entry` = 9026;
UPDATE `creature_template` SET `minrangedmg` = 334, `maxrangedmg` = 493 WHERE `entry` = 9027;
UPDATE `creature_template` SET `minrangedmg` = 372, `maxrangedmg` = 548 WHERE `entry` = 9028;
UPDATE `creature_template` SET `minrangedmg` = 274, `maxrangedmg` = 406 WHERE `entry` = 9029;
UPDATE `creature_template` SET `minrangedmg` = 238, `maxrangedmg` = 353 WHERE `entry` = 9030;
UPDATE `creature_template` SET `minrangedmg` = 303, `maxrangedmg` = 449 WHERE `entry` = 9031;
UPDATE `creature_template` SET `minrangedmg` = 409, `maxrangedmg` = 603 WHERE `entry` = 9032;
UPDATE `creature_template` SET `minrangedmg` = 380, `maxrangedmg` = 556 WHERE `entry` = 9033;
UPDATE `creature_template` SET `minrangedmg` = 241, `maxrangedmg` = 354 WHERE `entry` = 9034;
UPDATE `creature_template` SET `minrangedmg` = 260, `maxrangedmg` = 380 WHERE `entry` = 9035;
UPDATE `creature_template` SET `minrangedmg` = 220, `maxrangedmg` = 325 WHERE `entry` = 9036;
UPDATE `creature_template` SET `minrangedmg` = 375, `maxrangedmg` = 543 WHERE `entry` = 9037;
UPDATE `creature_template` SET `minrangedmg` = 220, `maxrangedmg` = 325 WHERE `entry` = 9038;
UPDATE `creature_template` SET `minrangedmg` = 226, `maxrangedmg` = 334 WHERE `entry` = 9039;
UPDATE `creature_template` SET `minrangedmg` = 268, `maxrangedmg` = 388 WHERE `entry` = 9040;
UPDATE `creature_template` SET `minrangedmg` = 206, `maxrangedmg` = 300 WHERE `entry` = 9041;
UPDATE `creature_template` SET `minrangedmg` = 282, `maxrangedmg` = 414 WHERE `entry` = 9042;
UPDATE `creature_template` SET `minrangedmg` = 433, `maxrangedmg` = 638 WHERE `entry` = 9056;
UPDATE `creature_template` SET `minrangedmg` = 325, `maxrangedmg` = 475 WHERE `entry` = 9156;
UPDATE `creature_template` SET `minrangedmg` = 543, `maxrangedmg` = 791 WHERE `entry` = 9196;
UPDATE `creature_template` SET `minrangedmg` = 383, `maxrangedmg` = 563 WHERE `entry` = 9217;
UPDATE `creature_template` SET `minrangedmg` = 413, `maxrangedmg` = 605 WHERE `entry` = 9218;
UPDATE `creature_template` SET `minrangedmg` = 407, `maxrangedmg` = 593 WHERE `entry` = 9219;
UPDATE `creature_template` SET `minrangedmg` = 332, `maxrangedmg` = 488 WHERE `entry` = 9236;
UPDATE `creature_template` SET `minrangedmg` = 516, `maxrangedmg` = 755 WHERE `entry` = 9237;
UPDATE `creature_template` SET `minrangedmg` = 229, `maxrangedmg` = 338 WHERE `entry` = 9319;
UPDATE `creature_template` SET `minrangedmg` = 228, `maxrangedmg` = 335 WHERE `entry` = 9499;
UPDATE `creature_template` SET `minrangedmg` = 455, `maxrangedmg` = 665 WHERE `entry` = 9502;
UPDATE `creature_template` SET `minrangedmg` = 488, `maxrangedmg` = 713 WHERE `entry` = 9537;
UPDATE `creature_template` SET `minrangedmg` = 207, `maxrangedmg` = 304 WHERE `entry` = 9543;
UPDATE `creature_template` SET `minrangedmg` = 503, `maxrangedmg` = 741 WHERE `entry` = 9568;
UPDATE `creature_template` SET `minrangedmg` = 105, `maxrangedmg` = 155 WHERE `entry` = 9596;
UPDATE `creature_template` SET `minrangedmg` = 272, `maxrangedmg` = 401 WHERE `entry` = 9718;
UPDATE `creature_template` SET `minrangedmg` = 349, `maxrangedmg` = 514 WHERE `entry` = 9736;
UPDATE `creature_template` SET `minrangedmg` = 432, `maxrangedmg` = 636 WHERE `entry` = 9816;
UPDATE `creature_template` SET `minrangedmg` = 563, `maxrangedmg` = 814 WHERE `entry` = 9938;
UPDATE `creature_template` SET `minrangedmg` = 129, `maxrangedmg` = 189 WHERE `entry` = 10080;
UPDATE `creature_template` SET `minrangedmg` = 401, `maxrangedmg` = 591 WHERE `entry` = 10081;
UPDATE `creature_template` SET `minrangedmg` = 129, `maxrangedmg` = 189 WHERE `entry` = 10082;
UPDATE `creature_template` SET `minrangedmg` = 250, `maxrangedmg` = 368 WHERE `entry` = 10220;
UPDATE `creature_template` SET `minrangedmg` = 344, `maxrangedmg` = 501 WHERE `entry` = 10263;
UPDATE `creature_template` SET `minrangedmg` = 432, `maxrangedmg` = 636 WHERE `entry` = 10264;
UPDATE `creature_template` SET `minrangedmg` = 468, `maxrangedmg` = 689 WHERE `entry` = 10268;
UPDATE `creature_template` SET `minrangedmg` = 436, `maxrangedmg` = 649 WHERE `entry` = 10339;
UPDATE `creature_template` SET `minrangedmg` = 872, `maxrangedmg` = 1299 WHERE `entry` = 10363;
UPDATE `creature_template` SET `minrangedmg` = 199, `maxrangedmg` = 294 WHERE `entry` = 10376;
UPDATE `creature_template` SET `minrangedmg` = 322, `maxrangedmg` = 474 WHERE `entry` = 10393;
UPDATE `creature_template` SET `minrangedmg` = 680, `maxrangedmg` = 1013 WHERE `entry` = 10429;
UPDATE `creature_template` SET `minrangedmg` = 872, `maxrangedmg` = 1299 WHERE `entry` = 10430;
UPDATE `creature_template` SET `minrangedmg` = 301, `maxrangedmg` = 498 WHERE `entry` = 10432;
UPDATE `creature_template` SET `minrangedmg` = 399, `maxrangedmg` = 586 WHERE `entry` = 10433;
UPDATE `creature_template` SET `minrangedmg` = 620, `maxrangedmg` = 907 WHERE `entry` = 10435;
UPDATE `creature_template` SET `minrangedmg` = 470, `maxrangedmg` = 687 WHERE `entry` = 10436;
UPDATE `creature_template` SET `minrangedmg` = 539, `maxrangedmg` = 794 WHERE `entry` = 10437;
UPDATE `creature_template` SET `minrangedmg` = 404, `maxrangedmg` = 597 WHERE `entry` = 10438;
UPDATE `creature_template` SET `minrangedmg` = 951, `maxrangedmg` = 1407 WHERE `entry` = 10439;
UPDATE `creature_template` SET `minrangedmg` = 283, `maxrangedmg` = 419 WHERE `entry` = 10440;
UPDATE `creature_template` SET `minrangedmg` = 435, `maxrangedmg` = 719 WHERE `entry` = 10502;
UPDATE `creature_template` SET `minrangedmg` = 389, `maxrangedmg` = 581 WHERE `entry` = 10503;
UPDATE `creature_template` SET `minrangedmg` = 432, `maxrangedmg` = 636 WHERE `entry` = 10504;
UPDATE `creature_template` SET `minrangedmg` = 335, `maxrangedmg` = 554 WHERE `entry` = 10505;
UPDATE `creature_template` SET `minrangedmg` = 803, `maxrangedmg` = 1328 WHERE `entry` = 10506;
UPDATE `creature_template` SET `minrangedmg` = 251, `maxrangedmg` = 369 WHERE `entry` = 10507;
UPDATE `creature_template` SET `minrangedmg` = 324, `maxrangedmg` = 480 WHERE `entry` = 10508;
UPDATE `creature_template` SET `minrangedmg` = 523, `maxrangedmg` = 769 WHERE `entry` = 10509;
UPDATE `creature_template` SET `minrangedmg` = 251, `maxrangedmg` = 366 WHERE `entry` = 10516;
UPDATE `creature_template` SET `minrangedmg` = 272, `maxrangedmg` = 396 WHERE `entry` = 10558;
UPDATE `creature_template` SET `minrangedmg` = 535, `maxrangedmg` = 885 WHERE `entry` = 10584;
UPDATE `creature_template` SET `minrangedmg` = 299, `maxrangedmg` = 439 WHERE `entry` = 10596;
UPDATE `creature_template` SET `minrangedmg` = 627, `maxrangedmg` = 917 WHERE `entry` = 10808;
UPDATE `creature_template` SET `minrangedmg` = 360, `maxrangedmg` = 530 WHERE `entry` = 10809;
UPDATE `creature_template` SET `minrangedmg` = 435, `maxrangedmg` = 719 WHERE `entry` = 10811;
UPDATE `creature_template` SET `minrangedmg` = 731, `maxrangedmg` = 1088 WHERE `entry` = 10813;
UPDATE `creature_template` SET `minrangedmg` = 507, `maxrangedmg` = 751 WHERE `entry` = 10899;
UPDATE `creature_template` SET `minrangedmg` = 288, `maxrangedmg` = 424 WHERE `entry` = 10901;
UPDATE `creature_template` SET `minrangedmg` = 503, `maxrangedmg` = 741 WHERE `entry` = 10997;
UPDATE `creature_template` SET `minrangedmg` = 452, `maxrangedmg` = 747 WHERE `entry` = 11032;
UPDATE `creature_template` SET `minrangedmg` = 718, `maxrangedmg` = 1063 WHERE `entry` = 11058;
UPDATE `creature_template` SET `minrangedmg` = 432, `maxrangedmg` = 636 WHERE `entry` = 11120;
UPDATE `creature_template` SET `minrangedmg` = 362, `maxrangedmg` = 539 WHERE `entry` = 11121;
UPDATE `creature_template` SET `minrangedmg` = 607, `maxrangedmg` = 1004 WHERE `entry` = 11143;
UPDATE `creature_template` SET `minrangedmg` = 593, `maxrangedmg` = 873 WHERE `entry` = 11261;
UPDATE `creature_template` SET `minrangedmg` = 447, `maxrangedmg` = 658 WHERE `entry` = 11467;
UPDATE `creature_template` SET `minrangedmg` = 316, `maxrangedmg` = 467 WHERE `entry` = 11486;
UPDATE `creature_template` SET `minrangedmg` = 468, `maxrangedmg` = 774 WHERE `entry` = 11487;
UPDATE `creature_template` SET `minrangedmg` = 402, `maxrangedmg` = 665 WHERE `entry` = 11488;
UPDATE `creature_template` SET `minrangedmg` = 575, `maxrangedmg` = 847 WHERE `entry` = 11489;
UPDATE `creature_template` SET `minrangedmg` = 441, `maxrangedmg` = 642 WHERE `entry` = 11490;
UPDATE `creature_template` SET `minrangedmg` = 228, `maxrangedmg` = 336 WHERE `entry` = 11492;
UPDATE `creature_template` SET `minrangedmg` = 677, `maxrangedmg` = 1001 WHERE `entry` = 11496;
UPDATE `creature_template` SET `minrangedmg` = 523, `maxrangedmg` = 779 WHERE `entry` = 11501;
UPDATE `creature_template` SET `minrangedmg` = 35, `maxrangedmg` = 51 WHERE `entry` = 11517;
UPDATE `creature_template` SET `minrangedmg` = 35, `maxrangedmg` = 52 WHERE `entry` = 11518;
UPDATE `creature_template` SET `minrangedmg` = 35, `maxrangedmg` = 51 WHERE `entry` = 11519;
UPDATE `creature_template` SET `minrangedmg` = 39, `maxrangedmg` = 56 WHERE `entry` = 11520;
UPDATE `creature_template` SET `minrangedmg` = 545, `maxrangedmg` = 813 WHERE `entry` = 11622;
UPDATE `creature_template` SET `minrangedmg` = 279, `maxrangedmg` = 408 WHERE `entry` = 12201;
UPDATE `creature_template` SET `minrangedmg` = 279, `maxrangedmg` = 408 WHERE `entry` = 12203;
UPDATE `creature_template` SET `minrangedmg` = 220, `maxrangedmg` = 323 WHERE `entry` = 12225;
UPDATE `creature_template` SET `minrangedmg` = 196, `maxrangedmg` = 292 WHERE `entry` = 12236;
UPDATE `creature_template` SET `minrangedmg` = 200, `maxrangedmg` = 294 WHERE `entry` = 12237;
UPDATE `creature_template` SET `minrangedmg` = 160, `maxrangedmg` = 235 WHERE `entry` = 12258;
UPDATE `creature_template` SET `minrangedmg` = 47, `maxrangedmg` = 69 WHERE `entry` = 12876;
UPDATE `creature_template` SET `minrangedmg` = 38, `maxrangedmg` = 55 WHERE `entry` = 12902;
UPDATE `creature_template` SET `minrangedmg` = 403, `maxrangedmg` = 599 WHERE `entry` = 13280;
UPDATE `creature_template` SET `minrangedmg` = 186, `maxrangedmg` = 274 WHERE `entry` = 13282;
UPDATE `creature_template` SET `minrangedmg` = 374, `maxrangedmg` = 548 WHERE `entry` = 13596;
UPDATE `creature_template` SET `minrangedmg` = 251, `maxrangedmg` = 367 WHERE `entry` = 13601;
UPDATE `creature_template` SET `minrangedmg` = 489, `maxrangedmg` = 720 WHERE `entry` = 14321;
UPDATE `creature_template` SET `minrangedmg` = 559, `maxrangedmg` = 823 WHERE `entry` = 14322;
UPDATE `creature_template` SET `minrangedmg` = 489, `maxrangedmg` = 720 WHERE `entry` = 14323;
UPDATE `creature_template` SET `minrangedmg` = 167, `maxrangedmg` = 277 WHERE `entry` = 14324;
UPDATE `creature_template` SET `minrangedmg` = 677, `maxrangedmg` = 1001 WHERE `entry` = 14325;
UPDATE `creature_template` SET `minrangedmg` = 489, `maxrangedmg` = 720 WHERE `entry` = 14326;
UPDATE `creature_template` SET `minrangedmg` = 373, `maxrangedmg` = 553 WHERE `entry` = 14327;
UPDATE `creature_template` SET `minrangedmg` = 219, `maxrangedmg` = 325 WHERE `entry` = 14338;
UPDATE `creature_template` SET `minrangedmg` = 245, `maxrangedmg` = 361 WHERE `entry` = 14349;
UPDATE `creature_template` SET `minrangedmg` = 249, `maxrangedmg` = 369 WHERE `entry` = 14354;
UPDATE `creature_template` SET `minrangedmg` = 777, `maxrangedmg` = 1151 WHERE `entry` = 14506;
UPDATE `creature_template` SET `minrangedmg` = 728, `maxrangedmg` = 1078 WHERE `entry` = 14516;
UPDATE `creature_template` SET `minrangedmg` = 350, `maxrangedmg` = 522 WHERE `entry` = 14861;
UPDATE `creature_template` SET `minrangedmg` = 1078, `maxrangedmg` = 1588 WHERE `entry` = 16042;
UPDATE `creature_template` SET `minrangedmg` = 327, `maxrangedmg` = 488 WHERE `entry` = 16059;
UPDATE `creature_template` SET `minrangedmg` = 562, `maxrangedmg` = 930 WHERE `entry` = 16080;
UPDATE `creature_template` SET `minrangedmg` = 522, `maxrangedmg` = 864 WHERE `entry` = 16097;
UPDATE `creature_template` SET `minrangedmg` = 348, `maxrangedmg` = 575 WHERE `entry` = 16101;
UPDATE `creature_template` SET `minrangedmg` = 348, `maxrangedmg` = 575 WHERE `entry` = 16102;
UPDATE `creature_template` SET `minrangedmg` = 562, `maxrangedmg` = 930 WHERE `entry` = 16118;
UPDATE `creature_template` SET `minrangedmg` = 3708, `maxrangedmg` = 5464 WHERE `entry` = 16387;
UPDATE `creature_template` SET `minrangedmg` = 61, `maxrangedmg` = 92 WHERE `entry` = 17830;
