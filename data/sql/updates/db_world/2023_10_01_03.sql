-- DB update 2023_10_01_02 -> 2023_10_01_03
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (21218, 21220, 21221, 21224, 21225, 21226, 21228, 21229, 21230, 21231, 21232, 21251, 21263, 21298, 21299, 21301, 21339, 21806, 21863, 21865, 21873, 21920, 22009, 22055, 22056, 22250) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21218, 0, 0, 0, 0, 0, 100, 0, 16300, 19300, 10090, 19400, 0, 0, 11, 38572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - In Combat - Cast Mortal Cleave'),-- fully sniffed
(21218, 0, 1, 0, 105, 0, 100, 0, 15750, 16850, 15750, 16850, 0, 5, 11, 38576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Victim Casting - Cast Knockback'),-- fully sniffed
(21218, 0, 2, 3, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 38947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Between Health 0-50% - Cast Frenzy'),-- fully sniffed
(21218, 0, 3, 0, 61, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Between Health 0-50% - Talk'),
(21218, 0, 4, 0, 12, 0, 100, 0, 0, 20, 15000, 15000, 0, 0, 11, 38959, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vashj\'ir Honor Guard - Target Health 0-20% - Cast Execute'),-- not sniffed thus unchanged
(21220, 0, 0, 0, 0, 0, 100, 0, 4800, 6900, 3650, 14750, 0, 0, 11, 38582, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Smite'),-- fully sniffed
(21220, 0, 1, 0, 0, 0, 100, 0, 6050, 12850, 6050, 17050, 0, 0, 11, 38585, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - In Combat - Cast Holy Fire'),-- fully sniffed
(21220, 0, 2, 0, 14, 0, 100, 0, 25000, 35, 8500, 16100, 0, 0, 11, 38580, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - Friendly Missing Health - Cast Greater Heal'),-- fully sniffed
(21220, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Priestess - On Aggro - Call For Help'),
(21221, 0, 0, 0, 0, 0, 100, 0, 0, 2000, 2000, 2000, 0, 0, 11, 38904, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Throw'),-- not sniffed thus unchanged
(21221, 0, 1, 0, 0, 0, 100, 0, 6050, 10850, 6050, 12950, 0, 0, 11, 38474, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Cleave'),-- fully sniffed
(21221, 0, 2, 0, 0, 0, 100, 0, 6050, 7250, 15800, 19200, 0, 0, 11, 38484, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Beast-Tamer - In Combat - Cast Bestial Wrath'),-- fully sniffed
(21224, 0, 0, 0, 14, 0, 100, 0, 8000, 40, 8000, 10000, 0, 0, 11, 38658, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - Friendly Missing Health - Cast Healing Touch'),-- not sniffed thus unchanged
(21224, 0, 1, 0, 16, 1, 100, 0, 38657, 40, 7000, 10000, 0, 0, 11, 38657, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - Friendly Missing Buff - Cast Rejuvenation'),-- not sniffed thus unchanged
(21224, 0, 2, 0, 0, 0, 100, 0, 8450, 8450, 25000, 35000, 0, 0, 11, 38659, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - In Combat - Cast Tranquility'),-- repeat timer not sniffed
(21224, 0, 3, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Depth-Seer - On Aggro - Set Event Phase'),
(21225, 0, 0, 0, 0, 0, 100, 0, 8650, 8850, 18000, 25000, 0, 0, 11, 39070, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Bloodthirst'),-- repeat timer not sniffed
(21225, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 25000, 30000, 0, 0, 11, 38664, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Enrage'),-- not sniffed thus unchanged
(21225, 0, 2, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 0, 0, 11, 39069, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Warrior - In Combat - Cast Uppercut'),-- not sniffed thus unchanged
(21226, 0, 0, 0, 0, 0, 100, 0, 7250, 8850, 3000, 4000, 0, 0, 11, 39065, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Lightning Bolt'),-- repeat timer not sniffed
(21226, 0, 1, 0, 0, 0, 100, 0, 0, 0, 60000, 60000, 0, 0, 11, 39067, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Lightning Shield'),-- not sniffed thus unchanged
(21226, 0, 2, 0, 0, 0, 100, 0, 3000, 10000, 10000, 15000, 0, 0, 11, 39066, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Shaman - In Combat - Cast Chain Lightning'),-- not sniffed thus unchanged
(21228, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2200, 0, 0, 11, 39064, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - In Combat - Cast FrostBolt'),-- not sniffed correctly thus unchanged
(21228, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 0, 11, 39062, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - In Combat - Cast Frost Shock'),-- not sniffed thus unchanged
(21228, 0, 2, 0, 106, 0, 100, 0, 10000, 15000, 10000, 15000, 0, 10, 11, 39063, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Hydromancer - Within Range 0-10yd - Cast Frost Nova'),-- not sniffed correctly thus unchanged
(21229, 0, 0, 0, 0, 0, 100, 0, 10900, 21200, 120000, 120000, 0, 0, 11, 39027, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Poison Shield'),-- repeat unchanged due to logical timer
(21229, 0, 1, 0, 0, 0, 100, 0, 5200, 11900, 35150, 35150, 0, 0, 11, 38624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Water Elemental Totem'),
(21230, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 30, 1, 2, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - On Aggro - Set Event Phase Random'),
(21230, 0, 1, 0, 0, 1, 100, 0, 1550, 9550, 2400, 8700, 0, 0, 11, 38641, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Fireball'),-- fully sniffed
(21230, 0, 2, 0, 0, 1, 100, 0, 1200, 2000, 60000, 60000, 0, 0, 11, 38648, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Fire Destruction'),-- repeat timer not sniffed
(21230, 0, 3, 0, 0, 1, 100, 0, 12100, 22000, 10950, 18150, 0, 0, 11, 38635, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Rain of Fire'),-- fully sniffed
(21230, 0, 4, 0, 0, 1, 100, 0, 8500, 12300, 6050, 20850, 0, 0, 11, 38636, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Scorch'),-- fully sniffed
(21230, 0, 5, 0, 0, 2, 100, 0, 4800, 10900, 1200, 6700, 0, 0, 11, 38645, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Frostbolt'),-- fully sniffed
(21230, 0, 6, 0, 0, 2, 100, 0, 1200, 9600, 60000, 60000, 0, 0, 11, 38649, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Frost Destruction'),-- repeat timer not sniffed
(21230, 0, 7, 0, 0, 2, 100, 0, 21750, 35150, 14000, 17000, 0, 0, 11, 38644, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Cone of Cold'),-- repeat timer not sniffed
(21230, 0, 8, 0, 0, 2, 100, 1, 7250, 24250, 0, 0, 0, 0, 11, 38646, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Blizzard'),-- new added spell
(21230, 0, 9, 0, 0, 4, 100, 0, 7250, 12950, 13500, 14900, 0, 0, 11, 38633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Volley'),-- fully sniffed
(21230, 0, 10, 0, 0, 4, 100, 0, 350, 4650, 60000, 60000, 0, 0, 11, 38647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Destruction'),-- repeat timer not sniffed
(21230, 0, 11, 0, 0, 4, 100, 0, 17350, 21400, 14550, 15350, 0, 0, 11, 38634, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Arcane Lightning'),-- fully sniffed
(21230, 0, 12, 0, 0, 4, 100, 0, 8450, 12550, 12100, 22800, 0, 0, 11, 38642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Nether-Mage - In Combat - Cast Blink'),-- new added spell
(21231, 0, 0, 0, 0, 0, 100, 0, 5000, 12000, 10000, 15000, 0, 0, 11, 38631, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Shield-Bearer - In Combat - Cast Avenger\'s Shield'),-- not sniffed correctly thus unchanged
(21231, 0, 1, 9, 0, 0, 100, 0, 8, 25, 10000, 15000, 0, 0, 11, 38630, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Shield-Bearer - In Combat - Cast Shield Charge'),-- not sniffed correctly thus unchanged
(21232, 0, 0, 0, 25, 0, 100, 257, 0, 0, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Skulker - On Reset - Cast Dual Wield'),
(21232, 0, 1, 0, 105, 0, 100, 0, 4800, 13100, 4850, 9050, 0, 5, 11, 38625, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Skulker - Victim Casting - Cast Kick'),-- fully sniffed
(21251, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 30, 1, 2, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Aggro - Set Random Phase'), 
(21251, 0, 1, 0, 0, 1, 100, 0, 19400, 19400, 13350, 16950, 0, 0, 11, 39031, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Enrage (Phase 1)'),-- fully sniffed
(21251, 0, 2, 0, 0, 1, 100, 1, 0, 0, 0, 0, 0, 0, 11, 39014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Atrophic Blow (Phase 1)'),-- not sniffed thus unchanged
(21251, 0, 3, 0, 0, 2, 100, 0, 16950, 16950, 25500, 29100, 0, 0, 11, 38971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Acid Geyser (Phase 2)'),-- fully sniffed
(21251, 0, 4, 0, 0, 2, 100, 0, 25450, 25450, 29150, 29150, 0, 0, 11, 39044, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Serpentshrine Parasite (Phase 2)'),-- fully sniffed
(21251, 0, 5, 0, 0, 4, 100, 0, 19450, 19450, 25450, 25450, 0, 0, 11, 38976, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Spore Quake (Phase 3)'),-- fully sniffed
(21251, 0, 6, 0, 0, 4, 100, 0, 27900, 27900, 29100, 29100, 0, 0, 11, 39032, 0, 0, 0, 0, 0, 5, 40, 1, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - In Combat - Cast Initial Infection (Phase 3)'),-- fully sniffed
(21251, 0, 7, 0, 6, 0, 80, 512, 0, 0, 0, 0, 0, 0, 125, 1, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Death - Run Random Timed Event'),
(21251, 0, 8, 0, 59, 0, 100, 512, 1, 0, 0, 0, 0, 0, 11, 38718, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Toxic Pool'),-- unchanged
(21251, 0, 9, 0, 59, 0, 100, 512, 2, 0, 0, 0, 0, 0, 11, 38922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Colossus Lurkers'),-- unchanged
(21251, 0, 10, 0, 59, 0, 100, 512, 3, 0, 0, 0, 0, 0, 11, 38928, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Colossus Ragers'),-- unchanged
(21251, 0, 11, 0, 59, 0, 100, 512, 4, 0, 0, 0, 0, 0, 11, 38726, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Colossus - On Timed Event - Cast Summon Serpentshrine Mushroom'),-- unchanged
(21263, 0, 0, 0, 0, 0, 100, 0, 6050, 17850, 7250, 16350, 0, 0, 11, 38995, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Technician - In Combat - Cast Hamstring'),-- fully sniffed
(21298, 0, 0, 0, 0, 0, 80, 0, 10850, 17550, 10900, 17000, 0, 0, 11, 38599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Serpentguard - In Combat - Cast \'Spell Reflection\''),-- fully sniffed
(21298, 0, 1, 0, 0, 0, 100, 0, 0, 0, 59000, 60000, 0, 0, 11, 38603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Serpentguard - In Combat - Cast \'Corrupt Devotion Aura\''),-- not sniffed thus unchanged
(21299, 0, 0, 0, 0, 0, 80, 0, 10900, 16000, 22900, 32900, 0, 0, 11, 38626, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Fathom-Witch - In Combat - Cast \'Domination\''),-- repeat timer not sniffed
(21299, 0, 1, 0, 0, 0, 100, 0, 14700, 18500, 66300, 89300, 0, 0, 11, 38627, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Fathom-Witch - In Combat - Cast \'Shadow Nova\''),-- repeat timer not sniffed
(21299, 0, 2, 0, 0, 0, 100, 0, 4450, 5850, 3650, 8450, 0, 0, 11, 38628, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Fathom-Witch - In Combat - Cast \'Shadow Bolt\''),-- fully sniffed
(21301, 0, 0, 0, 0, 0, 100, 0, 6850, 12350, 19400, 27400, 0, 0, 11, 38591, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - In Combat - Cast Shatter Armor'),-- fully sniffed
(21301, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Shatterer - On Aggro - Call For Help'),
(21339, 0, 0, 0, 0, 0, 100, 0, 9700, 22400, 13350, 40050, 0, 0, 11, 38491, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Hate-Screamer - In Combat - Cast Silence'),-- fully sniffed
(21339, 0, 1, 0, 0, 0, 100, 0, 3600, 10900, 4850, 12950, 0, 0, 11, 38496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Hate-Screamer - In Combat - Cast Sonic Scream'),-- fully sniffed
(21806, 0, 0, 0, 0, 0, 100, 0, 6050, 9250, 8500, 11600, 0, 0, 11, 37531, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - In Combat - Cast Mind Blast'),-- fully sniffed
(21806, 0, 1, 0, 105, 0, 100, 0, 6050, 6050, 8000, 10000, 0, 45, 11, 39076, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - In Combat - Cast Spell Shock'),-- repeat timer not sniffed
(21806, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - On Aggro - Call For Help'),
(21806, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 0, 0, 11, 37626, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Spellbinder - Out of Combat - Cast Green Beam'),
(21863, 0, 0, 0, 0, 0, 100, 0, 9650, 15750, 12150, 15750, 0, 0, 11, 38650, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Lurker - In Combat - Cast Rancid Mushroom'),-- fully sniffed
(21863, 0, 1, 0, 0, 0, 100, 0, 12150, 18150, 15000, 22000, 0, 0, 11, 38655, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpentshrine Lurker - In Combat - Cast Poison Bolt Volley'),-- repeat timer not sniffed
(21865, 0, 0, 0, 0, 0, 100, 0, 1200, 9500, 3200, 11400, 0, 0, 11, 37770, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ambusher - In Combat - Cast Shoot'),-- fully sniffed
(21865, 0, 1, 0, 0, 0, 100, 0, 7250, 14850, 12100, 16000, 0, 0, 11, 37790, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Ambusher - In Combat - Cast Spread Shot'),-- fully sniffed
(21873, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 9000, 12000, 0, 0, 11, 28168, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - In Combat - Cast Arcing Smash'),-- not sniffed correctly
(21873, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 14000, 18000, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Guardian - In Combat - Cast Hamstring'),-- not sniffed but weird ID
(21920, 0, 0, 0, 0, 0, 100, 0, 7650, 26050, 7250, 26950, 0, 0, 11, 41932, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tidewalker Lurker - In Combat - Cast Carnivorous Bite'),-- fully sniffed
(22009, 0, 0, 0, 60, 0, 100, 1, 100, 100, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - On Reset - Set In Combat With Zone'),
(22009, 0, 1, 0, 60, 0, 100, 0, 100, 500, 2350, 2650, 0, 0, 11, 38253, 0, 0, 0, 0, 0, 5, 200, 0, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - In Combat - Cast Poison Bolt'),-- fully sniffed
(22009, 0, 2, 0, 60, 0, 100, 769, 15000, 15000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tainted Elemental - On Update - Despawn'),
(22055, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - On Aggro - Set In Combat With Zone'),
(22055, 0, 1, 0, 0, 0, 100, 0, 6850, 17250, 1250, 15750, 0, 0, 11, 38260, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - In Combat - Cast Cleave'),-- fully sniffed
(22055, 0, 2, 0, 0, 0, 100, 0, 15350, 17750, 8000, 10000, 0, 0, 11, 38262, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - In Combat - Cast Hamstring'),-- repeat not sniffed
(22055, 0, 3, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Elite - Movement Inform - Set In Combat With Zone'),
(22056, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - On Aggro - Set In Combat With Zone'),
(22056, 0, 1, 0, 0, 0, 100, 0, 15700, 15700, 10850, 13350, 0, 0, 11, 38259, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - In Combat - Cast Mind Blast'),-- fully sniffed
(22056, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Strider - Movement Inform - Set In Combat With Zone'),
(22250, 0, 0, 0, 25, 0, 100, 769, 0, 0, 0, 0, 0, 0, 41, 21000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - On Reset - Despawn'),
(22250, 0, 1, 0, 0, 0, 100, 0, 1150, 1150, 1200, 3400, 0, 0, 11, 31698, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - In Combat - Cast Grow'),-- fully sniffed
(22250, 0, 2, 3, 0, 0, 100, 1, 22950, 22950, 0, 0, 0, 0, 11, 38652, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - In Combat - Cast Spore Cloud (no repeat)'),-- fully sniffed
(22250, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rancid Mushroom - In Combat - Die');
