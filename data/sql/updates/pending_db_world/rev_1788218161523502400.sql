-- Basic Chemistry (13279 Horde / 13295 Alliance) and its repeatables Neutralizing the Plague
-- (13281 / 13297) - the plague cauldrons of Mord'rethar.
-- Moves the event off SmartAI and onto zone_icecrown.cpp, and replaces the hand-written wave
-- sequence with the spawn slots recovered from the retail sniff dump_12.1.0.69299 (15 cauldron
-- activations, 23 waves, 115 summons, 21 ghoul jumps, all on map 571 / area 4508).

--
-- Cauldron targets. 31773 was spawned at all three cauldrons, 32427 was never spawned at all, and
-- a stray 32442 sat on top of the southern one. Retail entries, positions, heights and facings.
--
DELETE FROM `creature` WHERE `guid`=16 AND `id`=32442;
UPDATE `creature` SET `position_x`=6776.59814453125, `position_y`=1628.5748291015625, `position_z`=390.922119140625, `orientation`=4.729842185974121, `VerifiedBuild`=69299, `CreateObject`=1 WHERE `guid`=1977255;
UPDATE `creature` SET `id`=32442, `position_x`=6777.50927734375, `position_y`=1539.3518066406250, `position_z`=390.87347412109375, `orientation`=1.623156189918518, `VerifiedBuild`=69299, `CreateObject`=1 WHERE `guid`=1977256;
UPDATE `creature` SET `id`=32427, `position_x`=6752.57568359375, `position_y`=1583.6961669921875, `position_z`=392.109619140625, `orientation`=4.276056766510010, `VerifiedBuild`=69299, `CreateObject`=1 WHERE `guid`=1977257;

--
-- Pustulant Spinal Fluid only ever found entry 31773, so the two cauldrons that now carry their
-- own entries would have been undousable.
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=59655;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,59655,0,0,31,0,3,31773,0,0,0,0,'','Neutralize Plague - Target Plague Cauldron'),
(13,1,59655,0,1,31,0,3,32427,0,0,0,0,'','Neutralize Plague - Target Plague Cauldron 01'),
(13,1,59655,0,2,31,0,3,32442,0,0,0,0,'','Neutralize Plague - Target Plague Cauldron 02');

--
-- The Plague Drenched Ghoul carries Ghoul Aura on the way out of the cauldron just like the
-- Rampaging Ghoul does, and the third cauldron target is now visible from as far off as the two
-- that were already spawned.
--
DELETE FROM `creature_template_addon` WHERE `entry`=32176;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(32176,0,0,0,1,0,0,'58812');

UPDATE `creature_template_addon` SET `visibilityDistanceType`=3 WHERE `entry`=32427;

--
-- Hand the event to C++. The Living Plague keeps SmartAI - it only wanders and attacks.
--
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_plague_cauldron_target' WHERE `entry` IN (31773,32427,32442);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_plague_cauldron_bunny' WHERE `entry` IN (31880,32431,32445);
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_plague_cauldron_ghoul' WHERE `entry` IN (32176,32178);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (59872,59873);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(59872,'spell_cauldron_event_timer_aura'),
(59873,'spell_cauldron_fluid_timer_aura');

--
-- Tear down the old SmartAI, including the orphaned 3244200 action list nothing ever called.
--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (31773, 32176, 32178, 32442, 32445) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3177300, 3177301, 3244200, 3244500, 3244501, 3244502) AND `source_type`=9;

