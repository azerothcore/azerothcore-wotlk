-- Breadcrumb quest updates from Questie data
-- Sets BreadcrumbForQuestId for quests that serve as breadcrumbs pointing to other quests
--

-- Vanilla Breadcrumbs
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 144 WHERE `ID` = 143; -- "Messenger to Westfall" [143] -> "Messenger to Westfall" [144]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 146 WHERE `ID` = 145; -- "Messenger to Darkshire" [145] -> "Messenger to Darkshire" [146]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 166 WHERE `ID` = 155; -- "The Defias Brotherhood" [155] -> "The Defias Brotherhood" [166]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4493 WHERE `ID` = 162; -- "Rise of the Silithid" -> "March of the Silithid"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6383 WHERE `ID` = 235; -- "The Ashenvale Hunt" [235] -> "The Ashenvale Hunt" [6383]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11 WHERE `ID` = 239; -- "Westbrook Garrison Needs Help!" -> "Riverpaw Gnoll Bounty"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 253 WHERE `ID` = 254; -- "Digging Through the Dirt" -> "Bride of the Embalmer"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 291 WHERE `ID` = 287; -- "Frostmane Hold" -> "The Reports"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 311 WHERE `ID` = 308; -- "Distracting Jarven" -> "Return to Marleth"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 413 WHERE `ID` = 315; -- "The Perfect Stout" -> "Shimmer Stout"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 364 WHERE `ID` = 363; -- "Rude Awakening" -> "The Mindless Ones"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 311 WHERE `ID` = 403; -- "Guarded Thunderbrew Barrel" -> "Return to Marleth"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 322 WHERE `ID` = 526; -- "Lightforge Ingots" -> "Blessed Arm"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 566 WHERE `ID` = 549; -- "WANTED: Syndicate Personnel" -> "WANTED: Baron Vardus"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 677 WHERE `ID` = 676; -- "The Hammer May Fall" -> "Call to Arms"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 738 WHERE `ID` = 707; -- "Ironband Wants You!" -> "Find Agmond"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6383 WHERE `ID` = 742; -- "The Ashenvale Hunt" [742] -> "The Ashenvale Hunt" [6383]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 753 WHERE `ID` = 752; -- "A Humble Task" [752] -> "A Humble Task" [753]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 654 WHERE `ID` = 841; -- "Another Power Source?" -> "Tanaris Field Sampling"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 844 WHERE `ID` = 854; -- "Journey to the Crossroads" -> "Plainstrider Menace"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 844 WHERE `ID` = 860; -- "Sergra Darkthorn" -> "Plainstrider Menace"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 844 WHERE `ID` = 861; -- "The Hunter's Way" -> "Plainstrider Menace"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 870 WHERE `ID` = 886; -- "The Barrens Oases" -> "The Forgotten Pools"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1004 WHERE `ID` = 1000; -- "The New Frontier" [1000] -> "The New Frontier" [1004]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1000 WHERE `ID` = 1004; -- "The New Frontier" [1004] -> "The New Frontier" [1000]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1047 WHERE `ID` = 1015; -- "The New Frontier" [1015] -> "The New Frontier" [1047]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1000 WHERE `ID` = 1018; -- "The New Frontier" [1018] -> "The New Frontier" [1000]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1015 WHERE `ID` = 1019; -- "The New Frontier" [1019] -> "The New Frontier" [1015]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1015 WHERE `ID` = 1047; -- "The New Frontier" [1047] -> "The New Frontier" [1015]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1062 WHERE `ID` = 1061; -- "The Spirits of Stonetalon" -> "Goblin Invaders"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1131 WHERE `ID` = 1130; -- "Melor Sends Word" -> "Steelsnap"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1133 WHERE `ID` = 1132; -- "Fiora Longears" -> "Journey to Astranaar"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1200 WHERE `ID` = 1198; -- "In Search of Thaelrid" -> "Blackfathom Villainy"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1301 WHERE `ID` = 1282; -- "They Call Him Smiling Jim" -> "James Hyal"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1362 WHERE `ID` = 1361; -- "Regthar Deathgate" -> "The Kolkar of Desolace"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1485 WHERE `ID` = 1470; -- "Piercing the Veil" -> "Vile Familiars"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1504 WHERE `ID` = 1471; -- "The Binding" [1471] -> "The Binding" [1504]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1513 WHERE `ID` = 1474; -- "The Binding" [1474] -> "The Binding" [1513]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1093 WHERE `ID` = 1483; -- "Ziz Fizziks" -> "Super Reaper 6000"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1470 WHERE `ID` = 1485; -- "Vile Familiars" -> "Piercing the Veil"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1471 WHERE `ID` = 1504; -- "The Binding" [1504] -> "The Binding" [1471]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1474 WHERE `ID` = 1513; -- "The Binding" [1513] -> "The Binding" [1474]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1519 WHERE `ID` = 1516; -- "Call of Earth" [1516] -> "Call of Earth" [1519]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1516 WHERE `ID` = 1519; -- "Call of Earth" [1519] -> "Call of Earth" [1516]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1524 WHERE `ID` = 1522; -- "Call of Fire" [1522] -> "Call of Fire" [1524]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1530 WHERE `ID` = 1528; -- "Call of Water" [1528] -> "Call of Water" [1530]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1530 WHERE `ID` = 1529; -- "Call of Water" [1529] -> "Call of Water" [1530]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1599 WHERE `ID` = 1598; -- "The Stolen Tome" -> "Beginnings"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1598 WHERE `ID` = 1599; -- "Beginnings" -> "The Stolen Tome"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1678 WHERE `ID` = 1638; -- "A Warrior's Training" -> "Vejrek"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1646 WHERE `ID` = 1642; -- "The Tome of Divinity" [1642] -> "The Tome of Divinity" [1646]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 1645; -- "The Tome of Divinity" [1645] -> "The Tome of Divinity" [1642]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 1646; -- "The Tome of Divinity" [1646] -> "The Tome of Divinity" [1642]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4485 WHERE `ID` = 1661; -- "The Tome of Nobility" [1661] -> "The Tome of Nobility" [4485]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1785 WHERE `ID` = 1789; -- "The Symbol of Life" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1788 WHERE `ID` = 1790; -- "The Symbol of Life" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1649 WHERE `ID` = 1793; -- "The Tome of Valor" [1793] -> "The Tome of Valor" [1649]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1819 WHERE `ID` = 1818; -- "Speak with Dillinger" -> "Ulag the Cleaver"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1838 WHERE `ID` = 1825; -- "Speak with Thun'grim" -> "Brutal Armor"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1963 WHERE `ID` = 1859; -- "Therzok" -> "The Shattered Hand"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1886 WHERE `ID` = 1885; -- "Mennet Carkad" -> "The Deathstalkers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2518 WHERE `ID` = 2519; -- "The Temple of the Moon" -> "Tears of the Moon"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2770 WHERE `ID` = 2769; -- "The Brassbolts Brothers" -> "Gahz'rilla"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2842 WHERE `ID` = 2841; -- "Rig Wars" -> "Chief Engineer Scooty"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2865 WHERE `ID` = 2864; -- "Tran'rek" -> "Scarab Shells"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2873 WHERE `ID` = 2872; -- "Stoley's Debt" -> "Stoley's Shipment"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4601 WHERE `ID` = 2951; -- "The Sparklematic 5200!" [2951] -> "The Sparklematic 5200!" [4601]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4605 WHERE `ID` = 2952; -- "The Sparklematic 5200!" [2952] -> "The Sparklematic 5200!" [4605]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4603 WHERE `ID` = 2953; -- "More Sparklematic Action" [2953] -> "More Sparklematic Action" [4603]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2975 WHERE `ID` = 2981; -- "A Threat in Feralas" -> "The Ogres of Feralas"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1524 WHERE `ID` = 2983; -- "Call of Fire" [2983] -> "Call of Fire" [1524]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1524 WHERE `ID` = 2984; -- "Call of Fire" [2984] -> "Call of Fire" [1524]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1530 WHERE `ID` = 2985; -- "Call of Water" [2985] -> "Call of Water" [1530]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1530 WHERE `ID` = 2986; -- "Call of Water" [2986] -> "Call of Water" [1530]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 2997; -- "Tome of Divinity" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 2998; -- "Tome of Divinity" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 2999; -- "Tome of Divinity" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 3000; -- "Tome of Divinity" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3633 WHERE `ID` = 3526; -- "Goblin Engineering" [3526] -> "Goblin Engineering" [3633]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3633 WHERE `ID` = 3629; -- "Goblin Engineering" [3629] -> "Goblin Engineering" [3633]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3632 WHERE `ID` = 3630; -- "Gnome Engineering" [3630] -> "Gnome Engineering" [3632]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3630 WHERE `ID` = 3632; -- "Gnome Engineering" [3632] -> "Gnome Engineering" [3630]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3526 WHERE `ID` = 3633; -- "Goblin Engineering" [3633] -> "Goblin Engineering" [3526]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3630 WHERE `ID` = 3634; -- "Gnome Engineering" [3634] -> "Gnome Engineering" [3630]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3637 WHERE `ID` = 3635; -- "Gnome Engineering" [3635] -> "Gnome Engineering" [3637]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3635 WHERE `ID` = 3637; -- "Gnome Engineering" [3637] -> "Gnome Engineering" [3635]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3641 WHERE `ID` = 3639; -- "Show Your Work" [3639] -> "Show Your Work" [3641]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3639 WHERE `ID` = 3641; -- "Show Your Work" [3641] -> "Show Your Work" [3639]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3639 WHERE `ID` = 3643; -- "Show Your Work" [3643] -> "Show Your Work" [3639]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1642 WHERE `ID` = 3681; -- "Tome of Divinity" -> "The Tome of Divinity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1275 WHERE `ID` = 3765; -- "The Corruption Abroad" -> "Researching the Corruption"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3481 WHERE `ID` = 4023; -- "A Taste of Flame" -> "Trinkets..."
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4126 WHERE `ID` = 4128; -- "Ragnar Thunderbrew" -> "Hurley Blackbreath"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 3629 WHERE `ID` = 4181; -- "Goblin Engineering" [4181] -> "Goblin Engineering" [3629]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4493 WHERE `ID` = 4267; -- "Rise of the Silithid" -> "March of the Silithid"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1661 WHERE `ID` = 4486; -- "The Tome of Nobility" [4486] -> "The Tome of Nobility" [1661]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 4841 WHERE `ID` = 4542; -- "Message to Freewind Post" -> "Pacify the Centaur"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2951 WHERE `ID` = 4601; -- "The Sparklematic 5200!" [4601] -> "The Sparklematic 5200!" [2951]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2951 WHERE `ID` = 4602; -- "The Sparklematic 5200!" [4602] -> "The Sparklematic 5200!" [2951]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2953 WHERE `ID` = 4603; -- "More Sparklematic Action" [4603] -> "More Sparklematic Action" [2953]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2953 WHERE `ID` = 4604; -- "More Sparklematic Action" [4604] -> "More Sparklematic Action" [2953]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2952 WHERE `ID` = 4605; -- "The Sparklematic 5200!" [4605] -> "The Sparklematic 5200!" [2952]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 2952 WHERE `ID` = 4606; -- "The Sparklematic 5200!" [4606] -> "The Sparklematic 5200!" [2952]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 788 WHERE `ID` = 4641; -- "Your Place In The World" -> "Cutting Teeth"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 33 WHERE `ID` = 5261; -- "Eagan Peltskinner" -> "Wolves Across the Border"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8869 WHERE `ID` = 5305; -- "Sweet Serenity" [5305] -> "Sweet Serenity" [8869]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5621 WHERE `ID` = 5622; -- "In Favor of Elune" -> "Garments of the Moon"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5624 WHERE `ID` = 5623; -- "In Favor of the Light" -> "Garments of the Light"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5625 WHERE `ID` = 5626; -- "In Favor of the Light" -> "Garments of the Light"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5634 WHERE `ID` = 5636; -- "Desperate Prayer" [5636] -> "Desperate Prayer" [5634]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5634 WHERE `ID` = 5638; -- "Desperate Prayer" [5638] -> "Desperate Prayer" [5634]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5634 WHERE `ID` = 5639; -- "Desperate Prayer" [5639] -> "Desperate Prayer" [5634]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5648 WHERE `ID` = 5649; -- "In Favor of Spirituality" -> "Garments of Spirituality"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5650 WHERE `ID` = 5651; -- "In Favor of Darkness" -> "Garments of Darkness"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5676 WHERE `ID` = 5677; -- "Arcane Feedback" [5677] -> "Arcane Feedback" [5676]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6066 WHERE `ID` = 6065; -- "The Hunter's Path" [6065] -> "The Hunter's Path" [6066]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6065 WHERE `ID` = 6067; -- "The Hunter's Path" [6067] -> "The Hunter's Path" [6065]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6072 WHERE `ID` = 6071; -- "The Hunter's Path" [6071] -> "The Hunter's Path" [6072]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6071 WHERE `ID` = 6072; -- "The Hunter's Path" [6072] -> "The Hunter's Path" [6071]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6074 WHERE `ID` = 6076; -- "The Hunter's Path" [6076] -> "The Hunter's Path" [6074]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6341 WHERE `ID` = 6344; -- "Nessa Shadowsong" -> "The Bounty of Teldrassil"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6383 WHERE `ID` = 6382; -- "The Ashenvale Hunt" [6382] -> "The Ashenvale Hunt" [6383]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6543 WHERE `ID` = 6541; -- "Report to Kadrak" -> "The Warsong Reports"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6543 WHERE `ID` = 6542; -- "Report to Kadrak" -> "The Warsong Reports"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6563 WHERE `ID` = 6562; -- "Trouble in the Deeps" -> "The Essence of Aku'Mai"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 6607 WHERE `ID` = 6608; -- "You Too Good." -> "Nat Pagle, Angler Extreme"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7021 WHERE `ID` = 6961; -- "Great-father Winter is Here!" [6961] -> "Great-father Winter is Here!" [7021]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5892 WHERE `ID` = 7121; -- "The Quartermaster" -> "Irondeep Supplies"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5893 WHERE `ID` = 7123; -- "Speak with our Quartermaster" -> "Coldtooth Supplies"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7161 WHERE `ID` = 7241; -- "In Defense of Frostwolf" -> "Proving Grounds"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7162 WHERE `ID` = 7261; -- "The Sovereign Imperative" -> "Proving Grounds"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 7668 WHERE `ID` = 8258; -- "The Darkreaver Menace" [8258] -> "The Darkreaver Menace" [7668]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8332 WHERE `ID` = 8331; -- "Aurel Goldleaf" -> "Dukes of the Council"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8341 WHERE `ID` = 8343; -- "Goldleaf's Discovery" -> "Lords of the Council"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8348 WHERE `ID` = 8349; -- "Bor Wildmane" -> "Signet of the Dukes"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8352 WHERE `ID` = 8351; -- "Bor Wishes to Speak" -> "Scepter of the Council"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8426 WHERE `ID` = 8368; -- "Battle of Warsong Gulch" [8368] -> "Battle of Warsong Gulch" [8426]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8436 WHERE `ID` = 8370; -- "Conquering Arathi Basin" [8370] -> "Conquering Arathi Basin" [8436]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8399 WHERE `ID` = 8372; -- "Fight for Warsong Gulch" [8372] -> "Fight for Warsong Gulch" [8399]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8393 WHERE `ID` = 8374; -- "Claiming Arathi Basin" [8374] -> "Claiming Arathi Basin" [8393]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8374 WHERE `ID` = 8393; -- "Claiming Arathi Basin" [8393] -> "Claiming Arathi Basin" [8374]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8374 WHERE `ID` = 8394; -- "Claiming Arathi Basin" [8394] -> "Claiming Arathi Basin" [8374]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8374 WHERE `ID` = 8395; -- "Claiming Arathi Basin" [8395] -> "Claiming Arathi Basin" [8374]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8374 WHERE `ID` = 8396; -- "Claiming Arathi Basin" [8396] -> "Claiming Arathi Basin" [8374]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8372 WHERE `ID` = 8399; -- "Fight for Warsong Gulch" [8399] -> "Fight for Warsong Gulch" [8372]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8372 WHERE `ID` = 8400; -- "Fight for Warsong Gulch" [8400] -> "Fight for Warsong Gulch" [8372]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8372 WHERE `ID` = 8401; -- "Fight for Warsong Gulch" [8401] -> "Fight for Warsong Gulch" [8372]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8372 WHERE `ID` = 8402; -- "Fight for Warsong Gulch" [8402] -> "Fight for Warsong Gulch" [8372]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8372 WHERE `ID` = 8403; -- "Fight for Warsong Gulch" [8403] -> "Fight for Warsong Gulch" [8372]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8411 WHERE `ID` = 8410; -- "Elemental Mastery" -> "Mastering the Elements"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8410 WHERE `ID` = 8411; -- "Mastering the Elements" -> "Elemental Mastery"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8368 WHERE `ID` = 8426; -- "Battle of Warsong Gulch" [8426] -> "Battle of Warsong Gulch" [8368]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8368 WHERE `ID` = 8427; -- "Battle of Warsong Gulch" [8427] -> "Battle of Warsong Gulch" [8368]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8368 WHERE `ID` = 8428; -- "Battle of Warsong Gulch" [8428] -> "Battle of Warsong Gulch" [8368]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8368 WHERE `ID` = 8429; -- "Battle of Warsong Gulch" [8429] -> "Battle of Warsong Gulch" [8368]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8368 WHERE `ID` = 8430; -- "Battle of Warsong Gulch" [8430] -> "Battle of Warsong Gulch" [8368]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8370 WHERE `ID` = 8436; -- "Conquering Arathi Basin" [8436] -> "Conquering Arathi Basin" [8370]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8370 WHERE `ID` = 8437; -- "Conquering Arathi Basin" [8437] -> "Conquering Arathi Basin" [8370]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8370 WHERE `ID` = 8438; -- "Conquering Arathi Basin" [8438] -> "Conquering Arathi Basin" [8370]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8370 WHERE `ID` = 8439; -- "Conquering Arathi Basin" [8439] -> "Conquering Arathi Basin" [8370]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8752 WHERE `ID` = 8747; -- "The Path of the Protector" -> "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8752 WHERE `ID` = 8748; -- "The Path of the Protector" -> "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8752 WHERE `ID` = 8749; -- "The Path of the Protector" -> "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8752 WHERE `ID` = 8750; -- "The Path of the Protector" -> "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8752 WHERE `ID` = 8751; -- "The Protector of Kalimdor" -> "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8752; -- "The Path of the Conqueror" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8753; -- "The Path of the Conqueror" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8754; -- "The Path of the Conqueror" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8755; -- "The Path of the Conqueror" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8756; -- "The Qiraji Conqueror" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8757; -- "The Path of the Invoker" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8758; -- "The Path of the Invoker" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8759; -- "The Path of the Invoker" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8760; -- "The Path of the Invoker" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8747 WHERE `ID` = 8761; -- "The Grand Invoker" -> "The Path of the Protector"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8788 WHERE `ID` = 8767; -- "A Gently Shaken Gift" [8767] -> "A Gently Shaken Gift" [8788]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8767 WHERE `ID` = 8788; -- "A Gently Shaken Gift" [8788] -> "A Gently Shaken Gift" [8767]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8796 WHERE `ID` = 8795; -- "The Alliance Needs Your Help!" [8795] -> "The Alliance Needs Your Help!" [8796]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8795 WHERE `ID` = 8796; -- "The Alliance Needs Your Help!" [8796] -> "The Alliance Needs Your Help!" [8795]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8795 WHERE `ID` = 8797; -- "The Alliance Needs Your Help!" [8797] -> "The Alliance Needs Your Help!" [8795]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5305 WHERE `ID` = 8869; -- "Sweet Serenity" [8869] -> "Sweet Serenity" [5305]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8870; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8871; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8872; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8873; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8874; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8867 WHERE `ID` = 8875; -- "The Lunar Festival" -> "Lunar Fireworks"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8903 WHERE `ID` = 8897; -- "Dearest Colara," -> "Dangerous Love"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8903 WHERE `ID` = 8898; -- "Dearest Colara," -> "Dangerous Love"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8903 WHERE `ID` = 8899; -- "Dearest Colara," -> "Dangerous Love"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8901 WHERE `ID` = 8900; -- "Dearest Elenia," [8900] -> "Dearest Elenia," [8901]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8900 WHERE `ID` = 8901; -- "Dearest Elenia," [8901] -> "Dearest Elenia," [8900]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8900 WHERE `ID` = 8902; -- "Dearest Elenia," [8902] -> "Dearest Elenia," [8900]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8905; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8906; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8907; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8908; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8909; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8910; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8911; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8922 WHERE `ID` = 8912; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8913; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8914; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8915; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8916; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8917; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8918; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8919; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8923 WHERE `ID` = 8920; -- "An Earnest Proposition" -> "A Supernatural Device"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8967 WHERE `ID` = 8966; -- "The Left Piece of Lord Valthalak's Amulet" [8966] -> "The Left Piece of Lord Valthalak's Amulet" [8967]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8966 WHERE `ID` = 8967; -- "The Left Piece of Lord Valthalak's Amulet" [8967] -> "The Left Piece of Lord Valthalak's Amulet" [8966]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8966 WHERE `ID` = 8968; -- "The Left Piece of Lord Valthalak's Amulet" [8968] -> "The Left Piece of Lord Valthalak's Amulet" [8966]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8966 WHERE `ID` = 8969; -- "The Left Piece of Lord Valthalak's Amulet" [8969] -> "The Left Piece of Lord Valthalak's Amulet" [8966]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8980 WHERE `ID` = 8979; -- "Fenstad's Hunch" -> "Zinge's Assessment"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9025 WHERE `ID` = 9024; -- "Aristan's Hunch" -> "Morgan's Discovery"

