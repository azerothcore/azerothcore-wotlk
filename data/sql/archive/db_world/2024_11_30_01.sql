-- DB update 2024_11_30_00 -> 2024_11_30_01
-- enforce minCnt == macCnt for reference loot entries

-- creature loot

-- 33885 XT-002 Deconstructor (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33885 AND `Item` = 1 AND `Reference` = 34358 );
-- 37613 Forgemaster Garfrost (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37613 AND `Item` = 1 AND `Reference` = 35060 );
-- 17808 Anetheron, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17808 AND `Item` = 34065 AND `Reference` = 34065 );
-- 22898 Supremus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22898 AND `Item` = 34071 AND `Reference` = 34071 );
-- 38401 Prince Valanar (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38401 AND `Item` = 1 AND `Reference` = 34248 );
-- 38075 Deathspeaker Servant (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38075 AND `Item` = 1 AND `Reference` = 35069 );
-- 35448 Icehowl (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35448 AND `Item` = 1 AND `Reference` = 34306 );
-- 35448 Icehowl (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35448 AND `Item` = 2 AND `Reference` = 34313 );
-- 38390 Rotface (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38390 AND `Item` = 1 AND `Reference` = 34245 );
-- 37957 Lord Marrowgar (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 37957 AND `Item` = 1 AND `Reference` = 34242 );
-- 38479 Darkfallen Tactician (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38479 AND `Item` = 1 AND `Reference` = 35069 );
-- 33515 Auriaya, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33515 AND `Item` = 1 AND `Reference` = 34363 );
-- 37664 Darkfallen Archmage, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37664 AND `Item` = 1 AND `Reference` = 35069 );
-- 37546 Frenzied Abomination, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37546 AND `Item` = 1 AND `Reference` = 35069 );
-- 38599 Falric (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38599 AND `Item` = 1 AND `Reference` = 35055 );
-- 11492 Alzzin the Wildshaper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11492 AND `Item` = 35017 AND `Reference` = 35017 );
-- 38058 Nerub'ar Broodkeeper (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38058 AND `Item` = 1 AND `Reference` = 35069 );
-- 19516 Void Reaver, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 19516 AND `Item` = 34054 AND `Reference` = 34054 );
-- 19622 Kael'thas Sunstrider, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 19622 AND `Item` = 34056 AND `Reference` = 34056 );
-- 19622 Kael'thas Sunstrider, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 19622 AND `Item` = 90056 AND `Reference` = 34056 );
-- 29278 Maexxna (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29278 AND `Item` = 1 AND `Reference` = 34139 );
-- 38434 Blood-Queen Lana'thel (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38434 AND `Item` = 2 AND `Reference` = 34278 );
-- 15936 Heigan the Unclean, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15936 AND `Item` = 1 AND `Reference` = 34041 );
-- 38059 Ancient Skeletal Soldier (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38059 AND `Item` = 1 AND `Reference` = 35069 );
-- 38585 Professor Putricide (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38585 AND `Item` = 1 AND `Reference` = 34258 );
-- 18831 High King Maulgar, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 18831 AND `Item` = 34050 AND `Reference` = 34050 );
-- 38031 Deathbound Ward (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38031 AND `Item` = 1 AND `Reference` = 35069 );
-- 38074 Deathspeaker High Priest (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38074 AND `Item` = 1 AND `Reference` = 35069 );
-- 38267 Sindragosa (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38267 AND `Item` = 2 AND `Reference` = 34278 );
-- 29701 Heigan the Unclean (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29701 AND `Item` = 1 AND `Reference` = 34148 );
-- 31311 Sartharion (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 31311 AND `Item` = 1 AND `Reference` = 34166 );
-- 22947 Mother Shahraz, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 22947 AND `Item` = 34076 AND `Reference` = 34076 );
-- 22917 Illidan Stormrage, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22917 AND `Item` = 90077 AND `Reference` = 34077 );
-- 9019 Emperor Dagran Thaurissan, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 9019 AND `Item` = 35014 AND `Reference` = 35014 );
-- 38106 Lady Deathwhisper (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38106 AND `Item` = 1 AND `Reference` = 34243 );
-- 11486 Prince Tortheldrin, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11486 AND `Item` = 35021 AND `Reference` = 35021 );
-- 38296 Lady Deathwhisper (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38296 AND `Item` = 1 AND `Reference` = 34255 );
-- 21214 Fathom-Lord Karathress, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21214 AND `Item` = 34060 AND `Reference` = 34060 );
-- 19044 Gruul the Dragonkiller, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 19044 AND `Item` = 34051 AND `Reference` = 34051 );
-- 25165 Lady Sacrolash, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 25165 AND `Item` = 34085 AND `Reference` = 34085 );
-- 32867 Steelbreaker, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 32867 AND `Item` = 1 AND `Reference` = 34359 );
-- 33724 Razorscale (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33724 AND `Item` = 1 AND `Reference` = 34356 );
-- 12017 Broodlord Lashlayer, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 12017 AND `Item` = 30346 AND `Reference` = 30346 );
-- 37662 Darkfallen Commander, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37662 AND `Item` = 1 AND `Reference` = 35069 );
-- 24239 Hex Lord Malacrass, minCnt 2, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 24239 AND `Item` = 34078 AND `Reference` = 34078 );
-- 38564 Shadowy Mercenary (1), minCnt 1, maxCnt 2
-- 38563 Ghostly Priest (1), minCnt 1, maxCnt 2
-- 38544 Tortured Rifleman (1), minCnt 1, maxCnt 2
-- 38525 Spectral Footman (1), minCnt 1, maxCnt 2
-- 38524 Phantom Mage (1), minCnt 1, maxCnt 2
-- 38249 Hungering Ghoul (1), minCnt 1, maxCnt 2
-- 38193 Soulguard Bonecaster (1), minCnt 1, maxCnt 2
-- 38026 Deathwhisper Torturer (1), minCnt 1, maxCnt 2
-- 38025 Deathwhisper Shadowcaster (1), minCnt 1, maxCnt 2
-- 37720 Frostsworn General (1), minCnt 1, maxCnt 2
-- 37644 Ymirjar Wrathbringer (1), minCnt 1, maxCnt 2
-- 37643 Ymirjar Skycaller (1), minCnt 1, maxCnt 2
-- 37642 Ymirjar Flamebearer (1), minCnt 1, maxCnt 2
-- 37641 Ymirjar Deathbringer (1), minCnt 1, maxCnt 2
-- 37638 Wrathbone Laborer (1), minCnt 1, maxCnt 2
-- 37637 Wrathbone Coldwraith (1), minCnt 1, maxCnt 2
-- 37636 Stonespine Gargoyle (1), minCnt 1, maxCnt 2
-- 37635 Plagueborn Horror (1), minCnt 1, maxCnt 2
-- 37622 Geist Ambusher (1), minCnt 1, maxCnt 2
-- 37609 Deathwhisper Necrolyte (1), minCnt 1, maxCnt 2
-- 37569 Soulguard Watchman (1), minCnt 1, maxCnt 2
-- 37568 Soulguard Reaper (1), minCnt 1, maxCnt 2
-- 37567 Soulguard Animator (1), minCnt 1, maxCnt 2
-- 37566 Soulguard Adept (1), minCnt 1, maxCnt 2
-- 37565 Soul Horror (1), minCnt 1, maxCnt 2
-- 37563 Spectral Warden (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 100001 AND `Item` = 1 AND `Reference` = 35073 );
-- 38494 Rotting Frost Giant, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38494 AND `Item` = 1 AND `Reference` = 35069 );
-- 37007 Deathbound Ward, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37007 AND `Item` = 1 AND `Reference` = 35069 );
-- 38134 Frostwarden Warrior (1), minCnt 1, maxCnt 2
-- 37228 Frostwarden Warrior, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37228 AND `Item` = 1 AND `Reference` = 35069 );
-- 38550 Rotface (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38550 AND `Item` = 1 AND `Reference` = 34269 );
-- 38445 Spire Minion (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38445 AND `Item` = 1 AND `Reference` = 35069 );
-- 37012 Ancient Skeletal Soldier, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37012 AND `Item` = 1 AND `Reference` = 35069 );
-- 38110 Pustulating Horror (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38110 AND `Item` = 1 AND `Reference` = 35069 );
-- 38099 Darkfallen Archmage (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38099 AND `Item` = 1 AND `Reference` = 35069 );
-- 24892 Sathrovarr the Corruptor, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 24892 AND `Item` = 34082 AND `Reference` = 34082 );
-- 35615 Anub'arak (2), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35615 AND `Item` = 1 AND `Reference` = 34310 );
-- 35615 Anub'arak (2), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35615 AND `Item` = 2 AND `Reference` = 34317 );
-- 37677 Devourer of Souls (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37677 AND `Item` = 1 AND `Reference` = 35052 );
-- 38063 Vengeful Fleshreaper (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38063 AND `Item` = 1 AND `Reference` = 35069 );
-- 11583 Nefarian, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11583 AND `Item` = 30486 AND `Reference` = 30486 );
-- 11583 Nefarian, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11583 AND `Item` = 34009 AND `Reference` = 34009 );
-- 29324 Patchwerk (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29324 AND `Item` = 1 AND `Reference` = 34140 );
-- 25840 Entropius, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 25840 AND `Item` = 34095 AND `Reference` = 34095 );
-- 10363 General Drakkisath, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10363 AND `Item` = 35025 AND `Reference` = 35025 );
-- 11382 Bloodlord Mandokir, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11382 AND `Item` = 34088 AND `Reference` = 34088 );
-- 38603 Marwyn (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38603 AND `Item` = 1 AND `Reference` = 35056 );
-- 17225 Nightbane, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17225 AND `Item` = 34022 AND `Reference` = 34022 );
-- 12435 Razorgore the Untamed, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 12435 AND `Item` = 30369 AND `Reference` = 30369 );
-- 12201 Princess Theradras, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 12201 AND `Item` = 35009 AND `Reference` = 35009 );
-- 29448 Thaddius (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29448 AND `Item` = 1 AND `Reference` = 34143 );
-- 29448 Thaddius (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29448 AND `Item` = 2 AND `Reference` = 34380 );
-- 8443 Avatar of Hakkar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 8443 AND `Item` = 35012 AND `Reference` = 35012 );
-- 10429 Warchief Rend Blackhand, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10429 AND `Item` = 35022 AND `Reference` = 35022 );
-- 37627 Ick (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37627 AND `Item` = 1 AND `Reference` = 35061 );
-- 36627 Rotface, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36627 AND `Item` = 1 AND `Reference` = 34233 );
-- 10404 Pustulating Horror, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10404 AND `Item` = 1 AND `Reference` = 35069 );
-- 29120 Anub'arak, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29120 AND `Item` = 1 AND `Reference` = 35035 );
-- 11498 Skarr the Unbreakable, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11498 AND `Item` = 35015 AND `Reference` = 35015 );
-- 21217 The Lurker Below, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21217 AND `Item` = 34058 AND `Reference` = 34058 );
-- 39167 The Lich King (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39167 AND `Item` = 1 AND `Reference` = 34262 );
-- 10813 Balnazzar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10813 AND `Item` = 35027 AND `Reference` = 35027 );
-- 11380 Jin'do the Hexxer, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11380 AND `Item` = 34089 AND `Reference` = 34089 );
-- 36811 Deathspeaker Attendant, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36811 AND `Item` = 1 AND `Reference` = 35069 );
-- 37595 Darkfallen Blood Knight, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37595 AND `Item` = 1 AND `Reference` = 35069 );
-- 33693 Steelbreaker (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33693 AND `Item` = 1 AND `Reference` = 34360 );
-- 38139 Frostwarden Handler (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38139 AND `Item` = 1 AND `Reference` = 35069 );
-- 37544 Spire Gargoyle, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37544 AND `Item` = 1 AND `Reference` = 35069 );
-- 17842 Azgalor, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 17842 AND `Item` = 34067 AND `Reference` = 34067 );
-- 37506 Festergut (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 37506 AND `Item` = 1 AND `Reference` = 34268 );
-- 11501 King Gordok, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11501 AND `Item` = 35019 AND `Reference` = 35019 );
-- 37959 Lord Marrowgar (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 37959 AND `Item` = 1 AND `Reference` = 34266 );
-- 33993 Emalon the Storm Watcher, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33993 AND `Item` = 1 AND `Reference` = 34208 );
-- 33118 Ignis the Furnace Master, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33118 AND `Item` = 1 AND `Reference` = 34353 );
-- 14888 Lethon, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14888 AND `Item` = 34002 AND `Reference` = 34002 );
-- 14888 Lethon, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14888 AND `Item` = 34005 AND `Reference` = 34005 );
-- 16457 Maiden of Virtue, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16457 AND `Item` = 34018 AND `Reference` = 34018 );
-- 5709 Shade of Eranikus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 5709 AND `Item` = 35013 AND `Reference` = 35013 );
-- 34564 Anub'arak, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34564 AND `Item` = 1 AND `Reference` = 34298 );
-- 34564 Anub'arak, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34564 AND `Item` = 2 AND `Reference` = 34304 );
-- 39168 The Lich King (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39168 AND `Item` = 1 AND `Reference` = 34274 );
-- 39168 The Lich King (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39168 AND `Item` = 2 AND `Reference` = 34278 );
-- 35352 Fjola Lightbane (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35352 AND `Item` = 1 AND `Reference` = 34336 );
-- 35352 Fjola Lightbane (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35352 AND `Item` = 2 AND `Reference` = 34343 );
-- 27978 Sjonnir The Ironshaper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27978 AND `Item` = 1 AND `Reference` = 35044 );
-- 22948 Gurtogg Bloodboil, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22948 AND `Item` = 34074 AND `Reference` = 34074 );
-- 35351 Fjola Lightbane (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35351 AND `Item` = 1 AND `Reference` = 34308 );
-- 35351 Fjola Lightbane (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35351 AND `Item` = 2 AND `Reference` = 34315 );
-- 33113 Flame Leviathan, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33113 AND `Item` = 2 AND `Reference` = 34351 );
-- 6109 Azuregos, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 6109 AND `Item` = 34002 AND `Reference` = 34002 );
-- 6109 Azuregos, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 6109 AND `Item` = 34004 AND `Reference` = 34004 );
-- 6109 Azuregos, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 6109 AND `Item` = 190003 AND `Reference` = 34003 );
-- 13020 Vaelastrasz the Corrupt, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 13020 AND `Item` = 30372 AND `Reference` = 30372 );
-- 17257 Magtheridon, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17257 AND `Item` = 90039 AND `Reference` = 34039 );
-- 35360 Koralon the Flame Watcher (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35360 AND `Item` = 1 AND `Reference` = 34205 );
-- 35360 Koralon the Flame Watcher (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35360 AND `Item` = 3 AND `Reference` = 34205 );
-- 35360 Koralon the Flame Watcher (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35360 AND `Item` = 4 AND `Reference` = 34205 );
-- 29306 Gal'darah, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29306 AND `Item` = 1 AND `Reference` = 35039 );
-- 36807 Deathspeaker Disciple, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36807 AND `Item` = 1 AND `Reference` = 35069 );
-- 15339 Ossirian the Unscarred, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15339 AND `Item` = 34024 AND `Reference` = 34024 );
-- 15339 Ossirian the Unscarred, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15339 AND `Item` = 34025 AND `Reference` = 34025 );
-- 14890 Taerar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14890 AND `Item` = 34002 AND `Reference` = 34002 );
-- 14890 Taerar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14890 AND `Item` = 34007 AND `Reference` = 34007 );
-- 36626 Festergut, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36626 AND `Item` = 1 AND `Reference` = 34232 );
-- 15688 Terestian Illhoof, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15688 AND `Item` = 34019 AND `Reference` = 34019 );
-- 37663 Darkfallen Noble, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37663 AND `Item` = 1 AND `Reference` = 35069 );
-- 37666 Darkfallen Tactician, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37666 AND `Item` = 1 AND `Reference` = 35069 );
-- 38785 Prince Valanar (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38785 AND `Item` = 1 AND `Reference` = 34271 );
-- 36805 Deathspeaker Servant, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36805 AND `Item` = 1 AND `Reference` = 35069 );
-- 37505 Festergut (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37505 AND `Item` = 1 AND `Reference` = 34256 );
-- 37501 Nerub'ar Champion, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37501 AND `Item` = 1 AND `Reference` = 35069 );
-- 38435 Blood-Queen Lana'thel (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38435 AND `Item` = 1 AND `Reference` = 34260 );
-- 10184 Onyxia, minCnt 1, maxCnt 5
UPDATE `creature_loot_template` SET `MinCount` = 5 WHERE ( `Entry`= 10184 AND `Item` = 1 AND `Reference` = 34000 );
-- 38108 Blighted Abomination (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38108 AND `Item` = 1 AND `Reference` = 35069 );
-- 21212 Lady Vashj, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21212 AND `Item` = 34062 AND `Reference` = 34062 );
-- 21212 Lady Vashj, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 21212 AND `Item` = 90062 AND `Reference` = 34062 );
-- 10430 The Beast, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10430 AND `Item` = 35023 AND `Reference` = 35023 );
-- 10440 Baron Rivendare, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10440 AND `Item` = 35028 AND `Reference` = 35028 );
-- 11447 Mushgog, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11447 AND `Item` = 35015 AND `Reference` = 35015 );
-- 10508 Ras Frostwhisper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10508 AND `Item` = 35030 AND `Reference` = 35030 );
-- 38102 Darkfallen Commander (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38102 AND `Item` = 1 AND `Reference` = 35069 );
-- 37022 Blighted Abomination, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37022 AND `Item` = 1 AND `Reference` = 35069 );
-- 10997 Cannon Master Willey, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 10997 AND `Item` = 35026 AND `Reference` = 35026 );
-- 11496 Immol'thar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11496 AND `Item` = 35020 AND `Reference` = 35020 );
-- 11497 The Razza, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11497 AND `Item` = 35015 AND `Reference` = 35015 );
-- 11502 Ragnaros, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 11502 AND `Item` = 30171 AND `Reference` = 30171 );
-- 26723 Keristrasza, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26723 AND `Item` = 1 AND `Reference` = 35033 );
-- 33449 General Vezax (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33449 AND `Item` = 1 AND `Reference` = 34374 );
-- 34175 Auriaya (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 34175 AND `Item` = 1 AND `Reference` = 34364 );
-- 16808 Warchief Kargath Bladefist, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16808 AND `Item` = 35003 AND `Reference` = 35003 );
-- 14020 Chromaggus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14020 AND `Item` = 30379 AND `Reference` = 30379 );
-- 35447 Icehowl (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35447 AND `Item` = 1 AND `Reference` = 34320 );
-- 35447 Icehowl (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35447 AND `Item` = 2 AND `Reference` = 34327 );
-- 15340 Moam, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15340 AND `Item` = 34024 AND `Reference` = 34024 );
-- 35268 Lord Jaraxxus (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35268 AND `Item` = 1 AND `Reference` = 34307 );
-- 35268 Lord Jaraxxus (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35268 AND `Item` = 2 AND `Reference` = 34314 );
-- 36724 Servant of the Throne, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36724 AND `Item` = 1 AND `Reference` = 35069 );
-- 36612 Lord Marrowgar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36612 AND `Item` = 1 AND `Reference` = 34230 );
-- 29311 Herald Volazj, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29311 AND `Item` = 1 AND `Reference` = 35036 );
-- 14887 Ysondre, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14887 AND `Item` = 34002 AND `Reference` = 34002 );
-- 14887 Ysondre, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14887 AND `Item` = 34008 AND `Reference` = 34008 );
-- 14889 Emeriss, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14889 AND `Item` = 34002 AND `Reference` = 34002 );
-- 14889 Emeriss, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 14889 AND `Item` = 34006 AND `Reference` = 34006 );
-- 25166 Grand Warlock Alythess, minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 25166 AND `Item` = 34085 AND `Reference` = 34085 );
-- 15341 General Rajaxx, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15341 AND `Item` = 34024 AND `Reference` = 34024 );
-- 15348 Kurinnaxx, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15348 AND `Item` = 34024 AND `Reference` = 34024 );
-- 15369 Ayamiss the Hunter, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15369 AND `Item` = 34024 AND `Reference` = 34024 );
-- 15370 Buru the Gorger, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15370 AND `Item` = 34024 AND `Reference` = 34024 );
-- 29955 Gothik the Harvester (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29955 AND `Item` = 1 AND `Reference` = 34145 );
-- 15952 Maexxna, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15952 AND `Item` = 1 AND `Reference` = 34040 );
-- 35449 Icehowl (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35449 AND `Item` = 1 AND `Reference` = 34334 );
-- 35449 Icehowl (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35449 AND `Item` = 2 AND `Reference` = 34341 );
-- 15687 Moroes, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15687 AND `Item` = 34017 AND `Reference` = 34017 );
-- 15689 Netherspite, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15689 AND `Item` = 34021 AND `Reference` = 34021 );
-- 15953 Grand Widow Faerlina, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15953 AND `Item` = 1 AND `Reference` = 34099 );
-- 15931 Grobbulus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15931 AND `Item` = 1 AND `Reference` = 34101 );
-- 15954 Noth the Plaguebringer, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15954 AND `Item` = 1 AND `Reference` = 34042 );
-- 15956 Anub'Rekhan, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15956 AND `Item` = 1 AND `Reference` = 34098 );
-- 29940 Instructor Razuvious (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29940 AND `Item` = 1 AND `Reference` = 34144 );
-- 15989 Sapphiron, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15989 AND `Item` = 1 AND `Reference` = 34043 );
-- 15990 Kel'Thuzad, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 15990 AND `Item` = 1 AND `Reference` = 34044 );
-- 16028 Patchwerk, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16028 AND `Item` = 1 AND `Reference` = 34100 );
-- 16042 Lord Valthalak, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16042 AND `Item` = 35024 AND `Reference` = 35024 );
-- 16060 Gothik the Harvester, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16060 AND `Item` = 1 AND `Reference` = 34103 );
-- 16061 Instructor Razuvious, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16061 AND `Item` = 1 AND `Reference` = 34102 );
-- 29268 Grand Widow Faerlina (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29268 AND `Item` = 1 AND `Reference` = 34138 );
-- 16152 Attumen the Huntsman, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16152 AND `Item` = 34016 AND `Reference` = 34016 );
-- 31125 Archavon the Stone Watcher, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 31125 AND `Item` = 1 AND `Reference` = 34209 );
-- 35616 Anub'arak (3), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 35616 AND `Item` = 1 AND `Reference` = 34338 );
-- 35616 Anub'arak (3), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 35616 AND `Item` = 2 AND `Reference` = 34345 );
-- 39166 The Lich King (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39166 AND `Item` = 1 AND `Reference` = 34250 );
-- 39166 The Lich King (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39166 AND `Item` = 2 AND `Reference` = 34278 );
-- 35216 Lord Jaraxxus (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35216 AND `Item` = 1 AND `Reference` = 34321 );
-- 35216 Lord Jaraxxus (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35216 AND `Item` = 2 AND `Reference` = 34328 );
-- 16524 Shade of Aran, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16524 AND `Item` = 34020 AND `Reference` = 34020 );
-- 35350 Fjola Lightbane (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35350 AND `Item` = 1 AND `Reference` = 34322 );
-- 35350 Fjola Lightbane (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35350 AND `Item` = 2 AND `Reference` = 34329 );
-- 17711 Doomwalker, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17711 AND `Item` = 34080 AND `Reference` = 34080 );
-- 17767 Rage Winterchill, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17767 AND `Item` = 34064 AND `Reference` = 34064 );
-- 17888 Kaz'rogal, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 17888 AND `Item` = 34066 AND `Reference` = 34066 );
-- 17968 Archimonde, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 17968 AND `Item` = 34068 AND `Reference` = 34068 );
-- 36853 Sindragosa, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36853 AND `Item` = 1 AND `Reference` = 34237 );
-- 38436 Blood-Queen Lana'thel (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38436 AND `Item` = 2 AND `Reference` = 34278 );
-- 18728 Doom Lord Kazzak, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 18728 AND `Item` = 1 AND `Reference` = 26043 );
-- 18805 High Astromancer Solarian, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 18805 AND `Item` = 34055 AND `Reference` = 34055 );
-- 38198 Nerub'ar Webweaver (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38198 AND `Item` = 1 AND `Reference` = 35069 );
-- 37025 Stinky, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37025 AND `Item` = 1 AND `Reference` = 35069 );
-- 36829 Deathspeaker High Priest, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36829 AND `Item` = 1 AND `Reference` = 35069 );
-- 19514 Al'ar, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 19514 AND `Item` = 1 AND `Reference` = 34053 );
-- 38076 Deathspeaker Zealot (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38076 AND `Item` = 1 AND `Reference` = 35069 );
-- 21213 Morogrim Tidewalker, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21213 AND `Item` = 34061 AND `Reference` = 34061 );
-- 21215 Leotheras the Blind, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21215 AND `Item` = 34059 AND `Reference` = 34059 );
-- 21216 Hydross the Unstable, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 21216 AND `Item` = 34057 AND `Reference` = 34057 );
-- 36808 Deathspeaker Zealot, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36808 AND `Item` = 1 AND `Reference` = 35069 );
-- 36494 Forgemaster Garfrost, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36494 AND `Item` = 1 AND `Reference` = 35057 );
-- 22841 Shade of Akama, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22841 AND `Item` = 34072 AND `Reference` = 34072 );
-- 22871 Teron Gorefiend, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22871 AND `Item` = 34073 AND `Reference` = 34073 );
-- 22887 High Warlord Naj'entus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 22887 AND `Item` = 34070 AND `Reference` = 34070 );
-- 33293 XT-002 Deconstructor, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33293 AND `Item` = 1 AND `Reference` = 34357 );
-- 23420 Essence of Anger, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 23420 AND `Item` = 34075 AND `Reference` = 34075 );
-- 37098 Val'kyr Herald, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37098 AND `Item` = 1 AND `Reference` = 35069 );
-- 38297 Lady Deathwhisper (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38297 AND `Item` = 1 AND `Reference` = 34267 );
-- 23863 Zul'jin, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 23863 AND `Item` = 34079 AND `Reference` = 34079 );
-- 38418 Val'kyr Herald (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38418 AND `Item` = 1 AND `Reference` = 35069 );
-- 23954 Ingvar the Plunderer, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 23954 AND `Item` = 1 AND `Reference` = 35048 );
-- 38112 Falric, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38112 AND `Item` = 1 AND `Reference` = 35053 );
-- 24882 Brutallus, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 24882 AND `Item` = 34083 AND `Reference` = 34083 );
-- 25038 Felmyst, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 25038 AND `Item` = 34084 AND `Reference` = 34084 );
-- 25315 Kil'jaeden, minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 25315 AND `Item` = 34096 AND `Reference` = 34096 );
-- 38549 Rotface (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38549 AND `Item` = 1 AND `Reference` = 34257 );
-- 37958 Lord Marrowgar (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37958 AND `Item` = 1 AND `Reference` = 34254 );
-- 26632 The Prophet Tharon'ja, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26632 AND `Item` = 1 AND `Reference` = 35032 );
-- 37504 Festergut (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 37504 AND `Item` = 1 AND `Reference` = 34244 );
-- 26861 King Ymiron, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26861 AND `Item` = 1 AND `Reference` = 35050 );
-- 38784 Prince Valanar (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38784 AND `Item` = 1 AND `Reference` = 34259 );
-- 33694 Stormcaller Brundir (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33694 AND `Item` = 1 AND `Reference` = 34360 );
-- 28923 Loken, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28923 AND `Item` = 1 AND `Reference` = 35043 );
-- 29249 Anub'Rekhan (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29249 AND `Item` = 1 AND `Reference` = 34137 );
-- 29373 Grobbulus (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29373 AND `Item` = 1 AND `Reference` = 34141 );
-- 29417 Gluth (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29417 AND `Item` = 1 AND `Reference` = 34142 );
-- 29417 Gluth (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29417 AND `Item` = 2 AND `Reference` = 34383 );
-- 29615 Noth the Plaguebringer (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29615 AND `Item` = 1 AND `Reference` = 34147 );
-- 29718 Loatheb (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29718 AND `Item` = 1 AND `Reference` = 34149 );
-- 29718 Loatheb (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 29718 AND `Item` = 2 AND `Reference` = 34381 );
-- 29991 Sapphiron (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 29991 AND `Item` = 1 AND `Reference` = 34135 );
-- 30061 Kel'Thuzad (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 30061 AND `Item` = 1 AND `Reference` = 34136 );
-- 30061 Kel'Thuzad (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 30061 AND `Item` = 2 AND `Reference` = 34133 );
-- 36476 Ick, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36476 AND `Item` = 1 AND `Reference` = 35058 );
-- 31134 Cyanigosa, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 31134 AND `Item` = 1 AND `Reference` = 35042 );
-- 31722 Archavon the Stone Watcher (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 31722 AND `Item` = 1 AND `Reference` = 34216 );
-- 37545 Spire Minion, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37545 AND `Item` = 1 AND `Reference` = 35069 );
-- 32857 Stormcaller Brundir, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 32857 AND `Item` = 1 AND `Reference` = 34359 );
-- 32927 Runemaster Molgeim, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 32927 AND `Item` = 1 AND `Reference` = 34359 );
-- 33186 Razorscale, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33186 AND `Item` = 1 AND `Reference` = 34355 );
-- 33190 Ignis the Furnace Master (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33190 AND `Item` = 1 AND `Reference` = 34354 );
-- 33271 General Vezax, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33271 AND `Item` = 1 AND `Reference` = 34373 );
-- 33692 Runemaster Molgeim (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 33692 AND `Item` = 1 AND `Reference` = 34360 );
-- 33955 Yogg-Saron (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33955 AND `Item` = 1 AND `Reference` = 34376 );
-- 33955 Yogg-Saron (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33955 AND `Item` = 2 AND `Reference` = 12035 );
-- 33994 Emalon the Storm Watcher (1), minCnt 1, maxCnt 4
UPDATE `creature_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 33994 AND `Item` = 1 AND `Reference` = 34215 );
-- 34003 Flame Leviathan (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 34003 AND `Item` = 2 AND `Reference` = 34352 );
-- 34003 Flame Leviathan (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34003 AND `Item` = 6 AND `Reference` = 34350 );
-- 34566 Anub'arak (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 34566 AND `Item` = 1 AND `Reference` = 34324 );
-- 34566 Anub'arak (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 34566 AND `Item` = 2 AND `Reference` = 34331 );
-- 34780 Lord Jaraxxus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34780 AND `Item` = 1 AND `Reference` = 34295 );
-- 34780 Lord Jaraxxus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34780 AND `Item` = 2 AND `Reference` = 34301 );
-- 34797 Icehowl, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34797 AND `Item` = 1 AND `Reference` = 34294 );
-- 34797 Icehowl, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34797 AND `Item` = 2 AND `Reference` = 34300 );
-- 35269 Lord Jaraxxus (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35269 AND `Item` = 1 AND `Reference` = 34335 );
-- 35269 Lord Jaraxxus (3), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 35269 AND `Item` = 2 AND `Reference` = 34342 );
-- 35451 The Black Knight, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35451 AND `Item` = 1 AND `Reference` = 34170 );
-- 35490 The Black Knight (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 35490 AND `Item` = 1 AND `Reference` = 34171 );
-- 36502 Devourer of Souls, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36502 AND `Item` = 1 AND `Reference` = 35051 );
-- 36538 Onyxia (1), minCnt 1, maxCnt 5
UPDATE `creature_loot_template` SET `MinCount` = 5 WHERE ( `Entry`= 36538 AND `Item` = 1 AND `Reference` = 34001 );
-- 36597 The Lich King, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36597 AND `Item` = 1 AND `Reference` = 34238 );
-- 36658 Scourgelord Tyrannus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36658 AND `Item` = 1 AND `Reference` = 35059 );
-- 36678 Professor Putricide, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36678 AND `Item` = 1 AND `Reference` = 34234 );
-- 36725 Nerub'ar Broodkeeper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36725 AND `Item` = 1 AND `Reference` = 35069 );
-- 36855 Lady Deathwhisper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36855 AND `Item` = 1 AND `Reference` = 34231 );
-- 36880 Decaying Colossus, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36880 AND `Item` = 1 AND `Reference` = 35069 );
-- 36938 Scourgelord Tyrannus (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 36938 AND `Item` = 1 AND `Reference` = 35062 );
-- 37023 Plague Scientist, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37023 AND `Item` = 1 AND `Reference` = 35069 );
-- 37038 Vengeful Fleshreaper, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37038 AND `Item` = 1 AND `Reference` = 35069 );
-- 38137 Frostwarden Sorceress (1), minCnt 1, maxCnt 2
-- 37229 Frostwarden Sorceress, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37229 AND `Item` = 1 AND `Reference` = 35069 );
-- 37502 Nerub'ar Webweaver, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37502 AND `Item` = 1 AND `Reference` = 35069 );
-- 37531 Frostwarden Handler, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37531 AND `Item` = 1 AND `Reference` = 35069 );
-- 37571 Darkfallen Advisor, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37571 AND `Item` = 1 AND `Reference` = 35069 );
-- 37655 Decaying Colossus (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37655 AND `Item` = 1 AND `Reference` = 35069 );
-- 37665 Darkfallen Lieutenant, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37665 AND `Item` = 1 AND `Reference` = 35069 );
-- 37955 Blood-Queen Lana'thel, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37955 AND `Item` = 1 AND `Reference` = 34236 );
-- 37970 Prince Valanar, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 37970 AND `Item` = 1 AND `Reference` = 34235 );
-- 38057 Servant of the Throne (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38057 AND `Item` = 1 AND `Reference` = 35069 );
-- 38062 Plague Scientist (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38062 AND `Item` = 1 AND `Reference` = 35069 );
-- 38064 Stinky (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38064 AND `Item` = 1 AND `Reference` = 35069 );
-- 38072 Deathspeaker Attendant (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38072 AND `Item` = 1 AND `Reference` = 35069 );
-- 38073 Deathspeaker Disciple (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38073 AND `Item` = 1 AND `Reference` = 35069 );
-- 38098 Darkfallen Advisor (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38098 AND `Item` = 1 AND `Reference` = 35069 );
-- 38100 Darkfallen Blood Knight (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38100 AND `Item` = 1 AND `Reference` = 35069 );
-- 38101 Darkfallen Lieutenant (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38101 AND `Item` = 1 AND `Reference` = 35069 );
-- 38113 Marwyn, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38113 AND `Item` = 1 AND `Reference` = 35054 );
-- 38197 Nerub'ar Champion (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38197 AND `Item` = 1 AND `Reference` = 35069 );
-- 38265 Sindragosa (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38265 AND `Item` = 2 AND `Reference` = 34278 );
-- 38266 Sindragosa (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38266 AND `Item` = 1 AND `Reference` = 34261 );
-- 38431 Professor Putricide (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38431 AND `Item` = 1 AND `Reference` = 34278 );
-- 38433 Toravon the Ice Watcher, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38433 AND `Item` = 1 AND `Reference` = 34206 );
-- 38446 Frenzied Abomination (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38446 AND `Item` = 1 AND `Reference` = 35069 );
-- 38462 Toravon the Ice Watcher (1), minCnt 1, maxCnt 3
UPDATE `creature_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 38462 AND `Item` = 1 AND `Reference` = 34207 );
-- 38480 Darkfallen Noble (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38480 AND `Item` = 1 AND `Reference` = 35069 );
-- 38481 Spire Gargoyle (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38481 AND `Item` = 1 AND `Reference` = 35069 );
-- 38490 Rotting Frost Giant, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38490 AND `Item` = 1 AND `Reference` = 35069 );
-- 38586 Professor Putricide (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 38586 AND `Item` = 1 AND `Reference` = 34278 );
-- 39863 Halion, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39863 AND `Item` = 1 AND `Reference` = 34280 );
-- 39864 Halion (1), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39864 AND `Item` = 1 AND `Reference` = 34282 );
-- 39944 Halion (2), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39944 AND `Item` = 1 AND `Reference` = 34281 );
-- 39945 Halion (3), minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 39945 AND `Item` = 1 AND `Reference` = 34283 );
-- 38177 Shadowy Mercenary, minCnt 1, maxCnt 2
-- 38176 Tortured Rifleman, minCnt 1, maxCnt 2
-- 38175 Ghostly Priest, minCnt 1, maxCnt 2
-- 38173 Spectral Footman, minCnt 1, maxCnt 2
-- 38172 Phantom Mage, minCnt 1, maxCnt 2
-- 37713 Deathwhisper Torturer, minCnt 1, maxCnt 2
-- 37712 Deathwhisper Shadowcaster, minCnt 1, maxCnt 2
-- 37711 Hungering Ghoul, minCnt 1, maxCnt 2
-- 36896 Stonespine Gargoyle, minCnt 1, maxCnt 2
-- 36879 Plagueborn Horror, minCnt 1, maxCnt 2
-- 36842 Wrathbone Coldwraith, minCnt 1, maxCnt 2
-- 36830 Wrathbone Laborer, minCnt 1, maxCnt 2
-- 36788 Deathwhisper Necrolyte, minCnt 1, maxCnt 2
-- 36723 Frostsworn General, minCnt 1, maxCnt 2
-- 36666 Spectral Warden, minCnt 1, maxCnt 2
-- 36620 Soulguard Adept, minCnt 1, maxCnt 2
-- 36564 Soulguard Bonecaster, minCnt 1, maxCnt 2
-- 36522 Soul Horror, minCnt 1, maxCnt 2
-- 36516 Soulguard Animator, minCnt 1, maxCnt 2
-- 36499 Soulguard Reaper, minCnt 1, maxCnt 2
-- 36478 Soulguard Watchman, minCnt 1, maxCnt 2
UPDATE `creature_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 100000 AND `Item` = 1 AND `Reference` = 35071 );

-- gameobject loot

-- 195672 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 195672 AND `Item` = 1 AND `Reference` = 34293 );
-- 195672 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 195672 AND `Item` = 2 AND `Reference` = 12002 );
-- 202238 Deathbringer's Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28058 AND `Item` = 1 AND `Reference` = 34264 );
-- 194315 Cache of Storms , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26956 AND `Item` = 2 AND `Reference` = 12033 );
-- 169243 Chest of The Seven , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 12260 AND `Item` = 12005 AND `Reference` = 12005 );
-- 185169 Reinforced Fel Iron Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 21764 AND `Item` = 1 AND `Reference` = 35093 );
-- 195046 Cache of Living Stone , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27061 AND `Item` = 1 AND `Reference` = 34361 );
-- 191349 Cache of Eregos , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 24462 AND `Item` = 1 AND `Reference` = 35041 );
-- 202338 Cache of the Dreamwalker , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28064 AND `Item` = 1 AND `Reference` = 34265 );
-- 195666 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 195666 AND `Item` = 3 AND `Reference` = 12002 );
-- 185119 Dust Covered Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 20712 AND `Item` = 12001 AND `Reference` = 12001 );
-- 195632 Champions' Cache , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 27503 AND `Item` = 1 AND `Reference` = 34325 );
-- 195632 Champions' Cache , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 27503 AND `Item` = 2 AND `Reference` = 34332 );
-- 202212 The Captain's Chest , minCnt 1, maxCnt 2
-- 201710 The Captain's Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27985 AND `Item` = 1 AND `Reference` = 35091 );
-- 179501 Knot Thimblejack's Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 16591 AND `Item` = 12006 AND `Reference` = 12006 );
-- 185168 Reinforced Fel Iron Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 21762 AND `Item` = 12003 AND `Reference` = 12003 );
-- 195668 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 195668 AND `Item` = 1 AND `Reference` = 12002 );
-- 194821 Gift of the Observer , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27030 AND `Item` = 1 AND `Reference` = 34134 );
-- 202241 Deathbringer's Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28088 AND `Item` = 2 AND `Reference` = 34278 );
-- 201872 Gunship Armory , minCnt 1, maxCnt 2
-- 202177 Gunship Armory , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28057 AND `Item` = 1 AND `Reference` = 34263 );
-- 194327 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27081 AND `Item` = 2 AND `Reference` = 12027 );
-- 194327 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27081 AND `Item` = 6 AND `Reference` = 34349 );
-- 202240 Deathbringer's Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28074 AND `Item` = 2 AND `Reference` = 34278 );
-- 193426 Four Horsemen Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 25193 AND `Item` = 2 AND `Reference` = 34382 );
-- 193426 Four Horsemen Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 25193 AND `Item` = 40344 AND `Reference` = 34146 );
-- 195633 Champions' Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27335 AND `Item` = 1 AND `Reference` = 34311 );
-- 195633 Champions' Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27335 AND `Item` = 2 AND `Reference` = 34318 );
-- 202336 The Captain's Chest , minCnt 1, maxCnt 2
-- 202337 The Captain's Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27993 AND `Item` = 1 AND `Reference` = 35092 );
-- 190663 Dark Runed Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 24556 AND `Item` = 1 AND `Reference` = 35037 );
-- 193905 Alexstrasza's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26094 AND `Item` = 1 AND `Reference` = 34174 );
-- 193967 Alexstrasza's Gift , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 26097 AND `Item` = 1 AND `Reference` = 34175 );
-- 195670 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 27517 AND `Item` = 1 AND `Reference` = 34293 );
-- 195670 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 27517 AND `Item` = 4 AND `Reference` = 12002 );
-- 195047 Cache of Living Stone , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 26929 AND `Item` = 1 AND `Reference` = 34362 );
-- 194314 Cache of Storms , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26955 AND `Item` = 2 AND `Reference` = 12033 );
-- 194329 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26960 AND `Item` = 2 AND `Reference` = 12027 );
-- 194329 Freya's Gift , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 26960 AND `Item` = 6 AND `Reference` = 34349 );
-- 194331 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26962 AND `Item` = 2 AND `Reference` = 12027 );
-- 194956 Cache of Innovation , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26963 AND `Item` = 2 AND `Reference` = 12031 );
-- 194958 Cache of Innovation , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 26967 AND `Item` = 2 AND `Reference` = 12031 );
-- 194822 Gift of the Observer , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 26974 AND `Item` = 1 AND `Reference` = 12023 );
-- 194325 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27079 AND `Item` = 2 AND `Reference` = 12027 );
-- 194326 Freya's Gift , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27080 AND `Item` = 4 AND `Reference` = 34349 );
-- 195635 Champions' Cache , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 27356 AND `Item` = 1 AND `Reference` = 34339 );
-- 195635 Champions' Cache , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 27356 AND `Item` = 2 AND `Reference` = 34346 );
-- 195631 Champions' Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27498 AND `Item` = 1 AND `Reference` = 34299 );
-- 195631 Champions' Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27498 AND `Item` = 2 AND `Reference` = 34305 );
-- 195669 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 27512 AND `Item` = 1 AND `Reference` = 34293 );
-- 195669 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 27512 AND `Item` = 6 AND `Reference` = 12002 );
-- 195671 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27518 AND `Item` = 1 AND `Reference` = 34293 );
-- 195671 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 27518 AND `Item` = 4 AND `Reference` = 12002 );
-- 201873 Gunship Armory , minCnt 1, maxCnt 2
-- 202178 Gunship Armory , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28045 AND `Item` = 1 AND `Reference` = 12036 );
-- 202239 Deathbringer's Cache , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28046 AND `Item` = 1 AND `Reference` = 34240 );
-- 201959 Cache of the Dreamwalker , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 28052 AND `Item` = 1 AND `Reference` = 34241 );
-- 201874 Gunship Armory , minCnt 1, maxCnt 3
-- 202180 Gunship Armory , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 28072 AND `Item` = 1 AND `Reference` = 34251 );
-- 202339 Cache of the Dreamwalker , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 28082 AND `Item` = 1 AND `Reference` = 34253 );
-- 201875 Gunship Armory , minCnt 1, maxCnt 3
-- 202179 Gunship Armory , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 28090 AND `Item` = 1 AND `Reference` = 34275 );
-- 202340 Cache of the Dreamwalker , minCnt 1, maxCnt 3
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 28096 AND `Item` = 1 AND `Reference` = 34277 );
-- 195665 Argent Crusade Tribute Chest , minCnt 1, maxCnt 4
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE ( `Entry`= 195665 AND `Item` = 5 AND `Reference` = 12002 );
-- 195667 Argent Crusade Tribute Chest , minCnt 1, maxCnt 2
UPDATE `gameobject_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 195667 AND `Item` = 3 AND `Reference` = 12002 );