--
-- Living Plague. They wander from the moment they surface and never jump. The summon group owns
-- their despawn now, so the out-of-combat despawn row is gone, and detection range brings them
-- onto a player without a scripted pull.
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=32181 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(32181,0,0,0,54,0,100,0,0,0,0,0,0,0,89,13,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Living Plague - On Just Summoned - Random Movement');

--
-- Wave spawns. Every slot reproduced to five decimals across activations minutes apart, so these
-- are fixed points and not the random placement 60056 / 60058 were being used for. Ghouls surface
-- three yards up, inside the cauldron; Living Plague rise in a ring on the ground around it.
-- summonType 4 = TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, at the observed lifetimes of 42s and
-- 126s. Retail clears a whole wave on the timer regardless; holding the despawn until they
-- are out of combat keeps a wave from vanishing out of a fight.
--
-- The script keys each ghoul's jump on its slot within the group, so the two rows of group 2 must
-- stay in the order they are written in - the Comment column names the slot each row feeds.
--
DELETE FROM `creature_summon_groups` WHERE `summonerType`=0 AND `summonerId` IN (31880,32431,32445);
INSERT INTO `creature_summon_groups` (`summonerId`,`summonerType`,`groupId`,`entry`,`position_x`,`position_y`,`position_z`,`orientation`,`summonType`,`summonTime`,`Comment`) VALUES
(31880,0,0,32181,6769.9907,1623.8656,389.11660,3.7694,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 0'),
(31880,0,0,32181,6770.0920,1629.6494,389.11660,5.4866,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 1'),
(31880,0,0,32181,6770.1960,1625.0200,389.11660,5.8720,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 2'),
(31880,0,0,32181,6771.6860,1622.6857,389.11660,6.0991,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 3'),
(31880,0,0,32181,6774.8680,1622.1152,389.11660,3.3795,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 4'),
(31880,0,0,32181,6776.6724,1621.3363,389.11660,5.8794,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 5'),
(31880,0,0,32181,6778.9243,1621.4818,389.11660,3.2861,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 6'),
(31880,0,0,32181,6780.2676,1622.2360,389.11660,3.1209,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 7'),
(31880,0,0,32181,6783.4673,1626.8779,389.11660,3.7405,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 8'),
(31880,0,0,32181,6783.7910,1628.4052,389.11660,5.8871,4,42000,'31880 group 0 (10x Living Plague) - Living Plague 9'),
(31880,0,1,32178,6776.6147,1627.8799,394.02630,5.1662,4,126000,'31880 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Rampaging Ghoul 0'),
(31880,0,1,32181,6770.2200,1626.5367,389.11660,4.3298,4,42000,'31880 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 0'),
(31880,0,1,32181,6773.8970,1622.2312,389.11660,3.4066,4,42000,'31880 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 1'),
(31880,0,1,32181,6782.8910,1623.0106,389.11660,3.3710,4,42000,'31880 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 2'),
(31880,0,1,32181,6783.9790,1630.4657,389.11660,5.7403,4,42000,'31880 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 3'),
(31880,0,2,32178,6776.3440,1628.6213,394.06790,3.8921,4,126000,'31880 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 0'),
(31880,0,2,32178,6776.8335,1629.1064,393.94990,6.2308,4,126000,'31880 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 1'),
(31880,0,3,32176,6776.6170,1628.1666,394.05410,4.9916,4,126000,'31880 group 3 (1x Plague Drenched Ghoul) - Plague Drenched Ghoul 0'),
(32431,0,0,32181,6754.4050,1594.0120,389.11660,3.9960,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 0'),
(32431,0,0,32181,6758.5312,1594.5061,389.11660,0.4294,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 1'),
(32431,0,0,32181,6758.5480,1572.6420,389.11660,3.9296,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 2'),
(32431,0,0,32181,6761.3000,1593.5180,389.11660,3.3588,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 3'),
(32431,0,0,32181,6761.6323,1573.6410,389.11650,6.2141,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 4'),
(32431,0,0,32181,6762.5360,1590.8041,389.11660,1.1293,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 5'),
(32431,0,0,32181,6763.8022,1579.9290,389.11650,1.2698,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 6'),
(32431,0,0,32181,6764.1350,1586.2543,389.11650,4.6826,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 7'),
(32431,0,0,32181,6764.3250,1582.0475,389.11650,3.3937,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 8'),
(32431,0,0,32181,6762.6940,1576.7335,389.11650,3.5850,4,42000,'32431 group 0 (10x Living Plague) - Living Plague 9'),
(32431,0,1,32178,6754.4517,1584.2598,396.33880,6.1785,4,126000,'32431 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Rampaging Ghoul 0'),
(32431,0,1,32181,6756.3447,1594.3248,389.11660,3.7328,4,42000,'32431 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 0'),
(32431,0,1,32181,6757.2427,1572.9735,389.11650,0.4313,4,42000,'32431 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 1'),
(32431,0,1,32181,6762.6177,1588.8864,389.11660,6.1610,4,42000,'32431 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 2'),
(32431,0,1,32181,6763.0690,1579.0770,389.11660,1.1746,4,42000,'32431 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 3'),
(32431,0,2,32178,6753.6875,1582.3635,396.06100,5.3931,4,126000,'32431 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 0'),
(32431,0,2,32178,6754.1885,1585.1517,396.31790,0.9076,4,126000,'32431 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 1'),
(32431,0,3,32176,6754.5845,1583.5083,396.24160,0.0349,4,126000,'32431 group 3 (1x Plague Drenched Ghoul) - Plague Drenched Ghoul 0'),
(32445,0,0,32181,6768.6550,1544.0116,389.11650,1.9897,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 0'),
(32445,0,0,32181,6770.1235,1545.2253,389.11650,2.6180,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 1'),
(32445,0,0,32181,6771.1780,1546.0436,389.11650,4.4680,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 2'),
(32445,0,0,32181,6772.6274,1546.4924,389.11650,5.1662,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 3'),
(32445,0,0,32181,6775.2017,1547.3397,389.11650,5.4105,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 4'),
(32445,0,0,32181,6776.3250,1547.5367,389.11650,3.8921,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 5'),
(32445,0,0,32181,6778.7485,1547.8766,389.11650,0.9250,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 6'),
(32445,0,0,32181,6783.0910,1545.7485,389.11650,4.3808,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 7'),
(32445,0,0,32181,6784.7275,1539.2513,389.11650,0.2094,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 8'),
(32445,0,0,32181,6784.7820,1544.0118,389.11650,3.0892,4,42000,'32445 group 0 (10x Living Plague) - Living Plague 9'),
(32445,0,1,32178,6777.4087,1540.2680,394.03320,1.4661,4,126000,'32445 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Rampaging Ghoul 0'),
(32445,0,1,32181,6773.9510,1546.4857,389.11650,2.6051,4,42000,'32445 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 0'),
(32445,0,1,32181,6780.4697,1546.4274,389.11650,2.9654,4,42000,'32445 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 1'),
(32445,0,1,32181,6784.6475,1541.7620,389.11650,4.3516,4,42000,'32445 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 2'),
(32445,0,1,32181,6770.2650,1542.2817,389.11650,5.2185,4,42000,'32445 group 1 (1x Rampaging Ghoul + 4x Living Plague) - Living Plague 3'),
(32445,0,2,32178,6776.8047,1539.5057,394.04010,2.4958,4,126000,'32445 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 0'),
(32445,0,2,32178,6778.0490,1539.5007,394.06100,0.3840,4,126000,'32445 group 2 (2x Rampaging Ghoul) - Rampaging Ghoul 1'),
(32445,0,3,32176,6777.3220,1539.9855,393.83880,1.6406,4,126000,'32445 group 3 (1x Plague Drenched Ghoul) - Plague Drenched Ghoul 0');

--
-- Retail sends each warning as one emote containing $b, not as two lines, and every emote after
-- the cauldron's own opening line comes from the bunny. No failure emote reaches the sniff, but
-- all three failures there happened while the player stood at another cauldron 45 yd away and
-- ListenRange.TextEmote is 40 - so the line stays, as the real 32487 text rather than the
-- invented "Plague batch becomes unstable!" it used to be.
--
DELETE FROM `creature_text` WHERE `CreatureID` IN (31773,31880,32427,32431,32442,32445);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(31773,0,0,'The plague cauldron begins to boil vigorously!',41,0,100,0,0,0,32477,0,'Plague Cauldron Target'),
(31880,0,0,'Something emerges from the cauldron!',41,0,100,0,0,0,32478,0,'Summoned Plague Cauldron Bunny'),
(31880,1,0,'The cauldron continues to boil...',41,0,100,0,0,0,32483,0,'Summoned Plague Cauldron Bunny'),
(31880,2,0,'Plague batch neutralized!',41,0,100,0,0,0,32488,0,'Summoned Plague Cauldron Bunny'),
(31880,3,0,'Neutralizing agent failing!$bAdd fluid soon!',41,0,100,0,0,0,32484,0,'Summoned Plague Cauldron Bunny'),
(31880,4,0,'Neutralizing agent failing!$bAdd fluid NOW!!',41,0,100,0,0,0,32486,0,'Summoned Plague Cauldron Bunny'),
(31880,5,0,'Neutralizing agent FAILED!',41,0,100,0,0,0,32487,0,'Summoned Plague Cauldron Bunny'),
(32427,0,0,'The plague cauldron begins to boil vigorously!',41,0,100,0,0,0,32477,0,'Plague Cauldron Target 01'),
(32431,0,0,'Something emerges from the cauldron!',41,0,100,0,0,0,32479,0,'Summoned Plague Cauldron Bunny 01'),
(32431,1,0,'The cauldron continues to boil...',41,0,100,0,0,0,32483,0,'Summoned Plague Cauldron Bunny 01'),
(32431,2,0,'Plague batch neutralized!',41,0,100,0,0,0,32488,0,'Summoned Plague Cauldron Bunny 01'),
(32431,3,0,'Neutralizing agent failing!$bAdd fluid soon!',41,0,100,0,0,0,32484,0,'Summoned Plague Cauldron Bunny 01'),
(32431,4,0,'Neutralizing agent failing!$bAdd fluid NOW!!',41,0,100,0,0,0,32486,0,'Summoned Plague Cauldron Bunny 01'),
(32431,5,0,'Neutralizing agent FAILED!',41,0,100,0,0,0,32487,0,'Summoned Plague Cauldron Bunny 01'),
(32442,0,0,'The plague cauldron begins to boil vigorously!',41,0,100,0,0,0,32477,0,'Plague Cauldron Target 02'),
(32445,0,0,'Something emerges from the cauldron!',41,0,100,0,0,0,32479,0,'Summoned Plague Cauldron Bunny 02'),
(32445,1,0,'The cauldron continues to boil...',41,0,100,0,0,0,32483,0,'Summoned Plague Cauldron Bunny 02'),
(32445,2,0,'Plague batch neutralized!',41,0,100,0,0,0,32488,0,'Summoned Plague Cauldron Bunny 02'),
(32445,3,0,'Neutralizing agent failing!$bAdd fluid soon!',41,0,100,0,0,0,32484,0,'Summoned Plague Cauldron Bunny 02'),
(32445,4,0,'Neutralizing agent failing!$bAdd fluid NOW!!',41,0,100,0,0,0,32486,0,'Summoned Plague Cauldron Bunny 02'),
(32445,5,0,'Neutralizing agent FAILED!',41,0,100,0,0,0,32487,0,'Summoned Plague Cauldron Bunny 02');