-- TBC Breadcrumbs
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1678 WHERE `ID` = 1639; -- "Bartleby the Drunk" -> "Vejrek"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1639 WHERE `ID` = 1678; -- "Vejrek" -> "Bartleby the Drunk"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1639 WHERE `ID` = 1679; -- "Muren Stormpike" -> "Bartleby the Drunk"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1639 WHERE `ID` = 1683; -- "Vorlus Vilehoof" -> "Bartleby the Drunk"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 1639 WHERE `ID` = 1684; -- "Elanaria" -> "Bartleby the Drunk"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5405 WHERE `ID` = 5401; -- "Argent Dawn Commission" [5401] -> "Argent Dawn Commission" [5405]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5401 WHERE `ID` = 5405; -- "Argent Dawn Commission" [5405] -> "Argent Dawn Commission" [5401]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 5401 WHERE `ID` = 5503; -- "Argent Dawn Commission" [5503] -> "Argent Dawn Commission" [5401]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9704 WHERE `ID` = 8347; -- "Aiding the Outrunners" -> "Slain by the Wretched"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9062 WHERE `ID` = 9035; -- "Roadside Ambush" -> "Soaked Pages"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9220 WHERE `ID` = 9151; -- "The Sanctum of the Sun" -> "War on Deatholme"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8490 WHERE `ID` = 9253; -- "Runewarden Deryan" -> "Powering our Defenses"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8487 WHERE `ID` = 9254; -- "The Wayward Apprentice" -> "Corrupted Soil"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8892 WHERE `ID` = 9256; -- "Fairbreeze Village" -> "Situation at Sunsail Anchorage"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8473 WHERE `ID` = 9258; -- "The Scorched Grove" -> "A Somber Task"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9280 WHERE `ID` = 9279; -- "You Survived!" -> "Replenishing the Healing Crystals"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9161 WHERE `ID` = 9282; -- "The Farstrider Enclave" -> "The Traitor's Shadow"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8476 WHERE `ID` = 9359; -- "Farstrider Retreat" -> "Amani Encroachment"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10302 WHERE `ID` = 9371; -- "Botanist Taerix" -> "Volatile Mutations"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8894 WHERE `ID` = 9394; -- "Where's Wyllithen?" -> "Cleaning up the Grounds"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9067 WHERE `ID` = 9395; -- "Saltheril's Haven" -> "The Party Never Ends"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9419 WHERE `ID` = 9415; -- "Report to Marshal Bluewall" -> "Scouring the Desert"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9422 WHERE `ID` = 9416; -- "Report to General Kirika" -> "Scouring the Desert"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9506 WHERE `ID` = 9505; -- "The Prophecy of Velen" -> "A Small Start"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9591 WHERE `ID` = 9757; -- "Seek Huntress Kella Nightbow" -> "Taming the Beast"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9759 WHERE `ID` = 9760; -- "Vindicator's Rest" -> "Ending Their World"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10105 WHERE `ID` = 9796; -- "News from Zangarmarsh" -> "News for Rakoria"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9882 WHERE `ID` = 9913; -- "The Consortium Needs You!" -> "Stealing from Thieves"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9991 WHERE `ID` = 9983; -- "He Called Himself Altruis..." -> "Survey the Land"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8330 WHERE `ID` = 10071; -- "Well Watcher Solanian" -> "Solanian's Belongings"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8330 WHERE `ID` = 10073; -- "Well Watcher Solanian" -> "Solanian's Belongings"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9796 WHERE `ID` = 10105; -- "News for Rakoria" -> "News from Zangarmarsh"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9854 WHERE `ID` = 10113; -- "The Nesingwary Safari" -> "Windroc Mastery"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9854 WHERE `ID` = 10114; -- "The Nesingwary Safari" -> "Windroc Mastery"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9303 WHERE `ID` = 10304; -- "Vindicator Aldar" -> "Inoculation"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9598 WHERE `ID` = 10366; -- "Jol" -> "Redemption"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9527 WHERE `ID` = 10428; -- "The Missing Fisherman" -> "All That Remains"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9484 WHERE `ID` = 10530; -- "The Hunter's Path" -> "Taming the Beast"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10584 WHERE `ID` = 10580; -- "Where Did Those Darn Gnomes Go?" -> "Picking Up Some Power Converters"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11052 WHERE `ID` = 10708; -- "Akama's Promise" [10708] -> "Akama's Promise" [11052]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11031 WHERE `ID` = 10725; -- "Eminence Among the Violet Eye" -> "Archmage No More"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11034 WHERE `ID` = 10726; -- "Eminence Among the Violet Eye" -> "Restorer No More"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11033 WHERE `ID` = 10727; -- "Eminence Among the Violet Eye" -> "Assassin No More"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11032 WHERE `ID` = 10728; -- "Eminence Among the Violet Eye" -> "Protector No More"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10908 WHERE `ID` = 10862; -- "Surrender to the Horde" -> "Speak with Rilak the Redeemed"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10908 WHERE `ID` = 10863; -- "Secrets of the Arakkoa" -> "Speak with Rilak the Redeemed"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10899 WHERE `ID` = 10905; -- "Master of Potions" -> "Master of Transmutation"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10897 WHERE `ID` = 10906; -- "Master of Elixirs" -> "Master of Potions"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10897 WHERE `ID` = 10907; -- "Master of Transmutation" -> "Master of Potions"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10862 WHERE `ID` = 10908; -- "Speak with Rilak the Redeemed" -> "Surrender to the Horde"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10983 WHERE `ID` = 10984; -- "Speak with the Ogre" -> "Mog'dorg the Wizened"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11044 WHERE `ID` = 11043; -- "Building a Better Gryphon" -> "Visions of Destruction"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11043 WHERE `ID` = 11044; -- "Visions of Destruction" -> "Building a Better Gryphon"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11043 WHERE `ID` = 11045; -- "Zorus the Judicator" -> "Building a Better Gryphon"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11047 WHERE `ID` = 11046; -- "Chief Apothecary Hildagard" -> "The Apprentice's Request"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11046 WHERE `ID` = 11047; -- "The Apprentice's Request" -> "Chief Apothecary Hildagard"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11046 WHERE `ID` = 11048; -- "Kroghan's Report" -> "Chief Apothecary Hildagard"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10708 WHERE `ID` = 11052; -- "Akama's Promise" [11052] -> "Akama's Promise" [10708]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11158 WHERE `ID` = 11208; -- "Delivery for Drazzit" -> "Bloodfen Feathers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11158 WHERE `ID` = 11211; -- "Help for Mudsprocket" -> "Bloodfen Feathers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11158 WHERE `ID` = 11214; -- "Mission to Mudsprocket" -> "Bloodfen Feathers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11158 WHERE `ID` = 11215; -- "Help Mudsprocket" -> "Bloodfen Feathers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9824 WHERE `ID` = 11216; -- "Archmage Alturus" -> "Arcane Disturbances"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11360 WHERE `ID` = 11356; -- "Costumed Orphan Matron" -> "Fire Brigade Practice"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11361 WHERE `ID` = 11357; -- "Masked Orphan Matron" -> "Fire Training"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11439 WHERE `ID` = 11360; -- "Fire Brigade Practice" [11360] -> "Fire Brigade Practice" [11439]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11449 WHERE `ID` = 11361; -- "Fire Training" [11361] -> "Fire Training" [11449]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11441 WHERE `ID` = 11442; -- "Welcome to Brewfest!" -> "Brewfest!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11446 WHERE `ID` = 11447; -- "Welcome to Brewfest!" -> "Brewfest!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11513 WHERE `ID` = 11534; -- "Report to Nasuun" -> "Intercepting the Mana Cells"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12515 WHERE `ID` = 12513; -- "Nice Hat..." [12513] -> "Nice Hat..." [12515]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12513 WHERE `ID` = 12515; -- "Nice Hat..." [12515] -> "Nice Hat..." [12513]

