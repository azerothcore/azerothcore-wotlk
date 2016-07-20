
-- Bone Crawler (21849)
UPDATE creature_template SET mechanic_immune_mask=mechanic_immune_mask|0x20, flags_extra=0x200000, AIName='SmartAI', ScriptName='' WHERE entry=21849;
DELETE FROM smart_scripts WHERE entryorguid=21849 AND source_type=0;
INSERT INTO smart_scripts VALUES (21849, 0, 0, 1, 25, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Reset - Set Unit Flag');
INSERT INTO smart_scripts VALUES (21849, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 19, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Reset - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (21849, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 37989, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Reset - Cast Tunnel Bore Bone Passive');
INSERT INTO smart_scripts VALUES (21849, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 90, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Reset - Set Bytes0');
INSERT INTO smart_scripts VALUES (21849, 0, 4, 5, 4, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Aggro - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (21849, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 18, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Aggro - Set Unit Flag');
INSERT INTO smart_scripts VALUES (21849, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 28, 37989, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Aggro - Remove Aura Tunnel Bore Bone Passive');
INSERT INTO smart_scripts VALUES (21849, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 147, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - On Aggro - Stop Motion');
INSERT INTO smart_scripts VALUES (21849, 0, 8, 0, 0, 0, 100, 1, 100, 100, 0, 0, 91, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - In Combat - Remove Bytes0');
INSERT INTO smart_scripts VALUES (21849, 0, 9, 0, 0, 0, 100, 0, 1000, 6000, 8000, 11000, 11, 32738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - In Combat - Cast Bore');
INSERT INTO smart_scripts VALUES (21849, 0, 10, 0, 9, 0, 100, 0, 4, 50, 2000, 3500, 11, 31747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Bone Crawler - Within Range 5-50yd - Cast Poison');

-- Talonpriest Zellek (23068)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23068;
DELETE FROM smart_scripts WHERE entryorguid=23068 AND source_type=0;
INSERT INTO smart_scripts VALUES (23068, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 10000, 15000, 11, 15652, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Zellek - In Combat - Cast Head Smash');
INSERT INTO smart_scripts VALUES (23068, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 18000, 25000, 11, 17173, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Zellek - In Combat - Cast Drain Life');

-- Talonpriest Ishaal (23066)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23066;
DELETE FROM smart_scripts WHERE entryorguid=23066 AND source_type=0;
INSERT INTO smart_scripts VALUES (23066, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 11, 17843, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Ishaal - In Combat - Cast Flash Heal');
INSERT INTO smart_scripts VALUES (23066, 0, 1, 0, 0, 0, 100, 0, 4000, 5000, 10000, 15000, 11, 12160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Ishaal - In Combat - Cast Rejuvenation');
INSERT INTO smart_scripts VALUES (23066, 0, 2, 0, 0, 0, 100, 0, 1000, 3000, 10000, 15000, 11, 15654, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Ishaal - In Combat - Cast Shadow Word: Pain');

-- Overseer Seylanna (20397)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=20397;
DELETE FROM smart_scripts WHERE entryorguid=20397 AND source_type=0;
INSERT INTO smart_scripts VALUES (20397, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 4500, 5500, 11, 36179, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Seylanna - In Combat - Cast Crystal Charge');
INSERT INTO smart_scripts VALUES (20397, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 10000, 15000, 11, 35919, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Overseer Seylanna - In Combat - Cast Welding Beam');

-- Talonpriest Skizzik (23067)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=23067;
DELETE FROM smart_scripts WHERE entryorguid=23067 AND source_type=0;
INSERT INTO smart_scripts VALUES (23067, 0, 0, 0, 0, 0, 100, 0, 2000, 3000, 8000, 12000, 11, 17165, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Skizzik - In Combat - Cast Mind Flay');
INSERT INTO smart_scripts VALUES (23067, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 25000, 11, 22884, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Skizzik - In Combat - Cast Psychic Scream');
INSERT INTO smart_scripts VALUES (23067, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 7000, 10000, 11, 32712, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talonpriest Skizzik - In Combat - Cast Shadow Nova');

-- Sahaak <Keeper of Scrolls> (23363)
DELETE FROM conditions WHERE SourceTypeOrReferenceId=15 AND SourceGroup=8683;
INSERT INTO conditions VALUES(15, 8683, 0, 0, 0, 1, 0, 41181, 0, 0, 0, 0, 0, '', 'Show gossip if player has aura 41181');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=14 AND SourceGroup=8683;
INSERT INTO conditions VALUES(14, 8683, 10953, 0, 0, 1, 0, 41181, 0, 0, 0, 0, 0, '', 'Show gossip if player has aura 41181');
INSERT INTO conditions VALUES(14, 8683, 10930, 0, 0, 1, 0, 41181, 0, 0, 1, 0, 0, '', 'Show gossip if player doesnt have aura 41181');
DELETE FROM gossip_menu WHERE entry=8683;
INSERT INTO gossip_menu VALUES (8683, 10930),(8683, 10953);

-- Doomsayer Jurim (18686)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18686;
DELETE FROM smart_scripts WHERE entryorguid=18686 AND source_type=0;
INSERT INTO smart_scripts VALUES (18686, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Doomsayer Jurim - In Combat - Cast Shadow Bolt');
INSERT INTO smart_scripts VALUES (18686, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 25000, 11, 39210, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Doomsayer Jurim - In Combat - Cast Fear');
INSERT INTO smart_scripts VALUES (18686, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 17000, 30000, 11, 39212, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Doomsayer Jurim - In Combat - Cast Corruption');
INSERT INTO smart_scripts VALUES (18686, 0, 3, 0, 0, 0, 100, 0, 4000, 4000, 20000, 40000, 11, 12493, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 'Doomsayer Jurim - In Combat - Cast Curse of Weakness');

-- Ashkaz (18539)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18539;
DELETE FROM smart_scripts WHERE entryorguid=18539 AND source_type=0;
INSERT INTO smart_scripts VALUES (18539, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 26098, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashkaz - In Combat - Cast Lightning Bolt');
INSERT INTO smart_scripts VALUES (18539, 0, 1, 0, 0, 0, 100, 0, 10000, 15000, 15000, 25000, 11, 6728, 0, 0, 0, 0, 0, 6, 20, 0, 0, 0, 0, 0, 0, 'Ashkaz - In Combat - Cast Enveloping Winds');
INSERT INTO smart_scripts VALUES (18539, 0, 2, 0, 0, 0, 100, 0, 7000, 8000, 12000, 15000, 11, 32907, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Ashkaz - In Combat - Cast Arakkoa Blast');
INSERT INTO smart_scripts VALUES (18539, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 32924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Ashkaz - In Combat - Cast Power of Kran''aish');

-- Pathaleon the Calculator's Image (21504)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21504;
DELETE FROM smart_scripts WHERE entryorguid=21504 AND source_type=0;
INSERT INTO smart_scripts VALUES (21504, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pathaleon the Calculator''s Image - On Data Set 1 1 - Set Event Phase');
INSERT INTO smart_scripts VALUES (21504, 0, 1, 0, 60, 1, 100, 1, 2000, 2000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pathaleon the Calculator''s Image - On Update - Say Line 8');
INSERT INTO smart_scripts VALUES (21504, 0, 2, 0, 60, 1, 100, 1, 9000, 9000, 0, 0, 11, 51347, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pathaleon the Calculator''s Image - On Update - Cast Teleport Visual Only');
INSERT INTO smart_scripts VALUES (21504, 0, 3, 0, 60, 1, 100, 1, 10200, 10200, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Pathaleon the Calculator''s Image - On Update - Despawn');

-- Voidhunter Yar (18683)
DELETE FROM creature_text WHERE entry=18683;
INSERT INTO creature_text VALUES (18683, 0, 0, 'I shall send your soul into the infinite void!', 12, 0, 100, 0, 0, 0, 0, 'Voidhunter Yar');
INSERT INTO creature_text VALUES (18683, 0, 1, 'Let my darkness engulf you!', 12, 0, 100, 0, 0, 0, 0, 'Voidhunter Yar');
INSERT INTO creature_text VALUES (18683, 0, 2, 'In the void, no one can hear you scream!', 12, 0, 100, 0, 0, 0, 0, 'Voidhunter Yar');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=18683;
DELETE FROM smart_scripts WHERE entryorguid=18683 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid IN(18683*100+0, 18683*100+1, 18683*100+2) AND source_type=9;
INSERT INTO smart_scripts VALUES (18683, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (18683, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 4000, 7000, 11, 38204, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Cast Arcane Bolt');
INSERT INTO smart_scripts VALUES (18683, 0, 2, 0, 0, 0, 100, 0, 0, 0, 10000, 10000, 88, 18683*100+0, 18683*100+2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - In Combat - Run Random Script');
INSERT INTO smart_scripts VALUES (18683*100+0, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Cast Damage Reduction: Arcane');
INSERT INTO smart_scripts VALUES (18683*100+0, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Fire');
INSERT INTO smart_scripts VALUES (18683*100+0, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Frost');
INSERT INTO smart_scripts VALUES (18683*100+1, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Cast Damage Reduction: Fire');
INSERT INTO smart_scripts VALUES (18683*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Arcane');
INSERT INTO smart_scripts VALUES (18683*100+1, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Frost');
INSERT INTO smart_scripts VALUES (18683*100+2, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 34334, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Cast Damage Reduction: Frost');
INSERT INTO smart_scripts VALUES (18683*100+2, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34331, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Arcane');
INSERT INTO smart_scripts VALUES (18683*100+2, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 34333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Voidhunter Yar - On Script - Remove Damage Reduction: Fire');

-- Cabal Skirmisher (21661)
DELETE FROM creature_text WHERE entry=21661;
INSERT INTO creature_text VALUES (21661, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 0, 'The end comes for you!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 1, 'You will not escape us so easily!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 2, 'I shall be rewarded!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 3, 'Ruin finds us all!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 4, 'In Sargeras'' name!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 5, 'I do as I must!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 6, 'The Legion reigns!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
INSERT INTO creature_text VALUES (21661, 1, 7, 'You''ll go nowhere, fool!', 12, 0, 100, 0, 0, 0, 0, 'Cabal Skirmisher');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=21661;
DELETE FROM smart_scripts WHERE entryorguid=21661 AND source_type=0;
INSERT INTO smart_scripts VALUES (21661, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Skirmisher - On Agro - Say Line 1');
INSERT INTO smart_scripts VALUES (21661, 0, 1, 0, 0, 0, 100, 0, 4000, 9000, 7000, 10000, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cabal Skirmisher - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (21661, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Skirmisher - Between Health 0-30% - Cast Enrage');
INSERT INTO smart_scripts VALUES (21661, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cabal Skirmisher - Between Health 0-30% - Say Line 0');
