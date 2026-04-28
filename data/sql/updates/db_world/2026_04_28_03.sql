-- DB update 2026_04_28_02 -> 2026_04_28_03
-- Naxxramas loot pool structure fix
-- Splits single GroupId pools into multiple pools matching retail WotLK behavior
-- Source: Wowhead WotLK 25-man drop rates, WowDB cross-validation, ChromieCraft #9131 (Anub'Rekhan)

-- =====================
-- Spider Wing
-- =====================

-- Anub'Rekhan 25-man (4 pools: 5+4+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29249 AND `Item`=1 AND `Reference`=34137;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34137 AND `Item`=39701; -- Dawnwalkers
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34137 AND `Item`=39702; -- Arachnoid Gold Band
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34137 AND `Item`=39703; -- Rescinding Grips
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34137 AND `Item`=39704; -- Pauldrons of Unnatural Death
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34137 AND `Item`=39706; -- Sabatons of Sudden Reprisal

-- Pool B (4 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34137 AND `Item`=39712; -- Gemmed Wand of the Nerubians
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34137 AND `Item`=39714; -- Webbed Death
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34137 AND `Item`=39716; -- Shield of Assimilation
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34137 AND `Item`=39717; -- Inexorable Sabatons

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34137 AND `Item`=39718; -- Corpse Scarab Handguards
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34137 AND `Item`=39719; -- Mantle of the Locusts
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34137 AND `Item`=39720; -- Leggings of Atrophy
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34137 AND `Item`=39721; -- Sash of the Parlor
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34137 AND `Item`=39722; -- Swarm Bindings

-- Pool D (9 items, shared jewelry)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40064; -- Thunderstorm Amulet
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40065; -- Fool's Trial
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40069; -- Heritage
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40071; -- Chains of Adoration
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40074; -- Strong-Handed Ring
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40075; -- Ruthlessness
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40080; -- Lost Jewel
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40107; -- Sand-Worn Band
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34137 AND `Item`=40108; -- Seized Beauty

-- Grand Widow Faerlina 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29268 AND `Item`=1 AND `Reference`=34138;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34138 AND `Item`=39723; -- Fire-Scorched Greathelm
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34138 AND `Item`=39724; -- Cult's Chestguard
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34138 AND `Item`=39725; -- Epaulets of the Grieving Servant
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34138 AND `Item`=39726; -- Callous-Hearted Gauntlets
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34138 AND `Item`=39727; -- Dislocating Handguards

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34138 AND `Item`=39728; -- Totem of Misery
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34138 AND `Item`=39729; -- Bracers of the Tyrant
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34138 AND `Item`=39730; -- Widow's Fury
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34138 AND `Item`=39731; -- Punctilious Bindings
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34138 AND `Item`=39732; -- Faerlina's Madness

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34138 AND `Item`=39733; -- Gloves of Token Respect
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34138 AND `Item`=39734; -- Atonement Greaves
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34138 AND `Item`=39735; -- Belt of False Dignity
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34138 AND `Item`=39756; -- Tunic of Prejudice
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34138 AND `Item`=39757; -- Idol of Worship

-- Pool D (9 items, shared jewelry)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40064; -- Thunderstorm Amulet
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40065; -- Fool's Trial
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40069; -- Heritage
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40071; -- Chains of Adoration
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40074; -- Strong-Handed Ring
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40075; -- Ruthlessness
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40080; -- Lost Jewel
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40107; -- Sand-Worn Band
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34138 AND `Item`=40108; -- Seized Beauty

-- Maexxna 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29278 AND `Item`=1 AND `Reference`=34139;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34139 AND `Item`=39758; -- The Jawbone
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34139 AND `Item`=39759; -- Ablative Chitin Girdle
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34139 AND `Item`=39760; -- Helm of Diminished Pride
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34139 AND `Item`=39761; -- Infectious Skitterer Leggings
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34139 AND `Item`=39762; -- Torn Web Wrapping

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34139 AND `Item`=39763; -- Wraith Strike
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34139 AND `Item`=39764; -- Bindings of the Hapless Prey
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34139 AND `Item`=39765; -- Sinner's Bindings
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34139 AND `Item`=39766; -- Matriarch's Spawn
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34139 AND `Item`=39767; -- Undiminished Battleplate

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34139 AND `Item`=39768; -- Cowl of the Perished
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34139 AND `Item`=40060; -- Distorted Limbs
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34139 AND `Item`=40061; -- Quivering Tunic
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34139 AND `Item`=40062; -- Digested Silken Robes
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34139 AND `Item`=40063; -- Mantle of Shattered Kinship

-- Pool D (9 items, shared cloaks/trinkets)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40250; -- Aged Winter Cloak
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40251; -- Shroud of Luminosity
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40252; -- Cloak of the Shadowed Sun
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40253; -- Shawl of the Old Maid
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40254; -- Cloak of Averted Crisis
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40255; -- Dying Curse
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40256; -- Grim Toll
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40257; -- Defender's Code
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34139 AND `Item`=40258; -- Forethought Talisman

-- =====================
-- Plague Wing
-- =====================

-- Noth the Plaguebringer 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29615 AND `Item`=1 AND `Reference`=34147;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34147 AND `Item`=40184; -- Crippled Treads
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34147 AND `Item`=40185; -- Shoulderguards of Opportunity
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34147 AND `Item`=40186; -- Thrusting Bands
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34147 AND `Item`=40187; -- Poignant Sabatons
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34147 AND `Item`=40188; -- Gauntlets of the Disobedient

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34147 AND `Item`=40189; -- Angry Dread
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34147 AND `Item`=40190; -- Spinning Fate
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34147 AND `Item`=40191; -- Libram of Radiance
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34147 AND `Item`=40192; -- Accursed Spine
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34147 AND `Item`=40193; -- Tunic of Masked Suffering

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34147 AND `Item`=40196; -- Legguards of the Undisturbed
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34147 AND `Item`=40197; -- Gloves of the Fallen Wizard
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34147 AND `Item`=40198; -- Bands of Impurity
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34147 AND `Item`=40200; -- Belt of Potent Chanting
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34147 AND `Item`=40602; -- Robes of Mutation

-- Pool D (9 items, shared jewelry)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40064; -- Thunderstorm Amulet
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40065; -- Fool's Trial
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40069; -- Heritage
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40071; -- Chains of Adoration
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40074; -- Strong-Handed Ring
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40075; -- Ruthlessness
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40080; -- Lost Jewel
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40107; -- Sand-Worn Band
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34147 AND `Item`=40108; -- Seized Beauty

-- Heigan the Unclean 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29701 AND `Item`=1 AND `Reference`=34148;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34148 AND `Item`=40201; -- Leggings of Colossal Strides
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34148 AND `Item`=40203; -- Breastplate of Tormented Rage
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34148 AND `Item`=40204; -- Legguards of the Apostle
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34148 AND `Item`=40205; -- Stalk-Skin Belt
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34148 AND `Item`=40206; -- Iron-Spring Jumpers

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34148 AND `Item`=40207; -- Sigil of Awareness
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34148 AND `Item`=40208; -- Cryptfiend's Bite
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34148 AND `Item`=40209; -- Bindings of the Decrepit
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34148 AND `Item`=40210; -- Chestguard of Bitter Charms
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34148 AND `Item`=40233; -- The Undeath Carrier

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34148 AND `Item`=40234; -- Heigan's Putrid Vestments
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34148 AND `Item`=40235; -- Helm of Pilgrimage
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34148 AND `Item`=40236; -- Serene Echoes
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34148 AND `Item`=40237; -- Eruption-Scarred Boots
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34148 AND `Item`=40238; -- Gloves of the Dancing Bear

-- Pool D (9 items, shared cloaks/trinkets)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40250; -- Aged Winter Cloak
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40251; -- Shroud of Luminosity
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40252; -- Cloak of the Shadowed Sun
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40253; -- Shawl of the Old Maid
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40254; -- Cloak of Averted Crisis
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40255; -- Dying Curse
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40256; -- Grim Toll
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40257; -- Defender's Code
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34148 AND `Item`=40258; -- Forethought Talisman

-- =====================
-- Military Wing
-- =====================

-- Instructor Razuvious 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29940 AND `Item`=1 AND `Reference`=34144;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34144 AND `Item`=40305; -- Spaulders of Egotism
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34144 AND `Item`=40306; -- Bracers of the Unholy Knight
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34144 AND `Item`=40315; -- Shoulderpads of Secret Arts
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34144 AND `Item`=40316; -- Gauntlets of Guiding Touch
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34144 AND `Item`=40317; -- Girdle of Razuvious

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34144 AND `Item`=40318; -- Legplates of Double Strikes
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34144 AND `Item`=40319; -- Chestpiece of Suspicion
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34144 AND `Item`=40320; -- Faithful Steel Sabatons
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34144 AND `Item`=40321; -- Idol of the Shooting Star
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34144 AND `Item`=40322; -- Totem of Dueling

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34144 AND `Item`=40323; -- Esteemed Bindings
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34144 AND `Item`=40324; -- Bands of Mutual Respect
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34144 AND `Item`=40325; -- Bindings of the Expansive Mind
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34144 AND `Item`=40326; -- Boots of Forlorn Wishes
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34144 AND `Item`=40327; -- Girdle of Recuperation

-- Pool D (9 items, shared jewelry)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40064; -- Thunderstorm Amulet
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40065; -- Fool's Trial
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40069; -- Heritage
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40071; -- Chains of Adoration
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40074; -- Strong-Handed Ring
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40075; -- Ruthlessness
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40080; -- Lost Jewel
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40107; -- Sand-Worn Band
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34144 AND `Item`=40108; -- Seized Beauty

-- Gothik the Harvester 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29955 AND `Item`=1 AND `Reference`=34145;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34145 AND `Item`=40328; -- Helm of Vital Protection
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34145 AND `Item`=40329; -- Hood of the Exodus
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34145 AND `Item`=40330; -- Bracers of Unrelenting Attack
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34145 AND `Item`=40331; -- Leggings of Failed Escape
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34145 AND `Item`=40332; -- Abetment Bracers

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34145 AND `Item`=40333; -- Leggings of Fleeting Moments
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34145 AND `Item`=40334; -- Burdened Shoulderplates
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34145 AND `Item`=40335; -- Touch of Horror
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34145 AND `Item`=40336; -- Life and Death
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34145 AND `Item`=40337; -- Libram of Resurgence

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34145 AND `Item`=40338; -- Bindings of Yearning
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34145 AND `Item`=40339; -- Gothik's Cowl
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34145 AND `Item`=40340; -- Helm of Unleashed Energy
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34145 AND `Item`=40341; -- Shackled Cinch
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34145 AND `Item`=40342; -- Idol of Awakening

-- Pool D (9 items, shared cloaks/trinkets)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40250; -- Aged Winter Cloak
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40251; -- Shroud of Luminosity
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40252; -- Cloak of the Shadowed Sun
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40253; -- Shawl of the Old Maid
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40254; -- Cloak of Averted Crisis
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40255; -- Dying Curse
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40256; -- Grim Toll
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40257; -- Defender's Code
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34145 AND `Item`=40258; -- Forethought Talisman

-- =====================
-- Construct Wing
-- =====================

-- Patchwerk 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29324 AND `Item`=1 AND `Reference`=34140;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34140 AND `Item`=40259; -- Waistguard of Divine Grace
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34140 AND `Item`=40260; -- Belt of the Tortured
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34140 AND `Item`=40261; -- Crude Discolored Battlegrips
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34140 AND `Item`=40262; -- Gloves of Calculated Risk
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34140 AND `Item`=40263; -- Fleshless Girdle

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34140 AND `Item`=40264; -- Split Greathammer
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34140 AND `Item`=40265; -- Arrowsong
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34140 AND `Item`=40266; -- Hero's Surrender
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34140 AND `Item`=40267; -- Totem of Hex
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34140 AND `Item`=40268; -- Libram of Tolerance

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34140 AND `Item`=40269; -- Boots of Persuasion
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34140 AND `Item`=40270; -- Boots of Septic Wounds
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34140 AND `Item`=40271; -- Sash of Solitude
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34140 AND `Item`=40272; -- Girdle of the Gambit
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34140 AND `Item`=40273; -- Surplus Limb

-- Pool D (9 items, shared jewelry)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40064; -- Thunderstorm Amulet
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40065; -- Fool's Trial
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40069; -- Heritage
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40071; -- Chains of Adoration
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40074; -- Strong-Handed Ring
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40075; -- Ruthlessness
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40080; -- Lost Jewel
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40107; -- Sand-Worn Band
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34140 AND `Item`=40108; -- Seized Beauty

-- Grobbulus 25-man (4 pools: 5+5+5+9)
UPDATE `creature_loot_template` SET `MinCount`=1, `MaxCount`=1
  WHERE `Entry`=29373 AND `Item`=1 AND `Reference`=34141;

-- Pool A (5 items)
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34141 AND `Item`=40274; -- Bracers of Liberation
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34141 AND `Item`=40275; -- Depraved Linked Belt
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34141 AND `Item`=40277; -- Tunic of Indulgence
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34141 AND `Item`=40278; -- Girdle of Chivalry
UPDATE `reference_loot_template` SET `GroupId`=1 WHERE `Entry`=34141 AND `Item`=40279; -- Chestguard of the Exhausted

-- Pool B (5 items)
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34141 AND `Item`=40280; -- Origin of Nightmares
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34141 AND `Item`=40281; -- Twilight Mist
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34141 AND `Item`=40282; -- Slime Stream Bands
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34141 AND `Item`=40283; -- Fallout Impervious Tunic
UPDATE `reference_loot_template` SET `GroupId`=2 WHERE `Entry`=34141 AND `Item`=40284; -- Plague Igniter

-- Pool C (5 items)
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34141 AND `Item`=40285; -- Desecrated Past
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34141 AND `Item`=40287; -- Cowl of Vanity
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34141 AND `Item`=40288; -- Spaulders of Incoherence
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34141 AND `Item`=40289; -- Sympathetic Amice
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=34141 AND `Item`=40351; -- Mantle of the Fatigued Sage

-- Pool D (9 items, shared cloaks/trinkets)
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40250; -- Aged Winter Cloak
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40251; -- Shroud of Luminosity
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40252; -- Cloak of the Shadowed Sun
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40253; -- Shawl of the Old Maid
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40254; -- Cloak of Averted Crisis
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40255; -- Dying Curse
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40256; -- Grim Toll
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40257; -- Defender's Code
UPDATE `reference_loot_template` SET `GroupId`=4 WHERE `Entry`=34141 AND `Item`=40258; -- Forethought Talisman