-- Wrath Breadcrumbs
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 8889 WHERE `ID` = 8888; -- "The Magister's Apprentice" -> "Deactivating the Spire"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 9252 WHERE `ID` = 9358; -- "Ranger Sareyn" -> "Defending Fairbreeze Village"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10097 WHERE `ID` = 10180; -- "Can't Stay Away" -> "Brother Against Brother"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13432 WHERE `ID` = 10445; -- "The Vials of Eternity" [10445] -> "The Vials of Eternity" [13432]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13430 WHERE `ID` = 10888; -- "Trial of the Naaru: Magtheridon" [10888] -> "Trial of the Naaru: Magtheridon" [13430]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13431 WHERE `ID` = 10901; -- "The Cudgel of Kar'desh" [10901] -> "The Cudgel of Kar'desh" [13431]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13429 WHERE `ID` = 10985; -- "A Distraction for Akama" [10985] -> "A Distraction for Akama" [13429]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11176 WHERE `ID` = 11175; -- "My Daughter" -> "See to the Operations"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11298 WHERE `ID` = 11297; -- "Keeping Watch on the Interlopers" -> "What's in That Brew?"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11448 WHERE `ID` = 11478; -- "Outpost Over Yonder..." -> "The Explorers' League Outpost"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13203 WHERE `ID` = 11528; -- "A Winter Veil Gift" [11528] -> "A Winter Veil Gift" [13203]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11587 WHERE `ID` = 11575; -- "Nick of Time" -> "Prison Break"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10212 WHERE `ID` = 11585; -- "Hellscream's Vigil" -> "Hero of the Mag'har"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11592 WHERE `ID` = 11591; -- "Report to Steeljaw's Caravan" -> "We Strike!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12439 WHERE `ID` = 11995; -- "Your Presence is Required at Stars' Rest" -> "A Disturbance In The West"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11958 WHERE `ID` = 12117; -- "Travel to Moa'ki Harbor" -> "Let Nothing Go To Waste"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11958 WHERE `ID` = 12118; -- "Travel to Moa'ki Harbor" -> "Let Nothing Go To Waste"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12171 WHERE `ID` = 12157; -- "The Lost Courier" -> "Of Traitors and Treason"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12235 WHERE `ID` = 12171; -- "Of Traitors and Treason" -> "Naxxramas and the Fall of Wintergarde"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12235 WHERE `ID` = 12174; -- "High Commander Halford Wyrmbane" -> "Naxxramas and the Fall of Wintergarde"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12188 WHERE `ID` = 12181; -- "Give it a Name" -> "The Forsaken Blight and You: How Not to Die"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12174 WHERE `ID` = 12298; -- "High Commander Halford Wyrmbane" [12298] -> "High Commander Halford Wyrmbane" [12174]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11995 WHERE `ID` = 12439; -- "A Disturbance In The West" -> "Your Presence is Required at Stars' Rest"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12710 WHERE `ID` = 12690; -- "Fuel for the Fire" -> "Disclosure"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 12932 WHERE `ID` = 12974; -- "The Champion's Call!" -> "The Amphitheater of Anguish: Yggdras!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13098 WHERE `ID` = 13099; -- "Just Checkin'" -> "For Posterity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13177 WHERE `ID` = 13179; -- "No Mercy for the Merciless" [13179] -> "No Mercy for the Merciless" [13177]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13178 WHERE `ID` = 13180; -- "Slay them all!" [13180] -> "Slay them all!" [13178]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13223 WHERE `ID` = 13185; -- "Stop the Siege" -> "Defend the Siege"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13222 WHERE `ID` = 13186; -- "Stop the Siege" -> "Defend the Siege"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13191 WHERE `ID` = 13192; -- "Warding the Walls" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 236 WHERE `ID` = 13195; -- "A Rare Herb" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 236 WHERE `ID` = 13196; -- "Bones and Arrows" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 236 WHERE `ID` = 13198; -- "Warding the Warriors" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13191 WHERE `ID` = 13199; -- "Bones and Arrows" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13191 WHERE `ID` = 13201; -- "Healing with Roses" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13191 WHERE `ID` = 13202; -- "Jinxing the Walls" -> "Fueling the Demolishers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11528 WHERE `ID` = 13203; -- "A Winter Veil Gift" [13203] -> "A Winter Veil Gift" [11528]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13186 WHERE `ID` = 13222; -- "Defend the Siege" -> "Stop the Siege"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 13185 WHERE `ID` = 13223; -- "Defend the Siege" -> "Stop the Siege"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10985 WHERE `ID` = 13429; -- "A Distraction for Akama" [13429] -> "A Distraction for Akama" [10985]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10888 WHERE `ID` = 13430; -- "Trial of the Naaru: Magtheridon" [13430] -> "Trial of the Naaru: Magtheridon" [10888]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10901 WHERE `ID` = 13431; -- "The Cudgel of Kar'desh" [13431] -> "The Cudgel of Kar'desh" [10901]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 10445 WHERE `ID` = 13432; -- "The Vials of Eternity" [13432] -> "The Vials of Eternity" [10445]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 11528 WHERE `ID` = 13966; -- "A Winter Veil Gift" [13966] -> "A Winter Veil Gift" [11528]
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14024 WHERE `ID` = 14023; -- "Spice Bread Stuffing" -> "Pumpkin Pie"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14028 WHERE `ID` = 14024; -- "Pumpkin Pie" -> "Cranberry Chutney"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14030 WHERE `ID` = 14028; -- "Cranberry Chutney" -> "They're Ravenous In Darnassus"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14033 WHERE `ID` = 14030; -- "They're Ravenous In Darnassus" -> "Candied Sweet Potatoes"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14035 WHERE `ID` = 14033; -- "Candied Sweet Potatoes" -> "Slow-roasted Turkey"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14040 WHERE `ID` = 14037; -- "Spice Bread Stuffing" -> "Pumpkin Pie"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14041 WHERE `ID` = 14040; -- "Pumpkin Pie" -> "Cranberry Chutney"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14043 WHERE `ID` = 14041; -- "Cranberry Chutney" -> "Candied Sweet Potatoes"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14044 WHERE `ID` = 14043; -- "Candied Sweet Potatoes" -> "Undersupplied in the Undercity"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14047 WHERE `ID` = 14044; -- "Undersupplied in the Undercity" -> "Slow-roasted Turkey"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14141 WHERE `ID` = 14092; -- "Breakfast Of Champions" -> "Gormok Wants His Snobolds"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14140 WHERE `ID` = 14136; -- "Rescue at Sea" -> "Stop The Aggressors"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14144 WHERE `ID` = 14140; -- "Stop The Aggressors" -> "The Light's Mercy"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14092 WHERE `ID` = 14141; -- "Gormok Wants His Snobolds" -> "Breakfast Of Champions"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14136 WHERE `ID` = 14143; -- "A Leg Up" -> "Rescue at Sea"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14136 WHERE `ID` = 14144; -- "The Light's Mercy" -> "Rescue at Sea"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 14092 WHERE `ID` = 14145; -- "What Do You Feed a Yeti, Anyway?" -> "Breakfast Of Champions"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24580 WHERE `ID` = 24579; -- "Sartharion Must Die!" -> "Anub'Rekhan Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24580; -- "Anub'Rekhan Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24581; -- "Noth the Plaguebringer Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24582; -- "Instructor Razuvious Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24583; -- "Patchwerk Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24584; -- "Malygos Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24585; -- "Flame Leviathan Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24586; -- "Razorscale Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24587; -- "Ignis the Furnace Master Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24588; -- "XT-002 Deconstructor Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24589; -- "Lord Jaraxxus Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24579 WHERE `ID` = 24590; -- "Lord Marrowgar Must Die!" -> "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24635 WHERE `ID` = 24629; -- "A Perfect Puff of Perfume" -> "A Cloudlet of Classy Cologne"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24629 WHERE `ID` = 24635; -- "A Cloudlet of Classy Cologne" -> "A Perfect Puff of Perfume"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 24629 WHERE `ID` = 24636; -- "Bonbon Blitz" -> "A Perfect Puff of Perfume"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 25461 WHERE `ID` = 25446; -- "Frogs Away!" -> "Trollin' For Volunteers"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 25495 WHERE `ID` = 25480; -- "Dance Of De Spirits" -> "Preparin' For Battle"
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 26013 WHERE `ID` = 26012; -- "Trouble at Wyrmrest" -> "Assault on the Sanctum"