-- item loot

-- 34846 Black Sack of Gems, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 34846 AND `Item` = 0 AND `Reference` = 10005 );
-- 34846 Black Sack of Gems, minCnt 1, maxCnt 3
UPDATE `item_loot_template` SET `MinCount` = 3 WHERE ( `Entry`= 34846 AND `Item` = 10005 AND `Reference` = 10005 );
-- 20469 Decoded True Believer Clippings, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 20469 AND `Item` = 1 AND `Reference` = 10025 );
-- 46007 Bag of Fishing Treasures, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 46007 AND `Item` = 1 AND `Reference` = 10016 );
-- 46007 Bag of Fishing Treasures, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 46007 AND `Item` = 2 AND `Reference` = 10017 );
-- 46007 Bag of Fishing Treasures, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 46007 AND `Item` = 3 AND `Reference` = 10018 );
-- 49909 Box of Chocolates, minCnt 1, maxCnt 6
UPDATE `item_loot_template` SET `MinCount` = 6 WHERE ( `Entry`= 49909 AND `Item` = 1 AND `Reference` = 50012 );
-- 44943 Icy Prism, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 44943 AND `Item` = 2 AND `Reference` = 45010 );
-- 30320 Bundle of Nether Spikes, minCnt 1, maxCnt 6
UPDATE `item_loot_template` SET `MinCount` = 6 WHERE ( `Entry`= 30320 AND `Item` = 10007 AND `Reference` = 10007 );
-- 33844 Barrel of Fish, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33844 AND `Item` = 10003 AND `Reference` = 10003 );
-- 33857 Crate of Meat, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 33857 AND `Item` = 10004 AND `Reference` = 10004 );
-- 45986 Tiny Titanium Lockbox, minCnt 1, maxCnt 2
UPDATE `item_loot_template` SET `MinCount` = 2 WHERE ( `Entry`= 45986 AND `Item` = 1 AND `Reference` = 10012 );
