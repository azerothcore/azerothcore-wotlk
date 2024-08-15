-- DB update 2024_06_29_08 -> 2024_06_29_09
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 524288 WHERE `entry` IN
(10184, -- Onyxia
15928, -- Thaddius
15931, -- Grobbulus
15932, -- Gluth
15936, -- Heigan the Unclean
15952, -- Maexxna
15953, -- Grand Widow Faerlina
15954, -- Noth the Plaguebringer
15956, -- Anub'Rekhan
15989, -- Sapphiron
15990, -- Kel'Thuzad
16011, -- Loatheb
16028, -- Patchwerk
16060, -- Gothik the Harvester
28859, -- Malygos
28860, -- Sartharion
29249, -- Anub'Rekhan (1)
29268, -- Grand Widow Faerlina (1)
29278, -- Maexxna (1)
29324, -- Patchwerk (1)
29373, -- Grobbulus (1)
29417, -- Gluth (1)
29448, -- Thaddius (1)
29615, -- Noth the Plaguebringer (1)
29701, -- Heigan the Unclean (1)
29718, -- Loatheb (1)
29955, -- Gothik the Harvester (1)
29991, -- Sapphiron (1)
30061, -- Kel'Thuzad (1)
30449, -- Vesperon
30451, -- Shadron
30452, -- Tenebron
31125, -- Archavon the Stone Watcher
31311, -- Sartharion (1)
31520, -- Shadron (1)
31534, -- Tenebron (1)
31535, -- Vesperon (1)
31722, -- Archavon the Stone Watcher (1)
31734, -- Malygos
32845, -- Hodir
32846, -- Hodir (1)
32857, -- Stormcaller Brundir
32865, -- Thorim
32867, -- Steelbreaker
32871, -- Algalon the Observer
32906, -- Freya
32927, -- Runemaster Molgeim
32930, -- Kologarn
33070, -- Algalon the Observer (1)
33113, -- Flame Leviathan
33118, -- Ignis the Furnace Master
33147, -- Thorim (1)
33186, -- Razorscale
33190, -- Ignis the Furnace Master (1)
33271, -- General Vezax
33288, -- Yogg-Saron
33293, -- XT-002 Deconstructor
33360, -- Freya (1)
33432, -- Leviathan Mk II
33449, -- General Vezax (1)
33515, -- Auriaya
33651, -- VX-001
33670, -- Aerial Command Unit
33692, -- Runemaster Molgeim (1)
33693, -- Steelbreaker (1)
33694, -- Stormcaller Brundir (1)
33724, -- Razorscale (1)
33885, -- XT-002 Deconstructor (1)
33909, -- Kologarn (1)
33955, -- Yogg-Saron (1)
33993, -- Emalon the Storm Watcher
33994, -- Emalon the Storm Watcher (1)
34003, -- Flame Leviathan (1)
34106, -- Leviathan Mk II (1)
34108, -- VX-001 (1)
34109, -- Aerial Command Unit (1)
34175, -- Auriaya (1)
34441, -- Vivienne Blackwhisper
34442, -- Vivienne Blackwhisper (1)
34443, -- Vivienne Blackwhisper (2)
34444, -- Thrakgar
34445, -- Liandra Suncaller
34447, -- Caiphus the Stern
34448, -- Ruj'kah
34449, -- Ginselle Blightslinger
34450, -- Harkzog
34451, -- Birana Stormhoof
34453, -- Narrhok Steelbreaker
34454, -- Maz'dinah
34455, -- Broln Stouthorn
34456, -- Malithas Brightblade
34458, -- Gorgrim Shadowcleave
34459, -- Erin Misthoof
34460, -- Kavina Grovesong
34461, -- Tyrius Duskblade
34463, -- Shaabad
34465, -- Velanaa
34466, -- Anthar Forgemender
34467, -- Alyssia Moonstalker
34468, -- Noozle Whizzlestick
34469, -- Melador Valestrider
34470, -- Saamul
34471, -- Baelnor Lightbearer
34472, -- Irieth Shadowstep
34474, -- Serissa Grimdabbler
34475, -- Shocuul
34496, -- Eydis Darkbane
34497, -- Fjola Lightbane
34564, -- Anub'arak
34566, -- Anub'arak (1)
34780, -- Lord Jaraxxus
34796, -- Gormok the Impaler
34797, -- Icehowl
34799, -- Dreadscale
35013, -- Koralon the Flame Watcher
35144, -- Acidmaw
35216, -- Lord Jaraxxus (1)
35268, -- Lord Jaraxxus (2)
35269, -- Lord Jaraxxus (3)
35347, -- Eydis Darkbane (1)
35348, -- Eydis Darkbane (2)
35349, -- Eydis Darkbane (3)
35350, -- Fjola Lightbane (1)
35351, -- Fjola Lightbane (2)
35352, -- Fjola Lightbane (3)
35360, -- Koralon the Flame Watcher (1)
35438, -- Gormok the Impaler (1)
35439, -- Gormok the Impaler (2)
35440, -- Gormok the Impaler (3)
35447, -- Icehowl (1)
35448, -- Icehowl (2)
35449, -- Icehowl (3)
35511, -- Acidmaw (1)
35512, -- Acidmaw (2)
35513, -- Acidmaw (3)
35514, -- Dreadscale (1)
35515, -- Dreadscale (2)
35516, -- Dreadscale (3)
35615, -- Anub'arak (2)
35616, -- Anub'arak (3)
35662, -- Alyssia Moonstalker (1)
35663, -- Alyssia Moonstalker (2)
35664, -- Alyssia Moonstalker (3)
35665, -- Anthar Forgemender (1)
35666, -- Anthar Forgemender (2)
35667, -- Anthar Forgemender (3)
35668, -- Baelnor Lightbearer (1)
35669, -- Baelnor Lightbearer (2)
35670, -- Baelnor Lightbearer (3)
35671, -- Birana Stormhoof (1)
35672, -- Birana Stormhoof (2)
35673, -- Birana Stormhoof (3)
35680, -- Broln Stouthorn (1)
35681, -- Broln Stouthorn (2)
35682, -- Broln Stouthorn (3)
35683, -- Caiphus the Stern (1)
35684, -- Caiphus the Stern (2)
35685, -- Caiphus the Stern (3)
35686, -- Erin Misthoof (1)
35687, -- Erin Misthoof (2)
35688, -- Erin Misthoof (3)
35689, -- Ginselle Blightslinger (1)
35690, -- Ginselle Blightslinger (2)
35691, -- Ginselle Blightslinger (3)
35692, -- Gorgrim Shadowcleave (1)
35693, -- Gorgrim Shadowcleave (2)
35694, -- Gorgrim Shadowcleave (3)
35695, -- Harkzog (1)
35696, -- Harkzog (2)
35697, -- Harkzog (3)
35699, -- Irieth Shadowstep (1)
35700, -- Irieth Shadowstep (2)
35701, -- Irieth Shadowstep (3)
35702, -- Kavina Grovesong (1)
35703, -- Kavina Grovesong (2)
35704, -- Kavina Grovesong (3)
35705, -- Liandra Suncaller (1)
35706, -- Liandra Suncaller (2)
35707, -- Liandra Suncaller (3)
35708, -- Malithas Brightblade (1)
35709, -- Malithas Brightblade (2)
35710, -- Malithas Brightblade (3)
35711, -- Maz'dinah (1)
35712, -- Maz'dinah (2)
35713, -- Maz'dinah (3)
35714, -- Melador Valestrider (1)
35715, -- Melador Valestrider (2)
35716, -- Melador Valestrider (3)
35718, -- Narrhok Steelbreaker (1)
35719, -- Narrhok Steelbreaker (2)
35720, -- Narrhok Steelbreaker (3)
35721, -- Noozle Whizzlestick (1)
35722, -- Noozle Whizzlestick (2)
35723, -- Noozle Whizzlestick (3)
35724, -- Ruj'kah (1)
35725, -- Ruj'kah (2)
35726, -- Ruj'kah (3)
35728, -- Saamul (1)
35729, -- Saamul (2)
35730, -- Saamul (3)
35731, -- Serissa Grimdabbler (1)
35732, -- Serissa Grimdabbler (2)
35733, -- Serissa Grimdabbler (3)
35734, -- Shaabad (1)
35735, -- Shaabad (2)
35736, -- Shaabad (3)
35737, -- Shocuul (1)
35738, -- Shocuul (2)
35739, -- Shocuul (3)
35740, -- Thrakgar (1)
35741, -- Thrakgar (2)
35742, -- Thrakgar (3)
35743, -- Tyrius Duskblade (1)
35744, -- Tyrius Duskblade (2)
35745, -- Tyrius Duskblade (3)
35746, -- Velanaa (1)
35747, -- Velanaa (2)
35748, -- Velanaa (3)
35749, -- Vivienne Blackwhisper (3)
36538, -- Onyxia (1)
36597, -- The Lich King
36612, -- Lord Marrowgar
36626, -- Festergut
36627, -- Rotface
36678, -- Professor Putricide
36855, -- Lady Deathwhisper
36899, -- Big Ooze
36939, -- High Overlord Saurfang
36948, -- Muradin Bronzebeard
37504, -- Festergut (1)
37505, -- Festergut (2)
37506, -- Festergut (3)
37562, -- Gas Cloud
37813, -- Deathbringer Saurfang
37955, -- Blood-Queen Lana'thel
37957, -- Lord Marrowgar (1)
37958, -- Lord Marrowgar (2)
37959, -- Lord Marrowgar (3)
37970, -- Prince Valanar
37972, -- Prince Keleseth
37973, -- Prince Taldaram
38106, -- Lady Deathwhisper (1)
38123, -- Big Ooze (1)
38156, -- High Overlord Saurfang (1)
38157, -- Muradin Bronzebeard (1)
38216, -- Mutated Professor Putricide
38296, -- Lady Deathwhisper (2)
38297, -- Lady Deathwhisper (3)
38390, -- Rotface (1)
38399, -- Prince Keleseth (1)
38400, -- Prince Taldaram (1)
38401, -- Prince Valanar (1)
38402, -- Deathbringer Saurfang (1)
38431, -- Professor Putricide (1)
38433, -- Toravon the Ice Watcher
38434, -- Blood-Queen Lana'thel (1)
38435, -- Blood-Queen Lana'thel (2)
38436, -- Blood-Queen Lana'thel (3)
38462, -- Toravon the Ice Watcher (1)
38549, -- Rotface (2)
38550, -- Rotface (3)
38582, -- Deathbringer Saurfang (2)
38583, -- Deathbringer Saurfang (3)
38585, -- Professor Putricide (2)
38586, -- Professor Putricide (3)
38602, -- Gas Cloud (1)
38637, -- High Overlord Saurfang (2)
38638, -- High Overlord Saurfang (3)
38639, -- Muradin Bronzebeard (2)
38640, -- Muradin Bronzebeard (3)
38760, -- Gas Cloud (2)
38761, -- Gas Cloud (3)
38769, -- Prince Keleseth (2)
38770, -- Prince Keleseth (3)
38771, -- Prince Taldaram (2)
38772, -- Prince Taldaram (3)
38784, -- Prince Valanar (2)
38785, -- Prince Valanar (3)
38883, -- ScottG Test
39166, -- The Lich King (1)
39167, -- The Lich King (2)
39168, -- The Lich King (3)
39231, -- The Lich King (Temp)
39232, -- The Lich King (Temp) (1)
39233, -- The Lich King (Temp) (2)
39234, -- The Lich King (Temp) (3)
39863, -- Halion
39864, -- Halion (1)
39944, -- Halion (2)
39945, -- Halion (3)
40142, -- Halion
40143, -- Halion (1)
40144, -- Halion (2)
40145 -- Halion (3)
);