-- Remove redundant conditions now handled by BreadcrumbForQuestId
-- Quest 254 (Digging Through the Dirt): breadcrumb for 253 (Bride of the Embalmer)
-- Conditions checking quest 253 not complete/not rewarded are redundant with breadcrumb
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 254 AND `ConditionValue1` = 253;

-- Quest 1641 (Gryphon Master Talonaxe): breadcrumb for 1642
-- Condition checking quest 1642 QUESTSTATE is redundant with breadcrumb
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 1641 AND `ConditionTypeOrReference` = 47 AND `ConditionValue1` = 1642;

-- Clear NextQuestId for breadcrumb quests (breadcrumbs should not chain via NextQuestId)
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 162; -- "Rise of the Silithid"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 112; -- "Collecting Kelp"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 771; -- "Rite of Vision"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 917; -- "Webwood Egg"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 923; -- "Tumors"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 937; -- "The Enchanted Glade"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 1642; -- "The Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 1646; -- "The Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 4267; -- "Rise of the Silithid"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 4495; -- "A Good Friend"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8905; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8906; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8907; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8908; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8909; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8910; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8911; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8912; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8913; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8914; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8915; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8916; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8917; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8918; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8919; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8920; -- "An Earnest Proposition"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8966; -- "The Left Piece of Lord Valthalak's Amulet"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8967; -- "The Left Piece of Lord Valthalak's Amulet"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8968; -- "The Left Piece of Lord Valthalak's Amulet"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 8969; -- "The Left Piece of Lord Valthalak's Amulet"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9962; -- "The Ring of Blood: Brokentoe"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9967; -- "The Ring of Blood: The Blue Brothers"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9970; -- "The Ring of Blood: Rokdar the Sundered Lord"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9972; -- "The Ring of Blood: Skra'gath"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9973; -- "The Ring of Blood: The Warmaul Champion"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 9983; -- "He Called Himself Altruis..."
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 11575; -- "Nick of Time"
UPDATE `quest_template_addon` SET `NextQuestId` = 0 WHERE `ID` = 12439; -- "A Disturbance In The West"

