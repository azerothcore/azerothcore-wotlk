-- ----------------------------------------------------------------------
--                          SPELL PROC EVENT
-- ----------------------------------------------------------------------
-- Fix Cooldowns
-- UPDATE spell_proc_event SET cooldown = cooldown*1000 WHERE cooldown < 1000;

-- [Paladin] Infusion of Light
REPLACE INTO spell_proc_event VALUES (-53569, 0, 10, 2097152, 65536, 0, 0, 2, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (53601, 0, 0, 0, 0, 0, 688808, 0, 0, 0, 6000); -- Sacred Shield
-- [Paladin] Heart of the Crusader
REPLACE INTO spell_proc_event VALUES (-20335, 0, 10, 8388608, 0, 0, 16, 0, 0, 100, 0);
-- [Paladin] Seal of Righteousness
REPLACE INTO spell_proc_event VALUES (21084, 1+2, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);
-- [Paladin] Seal of Corruption
REPLACE INTO spell_proc_event VALUES (53736, 0, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);
-- [Paladin] Seal of Vengeance
REPLACE INTO spell_proc_event VALUES (31801, 0, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);
-- [Paladin] Guarded by the light
REPLACE INTO spell_proc_event VALUES (53583, 0, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (53585, 0, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);
-- [Paladin] Reckoning
DELETE FROM spell_proc_event WHERE entry IN(-20177, 20177, 20179, 20180, 20181);
REPLACE INTO spell_proc_event VALUES (20182, 0, 0, 0, 0, 0, 0, 1+2+64+262144, 0, 0, 0);

-- [Hunter] Misdirection
REPLACE INTO spell_proc_event VALUES (34477, 0, 9, 0, 0, 0, 4+16+64+256+1024+4096+16384+65536+262144, 0, 0, 100, 0);
-- [Hunter] Culling the Herd
REPLACE INTO spell_proc_event VALUES (-61680, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0);
-- [Hunter] Entrapment
REPLACE INTO spell_proc_event VALUES (-19184, 0, 9, 16, 8192, 262144, 0, 0, 0, 0, 0);
-- [Hunter] Lock and Load
REPLACE INTO spell_proc_event VALUES (-56342, 0, 9, 24, 134217728, 409600, 0, 0, 0, 0, 22000);
-- [Hunter] Pet - Dust Cloud
REPLACE INTO spell_proc_event VALUES (54404, 0, 0, 0, 0, 0, 0, 4, 0, 100, 0);
-- [Hunter] Pet - Savage Rend
REPLACE INTO spell_proc_event VALUES (50871, 0, 9, 0, 1342177280, 0, 0, 2, 0, 100, 0);
-- [Hunter] Pet - Intimidation
REPLACE INTO spell_proc_event VALUES (19577, 0, 0, 0, 0, 0, 0, 1+2+1024, 0, 0, 0);

-- [Warlock] Improved Spirit Tap
REPLACE INTO spell_proc_event VALUES (-15337, 0, 6, 8192+8388608, 2, 0, 65536+262144, 2, 0, 100, 0);
-- [Warlock] Essence of Life
REPLACE INTO spell_proc_event VALUES (33953, 0, 0, 0, 0, 0, 278528, 3, 0, 0, 45000);
-- [Warlock] Siphon Life
REPLACE INTO spell_proc_event VALUES (63108, 0, 5, 2, 0, 0, 0, 262144, 0, 0, 0);
-- [Warlock] Demonic Immolation Passive
REPLACE INTO spell_proc_event VALUES (4524, 0, 0, 0, 0, 0, 1048576, 262144, 0, 0, 0);
-- [Warlock] Shadowfiend passive aura
REPLACE INTO spell_proc_event VALUES (28305, 0, 0, 0, 0, 0, 4, 1+2, 0, 100, 0);
-- [Warlock] Demonic Pact, pet trigger
REPLACE INTO spell_proc_event VALUES (53646, 0, 0, 0, 0, 0, 0, 2, 0, 0, 20000);
REPLACE INTO spell_proc_event VALUES (54909, 0, 0, 0, 0, 0, 0, 2, 0, 0, 20000);
-- [Warlock] Glyph of Shadowflame
REPLACE INTO spell_proc_event VALUES (63310, 0, 5, 0, 65536, 0, 65536, 1+2+1024, 0, 0, 0);
-- [Warlock] Nightfall
REPLACE INTO spell_proc_event VALUES (-18094, 0, 5, 10, 0, 0, 262144, 262144, 0, 0, 0);
-- [Warlock] Decimation
REPLACE INTO spell_proc_event VALUES (-63156, 126, 5, 1, 192, 0, 65536, 0, 0, 0, 0);

-- [Rogue] Overkill and Master of Subtlety with Vanish
REPLACE INTO spell_proc_event VALUES (31221, 0, 8, 4194304+2048, 0, 0, 1024, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (31222, 0, 8, 4194304+2048, 0, 0, 1024, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (31223, 0, 8, 4194304+2048, 0, 0, 1024, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (58426, 0, 8, 4194304+2048, 0, 0, 1024, 0, 0, 0, 0);
-- [Rogue] Stealth
REPLACE INTO spell_proc_event VALUES (1784, 0, 0, 0, 0, 0, 0, 262144, 0, 0, 0);
-- [Rogue] Hemorrhage
REPLACE INTO spell_proc_event VALUES (-16511, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- [Death Knight] Desolation
REPLACE INTO spell_proc_event VALUES (-66799, 0, 15, 4194304, 0, 0, 16, 0, 0, 0, 0);
-- [Death Knight] Cinderglacier
REPLACE INTO spell_proc_event VALUES (53386, 48, 15, 8192+1+2, 4+2, 128, 349456, 0, 0, 0, 0);
-- [Death Knight] Taste for Blood
REPLACE INTO spell_proc_event VALUES (60503, 1, 4, 4, 0, 0, 16, 65536, 0, 0, 0);
-- [Death Knight] Scent of Blood
REPLACE INTO spell_proc_event VALUES (50421, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000);
-- [Death Knight] Necrosis
REPLACE INTO spell_proc_event VALUES (-51459, 0, 15, 0, 536870912, 0, 20, 0, 0, 0, 0);
-- [Death Knight] Blood-Caked Blade
REPLACE INTO spell_proc_event VALUES (-49219, 0, 15, 0, 536870912, 0, 20, 0, 0, 0, 0);
-- [Death Knight] Enduring Winter
REPLACE INTO spell_proc_event VALUES (-44557, 0, 3, 32, 0, 0, 0, 0, 0, 0, 6000);
-- [Death Knight] Wandering Plague
REPLACE INTO spell_proc_event VALUES (-49217, 0, 15, 0, 0, 2, 0, 0, 0, 0, 500);

-- [Mage] Improved Mana Gems
REPLACE INTO spell_proc_event VALUES (37447, 0, 3, 0, 256, 0, 1024+16384, 0, 0, 100, 15000); 
REPLACE INTO spell_proc_event VALUES (61062, 0, 3, 0, 256, 0, 1024+16384, 0, 0, 100, 15000);
-- [Mage] Arcane Potency
DELETE FROM spell_proc_event WHERE entry IN(31571, 31572);
-- [Mage] Deep Freeze
DELETE FROM spell_proc_event WHERE entry=71761;
DELETE FROM playercreateinfo_spell WHERE spell=71761;
DELETE FROM spell_script_names WHERE spell_id=44572;
INSERT INTO spell_script_names VALUES (44572, 'spell_mage_deep_freeze');
DELETE FROM spell_linked_spell WHERE spell_trigger=44572;
-- [Mage] Master of Elements
UPDATE spell_proc_event SET SchoolMask=0 WHERE entry IN(29074, 29075, 29076);
-- [Mage] Combustion
REPLACE INTO spell_proc_event VALUES (11129, 4, 3, 12582935, 200768, 0, 0, 0, 0, 0, 0);
-- [Mage] Fingers of Frost
REPLACE INTO spell_proc_event VALUES (74396, 84, 3, 685904631, 1151040, 0, 65536, 3, 0, 0, 0);
-- [Mage] Brain Freeze - adding small internal cooldown (the rest is unchanged)
REPLACE INTO spell_proc_event VALUES (44546, 0, 3, 1049120, 4096, 0, 69632, 0, 0, 5, 3000);
REPLACE INTO spell_proc_event VALUES (44548, 0, 3, 1049120, 4096, 0, 69632, 0, 0, 10, 3000);
REPLACE INTO spell_proc_event VALUES (44549, 0, 3, 1049120, 4096, 0, 69632, 0, 0, 15, 3000);
DELETE FROM spell_script_names WHERE spell_id IN(-44546, 44546, 44548, 44549);
INSERT INTO spell_script_names VALUES (-44546, 'spell_mage_brain_freeze');
-- [Mage] Magic Absorption
REPLACE INTO spell_proc_event VALUES (-29441, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0);


-- [Shaman] Windfury Weapon
REPLACE INTO spell_proc_event VALUES (33757, 0, 0, 0, 0, 0, 0, 0, 0, 20, 3000);
-- [Shaman] Elemental Focus
REPLACE INTO spell_proc_event VALUES (16164, 0, 11, 2416967875, 4096+262144, 0, 0, 2, 0, 0, 0);
-- [Shaman] Improved Stormstrike
REPLACE INTO spell_proc_event VALUES (-51521, 0, 11, 0, 16, 0, 0, 0, 0, 0, 1);


-- [Priest] Inner Fire
REPLACE INTO spell_proc_event VALUES (-588, 0, 0, 0, 0, 0, 0, 262144, 0, 0, 0);
-- [Priest] Shadow Weaving
REPLACE INTO spell_proc_event VALUES (15257, 32, 6, 0, 0, 0, 65536, 0, 0, 33, 0);
REPLACE INTO spell_proc_event VALUES (15331, 32, 6, 0, 0, 0, 65536, 0, 0, 66, 0);
REPLACE INTO spell_proc_event VALUES (15332, 32, 6, 0, 0, 0, 65536, 0, 0, 100, 0);
-- [Priest] Renewed Hope
REPLACE INTO spell_proc_event VALUES (-57470, 0, 6, 1, 0, 0, 0, 0, 0, 0, 15000);
-- [Priest] Borrowed Time
REPLACE INTO spell_proc_event VALUES (59887, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (59888, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (59889, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (59890, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (59891, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0);
-- [Priest] Misery
DELETE FROM spell_proc_event WHERE entry IN(-33191, 33191, 33192, 33193);
INSERT INTO spell_proc_event VALUES (-33191, 0, 6, 8388608+32768, 1024, 0, 0, 0, 0, 0, 0);


-- [Warrior] Recklessness
REPLACE INTO spell_proc_event VALUES (1719, 0, 4, 778044484, 4212549, 0, 0, 2, 0, 0, 0);
-- [Warrior] Furious Attacks
REPLACE INTO spell_proc_event VALUES (46910, 0, 4, 64, 0, 0, 20, 0, 5.5, 0, 0);
REPLACE INTO spell_proc_event VALUES (46911, 0, 4, 64, 0, 0, 20, 0, 7.5, 0, 0);

-- [Druid] Idol of the Crying Moon
REPLACE INTO spell_proc_event VALUES (71174, 0, 7, 4096, 256, 0, 262144, 0, 0, 0, 0);

-- [Item] Glyph of Freezing trap
REPLACE INTO spell_proc_event VALUES (56845, 0, 9, 8, 0, 0, 2097152, 0, 0, 0, 0);
-- [Item] Warrior T8 Protection 4P Bonus
REPLACE INTO spell_proc_event VALUES (64936, 0, 4, 4096, 0, 0, 4096+65536, 0, 0, 100, 0);
-- [Item] Goblin Gumbo
REPLACE INTO spell_proc_event VALUES (42760, 0, 0, 0, 0, 0, 2+4+8+64+128+16384+32768+65536+131072, 0, 0, 20, 0);
-- [Item] Lightweave Embroidery
REPLACE INTO spell_proc_event VALUES (55640, 0, 0, 0, 0, 0, 0, 1+2, 0, 0, 45000);
-- [Item] Val'anyr
REPLACE INTO spell_proc_event VALUES (64411, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (64415, 0, 0, 0, 0, 0, 0, 524288, 0, 0, 45000);
-- [Item] Coment's Trial
REPLACE INTO spell_proc_event VALUES (64786, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45000);
-- [Item] Berserker!
REPLACE INTO spell_proc_event VALUES (57351, 0, 0, 0, 0, 0, 1782780, 0, 0, 0, 0);
-- [Item] - Rogue T10 2P Bonus
REPLACE INTO spell_proc_event VALUES (70805, 0, 8, 0, 131072, 0, 0, 0, 0, 0, 1000);
-- [Item] Coliseum 25 Normal Melee Trinket
REPLACE INTO spell_proc_event VALUES (67702, 1, 0, 0, 0, 0, 332116, 3+262144, 0, 35, 45000);
-- [Item] Coliseum 25 Heroic Melee Trinket
REPLACE INTO spell_proc_event VALUES (67771, 1, 0, 0, 0, 0, 332116, 3+262144, 0, 35, 45000);
-- [Item] Mage T8 2P Bonus
REPLACE INTO spell_proc_event VALUES (64867, 0, 3, 536870945, 4096, 0, 0, 0, 0, 0, 45000);
-- [Item] Rouge T9 Clearcasting
REPLACE INTO spell_proc_event VALUES (67210, 0, 8, 4294967295, 4294967295, 4294967295, 0, 0, 0, 0, 0);
-- [Item] Glyph of Shadow Word: Pain
REPLACE INTO spell_proc_event VALUES (55681, 0, 6, 32768, 0, 0, 262144, 0, 0, 0, 0);
-- [Item] Glyph of Blocking
REPLACE INTO spell_proc_event VALUES (58375, 0, 4, 0, 512, 0, 16+65536, 0, 0, 100, 0);
-- [Item] Eye of the Broodmother
DELETE FROM spell_proc_event WHERE entry=65007;
-- [Item] Alchemist Stone
REPLACE INTO spell_proc_event VALUES (17619, 0, 13, 0, 0, 0, 32768+2048, 3, 0, 0, 0);
-- [Item] Ephemeral Snowflake
REPLACE INTO spell_proc_event VALUES (71567, 0, 0, 0, 0, 0, 0, 1+2, 0, 0, 400);
-- [Item] Meteorite Crystal
REPLACE INTO spell_proc_event VALUES (64999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
-- [Item] Shadowmourne
REPLACE INTO spell_proc_event VALUES (71903, 0, 0, 0, 0, 0, 0, 1+2+1024+1048576, 0, 75, 0);
-- [Item] DK 4P bonus
REPLACE INTO spell_proc_event VALUES (61257, 0, 0, 0, 0, 0, 0, 1+2, 0, 0, 0);
-- [Item] Dislodged Foreign Object
REPLACE INTO spell_proc_event VALUES (71602, 0, 0, 0, 0, 0, 65536, 1+2, 0, 0, 45000);
REPLACE INTO spell_proc_event VALUES (71645, 0, 0, 0, 0, 0, 65536, 1+2, 0, 0, 45000);
-- [Item] Item - Shaman T10 Elemental Relic
REPLACE INTO spell_proc_event VALUES (71198, 0, 11, 268435456, 0, 0, 0, 0, 0, 0, 0);
-- [Item] Sundial of the Exiled
-- [Item] Mithril Pocketwatch
REPLACE INTO spell_proc_event VALUES (60063, 0, 0, 0, 0, 0, 65536, 0, 0, 0, 45000);




-- ----------------------------------------------------------------------
--                             SPELL SCRIPTS
-- ----------------------------------------------------------------------
-- Model Visibility
DELETE FROM spell_script_names WHERE spell_id=24401;
INSERT INTO spell_script_names VALUES (24401, 'spell_gen_model_visible');

-- One per cast procs
DELETE FROM spell_script_names WHERE ScriptName='spell_gen_proc_once_per_cast';
INSERT INTO spell_script_names VALUES (71845, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (75474, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (75465, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (71645, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (71846, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (71602, 'spell_gen_proc_once_per_cast');
INSERT INTO spell_script_names VALUES (72419, 'spell_gen_proc_once_per_cast');


-- [Item] SOTA Seaforium Charge
DELETE FROM spell_script_names WHERE spell_id=52417;
INSERT INTO spell_script_names VALUES (52417, 'spell_item_massive_seaforium_charge');
-- [Item] Titanium Seal of Dalaran
DELETE FROM spell_script_names WHERE spell_id=60476;
INSERT INTO spell_script_names VALUES (60476, 'spell_item_titanium_seal_of_dalaran');
-- [Item] Mind Amplification Dish
DELETE FROM spell_script_names WHERE spell_id IN(67799, 13180);
INSERT INTO spell_script_names VALUES (67799, 'spell_item_mind_amplify_dish');
INSERT INTO spell_script_names VALUES (13180, 'spell_item_mind_amplify_dish');
-- [Item] Mithril Spurs (7969)
DELETE FROM spell_script_names WHERE spell_id IN(7215);
INSERT INTO spell_script_names VALUES (7215, 'spell_item_mithril_spurs');
-- [Item] Magic Dust (2091)
DELETE FROM spell_script_names WHERE spell_id IN(1090);
INSERT INTO spell_script_names VALUES (1090, 'spell_item_magic_dust');
-- [Item] Crazy Alchemist's Potion (40077)
DELETE FROM spell_script_names WHERE spell_id IN(53750);
INSERT INTO spell_script_names VALUES (53750, 'spell_item_crazy_alchemists_potion');
-- [Item] Skull of Impending Doom (4984)
DELETE FROM spell_script_names WHERE spell_id IN(5024);
INSERT INTO spell_script_names VALUES (5024, 'spell_item_skull_of_impeding_doom');
-- [Item] Carrot on a Stick
DELETE FROM spell_script_names WHERE spell_id IN(48777);
INSERT INTO spell_script_names VALUES (48777, 'spell_item_carrot_on_a_stick');
-- [Item] Runescroll of Fortitude
DELETE FROM spell_linked_spell WHERE spell_trigger=69377;
DELETE FROM spell_script_names WHERE spell_id IN(69377);
INSERT INTO spell_script_names VALUES (69377, 'spell_item_runescroll_of_fortitude');
-- [Item] Brann's Communicator
DELETE FROM spell_linked_spell WHERE spell_trigger IN(61122);
DELETE FROM spell_script_names WHERE spell_id IN(61122);
INSERT INTO spell_script_names VALUES (61122, 'spell_item_branns_communicator');
-- [Item] Essence of Life (33953), triggered by Ancient Pickled Egg and The Egg of Mortal Essence
DELETE FROM spell_script_names WHERE spell_id IN(33953);
INSERT INTO spell_script_names VALUES (33953, 'spell_item_essence_of_life');
-- [Item] Fish Feast (57426)
DELETE FROM spell_script_names WHERE spell_id IN(57426);
INSERT INTO spell_script_names VALUES (57426, 'spell_item_fish_feast');
-- [Item] Strong Anti-Venom (7933)
DELETE FROM spell_script_names WHERE spell_id IN(7933);
INSERT INTO spell_script_names VALUES (7933, 'spell_item_strong_anti_venom');
-- [Item] Gnomish Shrink Ray
DELETE FROM spell_script_names WHERE spell_id IN(13006);
INSERT INTO spell_script_names VALUES (13006, 'spell_item_gnomish_shrink_ray');
-- [Item] Goblin Weather Machine
DELETE FROM spell_script_names WHERE spell_id IN(46203, 46736, 46738, 46739, 46740);
INSERT INTO spell_script_names VALUES (46203, 'spell_item_goblin_weather_machine');
INSERT INTO spell_script_names VALUES (46736, 'spell_item_goblin_weather_machine');
INSERT INTO spell_script_names VALUES (46738, 'spell_item_goblin_weather_machine');
INSERT INTO spell_script_names VALUES (46739, 'spell_item_goblin_weather_machine');
INSERT INTO spell_script_names VALUES (46740, 'spell_item_goblin_weather_machine');
-- [Item] Big Blizzard Bear
DELETE FROM spell_script_names WHERE spell_id IN(58983);
INSERT INTO spell_script_names VALUES (58983, 'spell_big_blizzard_bear');
-- [Item] Oracle Talisman of Ablution
DELETE FROM spell_script_names WHERE spell_id IN(59789);
INSERT INTO spell_script_names VALUES (59789, 'spell_item_oracle_ablutions');
-- [Item] Trauma
REPLACE INTO spell_proc_event VALUES (71865, 0, 0, 0, 0, 0, 0, 1+2, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (71868, 0, 0, 0, 0, 0, 0, 1+2, 0, 0, 0); -- HC
DELETE FROM spell_script_names WHERE spell_id IN(71865, 71868);
INSERT INTO spell_script_names VALUES (71865, 'spell_item_trauma');
INSERT INTO spell_script_names VALUES (71868, 'spell_item_trauma');
-- [Item] Furbolg Medicine Pouch
DELETE FROM spell_script_names WHERE spell_id IN(20631);
INSERT INTO spell_script_names VALUES (20631, 'spell_gen_use_spell_base_level_check');
-- [Item] Deadman's Hand
DELETE FROM spell_script_names WHERE spell_id IN(27867);
INSERT INTO spell_script_names VALUES (27867, 'spell_gen_disabled_above_70');
-- [Item] Lightweave Embroidery
DELETE FROM spell_script_names WHERE spell_id IN(55640);
INSERT INTO spell_script_names VALUES (55640, 'spell_gen_allow_proc_from_spells_with_cost');
-- [Item] Hand of Justice
REPLACE INTO spell_proc_event VALUES (15600, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0);
DELETE FROM spell_script_names WHERE spell_id IN(15600);
INSERT INTO spell_script_names VALUES (15600, 'spell_gen_proc_reduced_above_60');



-- [Enchant] Icy Chill (20005)
-- [Enchant] Lifestealing (20004)
-- [Enchant] Crusader (20007)
REPLACE INTO spell_enchant_proc_data VALUES (1894, 0, 1.7, 0);
DELETE FROM spell_script_names WHERE spell_id IN(20004, 20005, 20007);
INSERT INTO spell_script_names VALUES (20004, 'spell_gen_reduced_above_60');
INSERT INTO spell_script_names VALUES (20005, 'spell_gen_reduced_above_60');
INSERT INTO spell_script_names VALUES (20007, 'spell_gen_reduced_above_60');
-- [Enchant] Deathfrost (46629)
DELETE FROM spell_script_names WHERE spell_id IN(46629);
INSERT INTO spell_script_names VALUES (46629, 'spell_gen_disabled_above_73');
-- [Enchant] Enchant Gloves - Riding Skill (13927)
DELETE FROM spell_script_names WHERE spell_id IN(59917);
INSERT INTO spell_script_names VALUES (59917, 'spell_gen_disabled_above_70');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(13927, -13927);
INSERT INTO spell_linked_spell VALUES (13927, 59917, 1, 'Enchant Gloves - Riding Skill Speed add');
INSERT INTO spell_linked_spell VALUES (-13927, -59917, 0, 'Enchant Gloves - Riding Skill Speed remove');
-- [Enchant] Black Magic (59630)
REPLACE INTO spell_proc_event VALUES (59630, 0, 0, 0, 0, 0, 65536+16+4096, 0, 0, 0, 35000);
DELETE FROM spell_script_names WHERE spell_id IN(59630);
INSERT INTO spell_script_names VALUES (59630, 'spell_gen_black_magic_enchant');
-- [Enchant] Blade Ward (64440)
DELETE FROM spell_script_names WHERE spell_id IN(64440);
INSERT INTO spell_script_names VALUES (64440, 'spell_item_blade_ward_enchant');
INSERT INTO spell_script_names VALUES (64440, 'spell_gen_proc_above_75');
-- [Enchant] Blood Draining (64568)
DELETE FROM spell_script_names WHERE spell_id IN(64568);
INSERT INTO spell_script_names VALUES (64568, 'spell_item_blood_draining_enchant');
INSERT INTO spell_script_names VALUES (64568, 'spell_gen_proc_above_75');


-- [Misc] Luck of the Draw
DELETE FROM spell_script_names WHERE spell_id=72221;
-- [Misc] Grow Flower Patch (Lifeblood trigger)
DELETE FROM spell_script_names WHERE spell_id IN(55475);
INSERT INTO spell_script_names VALUES (55475, 'spell_gen_grow_flower_patch');
-- [Misc] Preparation / Arena Preparation
DELETE FROM spell_script_names WHERE spell_id IN(32727, 44521);
INSERT INTO spell_script_names VALUES (32727, 'spell_gen_bg_preparation');
INSERT INTO spell_script_names VALUES (44521, 'spell_gen_bg_preparation');
-- [Misc] Eject All Passengers
DELETE FROM spell_script_names WHERE spell_id IN(50630);
INSERT INTO spell_script_names VALUES (50630, 'spell_gen_eject_all_passengers');
-- [Misc] Fixate
DELETE FROM spell_script_names WHERE spell_id IN(40414, 40892, 49026);
INSERT INTO spell_script_names VALUES (40414, 'spell_gen_fixate');
INSERT INTO spell_script_names VALUES (40892, 'spell_gen_fixate');
INSERT INTO spell_script_names VALUES (49026, 'spell_gen_fixate');
-- [Misc] Periodic Knock Away
DELETE FROM spell_script_names WHERE spell_id IN(21737);
INSERT INTO spell_script_names VALUES (21737, 'spell_gen_periodic_knock_away');
-- [Misc] Knock Away 
DELETE FROM spell_script_names WHERE spell_id IN(10101, 18670, 18813, 18945, 19633, 20686, 25778, 31389, 32959);
INSERT INTO spell_script_names VALUES (10101, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (18670, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (18813, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (18945, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (19633, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (20686, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (25778, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (31389, "spell_gen_knock_away");
INSERT INTO spell_script_names VALUES (32959, "spell_gen_knock_away");
-- [Misc] Hate to Zero (9204), spell_dbc
DELETE FROM spell_script_names WHERE spell_id IN(9204);
INSERT INTO spell_script_names VALUES (9204, 'spell_gen_hate_to_zero');



-- [Death Knight] Wandering Plague target selector
DELETE FROM spell_script_names WHERE spell_id IN(50526);
INSERT INTO spell_script_names VALUES (50526, 'spell_dk_wandering_plague');
-- [Death Knight] Army of the Dead
UPDATE creature_template SET unit_class=4, AIName='', ScriptName='npc_pet_dk_army_of_the_dead', spell1=47468, spell2=47482 WHERE entry=24207;
REPLACE INTO creature_template_addon VALUES (24207, 0, 0, 0, 1, 0, '43264'); -- periodic taunt
DELETE FROM spell_script_names WHERE spell_id IN(43263);
INSERT INTO spell_script_names VALUES (43263, 'spell_dk_aotd_taunt');
-- [Death Knight] Raise Ally
DELETE FROM spell_script_names WHERE spell_id IN(61999);
INSERT INTO spell_script_names VALUES (61999, 'spell_dk_raise_ally');
DELETE FROM spell_script_names WHERE spell_id IN(46619);
INSERT INTO spell_script_names VALUES (46619, 'spell_dk_raise_ally_trigger');
-- [Death Knight] Master of Ghouls
DELETE FROM spell_script_names WHERE spell_id IN(52143);
INSERT INTO spell_script_names VALUES (52143, 'spell_dk_master_of_ghouls');
-- [Death Knight] Death Grip
DELETE FROM spell_script_names WHERE spell_id IN(49576, 49560);
INSERT INTO spell_script_names VALUES (49576, 'spell_dk_death_grip');
INSERT INTO spell_script_names VALUES (49560, 'spell_dk_death_grip');
DELETE FROM spell_linked_spell WHERE spell_trigger=49576;
-- [Death Knight] Chains of Ice
DELETE FROM spell_script_names WHERE spell_id IN(45524);
INSERT INTO spell_script_names VALUES (45524, 'spell_dk_chains_of_ice');
DELETE FROM spell_linked_spell WHERE spell_trigger=45524;
-- [Death Knight] Scent of Blood
DELETE FROM spell_script_names WHERE spell_id IN(-49004, 49004, 49508, 49509);
INSERT INTO spell_script_names VALUES (-49004, 'spell_gen_proc_from_direct_damage');
INSERT INTO spell_script_names VALUES (-49004, 'spell_dk_scent_of_blood_trigger');
-- [Death Knight] Rime
DELETE FROM spell_script_names WHERE spell_id IN(-49188, 49188, 56822, 59057);
INSERT INTO spell_script_names VALUES (-49188, 'spell_gen_no_offhand_proc');
-- [Death Knight] Killing Machine
DELETE FROM spell_script_names WHERE spell_id IN(-51123, 51123, 51127, 51128, 51129, 51130);
INSERT INTO spell_script_names VALUES (-51123, 'spell_gen_no_offhand_proc');
-- [Death Knight] Bloodworms
DELETE FROM spell_script_names WHERE spell_id IN(50452);
INSERT INTO spell_script_names VALUES (50452, 'spell_dk_bloodworms');
-- [Death Knight] Summon Gargoyle
DELETE FROM spell_script_names WHERE spell_id IN(49206);
INSERT INTO spell_script_names VALUES (49206, 'spell_dk_summon_gargoyle');
-- [Death Knight] Improved Blood Presence
DELETE FROM spell_script_names WHERE spell_id IN(63611);
INSERT INTO spell_script_names VALUES (63611, 'spell_dk_improved_blood_presence_proc');
-- [Death Knight] Wandering Plague
DELETE FROM spell_script_names WHERE spell_id IN(-49217, 49217, 49654, 49655);
INSERT INTO spell_script_names VALUES (-49217, 'spell_dk_wandering_plague_aura');
-- [Death Knight] Bone Shield
DELETE FROM spell_script_names WHERE spell_id IN(49222);
INSERT INTO spell_script_names VALUES (49222, 'spell_dk_bone_shield');
-- [Death Knight] Hungering Cold
DELETE FROM spell_script_names WHERE spell_id IN(51209);
INSERT INTO spell_script_names VALUES (51209, 'spell_dk_hungering_cold');
-- [Death Knight] Hungering Cold
DELETE FROM spell_script_names WHERE spell_id IN(-49219, 49219, 49627, 49628);
INSERT INTO spell_script_names VALUES (-49219, 'spell_dk_blood_caked_blade');


-- [Hunter] Call of the Wild, Furious Howl target only master / pet, done in spellmgr.cpp
DELETE FROM spell_script_names WHERE ScriptName='spell_hun_target_only_pet_and_owner';
-- [Hunter] Mend Pet
DELETE FROM spell_script_names WHERE spell_id IN(-136, 136, 3111, 3661, 3662, 13542, 13543, 13544, 27046, 33976, 48989, 48990);
INSERT INTO spell_script_names VALUES (-136, 'spell_hun_check_pet_los');
-- [Hunter] Aspect of the Beast
DELETE FROM spell_script_names WHERE spell_id IN(13161, 61669);
INSERT INTO spell_script_names VALUES (13161, 'spell_hun_aspect_of_the_beast');
INSERT INTO spell_script_names VALUES (61669, 'spell_hun_aspect_of_the_beast');
-- [Hunter] Pet's Cover
DELETE FROM spell_script_names WHERE spell_id IN(1742);
INSERT INTO spell_script_names VALUES (1742, 'spell_hun_cower');
-- [Hunter] Wyvern Sting
DELETE FROM spell_script_names WHERE spell_id IN(-19386, 19386, 24132, 24133, 27068, 49011, 49012);
INSERT INTO spell_script_names VALUES (-19386, 'spell_hun_wyvern_sting');
-- [Hunter] Animal Handler
DELETE FROM spell_pet_auras WHERE spell IN(34453, 34454);
INSERT INTO spell_pet_auras VALUES (34453, 1, 0, 68361);
INSERT INTO spell_pet_auras VALUES (34454, 1, 0, 68361);
DELETE FROM spell_script_names WHERE spell_id IN(68361);
INSERT INTO spell_script_names VALUES (68361, 'spell_hun_animal_handler');



-- [Rogue] Killing Spree
DELETE FROM spell_linked_spell WHERE spell_trigger IN(51690);
INSERT INTO spell_linked_spell VALUES (51690, 61851, 2, 'Rogue - Killing Spree');
DELETE FROM spell_script_names WHERE spell_id IN(51690);
INSERT INTO spell_script_names VALUES (51690, 'spell_rog_killing_spree');
-- [Rogue] Savage Combat
REPLACE INTO spell_proc_event VALUES (51682, 0, 8, 0, 524288, 0, 0, 0, 0, 0, 0);
REPLACE INTO spell_proc_event VALUES (58413, 0, 8, 0, 524288, 0, 0, 0, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(-58683, -58684, 58683, 58684);
INSERT INTO spell_script_names VALUES (58683, 'spell_rog_savage_combat');
INSERT INTO spell_script_names VALUES (58684, 'spell_rog_savage_combat');
-- [Rogue] Combat Potency
DELETE FROM spell_script_names WHERE spell_id IN(-35541, 35541);
INSERT INTO spell_script_names VALUES (-35541, 'spell_rog_combat_potency');
-- [Rogue] Item - Rogue T10 2P Bonus
DELETE FROM spell_script_names WHERE spell_id IN(70805);
INSERT INTO spell_script_names VALUES (70805, 'spell_gen_proc_on_self');
-- [Rogue] Item - Rogue T10 4P Bonus
DELETE FROM spell_script_names WHERE spell_id IN(70803);
INSERT INTO spell_script_names VALUES (70803, 'spell_gen_proc_not_self');
-- [Rogue] Cheat Death
DELETE FROM spell_scripts WHERE id=31231;



-- [Warrior] Mocking Blow
DELETE FROM spell_script_names WHERE spell_id IN(21008, 694);
INSERT INTO spell_script_names VALUES (694, 'spell_warr_mocking_blow');
-- [Warrior] Enrage talent
DELETE FROM spell_script_names WHERE spell_id IN(-12317, 12317, 13045, 13046, 13047, 13048);
INSERT INTO spell_script_names VALUES (-12317, 'spell_gen_proc_from_direct_damage');
-- [Warrior] Intervene
DELETE FROM spell_script_names WHERE spell_id IN(3411);
INSERT INTO spell_script_names VALUES (3411, 'spell_warr_intervene');
-- [Warrior] Intervene
DELETE FROM spell_script_names WHERE spell_id IN(-59725, 59725, 23920, -59088, 59088, 59089);
INSERT INTO spell_script_names VALUES (59088, 'spell_warr_improved_spell_reflection');
INSERT INTO spell_script_names VALUES (59089, 'spell_warr_improved_spell_reflection');
INSERT INTO spell_script_names VALUES (59725, 'spell_warr_improved_spell_reflection_trigger');


-- [Shaman] Glyph of Totem of Wrath
DELETE FROM spell_proc_event WHERE entry=63280;
DELETE FROM spell_script_names WHERE spell_id IN(-30706, 30706, 57720, 57721, 57722);
INSERT INTO spell_script_names VALUES (-30706, 'spell_sha_totem_of_wrath');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-57658, -57660, -57662, -57663);
-- [Shaman] Earthen Power
DELETE FROM spell_script_names WHERE spell_id IN(59566);
INSERT INTO spell_script_names VALUES (59566, 'spell_sha_earthen_power');
-- [Shaman] Spirit Walk (Feral Spirits)
DELETE FROM spell_script_names WHERE spell_id IN(58875);
INSERT INTO spell_script_names VALUES (58875, 'spell_sha_spirit_walk');
DELETE FROM disables WHERE entry IN(58875) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 58875, 64, '', '', 'Disable LOS for Spirit Walk');
-- [Shaman] Item - Shaman T10 Restoration 4P Bonus
REPLACE INTO spell_proc_event VALUES (70808, 0, 11, 256, 0, 0, 0, 2, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(70808);
INSERT INTO spell_script_names VALUES (70808, 'spell_sha_t10_restoration_4p_bonus');
-- [Shaman] Water Shield
DELETE FROM spell_script_names WHERE spell_id IN(-52127, 52127, 52129, 52131, 52134, 52136, 52138, 24398, 33736, 57960);
-- [Shaman] Item - Shaman T6 Totemic Mastery 2P Bonus
DELETE FROM spell_script_names WHERE spell_id IN(38443);
INSERT INTO spell_script_names VALUES (38443, 'spell_sha_totemic_mastery');



-- [Mage] Arcane Blast
DELETE FROM spell_script_names WHERE spell_id IN(-30451, 30451, 42894, 42896, 42897);
INSERT INTO spell_script_names VALUES (-30451, 'spell_mage_arcane_blast');
-- [Mage] Burning Determination
DELETE FROM spell_script_names WHERE spell_id IN(54747, 54749);
INSERT INTO spell_script_names VALUES (54747, 'spell_mage_burning_determination');
INSERT INTO spell_script_names VALUES (54749, 'spell_mage_burning_determination');
-- [Mage] Molten Shields (Molten Armor)
DELETE FROM spell_script_names WHERE spell_id IN(-30482, 30482, 43045, 43046);
INSERT INTO spell_script_names VALUES (-30482, 'spell_mage_molten_armor');
-- [Mage] Burnout
DELETE FROM spell_script_names WHERE spell_id IN(-44450, 44450, -44449, 44449, 44469, 44470, 44471, 44472);
INSERT INTO spell_script_names VALUES (-44449, 'spell_mage_burnout');
INSERT INTO spell_script_names VALUES (-44450, 'spell_mage_burnout_trigger');




-- [Warlock] Glyph of Seduction
DELETE FROM spell_script_names WHERE spell_id IN(6358);
INSERT INTO spell_script_names VALUES (6358, 'spell_warl_seduction');
-- [Warlock] Eye of Kilrogg
DELETE FROM spell_script_names WHERE spell_id IN(126);
INSERT INTO spell_script_names VALUES (126, 'spell_warl_eye_of_kilrogg');
-- [Warlock] Shadowflame
DELETE FROM spell_linked_spell WHERE spell_trigger IN(47897, 61290);
DELETE FROM spell_script_names WHERE spell_id IN(-47897);
INSERT INTO spell_script_names VALUES (-47897, 'spell_warl_shadowflame');
-- [Warlock] Health Funnel
DELETE FROM spell_script_names WHERE spell_id IN(-755);
INSERT INTO spell_script_names VALUES (-755, 'spell_hun_check_pet_los'); -- script name correct (spell_hun_*)
INSERT INTO spell_script_names VALUES (-755, 'spell_warl_health_funnel');
-- [Warlock] Improved Demonic Tactics
DELETE FROM spell_script_names WHERE spell_id IN(-54347, 54347, 54348, 54349);
INSERT INTO spell_script_names VALUES (-54347, 'spell_warl_improved_demonic_tactics');
-- [Warlock] Ritual of Summoning
DELETE FROM spell_script_names WHERE spell_id IN(698);
INSERT INTO spell_script_names VALUES (698, 'spell_warl_ritual_of_summoning');
-- [Warlock] Demonic Aegis
DELETE FROM spell_script_names WHERE spell_id IN(-30143, 30143, 30144, 30145);
INSERT INTO spell_script_names VALUES (-30143, 'spell_warl_demonic_aegis');
-- [Warlock] Demonic Aegis
DELETE FROM spell_script_names WHERE spell_id IN(-35696, 35696);
INSERT INTO spell_script_names VALUES (-35696, 'spell_warl_demonic_knowledge');


-- [Paladin] Seal of Command (20375)
REPLACE INTO spell_proc_event VALUES (20375, 1+2, 0, 0, 0, 0, 0, 0, 0, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(20375, 20424);
INSERT INTO spell_script_names VALUES (20375, 'spell_pal_seal_of_command');
INSERT INTO spell_script_names VALUES (20424, 'spell_pal_seal_of_command');
-- [Paladin] Divine Intervention (19753), trigger of (19752)
DELETE FROM spell_script_names WHERE spell_id IN(19753);
INSERT INTO spell_script_names VALUES (19753, 'spell_pal_divine_intervention');
-- [Paladin] Seal of Light
REPLACE INTO spell_proc_event VALUES (20165, 0, 0, 0, 0, 0, 0, 1+2+1024, 10, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(20165);
INSERT INTO spell_script_names VALUES (20165, 'spell_pal_seal_of_light');
-- [Paladin] Seal of Wisdom
REPLACE INTO spell_proc_event VALUES (20166, 0, 0, 0, 0, 0, 0, 1+2+1024, 12, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(20166);
INSERT INTO spell_script_names VALUES (20166, 'spell_pal_seal_of_light'); -- same script, no mistake
-- [Paladin] Sacred Shield
DELETE FROM spell_script_names WHERE spell_id IN(58597, 53601);
INSERT INTO spell_script_names VALUES (53601, 'spell_pal_sacred_shield_base');



-- [Druid] Item - Druid T10 Balance 4P Bonus, Languish
REPLACE INTO spell_proc_event VALUES (70723, 0, 7, 5, 0, 0, 65536, 2, 0, 100, 0);
DELETE FROM spell_script_names WHERE spell_id IN(70723);
INSERT INTO spell_script_names VALUES (70723, 'spell_dru_t10_balance_4p_bonus');
-- [Druid] Nurturing Instinct
DELETE FROM spell_script_names WHERE spell_id IN(-33872, 33872, 33873);
INSERT INTO spell_script_names VALUES (-33872, 'spell_dru_nurturing_instinct');
-- [Druid] Feral Swiftness, add to bear form
DELETE FROM spell_script_names WHERE spell_id IN(-17002, 17002, 24866);
DELETE FROM spell_script_names WHERE ScriptName='spell_dru_feral_swiftness';
INSERT INTO spell_script_names VALUES (-17002, 'spell_dru_feral_swiftness');
INSERT INTO spell_script_names VALUES (5487, 'spell_dru_feral_swiftness');
INSERT INTO spell_script_names VALUES (9634, 'spell_dru_feral_swiftness');
-- [Druid] Omen of Clarity
REPLACE INTO spell_proc_event VALUES (16864, 0, 0, 0, 0, 0, 0, 65536, 3.5, 0, 0);
DELETE FROM spell_script_names WHERE spell_id IN(16864);
INSERT INTO spell_script_names VALUES (16864, 'spell_dru_omen_of_clarity');
-- [Druid] Barkskin
DELETE FROM spell_script_names WHERE spell_id IN(-22812, 22812);
INSERT INTO spell_script_names VALUES (22812, 'spell_dru_barkskin');
-- [Druid] Owlkin Frenzy
DELETE FROM spell_script_names WHERE spell_id IN(-48389, 48389, 48392, 48393);



-- ----------------------------------------------------------------------
--                          SPELL LINKED SPELL
-- ----------------------------------------------------------------------
-- [Item] Nevermelting Ice Crystal
DELETE FROM spell_linked_spell WHERE spell_trigger=-71563;
REPLACE INTO spell_linked_spell VALUES (-71563, -71564, 0, 'Nevermelting Ice Crystal - Remove working trigger');
-- [Item] Electromagnetic Gigaflux Reactivator
DELETE FROM spell_linked_spell WHERE spell_trigger=-11826;
REPLACE INTO spell_linked_spell VALUES (-11826, 11828, 0, 'Electromagnetic Gigaflux Reactivator - Cast Forked Lightning');

-- [Warlock] Immolation Aura
DELETE FROM spell_linked_spell WHERE spell_trigger=-47241;
REPLACE INTO spell_linked_spell VALUES (-47241, -50589, 0, 'Metamorphosis - Remove Immolation Aura');
-- [Warlock] Glyph of Life Tap
DELETE FROM spell_linked_spell WHERE spell_trigger=-63320;
REPLACE INTO spell_linked_spell VALUES (-63320, -63321, 0, 'Glyph of Life Tap - Remove working trigger');

-- [Hunter] Wyvern Sting
DELETE FROM spell_linked_spell WHERE comment='Wyvern Sting';
DELETE FROM spell_linked_spell WHERE spell_effect=60089;

-- [Rogue] Tricks of Trade - remove parent aura
DELETE FROM spell_linked_spell WHERE spell_trigger=59628;
REPLACE INTO spell_linked_spell VALUES (59628, -57934, 0, 'Tricks of Trade - remove at trigger');

-- [Paladin] Repeatance
DELETE FROM spell_linked_spell WHERE spell_trigger=20066;
INSERT INTO spell_linked_spell VALUES (20066, -61840, 1, 'Repentance');

-- [Paladin] Sacred Shield
DELETE FROM spell_linked_spell WHERE spell_trigger=-53601;
INSERT INTO spell_linked_spell VALUES (-53601, -58597, 0, 'Sacred Shield remove');

-- [Death Knight] On a Pale Horse
DELETE FROM spell_linked_spell WHERE spell_trigger IN(51983, 51986, -51983, -51986);
-- [Paladin] Pursuit of Justice
DELETE FROM spell_linked_spell WHERE spell_trigger IN(26022, 26023, -26022, -26023);
INSERT INTO spell_linked_spell VALUES (26022, 61417, 2, 'Pursuit of Justice add');
INSERT INTO spell_linked_spell VALUES (26023, 61418, 2, 'Pursuit of Justice add');
INSERT INTO spell_linked_spell VALUES (-26022, -61417, 0, 'Pursuit of Justice remove');
INSERT INTO spell_linked_spell VALUES (-26023, -61418, 0, 'Pursuit of Justice remove');

-- Passive Threat for tanks
DELETE FROM spell_linked_spell WHERE spell_effect IN(57339, 57340, -57339, -57340);
INSERT INTO spell_linked_spell VALUES (7376, 57339, 2, 'Defensive Stance Passive - Tank Class Passive Threat');
INSERT INTO spell_linked_spell VALUES (21178, 57339, 2, 'Bear Form (Passive2) - Tank Class Passive Threat');
INSERT INTO spell_linked_spell VALUES (25780, 57340, 2, 'Righteous Fury - Tank Class Passive Threat');
INSERT INTO spell_linked_spell VALUES (48263, 57340, 2, 'Frost Presence - Tank Class Passive Threat');
INSERT INTO spell_linked_spell VALUES (-7376, -57339, 0, 'Defensive Stance Passive - Tank Class Passive Threat Remove');
INSERT INTO spell_linked_spell VALUES (-21178, -57339, 0, 'Bear Form (Passive2) - Tank Class Passive Threat Remove');
INSERT INTO spell_linked_spell VALUES (-25780, -57340, 0, 'Righteous Fury - Tank Class Passive Threat Remove');
INSERT INTO spell_linked_spell VALUES (-48263, -57340, 0, 'Frost Presence - Tank Class Passive Threat Remove');


-- ----------------------------------------------------------------------
--                          LoS Fixes
-- ----------------------------------------------------------------------
-- [Warlock] Nightmare, Improved Fear
DELETE FROM disables WHERE entry IN(60946, 60947) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 60946, 64, '', '', 'Disable LOS for Nightmare');
INSERT INTO disables VALUES (0, 60947, 64, '', '', 'Disable LOS for Nightmare');


-- [Druid] Revitalize
DELETE FROM disables WHERE entry IN(48540, 48541, 48542, 48543) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 48540, 64, '', '', 'Disable LOS for Revitalize');
INSERT INTO disables VALUES (0, 48541, 64, '', '', 'Disable LOS for Revitalize');
INSERT INTO disables VALUES (0, 48542, 64, '', '', 'Disable LOS for Revitalize');
INSERT INTO disables VALUES (0, 48543, 64, '', '', 'Disable LOS for Revitalize');


-- [Hunter] Roar of Recovery
-- [Hunter] Bestial Wrath
-- [Hunter] Heart of the Phoenix
DELETE FROM disables WHERE entry IN(53517, 19574, 54114) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 53517, 64, '', '', 'Disable LOS for Roar of Recovery');
INSERT INTO disables VALUES (0, 19574, 64, '', '', 'Disable LOS for Bestial Wrath');
INSERT INTO disables VALUES (0, 54114, 64, '', '', 'Disable LOS for Heart of the Phoenix');


-- [Death Knight] Frost Fever
DELETE FROM disables WHERE entry IN(55095) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 55095, 64, '', '', 'Disable LOS for Frost Fever');
-- [Death Knight] Raise Dead
DELETE FROM disables WHERE entry IN(46585, 52150) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 46585, 64, '', '', 'Disable LOS for Raise Dead Guardian');
INSERT INTO disables VALUES (0, 52150, 64, '', '', 'Disable LOS for Raise Dead Pet');


-- [Shaman] Tremor Totem effect
DELETE FROM disables WHERE entry IN(8146) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 8146, 64, '', '', 'Disable LOS for Tremor Totem effect');


-- [Priest] Shadow Fiend - Mana Leech proc
DELETE FROM disables WHERE entry IN(34650) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 34650, 64, '', '', 'Disable LOS for Shadow Fiend - Mana Leech proc');
-- [Priest] Improved Devouring Plague
DELETE FROM disables WHERE entry IN(63675) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 63675, 64, '', '', 'Disable LOS for Improved Devouring Plague');


-- [General] Ritual of Summoning
DELETE FROM disables WHERE entry IN(7720) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 7720, 64, '', '', 'Disable LOS for Ritual of Summoning');
-- [General] Temporary LoS fix EoE (for phase 3, some spells have this attribute added below)
DELETE FROM disables WHERE entry IN(56091, 56092, 57090, 57108, 57092) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 56091, 64, '', '', 'Disable LOS for EoE');
INSERT INTO disables VALUES (0, 56092, 64, '', '', 'Disable LOS for EoE');
INSERT INTO disables VALUES (0, 57090, 64, '', '', 'Disable LOS for EoE');
INSERT INTO disables VALUES (0, 57108, 64, '', '', 'Disable LOS for EoE');
INSERT INTO disables VALUES (0, 57092, 64, '', '', 'Disable LOS for EoE');
-- [General] Thorim, Charged Obr damage
DELETE FROM disables WHERE entry IN(62017) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 62017, 64, '', '', 'Disable LOS for Thorim');
DELETE FROM disables WHERE entry IN(64098) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 64098, 64, '', '', 'Disable LOS for Thorim');
-- [General] Quest Little Morsels (9440)
DELETE FROM disables WHERE entry IN(29916, 29917) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 29916, 64, '', '', 'Disable LOS for Quest Little Morsels (9440)');
INSERT INTO disables VALUES (0, 29917, 64, '', '', 'Disable LOS for Quest Little Morsels (9440)');
-- [General] Dark Energy, Sunken Temple (18948)
-- [General] Flame of Hakkar, Sunken Temple (12354)
-- [General] Atal'ai Poison, Sunken Temple (18949)
DELETE FROM disables WHERE entry IN(18948, 12354, 18949) AND sourceType=0 AND flags=64;
INSERT INTO disables VALUES (0, 18948, 64, '', '', 'Disable LOS for Dark Energy, Sunken Temple');
INSERT INTO disables VALUES (0, 12354, 64, '', '', 'Disable LOS for Flame of Hakkar, Sunken Temple');
INSERT INTO disables VALUES (0, 18949, 64, '', '', 'Disable LOS for Atal''ai Poison, Sunken Temple');




-- ----------------------------------------------------------------------
--                          THREAT & RANK FIXES
-- ----------------------------------------------------------------------
-- Totem of Wrath spell bonus, fix ranks
REPLACE INTO spell_ranks VALUES (57658, 57658, 1),(57658, 57660, 2),(57658, 57662, 3),(57658, 57663, 4);
-- Ferocious Inspiration trigger, fix ranks
REPLACE INTO spell_ranks VALUES (75593, 75593, 1),(75593, 75446, 2),(75593, 75447, 3);
-- Crypt Fever - fix ranks
REPLACE INTO spell_ranks VALUES (50508, 50508, 1),(50508, 50509, 2),(50508, 50510, 3);
-- Ebon Plague - fix ranks
REPLACE INTO spell_ranks VALUES (51726, 51726, 1),(51726, 51734, 2),(51726, 51735, 3);
-- Earth and Moon - fix ranks
REPLACE INTO spell_ranks VALUES (60431, 60431, 1),(60431, 60432, 2),(60431, 60433, 3);
-- Wrecking Crew - Enrage
REPLACE INTO spell_ranks VALUES (57518, 57518, 1),(57518, 57519, 2),(57518, 57520, 3), (57518, 57521, 4),(57518, 57522, 5);
-- Enrage - Enrage
REPLACE INTO spell_ranks VALUES (12880, 12880, 1),(12880, 14201, 2),(12880, 14202, 3), (12880, 14203, 4),(12880, 14204, 5);

-- [Shaman] Magma totem generates no threat
REPLACE INTO spell_threat VALUES (8187, 0, 0, 0);

-- [Death Knight] Icy touch threat generated
DELETE FROM spell_threat WHERE entry=45477;
-- [Death Knight] Death and Decay
DELETE FROM spell_threat WHERE entry IN(52212, 43265, 49936, 49937, 49938);
INSERT INTO spell_threat VALUES (52212, 0, 1.9, 0);



-- ----------------------------------------------------------------------
--                              MIXOLOGY
-- ----------------------------------------------------------------------
DROP TABLE IF EXISTS `spell_mixology`;
CREATE TABLE `spell_mixology` (
  `entry` mediumint(8) unsigned NOT NULL,
  `pctMod` float NOT NULL DEFAULT '30' COMMENT 'bonus multiplier',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;
INSERT INTO `spell_mixology` VALUES ('53752', '80');
INSERT INTO `spell_mixology` VALUES ('54212', '44.4');
INSERT INTO `spell_mixology` VALUES ('53760', '44.4');
INSERT INTO `spell_mixology` VALUES ('53758', '50');
INSERT INTO `spell_mixology` VALUES ('53755', '37.6');
INSERT INTO `spell_mixology` VALUES ('62380', '80');
INSERT INTO `spell_mixology` VALUES ('53764', '33.3');
INSERT INTO `spell_mixology` VALUES ('53751', '57');
INSERT INTO `spell_mixology` VALUES ('53748', '40');
INSERT INTO `spell_mixology` VALUES ('33721', '40');
INSERT INTO `spell_mixology` VALUES ('53749', '40');
INSERT INTO `spell_mixology` VALUES ('53763', '35');
INSERT INTO `spell_mixology` VALUES ('53746', '44.4');
INSERT INTO `spell_mixology` VALUES ('60340', '44.4');
INSERT INTO `spell_mixology` VALUES ('60347', '44.4');
INSERT INTO `spell_mixology` VALUES ('60345', '44.4');
INSERT INTO `spell_mixology` VALUES ('60344', '44.4');
INSERT INTO `spell_mixology` VALUES ('60341', '44.4');
INSERT INTO `spell_mixology` VALUES ('60343', '44.4');
INSERT INTO `spell_mixology` VALUES ('60346', '44.4');
INSERT INTO `spell_mixology` VALUES ('28497', '44.4');



-- ----------------------------------------------------------------------
--                               MISC
-- ----------------------------------------------------------------------

-- Pet Scaling
-- [Shared] Hit / Expertise scalling
DELETE FROM spell_linked_spell WHERE spell_trigger IN(61013, 61017, -61013, -61017) OR spell_effect IN(61013, 61017, -61013, -61017);
DELETE FROM spell_scripts WHERE id IN(61013, 61017, -61013, -61017);
DELETE FROM spell_script_names WHERE spell_id IN(61013, 61017, -61013, -61017);
INSERT INTO spell_script_names VALUES (61013, 'spell_pet_hit_expertise_scalling');
INSERT INTO spell_script_names VALUES (61017, 'spell_pet_hit_expertise_scalling');
-- [Hunter] Generic
DELETE FROM spell_linked_spell WHERE spell_trigger IN(34902, 34903, 34904, -34902, -34903, -34904) OR spell_effect IN(34902, 34903, 34904, -34902, -34903, -34904);
DELETE FROM spell_scripts WHERE id IN(34902, 34903, 34904, -34902, -34903, -34904);
DELETE FROM spell_script_names WHERE spell_id IN(34902, 34903, 34904, -34902, -34903, -34904);
INSERT INTO spell_script_names VALUES (34902, 'spell_hun_generic_scaling');
INSERT INTO spell_script_names VALUES (34903, 'spell_hun_generic_scaling');
INSERT INTO spell_script_names VALUES (34904, 'spell_hun_generic_scaling');
-- [Warlock] Generic
DELETE FROM spell_linked_spell WHERE spell_trigger IN(34947, 34956, 34957, 34958, -34947, -34956, -34957, -34958) OR spell_effect IN(34947, 34956, 34957, 34958, -34947, -34956, -34957, -34958);
DELETE FROM spell_scripts WHERE id IN(34947, 34956, 34957, 34958, -34947, -34956, -34957, -34958);
DELETE FROM spell_script_names WHERE spell_id IN(34947, 34956, 34957, 34958, -34947, -34956, -34957, -34958);
INSERT INTO spell_script_names VALUES (34947, 'spell_warl_generic_scaling');
INSERT INTO spell_script_names VALUES (34956, 'spell_warl_generic_scaling');
INSERT INTO spell_script_names VALUES (34957, 'spell_warl_generic_scaling');
INSERT INTO spell_script_names VALUES (34958, 'spell_warl_generic_scaling');
-- [Warlock] Infernal
DELETE FROM spell_linked_spell WHERE spell_trigger IN(36186, 36188, 36189, 36190, -36186, -36188, -36189, -36190) OR spell_effect IN(36186, 36188, 36189, 36190, -36186, -36188, -36189, -36190);
DELETE FROM spell_scripts WHERE id IN(36186, 36188, 36189, 36190, -36186, -36188, -36189, -36190);
DELETE FROM spell_script_names WHERE spell_id IN(36186, 36188, 36189, 36190, -36186, -36188, -36189, -36190);
INSERT INTO spell_script_names VALUES (36186, 'spell_warl_infernal_scaling');
INSERT INTO spell_script_names VALUES (36188, 'spell_warl_infernal_scaling');
INSERT INTO spell_script_names VALUES (36189, 'spell_warl_infernal_scaling');
INSERT INTO spell_script_names VALUES (36190, 'spell_warl_infernal_scaling');
-- [Shaman] Feral Spirit
DELETE FROM spell_linked_spell WHERE spell_trigger IN(35674, 35675, 35676, 61783, -35674, -35675, -35676, -61783) OR spell_effect IN(35674, 35675, 35676, 61783, -35674, -35675, -35676, -61783);
DELETE FROM spell_scripts WHERE id IN(35674, 35675, 35676, 61783, -35674, -35675, -35676, -61783);
DELETE FROM spell_script_names WHERE spell_id IN(35674, 35675, 35676, 61783, -35674, -35675, -35676, -61783);
INSERT INTO spell_script_names VALUES (35674, 'spell_sha_feral_spirit_scaling');
INSERT INTO spell_script_names VALUES (35675, 'spell_sha_feral_spirit_scaling');
INSERT INTO spell_script_names VALUES (35676, 'spell_sha_feral_spirit_scaling');
INSERT INTO spell_script_names VALUES (61783, 'spell_sha_feral_spirit_scaling');
-- [Shaman] Fire Elemental Totem
DELETE FROM spell_linked_spell WHERE spell_trigger IN(35665, 35666, 35667, 35668, -35665, -35666, -35667, -35668) OR spell_effect IN(35665, 35666, 35667, 35668, -35665, -35666, -35667, -35668);
DELETE FROM spell_scripts WHERE id IN(35665, 35666, 35667, 35668, -35665, -35666, -35667, -35668);
DELETE FROM spell_script_names WHERE spell_id IN(35665, 35666, 35667, 35668, -35665, -35666, -35667, -35668);
INSERT INTO spell_script_names VALUES (35665, 'spell_sha_fire_elemental_scaling');
INSERT INTO spell_script_names VALUES (35666, 'spell_sha_fire_elemental_scaling');
INSERT INTO spell_script_names VALUES (35667, 'spell_sha_fire_elemental_scaling');
INSERT INTO spell_script_names VALUES (35668, 'spell_sha_fire_elemental_scaling');
-- [Shaman] Earth Elemental Totem
DELETE FROM spell_linked_spell WHERE spell_trigger IN(65225, 65226, 65227, 65228, -65225, -65226, -65227, -65228) OR spell_effect IN(65225, 65226, 65227, 65228, -65225, -65226, -65227, -65228);
DELETE FROM spell_scripts WHERE id IN(65225, 65226, 65227, 65228, -65225, -65226, -65227, -65228);
DELETE FROM spell_script_names WHERE spell_id IN(65225, 65226, 65227, 65228, -65225, -65226, -65227, -65228);
INSERT INTO spell_script_names VALUES (65225, 'spell_sha_fire_elemental_scaling'); -- can be the same
INSERT INTO spell_script_names VALUES (65226, 'spell_sha_fire_elemental_scaling'); -- can be the same
INSERT INTO spell_script_names VALUES (65227, 'spell_sha_fire_elemental_scaling'); -- can be the same
INSERT INTO spell_script_names VALUES (65228, 'spell_sha_fire_elemental_scaling'); -- can be the same
-- [Priest] Shadowfiend
DELETE FROM spell_linked_spell WHERE spell_trigger IN(35661, 35662, 35663, 35664, -35661, -35662, -35663, -35664) OR spell_effect IN(35661, 35662, 35663, 35664, -35661, -35662, -35663, -35664);
DELETE FROM spell_scripts WHERE id IN(35661, 35662, 35663, 35664, -35661, -35662, -35663, -35664);
DELETE FROM spell_script_names WHERE spell_id IN(35661, 35662, 35663, 35664, -35661, -35662, -35663, -35664);
INSERT INTO spell_script_names VALUES (35661, 'spell_pri_shadowfiend_scaling');
INSERT INTO spell_script_names VALUES (35662, 'spell_pri_shadowfiend_scaling');
INSERT INTO spell_script_names VALUES (35663, 'spell_pri_shadowfiend_scaling');
INSERT INTO spell_script_names VALUES (35664, 'spell_pri_shadowfiend_scaling');
-- [Druid] Force of Nature (Treants)
DELETE FROM spell_linked_spell WHERE spell_trigger IN(35669, 35670, 35671, 35672, -35669, -35670, -35671, -35672) OR spell_effect IN(35669, 35670, 35671, 35672, -35669, -35670, -35671, -35672);
DELETE FROM spell_scripts WHERE id IN(35669, 35670, 35671, 35672, -35669, -35670, -35671, -35672);
DELETE FROM spell_script_names WHERE spell_id IN(35669, 35670, 35671, 35672, -35669, -35670, -35671, -35672);
INSERT INTO spell_script_names VALUES (35669, 'spell_dru_treant_scaling');
INSERT INTO spell_script_names VALUES (35670, 'spell_dru_treant_scaling');
INSERT INTO spell_script_names VALUES (35671, 'spell_dru_treant_scaling');
INSERT INTO spell_script_names VALUES (35672, 'spell_dru_treant_scaling');
-- [Mage] Mirror Image / Water Elemental
DELETE FROM spell_linked_spell WHERE spell_trigger IN(35657, 35658, 35659, 35660, -35657, -35658, -35659, -35660) OR spell_effect IN(35657, 35658, 35659, 35660, -35657, -35658, -35659, -35660);
DELETE FROM spell_scripts WHERE id IN(35657, 35658, 35659, 35660, -35657, -35658, -35659, -35660);
DELETE FROM spell_script_names WHERE spell_id IN(35657, 35658, 35659, 35660, -35657, -35658, -35659, -35660);
INSERT INTO spell_script_names VALUES (35657, 'spell_mage_pet_scaling');
INSERT INTO spell_script_names VALUES (35658, 'spell_mage_pet_scaling');
INSERT INTO spell_script_names VALUES (35659, 'spell_mage_pet_scaling');
INSERT INTO spell_script_names VALUES (35660, 'spell_mage_pet_scaling');
-- [Death Knight] Ghoul / Ebon Gargoyle / Army of the Dead
DELETE FROM spell_linked_spell WHERE spell_trigger IN(51996, 54566, 61697, -51996, -54566, -61697) OR spell_effect IN(51996, 54566, 61697, -51996, -54566, -61697);
DELETE FROM spell_scripts WHERE id IN(51996, 54566, 61697, -51996, -54566, -61697);
DELETE FROM spell_script_names WHERE spell_id IN(51996, 54566, 61697, -51996, -54566, -61697);
INSERT INTO spell_script_names VALUES (51996, 'spell_dk_pet_scaling');
INSERT INTO spell_script_names VALUES (54566, 'spell_dk_pet_scaling');
INSERT INTO spell_script_names VALUES (61697, 'spell_dk_pet_scaling');




-- [Druid] Force of Nature
REPLACE INTO creature_template_addon VALUES (1964, 0, 0, 0, 4097, 0, '50419');
DELETE FROM spell_script_names WHERE spell_id IN(50419);
INSERT INTO spell_script_names VALUES (50419, 'spell_dru_brambles_treant');


-- [Priest] Shadowfiend
UPDATE creature_template SET resistance1=0, resistance2=0, resistance3=0, resistance4=0, resistance5=0, resistance6=0 WHERE entry=19668;


-- [Hunter] Snake Trap
UPDATE creature_template SET mindmg = 38, maxdmg = 53 WHERE entry = 19921;
UPDATE creature_template SET mindmg = 16, maxdmg = 24 WHERE entry = 19833;


-- [Death Knight] Remove Ghouls at despawn (cooldown disabled while active...)
REPLACE INTO creature_template_addon VALUES (26125, 0, 0, 0, 0, 0, '');
REPLACE INTO creature_template_addon VALUES (30230, 0, 0, 0, 0, 0, '');
UPDATE creature_template SET mindmg=87, maxdmg=87, unit_class=4, spell1=47468, spell2=47484, spell3=47481, spell4=47482, ScriptName='npc_pet_dk_ghoul' WHERE entry=26125;
UPDATE creature_template SET mindmg=87, maxdmg=87, unit_class=4, spell1=47468, spell2=47484, spell3=47481, spell4=47482, spell5=51874, ScriptName='' WHERE entry=30230;
-- [Death Knight] Dancing Rune Weapon
REPLACE INTO spell_proc_event VALUES (49028, 0, 0, 0, 0, 0, 0, 65536, 0, 0, 0);
REPLACE INTO creature_template_addon VALUES (27893, 0, 0, 0, 0, 0, '53160');
UPDATE creature_template SET unit_flags=33554434, flags_extra=128, AIName='', ScriptName='npc_pet_dk_dancing_rune_weapon' WHERE entry=27893;
DELETE FROM spell_script_names WHERE spell_id IN(49028, 53160);
INSERT INTO spell_script_names VALUES (49028, 'spell_dk_dancing_rune_weapon');
INSERT INTO spell_script_names VALUES (53160, 'spell_dk_dancing_rune_weapon_visual');


-- [Death Knight] Bloodworms
REPLACE INTO creature_template_addon VALUES (28017, 0, 0, 0, 4097, 0, '50453 65221');
-- [Death Knight] Ebon Gargoyle
REPLACE INTO creature_template_addon VALUES (27829, 0, 0, 0, 0, 0, '65221 62137');
-- [Death Knight] Rune Strike proc
REPLACE INTO spell_proc_event VALUES (56817, 0, 15, 0, 536870912, 0, 0, 0, 0, 0, 0);
UPDATE spell_dbc SET EffectSpellClassMaskA2=536870912 WHERE Id=56817;
-- [Death Knight] Death and Decay
DELETE FROM spell_script_names WHERE spell_id IN(-43265, 52212);
INSERT INTO spell_script_names VALUES (-43265, 'spell_dk_death_and_decay');
INSERT INTO spell_script_names VALUES (52212, 'spell_dk_death_and_decay');
-- [Death Knight]
DELETE FROM playercreateinfo_spell WHERE spell=3275;


-- [Warlock] Eye of Kilrogg
UPDATE creature_template SET unit_flags=unit_flags|131072, mindmg=0, maxdmg=0, attackpower=0, Health_mod=0.1 WHERE entry=4277;
-- [Warlock] Infernal
REPLACE INTO creature_template_addon VALUES (89, 0, 0, 0, 4097, 0, '7942 4525 19483');
UPDATE creature_template SET exp=2, speed_walk=1, speed_run=1.14286 WHERE entry=89;


-- [Rogue] Master Poisoner - crit chance
REPLACE INTO spell_proc_event VALUES (58410, 0, 0, 0, 0, 0, 0, 1+2+65536, 0, 0, 0);


-- [Mage] Summon Water Elemental (perm)
UPDATE creature_template SET faction=35, exp=0, unit_class=8, unit_flags=0, spell1=31707, spell2=33395, MovementType=1 WHERE entry=510;
UPDATE creature_template SET faction=35, exp=0, unit_class=8, unit_flags=0, spell1=72898, spell2=0, MovementType=1 WHERE entry=37994;
-- [Mage] Mirror Image
UPDATE creature_template SET Health_mod=0.4, unit_class=8 WHERE entry=31216;
DELETE FROM spell_script_names WHERE spell_id IN(55342);
INSERT INTO spell_script_names VALUES (55342, 'spell_mage_mirror_image');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58836;
INSERT INTO conditions VALUES (13, 1, 58836, 0, 0, 31, 0, 3, 31216, 0, 0, 0, 0, '', 'Target Mirror Images');
INSERT INTO conditions VALUES (13, 1, 58836, 0, 0, 33, 0, 1, 3, 0, 0, 0, 0, '', 'Owned by caster');


-- [Optimization] Wintergarde Invisibility
DELETE FROM spell_linked_spell WHERE spell_effect IN(48357, -48357);
DELETE FROM spell_area WHERE spell=48358;


-- [Generic] Argent Pony Bridle
UPDATE creature_template SET npcflag=1+128, ScriptName='npc_pet_gen_argent_pony_bridle' WHERE entry IN(33238, 33239);
-- [Generic] Freeze Fix
DELETE FROM spell_linked_spell WHERE spell_trigger IN(53355, 53371);
INSERT INTO spell_linked_spell VALUES (53355, -53371, 1, 'Freeze fix');
INSERT INTO spell_linked_spell VALUES (53371, -53355, 1, 'Freeze fix');
-- [Generic] Nitro Boosts
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=55004;
INSERT INTO conditions VALUES (17, 0, 55004, 0, 0, 7, 0, 202, 405, 0, 0, 0, 0, '', 'Nitro Boosts requires 405 Engineering skill');
-- [Generic] Magnificent Flying Carpet
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=61309;
INSERT INTO conditions VALUES (17, 0, 61309, 0, 0, 7, 0, 197, 425, 0, 0, 0, 0, '', 'Magnificent Flying Carpet requires 425 Tailoring skill');
-- [Generic] Hand-Mounted Pyro Rocket
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=54757;
INSERT INTO conditions VALUES (17, 0, 54757, 0, 0, 7, 0, 202, 400, 0, 0, 0, 0, '', 'Pyro Rocket requires 400 Engineering skill');
-- [Generic] Frag Belt
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=67890;
INSERT INTO conditions VALUES (17, 0, 67890, 0, 0, 7, 0, 202, 380, 0, 0, 0, 0, '', 'Frag Belt (Cobalt Frag Bomb) requires 380 Engineering skill');
-- [Generic] Flexweave Underlay
DELETE FROM conditions WHERE SourceTypeOrReferenceId=17 AND SourceEntry=55001;
INSERT INTO conditions VALUES (17, 0, 55001, 0, 0, 7, 0, 202, 350, 0, 0, 0, 0, '', 'Flexweave Underlay (Parachute) requires 350 Engineering skill');


-- [Generic] Summoning
UPDATE gameobject_template SET data2=32783, data3=0 WHERE entry IN(36727, 179944);


-- pussywizard: encounter credit spells
-- pussywizard: remove spellscript spell_gen_dungeon_credit (done in spell::finish)
DELETE FROM spell_script_names WHERE ScriptName='spell_gen_dungeon_credit';
-- ensure all entries in spell_dbc / conditions have proper data
UPDATE spell_dbc SET Attributes=Attributes|(0x00800180), AttributesEx2=AttributesEx2|(0x5), AttributesEx3=AttributesEx3|(0x40100), AttributesEx6=AttributesEx6|(0x1000000), Targets=0, CastingTimeIndex=1, Effect1=3, Effect2=0, Effect3=0, EffectImplicitTargetA1=22, EffectImplicitTargetB1=7, EffectRadiusIndex1=28, MaxAffectedTargets=0 WHERE Id IN(58630, 59046, 59450, 61863, 64899, 64985, 65074, 65184, 65195, 68184, 68572, 68574, 68575, 68663, 72706, 72830, 72959);
UPDATE spell_dbc SET `comment`='Mal\'ganis - credit marker' WHERE Id=58630;
UPDATE spell_dbc SET `comment`='Tribunal of Ages - credit marker' WHERE Id=59046;
UPDATE spell_dbc SET `comment`='The Four Horsemen - credit marker' WHERE Id=59450;
UPDATE spell_dbc SET `comment`='The Prophet Tharon\'ja - credit marker' WHERE Id=61863;
UPDATE spell_dbc SET `comment`='Hodir - credit marker' WHERE Id=64899;
UPDATE spell_dbc SET `comment`='Thorim - credit marker' WHERE Id=64985;
UPDATE spell_dbc SET `comment`='Freya - credit marker' WHERE Id=65074;
UPDATE spell_dbc SET `comment`='Algalon the Observer - credit marker' WHERE Id=65184;
UPDATE spell_dbc SET `comment`='The Iron Council - credit marker' WHERE Id=65195;
UPDATE spell_dbc SET `comment`='Faction Champions - credit marker' WHERE Id=68184;
UPDATE spell_dbc SET `comment`='Grand Champions - credit marker' WHERE Id=68572;
UPDATE spell_dbc SET `comment`='Argent Champion - credit marker' WHERE Id=68574;
UPDATE spell_dbc SET `comment`='Argent Champion - credit marker' WHERE Id=68575;
UPDATE spell_dbc SET `comment`='The Black Knight - credit marker' WHERE Id=68663;
UPDATE spell_dbc SET `comment`='Valithria Dreamwalker - credit marker' WHERE Id=72706;
UPDATE spell_dbc SET `comment`='Escaped from Arthas - credit marker' WHERE Id=72830;
UPDATE spell_dbc SET `comment`='Icecrown Gunship Battle - credit marker' WHERE Id=72959;
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(58630, 59046, 59450, 61863, 64899, 64985, 65074, 65184, 65195, 68184, 68572, 68574, 68575, 68663, 72706, 72830, 72959);
INSERT INTO conditions VALUES
(13, 1, 58630, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Mal\'ganis - credit marker'),
(13, 1, 59046, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Tribunal of Ages - credit marker'),
(13, 1, 59450, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'The Four Horsemen - credit marker'),
(13, 1, 61863, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'The Prophet Tharon\'ja - credit marker'),
(13, 1, 64899, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Hodir - credit marker'),
(13, 1, 64985, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Thorim - credit marker'),
(13, 1, 65074, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Freya - credit marker'),
(13, 1, 65184, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Algalon the Observer - credit marker'),
(13, 1, 65195, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'The Iron Council - credit marker'),
(13, 1, 68184, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Faction Champions - credit marker'),
(13, 1, 68572, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Grand Champions - credit marker'),
(13, 1, 68574, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Argent Champion - credit marker'),
(13, 1, 68575, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Argent Champion - credit marker'),
(13, 1, 68663, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'The Black Knight - credit marker'),
(13, 1, 72706, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Valithria Dreamwalker - credit marker'),
(13, 1, 72830, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Escaped from Arthas - credit marker'),
(13, 1, 72959, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Icecrown Gunship Battle - credit marker');



-- [Item] Bryntroll (50415) (50709)
UPDATE item_template SET spellppmRate_1=2, spellcooldown_1=500 WHERE entry IN(50415, 50709); -- 500ms cooldown just in case
-- [Item] Nibelung (49992) (50648)
DELETE FROM smart_scripts WHERE entryorguid IN(38391, 38392) AND source_type=0;
UPDATE creature_template SET spell1=71841, AIName='', InhabitType=5, ScriptName='npc_pet_gen_valkyr_guardian' WHERE entry=38391;
UPDATE creature_template SET spell1=71842, AIName='', InhabitType=5, ScriptName='npc_pet_gen_valkyr_guardian' WHERE entry=38392;
DELETE FROM spell_script_names WHERE spell_id IN(71841, 71842);
INSERT INTO spell_script_names VALUES (71841, 'spell_pet_gen_valkyr_guardian_smite');
INSERT INTO spell_script_names VALUES (71842, 'spell_pet_gen_valkyr_guardian_smite');
-- [Item] The Flag of Ownership
DELETE FROM spell_linked_spell WHERE spell_trigger IN(51640,-51640,51702,-51702,52605,-52605,51657,-51657) OR spell_effect IN(51640,-51640,51702,-51702,52605,-52605,51657,-51657);
DELETE FROM spell_script_names WHERE spell_id IN(51640,-51640,51702,-51702,52605,-52605,51657,-51657);
DELETE FROM spell_scripts WHERE id IN(51640,-51640,51702,-51702,52605,-52605,51657,-51657);
INSERT INTO spell_script_names VALUES (51640, 'spell_the_flag_of_ownership');
-- [Item] Mooncloth Tailoring
DELETE FROM skill_extra_item_template WHERE requiredSpecialization=26798;
INSERT INTO skill_extra_item_template VALUES (18560, 26798, 100, 1),(26751, 26798, 100, 1),(56001, 26798, 100, 1);
-- [Item] Teleport Underground (wormhole)
DELETE FROM spell_target_position WHERE id=68081;
INSERT INTO spell_target_position VALUES (68081, 0, 571, 5860.42, 517.54, 599.82, 3.45);
-- [Item] Solace of the Fallen (47271) (47432)
-- [Item] Solace of the Defeated (47041) (47059)
DELETE FROM spell_script_names WHERE spell_id IN(67698, 67752);
INSERT INTO spell_script_names VALUES (67698, 'spell_gen_allow_proc_from_spells_with_cost');
INSERT INTO spell_script_names VALUES (67752, 'spell_gen_allow_proc_from_spells_with_cost');
REPLACE INTO spell_proc_event VALUES (67698, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0); -- hit + crit, anything different than 0
REPLACE INTO spell_proc_event VALUES (67752, 0, 0, 0, 0, 0, 87040, 3, 0, 0, 0); -- hit + crit, anything different than 0


-- [Enchant] Rune of the Fallen Crusader (53344)
UPDATE spell_enchant_proc_data SET PPMChance=2 WHERE entry=3368;
DELETE FROM spell_script_names WHERE spell_id IN(-53365, 53365);
INSERT INTO spell_script_names VALUES (53365, 'spell_dk_rune_of_the_fallen_crusader');


-- [Night elf] Elusiveness
DELETE FROM playercreateinfo_spell WHERE spell=21009;
INSERT INTO playercreateinfo_spell VALUES (8, 1085, 21009, 'Elusiveness');
