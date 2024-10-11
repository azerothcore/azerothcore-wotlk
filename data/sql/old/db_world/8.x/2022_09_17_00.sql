-- DB update 2022_09_15_01 -> 2022_09_17_00
--
DELETE FROM `spell_bonus_data` WHERE `entry` IN (
116, /* Mage - Frost Bolt */
120, /* Mage - Cone of Cold */
122, /* Mage - Frost Nova */
133, /* Mage - Fire ball */
139, /* Priest - Renew */
143, /* Mage - Fire ball */
145, /* Mage - Fire ball */
172, /* Warlock - Corruption */
205, /* Mage - Frost Bolt */
331, /* Shaman - Healing Wave */
332, /* Shaman - Healing Wave */
339, /* Druid - Entangling Roots */
348, /* Warlock - Immolate */
403, /* Shaman - Lightning Bolt */
421, /* Shaman - Chain Lightning */
529, /* Shaman - Lightning Bolt */
547, /* Shaman - Healing Wave */
548, /* Shaman - Lightning Bolt */
585, /* Priest - Smite */
591, /* Priest - Smite */
596, /* Priest - Prayer of Healing */
598, /* Priest - Smite */
603, /* Warlock - Curse of Doom */
635, /* Paladin - Holy Light */
639, /* Paladin - Holy Light */
647, /* Paladin - Holy Light */
686, /* Warlock - Shadow Bolt */
689, /* Warlock - Drain Life */
695, /* Warlock - Shadow Bolt */
699, /* Warlock - Drain Life */
705, /* Warlock - Shadow Bolt */
707, /* Warlock - Immolate */
709, /* Warlock - Drain Life */
755, /* Warlock - Health Funnel */
774, /* Druid - Rejuvenation */
837, /* Mage - Frost Bolt */
865, /* Mage - Frost Nova */
879, /* Paladin - Exorcism */
913, /* Shaman - Healing Wave */
915, /* Shaman - Lightning Bolt */
930, /* Shaman - Chain Lightning */
939, /* Shaman - Healing Wave */
943, /* Shaman - Lightning Bolt */
959, /* Shaman - Healing Wave */
980, /* Warlock - Curse of Agony */
984, /* Priest - Smite */
996, /* Priest - Prayer of Healing */
1004, /* Priest - Smite */
1014, /* Warlock - Curse of Agony */
1026, /* Paladin - Holy Light */
1042, /* Paladin - Holy Light */
1058, /* Druid - Rejuvenation */
1062, /* Druid - Entangling Roots */
1064, /* Shaman - Chain Heal */
1088, /* Warlock - Shadow Bolt */
1094, /* Warlock - Immolate */
1106, /* Warlock - Shadow Bolt */
1120, /* Warlock - Drain Soul */
1430, /* Druid - Rejuvenation */
1449, /* Mage - Arcane Explosion */
1949, /* Warlock - Hellfire */
2050, /* Priest - Lesser Heal */
2052, /* Priest - Lesser Heal */
2053, /* Priest - Lesser Heal */
2054, /* Priest - Heal */
2055, /* Priest - Heal */
2060, /* Priest - Greater Heal */
2061, /* Priest - Flash Heal */
2090, /* Druid - Rejuvenation */
2091, /* Druid - Rejuvenation */
2120, /* Mage - Flamestrike */
2121, /* Mage - Flamestrike */
2136, /* Mage - Fire Blast */
2137, /* Mage - Fire Blast */
2138, /* Mage - Fire Blast */
2812, /* Paladin - Holy Wrath */
2860, /* Shaman - Chain Lightning */
2941, /* Warlock - Immolate */
2944, /* Priest - Devouring Plague */
2948, /* Mage - Scorch */
3110, /* Pet Warlock - Firebolt */
3140, /* Mage - Fire ball */
3472, /* Paladin - Holy Light */
3606, /* Shaman - Searing Totem Attack Rank 1 */
3627, /* Druid - Rejuvenation */
3674, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
3698, /* Warlock - Health Funnel */
3699, /* Warlock - Health Funnel */
3700, /* Warlock - Health Funnel */
5176, /* Druid - Wrath */
5177, /* Druid - Wrath */
5178, /* Druid - Wrath */
5179, /* Druid - Wrath */
5180, /* Druid - Wrath */
5185, /* Druid - Healing Touch */
5186, /* Druid - Healing Touch */
5187, /* Druid - Healing Touch */
5188, /* Druid - Healing Touch */
5189, /* Druid - Healing Touch */
5195, /* Druid - Entangling Roots */
5196, /* Druid - Entangling Roots */
5570, /* Druid - Insect Swarm */
5614, /* Paladin - Exorcism */
5615, /* Paladin - Exorcism */
5676, /* Warlock - Searing Pain */
5857, /* Warlock - Hellfire Effect on Enemy Rank 1 */
6041, /* Shaman - Lightning Bolt */
6060, /* Priest - Smite */
6063, /* Priest - Heal */
6064, /* Priest - Heal */
6074, /* Priest - Renew */
6075, /* Priest - Renew */
6076, /* Priest - Renew */
6077, /* Priest - Renew */
6078, /* Priest - Renew */
6131, /* Mage - Frost Nova */
6217, /* Warlock - Curse of Agony */
6350, /* Shaman - Searing Totem Attack Rank 2 */
6351, /* Shaman - Searing Totem Attack Rank 3 */
6352, /* Shaman - Searing Totem Attack Rank 4 */
6353, /* Warlock - Soul Fire */
6778, /* Druid - Healing Touch */
6780, /* Druid - Wrath */
6789, /* Warlock - Death Coil */
7268, /* Mage - Arcane Missiles */
7269, /* Mage - Arcane Missiles */
7270, /* Mage - Arcane Missiles */
7294, /* Paladin - Retribution Aura */
7322, /* Mage - Frost Bolt */
7641, /* Warlock - Shadow Bolt */
7651, /* Warlock - Drain Life */
7799, /* Pet Warlock - Firebolt */
7800, /* Pet Warlock - Firebolt */
7801, /* Pet Warlock - Firebolt */
7802, /* Pet Warlock - Firebolt */
7814, /* Pet Warlock - Lash of Pain */
7815, /* Pet Warlock - Lash of Pain */
7816, /* Pet Warlock - Lash of Pain */
8004, /* Shaman - Lesser Healing Wave */
8005, /* Shaman - Healing Wave */
8008, /* Shaman - Lesser Healing Wave */
8010, /* Shaman - Lesser Healing Wave */
8034, /* Shaman - Frostbrand Attack */
8037, /* Shaman - Frostbrand Attack */
8042, /* Shaman - Earth Shock */
8044, /* Shaman - Earth Shock */
8045, /* Shaman - Earth Shock */
8046, /* Shaman - Earth Shock */
8050, /* Shaman - Flame Shock */
8052, /* Shaman - Flame Shock */
8053, /* Shaman - Flame Shock */
8056, /* Shaman - Frost Shock */
8058, /* Shaman - Frost Shock */
8092, /* Priest - Mind Blast */
8102, /* Priest - Mind Blast */
8103, /* Priest - Mind Blast */
8104, /* Priest - Mind Blast */
8105, /* Priest - Mind Blast */
8106, /* Priest - Mind Blast */
8187, /* Shaman - Magma totem trigger 1 */
8288, /* Warlock - Drain Soul */
8289, /* Warlock - Drain Soul */
8349, /* Shaman - Fire Nova Totem */
8406, /* Mage - Frost Bolt */
8407, /* Mage - Frost Bolt */
8408, /* Mage - Frost Bolt */
8412, /* Mage - Fire Blast */
8413, /* Mage - Fire Blast */
8418, /* Mage - Arcane Missiles */
8419, /* Mage - Arcane Missiles */
8422, /* Mage - Flamestrike */
8423, /* Mage - Flamestrike */
8437, /* Mage - Arcane Explosion */
8438, /* Mage - Arcane Explosion */
8439, /* Mage - Arcane Explosion */
8444, /* Mage - Scorch */
8445, /* Mage - Scorch */
8446, /* Mage - Scorch */
8492, /* Mage - Cone of Cold */
8502, /* Shaman - Fire Nova Totem */
8503, /* Shaman - Fire Nova Totem */
8903, /* Druid - Healing Touch */
8905, /* Druid - Wrath */
8910, /* Druid - Rejuvenation */
8921, /* Druid - Moonfire */
8924, /* Druid - Moonfire */
8925, /* Druid - Moonfire */
8926, /* Druid - Moonfire */
8927, /* Druid - Moonfire */
8928, /* Druid - Moonfire */
8929, /* Druid - Moonfire */
8936, /* Druid - Regrowth */
8938, /* Druid - Regrowth */
8939, /* Druid - Regrowth */
8940, /* Druid - Regrowth */
8941, /* Druid - Regrowth */
9472, /* Priest - Flash Heal */
9473, /* Priest - Flash Heal */
9474, /* Priest - Flash Heal */
9750, /* Druid - Regrowth */
9758, /* Druid - Healing Touch */
9833, /* Druid - Moonfire */
9834, /* Druid - Moonfire */
9835, /* Druid - Moonfire */
9839, /* Druid - Rejuvenation */
9840, /* Druid - Rejuvenation */
9841, /* Druid - Rejuvenation */
9852, /* Druid - Entangling Roots */
9853, /* Druid - Entangling Roots */
9856, /* Druid - Regrowth */
9857, /* Druid - Regrowth */
9858, /* Druid - Regrowth */
9888, /* Druid - Healing Touch */
9889, /* Druid - Healing Touch */
9912, /* Druid - Wrath */
10159, /* Mage - Cone of Cold */
10160, /* Mage - Cone of Cold */
10161, /* Mage - Cone of Cold */
10179, /* Mage - Frost Bolt */
10180, /* Mage - Frost Bolt */
10181, /* Mage - Frost Bolt */
10197, /* Mage - Fire Blast */
10199, /* Mage - Fire Blast */
10201, /* Mage - Arcane Explosion */
10202, /* Mage - Arcane Explosion */
10205, /* Mage - Scorch */
10206, /* Mage - Scorch */
10207, /* Mage - Scorch */
10215, /* Mage - Flamestrike */
10216, /* Mage - Flamestrike */
10230, /* Mage - Frost Nova */
10273, /* Mage - Arcane Missiles */
10274, /* Mage - Arcane Missiles */
10312, /* Paladin - Exorcism */
10313, /* Paladin - Exorcism */
10314, /* Paladin - Exorcism */
10318, /* Paladin - Holy Wrath */
10328, /* Paladin - Holy Light */
10329, /* Paladin - Holy Light */
10391, /* Shaman - Lightning Bolt */
10392, /* Shaman - Lightning Bolt */
10395, /* Shaman - Healing Wave */
10396, /* Shaman - Healing Wave */
10412, /* Shaman - Earth Shock */
10413, /* Shaman - Earth Shock */
10414, /* Shaman - Earth Shock */
10435, /* Shaman - Searing Totem Attack Rank 5 */
10436, /* Shaman - Searing Totem Attack Rank 6 */
10447, /* Shaman - Flame Shock */
10448, /* Shaman - Flame Shock */
10458, /* Shaman - Frostbrand Attack */
10466, /* Shaman - Lesser Healing Wave */
10467, /* Shaman - Lesser Healing Wave */
10468, /* Shaman - Lesser Healing Wave */
10472, /* Shaman - Frost Shock */
10473, /* Shaman - Frost Shock */
10579, /* Shaman - Magma totem trigger 2 */
10580, /* Shaman - Magma totem trigger 3 */
10581, /* Shaman - Magma totem trigger 4 */
10605, /* Shaman - Chain Lightning */
10622, /* Shaman - Chain Heal */
10623, /* Shaman - Chain Heal */
10915, /* Priest - Flash Heal */
10916, /* Priest - Flash Heal */
10917, /* Priest - Flash Heal */
10927, /* Priest - Renew */
10928, /* Priest - Renew */
10929, /* Priest - Renew */
10933, /* Priest - Smite */
10934, /* Priest - Smite */
10945, /* Priest - Mind Blast */
10946, /* Priest - Mind Blast */
10947, /* Priest - Mind Blast */
10960, /* Priest - Prayer of Healing */
10961, /* Priest - Prayer of Healing */
10963, /* Priest - Greater Heal */
10964, /* Priest - Greater Heal */
10965, /* Priest - Greater Heal */
11113, /* Mage - Blast Wave */
11306, /* Shaman - Fire Nova Totem */
11307, /* Shaman - Fire Nova Totem */
11366, /* Mage - Pyroblast */
11659, /* Warlock - Shadow Bolt */
11660, /* Warlock - Shadow Bolt */
11661, /* Warlock - Shadow Bolt */
11665, /* Warlock - Immolate */
11667, /* Warlock - Immolate */
11668, /* Warlock - Immolate */
11675, /* Warlock - Drain Soul */
11681, /* Warlock - Hellfire Effect on Enemy Rank 1 */
11682, /* Warlock - Hellfire Effect on Enemy Rank 1 */
11683, /* Warlock - Hellfire */
11684, /* Warlock - Hellfire */
11693, /* Warlock - Health Funnel */
11694, /* Warlock - Health Funnel */
11695, /* Warlock - Health Funnel */
11699, /* Warlock - Drain Life */
11700, /* Warlock - Drain Life */
11711, /* Warlock - Curse of Agony */
11712, /* Warlock - Curse of Agony */
11713, /* Warlock - Curse of Agony */
11762, /* Pet Warlock - Firebolt */
11763, /* Pet Warlock - Firebolt */
11778, /* Pet Warlock - Lash of Pain */
11779, /* Pet Warlock - Lash of Pain */
11780, /* Pet Warlock - Lash of Pain */
12505, /* Mage - Pyroblast */
12522, /* Mage - Pyroblast */
12523, /* Mage - Pyroblast */
12524, /* Mage - Pyroblast */
12525, /* Mage - Pyroblast */
12526, /* Mage - Pyroblast */
13018, /* Mage - Blast Wave */
13019, /* Mage - Blast Wave */
13020, /* Mage - Blast Wave */
13021, /* Mage - Blast Wave */
13376, /* Pet Shaman - Fire Elemental Fire Shield */
14914, /* Priest - Holy Fire */
15207, /* Shaman - Lightning Bolt */
15208, /* Shaman - Lightning Bolt */
15237, /* Priest - Holy Nova Damage */
15261, /* Priest - Holy Fire */
15262, /* Priest - Holy Fire */
15263, /* Priest - Holy Fire */
15264, /* Priest - Holy Fire */
15265, /* Priest - Holy Fire */
15266, /* Priest - Holy Fire */
15267, /* Priest - Holy Fire */
15430, /* Priest - Holy Nova Damage */
15431, /* Priest - Holy Nova Damage */
16352, /* Shaman - Frostbrand Attack */
16353, /* Shaman - Frostbrand Attack */
17877, /* Warlock - Shadowburn */
17919, /* Warlock - Searing Pain */
17920, /* Warlock - Searing Pain */
17921, /* Warlock - Searing Pain */
17922, /* Warlock - Searing Pain */
17923, /* Warlock - Searing Pain */
17924, /* Warlock - Soul Fire */
17925, /* Warlock - Death Coil */
17926, /* Warlock - Death Coil */
18809, /* Mage - Pyroblast */
18867, /* Warlock - Shadowburn */
18868, /* Warlock - Shadowburn */
18869, /* Warlock - Shadowburn */
18870, /* Warlock - Shadowburn */
18871, /* Warlock - Shadowburn */
19236, /* Priest - Desperate Prayer */
19238, /* Priest - Desperate Prayer */
19240, /* Priest - Desperate Prayer */
19241, /* Priest - Desperate Prayer */
19242, /* Priest - Desperate Prayer */
19243, /* Priest - Desperate Prayer */
19276, /* Priest - Devouring Plague */
19277, /* Priest - Devouring Plague */
19278, /* Priest - Devouring Plague */
19279, /* Priest - Devouring Plague */
19280, /* Priest - Devouring Plague */
19750, /* Paladin - Flash of Light */
19939, /* Paladin - Flash of Light */
19940, /* Paladin - Flash of Light */
19941, /* Paladin - Flash of Light */
19942, /* Paladin - Flash of Light */
19943, /* Paladin - Flash of Light */
19970, /* Druid - Entangling Roots (Natures Grasp) */
19971, /* Druid - Entangling Roots (Natures Grasp) */
19972, /* Druid - Entangling Roots (Natures Grasp) */
19973, /* Druid - Entangling Roots (Natures Grasp) */
19974, /* Druid - Entangling Roots (Natures Grasp) */
19975, /* Druid - Entangling Roots (Natures Grasp) */
20116, /* Paladin - Consecration */
20187, /* Paladin - Judgement of Righteousness */
20922, /* Paladin - Consecration */
20923, /* Paladin - Consecration */
20924, /* Paladin - Consecration */
20925, /* Paladin - Holy Shield */
20927, /* Paladin - Holy Shield */
20928, /* Paladin - Holy Shield */
23455, /* Priest - Holy Nova Heal */
23458, /* Priest - Holy Nova Heal */
23459, /* Priest - Holy Nova Heal */
24239, /* Paladin - Hammer of Wrath */
24274, /* Paladin - Hammer of Wrath */
24275, /* Paladin - Hammer of Wrath */
24974, /* Druid - Insect Swarm */
24975, /* Druid - Insect Swarm */
24976, /* Druid - Insect Swarm */
24977, /* Druid - Insect Swarm */
25210, /* Priest - Greater Heal */
25213, /* Priest - Greater Heal */
25221, /* Priest - Renew */
25222, /* Priest - Renew */
25233, /* Priest - Flash Heal */
25235, /* Priest - Flash Heal */
25292, /* Paladin - Holy Light */
25297, /* Druid - Healing Touch */
25299, /* Druid - Rejuvenation */
25304, /* Mage - Frost Bolt */
25307, /* Warlock - Shadow Bolt */
25308, /* Priest - Prayer of Healing */
25309, /* Warlock - Immolate */
25314, /* Priest - Greater Heal */
25315, /* Priest - Renew */
25316, /* Priest - Prayer of Healing */
25329, /* Priest - Holy Nova Heal */
25331, /* Priest - Holy Nova Damage */
25346, /* Mage - Arcane Missiles */
25357, /* Shaman - Healing Wave */
25363, /* Priest - Smite */
25364, /* Priest - Smite */
25372, /* Priest - Mind Blast */
25375, /* Priest - Mind Blast */
25384, /* Priest - Holy Fire */
25391, /* Shaman - Healing Wave */
25396, /* Shaman - Healing Wave */
25420, /* Shaman - Lesser Healing Wave */
25422, /* Shaman - Chain Heal */
25423, /* Shaman - Chain Heal */
25437, /* Priest - Desperate Prayer */
25439, /* Shaman - Chain Lightning */
25442, /* Shaman - Chain Lightning */
25448, /* Shaman - Lightning Bolt */
25449, /* Shaman - Lightning Bolt */
25454, /* Shaman - Earth Shock */
25457, /* Shaman - Flame Shock */
25464, /* Shaman - Frost Shock */
25467, /* Priest - Devouring Plague */
25501, /* Shaman - Frostbrand Attack */
25530, /* Shaman - Searing Totem Attack Rank 7 */
25535, /* Shaman - Fire Nova Totem */
25537, /* Shaman - Fire Nova Totem */
25550, /* Shaman - Magma totem trigger 5 */
25902, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
25903, /* Paladin - Holy Shock Triggered Heal Rank 1 */
25911, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
25912, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
25913, /* Paladin - Holy Shock Triggered Heal Rank 1 */
25914, /* Paladin - Holy Shock Triggered Heal Rank 1 */
26363, /* Shaman - Lightning Shield Proc Rank 1 */
26364, /* Shaman - Lightning Shield Proc Rank 1 */
26365, /* Shaman - Lightning Shield Proc Rank 1 */
26366, /* Shaman - Lightning Shield Proc Rank 1 */
26367, /* Shaman - Lightning Shield Proc Rank 1 */
26369, /* Shaman - Lightning Shield Proc Rank 1 */
26370, /* Shaman - Lightning Shield Proc Rank 1 */
26371, /* Shaman - Lightning Shield Proc Rank 1 */
26372, /* Shaman - Lightning Shield Proc Rank 1 */
26573, /* Paladin - Consecration */
26978, /* Druid - Healing Touch */
26979, /* Druid - Healing Touch */
26980, /* Druid - Regrowth */
26981, /* Druid - Rejuvenation */
26982, /* Druid - Rejuvenation */
26984, /* Druid - Wrath */
26985, /* Druid - Wrath */
26987, /* Druid - Moonfire */
26988, /* Druid - Moonfire */
26989, /* Druid - Entangling Roots */
27010, /* Druid - Entangling Roots (Natures Grasp) */
27013, /* Druid - Insect Swarm */
27071, /* Mage - Frost Bolt */
27072, /* Mage - Frost Bolt */
27073, /* Mage - Scorch */
27074, /* Mage - Scorch */
27076, /* Mage - Arcane Missiles */
27078, /* Mage - Fire Blast */
27079, /* Mage - Fire Blast */
27080, /* Mage - Arcane Explosion */
27082, /* Mage - Arcane Explosion */
27086, /* Mage - Flamestrike */
27087, /* Mage - Cone of Cold */
27088, /* Mage - Frost Nova */
27132, /* Mage - Pyroblast */
27133, /* Mage - Blast Wave */
27135, /* Paladin - Holy Light */
27136, /* Paladin - Holy Light */
27137, /* Paladin - Flash of Light */
27138, /* Paladin - Exorcism */
27139, /* Paladin - Holy Wrath */
27173, /* Paladin - Consecration */
27175, /* Paladin - Holy Shock Triggered Heal Rank 1 */
27176, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
27179, /* Paladin - Holy Shield */
27180, /* Paladin - Hammer of Wrath */
27209, /* Warlock - Shadow Bolt */
27210, /* Warlock - Searing Pain */
27211, /* Warlock - Soul Fire */
27213, /* Warlock - Hellfire */
27214, /* Warlock - Hellfire Effect on Enemy Rank 1 */
27215, /* Warlock - Immolate */
27217, /* Warlock - Drain Soul */
27218, /* Warlock - Curse of Agony */
27219, /* Warlock - Drain Life */
27220, /* Warlock - Drain Life */
27223, /* Warlock - Death Coil */
27243, /* Warlock - Seed of Corruption DOT */
27259, /* Warlock - Health Funnel */
27263, /* Warlock - Shadowburn */
27267, /* Pet Warlock - Firebolt */
27274, /* Pet Warlock - Lash of Pain */
27285, /* Warlock - Seed of Corruption DD */
27799, /* Priest - Holy Nova Damage */
27800, /* Priest - Holy Nova Damage */
27801, /* Priest - Holy Nova Damage */
27803, /* Priest - Holy Nova Heal */
27804, /* Priest - Holy Nova Heal */
27805, /* Priest - Holy Nova Heal */
29228, /* Shaman - Flame Shock */
29722, /* Warlock - Incinerate */
30108, /* Warlock - Unstable Affliction */
30283, /* Warlock - Shadowfury */
30404, /* Warlock - Unstable Affliction */
30405, /* Warlock - Unstable Affliction */
30413, /* Warlock - Shadowfury */
30414, /* Warlock - Shadowfury */
30451, /* Mage - Arcane Blast */
30455, /* Mage - Ice Lance */
30459, /* Warlock - Searing Pain */
30545, /* Warlock - Soul Fire */
30546, /* Warlock - Shadowburn */
30910, /* Warlock - Curse of Doom */
31661, /* Mage - Dragons Breath */
31707, /* Pet Mage - Water Elemental Frostbolt */
31803, /* Paladin - Seal of Vengeance */
31804, /* Paladin - Judgement of Vengeance */
31935, /* Paladin - Avenger Shield */
32231, /* Warlock - Incinerate */
32379, /* Priest - Shadow Word: Death */
32546, /* Priest - Binding Heal */
32699, /* Paladin - Avenger Shield */
32700, /* Paladin - Avenger Shield */
32996, /* Priest - Shadow Word: Death */
33041, /* Mage - Dragons Breath */
33042, /* Mage - Dragons Breath */
33043, /* Mage - Dragons Breath */
33073, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
33074, /* Paladin - Holy Shock Triggered Heal Rank 1 */
33763, /* Druid - Lifebloom HOT */
33933, /* Mage - Blast Wave */
33938, /* Mage - Pyroblast */
34861, /* Priest - Circle of Healing */
34863, /* Priest - Circle of Healing */
34864, /* Priest - Circle of Healing */
34865, /* Priest - Circle of Healing */
34866, /* Priest - Circle of Healing */
34914, /* Priest - Vampiric Touch */
34916, /* Priest - Vampiric Touch */
34917, /* Priest - Vampiric Touch */
38697, /* Mage - Frost Bolt */
38700, /* Mage - Arcane Missiles */
38703, /* Mage - Arcane Missiles */
42198, /* Mage - Blizzard Triggered Spell */
42208, /* Mage - Blizzard Triggered Spell */
42209, /* Mage - Blizzard Triggered Spell */
42210, /* Mage - Blizzard Triggered Spell */
42211, /* Mage - Blizzard Triggered Spell */
42212, /* Mage - Blizzard Triggered Spell */
42213, /* Mage - Blizzard Triggered Spell */
42218, /* Warlock - Rain of Fire Triggered Rank 1 */
42223, /* Warlock - Rain of Fire Triggered Rank 1 */
42224, /* Warlock - Rain of Fire Triggered Rank 1 */
42225, /* Warlock - Rain of Fire Triggered Rank 1 */
42226, /* Warlock - Rain of Fire Triggered Rank 1 */
42227, /* Pet Warlock - Rain of Fire */
42230, /* Druid - Hurricane Triggered */
42231, /* Druid - Hurricane Triggered */
42232, /* Druid - Hurricane Triggered */
42233, /* Druid - Hurricane Triggered */
42841, /* Mage - Frost Bolt */
42842, /* Mage - Frost Bolt */
42844, /* Mage - Arcane Missiles */
42845, /* Mage - Arcane Missiles */
42858, /* Mage - Scorch */
42859, /* Mage - Scorch */
42872, /* Mage - Fire Blast */
42873, /* Mage - Fire Blast */
42890, /* Mage - Pyroblast */
42891, /* Mage - Pyroblast */
42894, /* Mage - Arcane Blast */
42896, /* Mage - Arcane Blast */
42897, /* Mage - Arcane Blast */
42913, /* Mage - Ice Lance */
42914, /* Mage - Ice Lance */
42917, /* Mage - Frost Nova */
42920, /* Mage - Arcane Explosion */
42921, /* Mage - Arcane Explosion */
42925, /* Mage - Flamestrike */
42926, /* Mage - Flamestrike */
42930, /* Mage - Cone of Cold */
42931, /* Mage - Cone of Cold */
42937, /* Mage - Blizzard Triggered Spell */
42938, /* Mage - Blizzard Triggered Spell */
42944, /* Mage - Blast Wave */
42945, /* Mage - Blast Wave */
42949, /* Mage - Dragons Breath */
42950, /* Mage - Dragons Breath */
44203, /* Druid - Tranquility Triggered */
44205, /* Druid - Tranquility Triggered */
44206, /* Druid - Tranquility Triggered */
44207, /* Druid - Tranquility Triggered */
44208, /* Druid - Tranquility Triggered */
44425, /* Mage - Arcane Barrage */
44457, /* Mage - Living Bomb DOT */
44461, /* Mage - Living Bomb DD */
44614, /* Mage - Frostfire Bolt */
44780, /* Mage - Arcane Barrage */
44781, /* Mage - Arcane Barrage */
47610, /* Mage - Frostfire Bolt */
47666, /* Priest - Pennance damage */
47750, /* Priest - Pennance heal */
47808, /* Warlock - Shadow Bolt */
47809, /* Warlock - Shadow Bolt */
47810, /* Warlock - Immolate */
47811, /* Warlock - Immolate */
47814, /* Warlock - Searing Pain */
47815, /* Warlock - Searing Pain */
47817, /* Warlock - Rain of Fire Triggered Rank 1 */
47818, /* Warlock - Rain of Fire Triggered Rank 1 */
47822, /* Warlock - Hellfire Effect on Enemy Rank 1 */
47823, /* Warlock - Hellfire */
47824, /* Warlock - Soul Fire */
47825, /* Warlock - Soul Fire */
47826, /* Warlock - Shadowburn */
47827, /* Warlock - Shadowburn */
47833, /* Warlock - Seed of Corruption DD */
47834, /* Warlock - Seed of Corruption DD */
47835, /* Warlock - Seed of Corruption DOT */
47836, /* Warlock - Seed of Corruption DOT */
47837, /* Warlock - Incinerate */
47838, /* Warlock - Incinerate */
47841, /* Warlock - Unstable Affliction */
47843, /* Warlock - Unstable Affliction */
47846, /* Warlock - Shadowfury */
47847, /* Warlock - Shadowfury */
47855, /* Warlock - Drain Soul */
47856, /* Warlock - Health Funnel */
47857, /* Warlock - Drain Life */
47859, /* Warlock - Death Coil */
47860, /* Warlock - Death Coil */
47863, /* Warlock - Curse of Agony */
47864, /* Warlock - Curse of Agony */
47867, /* Warlock - Curse of Doom */
47897, /* Warlock - Shadowflame(rank 1, DD) */
47960, /* Warlock - Shadowflame(rank 1, DOT) */
47964, /* Pet Warlock - Firebolt */
47991, /* Pet Warlock - Lash of Pain */
47992, /* Pet Warlock - Lash of Pain */
48062, /* Priest - Greater Heal */
48063, /* Priest - Greater Heal */
48067, /* Priest - Renew */
48068, /* Priest - Renew */
48070, /* Priest - Flash Heal */
48071, /* Priest - Flash Heal */
48072, /* Priest - Prayer of Healing */
48075, /* Priest - Holy Nova Heal */
48076, /* Priest - Holy Nova Heal */
48077, /* Priest - Holy Nova Damage */
48078, /* Priest - Holy Nova Damage */
48088, /* Priest - Circle of Healing */
48089, /* Priest - Circle of Healing */
48119, /* Priest - Binding Heal */
48120, /* Priest - Binding Heal */
48122, /* Priest - Smite */
48123, /* Priest - Smite */
48126, /* Priest - Mind Blast */
48127, /* Priest - Mind Blast */
48134, /* Priest - Holy Fire */
48135, /* Priest - Holy Fire */
48157, /* Priest - Shadow Word: Death */
48158, /* Priest - Shadow Word: Death */
48159, /* Priest - Vampiric Touch */
48160, /* Priest - Vampiric Touch */
48172, /* Priest - Desperate Prayer */
48173, /* Priest - Desperate Prayer */
48299, /* Priest - Devouring Plague */
48300, /* Priest - Devouring Plague */
48377, /* Druid - Healing Touch */
48378, /* Druid - Healing Touch */
48438, /* Druid - Wild Growth */
48440, /* Druid - Rejuvenation */
48441, /* Druid - Rejuvenation */
48442, /* Druid - Regrowth */
48443, /* Druid - Regrowth */
48444, /* Druid - Tranquility Triggered */
48445, /* Druid - Tranquility Triggered */
48450, /* Druid - Lifebloom HOT */
48451, /* Druid - Lifebloom HOT */
48459, /* Druid - Wrath */
48461, /* Druid - Wrath */
48462, /* Druid - Moonfire */
48463, /* Druid - Moonfire */
48466, /* Druid - Hurricane Triggered */
48468, /* Druid - Insect Swarm */
48781, /* Paladin - Holy Light */
48782, /* Paladin - Holy Light */
48784, /* Paladin - Flash of Light */
48785, /* Paladin - Flash of Light */
48800, /* Paladin - Exorcism */
48801, /* Paladin - Exorcism */
48805, /* Paladin - Hammer of Wrath */
48806, /* Paladin - Hammer of Wrath */
48816, /* Paladin - Holy Wrath */
48817, /* Paladin - Holy Wrath */
48818, /* Paladin - Consecration */
48819, /* Paladin - Consecration */
48820, /* Paladin - Holy Shock Triggered Heal Rank 1 */
48821, /* Paladin - Holy Shock Triggered Heal Rank 1 */
48822, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
48823, /* Paladin - Holy Shock Triggered Hurt Rank 1 */
48826, /* Paladin - Avenger Shield */
48827, /* Paladin - Avenger Shield */
48951, /* Paladin - Holy Shield */
48952, /* Paladin - Holy Shield */
49230, /* Shaman - Earth Shock */
49231, /* Shaman - Earth Shock */
49232, /* Shaman - Flame Shock */
49233, /* Shaman - Flame Shock */
49235, /* Shaman - Frost Shock */
49236, /* Shaman - Frost Shock */
49237, /* Shaman - Lightning Bolt */
49238, /* Shaman - Lightning Bolt */
49270, /* Shaman - Chain Lightning */
49271, /* Shaman - Chain Lightning */
49272, /* Shaman - Healing Wave */
49273, /* Shaman - Healing Wave */
49275, /* Shaman - Lesser Healing Wave */
49276, /* Shaman - Lesser Healing Wave */
49278, /* Shaman - Lightning Shield Proc Rank 1 */
49279, /* Shaman - Lightning Shield Proc Rank 1 */
49821, /* Priest - Mind Sear Trigger Rank 1 */
50288, /* Druid - Starfall rank 1 */
50294, /* Druid - Starfall AOE rank 1 */
50464, /* Druid - Nourish */
50581, /* Warlock - Shadow Cleave */
50590, /* Warlock - Immolation Aura */
50796, /* Warlock - Chaos Bolt */
51505, /* Shaman - Lava Burst */
51945, /* Shaman - Earthliving Weapon */
51963, /* Pet Death Knight, Gargoyle Strike */
51990, /* Shaman - Earthliving Weapon */
51997, /* Shaman - Earthliving Weapon */
51998, /* Shaman - Earthliving Weapon */
51999, /* Shaman - Earthliving Weapon */
52000, /* Shaman - Earthliving Weapon */
52042, /* Shaman - Healing Stream Totem Triggered Heal */
52983, /* Priest - Pennance heal */
52984, /* Priest - Pennance heal */
52985, /* Priest - Pennance heal */
52998, /* Priest - Pennance damage */
52999, /* Priest - Pennance damage */
53000, /* Priest - Pennance damage */
53022, /* Priest - Mind Sear Trigger Rank 1 */
53188, /* Druid - Starfall AOE rank 2 */
53189, /* Druid - Starfall AOE rank 3 */
53190, /* Druid - Starfall AOE rank 4 */
53191, /* Druid - Starfall rank 2 */
53194, /* Druid - Starfall rank 3 */
53195, /* Druid - Starfall rank 4 */
53227, /* Druid - Typhoon */
53248, /* Druid - Wild Growth */
53249, /* Druid - Wild Growth */
53251, /* Druid - Wild Growth */
53308, /* Druid - Entangling Roots */
53313, /* Druid - Entangling Roots (Natures Grasp) */
53733, /* Paladin - Judgement of Corruption */
53742, /* Paladin - Seal of Corruption */
54049, /* Pet Warlock - Shadow Bite */
54050, /* Pet Warlock - Shadow Bite */
54051, /* Pet Warlock - Shadow Bite */
54052, /* Pet Warlock - Shadow Bite */
54053, /* Pet Warlock - Shadow Bite */
54158, /* Paladin - Jugdement (Seal of Light, Seal of Wisdom, Seal of Justice) */
55359, /* Mage - Living Bomb DOT */
55360, /* Mage - Living Bomb DOT */
55361, /* Mage - Living Bomb DD */
55362, /* Mage - Living Bomb DD */
55458, /* Shaman - Chain Heal */
55459, /* Shaman - Chain Heal */
57984, /* Pet Shaman - Fire Elemental Fire Blast */
58381, /* Priest - Mind Flay */
58700, /* Shaman - Searing Totem Attack Rank 8 */
58701, /* Shaman - Searing Totem Attack Rank 9 */
58702, /* Shaman - Searing Totem Attack Rank 10 */
58732, /* Shaman - Magma totem trigger 6 */
58735, /* Shaman - Magma totem trigger 7 */
58797, /* Shaman - Frostbrand Attack */
58798, /* Shaman - Frostbrand Attack */
58799, /* Shaman - Frostbrand Attack */
59170, /* Warlock - Chaos Bolt */
59171, /* Warlock - Chaos Bolt */
59172, /* Warlock - Chaos Bolt */
59637, /* Pet Mage - Mirror Image Fireblast */
59638, /* Pet Mage - Mirror Image Frostbolt */
60043, /* Shaman - Lava Burst */
61290, /* Warlock - Shadowflame(rank 1, DD) */
61291, /* Warlock - Shadowflame(rank 2, DOT) */
61295, /* Shaman - Riptide */
61299, /* Shaman - Riptide */
61300, /* Shaman - Riptide */
61301, /* Shaman - Riptide */
61387, /* Druid - Typhoon */
61388, /* Druid - Typhoon */
61390, /* Druid - Typhoon */
61391, /* Druid - Typhoon */
61650, /* Shaman - Fire Nova Totem */
61654, /* Shaman - Fire Nova Totem */
63668, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
63669, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
63670, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
63671, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
63672, /* Hunter - Black Arrow($RAP*0.1 / number of ticks) */
64844, /* Priest - Divine Hymn */
71757, /* Mage - Deep Freeze */
72898 /* Pet Mage - Water Elemental Frostbolt */
);