-- Clear ExclusiveGroup for breadcrumb quests (breadcrumbs should not use ExclusiveGroup)
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 235; -- "The Ashenvale Hunt"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 742; -- "The Ashenvale Hunt"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1516; -- "Call of Earth"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1519; -- "Call of Earth"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1522; -- "Call of Fire"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1528; -- "Call of Water"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1529; -- "Call of Water"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1638; -- "A Warrior's Training"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1679; -- "Muren Stormpike"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1684; -- "Elanaria"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1793; -- "The Tome of Valor"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1818; -- "Speak with Dillinger"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1859; -- "Therzok"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 1885; -- "Mennet Carkad"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 2983; -- "Call of Fire"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 2984; -- "Call of Fire"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 2985; -- "Call of Water"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 2986; -- "Call of Water"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 4486; -- "The Tome of Nobility"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 5623; -- "In Favor of the Light"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 5626; -- "In Favor of the Light"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 5649; -- "In Favor of Spirituality"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 5651; -- "In Favor of Darkness"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6065; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6067; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6071; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6072; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6076; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6541; -- "Report to Kadrak"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6542; -- "Report to Kadrak"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 6961; -- "Great-father Winter is Here!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8368; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8370; -- "Conquering Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8372; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8374; -- "Claiming Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8393; -- "Claiming Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8394; -- "Claiming Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8395; -- "Claiming Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8396; -- "Claiming Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8399; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8400; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8401; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8402; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8403; -- "Fight for Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8426; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8427; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8428; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8429; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8430; -- "Battle of Warsong Gulch"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8436; -- "Conquering Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8437; -- "Conquering Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8438; -- "Conquering Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8439; -- "Conquering Arathi Basin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8747; -- "The Path of the Protector"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8752; -- "The Path of the Conqueror"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8757; -- "The Path of the Invoker"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8870; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8871; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8872; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8873; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8874; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 8875; -- "The Lunar Festival"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 9796; -- "News from Zangarmarsh"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10105; -- "News for Rakoria"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10530; -- "The Hunter's Path"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10729; -- "Path of the Violet Mage"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10730; -- "Path of the Violet Restorer"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10731; -- "Path of the Violet Assassin"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10732; -- "Path of the Violet Protector"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10905; -- "Master of Potions"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10906; -- "Master of Elixirs"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 10907; -- "Master of Transmutation"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 11360; -- "Fire Brigade Practice"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 11361; -- "Fire Training"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 11442; -- "Welcome to Brewfest!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 11585; -- "Hellscream's Vigil"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 11995; -- "Your Presence is Required at Stars' Rest"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 12117; -- "Travel to Moa'ki Harbor"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 12118; -- "Travel to Moa'ki Harbor"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 12171; -- "Of Traitors and Treason"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 12174; -- "High Commander Halford Wyrmbane"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 12298; -- "High Commander Halford Wyrmbane"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13179; -- "No Mercy for the Merciless"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13180; -- "Slay them all!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13185; -- "Stop the Siege"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13186; -- "Stop the Siege"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13192; -- "Warding the Walls"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13195; -- "A Rare Herb"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13196; -- "Bones and Arrows"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13198; -- "Warding the Warriors"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13199; -- "Bones and Arrows"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13201; -- "Healing with Roses"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13202; -- "Jinxing the Walls"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13222; -- "Defend the Siege"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13223; -- "Defend the Siege"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 13430; -- "Trial of the Naaru: Magtheridon"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24579; -- "Sartharion Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24580; -- "Anub'Rekhan Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24581; -- "Noth the Plaguebringer Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24582; -- "Instructor Razuvious Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24583; -- "Patchwerk Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24584; -- "Malygos Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24585; -- "Flame Leviathan Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24586; -- "Razorscale Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24587; -- "Ignis the Furnace Master Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24588; -- "XT-002 Deconstructor Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24589; -- "Lord Jaraxxus Must Die!"
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` = 24590; -- "Lord Marrowgar Must Die!"

-- Clear both NextQuestId and ExclusiveGroup for breadcrumb quests that have both set
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1000; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1004; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1015; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1018; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1019; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1047; -- "The New Frontier"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 1282; -- "They Call Him Smiling Jim"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 2997; -- "Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 2998; -- "Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 2999; -- "Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3000; -- "Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3526; -- "Goblin Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3629; -- "Goblin Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3630; -- "Gnome Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3632; -- "Gnome Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3633; -- "Goblin Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3634; -- "Gnome Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3635; -- "Gnome Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3637; -- "Gnome Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 3681; -- "Tome of Divinity"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 4023; -- "A Taste of Flame"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 4181; -- "Goblin Engineering"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 10862; -- "Surrender to the Horde"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 10863; -- "Secrets of the Arakkoa"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 10908; -- "Speak with Rilak the Redeemed"
UPDATE `quest_template_addon` SET `NextQuestId` = 0, `ExclusiveGroup` = 0 WHERE `ID` = 11447; -- "Welcome to Brewfest!"

-- Fix breadcrumb quest loops: break mutual/cyclic BreadcrumbForQuestId references
-- For each mutual pair (A<->B), remove the lower quest's breadcrumb (keep higher->lower)
-- This preserves the breadcrumb relationship in one direction while eliminating the cycle

-- Mutual breadcrumb pairs: clear the lower quest ID to break the cycle
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1000; -- Break loop: 1000 ("The New Frontier") <-> 1004
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1015; -- Break loop: 1015 ("The New Frontier") <-> 1047
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1470; -- Break loop: 1470 ("Piercing the Veil") <-> 1485
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1471; -- Break loop: 1471 ("The Binding") <-> 1504
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1474; -- Break loop: 1474 ("The Binding") <-> 1513
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1516; -- Break loop: 1516 ("Call of Earth") <-> 1519
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1598; -- Break loop: 1598 ("The Stolen Tome") <-> 1599
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1639; -- Break loop: 1639 ("Bartleby the Drunk") <-> 1678
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 1642; -- Break loop: 1642 ("The Tome of Divinity") <-> 1646
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 2951; -- Break loop: 2951 ("The Sparklematic 5200!") <-> 4601
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 2952; -- Break loop: 2952 ("The Sparklematic 5200!") <-> 4605
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 2953; -- Break loop: 2953 ("More Sparklematic Action") <-> 4603
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 3526; -- Break loop: 3526 ("Goblin Engineering") <-> 3633
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 3630; -- Break loop: 3630 ("Gnome Engineering") <-> 3632
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 3635; -- Break loop: 3635 ("Gnome Engineering") <-> 3637
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 3639; -- Break loop: 3639 ("Show Your Work") <-> 3641
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 5305; -- Break loop: 5305 ("Sweet Serenity") <-> 8869
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 5401; -- Break loop: 5401 ("Argent Dawn Commission") <-> 5405
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 6071; -- Break loop: 6071 ("The Hunter's Path") <-> 6072
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8368; -- Break loop: 8368 ("Battle of Warsong Gulch") <-> 8426
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8370; -- Break loop: 8370 ("Conquering Arathi Basin") <-> 8436
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8372; -- Break loop: 8372 ("Fight for Warsong Gulch") <-> 8399
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8374; -- Break loop: 8374 ("Claiming Arathi Basin") <-> 8393
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8410; -- Break loop: 8410 ("Elemental Mastery") <-> 8411
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8747; -- Break loop: 8747 ("The Path of the Protector") <-> 8752
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8767; -- Break loop: 8767 ("A Gently Shaken Gift") <-> 8788
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8795; -- Break loop: 8795 ("The Alliance Needs Your Help!") <-> 8796
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8900; -- Break loop: 8900 ("Dearest Elenia,") <-> 8901
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 8966; -- Break loop: 8966 ("The Left Piece of Lord Valthalak's Amulet") <-> 8967
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 9796; -- Break loop: 9796 ("News from Zangarmarsh") <-> 10105
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10445; -- Break loop: 10445 ("The Vials of Eternity") <-> 13432
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10708; -- Break loop: 10708 ("Akama's Promise") <-> 11052
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10862; -- Break loop: 10862 ("Surrender to the Horde") <-> 10908
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10888; -- Break loop: 10888 ("Trial of the Naaru: Magtheridon") <-> 13430
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10901; -- Break loop: 10901 ("The Cudgel of Kar'desh") <-> 13431
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 10985; -- Break loop: 10985 ("A Distraction for Akama") <-> 13429
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 11043; -- Break loop: 11043 ("Building a Better Gryphon") <-> 11044
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 11046; -- Break loop: 11046 ("Chief Apothecary Hildagard") <-> 11047
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 11528; -- Break loop: 11528 ("A Winter Veil Gift") <-> 13203
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 11995; -- Break loop: 11995 ("Your Presence is Required at Stars' Rest") <-> 12439
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 12513; -- Break loop: 12513 ("Nice Hat...") <-> 12515
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 13185; -- Break loop: 13185 ("Stop the Siege") <-> 13223
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 13186; -- Break loop: 13186 ("Stop the Siege") <-> 13222
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 14092; -- Break loop: 14092 ("Breakfast Of Champions") <-> 14141
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 24579; -- Break loop: 24579 ("Sartharion Must Die!") <-> 24580
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 24629; -- Break loop: 24629 ("A Perfect Puff of Perfume") <-> 24635

-- 3-way cycle: 14136 -> 14140 -> 14144 -> 14136 (Argent Tournament dailies)
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId` = 0 WHERE `ID` = 14136; -- Break 3-way cycle: "Rescue at Sea"
