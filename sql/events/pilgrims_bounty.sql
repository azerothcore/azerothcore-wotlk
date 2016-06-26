
-- Add game_event entry
REPLACE INTO game_event VALUES (26, '2015-11-23 01:00:00', '2020-12-30 22:00:00', 525600, 10019, 404, 'Pilgrim''s Bounty', 0);

-- Fixing protos
UPDATE creature_template SET npcflag=83 WHERE entry IN(34708, 34710, 34711, 34712, 34713, 34714);
UPDATE creature_template SET MovementType=1, lootid=32820 WHERE entry=32820;

-- Food
DELETE FROM spell_group WHERE spell_id=66624;
DELETE FROM spell_script_names WHERE spell_id IN(65418, 65419, 65420, 65421, 65422, 66041, 66477);
INSERT INTO spell_script_names VALUES(65418, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(65419, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(65420, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(65421, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(65422, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(66041, 'spell_pilgrims_bounty_food');
INSERT INTO spell_script_names VALUES(66477, 'spell_pilgrims_bounty_food');
DELETE FROM spell_linked_spell WHERE spell_trigger IN(66623, -66623);
INSERT INTO spell_linked_spell VALUES(66623, 66624, 2, 'Bountiful Basket Bonus Aura');
INSERT INTO spell_linked_spell VALUES(-66623, -66624, 0, 'Bountiful Basket Bonus Remove');


-- ---------------------------------
-- Tables / chairs
-- ---------------------------------
DELETE FROM vehicle_template_accessory WHERE entry IN(32823, 32830, 32840);
INSERT INTO vehicle_template_accessory VALUES (32823, 34812, 0, 1, 'Bountiful Table - The Turkey Chair', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 34823, 1, 1, 'Bountiful Table - The Cranberry Chair', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 34819, 2, 1, 'Bountiful Table - The Stuffing Chair', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 34824, 3, 1, 'Bountiful Table - The Sweet Potato Chair', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 34822, 4, 1, 'Bountiful Table - The Pie Chair', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 32830, 5, 1, 'Bountiful Table - Food Holder', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32823, 32840, 6, 1, 'Bountiful Table - Plate Holder', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32830, 32824, 0, 1, 'Food Holder - [PH] Pilgrim''s Bounty Table - Turkey', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32830, 32827, 1, 1, 'Food Holder - [PH] Pilgrim''s Bounty Table - Cranberry Sauce', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32830, 32831, 2, 1, 'Food Holder - [PH] Pilgrim''s Bounty Table - Stuffing', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32830, 32825, 3, 1, 'Food Holder - [PH] Pilgrim''s Bounty Table - Yams', 8, 0);
INSERT INTO vehicle_template_accessory VALUES (32830, 32829, 4, 1, 'Food Holder - [PH] Pilgrim''s Bounty Table - Pie', 8, 0);
UPDATE creature_template SET modelid2=0, VehicleId=321, unit_flags=0, unit_flags2=32768, flags_extra=0, ScriptName='npc_pilgrims_bounty_chair' WHERE entry IN(34812, 34819, 34822, 34824, 34823);
DELETE FROM npc_spellclick_spells WHERE npc_entry IN(34812, 34819, 34822, 34824, 34823);
INSERT INTO npc_spellclick_spells VALUES(34812, 65403, 1, 0);
INSERT INTO npc_spellclick_spells VALUES(34819, 65403, 1, 0);
INSERT INTO npc_spellclick_spells VALUES(34822, 65403, 1, 0);
INSERT INTO npc_spellclick_spells VALUES(34823, 65403, 1, 0);
INSERT INTO npc_spellclick_spells VALUES(34824, 65403, 1, 0);
UPDATE creature_template SET spell1=66250, spell2=61784, spell3=61785, spell4=61788, spell5=61786, spell6=61787 WHERE entry=34812;
UPDATE creature_template SET spell1=66259, spell2=61784, spell3=61785, spell4=61788, spell5=61786, spell6=61787 WHERE entry=34819;
UPDATE creature_template SET spell1=66260, spell2=61784, spell3=61785, spell4=61788, spell5=61786, spell6=61787 WHERE entry=34822;
UPDATE creature_template SET spell1=66261, spell2=61784, spell3=61785, spell4=61788, spell5=61786, spell6=61787 WHERE entry=34823;
UPDATE creature_template SET spell1=66262, spell2=61784, spell3=61785, spell4=61788, spell5=61786, spell6=61787 WHERE entry=34824;
REPLACE INTO creature_template_addon VALUES(34812, 0, 0, 0, 4097, 0, '61801'); -- can eat turkey
REPLACE INTO creature_template_addon VALUES(34819, 0, 0, 0, 4097, 0, '61800'); -- can eat stuffing
REPLACE INTO creature_template_addon VALUES(34822, 0, 0, 0, 4097, 0, '61799'); -- can eat pie
REPLACE INTO creature_template_addon VALUES(34823, 0, 0, 0, 4097, 0, '61798'); -- can eat cranberry
REPLACE INTO creature_template_addon VALUES(34824, 0, 0, 0, 4097, 0, '61802'); -- can eat sweet potato
UPDATE creature_template SET InhabitType=4, unit_flags=0, ScriptName='npc_pilgrims_bounty_plate' WHERE entry=32839;
REPLACE INTO creature_template_addon VALUES(32839, 0, 0, 50331648, 1, 0, '');
DELETE FROM spell_script_names WHERE spell_id IN(66250, 66259, 66260, 66261, 66262);
INSERT INTO spell_script_names VALUES(66250, 'spell_pilgrims_bounty_pass_generic');
INSERT INTO spell_script_names VALUES(66259, 'spell_pilgrims_bounty_pass_generic');
INSERT INTO spell_script_names VALUES(66260, 'spell_pilgrims_bounty_pass_generic');
INSERT INTO spell_script_names VALUES(66261, 'spell_pilgrims_bounty_pass_generic');
INSERT INTO spell_script_names VALUES(66262, 'spell_pilgrims_bounty_pass_generic');
DELETE FROM spell_script_names WHERE spell_id IN(61784, 61785, 61786, 61787, 61788);
INSERT INTO spell_script_names VALUES(61784, 'spell_pilgrims_bounty_feast_on_generic');
INSERT INTO spell_script_names VALUES(61785, 'spell_pilgrims_bounty_feast_on_generic');
INSERT INTO spell_script_names VALUES(61788, 'spell_pilgrims_bounty_feast_on_generic');
INSERT INTO spell_script_names VALUES(61786, 'spell_pilgrims_bounty_feast_on_generic');
INSERT INTO spell_script_names VALUES(61787, 'spell_pilgrims_bounty_feast_on_generic');
DELETE FROM spell_script_names WHERE spell_id IN(61804, 61805, 61806, 61807, 61808);
INSERT INTO spell_script_names VALUES(61804, 'spell_pilgrims_bounty_serve_generic');
INSERT INTO spell_script_names VALUES(61805, 'spell_pilgrims_bounty_serve_generic');
INSERT INTO spell_script_names VALUES(61806, 'spell_pilgrims_bounty_serve_generic');
INSERT INTO spell_script_names VALUES(61807, 'spell_pilgrims_bounty_serve_generic');
INSERT INTO spell_script_names VALUES(61808, 'spell_pilgrims_bounty_serve_generic');

-- Passing spells requirements
DELETE FROM conditions WHERE SourceEntry IN(66250, 66259, 66260, 66261, 66262) AND SourceTypeOrReferenceId=17;
INSERT INTO conditions VALUES(17, 0, 66250, 0, 0, 31, 1, 3, 32839, 0, 0, 0, 0, '', 'Requires Strudy Plate');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 1, 31, 1, 3, 34819, 0, 0, 0, 0, '', 'Requires The Stuffing Chair');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 1, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 2, 31, 1, 3, 34822, 0, 0, 0, 0, '', 'Requires The Pie Chair');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 2, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 3, 31, 1, 3, 34823, 0, 0, 0, 0, '', 'Requires The Cranberry Chair');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 3, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 4, 31, 1, 3, 34824, 0, 0, 0, 0, '', 'Requires The Sweet Potato Chair');
INSERT INTO conditions VALUES(17, 0, 66250, 0, 4, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 0, 31, 1, 3, 32839, 0, 0, 0, 0, '', 'Requires Strudy Plate');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 1, 31, 1, 3, 34812, 0, 0, 0, 0, '', 'Requires The Turkey Chair');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 1, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 2, 31, 1, 3, 34822, 0, 0, 0, 0, '', 'Requires The Pie Chair');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 2, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 3, 31, 1, 3, 34823, 0, 0, 0, 0, '', 'Requires The Cranberry Chair');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 3, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 4, 31, 1, 3, 34824, 0, 0, 0, 0, '', 'Requires The Sweet Potato Chair');
INSERT INTO conditions VALUES(17, 0, 66259, 0, 4, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 0, 31, 1, 3, 32839, 0, 0, 0, 0, '', 'Requires Strudy Plate');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 1, 31, 1, 3, 34812, 0, 0, 0, 0, '', 'Requires The Turkey Chair');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 1, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 2, 31, 1, 3, 34819, 0, 0, 0, 0, '', 'Requires The Stuffing Chair');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 2, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 3, 31, 1, 3, 34823, 0, 0, 0, 0, '', 'Requires The Cranberry Chair');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 3, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 4, 31, 1, 3, 34824, 0, 0, 0, 0, '', 'Requires The Sweet Potato Chair');
INSERT INTO conditions VALUES(17, 0, 66260, 0, 4, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 0, 31, 1, 3, 32839, 0, 0, 0, 0, '', 'Requires Strudy Plate');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 1, 31, 1, 3, 34812, 0, 0, 0, 0, '', 'Requires The Turkey Chair');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 1, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 2, 31, 1, 3, 34819, 0, 0, 0, 0, '', 'Requires The Stuffing Chair');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 2, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 3, 31, 1, 3, 34822, 0, 0, 0, 0, '', 'Requires The Pie Chair');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 3, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 4, 31, 1, 3, 34824, 0, 0, 0, 0, '', 'Requires The Sweet Potato Chair');
INSERT INTO conditions VALUES(17, 0, 66261, 0, 4, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 0, 31, 1, 3, 32839, 0, 0, 0, 0, '', 'Requires Strudy Plate');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 1, 31, 1, 3, 34812, 0, 0, 0, 0, '', 'Requires The Turkey Chair');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 1, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 2, 31, 1, 3, 34819, 0, 0, 0, 0, '', 'Requires The Stuffing Chair');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 2, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 3, 31, 1, 3, 34822, 0, 0, 0, 0, '', 'Requires The Pie Chair');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 3, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 4, 31, 1, 3, 34823, 0, 0, 0, 0, '', 'Requires The Cranberry Chair');
INSERT INTO conditions VALUES(17, 0, 66262, 0, 4, 51, 1, 236, 0, 0, 0, 0, 0, '', 'Requires Aura Type Control Vehicle');

-- ---------------------------------
-- NPCs
-- ---------------------------------

-- Bountiful Table Hostess (34653)
UPDATE creature_template SET gossip_menu_id=10575, npcflag=3 WHERE entry=34653;

DELETE FROM gossip_menu WHERE entry IN(10568, 10569) AND text_id IN(14627, 14628);
INSERT INTO gossip_menu VALUES (10568, 14627),(10569, 14628);

-- Jasper Moore (34744)
UPDATE creature_template SET gossip_menu_id=10569 WHERE entry=34744;

-- Mary Allerton (34711)
UPDATE creature_template SET gossip_menu_id=10569 WHERE entry=34711;

-- Ellen Moore (34710)
UPDATE creature_template SET gossip_menu_id=10568 WHERE entry=34710;

-- Caitrin Ironkettle (34708)
UPDATE creature_template SET gossip_menu_id=10568 WHERE entry=34708;

-- ---------------------------------
-- Quests
-- ---------------------------------
-- Quest requirements
-- Alliance
UPDATE quest_template SET PrevQuestId=14022 WHERE Id IN(14064, 14053, 14055, 14051, 14048, 14054);
UPDATE quest_template SET prevQuestId=14064 WHERE Id=14023;
UPDATE quest_template SET prevQuestId=14023 WHERE Id=14024;
UPDATE quest_template SET prevQuestId=14024 WHERE Id=14028;
UPDATE quest_template SET prevQuestId=14028 WHERE Id=14030;
UPDATE quest_template SET prevQuestId=14030 WHERE Id=14033;
UPDATE quest_template SET prevQuestId=14033 WHERE Id=14035;
-- Horde
UPDATE quest_template SET PrevQuestId=14036 WHERE Id IN(14065, 14059, 14058, 14062, 14061, 14060);
UPDATE quest_template SET prevQuestId=14065 WHERE Id=14037;
UPDATE quest_template SET prevQuestId=14037 WHERE Id=14040;
UPDATE quest_template SET prevQuestId=14040 WHERE Id=14041;
UPDATE quest_template SET prevQuestId=14041 WHERE Id=14043;
UPDATE quest_template SET prevQuestId=14043 WHERE Id=14044;
UPDATE quest_template SET prevQuestId=14044 WHERE Id=14047;

-- Sharing a Bountiful Feast (14064)
-- Sharing a Bountiful Feast (14065)
UPDATE quest_template SET OfferRewardText='What a feast, hmmm?$B$BI''m so glad you could celebrate the spirit of Pilgrim''s Bounty with us.' WHERE Id IN(14064, 14065);

-- Pilgrim's Bounty (14022)
-- Pilgrim's Bounty (14036)
UPDATE quest_template SET OfferRewardText='If you''d like to learn to cook Pilgrim''s Bounty foods, I can help. If you''re not already a cook, all you have to do is train and you''ll be cooking in no time!' WHERE Id=14022;
UPDATE quest_template SET OfferRewardText='If you''d like to learn to cook Pilgrim''s Bounty foods, I can help. If you''re not already a cook, all you have to do is train and you''ll be cooking in no time.' WHERE Id=14036;

-- Don't Forget The Stuffing! (14051)
-- Don't Forget The Stuffing! (14062)
UPDATE quest_template SET RequestItemsText='Were you able to get that stuffing?', OfferRewardText='Thank goodness! I wouldn''t be able to serve the feast without spice bread stuffing.' WHERE Id=14051;
UPDATE quest_template SET RequestItemsText='Were you able to get that stuffing?', OfferRewardText='Perfect timing! I wouldn''t be able to serve the feast without spice bread stuffing.' WHERE Id=14062;

-- Spice Bread Stuffing (14023)
-- Spice Bread Stuffing (14037)
UPDATE quest_template SET RequestItemsText='We can always use more of that delicious spice bread stuffing. It''s very popular.', OfferRewardText='Excellent. This is just what we needed. It''s going to be a chore keeping all the tables stocked with fresh food, but it''s well worth it.' WHERE Id=14023;
UPDATE quest_template SET RequestItemsText='The tables could really use more of that spice bread stuffing.', OfferRewardText='It''s a chore keeping all these tables stocked. If you stop and think about it, it''s strange going to so much trouble when we needn''t eat anymore.$B$B<William shrugs.>$B$BTradition is tradition.' WHERE Id=14037;

-- We're Out of Cranberry Chutney Again? (14053)
-- We're Out of Cranberry Chutney Again? (14059)
UPDATE quest_template SET RequestItemsText='Were you able to get your hands on any cranberry chutney?', OfferRewardText='Thanks. This looks great, and you''re a fair bit faster than Jasper, but don''t tell him I said so.' WHERE Id=14053;
UPDATE quest_template SET RequestItemsText='Were you able to get your hands on any cranberry chutney?', OfferRewardText='Thanks for your help, and let me know if you ever get to the bottom of the case of the disappearing chutney.' WHERE Id=14059;

-- She Says Potato (14055)
-- She Says Potato (14058)
UPDATE quest_template SET RequestItemsText='Do you have those candied sweet potatoes?', OfferRewardText='These are perfect. Thanks for helping me with this, $N. The meal will get served on time and Ellen will be happy.' WHERE Id=14055;
UPDATE quest_template SET RequestItemsText='Do you have those candied sweet potatoes?', OfferRewardText='Thanks, $N. Now, I can help the hostess out and still keep my word to Roberta.' WHERE Id=14058;

-- Candied Sweet Potatoes (14033)
-- Candied Sweet Potatoes (14043)
UPDATE quest_template SET RequestItemsText='$N, it''s good to see you again.', OfferRewardText='Ah, candied sweet potatoes! My favorite! Did Isaac tell you?' WHERE Id=14033;
UPDATE quest_template SET RequestItemsText='Welcome back, $N.', OfferRewardText='So Dokin drafted you to help with the candied sweet potatoes?$B$B<Francis smiles.>$B$BIt''s the only way he can keep up. Thanks for bringing these.' WHERE Id=14043;

-- Easy As Pie (14054)
-- Easy As Pie (14060)
UPDATE quest_template SET RequestItemsText='How are those pies coming along?', OfferRewardText='These are perfect. Isaac, and everyone else, will love them!' WHERE Id=14054;
UPDATE quest_template SET RequestItemsText='How are those pies coming along?', OfferRewardText='These are great! Thank you for helping, $N.' WHERE Id=14060;

-- Can't Get Enough Turkey (14048)
-- Can't Get Enough Turkey (14061)
UPDATE quest_template SET RequestItemsText='Did you manage to find those turkeys?', OfferRewardText='These are just what I need. Thanks, $N. You''re a lifesaver.' WHERE Id=14048;
UPDATE quest_template SET RequestItemsText='How''s your turkey hunt going?', OfferRewardText='These turkeys are exactly what I needed. Thanks for helping me out of a tough situation.' WHERE Id=14061;

-- Pumpkin Pie (14024)
-- Pumpkin Pie (14040)
UPDATE quest_template SET RequestItemsText='More pumpkin pie? Just in time.', OfferRewardText='The pumpkin pie''s been a big hit up here. I''ve never seen a dwarf get so excited about anything made from a vegetable.' WHERE Id=14024;
UPDATE quest_template SET RequestItemsText='We can always use more pumpkin pie.', OfferRewardText='The pie always goes first. I think people must be skipping the meal and going directly for the dessert. Have you given it a try yet?' WHERE Id=14040;

-- Cranberry Chutney (14028)
-- Cranberry Chutney (14041)
UPDATE quest_template SET RequestItemsText='Is that cranberry chutney I smell?', OfferRewardText='Finally, the cranberry chutney I was promised. You wouldn''t believe how fast the celebrants go through the stuff here.' WHERE Id=14028;
UPDATE quest_template SET RequestItemsText='How are you enjoying Pilgrim''s Bounty, $C?', OfferRewardText='Ah, more cranberry chutney! You wouldn''t believe how fast the celebrants go through it.' WHERE Id=14041;

-- Slow-roasted Turkey (14035)
-- Slow-roasted Turkey (14047)
UPDATE quest_template SET RequestItemsText='What brings you back to Darnassus, $N?', OfferRewardText='These are beautiful and just in time to feed hungry feasters. Thank you, $N. You''ve truly mastered all the courses of a traditional Pilgrim''s Bounty meal.' WHERE Id=14035;
UPDATE quest_template SET RequestItemsText='What brings you back to Orgrimmar, $N?', OfferRewardText='These look perfect. Thank you, $N. You''ve truly mastered all the courses of a traditional Pilgrim''s Bounty meal.' WHERE Id=14047;

-- Undersupplied in the Undercity (14044)
UPDATE quest_template SET RequestItemsText='It''s good to see you again. $N.', OfferRewardText='Thanks for bringing everything. Some of the tables were starting to look a little bereft of serving dishes.' WHERE Id=14044;

-- They're Ravenous In Darnassus (14030)
UPDATE quest_template SET RequestItemsText='Have you come to partake of the Pilgrim''s Bounty feast?', OfferRewardText='Thanks for bringing everything. I was starting to get worried.$B$BWhile you''re here, you should try your hand at making some candied sweet potatoes.' WHERE Id=14030;


-- ---------------------------------
-- Achievements
-- ---------------------------------
-- "FOOD FIGHT!" (3579)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11168, 11178, 11179, 11180, 11181);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11168, 11178, 11179, 11180, 11181);
INSERT INTO achievement_criteria_data VALUES(11168, 16, 404, 0, ''),(11178, 16, 404, 0, ''),(11179, 16, 404, 0, ''),(11180, 16, 404, 0, ''),(11181, 16, 404, 0, '');

-- Now We're Cookin' (3576)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11119, 11118, 11120, 11121, 11122);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11119, 11118, 11120, 11121, 11122);
INSERT INTO achievement_criteria_data VALUES(11120, 14, 469, 0, ''),(11119, 14, 469, 0, ''),(11118, 14, 469, 0, ''),(11121, 14, 469, 0, ''),(11122, 14, 469, 0, '');
-- Now We're Cookin' (3577)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11123, 11124, 11125, 11126, 11127);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11123, 11124, 11125, 11126, 11127);
INSERT INTO achievement_criteria_data VALUES(11123, 14, 67, 0, ''),(11124, 14, 67, 0, ''),(11125, 14, 67, 0, ''),(11126, 14, 67, 0, ''),(11127, 14, 67, 0, '');

-- Pilgrim's Paunch (3556)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11078, 11079, 11080, 11081);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11078, 11079, 11080, 11081);
INSERT INTO achievement_criteria_data VALUES(11078, 6, 1657, 0, ''); -- Darnassus
INSERT INTO achievement_criteria_data VALUES(11079, 6, 809, 0, ''); -- Ironforge
INSERT INTO achievement_criteria_data VALUES(11080, 6, 3557, 0, ''); -- The Exodar
INSERT INTO achievement_criteria_data VALUES(11081, 6, 12, 0, ''); -- Stormwind

-- Pilgrim's Paunch (3557)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11082, 11083, 11084, 11085);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11082, 11083, 11084, 11085);
INSERT INTO achievement_criteria_data VALUES(11082, 6, 14, 0, ''); -- Orgirmmar
INSERT INTO achievement_criteria_data VALUES(11083, 6, 3470, 0, ''); -- Silvermoon
INSERT INTO achievement_criteria_data VALUES(11084, 6, 1638, 0, ''); -- TB
INSERT INTO achievement_criteria_data VALUES(11085, 6, 1497, 0, ''); -- Undercity

-- Pilgrim's Peril (3580)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11134, 11135, 11136, 11137);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11134, 11135, 11136, 11137);
INSERT INTO achievement_criteria_data VALUES(11134, 6, 14, 0, ''); -- Orgirmmar
INSERT INTO achievement_criteria_data VALUES(11134, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11135, 6, 3470, 0, ''); -- Silvermoon
INSERT INTO achievement_criteria_data VALUES(11135, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11136, 6, 1638, 0, ''); -- TB
INSERT INTO achievement_criteria_data VALUES(11136, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11137, 6, 1497, 0, ''); -- Undercity
INSERT INTO achievement_criteria_data VALUES(11137, 11, 0, 0, 'achievement_pb_pilgrims_peril');

-- Pilgrim's Peril (3581)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11139, 11140, 11138, 11141);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11139, 11140, 11138, 11141);
INSERT INTO achievement_criteria_data VALUES(11139, 6, 1657, 0, ''); -- Darnassus
INSERT INTO achievement_criteria_data VALUES(11139, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11140, 6, 809, 0, ''); -- Ironforge
INSERT INTO achievement_criteria_data VALUES(11140, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11138, 6, 3557, 0, ''); -- The Exodar
INSERT INTO achievement_criteria_data VALUES(11138, 11, 0, 0, 'achievement_pb_pilgrims_peril');
INSERT INTO achievement_criteria_data VALUES(11141, 6, 12, 0, ''); -- Stormwind
INSERT INTO achievement_criteria_data VALUES(11141, 11, 0, 0, 'achievement_pb_pilgrims_peril');

-- Turkey Lurkey (3559)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11163, 11164, 11165, 11158, 11159, 11160, 11161, 11162);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11163, 11164, 11165, 11158, 11159, 11160, 11161, 11162);
INSERT INTO achievement_criteria_data VALUES(11163, 2, 4, 10, ''); -- Blood Elf
INSERT INTO achievement_criteria_data VALUES(11164, 2, 4, 3, '');  -- Dwarf
INSERT INTO achievement_criteria_data VALUES(11165, 2, 4, 7, '');  -- Gnome
INSERT INTO achievement_criteria_data VALUES(11158, 2, 4, 1, '');  -- Human
INSERT INTO achievement_criteria_data VALUES(11159, 2, 4, 4, '');  -- Night Elf
INSERT INTO achievement_criteria_data VALUES(11160, 2, 4, 2, ''); -- Orc
INSERT INTO achievement_criteria_data VALUES(11161, 2, 4, 8, ''); -- Troll
INSERT INTO achievement_criteria_data VALUES(11162, 2, 4, 5, ''); -- Undead

-- Terokkar Turkey Time (3582)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(11142);
DELETE FROM disables WHERE sourceType=4 AND entry IN(11142);
INSERT INTO achievement_criteria_data VALUES(11142, 11, 0, 0, 'achievement_pb_terokkar_turkey_time');

-- The Turkinator (3578)
UPDATE creature_template SET faction=7, AIName='SmartAI' WHERE entry=32820;
DELETE FROM smart_scripts WHERE entryorguid=32820 AND source_type=0;
INSERT INTO smart_scripts VALUES(32820, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 85, 62014, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'cast spell on death');
DELETE FROM spell_script_names WHERE spell_id IN(62014);
INSERT INTO spell_script_names VALUES(62014, 'spell_pilgrims_bounty_turkey_tracker');

-- Reward
REPLACE INTO achievement_reward VALUES(3478, 168, 0, 44810, 28951, 'A Gobbler not yet Gobbled', 'Can you believe this Plump Turkey made it through November alive?$N$NSince all his friends have been served up on Bountiful Tables with sides of Cranberry Chutney and Spice Bread and... ooo... I''m getting hungry. But anyhow! He''s all alone, now, so I was hoping you might be willing to take care of him. There simply isn''t enough room left in my shop!$N$NJust keep him away from cooking fires, please. He gets this strange look in his eyes around them...$N$N-Breanni', 0);
REPLACE INTO achievement_reward VALUES(3656, 0, 168, 44810, 28951, 'A Gobbler not yet Gobbled', 'Can you believe this Plump Turkey made it through November alive?$N$NSince all his friends have been served up on Bountiful Tables with sides of Cranberry Chutney and Spice Bread and... ooo... I''m getting hungry. But anyhow! He''s all alone, now, so I was hoping you might be willing to take care of him. There simply isn''t enough room left in my shop!$N$NJust keep him away from cooking fires, please. He gets this strange look in his eyes around them...$N$N-Breanni', 0);

-- ---------------------------------
-- Vendors
-- ---------------------------------
UPDATE creature_template SET npcflag=128 WHERE entry IN(34682, 34645, 34681, 34783, 34683, 34684, 34685, 34787);
DELETE FROM npc_vendor WHERE entry IN(34682, 34645, 34681, 34783, 34683, 34684, 34685, 34787);
INSERT INTO npc_vendor VALUES(34682, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 46784, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 46809, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34682, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 44854, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 46809, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34645, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 44855, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 46809, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34681, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 46809, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34783, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 46796, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 46810, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34683, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 46797, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 46810, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34684, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 46793, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 46810, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34685, 0, 46888, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 159, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 2678, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 30817, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 44835, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 44853, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 46810, 0, 0, 0);
INSERT INTO npc_vendor VALUES(34787, 0, 46888, 0, 0, 0);

-- ---------------------------------
-- loot
-- ---------------------------------
DELETE FROM item_loot_template WHERE entry IN(46809, 46810);
INSERT INTO item_loot_template VALUES(46809, 44858, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46809, 44859, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46809, 44860, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46809, 44861, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46809, 44862, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46810, 46803, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46810, 46804, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46810, 46805, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46810, 46806, 100, 1, 0, 1, 1);
INSERT INTO item_loot_template VALUES(46810, 46807, 100, 1, 0, 1, 1);

DELETE FROM creature_loot_template WHERE entry=32820;
INSERT INTO creature_loot_template VALUES(32820, 44834, 100, 1, 0, 1, 1);

-- ---------------------------------
-- Creature spawns
-- ---------------------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid from game_event_creature WHERE eventEntry=26);
DELETE FROM creature WHERE guid IN(SELECT guid FROM game_event_creature WHERE eventEntry=26);
DELETE FROM creature WHERE guid BETWEEN 240400 AND 244399;
INSERT INTO creature VALUES(240413, 18927, 0, 1, 1, 0, 0, -8854.78, 649.83, 96.7417, 1.43117, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240414, 32823, 0, 1, 1, 0, 0, -5092.7, -803.861, 495.148, 0.164747, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240415, 32823, 0, 1, 1, 0, 0, -5079.45, -800.684, 495.127, 0.258995, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240416, 32823, 0, 1, 1, 0, 0, -5093.01, -795.451, 495.128, 3.49483, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240417, 32823, 0, 1, 1, 0, 0, -5082.28, -792.136, 495.678, 1.86906, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240418, 32820, 0, 1, 1, 0, 0, 1953.33, 1514.46, 88.0872, 5.32666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240419, 32820, 0, 1, 1, 0, 0, -14187, 731, 24.75, 1.778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240420, 32820, 0, 1, 1, 0, 0, -14286, 283.778, 32.739, 1.543, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240427, 34653, 0, 1, 1, 0, 0, -5071.89, -801.345, 495.128, 0.094064, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240428, 34708, 0, 1, 1, 0, 1, -5079.31, -809.352, 495.833, 1.53919, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240429, 34645, 0, 1, 1, 0, 0, -5076.66, -808.073, 495.833, 2.01829, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240430, 35340, 0, 1, 1, 0, 0, -5073.03, -787.526, 495.117, 4.57476, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240431, 34644, 0, 1, 1, 0, 1, -5084.24, -808.46, 495.832, 0.977634, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240432, 32823, 0, 1, 1, 0, 0, -9116.83, 309.643, 93.1605, 1.45805, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240433, 32823, 0, 1, 1, 0, 0, -9115.63, 320.223, 93.189, 1.45805, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240434, 32823, 0, 1, 1, 0, 0, -9114.71, 332.007, 93.1289, 1.50517, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240435, 32823, 0, 1, 1, 0, 0, -9113.9, 344.27, 93.6394, 1.50517, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240455, 34653, 0, 1, 1, 0, 0, -9118.91, 350.746, 93.735, 2.14134, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240456, 34710, 0, 1, 1, 0, 1, -9118.18, 359.164, 93.2702, 1.90179, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240457, 35337, 0, 1, 1, 0, 0, -9111.63, 353.697, 93.4015, 2.40837, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240458, 34744, 0, 1, 1, 0, 0, -9127.56, 351.404, 94.2329, 2.13741, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240459, 34682, 0, 1, 1, 0, 0, -9110.83, 366.354, 94.0632, 2.67934, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240460, 34675, 0, 1, 1, 0, 1, -9125.02, 352.824, 94.2342, 2.1217, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240461, 32823, 1, 1, 1, 0, 0, 9992.89, 2213.08, 1328.19, 3.36582, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240462, 32823, 1, 1, 1, 0, 0, 9981.25, 2210.43, 1328.79, 3.36582, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240463, 32823, 1, 1, 1, 0, 0, 9993.91, 2203.28, 1327.78, 3.25587, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240464, 32823, 1, 1, 1, 0, 0, 9983.74, 2200.09, 1328.61, 3.29906, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240487, 35338, 1, 1, 1, 0, 0, 9992.78, 2238.74, 1330.6, 3.11451, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240488, 35338, 1, 1, 1, 0, 0, 9989.53, 2237.63, 1330.96, 3.11451, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240489, 35338, 1, 1, 1, 0, 0, 9987.13, 2238.11, 1331.16, 2.8082, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240490, 34711, 1, 1, 1, 0, 1, 10001.8, 2228.02, 1330.16, 2.9535, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240491, 34653, 1, 1, 1, 0, 0, 9975.5, 2212.18, 1329.26, 3.14199, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240492, 34681, 1, 1, 1, 0, 0, 9982.08, 2243.54, 1332.54, 3.01633, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240493, 34676, 1, 1, 1, 0, 1, 9982.13, 2246.34, 1332.72, 3.12629, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240494, 32823, 530, 1, 1, 0, 0, -3975.02, -11870.6, 0.510499, 1.83564, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240495, 32823, 530, 1, 1, 0, 0, -3966.15, -11868.9, 0.677072, 4.56098, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240496, 32823, 530, 1, 1, 0, 0, -3967.7, -11879, 0.698275, 4.67093, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240497, 32823, 530, 1, 1, 0, 0, -3975.57, -11879.1, 0.563379, 4.59239, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240518, 34653, 530, 1, 1, 0, 0, -3978.75, -11863, 0.438156, 3.94051, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240519, 34785, 530, 1, 1, 0, 0, -3957.89, -11863, 0.778528, 3.47713, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240520, 34783, 530, 1, 1, 0, 0, -3981.01, -11861.1, 1.12189, 4.16906, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240521, 35340, 530, 1, 1, 0, 0, -3955.87, -11866.3, 0.850197, 5.07934, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240522, 32823, 1, 1, 1, 0, 0, 1282.83, -4418.29, 26.5714, 0.327693, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240523, 32823, 1, 1, 1, 0, 0, 1274.4, -4425.46, 26.665, 0.704684, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240524, 32823, 1, 1, 1, 0, 0, 1280.76, -4432.94, 27.0913, 0.704684, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240525, 32823, 1, 1, 1, 0, 0, 1290.11, -4426.16, 26.7342, 0.641852, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240526, 34654, 1, 1, 1, 0, 0, 1293.13, -4405.79, 26.3839, 4.12117, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240531, 35342, 1, 1, 1, 0, 0, 1296.57, -4421.63, 26.6309, 5.13825, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240532, 35342, 1, 1, 1, 0, 0, 1294.78, -4421.96, 26.6249, 5.14218, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240533, 35342, 1, 1, 1, 0, 0, 1293.33, -4420.44, 26.5897, 5.25292, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240534, 34713, 1, 1, 1, 0, 0, 1300.64, -4407.67, 26.5393, 3.71747, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240535, 34679, 1, 1, 1, 0, 1, 1296.81, -4417.88, 27.3402, 2.33909, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240536, 34685, 1, 1, 1, 0, 0, 1294.88, -4419.93, 27.2965, 2.29982, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240553, 32823, 1, 1, 1, 0, 0, -1328.29, 188.777, 60.5313, 3.36455, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240554, 32823, 1, 1, 1, 0, 0, -1321.55, 190.334, 59.733, 3.36848, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240555, 32823, 1, 1, 1, 0, 0, -1330.56, 196.448, 59.9585, 3.26245, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240556, 32823, 1, 1, 1, 0, 0, -1323.39, 197.319, 59.3536, 3.26245, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240577, 34714, 1, 1, 1, 0, 0, -1314.67, 206.382, 58.8653, 3.50594, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240578, 34654, 1, 1, 1, 0, 0, -1337.67, 190.598, 60.8631, 4.17745, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240579, 35343, 1, 1, 1, 0, 0, -1317.71, 208.647, 58.8602, 5.42231, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240580, 35343, 1, 1, 1, 0, 0, -1317.08, 185.668, 59.6624, 4.92751, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240581, 34684, 1, 1, 1, 0, 0, -1313.09, 189.957, 59.9336, 2.56739, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240582, 34678, 1, 1, 1, 0, 1, -1311.92, 192.569, 59.8367, 2.6852, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240583, 32823, 0, 1, 1, 0, 0, 1834.55, 253.055, 59.7593, 2.898, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240584, 32823, 0, 1, 1, 0, 0, 1824.34, 255.595, 59.9598, 2.898, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240585, 32823, 0, 1, 1, 0, 0, 1836.01, 219.866, 60.2, 2.98046, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240586, 32823, 0, 1, 1, 0, 0, 1826.08, 221.479, 60.564, 2.98046, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240607, 34654, 0, 1, 1, 0, 0, 1828.25, 248.785, 59.9713, 4.91178, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240608, 34654, 0, 1, 1, 0, 0, 1830.22, 228.484, 60.2551, 1.65238, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240609, 34712, 0, 1, 1, 0, 0, 1822.06, 266.801, 60.0993, 5.01388, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240610, 34768, 0, 1, 1, 0, 0, 1817.01, 258.573, 60.721, 4.95498, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240611, 34683, 0, 1, 1, 0, 0, 1814.56, 257.735, 60.6853, 4.9589, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240612, 34677, 0, 1, 1, 0, 1, 1811.74, 257.052, 60.6289, 4.87643, 300, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240613, 35341, 0, 1, 1, 0, 0, 1827.28, 266.018, 60.0083, 0.203308, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240614, 35341, 0, 1, 1, 0, 0, 1830.09, 263.893, 59.7316, 0.22687, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240615, 35341, 0, 1, 1, 0, 0, 1818.25, 260.215, 60.0523, 4.03212, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240616, 32823, 530, 1, 1, 0, 0, 9298, -7223.78, 16.7799, 1.75493, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240617, 32823, 530, 1, 1, 0, 0, 9296.96, -7213.65, 16.3391, 1.67246, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240618, 32823, 530, 1, 1, 0, 0, 9289.92, -7224.35, 16.434, 1.69603, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240619, 32823, 530, 1, 1, 0, 0, 9288.17, -7214.89, 16.2739, 1.80598, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240640, 34654, 530, 1, 1, 0, 0, 9304.13, -7219.49, 16.4335, 5.7801, 300, 0, 0, 5342, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240641, 34787, 530, 1, 1, 0, 0, 9305.74, -7211.06, 16.6184, 5.76831, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240642, 34786, 530, 1, 1, 0, 0, 9282.31, -7206.7, 16.6141, 5.7094, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240643, 35342, 530, 1, 1, 0, 0, 9285.98, -7199.02, 17.4229, 5.64657, 600, 0, 0, 1524, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(240644, 32820, 0, 1, 1, 0, 0, 2008.17, 1571.98, 78.9962, 2.06544, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240645, 32820, 0, 1, 1, 0, 0, -11550, -228, 28.285, 6.161, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240646, 32820, 0, 1, 1, 0, 0, 2041.98, 1535.7, 77.489, 5.11492, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240647, 32820, 0, 1, 1, 0, 0, 2034.85, 1631.35, 70.8452, 4.14039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240648, 32820, 0, 1, 1, 0, 0, 1927.26, 1692.24, 80.6916, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240649, 32820, 0, 1, 1, 0, 0, 1998.23, 1590.11, 80.3288, 0.610921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240650, 32820, 0, 1, 1, 0, 0, 2051.76, 1763.78, 87.6605, 5.93412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240651, 32820, 0, 1, 1, 0, 0, 2118.09, 1685.36, 75.11, 1.20324, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240652, 32820, 0, 1, 1, 0, 0, 2084.58, 1630.43, 71.3452, 2.4115, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240653, 32820, 0, 1, 1, 0, 0, 2139.72, 1655.26, 79.3505, 2.00735, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240654, 32820, 0, 1, 1, 0, 0, -10836, -2953, 13.941, 3.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240655, 32820, 0, 1, 1, 0, 0, -10779, -1194, 35.275, 0.915, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240656, 32820, 0, 1, 1, 0, 0, -10575, -3377, 22.344, 0.017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240657, 32820, 0, 1, 1, 0, 0, -10559, 1206.87, 31.476, 5.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240658, 32820, 0, 1, 1, 0, 0, -10181, 83.288, 24.122, 4.197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240659, 32820, 0, 1, 1, 0, 0, -10170, 227.366, 22.462, 1.415, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240660, 32820, 0, 1, 1, 0, 0, -10154, 619.3, 27.052, 4.304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240661, 32820, 0, 1, 1, 0, 0, -10149, 1053.31, 36.284, 5.61, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240662, 32820, 0, 1, 1, 0, 0, -10111, 648.959, 36.886, 5.357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240663, 32820, 0, 1, 1, 0, 0, -10107, 690.702, 32.081, 3.962, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240664, 32820, 0, 1, 1, 0, 0, -10085, 687.327, 35.046, 5.849, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240665, 32820, 0, 1, 1, 0, 0, -10083, 545.919, 29.148, 0.695, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240666, 32820, 0, 1, 1, 0, 0, -10071, 633.184, 39.449, 6.174, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240667, 32820, 0, 1, 1, 0, 0, -10059, 155.731, 27.684, 3.863, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240668, 32820, 0, 1, 1, 0, 0, -10056, 553.198, 32.706, 2.992, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240669, 32820, 0, 1, 1, 0, 0, -10055, 49.171, 31.882, 3.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240670, 32820, 0, 1, 1, 0, 0, -10049, 48.827, 32.967, 5.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240671, 32820, 0, 1, 1, 0, 0, -10045, 225.886, 27.451, 3.413, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240672, 32820, 0, 1, 1, 0, 0, -10043, 139.908, 28.927, 3.603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240673, 32820, 0, 1, 1, 0, 0, -10042, 139.466, 29.229, 1.223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240674, 32820, 0, 1, 1, 0, 0, -10042, 674.065, 36.148, 2.347, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240675, 32820, 0, 1, 1, 0, 0, -10039, 283.298, 30.42, 6.267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240676, 32820, 0, 1, 1, 0, 0, -10033, 72.485, 34.809, 0.916, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240677, 32820, 0, 1, 1, 0, 0, -10031, 143.328, 31.699, 0.896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240678, 32820, 0, 1, 1, 0, 0, -10027, 185.975, 29.686, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240679, 32820, 0, 1, 1, 0, 0, -10022, 20.283, 36.088, 5.391, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240680, 32820, 0, 1, 1, 0, 0, -10019, 660.572, 36.286, 1.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240681, 32820, 0, 1, 1, 0, 0, -10017, 654.089, 37.149, 5.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240682, 32820, 0, 1, 1, 0, 0, -10016, 383.118, 33.056, 5.043, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240683, 32820, 0, 1, 1, 0, 0, -10014, 37.605, 35.253, 0.768, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240684, 32820, 0, 1, 1, 0, 0, -10014, 108.05, 33.946, 2.447, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240685, 32820, 0, 1, 1, 0, 0, -10012, 216.285, 30.095, 1.123, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240686, 32820, 0, 1, 1, 0, 0, -10010, 325.804, 32.068, 2.688, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240687, 32820, 0, 1, 1, 0, 0, -10010, 582.399, 38.946, 5.949, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240688, 32820, 0, 1, 1, 0, 0, -10008, 65.212, 34.866, 0.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240689, 32820, 0, 1, 1, 0, 0, -10008, 209.363, 30.628, 0.802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240690, 32820, 0, 1, 1, 0, 0, -10008, 225.141, 30.128, 3.086, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240691, 32820, 0, 1, 1, 0, 0, -10005, 52.82, 34.654, 0.297, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240692, 32820, 0, 1, 1, 0, 0, -10002, 657.114, 36.623, 1.815, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240693, 32820, 0, 1, 1, 0, 0, -9999, 206.431, 30.798, 0.059, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240694, 32820, 0, 1, 1, 0, 0, -9999, 273.547, 32.871, 0.12, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240695, 32820, 0, 1, 1, 0, 0, -9997, 356.614, 35.086, 5.825, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240696, 32820, 0, 1, 1, 0, 0, -9997, 665.204, 36.668, 3.77, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240697, 32820, 0, 1, 1, 0, 0, -9995, 471.122, 33.046, 5.384, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240698, 32820, 0, 1, 1, 0, 0, -9993, 233.377, 30.43, 3.647, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240699, 32820, 0, 1, 1, 0, 0, -9993, 298.491, 34.711, 1.195, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240700, 32820, 0, 1, 1, 0, 0, -9993, 319.126, 35.156, 5.748, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240701, 32820, 0, 1, 1, 0, 0, -9991, 474.728, 33.654, 6.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240702, 32820, 0, 1, 1, 0, 0, -9990, 310.445, 35.333, 3.769, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240703, 32820, 0, 1, 1, 0, 0, -9989, -1478, 24.047, 5.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240704, 32820, 0, 1, 1, 0, 0, -9989, 238.463, 30.235, 2.087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240705, 32820, 0, 1, 1, 0, 0, -9989, 270.974, 33.069, 1.406, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240706, 32820, 0, 1, 1, 0, 0, -9988, 472.114, 34.029, 1.646, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240707, 32820, 0, 1, 1, 0, 0, -9987, 303.128, 34.983, 3.132, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240708, 32820, 0, 1, 1, 0, 0, -9986, 191.426, 31.517, 1.057, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240709, 32820, 0, 1, 1, 0, 0, -9986, 453.746, 35.546, 0.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240710, 32820, 0, 1, 1, 0, 0, -9985, 446.073, 36.32, 4.079, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240711, 32820, 0, 1, 1, 0, 0, -9984, 448.163, 36.195, 5.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240712, 32820, 0, 1, 1, 0, 0, -9982, 562.627, 37.885, 1.274, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240713, 32820, 0, 1, 1, 0, 0, -9981, 542.102, 37.19, 5.026, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240714, 32820, 0, 1, 1, 0, 0, -9980, 156.79, 34.349, 0.199, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240715, 32820, 0, 1, 1, 0, 0, -9979, 644.991, 37.125, 5.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240716, 32820, 0, 1, 1, 0, 0, -9976, -24, 35.04, 2.754, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240717, 32820, 0, 1, 1, 0, 0, -9975, -27, 34.762, 4.23, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240718, 32820, 0, 1, 1, 0, 0, -9975, 292.899, 36.336, 4.86, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240719, 32820, 0, 1, 1, 0, 0, -9853.68, 284.862, 37.987, 1.89787, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240720, 32820, 0, 1, 1, 0, 0, -9962, 307.319, 36.992, 0.284, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240721, 32820, 0, 1, 1, 0, 0, -9961, 917.581, 44.361, 0.689, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240722, 32820, 0, 1, 1, 0, 0, -9960, -144, 24.59, 0.618, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240723, 32820, 0, 1, 1, 0, 0, -9959, 925.294, 45.374, 5.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240724, 32820, 0, 1, 1, 0, 0, -9957, -1421, 25.077, 0.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240725, 32820, 0, 1, 1, 0, 0, -9957, -1280, 24.766, 2.885, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240726, 32820, 0, 1, 1, 0, 0, -9957, -274, 26.367, 3.351, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240727, 32820, 0, 1, 1, 0, 0, -9957, -46, 33.197, 3.964, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240728, 32820, 0, 1, 1, 0, 0, -9955, 41.774, 33.476, 1.127, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240729, 32820, 0, 1, 1, 0, 0, -9954, 554.6, 39.256, 0.457, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240730, 32820, 0, 1, 1, 0, 0, -9952, -133, 25.452, 3.594, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240731, 32820, 0, 1, 1, 0, 0, -9952, -19, 34.434, 5.494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240732, 32820, 0, 1, 1, 0, 0, -9951, 675.731, 32.108, 3.045, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240733, 32820, 0, 1, 1, 0, 0, -9950, 413.263, 35.043, 3.409, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240734, 32820, 0, 1, 1, 0, 0, -9950, 615.613, 37.291, 1.169, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240735, 32820, 0, 1, 1, 0, 0, -9950, 621.918, 37.356, 5.061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240736, 32820, 0, 1, 1, 0, 0, -9948, -55, 32.847, 5.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240737, 32820, 0, 1, 1, 0, 0, -9948, -20, 34.2, 5.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240738, 32820, 0, 1, 1, 0, 0, -9947, -44, 33.23, 1.308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240739, 32820, 0, 1, 1, 0, 0, -9946, 129.134, 33.365, 0.596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240740, 32820, 0, 1, 1, 0, 0, -9946, 604.266, 38.356, 1.857, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240741, 32820, 0, 1, 1, 0, 0, -9958.61, -153.27, 22.3896, 5.7039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240742, 32820, 0, 1, 1, 0, 0, -9942, -1560, 25.45, 2.348, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240743, 32820, 0, 1, 1, 0, 0, -9937, 650.755, 33.537, 0.565, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240744, 32820, 0, 1, 1, 0, 0, -9936, 583.854, 37.895, 3.957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240745, 32820, 0, 1, 1, 0, 0, -9933, -1164, 20.941, 4.451, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240746, 32820, 0, 1, 1, 0, 0, -9933, -1093, 23.46, 6.133, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240747, 32820, 0, 1, 1, 0, 0, -9931, -45, 30.883, 5.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240748, 32820, 0, 1, 1, 0, 0, -9929, -1157, 22.215, 3.421, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240749, 32820, 0, 1, 1, 0, 0, -9929, -1098, 24.09, 2.897, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240750, 32820, 0, 1, 1, 0, 0, -9928, -1452, 27.62, 1.308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240751, 32820, 0, 1, 1, 0, 0, -9925, -90, 29.881, 0.517, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240752, 32820, 0, 1, 1, 0, 0, -9924, -979, 20.854, 2.209, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240753, 32820, 0, 1, 1, 0, 0, -9924, 38.387, 32.595, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240754, 32820, 0, 1, 1, 0, 0, -9923, -1477, 24.17, 2.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240755, 32820, 0, 1, 1, 0, 0, -9923, 79.156, 32.697, 3.526, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240756, 32820, 0, 1, 1, 0, 0, -9921, -1244, 25.03, 2.628, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240757, 32820, 0, 1, 1, 0, 0, -9920, -419, 24.92, 3.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240758, 32820, 0, 1, 1, 0, 0, -9920, 613.934, 40.759, 3.77, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240759, 32820, 0, 1, 1, 0, 0, -9919, -64, 30.693, 1.277, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240760, 32820, 0, 1, 1, 0, 0, -9918, -839, 20.029, 1.622, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240761, 32820, 0, 1, 1, 0, 0, -9918, 42.296, 32.719, 2.63, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240762, 32820, 0, 1, 1, 0, 0, -9918, 415.128, 35.311, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240763, 32820, 0, 1, 1, 0, 0, -9917, 599.298, 39.564, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240764, 32820, 0, 1, 1, 0, 0, -9914, -1657, 22.859, 4.768, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240765, 32820, 0, 1, 1, 0, 0, -9914, -1056, 25.676, 4.699, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240766, 32820, 0, 1, 1, 0, 0, -9914, -911, 23.237, 2.325, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240767, 32820, 0, 1, 1, 0, 0, -9913, 646.473, 36.822, 4.221, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240768, 32820, 0, 1, 1, 0, 0, -9911, -377, 31.405, 5.939, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240769, 32820, 0, 1, 1, 0, 0, -9911, 456.769, 34.47, 2.141, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240770, 32820, 0, 1, 1, 0, 0, -9910, -894, 23.534, 0.697, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240771, 32820, 0, 1, 1, 0, 0, -9908, -1489, 26.38, 5.963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240772, 32820, 0, 1, 1, 0, 0, -9907, -331, 33.75, 3.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240773, 32820, 0, 1, 1, 0, 0, -9906, -56, 29.896, 0.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240774, 32820, 0, 1, 1, 0, 0, -9902, 81.655, 32.322, 5.607, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240775, 32820, 0, 1, 1, 0, 0, -9901, -1281, 32.436, 4.133, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240776, 32820, 0, 1, 1, 0, 0, -9901, -303, 34.373, 0.437, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240777, 32820, 0, 1, 1, 0, 0, -9896, -1061, 28.464, 5.99, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240778, 32820, 0, 1, 1, 0, 0, -9896, 329.928, 36.451, 1.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240779, 32820, 0, 1, 1, 0, 0, -9895, -1281, 33.821, 4.304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240780, 32820, 0, 1, 1, 0, 0, -9892, -1359, 34.463, 6.268, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240781, 32820, 0, 1, 1, 0, 0, -9892, -296, 34.618, 3.511, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240782, 32820, 0, 1, 1, 0, 0, -9891, -291, 34.098, 3.514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240783, 32820, 0, 1, 1, 0, 0, -9890, -1332, 32.508, 3.66, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240784, 32820, 0, 1, 1, 0, 0, -9890, 338.467, 36.649, 2.758, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240785, 32820, 0, 1, 1, 0, 0, -9770.83, 279.166, 43.1248, 0.1198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240786, 32820, 0, 1, 1, 0, 0, -9833.96, 188.524, 22.577, 5.79556, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240787, 32820, 0, 1, 1, 0, 0, -9887, -749, 22.768, 1.657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240788, 32820, 0, 1, 1, 0, 0, -9884, -299, 34.827, 2.17, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240789, 32820, 0, 1, 1, 0, 0, -9883, -1496, 29.322, 2.166, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240790, 32820, 0, 1, 1, 0, 0, -9883, -1017, 29.945, 0.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240791, 32820, 0, 1, 1, 0, 0, -9882, -446, 30.028, 3.263, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240792, 32820, 0, 1, 1, 0, 0, -9882, 685.787, 34.208, 0.54, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240793, 32820, 0, 1, 1, 0, 0, -9881, 322.619, 37.824, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240794, 32820, 0, 1, 1, 0, 0, -9879, -816, 28.519, 1.704, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240795, 32820, 0, 1, 1, 0, 0, -9878, -309, 36.016, 0.577, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240796, 32820, 0, 1, 1, 0, 0, -9876, -1097, 27.52, 0.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240797, 32820, 0, 1, 1, 0, 0, -9876, -15, 26.9, 1.334, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240798, 32820, 0, 1, 1, 0, 0, -9870, -1232, 31.674, 2.685, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240799, 32820, 0, 1, 1, 0, 0, -9869, -1537, 26.111, 0.722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240800, 32820, 0, 1, 1, 0, 0, -9867, -917, 36.258, 0.774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240801, 32820, 0, 1, 1, 0, 0, -9953.17, 491.623, 31.376, 1.92737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240802, 32820, 0, 1, 1, 0, 0, -9865, -222, 35.965, 0.876, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240803, 32820, 0, 1, 1, 0, 0, -9864, -190, 35.805, 5.313, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240804, 32820, 0, 1, 1, 0, 0, -9864, 932.292, 31.144, 4.844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240805, 32820, 0, 1, 1, 0, 0, -9862, -1481, 32.855, 0.064, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240806, 32820, 0, 1, 1, 0, 0, -9861, -124, 28.832, 2.762, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240807, 32820, 0, 1, 1, 0, 0, -9859.72, -226.423, 35.9223, 0.545298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240808, 32820, 0, 1, 1, 0, 0, -9860, -129, 29.292, 0.763, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240809, 32820, 0, 1, 1, 0, 0, -9860, 471.51, 36.643, 4.627, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240810, 32820, 0, 1, 1, 0, 0, -9860, 924.283, 30.318, 1.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240811, 32820, 0, 1, 1, 0, 0, -9859, 922.723, 30.178, 0.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240812, 32820, 0, 1, 1, 0, 0, -9858, 365.972, 36.337, 1.815, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240813, 32820, 0, 1, 1, 0, 0, -9857, -930, 37.532, 2.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240814, 32820, 0, 1, 1, 0, 0, -9857, -715, 30.994, 3.81, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240815, 32820, 0, 1, 1, 0, 0, -9857, -135, 29.663, 6.193, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240816, 32820, 0, 1, 1, 0, 0, -9857, 671.134, 37.354, 2.036, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240817, 32820, 0, 1, 1, 0, 0, -9856, -1199, 32.526, 2.099, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240818, 32820, 0, 1, 1, 0, 0, -9856, -920, 38.461, 1.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240819, 32820, 0, 1, 1, 0, 0, -9855, -1380, 40.682, 1.781, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240820, 32820, 0, 1, 1, 0, 0, -9854, -993, 36.544, 1.231, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240821, 32820, 0, 1, 1, 0, 0, -9853, -1134, 27.79, 0.14, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240822, 32820, 0, 1, 1, 0, 0, -9851, -913, 39.336, 2.219, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240823, 32820, 0, 1, 1, 0, 0, -9850, -593, 20.515, 4.231, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240824, 32820, 0, 1, 1, 0, 0, -9850, 644.698, 39.705, 3.528, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240825, 32820, 0, 1, 1, 0, 0, -9804.73, 240.662, 41.1706, 4.86251, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240826, 32820, 0, 1, 1, 0, 0, -9848, -1652, 22.788, 0.41, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240827, 32820, 0, 1, 1, 0, 0, -9847, -1585, 26.385, 2.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240828, 32820, 0, 1, 1, 0, 0, -9845, -924, 40.598, 6.244, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240829, 32820, 0, 1, 1, 0, 0, -9843, -1486, 35.741, 4.619, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240830, 32820, 0, 1, 1, 0, 0, -9841, -514, 28.703, 0.697, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240831, 32820, 0, 1, 1, 0, 0, -9840, -1050, 34.617, 4.469, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240832, 32820, 0, 1, 1, 0, 0, -9840, -839, 38.619, 4.48, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240833, 32820, 0, 1, 1, 0, 0, -9840, 94.95, 38.219, 3.128, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240834, 32820, 0, 1, 1, 0, 0, -9839, -1016, 36.34, 3.464, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240835, 32820, 0, 1, 1, 0, 0, -9836, -1589, 27.767, 5.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240836, 32820, 0, 1, 1, 0, 0, -9836, -1503, 39.312, 5.869, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240837, 32820, 0, 1, 1, 0, 0, -9835, -1180, 33.735, 6.256, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240838, 32820, 0, 1, 1, 0, 0, -9835, -1014, 36.715, 3.416, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240839, 32820, 0, 1, 1, 0, 0, -9834, -1641, 27.372, 0.369, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240840, 32820, 0, 1, 1, 0, 0, -9843.61, 198.627, 22.7217, 5.28962, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240841, 32820, 0, 1, 1, 0, 0, -9832, -1498, 39.74, 5.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240842, 32820, 0, 1, 1, 0, 0, -9831, -919, 41.841, 3.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240843, 32820, 0, 1, 1, 0, 0, -9829, -546, 26.926, 2.84, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240844, 32820, 0, 1, 1, 0, 0, -9829, 471.386, 36.938, 0.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240845, 32820, 0, 1, 1, 0, 0, -9829, 562.429, 39.357, 6.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240846, 32820, 0, 1, 1, 0, 0, -9826, -1192, 35.56, 4.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240847, 32820, 0, 1, 1, 0, 0, -9826, 261.761, 40.683, 1.78, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240848, 32820, 0, 1, 1, 0, 0, -9826, 285.082, 38.577, 1.575, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240849, 32820, 0, 1, 1, 0, 0, -9826, 543.539, 36.069, 1.571, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240850, 32820, 0, 1, 1, 0, 0, -9826, 550.792, 37.732, 4.378, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240851, 32820, 0, 1, 1, 0, 0, -9825, -358, 54.618, 2.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240852, 32820, 0, 1, 1, 0, 0, -9825, 269.418, 39.451, 3.454, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240853, 32820, 0, 1, 1, 0, 0, -9824, 81.413, 3.073, 4.745, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240854, 32820, 0, 1, 1, 0, 0, -9823, 39.419, 32.713, 5.261, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240855, 32820, 0, 1, 1, 0, 0, -9822, 180.986, 22.808, 0.379, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240856, 32820, 0, 1, 1, 0, 0, -9821, -1582, 30.796, 5.815, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240857, 32820, 0, 1, 1, 0, 0, -9821, -760, 37.255, 3.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240858, 32820, 0, 1, 1, 0, 0, -9821, -235, 37.324, 4.182, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240859, 32820, 0, 1, 1, 0, 0, -9821, 270.262, 39.826, 3.543, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240860, 32820, 0, 1, 1, 0, 0, -9820, -1186, 35.621, 0.891, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240861, 32820, 0, 1, 1, 0, 0, -9806.61, 181.334, 22.481, 0.226278, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240862, 32820, 0, 1, 1, 0, 0, -9819, -1014, 38.261, 2.284, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240863, 32820, 0, 1, 1, 0, 0, -9819, 271.888, 39.745, 3.47, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240864, 32820, 0, 1, 1, 0, 0, -9819, 448.569, 36.18, 4.211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240865, 32820, 0, 1, 1, 0, 0, -9818, -173, 33.968, 0.393, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240866, 32820, 0, 1, 1, 0, 0, -9818, -77, 25.713, 3.213, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240867, 32820, 0, 1, 1, 0, 0, -9818, 470.864, 36.726, 3.236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240868, 32820, 0, 1, 1, 0, 0, -9818, 610.676, 41.971, 1.021, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240869, 32820, 0, 1, 1, 0, 0, -9817, -856, 39.261, 5.935, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240870, 32820, 0, 1, 1, 0, 0, -9817, -291, 41.486, 3.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240871, 32820, 0, 1, 1, 0, 0, -9817, -81, 26.183, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240872, 32820, 0, 1, 1, 0, 0, -9817, 49.706, 34.991, 3.594, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240873, 32820, 0, 1, 1, 0, 0, -9817, 139.933, 5.035, 4.008, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240874, 32820, 0, 1, 1, 0, 0, -9817, 415.699, 36.716, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240875, 32820, 0, 1, 1, 0, 0, -9816, -184, 36.307, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240876, 32820, 0, 1, 1, 0, 0, -9816, 451.863, 36.203, 4.279, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240877, 32820, 0, 1, 1, 0, 0, -9815, -1161, 34.012, 4.563, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240878, 32820, 0, 1, 1, 0, 0, -9815, -1034, 37.253, 4.324, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240879, 32820, 0, 1, 1, 0, 0, -9815, -120, 28.903, 6.033, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240880, 32820, 0, 1, 1, 0, 0, -9813, -1023, 37.602, 1.692, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240881, 32820, 0, 1, 1, 0, 0, -9812, -1007, 39.106, 6.136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240882, 32820, 0, 1, 1, 0, 0, -9809, -8, 27.107, 2.378, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240883, 32820, 0, 1, 1, 0, 0, -9818.85, 181.23, 22.8492, 3.23508, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240884, 32820, 0, 1, 1, 0, 0, -9808, -1257, 35.589, 3.087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240885, 32820, 0, 1, 1, 0, 0, -9808, -931, 39.855, 0.515, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240886, 32820, 0, 1, 1, 0, 0, -9808, 700.085, 33.112, 4.485, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240887, 32820, 0, 1, 1, 0, 0, -9806, -932, 39.941, 1.082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240888, 32820, 0, 1, 1, 0, 0, -9806, -927, 39.94, 4.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240889, 32820, 0, 1, 1, 0, 0, -9806, 444.748, 36.487, 4.376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240890, 32820, 0, 1, 1, 0, 0, -9803, 369.894, 39.797, 0.106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240891, 32820, 0, 1, 1, 0, 0, -9803, 698.179, 33.112, 4.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240892, 32820, 0, 1, 1, 0, 0, -9801, -339, 50.996, 2.859, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240893, 32820, 0, 1, 1, 0, 0, -9828.89, 215.772, 15.5806, 4.06545, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240894, 32820, 0, 1, 1, 0, 0, -9801, 428.308, 37.763, 5.009, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240895, 32820, 0, 1, 1, 0, 0, -9800, -1545, 40.87, 6.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240896, 32820, 0, 1, 1, 0, 0, -9800, -69, 25.769, 2.678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240897, 32820, 0, 1, 1, 0, 0, -9799, -84, 25.817, 2.924, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240898, 32820, 0, 1, 1, 0, 0, -9799, 109.791, 24.437, 2.13, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240899, 32820, 0, 1, 1, 0, 0, -9825.36, 199.121, 13.9991, 5.394, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240900, 32820, 0, 1, 1, 0, 0, -9798, -1566, 37.678, 4.835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240901, 32820, 0, 1, 1, 0, 0, -9798, -71, 25.992, 2.625, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240902, 32820, 0, 1, 1, 0, 0, -9798, 460.417, 36.02, 1.952, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240903, 32820, 0, 1, 1, 0, 0, -9797, -1545, 41.124, 6.074, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240904, 32820, 0, 1, 1, 0, 0, -9797, 99.441, 27.848, 3.72, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240905, 32820, 0, 1, 1, 0, 0, -9797, 140.117, 23.51, 0.629, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240906, 32820, 0, 1, 1, 0, 0, -9796, -1328, 44.102, 3.989, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240907, 32820, 0, 1, 1, 0, 0, -9796, -92, 26.825, 4.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240908, 32820, 0, 1, 1, 0, 0, -9768.37, 231.5, 46.3995, 2.64377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240909, 32820, 0, 1, 1, 0, 0, -9795, 109.769, 46.1, 1.688, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240910, 32820, 0, 1, 1, 0, 0, -9795, 470.588, 35.875, 5.219, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240911, 32820, 0, 1, 1, 0, 0, -9793, -76, 26.349, 0.763, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240912, 32820, 0, 1, 1, 0, 0, -9790, -891, 40.109, 0.336, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240913, 32820, 0, 1, 1, 0, 0, -9790, 811.494, 25.983, 5.441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240914, 32820, 0, 1, 1, 0, 0, -9789, -52, 26.779, 3.638, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240915, 32820, 0, 1, 1, 0, 0, -9788, 111.106, 46.738, 4.66, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240916, 32820, 0, 1, 1, 0, 0, -9787, -555, 32.218, 1.918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240917, 32820, 0, 1, 1, 0, 0, -9787, 446.78, 37.712, 3.265, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240918, 32820, 0, 1, 1, 0, 0, -9787, 731.342, 33.005, 2.531, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240919, 32820, 0, 1, 1, 0, 0, -9786, -338, 52.05, 3.137, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240920, 32820, 0, 1, 1, 0, 0, -9785, -1131, 35.206, 4.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240921, 32820, 0, 1, 1, 0, 0, -9785, -369, 53.851, 0.932, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240922, 32820, 0, 1, 1, 0, 0, -9785, -312, 47.715, 1.767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240923, 32820, 0, 1, 1, 0, 0, -9784, -1540, 43.124, 6.088, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240924, 32820, 0, 1, 1, 0, 0, -9784, -984, 40.225, 2.491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240925, 32820, 0, 1, 1, 0, 0, -9784, 583.306, 37.658, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240926, 32820, 0, 1, 1, 0, 0, -9783, -643, 38.064, 3.106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240927, 32820, 0, 1, 1, 0, 0, -9783, -206, 40.169, 4.714, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240928, 32820, 0, 1, 1, 0, 0, -9783, 108.722, 46.037, 1.602, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240929, 32820, 0, 1, 1, 0, 0, -9782, -1214, 40.11, 4.743, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240930, 32820, 0, 1, 1, 0, 0, -9781, -340, 52.759, 6.267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240931, 32820, 0, 1, 1, 0, 0, -9781, 38.677, 34.476, 3.719, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240932, 32820, 0, 1, 1, 0, 0, -9781, 818.493, 25.876, 5.222, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240933, 32820, 0, 1, 1, 0, 0, -9780, -713, 37.885, 4.901, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240934, 32820, 0, 1, 1, 0, 0, -9774, 42.294, 35.31, 3.105, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240935, 32820, 0, 1, 1, 0, 0, -9773, -877, 39.698, 0.241, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240936, 32820, 0, 1, 1, 0, 0, -9773, -663, 38.65, 4.342, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240937, 32820, 0, 1, 1, 0, 0, -9773, -625, 38.944, 4.624, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240938, 32820, 0, 1, 1, 0, 0, -9773, -85, 28.616, 5.453, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240939, 32820, 0, 1, 1, 0, 0, -9772, -741, 39.829, 5.986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240940, 32820, 0, 1, 1, 0, 0, -9771, -857, 39.585, 4.254, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240941, 32820, 0, 1, 1, 0, 0, -9771, -579, 36.326, 3.167, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240942, 32820, 0, 1, 1, 0, 0, -9771, 111.906, 47.054, 2.732, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240943, 32820, 0, 1, 1, 0, 0, -9758.04, 191.688, 51.0349, 3.51339, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240944, 32820, 0, 1, 1, 0, 0, -9770, 205.796, 46.15, 3.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240945, 32820, 0, 1, 1, 0, 0, -9769, -1566, 41.704, 5.201, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240946, 32820, 0, 1, 1, 0, 0, -9769, -77, 28.542, 4.893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240947, 32820, 0, 1, 1, 0, 0, -9765, -740, 40.328, 1.356, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240948, 32820, 0, 1, 1, 0, 0, -9765, -640, 40.579, 3.144, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240949, 32820, 0, 1, 1, 0, 0, -9764, -1627, 47.481, 2.482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240950, 32820, 0, 1, 1, 0, 0, -9764, -580, 37.913, 5.737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240951, 32820, 0, 1, 1, 0, 0, -9763, 325.363, 43.322, 2.428, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240952, 32820, 0, 1, 1, 0, 0, -9762, 54.415, 38.711, 1.661, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240953, 32820, 0, 1, 1, 0, 0, -9761, -1015, 40.758, 1.741, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240954, 32820, 0, 1, 1, 0, 0, -9761, -948, 39.179, 5.835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240955, 32820, 0, 1, 1, 0, 0, -9759, -643, 40.987, 6.268, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240956, 32820, 0, 1, 1, 0, 0, -9758, -137, 32.806, 0.543, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240957, 32820, 0, 1, 1, 0, 0, -9758, -73, 30.879, 3.776, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240958, 32820, 0, 1, 1, 0, 0, -9757, -734, 40.014, 1.117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240959, 32820, 0, 1, 1, 0, 0, -9757, 212.414, 47.7, 0.285, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240960, 32820, 0, 1, 1, 0, 0, -9756, -743, 41.258, 3.814, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240961, 32820, 0, 1, 1, 0, 0, -9754, -1314, 47.153, 3.479, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240962, 32820, 0, 1, 1, 0, 0, -9754, 83.393, 42.845, 3.962, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240963, 32820, 0, 1, 1, 0, 0, -9753, -265, 46.591, 4.372, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240964, 32820, 0, 1, 1, 0, 0, -9752, -1450, 49.442, 5.795, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240965, 32820, 0, 1, 1, 0, 0, -9752, -219, 44.307, 5.562, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240966, 32820, 0, 1, 1, 0, 0, -9752, 317.84, 44.536, 1.763, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240967, 32820, 0, 1, 1, 0, 0, -9751, -747, 41.764, 5.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240968, 32820, 0, 1, 1, 0, 0, -9750, -749, 41.764, 5.17, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240969, 32820, 0, 1, 1, 0, 0, -9750, 317.248, 44.883, 6.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240970, 32820, 0, 1, 1, 0, 0, -9750, 520.191, 35.408, 4.794, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240971, 32820, 0, 1, 1, 0, 0, -9749, -147, 35.487, 1.987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240972, 32820, 0, 1, 1, 0, 0, -9826.07, 186.314, 12.2822, 1.2734, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240973, 32820, 0, 1, 1, 0, 0, -9748, -753, 41.264, 5.73, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240974, 32820, 0, 1, 1, 0, 0, -9748, -348, 54.392, 0.792, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240975, 32820, 0, 1, 1, 0, 0, -9748, 311.153, 45.449, 6.103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240976, 32820, 0, 1, 1, 0, 0, -9747, -1530, 49.29, 4.695, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240977, 32820, 0, 1, 1, 0, 0, -9747, -918, 39.343, 6.169, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240978, 32820, 0, 1, 1, 0, 0, -9747, 103.541, 45.928, 0.122, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240979, 32820, 0, 1, 1, 0, 0, -9851.49, 213.185, 14.1337, 2.54401, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240980, 32820, 0, 1, 1, 0, 0, -9744, 87.153, 12.71, 6.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240981, 32820, 0, 1, 1, 0, 0, -9743, -361, 53.892, 3.28, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240982, 32820, 0, 1, 1, 0, 0, -9743, -1, 37.689, 2.205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240983, 32820, 0, 1, 1, 0, 0, -9743, 430.639, 38.11, 3.056, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240984, 32820, 0, 1, 1, 0, 0, -9742, -759, 41.002, 4.724, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240985, 32820, 0, 1, 1, 0, 0, -9742, -725, 40.918, 1.935, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240986, 32820, 0, 1, 1, 0, 0, -9741, -837, 40.12, 4.08, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240987, 32820, 0, 1, 1, 0, 0, -9741, 165.586, 50.495, 0.571, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240988, 32820, 0, 1, 1, 0, 0, -9903.68, 226.756, 16.4163, 0.336615, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240989, 32820, 0, 1, 1, 0, 0, -9739, 518.949, 35.619, 1.928, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240990, 32820, 0, 1, 1, 0, 0, -9738, -1213, 47.634, 2.495, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240991, 32820, 0, 1, 1, 0, 0, -9738, 921.018, 26.584, 5.289, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240992, 32820, 0, 1, 1, 0, 0, -9735, -989, 42.063, 0.381, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240993, 32820, 0, 1, 1, 0, 0, -9735, -79, 34.112, 3.089, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240994, 32820, 0, 1, 1, 0, 0, -9735, 138.105, 19.025, 0.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240995, 32820, 0, 1, 1, 0, 0, -9734, 114.787, 24.424, 5.405, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240996, 32820, 0, 1, 1, 0, 0, -9731, 115.349, 24.41, 4.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240997, 32820, 0, 1, 1, 0, 0, -9731, 447.916, 37.187, 2.678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240998, 32820, 0, 1, 1, 0, 0, -9730, -1466, 52.464, 4.684, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(240999, 32820, 0, 1, 1, 0, 0, -9730, -259, 47.41, 2.503, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241000, 32820, 0, 1, 1, 0, 0, -9730, 103.062, 46.948, 5.309, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241001, 32820, 0, 1, 1, 0, 0, -9730, 341.769, 43.205, 2.423, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241002, 32820, 0, 1, 1, 0, 0, -9729, 437.74, 37.602, 2.513, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241003, 32820, 0, 1, 1, 0, 0, -9728, -1553, 52.11, 6.186, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241004, 32820, 0, 1, 1, 0, 0, -9728, -746, 41.971, 0.902, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241005, 32820, 0, 1, 1, 0, 0, -9728, 290.418, 48.336, 1.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241006, 32820, 0, 1, 1, 0, 0, -9727, -1089, 38.716, 2.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241007, 32820, 0, 1, 1, 0, 0, -9727, 40.062, 39.599, 3.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241008, 32820, 0, 1, 1, 0, 0, -9727, 474.598, 35.212, 2.846, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241009, 32820, 0, 1, 1, 0, 0, -9727, 720.553, 28.913, 6.131, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241010, 32820, 0, 1, 1, 0, 0, -9726, -1129, 39.08, 2.512, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241011, 32820, 0, 1, 1, 0, 0, -9726, 712.112, 29.85, 2.776, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241012, 32820, 0, 1, 1, 0, 0, -9724, -1310, 48.816, 0.756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241013, 32820, 0, 1, 1, 0, 0, -9724, -1112, 40.213, 3.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241014, 32820, 0, 1, 1, 0, 0, -9724, -930, 38.308, 2.72, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241015, 32820, 0, 1, 1, 0, 0, -9723, -581, 45.81, 5.94, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241016, 32820, 0, 1, 1, 0, 0, -9722, 128.517, 47.234, 0.323, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241017, 32820, 0, 1, 1, 0, 0, -9722, 197.088, 50.27, 4.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241018, 32820, 0, 1, 1, 0, 0, -9722, 256.462, 49.063, 1.155, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241019, 32820, 0, 1, 1, 0, 0, -9721, 23.362, 39.87, 5.61, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241020, 32820, 0, 1, 1, 0, 0, -9721, 428.239, 38.853, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241021, 32820, 0, 1, 1, 0, 0, -9721, 745.296, 30.548, 5.925, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241022, 32820, 0, 1, 1, 0, 0, -9720, -1205, 49.588, 5.101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241023, 32820, 0, 1, 1, 0, 0, -9720, 429.388, 38.745, 2.756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241024, 32820, 0, 1, 1, 0, 0, -9719, -395, 50.859, 0.383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241025, 32820, 0, 1, 1, 0, 0, -9718, -85, 36.09, 3.028, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241026, 32820, 0, 1, 1, 0, 0, -9718, 371.821, 42.544, 5.649, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241027, 32820, 0, 1, 1, 0, 0, -9717, -1490, 50.84, 4.318, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241028, 32820, 0, 1, 1, 0, 0, -9717, -1303, 50.725, 4.052, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241029, 32820, 0, 1, 1, 0, 0, -9717, 755.86, 30.836, 4.349, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241030, 32820, 0, 1, 1, 0, 0, -9716, -1144, 40.123, 0.638, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241031, 32820, 0, 1, 1, 0, 0, -9716, -818, 43.924, 1.439, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241032, 32820, 0, 1, 1, 0, 0, -9715, -1537, 54.61, 0.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241033, 32820, 0, 1, 1, 0, 0, -9715, -716, 45.383, 1.985, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241034, 32820, 0, 1, 1, 0, 0, -9715, -245, 48.313, 0.157, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241035, 32820, 0, 1, 1, 0, 0, -9714, -7, 38.999, 6.216, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241036, 32820, 0, 1, 1, 0, 0, -9714, 410.541, 40.489, 5.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241037, 32820, 0, 1, 1, 0, 0, -9713, -646, 46.941, 5.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241038, 32820, 0, 1, 1, 0, 0, -9712, -660, 46.67, 0.96, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241039, 32820, 0, 1, 1, 0, 0, -9712, -181, 43.842, 3.608, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241040, 32820, 0, 1, 1, 0, 0, -9712, -113, 36.01, 5.03, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241041, 32820, 0, 1, 1, 0, 0, -9712, 579.657, 37.595, 0.698, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241042, 32820, 0, 1, 1, 0, 0, -9711, -1546, 56.61, 1.215, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241043, 32820, 0, 1, 1, 0, 0, -9711, 245.09, 49.688, 5.531, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241044, 32820, 0, 1, 1, 0, 0, -9709, -515, 53.228, 5.221, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241045, 32820, 0, 1, 1, 0, 0, -9708, -375, 53.215, 4.519, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241046, 32820, 0, 1, 1, 0, 0, -9708, 726.474, 30.275, 0.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241047, 32820, 0, 1, 1, 0, 0, -9707, -1225, 54.113, 6.001, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241048, 32820, 0, 1, 1, 0, 0, -9706, -448, 51.78, 3.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241049, 32820, 0, 1, 1, 0, 0, -9706, -50, 38.471, 0.338, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241050, 32820, 0, 1, 1, 0, 0, -9705, -986, 41.854, 0.701, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241051, 32820, 0, 1, 1, 0, 0, -9729.64, 590.888, 32.8345, 2.93918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241052, 32820, 0, 1, 1, 0, 0, -9703, -194, 45.877, 3.77, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241053, 32820, 0, 1, 1, 0, 0, -9701, -343, 56.395, 0.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241054, 32820, 0, 1, 1, 0, 0, -9699, -1219, 53.988, 3.839, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241055, 32820, 0, 1, 1, 0, 0, -9699, 754.402, 31.08, 4.664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241056, 32820, 0, 1, 1, 0, 0, -9698, -79, 38.762, 4.605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241057, 32820, 0, 1, 1, 0, 0, -9698, -73, 38.956, 5.983, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241058, 32820, 0, 1, 1, 0, 0, -9697, -77, 38.994, 4.625, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241059, 32820, 0, 1, 1, 0, 0, -9696, -563, 47.972, 4.491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241060, 32820, 0, 1, 1, 0, 0, -9696, -518, 51.99, 2.203, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241061, 32820, 0, 1, 1, 0, 0, -9696, -287, 58.855, 3.667, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241062, 32820, 0, 1, 1, 0, 0, -9696, 119.949, 48.207, 3.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241063, 32820, 0, 1, 1, 0, 0, -9696, 605.496, 39.227, 0.987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241064, 32820, 0, 1, 1, 0, 0, -9695, -596, 48.613, 2.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241065, 32820, 0, 1, 1, 0, 0, -9694, -338, 57.316, 1.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241066, 32820, 0, 1, 1, 0, 0, -9694, -325, 56.084, 3.284, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241067, 32820, 0, 1, 1, 0, 0, -9693, -891, 42.969, 3.883, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241068, 32820, 0, 1, 1, 0, 0, -9693, -681, 46.882, 3.713, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241069, 32820, 0, 1, 1, 0, 0, -9693, -565, 48.472, 1.692, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241070, 32820, 0, 1, 1, 0, 0, -9693, -12, 40.812, 2.241, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241071, 32820, 0, 1, 1, 0, 0, -9693, 757.182, 31.571, 2.831, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241072, 32820, 0, 1, 1, 0, 0, -9691, -179, 45.468, 3.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241073, 32820, 0, 1, 1, 0, 0, -9690, -684, 47.855, 1.707, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241074, 32820, 0, 1, 1, 0, 0, -9690, 214.238, 51.084, 2.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241075, 32820, 0, 1, 1, 0, 0, -9689, -702, 48.288, 1.51, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241076, 32820, 0, 1, 1, 0, 0, -9689, -582, 50.154, 5.298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241077, 32820, 0, 1, 1, 0, 0, -9689, -311, 56.459, 1.525, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241078, 32820, 0, 1, 1, 0, 0, -9688, -1583, 56.778, 3.584, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241079, 32820, 0, 1, 1, 0, 0, -9688, -708, 48.174, 4.93, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241080, 32820, 0, 1, 1, 0, 0, -9688, -363, 55.84, 4.373, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241081, 32820, 0, 1, 1, 0, 0, -9688, 212.671, 51.334, 2.213, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241082, 32820, 0, 1, 1, 0, 0, -9688, 535.311, 38.85, 4.16, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241083, 32820, 0, 1, 1, 0, 0, -9687, -750, 46.082, 3.762, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241084, 32820, 0, 1, 1, 0, 0, -9687, -684, 48.302, 6.184, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241085, 32820, 0, 1, 1, 0, 0, -9687, -684, 48.895, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241086, 32820, 0, 1, 1, 0, 0, -9686, -1131, 40.541, 4.802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241087, 32820, 0, 1, 1, 0, 0, -9686, -349, 57.389, 2.183, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241088, 32820, 0, 1, 1, 0, 0, -9686, -168, 45.128, 3.634, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241089, 32820, 0, 1, 1, 0, 0, -9685, -421, 54.012, 2.846, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241090, 32820, 0, 1, 1, 0, 0, -9685, -269, 61.53, 3.605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241091, 32820, 0, 1, 1, 0, 0, -9684, -951, 41.894, 1.231, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241092, 32820, 0, 1, 1, 0, 0, -9683, -50, 39.54, 2.438, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241093, 32820, 0, 1, 1, 0, 0, -9682, -327, 56.332, 3.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241094, 32820, 0, 1, 1, 0, 0, -9682, 136.4, 47.849, 0.967, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241095, 32820, 0, 1, 1, 0, 0, -9681, -416, 54.327, 3.698, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241096, 32820, 0, 1, 1, 0, 0, -9681, -335, 57.205, 3.703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241097, 32820, 0, 1, 1, 0, 0, -9681, -164, 45.229, 0.723, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241098, 32820, 0, 1, 1, 0, 0, -9681, -135, 43.235, 5.441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241099, 32820, 0, 1, 1, 0, 0, -9680, 356.074, 43.955, 3.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241100, 32820, 0, 1, 1, 0, 0, -9680, 754.835, 33.07, 1.964, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241101, 32820, 0, 1, 1, 0, 0, -9678, -1581, 57.199, 3.789, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241102, 32820, 0, 1, 1, 0, 0, -9678, -183, 46.748, 4.703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241103, 32820, 0, 1, 1, 0, 0, -9678, 598.149, 39.802, 4.33, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241104, 32820, 0, 1, 1, 0, 0, -9677, -567, 49.951, 3.448, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241105, 32820, 0, 1, 1, 0, 0, -9676, -1601, 54.754, 2.82, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241106, 32820, 0, 1, 1, 0, 0, -9676, -1573, 55.732, 3.81, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241107, 32820, 0, 1, 1, 0, 0, -9676, -423, 54.769, 3.825, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241108, 32820, 0, 1, 1, 0, 0, -9676, 108.541, 45.798, 5.688, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241109, 32820, 0, 1, 1, 0, 0, -9675, -815, 47.432, 3.599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241110, 32820, 0, 1, 1, 0, 0, -9675, 174.857, 49.398, 0.567, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241111, 32820, 0, 1, 1, 0, 0, -9674, -905, 42.956, 3.032, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241112, 32820, 0, 1, 1, 0, 0, -9673, -492, 51.997, 4.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241113, 32820, 0, 1, 1, 0, 0, -9673, 318.748, 46.291, 2.546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241114, 32820, 0, 1, 1, 0, 0, -9673, 374.112, 43.139, 2.698, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241115, 32820, 0, 1, 1, 0, 0, -9671, 374.911, 43.226, 1.907, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241116, 32820, 0, 1, 1, 0, 0, -9667, -434, 54.843, 0.73, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241117, 32820, 0, 1, 1, 0, 0, -9667, -429, 55.276, 2.6, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241118, 32820, 0, 1, 1, 0, 0, -9667, 494.199, 38.632, 5.933, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241119, 32820, 0, 1, 1, 0, 0, -9666, 541.163, 41.336, 3.046, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241120, 32820, 0, 1, 1, 0, 0, -9665, 693.473, 36.846, 3.491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241121, 32820, 0, 1, 1, 0, 0, -9663, -1154, 40.172, 0.397, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241122, 32820, 0, 1, 1, 0, 0, -9663, 401.738, 40.652, 5.242, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241123, 32820, 0, 1, 1, 0, 0, -9663, 603.806, 40.344, 0.648, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241124, 32820, 0, 1, 1, 0, 0, -9662, -190, 50.471, 0.433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241125, 32820, 0, 1, 1, 0, 0, -9661, -1084, 43.3, 0.976, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241126, 32820, 0, 1, 1, 0, 0, -9660, 525.708, 41.011, 2.836, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241127, 32820, 0, 1, 1, 0, 0, -9658, 108.193, 46.029, 3.889, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241128, 32820, 0, 1, 1, 0, 0, -9658, 208.041, 48.973, 1.677, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241129, 32820, 0, 1, 1, 0, 0, -9658, 384.124, 41.988, 2.129, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241130, 32820, 0, 1, 1, 0, 0, -9657, 177.253, 48.539, 1.592, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241131, 32820, 0, 1, 1, 0, 0, -9656, -186, 52.282, 5.817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241132, 32820, 0, 1, 1, 0, 0, -9655, -430, 56.846, 3.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241133, 32820, 0, 1, 1, 0, 0, -9655, 161.958, 47.921, 4.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241134, 32820, 0, 1, 1, 0, 0, -9654, -589, 55.268, 6.118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241135, 32820, 0, 1, 1, 0, 0, -9654, 564.774, 41.556, 4.709, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241136, 32820, 0, 1, 1, 0, 0, -9654, 659.651, 38.735, 5.69, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241137, 32820, 0, 1, 1, 0, 0, -9653, -1626, 56.418, 0.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241138, 32820, 0, 1, 1, 0, 0, -9653, 625.699, 38.357, 0.42, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241139, 32820, 0, 1, 1, 0, 0, -9652, 654.731, 38.735, 0.454, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241140, 32820, 0, 1, 1, 0, 0, -9651, -923, 46.883, 3.953, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241141, 32820, 0, 1, 1, 0, 0, -9651, -451, 55.271, 0.3, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241142, 32820, 0, 1, 1, 0, 0, -9651, 346.356, 43.78, 3.174, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241143, 32820, 0, 1, 1, 0, 0, -9651, 534.697, 43.157, 2.778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241144, 32820, 0, 1, 1, 0, 0, -9651, 608.674, 41.892, 5.38, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241145, 32820, 0, 1, 1, 0, 0, -9650, 141.491, 45.918, 3.654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241146, 32820, 0, 1, 1, 0, 0, -9650, 661.417, 38.735, 5.027, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241147, 32820, 0, 1, 1, 0, 0, -9646, -259, 62.374, 4.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241148, 32820, 0, 1, 1, 0, 0, -9644, -117, 50.891, 5.77, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241149, 32820, 0, 1, 1, 0, 0, -9643, -390, 60.446, 1.07, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241150, 32820, 0, 1, 1, 0, 0, -9643, -52, 43.822, 4.879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241151, 32820, 0, 1, 1, 0, 0, -9643, 377.555, 42.262, 0.399, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241152, 32820, 0, 1, 1, 0, 0, -9642, -208, 53.564, 3.837, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241153, 32820, 0, 1, 1, 0, 0, -9642, 171.817, 47.878, 1.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241154, 32820, 0, 1, 1, 0, 0, -9641, -423, 60.277, 2.665, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241155, 32820, 0, 1, 1, 0, 0, -9638, 696.574, 38.652, 0.302, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241156, 32820, 0, 1, 1, 0, 0, -9635, 56.194, 59.917, 4.14, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241157, 32820, 0, 1, 1, 0, 0, -9633, 304.301, 47.332, 5.973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241158, 32820, 0, 1, 1, 0, 0, -9631, -1569, 55.883, 5.065, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241159, 32820, 0, 1, 1, 0, 0, -9631, -45, 44.366, 2.666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241160, 32820, 0, 1, 1, 0, 0, -9629, 212.808, 47.86, 2.653, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241161, 32820, 0, 1, 1, 0, 0, -9621.46, -1038.96, 39.6437, 0.24935, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241162, 32820, 0, 1, 1, 0, 0, -9621, 195.889, 47.699, 4.419, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241163, 32820, 0, 1, 1, 0, 0, -9620, -1070, 39.575, 0.448, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241164, 32820, 0, 1, 1, 0, 0, -9617, -884, 49.006, 5.743, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241165, 32820, 0, 1, 1, 0, 0, -9617, -854, 45.009, 4.939, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241166, 32820, 0, 1, 1, 0, 0, -9616, -1039, 39.999, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241167, 32820, 0, 1, 1, 0, 0, -9616, 358.532, 44.245, 2.353, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241168, 32820, 0, 1, 1, 0, 0, -9615, -1164, 42.549, 2.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241169, 32820, 0, 1, 1, 0, 0, -9615, -877, 48.881, 0.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241170, 32820, 0, 1, 1, 0, 0, -9614, -884, 49.325, 3.363, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241171, 32820, 0, 1, 1, 0, 0, -9612, -880, 48.976, 2.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241172, 32820, 0, 1, 1, 0, 0, -9610.42, -1072.08, 39.5028, 3.2748, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241173, 32820, 0, 1, 1, 0, 0, -9610, -1032, 41.306, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241174, 32820, 0, 1, 1, 0, 0, -9610, 640.565, 38.652, 2.732, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241175, 32820, 0, 1, 1, 0, 0, -9609, -873, 48.006, 0.976, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241176, 32820, 0, 1, 1, 0, 0, -9606, -1474, 59.74, 2.897, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241177, 32820, 0, 1, 1, 0, 0, -9606, 541.682, 45.521, 3.87, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241178, 32820, 0, 1, 1, 0, 0, -9606, 684.352, 38.652, 1.964, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241179, 32820, 0, 1, 1, 0, 0, -9605, -536, 55.4, 2.668, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241180, 32820, 0, 1, 1, 0, 0, -9600, -617, 56.301, 5.539, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241181, 32820, 0, 1, 1, 0, 0, -9598, -625, 56.651, 3.35, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241182, 32820, 0, 1, 1, 0, 0, -9596, -614, 56.776, 2.182, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241183, 32820, 0, 1, 1, 0, 0, -9592, -614, 57.006, 3.361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241184, 32820, 0, 1, 1, 0, 0, -9590, -1128, 44.706, 1.545, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241185, 32820, 0, 1, 1, 0, 0, -9588, -438, 60.505, 3.263, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241186, 32820, 0, 1, 1, 0, 0, -9587, -1545, 59.617, 6.028, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241187, 32820, 0, 1, 1, 0, 0, -9587, -1149, 45.731, 5.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241188, 32820, 0, 1, 1, 0, 0, -9586, 435.596, 39.798, 3.141, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241189, 32820, 0, 1, 1, 0, 0, -9586, 459.753, 41.175, 3.861, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241190, 32820, 0, 1, 1, 0, 0, -9584, -160, 57.909, 5.738, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241191, 32820, 0, 1, 1, 0, 0, -9582, -317, 61.673, 1.959, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241192, 32820, 0, 1, 1, 0, 0, -9580, 727.4, 34.263, 6.273, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241193, 32820, 0, 1, 1, 0, 0, -9578, 576.959, 49.341, 1.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241194, 32820, 0, 1, 1, 0, 0, -9576, -718, 99.27, 3.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241195, 32820, 0, 1, 1, 0, 0, -9576, 314.797, 55.528, 2.647, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241196, 32820, 0, 1, 1, 0, 0, -9575, -424, 62.826, 1.817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241197, 32820, 0, 1, 1, 0, 0, -9575, -297, 61.31, 2.498, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241198, 32820, 0, 1, 1, 0, 0, -9572.62, 88.1464, 58.8819, 5.974, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241199, 32820, 0, 1, 1, 0, 0, -9571, -432, 62.519, 0.868, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241200, 32820, 0, 1, 1, 0, 0, -9570, -1141, 43.698, 5.645, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241201, 32820, 0, 1, 1, 0, 0, -9570, 518.539, 48.457, 1.061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241202, 32820, 0, 1, 1, 0, 0, -9568, -1482, 61.479, 0.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241203, 32820, 0, 1, 1, 0, 0, -9568, -1260, 47.978, 3.074, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241204, 32820, 0, 1, 1, 0, 0, -9568, -1142, 43.928, 5.745, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241205, 32820, 0, 1, 1, 0, 0, -9568, -1011, 47.385, 2.208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241206, 32820, 0, 1, 1, 0, 0, -9568, -439, 61.607, 0.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241207, 32820, 0, 1, 1, 0, 0, -9568, -222, 62.061, 6.001, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241208, 32820, 0, 1, 1, 0, 0, -9567, 81.004, 58.881, 0.348, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241209, 32820, 0, 1, 1, 0, 0, -9567, 195.622, 59.003, 3.211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241210, 32820, 0, 1, 1, 0, 0, -9565, -1139, 43.958, 3.8, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241211, 32820, 0, 1, 1, 0, 0, -9563, -307, 63.23, 2.619, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241212, 32820, 0, 1, 1, 0, 0, -9562, 103.726, 58.882, 4.918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241213, 32820, 0, 1, 1, 0, 0, -9560.06, 74.1694, 58.8881, 0.905975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241214, 32820, 0, 1, 1, 0, 0, -9563.21, 76.4257, 58.8835, 0.935819, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241215, 32820, 0, 1, 1, 0, 0, -9558, 104.884, 58.882, 4.923, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241216, 32820, 0, 1, 1, 0, 0, -9557, 89.681, 58.881, 4.876, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241217, 32820, 0, 1, 1, 0, 0, -9557, 129.744, 58.881, 5.82, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241218, 32820, 0, 1, 1, 0, 0, -9556, -316, 62.352, 6.073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241219, 32820, 0, 1, 1, 0, 0, -9555, 181.645, 59.138, 2.708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241220, 32820, 0, 1, 1, 0, 0, -9554, -390, 62.948, 0.279, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241221, 32820, 0, 1, 1, 0, 0, -9554, -313, 62.556, 4.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241222, 32820, 0, 1, 1, 0, 0, -9553, -1502, 61.176, 6.117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241223, 32820, 0, 1, 1, 0, 0, -9553, -728, 99.252, 2.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241224, 32820, 0, 1, 1, 0, 0, -9553, -244, 62.128, 1.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241225, 32820, 0, 1, 1, 0, 0, -9553, 108.151, 58.882, 0.059, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241226, 32820, 0, 1, 1, 0, 0, -9552, 140.323, 58.881, 5.078, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241227, 32820, 0, 1, 1, 0, 0, -9551.31, -712.266, 75.0554, 3.9444, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241228, 32820, 0, 1, 1, 0, 0, -9551, 209.447, 57.854, 3.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241229, 32820, 0, 1, 1, 0, 0, -9550, -315, 62.703, 2.76, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241230, 32820, 0, 1, 1, 0, 0, -9549, -381, 62.186, 0.841, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241231, 32820, 0, 1, 1, 0, 0, -9548.14, -710.201, 90.4265, 3.76926, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241232, 32820, 0, 1, 1, 0, 0, -9548, -540, 60.557, 3.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241233, 32820, 0, 1, 1, 0, 0, -9548, 67.039, 59.25, 1.844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241234, 32820, 0, 1, 1, 0, 0, -9547, -975, 49.27, 2.344, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241235, 32820, 0, 1, 1, 0, 0, -9547, -551, 60.16, 3.215, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241236, 32820, 0, 1, 1, 0, 0, -9546, -187, 61.342, 5.506, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241237, 32820, 0, 1, 1, 0, 0, -9545, -1401, 53.933, 2.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241238, 32820, 0, 1, 1, 0, 0, -9545, -1145, 46.409, 4.804, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241239, 32820, 0, 1, 1, 0, 0, -9545, 126.803, 59.076, 2.364, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241240, 32820, 0, 1, 1, 0, 0, -9544.87, 77.7707, 59.0124, 5.92404, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241241, 32820, 0, 1, 1, 0, 0, -9544, -1495, 61.319, 0.796, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241242, 32820, 0, 1, 1, 0, 0, -9544, -886, 46.261, 3.139, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241243, 32820, 0, 1, 1, 0, 0, -9543, -1003, 51.05, 3.629, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241244, 32820, 0, 1, 1, 0, 0, -9542, -517, 63.119, 1.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241245, 32820, 0, 1, 1, 0, 0, -9542, 299.005, 53.319, 4.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241246, 32820, 0, 1, 1, 0, 0, -9541.55, -716.649, 99.212, 3.32507, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241247, 32820, 0, 1, 1, 0, 0, -9541, -1533, 61.272, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241248, 32820, 0, 1, 1, 0, 0, -9541, -1067, 47.727, 0.79, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241249, 32820, 0, 1, 1, 0, 0, -9541, -537, 61.838, 5.395, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241250, 32820, 0, 1, 1, 0, 0, -9540, 85.383, 59.121, 6.25, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241251, 32820, 0, 1, 1, 0, 0, -9539, 508.213, 50.727, 4.763, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241252, 32820, 0, 1, 1, 0, 0, -9538, 112.447, 58.885, 6.095, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241253, 32820, 0, 1, 1, 0, 0, -9539.97, 71.6819, 58.8818, 1.48463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241254, 32820, 0, 1, 1, 0, 0, -9537, -1214, 48.234, 4.904, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241255, 32820, 0, 1, 1, 0, 0, -9537, 513.434, 51.446, 2.756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241256, 32820, 0, 1, 1, 0, 0, -9536, -1273, 43.544, 5.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241257, 32820, 0, 1, 1, 0, 0, -9536, 277.975, 53.924, 5.843, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241258, 32820, 0, 1, 1, 0, 0, -9535, -486, 62.979, 2.737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241259, 32820, 0, 1, 1, 0, 0, -9535, 92, 58.8819, 4.462, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241260, 32820, 0, 1, 1, 0, 0, -9535, 280.233, 54.284, 4.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241261, 32820, 0, 1, 1, 0, 0, -9534, -1303, 44.488, 5.102, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241262, 32820, 0, 1, 1, 0, 0, -9534, -451, 60.238, 0.334, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241263, 32820, 0, 1, 1, 0, 0, -9534, -378, 59.494, 0.528, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241264, 32820, 0, 1, 1, 0, 0, -9533, -34, 56.448, 2.767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241265, 32820, 0, 1, 1, 0, 0, -9533, 80.093, 58.881, 6.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241266, 32820, 0, 1, 1, 0, 0, -9532, -730, 62.635, 3.772, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241267, 32820, 0, 1, 1, 0, 0, -9531.92, -1222.34, 47.6548, 5.61777, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241268, 32820, 0, 1, 1, 0, 0, -9531, -264, 59.372, 6.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241269, 32820, 0, 1, 1, 0, 0, -9531, -252, 58.833, 5.188, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241270, 32820, 0, 1, 1, 0, 0, -9531, 81.822, 58.881, 0.107, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241271, 32820, 0, 1, 1, 0, 0, -9530, 82.757, 58.881, 0.078, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241272, 32820, 0, 1, 1, 0, 0, -9530, 173.256, 57.863, 4.879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241273, 32820, 0, 1, 1, 0, 0, -9530, 534.204, 51.063, 3.854, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241274, 32820, 0, 1, 1, 0, 0, -9529, -651, 63.198, 0.171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241275, 32820, 0, 1, 1, 0, 0, -9528, 175.567, 57.614, 0.737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241276, 32820, 0, 1, 1, 0, 0, -9528, 177.394, 57.646, 2.687, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241277, 32820, 0, 1, 1, 0, 0, -9526, -986, 51.973, 3.31, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241278, 32820, 0, 1, 1, 0, 0, -9526, -138, 61.369, 2.666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241279, 32820, 0, 1, 1, 0, 0, -9523, -1290, 44.27, 0.136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241280, 32820, 0, 1, 1, 0, 0, -9522, -1048, 49.724, 4.858, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241281, 32820, 0, 1, 1, 0, 0, -9522, 409.066, 52.694, 4.811, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241282, 32820, 0, 1, 1, 0, 0, -9521, -532, 63.048, 3.274, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241283, 32820, 0, 1, 1, 0, 0, -9520, 472.334, 53.101, 0.539, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241284, 32820, 0, 1, 1, 0, 0, -9519, -452, 59.807, 2.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241285, 32820, 0, 1, 1, 0, 0, -9519, 484.227, 52.792, 2.03, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241286, 32820, 0, 1, 1, 0, 0, -9517, 79.223, 59.568, 6.194, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241287, 32820, 0, 1, 1, 0, 0, -9517, 85.71, 59.509, 6.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241288, 32820, 0, 1, 1, 0, 0, -9516, 409.141, 52.729, 3.851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241289, 32820, 0, 1, 1, 0, 0, -9516, 427.811, 54.883, 0.716, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241290, 32820, 0, 1, 1, 0, 0, -9516, 551.302, 51.241, 3.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241291, 32820, 0, 1, 1, 0, 0, -9513, -1370, 49.18, 5.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241292, 32820, 0, 1, 1, 0, 0, -9512, -518, 63.121, 6.079, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241293, 32820, 0, 1, 1, 0, 0, -9512, -303, 55.091, 5.382, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241294, 32820, 0, 1, 1, 0, 0, -9511, -1286, 44.145, 3.789, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241295, 32820, 0, 1, 1, 0, 0, -9511, -1005, 54.496, 1.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241296, 32820, 0, 1, 1, 0, 0, -9511, -780, 60.461, 2.016, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241297, 32820, 0, 1, 1, 0, 0, -9509, 419.477, 52.881, 3.244, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241298, 32820, 0, 1, 1, 0, 0, -9508, -1091, 49.683, 4.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241299, 32820, 0, 1, 1, 0, 0, -9508, 174.773, 57.988, 5.893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241300, 32820, 0, 1, 1, 0, 0, -9507, -1063, 50.982, 5.505, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241301, 32820, 0, 1, 1, 0, 0, -9507, -1003, 54.765, 4.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241302, 32820, 0, 1, 1, 0, 0, -9507, 391.523, 50.688, 2.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241303, 32820, 0, 1, 1, 0, 0, -9505, -210, 52.069, 0.998, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241304, 32820, 0, 1, 1, 0, 0, -9504, -1286, 43.067, 4.472, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241305, 32820, 0, 1, 1, 0, 0, -9504, 389.215, 50.779, 5.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241306, 32820, 0, 1, 1, 0, 0, -9503, -1520, 61.407, 3.675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241307, 32820, 0, 1, 1, 0, 0, -9499, -960, 54.024, 3.495, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241308, 32820, 0, 1, 1, 0, 0, -9499, -56, 59.989, 1.879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241309, 32820, 0, 1, 1, 0, 0, -9498, 66.229, 56.528, 6.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241310, 32820, 0, 1, 1, 0, 0, -9497, -1274, 43.456, 0.703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241311, 32820, 0, 1, 1, 0, 0, -9496, -939, 54.836, 0.463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241312, 32820, 0, 1, 1, 0, 0, -9496, 73.146, 56.438, 6.088, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241313, 32820, 0, 1, 1, 0, 0, -9494, -1063, 52.208, 2.649, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241314, 32820, 0, 1, 1, 0, 0, -9494, 83.081, 56.474, 6.151, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241315, 32820, 0, 1, 1, 0, 0, -9494, 324.211, 52.561, 6.057, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241316, 32820, 0, 1, 1, 0, 0, -9493, -450, 56.073, 5.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241317, 32820, 0, 1, 1, 0, 0, -9492, -559, 64.456, 1.584, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241318, 32820, 0, 1, 1, 0, 0, -9491, -1193, 49.564, 4.063, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241319, 32820, 0, 1, 1, 0, 0, -9491, -53, 60.493, 5.207, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241320, 32820, 0, 1, 1, 0, 0, -9491, -21, 58.339, 2.126, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241321, 32820, 0, 1, 1, 0, 0, -9490, -958, 55.971, 3.14, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241322, 32820, 0, 1, 1, 0, 0, -9490, -31, 59.078, 1.199, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241323, 32820, 0, 1, 1, 0, 0, -9490, -29, 58.923, 4.502, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241324, 32820, 0, 1, 1, 0, 0, -9490, 475.371, 51.298, 6.274, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241325, 32820, 0, 1, 1, 0, 0, -9489, 482.235, 51.715, 5.562, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241326, 32820, 0, 1, 1, 0, 0, -9488, -766, 61.281, 1.937, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241327, 32820, 0, 1, 1, 0, 0, -9487, -1254, 43.483, 1.865, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241328, 32820, 0, 1, 1, 0, 0, -9487, -1028, 53.171, 0.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241329, 32820, 0, 1, 1, 0, 0, -9487, 271.435, 52.855, 4.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241330, 32820, 0, 1, 1, 0, 0, -9486, 246.719, 54.08, 4.007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241331, 32820, 0, 1, 1, 0, 0, -9485, -329, 54.892, 0.419, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241332, 32820, 0, 1, 1, 0, 0, -9484, -350, 60.2, 4.378, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241333, 32820, 0, 1, 1, 0, 0, -9483, -1356, 46.958, 1.011, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241334, 32820, 0, 1, 1, 0, 0, -9482, 266.885, 53.234, 1.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241335, 32820, 0, 1, 1, 0, 0, -9482, 425.988, 53.979, 4.061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241336, 32820, 0, 1, 1, 0, 0, -9480, -786, 60.603, 5.01, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241337, 32820, 0, 1, 1, 0, 0, -9479, -183, 58.503, 1.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241338, 32820, 0, 1, 1, 0, 0, -9478, 280.815, 53.192, 4.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241339, 32820, 0, 1, 1, 0, 0, -9476, -1207, 48.181, 4.108, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241340, 32820, 0, 1, 1, 0, 0, -9126.18, 394.417, 91.7424, 3.92184, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241341, 32820, 0, 1, 1, 0, 0, -9474, 533.132, 54.285, 2.501, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241342, 32820, 0, 1, 1, 0, 0, -9473, -18, 57.595, 1.346, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241343, 32820, 0, 1, 1, 0, 0, -9473, -9, 49.794, 0.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241344, 32820, 0, 1, 1, 0, 0, -9473, 46.977, 56.887, 5.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241345, 32820, 0, 1, 1, 0, 0, -9472, -838, 60.511, 4.709, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241346, 32820, 0, 1, 1, 0, 0, -9472, -271, 58.229, 2.496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241347, 32820, 0, 1, 1, 0, 0, -9472, -5, 49.794, 5.611, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241348, 32820, 0, 1, 1, 0, 0, -9472, 34.1, 63.82, 4.407, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241349, 32820, 0, 1, 1, 0, 0, -9471, -165, 59.226, 1.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241350, 32820, 0, 1, 1, 0, 0, -9471, 27.047, 56.339, 5.751, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241351, 32820, 0, 1, 1, 0, 0, -9471, 46.904, 56.764, 4.637, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241352, 32820, 0, 1, 1, 0, 0, -9471, 419.262, 53.117, 4.697, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241353, 32820, 0, 1, 1, 0, 0, -9470.26, -1289.42, 41.1047, 2.80465, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241354, 32820, 0, 1, 1, 0, 0, -9470, -379, 59.032, 4.241, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241355, 32820, 0, 1, 1, 0, 0, -9469, -1355, 47.429, 1.03, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241356, 32820, 0, 1, 1, 0, 0, -9468, 108.976, 57.661, 1.798, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241357, 32820, 0, 1, 1, 0, 0, -9468, 241.764, 56.08, 3.422, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241358, 32820, 0, 1, 1, 0, 0, -9468, 298.53, 53.903, 5.522, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241359, 32820, 0, 1, 1, 0, 0, -9467, -5, 49.793, 4.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241360, 32820, 0, 1, 1, 0, 0, -9467, -5, 57.033, 1.641, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241361, 32820, 0, 1, 1, 0, 0, -9467, 275.755, 53.695, 0.512, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241362, 32820, 0, 1, 1, 0, 0, -9466, 0.061, 57.033, 0.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241363, 32820, 0, 1, 1, 0, 0, -9466, 12.645, 63.904, 1.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241364, 32820, 0, 1, 1, 0, 0, -9466, 48.142, 56.968, 1.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241365, 32820, 0, 1, 1, 0, 0, -9466, 74.007, 56.779, 5.336, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241366, 32820, 0, 1, 1, 0, 0, -9465, 9.633, 57.146, 1.449, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241367, 32820, 0, 1, 1, 0, 0, -9465, 93.99, 58.527, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241368, 32820, 0, 1, 1, 0, 0, -9464, 87.43, 58.344, 0.437, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241369, 32820, 0, 1, 1, 0, 0, -9463, -827, 60.746, 0.319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241370, 32820, 0, 1, 1, 0, 0, -9463, -239, 57.831, 1.002, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241371, 32820, 0, 1, 1, 0, 0, -9463, -236, 57.742, 1.557, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241372, 32820, 0, 1, 1, 0, 0, -9463, 16.192, 57.046, 3.037, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241373, 32820, 0, 1, 1, 0, 0, -9462, 109.353, 57.878, 2.653, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241374, 32820, 0, 1, 1, 0, 0, -9461, -551, 67.28, 0.317, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241375, 32820, 0, 1, 1, 0, 0, -9461, 33.134, 63.904, 4.363, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241376, 32820, 0, 1, 1, 0, 0, -9420.84, -1302.43, 47.8857, 5.23631, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241377, 32820, 0, 1, 1, 0, 0, -9460, 8.411, 57.146, 1.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241378, 32820, 0, 1, 1, 0, 0, -9460, 31.939, 57.049, 2.985, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241379, 32820, 0, 1, 1, 0, 0, -9459, -992, 57.716, 2.639, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241380, 32820, 0, 1, 1, 0, 0, -9459, 325.026, 53.68, 1.983, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241381, 32820, 0, 1, 1, 0, 0, -9457, 29.361, 63.904, 2.967, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241382, 32820, 0, 1, 1, 0, 0, -9457, 99.168, 58.343, 4.304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241383, 32820, 0, 1, 1, 0, 0, -9455.22, -1386.21, 47.1356, 1.81376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241384, 32820, 0, 1, 1, 0, 0, -9455, 73.496, 56.996, 3.142, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241385, 32820, 0, 1, 1, 0, 0, -9455, 87.35, 58.343, 2.628, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241386, 32820, 0, 1, 1, 0, 0, -9454.16, -1385.95, 47.1707, 1.71476, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241387, 32820, 0, 1, 1, 0, 0, -9452, -1051, 57.28, 0.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241388, 32820, 0, 1, 1, 0, 0, -9452, 520.263, 56.225, 2.973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241389, 32820, 0, 1, 1, 0, 0, -9451, -957, 55.738, 4.467, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241390, 32820, 0, 1, 1, 0, 0, -9449, -1449, 59.031, 0.017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241391, 32820, 0, 1, 1, 0, 0, -9449, -779, 62.301, 1.985, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241392, 32820, 0, 1, 1, 0, 0, -9448, -494, 63.785, 5.27, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241393, 32820, 0, 1, 1, 0, 0, -9448, 217.373, 59.931, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241394, 32820, 0, 1, 1, 0, 0, -9448, 339.654, 54.638, 0.588, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241395, 32820, 0, 1, 1, 0, 0, -9448, 462.158, 52.286, 4.192, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241396, 32820, 0, 1, 1, 0, 0, -9445, -973, 55.591, 4.366, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241397, 32820, 0, 1, 1, 0, 0, -9445, -595, 65.405, 3.864, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241398, 32820, 0, 1, 1, 0, 0, -9444.1, -1412.31, 46.6621, 1.63715, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241399, 32820, 0, 1, 1, 0, 0, -9444, -900, 58.153, 3.64, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241400, 32820, 0, 1, 1, 0, 0, -9444, 459.607, 52.21, 4.193, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241401, 32820, 0, 1, 1, 0, 0, -9440.76, -1391.15, 46.7888, 2.02346, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241402, 32820, 0, 1, 1, 0, 0, -9440, -1379, 46.953, 0.955, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241403, 32820, 0, 1, 1, 0, 0, -9439, -675, 64.124, 4.529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241404, 32820, 0, 1, 1, 0, 0, -9438.49, -1405, 46.662, 4.60941, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241405, 32820, 0, 1, 1, 0, 0, -9438.22, -1412.35, 46.662, 1.68739, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241406, 32820, 0, 1, 1, 0, 0, -9438, -655, 65.773, 2.11, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241407, 32820, 0, 1, 1, 0, 0, -9438, 470.249, 53.274, 4.009, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241408, 32820, 0, 1, 1, 0, 0, -9437, -1452, 59.817, 6.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241409, 32820, 0, 1, 1, 0, 0, -9435, -639, 66.116, 5.863, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241410, 32820, 0, 1, 1, 0, 0, -9434, -1253, 49.267, 2.305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241411, 32820, 0, 1, 1, 0, 0, -9433, 482.528, 53.247, 2.295, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241412, 32820, 0, 1, 1, 0, 0, -9432, -1387, 46.663, 5.947, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241413, 32820, 0, 1, 1, 0, 0, -9432, 133.199, 58.837, 6.151, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241414, 32820, 0, 1, 1, 0, 0, -9432, 150.687, 55.834, 2.532, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241415, 32820, 0, 1, 1, 0, 0, -9431, -2104, 65.708, 2.979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241416, 32820, 0, 1, 1, 0, 0, -9430, -1514, 68.918, 0.448, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241417, 32820, 0, 1, 1, 0, 0, -9430, 132.438, 59.079, 2.802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241418, 32820, 0, 1, 1, 0, 0, -9430, 134.259, 58.901, 3.849, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241419, 32820, 0, 1, 1, 0, 0, -9429, -1262, 49.045, 1.86, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241420, 32820, 0, 1, 1, 0, 0, -9429, -1261, 49.154, 5.276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241421, 32820, 0, 1, 1, 0, 0, -9427, -671, 64.684, 4.566, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241422, 32820, 0, 1, 1, 0, 0, -9427, 323.42, 55.912, 3.39, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241423, 32820, 0, 1, 1, 0, 0, -9426.71, -1323.56, 51.4573, 2.53904, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241424, 32820, 0, 1, 1, 0, 0, -9422, -1239, 52.7, 5.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241425, 32820, 0, 1, 1, 0, 0, -9422, -1182, 56.483, 6.115, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241426, 32820, 0, 1, 1, 0, 0, -9421, -566, 67.708, 4.625, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241427, 32820, 0, 1, 1, 0, 0, -9421, -453, 60.422, 3.662, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241428, 32820, 0, 1, 1, 0, 0, -9419, -728, 65.583, 3.245, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241429, 32820, 0, 1, 1, 0, 0, -9418, -1362, 50.564, 4.5, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241430, 32820, 0, 1, 1, 0, 0, -9416, -782, 66.395, 1.487, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241431, 32820, 0, 1, 1, 0, 0, -9416, 155.709, 56.403, 5.045, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241432, 32820, 0, 1, 1, 0, 0, -9415, 295.758, 60.265, 4.891, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241433, 32820, 0, 1, 1, 0, 0, -9414, -845, 62.561, 0.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241434, 32820, 0, 1, 1, 0, 0, -9412, -387, 57.469, 2.226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241435, 32820, 0, 1, 1, 0, 0, -9412, -314, 60.602, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241436, 32820, 0, 1, 1, 0, 0, -9411, -1350, 50.028, 1.498, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241437, 32820, 0, 1, 1, 0, 0, -9410, -1271, 49.832, 5.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241438, 32820, 0, 1, 1, 0, 0, -9410, -853, 62.711, 0.461, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241439, 32820, 0, 1, 1, 0, 0, -9410, -324, 59.375, 1.682, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241440, 32820, 0, 1, 1, 0, 0, -9410, 208.355, 61.079, 3.912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241441, 32820, 0, 1, 1, 0, 0, -9409, 243.329, 61.172, 1.582, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241442, 32820, 0, 1, 1, 0, 0, -9408, -999, 61.864, 2.694, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241443, 32820, 0, 1, 1, 0, 0, -9407, -1107, 61.211, 5.323, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241444, 32820, 0, 1, 1, 0, 0, -9405, -1344, 50.111, 2.461, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241445, 32820, 0, 1, 1, 0, 0, -9404, -30, 64.335, 1.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241446, 32820, 0, 1, 1, 0, 0, -9402, 324.172, 58.219, 0.634, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241447, 32820, 0, 1, 1, 0, 0, -9400.99, -1336.26, 50.0274, 3.16106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241448, 32820, 0, 1, 1, 0, 0, -9397, -443, 60.336, 0.515, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241449, 32820, 0, 1, 1, 0, 0, -9397, 305.106, 61.005, 5.919, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241450, 32820, 0, 1, 1, 0, 0, -9396, -711, 67.79, 2.396, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241451, 32820, 0, 1, 1, 0, 0, -9395, -1514, 69.385, 4.886, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241452, 32820, 0, 1, 1, 0, 0, -9395, 312.681, 61.586, 1.533, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241453, 32820, 0, 1, 1, 0, 0, -9394, -2022, 58.275, 4.33, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241454, 32820, 0, 1, 1, 0, 0, -9393, -1276, 54.057, 6.24, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241455, 32820, 0, 1, 1, 0, 0, -9392, -345, 59.169, 5.621, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241456, 32820, 0, 1, 1, 0, 0, -9390, -587, 67.012, 4.101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241457, 32820, 0, 1, 1, 0, 0, -9390, -508, 68.811, 2.179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241458, 32820, 0, 1, 1, 0, 0, -9390, 56.554, 59.985, 3.128, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241459, 32820, 0, 1, 1, 0, 0, -9390, 528.081, 61.321, 3.906, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241460, 32820, 0, 1, 1, 0, 0, -9389, -1275, 55.114, 3.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241461, 32820, 0, 1, 1, 0, 0, -9387.13, -117.859, 58.8626, 2.81827, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241462, 32820, 0, 1, 1, 0, 0, -9387, -1435, 62.189, 0.904, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241463, 32820, 0, 1, 1, 0, 0, -9387, -963, 63.591, 2.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241464, 32820, 0, 1, 1, 0, 0, -9386, -1276, 55.562, 2.717, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241465, 32820, 0, 1, 1, 0, 0, -9384, -924, 63.488, 2.606, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241466, 32820, 0, 1, 1, 0, 0, -9384, -486, 68.886, 1.506, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241467, 32820, 0, 1, 1, 0, 0, -9384, -230, 64.15, 0.899, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241468, 32820, 0, 1, 1, 0, 0, -9384, -21, 62.361, 0.496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241469, 32820, 0, 1, 1, 0, 0, -9384, 343.232, 56.396, 4.664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241470, 32820, 0, 1, 1, 0, 0, -9381.82, -117.429, 58.7558, 4.28438, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241471, 32820, 0, 1, 1, 0, 0, -9381, -280, 64.459, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241472, 32820, 0, 1, 1, 0, 0, -9381, 127.141, 61.364, 3.11, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241473, 32820, 0, 1, 1, 0, 0, -9380, -70, 64.521, 4.555, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241474, 32820, 0, 1, 1, 0, 0, -9380, 29.617, 61.183, 2.488, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241475, 32820, 0, 1, 1, 0, 0, -9379, -112, 58.793, 2.077, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241476, 32820, 0, 1, 1, 0, 0, -9378, -1127, 62.701, 1.784, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241477, 32820, 0, 1, 1, 0, 0, -9378, -216, 63.953, 0.897, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241478, 32820, 0, 1, 1, 0, 0, -9376, -74, 64.521, 3.456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241479, 32820, 0, 1, 1, 0, 0, -9376, -67, 69.202, 1.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241480, 32820, 0, 1, 1, 0, 0, -9376, -66, 69.202, 5.798, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241481, 32820, 0, 1, 1, 0, 0, -9374, -1225, 63.762, 5.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241482, 32820, 0, 1, 1, 0, 0, -9374, -66, 69.202, 3.57, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241483, 32820, 0, 1, 1, 0, 0, -9373, -1210, 63.557, 3.059, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241484, 32820, 0, 1, 1, 0, 0, -9373, 134.102, 61.836, 1.385, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241485, 32820, 0, 1, 1, 0, 0, -9373, 147.602, 61.685, 4.386, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241486, 32820, 0, 1, 1, 0, 0, -9371, -944, 65.101, 5.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241487, 32820, 0, 1, 1, 0, 0, -9371, -70, 69.202, 0.374, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241488, 32820, 0, 1, 1, 0, 0, -9371, -68, 69.202, 5.049, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241489, 32820, 0, 1, 1, 0, 0, -9371, 134.791, 61.985, 4.722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241490, 32820, 0, 1, 1, 0, 0, -9369, -1192, 63.624, 0.609, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241491, 32820, 0, 1, 1, 0, 0, -9369, -68, 69.202, 2.963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241492, 32820, 0, 1, 1, 0, 0, -9367, -1168, 65.193, 5.53, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241493, 32820, 0, 1, 1, 0, 0, -9366, -810, 65.544, 2.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241494, 32820, 0, 1, 1, 0, 0, -9365, -596, 69.178, 4.296, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241495, 32820, 0, 1, 1, 0, 0, -9364, 11.024, 61.815, 2.506, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241496, 32820, 0, 1, 1, 0, 0, -9361, -1405, 63.575, 4.344, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241497, 32820, 0, 1, 1, 0, 0, -9361, -869, 64.962, 3.987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241498, 32820, 0, 1, 1, 0, 0, -9358, -926, 65.732, 2.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241499, 32820, 0, 1, 1, 0, 0, -9358, -849, 63.997, 2.375, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241500, 32820, 0, 1, 1, 0, 0, -9354, -1404, 63.973, 4.167, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241501, 32820, 0, 1, 1, 0, 0, -9354, -1195, 66.266, 2.266, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241502, 32820, 0, 1, 1, 0, 0, -9354, -186, 65.198, 0.372, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241503, 32820, 0, 1, 1, 0, 0, -9353, -904, 66.04, 6.18, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241504, 32820, 0, 1, 1, 0, 0, -9353, -843, 64.12, 6.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241505, 32820, 0, 1, 1, 0, 0, -9352, -1164, 65.353, 2.384, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241506, 32820, 0, 1, 1, 0, 0, -9352, -1160, 65.543, 5.245, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241507, 32820, 0, 1, 1, 0, 0, -9352, -611, 71.313, 1.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241508, 32820, 0, 1, 1, 0, 0, -9352, 503.765, 50.321, 4.473, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241509, 32820, 0, 1, 1, 0, 0, -9350, -1166, 65.293, 1.933, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241510, 32820, 0, 1, 1, 0, 0, -9347, -1445, 66.672, 1.459, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241511, 32820, 0, 1, 1, 0, 0, -9346, -748, 68.344, 0.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241512, 32820, 0, 1, 1, 0, 0, -9346, 44.308, 61.314, 2.717, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241513, 32820, 0, 1, 1, 0, 0, -9346, 477.343, 52.18, 5.385, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241514, 32820, 0, 1, 1, 0, 0, -9341, 165.021, 61.641, 1.096, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241515, 32820, 0, 1, 1, 0, 0, -9340, -1120, 67.994, 5.368, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241516, 32820, 0, 1, 1, 0, 0, -9340, -716, 67.003, 4.005, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241517, 32820, 0, 1, 1, 0, 0, -9338, -1155, 67.043, 0.595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241518, 32820, 0, 1, 1, 0, 0, -9336, -1254, 66.113, 5.261, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241519, 32820, 0, 1, 1, 0, 0, -9336, -436, 67.543, 3.382, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241520, 32820, 0, 1, 1, 0, 0, -9334, -947, 67.321, 5.957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241521, 32820, 0, 1, 1, 0, 0, -9331, -1168, 66.517, 3.206, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241522, 32820, 0, 1, 1, 0, 0, -9330, -1313, 65.07, 0.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241523, 32820, 0, 1, 1, 0, 0, -9328, -1318, 65.451, 3.679, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241524, 32820, 0, 1, 1, 0, 0, -9327, 366.189, 66.437, 4.384, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241525, 32820, 0, 1, 1, 0, 0, -9326, 325.428, 68.249, 2.474, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241526, 32820, 0, 1, 1, 0, 0, -9324.74, -106.101, 64.0093, 1.6099, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241527, 32820, 0, 1, 1, 0, 0, -9323, -557, 69.447, 0.586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241528, 32820, 0, 1, 1, 0, 0, -9322, -288, 69.495, 4.24, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241529, 32820, 0, 1, 1, 0, 0, -9321, -1189, 68.549, 4.907, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241530, 32820, 0, 1, 1, 0, 0, -9321, -386, 67.161, 3.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241531, 32820, 0, 1, 1, 0, 0, -9321, 551.713, 77.139, 2.583, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241532, 32820, 0, 1, 1, 0, 0, -9320, -272, 69.786, 1.371, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241533, 32820, 0, 1, 1, 0, 0, -9319, 397.511, 71.732, 0.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241534, 32820, 0, 1, 1, 0, 0, -9317, -1183, 68.226, 5.533, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241535, 32820, 0, 1, 1, 0, 0, -9316, -719, 67.299, 5.341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241536, 32820, 0, 1, 1, 0, 0, -9316, -520, 68.63, 2.477, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241537, 32820, 0, 1, 1, 0, 0, -9316, -495, 69.81, 1.649, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241538, 32820, 0, 1, 1, 0, 0, -9315, 324.735, 70.124, 0.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241539, 32820, 0, 1, 1, 0, 0, -9313, 281.484, 70.538, 2.381, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241540, 32820, 0, 1, 1, 0, 0, -9313, 291.223, 70.619, 4.102, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241541, 32820, 0, 1, 1, 0, 0, -9313, 335.962, 69.282, 5.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241542, 32820, 0, 1, 1, 0, 0, -9312, -432, 68.237, 2.052, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241543, 32820, 0, 1, 1, 0, 0, -9312, -169, 65.719, 4.121, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241544, 32820, 0, 1, 1, 0, 0, -9310, 355.481, 70.081, 4.042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241545, 32820, 0, 1, 1, 0, 0, -9309, -376, 71.145, 3.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241546, 32820, 0, 1, 1, 0, 0, -9309, 64.142, 76.196, 0.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241547, 32820, 0, 1, 1, 0, 0, -9309, 325.857, 70.749, 0.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241548, 32820, 0, 1, 1, 0, 0, -9309.12, 283.676, 70.5382, 2.26234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241549, 32820, 0, 1, 1, 0, 0, -9308, 454.329, 77.708, 2.505, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241550, 32820, 0, 1, 1, 0, 0, -9307, -287, 70.447, 3.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241551, 32820, 0, 1, 1, 0, 0, -9307, -109, 66.028, 0.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241552, 32820, 0, 1, 1, 0, 0, -9307, 363.144, 71.563, 1.509, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241553, 32820, 0, 1, 1, 0, 0, -9306, -1303, 68.616, 0.837, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241554, 32820, 0, 1, 1, 0, 0, -9304, -65, 67.552, 1.358, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241555, 32820, 0, 1, 1, 0, 0, -9303, -27, 69.883, 4.012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241556, 32820, 0, 1, 1, 0, 0, -9302, -105, 67.37, 0.023, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241557, 32820, 0, 1, 1, 0, 0, -9303.19, -292.231, 70.63, 3.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241558, 32820, 0, 1, 1, 0, 0, -9299, 406.242, 74.38, 1.508, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241559, 32820, 0, 1, 1, 0, 0, -9299, 653.552, 131.166, 4.433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241560, 32820, 0, 1, 1, 0, 0, -9299, 672.389, 131.976, 2.461, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241561, 32820, 0, 1, 1, 0, 0, -9298, 625.19, 130.763, 5.201, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241562, 32820, 0, 1, 1, 0, 0, -9297, 386.209, 75.43, 1.276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241563, 32820, 0, 1, 1, 0, 0, -9297, 394.508, 76.329, 6.133, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241564, 32820, 0, 1, 1, 0, 0, -9297, 702.451, 131.679, 4.268, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241565, 32820, 0, 1, 1, 0, 0, -9296, 474.446, 79.65, 4.031, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241566, 32820, 0, 1, 1, 0, 0, 1684.79, 1424.86, 136.907, 2.39333, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241567, 32820, 0, 1, 1, 0, 0, -9295, 693.985, 132.569, 1.479, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241568, 32820, 0, 1, 1, 0, 0, -9293, -6, 69.154, 2.281, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241569, 32820, 0, 1, 1, 0, 0, -9293, 707.857, 132.644, 4.331, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241570, 32820, 0, 1, 1, 0, 0, -9292, -674, 64.812, 1.99, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241571, 32820, 0, 1, 1, 0, 0, -9292, 388.547, 76.684, 2.622, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241572, 32820, 0, 1, 1, 0, 0, 2151.18, 1679.44, 84.4418, 5.45437, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241573, 32820, 0, 1, 1, 0, 0, -9289, -1268, 71.882, 3.342, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241574, 32820, 0, 1, 1, 0, 0, -9289, -1243, 70.201, 1.858, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241575, 32820, 0, 1, 1, 0, 0, -9289, -820, 69.269, 1.641, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241576, 32820, 0, 1, 1, 0, 0, -9289, 466.884, 80.109, 2.618, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241577, 32820, 0, 1, 1, 0, 0, 1992.5, 1552.64, 78.9382, 5.31272, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241578, 32820, 0, 1, 1, 0, 0, -9287, 461.562, 79.709, 5.307, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241579, 32820, 0, 1, 1, 0, 0, -9285, 350.418, 75.529, 4.967, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241580, 32820, 0, 1, 1, 0, 0, -9285, 375.705, 76.131, 6.197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241581, 32820, 0, 1, 1, 0, 0, -9285, 446.773, 79.723, 3.549, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241582, 32820, 0, 1, 1, 0, 0, -9284, 97.42, 68.968, 0.59, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241583, 32820, 0, 1, 1, 0, 0, -9282, -579, 65.184, 5.812, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241584, 32820, 0, 1, 1, 0, 0, -9282, -198, 69.361, 5.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241585, 32820, 0, 1, 1, 0, 0, -9282, 269.266, 70.933, 0.031, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241586, 32820, 0, 1, 1, 0, 0, -9281, -1310, 72.626, 0.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241587, 32820, 0, 1, 1, 0, 0, -9281, -1251, 72.546, 0.254, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241588, 32820, 0, 1, 1, 0, 0, -9281, 662.627, 131.965, 6.151, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241589, 32820, 0, 1, 1, 0, 0, -9280, -1270, 72.882, 4.849, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241590, 32820, 0, 1, 1, 0, 0, -9279, -1183, 71.143, 4.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241591, 32820, 0, 1, 1, 0, 0, -9279, 454.254, 80.569, 5.573, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241592, 32820, 0, 1, 1, 0, 0, -9278, -1253, 73.114, 0.458, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241593, 32820, 0, 1, 1, 0, 0, -9278, -1160, 68.225, 2.435, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241594, 32820, 0, 1, 1, 0, 0, -9277, -686, 63.879, 2.484, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241595, 32820, 0, 1, 1, 0, 0, -9277, -585, 65.184, 4.929, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241596, 32820, 0, 1, 1, 0, 0, -9273, 23.978, 71.351, 0.267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241597, 32820, 0, 1, 1, 0, 0, -9271, 398.325, 79.749, 4.007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241598, 32820, 0, 1, 1, 0, 0, -9270, -549, 66.459, 5.589, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241599, 32820, 0, 1, 1, 0, 0, -9268, 459.041, 81.799, 3.677, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241600, 32820, 0, 1, 1, 0, 0, -9266.12, 354.4, 76.6919, 2.2945, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241601, 32820, 0, 1, 1, 0, 0, -9265, 294.519, 71.125, 2.064, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241602, 32820, 0, 1, 1, 0, 0, -9261, 111.896, 70.995, 2.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241603, 32820, 0, 1, 1, 0, 0, -9260, -1972, 77.436, 6.126, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241604, 32820, 0, 1, 1, 0, 0, -9259, -21, 73.236, 1.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241605, 32820, 0, 1, 1, 0, 0, -9258, -1987, 77.061, 1.831, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241606, 32820, 0, 1, 1, 0, 0, -9256, -981, 68.516, 3.069, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241607, 32820, 0, 1, 1, 0, 0, -9256, -712, 62.856, 4.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241608, 32820, 0, 1, 1, 0, 0, -9256, -708, 63.098, 0.942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241609, 32820, 0, 1, 1, 0, 0, -9255, -1242, 73.934, 4.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241610, 32820, 0, 1, 1, 0, 0, -9254, -574, 66.763, 5.249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241611, 32820, 0, 1, 1, 0, 0, -9254, 129.862, 70.735, 1.889, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241612, 32820, 0, 1, 1, 0, 0, -9253, 368.858, 77.524, 1.918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241613, 32820, 0, 1, 1, 0, 0, -9253, 437.779, 85.565, 2.492, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241614, 32820, 0, 1, 1, 0, 0, -9252, -1241, 74.04, 2.156, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241615, 32820, 0, 1, 1, 0, 0, -9252, 451.583, 87.269, 1.573, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241616, 32820, 0, 1, 1, 0, 0, -9250, 126.236, 71.395, 3.382, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241617, 32820, 0, 1, 1, 0, 0, -9250, 131.177, 70.459, 5.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241618, 32820, 0, 1, 1, 0, 0, -9249, 382.408, 80.118, 4.058, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241619, 32820, 0, 1, 1, 0, 0, -9247, -577, 66.772, 4.605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241620, 32820, 0, 1, 1, 0, 0, -9246, -853, 69.761, 0.044, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241621, 32820, 0, 1, 1, 0, 0, -9246, 52.701, 73.837, 2.13, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241622, 32820, 0, 1, 1, 0, 0, -9245, -713, 63.039, 1.92, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241623, 32820, 0, 1, 1, 0, 0, -9245, 48.974, 73.712, 1.003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241624, 32820, 0, 1, 1, 0, 0, -9245, 275.584, 72.016, 2.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241625, 32820, 0, 1, 1, 0, 0, -9244, -2261, 63.933, 4.036, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241626, 32820, 0, 1, 1, 0, 0, -9244, 238.294, 71.189, 2.089, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241627, 32820, 0, 1, 1, 0, 0, -9242, -1161, 63.476, 1.693, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241628, 32820, 0, 1, 1, 0, 0, -9239, -40, 71.632, 3.505, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241629, 32820, 0, 1, 1, 0, 0, -9238, 244.909, 71.441, 3.295, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241630, 32820, 0, 1, 1, 0, 0, -9236, -1226, 72.69, 0.837, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241631, 32820, 0, 1, 1, 0, 0, -9236, -67, 73.709, 4.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241632, 32820, 0, 1, 1, 0, 0, -9234, 265.97, 72.531, 2.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241633, 32820, 0, 1, 1, 0, 0, -9232, 361.053, 73.698, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241634, 32820, 0, 1, 1, 0, 0, -9230, -1199, 67.716, 1.134, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241635, 32820, 0, 1, 1, 0, 0, -9230, 46.47, 74.578, 2.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241636, 32820, 0, 1, 1, 0, 0, -9229, 67.144, 75.609, 5.941, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241637, 32820, 0, 1, 1, 0, 0, -9228, -70, 74.946, 2.101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241638, 32820, 0, 1, 1, 0, 0, -9226, -1031, 69.881, 4.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241639, 32820, 0, 1, 1, 0, 0, -9225, -62, 74.978, 3.717, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241640, 32820, 0, 1, 1, 0, 0, -9225, 9.06, 76.471, 3.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241641, 32820, 0, 1, 1, 0, 0, -9224, -50, 73.483, 5.111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241642, 32820, 0, 1, 1, 0, 0, -9224, -40, 73.401, 4.839, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241643, 32820, 0, 1, 1, 0, 0, -9223, -630, 61.972, 5.414, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241644, 32820, 0, 1, 1, 0, 0, -9222, 54.203, 75.669, 1.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241645, 32820, 0, 1, 1, 0, 0, -9221, 52.523, 75.601, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241646, 32820, 0, 1, 1, 0, 0, -9219, -1243, 76.007, 3.363, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241647, 32820, 0, 1, 1, 0, 0, -9218, -1229, 72.683, 1.85, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241648, 32820, 0, 1, 1, 0, 0, -9217, 427.754, 89.692, 0.175, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241649, 32820, 0, 1, 1, 0, 0, -9215, -39, 75.276, 0.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241650, 32820, 0, 1, 1, 0, 0, -9214, -48, 74.123, 1.782, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241651, 32820, 0, 1, 1, 0, 0, -9213, 302.359, 74.24, 2.633, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241652, 32820, 0, 1, 1, 0, 0, -9213, 426.235, 88.855, 0.441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241653, 32820, 0, 1, 1, 0, 0, -9211, 146.711, 72.205, 4.103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241654, 32820, 0, 1, 1, 0, 0, -9211, 243.926, 72.691, 0.525, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241655, 32820, 0, 1, 1, 0, 0, -9210, 54.903, 76.405, 4.504, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241656, 32820, 0, 1, 1, 0, 0, -9209, 414.569, 88.298, 3.841, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241657, 32820, 0, 1, 1, 0, 0, -9208, 31.073, 74.841, 2.235, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241658, 32820, 0, 1, 1, 0, 0, -9203, 419.836, 89.486, 4.915, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241659, 32820, 0, 1, 1, 0, 0, -9202.86, 204.19, 71.1686, 3.47368, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241660, 32820, 0, 1, 1, 0, 0, -9199, 63.807, 77.537, 3.797, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241661, 32820, 0, 1, 1, 0, 0, -9196, -1113, 71.647, 4.988, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241662, 32820, 0, 1, 1, 0, 0, -9196, -846, 70.045, 2.073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241663, 32820, 0, 1, 1, 0, 0, -9195, -1215, 68.435, 1.082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241664, 32820, 0, 1, 1, 0, 0, -9195, -1003, 70.54, 3.322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241665, 32820, 0, 1, 1, 0, 0, -9190, 356.967, 76.234, 5.988, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241666, 32820, 0, 1, 1, 0, 0, -9189, -2301, 90.541, 3.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241667, 32820, 0, 1, 1, 0, 0, -9185, -643, 65.545, 5.197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241668, 32820, 0, 1, 1, 0, 0, -9185, 117.698, 74.854, 4.701, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241669, 32820, 0, 1, 1, 0, 0, -9182, 412.594, 89.109, 1.428, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241670, 32820, 0, 1, 1, 0, 0, -9177, 418.347, 91.326, 0.86, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241671, 32820, 0, 1, 1, 0, 0, -9176, 0.704, 80.476, 5.794, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241672, 32820, 0, 1, 1, 0, 0, -9175, -1125, 71.073, 4.476, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241673, 32820, 0, 1, 1, 0, 0, -9175, 44.244, 78.296, 5.373, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241674, 32820, 0, 1, 1, 0, 0, -9173.18, 317.426, 80.4488, 0.5183, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241675, 32820, 0, 1, 1, 0, 0, -9172, -1262, 76.002, 4.264, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241676, 32820, 0, 1, 1, 0, 0, -9172, -1251, 75.127, 2.195, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241677, 32820, 0, 1, 1, 0, 0, -9164.27, 16.4855, 78.7518, 2.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241678, 32820, 0, 1, 1, 0, 0, -9163, 86.072, 76.823, 4.657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241679, 32820, 0, 1, 1, 0, 0, -9162, 84.631, 77.076, 1.632, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241680, 32820, 0, 1, 1, 0, 0, -9159, -591, 59.162, 2.716, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241681, 32820, 0, 1, 1, 0, 0, -9159, 15.513, 78.548, 0.996, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241682, 32820, 0, 1, 1, 0, 0, -9155, -1277, 77.293, 4.105, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241683, 32820, 0, 1, 1, 0, 0, -9154, -962, 71.24, 4.629, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241684, 32820, 0, 1, 1, 0, 0, -9150, -1243, 74.013, 1.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241685, 32820, 0, 1, 1, 0, 0, -9144, -1065, 71.558, 1.585, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241686, 32820, 0, 1, 1, 0, 0, -9136, -1148, 70.616, 4.383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241687, 32820, 0, 1, 1, 0, 0, -9135, -818, 70.427, 2.753, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241688, 32820, 0, 1, 1, 0, 0, -9132, -596, 57.446, 4.187, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241689, 32820, 0, 1, 1, 0, 0, -9130, -984, 76.181, 2.059, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241690, 32820, 0, 1, 1, 0, 0, -9122, -300, 73.442, 5.435, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241691, 32820, 0, 1, 1, 0, 0, -9121, -386, 73.345, 0.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241692, 32820, 0, 1, 1, 0, 0, -9121, -355, 73.511, 0.882, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241693, 32820, 0, 1, 1, 0, 0, -9118, -1080, 72.304, 2.059, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241694, 32820, 0, 1, 1, 0, 0, -9118, -1017, 72.287, 0.898, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241695, 32820, 0, 1, 1, 0, 0, -9110, -257, 75.005, 1.177, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241696, 32820, 0, 1, 1, 0, 0, -9107, -1217, 65.194, 0.54, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241697, 32820, 0, 1, 1, 0, 0, -9100, -564, 61.503, 5.695, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241698, 32820, 0, 1, 1, 0, 0, -9098, -1101, 73.715, 2.16, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241699, 32820, 0, 1, 1, 0, 0, -9095, -12, 91.408, 3.817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241700, 32820, 0, 1, 1, 0, 0, -9092, -951, 68.852, 6.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241701, 32820, 0, 1, 1, 0, 0, -9092, -238, 74.343, 0.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241702, 32820, 0, 1, 1, 0, 0, -9091, -23, 90.156, 3.576, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241703, 32820, 0, 1, 1, 0, 0, -9090, -417, 74.617, 0.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241704, 32820, 0, 1, 1, 0, 0, -9087, -242, 74.122, 2.901, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241705, 32820, 0, 1, 1, 0, 0, -9087, -31, 89.033, 2.37, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241706, 32820, 0, 1, 1, 0, 0, -9085, -577, 62.104, 1.69, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241707, 32820, 0, 1, 1, 0, 0, -9085, -556, 60.266, 5.407, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241708, 32820, 0, 1, 1, 0, 0, -9085, -281, 73.99, 4.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241709, 32820, 0, 1, 1, 0, 0, -9081, -180, 74.765, 4.778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241710, 32820, 0, 1, 1, 0, 0, -9079, -1050, 72.226, 1.654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241711, 32820, 0, 1, 1, 0, 0, -9079, -331, 73.452, 2.367, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241712, 32820, 0, 1, 1, 0, 0, -9079.87, 442.777, 93.2956, 5.26296, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241713, 32820, 0, 1, 1, 0, 0, -9076, -1218, 66.36, 3.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241714, 32820, 0, 1, 1, 0, 0, -9072, -348, 73.45, 6.175, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241715, 32820, 0, 1, 1, 0, 0, -9059.67, 417.093, 93.2961, 2.26746, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241716, 32820, 0, 1, 1, 0, 0, -9065, -547, 58.235, 1.246, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241717, 32820, 0, 1, 1, 0, 0, -9065, -312, 73.452, 2.842, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241718, 32820, 0, 1, 1, 0, 0, -9064, -48, 88.244, 1.519, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241719, 32820, 0, 1, 1, 0, 0, -9063, -39, 87.959, 4.575, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241720, 32820, 0, 1, 1, 0, 0, -9060, 148.566, 115.222, 1.606, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241721, 32820, 0, 1, 1, 0, 0, -9093.46, 425.22, 92.1354, 4.12178, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241722, 32820, 0, 1, 1, 0, 0, -9059, -458, 72.486, 1.305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241723, 32820, 0, 1, 1, 0, 0, -9056, -459, 72.524, 1.373, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241724, 32820, 0, 1, 1, 0, 0, -9056, 152.629, 115.116, 3.159, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241725, 32820, 0, 1, 1, 0, 0, -9053, -95, 88.19, 1.118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241726, 32820, 0, 1, 1, 0, 0, -9052, -621, 53.577, 4.241, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241727, 32820, 0, 1, 1, 0, 0, -9052, -458, 72.651, 1.578, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241728, 32820, 0, 1, 1, 0, 0, -9045, -553, 55.85, 6.107, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241729, 32820, 0, 1, 1, 0, 0, -9045, -264, 74.078, 3.496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241730, 32820, 0, 1, 1, 0, 0, -9044, -45, 88.36, 2.96, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241731, 32820, 0, 1, 1, 0, 0, -9041, -324, 73.702, 0.899, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241732, 32820, 0, 1, 1, 0, 0, -9040, -1105, 71.361, 4.023, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241733, 32820, 0, 1, 1, 0, 0, -9040, -607, 53.241, 1.478, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241734, 32820, 0, 1, 1, 0, 0, -9036, -265, 73.556, 5.196, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241735, 32820, 0, 1, 1, 0, 0, -9034, -368, 75.484, 4.205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241736, 32820, 0, 1, 1, 0, 0, -9031, 10.083, 87.884, 4.486, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241737, 32820, 0, 1, 1, 0, 0, -9029, -422, 69.392, 3.737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241738, 32820, 0, 1, 1, 0, 0, -9016, -149, 83.221, 5.737, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241739, 32820, 0, 1, 1, 0, 0, -9013, -845, 70.453, 3.003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241740, 32820, 0, 1, 1, 0, 0, -9012, -981, 69.494, 5.286, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241741, 32820, 0, 1, 1, 0, 0, -9012, -409, 70.771, 3.896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241742, 32820, 0, 1, 1, 0, 0, -9012, -376, 74.271, 5.453, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241743, 32820, 0, 1, 1, 0, 0, -9012, -362, 75.378, 1.618, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241744, 32820, 0, 1, 1, 0, 0, -9011, -1231, 74.086, 0.222, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241745, 32820, 0, 1, 1, 0, 0, -9011, -867, 69.49, 1.788, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241746, 32820, 0, 1, 1, 0, 0, -9003, -148, 80.381, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241747, 32820, 0, 1, 1, 0, 0, -9001, -826, 69.884, 2, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241748, 32820, 0, 1, 1, 0, 0, -9001, -404, 71.292, 6.259, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241749, 32820, 0, 1, 1, 0, 0, -9000, -414, 69.884, 3.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241750, 32820, 0, 1, 1, 0, 0, -8996, -818, 69.715, 2.023, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241751, 32820, 0, 1, 1, 0, 0, -8914.36, -134.589, 80.4957, 2.23039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241752, 32820, 0, 1, 1, 0, 0, -8990, -771, 73.386, 5.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241753, 32820, 0, 1, 1, 0, 0, -8989, -1174, 65.43, 1.623, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241754, 32820, 0, 1, 1, 0, 0, -8987, -855, 69.49, 4.981, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241755, 32820, 0, 1, 1, 0, 0, -8984, -1199, 71.807, 1.113, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241756, 32820, 0, 1, 1, 0, 0, -8984, -1170, 65.087, 2.688, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241757, 32820, 0, 1, 1, 0, 0, -8980, -208, 73.729, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241758, 32820, 0, 1, 1, 0, 0, -8978, -339, 73.712, 5.346, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241759, 32820, 0, 1, 1, 0, 0, -8974, -57, 91.582, 1.171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241760, 32820, 0, 1, 1, 0, 0, -8971, -359, 73.401, 2.806, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241761, 32820, 0, 1, 1, 0, 0, -8967, -203, 75.644, 2.318, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241762, 32820, 0, 1, 1, 0, 0, -8962, -406, 68.404, 3.042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241763, 32820, 0, 1, 1, 0, 0, -8961, -447, 66.772, 4.475, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241764, 32820, 0, 1, 1, 0, 0, -8960, -807, 69.773, 1.665, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241765, 32820, 0, 1, 1, 0, 0, -8960, -228, 77.593, 4.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241766, 32820, 0, 1, 1, 0, 0, -8959, -792, 69.974, 1.393, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241767, 32820, 0, 1, 1, 0, 0, -8956, -43, 91.414, 1.311, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241768, 32820, 0, 1, 1, 0, 0, -8955, -373, 72.205, 2.905, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241769, 32820, 0, 1, 1, 0, 0, -8952, -1145, 66.507, 6.157, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241770, 32820, 0, 1, 1, 0, 0, -8952, -404, 68.705, 3.014, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241771, 32820, 0, 1, 1, 0, 0, -8952, 536.444, 96.367, 4.248, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241772, 32820, 0, 1, 1, 0, 0, -8951, -790, 69.117, 0.205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241773, 32820, 0, 1, 1, 0, 0, -8951, -418, 65.92, 0.187, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241774, 32820, 0, 1, 1, 0, 0, -8949, -78, 89.266, 2.86, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241775, 32820, 0, 1, 1, 0, 0, -8948, -773, 68.77, 4.14, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241776, 32820, 0, 1, 1, 0, 0, -8937, -378, 71.14, 1.232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241777, 32820, 0, 1, 1, 0, 0, -8937, 518.506, 96.366, 3.598, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241778, 32820, 0, 1, 1, 0, 0, -8935, -52, 90.24, 0.223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241779, 32820, 0, 1, 1, 0, 0, -8934, -167, 80.842, 5.977, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241780, 32820, 0, 1, 1, 0, 0, -8932.9, -136.332, 83.1518, 1.6083, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241781, 32820, 0, 1, 1, 0, 0, -8931, 78.547, 154.017, 5.008, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241782, 32820, 0, 1, 1, 0, 0, -8929, -734, 70.519, 5.786, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241783, 32820, 0, 1, 1, 0, 0, -8929, -63, 89.939, 5.168, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241784, 32820, 0, 1, 1, 0, 0, -8928, -202, 80.682, 2.204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241785, 32820, 0, 1, 1, 0, 0, -8927, -196, 80.771, 2.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241786, 32820, 0, 1, 1, 0, 0, -8924, -438, 67.911, 0.277, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241787, 32820, 0, 1, 1, 0, 0, -8947.97, -182.604, 79.8355, 5.84689, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241788, 32820, 0, 1, 1, 0, 0, -8921, -1201, 74.587, 3.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241789, 32820, 0, 1, 1, 0, 0, -8918, -403, 67.755, 0.63, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241790, 32820, 0, 1, 1, 0, 0, -8918, -208, 82.309, 6.282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241791, 32820, 0, 1, 1, 0, 0, -8917, -36, 91.844, 0.749, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241792, 32820, 0, 1, 1, 0, 0, -8915, -438, 69.636, 1.035, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241793, 32820, 0, 1, 1, 0, 0, -8915, -215, 82.3, 1.204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241794, 32820, 0, 1, 1, 0, 0, -8914, -810, 68.928, 3.611, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241795, 32820, 0, 1, 1, 0, 0, -8910, -278, 78.267, 4.534, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241796, 32820, 0, 1, 1, 0, 0, -8910, -262, 79.214, 4.587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241797, 32820, 0, 1, 1, 0, 0, -8910, -105, 81.848, 4.411, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241798, 32820, 0, 1, 1, 0, 0, -8908.13, -108.89, 81.8481, 4.28817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241799, 32820, 0, 1, 1, 0, 0, -8906, -891, 73.501, 3.254, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241800, 32820, 0, 1, 1, 0, 0, -8904, 792.487, 87.501, 2.376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241801, 32820, 0, 1, 1, 0, 0, -8903, -286, 77.597, 3.899, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241802, 32820, 0, 1, 1, 0, 0, -8903, -163, 82.022, 2.042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241803, 32820, 0, 1, 1, 0, 0, -8902, -182, 113.24, 0.873, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241804, 32820, 0, 1, 1, 0, 0, -8901.56, -112.697, 81.8482, 3.18871, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241805, 32820, 0, 1, 1, 0, 0, -8901, -362, 71.707, 5.729, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241806, 32820, 0, 1, 1, 0, 0, -8901, -80, 84.384, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241807, 32820, 0, 1, 1, 0, 0, -8898, -120, 82.016, 3.315, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241808, 32820, 0, 1, 1, 0, 0, -8898, -19, 92.553, 1.283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241809, 32820, 0, 1, 1, 0, 0, -8897.47, -115.457, 81.838, 3.76358, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241810, 32820, 0, 1, 1, 0, 0, -8896, -769, 69.566, 5.637, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241811, 32820, 0, 1, 1, 0, 0, -8895, 575.431, 92.564, 5.253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241812, 32820, 0, 1, 1, 0, 0, -8893, -1205, 76.779, 4.969, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241813, 32820, 0, 1, 1, 0, 0, -8892, -47, 86.954, 4.215, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241814, 32820, 0, 1, 1, 0, 0, -8890, -919, 75.5, 2.696, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241815, 32820, 0, 1, 1, 0, 0, -8890, 639.99, 99.522, 0.474, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241816, 32820, 0, 1, 1, 0, 0, -8889, -755, 69.426, 1.799, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241817, 32820, 0, 1, 1, 0, 0, -8889, -393, 67.44, 2.896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241818, 32820, 0, 1, 1, 0, 0, -8888, 566.202, 92.534, 2.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241819, 32820, 0, 1, 1, 0, 0, -8887, -779, 69.713, 0.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241820, 32820, 0, 1, 1, 0, 0, -8887, 635.868, 99.606, 0.765, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241821, 32820, 0, 1, 1, 0, 0, -8886, -1023, 72.819, 4.919, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241822, 32820, 0, 1, 1, 0, 0, -8885, 6.25, 94.517, 4.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241823, 32820, 0, 1, 1, 0, 0, -8885, 752.073, 96.195, 5.432, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241824, 32820, 0, 1, 1, 0, 0, -8883, -60, 85.681, 5.152, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241825, 32820, 0, 1, 1, 0, 0, -8883, -33, 88.557, 5.21, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241826, 32820, 0, 1, 1, 0, 0, -8882, 6.896, 93.946, 0.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241827, 32820, 0, 1, 1, 0, 0, -8879, -955, 75.224, 6.101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241828, 32820, 0, 1, 1, 0, 0, -8877, -1107, 75.2, 1.914, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241829, 32820, 0, 1, 1, 0, 0, -8877, -1083, 74.682, 1.344, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241830, 32820, 0, 1, 1, 0, 0, -8876, -186, 81.938, 1.482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241831, 32820, 0, 1, 1, 0, 0, -8875, 13.938, 92.975, 1.121, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241832, 32820, 0, 1, 1, 0, 0, -8874, -923, 75.937, 2.913, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241833, 32820, 0, 1, 1, 0, 0, -8874, -78, 83.112, 5.152, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241834, 32820, 0, 1, 1, 0, 0, -8869, -374, 71.815, 5.453, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241835, 32820, 0, 1, 1, 0, 0, -8842.51, -270.136, 81.1989, 1.18472, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241836, 32820, 0, 1, 1, 0, 0, -8865, -217, 80.956, 4.368, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241837, 32820, 0, 1, 1, 0, 0, -8865, 762.931, 96.889, 2.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241838, 32820, 0, 1, 1, 0, 0, -8860, -813, 70.458, 0.663, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241839, 32820, 0, 1, 1, 0, 0, -8857, 937.947, 102.143, 0.53, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241840, 32820, 0, 1, 1, 0, 0, -8856, -81, 84.245, 0.97, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241841, 32820, 0, 1, 1, 0, 0, -8855, -1139, 76.615, 1.998, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241842, 32820, 0, 1, 1, 0, 0, -8854, -938, 76.242, 4.371, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241843, 32820, 0, 1, 1, 0, 0, -8854, -823, 71.878, 4.805, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241844, 32820, 0, 1, 1, 0, 0, -8854, -192, 81.933, 3.32, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241845, 32820, 0, 1, 1, 0, 0, -8854, 541.299, 105.898, 4.976, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241846, 32820, 0, 1, 1, 0, 0, -8853, -835, 73.025, 1.413, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241847, 32820, 0, 1, 1, 0, 0, -8853, -776, 70.516, 5.55, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241848, 32820, 0, 1, 1, 0, 0, -8851, -919, 75.995, 1.985, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241849, 32820, 0, 1, 1, 0, 0, -8851, -223, 81.562, 4.969, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241850, 32820, 0, 1, 1, 0, 0, -8851, -188, 89.313, 2.37, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241851, 32820, 0, 1, 1, 0, 0, -8850, -287, 78.741, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241852, 32820, 0, 1, 1, 0, 0, -8849, -918, 76.015, 2.365, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241853, 32820, 0, 1, 1, 0, 0, -8848, -812, 70.712, 4.206, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241854, 32820, 0, 1, 1, 0, 0, -8848, -105, 81.92, 3.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241855, 32820, 0, 1, 1, 0, 0, -8844, -1125, 76.107, 5.95, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241856, 32820, 0, 1, 1, 0, 0, -8843, -981, 74.577, 1.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241857, 32820, 0, 1, 1, 0, 0, -8838, -854, 74.684, 0.639, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241858, 32820, 0, 1, 1, 0, 0, -8837, -999, 74.077, 6.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241859, 32820, 0, 1, 1, 0, 0, -8835, -61, 86.624, 0.924, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241860, 32820, 0, 1, 1, 0, 0, -8835, 723.541, 97.881, 1.986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241861, 32820, 0, 1, 1, 0, 0, -8834, -881, 74.428, 2.025, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241862, 32820, 0, 1, 1, 0, 0, -8833, 542.104, 96.942, 2.753, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241863, 32820, 0, 1, 1, 0, 0, -8828, -867, 74.593, 3.229, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241864, 32820, 0, 1, 1, 0, 0, -8827, 904.341, 98.139, 4.034, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241865, 32820, 0, 1, 1, 0, 0, -8825, 613.922, 94.463, 0.89, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241866, 32820, 0, 1, 1, 0, 0, -8824, -142, 80.839, 5.912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241867, 32820, 0, 1, 1, 0, 0, -8821, -843, 74.501, 2.856, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241868, 32820, 0, 1, 1, 0, 0, -8821, -122, 80.865, 3.5, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241869, 32820, 0, 1, 1, 0, 0, -8818, 97.723, 164.66, 4.413, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241870, 32820, 0, 1, 1, 0, 0, -8817, 810.273, 99.022, 3.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241871, 32820, 0, 1, 1, 0, 0, -8813, 803.688, 98.623, 3.761, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241872, 32820, 0, 1, 1, 0, 0, -8812, -169, 81.309, 5.209, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241873, 32820, 0, 1, 1, 0, 0, -8811, -1017, 75.755, 4.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241874, 32820, 0, 1, 1, 0, 0, -8811, -244, 82.142, 2.682, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241875, 32820, 0, 1, 1, 0, 0, -8809, -213, 81.973, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241876, 32820, 0, 1, 1, 0, 0, -8809, -61, 91.362, 0.557, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241877, 32820, 0, 1, 1, 0, 0, -8808, -96, 83.649, 5.901, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241878, 32820, 0, 1, 1, 0, 0, -8808, 623.519, 94.485, 2.347, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241879, 32820, 0, 1, 1, 0, 0, -8803, -81, 86.374, 3.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241880, 32820, 0, 1, 1, 0, 0, -8803, 862.081, 98.887, 2.161, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241881, 32820, 0, 1, 1, 0, 0, -8799, -1097, 76.21, 1.408, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241882, 32820, 0, 1, 1, 0, 0, -8799, 865.216, 98.958, 2.381, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241883, 32820, 0, 1, 1, 0, 0, -8798, -99, 83.259, 2.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241884, 32820, 0, 1, 1, 0, 0, -8797, -173, 81.655, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241885, 32820, 0, 1, 1, 0, 0, -8796, -211, 82.807, 2.339, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241886, 32820, 0, 1, 1, 0, 0, -8795, -108, 83.073, 1.504, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241887, 32820, 0, 1, 1, 0, 0, -8791, -129, 82.513, 4.16, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241888, 32820, 0, 1, 1, 0, 0, -8790, -124, 82.994, 4.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241889, 32820, 0, 1, 1, 0, 0, -8790, -121, 82.98, 2.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241890, 32820, 0, 1, 1, 0, 0, -8787, -935, 74.019, 3.324, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241891, 32820, 0, 1, 1, 0, 0, -8787, -252, 82.661, 2.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241892, 32820, 0, 1, 1, 0, 0, -8785, -278, 78.736, 0.996, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241893, 32820, 0, 1, 1, 0, 0, -8782, -203, 84.005, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241894, 32820, 0, 1, 1, 0, 0, -8780, -59, 92.094, 0.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241895, 32820, 0, 1, 1, 0, 0, -8779, -250, 82.702, 2.752, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241896, 32820, 0, 1, 1, 0, 0, -8779, -171, 82.004, 0.97, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241897, 32820, 0, 1, 1, 0, 0, -8773, -127, 83.395, 3.134, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241898, 32820, 0, 1, 1, 0, 0, -8772, -151, 81.32, 0.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241899, 32820, 0, 1, 1, 0, 0, -8770, -158, 81.992, 4.023, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241900, 32820, 0, 1, 1, 0, 0, -8770, -118, 83.495, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241901, 32820, 0, 1, 1, 0, 0, -8770, -102, 87.125, 5.647, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241902, 32820, 0, 1, 1, 0, 0, -8769, -286, 77.486, 3.298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241903, 32820, 0, 1, 1, 0, 0, -8769, -272, 78.433, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241904, 32820, 0, 1, 1, 0, 0, -8768, -76, 90.689, 2.175, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241905, 32820, 0, 1, 1, 0, 0, -8765, -232, 85.305, 5.685, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241906, 32820, 0, 1, 1, 0, 0, -8765, -193, 85.266, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241907, 32820, 0, 1, 1, 0, 0, -8765, -183, 84.088, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241908, 32820, 0, 1, 1, 0, 0, -8765, 607.706, 96.892, 3.959, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241909, 32820, 0, 1, 1, 0, 0, -8760.53, -109.372, 85.435, 3.84574, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241910, 32820, 0, 1, 1, 0, 0, -8763, -158, 82.828, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241911, 32820, 0, 1, 1, 0, 0, -8762, -144, 81.933, 3.59, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241912, 32820, 0, 1, 1, 0, 0, -8756, -186, 84.99, 4.422, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241913, 32820, 0, 1, 1, 0, 0, -8756, -89, 91.77, 2.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241914, 32820, 0, 1, 1, 0, 0, -8755, -129, 83.029, 2.396, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241915, 32820, 0, 1, 1, 0, 0, -8753, -203, 86.316, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241916, 32820, 0, 1, 1, 0, 0, -8744, -177, 85.559, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241917, 32820, 0, 1, 1, 0, 0, -8743, -120, 85.732, 1.077, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241918, 32820, 0, 1, 1, 0, 0, -8742, -163, 84.981, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241919, 32820, 0, 1, 1, 0, 0, -8741, -192, 86.09, 0.947, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241920, 32820, 0, 1, 1, 0, 0, -8741, -97, 89.23, 2.363, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241921, 32820, 0, 1, 1, 0, 0, -8737, -58, 91.341, 2.596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241922, 32820, 0, 1, 1, 0, 0, -8735, -103, 87.046, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241923, 32820, 0, 1, 1, 0, 0, -8728, 375.537, 101.265, 3.352, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241924, 32820, 0, 1, 1, 0, 0, -8600.26, -139.186, 87.808, 3.4111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241925, 32820, 0, 1, 1, 0, 0, -8724, -139, 86.919, 4.184, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241926, 32820, 0, 1, 1, 0, 0, -8723, -208, 89.648, 3.229, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241927, 32820, 0, 1, 1, 0, 0, -8717, -105, 87.423, 3.695, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241928, 32820, 0, 1, 1, 0, 0, -8717, 923.309, 100.879, 2.292, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241929, 32820, 0, 1, 1, 0, 0, -8714, 348.185, 101.019, 2.83, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241930, 32820, 0, 1, 1, 0, 0, -8710, -80, 90.094, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241931, 32820, 0, 1, 1, 0, 0, -8708, -188, 99.205, 5.373, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241932, 32820, 0, 1, 1, 0, 0, -8698, -74, 89.932, 0.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241933, 32820, 0, 1, 1, 0, 0, -8691, -122, 88.343, 2.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241934, 32820, 0, 1, 1, 0, 0, -8685, -185, 91.246, 0.43, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241935, 32820, 0, 1, 1, 0, 0, -8684, 575.301, 97.054, 3.805, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241936, 32820, 0, 1, 1, 0, 0, -8682, -100, 89.536, 2.684, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241937, 32820, 0, 1, 1, 0, 0, -8680, -191, 91.409, 6.181, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241938, 32820, 0, 1, 1, 0, 0, -8679, 635.687, 96.969, 2.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241939, 32820, 0, 1, 1, 0, 0, -8676, -203, 94.627, 4.422, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241940, 32820, 0, 1, 1, 0, 0, -8676, 638.406, 96.969, 2.26, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241941, 32820, 0, 1, 1, 0, 0, -8675, 869.995, 97.016, 2.455, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241942, 32820, 0, 1, 1, 0, 0, -8586.41, -147.882, 89.9644, 2.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241943, 32820, 0, 1, 1, 0, 0, -8556, -217.474, 84.981, 2.05473, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241944, 32820, 0, 1, 1, 0, 0, -8644, 801.707, 96.67, 2.527, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241945, 32820, 0, 1, 1, 0, 0, -8561.69, -148.63, 88.3487, 3.41111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241946, 32820, 0, 1, 1, 0, 0, -8545.58, -159.898, 87.1807, 1.5772, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241947, 32820, 0, 1, 1, 0, 0, -8539.24, -174.348, 85.1864, 2.13876, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241948, 32820, 0, 1, 1, 0, 0, -8623, 848.741, 96.721, 2.331, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241949, 32820, 0, 1, 1, 0, 0, -8618, 784.698, 97.252, 3.766, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241950, 32820, 0, 1, 1, 0, 0, -8565.04, -218.299, 85.4327, 0.399106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241951, 32820, 0, 1, 1, 0, 0, -8613, 778.144, 97.243, 3.864, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241952, 32820, 0, 1, 1, 0, 0, -8551.88, -202.872, 85.526, 5.97622, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241953, 32820, 0, 1, 1, 0, 0, -8533.56, -195.278, 83.5968, 1.74214, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241954, 32820, 0, 1, 1, 0, 0, -8583.03, -173.171, 90.9283, 1.62904, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241955, 32820, 0, 1, 1, 0, 0, -8644.95, -115.942, 88.0407, 3.95727, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241956, 32820, 0, 1, 1, 0, 0, -8563.16, -203.576, 84.3093, 4.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241957, 32820, 0, 1, 1, 0, 0, -8635.73, -111.035, 86.8433, 3.64311, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241958, 32820, 0, 1, 1, 0, 0, -8544, 502.641, 98.552, 5.48, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241959, 32820, 0, 1, 1, 0, 0, -8887.99, -274.452, 80.4154, 4.88438, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241960, 32820, 0, 1, 1, 0, 0, -8856.3, -252.666, 81.1253, 5.68549, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241961, 32820, 0, 1, 1, 0, 0, -8534, 692.766, 97.669, 3.918, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(241962, 32820, 0, 1, 1, 0, 0, -8368, 542.082, 91.797, 2.27, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241963, 32820, 0, 1, 1, 0, 0, -8217, -499, 197.379, 2.145, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241964, 32820, 0, 1, 1, 0, 0, -8208, -485, 193.739, 5.354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241965, 32820, 0, 1, 1, 0, 0, -8205, -483, 193.823, 2.678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241966, 32820, 0, 1, 1, 0, 0, -8184, -577, 200.644, 4.471, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241967, 32820, 0, 1, 1, 0, 0, -8177, -594, 200.167, 0.811, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241968, 32820, 0, 1, 1, 0, 0, -8159, -597, 199.913, 2.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241969, 32820, 0, 1, 1, 0, 0, -8150, -540, 200.85, 1.866, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241970, 32820, 0, 1, 1, 0, 0, -7501, -2145, 146.088, 0.955, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241971, 32820, 0, 1, 1, 0, 0, -6807, -2289, 280.753, 2.587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241972, 32820, 0, 1, 1, 0, 0, -6439, -1115, 312.16, 3.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241973, 32820, 0, 1, 1, 0, 0, 1901.5, 1507.09, 89.1851, 0.850343, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241974, 32820, 0, 1, 1, 0, 0, 1939.89, 1545.48, 90.165, 1.22525, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241975, 32820, 0, 1, 1, 0, 0, 1939.86, 1574.08, 82.4603, 2.76817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241976, 32820, 0, 1, 1, 0, 0, 1909.7, 1514.67, 87.3891, 4.62487, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241977, 32820, 0, 1, 1, 0, 0, -6160, 325.568, 399.968, 1.928, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241978, 32820, 0, 1, 1, 0, 0, 1947.43, 1559.7, 87.6517, 5.05464, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241979, 32820, 0, 1, 1, 0, 0, 1871.81, 1511.04, 88.1731, 1.4094, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241980, 32820, 0, 1, 1, 0, 0, 1923.72, 1546.34, 87.5938, 5.72714, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241981, 32820, 0, 1, 1, 0, 0, 1951.47, 1608.03, 83.4339, 0.90738, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241982, 32820, 0, 1, 1, 0, 0, 1957.45, 1559.31, 86.7158, 3.11913, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241983, 32820, 0, 1, 1, 0, 0, 1964.36, 1596.41, 88.1966, 6.16458, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241984, 32820, 0, 1, 1, 0, 0, 1958.78, 1605.91, 88.1813, 3.39428, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241985, 32820, 0, 1, 1, 0, 0, 1969.51, 1611.49, 88.1993, 1.55372, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241986, 32820, 0, 1, 1, 0, 0, 1998.98, 1702.84, 79.2207, 4.83678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241987, 32820, 0, 1, 1, 0, 0, 1964.83, 1611.97, 88.1991, 5.10508, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241988, 32820, 0, 1, 1, 0, 0, 1965.75, 1611.9, 83.5143, 4.57629, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241989, 32820, 0, 1, 1, 0, 0, 1985.09, 1674.03, 77.8688, 2.46003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241990, 32820, 0, 1, 1, 0, 0, 1961.67, 1604, 83.4338, 1.92067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241991, 32820, 0, 1, 1, 0, 0, 1989.34, 1614.82, 82.0564, 3.55892, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241992, 32820, 0, 1, 1, 0, 0, 1744.62, 1564.06, 115.271, 4.91857, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241993, 32820, 0, 1, 1, 0, 0, 1992.71, 1626.04, 79.6506, 1.53227, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241994, 32820, 0, 1, 1, 0, 0, -5816, -3455, 311.46, 4.143, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241995, 32820, 0, 1, 1, 0, 0, -5793, -2582, 309.097, 4.926, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241996, 32820, 0, 1, 1, 0, 0, -5787, -3588, 335.657, 3.72, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241997, 32820, 0, 1, 1, 0, 0, -5726, -3310, 304.167, 1.49, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241998, 32820, 0, 1, 1, 0, 0, -5706, -3545, 305.103, 4.912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(241999, 32820, 0, 1, 1, 0, 0, -5687, -3183, 318.88, 0.687, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242000, 32820, 0, 1, 1, 0, 0, -5670, -528, 398.13, 2.381, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242001, 32820, 0, 1, 1, 0, 0, -5656, -3646, 315.12, 5.039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242002, 32820, 0, 1, 1, 0, 0, -5614, -3701, 315.196, 4.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242003, 32820, 0, 1, 1, 0, 0, -5559, -2779, 364.792, 0.143, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242004, 32820, 0, 1, 1, 0, 0, -5485, -3766, 317.351, 0.37, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242005, 32820, 0, 1, 1, 0, 0, -5454, -2859, 348.231, 3.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242006, 32820, 0, 1, 1, 0, 0, -5425, -2851, 345.649, 3.473, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242007, 32820, 0, 1, 1, 0, 0, -5352, -2892, 341.729, 1.654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242008, 32820, 0, 1, 1, 0, 0, -5325, -3759, 309.441, 0.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242009, 32820, 0, 1, 1, 0, 0, -5250, -2806, 345.624, 3.708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242010, 32820, 0, 1, 1, 0, 0, -5224, -3745, 313.321, 0.176, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242011, 32820, 0, 1, 1, 0, 0, -5212, -2780, 338.271, 1.048, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242012, 32820, 0, 1, 1, 0, 0, -5165, -876, 507.245, 0.929, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242013, 32820, 0, 1, 1, 0, 0, -5154, -2987, 331.929, 4.471, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242014, 32820, 0, 1, 1, 0, 0, -5135, -3739, 311.317, 0.08, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242015, 32820, 0, 1, 1, 0, 0, 1776.54, 1422.64, 94.6241, 1.23212, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242016, 32820, 0, 1, 1, 0, 0, -5085, -3052, 323.62, 6.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242017, 32820, 0, 1, 1, 0, 0, -5076, -2855, 323.234, 5.708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242018, 32820, 0, 1, 1, 0, 0, -5059, -3717, 313.61, 0.869, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242019, 32820, 0, 1, 1, 0, 0, -5049, -2745, 336.041, 2.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242020, 32820, 0, 1, 1, 0, 0, -4991, -2879, 338.593, 4.392, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242021, 32820, 0, 1, 1, 0, 0, -4977, -3080, 317.529, 3.301, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242022, 32820, 0, 1, 1, 0, 0, -4940, -2970, 321.597, 2.764, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242023, 32820, 0, 1, 1, 0, 0, -4905, -2783, 329.388, 3.044, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242024, 32820, 0, 1, 1, 0, 0, -4895, -2662, 331.436, 2.669, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242025, 32820, 0, 1, 1, 0, 0, -4816, -2960, 321.874, 0.081, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242026, 32820, 0, 1, 1, 0, 0, -4805, -2784, 325.017, 1.212, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242027, 32820, 0, 1, 1, 0, 0, -4782, -2972, 322.237, 1.247, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242028, 32820, 0, 1, 1, 0, 0, -4745, -2866, 328.156, 0.666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242029, 32820, 0, 1, 1, 0, 0, -4720, -2753, 325.374, 0.837, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242030, 32820, 0, 1, 1, 0, 0, -4700, -2790, 328.179, 0.831, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242031, 32820, 0, 1, 1, 0, 0, 1707.5, 1481.87, 146.438, 5.03859, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242032, 32820, 0, 1, 1, 0, 0, -3645, -720, 9.968, 4.426, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242033, 32820, 0, 1, 1, 0, 0, -3639, -715, 9.945, 4.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242034, 32820, 0, 1, 1, 0, 0, -3636, -716, 9.897, 4.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242035, 32820, 0, 1, 1, 0, 0, -3633, -718, 9.898, 4.041, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242036, 32820, 0, 1, 1, 0, 0, -3355, -845, 1.063, 1.734, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242037, 32820, 0, 1, 1, 0, 0, -3299, -2430, 18.597, 5.693, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242038, 32820, 0, 1, 1, 0, 0, -8836.48, -240.295, 82.7459, 5.43024, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242039, 32820, 0, 1, 1, 0, 0, -8962.26, -174.974, 79.7247, 2.9633, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242040, 32820, 0, 1, 1, 0, 0, -1468, -2625, 48.363, 4.617, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242041, 32820, 0, 1, 1, 0, 0, 1897.38, 1491.79, 93.9505, 3.99949, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242042, 32820, 0, 1, 1, 0, 0, 1903.73, 1497, 89.1851, 0.677535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242043, 32820, 0, 1, 1, 0, 0, -1322.33, -3190.17, 37.5942, 0.173087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242044, 32820, 0, 1, 1, 0, 0, -806, -638, 12.021, 5.902, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242045, 32820, 0, 1, 1, 0, 0, -789, 1241.1, 77.095, 3.885, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242046, 32820, 0, 1, 1, 0, 0, -786, -607, 15.235, 1.414, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242047, 32820, 0, 1, 1, 0, 0, -782, -612, 15.235, 1.892, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242048, 32820, 0, 1, 1, 0, 0, -779, -631, 14.728, 1.099, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242049, 32820, 0, 1, 1, 0, 0, -779, -610, 15.235, 2.179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242050, 32820, 0, 1, 1, 0, 0, -779, -601, 15.235, 3.222, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242051, 32820, 0, 1, 1, 0, 0, -777, -608, 15.235, 2.453, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242052, 32820, 0, 1, 1, 0, 0, -775, -606, 15.235, 2.706, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242053, 32820, 0, 1, 1, 0, 0, -750, -455, 25.201, 6.185, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242054, 32820, 0, 1, 1, 0, 0, -721, -592, 25.011, 3.121, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242055, 32820, 0, 1, 1, 0, 0, 2051.43, 1574.93, 74.2552, 2.10952, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242056, 32820, 0, 1, 1, 0, 0, -569, -112, 47.513, 1.302, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242057, 32820, 0, 1, 1, 0, 0, -566, -132, 51.169, 3.078, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242058, 32820, 0, 1, 1, 0, 0, -482, 917.984, 91.386, 5.378, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242059, 32820, 0, 1, 1, 0, 0, -456, -111, 54.729, 1.605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242060, 32820, 0, 1, 1, 0, 0, -408, -53, 54.454, 4.922, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242061, 32820, 0, 1, 1, 0, 0, -322, -3297, 131.5, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242062, 32820, 0, 1, 1, 0, 0, -314, 1135.16, 72.124, 5.49, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242063, 32820, 0, 1, 1, 0, 0, -313, 1340.57, 34.934, 4.864, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242064, 32820, 0, 1, 1, 0, 0, -287, -3255, 125.125, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242065, 32820, 0, 1, 1, 0, 0, -285, -4388, 108.627, 2.007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242066, 32820, 0, 1, 1, 0, 0, -258, -3199, 121.5, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242067, 32820, 0, 1, 1, 0, 0, -243, 1359.05, 37.73, 2.687, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242068, 32820, 0, 1, 1, 0, 0, -221, 1384.99, 33.943, 4.851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242069, 32820, 0, 1, 1, 0, 0, -210, 1297.49, 40.747, 1.959, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242070, 32820, 0, 1, 1, 0, 0, -204, 1427.15, 31.121, 0.767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242071, 32820, 0, 1, 1, 0, 0, -168.824, -3033.28, 120.93, 0.713902, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242072, 32820, 0, 1, 1, 0, 0, -164.849, -3120.23, 119.516, 1.97133, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242073, 32820, 0, 1, 1, 0, 0, -141, -2899, 124, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242074, 32820, 0, 1, 1, 0, 0, -95, 1120.03, 64.676, 2.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242075, 32820, 0, 1, 1, 0, 0, -93, 1136.79, 64.397, 0.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242076, 32820, 0, 1, 1, 0, 0, 1751.11, 1422.08, 113.726, 0.503288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242077, 32820, 0, 1, 1, 0, 0, -72, -3364, 123.75, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242078, 32820, 0, 1, 1, 0, 0, -55, 1256.13, 60.262, 5.175, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242079, 32820, 0, 1, 1, 0, 0, -52, -4357, 137, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242080, 32820, 0, 1, 1, 0, 0, -20, -996, 55.837, 1.499, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242081, 32820, 0, 1, 1, 0, 0, -8.41412, -3427.04, 118.346, 2.41664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242082, 32820, 0, 1, 1, 0, 0, 8.155, 1241.76, 62.017, 0.162, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242083, 32820, 0, 1, 1, 0, 0, 45.579, 1312.13, 63.793, 2.42, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242084, 32820, 0, 1, 1, 0, 0, 58, -4295, 123, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242085, 32820, 0, 1, 1, 0, 0, 71.864, 690.764, 63.165, 4.919, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242086, 32820, 0, 1, 1, 0, 0, 79.621, 1189.98, 63.799, 6.213, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242087, 32820, 0, 1, 1, 0, 0, 84.175, 1333.08, 67.441, 6.08, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242088, 32820, 0, 1, 1, 0, 0, 92.791, 1120.78, 68.67, 5.628, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242089, 32820, 0, 1, 1, 0, 0, 110.456, 1269.12, 67.596, 2.889, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242090, 32820, 0, 1, 1, 0, 0, 119.804, 1150.93, 70.085, 4.101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242091, 32820, 0, 1, 1, 0, 0, 148.276, 681.614, 52.887, 5.253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242092, 32820, 0, 1, 1, 0, 0, 164.149, 1489.78, 114.394, 4.949, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242093, 32820, 0, 1, 1, 0, 0, 176.92, 1211.73, 68.081, 5.471, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242094, 32820, 0, 1, 1, 0, 0, 197, -4201, 122.125, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242095, 32820, 0, 1, 1, 0, 0, 198.296, 1373.02, 98.163, 1.522, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242096, 32820, 0, 1, 1, 0, 0, 216, -2991, 117.25, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242097, 32820, 0, 1, 1, 0, 0, 219.332, 1128.08, 70.276, 5.282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242098, 32820, 0, 1, 1, 0, 0, 279.445, 1516.3, 139.208, 0.012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242099, 32820, 0, 1, 1, 0, 0, 282.42, -4022.96, 119.372, 4.14295, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242100, 32820, 0, 1, 1, 0, 0, 294.869, 691.752, 42.9, 0.711, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242101, 32820, 0, 1, 1, 0, 0, 304.059, -3981.02, 124.132, 4.53172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242102, 32820, 0, 1, 1, 0, 0, 306, -4176, 123.125, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242103, 32820, 0, 1, 1, 0, 0, 313.482, -1524, 58.629, 5.506, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242104, 32820, 0, 1, 1, 0, 0, 314.622, -1487, 43.999, 2.356, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242105, 32820, 0, 1, 1, 0, 0, 324.261, -2227, 137.775, 3.107, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242106, 32820, 0, 1, 1, 0, 0, 328.469, 1291.78, 77.505, 2.143, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242107, 32820, 0, 1, 1, 0, 0, 336.852, 1435.4, 125.617, 0.703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242108, 32820, 0, 1, 1, 0, 0, 336.92, 1276.86, 78.202, 4.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242109, 32820, 0, 1, 1, 0, 0, 340.961, 1179.32, 81.573, 0.755, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242110, 32820, 0, 1, 1, 0, 0, 341.178, 1449.96, 126.285, 5.911, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242111, 32820, 0, 1, 1, 0, 0, 350.82, 1602.25, 128.812, 5.964, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242112, 32820, 0, 1, 1, 0, 0, 354.014, 1600.3, 128.227, 1.082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242113, 32820, 0, 1, 1, 0, 0, 367.389, 1587.62, 128.909, 6.258, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242114, 32820, 0, 1, 1, 0, 0, 372, -4205, 118.375, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242115, 32820, 0, 1, 1, 0, 0, 381, -3528, 122, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242116, 32820, 0, 1, 1, 0, 0, 397.303, -865, 124.349, 4.744, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242117, 32820, 0, 1, 1, 0, 0, 399.17, -845, 126.687, 0.343, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242118, 32820, 0, 1, 1, 0, 0, 428.552, 1181.1, 87.954, 4.704, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242119, 32820, 0, 1, 1, 0, 0, 428.681, 1196.46, 84.859, 0.324, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242120, 32820, 0, 1, 1, 0, 0, 458.206, 1315.96, 81.804, 4.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242121, 32820, 0, 1, 1, 0, 0, 476.229, 1595.9, 126.662, 5.942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242122, 32820, 0, 1, 1, 0, 0, 479.811, 1267.26, 82.98, 5.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242123, 32820, 0, 1, 1, 0, 0, 492.422, -772, 147.39, 0.249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242124, 32820, 0, 1, 1, 0, 0, 493.482, -1455, 48.912, 1.236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242125, 32820, 0, 1, 1, 0, 0, 508.227, 1326.29, 85.711, 1.012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242126, 32820, 0, 1, 1, 0, 0, 516.715, 1410.04, 99.79, 3.753, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242127, 32820, 0, 1, 1, 0, 0, 521.218, -1447, 50.313, 0.002, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242128, 32820, 0, 1, 1, 0, 0, 522.159, -764, 157.889, 0.261, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242129, 32820, 0, 1, 1, 0, 0, 529.541, 1160.25, 93.347, 6.039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242130, 32820, 0, 1, 1, 0, 0, 542.417, -1074, 143.417, 4.494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242131, 32820, 0, 1, 1, 0, 0, 547.18, 1194.25, 86.435, 1.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242132, 32820, 0, 1, 1, 0, 0, 635.297, -1337, 102.984, 1.89, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242133, 32820, 0, 1, 1, 0, 0, 651.539, 1308.37, 84.0927, 4.64149, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242134, 32820, 0, 1, 1, 0, 0, 660.913, 1367.78, 79.66, 1.29, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242135, 32820, 0, 1, 1, 0, 0, 674.073, -1453, 81.108, 1.849, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242136, 32820, 0, 1, 1, 0, 0, 691.448, 1073.78, 50.784, 3.328, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242137, 32820, 0, 1, 1, 0, 0, 698.865, 1238.2, 67.384, 5.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242138, 32820, 0, 1, 1, 0, 0, 702.753, 1365.46, 73.569, 3.576, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242139, 32820, 0, 1, 1, 0, 0, 715.927, 1462.33, 61.307, 1.025, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242140, 32820, 0, 1, 1, 0, 0, 718.784, 527.067, 36.267, 3.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242141, 32820, 0, 1, 1, 0, 0, 749.011, 1645.38, 38.022, 0.664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242142, 32820, 0, 1, 1, 0, 0, 767.278, -1467, 77.457, 0.903, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242143, 32820, 0, 1, 1, 0, 0, 783.957, 1403.71, 59.312, 2.411, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242144, 32820, 0, 1, 1, 0, 0, 790.984, -1462, 75.27, 5.116, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242145, 32820, 0, 1, 1, 0, 0, 803.386, 1224.31, 54.166, 5.726, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242146, 32820, 0, 1, 1, 0, 0, 834.511, 1501.72, 42.526, 2.397, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242147, 32820, 0, 1, 1, 0, 0, 837.677, 1657.8, 24.021, 4.907, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242148, 32820, 0, 1, 1, 0, 0, 842.183, 1713.32, 18.871, 1.618, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242149, 32820, 0, 1, 1, 0, 0, 872.046, -1497, 64.076, 5.529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242150, 32820, 0, 1, 1, 0, 0, 879.713, 1560.15, 28.648, 4.103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242151, 32820, 0, 1, 1, 0, 0, 902.236, -1517, 55.037, 4.744, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242152, 32820, 0, 1, 1, 0, 0, 902.684, 1150.51, 49.979, 4.75, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242153, 32820, 0, 1, 1, 0, 0, 921.494, -1460, 64.486, 4.481, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242154, 32820, 0, 1, 1, 0, 0, 932.54, 1367.52, 39.984, 3.724, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242155, 32820, 0, 1, 1, 0, 0, 934.564, 1298.45, 41.96, 4.17, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242156, 32820, 0, 1, 1, 0, 0, 939.838, -1489, 64.446, 1.179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242157, 32820, 0, 1, 1, 0, 0, 940.014, 1370.98, 40.845, 2.561, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242158, 32820, 0, 1, 1, 0, 0, 940.727, -1420, 66.623, 4.131, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242159, 32820, 0, 1, 1, 0, 0, 941.62, 1527.42, 37.729, 4.598, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242160, 32820, 0, 1, 1, 0, 0, 961.048, 1490.55, 39.627, 1.623, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242161, 32820, 0, 1, 1, 0, 0, 961.14, 1588.06, 31.173, 5.24, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242162, 32820, 0, 1, 1, 0, 0, 961.831, 1125.4, 46.842, 4.461, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242163, 32820, 0, 1, 1, 0, 0, 964.77, -1479, 62.365, 2.321, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242164, 32820, 0, 1, 1, 0, 0, 971.502, -1428, 65.169, 3.7, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242165, 32820, 0, 1, 1, 0, 0, 972.236, 1711.85, 14.58, 0.027, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242166, 32820, 0, 1, 1, 0, 0, 975.02, 1706.71, 15.328, 2.404, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242167, 32820, 0, 1, 1, 0, 0, 976.797, -1484, 65.31, 4.421, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242168, 32820, 0, 1, 1, 0, 0, 982.935, -1445, 64.272, 5.572, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242169, 32820, 0, 1, 1, 0, 0, 989.992, 1135.55, 47.204, 0.83, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242170, 32820, 0, 1, 1, 0, 0, 992.585, -1428, 66.198, 5.702, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242171, 32820, 0, 1, 1, 0, 0, 999.113, -1217, 63.045, 5.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242172, 32820, 0, 1, 1, 0, 0, 1011.79, 1898.79, 6.703, 2.323, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242173, 32820, 0, 1, 1, 0, 0, 1014.25, 1690.75, 19.267, 5.831, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242174, 32820, 0, 1, 1, 0, 0, 1024.46, 1607.47, 23.935, 1.58, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242175, 32820, 0, 1, 1, 0, 0, 1026.51, 1408.18, 41.933, 6.077, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242176, 32820, 0, 1, 1, 0, 0, 1027.28, -1380, 70.556, 1.592, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242177, 32820, 0, 1, 1, 0, 0, 1028.52, -1308, 66.208, 5.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242178, 32820, 0, 1, 1, 0, 0, 1032.82, -1473, 63.758, 2.425, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242179, 32820, 0, 1, 1, 0, 0, 1036.64, -1410, 67.689, 3.6, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242180, 32820, 0, 1, 1, 0, 0, 1044.71, 1442.55, 45.77, 0.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242181, 32820, 0, 1, 1, 0, 0, 1047.85, 1457, 43.695, 4.987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242182, 32820, 0, 1, 1, 0, 0, 1057.5, 1450.18, 44.245, 3.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242183, 32820, 0, 1, 1, 0, 0, 1065.34, 1115.21, 40.001, 5.21, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242184, 32820, 0, 1, 1, 0, 0, 1072.76, 1186.9, 45.242, 3.648, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242185, 32820, 0, 1, 1, 0, 0, 1085.11, 1831.97, 17, 0.039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242186, 32820, 0, 1, 1, 0, 0, 1096.79, 1316.54, 38.34, 0.349, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242187, 32820, 0, 1, 1, 0, 0, 1097.12, -1344, 66.021, 4.819, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242188, 32820, 0, 1, 1, 0, 0, 1105.8, 1352.05, 38.387, 0.359, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242189, 32820, 0, 1, 1, 0, 0, 1110.63, 1650.16, 31.133, 6.068, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242190, 32820, 0, 1, 1, 0, 0, 1111.45, 1274.43, 40.292, 4.603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242191, 32820, 0, 1, 1, 0, 0, 1117.94, 1703.66, 28.618, 0.473, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242192, 32820, 0, 1, 1, 0, 0, 1124.87, 1935.88, 10.525, 3.143, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242193, 32820, 0, 1, 1, 0, 0, 1139.53, 1429.37, 36.176, 4.869, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242194, 32820, 0, 1, 1, 0, 0, 1155.84, 1635.29, 26.623, 5.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242195, 32820, 0, 1, 1, 0, 0, 1165.2, 1251.65, 48.534, 1.301, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242196, 32820, 0, 1, 1, 0, 0, 1177.1, 1398.64, 35.231, 3.281, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242197, 32820, 0, 1, 1, 0, 0, 1200.58, 1017.83, 36.449, 2.116, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242198, 32820, 0, 1, 1, 0, 0, 1207, 1087.9, 38.04, 3.912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242199, 32820, 0, 1, 1, 0, 0, 1210.67, 902.129, 33.872, 4.266, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242200, 32820, 0, 1, 1, 0, 0, 1220.44, 1100.96, 42.555, 0.811, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242201, 32820, 0, 1, 1, 0, 0, 1226.66, 1831.86, 10.109, 4.419, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242202, 32820, 0, 1, 1, 0, 0, 1227.34, 1350.73, 37.992, 1.734, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242203, 32820, 0, 1, 1, 0, 0, 1238.37, -2414, 60.739, 2.359, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242204, 32820, 0, 1, 1, 0, 0, 1243.33, 1218.2, 52.665, 3.723, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242205, 32820, 0, 1, 1, 0, 0, 1244.41, 1916.89, 12.889, 5.072, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242206, 32820, 0, 1, 1, 0, 0, 1253.23, 1889.74, 13.083, 6.259, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242207, 32820, 0, 1, 1, 0, 0, 1260.69, 1030.85, 43.393, 3.04, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242208, 32820, 0, 1, 1, 0, 0, 1270.04, 982.334, 44.642, 4.756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242209, 32820, 0, 1, 1, 0, 0, 1274.15, 1028.39, 44.708, 4.273, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242210, 32820, 0, 1, 1, 0, 0, 1284.15, 1123.82, 49.611, 2.928, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242211, 32820, 0, 1, 1, 0, 0, 1313.34, 834.769, 34.935, 4.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242212, 32820, 0, 1, 1, 0, 0, 1321.23, 884.217, 46.26, 1.124, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242213, 32820, 0, 1, 1, 0, 0, 1365.56, 805.331, 49.44, 0.836, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242214, 32820, 0, 1, 1, 0, 0, 1374.01, 735.929, 46.282, 3.878, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242215, 32820, 0, 1, 1, 0, 0, 1380.44, -3701, 77.017, 6.271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242216, 32820, 0, 1, 1, 0, 0, 1396.86, 989.125, 52.179, 2.145, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242217, 32820, 0, 1, 1, 0, 0, 1402.22, 1034.58, 52.993, 2.04, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242218, 32820, 0, 1, 1, 0, 0, 1406.98, 821.089, 47.211, 2.337, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242219, 32820, 0, 1, 1, 0, 0, 1412.15, 655.785, 48.723, 5.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242220, 32820, 0, 1, 1, 0, 0, 1887.06, 1454.94, 78.2062, 1.73572, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242221, 32820, 0, 1, 1, 0, 0, 1429.86, 679.498, 48.31, 6.226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242222, 32820, 0, 1, 1, 0, 0, 1438.34, 612.295, 46.114, 3.06, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242223, 32820, 0, 1, 1, 0, 0, 1442.72, 569.365, 48.616, 2.83, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242224, 32820, 0, 1, 1, 0, 0, 1448.06, 724.958, 44.822, 0.521, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242225, 32820, 0, 1, 1, 0, 0, 1448.35, 551.224, 51.476, 5.49, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242226, 32820, 0, 1, 1, 0, 0, 1450.61, 1113.83, 60.735, 1.44, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242227, 32820, 0, 1, 1, 0, 0, 1453.31, 917.864, 57.259, 3.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242228, 32820, 0, 1, 1, 0, 0, 1461.07, 768.615, 50.337, 0.188, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242229, 32820, 0, 1, 1, 0, 0, 1464.24, 728.697, 45.235, 0.544, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242230, 32820, 0, 1, 1, 0, 0, 1464.99, 789.986, 54.668, 5.75, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242231, 32820, 0, 1, 1, 0, 0, 1465.57, 567.219, 53.163, 5.131, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242232, 32820, 0, 1, 1, 0, 0, 1471.52, 859.503, 72.349, 6.161, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242233, 32820, 0, 1, 1, 0, 0, 1474.97, 499.644, 39.622, 3.757, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242234, 32820, 0, 1, 1, 0, 0, 1475.14, 576.905, 53.428, 1.352, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242235, 32820, 0, 1, 1, 0, 0, 1491.46, 661.033, 44.706, 6.228, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242236, 32820, 0, 1, 1, 0, 0, 1512.77, 659.536, 43.255, 0.676, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242237, 32820, 0, 1, 1, 0, 0, 1513.26, 720.752, 50.903, 4.559, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242238, 32820, 0, 1, 1, 0, 0, 1519.5, 644.208, 43.157, 3.962, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242239, 32820, 0, 1, 1, 0, 0, 1520.7, 586.997, 47.605, 0.88, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242240, 32820, 0, 1, 1, 0, 0, 1528.25, 548.5, 52.608, 4.647, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242241, 32820, 0, 1, 1, 0, 0, 1541.52, 603.2, 45.237, 0.105, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242242, 32820, 0, 1, 1, 0, 0, 1543.7, 505.559, 45.386, 3.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242243, 32820, 0, 1, 1, 0, 0, 1579.24, 508.478, 43.526, 5.306, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242244, 32820, 0, 1, 1, 0, 0, 1583.18, 612.709, 51.515, 0.361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242245, 32820, 0, 1, 1, 0, 0, 1599.26, 631.194, 65.446, 3.249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242246, 32820, 0, 1, 1, 0, 0, 1602.33, 665.019, 84.633, 0.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242247, 32820, 0, 1, 1, 0, 0, 1602.58, 535.46, 38.724, 4.262, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242248, 32820, 0, 1, 1, 0, 0, 1603.01, 586.253, 37.579, 4.245, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242249, 32820, 0, 1, 1, 0, 0, 1611.48, 600.123, 44.223, 1.541, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242250, 32820, 0, 1, 1, 0, 0, 1615.33, 517.125, 39.614, 2.911, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242251, 32820, 0, 1, 1, 0, 0, 1625.79, 535.696, 35.541, 4.307, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242252, 32820, 0, 1, 1, 0, 0, 1633.98, 510.343, 41.396, 0.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242253, 32820, 0, 1, 1, 0, 0, 1638.49, -373, 45.013, 0.679, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242254, 32820, 0, 1, 1, 0, 0, 1638.76, -463, 45.635, 1.425, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242255, 32820, 0, 1, 1, 0, 0, 1640.62, -588, 44.993, 1.372, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242256, 32820, 0, 1, 1, 0, 0, 1651.88, 684.505, 77.946, 1.918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242257, 32820, 0, 1, 1, 0, 0, 1651.93, -611, 47.782, 1.726, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242258, 32820, 0, 1, 1, 0, 0, 1652.61, -478, 45.697, 3.065, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242259, 32820, 0, 1, 1, 0, 0, 1655.15, -354, 44.998, 1.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242260, 32820, 0, 1, 1, 0, 0, 1655.88, -728, 58.925, 1.355, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242261, 32820, 0, 1, 1, 0, 0, 1660.99, 623.452, 51.54, 5.326, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242262, 32820, 0, 1, 1, 0, 0, 1669.65, -719, 58.302, 0.806, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242263, 32820, 0, 1, 1, 0, 0, 2113.83, 1512.22, 68.1744, 3.83896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242264, 32820, 0, 1, 1, 0, 0, 1673.15, -733, 59.067, 1.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242265, 32820, 0, 1, 1, 0, 0, -8869.22, -163.237, 80.9719, 0.959931, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242266, 32820, 0, 1, 1, 0, 0, 1676.1, 583.93, 35.881, 5.875, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242267, 32820, 0, 1, 1, 0, 0, 1676.29, -514, 44.081, 0.221, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242268, 32820, 0, 1, 1, 0, 0, 1684.25, -722, 57.97, 0.646, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242269, 32820, 0, 1, 1, 0, 0, 1684.41, -479, 43.864, 1.012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242270, 32820, 0, 1, 1, 0, 0, 1678.99, 1667.86, 135.855, 3.76991, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242271, 32820, 0, 1, 1, 0, 0, 1685.87, 746.877, 46.417, 0.75, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242272, 32820, 0, 1, 1, 0, 0, 1691.92, -274, 45.27, 2.423, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242273, 32820, 0, 1, 1, 0, 0, 1695.67, 520.835, 36.226, 4.154, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242274, 32820, 0, 1, 1, 0, 0, 1696.57, 1555.23, 123.589, 1.832, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242275, 32820, 0, 1, 1, 0, 0, 1698.1, -451, 42.402, 4.957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242276, 32820, 0, 1, 1, 0, 0, 2124.29, 1441.22, 65.7511, 3.60963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242277, 32820, 0, 1, 1, 0, 0, 1701.33, 1360.07, 118.736, 5.297, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242278, 32820, 0, 1, 1, 0, 0, 1708.89, 660.346, 46.65, 1.728, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242279, 32820, 0, 1, 1, 0, 0, 1712.34, -799, 57.709, 5.224, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242280, 32820, 0, 1, 1, 0, 0, 1875, 1295.83, 94.1748, 3.14138, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242281, 32820, 0, 1, 1, 0, 0, 2087.13, 1555.71, 73.1964, 2.58382, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242282, 32820, 0, 1, 1, 0, 0, 1715.04, -744, 55.649, 4.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242283, 32820, 0, 1, 1, 0, 0, 1715.86, -503, 37.7, 5.188, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242284, 32820, 0, 1, 1, 0, 0, 1716.27, 895.978, 59.525, 1.7, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242285, 32820, 0, 1, 1, 0, 0, 1722.14, 720.163, 48.042, 4.625, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242286, 32820, 0, 1, 1, 0, 0, 1722.58, -411, 38.156, 2.721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242287, 32820, 0, 1, 1, 0, 0, 1725.59, -797, 57.811, 4.292, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242288, 32820, 0, 1, 1, 0, 0, 1727.82, -431, 33.846, 0.401, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242289, 32820, 0, 1, 1, 0, 0, 1843.58, 1289.87, 102.559, 2.53327, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242290, 32820, 0, 1, 1, 0, 0, 2117.84, 1501.78, 70.6263, 3.58777, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242291, 32820, 0, 1, 1, 0, 0, 1860.73, 1327, 76.9402, 0.14983, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242292, 32820, 0, 1, 1, 0, 0, 2043.76, 1481.58, 68.4653, 1.36325, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242293, 32820, 0, 1, 1, 0, 0, 1735.87, 507.163, 41.611, 4.232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242294, 32820, 0, 1, 1, 0, 0, 1736.9, -743, 59.443, 2.177, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242295, 32820, 0, 1, 1, 0, 0, 1739.56, -672, 45.062, 6.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242296, 32820, 0, 1, 1, 0, 0, 1740.46, -726, 59.947, 2.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242297, 32820, 0, 1, 1, 0, 0, 1740.5, 718.644, 48.531, 4.257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242298, 32820, 0, 1, 1, 0, 0, 1875.24, 1284.18, 98.7998, 3.50248, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242299, 32820, 0, 1, 1, 0, 0, 2113.07, 1459.33, 64.3409, 5.2157, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242300, 32820, 0, 1, 1, 0, 0, 1747.26, 996.788, 51.869, 5.302, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242301, 32820, 0, 1, 1, 0, 0, 1747.84, -334, 33.709, 6.276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242302, 32820, 0, 1, 1, 0, 0, 1748.48, 723.007, 47.149, 2.937, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242303, 32820, 0, 1, 1, 0, 0, 1859.39, 1358.49, 71.724, 3.31082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242304, 32820, 0, 1, 1, 0, 0, 1749.61, 1143.83, 65.782, 4.822, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242305, 32820, 0, 1, 1, 0, 0, 1749.83, -489, 41.373, 2.124, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242306, 32820, 0, 1, 1, 0, 0, 1750.92, 575.75, 34.078, 1.936, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242307, 32820, 0, 1, 1, 0, 0, 2079.73, 1495.97, 65.6415, 4.19379, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242308, 32820, 0, 1, 1, 0, 0, 1752.85, 805.094, 55.123, 2.523, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242309, 32820, 0, 1, 1, 0, 0, 1962.59, 1426.8, 65.9927, 1.73293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242310, 32820, 0, 1, 1, 0, 0, 1755.4, 583.822, 34.658, 3.593, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242311, 32820, 0, 1, 1, 0, 0, 1756.59, 647.783, 40.193, 3.165, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242312, 32820, 0, 1, 1, 0, 0, 1756.84, 725.38, 46.759, 6.033, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242313, 32820, 0, 1, 1, 0, 0, 1758.66, -723, 60.08, 1.556, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242314, 32820, 0, 1, 1, 0, 0, 1760.69, 510.543, 35.915, 6.259, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242315, 32820, 0, 1, 1, 0, 0, 1764.56, -343, 34.68, 5.949, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242316, 32820, 0, 1, 1, 0, 0, 1765.15, 1382.99, 92.056, 5.248, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242317, 32820, 0, 1, 1, 0, 0, 1766.44, 1324.48, 93.714, 4.221, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242318, 32820, 0, 1, 1, 0, 0, 1767.02, -725, 59.559, 1.387, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242319, 32820, 0, 1, 1, 0, 0, 1769.21, 1080.19, 50.29, 0.406, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242320, 32820, 0, 1, 1, 0, 0, 1769.49, 1406.18, 95.175, 3.895, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242321, 32820, 0, 1, 1, 0, 0, 1771.38, 675.97, 44.102, 6.258, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242322, 32820, 0, 1, 1, 0, 0, 1829.34, 1327.7, 86.4345, 3.61845, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242323, 32820, 0, 1, 1, 0, 0, 1774.55, 941.946, 51.615, 1.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242324, 32820, 0, 1, 1, 0, 0, 1776.04, -726, 59.321, 1.587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242325, 32820, 0, 1, 1, 0, 0, 1776.3, -558, 41.212, 1.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242326, 32820, 0, 1, 1, 0, 0, 1776.79, 809.271, 45.337, 2.398, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242327, 32820, 0, 1, 1, 0, 0, 1777.3, 1381.93, 90.909, 2.169, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242328, 32820, 0, 1, 1, 0, 0, 1778.47, 618.782, 41.311, 2.436, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242329, 32820, 0, 1, 1, 0, 0, 1779.04, -713, 58.765, 1.819, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242330, 32820, 0, 1, 1, 0, 0, 1779.22, 1015.1, 45.195, 3.458, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242331, 32820, 0, 1, 1, 0, 0, 1782.03, -588, 39.544, 1.547, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242332, 32820, 0, 1, 1, 0, 0, 2096.18, 1458.27, 62.7233, 1.46592, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242333, 32820, 0, 1, 1, 0, 0, 1783.4, -726, 59.358, 2.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242334, 32820, 0, 1, 1, 0, 0, 1785.68, 1126.35, 51.003, 2.578, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242335, 32820, 0, 1, 1, 0, 0, 1786.31, 948.231, 45.374, 0.271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242336, 32820, 0, 1, 1, 0, 0, 1787.57, 1342.62, 89.397, 5.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242337, 32820, 0, 1, 1, 0, 0, 1789.58, 1335.53, 89.614, 1.3, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242338, 32820, 0, 1, 1, 0, 0, 1789.88, -729, 59.365, 2.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242339, 32820, 0, 1, 1, 0, 0, 1790.21, 746.825, 49.162, 1.082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242340, 32820, 0, 1, 1, 0, 0, 1793.44, -585, 39.674, 6.122, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242341, 32820, 0, 1, 1, 0, 0, 1793.69, 1092.51, 45.104, 4.596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242342, 32820, 0, 1, 1, 0, 0, 1794.38, 1420.41, 87.027, 3.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242343, 32820, 0, 1, 1, 0, 0, 1795.21, 653.885, 40.579, 0.341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242344, 32820, 0, 1, 1, 0, 0, 1795.23, 611.12, 39.596, 6.249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242345, 32820, 0, 1, 1, 0, 0, 1796.6, 744.136, 48.883, 3.167, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242346, 32820, 0, 1, 1, 0, 0, 1798.77, 722.748, 48.9869, 4.68094, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242347, 32820, 0, 1, 1, 0, 0, 1796.91, 700.662, 47.661, 1.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242348, 32820, 0, 1, 1, 0, 0, 1799.02, 587.317, 45.299, 3.106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242349, 32820, 0, 1, 1, 0, 0, 1804.06, 945.904, 41.354, 0.456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242350, 32820, 0, 1, 1, 0, 0, 2130.92, 1470.55, 67.8589, 5.86654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242351, 32820, 0, 1, 1, 0, 0, 1808.03, 550.08, 34.296, 2.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242352, 32820, 0, 1, 1, 0, 0, 1809.63, 764.674, 43.892, 4.413, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242353, 32820, 0, 1, 1, 0, 0, 1810.09, 1388.97, 78.849, 4.225, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242354, 32820, 0, 1, 1, 0, 0, 2094.89, 1590.31, 75.1982, 2.80818, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242355, 32820, 0, 1, 1, 0, 0, 1811.25, 958.817, 37.394, 3.106, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242356, 32820, 0, 1, 1, 0, 0, 1812.66, 1328.37, 88.503, 5.502, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242357, 32820, 0, 1, 1, 0, 0, 1813.97, 1086.19, 40.126, 2.411, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242358, 32820, 0, 1, 1, 0, 0, 1814.69, 646.793, 38.318, 3.872, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242359, 32820, 0, 1, 1, 0, 0, 2046.56, 1454.31, 66.9644, 5.65726, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242360, 32820, 0, 1, 1, 0, 0, 1816.61, -412, 34.494, 3.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242361, 32820, 0, 1, 1, 0, 0, 1816.62, 1171.46, 52.676, 2.391, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242362, 32820, 0, 1, 1, 0, 0, 1813.74, 1285.59, 97.9754, 2.39028, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242363, 32820, 0, 1, 1, 0, 0, 1836.88, 1362.87, 74.5884, 5.03491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242364, 32820, 0, 1, 1, 0, 0, 1819.85, 1372.79, 77.398, 1.299, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242365, 32820, 0, 1, 1, 0, 0, 2147.9, 1561.27, 79.8816, 5.77033, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242366, 32820, 0, 1, 1, 0, 0, 1822.34, 1039.74, 36.694, 1.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242367, 32820, 0, 1, 1, 0, 0, 1822.95, 1581.81, 95.519, 1.553, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(242368, 32820, 0, 1, 1, 0, 0, 1997.29, 1530.76, 77.0698, 0.676724, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242369, 32820, 0, 1, 1, 0, 0, 1824.26, 1637.18, 95.64, 4.757, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(242370, 32820, 0, 1, 1, 0, 0, 1824.89, -26, 40.307, 0.136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242371, 32820, 0, 1, 1, 0, 0, 1825.6, -457, 34.707, 5.735, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242372, 32820, 0, 1, 1, 0, 0, 1826.04, 825.973, 26.091, 1.117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242373, 32820, 0, 1, 1, 0, 0, 2141.36, 1604.68, 78.3542, 5.06096, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242374, 32820, 0, 1, 1, 0, 0, 1681.86, 1582.67, 127.197, 5.19291, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242375, 32820, 0, 1, 1, 0, 0, 1830.23, 1089.14, 36.664, 1.256, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242376, 32820, 0, 1, 1, 0, 0, 1831.57, 1581.19, 95.196, 1.688, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242377, 32820, 0, 1, 1, 0, 0, 1834.6, 855.579, 25.122, 3.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242378, 32820, 0, 1, 1, 0, 0, 1835.48, 1567.26, 96.581, 1.149, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242379, 32820, 0, 1, 1, 0, 0, 1836.2, 1641.24, 97.628, 5.411, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242380, 32820, 0, 1, 1, 0, 0, 1912.12, 1645.39, 88.5127, 1.663, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242381, 32820, 0, 1, 1, 0, 0, 1835.42, 1340.63, 81.0884, 2.26482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242382, 32820, 0, 1, 1, 0, 0, 1837.5, 604.166, 45.402, 1.575, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242383, 32820, 0, 1, 1, 0, 0, 1837.51, 1630.92, 96.933, 5.732, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242384, 32820, 0, 1, 1, 0, 0, 1837.56, -151, 42.103, 3.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242385, 32820, 0, 1, 1, 0, 0, 1657.81, 1712.5, 147.393, 6.28308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242386, 32820, 0, 1, 1, 0, 0, 1838.74, 1636.12, 96.933, 5.478, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242387, 32820, 0, 1, 1, 0, 0, 1840.57, 1567.1, 96.579, 1.738, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242388, 32820, 0, 1, 1, 0, 0, 1840.67, 828.307, 25.675, 5.783, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242389, 32820, 0, 1, 1, 0, 0, 1842.69, 857.234, 25.365, 0.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242390, 32820, 0, 1, 1, 0, 0, 1843.18, 965.094, 32.259, 0.896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242391, 32820, 0, 1, 1, 0, 0, 1843.24, 1640.52, 97.628, 4.659, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242392, 32820, 0, 1, 1, 0, 0, 2009.14, 1567.49, 79.1212, 5.19624, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242393, 32820, 0, 1, 1, 0, 0, 1845.17, 983.134, 30.429, 2.39, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242394, 32820, 0, 1, 1, 0, 0, 1846.35, 607.813, 47.902, 4.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242395, 32820, 0, 1, 1, 0, 0, 1846.81, 1580.69, 94.733, 1.544, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242396, 32820, 0, 1, 1, 0, 0, 1847.24, 1635.95, 96.933, 3.801, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242397, 32820, 0, 1, 1, 0, 0, 1847.38, -479, 37.062, 0.526, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242398, 32820, 0, 1, 1, 0, 0, 1848.14, 1638.79, 96.933, 4.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242399, 32820, 0, 1, 1, 0, 0, 1848.14, -280, 39.265, 1.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242400, 32820, 0, 1, 1, 0, 0, 1849.35, 1625.72, 96.933, 2.619, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242401, 32820, 0, 1, 1, 0, 0, 1850.01, 801.833, 25.284, 1.716, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242402, 32820, 0, 1, 1, 0, 0, 1850.51, -355, 38.283, 3.005, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242403, 32820, 0, 1, 1, 0, 0, 1860.96, 1378.44, 75.3596, 2.25591, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242404, 32820, 0, 1, 1, 0, 0, 2127, 1488.45, 69.0985, 2.74564, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242405, 32820, 0, 1, 1, 0, 0, 1854.36, 592.129, 46.343, 1.284, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242406, 32820, 0, 1, 1, 0, 0, 1854.56, 729.64, 35.772, 1.513, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242407, 32820, 0, 1, 1, 0, 0, 2044.37, 1593.64, 70.4317, 5.45417, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242408, 32820, 0, 1, 1, 0, 0, 1922.86, 1625.93, 83.5842, 5.30097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242409, 32820, 0, 1, 1, 0, 0, 1856.9, -731, 63.023, 5.278, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242410, 32820, 0, 1, 1, 0, 0, 2072.53, 1612.54, 70.259, 5.6282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242411, 32820, 0, 1, 1, 0, 0, 1859.98, -506, 42.399, 5.783, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242412, 32820, 0, 1, 1, 0, 0, 1797.46, 1301.62, 102.951, 1.10146, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242413, 32820, 0, 1, 1, 0, 0, 1860.1, 1568.58, 94.312, 1.348, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242414, 32820, 0, 1, 1, 0, 0, 1860.12, 1563.55, 94.307, 6.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242415, 32820, 0, 1, 1, 0, 0, 1860.66, 879.395, 25.829, 5.836, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242416, 32820, 0, 1, 1, 0, 0, 1861.01, 1586.07, 92.45, 1.604, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(242417, 32820, 0, 1, 1, 0, 0, 1862.08, 982.911, 30.425, 0.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242418, 32820, 0, 1, 1, 0, 0, 1782.46, 1719.94, 118.715, 3.53443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242419, 32820, 0, 1, 1, 0, 0, 1862.71, 515.728, 36.189, 4.633, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242420, 32820, 0, 1, 1, 0, 0, 1862.88, 1556.41, 94.783, 2.292, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242421, 32820, 0, 1, 1, 0, 0, 1864.19, -652, 45.329, 1.955, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242422, 32820, 0, 1, 1, 0, 0, 1865.48, 1574.8, 94.313, 3.388, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242423, 32820, 0, 1, 1, 0, 0, 1872.23, -242, 35.433, 0.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242424, 32820, 0, 1, 1, 0, 0, 1936.33, 1635.19, 80.3736, 5.76424, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242425, 32820, 0, 1, 1, 0, 0, 1965.95, 1639.71, 77.8335, 1.1349, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242426, 32820, 0, 1, 1, 0, 0, 1804.12, 1333.83, 88.1972, 4.64479, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242427, 32820, 0, 1, 1, 0, 0, 1876.44, 871.104, 28.305, 3.552, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242428, 32820, 0, 1, 1, 0, 0, 1876.45, 555.231, 40.008, 5.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242429, 32820, 0, 1, 1, 0, 0, 1877.21, 1596.18, 91.709, 4.337, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242430, 32820, 0, 1, 1, 0, 0, 1978.28, 1483.97, 84.012, 1.10496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242431, 32820, 0, 1, 1, 0, 0, 1878.76, 1082.84, 25.703, 1.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242432, 32820, 0, 1, 1, 0, 0, 1878.78, 1166.95, 48.971, 2.537, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242433, 32820, 0, 1, 1, 0, 0, 1880.06, -625, 45.501, 0.117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242434, 32820, 0, 1, 1, 0, 0, 1881.26, 1018.92, 28.588, 5.649, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242435, 32820, 0, 1, 1, 0, 0, 1881.53, -453, 39.486, 2.446, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242436, 32820, 0, 1, 1, 0, 0, 1882.3, 1641.52, 93.646, 4.491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242437, 32820, 0, 1, 1, 0, 0, 2023.47, 1543.74, 79.1664, 5.45035, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242438, 32820, 0, 1, 1, 0, 0, 1886.01, -437, 38.723, 1.311, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242439, 32820, 0, 1, 1, 0, 0, 1886.1, 484.668, 36.103, 1.891, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242440, 32820, 0, 1, 1, 0, 0, 1886.81, 949.465, 26.261, 1.724, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242441, 32820, 0, 1, 1, 0, 0, 2080.8, 1426.5, 61.9559, 2.22875, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242442, 32820, 0, 1, 1, 0, 0, 1886.94, 1610.79, 92.62, 4.476, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242443, 32820, 0, 1, 1, 0, 0, 1887.42, -92, 32.805, 1.572, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242444, 32820, 0, 1, 1, 0, 0, 1985.82, 1637.55, 77.274, 4.34587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242445, 32820, 0, 1, 1, 0, 0, 2004.96, 1536.57, 76.9095, 5.17953, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242446, 32820, 0, 1, 1, 0, 0, 1890.28, 1054.18, 32.508, 3.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242447, 32820, 0, 1, 1, 0, 0, 1891.12, 542.912, 40.554, 3.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242448, 32820, 0, 1, 1, 0, 0, 2012.47, 1580.58, 77.6077, 4.3923, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242449, 32820, 0, 1, 1, 0, 0, 1893.65, -537, 41.372, 3.531, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242450, 32820, 0, 1, 1, 0, 0, 1893.68, -169, 35.857, 5.472, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242451, 32820, 0, 1, 1, 0, 0, 1653.06, 1609.58, 149.414, 4.17314, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242452, 32820, 0, 1, 1, 0, 0, 1894.75, -205, 37.689, 1.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242453, 32820, 0, 1, 1, 0, 0, 1895.31, 1581.26, 88.185, 0.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242454, 32820, 0, 1, 1, 0, 0, 1895.89, -105, 33.024, 0.914, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242455, 32820, 0, 1, 1, 0, 0, 1898.83, 531.013, 39.578, 4.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242456, 32820, 0, 1, 1, 0, 0, 1899, -683, 53.638, 2.476, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242457, 32820, 0, 1, 1, 0, 0, 1899.19, 476.333, 37.781, 3.259, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242458, 32820, 0, 1, 1, 0, 0, 1899.36, 688.674, 36.042, 2.18, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242459, 32820, 0, 1, 1, 0, 0, 2020.63, 1526.77, 78.8895, 4.93289, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242460, 32820, 0, 1, 1, 0, 0, 1976.96, 1515.52, 86.8198, 2.82125, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242461, 32820, 0, 1, 1, 0, 0, 1975.9, 1641.65, 75.8876, 1.81514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242462, 32820, 0, 1, 1, 0, 0, 1903.02, 330.524, 41.208, 3.816, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242463, 32820, 0, 1, 1, 0, 0, 1903.3, -550, 45.428, 4.392, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242464, 32820, 0, 1, 1, 0, 0, 1888.39, 1537.52, 88.2019, 3.65945, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242465, 32820, 0, 1, 1, 0, 0, 1904.02, 609.035, 50.982, 3.845, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242466, 32820, 0, 1, 1, 0, 0, 1905.15, 322.905, 40.198, 4.985, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242467, 32820, 0, 1, 1, 0, 0, 2073.59, 1476.34, 66.1495, 0.756588, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242468, 32820, 0, 1, 1, 0, 0, 1905.31, -513, 39.205, 3.276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242469, 32820, 0, 1, 1, 0, 0, 1905.98, 1054.98, 34.74, 1.406, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242470, 32820, 0, 1, 1, 0, 0, 2087.25, 1392.01, 61.4079, 6.27286, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242471, 32820, 0, 1, 1, 0, 0, 1907.51, 1151.35, 39.611, 5.437, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242472, 32820, 0, 1, 1, 0, 0, 1908.24, 792.84, 37.379, 4.588, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242473, 32820, 0, 1, 1, 0, 0, 1970.62, 1470.79, 79.7657, 5.48111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242474, 32820, 0, 1, 1, 0, 0, 1909.56, 634.198, 45.749, 5.973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242475, 32820, 0, 1, 1, 0, 0, 1911.94, -117, 36.172, 0.283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242476, 32820, 0, 1, 1, 0, 0, 1913.53, -804, 64.965, 4.987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242477, 32820, 0, 1, 1, 0, 0, 1899.79, 1553.29, 88.9766, 0.758083, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242478, 32820, 0, 1, 1, 0, 0, 1913.97, 832.742, 41.563, 1.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242479, 32820, 0, 1, 1, 0, 0, 2103.97, 1420.71, 60.5048, 2.73086, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242480, 32820, 0, 1, 1, 0, 0, 1914.55, 826.282, 41.174, 5.214, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242481, 32820, 0, 1, 1, 0, 0, 1914.66, 959.827, 31.803, 1.865, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242482, 32820, 0, 1, 1, 0, 0, 1915.67, -352, 37.103, 3.7, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242483, 32820, 0, 1, 1, 0, 0, 1912.84, 1604.96, 84.7089, 4.03322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242484, 32820, 0, 1, 1, 0, 0, 1917.24, -189, 36.152, 4.236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242485, 32820, 0, 1, 1, 0, 0, 1920.11, -561, 49.963, 2.026, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242486, 32820, 0, 1, 1, 0, 0, 1920.96, 182.272, 10.43, 1.058, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242487, 32820, 0, 1, 1, 0, 0, 1976.86, 1596.07, 82.3567, 5.34529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242488, 32820, 0, 1, 1, 0, 0, 1892.15, 1516.01, 88.1731, 4.6511, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242489, 32820, 0, 1, 1, 0, 0, 1923.08, 784.038, 41.753, 3.343, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242490, 32820, 0, 1, 1, 0, 0, 1922.86, 1660.1, 80.2627, 1.04457, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242491, 32820, 0, 1, 1, 0, 0, 1924.15, -262, 34.052, 1.142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242492, 32820, 0, 1, 1, 0, 0, 1811.3, 1698.05, 105.944, 2.54522, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242493, 32820, 0, 1, 1, 0, 0, 1930.87, -132, 39.476, 6.129, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242494, 32820, 0, 1, 1, 0, 0, 1931.21, 1.265, 11.003, 0.835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242495, 32820, 0, 1, 1, 0, 0, 1933.14, 681.603, 41.725, 5.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242496, 32820, 0, 1, 1, 0, 0, 1934.58, 639.221, 51.061, 2.058, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242497, 32820, 0, 1, 1, 0, 0, 1934.71, 610.212, 54.488, 0.334, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242498, 32820, 0, 1, 1, 0, 0, 1856.51, 1528.37, 88.5612, 2.93345, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242499, 32820, 0, 1, 1, 0, 0, 1938.13, 1015.19, 32.456, 1.546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242500, 32820, 0, 1, 1, 0, 0, 1851.69, 1505.98, 89.3269, 2.95227, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242501, 32820, 0, 1, 1, 0, 0, 1940.49, 574.039, 50.971, 2.927, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242502, 32820, 0, 1, 1, 0, 0, 1940.51, 426.475, 37.108, 1.603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242503, 32820, 0, 1, 1, 0, 0, 1940.71, -34, 14.904, 1.806, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242504, 32820, 0, 1, 1, 0, 0, 1922.01, 1575.06, 84.9355, 0.885617, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242505, 32820, 0, 1, 1, 0, 0, 1918.92, 1537.7, 86.9618, 0.138741, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242506, 32820, 0, 1, 1, 0, 0, 1857.73, 1705.33, 94.4552, 2.90437, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242507, 32820, 0, 1, 1, 0, 0, 1943.15, 111.969, 9.73, 2.298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242508, 32820, 0, 1, 1, 0, 0, 1943.39, -56, 29.26, 0.768, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242509, 32820, 0, 1, 1, 0, 0, 1944.55, 296.285, 38.875, 4.456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242510, 32820, 0, 1, 1, 0, 0, 1948.13, -592, 54.881, 5.435, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242511, 32820, 0, 1, 1, 0, 0, 1948.55, 792.451, 37.931, 5.945, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242512, 32820, 0, 1, 1, 0, 0, 1891.52, 1725.97, 93.6389, 4.01667, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242513, 32820, 0, 1, 1, 0, 0, 1950.03, 547.195, 51.345, 3.805, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242514, 32820, 0, 1, 1, 0, 0, 1950.08, 470.193, 37.169, 4.111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242515, 32820, 0, 1, 1, 0, 0, 1952.4, 540.482, 49.681, 4.556, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242516, 32820, 0, 1, 1, 0, 0, 1952.86, 1169.39, 40.689, 3.675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242517, 32820, 0, 1, 1, 0, 0, 1952.9, -252, 36.315, 0.569, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242518, 32820, 0, 1, 1, 0, 0, 1953.24, 966.066, 33.746, 2.491, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242519, 32820, 0, 1, 1, 0, 0, 1953.59, 1095.42, 33.556, 1.442, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242520, 32820, 0, 1, 1, 0, 0, 1953.89, -315, 35.385, 6.102, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242521, 32820, 0, 1, 1, 0, 0, 1954.09, -602, 56.585, 0.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242522, 32820, 0, 1, 1, 0, 0, 1954.25, 1111.91, 33.531, 1.752, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242523, 32820, 0, 1, 1, 0, 0, 1954.77, 413.706, 37.504, 5.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242524, 32820, 0, 1, 1, 0, 0, 1955.2, -232, 33.633, 1.746, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242525, 32820, 0, 1, 1, 0, 0, 1955.75, 39.908, 18.991, 5.913, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242526, 32820, 0, 1, 1, 0, 0, 1955.84, 719.583, 36.919, 1.406, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242527, 32820, 0, 1, 1, 0, 0, 1955.92, 886.075, 34.76, 2.482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242528, 32820, 0, 1, 1, 0, 0, 1955.99, -301, 34.315, 2.913, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242529, 32820, 0, 1, 1, 0, 0, 1957.26, -431, 35.451, 3.13, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242530, 32820, 0, 1, 1, 0, 0, 1957.68, -579, 53.973, 1.195, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242531, 32820, 0, 1, 1, 0, 0, 1958.6, 912.246, 34.687, 3.052, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242532, 32820, 0, 1, 1, 0, 0, 1959.16, -414, 35.702, 5.209, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242533, 32820, 0, 1, 1, 0, 0, 1862.97, 1529.46, 88.5361, 0.636311, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242534, 32820, 0, 1, 1, 0, 0, 1959.88, 104.673, 18.088, 5.631, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242535, 32820, 0, 1, 1, 0, 0, 1961.28, 494.136, 37.534, 0.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242536, 32820, 0, 1, 1, 0, 0, 1940.53, 1664.75, 79.007, 0.17767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242537, 32820, 0, 1, 1, 0, 0, 1963.1, 1170.4, 41.227, 3.751, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242538, 32820, 0, 1, 1, 0, 0, 1963.52, -397, 35.452, 3.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242539, 32820, 0, 1, 1, 0, 0, 1946.97, 1590.39, 82.2999, 5.39887, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242540, 32820, 0, 1, 1, 0, 0, 1904.25, 1524.12, 87.3555, 1.85287, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242541, 32820, 0, 1, 1, 0, 0, 1965.91, 1378.91, 64.162, 6.1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242542, 32820, 0, 1, 1, 0, 0, 1966.15, 821.354, 39.084, 2.69, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242543, 32820, 0, 1, 1, 0, 0, 1968.89, 355.661, 39.631, 0.293, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242544, 32820, 0, 1, 1, 0, 0, 1971.24, 1012.8, 36.202, 5.523, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242545, 32820, 0, 1, 1, 0, 0, 1972.52, 324.816, 39.891, 2.445, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242546, 32820, 0, 1, 1, 0, 0, 1972.77, 329.349, 39.975, 4.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242547, 32820, 0, 1, 1, 0, 0, 1974.31, 141.348, 15.627, 3.536, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242548, 32820, 0, 1, 1, 0, 0, 1974.32, -211, 33.944, 4.797, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242549, 32820, 0, 1, 1, 0, 0, 1976.2, -320, 36.589, 6.212, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242550, 32820, 0, 1, 1, 0, 0, 1976.48, 724.143, 35.804, 4.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242551, 32820, 0, 1, 1, 0, 0, 1976.74, 956.769, 37.919, 1.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242552, 32820, 0, 1, 1, 0, 0, 1976.91, 1372.13, 63.869, 0.662, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242553, 32820, 0, 1, 1, 0, 0, 1977, 1381.61, 63.031, 6.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242554, 32820, 0, 1, 1, 0, 0, 1977.12, -380, 35.702, 3.502, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242555, 32820, 0, 1, 1, 0, 0, 1978.05, 592.804, 50.152, 0.347, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242556, 32820, 0, 1, 1, 0, 0, 2028.75, 1695, 78.2094, 4.26584, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242557, 32820, 0, 1, 1, 0, 0, 1978.75, 897.572, 34.957, 0.503, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242558, 32820, 0, 1, 1, 0, 0, 1979.7, 988.74, 33.193, 0.35, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242559, 32820, 0, 1, 1, 0, 0, 1918.99, 1587.29, 84.0605, 3.8303, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242560, 32820, 0, 1, 1, 0, 0, 1719.25, 1686.25, 132.317, 2.03842, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242561, 32820, 0, 1, 1, 0, 0, 2136.24, 1379.74, 69.1082, 1.09842, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242562, 32820, 0, 1, 1, 0, 0, 1981.74, -545, 50.134, 1.324, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242563, 32820, 0, 1, 1, 0, 0, 1981.8, -211, 34.36, 3.751, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242564, 32820, 0, 1, 1, 0, 0, 1983.04, 1104.12, 34.043, 4.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242565, 32820, 0, 1, 1, 0, 0, 2086.6, 1328.16, 61.8731, 5.722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242566, 32820, 0, 1, 1, 0, 0, 1985, 694.409, 43.827, 4.429, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242567, 32820, 0, 1, 1, 0, 0, 1985.3, 17.109, 30.404, 2.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242568, 32820, 0, 1, 1, 0, 0, 1985.88, 1376.55, 62.691, 0.77, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242569, 32820, 0, 1, 1, 0, 0, 1987.16, -482, 35.043, 3.723, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242570, 32820, 0, 1, 1, 0, 0, 1987.47, 649.66, 42.471, 6.087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242571, 32820, 0, 1, 1, 0, 0, 1987.93, 734.326, 37.279, 5.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242572, 32820, 0, 1, 1, 0, 0, 1989.89, -453, 34.525, 1.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242573, 32820, 0, 1, 1, 0, 0, 2143.56, 1409.93, 69.885, 2.07938, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242574, 32820, 0, 1, 1, 0, 0, 1992.91, 429.715, 35.739, 1.723, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242575, 32820, 0, 1, 1, 0, 0, 1993.71, 280.852, 47.869, 3.271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242576, 32820, 0, 1, 1, 0, 0, 1994.38, -156, 34.638, 2.529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242577, 32820, 0, 1, 1, 0, 0, 1994.78, 601.365, 46.923, 3.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242578, 32820, 0, 1, 1, 0, 0, 1994.82, -153, 34.467, 1.022, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242579, 32820, 0, 1, 1, 0, 0, 1745.02, 1711.84, 130.134, 3.19535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242580, 32820, 0, 1, 1, 0, 0, 1995.44, 966.284, 36.649, 2.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242581, 32820, 0, 1, 1, 0, 0, 1901.4, 1572.05, 89.2571, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242582, 32820, 0, 1, 1, 0, 0, 2013.52, 1505.72, 74.5312, 0.065802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242583, 32820, 0, 1, 1, 0, 0, 2022.5, 1582.05, 74.9962, 3.91096, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242584, 32820, 0, 1, 1, 0, 0, 1999.06, -369, 35.702, 2.865, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242585, 32820, 0, 1, 1, 0, 0, 1999.12, 876.686, 33.847, 0.581, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242586, 32820, 0, 1, 1, 0, 0, 2002.6, 280.089, 47.823, 3.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242587, 32820, 0, 1, 1, 0, 0, 1967.6, 1641.89, 77.3097, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242588, 32820, 0, 1, 1, 0, 0, 2004.93, 1071.75, 35.777, 0.534, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242589, 32820, 0, 1, 1, 0, 0, 2005.88, 444.298, 37.364, 5.514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242590, 32820, 0, 1, 1, 0, 0, 2006.19, 99.895, 34.778, 4.494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242591, 32820, 0, 1, 1, 0, 0, 2006.23, 365.215, 42.958, 0.61, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242592, 32820, 0, 1, 1, 0, 0, 2060.22, 1775.06, 88.9039, -1.53637, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242593, 32820, 0, 1, 1, 0, 0, 2008.58, 1006.15, 32.019, 4.622, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242594, 32820, 0, 1, 1, 0, 0, 2009.37, 223.66, 35.843, 5.281, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242595, 32820, 0, 1, 1, 0, 0, 1749.95, 1645.55, 118.51, 5.68655, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242596, 32820, 0, 1, 1, 0, 0, 2011.53, -403, 35.452, 4.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242597, 32820, 0, 1, 1, 0, 0, 2012.68, 353.627, 41.517, 3.932, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242598, 32820, 0, 1, 1, 0, 0, 2012.9, 229.321, 38.256, 4.04, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242599, 32820, 0, 1, 1, 0, 0, 2014.47, 1024.09, 29.558, 4.305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242600, 32820, 0, 1, 1, 0, 0, 1913.93, 1588.19, 84.9734, 2.88904, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242601, 32820, 0, 1, 1, 0, 0, 2015.8, -344, 35.702, 0.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242602, 32820, 0, 1, 1, 0, 0, 2016.65, 36.857, 35.85, 3.609, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242603, 32820, 0, 1, 1, 0, 0, 2017.34, -514, 41.614, 6.053, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242604, 32820, 0, 1, 1, 0, 0, 2017.49, -417, 35.452, 0.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242605, 32820, 0, 1, 1, 0, 0, 2017.73, 79.376, 36.834, 0.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242606, 32820, 0, 1, 1, 0, 0, 2019.74, -364, 35.452, 4.031, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242607, 32820, 0, 1, 1, 0, 0, 2046.36, 1822.14, 107.323, -1.30963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242608, 32820, 0, 1, 1, 0, 0, 2042.42, 1851.53, 103.969, -1.74312, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242609, 32820, 0, 1, 1, 0, 0, 2021.72, 1201.21, 50.152, 5.867, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242610, 32820, 0, 1, 1, 0, 0, 2022.21, 883.465, 34.844, 6.222, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242611, 32820, 0, 1, 1, 0, 0, 2022.4, 85.277, 36.178, 0.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242612, 32820, 0, 1, 1, 0, 0, 1797.22, 1718.62, 112.576, 0.078981, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242613, 32820, 0, 1, 1, 0, 0, 2023.04, 73.922, 36.302, 0.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242614, 32820, 0, 1, 1, 0, 0, 2051.46, 1328.73, 69.1295, 2.2204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242615, 32820, 0, 1, 1, 0, 0, 2024.87, 615.426, 37.312, 3.499, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242616, 32820, 0, 1, 1, 0, 0, 2026.9, 391.331, 42.343, 3.322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242617, 32820, 0, 1, 1, 0, 0, 2026.91, 1074.94, 34.519, 1.16, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242618, 32820, 0, 1, 1, 0, 0, 2027.05, 226.902, 38.685, 4.85, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242619, 32820, 0, 1, 1, 0, 0, 2027.55, -122, 34.171, 3.21, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242620, 32820, 0, 1, 1, 0, 0, 1755.43, 1745.95, 139.746, 0.129933, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242621, 32820, 0, 1, 1, 0, 0, 2028.31, 45.886, 34.271, 0.033, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242622, 32820, 0, 1, 1, 0, 0, 2029.08, 1119.06, 35.292, 5.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242623, 32820, 0, 1, 1, 0, 0, 2004.61, 1644.08, 73.5819, 2.64459, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242624, 32820, 0, 1, 1, 0, 0, 1808.03, 1542.79, 97.2619, 2.91201, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242625, 32820, 0, 1, 1, 0, 0, 2029.87, 201.484, 37.672, 1.759, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242626, 32820, 0, 1, 1, 0, 0, 2117.51, 1370.31, 62.8016, 1.43566, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242627, 32820, 0, 1, 1, 0, 0, 2042.87, 1858.22, 102.938, -1.70908, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242628, 32820, 0, 1, 1, 0, 0, 2030.61, 808.408, 34.358, 4.642, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242629, 32820, 0, 1, 1, 0, 0, 2031.74, -551, 54.019, 5.226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242630, 32820, 0, 1, 1, 0, 0, 2034.18, 1350.95, 64.3509, 4.01332, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242631, 32820, 0, 1, 1, 0, 0, 2039.39, 1849.1, 103.807, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242632, 32820, 0, 1, 1, 0, 0, 2035.67, 823.547, 35.171, 3.481, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242633, 32820, 0, 1, 1, 0, 0, 2035.76, -82, 34.226, 5.239, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242634, 32820, 0, 1, 1, 0, 0, 2015.52, 1771.9, 105.903, 4.55457, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242635, 32820, 0, 1, 1, 0, 0, 2036.43, -502, 40.14, 0.839, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242636, 32820, 0, 1, 1, 0, 0, 2037.54, -141, 36.938, 1.933, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242637, 32820, 0, 1, 1, 0, 0, 2038.44, -336, 35.452, 6.103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242638, 32820, 0, 1, 1, 0, 0, 1897.8, 1504.98, 93.9504, 2.18601, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242639, 32820, 0, 1, 1, 0, 0, 2040.2, -31, 37.94, 0.267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242640, 32820, 0, 1, 1, 0, 0, 2040.4, -332, 35.68, 3.45, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242641, 32820, 0, 1, 1, 0, 0, 2021.58, 1849.13, 102.658, 4.56117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242642, 32820, 0, 1, 1, 0, 0, 2040.84, 58.942, 33.868, 4.036, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242643, 32820, 0, 1, 1, 0, 0, 2041.02, 726.205, 38.435, 1.326, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242644, 32820, 0, 1, 1, 0, 0, 1762.79, 1518, 113.58, 2.96888, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242645, 32820, 0, 1, 1, 0, 0, 2043.66, -225, 36.929, 3.266, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242646, 32820, 0, 1, 1, 0, 0, 2017.02, 1853.65, 102.919, 2.19558, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242647, 32820, 0, 1, 1, 0, 0, 2044.93, -24, 39.357, 2.159, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242648, 32820, 0, 1, 1, 0, 0, 2046.22, 971.689, 33.381, 0.407, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242649, 32820, 0, 1, 1, 0, 0, 2046.36, 734.951, 38.477, 1.144, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242650, 32820, 0, 1, 1, 0, 0, 2031.61, 1760.52, 104.635, 2.65555, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242651, 32820, 0, 1, 1, 0, 0, 2046.61, -413, 35.467, 3.689, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242652, 32820, 0, 1, 1, 0, 0, 1971.72, 1332.93, 77.2402, 1.3484, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242653, 32820, 0, 1, 1, 0, 0, 2042.69, 1875.06, 102.249, -0.92142, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242654, 32820, 0, 1, 1, 0, 0, 2047.1, 1015.39, 31.633, 0.017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242655, 32820, 0, 1, 1, 0, 0, 2047.41, 1162.26, 37.78, 3.208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242656, 32820, 0, 1, 1, 0, 0, 2047.49, 645.674, 36.773, 1.013, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242657, 32820, 0, 1, 1, 0, 0, 2048.14, 550.227, 45.484, 2.278, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242658, 32820, 0, 1, 1, 0, 0, 1842.82, 1678.65, 97.1791, 5.06255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242659, 32820, 0, 1, 1, 0, 0, 1907.3, 1665.82, 83.5905, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242660, 32820, 0, 1, 1, 0, 0, 2044.95, 1708.38, 76.6127, 5.74122, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242661, 32820, 0, 1, 1, 0, 0, 2050.19, -487, 40.927, 4.162, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242662, 32820, 0, 1, 1, 0, 0, 2050.19, 835.752, 37.088, 2.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242663, 32820, 0, 1, 1, 0, 0, 2046.7, 1420.23, 64.6285, 3.4127, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242664, 32820, 0, 1, 1, 0, 0, 2051.93, -507, 43.35, 6.162, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242665, 32820, 0, 1, 1, 0, 0, 2052.7, 459.638, 49.471, 1.834, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242666, 32820, 0, 1, 1, 0, 0, 2052.71, 885.654, 34.156, 1.804, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242667, 32820, 0, 1, 1, 0, 0, 2039.24, 1927.41, 106.997, 5.2572, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242668, 32820, 0, 1, 1, 0, 0, 2053.8, 948.836, 37.278, 1.334, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242669, 32820, 0, 1, 1, 0, 0, 2053.91, 239.607, 99.769, 0.538, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242670, 32820, 0, 1, 1, 0, 0, 2162.31, 1631.2, 85.9035, 1.46979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242671, 32820, 0, 1, 1, 0, 0, 2055.44, 692.034, 40.564, 4.801, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242672, 32820, 0, 1, 1, 0, 0, 2060.85, 1778.14, 88.95, -1.80664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242673, 32820, 0, 1, 1, 0, 0, 2057.16, -23, 40.07, 3.832, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242674, 32820, 0, 1, 1, 0, 0, 2057.21, 913.271, 33.526, 3.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242675, 32820, 0, 1, 1, 0, 0, 2057.51, 279.706, 59.643, 3.013, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242676, 32820, 0, 1, 1, 0, 0, 2058.29, 806.14, 36.001, 1.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242677, 32820, 0, 1, 1, 0, 0, 2056.97, 1776.17, 90.0997, -0.482707, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242678, 32820, 0, 1, 1, 0, 0, 2058.78, 285.885, 59.647, 2.986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242679, 32820, 0, 1, 1, 0, 0, 2023.58, 1706.39, 79.4175, 5.01283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242680, 32820, 0, 1, 1, 0, 0, 2059.86, 482.621, 48.592, 0.632, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242681, 32820, 0, 1, 1, 0, 0, 2028.19, 1922.43, 107.104, 1.76648, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242682, 32820, 0, 1, 1, 0, 0, 2062.18, 338.783, 55.208, 5.476, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242683, 32820, 0, 1, 1, 0, 0, 2063.56, 290.546, 97.031, 5.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242684, 32820, 0, 1, 1, 0, 0, 2064.44, 756.674, 39.752, 5.325, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242685, 32820, 0, 1, 1, 0, 0, 2064.98, 70.83, 39.206, 6.049, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242686, 32820, 0, 1, 1, 0, 0, 2065.42, -370, 35.665, 5.481, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242687, 32820, 0, 1, 1, 0, 0, 2066.76, -82, 36.672, 3.541, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242688, 32820, 0, 1, 1, 0, 0, 2067.05, -550, 55.844, 5.643, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242689, 32820, 0, 1, 1, 0, 0, 2067.3, -197, 38.593, 5.404, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242690, 32820, 0, 1, 1, 0, 0, 2067.57, 369.811, 40.361, 0.171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242691, 32820, 0, 1, 1, 0, 0, 2067.97, -101, 38.276, 1.817, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242692, 32820, 0, 1, 1, 0, 0, 2068.44, -118, 37.03, 0.131, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242693, 32820, 0, 1, 1, 0, 0, 2138.94, 1335.12, 54.5369, 2.61531, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242694, 32820, 0, 1, 1, 0, 0, 2070.34, 878.129, 35.484, 1.15, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242695, 32820, 0, 1, 1, 0, 0, 2060.03, 1778.16, 89.545, -1.58239, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242696, 32820, 0, 1, 1, 0, 0, 2070.94, -287, 42.476, 1.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242697, 32820, 0, 1, 1, 0, 0, 2066.83, 1349.86, 61.2389, 5.49917, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242698, 32820, 0, 1, 1, 0, 0, 2072.44, 276.922, 59.6398, 6.27228, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242699, 32820, 0, 1, 1, 0, 0, 2004.17, 1654.17, 75.4569, 1.8434, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242700, 32820, 0, 1, 1, 0, 0, 2073.38, -419, 39.952, 4.991, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242701, 32820, 0, 1, 1, 0, 0, 2073.47, 282.781, 59.645, 6.124, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242702, 32820, 0, 1, 1, 0, 0, 2073.73, 1132.56, 35.526, 3.825, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242703, 32820, 0, 1, 1, 0, 0, 2074.66, 1034.66, 34.803, 0.718, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242704, 32820, 0, 1, 1, 0, 0, 2074.73, -519, 55.793, 2.566, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242705, 32820, 0, 1, 1, 0, 0, 2075.72, 1202.52, 45.322, 2.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242706, 32820, 0, 1, 1, 0, 0, 2021.02, 1911.75, 105.644, 3.21279, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242707, 32820, 0, 1, 1, 0, 0, 2076.91, -185, 43.133, 4.205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242708, 32820, 0, 1, 1, 0, 0, 2049.65, 1732.27, 80.4877, 3.31944, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242709, 32820, 0, 1, 1, 0, 0, 1971.43, 1354.39, 68.887, 4.29635, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242710, 32820, 0, 1, 1, 0, 0, 2077.52, 693.921, 37.999, 5.065, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242711, 32820, 0, 1, 1, 0, 0, 2078.41, -251, 40.586, 0.182, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242712, 32820, 0, 1, 1, 0, 0, 2078.57, 4.905, 42.068, 1.306, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242713, 32820, 0, 1, 1, 0, 0, 2078.67, 629.378, 34.795, 2.592, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242714, 32820, 0, 1, 1, 0, 0, 2078.89, 1140.56, 35.846, 4.338, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242715, 32820, 0, 1, 1, 0, 0, 2078.96, 91.511, 36.836, 2.531, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242716, 32820, 0, 1, 1, 0, 0, 2019.53, 1898.06, 103.851, 2.14568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242717, 32820, 0, 1, 1, 0, 0, 2006.41, 1378.54, 61.7167, 1.51118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242718, 32820, 0, 1, 1, 0, 0, 2083.03, 1201.24, 44.457, 6.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242719, 32820, 0, 1, 1, 0, 0, 2083.07, 684.921, 38.775, 0.814, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242720, 32820, 0, 1, 1, 0, 0, 1896.38, 1364.77, 69.7813, 5.23592, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242721, 32820, 0, 1, 1, 0, 0, 2083.9, 1947.31, 98.64, 2.035, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242722, 32820, 0, 1, 1, 0, 0, 2084.73, 452.826, 53.378, 5.251, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242723, 32820, 0, 1, 1, 0, 0, 1827.52, 1715.56, 102.475, 4.52974, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242724, 32820, 0, 1, 1, 0, 0, 2085.16, 345.001, 52.812, 1.366, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242725, 32820, 0, 1, 1, 0, 0, 2085.53, -123, 39.026, 5.75, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242726, 32820, 0, 1, 1, 0, 0, 1808.53, 1774.53, 132.221, 4.17193, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242727, 32820, 0, 1, 1, 0, 0, 2087.39, 608.782, 34.674, 0.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242728, 32820, 0, 1, 1, 0, 0, 1869.89, 1671.97, 92.0772, 0.063407, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242729, 32820, 0, 1, 1, 0, 0, 1815.67, 1447.38, 85.6652, 4.00511, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242730, 32820, 0, 1, 1, 0, 0, 2090.29, 917.421, 36.175, 4.487, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242731, 32820, 0, 1, 1, 0, 0, 2091.17, 206.584, 55.045, 3.016, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242732, 32820, 0, 1, 1, 0, 0, 2092.74, 1062.42, 32.512, 5.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242733, 32820, 0, 1, 1, 0, 0, 1840.7, 1441.26, 80.3841, 4.92828, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242734, 32820, 0, 1, 1, 0, 0, 2092.98, -455, 44.693, 3.958, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242735, 32820, 0, 1, 1, 0, 0, 2093.42, 1084.22, 37.3, 1.54, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242736, 32820, 0, 1, 1, 0, 0, 2093.44, -43, 39.19, 0.084, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242737, 32820, 0, 1, 1, 0, 0, 2095.32, 1126.56, 34.958, 2.117, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242738, 32820, 0, 1, 1, 0, 0, 2096.49, -589, 61.891, 0.042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242739, 32820, 0, 1, 1, 0, 0, 2097.09, 1022.21, 33.55, 4.858, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242740, 32820, 0, 1, 1, 0, 0, 2097.09, 190.874, 56.708, 4.383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242741, 32820, 0, 1, 1, 0, 0, 2097.55, 945.28, 36.636, 3.586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242742, 32820, 0, 1, 1, 0, 0, 2097.96, 367.464, 44.919, 4.056, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242743, 32820, 0, 1, 1, 0, 0, 2098.45, 24.948, 35.683, 0.745, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242744, 32820, 0, 1, 1, 0, 0, 2011.17, 1337.33, 72.2587, 4.60995, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242745, 32820, 0, 1, 1, 0, 0, 2100.96, 105.429, 32.285, 2.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242746, 32820, 0, 1, 1, 0, 0, 1881.74, 1440.92, 74.5331, 3.04863, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242747, 32820, 0, 1, 1, 0, 0, 2088.35, 1713.08, 67.0698, 5.9835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242748, 32820, 0, 1, 1, 0, 0, 2102.76, 233.472, 61.795, 6.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242749, 32820, 0, 1, 1, 0, 0, 2104.04, 986.665, 36.72, 4.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242750, 32820, 0, 1, 1, 0, 0, 2077.3, 1688.81, 70.235, 5.82023, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242751, 32820, 0, 1, 1, 0, 0, 1861.56, 1489.31, 89.5527, 4.47295, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242752, 32820, 0, 1, 1, 0, 0, 1943.11, 1434.81, 67.6766, 0.955429, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242753, 32820, 0, 1, 1, 0, 0, 2107.05, 660.18, 35.125, 4.362, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242754, 32820, 0, 1, 1, 0, 0, 2108.62, -894, 108.976, 3.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242755, 32820, 0, 1, 1, 0, 0, 2108.83, 478.31, 62.263, 6.225, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242756, 32820, 0, 1, 1, 0, 0, 2110.95, 1003.16, 34.44, 0.332, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242757, 32820, 0, 1, 1, 0, 0, 2111.17, 693.495, 36.539, 6.102, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242758, 32820, 0, 1, 1, 0, 0, 2112.4, 821.576, 33.143, 1.608, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242759, 32820, 0, 1, 1, 0, 0, 2112.78, -625, 93.599, 0.281, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242760, 32820, 0, 1, 1, 0, 0, 2114.84, -38, 42.798, 0.651, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242761, 32820, 0, 1, 1, 0, 0, 2115.19, 43.542, 38.107, 4.966, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242762, 32820, 0, 1, 1, 0, 0, 1976.24, 1495.05, 85.6114, 4.69927, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242763, 32820, 0, 1, 1, 0, 0, 2115.64, -5299, 82.163, 1.075, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242764, 32820, 0, 1, 1, 0, 0, 2115.65, 549.438, 40.849, 0.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242765, 32820, 0, 1, 1, 0, 0, 2117.29, 516.623, 53.938, 5.176, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242766, 32820, 0, 1, 1, 0, 0, 2118.06, -258, 50.686, 0.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242767, 32820, 0, 1, 1, 0, 0, 2118.31, -61, 41.311, 6.279, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242768, 32820, 0, 1, 1, 0, 0, 2119.43, -191, 41.035, 2.649, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242769, 32820, 0, 1, 1, 0, 0, 1881.93, 1774.41, 118.192, 4.4506, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242770, 32820, 0, 1, 1, 0, 0, 2119.86, 825.431, 32.753, 5.361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242771, 32820, 0, 1, 1, 0, 0, 2059.25, 1744.25, 81.5146, 3.61765, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242772, 32820, 0, 1, 1, 0, 0, 2120.54, 1012.54, 33.564, 4.349, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242773, 32820, 0, 1, 1, 0, 0, 2121.89, 622.939, 34.849, 5.541, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242774, 32820, 0, 1, 1, 0, 0, 2122.32, -83, 41.185, 0.064, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242775, 32820, 0, 1, 1, 0, 0, 2122.4, 386.537, 49.507, 2.28, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242776, 32820, 0, 1, 1, 0, 0, 2123.31, 54.756, 37.694, 2.942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242777, 32820, 0, 1, 1, 0, 0, 1919.79, 1780.21, 118.376, 1.84019, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242778, 32820, 0, 1, 1, 0, 0, 2078.28, 1604.84, 71.8452, 5.88908, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242779, 32820, 0, 1, 1, 0, 0, 1931.08, 1322.22, 80.217, 5.90955, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242780, 32820, 0, 1, 1, 0, 0, 2128.11, 1140.33, 33.863, 5.55, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242781, 32820, 0, 1, 1, 0, 0, 2042.77, 1895, 101.84, 3.27782, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242782, 32820, 0, 1, 1, 0, 0, 2128.86, 676.09, 35.774, 3.255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242783, 32820, 0, 1, 1, 0, 0, 1930.97, 1361.04, 68.2014, 5.75946, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242784, 32820, 0, 1, 1, 0, 0, 1917.79, 1752.5, 95.0883, 3.73869, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242785, 32820, 0, 1, 1, 0, 0, 2129.72, 1302.56, 53.803, 0.914, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242786, 32820, 0, 1, 1, 0, 0, 2129.84, 845.292, 32.861, 1.673, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242787, 32820, 0, 1, 1, 0, 0, 2130.11, 1195.2, 43.28, 3.537, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242788, 32820, 0, 1, 1, 0, 0, 2078.82, 1746.4, 76.4259, 4.10132, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242789, 32820, 0, 1, 1, 0, 0, 2130.51, -229, 50.741, 4.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242790, 32820, 0, 1, 1, 0, 0, 2130.54, 836.084, 33.936, 5.46, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242791, 32820, 0, 1, 1, 0, 0, 2130.57, 277.66, 56.109, 0.016, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242792, 32820, 0, 1, 1, 0, 0, 2131.32, 1081.94, 32.295, 1.587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242793, 32820, 0, 1, 1, 0, 0, 2131.94, 78.192, 32.567, 4.208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242794, 32820, 0, 1, 1, 0, 0, 2132.06, 1172.27, 41.235, 5.514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242795, 32820, 0, 1, 1, 0, 0, 2132.21, -292, 53.727, 6.193, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242796, 32820, 0, 1, 1, 0, 0, 2134.68, 766.579, 33.696, 1.245, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242797, 32820, 0, 1, 1, 0, 0, 2134.81, 24.776, 40.508, 1.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242798, 32820, 0, 1, 1, 0, 0, 2045.77, 1592.61, 70.3002, 1.46481, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242799, 32820, 0, 1, 1, 0, 0, 2136.56, -55, 42.489, 2.449, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242800, 32820, 0, 1, 1, 0, 0, 1809.05, 1487.63, 92.2249, 2.22045, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242801, 32820, 0, 1, 1, 0, 0, 2137.51, 447.275, 67.546, 4.482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242802, 32820, 0, 1, 1, 0, 0, 2138.22, 932.278, 32.517, 2.298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242803, 32820, 0, 1, 1, 0, 0, 2139.55, -629, 89.778, 5.681, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242804, 32820, 0, 1, 1, 0, 0, 2139.64, -70, 43.366, 6.014, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242805, 32820, 0, 1, 1, 0, 0, 2140.19, -143, 41.601, 2.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242806, 32820, 0, 1, 1, 0, 0, 2140.74, 333.625, 47.038, 5.583, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242807, 32820, 0, 1, 1, 0, 0, 2142.25, -574, 79.316, 1.743, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242808, 32820, 0, 1, 1, 0, 0, 2143.7, 617.114, 34.785, 6.194, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242809, 32820, 0, 1, 1, 0, 0, 2143.81, 905.505, 33.556, 5.041, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242810, 32820, 0, 1, 1, 0, 0, 2143.92, -261, 54.597, 4.158, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242811, 32820, 0, 1, 1, 0, 0, 2144.01, 295.302, 49.235, 4.696, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242812, 32820, 0, 1, 1, 0, 0, 2144.69, 845.938, 36.816, 6.026, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242813, 32820, 0, 1, 1, 0, 0, 2167.13, 1289.97, 53.8044, 2.92954, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242814, 32820, 0, 1, 1, 0, 0, 2146.51, 1087.12, 33.038, 2.173, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242815, 32820, 0, 1, 1, 0, 0, 2147.98, -162, 42.288, 1.28, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242816, 32820, 0, 1, 1, 0, 0, 2148.51, -548, 81.304, 4.714, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242817, 32820, 0, 1, 1, 0, 0, 2148.96, 1173.49, 41.564, 1.967, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242818, 32820, 0, 1, 1, 0, 0, 2149.56, 923.256, 33.366, 2.19, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242819, 32820, 0, 1, 1, 0, 0, 2149.72, 784.085, 35.757, 4.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242820, 32820, 0, 1, 1, 0, 0, 1912.29, 1756.79, 96.8451, 0.664982, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242821, 32820, 0, 1, 1, 0, 0, 2150.27, 581.356, 38.759, 5.833, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242822, 32820, 0, 1, 1, 0, 0, 2151.13, -532, 81.656, 4.728, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242823, 32820, 0, 1, 1, 0, 0, 2151.28, 781.396, 35.387, 1.441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242824, 32820, 0, 1, 1, 0, 0, 1913.28, 1698.36, 84.2699, 1.17009, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242825, 32820, 0, 1, 1, 0, 0, 2152.85, -376, 77.095, 2.125, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242826, 32820, 0, 1, 1, 0, 0, 2153.82, 264.085, 43.75, 6.073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242827, 32820, 0, 1, 1, 0, 0, 2154.14, -549, 81.38, 4.69, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242828, 32820, 0, 1, 1, 0, 0, 2154.25, 1273.87, 52.923, 5.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242829, 32820, 0, 1, 1, 0, 0, 2154.3, 613.135, 35.59, 4.875, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242830, 32820, 0, 1, 1, 0, 0, 2154.42, -509, 81.625, 6.261, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242831, 32820, 0, 1, 1, 0, 0, 2156.87, 76.336, 30.127, 1.953, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242832, 32820, 0, 1, 1, 0, 0, 2157.17, 1314.07, 53.888, 4.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242833, 32820, 0, 1, 1, 0, 0, 2157.89, 657.364, 34.545, 1.219, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242834, 32820, 0, 1, 1, 0, 0, 2158.68, 1178.75, 40.923, 2.14, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242835, 32820, 0, 1, 1, 0, 0, 2103.8, 1670.5, 71.61, 4.75789, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242836, 32820, 0, 1, 1, 0, 0, 2102.83, 1710.7, 67.3188, 5.1591, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242837, 32820, 0, 1, 1, 0, 0, 2161.29, -135, 40.317, 5.06, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242838, 32820, 0, 1, 1, 0, 0, 2161.74, 1309.66, 54.058, 3.609, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242839, 32820, 0, 1, 1, 0, 0, 2161.79, 1078.17, 32.831, 2.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242840, 32820, 0, 1, 1, 0, 0, 2161.84, 810.492, 40.524, 3.461, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242841, 32820, 0, 1, 1, 0, 0, 2162.56, 1053.67, 34.093, 3.124, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242842, 32820, 0, 1, 1, 0, 0, 2163.73, 657.343, 34.545, 2.354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242843, 32820, 0, 1, 1, 0, 0, 2164.72, 179.13, 42.693, 1.357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242844, 32820, 0, 1, 1, 0, 0, 1950.14, 1751.67, 112.956, 5.89412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242845, 32820, 0, 1, 1, 0, 0, 1905.91, 1666.46, 84.3586, 4.94577, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242846, 32820, 0, 1, 1, 0, 0, 2167.67, 480.995, 66.483, 1.386, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242847, 32820, 0, 1, 1, 0, 0, 2167.71, -606, 80.193, 5.898, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242848, 32820, 0, 1, 1, 0, 0, 2167.89, 1275.51, 53.207, 4.893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242849, 32820, 0, 1, 1, 0, 0, 2169.13, 1063.9, 33.426, 5.259, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242850, 32820, 0, 1, 1, 0, 0, 2170.73, -739, 72.017, 2.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242851, 32820, 0, 1, 1, 0, 0, 2171.07, 11.519, 41.672, 3.089, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242852, 32820, 0, 1, 1, 0, 0, 2173.42, 959.488, 34.521, 4.991, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242853, 32820, 0, 1, 1, 0, 0, 2175.75, -579, 79.655, 6.141, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242854, 32820, 0, 1, 1, 0, 0, 2176.37, -415, 71.493, 3.83, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242855, 32820, 0, 1, 1, 0, 0, 2176.81, -494, 77.326, 1.678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242856, 32820, 0, 1, 1, 0, 0, 2177.08, -448, 75, 2.048, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242857, 32820, 0, 1, 1, 0, 0, 2177.16, -56, 39.25, 3.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242858, 32820, 0, 1, 1, 0, 0, 2178.04, -707, 68.489, 4.028, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242859, 32820, 0, 1, 1, 0, 0, 2179.45, 265.599, 41.922, 2.515, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242860, 32820, 0, 1, 1, 0, 0, 2182.14, -21, 37.709, 3.873, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242861, 32820, 0, 1, 1, 0, 0, 2183.91, 334.654, 37.535, 5.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242862, 32820, 0, 1, 1, 0, 0, 2184.19, -451, 75.493, 2.496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242863, 32820, 0, 1, 1, 0, 0, 2184.33, 156.662, 54.539, 3.572, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242864, 32820, 0, 1, 1, 0, 0, 2185.43, 905.478, 44.982, 4.872, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242865, 32820, 0, 1, 1, 0, 0, 2185.44, -953, 86.888, 5.122, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242866, 32820, 0, 1, 1, 0, 0, 2186.22, 985.717, 34.936, 3.18, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242867, 32820, 0, 1, 1, 0, 0, 2187.24, -124, 33.846, 3.261, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242868, 32820, 0, 1, 1, 0, 0, 2188.02, 867.697, 47.564, 1.242, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242869, 32820, 0, 1, 1, 0, 0, 1963.34, 1693.95, 79.0409, 5.03445, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242870, 32820, 0, 1, 1, 0, 0, 2189.44, 244.623, 35.495, 5.568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242871, 32820, 0, 1, 1, 0, 0, 2190.93, -350, 76.38, 0.323, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242872, 32820, 0, 1, 1, 0, 0, 2192.44, -803, 78.426, 4.797, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242873, 32820, 0, 1, 1, 0, 0, 2195.31, 73.998, 27.678, 3.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242874, 32820, 0, 1, 1, 0, 0, 2198.03, -628, 79.928, 5.654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242875, 32820, 0, 1, 1, 0, 0, 2199.94, -916, 82.351, 3.032, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242876, 32820, 0, 1, 1, 0, 0, 2200.89, -834, 81.376, 3.29, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242877, 32820, 0, 1, 1, 0, 0, 2201.67, 569.413, 28.92, 1.475, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242878, 32820, 0, 1, 1, 0, 0, 2201.7, 1008.8, 37.503, 3.11, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242879, 32820, 0, 1, 1, 0, 0, 2202.54, -790, 77.934, 5.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242880, 32820, 0, 1, 1, 0, 0, 2202.84, 1184.23, 31.857, 2.052, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242881, 32820, 0, 1, 1, 0, 0, 2203.5, 99.245, 37.464, 0.982, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242882, 32820, 0, 1, 1, 0, 0, 2206.58, -291, 60.776, 1.558, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242883, 32820, 0, 1, 1, 0, 0, 2207.06, 625.442, 24.75, 5.076, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242884, 32820, 0, 1, 1, 0, 0, 2207.85, -83, 28.178, 2.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242885, 32820, 0, 1, 1, 0, 0, 2208.23, -46, 29.994, 3.938, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242886, 32820, 0, 1, 1, 0, 0, 2208.29, 1108.22, 35.033, 5.086, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242887, 32820, 0, 1, 1, 0, 0, 2210.07, -884, 79.818, 3.91, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242888, 32820, 0, 1, 1, 0, 0, 2210.19, 690.232, 34.949, 1.716, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242889, 32820, 0, 1, 1, 0, 0, 2210.48, 613.118, 25.056, 1.509, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242890, 32820, 0, 1, 1, 0, 0, 2210.61, -343, 76.102, 6.024, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242891, 32820, 0, 1, 1, 0, 0, 2213.12, 974.64, 34.851, 5.039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242892, 32820, 0, 1, 1, 0, 0, 2213.42, 1151.44, 36.331, 1.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242893, 32820, 0, 1, 1, 0, 0, 2213.96, 1014.27, 37.358, 1.463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242894, 32820, 0, 1, 1, 0, 0, 2214.63, -142, 29.372, 6.129, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242895, 32820, 0, 1, 1, 0, 0, 2214.8, 830.625, 42.754, 3.829, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242896, 32820, 0, 1, 1, 0, 0, 2215.25, 89.87, 33.792, 2.13, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242897, 32820, 0, 1, 1, 0, 0, 2215.64, 810.335, 36.014, 4.717, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242898, 32820, 0, 1, 1, 0, 0, 2215.74, 744.866, 37.825, 4.187, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242899, 32820, 0, 1, 1, 0, 0, 2215.75, 187.039, 46.615, 0.698, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242900, 32820, 0, 1, 1, 0, 0, 2216.58, 716.134, 37.089, 4.992, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242901, 32820, 0, 1, 1, 0, 0, 2217.6, 688.029, 35.747, 6.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242902, 32820, 0, 1, 1, 0, 0, 2217.66, 781.878, 33.909, 0.436, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242903, 32820, 0, 1, 1, 0, 0, 2218.03, 780.519, 33.878, 4.977, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242904, 32820, 0, 1, 1, 0, 0, 2218.38, 853.719, 47.378, 0.906, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242905, 32820, 0, 1, 1, 0, 0, 2218.94, -181, 24.371, 2.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242906, 32820, 0, 1, 1, 0, 0, 2219.32, -688, 66.713, 5.733, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242907, 32820, 0, 1, 1, 0, 0, 2219.82, 449.194, 53.727, 1.446, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242908, 32820, 0, 1, 1, 0, 0, 2220.45, 58.252, 34.739, 2.252, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242909, 32820, 0, 1, 1, 0, 0, 2222.72, 847.681, 46.425, 6.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242910, 32820, 0, 1, 1, 0, 0, 2223.43, 712.979, 36.523, 0.662, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242911, 32820, 0, 1, 1, 0, 0, 2223.5, 399.235, 45.126, 0.504, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242912, 32820, 0, 1, 1, 0, 0, 2225.04, 382.953, 39.736, 5.981, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242913, 32820, 0, 1, 1, 0, 0, 2226.55, 517.816, 40.286, 3.045, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242914, 32820, 0, 1, 1, 0, 0, 2227.02, -750, 71.357, 0.732, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242915, 32820, 0, 1, 1, 0, 0, 2227.53, 317.641, 36.719, 5.185, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242916, 32820, 0, 1, 1, 0, 0, 2229.11, 636.011, 24.968, 4.452, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242917, 32820, 0, 1, 1, 0, 0, 2229.59, -206, 40.297, 1.597, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242918, 32820, 0, 1, 1, 0, 0, 2230.34, -29, 25.738, 4.09, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242919, 32820, 0, 1, 1, 0, 0, 2230.35, 541.228, 40.439, 1.739, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242920, 32820, 0, 1, 1, 0, 0, 2230.55, 975.858, 37.83, 5.8, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242921, 32820, 0, 1, 1, 0, 0, 2231.01, -239, 52.908, 0.153, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242922, 32820, 0, 1, 1, 0, 0, 2231.63, 560.475, 34.627, 5.567, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242923, 32820, 0, 1, 1, 0, 0, 2231.82, 755.998, 34.81, 4.626, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242924, 32820, 0, 1, 1, 0, 0, 2233.58, -1007, 80.965, 2.657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242925, 32820, 0, 1, 1, 0, 0, 2235.19, 447.66, 46.216, 2.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242926, 32820, 0, 1, 1, 0, 0, 2236.58, 312.188, 36.721, 3.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242927, 32820, 0, 1, 1, 0, 0, 2236.77, -680, 66.274, 0.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242928, 32820, 0, 1, 1, 0, 0, 2238.35, 918.627, 45.64, 4.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242929, 32820, 0, 1, 1, 0, 0, 2238.9, -915, 75.816, 4.474, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242930, 32820, 0, 1, 1, 0, 0, 2240.14, 609.873, 33.625, 3.535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242931, 32820, 0, 1, 1, 0, 0, 2241.17, 133.656, 48.826, 4.33, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242932, 32820, 0, 1, 1, 0, 0, 2241.75, 458.269, 39.242, 0.722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242933, 32820, 0, 1, 1, 0, 0, 2242.3, 707.793, 35.301, 6.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242934, 32820, 0, 1, 1, 0, 0, 2244.3, -799, 73.969, 4.518, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242935, 32820, 0, 1, 1, 0, 0, 2245.02, 326.546, 35.272, 5.609, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242936, 32820, 0, 1, 1, 0, 0, 2246.19, 239.989, 34.26, 1.255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242937, 32820, 0, 1, 1, 0, 0, 2246.33, 308.24, 35.272, 5.104, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242938, 32820, 0, 1, 1, 0, 0, 2242.45, 599.449, 33.3335, 2.52821, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242939, 32820, 0, 1, 1, 0, 0, 2248.2, 641.756, 25, 3.243, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242940, 32820, 0, 1, 1, 0, 0, 2248.69, 331.302, 35.189, 5.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242941, 32820, 0, 1, 1, 0, 0, 2249.07, 237.011, 41.115, 6.115, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242942, 32820, 0, 1, 1, 0, 0, 2249.76, 267.438, 34.274, 3.569, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242943, 32820, 0, 1, 1, 0, 0, 2249.8, 416.225, 40.756, 3.341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242944, 32820, 0, 1, 1, 0, 0, 2250.01, 960.429, 42.133, 1.314, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242945, 32820, 0, 1, 1, 0, 0, 2250.26, 322.025, 35.272, 5.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242946, 32820, 0, 1, 1, 0, 0, 2250.35, 249.125, 41.115, 6.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242947, 32820, 0, 1, 1, 0, 0, 2250.97, 327.095, 35.189, 5.591, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242948, 32820, 0, 1, 1, 0, 0, 2251.46, -182, 27.26, 1.651, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242949, 32820, 0, 1, 1, 0, 0, 2251.83, 641.975, 24.75, 0.245, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242950, 32820, 0, 1, 1, 0, 0, 2251.91, -307, 65.069, 1.42, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242951, 32820, 0, 1, 1, 0, 0, 2252.4, -17, 26.358, 0.748, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242952, 32820, 0, 1, 1, 0, 0, 2252.48, 247.986, 34.259, 4.599, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(242953, 32820, 0, 1, 1, 0, 0, 2252.73, 250.472, 34.259, 6.011, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242954, 32820, 0, 1, 1, 0, 0, 2253.01, 251.748, 41.115, 5.255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242955, 32820, 0, 1, 1, 0, 0, 2253.27, -336, 76.373, 2.778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242956, 32820, 0, 1, 1, 0, 0, 2254.41, 297.984, 34.612, 5.776, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242957, 32820, 0, 1, 1, 0, 0, 2254.87, 238.435, 33.634, 0.859, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242958, 32820, 0, 1, 1, 0, 0, 2254.88, -229, 51.733, 1.118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242959, 32820, 0, 1, 1, 0, 0, 2255.34, 317.76, 35.165, 6.128, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242960, 32820, 0, 1, 1, 0, 0, 2256.2, 329.762, 35.189, 5.605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242961, 32820, 0, 1, 1, 0, 0, 2256.83, 233.273, 41.115, 1.251, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242962, 32820, 0, 1, 1, 0, 0, 2257.28, 1101.54, 33.523, 0.983, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242963, 32820, 0, 1, 1, 0, 0, 2258, 1230.01, 34.533, 0.171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242964, 32820, 0, 1, 1, 0, 0, 2258.75, -362, 78.608, 2.684, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242965, 32820, 0, 1, 1, 0, 0, 2258.9, 249.927, 41.115, 3.529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242966, 32820, 0, 1, 1, 0, 0, 2259.14, 312.748, 34.701, 0.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242967, 32820, 0, 1, 1, 0, 0, 2259.14, 346.602, 36.018, 6.056, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242968, 32820, 0, 1, 1, 0, 0, 2260.35, 325.859, 35.16, 5.591, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242969, 32820, 0, 1, 1, 0, 0, 2261, 1015.88, 39.699, 2.774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242970, 32820, 0, 1, 1, 0, 0, 2262.08, -721, 67.26, 1.205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242971, 32820, 0, 1, 1, 0, 0, 2262.09, 244.27, 33.634, 3.586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242972, 32820, 0, 1, 1, 0, 0, 2262.99, 1488.16, 33.519, 3.996, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242973, 32820, 0, 1, 1, 0, 0, 2264.45, 251.177, 41.115, 4.974, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242974, 32820, 0, 1, 1, 0, 0, 2264.8, 146.817, 42.451, 2.634, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242975, 32820, 0, 1, 1, 0, 0, 2265.31, 238.893, 34.257, 2.61, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242976, 32820, 0, 1, 1, 0, 0, 2265.82, 333.306, 35.183, 5.779, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242977, 32820, 0, 1, 1, 0, 0, 2266.43, 320.628, 34.316, 5.505, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242978, 32820, 0, 1, 1, 0, 0, 2266.47, 345.762, 36.019, 4.754, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242979, 32820, 0, 1, 1, 0, 0, 2266.67, 1174.01, 34.004, 4.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242980, 32820, 0, 1, 1, 0, 0, 2268.22, 897.28, 46.609, 1.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242981, 32820, 0, 1, 1, 0, 0, 2268.35, -404, 77.129, 3.161, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242982, 32820, 0, 1, 1, 0, 0, 2269.4, 245.072, 34.256, 3.934, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242983, 32820, 0, 1, 1, 0, 0, 2269.52, 280.954, 35.135, 2.893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242984, 32820, 0, 1, 1, 0, 0, 2271.04, 242.997, 41.198, 1.917, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242985, 32820, 0, 1, 1, 0, 0, 2271.33, 1392.69, 33.332, 0.283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242986, 32820, 0, 1, 1, 0, 0, 2271.47, 0, 24.333, 3.697, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242987, 32820, 0, 1, 1, 0, 0, 2271.86, 667.944, 32.413, 0.073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242988, 32820, 0, 1, 1, 0, 0, 2271.97, 289.642, 35.06, 2.905, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242989, 32820, 0, 1, 1, 0, 0, 2273.61, 964.523, 45.992, 0.127, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242990, 32820, 0, 1, 1, 0, 0, 2275.09, -196, 36.918, 5.87, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242991, 32820, 0, 1, 1, 0, 0, 2277.59, -946, 77.799, 2.024, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242992, 32820, 0, 1, 1, 0, 0, 2280.33, 1473.05, 33.332, 2.445, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242993, 32820, 0, 1, 1, 0, 0, 2280.49, 1429.07, 33.332, 3.626, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242994, 32820, 0, 1, 1, 0, 0, 2281.22, -877, 74.515, 5.913, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242995, 32820, 0, 1, 1, 0, 0, 2281.5, 1419.94, 33.333, 3.333, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242996, 32820, 0, 1, 1, 0, 0, 2283.77, 1192.16, 36.171, 0.37, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242997, 32820, 0, 1, 1, 0, 0, 2283.95, 242.051, 41.114, 2.494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242998, 32820, 0, 1, 1, 0, 0, 2284.06, 1386.85, 33.583, 5.228, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(242999, 32820, 0, 1, 1, 0, 0, 2284.94, 56.744, 31.758, 3.478, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243000, 32820, 0, 1, 1, 0, 0, 2284.98, 560.028, 35.597, 1.235, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243001, 32820, 0, 1, 1, 0, 0, 2285.66, -222, 43.143, 0.708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243002, 32820, 0, 1, 1, 0, 0, 2285.93, 597.451, 30.5, 2.537, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243003, 32820, 0, 1, 1, 0, 0, 2286.23, 337.584, 34.228, 3.604, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243004, 32820, 0, 1, 1, 0, 0, 2286.48, -781, 68.963, 0.839, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243005, 32820, 0, 1, 1, 0, 0, 2287.02, 1314.32, 31.399, 5.33, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243006, 32820, 0, 1, 1, 0, 0, 2287.27, 302.189, 35.189, 2.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243007, 32820, 0, 1, 1, 0, 0, 2287.94, 855.278, 39.751, 1.603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243008, 32820, 0, 1, 1, 0, 0, 2288.69, 717.236, 35.489, 1.637, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243009, 32820, 0, 1, 1, 0, 0, 2288.87, 243.432, 27.172, 5.223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243010, 32820, 0, 1, 1, 0, 0, 2288.99, 706.963, 35.832, 6.265, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243011, 32820, 0, 1, 1, 0, 0, 2289.03, 235.309, 27.088, 1.301, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243012, 32820, 0, 1, 1, 0, 0, 2289.26, 391.07, 34.114, 3.156, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243013, 32820, 0, 1, 1, 0, 0, 2289.37, 401.44, 33.95, 3.308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243014, 32820, 0, 1, 1, 0, 0, 2291.09, -1019, 76.653, 5.459, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243015, 32820, 0, 1, 1, 0, 0, 2292.45, 233.122, 27.273, 1.71, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243016, 32820, 0, 1, 1, 0, 0, 2293.34, 423.774, 34.761, 5.638, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243017, 32820, 0, 1, 1, 0, 0, 2294.07, 722.974, 35.609, 5.35, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243018, 32820, 0, 1, 1, 0, 0, 2295.49, 850.026, 40.156, 3.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243019, 32820, 0, 1, 1, 0, 0, 2295.53, 178.992, 35.525, 6.01, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243020, 32820, 0, 1, 1, 0, 0, 2295.68, 246.425, 27.541, 3.589, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243021, 32820, 0, 1, 1, 0, 0, 2296.19, -10, 21.036, 5.255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243022, 32820, 0, 1, 1, 0, 0, 2297.44, 1463.4, 33.333, 1.799, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243023, 32820, 0, 1, 1, 0, 0, 2298.11, 1330.05, 32.604, 4.76, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243024, 32820, 0, 1, 1, 0, 0, 2299.6, 983.578, 49.516, 3.326, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243025, 32820, 0, 1, 1, 0, 0, 2300.05, 555.742, 34.818, 3.778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243026, 32820, 0, 1, 1, 0, 0, 2301.89, 949.822, 56.805, 0.538, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243027, 32820, 0, 1, 1, 0, 0, 2303.09, 1125.23, 34.745, 0.168, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243028, 32820, 0, 1, 1, 0, 0, 2305.5, 715.549, 37.693, 3.289, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243029, 32820, 0, 1, 1, 0, 0, 2305.77, 1477.72, 33.574, 2.863, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243030, 32820, 0, 1, 1, 0, 0, 2307.53, 264.358, 38.67, 1.313, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243031, 32820, 0, 1, 1, 0, 0, 2308.34, 103.228, 38.21, 3.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243032, 32820, 0, 1, 1, 0, 0, 2310.55, 648.208, 31.984, 2.79, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243033, 32820, 0, 1, 1, 0, 0, 2311.93, 1037.26, 43.999, 5.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243034, 32820, 0, 1, 1, 0, 0, 2311.94, -351, 72.51, 3.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243035, 32820, 0, 1, 1, 0, 0, 2313.01, 174.293, 35.217, 0.415, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243036, 32820, 0, 1, 1, 0, 0, 2314.93, 288.278, 37.311, 2.876, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243037, 32820, 0, 1, 1, 0, 0, 2316.19, 1537.13, 34.128, 4.887, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243038, 32820, 0, 1, 1, 0, 0, 2316.75, 1549.7, 33.736, 3.995, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243039, 32820, 0, 1, 1, 0, 0, 2317.02, 1314.35, 32.847, 4.488, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243040, 32820, 0, 1, 1, 0, 0, 2317.38, -194, 36.857, 5.514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243041, 32820, 0, 1, 1, 0, 0, 2317.61, 563.985, 26.07, 3.317, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243042, 32820, 0, 1, 1, 0, 0, 2318.22, -176, 32.414, 0.941, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243043, 32820, 0, 1, 1, 0, 0, 2319.53, 1098.57, 37.407, 1.036, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243044, 32820, 0, 1, 1, 0, 0, 2320.4, -255, 47.498, 3.949, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243045, 32820, 0, 1, 1, 0, 0, 2320.82, 653.608, 31.56, 5.556, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243046, 32820, 0, 1, 1, 0, 0, 2322.08, -378, 71.204, 2.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243047, 32820, 0, 1, 1, 0, 0, 2322.2, 332.751, 36.502, 4.385, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243048, 32820, 0, 1, 1, 0, 0, 2323.16, 1482.42, 33.574, 1.884, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243049, 32820, 0, 1, 1, 0, 0, 2323.53, 1004.91, 51.782, 2.099, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243050, 32820, 0, 1, 1, 0, 0, 2324.44, 622.718, 33.868, 3.246, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243051, 32820, 0, 1, 1, 0, 0, 2325.31, -667, 69.304, 0.387, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243052, 32820, 0, 1, 1, 0, 0, 2327.63, 114.74, 36.88, 3.775, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243053, 32820, 0, 1, 1, 0, 0, 2327.67, -206, 38.609, 6.026, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243054, 32820, 0, 1, 1, 0, 0, 2327.82, 693.471, 39.356, 1.926, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243055, 32820, 0, 1, 1, 0, 0, 2328.58, 774.542, 33.337, 5.827, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243056, 32820, 0, 1, 1, 0, 0, 2330.09, 243.529, 28.61, 5.202, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243057, 32820, 0, 1, 1, 0, 0, 2331.17, 1391.91, 33.333, 3.749, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243058, 32820, 0, 1, 1, 0, 0, 2331.26, 1693.33, 46.975, 2.969, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243059, 32820, 0, 1, 1, 0, 0, 2332.93, 933.291, 61.245, 0.091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243060, 32820, 0, 1, 1, 0, 0, 2334.68, 115.599, 36.568, 5.198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243061, 32820, 0, 1, 1, 0, 0, 2340.05, 1015.01, 51.349, 1.017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243062, 32820, 0, 1, 1, 0, 0, 2340.52, 763.396, 34.971, 4.497, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243063, 32820, 0, 1, 1, 0, 0, 2340.65, 732.441, 36.408, 2.016, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243064, 32820, 0, 1, 1, 0, 0, 2341.36, 178.039, 38.336, 6.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243065, 32820, 0, 1, 1, 0, 0, 2341.99, -226, 41.779, 3.074, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243066, 32820, 0, 1, 1, 0, 0, 2342.92, 1314.31, 34.119, 3.194, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243067, 32820, 0, 1, 1, 0, 0, 2343.9, 595.659, 34.857, 0.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243068, 32820, 0, 1, 1, 0, 0, 2344.03, 265.531, 34.206, 0.211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243069, 32820, 0, 1, 1, 0, 0, 2344.56, 894.859, 57.8, 5.072, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243070, 32820, 0, 1, 1, 0, 0, 2345.99, 1129.3, 41.876, 1.589, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243071, 32820, 0, 1, 1, 0, 0, 2346.36, 50.501, 27.321, 5.781, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243072, 32820, 0, 1, 1, 0, 0, 2348.1, 1384.92, 33.528, 0.728, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243073, 32820, 0, 1, 1, 0, 0, 2348.53, 176.39, 37.435, 2.873, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243074, 32820, 0, 1, 1, 0, 0, 2348.58, 492.862, 33.358, 4.879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243075, 32820, 0, 1, 1, 0, 0, 2349.34, -910, 71.468, 1.993, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243076, 32820, 0, 1, 1, 0, 0, 2349.95, 1291.15, 33.534, 1.661, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243077, 32820, 0, 1, 1, 0, 0, 2350.06, 679.128, 35.492, 2.183, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243078, 32820, 0, 1, 1, 0, 0, 2350.12, 609.547, 35.335, 1.012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243079, 32820, 0, 1, 1, 0, 0, 2350.54, 1469.74, 33.332, 3.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243080, 32820, 0, 1, 1, 0, 0, 2350.96, -256, 42.913, 5.774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243081, 32820, 0, 1, 1, 0, 0, 2351.02, -1050, 83.63, 5.796, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243082, 32820, 0, 1, 1, 0, 0, 2351.05, 649.239, 33.729, 5.742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243083, 32820, 0, 1, 1, 0, 0, 2351.5, 81.281, 28.505, 1.363, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243084, 32820, 0, 1, 1, 0, 0, 2352.98, -160, 28.558, 2.635, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243085, 32820, 0, 1, 1, 0, 0, 2354.14, 1367.2, 33.332, 5.345, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243086, 32820, 0, 1, 1, 0, 0, 2354.38, 329.058, 37.779, 4.064, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243087, 32820, 0, 1, 1, 0, 0, 2354.99, 866.681, 54.057, 1.686, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243088, 32820, 0, 1, 1, 0, 0, 2355.48, 251.407, 28.57, 4.943, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243089, 32820, 0, 1, 1, 0, 0, 2356.2, 1173.56, 37.18, 0.307, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243090, 32820, 0, 1, 1, 0, 0, 2356.43, 672.208, 34.242, 0.826, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243091, 32820, 0, 1, 1, 0, 0, 2356.71, 1288.87, 32.962, 5.288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243092, 32820, 0, 1, 1, 0, 0, 2360.86, 877.532, 57.312, 6.185, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243093, 32820, 0, 1, 1, 0, 0, 2361.41, 425.175, 33.552, 1.843, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243094, 32820, 0, 1, 1, 0, 0, 2361.42, 1313.94, 33.537, 6.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243095, 32820, 0, 1, 1, 0, 0, 2363.14, 1650.9, 33.881, 0.542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243096, 32820, 0, 1, 1, 0, 0, 2363.58, 1215.44, 34.043, 1.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243097, 32820, 0, 1, 1, 0, 0, 2364.95, 294.312, 34.916, 0.113, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243098, 32820, 0, 1, 1, 0, 0, 2365.96, -581, 75.685, 0.85, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243099, 32820, 0, 1, 1, 0, 0, 2370.9, -442, 76.593, 6.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243100, 32820, 0, 1, 1, 0, 0, 2371.08, 204.149, 35.612, 1.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243101, 32820, 0, 1, 1, 0, 0, 2372.24, -834, 71.854, 5.471, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243102, 32820, 0, 1, 1, 0, 0, 2372.64, 334.076, 38.745, 0.673, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243103, 32820, 0, 1, 1, 0, 0, 2373.57, 1543.44, 34.328, 0.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243104, 32820, 0, 1, 1, 0, 0, 2374.06, 1284.32, 31.413, 4.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243105, 32820, 0, 1, 1, 0, 0, 2374.97, 580.367, 33.505, 4.767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243106, 32820, 0, 1, 1, 0, 0, 2375.43, 1098.79, 43.639, 5.316, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243107, 32820, 0, 1, 1, 0, 0, 2376.34, 1493.49, 34.884, 5.341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243108, 32820, 0, 1, 1, 0, 0, 2377, 1017.97, 54.718, 3.905, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243109, 32820, 0, 1, 1, 0, 0, 2377.16, 111.89, 27.662, 4.962, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243110, 32820, 0, 1, 1, 0, 0, 2377.67, -594, 72.983, 1.424, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243111, 32820, 0, 1, 1, 0, 0, 2377.8, 747.063, 34.106, 4.872, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243112, 32820, 0, 1, 1, 0, 0, 2377.98, 137.006, 31.717, 3.492, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243113, 32820, 0, 1, 1, 0, 0, 2378.88, -572, 74.79, 2.643, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243114, 32820, 0, 1, 1, 0, 0, 2379.37, 1877.52, 0.848, 4.616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243115, 32820, 0, 1, 1, 0, 0, 2379.44, 1017.43, 55.545, 0.852, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243116, 32820, 0, 1, 1, 0, 0, 2382.23, 636.662, 30.31, 0.463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243117, 32820, 0, 1, 1, 0, 0, 2382.42, -935, 67.969, 2.253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243118, 32820, 0, 1, 1, 0, 0, 2383.29, 1106.76, 46.027, 6.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243119, 32820, 0, 1, 1, 0, 0, 2384.88, 1051.42, 56.973, 4.909, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243120, 32820, 0, 1, 1, 0, 0, 2386.36, -1050, 85.605, 3.171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243121, 32820, 0, 1, 1, 0, 0, 2387.03, 204.682, 35.487, 5.981, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243122, 32820, 0, 1, 1, 0, 0, 2387.31, -627, 70.923, 4.593, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243123, 32820, 0, 1, 1, 0, 0, 2387.66, -447, 74.785, 4.973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243124, 32820, 0, 1, 1, 0, 0, 2388.53, -448, 75.259, 3.57, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243125, 32820, 0, 1, 1, 0, 0, 2388.84, -373, 68.993, 3.957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243126, 32820, 0, 1, 1, 0, 0, 2389.22, -932, 68.069, 1.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243127, 32820, 0, 1, 1, 0, 0, 2389.34, 1440.19, 34.403, 2.12, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243128, 32820, 0, 1, 1, 0, 0, 2390.27, 336.502, 40.016, 2.271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243129, 32820, 0, 1, 1, 0, 0, 2394.46, -291, 55.946, 0.978, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243130, 32820, 0, 1, 1, 0, 0, 2395.9, -592, 71.83, 0.24, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243131, 32820, 0, 1, 1, 0, 0, 2396.11, 1262.56, 36.633, 5.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243132, 32820, 0, 1, 1, 0, 0, 2396.53, 870.308, 64.018, 0.119, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243133, 32820, 0, 1, 1, 0, 0, 2398.11, 1026.08, 61.023, 3.502, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243134, 32820, 0, 1, 1, 0, 0, 2398.29, 1596.08, 33.56, 4.911, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243135, 32820, 0, 1, 1, 0, 0, 2401.57, 1406.94, 32.985, 2.087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243136, 32820, 0, 1, 1, 0, 0, 2402.73, 1124.35, 50.437, 3.04, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243137, 32820, 0, 1, 1, 0, 0, 2403.28, 227.164, 34.464, 1.926, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243138, 32820, 0, 1, 1, 0, 0, 2403.65, 1105.96, 52.947, 6.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243139, 32820, 0, 1, 1, 0, 0, 2403.79, 675.319, 34.263, 2.516, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243140, 32820, 0, 1, 1, 0, 0, 2405.23, 1285.12, 31.2, 4.19, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243141, 32820, 0, 1, 1, 0, 0, 2405.36, -734, 73.272, 2.557, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243142, 32820, 0, 1, 1, 0, 0, 2406.45, -1035, 85.414, 0.457, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243143, 32820, 0, 1, 1, 0, 0, 2406.7, 795.103, 41.574, 4.812, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243144, 32820, 0, 1, 1, 0, 0, 2408.2, 687.692, 33.231, 2.845, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243145, 32820, 0, 1, 1, 0, 0, 2409.2, 1381.42, 36.009, 6.158, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243146, 32820, 0, 1, 1, 0, 0, 2409.28, 1889.54, 11.37, 5.307, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243147, 32820, 0, 1, 1, 0, 0, 2410.23, -241, 45.519, 1.328, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243148, 32820, 0, 1, 1, 0, 0, 2410.56, 1583.85, 32.966, 3.664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243149, 32820, 0, 1, 1, 0, 0, 2410.67, 612.571, 30.944, 3.927, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243150, 32820, 0, 1, 1, 0, 0, 2411.49, 653.125, 31.986, 2.168, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243151, 32820, 0, 1, 1, 0, 0, 2411.89, 1399.55, 33.384, 0.56, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243152, 32820, 0, 1, 1, 0, 0, 2412.98, 745.356, 41.134, 0.099, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243153, 32820, 0, 1, 1, 0, 0, 2413.26, -277, 59.124, 5.309, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243154, 32820, 0, 1, 1, 0, 0, 2413.61, 1520.4, 34.687, 2.74, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243155, 32820, 0, 1, 1, 0, 0, 2414.1, 1303.18, 30.4, 1.796, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243156, 32820, 0, 1, 1, 0, 0, 2416.16, 1335.9, 33.074, 3.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243157, 32820, 0, 1, 1, 0, 0, 2416.42, 195.813, 31.897, 4.942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243158, 32820, 0, 1, 1, 0, 0, 2417.2, -275, 59.469, 2.832, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243159, 32820, 0, 1, 1, 0, 0, 2417.36, 1214.98, 43.743, 3.638, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243160, 32820, 0, 1, 1, 0, 0, 2417.91, -742, 70.812, 0.802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243161, 32820, 0, 1, 1, 0, 0, 2418, -479, 74.076, 4.456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243162, 32820, 0, 1, 1, 0, 0, 2419.78, 1567.44, 32.97, 3.735, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243163, 32820, 0, 1, 1, 0, 0, 2421.85, 190.064, 32.594, 3.308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243164, 32820, 0, 1, 1, 0, 0, 2422.22, 297.866, 35.91, 3.53, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243165, 32820, 0, 1, 1, 0, 0, 2424.05, 148.275, 31.336, 2.675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243166, 32820, 0, 1, 1, 0, 0, 2425.21, -651, 72.322, 4.155, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243167, 32820, 0, 1, 1, 0, 0, 2425.83, 218.091, 36.324, 2.626, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243168, 32820, 0, 1, 1, 0, 0, 2429.17, 1531.98, 35.504, 2.935, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243169, 32820, 0, 1, 1, 0, 0, 2429.26, 889.561, 72.831, 4.188, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243170, 32820, 0, 1, 1, 0, 0, 2432.26, 738.563, 40.884, 5.255, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243171, 32820, 0, 1, 1, 0, 0, 2432.8, 772.851, 43.749, 0.52, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243172, 32820, 0, 1, 1, 0, 0, 2433.11, 978.304, 68.19, 1.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243173, 32820, 0, 1, 1, 0, 0, 2434.17, 608.949, 31.609, 3.929, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243174, 32820, 0, 1, 1, 0, 0, 2434.33, -404, 68.323, 1.155, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243175, 32820, 0, 1, 1, 0, 0, 2435.63, 1777.61, 29.416, 4.681, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243176, 32820, 0, 1, 1, 0, 0, 2436.55, -192, 33.496, 0.211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243177, 32820, 0, 1, 1, 0, 0, 2438.41, 1599.72, 50.777, 5.947, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243178, 32820, 0, 1, 1, 0, 0, 2438.83, 875.833, 74.285, 3.298, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243179, 32820, 0, 1, 1, 0, 0, 2439.32, -400, 68.798, 2.566, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243180, 32820, 0, 1, 1, 0, 0, 2439.4, -684, 72.739, 3.02, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243181, 32820, 0, 1, 1, 0, 0, 2440.72, 486.974, 44.588, 4.485, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243182, 32820, 0, 1, 1, 0, 0, 2441.02, 1589.64, 72.156, 4.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243183, 32820, 0, 1, 1, 0, 0, 2441.18, 360.312, 32.705, 5.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243184, 32820, 0, 1, 1, 0, 0, 2441.91, 763.84, 46.683, 5.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243185, 32820, 0, 1, 1, 0, 0, 2441.93, 1472.27, 32.176, 4.253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243186, 32820, 0, 1, 1, 0, 0, 2442.47, 1333.02, 27.135, 2.692, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243187, 32820, 0, 1, 1, 0, 0, 2442.5, 226.8, 41.196, 0.172, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243188, 32820, 0, 1, 1, 0, 0, 2442.64, -543, 71.297, 3.584, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243189, 32820, 0, 1, 1, 0, 0, 2442.75, -656, 71.741, 2.654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243190, 32820, 0, 1, 1, 0, 0, 2442.84, -611, 70.441, 3.285, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243191, 32820, 0, 1, 1, 0, 0, 2444.13, 1599.84, 66.573, 3.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243192, 32820, 0, 1, 1, 0, 0, 2447.07, 797.919, 48.376, 5.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243193, 32820, 0, 1, 1, 0, 0, 2447.11, 1584.32, 44.952, 1.498, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243194, 32820, 0, 1, 1, 0, 0, 2447.51, -326, 68.49, 0.001, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243195, 32820, 0, 1, 1, 0, 0, 2448.66, 473.064, 44.351, 4.494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243196, 32820, 0, 1, 1, 0, 0, 2448.74, 438.474, 37.248, 0.923, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243197, 32820, 0, 1, 1, 0, 0, 2448.81, -473, 76.137, 4.731, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243198, 32820, 0, 1, 1, 0, 0, 2449.55, 1586.94, 61.069, 1.798, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243199, 32820, 0, 1, 1, 0, 0, 2450.12, 468.537, 43.871, 2.586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243200, 32820, 0, 1, 1, 0, 0, 2450.14, 1596.42, 37.069, 3.452, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243201, 32820, 0, 1, 1, 0, 0, 2451.87, 939.724, 75.693, 4.989, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243202, 32820, 0, 1, 1, 0, 0, 2452.02, 400.364, 35.155, 1.552, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243203, 32820, 0, 1, 1, 0, 0, 2453.19, 1600.67, 72.156, 0.612, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243204, 32820, 0, 1, 1, 0, 0, 2453.67, 1085.37, 61.041, 0.916, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243205, 32820, 0, 1, 1, 0, 0, 2456.21, 1600.09, 56.384, 3.744, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243206, 32820, 0, 1, 1, 0, 0, 2457.74, -961, 73.592, 4.799, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243207, 32820, 0, 1, 1, 0, 0, 2460.72, -843, 59.263, 3.194, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243208, 32820, 0, 1, 1, 0, 0, 2460.77, 1715.16, 24.784, 0.707, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243209, 32820, 0, 1, 1, 0, 0, 2461.74, 1389.54, 24.402, 5.66, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243210, 32820, 0, 1, 1, 0, 0, 2463.91, -832, 61.865, 2.465, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243211, 32820, 0, 1, 1, 0, 0, 2464.89, 240.908, 44.565, 2.955, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243212, 32820, 0, 1, 1, 0, 0, 2468.9, -534, 73.361, 0.95, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243213, 32820, 0, 1, 1, 0, 0, 2468.97, 694.866, 45.229, 1.525, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243214, 32820, 0, 1, 1, 0, 0, 2469.59, 678.841, 41.703, 4.656, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243215, 32820, 0, 1, 1, 0, 0, 2469.93, -414, 76.909, 4.781, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243216, 32820, 0, 1, 1, 0, 0, 2470.08, -764, 66.258, 5.086, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243217, 32820, 0, 1, 1, 0, 0, 2470.76, 1133.18, 62.891, 4.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243218, 32820, 0, 1, 1, 0, 0, 2472.49, -660, 71.856, 2.738, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243219, 32820, 0, 1, 1, 0, 0, 2474.11, 136.395, 30.48, 2.844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243220, 32820, 0, 1, 1, 0, 0, 2474.74, 17.994, 24.719, 3.621, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243221, 32820, 0, 1, 1, 0, 0, 2478.08, 670.223, 43.878, 4.858, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243222, 32820, 0, 1, 1, 0, 0, 2478.1, 988.421, 70.941, 2.216, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243223, 32820, 0, 1, 1, 0, 0, 2478.76, -586, 72.697, 3.975, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243224, 32820, 0, 1, 1, 0, 0, 2481.06, -279, 49.659, 2.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243225, 32820, 0, 1, 1, 0, 0, 2481.38, 1649.24, 15.072, 3.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243226, 32820, 0, 1, 1, 0, 0, 2481.47, -221, 31.593, 2.759, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243227, 32820, 0, 1, 1, 0, 0, 2481.59, 1653.69, 14.068, 3.26, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243228, 32820, 0, 1, 1, 0, 0, 2482.21, 1328.45, 25.967, 3.804, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243229, 32820, 0, 1, 1, 0, 0, 2483.31, 1008, 71.644, 3.179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243230, 32820, 0, 1, 1, 0, 0, 2483.98, -342, 73.162, 0.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243231, 32820, 0, 1, 1, 0, 0, 2484.06, 27.081, 25.565, 1.039, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243232, 32820, 0, 1, 1, 0, 0, 2485.9, 150.755, 29.072, 2.887, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243233, 32820, 0, 1, 1, 0, 0, 2487.11, 1442.07, 8.595, 4.038, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243234, 32820, 0, 1, 1, 0, 0, 2487.39, 1243.5, 46.953, 2.747, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243235, 32820, 0, 1, 1, 0, 0, 2487.97, 1419.32, 7.593, 4.576, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243236, 32820, 0, 1, 1, 0, 0, 2490.63, 1072.42, 73.45, 3.498, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243237, 32820, 0, 1, 1, 0, 0, 2492.37, 127.447, 29.059, 3.712, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243238, 32820, 0, 1, 1, 0, 0, 2492.59, 1112.71, 69.615, 3.005, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243239, 32820, 0, 1, 1, 0, 0, 2492.84, 646.658, 32.245, 2.232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243240, 32820, 0, 1, 1, 0, 0, 2493.48, 785.188, 120.149, 1.976, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243241, 32820, 0, 1, 1, 0, 0, 2493.81, 1394.65, 6.509, 2.05, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243242, 32820, 0, 1, 1, 0, 0, 2494.57, 1673.4, 10.128, 2.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243243, 32820, 0, 1, 1, 0, 0, 2494.93, 1669.37, 8.719, 5.881, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243244, 32820, 0, 1, 1, 0, 0, 2497.9, 364.587, 35.105, 0.979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243245, 32820, 0, 1, 1, 0, 0, 2499.18, 348.946, 34.077, 1.87, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243246, 32820, 0, 1, 1, 0, 0, 2500.01, 1137.44, 67.536, 3.6, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243247, 32820, 0, 1, 1, 0, 0, 2503.03, 868.549, 85.899, 1.18, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243248, 32820, 0, 1, 1, 0, 0, 2503.29, 978.85, 80.657, 4.556, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243249, 32820, 0, 1, 1, 0, 0, 2505.76, 458.109, 36.993, 0.063, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243250, 32820, 0, 1, 1, 0, 0, 2507.29, 388.541, 34.313, 3.383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243251, 32820, 0, 1, 1, 0, 0, 2511.19, -536, 87.971, 0.224, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243252, 32820, 0, 1, 1, 0, 0, 2512.91, -37, 26.205, 1.418, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243253, 32820, 0, 1, 1, 0, 0, 2513.44, 289.726, 44.531, 0.773, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243254, 32820, 0, 1, 1, 0, 0, 2513.47, 243.981, 48.784, 2.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243255, 32820, 0, 1, 1, 0, 0, 2514.11, -675, 71.4, 0.648, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243256, 32820, 0, 1, 1, 0, 0, 2514.84, 1344.22, 21.131, 3.802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243257, 32820, 0, 1, 1, 0, 0, 2517.36, 789.009, 110.905, 4.528, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243258, 32820, 0, 1, 1, 0, 0, 2517.52, 226.214, 44.075, 5.972, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243259, 32820, 0, 1, 1, 0, 0, 2518.14, -245, 34.107, 2.611, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243260, 32820, 0, 1, 1, 0, 0, 2518.76, 1609.94, -3, 4.409, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243261, 32820, 0, 1, 1, 0, 0, 2520.1, 1497.1, 0.191, 1.595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243262, 32820, 0, 1, 1, 0, 0, 2521.87, -850, 58.087, 5.361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243263, 32820, 0, 1, 1, 0, 0, 2523.5, 945.028, 90.841, 3.182, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243264, 32820, 0, 1, 1, 0, 0, 2523.72, 1421.92, 1.661, 2.047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243265, 32820, 0, 1, 1, 0, 0, 2523.8, 1047.83, 81.655, 3.009, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243266, 32820, 0, 1, 1, 0, 0, 2524.32, 1174.54, 69.023, 6.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243267, 32820, 0, 1, 1, 0, 0, 2524.39, 1290.53, 40.599, 2.301, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243268, 32820, 0, 1, 1, 0, 0, 2524.56, 385.299, 34.712, 3.378, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243269, 32820, 0, 1, 1, 0, 0, 2528.36, -905, 57.091, 1.203, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243270, 32820, 0, 1, 1, 0, 0, 2528.93, 293.153, 42.922, 3.196, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243271, 32820, 0, 1, 1, 0, 0, 2531.76, -899, 56.364, 1.546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243272, 32820, 0, 1, 1, 0, 0, 2532.49, -892, 55.919, 4.546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243273, 32820, 0, 1, 1, 0, 0, 2532.96, -726, 62.975, 6.229, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243274, 32820, 0, 1, 1, 0, 0, 2533.1, 1390.19, 4.32, 4.062, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243275, 32820, 0, 1, 1, 0, 0, 2533.89, 543.76, 15.734, 0.35, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243276, 32820, 0, 1, 1, 0, 0, 2533.9, 956.824, 92.354, 2.725, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243277, 32820, 0, 1, 1, 0, 0, 2536.84, 1284.58, 44.213, 4.287, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243278, 32820, 0, 1, 1, 0, 0, 2536.85, -61, 29.111, 5.919, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243279, 32820, 0, 1, 1, 0, 0, 2536.85, 769.594, 110.986, 5.986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243280, 32820, 0, 1, 1, 0, 0, 2538.43, 279.164, 47.359, 4.017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243281, 32820, 0, 1, 1, 0, 0, 2538.94, 547.931, 15.817, 3.534, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243282, 32820, 0, 1, 1, 0, 0, -9327.6, 178.975, 61.6973, 4.10484, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243283, 32820, 0, 1, 1, 0, 0, 2540.4, -1041, 98.397, 4.767, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243284, 32820, 0, 1, 1, 0, 0, 2541.16, 763.772, 110.81, 0.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243285, 32820, 0, 1, 1, 0, 0, 2543.3, 979.199, 89.469, 3.708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243286, 32820, 0, 1, 1, 0, 0, 2543.48, -22, 28.248, 5.313, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243287, 32820, 0, 1, 1, 0, 0, 2544.24, 173.075, 35.024, 5.433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243288, 32820, 0, 1, 1, 0, 0, 2544.83, 1050.89, 85.722, 0.247, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243289, 32820, 0, 1, 1, 0, 0, 2545.18, 1462.11, -5, 0.007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243290, 32820, 0, 1, 1, 0, 0, 2545.58, 293.867, 42.537, 1.439, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243291, 32820, 0, 1, 1, 0, 0, 2545.93, 1166.3, 73.116, 2.195, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243292, 32820, 0, 1, 1, 0, 0, 2546.21, 947.298, 93.246, 4.243, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243293, 32820, 0, 1, 1, 0, 0, 2547.36, -626, 81.138, 3.999, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243294, 32820, 0, 1, 1, 0, 0, 2547.51, -269, 46.196, 4.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243295, 32820, 0, 1, 1, 0, 0, 2548.62, -899, 56.71, 2.666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243296, 32820, 0, 1, 1, 0, 0, 2549, -104, 24.141, 3.394, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243297, 32820, 0, 1, 1, 0, 0, 2549.66, 816.335, 109.295, 5.37, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243298, 32820, 0, 1, 1, 0, 0, 2549.94, 404.449, 31.932, 3.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243299, 32820, 0, 1, 1, 0, 0, 2550.7, 386.404, 33.878, 6.21, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243300, 32820, 0, 1, 1, 0, 0, 2551.59, 878.635, 91.77, 5.735, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243301, 32820, 0, 1, 1, 0, 0, 2552.27, 1122.7, 82.146, 1.677, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243302, 32820, 0, 1, 1, 0, 0, 2552.46, -275, 48.48, 0.503, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243303, 32820, 0, 1, 1, 0, 0, 2552.9, 121.243, 29.951, 5.989, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243304, 32820, 0, 1, 1, 0, 0, 2552.97, 236.42, 47.253, 4.223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243305, 32820, 0, 1, 1, 0, 0, 2556.54, 1066.15, 85.343, 3.776, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243306, 32820, 0, 1, 1, 0, 0, 2557.17, -892, 56.093, 3.269, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243307, 32820, 0, 1, 1, 0, 0, 2557.55, -690, 67.732, 3.509, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243308, 32820, 0, 1, 1, 0, 0, 2558.34, 188.341, 35.937, 4.756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243309, 32820, 0, 1, 1, 0, 0, 2558.63, 919.597, 95.841, 5.446, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243310, 32820, 0, 1, 1, 0, 0, 2558.88, 1393.52, 3.939, 3.53, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243311, 32820, 0, 1, 1, 0, 0, 2559.27, 1388.1, 4.529, 3.079, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243312, 32820, 0, 1, 1, 0, 0, 2560.17, 165.253, 32.245, 6.157, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243313, 32820, 0, 1, 1, 0, 0, 2561.77, 391.63, 32.895, 2.354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243314, 32820, 0, 1, 1, 0, 0, 2562.53, 414.495, 28.078, 4.206, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243315, 32820, 0, 1, 1, 0, 0, 2563.32, -13, 27.873, 5.002, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243316, 32820, 0, 1, 1, 0, 0, 2563.46, 807.718, 108.717, 0.277, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243317, 32820, 0, 1, 1, 0, 0, 2563.7, 1204.8, 67.354, 3.764, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243318, 32820, 0, 1, 1, 0, 0, 2564.08, 1108.73, 85.43, 5.738, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243319, 32820, 0, 1, 1, 0, 0, 2566.08, -748, 65.709, 4.607, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243320, 32820, 0, 1, 1, 0, 0, 2566.2, -770, 65.17, 1.883, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243321, 32820, 0, 1, 1, 0, 0, 2566.91, 1238.9, 63.893, 5.629, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243322, 32820, 0, 1, 1, 0, 0, 2567.96, -298, 62.694, 1.472, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243323, 32820, 0, 1, 1, 0, 0, 2569.49, -26, 30.197, 0.603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243324, 32820, 0, 1, 1, 0, 0, 2571.24, 538.871, 15.381, 5.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243325, 32820, 0, 1, 1, 0, 0, 2571.73, 1374.47, 10.336, 2.341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243326, 32820, 0, 1, 1, 0, 0, 2572.32, -50, 33.493, 3.851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243327, 32820, 0, 1, 1, 0, 0, 2573.81, -977, 78.49, 5.886, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243328, 32820, 0, 1, 1, 0, 0, 2574.67, 840.848, 100.144, 3.899, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243329, 32820, 0, 1, 1, 0, 0, 2576.12, 885.095, 100.947, 2.425, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243330, 32820, 0, 1, 1, 0, 0, 2576.19, 1004.2, 94.243, 4.529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243331, 32820, 0, 1, 1, 0, 0, 2576.21, 290.176, 47.016, 2.896, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243332, 32820, 0, 1, 1, 0, 0, 2576.22, -976, 78.337, 5.819, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243333, 32820, 0, 1, 1, 0, 0, 2577.17, 981.727, 98.292, 0.805, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243334, 32820, 0, 1, 1, 0, 0, 2578.07, -1024, 94.786, 3.179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243335, 32820, 0, 1, 1, 0, 0, 2578.28, 572.019, 14.308, 0.791, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243336, 32820, 0, 1, 1, 0, 0, 2578.41, 918.022, 104.599, 3.372, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243337, 32820, 0, 1, 1, 0, 0, 2580.07, -107, 30.212, 1.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243338, 32820, 0, 1, 1, 0, 0, 2580.33, 154.82, 33.075, 4.111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243339, 32820, 0, 1, 1, 0, 0, 2582.18, -723, 69.794, 3.713, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243340, 32820, 0, 1, 1, 0, 0, 2583.98, -54, 31.023, 1.123, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243341, 32820, 0, 1, 1, 0, 0, 2585.77, 854.39, 99.341, 1.582, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243342, 32820, 0, 1, 1, 0, 0, 2588.44, -956, 76.685, 5.424, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243343, 32820, 0, 1, 1, 0, 0, 2589.61, -118, 31.162, 5.597, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243344, 32820, 0, 1, 1, 0, 0, 2591.06, 1019.88, 99.046, 0.34, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243345, 32820, 0, 1, 1, 0, 0, 2593.26, 136.157, 30.133, 4.803, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243346, 32820, 0, 1, 1, 0, 0, 2594.13, 1687.93, -1, 3.606, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243347, 32820, 0, 1, 1, 0, 0, 2594.44, 246.63, 41.364, 5.094, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243348, 32820, 0, 1, 1, 0, 0, 2597.33, 1385.28, 1.157, 5.836, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243349, 32820, 0, 1, 1, 0, 0, 2599.74, 1284.34, 51.977, 6.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243350, 32820, 0, 1, 1, 0, 0, 2600.66, -690, 78.686, 6.225, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243351, 32820, 0, 1, 1, 0, 0, 2601.85, 520.278, 17.73, 3.256, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243352, 32820, 0, 1, 1, 0, 0, 2603.09, -535, 89, 5.596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243353, 32820, 0, 1, 1, 0, 0, 2606.83, 235.35, 37.201, 0.492, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243354, 32820, 0, 1, 1, 0, 0, 2606.87, -781, 74.363, 3.376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243355, 32820, 0, 1, 1, 0, 0, 2611.07, -913, 60.155, 0.057, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243356, 32820, 0, 1, 1, 0, 0, 2611.5, 463.978, 22.947, 2.03, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243357, 32820, 0, 1, 1, 0, 0, 2613.55, 133.443, 30.158, 2.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243358, 32820, 0, 1, 1, 0, 0, 2613.68, 1098.27, 93.415, 4.322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243359, 32820, 0, 1, 1, 0, 0, 2613.99, 1124.28, 90.504, 0.247, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243360, 32820, 0, 1, 1, 0, 0, 2617.13, 313.391, 37.435, 5.833, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243361, 32820, 0, 1, 1, 0, 0, 2620.38, 883.914, 111.555, 0.524, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243362, 32820, 0, 1, 1, 0, 0, 2623.53, 1040.28, 99.36, 6.136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243363, 32820, 0, 1, 1, 0, 0, 2624.08, 239.211, 34.552, 3.577, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243364, 32820, 0, 1, 1, 0, 0, 2624.32, 406.3, 36.144, 0.357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243365, 32820, 0, 1, 1, 0, 0, 2624.68, -824, 71.093, 1.271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243366, 32820, 0, 1, 1, 0, 0, 2625.31, 462.516, 21.719, 3.28319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243367, 32820, 0, 1, 1, 0, 0, 2625.58, 1291.88, 47.811, 5.974, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243368, 32820, 0, 1, 1, 0, 0, 2626.29, -823, 70.467, 5.276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243369, 32820, 0, 1, 1, 0, 0, 2627.41, -323, 86.15, 3.227, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243370, 32820, 0, 1, 1, 0, 0, 2630.11, 980.202, 109.971, 2.083, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243371, 32820, 0, 1, 1, 0, 0, 2631, 60.832, 28.403, 0.685, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243372, 32820, 0, 1, 1, 0, 0, 2632.86, 388.887, 35.111, 2.082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243373, 32820, 0, 1, 1, 0, 0, 2634.35, -1071, 108.356, 4.795, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243374, 32820, 0, 1, 1, 0, 0, 2635.33, 51.674, 28.114, 5.333, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243375, 32820, 0, 1, 1, 0, 0, 2636.46, 144.211, 32.506, 0.82, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243376, 32820, 0, 1, 1, 0, 0, 2636.98, 1049.48, 103.165, 3.109, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243377, 32820, 0, 1, 1, 0, 0, 2637.98, 1191.98, 79.642, 3.719, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243378, 32820, 0, 1, 1, 0, 0, 2638.66, 892.341, 112.888, 0.664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243379, 32820, 0, 1, 1, 0, 0, 2639.2, 254.461, 34.408, 1.233, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243380, 32820, 0, 1, 1, 0, 0, 2640.71, 1210.13, 70.931, 1.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243381, 32820, 0, 1, 1, 0, 0, 2641.28, -4015, 106.292, 6.239, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243382, 32820, 0, 1, 1, 0, 0, 2641.52, 1067.63, 102.771, 2.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243383, 32820, 0, 1, 1, 0, 0, 2641.83, 1368.93, 2.269, 5.923, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243384, 32820, 0, 1, 1, 0, 0, 2643.22, 337.924, 28.726, 3.94, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243385, 32820, 0, 1, 1, 0, 0, 2644.96, 180.961, 29.834, 2.608, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243386, 32820, 0, 1, 1, 0, 0, 2645.24, 1061.54, 104.29, 1.755, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243387, 32820, 0, 1, 1, 0, 0, 2646.01, 404.876, 31.007, 5.402, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243388, 32820, 0, 1, 1, 0, 0, 2646.92, -626, 106.988, 5.102, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243389, 32820, 0, 1, 1, 0, 0, 2647.27, 1153.66, 85.855, 5.867, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243390, 32820, 0, 1, 1, 0, 0, 2648.11, -892, 65.367, 3.03, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243391, 32820, 0, 1, 1, 0, 0, 2649.44, 218.311, 32.536, 1.33, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243392, 32820, 0, 1, 1, 0, 0, 2650.44, 351.058, 28.934, 0.89, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243393, 32820, 0, 1, 1, 0, 0, 2655.85, 1314.34, 41.119, 5.317, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243394, 32820, 0, 1, 1, 0, 0, 2656.03, 950.07, 113.864, 0.646, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243395, 32820, 0, 1, 1, 0, 0, 2656.3, 533.697, 15.485, 1.331, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243396, 32820, 0, 1, 1, 0, 0, 2657.29, -885, 68.351, 2.818, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243397, 32820, 0, 1, 1, 0, 0, 2659.79, 362.477, 28.379, 1, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243398, 32820, 0, 1, 1, 0, 0, 2660.56, 847.725, 109.709, 5.826, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243399, 32820, 0, 1, 1, 0, 0, 2667.88, 127.652, 32.426, 3.257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243400, 32820, 0, 1, 1, 0, 0, 2672.69, -887, 71.183, 2.83, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243401, 32820, 0, 1, 1, 0, 0, 2673.69, 256.889, 31.865, 3.889, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243402, 32820, 0, 1, 1, 0, 0, 2678.87, 311.54, 31.12, 4.258, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243403, 32820, 0, 1, 1, 0, 0, 2679.21, 1013.13, 108.381, 4.384, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243404, 32820, 0, 1, 1, 0, 0, 2679.77, 1032.67, 108.821, 5.304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243405, 32820, 0, 1, 1, 0, 0, 2680.93, 812.035, 109.282, 3.861, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243406, 32820, 0, 1, 1, 0, 0, 2681.23, 861.878, 108.754, 5.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243407, 32820, 0, 1, 1, 0, 0, 2684.66, 443.218, 18.817, 2.514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243408, 32820, 0, 1, 1, 0, 0, 2685.8, 8.171, 29.688, 2.305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243409, 32820, 0, 1, 1, 0, 0, 2686.46, 221.022, 31.364, 0.673, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243410, 32820, 0, 1, 1, 0, 0, 2689.81, 7.583, 30.024, 5.376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243411, 32820, 0, 1, 1, 0, 0, 2691.65, 944.4, 110.92, 2.273, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243412, 32820, 0, 1, 1, 0, 0, 2692.62, 884.526, 110.192, 5.771, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243413, 32820, 0, 1, 1, 0, 0, 2693.22, 97.336, 35.577, 4.421, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243414, 32820, 0, 1, 1, 0, 0, 2693.45, 492.476, 17.507, 3.089, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243415, 32820, 0, 1, 1, 0, 0, 2701.31, -487, 107.766, 1.322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243416, 32820, 0, 1, 1, 0, 0, 2702.78, -269, 62.324, 0.484, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243417, 32820, 0, 1, 1, 0, 0, 2705.41, 379.311, 26.93, 1.551, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243418, 32820, 0, 1, 1, 0, 0, 2706.57, 407.431, 23.754, 1.209, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243419, 32820, 0, 1, 1, 0, 0, 2707.92, -41, 28.567, 2.55, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243420, 32820, 0, 1, 1, 0, 0, 2708.15, 342.402, 29.246, 3.835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243421, 32820, 0, 1, 1, 0, 0, 2710.12, 923.481, 112.48, 2.31, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243422, 32820, 0, 1, 1, 0, 0, 2712.58, 295.287, 31.149, 1.383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243423, 32820, 0, 1, 1, 0, 0, 2712.75, 223.41, 33.219, 6.015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243424, 32820, 0, 1, 1, 0, 0, 2715.01, -343, 92.65, 1.784, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243425, 32820, 0, 1, 1, 0, 0, 2716.14, -745, 135.23, 2.544, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243426, 32820, 0, 1, 1, 0, 0, 2716.88, -688, 119.268, 4.116, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243427, 32820, 0, 1, 1, 0, 0, 2717.71, 780.438, 111.583, 5.339, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243428, 32820, 0, 1, 1, 0, 0, 2723.15, 842.9, 114.437, 3.655, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243429, 32820, 0, 1, 1, 0, 0, 2723.92, -265, 60.197, 2.092, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243430, 32820, 0, 1, 1, 0, 0, 2727.35, 360.837, 27.167, 5.2, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243431, 32820, 0, 1, 1, 0, 0, 2728.22, -47, 29.317, 6.112, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243432, 32820, 0, 1, 1, 0, 0, 2730.6, 122.119, 34.944, 3.636, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243433, 32820, 0, 1, 1, 0, 0, 2731.25, 140.329, 30.919, 3.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243434, 32820, 0, 1, 1, 0, 0, 2732.84, -505, 103.028, 3.26, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243435, 32820, 0, 1, 1, 0, 0, 2733.1, 221.369, 34.842, 0.67, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243436, 32820, 0, 1, 1, 0, 0, 2737.26, 861.033, 115.463, 1.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243437, 32820, 0, 1, 1, 0, 0, 2738.61, 953.638, 109.836, 2.632, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243438, 32820, 0, 1, 1, 0, 0, 2739.95, 90.715, 34.121, 1.554, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243439, 32820, 0, 1, 1, 0, 0, 2741.66, -229, 50.351, 0.806, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243440, 32820, 0, 1, 1, 0, 0, 2741.69, -76, 31.535, 5.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243441, 32820, 0, 1, 1, 0, 0, 2744.38, -790, 147.906, 2.75, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243442, 32820, 0, 1, 1, 0, 0, 2745.03, 238.559, 34.676, 3.898, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243443, 32820, 0, 1, 1, 0, 0, 2745.98, 782.205, 114.843, 1.214, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243444, 32820, 0, 1, 1, 0, 0, 2746.17, 313.784, 30.283, 5.061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243445, 32820, 0, 1, 1, 0, 0, 2747.19, -279, 64.486, 5.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243446, 32820, 0, 1, 1, 0, 0, 2748.59, 881.264, 114.505, 0.087, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243447, 32820, 0, 1, 1, 0, 0, 2749.44, 786.891, 114.357, 1.408, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243448, 32820, 0, 1, 1, 0, 0, 2750.02, -531, 104.626, 2.793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243449, 32820, 0, 1, 1, 0, 0, 2751.57, -531, 104.416, 4.951, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243450, 32820, 0, 1, 1, 0, 0, 2753.36, 122.284, 29.101, 5.357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243451, 32820, 0, 1, 1, 0, 0, 2754.19, 272.893, 28.355, 6.13, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243452, 32820, 0, 1, 1, 0, 0, 2754.9, 807.562, 113.174, 1.676, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243453, 32820, 0, 1, 1, 0, 0, 2756.84, -691, 126.144, 5.155, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243454, 32820, 0, 1, 1, 0, 0, 2757.54, -347, 78.813, 3.879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243455, 32820, 0, 1, 1, 0, 0, 2758.23, -162, 34.031, 5.088, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243456, 32820, 0, 1, 1, 0, 0, 2758.75, 79.879, 31.355, 0.578, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243457, 32820, 0, 1, 1, 0, 0, 2761.43, -751, 135.385, 0.335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243458, 32820, 0, 1, 1, 0, 0, 2763.1, 445.459, 20.5, 0.648, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243459, 32820, 0, 1, 1, 0, 0, 2763.11, -334, 77.089, 4.666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243460, 32820, 0, 1, 1, 0, 0, 2768.53, -171, 36.586, 1.213, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243461, 32820, 0, 1, 1, 0, 0, 2769.63, -337, 75.881, 5.695, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243462, 32820, 0, 1, 1, 0, 0, 2769.83, 869.461, 112.399, 5.785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243463, 32820, 0, 1, 1, 0, 0, 2770.84, -13, 34.186, 1.078, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243464, 32820, 0, 1, 1, 0, 0, 2771.16, 153.872, 30.78, 1.108, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243465, 32820, 0, 1, 1, 0, 0, 2771.49, 187.297, 31.745, 4.168, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243466, 32820, 0, 1, 1, 0, 0, 2775.09, -749, 135.039, 2.595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243467, 32820, 0, 1, 1, 0, 0, 2775.25, -406, 82.028, 5.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243468, 32820, 0, 1, 1, 0, 0, 3027.02, 671.836, 90.4184, 3.14605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243469, 32820, 0, 1, 1, 0, 0, 2777.98, 285.861, 31.831, 2.783, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243470, 32820, 0, 1, 1, 0, 0, 2778.1, 1026.33, 108.903, 4.347, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243471, 32820, 0, 1, 1, 0, 0, 2778.38, -66, 34.106, 4.347, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243472, 32820, 0, 1, 1, 0, 0, 2779.73, 344.693, 26.697, 1.297, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243473, 32820, 0, 1, 1, 0, 0, 2780.26, -419, 81.504, 3.05, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243474, 32820, 0, 1, 1, 0, 0, 2781.3, 348.492, 26.39, 3.792, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243475, 32820, 0, 1, 1, 0, 0, 2781.32, 78.466, 28.691, 4.853, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243476, 32820, 0, 1, 1, 0, 0, 2782.21, 1060.45, 110.458, 4.223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243477, 32820, 0, 1, 1, 0, 0, 2782.22, -748, 134.874, 4.873, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243478, 32820, 0, 1, 1, 0, 0, 2782.46, 975.446, 112.993, 3.098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243479, 32820, 0, 1, 1, 0, 0, 2783.65, 1057.34, 110.378, 4.234, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243480, 32820, 0, 1, 1, 0, 0, 2783.88, -770, 139.92, 6.148, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243481, 32820, 0, 1, 1, 0, 0, 2784.07, 416.318, 19.71, 1.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243482, 32820, 0, 1, 1, 0, 0, 2784.3, 42.982, 29.613, 0.994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243483, 32820, 0, 1, 1, 0, 0, 2785.3, 20.632, 31.625, 1.381, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243484, 32820, 0, 1, 1, 0, 0, 2786.16, 800.124, 113.599, 5.463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243485, 32820, 0, 1, 1, 0, 0, 2786.49, 996.78, 111.898, 5.657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243486, 32820, 0, 1, 1, 0, 0, 2786.53, 237.086, 33.154, 0.563, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243487, 32820, 0, 1, 1, 0, 0, 2786.78, 1058.27, 110.623, 4.197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243488, 32820, 0, 1, 1, 0, 0, 2787.2, 308.044, 30.555, 5.596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243489, 32820, 0, 1, 1, 0, 0, 2788.7, 792.128, 115.004, 5.513, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243490, 32820, 0, 1, 1, 0, 0, 2789.81, -31, 33.866, 3.21, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243491, 32820, 0, 1, 1, 0, 0, 2791.81, -474, 101.641, 1.257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243492, 32820, 0, 1, 1, 0, 0, 2938.94, 601.286, 91.7991, 0.439689, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243493, 32820, 0, 1, 1, 0, 0, 2799.56, 144.821, 21.517, 4.682, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243494, 32820, 0, 1, 1, 0, 0, 2801.71, 317.016, 27.388, 3.812, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243495, 32820, 0, 1, 1, 0, 0, 2802.34, -106, 33.645, 2.441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243496, 32820, 0, 1, 1, 0, 0, 2805.02, 314.912, 27.249, 0.702, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243497, 32820, 0, 1, 1, 0, 0, 2805.06, 1100.72, 86.029, 5.157, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243498, 32820, 0, 1, 1, 0, 0, 2805.34, -679, 137.438, 3.973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243499, 32820, 0, 1, 1, 0, 0, 2806.21, 745.621, 139.187, 1.847, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243500, 32820, 0, 1, 1, 0, 0, 3059.38, 655.884, 75.3527, 3.07709, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243501, 32820, 0, 1, 1, 0, 0, 2807.62, 49.259, 27.098, 6.24, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243502, 32820, 0, 1, 1, 0, 0, 2807.95, -426, 80.45, 0.191, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243503, 32820, 0, 1, 1, 0, 0, 2809.32, 818.412, 112.829, 1.798, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243504, 32820, 0, 1, 1, 0, 0, 2809.33, 185.504, 29.006, 4.035, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243505, 32820, 0, 1, 1, 0, 0, 2810.2, 948.442, 118.026, 3.299, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243506, 32820, 0, 1, 1, 0, 0, 2810.22, -311, 67.937, 2.459, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243507, 32820, 0, 1, 1, 0, 0, 2810.6, 142.153, 21.616, 1.07, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243508, 32820, 0, 1, 1, 0, 0, 2811.14, -789, 144.879, 4.823, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243509, 32820, 0, 1, 1, 0, 0, 2811.39, -790, 145.105, 2.535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243510, 32820, 0, 1, 1, 0, 0, 2813.94, 831.372, 112.091, 6.105, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243511, 32820, 0, 1, 1, 0, 0, 2814.09, 1010.74, 115.849, 3.777, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243512, 32820, 0, 1, 1, 0, 0, 2814.33, 91.472, 25.442, 6.23, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243513, 32820, 0, 1, 1, 0, 0, 2814.48, 728.167, 139.574, 6.22, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243514, 32820, 0, 1, 1, 0, 0, 2814.63, 228.967, 30.876, 0.505, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243515, 32820, 0, 1, 1, 0, 0, 2815.55, -19, 32.59, 0.677, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243516, 32820, 0, 1, 1, 0, 0, 2815.74, 182.766, 27.329, 3.478, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243517, 32820, 0, 1, 1, 0, 0, 2815.95, -683, 137.601, 3.595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243518, 32820, 0, 1, 1, 0, 0, 2817.45, -381, 77.81, 0.86, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243519, 32820, 0, 1, 1, 0, 0, 2820.31, -344, 75.417, 1.808, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243520, 32820, 0, 1, 1, 0, 0, 2821.16, -649, 140.416, 1.739, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243521, 32820, 0, 1, 1, 0, 0, 2821.66, -755, 146.603, 4.311, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243522, 32820, 0, 1, 1, 0, 0, 2821.88, -87, 32.634, 4.857, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243523, 32820, 0, 1, 1, 0, 0, 2822.21, 487.184, 31.126, 3.7, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243524, 32820, 0, 1, 1, 0, 0, 2822.22, 948.464, 120.006, 0.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243525, 32820, 0, 1, 1, 0, 0, 2822.63, -220, 47.639, 4.51, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243526, 32820, 0, 1, 1, 0, 0, 2822.8, -646, 141.084, 0.832, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243527, 32820, 0, 1, 1, 0, 0, 2823.48, 701.019, 144.699, 3.563, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243528, 32820, 0, 1, 1, 0, 0, 2824.21, 286.932, 28.296, 0.217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243529, 32820, 0, 1, 1, 0, 0, 2828.15, -484, 99.097, 6.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243530, 32820, 0, 1, 1, 0, 0, 2828.31, -713, 138.438, 3.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243531, 32820, 0, 1, 1, 0, 0, 2828.31, -713, 138.668, 3.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243532, 32820, 0, 1, 1, 0, 0, 2833.22, 1020.89, 116.123, 5.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243533, 32820, 0, 1, 1, 0, 0, 2835.46, -379, 77.259, 4.455, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243534, 32820, 0, 1, 1, 0, 0, 2839.44, -226, 48.06, 5.984, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243535, 32820, 0, 1, 1, 0, 0, 3043.64, 684.044, 66.735, 4.72956, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243536, 32820, 0, 1, 1, 0, 0, 2844.7, 850.579, 112.802, 0.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243537, 32820, 0, 1, 1, 0, 0, 2846.05, -505, 107.585, 1.65, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243538, 32820, 0, 1, 1, 0, 0, 2847.02, -14, 24.719, 2.777, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243539, 32820, 0, 1, 1, 0, 0, 2847.58, 238.872, 29.028, 2.167, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243540, 32820, 0, 1, 1, 0, 0, 2848.24, -451, 77.662, 6.055, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243541, 32820, 0, 1, 1, 0, 0, 2848.26, -653, 138.698, 3.634, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243542, 32820, 0, 1, 1, 0, 0, 2848.69, 346.604, 24.445, 0.524, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243543, 32820, 0, 1, 1, 0, 0, 2849.62, 205.19, 30.838, 4.131, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243544, 32820, 0, 1, 1, 0, 0, 2851.43, -19, 23.539, 2.208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243545, 32820, 0, 1, 1, 0, 0, 2852.84, -649, 139.024, 2.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243546, 32820, 0, 1, 1, 0, 0, 2852.87, 1046.5, 114.813, 5.593, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243547, 32820, 0, 1, 1, 0, 0, 2853.96, -182, 43.164, 5.031, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243548, 32820, 0, 1, 1, 0, 0, 2854.2, -776, 160.333, 0.377, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243549, 32820, 0, 1, 1, 0, 0, 2855.61, 427.809, 20.219, 1.466, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243550, 32820, 0, 1, 1, 0, 0, 2856.63, 948.791, 121.861, 6.166, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243551, 32820, 0, 1, 1, 0, 0, 2858.62, -219, 50.504, 3.283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243552, 32820, 0, 1, 1, 0, 0, 2858.66, 276, 29.324, 4.692, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243553, 32820, 0, 1, 1, 0, 0, 2858.72, -512, 107.163, 3.526, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243554, 32820, 0, 1, 1, 0, 0, 3044.81, 671.019, 81.0471, 4.74525, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243555, 32820, 0, 1, 1, 0, 0, 2860.16, -291, 56.522, 1.288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243556, 32820, 0, 1, 1, 0, 0, 2860.19, -490, 100.104, 0.334, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243557, 32820, 0, 1, 1, 0, 0, 2861.32, 288.391, 28.172, 6.224, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243558, 32820, 0, 1, 1, 0, 0, 2862.91, -798, 160.333, 0.405, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243559, 32820, 0, 1, 1, 0, 0, 2863.2, 1102.02, 116.52, 2.028, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243560, 32820, 0, 1, 1, 0, 0, 2863.74, -742, 160.332, 1.931, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243561, 32820, 0, 1, 1, 0, 0, 2864.16, -82, 34.52, 1.696, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243562, 32820, 0, 1, 1, 0, 0, 2867.45, -444, 76.938, 6.279, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243563, 32820, 0, 1, 1, 0, 0, 2868.94, -314, 61.622, 5.248, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243564, 32820, 0, 1, 1, 0, 0, 2869.83, 351.009, 25.677, 2.216, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243565, 32820, 0, 1, 1, 0, 0, 2871.16, -653, 137.776, 5.027, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243566, 32820, 0, 1, 1, 0, 0, 2872.27, 68.096, 7.318, 0.468, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243567, 32820, 0, 1, 1, 0, 0, 2873.01, 931.492, 120.33, 1.98, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243568, 32820, 0, 1, 1, 0, 0, 2873.29, -643, 137.839, 4.579, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243569, 32820, 0, 1, 1, 0, 0, 2873.88, 385.114, 23.78, 2.826, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243570, 32820, 0, 1, 1, 0, 0, 2873.99, -766, 160.333, 2.103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243571, 32820, 0, 1, 1, 0, 0, 2878.97, 755.981, 121.907, 1.751, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243572, 32820, 0, 1, 1, 0, 0, 2879, -4, 19.086, 5.243, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243573, 32820, 0, 1, 1, 0, 0, 2879.51, -744, 160.416, 5.197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243574, 32820, 0, 1, 1, 0, 0, 2880.28, 845.764, 112.495, 2.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243575, 32820, 0, 1, 1, 0, 0, 2883.51, -789, 160.333, 3.574, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243576, 32820, 0, 1, 1, 0, 0, 2883.86, 261.845, 24.999, 4.842, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243577, 32820, 0, 1, 1, 0, 0, 2885.88, -253, 48.962, 1.164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243578, 32820, 0, 1, 1, 0, 0, 2889.46, -448, 80.326, 0.968, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243579, 32820, 0, 1, 1, 0, 0, 2889.54, 182.161, 7.886, 1.546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243580, 32820, 0, 1, 1, 0, 0, 2891.65, -809, 160.333, 5.178, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243581, 32820, 0, 1, 1, 0, 0, 2892.33, -533, 106.285, 3.91, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243582, 32820, 0, 1, 1, 0, 0, 2893.6, 53.019, 8.434, 4.642, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243583, 32820, 0, 1, 1, 0, 0, 3020.6, 705.731, 99.9982, 3.81062, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243584, 32820, 0, 1, 1, 0, 0, 2894.91, -659, 138.365, 6.066, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243585, 32820, 0, 1, 1, 0, 0, 2896.52, 406.991, 25.118, 0.604, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243586, 32820, 0, 1, 1, 0, 0, 2896.56, -538, 106.566, 3.246, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243587, 32820, 0, 1, 1, 0, 0, 2899.94, 388.981, 29.211, 3.126, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243588, 32820, 0, 1, 1, 0, 0, 2901.96, 102.868, 6.763, 1.788, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243589, 32820, 0, 1, 1, 0, 0, 2902.53, -781, 160.333, 3.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243590, 32820, 0, 1, 1, 0, 0, 2902.63, 385.339, 30.095, 3.078, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243591, 32820, 0, 1, 1, 0, 0, 2902.79, 379.436, 30.328, 2.988, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243592, 32820, 0, 1, 1, 0, 0, 2903.55, -707, 154.518, 2.736, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243593, 32820, 0, 1, 1, 0, 0, 2904.61, -626, 149.925, 2.946, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243594, 32820, 0, 1, 1, 0, 0, 2905.63, 851.381, 112.685, 6.2, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243595, 32820, 0, 1, 1, 0, 0, 2906.4, -79, 23.843, 1.339, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243596, 32820, 0, 1, 1, 0, 0, 2907.77, -710, 154.768, 3.285, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243597, 32820, 0, 1, 1, 0, 0, 2911.67, -162, 33.899, 2.483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243598, 32820, 0, 1, 1, 0, 0, 2912.35, -760, 154.067, 1.065, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243599, 32820, 0, 1, 1, 0, 0, 2913.44, -754, 153.983, 2.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243600, 32820, 0, 1, 1, 0, 0, 2916.26, -83, 26.383, 4.804, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243601, 32820, 0, 1, 1, 0, 0, 2916.44, 149.209, 6.926, 3.96, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243602, 32820, 0, 1, 1, 0, 0, 2916.55, 1061.98, 100.848, 6.182, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243603, 32820, 0, 1, 1, 0, 0, 2917.87, 918.233, 115.606, 0.977, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243604, 32820, 0, 1, 1, 0, 0, 2918.58, -440, 85.155, 4.499, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243605, 32820, 0, 1, 1, 0, 0, 2918.6, 1048.91, 100.867, 1.956, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243606, 32820, 0, 1, 1, 0, 0, 2919.32, 673.126, 110.042, 3.384, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243607, 32820, 0, 1, 1, 0, 0, 2920.15, 169.812, 5.183, 4.343, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243608, 32820, 0, 1, 1, 0, 0, 2921.05, 797.461, 116.681, 4.988, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243609, 32820, 0, 1, 1, 0, 0, 2923.18, 751.02, 107.677, 4.449, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243610, 32820, 0, 1, 1, 0, 0, 2924.28, -415, 80.677, 3.127, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243611, 32820, 0, 1, 1, 0, 0, 2925.68, 953.221, 121.743, 4.328, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243612, 32820, 0, 1, 1, 0, 0, 2926.76, 658.565, 107.85, 1.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243613, 32820, 0, 1, 1, 0, 0, 2927.31, 319.104, 20.54, 0.619, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243614, 32820, 0, 1, 1, 0, 0, 2929.2, 89.24, 4.717, 5.706, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243615, 32820, 0, 1, 1, 0, 0, 2929.25, 666.884, 108.087, 1.678, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243616, 32820, 0, 1, 1, 0, 0, 2929.88, 788.119, 109.945, 0.705, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243617, 32820, 0, 1, 1, 0, 0, 2929.93, -241, 35.956, 1.894, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243618, 32820, 0, 1, 1, 0, 0, 2931.4, -730, 153.635, 4.361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243619, 32820, 0, 1, 1, 0, 0, 2934.09, 263.472, 8.085, 6.266, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243620, 32820, 0, 1, 1, 0, 0, 2936.11, -656, 148.523, 0.068, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243621, 32820, 0, 1, 1, 0, 0, 2936.93, -237, 34.005, 0.051, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243622, 32820, 0, 1, 1, 0, 0, 2941.69, 102.462, 6.311, 6.056, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243623, 32820, 0, 1, 1, 0, 0, 2942.63, -151, 26.086, 2.002, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243624, 32820, 0, 1, 1, 0, 0, 2943.65, 63.731, 6.236, 3.308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243625, 32820, 0, 1, 1, 0, 0, 2944.22, -625, 154.703, 2.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243626, 32820, 0, 1, 1, 0, 0, 2944.88, 562.758, 91.401, 2.818, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243627, 32820, 0, 1, 1, 0, 0, 2945.26, 971.593, 121.785, 1.886, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243628, 32820, 0, 1, 1, 0, 0, 2946.59, 181.706, 3.237, 3.686, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243629, 32820, 0, 1, 1, 0, 0, 2947.27, -769, 154.118, 0.31, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243630, 32820, 0, 1, 1, 0, 0, 2947.86, 161.726, 4.916, 1.018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243631, 32820, 0, 1, 1, 0, 0, 2947.92, -652, 154.773, 5.658, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243632, 32820, 0, 1, 1, 0, 0, 2948.83, -273, 27.43, 2.897, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243633, 32820, 0, 1, 1, 0, 0, 2953.51, -717, 154.858, 2.905, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243634, 32820, 0, 1, 1, 0, 0, 2954.64, 315.11, 7.777, 1.495, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243635, 32820, 0, 1, 1, 0, 0, 2954.81, 1018.79, 103.163, 3.807, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243636, 32820, 0, 1, 1, 0, 0, 2956.01, 709.12, 105.911, 0.855, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243637, 32820, 0, 1, 1, 0, 0, 2956.12, 819.863, 101.797, 2.267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243638, 32820, 0, 1, 1, 0, 0, 2967.57, 333.307, 8.102, 5.69, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243639, 32820, 0, 1, 1, 0, 0, 2968.38, 335.047, 8.085, 0.401, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243640, 32820, 0, 1, 1, 0, 0, 2969.37, -292, 21.871, 4.815, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243641, 32820, 0, 1, 1, 0, 0, 2970.81, 274.396, 5.439, 4.338, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243642, 32820, 0, 1, 1, 0, 0, 2972.62, -558, 111.918, 3.277, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243643, 32820, 0, 1, 1, 0, 0, 2974.08, 571.61, 94.697, 2.646, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243644, 32820, 0, 1, 1, 0, 0, 2974.75, 287.31, 4.246, 0.001, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243645, 32820, 0, 1, 1, 0, 0, 2978.02, -540, 112.539, 3.735, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243646, 32820, 0, 1, 1, 0, 0, 2979.02, 1073.34, 85.655, 5.99, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243647, 32820, 0, 1, 1, 0, 0, 2979.26, -17, 6.461, 2.412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243648, 32820, 0, 1, 1, 0, 0, 2980.37, -179, 18.694, 0.84, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243649, 32820, 0, 1, 1, 0, 0, 2981.09, -307, 18.762, 0.878, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243650, 32820, 0, 1, 1, 0, 0, 2984.23, 918.186, 110.832, 5.333, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243651, 32820, 0, 1, 1, 0, 0, 2985.34, 978.439, 114.323, 6.253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243652, 32820, 0, 1, 1, 0, 0, 2985.35, -748, 157.915, 6.231, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243653, 32820, 0, 1, 1, 0, 0, 2986.52, 422.934, 19.479, 5.042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243654, 32820, 0, 1, 1, 0, 0, 2990.13, -66, 16.091, 4.713, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243655, 32820, 0, 1, 1, 0, 0, 2992.05, 698.937, 93.051, 5.166, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243656, 32820, 0, 1, 1, 0, 0, 2994.95, 383.693, 7.901, 5.36, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243657, 32820, 0, 1, 1, 0, 0, 3003.91, -540, 115.815, 3.553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243658, 32820, 0, 1, 1, 0, 0, 3004.72, -494, 96.224, 1.054, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243659, 32820, 0, 1, 1, 0, 0, 3005.26, 804.189, 86.07, 3.823, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243660, 32820, 0, 1, 1, 0, 0, 3013.12, 367.309, 2.625, 3.236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243661, 32820, 0, 1, 1, 0, 0, 3017.92, -559, 118.956, 2.777, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243662, 32820, 0, 1, 1, 0, 0, 3019.24, -345, 7.387, 2.226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243663, 32820, 0, 1, 1, 0, 0, 3021.42, -542, 119.423, 2.598, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243664, 32820, 0, 1, 1, 0, 0, 3022.31, -143, 5.012, 2.794, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243665, 32820, 0, 1, 1, 0, 0, 3024.11, 652.807, 90.253, 5.443, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243666, 32820, 0, 1, 1, 0, 0, 3024.93, -233, 7.387, 1.6, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243667, 32820, 0, 1, 1, 0, 0, 3026.09, -249, 7.387, 4.482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243668, 32820, 0, 1, 1, 0, 0, 3026.25, -362, 4.429, 5.986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243669, 32820, 0, 1, 1, 0, 0, 3027.17, 689.5, 65.964, 2.264, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243670, 32820, 0, 1, 1, 0, 0, 3028.97, -179, 7.284, 4.565, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243671, 32820, 0, 1, 1, 0, 0, 3030.19, -366, 2.743, 4.049, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243672, 32820, 0, 1, 1, 0, 0, 3032.96, 655.387, 75.35, 0.114, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243673, 32820, 0, 1, 1, 0, 0, 3033.13, 398.802, 0.929, 2.906, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243674, 32820, 0, 1, 1, 0, 0, 3038.01, 656.1, 75.35, 6.275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243675, 32820, 0, 1, 1, 0, 0, 3040.67, -31, 5.143, 5.691, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243676, 32820, 0, 1, 1, 0, 0, 3041.3, 660.506, 57.506, 2.147, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243677, 32820, 0, 1, 1, 0, 0, 3043.79, 657.255, 57.423, 1.618, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243678, 32820, 0, 1, 1, 0, 0, 2982.18, 601.382, 98.2531, 2.72127, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243679, 32820, 0, 1, 1, 0, 0, 3045.31, 417.43, 0.567, 5.655, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243680, 32820, 0, 1, 1, 0, 0, 3046.45, 11.109, 0.234, 4.485, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243681, 32820, 0, 1, 1, 0, 0, 3049.32, 661.191, 57.423, 1.826, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243682, 32820, 0, 1, 1, 0, 0, 3051.71, -551, 126.513, 3.651, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243683, 32820, 0, 1, 1, 0, 0, 3052.12, -566, 126.397, 2.459, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243684, 32820, 0, 1, 1, 0, 0, 3052.36, 426.242, 7.103, 4.067, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243685, 32820, 0, 1, 1, 0, 0, 3054.02, -183, 1.923, 0.202, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243686, 32820, 0, 1, 1, 0, 0, 3056.72, -559, 125.842, 2.512, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243687, 32820, 0, 1, 1, 0, 0, 3059.86, 691.63, 65.964, 1.097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243688, 32820, 0, 1, 1, 0, 0, 3061.28, -147, -2, 2.921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243689, 32820, 0, 1, 1, 0, 0, 3069, -80, 0.579, 4.59, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243690, 32820, 0, 1, 1, 0, 0, 3076.78, -562, 126.721, 2.868, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243691, 32820, 0, 1, 1, 0, 0, 2928.53, 696.453, 108.188, 1.70351, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243692, 32820, 0, 1, 1, 0, 0, 3078.75, -560, 126.722, 3.165, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243693, 32820, 0, 1, 1, 0, 0, 3088.75, -10, 0.235, 2.426, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243694, 32820, 0, 1, 1, 0, 0, 3096.26, -566, 126.807, 1.006, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243695, 32820, 0, 1, 1, 0, 0, 3102.06, -553, 126.627, 0.175, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243696, 32820, 0, 1, 1, 0, 0, 3119.52, -574, 128.942, 0.681, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243697, 32820, 0, 1, 1, 0, 0, 1964.31, 1554.16, 85.7158, 1.30119, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243698, 32820, 0, 1, 1, 0, 0, -9744, 558.748, 35.745, 6.004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243699, 32820, 0, 1, 1, 0, 0, -9793, -306, 46.5, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243700, 32820, 0, 1, 1, 0, 0, -9860, -221, 36.19, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243701, 32820, 0, 1, 1, 0, 0, -9898, -277, 33.4, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243702, 32820, 0, 1, 1, 0, 0, -9495.05, 395.521, 51.949, 1.53097, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243703, 32820, 0, 1, 1, 0, 0, -9270, 653.4, 134.5, 0.4, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243704, 32820, 0, 1, 1, 0, 0, 1786.59, 1490.76, 104.011, 0.357352, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243705, 32820, 0, 1, 1, 0, 0, 2010.64, 1633.8, 71.8949, 3.6393, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243706, 32820, 0, 1, 1, 0, 0, 1825.83, 1520.08, 90.2908, 4.37744, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243707, 32820, 0, 1, 1, 0, 0, 2042.86, 1895.12, 102.009, 4.20624, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243708, 32820, 0, 1, 1, 0, 0, 2947.37, 537.734, 95.8111, 1.59355, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243709, 32820, 0, 1, 1, 0, 0, 2817.39, 698.619, 145.777, 0.297644, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243710, 32820, 0, 1, 1, 0, 0, 2910.61, 801.003, 118.231, 2.66562, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243711, 32820, 0, 1, 1, 0, 0, -385.302, 1110.64, 85.3631, 1.345, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243712, 32820, 0, 1, 1, 0, 0, -8933.42, -236.962, 79.4718, 3.6465, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243713, 32820, 0, 1, 1, 0, 0, 1775.35, 768.2, 55.1358, 3.94759, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243714, 32820, 0, 1, 1, 0, 0, 2142.51, 1818.9, 112.467, 0.113485, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243715, 32820, 0, 1, 1, 0, 0, 2030.92, 1759.4, 105.187, 3.13952, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243716, 32820, 0, 1, 1, 0, 0, 2053.61, 1904.96, 101.297, 2.74847, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243717, 32820, 0, 1, 1, 0, 0, 2048.1, 1913.08, 102.643, 3.59252, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243718, 32820, 0, 1, 1, 0, 0, 2037.69, 1915.95, 102.442, 2.21748, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243719, 32820, 0, 1, 1, 0, 0, 2009.23, 1927.88, 105.324, 0.789907, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243720, 32820, 0, 1, 1, 0, 0, 2004.1, 1943.92, 103.936, 2.06274, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243721, 32820, 0, 1, 1, 0, 0, 2067.3, 1974.92, 100.632, 0.468552, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243722, 32820, 0, 1, 1, 0, 0, 2056.7, 1973.26, 100.731, 5.72906, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243723, 32820, 0, 1, 1, 0, 0, 2078.01, 1960.71, 96.9135, 5.26414, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243724, 32820, 0, 1, 1, 0, 0, 2077.98, 1951.27, 97.9999, 3.21011, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243725, 32820, 0, 1, 1, 0, 0, 2041.57, 1990.01, 100.102, 1.21743, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243726, 32820, 0, 1, 1, 0, 0, 2009.06, 1952.52, 102.697, 2.3456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243727, 32820, 0, 1, 1, 0, 0, 2021.89, 1970.46, 100.136, 4.28176, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243728, 32820, 0, 1, 1, 0, 0, 2031.09, 1981.2, 99.4831, 5.68204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243729, 32820, 0, 1, 1, 0, 0, 2081.52, 1969.65, 101.161, 3.06268, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243730, 32820, 0, 1, 1, 0, 0, 2068.09, 1970.57, 99.694, 5.04511, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243731, 32820, 0, 1, 1, 0, 0, 2044.35, 1863.3, 102.94, 2.87979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243732, 32820, 0, 1, 1, 0, 0, 2045.76, 1876.12, 101.938, 0.09333, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243733, 32820, 0, 1, 1, 0, 0, 2035.48, 1884.91, 103.122, 0.21166, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243734, 32820, 0, 1, 1, 0, 0, 2045.61, 1832.43, 107.74, 0.226662, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243735, 32820, 0, 1, 1, 0, 0, 2290.18, 396.015, 34.0273, 6.22659, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243736, 32820, 0, 1, 1, 0, 0, 2235.23, 248.3, 33.3851, 3.24248, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243737, 32820, 0, 1, 1, 0, 0, 2165.83, 1763.53, 98.8838, 0.006357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243738, 32820, 0, 1, 1, 0, 0, 2135.63, 1749.76, 85.8838, 0.947992, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243739, 32820, 0, 1, 1, 0, 0, 2114.67, 1785.05, 91.621, 3.36632, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243740, 32820, 0, 1, 1, 0, 0, 2061.67, 1790.69, 92.8739, 2.77722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243741, 32820, 0, 1, 1, 0, 0, 2042.98, 1780.07, 96.8739, 5.71924, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243742, 32820, 0, 1, 1, 0, 0, 2090.34, 1794.37, 104.809, 1.85416, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243743, 32820, 0, 1, 1, 0, 0, 2267.57, 1148.76, 33.1175, 0.06058, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243744, 32820, 0, 1, 1, 0, 0, 1952.85, 674.922, 46.8509, 1.98156, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243745, 32820, 0, 1, 1, 0, 0, 2149.02, -707.278, 66.9912, 5.39988, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243746, 32820, 0, 1, 1, 0, 0, 2246.61, 329.109, 35.1891, 5.54353, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243747, 32820, 0, 1, 1, 0, 0, -9585.09, 22.4941, 60.2258, 3.83489, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243748, 32820, 0, 1, 1, 0, 0, 1767.39, 1401.59, 95.4556, 0.907202, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243749, 32820, 0, 1, 1, 0, 0, 2133, 1812.78, 107.113, 0.076802, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243750, 32820, 0, 1, 1, 0, 0, 2055.19, 1802.37, 99.9483, 5.11756, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243751, 32820, 0, 1, 1, 0, 0, 1785.62, 1413.87, 89.7434, 5.52893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243752, 32820, 0, 1, 1, 0, 0, 2150.35, 1796.23, 111.591, 3.85096, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243753, 32820, 0, 1, 1, 0, 0, 2176.15, 1773.74, 106.631, 4.70236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243754, 32820, 0, 1, 1, 0, 0, 1745.32, 1456.14, 127.703, 0.931008, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243755, 32820, 0, 1, 1, 0, 0, 1745.24, 1384.37, 99.1645, 3.97365, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243756, 32820, 0, 1, 1, 0, 0, 1682.29, 1331.34, 129.135, 5.97211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243757, 32820, 0, 1, 1, 0, 0, 1842.72, 1326.38, 82.5225, 3.55238, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243758, 32820, 0, 1, 1, 0, 0, 2042.62, 1535.94, 77.489, 0.78331, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243759, 32820, 0, 1, 1, 0, 0, 1680.36, 1459.78, 131.926, 5.12536, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243760, 32820, 0, 1, 1, 0, 0, 1743.9, 1484.4, 131.095, 1.93249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243761, 32820, 0, 1, 1, 0, 0, 1843.25, 1411.66, 81.1712, 3.52332, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243762, 32820, 0, 1, 1, 0, 0, 1856.99, 1486.92, 90.4841, 6.24703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243763, 32820, 0, 1, 1, 0, 0, 1875.6, 1475.32, 84.1047, 1.0482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243764, 32820, 0, 1, 1, 0, 0, 1876.33, 1286.86, 97.0498, 2.29111, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243765, 32820, 0, 1, 1, 0, 0, 1904.95, 1459.38, 81.8932, 1.99645, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243766, 32820, 0, 1, 1, 0, 0, 1897.44, 1470.9, 84.7727, 1.74171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243767, 32820, 0, 1, 1, 0, 0, 1814.22, 1281.65, 98.8504, 4.30128, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243768, 32820, 0, 1, 1, 0, 0, -9314.44, 534.504, 75.7665, 5.50474, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243769, 32820, 0, 1, 1, 0, 0, 2164.71, 1707.36, 94.5088, 5.24337, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243770, 32820, 0, 1, 1, 0, 0, 1700.66, 1412.59, 128.992, 3.27602, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243771, 32820, 0, 1, 1, 0, 0, 1904.61, 1490.4, 93.9505, 1.04444, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243772, 32820, 0, 1, 1, 0, 0, 1911.6, 1499.34, 89.1851, 4.08433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243773, 32820, 0, 1, 1, 0, 0, -9511.31, -1285.64, 44.1448, 3.93122, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243774, 32820, 0, 1, 1, 0, 0, -9071.98, 445.326, 93.2958, 5.4317, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243775, 32820, 0, 1, 1, 0, 0, -9055.89, 424.686, 93.2957, 2.28775, 600, 20, 1, 2, 0, 1, 1, 0, 0);
INSERT INTO creature VALUES(243776, 32820, 0, 1, 1, 0, 0, -10561.6, -1320.52, 47.1949, 2.26275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243777, 32820, 0, 1, 1, 0, 0, -10683.7, -1233.15, 28.7227, 5.27282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243778, 32820, 0, 1, 1, 0, 0, -10672.2, -1153.13, 25.833, 1.41593, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243779, 32820, 0, 1, 1, 0, 0, -9427.15, 129.176, 59.4742, 2.84226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243780, 32820, 0, 1, 1, 0, 0, -9332.22, 272.505, 68.1097, 1.01197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243781, 32820, 0, 1, 1, 0, 0, -9325.21, 269.797, 67.8272, 5.27587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243782, 32820, 0, 1, 1, 0, 0, -790.13, -605.027, 22.1652, 4.44376, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243783, 32820, 0, 1, 1, 0, 0, -753.823, -573.231, 19.5524, 1.55322, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243784, 32820, 0, 1, 1, 0, 0, -816.533, -537.25, 15.3231, 2.77414, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243785, 32820, 0, 1, 1, 0, 0, -814.948, -616.612, 13.8203, 1.96799, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243786, 32820, 0, 1, 1, 0, 0, -908.8, -959.17, 30.4945, 0.763091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243787, 32820, 0, 1, 1, 0, 0, -10694.7, -1130.38, 25.5715, 3.55496, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243788, 32820, 0, 1, 1, 0, 0, -526.007, 18.1682, 49.3176, 3.12987, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243789, 32820, 0, 1, 1, 0, 0, -479.589, 4.75845, 55.4283, 4.72252, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243790, 32820, 0, 1, 1, 0, 0, -9944.64, -150.41, 25.0081, 1.68865, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243791, 32820, 0, 1, 1, 0, 0, -9472.62, 47.3926, 56.7775, 5.34535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243792, 32820, 0, 1, 1, 0, 0, -9507.4, -1209.39, 47.8715, 3.73257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243793, 32820, 0, 1, 1, 0, 0, -9475.52, -1161.98, 50.9518, 4.90971, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243794, 32820, 0, 1, 1, 0, 0, -9478.55, -1166.22, 50.4518, 4.10283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243795, 32820, 0, 1, 1, 0, 0, 1977.02, 1522.91, 87.5698, 4.72587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243796, 32820, 0, 1, 1, 0, 0, 1975.66, 1546.43, 87.2305, 1.15654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243797, 32820, 0, 1, 1, 0, 0, 1976.01, 1501.05, 86.214, 0.928894, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243798, 32820, 0, 1, 1, 0, 0, 1994.22, 1586.34, 81.2317, 2.31178, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243799, 32820, 0, 1, 1, 0, 0, 1987.36, 1591.49, 82.5041, 5.49851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243800, 32820, 0, 1, 1, 0, 0, 1971.58, 1570.47, 79.1067, 4.18616, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243801, 32820, 0, 1, 1, 0, 0, 2021.87, 1612.39, 71.5787, 3.98252, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243802, 32820, 0, 1, 1, 0, 0, 2993.51, 640.431, 95.6329, 3.82409, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243803, 32820, 0, 1, 1, 0, 0, 2908.8, 916.291, 115.437, 1.75454, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243804, 32820, 0, 1, 1, 0, 0, 3076.84, -557, 126.803, 3.108, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243805, 32820, 0, 1, 1, 0, 0, 3076.96, -562.549, 126.721, 3.01007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243806, 32820, 0, 1, 1, 0, 0, -9791.47, 720.201, 68.2069, 0.529751, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243807, 32820, 0, 1, 1, 0, 0, -9616.04, 642.939, 62.6796, 5.88775, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243808, 32820, 0, 1, 1, 0, 0, -9625.31, 695.083, 62.7331, 2.7061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243809, 32820, 0, 1, 1, 0, 0, 1688.74, -726.084, 58.1182, 1.29598, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243810, 32820, 0, 1, 1, 0, 0, -9041.9, 434.215, 93.296, 2.11911, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243811, 32820, 0, 1, 1, 0, 0, 1909.56, 1307.61, 90.0274, 5.69666, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243812, 32820, 0, 1, 1, 0, 0, 1916.15, 1382.17, 69.2014, 4.87436, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243813, 32820, 0, 1, 1, 0, 0, 1806.7, 1357.22, 85.9472, 2.21564, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243814, 32820, 0, 1, 1, 0, 0, 1770.66, 1357.48, 89.9835, 0.627305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243815, 32820, 0, 1, 1, 0, 0, 1780.09, 1306.45, 102.451, 0.492249, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243816, 32820, 0, 1, 1, 0, 0, 1789.5, 1376.98, 86.1594, 0.482362, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243817, 32820, 0, 1, 1, 0, 0, 1751.2, 1321.49, 101.106, 4.24247, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243818, 32820, 0, 1, 1, 0, 0, 1757.26, 1370.34, 92.2895, 3.84071, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243819, 32820, 0, 1, 1, 0, 0, 1731.53, 1369.26, 103.698, 3.65316, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243820, 32820, 0, 1, 1, 0, 0, 1812.44, 1387.72, 78.1535, 4.82501, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243821, 32820, 0, 1, 1, 0, 0, 1767.78, 1335.96, 90.7335, 3.74657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243822, 32820, 0, 1, 1, 0, 0, 1729.5, 1318.17, 111.616, 5.02367, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243823, 32820, 0, 1, 1, 0, 0, 1779.57, 1381.83, 90.4094, 2.32509, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243824, 32820, 0, 1, 1, 0, 0, 1789.48, 1335.2, 89.7295, 1.36136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243825, 32820, 0, 1, 1, 0, 0, 1795.91, 1342.81, 89.0869, 3.64774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243826, 32820, 0, 1, 1, 0, 0, -11098.5, -1830.69, 71.8642, 3.63551, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243827, 32820, 0, 1, 1, 0, 0, 2692.43, 530.939, 22.942, 2.97468, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243828, 32820, 0, 1, 1, 0, 0, 2598.77, 480.74, 24.1265, 2.61145, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243829, 32820, 0, 1, 1, 0, 0, 2487.49, 455.609, 39.5088, 0.0451597, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243830, 32820, 0, 1, 1, 0, 0, -5429.74, -524.295, 397.028, 1.47952, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243831, 32820, 0, 1, 1, 0, 0, -9393.06, -12.708, 61.7282, 0.609785, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243832, 32820, 0, 1, 1, 0, 0, -5251.04, -2890.35, 339.293, 0.932313, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243833, 32820, 0, 1, 1, 0, 0, 2553.22, 507.565, 18.0189, 4.67312, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243834, 32820, 0, 1, 1, 0, 0, 2522.67, 506.184, 38.5263, 0.121734, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243835, 32820, 0, 1, 1, 0, 0, 2607.11, 642.275, 28.6185, 4.66722, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243836, 32820, 0, 1, 1, 0, 0, -10722.2, 1669.9, 44.0413, 1.1882, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243837, 32820, 0, 1, 1, 0, 0, -9842.73, 1269.92, 41.3237, 0.834495, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243838, 32820, 0, 1, 1, 0, 0, -10324, 1419.24, 39.9909, 1.01209, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243839, 32820, 0, 1, 1, 0, 0, -10142.5, 1048.42, 36.8772, 2.92152, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243840, 32820, 0, 1, 1, 0, 0, -10093.3, 1053.26, 37.1329, 5.03173, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243841, 32820, 0, 1, 1, 0, 0, -10101.1, 1053.31, 36.5544, 1.38766, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243842, 32820, 0, 1, 1, 0, 0, 2364.21, 1314.57, 33.4123, 1.35871, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243843, 32820, 0, 1, 1, 0, 0, 2141.23, 640.716, 34.2212, 5.15441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243844, 32820, 0, 1, 1, 0, 0, 2293.08, 310.279, 35.611, 3.29253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243845, 32820, 0, 1, 1, 0, 0, 2326.63, 1351.72, 33.4583, 5.00745, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243846, 32820, 0, 1, 1, 0, 0, 2053.13, 1905.26, 101.451, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243847, 32820, 0, 1, 1, 0, 0, 2047.8, 1912.96, 102.799, 5.39307, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243848, 32820, 0, 1, 1, 0, 0, 2059.84, 1747.6, 82.0121, 5.46288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243849, 32820, 0, 1, 1, 0, 0, 2048.31, 1729.92, 80.3154, 1.5708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243850, 32820, 0, 1, 1, 0, 0, 1996.41, 1699.24, 79.0733, 4.19742, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243851, 32820, 0, 1, 1, 0, 0, 2039.44, 1637.45, 70.7334, 3.08192, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243852, 32820, 0, 1, 1, 0, 0, -9346.44, 171.041, 61.5582, 2.74061, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243853, 32820, 0, 1, 1, 0, 0, -9340.16, 183.339, 61.5512, 0.349854, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243854, 32820, 0, 1, 1, 0, 0, -9958.02, -155.297, 22.3585, 5.67327, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243855, 32820, 0, 1, 1, 0, 0, -9960.07, -154.13, 21.9752, 5.60729, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243856, 32820, 0, 1, 1, 0, 0, 2023.33, 1615.64, 71.4021, 2.48225, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243857, 32820, 0, 1, 1, 0, 0, 2018.5, 1613.13, 71.539, 5.58342, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243858, 32820, 0, 1, 1, 0, 0, 2007.43, 1635.3, 72.8902, 1.47816, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243859, 32820, 0, 1, 1, 0, 0, 2143.41, 1713.96, 88.0088, 4.44622, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243860, 32820, 0, 1, 1, 0, 0, 2121.93, 1762.63, 89.4838, 0.686555, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243861, 32820, 0, 1, 1, 0, 0, 2113.85, 1753.13, 81.2572, 6.05912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243862, 32820, 0, 1, 1, 0, 0, 797.762, -426.993, 135.484, 2.26174, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243863, 32820, 0, 1, 1, 0, 0, -7106.25, -3488.66, 242.38, 0.0916974, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243864, 32820, 0, 1, 1, 0, 0, -6863.72, -1537.16, 241.747, 3.64169, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243865, 32820, 0, 1, 1, 0, 0, 1849.51, -2142.72, 68.1751, 3.99197, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243866, 32820, 0, 1, 1, 0, 0, 2123.26, 1723.26, 75.4448, 0.848595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243867, 32820, 0, 1, 1, 0, 0, -9861.98, -223.795, 36.1011, 0.612494, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243868, 32820, 0, 1, 1, 0, 0, -9778.55, -1564.57, 41.988, 1.68063, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243869, 32820, 0, 1, 1, 0, 0, 2051.51, 1574.01, 74.622, 1.76244, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243870, 32820, 0, 1, 1, 0, 0, 2020.66, 1586.14, 74.7462, 2.30483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243871, 32820, 0, 1, 1, 0, 0, -9897.53, 1311.06, 42.2721, 2.52486, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243872, 32820, 0, 1, 1, 0, 0, 2239.51, 282.798, 35.1478, 5.28835, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243873, 32820, 0, 1, 1, 0, 0, 1877.29, 1485.36, 86.1047, 1.54772, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243874, 32820, 0, 1, 1, 0, 0, -5621.95, -472.837, 397.14, 5.67232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243875, 32820, 0, 1, 1, 0, 0, 1819.41, 219.233, 60.0732, 0.337883, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243876, 32820, 0, 1, 1, 0, 0, 603.436, 1338.35, 88.5123, 5.87362, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243877, 32820, 0, 1, 1, 0, 0, -156.058, -872.543, 57.013, 2.16546, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243878, 32820, 0, 1, 1, 0, 0, 2286.63, 403.383, 33.9185, 5.40354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243879, 32820, 0, 1, 1, 0, 0, 2055.57, 246.986, 99.7687, 5.24251, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243880, 32820, 0, 1, 1, 0, 0, 2061.88, 245.766, 99.7687, 3.6992, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243881, 32820, 0, 1, 1, 0, 0, 2069.68, 281.58, 97.0315, 1.49224, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243882, 32820, 0, 1, 1, 0, 0, 2062.2, 282.961, 97.0315, 1.13488, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243883, 32820, 0, 1, 1, 0, 0, 1922.26, 1487.58, 87.5093, 4.91906, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243884, 32820, 0, 1, 1, 0, 0, 1925.79, 1505.03, 87.8891, 2.73881, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243885, 32820, 0, 1, 1, 0, 0, 1879.95, 1531.01, 88.1731, 1.93335, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243886, 32820, 0, 1, 1, 0, 0, 1941.18, 1482.73, 80.68, 3.9118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243887, 32820, 0, 1, 1, 0, 0, 1936.46, 1470.72, 76.8807, 3.05083, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243888, 32820, 0, 1, 1, 0, 0, 1942.84, 1504.06, 86.6385, 1.42973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243889, 32820, 0, 1, 1, 0, 0, 1938.6, 1520.76, 88.0872, 1.41664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243890, 32820, 0, 1, 1, 0, 0, 1900.82, 1551.82, 88.9754, 5.83433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243891, 32820, 0, 1, 1, 0, 0, 1903.38, 1571.51, 89.0855, 6.14036, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243892, 32820, 0, 1, 1, 0, 0, 1939.42, 1543.6, 90.165, 1.29469, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243893, 32820, 0, 1, 1, 0, 0, 1916.89, 1579.84, 85.3748, 5.26223, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243894, 32820, 0, 1, 1, 0, 0, 1941.21, 1459.58, 73.8011, 3.80354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243895, 32820, 0, 1, 1, 0, 0, 1953.75, 1514.37, 88.0872, 5.63848, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243896, 32820, 0, 1, 1, 0, 0, 1952.23, 1474.47, 79.4592, 3.58341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243897, 32820, 0, 1, 1, 0, 0, 1926.11, 1583.07, 83.2642, 2.48772, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243898, 32820, 0, 1, 1, 0, 0, 1975.21, 1496.68, 85.9142, 3.69236, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243899, 32820, 0, 1, 1, 0, 0, 1908.9, 1605.24, 85.7089, 1.83176, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243900, 32820, 0, 1, 1, 0, 0, 1945.63, 1589.38, 82.286, 3.08945, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243901, 32820, 0, 1, 1, 0, 0, 1976.71, 1547.91, 87.0632, 2.66361, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243902, 32820, 0, 1, 1, 0, 0, 1978.92, 1574.15, 79.2329, 5.05864, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243903, 32820, 0, 1, 1, 0, 0, 1980.2, 1591.12, 82.4889, 3.00435, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243904, 32820, 0, 1, 1, 0, 0, 1910.31, 1641.54, 89.5206, 3.50196, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243905, 32820, 0, 1, 1, 0, 0, 1865.18, 1669.82, 93.3175, 2.92431, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243906, 32820, 0, 1, 1, 0, 0, 1926.77, 1661.55, 79.5127, 0.077276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243907, 32820, 0, 1, 1, 0, 0, 1981.57, 1528.8, 86.8198, 3.16503, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243908, 32820, 0, 1, 1, 0, 0, 1991.34, 1528.17, 80.8495, 4.96921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243909, 32820, 0, 1, 1, 0, 0, 2015.67, 1553.31, 79.1846, 0.825705, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243910, 32820, 0, 1, 1, 0, 0, 2000.95, 1587.97, 78.9962, 0.191096, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243911, 32820, 0, 1, 1, 0, 0, 1962.43, 1638.69, 78.8776, 3.91656, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243912, 32820, 0, 1, 1, 0, 0, 1944.29, 1667.7, 78.3294, 5.0045, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243913, 32820, 0, 1, 1, 0, 0, 2004.91, 1641.77, 73.3319, 3.15426, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243914, 32820, 0, 1, 1, 0, 0, 1931.45, 1688.03, 79.5437, 6.06427, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243915, 32820, 0, 1, 1, 0, 0, 1964.51, 1690.35, 78.3776, 1.10587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243916, 32820, 0, 1, 1, 0, 0, 1905.2, 1690.69, 86.5372, 4.7797, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243917, 32820, 0, 1, 1, 0, 0, 1980.72, 1677.9, 78.1821, 0.840403, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243918, 32820, 0, 1, 1, 0, 0, 1969.44, 1592.83, 82.4083, 5.2709, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243919, 32820, 0, 1, 1, 0, 0, 2018.37, 1524, 78.2645, 3.27533, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243920, 32820, 0, 1, 1, 0, 0, 2009.44, 1505.26, 73.9583, 0.280782, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243921, 32820, 0, 1, 1, 0, 0, 1930.14, 1606.7, 83.0828, 4.03171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243922, 32820, 0, 1, 1, 0, 0, 1986.28, 1453.64, 72.3036, 3.93793, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243923, 32820, 0, 1, 1, 0, 0, 2075.97, 1690.9, 70.36, 1.95063, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243924, 32820, 0, 1, 1, 0, 0, 1940.68, 1629.14, 80.2658, 0, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243925, 32820, 0, 1, 1, 0, 0, 1922.12, 1585.29, 83.6855, 4.3673, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243926, 32820, 0, 1, 1, 0, 0, 1912.03, 1588.68, 85.3317, 2.88977, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243927, 32820, 0, 1, 1, 0, 0, 1938.94, 1571.99, 82.8736, 2.15963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243928, 32820, 0, 1, 1, 0, 0, 1839.13, 1676.02, 97.8696, 2.48715, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243929, 32820, 0, 1, 1, 0, 0, -8440.71, 332.994, 122.579, 2.25725, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243930, 32820, 0, 1, 1, 0, 0, 1986.74, -3652.08, 120.22, 3.70105, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243931, 32820, 0, 1, 1, 0, 0, 1785.33, 255.107, 59.4587, 5.99957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243932, 32820, 0, 1, 1, 0, 0, 1780.83, 222.77, 59.5924, 6.05062, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243933, 32820, 0, 1, 1, 0, 0, 1782.32, 220.804, 59.682, 2.22355, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243934, 32820, 0, 1, 1, 0, 0, 1821.38, 222.513, 60.1257, 1.27628, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243935, 32820, 0, 1, 1, 0, 0, 1824.52, 227.309, 60.1057, 4.05004, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243936, 32820, 0, 1, 1, 0, 0, 1825.34, 223.486, 60.3934, 2.58265, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243937, 32820, 0, 1, 1, 0, 0, 1835.32, 263.231, 59.9427, 5.64963, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243938, 32820, 0, 1, 1, 0, 0, 1827.62, 265.956, 59.9849, 5.97439, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243939, 32820, 0, 1, 1, 0, 0, 1829.44, 268.891, 59.9694, 5.55464, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243940, 32820, 0, 1, 1, 0, 0, 1831.32, 263.327, 59.7531, 0.343526, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243941, 32820, 0, 1, 1, 0, 0, 1832.91, 267.348, 59.9059, 5.20296, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243942, 32820, 0, 1, 1, 0, 0, -9553.82, -1369.03, 51.2913, 4.73714, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243943, 32820, 0, 1, 1, 0, 0, -10569.2, 270.718, 30.3921, 2.22656, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243944, 32820, 0, 1, 1, 0, 0, -6300.15, -3497.22, 249.889, 0.483008, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243945, 32820, 0, 1, 1, 0, 0, 992.215, -1450.24, 61.5221, 2.99252, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243946, 32820, 0, 1, 1, 0, 0, -1208.24, -2664.68, 45.3872, 5.93412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243947, 32820, 0, 1, 1, 0, 0, -14298.2, 55.3486, 1.47578, 2.54818, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243948, 32820, 0, 1, 1, 0, 0, -612.235, -547.718, 36.5576, 4.5204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243949, 32820, 0, 1, 1, 0, 0, -3442.66, -947.768, 9.99993, 4.10152, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243950, 32820, 0, 1, 1, 0, 0, -14298.2, 55.3486, 1.47578, 2.54818, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243951, 32820, 0, 1, 1, 0, 0, -9386.23, 26.1518, 60.6273, 4.5204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243952, 32820, 0, 1, 1, 0, 0, -9432.88, -2136.9, 66.4413, 4.17939, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243953, 32820, 0, 1, 1, 0, 0, 183.036, -2129.67, 103.204, 3.66519, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243954, 32820, 0, 1, 1, 0, 0, -10645.8, 1061.62, 33.1256, 5.49779, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243955, 32820, 0, 1, 1, 0, 0, -5415.36, -497.514, 396.772, 4.76475, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243956, 32820, 0, 1, 1, 0, 0, -5243.61, -2892.8, 338.307, 1.93731, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243957, 32820, 0, 1, 1, 0, 0, -10697.6, -1158.41, 25.0413, 3.90954, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243958, 32820, 0, 1, 1, 0, 0, -1208.24, -2664.68, 45.3872, 5.93412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243959, 32820, 0, 1, 1, 0, 0, -10943.7, -3228.1, 41.5281, 4.5204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243960, 32820, 0, 1, 1, 0, 0, -9389.17, 26.7242, 60.1325, 4.5204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243961, 32820, 0, 1, 1, 0, 0, 1005.67, -1467.89, 61.4503, 3.50539, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243962, 32820, 0, 1, 1, 0, 0, 991.474, -1439.02, 64.4612, 4.86805, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243963, 32820, 0, 1, 1, 0, 0, 1002.38, -1469.14, 62.0178, 0.285257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243964, 32820, 0, 1, 1, 0, 0, 991.534, -1441.7, 63.8837, 1.57881, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243965, 32820, 0, 1, 1, 0, 0, -9547.6, 83.9896, 59.5094, 5.09636, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243966, 32820, 0, 1, 1, 0, 0, -9554.76, 82.208, 59.0394, 1.38046, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243967, 32820, 0, 1, 1, 0, 0, -9548.47, 115.032, 59.1045, 3.35103, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243968, 32820, 0, 1, 1, 0, 0, -5038.69, -793.428, 495.214, 2.36238, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243969, 32820, 0, 1, 1, 0, 0, -9145.26, 339.64, 90.6757, 0.052739, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243970, 32820, 0, 1, 1, 0, 0, -5041.32, -790.831, 495.211, 0.350973, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243971, 32820, 0, 1, 1, 0, 0, -9129.28, 362.629, 92.3738, 4.11774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243972, 32820, 0, 1, 1, 0, 0, -5037.43, -789.404, 495.213, 3.49257, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243973, 32820, 0, 1, 1, 0, 0, -9114.79, 338.765, 93.6277, 2.9147, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243974, 32820, 0, 1, 1, 0, 0, -9118.65, 325.3, 93.3136, 1.91986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243975, 32820, 0, 1, 1, 0, 0, -9128.35, 345.368, 94.0594, 2.68781, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243976, 32820, 0, 1, 1, 0, 0, -9130.68, 347.471, 93.6376, 5.67232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243977, 32820, 0, 1, 1, 0, 0, -9131.85, 358.836, 92.3964, 0.976147, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243978, 32820, 0, 1, 1, 0, 0, -9142.22, 339.801, 91.3411, 3.19433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243979, 32820, 0, 1, 1, 0, 0, -9118.48, 348.456, 93.9492, 3.78736, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243980, 32820, 0, 1, 1, 0, 0, -9130.91, 344.503, 93.7304, 0.942478, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243981, 32820, 0, 1, 1, 0, 0, -9130.69, 333.939, 93.3105, 0.837273, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243982, 32820, 0, 1, 1, 0, 0, -9126.82, 338.231, 93.9283, 3.97886, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243983, 32820, 0, 1, 1, 0, 0, -9127.97, 347.931, 93.9306, 3.87463, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243984, 32820, 0, 1, 1, 0, 0, -5210.18, -512.958, 389.592, 0.808568, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243985, 32820, 0, 1, 1, 0, 0, -5195.69, -515.611, 389.714, 5.10018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243986, 32820, 0, 1, 1, 0, 0, -5139.07, -579.316, 397.26, 4.03171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243987, 32820, 0, 1, 1, 0, 0, -5185.08, -608.256, 397.26, 0.506145, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243988, 32820, 0, 1, 1, 0, 0, -5149.61, -634.204, 397.265, 1.72788, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243989, 32820, 0, 1, 1, 0, 0, -5210.78, -506.068, 388.505, 5.52483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243990, 32820, 0, 1, 1, 0, 0, -5194.19, -519.275, 390.262, 1.95859, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243991, 32820, 0, 1, 1, 0, 0, -5207.01, -509.638, 388.825, 3.95016, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243992, 32820, 0, 1, 1, 0, 0, -5172.55, -586.553, 397.906, 0.046851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243993, 32820, 0, 1, 1, 0, 0, -5166.66, -586.277, 397.821, 3.18844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243994, 32820, 0, 1, 1, 0, 0, -5179.54, -596.714, 397.412, 4.97636, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243995, 32820, 0, 1, 1, 0, 0, -5178.24, -601.539, 397.367, 5.77101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243996, 32820, 0, 1, 1, 0, 0, -5170.15, -578.862, 397.368, 4.41018, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243997, 32820, 0, 1, 1, 0, 0, -5165.99, -608.422, 397.667, 1.14204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243998, 32820, 0, 1, 1, 0, 0, -5154.86, -585.464, 397.293, 6.03208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(243999, 32820, 0, 1, 1, 0, 0, -5141.22, -594.877, 397.547, 4.15292, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244000, 32820, 0, 1, 1, 0, 0, -5162.54, -600.876, 398.227, 4.91465, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244001, 32820, 0, 1, 1, 0, 0, -5149.82, -605.071, 398.556, 0.7283, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244002, 32820, 0, 1, 1, 0, 0, -5144.81, -600.602, 398.184, 3.86989, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244003, 32820, 0, 1, 1, 0, 0, -5142.32, -609.345, 398.355, 4.1853, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244004, 32820, 0, 1, 1, 0, 0, -5161.28, -607.041, 398.095, 3.42675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244005, 32820, 0, 1, 1, 0, 0, -5159.97, -627.401, 397.341, 0.481445, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244006, 32820, 0, 1, 1, 0, 0, -5150.19, -581.106, 397.262, 4.93512, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244007, 32820, 0, 1, 1, 0, 0, -5148.86, -587.004, 397.285, 1.79353, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244008, 32820, 0, 1, 1, 0, 0, -5155.71, -625.177, 397.533, 3.62304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244009, 32820, 0, 1, 1, 0, 0, -5160.29, -623.134, 397.509, 4.788, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244010, 32820, 0, 1, 1, 0, 0, -5145.6, -614.992, 398.375, 3.93084, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244011, 32820, 0, 1, 1, 0, 0, 1826.47, 231.201, 60.3244, 1.71042, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244012, 32820, 0, 1, 1, 0, 0, 1834.12, 242.622, 59.9811, 2.70282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244013, 32820, 0, 1, 1, 0, 0, 1829.69, 244.7, 60.1498, 4.44542, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244014, 32820, 0, 1, 1, 0, 0, 1826.81, 257.185, 59.8664, 4.06662, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244015, 32820, 0, 1, 1, 0, 0, 1815.06, 236.906, 60.5297, 0.263669, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244016, 32820, 0, 1, 1, 0, 0, 1824.81, 233.503, 60.3995, 0.366519, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244017, 32820, 0, 1, 1, 0, 0, 1828.39, 233.235, 60.4152, 2.80998, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244018, 32820, 0, 1, 1, 0, 0, 1813.03, 233.163, 60.6701, 0.206939, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244019, 32820, 0, 1, 1, 0, 0, 1828.56, 240.548, 60.8235, 1.30383, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244020, 32820, 0, 1, 1, 0, 0, 1816.68, 233.928, 60.6217, 2.06775, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244021, 32820, 0, 1, 1, 0, 0, 1826.44, 235.119, 60.824, 4.43314, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244022, 32820, 0, 1, 1, 0, 0, -9480.22, -1159.73, 50.8268, 0.586483, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244023, 32820, 0, 1, 1, 0, 0, -9871.14, 237.252, 19.4741, 4.31734, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244024, 32820, 0, 1, 1, 0, 0, -9879.33, 217.356, 14.1337, 5.82548, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244025, 32820, 0, 1, 1, 0, 0, -9879.43, 190.812, 16.6024, 1.79753, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244026, 32820, 0, 1, 1, 0, 0, -9884.25, 260.653, 34.8986, 2.57944, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244027, 32820, 0, 1, 1, 0, 0, -9885.02, 196.351, 15.2175, 2.27603, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244028, 32820, 0, 1, 1, 0, 0, -9852.19, 179.62, 20.9187, 3.22526, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244029, 32820, 0, 1, 1, 0, 0, -9822.68, 180.421, 22.9706, 3.13012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244030, 32820, 0, 1, 1, 0, 0, -9865.25, 170.29, 19.6687, 5.36632, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244031, 32820, 0, 1, 1, 0, 0, -9816.59, 120.354, 45.9586, 3.66559, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244032, 32820, 0, 1, 1, 0, 0, -9819.45, 129.544, 4.7231, 5.83605, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244033, 32820, 0, 1, 1, 0, 0, -9827.35, 124.626, 4.25697, 6.19969, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244034, 32820, 0, 1, 1, 0, 0, -9907.61, 178.849, 31.9818, 5.60655, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244035, 32820, 0, 1, 1, 0, 0, -9888.21, 153.554, 32.0522, 5.88405, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244036, 32820, 0, 1, 1, 0, 0, -9799.58, 167.104, 24.0743, 2.08218, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244037, 32820, 0, 1, 1, 0, 0, -9840.62, 161.11, 4.89257, 0.281934, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244038, 32820, 0, 1, 1, 0, 0, -9849.7, 135.178, 6.03231, 6.08721, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244039, 32820, 0, 1, 1, 0, 0, -9857.44, 157.624, 6.20103, 0.988133, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244040, 32820, 0, 1, 1, 0, 0, -9751.76, 122.076, 16.1832, 6.27415, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244041, 32820, 0, 1, 1, 0, 0, -9750.53, 109.906, 25.705, 3.41538, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244042, 32820, 0, 1, 1, 0, 0, -9800.68, 103.668, 24.789, 5.76924, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244043, 32820, 0, 1, 1, 0, 0, -9797.96, 109.575, 24.4197, 3.88405, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244044, 32820, 0, 1, 1, 0, 0, -9783.55, 84.901, 42.6198, 3.27819, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244045, 32820, 0, 1, 1, 0, 0, -9752.98, 120.348, 15.9225, 1.30766, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244046, 32820, 0, 1, 1, 0, 0, -9734.4, 138.944, 49.0226, 0.433051, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244047, 32820, 0, 1, 1, 0, 0, -9954.52, 222.797, 26.328, 4.94774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244048, 32820, 0, 1, 1, 0, 0, -9354.72, 167.942, 61.665, 0.27367, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244049, 32820, 0, 1, 1, 0, 0, 1773.81, 769.425, 55.5537, 3.61274, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244050, 32820, 0, 1, 1, 0, 0, 1719.01, 1446.6, 124.313, 2.87145, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244051, 32820, 0, 1, 1, 0, 0, -11023.7, 1429.76, 43.6226, 3.60857, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244052, 32820, 0, 1, 1, 0, 0, -10314.4, 1417.72, 40.3659, 1.51624, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244053, 32820, 0, 1, 1, 0, 0, -9854.85, 1275.5, 40.9487, 3.8068, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244054, 32820, 0, 1, 1, 0, 0, 1887.28, 1494.68, 87.9338, 4.62341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244055, 32820, 0, 1, 1, 0, 0, -9456.54, -1160.68, 52.9803, 4.11778, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244056, 32820, 0, 1, 1, 0, 0, -9342.2, 187.984, 61.5586, 5.25467, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244057, 32820, 0, 1, 1, 0, 0, -10731.8, 1678.61, 45.4163, 3.35598, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244058, 32820, 0, 1, 1, 0, 0, -10145.4, 1059.4, 36.4085, 3.94727, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244059, 32820, 0, 1, 1, 0, 0, 2027.17, 187.734, 35.9719, 3.51091, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244060, 32820, 0, 1, 1, 0, 0, -9321.16, 270.756, 68.0387, 6.23488, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244061, 32820, 0, 1, 1, 0, 0, -9877.59, 1295.1, 42.1903, 3.43758, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244062, 32820, 0, 1, 1, 0, 0, -9861.1, 1290.83, 41.8237, 1.62479, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244063, 32820, 0, 1, 1, 0, 0, -9164.88, -6.60355, 79.3901, 4.80705, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244064, 32820, 0, 1, 1, 0, 0, -9162.92, -2.91795, 79.6812, 0.60909, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244065, 32820, 0, 1, 1, 0, 0, -9167.2, 19.38, 78.803, 1.52015, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244066, 32820, 0, 1, 1, 0, 0, -9162.07, 13.6444, 78.6699, 5.53354, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244067, 32820, 0, 1, 1, 0, 0, -9180.29, -8.10362, 78.8, 3.87635, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244068, 32820, 0, 1, 1, 0, 0, -9189.71, 0.452663, 77.6916, 3.02419, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244069, 32820, 0, 1, 1, 0, 0, -9344.05, 175.877, 61.5584, 3.59669, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244070, 32820, 0, 1, 1, 0, 0, -9318.67, 173.348, 61.613, 2.83957, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244071, 32820, 0, 1, 1, 0, 0, -9329.31, 166.352, 61.5815, 1.76357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244072, 32820, 0, 1, 1, 0, 0, 2310.73, 296.853, 37.3108, 4.44553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244073, 32820, 0, 1, 1, 0, 0, -5607.53, -511.287, 402.237, 1.0253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244074, 32820, 0, 1, 1, 0, 0, -9474.49, 87.242, 56.7402, 2.98374, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244075, 32820, 0, 1, 1, 0, 0, -9322.06, 168.47, 61.6066, 2.40367, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244076, 32820, 0, 1, 1, 0, 0, -5604.8, -527.253, 399.659, 2.43902, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244077, 32820, 0, 1, 1, 0, 0, -9460.17, 26.0472, 56.3399, 5.44596, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244078, 32820, 0, 1, 1, 0, 0, -9349.19, 176.153, 61.726, 5.18634, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244079, 32820, 0, 1, 1, 0, 0, -9350.81, 171.018, 61.7532, 1.0198, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244080, 32820, 0, 1, 1, 0, 0, -9337.56, 188.283, 61.5117, 3.72314, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244081, 32820, 0, 1, 1, 0, 0, 2255.62, 271.928, 34.4734, 2.52523, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244082, 32820, 0, 1, 1, 0, 0, 2261.95, 280.004, 34.6234, 2.42705, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244083, 32820, 0, 1, 1, 0, 0, 2057.72, 357.983, 82.4699, 5.64937, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244084, 32820, 0, 1, 1, 0, 0, -7916.41, -1354.48, 134.08, 3.19768, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244085, 32820, 0, 1, 1, 0, 0, -7986.89, -2355.5, 124.949, 4.57919, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244086, 32820, 0, 1, 1, 0, 0, -9449.18, -2123.47, 69.2066, 6.03994, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244087, 32820, 0, 1, 1, 0, 0, -3433.67, -959.299, 9.56594, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244088, 32820, 0, 1, 1, 0, 0, -14277.8, 54.594, 0.903981, 2.87979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244089, 32820, 0, 1, 1, 0, 0, -14289.6, 46.9671, 0.852089, 6.02139, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244090, 32820, 0, 1, 1, 0, 0, -14285.2, 45.2736, 0.5652, 1.76951, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244091, 32820, 0, 1, 1, 0, 0, -14282.4, 55.3707, 0.467201, 6.21337, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244092, 32820, 0, 1, 1, 0, 0, -1197.29, -2680.87, 46.3772, 6.12611, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244093, 32820, 0, 1, 1, 0, 0, -1202.46, -2657.93, 45.8036, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244094, 32820, 0, 1, 1, 0, 0, -10968, -3234.34, 41.4491, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244095, 32820, 0, 1, 1, 0, 0, -9375.14, 26.3486, 61.714, 4.83456, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244096, 32820, 0, 1, 1, 0, 0, -9383.17, 11.5458, 61.1362, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244097, 32820, 0, 1, 1, 0, 0, -9373.36, 22.8965, 62.0908, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244098, 32820, 0, 1, 1, 0, 0, -5428.45, -486.615, 396.646, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244099, 32820, 0, 1, 1, 0, 0, -5250.07, -2891.32, 339.267, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244100, 32820, 0, 1, 1, 0, 0, -6686.65, -2194.68, 248.353, 0.145253, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244101, 32820, 0, 1, 1, 0, 0, -6685.3, -2199.44, 248.978, 3.21141, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244102, 32820, 0, 1, 1, 0, 0, -474.941, -4528.3, 12.8381, 4.66003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244103, 32820, 0, 1, 1, 0, 0, -463.082, -4537.73, 9.4355, 2.15069, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244104, 32820, 0, 1, 1, 0, 0, -468.089, -4537.65, 10.3289, 1.34167, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244105, 32820, 0, 1, 1, 0, 0, 1792.44, 219.541, 60.0122, 1.5708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244106, 32820, 0, 1, 1, 0, 0, 1793.16, 224.844, 59.7142, 4.46804, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244107, 32820, 0, 1, 1, 0, 0, 1816.48, 217.623, 59.9269, 2.04204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244108, 32820, 0, 1, 1, 0, 0, -10351.3, -3292.1, 23.2491, 4.5204, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244109, 32820, 0, 1, 1, 0, 0, -9437.42, -2137.57, 66.7224, 1.98536, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244110, 32820, 0, 1, 1, 0, 0, -9434.02, -2135.57, 66.2969, 3.75246, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244111, 32820, 0, 1, 1, 0, 0, 178.85, -2118.32, 104.996, 0.85135, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244112, 32820, 0, 1, 1, 0, 0, -3427.64, -949.945, 9.66967, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244113, 32820, 0, 1, 1, 0, 0, -1201.28, -2660.02, 45.4031, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244114, 32820, 0, 1, 1, 0, 0, -10936.2, -3219.52, 41.4308, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244115, 32820, 0, 1, 1, 0, 0, -10968.9, -3230.71, 41.5834, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244116, 32820, 0, 1, 1, 0, 0, -10935.7, -3215.98, 41.4308, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244117, 32820, 0, 1, 1, 0, 0, -5430.02, -489.223, 396.787, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244118, 32820, 0, 1, 1, 0, 0, -5243.4, -2868.25, 336.974, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244119, 32820, 0, 1, 1, 0, 0, -6688.79, -2191.26, 247.728, 5.94547, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244120, 32820, 0, 1, 1, 0, 0, -475.423, -4532.37, 12.327, 0.034308, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244121, 32820, 0, 1, 1, 0, 0, 1814.13, 220.927, 59.5969, 5.21853, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244122, 32820, 0, 1, 1, 0, 0, -9449.25, -2120.39, 69.2066, 4.57276, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244123, 32820, 0, 1, 1, 0, 0, -9382.33, 14.4817, 61.6174, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244124, 32820, 0, 1, 1, 0, 0, -5431.74, -502.427, 397.758, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244125, 32820, 0, 1, 1, 0, 0, -5433.93, -500.603, 397.292, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244126, 32820, 0, 1, 1, 0, 0, -5242.92, -2871.7, 338.068, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244127, 32820, 0, 1, 1, 0, 0, -5250.77, -2895.2, 338.614, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244128, 32820, 0, 1, 1, 0, 0, -1195.37, -2682.08, 47.0076, 2.53073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244129, 32820, 0, 1, 1, 0, 0, 186.365, -2115.52, 105.464, 3.12523, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244130, 32820, 0, 1, 1, 0, 0, 187.437, -2112.56, 106.084, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244131, 32820, 0, 1, 1, 0, 0, 177.178, -2115.24, 105.307, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244132, 32820, 0, 1, 1, 0, 0, -1143.94, -3549.91, 52.3624, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244133, 32820, 0, 1, 1, 0, 0, -1142.06, -3553.01, 52.2374, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244134, 32820, 0, 1, 1, 0, 0, -1115.13, -3547.66, 50.1345, 2.53073, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244135, 32820, 0, 1, 1, 0, 0, -1117.82, -3543.86, 50.2867, 5.34071, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244136, 32820, 0, 1, 1, 0, 0, -10684.3, -1148.58, 25.833, 5.39903, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244137, 32820, 0, 1, 1, 0, 0, -10682.6, -1168.07, 24.7525, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244138, 32820, 0, 1, 1, 0, 0, -10681.5, -1164.25, 25.208, 1.03306, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244139, 32820, 0, 1, 1, 0, 0, -10680.3, -1147.93, 25.833, 5.02826, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244140, 32820, 0, 1, 1, 0, 0, -10352, -3296.74, 23.6612, 5.58471, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244141, 32820, 0, 1, 1, 0, 0, -10350.1, -3307.59, 23.2149, 0.191986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244142, 32820, 0, 1, 1, 0, 0, -10344.4, -3306.41, 23.1961, 2.02267, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244143, 32820, 0, 1, 1, 0, 0, -14371.5, 132.86, 1.04293, 1.78024, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244144, 32820, 0, 1, 1, 0, 0, -14388.8, 125.666, 1.1453, 5.5676, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244145, 32820, 0, 1, 1, 0, 0, -14385.1, 122.559, 1.3256, 0.642415, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244146, 32820, 0, 1, 1, 0, 0, -14374.6, 137.59, 0.44237, 4.40481, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244147, 32820, 0, 1, 1, 0, 0, -122.378, -813.281, 55.6416, 3.01942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244148, 32820, 0, 1, 1, 0, 0, -125.86, -811.308, 55.3297, 5.88176, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244149, 32820, 0, 1, 1, 0, 0, -129.014, -823.608, 55.2595, 0.593412, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244150, 32820, 0, 1, 1, 0, 0, -125.36, -821.476, 55.4535, 3.56047, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244151, 32820, 0, 1, 1, 0, 0, -4708.43, -1236.96, 501.743, 1.11701, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244152, 32820, 0, 1, 1, 0, 0, -4692.72, -1218.07, 501.743, 0.750492, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244153, 32820, 0, 1, 1, 0, 0, -4706.34, -1233.23, 501.743, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244154, 32820, 0, 1, 1, 0, 0, -4688.58, -1213.5, 501.743, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244155, 32820, 0, 1, 1, 0, 0, -10647, 1072.17, 34.0896, 1.51844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244156, 32820, 0, 1, 1, 0, 0, -10640.6, 1080.97, 34.8855, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244157, 32820, 0, 1, 1, 0, 0, -10646.3, 1075.05, 34.6687, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244158, 32820, 0, 1, 1, 0, 0, -10642.2, 1083.53, 35.0052, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244159, 32820, 0, 1, 1, 0, 0, -614.224, -535.796, 36.2243, 2.21657, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244160, 32820, 0, 1, 1, 0, 0, -615.6, -532.523, 35.7472, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244161, 32820, 0, 1, 1, 0, 0, -8840.87, 851.164, 98.8638, 1.91986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244162, 32820, 0, 1, 1, 0, 0, -8842.71, 856.191, 98.5909, 4.99164, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244163, 32820, 0, 1, 1, 0, 0, 593.821, 1350.02, 90.3997, 0.490553, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244164, 32820, 0, 1, 1, 0, 0, 595.365, 1345.8, 90.1562, 1.8675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244165, 32820, 0, 1, 1, 0, 0, 602.084, 1351.74, 88.1745, 3.05093, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244166, 32820, 0, 1, 1, 0, 0, 600.03, 1355.18, 88.8279, 4.07527, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244167, 32820, 0, 1, 1, 0, 0, -7603.89, -2066, 129.675, 6.24828, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244168, 32820, 0, 1, 1, 0, 0, -7595.41, -2060.63, 131.677, 2.99611, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244169, 32820, 0, 1, 1, 0, 0, -7592.49, -2065.33, 131.078, 2.35619, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244170, 32820, 0, 1, 1, 0, 0, -7599.02, -2067, 129.618, 2.84489, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244171, 32820, 0, 1, 1, 0, 0, -623.304, -530.146, 34.2168, 4.2586, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244172, 32820, 0, 1, 1, 0, 0, -623.67, -533.012, 34.4668, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244173, 32820, 0, 1, 1, 0, 0, -3434.67, -956.682, 9.65595, 5.23599, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244174, 32820, 0, 1, 1, 0, 0, -3428.97, -953.84, 10.2242, 1.44862, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244175, 32820, 0, 1, 1, 0, 0, -11252.4, 1881.89, 35.4734, 3.69371, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244176, 32820, 0, 1, 1, 0, 0, -8932.72, -163.066, 80.9754, 5.81801, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244177, 32820, 0, 1, 1, 0, 0, -9238.75, -2055.19, 77.099, 4.86356, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244178, 32820, 0, 1, 1, 0, 0, -9429.92, 56.1355, 56.7913, 2.98451, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244179, 32820, 0, 1, 1, 0, 0, -9431.01, 58.3279, 56.7729, 5.48033, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244180, 32820, 0, 1, 1, 0, 0, -9428.72, 54.0571, 56.819, 1.91986, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244181, 32820, 0, 1, 1, 0, 0, -9431.32, 55.0524, 56.6871, 3.38594, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244182, 32820, 0, 1, 1, 0, 0, -9431.98, 56.7107, 56.6996, 6.16101, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244183, 32820, 0, 1, 1, 0, 0, 2052.22, 294.354, 56.9512, 3.27529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244184, 32820, 0, 1, 1, 0, 0, 1945.08, 252.741, 44.3246, 3.58978, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244185, 32820, 0, 1, 1, 0, 0, 1832.47, 210.797, 60.312, 2.04222, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244186, 32820, 0, 1, 1, 0, 0, -5151.65, -852.495, 508.667, 4.58185, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244187, 32820, 0, 1, 1, 0, 0, 1828.96, 210.695, 60.2619, 1.24504, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244188, 32820, 0, 1, 1, 0, 0, -9400.13, 111.152, 60.0272, 5.17295, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244189, 32820, 0, 1, 1, 0, 0, -5155.07, -854.489, 508.115, 5.0845, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244190, 32820, 0, 1, 1, 0, 0, -9143.81, 412.898, 93.7079, 5.32893, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244191, 32820, 0, 1, 1, 0, 0, -9109.08, 365.884, 93.9828, 2.40332, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244192, 32820, 0, 1, 1, 0, 0, -9116.37, 334.754, 93.3562, 1.99884, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244193, 32820, 0, 1, 1, 0, 0, -9177.49, 414.626, 90.1926, 5.65879, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244194, 32820, 0, 1, 1, 0, 0, -9170.68, 377.801, 88.388, 5.18362, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244195, 32820, 0, 1, 1, 0, 0, -9140.75, 332.216, 91.2239, 2.34441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244196, 32820, 0, 1, 1, 0, 0, -9227.25, 318.984, 73.9797, 5.50171, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244197, 32820, 0, 1, 1, 0, 0, -9155.61, 261.754, 80.1009, 2.98844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244198, 32820, 0, 1, 1, 0, 0, -9468.33, 24.9295, 56.5369, 6.0912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244199, 32820, 0, 1, 1, 0, 0, -9465.93, 24.9355, 56.6126, 3.12414, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244200, 32820, 0, 1, 1, 0, 0, -8866.35, 676.362, 97.9864, 0.034907, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244201, 32820, 0, 1, 1, 0, 0, -8864.07, 675.996, 97.9864, 2.87979, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244202, 32820, 0, 1, 1, 0, 0, -10647.7, 1174.96, 34.4276, 1.09956, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244203, 32820, 0, 1, 1, 0, 0, -10645.7, 1177.46, 34.5556, 4.13643, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244204, 32820, 0, 1, 1, 0, 0, -10523.2, -1164.94, 27.5597, 1.5708, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244205, 32820, 0, 1, 1, 0, 0, -10523.5, -1162.52, 27.5597, 4.66003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244206, 32820, 0, 1, 1, 0, 0, -9223.84, -2153.94, 64.0168, 3.01942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244207, 32820, 0, 1, 1, 0, 0, -9225.23, -2153.85, 64.0168, 6.23082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244208, 32820, 0, 1, 1, 0, 0, -5581.24, -525.341, 400.846, 1.51844, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244209, 32820, 0, 1, 1, 0, 0, -5581.07, -523.102, 400.846, 4.62512, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244210, 32820, 0, 1, 1, 0, 0, -4853.14, -870.297, 501.997, 4.81711, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244211, 32820, 0, 1, 1, 0, 0, -4852.92, -872.19, 501.997, 1.69297, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244212, 32820, 0, 1, 1, 0, 0, -14461.9, 491.803, 15.2063, 0.837758, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244213, 32820, 0, 1, 1, 0, 0, -14460.8, 492.998, 15.208, 3.92699, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244214, 32820, 0, 1, 1, 0, 0, 1635.82, 233.67, -43.0193, 1.11701, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244215, 32820, 0, 1, 1, 0, 0, 1637.09, 236.273, -43.0193, 4.34587, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244216, 32820, 0, 1, 1, 0, 0, -11.5524, -932.199, 57.2556, 5.84685, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244217, 32820, 0, 1, 1, 0, 0, -9.5064, -933.083, 57.2556, 2.74017, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244218, 32820, 0, 1, 1, 0, 0, 2249.08, 240.226, 34.3437, 6.14356, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244219, 32820, 0, 1, 1, 0, 0, 2251.53, 240.007, 34.3437, 3.05433, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244220, 32820, 0, 1, 1, 0, 0, -6665.69, -2167.53, 245.456, 5.67232, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244221, 32820, 0, 1, 1, 0, 0, -6663, -2169.4, 245.456, 2.49582, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244222, 32820, 0, 1, 1, 0, 0, -858.777, -558.361, 11.7749, 4.66003, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244223, 32820, 0, 1, 1, 0, 0, -858.831, -559.944, 11.7749, 1.50098, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244224, 32820, 0, 1, 1, 0, 0, -9566.38, 31.1655, 61.4444, 1.58992, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244225, 32820, 0, 1, 1, 0, 0, -9541.73, 87.4378, 59.3029, 6.23082, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244226, 32820, 0, 1, 1, 0, 0, -9540.56, 115.219, 59.1773, 4.62012, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244227, 32820, 0, 1, 1, 0, 0, -9525.15, 89.6348, 58.9238, 4.11548, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244228, 32820, 0, 1, 1, 0, 0, -11265.3, 1875.47, 36.7309, 5.89441, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244229, 32820, 0, 1, 1, 0, 0, -11259.8, 1888.13, 35.7742, 4.43043, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244230, 32820, 0, 1, 1, 0, 0, -11251.2, 1870.46, 35.5459, 2.39153, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244231, 32820, 0, 1, 1, 0, 0, -7442.29, -2257.15, 347.476, 5.51524, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244232, 32820, 0, 1, 1, 0, 0, -9330.46, 180.936, 61.6792, 4.1716, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244233, 32820, 0, 1, 1, 0, 0, -9075.59, 426.68, 93.0562, 3.78874, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244234, 32820, 0, 1, 1, 0, 0, -9180.08, 300.471, 78.2777, 1.48024, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244235, 32820, 0, 1, 1, 0, 0, -9082.31, 410.951, 92.2809, 3.21226, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244236, 32820, 0, 1, 1, 0, 0, -9045.34, -46.7572, 88.3206, 4.60601, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244237, 32820, 0, 1, 1, 0, 0, -9044.58, -43.6128, 88.3693, 1.24136, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244238, 32820, 0, 1, 1, 0, 0, -9068.83, -382.097, 73.4742, 1.12514, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244239, 32820, 0, 1, 1, 0, 0, -9067.18, -379.59, 73.4847, 4.20468, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244240, 32820, 0, 1, 1, 0, 0, -9083.1, -370.122, 73.4512, 2.04719, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244241, 32820, 0, 1, 1, 0, 0, -9093.95, -363.895, 73.4845, 1.58774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244242, 32820, 0, 1, 1, 0, 0, -9093.79, -350.975, 73.4519, 0.331884, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244243, 32820, 0, 1, 1, 0, 0, -9114.81, -341.066, 73.2501, 1.02225, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244244, 32820, 0, 1, 1, 0, 0, -9111.6, -339.933, 73.3671, 2.90956, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244245, 32820, 0, 1, 1, 0, 0, -9085.03, -310.686, 73.4186, 1.76288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244246, 32820, 0, 1, 1, 0, 0, -9085.39, -308.122, 73.3757, 4.73482, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244247, 32820, 0, 1, 1, 0, 0, -9067.4, -299.552, 73.4566, 5.35529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244248, 32820, 0, 1, 1, 0, 0, -9027.26, -326.174, 73.7017, 1.51626, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244249, 32820, 0, 1, 1, 0, 0, -9031.94, -346.149, 74.21, 4.03346, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244250, 32820, 0, 1, 1, 0, 0, -9033.21, -347.614, 74.1532, 0.925643, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244251, 32820, 0, 1, 1, 0, 0, -9053.11, -362.477, 73.5042, 1.69219, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244252, 32820, 0, 1, 1, 0, 0, -9056.23, -339.958, 73.4526, 1.3529, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244253, 32820, 0, 1, 1, 0, 0, -8852.69, -373.834, 70.594, 2.33229, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244254, 32820, 0, 1, 1, 0, 0, -9002.91, -297.798, 71.1119, 1.96551, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244255, 32820, 0, 1, 1, 0, 0, -9099.05, -316.07, 73.2522, 4.72462, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244256, 32820, 0, 1, 1, 0, 0, -9100.01, -318.048, 73.2989, 0.825899, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244257, 32820, 0, 1, 1, 0, 0, -9098.24, -317.918, 73.3343, 2.3535, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244258, 32820, 0, 1, 1, 0, 0, -8686.07, -108.569, 89.1135, 2.78625, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244259, 32820, 0, 1, 1, 0, 0, -8666.96, -117.197, 92.3837, 3.99341, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244260, 32820, 0, 1, 1, 0, 0, -8670.19, -121.659, 92.0285, 2.88129, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244261, 32820, 0, 1, 1, 0, 0, -8669.95, -127.286, 92.3917, 2.34329, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244262, 32820, 0, 1, 1, 0, 0, -9040.38, -303.146, 74.3207, 2.427, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244263, 32820, 0, 1, 1, 0, 0, -9016.16, -310.595, 73.9234, 0.27187, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244264, 32820, 0, 1, 1, 0, 0, -9064, -283.949, 73.6745, 3.43703, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244265, 32820, 0, 1, 1, 0, 0, -9065.73, -284.406, 73.7253, 0.336275, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244266, 32820, 0, 1, 1, 0, 0, -8950.56, -429.528, 65.1177, 2.42386, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244267, 32820, 0, 1, 1, 0, 0, -8958.33, -432.896, 64.651, 1.27326, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244268, 32820, 0, 1, 1, 0, 0, -9142.99, -340.123, 72.6333, 0.0818056, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244269, 32820, 0, 1, 1, 0, 0, -9113.54, -339.171, 73.3014, 4.93007, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244270, 32820, 0, 1, 1, 0, 0, -8768.27, -178.215, 83.3675, 2.51811, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244271, 32820, 0, 1, 1, 0, 0, -8775.73, -181.91, 82.5802, 3.23282, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244272, 32820, 0, 1, 1, 0, 0, -8770.16, -164.681, 82.478, 0.248304, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244273, 32820, 0, 1, 1, 0, 0, -8756.49, -174.042, 84.9656, 3.31921, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244274, 32820, 0, 1, 1, 0, 0, -8781.03, -131.108, 82.3968, 0.897357, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244275, 32820, 0, 1, 1, 0, 0, -8785.22, -107.864, 83.2028, 0.123741, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244276, 32820, 0, 1, 1, 0, 0, -8776.25, -110.324, 83.546, 3.32031, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244277, 32820, 0, 1, 1, 0, 0, -8617.63, -139.172, 87.0543, 4.94263, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244278, 32820, 0, 1, 1, 0, 0, -8597.56, -168.066, 86.7534, 3.37969, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244279, 32820, 0, 1, 1, 0, 0, -8613.21, -165.797, 85.7466, 2.33118, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244280, 32820, 0, 1, 1, 0, 0, -8633.86, -149.127, 86.0851, 2.02487, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244281, 32820, 0, 1, 1, 0, 0, -8631.62, -143.587, 86.3522, 3.1205, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244282, 32820, 0, 1, 1, 0, 0, -8647.69, -133.363, 87.7432, 2.11912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244283, 32820, 0, 1, 1, 0, 0, -8656.88, -124.537, 90.8129, 3.17155, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244284, 32820, 0, 1, 1, 0, 0, -8557.35, -209.402, 84.2385, 3.1912, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244285, 32820, 0, 1, 1, 0, 0, -5387.28, 37.1367, 395.534, 6.2025, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244286, 32820, 0, 1, 1, 0, 0, -2958.56, -1753.26, 9.50943, 5.57129, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244287, 32820, 0, 1, 1, 0, 0, -9191.3, -2309.23, 89.4674, 4.11041, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244288, 32820, 0, 1, 1, 0, 0, -9475.93, -3009.16, 134.516, 0.205501, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244289, 32820, 0, 1, 1, 0, 0, 2281.77, 453.836, 33.9988, 4.05597, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244290, 32820, 0, 1, 1, 0, 0, -8253.41, -2609.76, 133.155, 1.12654, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244291, 32820, 0, 1, 1, 0, 0, -8246.66, -2607.97, 133.155, 5.62294, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244292, 32820, 0, 1, 1, 0, 0, -8243.34, -2610.47, 133.155, 2.40595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244293, 32820, 0, 1, 1, 0, 0, -8260.93, -2615.06, 133.292, 5.39675, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244294, 32820, 0, 1, 1, 0, 0, -8258.65, -2617.86, 133.251, 2.3871, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244295, 32820, 0, 1, 1, 0, 0, -6689.68, -2200.1, 248.974, 0.0691265, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244296, 32820, 0, 1, 1, 0, 0, 2286.11, 463.02, 33.7305, 3.4143, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244297, 32820, 0, 1, 1, 0, 0, 2283.48, 462.282, 33.7857, 0.615141, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244298, 32820, 0, 1, 1, 0, 0, 2285.45, 441.484, 34.6447, 6.04774, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244299, 32820, 0, 1, 1, 0, 0, 2287.89, 440.899, 35.0368, 3.14177, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244300, 32820, 0, 1, 1, 0, 0, -9327.92, 185.507, 62.7096, 4.07265, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244301, 32820, 0, 1, 1, 0, 0, 2269.4, 950.182, 46.8056, 1.88271, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244302, 32820, 0, 1, 1, 0, 0, 2291.65, 732.825, 33.7658, 5.40522, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244303, 32820, 0, 1, 1, 0, 0, 2589.44, 475.936, 25.3739, 3.21396, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244304, 32820, 0, 1, 1, 0, 0, 2560.58, 1207.44, 66.8358, 3.85013, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244305, 32820, 0, 1, 1, 0, 0, 2047.95, 292.193, 56.5388, 3.68053, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244306, 32820, 0, 1, 1, 0, 0, -14293.8, 517.256, 8.95354, 3.72474, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244307, 32820, 0, 1, 1, 0, 0, -3756.55, -762.724, 9.32934, 2.4319, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244308, 32820, 0, 1, 1, 0, 0, -5040.8, -803.692, 495.129, 2.81595, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244309, 32820, 0, 1, 1, 0, 0, -5087.72, -803.254, 495.127, 3.21995, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244310, 32820, 0, 1, 1, 0, 0, -5097.2, -797.589, 495.127, 0.435709, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244311, 32820, 0, 1, 1, 0, 0, -5083.38, -787.805, 495.911, 4.78682, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244312, 32820, 0, 1, 1, 0, 0, -5074.94, -799.68, 495.127, 3.3299, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244313, 32820, 0, 1, 1, 0, 0, -5076.41, -803.853, 495.127, 2.04185, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244314, 32820, 0, 1, 1, 0, 0, -5090.39, -807.055, 495.08, 2.00258, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244315, 32820, 0, 1, 1, 0, 0, -5095.91, -792.882, 495.157, 5.22664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244316, 32820, 0, 1, 1, 0, 0, -5079.43, -789.073, 495.722, 3.73046, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244317, 32820, 0, 1, 1, 0, 0, -5079.51, -793.698, 495.44, 2.5445, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244318, 32820, 0, 1, 1, 0, 0, -5081.14, -803.525, 495.128, 0.848043, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244319, 32820, 0, 1, 1, 0, 0, -5090.63, -807.07, 495.078, 1.75518, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244320, 32820, 0, 1, 1, 0, 0, -5094.72, -806.292, 495.161, 0.745942, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244321, 32820, 0, 1, 1, 0, 0, -5095.77, -802.078, 495.132, 5.84318, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244322, 32820, 0, 1, 1, 0, 0, -5089.96, -796.654, 495.151, 2.80369, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244323, 32820, 0, 1, 1, 0, 0, -5082.59, -795.26, 495.322, 1.50385, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244324, 32820, 0, 1, 1, 0, 0, -5082.54, -798.894, 495.137, 5.86674, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244325, 32820, 0, 1, 1, 0, 0, -5071.89, -801.345, 495.128, 0.094064, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244326, 32820, 0, 1, 1, 0, 0, -9116.52, 314.55, 93.0822, 4.65069, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244327, 32820, 0, 1, 1, 0, 0, -9115.78, 325.128, 93.2047, 4.70174, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244328, 32820, 0, 1, 1, 0, 0, -9114.1, 336.911, 93.4026, 4.61927, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244329, 32820, 0, 1, 1, 0, 0, -9113.13, 348.931, 93.5571, 4.53288, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244330, 32820, 0, 1, 1, 0, 0, -9110.13, 345.405, 93.4552, 3.04455, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244331, 32820, 0, 1, 1, 0, 0, -9111.31, 333.146, 93.2693, 3.15058, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244332, 32820, 0, 1, 1, 0, 0, -9111.83, 320.705, 93.1879, 2.86784, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244333, 32820, 0, 1, 1, 0, 0, -9113.34, 310.046, 93.2807, 2.96208, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244334, 32820, 0, 1, 1, 0, 0, -9114.8, 307.034, 93.4531, 2.28664, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244335, 32820, 0, 1, 1, 0, 0, -9119.35, 307.993, 93.1764, 0.637305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244336, 32820, 0, 1, 1, 0, 0, -9114.01, 317.994, 93.1465, 2.10207, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244337, 32820, 0, 1, 1, 0, 0, -9118.64, 318.192, 93.207, 0.484153, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244338, 32820, 0, 1, 1, 0, 0, -9112.75, 329.259, 93.1734, 2.12564, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244339, 32820, 0, 1, 1, 0, 0, -9116.74, 329.417, 93.1118, 0.923976, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244340, 32820, 0, 1, 1, 0, 0, -9112.46, 341.845, 93.5009, 1.93714, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244341, 32820, 0, 1, 1, 0, 0, -9116.35, 342.758, 93.8079, 0.637305, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244342, 32820, 0, 1, 1, 0, 0, -9118.91, 350.746, 93.735, 2.14134, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244343, 32820, 0, 1, 1, 0, 0, -9118.18, 359.164, 93.2702, 1.90179, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244344, 32820, 0, 1, 1, 0, 0, -9111.63, 353.697, 93.4015, 2.40837, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244345, 32820, 0, 1, 1, 0, 0, -9127.56, 351.404, 94.2329, 2.13741, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244346, 32820, 0, 1, 1, 0, 0, -9110.83, 366.354, 94.0632, 2.67934, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244347, 32820, 0, 1, 1, 0, 0, -9125.02, 352.824, 94.2342, 2.1217, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244348, 32820, 0, 1, 1, 0, 0, 1819.47, 256.351, 60.0177, 6.08671, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244349, 32820, 0, 1, 1, 0, 0, 1823.47, 259.36, 59.921, 4.44916, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244350, 32820, 0, 1, 1, 0, 0, 1826.98, 256.962, 59.7774, 3.40851, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244351, 32820, 0, 1, 1, 0, 0, 1825.59, 252.345, 59.9664, 2.01836, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244352, 32820, 0, 1, 1, 0, 0, 1830.29, 254.158, 59.6774, 6.02781, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244353, 32820, 0, 1, 1, 0, 0, 1833.77, 256.523, 59.7223, 4.64552, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244354, 32820, 0, 1, 1, 0, 0, 1837.2, 254.766, 59.856, 3.58916, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244355, 32820, 0, 1, 1, 0, 0, 1836.83, 251.094, 59.922, 2.54065, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244356, 32820, 0, 1, 1, 0, 0, 1821.62, 222.529, 60.1521, 6.01211, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244357, 32820, 0, 1, 1, 0, 0, 1825.06, 224.891, 60.2886, 4.72799, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244358, 32820, 0, 1, 1, 0, 0, 1828.78, 223.155, 60.5687, 3.59309, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244359, 32820, 0, 1, 1, 0, 0, 1828.2, 219.471, 60.6056, 2.42991, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244360, 32820, 0, 1, 1, 0, 0, 1831.58, 220.664, 60.5304, 6.01918, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244361, 32820, 0, 1, 1, 0, 0, 1834.82, 223.437, 60.2865, 4.83323, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244362, 32820, 0, 1, 1, 0, 0, 1838.43, 221.277, 60.1987, 3.55697, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244363, 32820, 0, 1, 1, 0, 0, 1837.5, 217.672, 60.1333, 2.31996, 600, 20, 0, 2, 0, 1, 0, 0, 0);
INSERT INTO creature VALUES(244364, 19148, 0, 1, 1, 0, 0, -4915.33, -953.892, 501.498, 2.25016, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244365, 19171, 530, 1, 1, 0, 0, -3909.22, -11614.8, -138.101, 3.1765, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244366, 19172, 0, 1, 1, 0, 0, -4829.02, -1174.75, 502.193, 0.724139, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244367, 19173, 1, 1, 1, 0, 0, 9921.56, 2499.58, 1317.77, 5.61996, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244368, 19178, 0, 1, 1, 0, 0, 1626.7, 222.7, -43.1027, 1.01229, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244369, 19177, 1, 1, 1, 0, 0, 1688.01, -4350.19, 61.2691, 2.56413, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244370, 19176, 1, 1, 1, 0, 0, -1241.98, 81.7344, 129.422, 5.4992, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244371, 19175, 1, 1, 1, 0, 0, 1607.39, -4402.93, 10.1664, 3.11715, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244372, 19169, 530, 1, 1, 0, 0, 9659.86, -7115.63, 14.3239, 5.88552, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244373, 20102, 1, 1, 1, 0, 0, 6747.03, -4664.43, 724.551, 3.61009, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244374, 20102, 1, 1, 1, 0, 0, -938.792, -3735.2, 8.57162, 3.66385, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244375, 20102, 1, 1, 1, 0, 0, -7177.24, -3810.02, 8.3753, 0.711558, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244376, 20102, 0, 1, 1, 0, 0, -14464.9, 470.287, 15.0369, 5.96098, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244377, 20102, 530, 1, 1, 0, 0, -1888.02, 5400.44, -12.4278, 5.97919, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244378, 20102, 530, 1, 1, 0, 0, 3035.51, 3635.08, 144.47, 0.901821, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244379, 19169, 571, 1, 1, 0, 0, 5889.57, 550.355, 639.637, 1.57167, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244380, 18927, 571, 1, 1, 0, 0, 5719.3, 687.257, 645.752, 5.72721, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244381, 18927, 0, 1, 1, 0, 0, -8855.97, 652.546, 96.2675, 5.07716, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244382, 18927, 571, 1, 1, 0, 0, 5678.09, 658.93, 647.134, 0.088838, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244383, 19148, 0, 1, 1, 0, 0, -4914.82, -951.191, 501.498, 4.5773, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244384, 19171, 530, 1, 1, 0, 0, -3910.91, -11612.4, -138.243, 4.99941, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244385, 19172, 0, 1, 1, 0, 0, -4826.78, -1175.89, 502.193, 2.45358, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244386, 19173, 1, 1, 1, 0, 0, 9923.44, 2496.95, 1317.49, 2.28359, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244387, 19169, 571, 1, 1, 0, 0, 5928.98, 639.593, 645.557, 3.01052, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244388, 19169, 530, 1, 1, 0, 0, 9664.38, -7117.91, 14.324, 2.63397, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244389, 19175, 1, 1, 1, 0, 0, 1603.36, -4404.49, 9.30901, 0.627438, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244390, 19176, 1, 1, 1, 0, 0, -1242.68, 76.7127, 128.935, 1.27376, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244391, 19177, 1, 1, 1, 0, 0, 1685.07, -4352.88, 61.7253, 1.79601, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244392, 19178, 0, 1, 1, 0, 0, 1629.95, 219.238, -43.1027, 1.91079, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244393, 20102, 1, 1, 1, 0, 0, 6745.48, -4667.44, 723.103, 1.03712, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244394, 20102, 1, 1, 1, 0, 0, -936.306, -3738.3, 8.96324, 3.35283, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244395, 20102, 1, 1, 1, 0, 0, -7173.14, -3808.58, 8.37043, 3.3285, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244396, 20102, 0, 1, 1, 0, 0, -14461.4, 468.507, 15.1232, 2.66545, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244397, 20102, 530, 1, 1, 0, 0, -1884.63, 5397.52, -12.4278, 2.51637, 300, 0, 0, 42, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES(244398, 20102, 530, 1, 1, 0, 0, 3038.56, 3635.53, 144.012, 3.32713, 300, 0, 0, 42, 0, 0, 0, 0, 0);
DELETE FROM game_event_creature WHERE eventEntry=26;
REPLACE INTO game_event_creature VALUES(26, 240400),(26, 240401),(26, 240402),(26, 240403),(26, 240404),(26, 240405),
(26, 240406),(26, 240407),(26, 240408),(26, 240409),(26, 240410),(26, 240411),(26, 240412),(26, 240413),(26, 240414),(26, 240415),(26, 240416),
(26, 240417),(26, 240418),(26, 240419),(26, 240420),(26, 240421),(26, 240422),(26, 240423),(26, 240424),(26, 240425),(26, 240426),(26, 240427),
(26, 240428),(26, 240429),(26, 240430),(26, 240431),(26, 240432),(26, 240433),(26, 240434),(26, 240435),(26, 240436),(26, 240437),(26, 240438),
(26, 240439),(26, 240440),(26, 240441),(26, 240442),(26, 240443),(26, 240444),(26, 240445),(26, 240446),(26, 240447),(26, 240448),(26, 240449),
(26, 240450),(26, 240451),(26, 240452),(26, 240453),(26, 240454),(26, 240455),(26, 240456),(26, 240457),(26, 240458),(26, 240459),(26, 240460),
(26, 240461),(26, 240462),(26, 240463),(26, 240464),(26, 240465),(26, 240466),(26, 240467),(26, 240468),(26, 240470),(26, 240471), -- (26, 240469)
(26, 240472),(26, 240473),(26, 240474),(26, 240475),(26, 240476),(26, 240477),(26, 240478),(26, 240479),(26, 240480),(26, 240481),(26, 240482),
(26, 240483),(26, 240484),(26, 240485),(26, 240486),(26, 240487),(26, 240488),(26, 240489),(26, 240490),(26, 240491),(26, 240492),(26, 240493),
(26, 240494),(26, 240495),(26, 240496),(26, 240497),(26, 240498),(26, 240499),(26, 240500),(26, 240501),(26, 240502),(26, 240503),(26, 240504),
(26, 240505),(26, 240506),(26, 240507),(26, 240508),(26, 240509),(26, 240510),(26, 240511),(26, 240512),(26, 240513),(26, 240514),(26, 240515),
(26, 240516),(26, 240517),(26, 240518),(26, 240519),(26, 240520),(26, 240521),(26, 240522),(26, 240523),(26, 240524),(26, 240525),(26, 240526),
(26, 240527),(26, 240528),(26, 240529),(26, 240530),(26, 240531),(26, 240532),(26, 240533),(26, 240534),(26, 240535),(26, 240536),(26, 240537),
(26, 240538),(26, 240539),(26, 240540),(26, 240541),(26, 240542),(26, 240543),(26, 240544),(26, 240545),(26, 240546),(26, 240547),(26, 240548),
(26, 240549),(26, 240550),(26, 240551),(26, 240552),(26, 240553),(26, 240554),(26, 240555),(26, 240556),(26, 240557),(26, 240558),(26, 240559),
(26, 240560),(26, 240561),(26, 240562),(26, 240563),(26, 240564),(26, 240565),(26, 240566),(26, 240567),(26, 240568),(26, 240569),(26, 240570),
(26, 240571),(26, 240572),(26, 240573),(26, 240574),(26, 240575),(26, 240576),(26, 240577),(26, 240578),(26, 240579),(26, 240580),(26, 240581),
(26, 240582),(26, 240583),(26, 240584),(26, 240585),(26, 240586),(26, 240587),(26, 240588),(26, 240589),(26, 240590),(26, 240591),(26, 240592),
(26, 240593),(26, 240594),(26, 240595),(26, 240596),(26, 240597),(26, 240598),(26, 240599),(26, 240600),(26, 240601),(26, 240602),(26, 240603),
(26, 240604),(26, 240605),(26, 240606),(26, 240607),(26, 240608),(26, 240609),(26, 240610),(26, 240611),(26, 240612),(26, 240613),(26, 240614),
(26, 240615),(26, 240616),(26, 240617),(26, 240618),(26, 240619),(26, 240620),(26, 240621),(26, 240622),(26, 240623),(26, 240624),(26, 240625),
(26, 240626),(26, 240627),(26, 240628),(26, 240629),(26, 240630),(26, 240631),(26, 240632),(26, 240633),(26, 240634),(26, 240635),(26, 240636),
(26, 240637),(26, 240638),(26, 240639),(26, 240640),(26, 240641),(26, 240642),(26, 240643),(26, 240644),(26, 240645),(26, 240646),(26, 240647),
(26, 240648),(26, 240649),(26, 240650),(26, 240651),(26, 240652),(26, 240653),(26, 240654),(26, 240655),(26, 240656),(26, 240657),(26, 240658),
(26, 240659),(26, 240660),(26, 240661),(26, 240662),(26, 240663),(26, 240664),(26, 240665),(26, 240666),(26, 240667),(26, 240668),(26, 240669),
(26, 240670),(26, 240671),(26, 240672),(26, 240673),(26, 240674),(26, 240675),(26, 240676),(26, 240677),(26, 240678),(26, 240679),(26, 240680),
(26, 240681),(26, 240682),(26, 240683),(26, 240684),(26, 240685),(26, 240686),(26, 240687),(26, 240688),(26, 240689),(26, 240690),(26, 240691),
(26, 240692),(26, 240693),(26, 240694),(26, 240695),(26, 240696),(26, 240697),(26, 240698),(26, 240699),(26, 240700),(26, 240701),(26, 240702),
(26, 240703),(26, 240704),(26, 240705),(26, 240706),(26, 240707),(26, 240708),(26, 240709),(26, 240710),(26, 240711),(26, 240712),(26, 240713),
(26, 240714),(26, 240715),(26, 240716),(26, 240717),(26, 240718),(26, 240719),(26, 240720),(26, 240721),(26, 240722),(26, 240723),(26, 240724),
(26, 240725),(26, 240726),(26, 240727),(26, 240728),(26, 240729),(26, 240730),(26, 240731),(26, 240732),(26, 240733),(26, 240734),(26, 240735),
(26, 240736),(26, 240737),(26, 240738),(26, 240739),(26, 240740),(26, 240741),(26, 240742),(26, 240743),(26, 240744),(26, 240745),(26, 240746),
(26, 240747),(26, 240748),(26, 240749),(26, 240750),(26, 240751),(26, 240752),(26, 240753),(26, 240754),(26, 240755),(26, 240756),(26, 240757),
(26, 240758),(26, 240759),(26, 240760),(26, 240761),(26, 240762),(26, 240763),(26, 240764),(26, 240765),(26, 240766),(26, 240767),(26, 240768),
(26, 240769),(26, 240770),(26, 240771),(26, 240772),(26, 240773),(26, 240774),(26, 240775),(26, 240776),(26, 240777),(26, 240778),(26, 240779),
(26, 240780),(26, 240781),(26, 240782),(26, 240783),(26, 240784),(26, 240785),(26, 240786),(26, 240787),(26, 240788),(26, 240789),(26, 240790),
(26, 240791),(26, 240792),(26, 240793),(26, 240794),(26, 240795),(26, 240796),(26, 240797),(26, 240798),(26, 240799),(26, 240800),(26, 240801),
(26, 240802),(26, 240803),(26, 240804),(26, 240805),(26, 240806),(26, 240807),(26, 240808),(26, 240809),(26, 240810),(26, 240811),(26, 240812),
(26, 240813),(26, 240814),(26, 240815),(26, 240816),(26, 240817),(26, 240818),(26, 240819),(26, 240820),(26, 240821),(26, 240822),(26, 240823),
(26, 240824),(26, 240825),(26, 240826),(26, 240827),(26, 240828),(26, 240829),(26, 240830),(26, 240831),(26, 240832),(26, 240833),(26, 240834),
(26, 240835),(26, 240836),(26, 240837),(26, 240838),(26, 240839),(26, 240840),(26, 240841),(26, 240842),(26, 240843),(26, 240844),(26, 240845),
(26, 240846),(26, 240847),(26, 240848),(26, 240849),(26, 240850),(26, 240851),(26, 240852),(26, 240853),(26, 240854),(26, 240855),(26, 240856),
(26, 240857),(26, 240858),(26, 240859),(26, 240860),(26, 240861),(26, 240862),(26, 240863),(26, 240864),(26, 240865),(26, 240866),(26, 240867),
(26, 240868),(26, 240869),(26, 240870),(26, 240871),(26, 240872),(26, 240873),(26, 240874),(26, 240875),(26, 240876),(26, 240877),(26, 240878),
(26, 240879),(26, 240880),(26, 240881),(26, 240882),(26, 240883),(26, 240884),(26, 240885),(26, 240886),(26, 240887),(26, 240888),(26, 240889),
(26, 240890),(26, 240891),(26, 240892),(26, 240893),(26, 240894),(26, 240895),(26, 240896),(26, 240897),(26, 240898),(26, 240899),(26, 240900),
(26, 240901),(26, 240902),(26, 240903),(26, 240904),(26, 240905),(26, 240906),(26, 240907),(26, 240908),(26, 240909),(26, 240910),(26, 240911),
(26, 240912),(26, 240913),(26, 240914),(26, 240915),(26, 240916),(26, 240917),(26, 240918),(26, 240919),(26, 240920),(26, 240921),(26, 240922),
(26, 240923),(26, 240924),(26, 240925),(26, 240926),(26, 240927),(26, 240928),(26, 240929),(26, 240930),(26, 240931),(26, 240932),(26, 240933),
(26, 240934),(26, 240935),(26, 240936),(26, 240937),(26, 240938),(26, 240939),(26, 240940),(26, 240941),(26, 240942),(26, 240943),(26, 240944),
(26, 240945),(26, 240946),(26, 240947),(26, 240948),(26, 240949),(26, 240950),(26, 240951),(26, 240952),(26, 240953),(26, 240954),(26, 240955),
(26, 240956),(26, 240957),(26, 240958),(26, 240959),(26, 240960),(26, 240961),(26, 240962),(26, 240963),(26, 240964),(26, 240965),(26, 240966),
(26, 240967),(26, 240968),(26, 240969),(26, 240970),(26, 240971),(26, 240972),(26, 240973),(26, 240974),(26, 240975),(26, 240976),(26, 240977),
(26, 240978),(26, 240979),(26, 240980),(26, 240981),(26, 240982),(26, 240983),(26, 240984),(26, 240985),(26, 240986),(26, 240987),(26, 240988),
(26, 240989),(26, 240990),(26, 240991),(26, 240992),(26, 240993),(26, 240994),(26, 240995),(26, 240996),(26, 240997),(26, 240998),(26, 240999),
(26, 241000),(26, 241001),(26, 241002),(26, 241003),(26, 241004),(26, 241005),(26, 241006),(26, 241007),(26, 241008),(26, 241009),(26, 241010),
(26, 241011),(26, 241012),(26, 241013),(26, 241014),(26, 241015),(26, 241016),(26, 241017),(26, 241018),(26, 241019),(26, 241020),(26, 241021),
(26, 241022),(26, 241023),(26, 241024),(26, 241025),(26, 241026),(26, 241027),(26, 241028),(26, 241029),(26, 241030),(26, 241031),(26, 241032),
(26, 241033),(26, 241034),(26, 241035),(26, 241036),(26, 241037),(26, 241038),(26, 241039),(26, 241040),(26, 241041),(26, 241042),(26, 241043),
(26, 241044),(26, 241045),(26, 241046),(26, 241047),(26, 241048),(26, 241049),(26, 241050),(26, 241051),(26, 241052),(26, 241053),(26, 241054),
(26, 241055),(26, 241056),(26, 241057),(26, 241058),(26, 241059),(26, 241060),(26, 241061),(26, 241062),(26, 241063),(26, 241064),(26, 241065),
(26, 241066),(26, 241067),(26, 241068),(26, 241069),(26, 241070),(26, 241071),(26, 241072),(26, 241073),(26, 241074),(26, 241075),(26, 241076),
(26, 241077),(26, 241078),(26, 241079),(26, 241080),(26, 241081),(26, 241082),(26, 241083),(26, 241084),(26, 241085),(26, 241086),(26, 241087),
(26, 241088),(26, 241089),(26, 241090),(26, 241091),(26, 241092),(26, 241093),(26, 241094),(26, 241095),(26, 241096),(26, 241097),(26, 241098),
(26, 241099),(26, 241100),(26, 241101),(26, 241102),(26, 241103),(26, 241104),(26, 241105),(26, 241106),(26, 241107),(26, 241108),(26, 241109),
(26, 241110),(26, 241111),(26, 241112),(26, 241113),(26, 241114),(26, 241115),(26, 241116),(26, 241117),(26, 241118),(26, 241119),(26, 241120),
(26, 241121),(26, 241122),(26, 241123),(26, 241124),(26, 241125),(26, 241126),(26, 241127),(26, 241128),(26, 241129),(26, 241130),(26, 241131),
(26, 241132),(26, 241133),(26, 241134),(26, 241135),(26, 241136),(26, 241137),(26, 241138),(26, 241139),(26, 241140),(26, 241141),(26, 241142),
(26, 241143),(26, 241144),(26, 241145),(26, 241146),(26, 241147),(26, 241148),(26, 241149),(26, 241150),(26, 241151),(26, 241152),(26, 241153),
(26, 241154),(26, 241155),(26, 241156),(26, 241157),(26, 241158),(26, 241159),(26, 241160),(26, 241161),(26, 241162),(26, 241163),(26, 241164),
(26, 241165),(26, 241166),(26, 241167),(26, 241168),(26, 241169),(26, 241170),(26, 241171),(26, 241172),(26, 241173),(26, 241174),(26, 241175),
(26, 241176),(26, 241177),(26, 241178),(26, 241179),(26, 241180),(26, 241181),(26, 241182),(26, 241183),(26, 241184),(26, 241185),(26, 241186),
(26, 241187),(26, 241188),(26, 241189),(26, 241190),(26, 241191),(26, 241192),(26, 241193),(26, 241194),(26, 241195),(26, 241196),(26, 241197),
(26, 241198),(26, 241199),(26, 241200),(26, 241201),(26, 241202),(26, 241203),(26, 241204),(26, 241205),(26, 241206),(26, 241207),(26, 241208),
(26, 241209),(26, 241210),(26, 241211),(26, 241212),(26, 241213),(26, 241214),(26, 241215),(26, 241216),(26, 241217),(26, 241218),(26, 241219),
(26, 241220),(26, 241221),(26, 241222),(26, 241223),(26, 241224),(26, 241225),(26, 241226),(26, 241227),(26, 241228),(26, 241229),(26, 241230),
(26, 241231),(26, 241232),(26, 241233),(26, 241234),(26, 241235),(26, 241236),(26, 241237),(26, 241238),(26, 241239),(26, 241240),(26, 241241),
(26, 241242),(26, 241243),(26, 241244),(26, 241245),(26, 241246),(26, 241247),(26, 241248),(26, 241249),(26, 241250),(26, 241251),(26, 241252),
(26, 241253),(26, 241254),(26, 241255),(26, 241256),(26, 241257),(26, 241258),(26, 241259),(26, 241260),(26, 241261),(26, 241262),(26, 241263),
(26, 241264),(26, 241265),(26, 241266),(26, 241267),(26, 241268),(26, 241269),(26, 241270),(26, 241271),(26, 241272),(26, 241273),(26, 241274),
(26, 241275),(26, 241276),(26, 241277),(26, 241278),(26, 241279),(26, 241280),(26, 241281),(26, 241282),(26, 241283),(26, 241284),(26, 241285),
(26, 241286),(26, 241287),(26, 241288),(26, 241289),(26, 241290),(26, 241291),(26, 241292),(26, 241293),(26, 241294),(26, 241295),(26, 241296),
(26, 241297),(26, 241298),(26, 241299),(26, 241300),(26, 241301),(26, 241302),(26, 241303),(26, 241304),(26, 241305),(26, 241306),(26, 241307),
(26, 241308),(26, 241309),(26, 241310),(26, 241311),(26, 241312),(26, 241313),(26, 241314),(26, 241315),(26, 241316),(26, 241317),(26, 241318),
(26, 241319),(26, 241320),(26, 241321),(26, 241322),(26, 241323),(26, 241324),(26, 241325),(26, 241326),(26, 241327),(26, 241328),(26, 241329),
(26, 241330),(26, 241331),(26, 241332),(26, 241333),(26, 241334),(26, 241335),(26, 241336),(26, 241337),(26, 241338),(26, 241339),(26, 241340),
(26, 241341),(26, 241342),(26, 241343),(26, 241344),(26, 241345),(26, 241346),(26, 241347),(26, 241348),(26, 241349),(26, 241350),(26, 241351),
(26, 241352),(26, 241353),(26, 241354),(26, 241355),(26, 241356),(26, 241357),(26, 241358),(26, 241359),(26, 241360),(26, 241361),(26, 241362),
(26, 241363),(26, 241364),(26, 241365),(26, 241366),(26, 241367),(26, 241368),(26, 241369),(26, 241370),(26, 241371),(26, 241372),(26, 241373),
(26, 241374),(26, 241375),(26, 241376),(26, 241377),(26, 241378),(26, 241379),(26, 241380),(26, 241381),(26, 241382),(26, 241383),(26, 241384),
(26, 241385),(26, 241386),(26, 241387),(26, 241388),(26, 241389),(26, 241390),(26, 241391),(26, 241392),(26, 241393),(26, 241394),(26, 241395),
(26, 241396),(26, 241397),(26, 241398),(26, 241399),(26, 241400),(26, 241401),(26, 241402),(26, 241403),(26, 241404),(26, 241405),(26, 241406),
(26, 241407),(26, 241408),(26, 241409),(26, 241410),(26, 241411),(26, 241412),(26, 241413),(26, 241414),(26, 241415),(26, 241416),(26, 241417),
(26, 241418),(26, 241419),(26, 241420),(26, 241421),(26, 241422),(26, 241423),(26, 241424),(26, 241425),(26, 241426),(26, 241427),(26, 241428),
(26, 241429),(26, 241430),(26, 241431),(26, 241432),(26, 241433),(26, 241434),(26, 241435),(26, 241436),(26, 241437),(26, 241438),(26, 241439),
(26, 241440),(26, 241441),(26, 241442),(26, 241443),(26, 241444),(26, 241445),(26, 241446),(26, 241447),(26, 241448),(26, 241449),(26, 241450),
(26, 241451),(26, 241452),(26, 241453),(26, 241454),(26, 241455),(26, 241456),(26, 241457),(26, 241458),(26, 241459),(26, 241460),(26, 241461),
(26, 241462),(26, 241463),(26, 241464),(26, 241465),(26, 241466),(26, 241467),(26, 241468),(26, 241469),(26, 241470),(26, 241471),(26, 241472),
(26, 241473),(26, 241474),(26, 241475),(26, 241476),(26, 241477),(26, 241478),(26, 241479),(26, 241480),(26, 241481),(26, 241482),(26, 241483),
(26, 241484),(26, 241485),(26, 241486),(26, 241487),(26, 241488),(26, 241489),(26, 241490),(26, 241491),(26, 241492),(26, 241493),(26, 241494),
(26, 241495),(26, 241496),(26, 241497),(26, 241498),(26, 241499),(26, 241500),(26, 241501),(26, 241502),(26, 241503),(26, 241504),(26, 241505),
(26, 241506),(26, 241507),(26, 241508),(26, 241509),(26, 241510),(26, 241511),(26, 241512),(26, 241513),(26, 241514),(26, 241515),(26, 241516),
(26, 241517),(26, 241518),(26, 241519),(26, 241520),(26, 241521),(26, 241522),(26, 241523),(26, 241524),(26, 241525),(26, 241526),(26, 241527),
(26, 241528),(26, 241529),(26, 241530),(26, 241531),(26, 241532),(26, 241533),(26, 241534),(26, 241535),(26, 241536),(26, 241537),(26, 241538),
(26, 241539),(26, 241540),(26, 241541),(26, 241542),(26, 241543),(26, 241544),(26, 241545),(26, 241546),(26, 241547),(26, 241548),(26, 241549),
(26, 241550),(26, 241551),(26, 241552),(26, 241553),(26, 241554),(26, 241555),(26, 241556),(26, 241557),(26, 241558),(26, 241559),(26, 241560),
(26, 241561),(26, 241562),(26, 241563),(26, 241564),(26, 241565),(26, 241566),(26, 241567),(26, 241568),(26, 241569),(26, 241570),(26, 241571),
(26, 241572),(26, 241573),(26, 241574),(26, 241575),(26, 241576),(26, 241577),(26, 241578),(26, 241579),(26, 241580),(26, 241581),(26, 241582),
(26, 241583),(26, 241584),(26, 241585),(26, 241586),(26, 241587),(26, 241588),(26, 241589),(26, 241590),(26, 241591),(26, 241592),(26, 241593),
(26, 241594),(26, 241595),(26, 241596),(26, 241597),(26, 241598),(26, 241599),(26, 241600),(26, 241601),(26, 241602),(26, 241603),(26, 241604),
(26, 241605),(26, 241606),(26, 241607),(26, 241608),(26, 241609),(26, 241610),(26, 241611),(26, 241612),(26, 241613),(26, 241614),(26, 241615),
(26, 241616),(26, 241617),(26, 241618),(26, 241619),(26, 241620),(26, 241621),(26, 241622),(26, 241623),(26, 241624),(26, 241625),(26, 241626),
(26, 241627),(26, 241628),(26, 241629),(26, 241630),(26, 241631),(26, 241632),(26, 241633),(26, 241634),(26, 241635),(26, 241636),(26, 241637),
(26, 241638),(26, 241639),(26, 241640),(26, 241641),(26, 241642),(26, 241643),(26, 241644),(26, 241645),(26, 241646),(26, 241647),(26, 241648),
(26, 241649),(26, 241650),(26, 241651),(26, 241652),(26, 241653),(26, 241654),(26, 241655),(26, 241656),(26, 241657),(26, 241658),(26, 241659),
(26, 241660),(26, 241661),(26, 241662),(26, 241663),(26, 241664),(26, 241665),(26, 241666),(26, 241667),(26, 241668),(26, 241669),(26, 241670),
(26, 241671),(26, 241672),(26, 241673),(26, 241674),(26, 241675),(26, 241676),(26, 241677),(26, 241678),(26, 241679),(26, 241680),(26, 241681),
(26, 241682),(26, 241683),(26, 241684),(26, 241685),(26, 241686),(26, 241687),(26, 241688),(26, 241689),(26, 241690),(26, 241691),(26, 241692),
(26, 241693),(26, 241694),(26, 241695),(26, 241696),(26, 241697),(26, 241698),(26, 241699),(26, 241700),(26, 241701),(26, 241702),(26, 241703),
(26, 241704),(26, 241705),(26, 241706),(26, 241707),(26, 241708),(26, 241709),(26, 241710),(26, 241711),(26, 241712),(26, 241713),(26, 241714),
(26, 241715),(26, 241716),(26, 241717),(26, 241718),(26, 241719),(26, 241720),(26, 241721),(26, 241722),(26, 241723),(26, 241724),(26, 241725),
(26, 241726),(26, 241727),(26, 241728),(26, 241729),(26, 241730),(26, 241731),(26, 241732),(26, 241733),(26, 241734),(26, 241735),(26, 241736),
(26, 241737),(26, 241738),(26, 241739),(26, 241740),(26, 241741),(26, 241742),(26, 241743),(26, 241744),(26, 241745),(26, 241746),(26, 241747),
(26, 241748),(26, 241749),(26, 241750),(26, 241751),(26, 241752),(26, 241753),(26, 241754),(26, 241755),(26, 241756),(26, 241757),(26, 241758),
(26, 241759),(26, 241760),(26, 241761),(26, 241762),(26, 241763),(26, 241764),(26, 241765),(26, 241766),(26, 241767),(26, 241768),(26, 241769),
(26, 241770),(26, 241771),(26, 241772),(26, 241773),(26, 241774),(26, 241775),(26, 241776),(26, 241777),(26, 241778),(26, 241779),(26, 241780),
(26, 241781),(26, 241782),(26, 241783),(26, 241784),(26, 241785),(26, 241786),(26, 241787),(26, 241788),(26, 241789),(26, 241790),(26, 241791),
(26, 241792),(26, 241793),(26, 241794),(26, 241795),(26, 241796),(26, 241797),(26, 241798),(26, 241799),(26, 241800),(26, 241801),(26, 241802),
(26, 241803),(26, 241804),(26, 241805),(26, 241806),(26, 241807),(26, 241808),(26, 241809),(26, 241810),(26, 241811),(26, 241812),(26, 241813),
(26, 241814),(26, 241815),(26, 241816),(26, 241817),(26, 241818),(26, 241819),(26, 241820),(26, 241821),(26, 241822),(26, 241823),(26, 241824),
(26, 241825),(26, 241826),(26, 241827),(26, 241828),(26, 241829),(26, 241830),(26, 241831),(26, 241832),(26, 241833),(26, 241834),(26, 241835),
(26, 241836),(26, 241837),(26, 241838),(26, 241839),(26, 241840),(26, 241841),(26, 241842),(26, 241843),(26, 241844),(26, 241845),(26, 241846),
(26, 241847),(26, 241848),(26, 241849),(26, 241850),(26, 241851),(26, 241852),(26, 241853),(26, 241854),(26, 241855),(26, 241856),(26, 241857),
(26, 241858),(26, 241859),(26, 241860),(26, 241861),(26, 241862),(26, 241863),(26, 241864),(26, 241865),(26, 241866),(26, 241867),(26, 241868),
(26, 241869),(26, 241870),(26, 241871),(26, 241872),(26, 241873),(26, 241874),(26, 241875),(26, 241876),(26, 241877),(26, 241878),(26, 241879),
(26, 241880),(26, 241881),(26, 241882),(26, 241883),(26, 241884),(26, 241885),(26, 241886),(26, 241887),(26, 241888),(26, 241889),(26, 241890),
(26, 241891),(26, 241892),(26, 241893),(26, 241894),(26, 241895),(26, 241896),(26, 241897),(26, 241898),(26, 241899),(26, 241900),(26, 241901),
(26, 241902),(26, 241903),(26, 241904),(26, 241905),(26, 241906),(26, 241907),(26, 241908),(26, 241909),(26, 241910),(26, 241911),(26, 241912),
(26, 241913),(26, 241914),(26, 241915),(26, 241916),(26, 241917),(26, 241918),(26, 241919),(26, 241920),(26, 241921),(26, 241922),(26, 241923),
(26, 241924),(26, 241925),(26, 241926),(26, 241927),(26, 241928),(26, 241929),(26, 241930),(26, 241931),(26, 241932),(26, 241933),(26, 241934),
(26, 241935),(26, 241936),(26, 241937),(26, 241938),(26, 241939),(26, 241940),(26, 241941),(26, 241942),(26, 241943),(26, 241944),(26, 241945),
(26, 241946),(26, 241947),(26, 241948),(26, 241949),(26, 241950),(26, 241951),(26, 241952),(26, 241953),(26, 241954),(26, 241955),(26, 241956),
(26, 241957),(26, 241958),(26, 241959),(26, 241960),(26, 241961),(26, 241962),(26, 241963),(26, 241964),(26, 241965),(26, 241966),(26, 241967),
(26, 241968),(26, 241969),(26, 241970),(26, 241971),(26, 241972),(26, 241973),(26, 241974),(26, 241975),(26, 241976),(26, 241977),(26, 241978),
(26, 241979),(26, 241980),(26, 241981),(26, 241982),(26, 241983),(26, 241984),(26, 241985),(26, 241986),(26, 241987),(26, 241988),(26, 241989),
(26, 241990),(26, 241991),(26, 241992),(26, 241993),(26, 241994),(26, 241995),(26, 241996),(26, 241997),(26, 241998),(26, 241999),(26, 242000),
(26, 242001),(26, 242002),(26, 242003),(26, 242004),(26, 242005),(26, 242006),(26, 242007),(26, 242008),(26, 242009),(26, 242010),(26, 242011),
(26, 242012),(26, 242013),(26, 242014),(26, 242015),(26, 242016),(26, 242017),(26, 242018),(26, 242019),(26, 242020),(26, 242021),(26, 242022),
(26, 242023),(26, 242024),(26, 242025),(26, 242026),(26, 242027),(26, 242028),(26, 242029),(26, 242030),(26, 242031),(26, 242032),(26, 242033),
(26, 242034),(26, 242035),(26, 242036),(26, 242037),(26, 242038),(26, 242039),(26, 242040),(26, 242041),(26, 242042),(26, 242043),(26, 242044),
(26, 242045),(26, 242046),(26, 242047),(26, 242048),(26, 242049),(26, 242050),(26, 242051),(26, 242052),(26, 242053),(26, 242054),(26, 242055),
(26, 242056),(26, 242057),(26, 242058),(26, 242059),(26, 242060),(26, 242061),(26, 242062),(26, 242063),(26, 242064),(26, 242065),(26, 242066),
(26, 242067),(26, 242068),(26, 242069),(26, 242070),(26, 242071),(26, 242072),(26, 242073),(26, 242074),(26, 242075),(26, 242076),(26, 242077),
(26, 242078),(26, 242079),(26, 242080),(26, 242081),(26, 242082),(26, 242083),(26, 242084),(26, 242085),(26, 242086),(26, 242087),(26, 242088),
(26, 242089),(26, 242090),(26, 242091),(26, 242092),(26, 242093),(26, 242094),(26, 242095),(26, 242096),(26, 242097),(26, 242098),(26, 242099),
(26, 242100),(26, 242101),(26, 242102),(26, 242103),(26, 242104),(26, 242105),(26, 242106),(26, 242107),(26, 242108),(26, 242109),(26, 242110),
(26, 242111),(26, 242112),(26, 242113),(26, 242114),(26, 242115),(26, 242116),(26, 242117),(26, 242118),(26, 242119),(26, 242120),(26, 242121),
(26, 242122),(26, 242123),(26, 242124),(26, 242125),(26, 242126),(26, 242127),(26, 242128),(26, 242129),(26, 242130),(26, 242131),(26, 242132),
(26, 242133),(26, 242134),(26, 242135),(26, 242136),(26, 242137),(26, 242138),(26, 242139),(26, 242140),(26, 242141),(26, 242142),(26, 242143),
(26, 242144),(26, 242145),(26, 242146),(26, 242147),(26, 242148),(26, 242149),(26, 242150),(26, 242151),(26, 242152),(26, 242153),(26, 242154),
(26, 242155),(26, 242156),(26, 242157),(26, 242158),(26, 242159),(26, 242160),(26, 242161),(26, 242162),(26, 242163),(26, 242164),(26, 242165),
(26, 242166),(26, 242167),(26, 242168),(26, 242169),(26, 242170),(26, 242171),(26, 242172),(26, 242173),(26, 242174),(26, 242175),(26, 242176),
(26, 242177),(26, 242178),(26, 242179),(26, 242180),(26, 242181),(26, 242182),(26, 242183),(26, 242184),(26, 242185),(26, 242186),(26, 242187),
(26, 242188),(26, 242189),(26, 242190),(26, 242191),(26, 242192),(26, 242193),(26, 242194),(26, 242195),(26, 242196),(26, 242197),(26, 242198),
(26, 242199),(26, 242200),(26, 242201),(26, 242202),(26, 242203),(26, 242204),(26, 242205),(26, 242206),(26, 242207),(26, 242208),(26, 242209),
(26, 242210),(26, 242211),(26, 242212),(26, 242213),(26, 242214),(26, 242215),(26, 242216),(26, 242217),(26, 242218),(26, 242219),(26, 242220),
(26, 242221),(26, 242222),(26, 242223),(26, 242224),(26, 242225),(26, 242226),(26, 242227),(26, 242228),(26, 242229),(26, 242230),(26, 242231),
(26, 242232),(26, 242233),(26, 242234),(26, 242235),(26, 242236),(26, 242237),(26, 242238),(26, 242239),(26, 242240),(26, 242241),(26, 242242),
(26, 242243),(26, 242244),(26, 242245),(26, 242246),(26, 242247),(26, 242248),(26, 242249),(26, 242250),(26, 242251),(26, 242252),(26, 242253),
(26, 242254),(26, 242255),(26, 242256),(26, 242257),(26, 242258),(26, 242259),(26, 242260),(26, 242261),(26, 242262),(26, 242263),(26, 242264),
(26, 242265),(26, 242266),(26, 242267),(26, 242268),(26, 242269),(26, 242270),(26, 242271),(26, 242272),(26, 242273),(26, 242274),(26, 242275),
(26, 242276),(26, 242277),(26, 242278),(26, 242279),(26, 242280),(26, 242281),(26, 242282),(26, 242283),(26, 242284),(26, 242285),(26, 242286),
(26, 242287),(26, 242288),(26, 242289),(26, 242290),(26, 242291),(26, 242292),(26, 242293),(26, 242294),(26, 242295),(26, 242296),(26, 242297),
(26, 242298),(26, 242299),(26, 242300),(26, 242301),(26, 242302),(26, 242303),(26, 242304),(26, 242305),(26, 242306),(26, 242307),(26, 242308),
(26, 242309),(26, 242310),(26, 242311),(26, 242312),(26, 242313),(26, 242314),(26, 242315),(26, 242316),(26, 242317),(26, 242318),(26, 242319),
(26, 242320),(26, 242321),(26, 242322),(26, 242323),(26, 242324),(26, 242325),(26, 242326),(26, 242327),(26, 242328),(26, 242329),(26, 242330),
(26, 242331),(26, 242332),(26, 242333),(26, 242334),(26, 242335),(26, 242336),(26, 242337),(26, 242338),(26, 242339),(26, 242340),(26, 242341),
(26, 242342),(26, 242343),(26, 242344),(26, 242345),(26, 242346),(26, 242347),(26, 242348),(26, 242349),(26, 242350),(26, 242351),(26, 242352),
(26, 242353),(26, 242354),(26, 242355),(26, 242356),(26, 242357),(26, 242358),(26, 242359),(26, 242360),(26, 242361),(26, 242362),(26, 242363),
(26, 242364),(26, 242365),(26, 242366),(26, 242367),(26, 242368),(26, 242369),(26, 242370),(26, 242371),(26, 242372),(26, 242373),(26, 242374),
(26, 242375),(26, 242376),(26, 242377),(26, 242378),(26, 242379),(26, 242380),(26, 242381),(26, 242382),(26, 242383),(26, 242384),(26, 242385),
(26, 242386),(26, 242387),(26, 242388),(26, 242389),(26, 242390),(26, 242391),(26, 242392),(26, 242393),(26, 242394),(26, 242395),(26, 242396),
(26, 242397),(26, 242398),(26, 242399),(26, 242400),(26, 242401),(26, 242402),(26, 242403),(26, 242404),(26, 242405),(26, 242406),(26, 242407),
(26, 242408),(26, 242409),(26, 242410),(26, 242411),(26, 242412),(26, 242413),(26, 242414),(26, 242415),(26, 242416),(26, 242417),(26, 242418),
(26, 242419),(26, 242420),(26, 242421),(26, 242422),(26, 242423),(26, 242424),(26, 242425),(26, 242426),(26, 242427),(26, 242428),(26, 242429),
(26, 242430),(26, 242431),(26, 242432),(26, 242433),(26, 242434),(26, 242435),(26, 242436),(26, 242437),(26, 242438),(26, 242439),(26, 242440),
(26, 242441),(26, 242442),(26, 242443),(26, 242444),(26, 242445),(26, 242446),(26, 242447),(26, 242448),(26, 242449),(26, 242450),(26, 242451),
(26, 242452),(26, 242453),(26, 242454),(26, 242455),(26, 242456),(26, 242457),(26, 242458),(26, 242459),(26, 242460),(26, 242461),(26, 242462),
(26, 242463),(26, 242464),(26, 242465),(26, 242466),(26, 242467),(26, 242468),(26, 242469),(26, 242470),(26, 242471),(26, 242472),(26, 242473),
(26, 242474),(26, 242475),(26, 242476),(26, 242477),(26, 242478),(26, 242479),(26, 242480),(26, 242481),(26, 242482),(26, 242483),(26, 242484),
(26, 242485),(26, 242486),(26, 242487),(26, 242488),(26, 242489),(26, 242490),(26, 242491),(26, 242492),(26, 242493),(26, 242494),(26, 242495),
(26, 242496),(26, 242497),(26, 242498),(26, 242499),(26, 242500),(26, 242501),(26, 242502),(26, 242503),(26, 242504),(26, 242505),(26, 242506),
(26, 242507),(26, 242508),(26, 242509),(26, 242510),(26, 242511),(26, 242512),(26, 242513),(26, 242514),(26, 242515),(26, 242516),(26, 242517),
(26, 242518),(26, 242519),(26, 242520),(26, 242521),(26, 242522),(26, 242523),(26, 242524),(26, 242525),(26, 242526),(26, 242527),(26, 242528),
(26, 242529),(26, 242530),(26, 242531),(26, 242532),(26, 242533),(26, 242534),(26, 242535),(26, 242536),(26, 242537),(26, 242538),(26, 242539),
(26, 242540),(26, 242541),(26, 242542),(26, 242543),(26, 242544),(26, 242545),(26, 242546),(26, 242547),(26, 242548),(26, 242549),(26, 242550),
(26, 242551),(26, 242552),(26, 242553),(26, 242554),(26, 242555),(26, 242556),(26, 242557),(26, 242558),(26, 242559),(26, 242560),(26, 242561),
(26, 242562),(26, 242563),(26, 242564),(26, 242565),(26, 242566),(26, 242567),(26, 242568),(26, 242569),(26, 242570),(26, 242571),(26, 242572),
(26, 242573),(26, 242574),(26, 242575),(26, 242576),(26, 242577),(26, 242578),(26, 242579),(26, 242580),(26, 242581),(26, 242582),(26, 242583),
(26, 242584),(26, 242585),(26, 242586),(26, 242587),(26, 242588),(26, 242589),(26, 242590),(26, 242591),(26, 242592),(26, 242593),(26, 242594),
(26, 242595),(26, 242596),(26, 242597),(26, 242598),(26, 242599),(26, 242600),(26, 242601),(26, 242602),(26, 242603),(26, 242604),(26, 242605),
(26, 242606),(26, 242607),(26, 242608),(26, 242609),(26, 242610),(26, 242611),(26, 242612),(26, 242613),(26, 242614),(26, 242615),(26, 242616),
(26, 242617),(26, 242618),(26, 242619),(26, 242620),(26, 242621),(26, 242622),(26, 242623),(26, 242624),(26, 242625),(26, 242626),(26, 242627),
(26, 242628),(26, 242629),(26, 242630),(26, 242631),(26, 242632),(26, 242633),(26, 242634),(26, 242635),(26, 242636),(26, 242637),(26, 242638),
(26, 242639),(26, 242640),(26, 242641),(26, 242642),(26, 242643),(26, 242644),(26, 242645),(26, 242646),(26, 242647),(26, 242648),(26, 242649),
(26, 242650),(26, 242651),(26, 242652),(26, 242653),(26, 242654),(26, 242655),(26, 242656),(26, 242657),(26, 242658),(26, 242659),(26, 242660),
(26, 242661),(26, 242662),(26, 242663),(26, 242664),(26, 242665),(26, 242666),(26, 242667),(26, 242668),(26, 242669),(26, 242670),(26, 242671),
(26, 242672),(26, 242673),(26, 242674),(26, 242675),(26, 242676),(26, 242677),(26, 242678),(26, 242679),(26, 242680),(26, 242681),(26, 242682),
(26, 242683),(26, 242684),(26, 242685),(26, 242686),(26, 242687),(26, 242688),(26, 242689),(26, 242690),(26, 242691),(26, 242692),(26, 242693),
(26, 242694),(26, 242695),(26, 242696),(26, 242697),(26, 242698),(26, 242699),(26, 242700),(26, 242701),(26, 242702),(26, 242703),(26, 242704),
(26, 242705),(26, 242706),(26, 242707),(26, 242708),(26, 242709),(26, 242710),(26, 242711),(26, 242712),(26, 242713),(26, 242714),(26, 242715),
(26, 242716),(26, 242717),(26, 242718),(26, 242719),(26, 242720),(26, 242721),(26, 242722),(26, 242723),(26, 242724),(26, 242725),(26, 242726),
(26, 242727),(26, 242728),(26, 242729),(26, 242730),(26, 242731),(26, 242732),(26, 242733),(26, 242734),(26, 242735),(26, 242736),(26, 242737),
(26, 242738),(26, 242739),(26, 242740),(26, 242741),(26, 242742),(26, 242743),(26, 242744),(26, 242745),(26, 242746),(26, 242747),(26, 242748),
(26, 242749),(26, 242750),(26, 242751),(26, 242752),(26, 242753),(26, 242754),(26, 242755),(26, 242756),(26, 242757),(26, 242758),(26, 242759),
(26, 242760),(26, 242761),(26, 242762),(26, 242763),(26, 242764),(26, 242765),(26, 242766),(26, 242767),(26, 242768),(26, 242769),(26, 242770),
(26, 242771),(26, 242772),(26, 242773),(26, 242774),(26, 242775),(26, 242776),(26, 242777),(26, 242778),(26, 242779),(26, 242780),(26, 242781),
(26, 242782),(26, 242783),(26, 242784),(26, 242785),(26, 242786),(26, 242787),(26, 242788),(26, 242789),(26, 242790),(26, 242791),(26, 242792),
(26, 242793),(26, 242794),(26, 242795),(26, 242796),(26, 242797),(26, 242798),(26, 242799),(26, 242800),(26, 242801),(26, 242802),(26, 242803),
(26, 242804),(26, 242805),(26, 242806),(26, 242807),(26, 242808),(26, 242809),(26, 242810),(26, 242811),(26, 242812),(26, 242813),(26, 242814),
(26, 242815),(26, 242816),(26, 242817),(26, 242818),(26, 242819),(26, 242820),(26, 242821),(26, 242822),(26, 242823),(26, 242824),(26, 242825),
(26, 242826),(26, 242827),(26, 242828),(26, 242829),(26, 242830),(26, 242831),(26, 242832),(26, 242833),(26, 242834),(26, 242835),(26, 242836),
(26, 242837),(26, 242838),(26, 242839),(26, 242840),(26, 242841),(26, 242842),(26, 242843),(26, 242844),(26, 242845),(26, 242846),(26, 242847),
(26, 242848),(26, 242849),(26, 242850),(26, 242851),(26, 242852),(26, 242853),(26, 242854),(26, 242855),(26, 242856),(26, 242857),(26, 242858),
(26, 242859),(26, 242860),(26, 242861),(26, 242862),(26, 242863),(26, 242864),(26, 242865),(26, 242866),(26, 242867),(26, 242868),(26, 242869),
(26, 242870),(26, 242871),(26, 242872),(26, 242873),(26, 242874),(26, 242875),(26, 242876),(26, 242877),(26, 242878),(26, 242879),(26, 242880),
(26, 242881),(26, 242882),(26, 242883),(26, 242884),(26, 242885),(26, 242886),(26, 242887),(26, 242888),(26, 242889),(26, 242890),(26, 242891),
(26, 242892),(26, 242893),(26, 242894),(26, 242895),(26, 242896),(26, 242897),(26, 242898),(26, 242899),(26, 242900),(26, 242901),(26, 242902),
(26, 242903),(26, 242904),(26, 242905),(26, 242906),(26, 242907),(26, 242908),(26, 242909),(26, 242910),(26, 242911),(26, 242912),(26, 242913),
(26, 242914),(26, 242915),(26, 242916),(26, 242917),(26, 242918),(26, 242919),(26, 242920),(26, 242921),(26, 242922),(26, 242923),(26, 242924),
(26, 242925),(26, 242926),(26, 242927),(26, 242928),(26, 242929),(26, 242930),(26, 242931),(26, 242932),(26, 242933),(26, 242934),(26, 242935),
(26, 242936),(26, 242937),(26, 242938),(26, 242939),(26, 242940),(26, 242941),(26, 242942),(26, 242943),(26, 242944),(26, 242945),(26, 242946),
(26, 242947),(26, 242948),(26, 242949),(26, 242950),(26, 242951),(26, 242952),(26, 242953),(26, 242954),(26, 242955),(26, 242956),(26, 242957),
(26, 242958),(26, 242959),(26, 242960),(26, 242961),(26, 242962),(26, 242963),(26, 242964),(26, 242965),(26, 242966),(26, 242967),(26, 242968),
(26, 242969),(26, 242970),(26, 242971),(26, 242972),(26, 242973),(26, 242974),(26, 242975),(26, 242976),(26, 242977),(26, 242978),(26, 242979),
(26, 242980),(26, 242981),(26, 242982),(26, 242983),(26, 242984),(26, 242985),(26, 242986),(26, 242987),(26, 242988),(26, 242989),(26, 242990),
(26, 242991),(26, 242992),(26, 242993),(26, 242994),(26, 242995),(26, 242996),(26, 242997),(26, 242998),(26, 242999),(26, 243000),(26, 243001),
(26, 243002),(26, 243003),(26, 243004),(26, 243005),(26, 243006),(26, 243007),(26, 243008),(26, 243009),(26, 243010),(26, 243011),(26, 243012),
(26, 243013),(26, 243014),(26, 243015),(26, 243016),(26, 243017),(26, 243018),(26, 243019),(26, 243020),(26, 243021),(26, 243022),(26, 243023),
(26, 243024),(26, 243025),(26, 243026),(26, 243027),(26, 243028),(26, 243029),(26, 243030),(26, 243031),(26, 243032),(26, 243033),(26, 243034),
(26, 243035),(26, 243036),(26, 243037),(26, 243038),(26, 243039),(26, 243040),(26, 243041),(26, 243042),(26, 243043),(26, 243044),(26, 243045),
(26, 243046),(26, 243047),(26, 243048),(26, 243049),(26, 243050),(26, 243051),(26, 243052),(26, 243053),(26, 243054),(26, 243055),(26, 243056),
(26, 243057),(26, 243058),(26, 243059),(26, 243060),(26, 243061),(26, 243062),(26, 243063),(26, 243064),(26, 243065),(26, 243066),(26, 243067),
(26, 243068),(26, 243069),(26, 243070),(26, 243071),(26, 243072),(26, 243073),(26, 243074),(26, 243075),(26, 243076),(26, 243077),(26, 243078),
(26, 243079),(26, 243080),(26, 243081),(26, 243082),(26, 243083),(26, 243084),(26, 243085),(26, 243086),(26, 243087),(26, 243088),(26, 243089),
(26, 243090),(26, 243091),(26, 243092),(26, 243093),(26, 243094),(26, 243095),(26, 243096),(26, 243097),(26, 243098),(26, 243099),(26, 243100),
(26, 243101),(26, 243102),(26, 243103),(26, 243104),(26, 243105),(26, 243106),(26, 243107),(26, 243108),(26, 243109),(26, 243110),(26, 243111),
(26, 243112),(26, 243113),(26, 243114),(26, 243115),(26, 243116),(26, 243117),(26, 243118),(26, 243119),(26, 243120),(26, 243121),(26, 243122),
(26, 243123),(26, 243124),(26, 243125),(26, 243126),(26, 243127),(26, 243128),(26, 243129),(26, 243130),(26, 243131),(26, 243132),(26, 243133),
(26, 243134),(26, 243135),(26, 243136),(26, 243137),(26, 243138),(26, 243139),(26, 243140),(26, 243141),(26, 243142),(26, 243143),(26, 243144),
(26, 243145),(26, 243146),(26, 243147),(26, 243148),(26, 243149),(26, 243150),(26, 243151),(26, 243152),(26, 243153),(26, 243154),(26, 243155),
(26, 243156),(26, 243157),(26, 243158),(26, 243159),(26, 243160),(26, 243161),(26, 243162),(26, 243163),(26, 243164),(26, 243165),(26, 243166),
(26, 243167),(26, 243168),(26, 243169),(26, 243170),(26, 243171),(26, 243172),(26, 243173),(26, 243174),(26, 243175),(26, 243176),(26, 243177),
(26, 243178),(26, 243179),(26, 243180),(26, 243181),(26, 243182),(26, 243183),(26, 243184),(26, 243185),(26, 243186),(26, 243187),(26, 243188),
(26, 243189),(26, 243190),(26, 243191),(26, 243192),(26, 243193),(26, 243194),(26, 243195),(26, 243196),(26, 243197),(26, 243198),(26, 243199),
(26, 243200),(26, 243201),(26, 243202),(26, 243203),(26, 243204),(26, 243205),(26, 243206),(26, 243207),(26, 243208),(26, 243209),(26, 243210),
(26, 243211),(26, 243212),(26, 243213),(26, 243214),(26, 243215),(26, 243216),(26, 243217),(26, 243218),(26, 243219),(26, 243220),(26, 243221),
(26, 243222),(26, 243223),(26, 243224),(26, 243225),(26, 243226),(26, 243227),(26, 243228),(26, 243229),(26, 243230),(26, 243231),(26, 243232),
(26, 243233),(26, 243234),(26, 243235),(26, 243236),(26, 243237),(26, 243238),(26, 243239),(26, 243240),(26, 243241),(26, 243242),(26, 243243),
(26, 243244),(26, 243245),(26, 243246),(26, 243247),(26, 243248),(26, 243249),(26, 243250),(26, 243251),(26, 243252),(26, 243253),(26, 243254),
(26, 243255),(26, 243256),(26, 243257),(26, 243258),(26, 243259),(26, 243260),(26, 243261),(26, 243262),(26, 243263),(26, 243264),(26, 243265),
(26, 243266),(26, 243267),(26, 243268),(26, 243269),(26, 243270),(26, 243271),(26, 243272),(26, 243273),(26, 243274),(26, 243275),(26, 243276),
(26, 243277),(26, 243278),(26, 243279),(26, 243280),(26, 243281),(26, 243282),(26, 243283),(26, 243284),(26, 243285),(26, 243286),(26, 243287),
(26, 243288),(26, 243289),(26, 243290),(26, 243291),(26, 243292),(26, 243293),(26, 243294),(26, 243295),(26, 243296),(26, 243297),(26, 243298),
(26, 243299),(26, 243300),(26, 243301),(26, 243302),(26, 243303),(26, 243304),(26, 243305),(26, 243306),(26, 243307),(26, 243308),(26, 243309),
(26, 243310),(26, 243311),(26, 243312),(26, 243313),(26, 243314),(26, 243315),(26, 243316),(26, 243317),(26, 243318),(26, 243319),(26, 243320),
(26, 243321),(26, 243322),(26, 243323),(26, 243324),(26, 243325),(26, 243326),(26, 243327),(26, 243328),(26, 243329),(26, 243330),(26, 243331),
(26, 243332),(26, 243333),(26, 243334),(26, 243335),(26, 243336),(26, 243337),(26, 243338),(26, 243339),(26, 243340),(26, 243341),(26, 243342),
(26, 243343),(26, 243344),(26, 243345),(26, 243346),(26, 243347),(26, 243348),(26, 243349),(26, 243350),(26, 243351),(26, 243352),(26, 243353),
(26, 243354),(26, 243355),(26, 243356),(26, 243357),(26, 243358),(26, 243359),(26, 243360),(26, 243361),(26, 243362),(26, 243363),(26, 243364),
(26, 243365),(26, 243366),(26, 243367),(26, 243368),(26, 243369),(26, 243370),(26, 243371),(26, 243372),(26, 243373),(26, 243374),(26, 243375),
(26, 243376),(26, 243377),(26, 243378),(26, 243379),(26, 243380),(26, 243381),(26, 243382),(26, 243383),(26, 243384),(26, 243385),(26, 243386),
(26, 243387),(26, 243388),(26, 243389),(26, 243390),(26, 243391),(26, 243392),(26, 243393),(26, 243394),(26, 243395),(26, 243396),(26, 243397),
(26, 243398),(26, 243399),(26, 243400),(26, 243401),(26, 243402),(26, 243403),(26, 243404),(26, 243405),(26, 243406),(26, 243407),(26, 243408),
(26, 243409),(26, 243410),(26, 243411),(26, 243412),(26, 243413),(26, 243414),(26, 243415),(26, 243416),(26, 243417),(26, 243418),(26, 243419),
(26, 243420),(26, 243421),(26, 243422),(26, 243423),(26, 243424),(26, 243425),(26, 243426),(26, 243427),(26, 243428),(26, 243429),(26, 243430),
(26, 243431),(26, 243432),(26, 243433),(26, 243434),(26, 243435),(26, 243436),(26, 243437),(26, 243438),(26, 243439),(26, 243440),(26, 243441),
(26, 243442),(26, 243443),(26, 243444),(26, 243445),(26, 243446),(26, 243447),(26, 243448),(26, 243449),(26, 243450),(26, 243451),(26, 243452),
(26, 243453),(26, 243454),(26, 243455),(26, 243456),(26, 243457),(26, 243458),(26, 243459),(26, 243460),(26, 243461),(26, 243462),(26, 243463),
(26, 243464),(26, 243465),(26, 243466),(26, 243467),(26, 243468),(26, 243469),(26, 243470),(26, 243471),(26, 243472),(26, 243473),(26, 243474),
(26, 243475),(26, 243476),(26, 243477),(26, 243478),(26, 243479),(26, 243480),(26, 243481),(26, 243482),(26, 243483),(26, 243484),(26, 243485),
(26, 243486),(26, 243487),(26, 243488),(26, 243489),(26, 243490),(26, 243491),(26, 243492),(26, 243493),(26, 243494),(26, 243495),(26, 243496),
(26, 243497),(26, 243498),(26, 243499),(26, 243500),(26, 243501),(26, 243502),(26, 243503),(26, 243504),(26, 243505),(26, 243506),(26, 243507),
(26, 243508),(26, 243509),(26, 243510),(26, 243511),(26, 243512),(26, 243513),(26, 243514),(26, 243515),(26, 243516),(26, 243517),(26, 243518),
(26, 243519),(26, 243520),(26, 243521),(26, 243522),(26, 243523),(26, 243524),(26, 243525),(26, 243526),(26, 243527),(26, 243528),(26, 243529),
(26, 243530),(26, 243531),(26, 243532),(26, 243533),(26, 243534),(26, 243535),(26, 243536),(26, 243537),(26, 243538),(26, 243539),(26, 243540),
(26, 243541),(26, 243542),(26, 243543),(26, 243544),(26, 243545),(26, 243546),(26, 243547),(26, 243548),(26, 243549),(26, 243550),(26, 243551),
(26, 243552),(26, 243553),(26, 243554),(26, 243555),(26, 243556),(26, 243557),(26, 243558),(26, 243559),(26, 243560),(26, 243561),(26, 243562),
(26, 243563),(26, 243564),(26, 243565),(26, 243566),(26, 243567),(26, 243568),(26, 243569),(26, 243570),(26, 243571),(26, 243572),(26, 243573),
(26, 243574),(26, 243575),(26, 243576),(26, 243577),(26, 243578),(26, 243579),(26, 243580),(26, 243581),(26, 243582),(26, 243583),(26, 243584),
(26, 243585),(26, 243586),(26, 243587),(26, 243588),(26, 243589),(26, 243590),(26, 243591),(26, 243592),(26, 243593),(26, 243594),(26, 243595),
(26, 243596),(26, 243597),(26, 243598),(26, 243599),(26, 243600),(26, 243601),(26, 243602),(26, 243603),(26, 243604),(26, 243605),(26, 243606),
(26, 243607),(26, 243608),(26, 243609),(26, 243610),(26, 243611),(26, 243612),(26, 243613),(26, 243614),(26, 243615),(26, 243616),(26, 243617),
(26, 243618),(26, 243619),(26, 243620),(26, 243621),(26, 243622),(26, 243623),(26, 243624),(26, 243625),(26, 243626),(26, 243627),(26, 243628),
(26, 243629),(26, 243630),(26, 243631),(26, 243632),(26, 243633),(26, 243634),(26, 243635),(26, 243636),(26, 243637),(26, 243638),(26, 243639),
(26, 243640),(26, 243641),(26, 243642),(26, 243643),(26, 243644),(26, 243645),(26, 243646),(26, 243647),(26, 243648),(26, 243649),(26, 243650),
(26, 243651),(26, 243652),(26, 243653),(26, 243654),(26, 243655),(26, 243656),(26, 243657),(26, 243658),(26, 243659),(26, 243660),(26, 243661),
(26, 243662),(26, 243663),(26, 243664),(26, 243665),(26, 243666),(26, 243667),(26, 243668),(26, 243669),(26, 243670),(26, 243671),(26, 243672),
(26, 243673),(26, 243674),(26, 243675),(26, 243676),(26, 243677),(26, 243678),(26, 243679),(26, 243680),(26, 243681),(26, 243682),(26, 243683),
(26, 243684),(26, 243685),(26, 243686),(26, 243687),(26, 243688),(26, 243689),(26, 243690),(26, 243691),(26, 243692),(26, 243693),(26, 243694),
(26, 243695),(26, 243696),(26, 243697),(26, 243698),(26, 243699),(26, 243700),(26, 243701),(26, 243702),(26, 243703),(26, 243704),(26, 243705),
(26, 243706),(26, 243707),(26, 243708),(26, 243709),(26, 243710),(26, 243711),(26, 243712),(26, 243713),(26, 243714),(26, 243715),(26, 243716),
(26, 243717),(26, 243718),(26, 243719),(26, 243720),(26, 243721),(26, 243722),(26, 243723),(26, 243724),(26, 243725),(26, 243726),(26, 243727),
(26, 243728),(26, 243729),(26, 243730),(26, 243731),(26, 243732),(26, 243733),(26, 243734),(26, 243735),(26, 243736),(26, 243737),(26, 243738),
(26, 243739),(26, 243740),(26, 243741),(26, 243742),(26, 243743),(26, 243744),(26, 243745),(26, 243746),(26, 243747),(26, 243748),(26, 243749),
(26, 243750),(26, 243751),(26, 243752),(26, 243753),(26, 243754),(26, 243755),(26, 243756),(26, 243757),(26, 243758),(26, 243759),(26, 243760),
(26, 243761),(26, 243762),(26, 243763),(26, 243764),(26, 243765),(26, 243766),(26, 243767),(26, 243768),(26, 243769),(26, 243770),(26, 243771),
(26, 243772),(26, 243773),(26, 243774),(26, 243775),(26, 243776),(26, 243777),(26, 243778),(26, 243779),(26, 243780),(26, 243781),(26, 243782),
(26, 243783),(26, 243784),(26, 243785),(26, 243786),(26, 243787),(26, 243788),(26, 243789),(26, 243790),(26, 243791),(26, 243792),(26, 243793),
(26, 243794),(26, 243795),(26, 243796),(26, 243797),(26, 243798),(26, 243799),(26, 243800),(26, 243801),(26, 243802),(26, 243803),(26, 243804),
(26, 243805),(26, 243806),(26, 243807),(26, 243808),(26, 243809),(26, 243810),(26, 243811),(26, 243812),(26, 243813),(26, 243814),(26, 243815),
(26, 243816),(26, 243817),(26, 243818),(26, 243819),(26, 243820),(26, 243821),(26, 243822),(26, 243823),(26, 243824),(26, 243825),(26, 243826),
(26, 243827),(26, 243828),(26, 243829),(26, 243830),(26, 243831),(26, 243832),(26, 243833),(26, 243834),(26, 243835),(26, 243836),(26, 243837),
(26, 243838),(26, 243839),(26, 243840),(26, 243841),(26, 243842),(26, 243843),(26, 243844),(26, 243845),(26, 243846),(26, 243847),(26, 243848),
(26, 243849),(26, 243850),(26, 243851),(26, 243852),(26, 243853),(26, 243854),(26, 243855),(26, 243856),(26, 243857),(26, 243858),(26, 243859),
(26, 243860),(26, 243861),(26, 243862),(26, 243863),(26, 243864),(26, 243865),(26, 243866),(26, 243867),(26, 243868),(26, 243869),(26, 243870),
(26, 243871),(26, 243872),(26, 243873),(26, 243874),(26, 243875),(26, 243876),(26, 243877),(26, 243878),(26, 243879),(26, 243880),(26, 243881),
(26, 243882),(26, 243883),(26, 243884),(26, 243885),(26, 243886),(26, 243887),(26, 243888),(26, 243889),(26, 243890),(26, 243891),(26, 243892),
(26, 243893),(26, 243894),(26, 243895),(26, 243896),(26, 243897),(26, 243898),(26, 243899),(26, 243900),(26, 243901),(26, 243902),(26, 243903),
(26, 243904),(26, 243905),(26, 243906),(26, 243907),(26, 243908),(26, 243909),(26, 243910),(26, 243911),(26, 243912),(26, 243913),(26, 243914),
(26, 243915),(26, 243916),(26, 243917),(26, 243918),(26, 243919),(26, 243920),(26, 243921),(26, 243922),(26, 243923),(26, 243924),(26, 243925),
(26, 243926),(26, 243927),(26, 243928),(26, 243929),(26, 243930),(26, 243931),(26, 243932),(26, 243933),(26, 243934),(26, 243935),(26, 243936),
(26, 243937),(26, 243938),(26, 243939),(26, 243940),(26, 243941),(26, 243942),(26, 243943),(26, 243944),(26, 243945),(26, 243946),(26, 243947),
(26, 243948),(26, 243949),(26, 243950),(26, 243951),(26, 243952),(26, 243953),(26, 243954),(26, 243955),(26, 243956),(26, 243957),(26, 243958),
(26, 243959),(26, 243960),(26, 243961),(26, 243962),(26, 243963),(26, 243964),(26, 243965),(26, 243966),(26, 243967),(26, 243968),(26, 243969),
(26, 243970),(26, 243971),(26, 243972),(26, 243973),(26, 243974),(26, 243975),(26, 243976),(26, 243977),(26, 243978),(26, 243979),(26, 243980),
(26, 243981),(26, 243982),(26, 243983),(26, 243984),(26, 243985),(26, 243986),(26, 243987),(26, 243988),(26, 243989),(26, 243990),(26, 243991),
(26, 243992),(26, 243993),(26, 243994),(26, 243995),(26, 243996),(26, 243997),(26, 243998),(26, 243999),(26, 244000),(26, 244001),(26, 244002),
(26, 244003),(26, 244004),(26, 244005),(26, 244006),(26, 244007),(26, 244008),(26, 244009),(26, 244010),(26, 244011),(26, 244012),(26, 244013),
(26, 244014),(26, 244015),(26, 244016),(26, 244017),(26, 244018),(26, 244019),(26, 244020),(26, 244021),(26, 244022),(26, 244023),(26, 244024),
(26, 244025),(26, 244026),(26, 244027),(26, 244028),(26, 244029),(26, 244030),(26, 244031),(26, 244032),(26, 244033),(26, 244034),(26, 244035),
(26, 244036),(26, 244037),(26, 244038),(26, 244039),(26, 244040),(26, 244041),(26, 244042),(26, 244043),(26, 244044),(26, 244045),(26, 244046),
(26, 244047),(26, 244048),(26, 244049),(26, 244050),(26, 244051),(26, 244052),(26, 244053),(26, 244054),(26, 244055),(26, 244056),(26, 244057),
(26, 244058),(26, 244059),(26, 244060),(26, 244061),(26, 244062),(26, 244063),(26, 244064),(26, 244065),(26, 244066),(26, 244067),(26, 244068),
(26, 244069),(26, 244070),(26, 244071),(26, 244072),(26, 244073),(26, 244074),(26, 244075),(26, 244076),(26, 244077),(26, 244078),(26, 244079),
(26, 244080),(26, 244081),(26, 244082),(26, 244083),(26, 244084),(26, 244085),(26, 244086),(26, 244087),(26, 244088),(26, 244089),(26, 244090),
(26, 244091),(26, 244092),(26, 244093),(26, 244094),(26, 244095),(26, 244096),(26, 244097),(26, 244098),(26, 244099),(26, 244100),(26, 244101),
(26, 244102),(26, 244103),(26, 244104),(26, 244105),(26, 244106),(26, 244107),(26, 244108),(26, 244109),(26, 244110),(26, 244111),(26, 244112),
(26, 244113),(26, 244114),(26, 244115),(26, 244116),(26, 244117),(26, 244118),(26, 244119),(26, 244120),(26, 244121),(26, 244122),(26, 244123),
(26, 244124),(26, 244125),(26, 244126),(26, 244127),(26, 244128),(26, 244129),(26, 244130),(26, 244131),(26, 244132),(26, 244133),(26, 244134),
(26, 244135),(26, 244136),(26, 244137),(26, 244138),(26, 244139),(26, 244140),(26, 244141),(26, 244142),(26, 244143),(26, 244144),(26, 244145),
(26, 244146),(26, 244147),(26, 244148),(26, 244149),(26, 244150),(26, 244151),(26, 244152),(26, 244153),(26, 244154),(26, 244155),(26, 244156),
(26, 244157),(26, 244158),(26, 244159),(26, 244160),(26, 244161),(26, 244162),(26, 244163),(26, 244164),(26, 244165),(26, 244166),(26, 244167),
(26, 244168),(26, 244169),(26, 244170),(26, 244171),(26, 244172),(26, 244173),(26, 244174),(26, 244175),(26, 244176),(26, 244177),(26, 244178),
(26, 244179),(26, 244180),(26, 244181),(26, 244182),(26, 244183),(26, 244184),(26, 244185),(26, 244186),(26, 244187),(26, 244188),(26, 244189),
(26, 244190),(26, 244191),(26, 244192),(26, 244193),(26, 244194),(26, 244195),(26, 244196),(26, 244197),(26, 244198),(26, 244199),(26, 244200),
(26, 244201),(26, 244202),(26, 244203),(26, 244204),(26, 244205),(26, 244206),(26, 244207),(26, 244208),(26, 244209),(26, 244210),(26, 244211),
(26, 244212),(26, 244213),(26, 244214),(26, 244215),(26, 244216),(26, 244217),(26, 244218),(26, 244219),(26, 244220),(26, 244221),(26, 244222),
(26, 244223),(26, 244224),(26, 244225),(26, 244226),(26, 244227),(26, 244228),(26, 244229),(26, 244230),(26, 244231),(26, 244232),(26, 244233),
(26, 244234),(26, 244235),(26, 244236),(26, 244237),(26, 244238),(26, 244239),(26, 244240),(26, 244241),(26, 244242),(26, 244243),(26, 244244),
(26, 244245),(26, 244246),(26, 244247),(26, 244248),(26, 244249),(26, 244250),(26, 244251),(26, 244252),(26, 244253),(26, 244254),(26, 244255),
(26, 244256),(26, 244257),(26, 244258),(26, 244259),(26, 244260),(26, 244261),(26, 244262),(26, 244263),(26, 244264),(26, 244265),(26, 244266),
(26, 244267),(26, 244268),(26, 244269),(26, 244270),(26, 244271),(26, 244272),(26, 244273),(26, 244274),(26, 244275),(26, 244276),(26, 244277),
(26, 244278),(26, 244279),(26, 244280),(26, 244281),(26, 244282),(26, 244283),(26, 244284),(26, 244285),(26, 244286),(26, 244287),(26, 244288),
(26, 244289),(26, 244290),(26, 244291),(26, 244292),(26, 244293),(26, 244294),(26, 244295),(26, 244296),(26, 244297),(26, 244298),(26, 244299),
(26, 244300),(26, 244301),(26, 244302),(26, 244303),(26, 244304),(26, 244305),(26, 244306),(26, 244307),(26, 244308),(26, 244309),(26, 244310),
(26, 244311),(26, 244312),(26, 244313),(26, 244314),(26, 244315),(26, 244316),(26, 244317),(26, 244318),(26, 244319),(26, 244320),(26, 244321),
(26, 244322),(26, 244323),(26, 244324),(26, 244325),(26, 244326),(26, 244327),(26, 244328),(26, 244329),(26, 244330),(26, 244331),(26, 244332),
(26, 244333),(26, 244334),(26, 244335),(26, 244336),(26, 244337),(26, 244338),(26, 244339),(26, 244340),(26, 244341),(26, 244342),(26, 244343),
(26, 244344),(26, 244345),(26, 244346),(26, 244347),(26, 244348),(26, 244349),(26, 244350),(26, 244351),(26, 244352),(26, 244353),(26, 244354),
(26, 244355),(26, 244356),(26, 244357),(26, 244358),(26, 244359),(26, 244360),(26, 244361),(26, 244362),(26, 244363),(26, 244364),(26, 244365),
(26, 244366),(26, 244367),(26, 244368),(26, 244369),(26, 244370),(26, 244371),(26, 244372),(26, 244373),(26, 244374),(26, 244375),(26, 244376),
(26, 244377),(26, 244378),(26, 244379),(26, 244380),(26, 244381),(26, 244382),(26, 244383),(26, 244384),(26, 244385),(26, 244386),(26, 244387),
(26, 244388),(26, 244389),(26, 244390),(26, 244391),(26, 244392),(26, 244393),(26, 244394),(26, 244395),(26, 244396),(26, 244397),(26, 244398),
(26, 244399);

-- ---------------------------------
-- Gameobject spawns
-- ---------------------------------
DELETE FROM gameobject WHERE guid IN(SELECT guid FROM game_event_gameobject WHERE eventEntry=26);
DELETE FROM gameobject WHERE guid BETWEEN 240400 AND 240991;
INSERT INTO gameobject VALUES (240400, 180353, 0, 1, 1, -5072.26, -803.167, 495.128, 6.17696, 0, 0, 0.0530877, -0.99859, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240401, 180353, 0, 1, 1, -5071.41, -783.176, 494.957, 0.702734, 0, 0, 0.344182, 0.938903, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240402, 180353, 0, 1, 1, -5076.27, -780.06, 495.307, 1.17397, 0, 0, 0.553853, 0.832614, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240403, 180353, 0, 1, 1, -5085.47, -807.597, 495.124, 4.16634, 0, 0, 0.871583, -0.490247, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240404, 180353, 0, 1, 1, -5076.06, -806.492, 495.126, 5.89029, 0, 0, 0.195187, -0.980766, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240405, 180353, 0, 1, 1, -5092.54, -808.978, 495.1, 6.22801, 0, 0, 0.0275841, -0.999619, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240406, 180353, 0, 1, 1, -5095.12, -790.328, 495.205, 3.48698, 0, 0, 0.985125, -0.171837, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240407, 180353, 0, 1, 1, -5084.4, -786.175, 495.73, 3.2435, 0, 0, 0.998702, -0.0509316, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240408, 195303, 0, 1, 1, -5077.27, -781.108, 495.129, 4.67293, 0, 0, 0.720919, -0.693019, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240409, 195303, 0, 1, 1, -5078.82, -811.385, 495.128, 1.35069, 0, 0, 0.625167, 0.780491, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240410, 195303, 0, 1, 1, -5079.17, -811.633, 495.128, 4.6101, 0, 0, 0.742331, -0.670033, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240411, 195212, 0, 1, 1, -5071.77, -785.649, 495.013, 0.698816, 0, 0, 0.342342, 0.939576, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240412, 195197, 0, 1, 1, -5071.19, -788.535, 495.001, 0.561371, 0, 0, 0.277014, 0.960866, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240413, 180353, 0, 1, 1, -9122.03, 343.65, 94.1882, 1.4816, 0, 0, 0.674878, 0.737929, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240414, 180353, 0, 1, 1, -9122.97, 335.626, 93.6704, 1.4816, 0, 0, 0.674878, 0.737929, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240415, 180353, 0, 1, 1, -9123.28, 332.133, 93.3779, 1.4816, 0, 0, 0.674878, 0.737929, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240416, 180353, 0, 1, 1, -9123.96, 324.078, 93.4462, 1.61119, 0, 0, 0.721243, 0.692682, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240417, 180353, 0, 1, 1, -9123.81, 320.224, 93.4622, 1.61119, 0, 0, 0.721243, 0.692682, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240418, 180353, 0, 1, 1, -9123.5, 312.509, 93.314, 1.61119, 0, 0, 0.721243, 0.692682, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240419, 180353, 0, 1, 1, -9123.38, 309.698, 93.1581, 1.61119, 0, 0, 0.721243, 0.692682, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240420, 180353, 0, 1, 1, -9108.5, 307.8, 93.8631, 4.61534, 0, 0, 0.740573, -0.671976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240421, 180353, 0, 1, 1, -9108.21, 310.725, 93.7368, 4.61534, 0, 0, 0.740573, -0.671976, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240422, 180353, 0, 1, 1, -9106.67, 320.002, 93.4244, 4.79991, 0, 0, 0.675496, -0.737363, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240423, 180353, 0, 1, 1, -9106.95, 323.154, 93.3763, 4.79991, 0, 0, 0.675496, -0.737363, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240424, 180353, 0, 1, 1, -9106.32, 332.317, 93.5889, 4.75279, 0, 0, 0.69268, -0.721245, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240425, 180353, 0, 1, 1, -9106.46, 335.828, 93.6541, 4.75279, 0, 0, 0.69268, -0.721245, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240426, 180353, 0, 1, 1, -9106.8, 343.546, 93.5129, 4.69388, 0, 0, 0.71362, -0.700533, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240427, 180353, 0, 1, 1, -9106.72, 347.759, 93.3323, 4.69388, 0, 0, 0.71362, -0.700533, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240428, 180353, 0, 1, 1, -9107.88, 355.021, 93.3263, 2.12956, 0, 0, 0.874682, 0.484697, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240429, 180353, 0, 1, 1, -9107.49, 361.434, 93.7582, 4.30904, 0, 0, 0.834416, -0.551135, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240430, 180353, 0, 1, 1, -9106.44, 366.297, 93.4249, 5.97015, 0, 0, 0.155879, -0.987776, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240431, 195303, 0, 1, 1, -9111.39, 362.091, 93.8947, 2.0628, 0, 0, 0.858019, 0.513618, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240432, 195303, 0, 1, 1, -9107.36, 367.547, 93.7091, 3.25661, 0, 0, 0.998347, -0.0574769, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240433, 195303, 0, 1, 1, -9108.46, 370.797, 93.9633, 3.30373, 0, 0, 0.996716, -0.0809799, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240434, 195212, 0, 1, 1, -9106.28, 369.586, 93.3838, 3.6336, 0, 0, 0.969893, -0.24353, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240435, 195212, 0, 1, 1, -9105.45, 364.199, 93.3237, 3.12702, 0, 0, 0.999973, 0.00728632, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240436, 195212, 0, 1, 1, -9109.4, 358.181, 93.6363, 2.58509, 0, 0, 0.961537, 0.274675, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240437, 195212, 0, 1, 1, -9111.21, 356.638, 93.3919, 2.32591, 0, 0, 0.917979, 0.396629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240438, 195212, 0, 1, 1, -9111.16, 360.718, 93.8337, 2.31413, 0, 0, 0.915627, 0.402029, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240439, 195199, 0, 1, 1, -9118.75, 357.285, 93.2502, 1.69366, 0, 0, 0.749184, 0.662361, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240440, 195199, 0, 1, 1, -9111.07, 351.772, 93.4565, 2.0039, 0, 0, 0.842523, 0.53866, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240441, 195199, 0, 1, 1, -9105.29, 367.059, 93.0555, 6.15472, 0, 0, 0.0641886, -0.997938, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240442, 195197, 0, 1, 1, -9109.75, 353.516, 93.3842, 5.47535, 0, 0, 0.393024, -0.919528, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240443, 195197, 0, 1, 1, -9111.72, 368.989, 94.1376, 6.2529, 0, 0, 0.015142, -0.999885, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240444, 195194, 0, 1, 1, -9119.82, 359.342, 93.1893, 5.08265, 0, 0, 0.564863, -0.825185, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240445, 195196, 0, 1, 1, -9113.92, 363.176, 93.8391, 5.46357, 0, 0, 0.398433, -0.917198, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240446, 195198, 0, 1, 1, -9114.53, 354.438, 93.4013, 5.24366, 0, 0, 0.496674, -0.867937, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240447, 195198, 0, 1, 1, -9109.01, 368.778, 94.0214, 0.342777, 0, 0, 0.170551, 0.985349, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240448, 195200, 0, 1, 1, -9114.88, 360.066, 93.5696, 5.88769, 0, 0, 0.196461, -0.980512, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240449, 195215, 0, 1, 1, -9109.13, 364.867, 94.8591, 1.20672, 0, 0, 0.567412, 0.823434, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240450, 195192, 0, 1, 1, -9108.85, 365.595, 94.8591, 1.20672, 0, 0, 0.567412, 0.823434, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240451, 195195, 0, 1, 1, -9110.3, 362.797, 94.8585, 0.814019, 0, 0, 0.395865, 0.918309, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240452, 195164, 0, 1, 1, -9108.9, 364.276, 94.8585, 1.14389, 0, 0, 0.541269, 0.84085, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240453, 195191, 0, 1, 1, -9108.9, 364.276, 93.9704, 2.74217, 0, 0, 0.980124, 0.198386, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240454, 180353, 0, 1, 1, -5069.62, -790.932, 495.128, 6.07878, 0, 0, 0.102025, -0.994782, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240455, 195194, 0, 1, 1, -5074.6, -805.472, 495.127, 5.17166, 0, 0, 0.527591, -0.849498, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240456, 195196, 0, 1, 1, -5081.48, -809.468, 495.127, 5.09312, 0, 0, 0.560536, -0.82813, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240457, 195198, 0, 1, 1, -5078.52, -780.332, 495.148, 1.81016, 0, 0, 0.786475, 0.617623, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240458, 195215, 0, 1, 1, -5074.51, -782.057, 496.007, 3.29063, 0, 0, 0.997225, -0.0744498, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240459, 195192, 0, 1, 1, -5075.63, -782.225, 496.007, 2.68195, 0, 0, 0.973707, 0.227804, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240460, 195195, 0, 1, 1, -5073.04, -783.32, 496.007, 2.21464, 0, 0, 0.894504, 0.44706, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240461, 195164, 0, 1, 1, -5073.87, -782.25, 496.007, 3.03145, 0, 0, 0.998484, 0.0550435, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240462, 195191, 0, 1, 1, -5074.44, -782.17, 495.119, 4.20169, 0, 0, 0.862782, -0.505575, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240463, 180353, 0, 1, 1, -9121.66, 347.84, 94.0413, 1.4816, 0, 0, 0.674878, 0.737929, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240464, 180353, 0, 1, 1, -9120.34, 357.919, 93.1309, 2.03924, 0, 0, 0.851909, 0.52369, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240465, 180353, 0, 1, 1, -9124.05, 353.904, 93.4149, 2.01096, 0, 0, 0.844419, 0.535683, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240466, 180353, 0, 1, 1, -9129.1, 350.316, 93.5324, 2.05966, 0, 0, 0.857211, 0.514965, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240467, 180353, 0, 1, 1, -9126.2, 352.023, 93.5502, 2.16569, 0, 0, 0.883295, 0.468817, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240468, 195191, 1, 1, 1, 10004.8, 2226.45, 1330.13, 3.13414, 0, 0, 0.999993, 0.00372631, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240469, 195164, 1, 1, 1, 10004.8, 2226.39, 1331.01, 1.59868, 0, 0, 0.716896, 0.69718, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240470, 195195, 1, 1, 1, 10004.7, 2224.82, 1331.01, 1.51229, 0, 0, 0.686122, 0.727486, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240471, 195192, 1, 1, 1, 10004.3, 2227.59, 1331.01, 1.67329, 0, 0, 0.7424, 0.669957, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240472, 195215, 1, 1, 1, 10004.4, 2226.69, 1331.01, 1.67722, 0, 0, 0.743715, 0.668497, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240473, 195200, 1, 1, 1, 10001.9, 2221.9, 1329.61, 4.41433, 0, 0, 0.804259, -0.594279, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240474, 195198, 1, 1, 1, 9985.81, 2241.07, 1331.4, 3.28336, 0, 0, 0.997489, -0.0708243, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240475, 195198, 1, 1, 1, 10003.1, 2234.87, 1329.32, 3.79387, 0, 0, 0.947287, -0.320388, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240476, 195196, 1, 1, 1, 10002.5, 2232.19, 1329.84, 3.7978, 0, 0, 0.946655, -0.322248, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240477, 195196, 1, 1, 1, 9988.36, 2241.36, 1331.18, 3.12236, 0, 0, 0.999954, 0.00961618, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240478, 195194, 1, 1, 1, 10001.2, 2225.46, 1329.96, 2.88281, 0, 0, 0.991641, 0.129031, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240479, 195197, 1, 1, 1, 9987.62, 2239.49, 1331.19, 3.04774, 0, 0, 0.998899, 0.0469091, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240480, 195197, 1, 1, 1, 10001.7, 2234.57, 1329.54, 4.3358, 0, 0, 0.826967, -0.56225, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240481, 195212, 1, 1, 1, 10005.8, 2231.28, 1329.7, 3.66821, 0, 0, 0.965534, -0.260277, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240482, 195212, 1, 1, 1, 10009.6, 2230.83, 1329.41, 3.54648, 0, 0, 0.979578, -0.201064, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240483, 195212, 1, 1, 1, 10008.6, 2228.53, 1329.99, 3.45616, 0, 0, 0.987656, -0.156636, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240484, 195212, 1, 1, 1, 10005.7, 2221.27, 1329.69, 2.71788, 0, 0, 0.977642, 0.210275, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240485, 195212, 1, 1, 1, 9990.62, 2240.48, 1330.86, 3.06346, 0, 0, 0.999237, 0.0390563, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240486, 195199, 1, 1, 1, 9990.57, 2243.64, 1330.71, 3.1577, 0, 0, 0.999968, -0.00805362, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240487, 195199, 1, 1, 1, 10007, 2235.34, 1328.77, 4.29653, 0, 0, 0.837847, -0.545905, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240488, 195199, 1, 1, 1, 10009.2, 2223.82, 1329.94, 2.84355, 0, 0, 0.988917, 0.14847, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240489, 195303, 1, 1, 1, 10005.2, 2222.65, 1329.86, 2.71003, 0, 0, 0.976809, 0.214111, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240490, 195303, 1, 1, 1, 10004.3, 2229.67, 1330.11, 3.55041, 0, 0, 0.979181, -0.202988, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240491, 195303, 1, 1, 1, 10004, 2231.16, 1329.87, 3.58575, 0, 0, 0.975442, -0.220258, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240492, 195303, 1, 1, 1, 9989.61, 2240.32, 1331.01, 5.05444, 0, 0, 0.576446, -0.817135, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240493, 180353, 1, 1, 1, 9983.18, 2245.02, 1331.84, 3.23231, 0, 0, 0.998971, -0.0453431, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240494, 180353, 1, 1, 1, 10006.4, 2229.73, 1329.97, 4.63818, 0, 0, 0.732851, -0.680389, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240495, 180353, 1, 1, 1, 10007, 2223.84, 1330.01, 4.69316, 0, 0, 0.713872, -0.700276, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240496, 180353, 1, 1, 1, 10002.6, 2215.54, 1328.7, 3.11451, 0, 0, 0.999908, 0.0135409, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240497, 180353, 1, 1, 1, 10002.7, 2212.55, 1328.26, 3.16163, 0, 0, 0.99995, -0.0100185, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240498, 180353, 1, 1, 1, 10002.2, 2207.07, 1327.79, 3.14985, 0, 0, 0.999991, -0.00412861, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240499, 180353, 1, 1, 1, 10002.8, 2203.31, 1327.76, 3.25195, 0, 0, 0.998478, -0.0551507, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240500, 180353, 1, 1, 1, 9996.26, 2194.43, 1327.7, 3.25588, 0, 0, 0.998368, -0.0571126, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240501, 180353, 1, 1, 1, 9992.76, 2194.03, 1327.82, 3.25588, 0, 0, 0.998368, -0.0571126, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240502, 180353, 1, 1, 1, 9985.05, 2193.15, 1328.59, 3.25588, 0, 0, 0.998368, -0.0571126, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240503, 180353, 1, 1, 1, 9982.1, 2192.81, 1328.84, 3.25588, 0, 0, 0.998368, -0.0571126, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240504, 180353, 1, 1, 1, 9975.17, 2197.07, 1328.93, 1.54371, 0, 0, 0.697466, 0.716618, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240505, 180353, 1, 1, 1, 9975.25, 2200.06, 1328.91, 1.54371, 0, 0, 0.697466, 0.716618, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240506, 180353, 1, 1, 1, 9973.8, 2207.95, 1329.23, 1.61832, 0, 0, 0.723708, 0.690107, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240507, 180353, 1, 1, 1, 9973.67, 2210.56, 1329.33, 1.62225, 0, 0, 0.725062, 0.688683, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240508, 180353, 1, 1, 1, 9976.81, 2216.66, 1329.18, 0.122141, 0, 0, 0.0610325, 0.998136, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240509, 180353, 1, 1, 1, 9980.82, 2217.15, 1328.8, 0.122141, 0, 0, 0.0610325, 0.998136, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240510, 180353, 1, 1, 1, 9990.4, 2218.56, 1328.55, 0.0553825, 0, 0, 0.0276877, 0.999617, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240511, 180353, 1, 1, 1, 9993.38, 2218.72, 1328.65, 0.0553825, 0, 0, 0.0276877, 0.999617, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240512, 195191, 530, 1, 1, -3955.34, -11863.2, 0.830986, 3.63028, 0, 0, 0.970296, -0.24192, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240513, 195164, 530, 1, 1, -3955.34, -11863.2, 1.71971, 3.52818, 0, 0, 0.981377, -0.192092, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240514, 195195, 530, 1, 1, -3954.82, -11864.6, 1.71971, 1.88277, 0, 0, 0.808374, 0.588669, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240515, 195192, 530, 1, 1, -3956.34, -11862.3, 1.71989, 2.16551, 0, 0, 0.883253, 0.468897, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240516, 195215, 530, 1, 1, -3955.13, -11864.2, 1.97205, 2.12624, 0, 0, 0.873877, 0.486148, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240517, 195200, 530, 1, 1, -3951.67, -11868.6, 0.949688, 3.61065, 0, 0, 0.972624, -0.232385, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240518, 195198, 530, 1, 1, -3955.82, -11857.2, 0.764875, 3.7206, 0, 0, 0.958386, -0.285477, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240519, 195196, 530, 1, 1, -3959.87, -11860, 0.710028, 3.96408, 0, 0, 0.916624, -0.39975, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240520, 195194, 530, 1, 1, -3957.05, -11866.4, 0.827674, 3.32397, 0, 0, 0.995845, -0.0910624, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240521, 195197, 530, 1, 1, -3954.63, -11867.9, 0.891499, 3.11192, 0, 0, 0.99989, 0.0148357, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240522, 195212, 530, 1, 1, -3953.94, -11866.2, 0.8877, 3.1237, 0, 0, 0.99996, 0.00894626, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240523, 195212, 530, 1, 1, -3953.9, -11859.5, 0.824961, 3.48498, 0, 0, 0.985297, -0.170851, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240524, 195212, 530, 1, 1, -3956.95, -11858.9, 0.758281, 3.66955, 0, 0, 0.96536, -0.260923, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240525, 195212, 530, 1, 1, -3959, -11857.7, 0.705579, 3.79521, 0, 0, 0.947072, -0.321022, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240526, 195303, 530, 1, 1, -3958.59, -11860.3, 1.02229, 4.30965, 0, 0, 0.834248, -0.551389, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240527, 195303, 530, 1, 1, -3957.48, -11861.1, 0.769591, 4.15257, 0, 0, 0.874938, -0.484235, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240528, 180353, 530, 1, 1, -3954.67, -11860.3, 0.817822, 3.70882, 0, 0, 0.96005, -0.279827, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240529, 180353, 530, 1, 1, -3952.77, -11864.2, 0.892707, 3.59886, 0, 0, 0.973977, -0.226647, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240530, 180353, 530, 1, 1, -3978.55, -11860.6, 0.446388, 3.98763, 0, 0, 0.911854, -0.410515, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240531, 180353, 530, 1, 1, -3980.7, -11859.3, 0.420101, 4.24681, 0, 0, 0.851158, -0.524909, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240532, 180353, 530, 1, 1, -3976.57, -11861.8, 0.465867, 4.09759, 0, 0, 0.887917, -0.460003, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240533, 180353, 530, 1, 1, -3974.81, -11863.1, 0.483395, 6.25743, 0, 0, 0.0128773, -0.999917, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240534, 180353, 530, 1, 1, -3970.8, -11863.2, 0.532856, 6.25743, 0, 0, 0.0128773, -0.999917, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240535, 180353, 530, 1, 1, -3965.14, -11863.3, 0.639776, 6.25743, 0, 0, 0.0128773, -0.999917, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240536, 180353, 530, 1, 1, -3958.77, -11871.5, 0.842487, 4.22718, 0, 0, 0.856269, -0.51653, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240537, 180353, 530, 1, 1, -3961.29, -11876.7, 0.829859, 4.26252, 0, 0, 0.847009, -0.531579, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240538, 180353, 530, 1, 1, -3963.99, -11882.9, 0.794779, 4.0701, 0, 0, 0.894156, -0.447756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240539, 180353, 530, 1, 1, -3969.7, -11887.5, 0.697352, 2.84095, 0, 0, 0.988723, 0.149756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240540, 180353, 530, 1, 1, -3972.96, -11886.6, 0.632589, 2.86059, 0, 0, 0.990146, 0.14004, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240541, 180353, 530, 1, 1, -3977.27, -11885.7, 0.550238, 2.99803, 0, 0, 0.997425, 0.0717197, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240542, 180353, 530, 1, 1, -3982.69, -11880.4, 0.446558, 1.34869, 0, 0, 0.624386, 0.781116, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240543, 180353, 530, 1, 1, -3981.39, -11874.6, 0.447613, 1.34869, 0, 0, 0.624386, 0.781116, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240544, 180353, 530, 1, 1, -3981.4, -11869.1, 0.40929, 1.43509, 0, 0, 0.657537, 0.753422, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240545, 195191, 1, 1, 1, 1302.52, -4410.94, 26.5561, 3.19832, 0, 0, 0.999598, -0.0283598, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240546, 195195, 1, 1, 1, 1302, -4412.47, 27.4441, 1.11702, 0, 0, 0.529923, 0.848046, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240547, 195192, 1, 1, 1, 1302.1, -4409.68, 27.444, 1.65109, 0, 0, 0.734918, 0.678157, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240548, 195215, 1, 1, 1, 1303.2, -4410.26, 27.444, 1.65501, 0, 0, 0.736245, 0.676715, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240549, 195200, 1, 1, 1, 1300.88, -4415.43, 26.6914, 0.150977, 0, 0, 0.0754168, 0.997152, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240550, 179968, 1, 1, 1, 1297.44, -4418.41, 26.6135, 5.58986, 0, 0, 0.339761, -0.940512, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240551, 179968, 1, 1, 1, 1296.58, -4417.67, 26.6345, 5.57808, 0, 0, 0.345295, -0.938494, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240552, 179968, 1, 1, 1, 1296.53, -4419.34, 26.6187, 5.66447, 0, 0, 0.304447, -0.952529, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240553, 179968, 1, 1, 1, 1295.43, -4418.55, 26.6254, 5.65662, 0, 0, 0.308183, -0.951327, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240554, 179968, 1, 1, 1, 1295.64, -4420.43, 26.6132, 5.64091, 0, 0, 0.315646, -0.948877, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240555, 179968, 1, 1, 1, 1294.66, -4419.7, 26.5909, 5.64091, 0, 0, 0.315646, -0.948877, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240556, 179968, 1, 1, 1, 1295.12, -4402.44, 26.3123, 1.1288, 0, 0, 0.534909, 0.84491, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240557, 179968, 1, 1, 1, 1294.65, -4403.47, 26.3195, 1.14843, 0, 0, 0.543176, 0.839619, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240558, 179968, 1, 1, 1, 1295.94, -4404.05, 26.3415, 1.14843, 0, 0, 0.543176, 0.839619, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240559, 179968, 1, 1, 1, 1296.37, -4403.09, 26.3204, 1.14843, 0, 0, 0.543176, 0.839619, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240560, 179968, 1, 1, 1, 1296.37, -4403.09, 27.026, 1.14843, 0, 0, 0.543176, 0.839619, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240561, 179968, 1, 1, 1, 1302.51, -4406.17, 26.4073, 0.339473, 0, 0, 0.168923, 0.985629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240562, 179968, 1, 1, 1, 1302.51, -4406.17, 27.1129, 0.292349, 0, 0, 0.145655, 0.989336, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240563, 179968, 1, 1, 1, 1301.68, -4406.42, 26.4589, 0.292349, 0, 0, 0.145655, 0.989336, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240564, 179968, 1, 1, 1, 1301.09, -4405.5, 26.478, 0.245226, 0, 0, 0.122306, 0.992492, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240565, 179968, 1, 1, 1, 1302.34, -4407.39, 26.4339, 0.260935, 0, 0, 0.130098, 0.991501, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240566, 195198, 1, 1, 1, 1303.12, -4403.25, 26.295, 3.58788, 0, 0, 0.975207, -0.221296, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240567, 195196, 1, 1, 1, 1304.8, -4406.37, 26.1649, 3.24623, 0, 0, 0.998632, -0.0522948, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240568, 195194, 1, 1, 1, 1299.46, -4405.2, 26.4748, 3.85491, 0, 0, 0.937069, -0.349145, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240569, 195197, 1, 1, 1, 1301.52, -4403.95, 26.3724, 3.72139, 0, 0, 0.958273, -0.285855, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240570, 195197, 1, 1, 1, 1297.9, -4420.87, 26.6368, 2.72394, 0, 0, 0.978275, 0.207312, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240571, 195212, 1, 1, 1, 1304.73, -4408.7, 26.2159, 2.90065, 0, 0, 0.992752, 0.12018, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240572, 195212, 1, 1, 1, 1306.55, -4410.74, 25.8364, 2.8496, 0, 0, 0.989361, 0.145478, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240573, 195303, 1, 1, 1, 1305.29, -4413.29, 26.1647, 2.67289, 0, 0, 0.972665, 0.232212, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240574, 195303, 1, 1, 1, 1298.76, -4419.4, 26.6275, 1.69507, 0, 0, 0.749651, 0.661833, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240575, 180353, 1, 1, 1, 1280.23, -4413.12, 26.4446, 3.85884, 0, 0, 0.936381, -0.350986, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240576, 180353, 1, 1, 1, 1275.71, -4417.02, 26.4, 3.85884, 0, 0, 0.936381, -0.350986, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240577, 180353, 1, 1, 1, 1270.68, -4421.41, 26.2863, 3.85492, 0, 0, 0.937067, -0.34915, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240578, 180353, 1, 1, 1, 1268.6, -4429.59, 26.6604, 5.32754, 0, 0, 0.459847, -0.887998, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240579, 180353, 1, 1, 1, 1271.09, -4433.14, 26.7162, 5.32361, 0, 0, 0.461591, -0.887093, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240580, 180353, 1, 1, 1, 1275.02, -4438.74, 26.9386, 5.32361, 0, 0, 0.461591, -0.887093, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240581, 180353, 1, 1, 1, 1284.69, -4438.29, 27.5673, 0.528753, 0, 0, 0.261307, 0.965256, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240582, 180353, 1, 1, 1, 1289.41, -4435.53, 27.3442, 0.528753, 0, 0, 0.261307, 0.965256, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240583, 180353, 1, 1, 1, 1296.54, -4430.96, 26.9027, 0.697614, 0, 0, 0.341777, 0.939781, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240584, 180353, 1, 1, 1, 1304.26, -4412.35, 26.4077, 1.50657, 0, 0, 0.684039, 0.729446, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240585, 180353, 1, 1, 1, 1304.41, -4408.99, 26.2925, 1.52621, 0, 0, 0.691169, 0.722693, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240586, 180353, 1, 1, 1, 1295.63, -4406.77, 26.4567, 4.16907, 0, 0, 0.870913, -0.491437, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240587, 180353, 1, 1, 1, 1290.06, -4404.73, 26.3184, 4.42826, 0, 0, 0.800101, -0.599866, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240588, 179968, 1, 1, 1, 1281.13, -4412.77, 26.4501, 5.42178, 0, 0, 0.417509, -0.908673, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240589, 179968, 1, 1, 1, 1279.71, -4413.85, 26.4523, 5.50817, 0, 0, 0.377882, -0.925854, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240590, 179968, 1, 1, 1, 1276.3, -4416.39, 26.4036, 5.32361, 0, 0, 0.461591, -0.887093, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240591, 179968, 1, 1, 1, 1274.84, -4417.44, 26.3812, 5.3511, 0, 0, 0.449355, -0.893354, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240592, 179968, 1, 1, 1, 1271.26, -4420.47, 26.2395, 5.9048, 0, 0, 0.188066, -0.982156, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240593, 179968, 1, 1, 1, 1270.17, -4422.24, 26.376, 5.87731, 0, 0, 0.201548, -0.979479, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240594, 179968, 1, 1, 1, 1267.92, -4428.64, 26.6532, 0.520896, 0, 0, 0.257513, 0.966275, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240595, 179968, 1, 1, 1, 1268.77, -4430.44, 26.6577, 0.591582, 0, 0, 0.291497, 0.956572, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240596, 179968, 1, 1, 1, 1270.65, -4432.46, 26.7018, 0.842909, 0, 0, 0.409088, 0.912495, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240597, 179968, 1, 1, 1, 1271.64, -4433.71, 26.7426, 0.897887, 0, 0, 0.434014, 0.900906, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240598, 179968, 1, 1, 1, 1274.36, -4437.81, 26.8996, 0.752588, 0, 0, 0.367476, 0.930033, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240599, 179968, 1, 1, 1, 1275.57, -4439.37, 26.9804, 0.741593, 0, 0, 0.362358, 0.932039, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240600, 179968, 1, 1, 1, 1283.83, -4438.68, 27.54, 2.0807, 0, 0, 0.862581, 0.505918, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240601, 179968, 1, 1, 1, 1285.38, -4437.76, 27.534, 2.10426, 0, 0, 0.868481, 0.495722, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240602, 179968, 1, 1, 1, 1288.37, -4435.9, 27.3867, 2.11604, 0, 0, 0.871386, 0.490598, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240603, 179968, 1, 1, 1, 1289.92, -4435.09, 27.3016, 2.15138, 0, 0, 0.879918, 0.475125, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240604, 179968, 1, 1, 1, 1295.79, -4431.59, 26.952, 2.24563, 0, 0, 0.901323, 0.433147, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240605, 179968, 1, 1, 1, 1297.16, -4430.09, 26.8497, 2.30061, 0, 0, 0.912889, 0.408209, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240606, 195164, 1, 1, 1, 1297.52, -4430.13, 27.5555, 2.40664, 0, 0, 0.933237, 0.359261, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240607, 195164, 1, 1, 1, 1295.88, -4431.63, 27.6582, 2.21029, 0, 0, 0.893529, 0.449005, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240608, 195164, 1, 1, 1, 1290.11, -4435.29, 28.0071, 2.10033, 0, 0, 0.867505, 0.497428, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240609, 195164, 1, 1, 1, 1288.56, -4436.14, 28.0923, 1.99823, 0, 0, 0.840993, 0.541047, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240610, 195164, 1, 1, 1, 1285.61, -4437.76, 28.2396, 2.19065, 0, 0, 0.889077, 0.457758, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240611, 195164, 1, 1, 1, 1284.02, -4438.77, 28.2456, 2.09248, 0, 0, 0.865546, 0.500829, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240612, 195164, 1, 1, 1, 1275.56, -4439.34, 27.6864, 0.753374, 0, 0, 0.367842, 0.929888, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240613, 195164, 1, 1, 1, 1274.15, -4437.9, 27.605, 0.741593, 0, 0, 0.362358, 0.932039, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240614, 195164, 1, 1, 1, 1271.66, -4433.78, 27.4488, 0.906527, 0, 0, 0.437902, 0.899023, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240615, 195164, 1, 1, 1, 1270.69, -4432.51, 27.4082, 0.835841, 0, 0, 0.405861, 0.913935, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240616, 195164, 1, 1, 1, 1268.61, -4430.38, 27.3632, 0.563308, 0, 0, 0.277945, 0.960597, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240617, 195164, 1, 1, 1, 1267.88, -4428.73, 27.3586, 0.606505, 0, 0, 0.298626, 0.95437, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240618, 195164, 1, 1, 1, 1270.24, -4422.24, 27.0815, 5.81762, 0, 0, 0.230686, -0.973028, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240619, 195164, 1, 1, 1, 1271.25, -4420.36, 26.9449, 5.87653, 0, 0, 0.201929, -0.9794, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240620, 195164, 1, 1, 1, 1274.69, -4417.34, 27.0869, 5.35424, 0, 0, 0.447951, -0.894058, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240621, 195164, 1, 1, 1, 1276.21, -4416.05, 27.1098, 5.34638, 0, 0, 0.451461, -0.892291, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240622, 195164, 1, 1, 1, 1279.75, -4413.7, 27.158, 5.26392, 0, 0, 0.487857, -0.872924, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240623, 195164, 1, 1, 1, 1280.97, -4412.84, 27.1556, 5.51917, 0, 0, 0.372784, -0.927918, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240624, 195164, 1, 1, 1, 1296.35, -4419.28, 27.3242, 5.7705, 0, 0, 0.253544, -0.967324, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240625, 195164, 1, 1, 1, 1301.94, -4411.23, 27.444, 0.311978, 0, 0, 0.155357, 0.987858, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240626, 195164, 1, 1, 1, 1296.44, -4403.09, 27.7315, 1.25681, 0, 0, 0.587855, 0.808966, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240627, 195164, 1, 1, 1, 1301.82, -4406.53, 27.2368, 5.4744, 0, 0, 0.39346, -0.919342, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240628, 179968, 530, 1, 1, -3981.01, -11861.1, 0.416226, 4.16906, 0, 0, 0.870916, -0.491432, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240629, 179968, 530, 1, 1, -3980.44, -11860.2, 0.423322, 4.16513, 0, 0, 0.87188, -0.48972, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240630, 179968, 530, 1, 1, -3980.04, -11861.9, 0.426034, 4.23975, 0, 0, 0.853006, -0.521901, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240631, 179968, 530, 1, 1, -3979.42, -11860.7, 0.432217, 4.23975, 0, 0, 0.853006, -0.521901, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240632, 179968, 530, 1, 1, -3962.22, -11859.2, 0.655255, 4.65994, 0, 0, 0.725405, -0.688322, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240633, 179968, 530, 1, 1, -3962.17, -11858.3, 0.647246, 4.65994, 0, 0, 0.725405, -0.688322, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240634, 179968, 530, 1, 1, -3962.17, -11858.3, 1.35331, 4.65994, 0, 0, 0.725405, -0.688322, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240635, 179968, 530, 1, 1, -3963.3, -11858, 0.622251, 4.49893, 0, 0, 0.778409, -0.627757, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240636, 179968, 530, 1, 1, -3963.57, -11858.9, 0.625538, 4.59711, 0, 0, 0.746667, -0.665198, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240637, 179968, 1, 1, 1, 9982.13, 2246.34, 1332.02, 3.13021, 0, 0, 0.999984, 0.00569133, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240638, 179968, 1, 1, 1, 9982.08, 2243.54, 1331.84, 3.02026, 0, 0, 0.99816, 0.0606291, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240639, 179968, 1, 1, 1, 9999.55, 2234.41, 1329.88, 4.31224, 0, 0, 0.833533, -0.552469, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240640, 179968, 1, 1, 1, 9999.9, 2235.24, 1329.73, 4.31224, 0, 0, 0.833533, -0.552469, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240641, 179968, 1, 1, 1, 9999.9, 2235.24, 1330.44, 4.31224, 0, 0, 0.833533, -0.552469, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240642, 179968, 1, 1, 1, 9998.76, 2235.77, 1329.83, 4.28475, 0, 0, 0.841048, -0.54096, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240643, 179968, 1, 1, 1, 10002.5, 2216.51, 1328.84, 3.28336, 0, 0, 0.997489, -0.0708243, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240644, 179968, 1, 1, 1, 10002.9, 2213.91, 1328.47, 3.31085, 0, 0, 0.996421, -0.0845276, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240645, 179968, 1, 1, 1, 10003.2, 2210.99, 1328.12, 3.17734, 0, 0, 0.99984, -0.0178727, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240646, 179968, 1, 1, 1, 10003.1, 2207.82, 1327.83, 3.33441, 0, 0, 0.995356, -0.0962594, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240647, 179968, 1, 1, 1, 10003.3, 2205.14, 1327.77, 3.22776, 0, 0, 0.999072, -0.0430704, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240648, 179968, 1, 1, 1, 10003.9, 2201.66, 1327.86, 3.21205, 0, 0, 0.99938, -0.0352214, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240649, 179968, 1, 1, 1, 9997.22, 2194.31, 1327.73, 1.54701, 0, 0, 0.698647, 0.715466, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240650, 179968, 1, 1, 1, 9994.37, 2194.29, 1327.74, 1.48811, 0, 0, 0.677277, 0.735728, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240651, 179968, 1, 1, 1, 9991.63, 2194.14, 1327.89, 1.41742, 0, 0, 0.650855, 0.759202, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240652, 179968, 1, 1, 1, 9986.12, 2193.36, 1328.47, 1.60199, 0, 0, 0.718049, 0.695993, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240653, 179968, 1, 1, 1, 9983.56, 2193.02, 1328.73, 1.55879, 0, 0, 0.702849, 0.711339, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240654, 179968, 1, 1, 1, 9980.77, 2192.63, 1328.9, 1.51167, 0, 0, 0.685897, 0.727699, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240655, 179968, 1, 1, 1, 9974.98, 2195.81, 1328.95, 0.0233379, 0, 0, 0.0116687, 0.999932, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240656, 179968, 1, 1, 1, 9975.06, 2198.89, 1328.92, 6.25155, 0, 0, 0.0158169, -0.999875, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240657, 179968, 1, 1, 1, 9975.13, 2201.37, 1328.94, 6.1573, 0, 0, 0.0629011, -0.99802, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240658, 179968, 1, 1, 1, 9974.23, 2207.13, 1329.15, 0.0508296, 0, 0, 0.0254121, 0.999677, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240659, 179968, 1, 1, 1, 9973.79, 2209.18, 1329.29, 0.0311947, 0, 0, 0.0155967, 0.999878, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240660, 179968, 1, 1, 1, 9973.39, 2211.61, 1329.39, 0.156859, 0, 0, 0.0783491, 0.996926, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240661, 179968, 1, 1, 1, 9979.24, 2216.92, 1328.91, 4.88889, 0, 0, 0.642034, -0.766677, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240662, 179968, 1, 1, 1, 9975.86, 2216.51, 1329.29, 4.82998, 0, 0, 0.664334, -0.747436, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240663, 179968, 1, 1, 1, 9981.93, 2217.48, 1328.73, 4.84961, 0, 0, 0.656966, -0.75392, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240664, 179968, 1, 1, 1, 9988.83, 2218.95, 1328.58, 4.75929, 0, 0, 0.690332, -0.723493, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240665, 179968, 1, 1, 1, 9991.92, 2218.84, 1328.61, 4.82213, 0, 0, 0.667263, -0.744823, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240666, 179968, 1, 1, 1, 9994.95, 2218.91, 1328.77, 4.66897, 0, 0, 0.72229, -0.69159, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240667, 195164, 1, 1, 1, 9999.51, 2234.51, 1330.59, 1.43313, 0, 0, 0.656798, 0.754066, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240668, 195164, 1, 1, 1, 9994.93, 2219.04, 1329.48, 4.65326, 0, 0, 0.7277, -0.685896, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240669, 195164, 1, 1, 1, 9991.99, 2219.15, 1329.31, 4.66897, 0, 0, 0.72229, -0.69159, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240670, 195164, 1, 1, 1, 9989.01, 2219.09, 1329.28, 4.64148, 0, 0, 0.731727, -0.681598, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240671, 195164, 1, 1, 1, 9981.98, 2217.51, 1329.43, 4.68468, 0, 0, 0.716835, -0.697243, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240672, 195164, 1, 1, 1, 9979.05, 2217.06, 1329.61, 4.82212, 0, 0, 0.667266, -0.744819, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240673, 195164, 1, 1, 1, 9975.8, 2216.83, 1330, 4.82369, 0, 0, 0.666682, -0.745343, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240674, 195164, 1, 1, 1, 9973.21, 2211.7, 1330.09, 0.0877428, 0, 0, 0.0438573, 0.999038, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240675, 195164, 1, 1, 1, 9973.8, 2209.13, 1329.99, 0.0846007, 0, 0, 0.0422877, 0.999105, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240676, 195164, 1, 1, 1, 9974.41, 2207.01, 1329.86, 0.0610387, 0, 0, 0.0305146, 0.999534, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240677, 195164, 1, 1, 1, 9974.75, 2201.51, 1329.62, 6.06541, 0, 0, 0.108673, -0.994078, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240678, 195164, 1, 1, 1, 9975.09, 2198.93, 1329.62, 0.0217681, 0, 0, 0.0108838, 0.999941, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240679, 195164, 1, 1, 1, 9974.65, 2196.08, 1329.65, 0.00213314, 0, 0, 0.00106657, 0.999999, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240680, 195164, 1, 1, 1, 9980.82, 2192.39, 1329.6, 1.42763, 0, 0, 0.654722, 0.75587, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240681, 195164, 1, 1, 1, 9983.48, 2192.95, 1329.43, 1.40407, 0, 0, 0.645773, 0.76353, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240682, 195164, 1, 1, 1, 9986.32, 2193.11, 1329.18, 1.48339, 0, 0, 0.675539, 0.737325, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240683, 195164, 1, 1, 1, 9991.7, 2193.93, 1328.59, 1.71116, 0, 0, 0.754951, 0.655781, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240684, 195164, 1, 1, 1, 9994.25, 2194.27, 1328.45, 1.45591, 0, 0, 0.665344, 0.746537, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240685, 195164, 1, 1, 1, 9997.38, 2194.07, 1328.44, 1.45591, 0, 0, 0.665344, 0.746537, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240686, 195164, 1, 1, 1, 10004, 2201.64, 1328.57, 3.10917, 0, 0, 0.999869, 0.0162106, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240687, 195164, 1, 1, 1, 10003.4, 2205.32, 1328.47, 3.14059, 0, 0, 1, 0.000501351, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240688, 195164, 1, 1, 1, 10003.1, 2207.89, 1328.54, 3.28196, 0, 0, 0.997538, -0.0701261, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240689, 195164, 1, 1, 1, 10003.1, 2210.9, 1328.82, 3.01492, 0, 0, 0.997995, 0.063294, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240690, 195164, 1, 1, 1, 10002.7, 2213.92, 1329.17, 3.20342, 0, 0, 0.999522, -0.0309087, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240691, 195164, 1, 1, 1, 10002.5, 2216.61, 1329.55, 3.16415, 0, 0, 0.999936, -0.0112784, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240692, 179968, 0, 1, 1, -9125.02, 352.824, 93.5288, 2.1217, 0, 0, 0.872771, 0.48813, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240693, 179968, 0, 1, 1, -9127.56, 351.404, 93.5273, 2.13741, 0, 0, 0.876578, 0.48126, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240694, 179968, 0, 1, 1, -9121.57, 348.944, 93.9659, 6.15864, 0, 0, 0.0622325, -0.998062, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240695, 179968, 0, 1, 1, -9122.27, 346.012, 94.1675, 6.20969, 0, 0, 0.0367393, -0.999325, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240696, 179968, 0, 1, 1, -9122.08, 342.306, 94.1731, 0.0325353, 0, 0, 0.0162669, 0.999868, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240697, 179968, 0, 1, 1, -9122.38, 336.465, 93.7437, 6.15864, 0, 0, 0.0622325, -0.998062, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240698, 179968, 0, 1, 1, -9122.77, 333.542, 93.4547, 6.10759, 0, 0, 0.0876848, -0.996148, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240699, 179968, 0, 1, 1, -9123.52, 331.044, 93.3352, 6.06832, 0, 0, 0.107226, -0.994235, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240700, 179968, 0, 1, 1, -9124.3, 325.218, 93.4123, 6.25681, 0, 0, 0.0131872, -0.999913, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240701, 179968, 0, 1, 1, -9124.62, 322.257, 93.4678, 6.26074, 0, 0, 0.0112225, -0.999937, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240702, 179968, 0, 1, 1, -9124, 318.81, 93.4679, 0.0796561, 0, 0, 0.0398175, 0.999207, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240703, 179968, 0, 1, 1, -9123.73, 313.696, 93.4004, 0.00504303, 0, 0, 0.00252151, 0.999997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240704, 179968, 0, 1, 1, -9123.56, 311.213, 93.2591, 0.00504327, 0, 0, 0.00252163, 0.999997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240705, 179968, 0, 1, 1, -9123.45, 308.836, 93.1538, 0.0128972, 0, 0, 0.00644856, 0.999979, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240706, 179968, 0, 1, 1, -9108.65, 306.666, 93.8969, 2.91887, 0, 0, 0.993806, 0.111131, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240707, 179968, 0, 1, 1, -9108.12, 309.489, 93.8183, 3.13486, 0, 0, 0.999994, 0.0033663, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240708, 179968, 0, 1, 1, -9108.47, 311.573, 93.6563, 3.00919, 0, 0, 0.997809, 0.0661529, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240709, 179968, 0, 1, 1, -9106.75, 319.206, 93.4457, 3.18591, 0, 0, 0.999754, -0.0221569, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240710, 179968, 0, 1, 1, -9106.91, 321.71, 93.3826, 3.26366, 0, 0, 0.998138, -0.0609958, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240711, 179968, 0, 1, 1, -9106.96, 324.388, 93.3783, 3.26366, 0, 0, 0.998138, -0.0609958, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240712, 179968, 0, 1, 1, -9106, 331.289, 93.583, 3.2833, 0, 0, 0.997491, -0.0707944, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240713, 179968, 0, 1, 1, -9106.34, 333.725, 93.6275, 3.2401, 0, 0, 0.998787, -0.0492337, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240714, 179968, 0, 1, 1, -9106.58, 336.794, 93.6628, 3.26759, 0, 0, 0.998016, -0.062957, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240715, 179968, 0, 1, 1, -9106.71, 342.403, 93.5723, 3.20083, 0, 0, 0.999561, -0.0296143, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240716, 179968, 0, 1, 1, -9106.88, 345.568, 93.432, 3.18669, 0, 0, 0.999746, -0.0225468, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240717, 179968, 0, 1, 1, -9107.08, 348.925, 93.3381, 3.25345, 0, 0, 0.998436, -0.0558995, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240718, 179968, 0, 1, 1, -9105.76, 361.675, 93.4297, 2.58586, 0, 0, 0.961643, 0.274304, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240719, 179968, 0, 1, 1, -9105, 361.2, 93.4297, 2.58586, 0, 0, 0.961643, 0.274304, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240720, 179968, 0, 1, 1, -9105, 361.2, 94.1356, 2.58586, 0, 0, 0.961643, 0.274304, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240721, 179968, 0, 1, 1, -9104.09, 360.604, 93.0295, 2.61335, 0, 0, 0.965322, 0.261061, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240722, 179968, 0, 1, 1, -9104.09, 360.604, 93.7354, 2.61335, 0, 0, 0.965322, 0.261061, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240723, 179968, 0, 1, 1, -9104.09, 360.604, 94.441, 2.61335, 0, 0, 0.965322, 0.261061, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240724, 179968, 0, 1, 1, -9106.57, 360.255, 93.5506, 2.58194, 0, 0, 0.961103, 0.276189, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240725, 179968, 0, 1, 1, -9105.81, 359.775, 93.5506, 2.48376, 0, 0, 0.946393, 0.323018, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240726, 179968, 0, 1, 1, -9105.81, 359.775, 94.2564, 2.55445, 0, 0, 0.957217, 0.289373, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240727, 179968, 0, 1, 1, -9104.89, 359.163, 93.1483, 2.55445, 0, 0, 0.957217, 0.289373, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240728, 179968, 0, 1, 1, -9104.89, 359.163, 93.854, 2.55445, 0, 0, 0.957217, 0.289373, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240729, 179968, 0, 1, 1, -9105.53, 358.184, 93.17, 2.49947, 0, 0, 0.948901, 0.315574, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240730, 195164, 0, 1, 1, -9106.82, 348.979, 94.044, 3.21811, 0, 0, 0.999268, -0.0382494, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240731, 195164, 0, 1, 1, -9106.61, 345.589, 94.1377, 3.09637, 0, 0, 0.999744, 0.0226094, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240732, 195164, 0, 1, 1, -9106.66, 342.347, 94.2784, 3.10423, 0, 0, 0.999826, 0.0186803, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240733, 195164, 0, 1, 1, -9106.7, 336.98, 94.3685, 3.23774, 0, 0, 0.998845, -0.0480552, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240734, 195164, 0, 1, 1, -9106.44, 333.544, 94.3332, 3.13564, 0, 0, 0.999996, 0.00297637, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240735, 195164, 0, 1, 1, -9106.12, 331.509, 94.2891, 3.13957, 0, 0, 0.999999, 0.00101133, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240736, 195164, 0, 1, 1, -9106.91, 324.458, 94.084, 3.17491, 0, 0, 0.999861, -0.0166579, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240737, 195164, 0, 1, 1, -9106.92, 321.9, 94.0888, 3.17098, 0, 0, 0.999892, -0.0146931, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240738, 195164, 0, 1, 1, -9106.6, 319.258, 94.1514, 3.21418, 0, 0, 0.999341, -0.0362857, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240739, 195164, 0, 1, 1, -9108.34, 311.514, 94.3619, 3.04532, 0, 0, 0.998842, 0.0481177, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240740, 195164, 0, 1, 1, -9108, 309.563, 94.524, 3.16706, 0, 0, 0.999919, -0.0127333, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240741, 195164, 0, 1, 1, -9108.7, 306.836, 94.6029, 2.92201, 0, 0, 0.993979, 0.109571, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240742, 195164, 0, 1, 1, -9123.52, 308.78, 93.8595, 0.0435288, 0, 0, 0.0217627, 0.999763, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240743, 195164, 0, 1, 1, -9123.57, 311.178, 93.9648, 6.25838, 0, 0, 0.0124024, -0.999923, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240744, 195164, 0, 1, 1, -9123.84, 313.691, 94.1064, 6.19477, 0, 0, 0.0441933, -0.999023, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240745, 195164, 0, 1, 1, -9124.06, 318.765, 94.1735, 6.26388, 0, 0, 0.00965262, -0.999953, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240746, 195164, 0, 1, 1, -9124.86, 322.295, 94.1734, 6.20576, 0, 0, 0.038703, -0.999251, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240747, 195164, 0, 1, 1, -9124.07, 325.098, 94.118, 6.2678, 0, 0, 0.00769265, -0.99997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240748, 195164, 0, 1, 1, -9123.43, 331.097, 94.041, 6.01255, 0, 0, 0.134905, -0.990858, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240749, 195164, 0, 1, 1, -9122.56, 333.536, 94.1602, 6.00077, 0, 0, 0.140739, -0.990047, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240750, 195164, 0, 1, 1, -9122.21, 336.358, 94.4494, 6.06753, 0, 0, 0.107619, -0.994192, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240751, 195164, 0, 1, 1, -9122.17, 342.507, 94.8786, 6.08323, 0, 0, 0.0998112, -0.995006, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240752, 195164, 0, 1, 1, -9122.66, 346.034, 94.8427, 6.24031, 0, 0, 0.0214359, -0.99977, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240753, 195164, 0, 1, 1, -9121.72, 348.977, 94.6714, 6.2246, 0, 0, 0.0292885, -0.999571, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240754, 179968, 0, 1, 1, -5084.24, -808.46, 495.127, 0.96978, 0, 0, 0.466111, 0.884726, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240755, 179968, 0, 1, 1, -5079.31, -809.352, 495.128, 1.52349, 0, 0, 0.690185, 0.723633, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240756, 179968, 0, 1, 1, -5076.66, -808.073, 495.127, 1.98294, 0, 0, 0.836832, 0.54746, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240757, 179968, 0, 1, 1, -5070, -786.548, 494.868, 3.54589, 0, 0, 0.979637, -0.200775, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240758, 179968, 0, 1, 1, -5069.18, -786.172, 494.83, 3.57338, 0, 0, 0.976785, -0.21422, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240759, 179968, 0, 1, 1, -5069.18, -786.172, 495.537, 3.57338, 0, 0, 0.976785, -0.21422, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240760, 179968, 0, 1, 1, -5068.53, -787.239, 494.916, 3.63621, 0, 0, 0.969575, -0.244795, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240761, 195191, 1, 1, 1, -1312.7, 205.607, 58.866, 6.27839, 0, 0, 0.00239769, -0.999997, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240762, 195164, 1, 1, 1, -1312.7, 205.607, 59.7541, 6.27447, 0, 0, 0.00435771, -0.999991, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240763, 195195, 1, 1, 1, -1313.19, 203.883, 59.7541, 1.3618, 0, 0, 0.629493, 0.777007, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240764, 195192, 1, 1, 1, -1313.04, 206.69, 59.754, 1.49925, 0, 0, 0.681364, 0.731944, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240765, 195215, 1, 1, 1, -1313.14, 204.888, 59.754, 1.51888, 0, 0, 0.688515, 0.725222, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240766, 195200, 1, 1, 1, -1313.53, 201.289, 58.8654, 5.48121, 0, 0, 0.390328, -0.920676, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240767, 179968, 1, 1, 1, -1311.94, 192.52, 59.1312, 2.59095, 0, 0, 0.962338, 0.271856, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240768, 179968, 1, 1, 1, -1313.24, 190.02, 59.2281, 2.57524, 0, 0, 0.960173, 0.279407, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240769, 179968, 1, 1, 1, -1314.58, 187.54, 59.418, 2.54383, 0, 0, 0.955666, 0.294451, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240770, 179968, 1, 1, 1, -1310.59, 194.635, 59.0592, 2.70876, 0, 0, 0.976673, 0.214731, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240771, 195198, 1, 1, 1, -1316.18, 210.677, 58.8661, 1.71916, 0, 0, 0.757568, 0.652756, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240772, 195196, 1, 1, 1, -1314.67, 209.519, 58.8661, 3.94969, 0, 0, 0.919477, -0.393144, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240773, 195194, 1, 1, 1, -1315.17, 204.322, 58.8654, 5.38304, 0, 0, 0.435031, -0.900415, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240774, 195197, 1, 1, 1, -1317.97, 210.447, 58.8648, 5.32807, 0, 0, 0.459611, -0.88812, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240775, 195197, 1, 1, 1, -1317.79, 185.104, 59.7552, 4.73116, 0, 0, 0.700439, -0.713712, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240776, 195197, 1, 1, 1, -1312.5, 187.357, 59.3122, 1.54245, 0, 0, 0.697014, 0.717057, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240777, 195212, 1, 1, 1, -1314.91, 183.793, 59.5933, 2.07652, 0, 0, 0.861522, 0.50772, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240778, 195212, 1, 1, 1, -1311.93, 209.505, 58.8648, 3.53343, 0, 0, 0.980869, -0.194668, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240779, 195212, 1, 1, 1, -1309.82, 205.756, 58.8648, 2.88548, 0, 0, 0.991812, 0.127707, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240780, 195303, 1, 1, 1, -1313.19, 208.798, 58.8649, 3.89079, 0, 0, 0.930655, -0.365899, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240781, 195303, 1, 1, 1, -1315.66, 184.701, 59.5959, 1.69952, 0, 0, 0.751122, 0.660163, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240782, 180353, 1, 1, 1, -1310.87, 193.496, 59.0985, 2.40246, 0, 0, 0.932484, 0.361211, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240783, 180353, 1, 1, 1, -1312.52, 191.397, 59.1709, 2.68127, 0, 0, 0.97363, 0.228135, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240784, 180353, 1, 1, 1, -1314.19, 188.785, 59.3004, 2.63022, 0, 0, 0.96749, 0.25291, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240785, 180353, 1, 1, 1, -1310.79, 203.753, 58.8658, 1.51888, 0, 0, 0.688515, 0.725222, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240786, 180353, 1, 1, 1, -1310.8, 207.802, 58.8649, 1.57386, 0, 0, 0.708189, 0.706023, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240787, 180353, 1, 1, 1, -1326.04, 203.805, 59.0962, 3.37635, 0, 0, 0.993119, -0.117109, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240788, 180353, 1, 1, 1, -1333.43, 201.997, 59.5005, 3.39598, 0, 0, 0.991922, -0.126851, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240789, 180353, 1, 1, 1, -1337.23, 195.937, 60.5344, 4.95108, 0, 0, 0.617887, -0.786267, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240790, 180353, 1, 1, 1, -1334.99, 186.726, 60.4348, 4.95108, 0, 0, 0.617887, -0.786267, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240791, 180353, 1, 1, 1, -1317.57, 198.279, 58.9668, 1.782, 0, 0, 0.777701, 0.628635, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240792, 179968, 1, 1, 1, -1317.25, 197.073, 58.992, 3.47846, 0, 0, 0.985849, -0.167638, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240793, 179968, 1, 1, 1, -1317.89, 199.355, 58.9472, 3.51773, 0, 0, 0.982367, -0.186962, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240794, 179968, 1, 1, 1, -1310.51, 202.173, 58.8655, 2.74018, 0, 0, 0.979926, 0.199362, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240795, 179968, 1, 1, 1, -1309.49, 201.749, 58.875, 2.74803, 0, 0, 0.980701, 0.195514, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240796, 179968, 1, 1, 1, -1309.49, 201.749, 59.5804, 2.74803, 0, 0, 0.980701, 0.195514, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240797, 179968, 1, 1, 1, -1308.66, 202.545, 59.6401, 2.74803, 0, 0, 0.980701, 0.195514, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240798, 179968, 1, 1, 1, -1310.23, 200.817, 58.8769, 2.77552, 0, 0, 0.983296, 0.182016, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240799, 179968, 1, 1, 1, -1309.39, 203.087, 58.8651, 5.99173, 0, 0, 0.145212, -0.989401, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240800, 179968, 1, 1, 1, -1307.76, 202.375, 58.8758, 2.74018, 0, 0, 0.979926, 0.199362, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240801, 179968, 1, 1, 1, -1308.25, 203.731, 58.8678, 4.49554, 0, 0, 0.779472, -0.626437, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240802, 179968, 1, 1, 1, -1325.17, 203.847, 59.0586, 4.95893, 0, 0, 0.614796, -0.788686, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240803, 179968, 1, 1, 1, -1326.97, 203.733, 59.1374, 5.02176, 0, 0, 0.58972, -0.807607, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240804, 179968, 1, 1, 1, -1332.88, 202.025, 59.4843, 5.00213, 0, 0, 0.597619, -0.801781, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240805, 179968, 1, 1, 1, -1334.27, 201.832, 59.5742, 4.9982, 0, 0, 0.599193, -0.800605, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240806, 179968, 1, 1, 1, -1337.15, 196.971, 60.3714, 0.199416, 0, 0, 0.0995429, 0.995033, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240807, 179968, 1, 1, 1, -1337.12, 195.238, 60.6238, 0.187635, 0, 0, 0.0936799, 0.995602, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240808, 179968, 1, 1, 1, -1335.37, 187.803, 60.5692, 0.329007, 0, 0, 0.163763, 0.9865, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240809, 179968, 1, 1, 1, -1334.83, 185.873, 60.319, 0.348642, 0, 0, 0.173439, 0.984845, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240810, 195164, 1, 1, 1, -1334.83, 185.873, 61.0245, 0.348642, 0, 0, 0.173439, 0.984845, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240811, 195164, 1, 1, 1, -1335.26, 187.819, 61.2746, 0.152293, 0, 0, 0.0760729, 0.997102, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240812, 195164, 1, 1, 1, -1337.35, 195.259, 61.3292, 0.171928, 0, 0, 0.0858582, 0.996307, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240813, 195164, 1, 1, 1, -1337.46, 196.912, 61.0769, 0.120877, 0, 0, 0.0604017, 0.998174, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240814, 195164, 1, 1, 1, -1334.29, 201.632, 60.2797, 0.332934, 0, 0, 0.165699, 0.986176, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240815, 195164, 1, 1, 1, -1332.57, 201.932, 60.1899, 4.97071, 0, 0, 0.61014, -0.792293, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240816, 195164, 1, 1, 1, -1327.13, 203.723, 59.8431, 5.04532, 0, 0, 0.580166, -0.814498, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240817, 195164, 1, 1, 1, -1325.23, 204.052, 59.7642, 4.75473, 0, 0, 0.69198, -0.721917, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240818, 195164, 1, 1, 1, -1310.25, 202.407, 59.5709, 6.03493, 0, 0, 0.123809, -0.992306, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240819, 195164, 1, 1, 1, -1309.5, 203.196, 59.5706, 5.45373, 0, 0, 0.402941, -0.915226, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240820, 195164, 1, 1, 1, -1308.14, 203.883, 59.5734, 4.30313, 0, 0, 0.836041, -0.548667, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240821, 195164, 1, 1, 1, -1317.92, 199.34, 59.6527, 3.40777, 0, 0, 0.991157, -0.132696, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240822, 195164, 1, 1, 1, -1317.29, 197.153, 59.6975, 3.52558, 0, 0, 0.981626, -0.190816, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240823, 195164, 1, 1, 1, -1310.59, 194.661, 59.7653, 5.88963, 0, 0, 0.19551, -0.980702, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240824, 195164, 1, 1, 1, -1314.3, 187.375, 60.1235, 2.71662, 0, 0, 0.97751, 0.210891, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240825, 195191, 0, 1, 1, 1822.65, 268.486, 60.1895, 4.68401, 0, 0, 0.717069, -0.697002, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240826, 195164, 0, 1, 1, 1822.65, 268.486, 61.0773, 3.01112, 0, 0, 0.997873, 0.06519, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240827, 195195, 0, 1, 1, 1824.44, 268.244, 61.0773, 3.00719, 0, 0, 0.997743, 0.0671508, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240828, 195192, 0, 1, 1, 1821.87, 267.983, 61.0774, 3.23496, 0, 0, 0.99891, -0.0466668, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240829, 195215, 0, 1, 1, 1821.85, 269.152, 61.0774, 3.13678, 0, 0, 0.999997, 0.00240631, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240830, 195200, 0, 1, 1, 1827.23, 267.982, 60.0917, 6.10166, 0, 0, 0.0906382, -0.995884, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240831, 179968, 0, 1, 1, 1811.88, 256.913, 59.9234, 4.88429, 0, 0, 0.643795, -0.765198, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240832, 179968, 0, 1, 1, 1814.57, 257.68, 59.9798, 4.93927, 0, 0, 0.622519, -0.782605, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240833, 179968, 0, 1, 1, 1817.01, 258.573, 60.0155, 4.94319, 0, 0, 0.620984, -0.783823, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240834, 195198, 0, 1, 1, 1817.06, 270.329, 60.2343, 5.35552, 0, 0, 0.447379, -0.894344, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240835, 195196, 0, 1, 1, 1818.48, 267.871, 60.1517, 5.31233, 0, 0, 0.466587, -0.884475, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240836, 195194, 0, 1, 1, 1822.93, 266.659, 60.1207, 0.144402, 0, 0, 0.0721383, 0.997395, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240837, 195197, 0, 1, 1, 1828.05, 264.454, 59.8784, 5.85425, 0, 0, 0.212827, -0.97709, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240838, 195197, 0, 1, 1, 1819.25, 266.187, 59.9856, 2.08434, 0, 0, 0.863501, 0.504348, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240839, 195212, 0, 1, 1, 1819.78, 271.369, 60.1539, 4.83323, 0, 0, 0.663119, -0.748514, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240840, 195212, 0, 1, 1, 1823.45, 271.665, 60.2191, 4.73506, 0, 0, 0.699046, -0.715077, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240841, 195199, 0, 1, 1, 1818.4, 269.984, 60.1338, 5.27305, 0, 0, 0.483867, -0.875142, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240842, 195199, 0, 1, 1, 1825.5, 270.99, 60.189, 0.678472, 0, 0, 0.332767, 0.943009, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240843, 195303, 0, 1, 1, 1825.46, 268.729, 60.3853, 4.50336, 0, 0, 0.777017, -0.62948, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240844, 195303, 0, 1, 1, 1819.84, 268.611, 60.1151, 5.10419, 0, 0, 0.555944, -0.83122, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240845, 180353, 0, 1, 1, 1824.92, 270.391, 60.2257, 3.20353, 0, 0, 0.99952, -0.0309638, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240846, 180353, 0, 1, 1, 1821.17, 270.063, 60.1725, 3.23101, 0, 0, 0.999001, -0.0446938, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240847, 180353, 0, 1, 1, 1813.1, 257.35, 59.9493, 4.88428, 0, 0, 0.643799, -0.765195, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240848, 180353, 0, 1, 1, 1815.67, 258.419, 60.0141, 4.9314, 0, 0, 0.625594, -0.780149, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240849, 180353, 0, 1, 1, 1823.87, 262.408, 59.9219, 6.00347, 0, 0, 0.139402, -0.990236, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240850, 180353, 0, 1, 1, 1829.26, 260.862, 59.6116, 6.00347, 0, 0, 0.139402, -0.990236, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240851, 180353, 0, 1, 1, 1835.55, 259.054, 59.7994, 6.00347, 0, 0, 0.139402, -0.990236, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240852, 180353, 0, 1, 1, 1833.15, 248.323, 59.8227, 2.89722, 0, 0, 0.992545, 0.121883, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240853, 180353, 0, 1, 1, 1822.7, 250.93, 60.0502, 2.89722, 0, 0, 0.992545, 0.121883, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240854, 180353, 0, 1, 1, 1825.45, 228.409, 60.0708, 6.12128, 0, 0, 0.0808642, -0.996725, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240855, 180353, 0, 1, 1, 1835.52, 226.764, 60.2553, 6.12128, 0, 0, 0.0808642, -0.996725, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240856, 180353, 0, 1, 1, 1834.41, 213.818, 60.216, 3.02289, 0, 0, 0.998239, 0.0593164, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240857, 180353, 0, 1, 1, 1828.95, 214.53, 60.503, 3.0111, 0, 0, 0.997872, 0.0652, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240858, 180353, 0, 1, 1, 1823.25, 215.279, 60.2116, 3.0111, 0, 0, 0.997872, 0.0652, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240859, 179968, 0, 1, 1, 1822.69, 215.403, 60.1776, 1.39318, 0, 0, 0.641606, 0.767035, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240860, 179968, 0, 1, 1, 1823.8, 214.992, 60.2217, 1.40104, 0, 0, 0.644615, 0.764507, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240861, 179968, 0, 1, 1, 1828.2, 214.485, 60.4552, 1.51492, 0, 0, 0.687078, 0.726584, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240862, 179968, 0, 1, 1, 1829.91, 214.581, 60.4197, 1.56676, 0, 0, 0.705678, 0.708532, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240863, 179968, 0, 1, 1, 1833.54, 214.099, 60.2353, 1.51963, 0, 0, 0.688787, 0.724963, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240864, 179968, 0, 1, 1, 1835.43, 214.118, 60.2106, 1.59424, 0, 0, 0.715347, 0.69877, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240865, 179968, 0, 1, 1, 1836.62, 226.776, 60.2415, 1.5, 0, 0, 0.681639, 0.731689, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240866, 179968, 0, 1, 1, 1834.29, 226.723, 60.3708, 1.33114, 0, 0, 0.617508, 0.786565, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240867, 179968, 0, 1, 1, 1826.45, 228.143, 60.1295, 1.44109, 0, 0, 0.659794, 0.751446, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240868, 179968, 0, 1, 1, 1824.26, 228.134, 60.0401, 1.36255, 0, 0, 0.629784, 0.77677, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240869, 179968, 0, 1, 1, 1834.21, 247.981, 59.8394, 1.55105, 0, 0, 0.700091, 0.714054, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240870, 179968, 0, 1, 1, 1832.03, 247.781, 59.8763, 1.60603, 0, 0, 0.719453, 0.694541, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240871, 179968, 0, 1, 1, 1823.6, 250.277, 60.0631, 1.31936, 0, 0, 0.612864, 0.790188, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240872, 179968, 0, 1, 1, 1821.45, 250.783, 60.0482, 1.22511, 0, 0, 0.57496, 0.818182, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240873, 179968, 0, 1, 1, 1822.89, 262.578, 59.9009, 1.3115, 0, 0, 0.609754, 0.792591, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240874, 179968, 0, 1, 1, 1824.7, 262.186, 59.8891, 1.37041, 0, 0, 0.632832, 0.774289, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240875, 179968, 0, 1, 1, 1828.37, 261.229, 59.6733, 1.41753, 0, 0, 0.650897, 0.759166, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240876, 179968, 0, 1, 1, 1830.13, 261.054, 59.5981, 1.33899, 0, 0, 0.62059, 0.784135, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240877, 179968, 0, 1, 1, 1834.58, 258.927, 59.7548, 1.2526, 0, 0, 0.586151, 0.810202, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240878, 179968, 0, 1, 1, 1836.16, 258.179, 59.8198, 1.14264, 0, 0, 0.540743, 0.841188, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240879, 179968, 0, 1, 1, 1815.95, 271.259, 60.2131, 5.37594, 0, 0, 0.438225, -0.898865, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240880, 179968, 0, 1, 1, 1815.39, 271.969, 60.2347, 5.37986, 0, 0, 0.436462, -0.899723, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240881, 179968, 0, 1, 1, 1815.39, 271.969, 60.9403, 5.37986, 0, 0, 0.436462, -0.899723, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240882, 179968, 0, 1, 1, 1816.72, 272.957, 60.2132, 5.44584, 0, 0, 0.406548, -0.913629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240883, 179968, 0, 1, 1, 1817.36, 272.251, 60.1876, 5.44584, 0, 0, 0.406548, -0.913629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240884, 195164, 0, 1, 1, 1817.36, 272.251, 60.8931, 5.44584, 0, 0, 0.406548, -0.913629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240885, 195164, 0, 1, 1, 1822.88, 262.575, 60.6064, 4.39341, 0, 0, 0.810431, -0.585834, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240886, 195164, 0, 1, 1, 1824.72, 262.287, 60.5945, 4.60154, 0, 0, 0.745192, -0.66685, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240887, 195164, 0, 1, 1, 1828.41, 261.179, 60.3789, 4.55834, 0, 0, 0.759421, -0.6506, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240888, 195164, 0, 1, 1, 1830.29, 260.989, 60.3037, 4.40519, 0, 0, 0.806967, -0.590597, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240889, 195164, 0, 1, 1, 1834.49, 259.129, 60.4603, 4.47588, 0, 0, 0.785592, -0.618745, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240890, 195164, 0, 1, 1, 1836.31, 258.493, 60.5252, 4.12245, 0, 0, 0.882131, -0.471004, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240891, 195164, 0, 1, 1, 1821.67, 250.916, 60.7537, 4.36199, 0, 0, 0.819534, -0.57303, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240892, 195164, 0, 1, 1, 1823.47, 250.206, 60.7687, 4.52222, 0, 0, 0.771046, -0.636779, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240893, 195164, 0, 1, 1, 1832, 248.018, 60.582, 4.7594, 0, 0, 0.690292, -0.723531, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240894, 195164, 0, 1, 1, 1834.14, 247.916, 60.545, 4.74212, 0, 0, 0.696518, -0.71754, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240895, 195164, 0, 1, 1, 1836.37, 227.114, 60.9472, 4.59683, 0, 0, 0.74676, -0.665093, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240896, 195164, 0, 1, 1, 1834.26, 226.399, 61.0765, 4.39891, 0, 0, 0.808817, -0.58806, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240897, 195164, 0, 1, 1, 1826.36, 228.105, 60.835, 4.52064, 0, 0, 0.771549, -0.63617, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240898, 195164, 0, 1, 1, 1824.26, 228.147, 60.7457, 4.61018, 0, 0, 0.742304, -0.670063, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240899, 195164, 0, 1, 1, 1822.35, 215.198, 60.8831, 4.55912, 0, 0, 0.759167, -0.650896, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240900, 195164, 0, 1, 1, 1824, 215.095, 60.9274, 4.51986, 0, 0, 0.771797, -0.635869, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240901, 195164, 0, 1, 1, 1828.14, 214.635, 61.1607, 4.56698, 0, 0, 0.756603, -0.653874, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240902, 195164, 0, 1, 1, 1829.93, 214.463, 61.1252, 4.60389, 0, 0, 0.744408, -0.667725, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240903, 195164, 0, 1, 1, 1833.41, 214.108, 60.941, 4.6196, 0, 0, 0.73914, -0.673552, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240904, 195164, 0, 1, 1, 1835.64, 214.253, 60.9162, 4.61567, 0, 0, 0.740462, -0.672098, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240905, 179968, 530, 1, 1, 9305.97, -7211.26, 15.9125, 5.77224, 0, 0, 0.252703, -0.967544, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240906, 179968, 530, 1, 1, 9305.18, -7213.52, 15.9982, 6.0864, 0, 0, 0.098234, -0.995163, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240907, 179968, 530, 1, 1, 9307.05, -7209.16, 15.8791, 5.57197, 0, 0, 0.34816, -0.937435, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240908, 195191, 530, 1, 1, 9281.03, -7204.93, 16.7354, 5.63479, 0, 0, 0.318548, -0.947907, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240909, 195164, 530, 1, 1, 9281.03, -7204.93, 17.6235, 4.91223, 0, 0, 0.633043, -0.774117, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240910, 195195, 530, 1, 1, 9282.63, -7203.82, 17.6235, 3.74591, 0, 0, 0.954696, -0.297582, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240911, 195192, 530, 1, 1, 9280.84, -7205.99, 17.6245, 4.04436, 0, 0, 0.899844, -0.436211, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240912, 195215, 530, 1, 1, 9280.06, -7205.31, 17.623, 4.23678, 0, 0, 0.85378, -0.520634, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240913, 195200, 530, 1, 1, 9284.67, -7200.88, 17.2278, 5.11643, 0, 0, 0.550846, -0.834607, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240914, 195198, 530, 1, 1, 9277.36, -7207.52, 16.424, 6.09424, 0, 0, 0.0943321, -0.995541, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240915, 195196, 530, 1, 1, 9279.56, -7209.09, 16.4021, 6.25525, 0, 0, 0.0139672, -0.999902, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240916, 195194, 530, 1, 1, 9283.41, -7205.43, 16.7583, 1.28368, 0, 0, 0.59867, 0.800996, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240917, 195197, 530, 1, 1, 9286.75, -7200.71, 17.2161, 1.58213, 0, 0, 0.711102, 0.703088, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240918, 195197, 530, 1, 1, 9277.64, -7209.89, 16.2857, 2.34789, 0, 0, 0.922283, 0.386516, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240919, 195212, 530, 1, 1, 9276.6, -7204.24, 16.638, 5.61908, 0, 0, 0.325984, -0.945375, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240920, 195212, 530, 1, 1, 9278.68, -7200.5, 17.0822, 5.58766, 0, 0, 0.340795, -0.940138, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240921, 195212, 530, 1, 1, 9277.92, -7202.53, 16.8511, 5.67405, 0, 0, 0.299881, -0.953977, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240922, 195199, 530, 1, 1, 9275.5, -7205.98, 16.4592, 5.67013, 0, 0, 0.30175, -0.953387, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240923, 195199, 530, 1, 1, 9280.95, -7200.67, 17.17, 1.21299, 0, 0, 0.569991, 0.821651, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240924, 195303, 530, 1, 1, 9282.95, -7202.64, 17.0309, 5.42273, 0, 0, 0.417078, -0.908871, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240925, 195303, 530, 1, 1, 9279.83, -7207.33, 16.9276, 6.00392, 0, 0, 0.139179, -0.990267, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240926, 180353, 530, 1, 1, 9278.21, -7205.61, 16.6083, 0.957736, 0, 0, 0.460775, 0.887517, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240927, 180353, 530, 1, 1, 9280.55, -7202.27, 16.9974, 0.957736, 0, 0, 0.460775, 0.887517, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240928, 180353, 530, 1, 1, 9306.54, -7210.01, 16.0835, 5.78401, 0, 0, 0.247004, -0.969014, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240929, 180353, 530, 1, 1, 9305.3, -7212.38, 15.9549, 6.14922, 0, 0, 0.0669326, -0.997757, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240930, 180353, 530, 1, 1, 9302.77, -7211.58, 16.0804, 3.41211, 0, 0, 0.990866, -0.134847, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240931, 180353, 530, 1, 1, 9303.11, -7223.44, 16.4783, 4.7355, 0, 0, 0.698889, -0.71523, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240932, 180353, 530, 1, 1, 9299.34, -7229.96, 16.5578, 3.149, 0, 0, 0.999993, -0.00370363, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240933, 180353, 530, 1, 1, 9293.58, -7230.07, 16.8357, 3.16078, 0, 0, 0.999954, -0.0095935, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240934, 180353, 530, 1, 1, 9288.71, -7230.16, 16.7451, 3.16078, 0, 0, 0.999954, -0.0095935, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240935, 180353, 530, 1, 1, 9283.86, -7225.95, 16.2737, 1.83346, 0, 0, 0.793616, 0.608419, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240936, 180353, 530, 1, 1, 9282.67, -7221.53, 16.1109, 1.83346, 0, 0, 0.793616, 0.608419, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240937, 180353, 530, 1, 1, 9281.12, -7215.74, 16.1288, 1.83346, 0, 0, 0.793616, 0.608419, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240938, 180353, 530, 1, 1, 9286.53, -7207.75, 16.5461, 0.117361, 0, 0, 0.0586468, 0.998279, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240939, 180353, 530, 1, 1, 9292.12, -7207.09, 16.4871, 0.117361, 0, 0, 0.0586468, 0.998279, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240940, 180353, 530, 1, 1, 9297.13, -7206.5, 16.3099, 0.117361, 0, 0, 0.0586468, 0.998279, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240941, 179968, 530, 1, 1, 9275.02, -7207.7, 16.313, 0.160557, 0, 0, 0.0801923, 0.996779, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240942, 179968, 530, 1, 1, 9274.35, -7207.81, 16.313, 0.160557, 0, 0, 0.0801923, 0.996779, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240943, 179968, 530, 1, 1, 9274.35, -7207.81, 17.0197, 0.160557, 0, 0, 0.0801923, 0.996779, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240944, 179968, 530, 1, 1, 9274.96, -7208.85, 16.233, 3.30608, 0, 0, 0.99662, -0.082151, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240945, 179968, 530, 1, 1, 9280.72, -7215.14, 16.1388, 0.368687, 0, 0, 0.183301, 0.983057, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240946, 179968, 530, 1, 1, 9281.43, -7216.52, 16.1099, 0.490423, 0, 0, 0.242762, 0.970086, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240947, 179968, 530, 1, 1, 9282.59, -7220.71, 16.0999, 0.309781, 0, 0, 0.154272, 0.988028, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240948, 179968, 530, 1, 1, 9282.9, -7222.09, 16.1318, 0.352978, 0, 0, 0.175574, 0.984466, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240949, 179968, 530, 1, 1, 9283.53, -7225.25, 16.2282, 0.553255, 0, 0, 0.273113, 0.961982, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240950, 179968, 530, 1, 1, 9284.43, -7226.71, 16.3315, 0.404029, 0, 0, 0.200643, 0.979664, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240951, 179968, 530, 1, 1, 9287.94, -7231.05, 16.794, 1.66459, 0, 0, 0.739478, 0.67318, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240952, 179968, 530, 1, 1, 9289.7, -7230.64, 16.8237, 1.73528, 0, 0, 0.762805, 0.646629, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240953, 179968, 530, 1, 1, 9292.94, -7230.5, 16.8598, 1.6214, 0, 0, 0.72477, 0.688991, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240954, 179968, 530, 1, 1, 9294.52, -7230.09, 16.842, 1.77455, 0, 0, 0.775354, 0.631527, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240955, 179968, 530, 1, 1, 9298.32, -7229.79, 16.6317, 1.53108, 0, 0, 0.692926, 0.721008, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240956, 179968, 530, 1, 1, 9300.41, -7229.9, 16.4162, 1.64103, 0, 0, 0.731497, 0.681845, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240957, 179968, 530, 1, 1, 9302.88, -7224.19, 16.4577, 2.9173, 0, 0, 0.993718, 0.111911, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240958, 179968, 530, 1, 1, 9303.3, -7222.68, 16.4909, 2.99977, 0, 0, 0.997487, 0.070852, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240959, 179968, 530, 1, 1, 9302.54, -7210.81, 16.0667, 3.32964, 0, 0, 0.995583, -0.0938852, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240960, 179968, 530, 1, 1, 9302.88, -7212.35, 16.1022, 3.40818, 0, 0, 0.99113, -0.132899, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240961, 179968, 530, 1, 1, 9298.13, -7206.27, 16.2716, 4.76692, 0, 0, 0.687567, -0.726121, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240962, 179968, 530, 1, 1, 9296.25, -7206.56, 16.3527, 4.85331, 0, 0, 0.65557, -0.755134, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240963, 179968, 530, 1, 1, 9293.1, -7206.86, 16.4519, 4.85331, 0, 0, 0.65557, -0.755134, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240964, 179968, 530, 1, 1, 9291.38, -7207.12, 16.5108, 4.84703, 0, 0, 0.657938, -0.753072, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240965, 179968, 530, 1, 1, 9287.17, -7207.68, 16.5565, 4.91379, 0, 0, 0.632439, -0.77461, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240966, 179968, 530, 1, 1, 9285.93, -7208.03, 16.53, 4.83132, 0, 0, 0.663833, -0.747881, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240967, 195164, 530, 1, 1, 9275.34, -7208.59, 16.8732, 2.23558, 0, 0, 0.899135, 0.437671, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240968, 195164, 530, 1, 1, 9280.83, -7214.95, 16.8446, 0.287796, 0, 0, 0.143402, 0.989665, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240969, 195164, 530, 1, 1, 9281.47, -7216.43, 16.8154, 0.653006, 0, 0, 0.320733, 0.94717, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240970, 195164, 530, 1, 1, 9282.72, -7220.66, 16.8067, 0.169986, 0, 0, 0.0848907, 0.99639, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240971, 195164, 530, 1, 1, 9282.76, -7222.2, 16.8376, 0.307431, 0, 0, 0.153111, 0.988209, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240972, 195164, 530, 1, 1, 9283.49, -7225.2, 16.934, 0.668714, 0, 0, 0.328162, 0.944622, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240973, 195164, 530, 1, 1, 9284.4, -7226.69, 17.0374, 0.495927, 0, 0, 0.24543, 0.969414, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240974, 195164, 530, 1, 1, 9287.91, -7231.42, 17.4998, 1.74471, 0, 0, 0.765845, 0.643025, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240975, 195164, 530, 1, 1, 9289.82, -7230.78, 17.5293, 1.8154, 0, 0, 0.78809, 0.61556, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240976, 195164, 530, 1, 1, 9292.8, -7230.59, 17.5657, 1.64653, 0, 0, 0.733369, 0.67983, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240977, 195164, 530, 1, 1, 9294.49, -7230.15, 17.5487, 1.61119, 0, 0, 0.721243, 0.692682, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240978, 195164, 530, 1, 1, 9298.31, -7229.87, 17.3376, 1.67402, 0, 0, 0.742644, 0.669686, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240979, 195164, 530, 1, 1, 9300.33, -7229.86, 17.1223, 1.54051, 0, 0, 0.696318, 0.717733, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240980, 195164, 530, 1, 1, 9302.9, -7224.07, 17.1636, 3.09952, 0, 0, 0.999779, 0.0210348, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240981, 195164, 530, 1, 1, 9303.32, -7222.57, 17.197, 3.05633, 0, 0, 0.999091, 0.0426184, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240982, 195164, 530, 1, 1, 9305.22, -7213.43, 16.7041, 2.90317, 0, 0, 0.992903, 0.118929, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240983, 195164, 530, 1, 1, 9307.03, -7209.21, 16.5859, 2.57331, 0, 0, 0.959903, 0.280333, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240984, 195164, 530, 1, 1, 9302.46, -7210.65, 16.7734, 3.27231, 0, 0, 0.997865, -0.0653122, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240985, 195164, 530, 1, 1, 9302.7, -7212.36, 16.8081, 3.26838, 0, 0, 0.997991, -0.0633512, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240986, 195164, 530, 1, 1, 9298.14, -7206.38, 16.9784, 4.81562, 0, 0, 0.669684, -0.742647, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240987, 195164, 530, 1, 1, 9296.39, -7206.61, 17.0586, 4.77242, 0, 0, 0.685567, -0.728009, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240988, 195164, 530, 1, 1, 9293.13, -7206.97, 17.1583, 4.741, 0, 0, 0.696919, -0.71715, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240989, 195164, 530, 1, 1, 9291.36, -7207.04, 17.2164, 4.88237, 0, 0, 0.644529, -0.764579, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240990, 195164, 530, 1, 1, 9287.29, -7207.67, 17.2622, 4.92164, 0, 0, 0.629394, -0.777087, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (240991, 195164, 530, 1, 1, 9285.87, -7208.02, 17.2357, 4.89415, 0, 0, 0.640015, -0.768362, 300, 0, 1, 0);
DELETE FROM game_event_gameobject WHERE eventEntry=26;
REPLACE INTO game_event_gameobject VALUES(26, 240400),(26, 240401),(26, 240402),(26, 240403),(26, 240404),(26, 240405),
(26, 240406),(26, 240407),(26, 240408),(26, 240409),(26, 240410),(26, 240411),(26, 240412),(26, 240413),(26, 240414),(26, 240415),(26, 240416),
(26, 240417),(26, 240418),(26, 240419),(26, 240420),(26, 240421),(26, 240422),(26, 240423),(26, 240424),(26, 240425),(26, 240426),(26, 240427),
(26, 240428),(26, 240429),(26, 240430),(26, 240431),(26, 240432),(26, 240433),(26, 240434),(26, 240435),(26, 240436),(26, 240437),(26, 240438),
(26, 240439),(26, 240440),(26, 240441),(26, 240442),(26, 240443),(26, 240444),(26, 240445),(26, 240446),(26, 240447),(26, 240448),(26, 240449),
(26, 240450),(26, 240451),(26, 240452),(26, 240453),(26, 240454),(26, 240455),(26, 240456),(26, 240457),(26, 240458),(26, 240459),(26, 240460),
(26, 240461),(26, 240462),(26, 240463),(26, 240464),(26, 240465),(26, 240466),(26, 240467),(26, 240468),(26, 240469),(26, 240470),(26, 240471),
(26, 240472),(26, 240473),(26, 240474),(26, 240475),(26, 240476),(26, 240477),(26, 240478),(26, 240479),(26, 240480),(26, 240481),(26, 240482),
(26, 240483),(26, 240484),(26, 240485),(26, 240486),(26, 240487),(26, 240488),(26, 240489),(26, 240490),(26, 240491),(26, 240492),(26, 240493),
(26, 240494),(26, 240495),(26, 240496),(26, 240497),(26, 240498),(26, 240499),(26, 240500),(26, 240501),(26, 240502),(26, 240503),(26, 240504),
(26, 240505),(26, 240506),(26, 240507),(26, 240508),(26, 240509),(26, 240510),(26, 240511),(26, 240512),(26, 240513),(26, 240514),(26, 240515),
(26, 240516),(26, 240517),(26, 240518),(26, 240519),(26, 240520),(26, 240521),(26, 240522),(26, 240523),(26, 240524),(26, 240525),(26, 240526),
(26, 240527),(26, 240528),(26, 240529),(26, 240530),(26, 240531),(26, 240532),(26, 240533),(26, 240534),(26, 240535),(26, 240536),(26, 240537),
(26, 240538),(26, 240539),(26, 240540),(26, 240541),(26, 240542),(26, 240543),(26, 240544),(26, 240545),(26, 240546),(26, 240547),(26, 240548),
(26, 240549),(26, 240550),(26, 240551),(26, 240552),(26, 240553),(26, 240554),(26, 240555),(26, 240556),(26, 240557),(26, 240558),(26, 240559),
(26, 240560),(26, 240561),(26, 240562),(26, 240563),(26, 240564),(26, 240565),(26, 240566),(26, 240567),(26, 240568),(26, 240569),(26, 240570),
(26, 240571),(26, 240572),(26, 240573),(26, 240574),(26, 240575),(26, 240576),(26, 240577),(26, 240578),(26, 240579),(26, 240580),(26, 240581),
(26, 240582),(26, 240583),(26, 240584),(26, 240585),(26, 240586),(26, 240587),(26, 240588),(26, 240589),(26, 240590),(26, 240591),(26, 240592),
(26, 240593),(26, 240594),(26, 240595),(26, 240596),(26, 240597),(26, 240598),(26, 240599),(26, 240600),(26, 240601),(26, 240602),(26, 240603),
(26, 240604),(26, 240605),(26, 240606),(26, 240607),(26, 240608),(26, 240609),(26, 240610),(26, 240611),(26, 240612),(26, 240613),(26, 240614),
(26, 240615),(26, 240616),(26, 240617),(26, 240618),(26, 240619),(26, 240620),(26, 240621),(26, 240622),(26, 240623),(26, 240624),(26, 240625),
(26, 240626),(26, 240627),(26, 240628),(26, 240629),(26, 240630),(26, 240631),(26, 240632),(26, 240633),(26, 240634),(26, 240635),(26, 240636),
(26, 240637),(26, 240638),(26, 240639),(26, 240640),(26, 240641),(26, 240642),(26, 240643),(26, 240644),(26, 240645),(26, 240646),(26, 240647),
(26, 240648),(26, 240649),(26, 240650),(26, 240651),(26, 240652),(26, 240653),(26, 240654),(26, 240655),(26, 240656),(26, 240657),(26, 240658),
(26, 240659),(26, 240660),(26, 240661),(26, 240662),(26, 240663),(26, 240664),(26, 240665),(26, 240666),(26, 240667),(26, 240668),(26, 240669),
(26, 240670),(26, 240671),(26, 240672),(26, 240673),(26, 240674),(26, 240675),(26, 240676),(26, 240677),(26, 240678),(26, 240679),(26, 240680),
(26, 240681),(26, 240682),(26, 240683),(26, 240684),(26, 240685),(26, 240686),(26, 240687),(26, 240688),(26, 240689),(26, 240690),(26, 240691),
(26, 240692),(26, 240693),(26, 240694),(26, 240695),(26, 240696),(26, 240697),(26, 240698),(26, 240699),(26, 240700),(26, 240701),(26, 240702),
(26, 240703),(26, 240704),(26, 240705),(26, 240706),(26, 240707),(26, 240708),(26, 240709),(26, 240710),(26, 240711),(26, 240712),(26, 240713),
(26, 240714),(26, 240715),(26, 240716),(26, 240717),(26, 240718),(26, 240719),(26, 240720),(26, 240721),(26, 240722),(26, 240723),(26, 240724),
(26, 240725),(26, 240726),(26, 240727),(26, 240728),(26, 240729),(26, 240730),(26, 240731),(26, 240732),(26, 240733),(26, 240734),(26, 240735),
(26, 240736),(26, 240737),(26, 240738),(26, 240739),(26, 240740),(26, 240741),(26, 240742),(26, 240743),(26, 240744),(26, 240745),(26, 240746),
(26, 240747),(26, 240748),(26, 240749),(26, 240750),(26, 240751),(26, 240752),(26, 240753),(26, 240754),(26, 240755),(26, 240756),(26, 240757),
(26, 240758),(26, 240759),(26, 240760),(26, 240761),(26, 240762),(26, 240763),(26, 240764),(26, 240765),(26, 240766),(26, 240767),(26, 240768),
(26, 240769),(26, 240770),(26, 240771),(26, 240772),(26, 240773),(26, 240774),(26, 240775),(26, 240776),(26, 240777),(26, 240778),(26, 240779),
(26, 240780),(26, 240781),(26, 240782),(26, 240783),(26, 240784),(26, 240785),(26, 240786),(26, 240787),(26, 240788),(26, 240789),(26, 240790),
(26, 240791),(26, 240792),(26, 240793),(26, 240794),(26, 240795),(26, 240796),(26, 240797),(26, 240798),(26, 240799),(26, 240800),(26, 240801),
(26, 240802),(26, 240803),(26, 240804),(26, 240805),(26, 240806),(26, 240807),(26, 240808),(26, 240809),(26, 240810),(26, 240811),(26, 240812),
(26, 240813),(26, 240814),(26, 240815),(26, 240816),(26, 240817),(26, 240818),(26, 240819),(26, 240820),(26, 240821),(26, 240822),(26, 240823),
(26, 240824),(26, 240825),(26, 240826),(26, 240827),(26, 240828),(26, 240829),(26, 240830),(26, 240831),(26, 240832),(26, 240833),(26, 240834),
(26, 240835),(26, 240836),(26, 240837),(26, 240838),(26, 240839),(26, 240840),(26, 240841),(26, 240842),(26, 240843),(26, 240844),(26, 240845),
(26, 240846),(26, 240847),(26, 240848),(26, 240849),(26, 240850),(26, 240851),(26, 240852),(26, 240853),(26, 240854),(26, 240855),(26, 240856),
(26, 240857),(26, 240858),(26, 240859),(26, 240860),(26, 240861),(26, 240862),(26, 240863),(26, 240864),(26, 240865),(26, 240866),(26, 240867),
(26, 240868),(26, 240869),(26, 240870),(26, 240871),(26, 240872),(26, 240873),(26, 240874),(26, 240875),(26, 240876),(26, 240877),(26, 240878),
(26, 240879),(26, 240880),(26, 240881),(26, 240882),(26, 240883),(26, 240884),(26, 240885),(26, 240886),(26, 240887),(26, 240888),(26, 240889),
(26, 240890),(26, 240891),(26, 240892),(26, 240893),(26, 240894),(26, 240895),(26, 240896),(26, 240897),(26, 240898),(26, 240899),(26, 240900),
(26, 240901),(26, 240902),(26, 240903),(26, 240904),(26, 240905),(26, 240906),(26, 240907),(26, 240908),(26, 240909),(26, 240910),(26, 240911),
(26, 240912),(26, 240913),(26, 240914),(26, 240915),(26, 240916),(26, 240917),(26, 240918),(26, 240919),(26, 240920),(26, 240921),(26, 240922),
(26, 240923),(26, 240924),(26, 240925),(26, 240926),(26, 240927),(26, 240928),(26, 240929),(26, 240930),(26, 240931),(26, 240932),(26, 240933),
(26, 240934),(26, 240935),(26, 240936),(26, 240937),(26, 240938),(26, 240939),(26, 240940),(26, 240941),(26, 240942),(26, 240943),(26, 240944),
(26, 240945),(26, 240946),(26, 240947),(26, 240948),(26, 240949),(26, 240950),(26, 240951),(26, 240952),(26, 240953),(26, 240954),(26, 240955),
(26, 240956),(26, 240957),(26, 240958),(26, 240959),(26, 240960),(26, 240961),(26, 240962),(26, 240963),(26, 240964),(26, 240965),(26, 240966),
(26, 240967),(26, 240968),(26, 240969),(26, 240970),(26, 240971),(26, 240972),(26, 240973),(26, 240974),(26, 240975),(26, 240976),(26, 240977),
(26, 240978),(26, 240979),(26, 240980),(26, 240981),(26, 240982),(26, 240983),(26, 240984),(26, 240985),(26, 240986),(26, 240987),(26, 240988),
(26, 240989),(26, 240990),(26, 240991);
