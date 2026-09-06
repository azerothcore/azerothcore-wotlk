-- DB update 2025_11_08_01 -> 2025_11_08_02
SET @BossXPMod = 7.5,
    @FinalBossXPMod = 10;

UPDATE `creature_template` SET `ExperienceModifier` = @BossXPMod WHERE `entry` IN (
-- Utgarde Keep
23953, -- Prince Keleseth
30748,
24200, -- Skarvald the Constructor
31679,
24201, -- Dalronn the Controller
31656,
-- Azjol-Nerub
28684, -- Krik'thir the Gatewatcher
31612,
28921, -- Hadronox
31611,
-- Ahn'kahet: The Old Kingdom
29309, -- Elder Nadox
31456,
29308, -- Prince Taldaram
31469,
29310, -- Jedoga Shadowseeker
31465,
30258, -- Amanitar
31463,
-- The Nexus
26731, -- Grand Magus Telestra
30510,
26763, -- Anomalus
30529,
26794, -- Ormorok the Tree-Shaper
30532,
26796, -- Commander Stoutbeard
30398,
26798, -- Commander Kolurg
30397,
-- Drak'Tharon Keep
26630, -- Trollgore
31362,
26631, -- Novos the Summoner
31350,
-- 27483, -- King Dred, observed to not give as much experience as this
-- 31349,
-- The Violet Hold
29315, -- Erekem
31507,
29316, -- Moragg
31510,
29313, -- Ichoron
31508,
29266, -- Xevozz
31511,
29312, -- Lavanthor
31509,
29314, -- Zuramat the Obliterator
31512,
-- Gundrak
29304, -- Slad'ran
31370,
-- 29573, -- Drakkari Elemental, observed to not give as much experience as this
-- 31367,
29305, -- Moorabi
30530,
29932, -- Eck the Ferocious
-- Halls of Stone
27975, -- Maiden of Grief
31384,
27977, -- Krystallus
31381,
-- Halls of Lightning
28586, -- General Bjarngrim
31533,
28587, -- Volkhan
31536,
28546, -- Ionar
31537,
-- The Oculus
27654, -- Drakos the Interrogator
31558,
27447, -- Varos Cloudstrider
31559,
27655, -- Mage-Lord Urom
31560,
-- Utgarde Pinnacle
26668, -- Svala Sorrowgrave
30810,
26687, -- Gortok Palehoof
30774,
26693, -- Skadi the Ruthless
30807,
-- The Culling of Stratholme
26529, -- Meathook
31211,
26530, -- Salramm the Fleshcrafter
31212,
26532, -- Chrono-Lord Epoch
31215,
32273, -- Infinite Corruptor
32313,
-- Trial of the Champion
34705, -- Marshal Jacob Alerius
36088,
34702, -- Ambrose Boltspark
36082,
34701, -- Colosos
36083,
34657, -- Jaelyne Evensong
36086,
34703, -- Lana Stouthammer
36087,
35572, -- Mokra the Skullcrusher
36089,
35569, -- Eressea Dawnsinger
36085,
35571, -- Runok Wildmane
36090,
35570, -- Zul'tore
36091,
35617, -- Deathstalker Visceri
36084,
35119, -- Eadric the Pure
35518,
34928, -- Argent Confessor Paletress
35517,
-- The Forge of Souls
36497, -- Bronjahm
36498,
-- Pit of Saron
36494, -- Forgemaster Garfrost
37613,
36476, -- Ick
37627,
-- Halls of Reflection
38112, -- Falric
38599,
38113, -- Marwyn
38603
);

UPDATE `creature_template` SET `ExperienceModifier` = @FinalBossXPMod WHERE `entry` IN (
23954, -- Ingvar the Plunderer, Utgarde Keep
31673,
29120, -- Anub'arak, Azjol-Nerub
31610,
29311, -- Herald Volazj,
31464,
26723, -- Keristrasza
30540,
26632, -- The Prophet Tharon'ja
31360,
31134, -- Cyanigosa
31506,
29306, -- Gal'darah
31368,
27978, -- Sjonnir The Ironshaper
31386,
28923, -- Loken
31538,
27656, -- Ley-Guardian Eregos
31561,
26861, -- King Ymiron
30788,
26533, -- Mal'Ganis
31217,
35451, -- The Black Knight, Trial of the Champion
35490,
36502, -- Devourer of Souls, Forge of Souls
37677,
36658, -- Scourgelord Tyrannus, Pit of Saron
36938
);
