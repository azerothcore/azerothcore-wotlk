DELETE FROM acore_world.forge_talent_tabs WHERE id = 999900;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 999900;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 999900;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 999900;
DELETE FROM acore_world.forge_talent_unlearn WHERE talentTabId = 999900;
DELETE FROM acore_world.forge_talent_exclusive WHERE talentTabId = 999900;

INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (999900,2047,32767,'Racials',6562,'Interface\\AddOns\\ForgedWoW\\UI\\racial',4, 0);
 
 -- 11 x 19
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (823,999900,3,8,0,1,4,0,0);


 -- Arcane Resistance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20592,999900,5,10,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20592,999900,1,20592);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20592,999900,823,999900,0);

-- Frost Resistance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20596,999900,3,10,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20596,999900,1,20596);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20596,999900,823,999900,0);

-- Magic Resistance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (822,999900,1,8,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (822,999900,1,822);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,822,999900,823,999900,0);

-- Nature Resistance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20551,999900,5,8,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20551,999900,1,20551);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20551,999900,823,999900,0);

-- Shadow Resistance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20579,999900,1,10,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20579,999900,1,20579);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20579,999900,823,999900,0);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (3369,999900,9,10,0,1,4,0,0);

  -- Endurance
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20550,999900,7,10,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20550,999900,1,20550);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20550,999900,3369,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20550,999900,20591);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20550,999900,20598);

  -- Expansive Mind
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20591,999900,11,10,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20591,999900,1,20591);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20591,999900,3369,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20591,999900,20550);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20591,999900,20598);

  -- The Human Spirit
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20598,999900,9,8,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20598,999900,1,20598);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20598,999900,3369,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20598,999900,20550);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20598,999900,20591);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20504,999900,17,8,0,1,4,0,0);
 
   -- Axe Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20574,999900,15,10,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20574,999900,1,20598);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20574,999900,20504,999900,0);


   -- Bow Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (26290,999900,17,10,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (26290,999900,1,20598);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,26290,999900,20504,999900,0);


   -- Gun Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20595,999900,19,10,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20595,999900,1,20595);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20595,999900,20504,999900,0);

   -- Mace Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (59224,999900,15,8,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (59224,999900,1,59224);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,59224,999900,20504,999900,0);


   -- Sword Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20597,999900,17,6,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20597,999900,1,20597);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20597,999900,20504,999900,0);


   -- Throwing Specialization
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20558,999900,19,8,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20558,999900,1,20558);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20558,999900,20504,999900,0);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (25,999900,7,7,0,1,4,0,0);
 
   -- Arcane Torrent
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (50613,999900,6,5,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (50613,999900,1,50613);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,50613,999900,25,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (50613,999900,20549);

   -- War Stomp
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20549,999900,8,5,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20549,999900,1,20549);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20549,999900,25,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20549,999900,50613);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (6979,999900,11,7,0,1,4,0,0);
 
   -- Berserking
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (26297,999900,13,5,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (26297,999900,1,26297);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,26297,999900,6979,999900,0);


INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (26297,999900,33697);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (26297,999900,65222);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (26297,999900,28878);

   -- Blood Fury
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (33697,999900,13,7,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (33697,999900,1,33697);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,33697,999900,6979,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (33697,999900,26297);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (33697,999900,65222);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (33697,999900,28878);

   -- Command
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (65222,999900,11,5,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (65222,999900,1,65222);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,65222,999900,6979,999900,0);


INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (65222,999900,26297);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (65222,999900,33697);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (65222,999900,28878);


   -- Heroic Presence
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (28878,999900,13,9,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (28878,999900,1,28878);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,28878,999900,6979,999900,0);


INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (28878,999900,26297);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (28878,999900,33697);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (28878,999900,65222);

  -- Heals
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (647,999900,8,1,0,1,4,0,0);
 
   -- Cannibalize
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20577,999900,7,3,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20577,999900,1,20577);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20577,999900,647,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20577,999900,59547);

   -- Gift of the Naaru
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (59547,999900,9,3,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (59547,999900,1,59547);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,59547,999900,647,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (59547,999900,20577);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1044,999900,19,3,0,1,4,0,0);
 
   -- Shadowmeld
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (58984,999900,19,5,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (58984,999900,1,58984);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,58984,999900,1044,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (58984,999900,7744);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (58984,999900,20594);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (58984,999900,59752);

   -- Every Man for Himself
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (59752,999900,17,3,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (59752,999900,1,59752);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,59752,999900,1044,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (59752,999900,7744);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (59752,999900,20594);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (59752,999900,58984);

   -- Stoneform
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20594,999900,17,1,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20594,999900,1,20594);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20594,999900,1044,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20594,999900,7744);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20594,999900,59752);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (20594,999900,58984);

   -- Will of the Forsaken
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (7744,999900,19,1,5,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (7744,999900,1,7744);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,7744,999900,1044,999900,0);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (7744,999900,20594);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (7744,999900,59752);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (7744,999900,58984);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (905,999900,13,1,0,1,4,0,0);


    -- Da Voodoo Shuffle
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (58943,999900,13,3,3,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (58943,999900,1,58943);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,58943,999900,905,999900,0);

    -- Hardiness
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20573,999900,11,3,3,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20573,999900,1,20573);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20573,999900,905,999900,0);


    -- Quickness
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20582,999900,15,3,3,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20582,999900,1,20582);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20582,999900,905,999900,0);


    -- Regeneration
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20555,999900,15,1,3,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20555,999900,1,20555);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20555,999900,905,999900,0);


INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (2382,999900,3,3,0,1,4,0,0);


     -- Wisp Spirit
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20585,999900,1,5,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20585,999900,1,20585);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20585,999900,2382,999900,0);

     -- Beast Slaying
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20557,999900,3,5,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20557,999900,1,20557);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20557,999900,2382,999900,0);

     -- Diplomacy
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20599,999900,1,1,4,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20599,999900,1,20599);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,20599,999900,2382,999900,0);

     -- Elusiveness
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (21009,999900,1,3,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (21009,999900,1,21009);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,21009,999900,2382,999900,0);


     -- Find Treasure
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (2481,999900,5,3,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (2481,999900,1,2481);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,2481,999900,2382,999900,0);


     -- Perception
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (58985,999900,3,1,2,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (58985,999900,1,58985);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,58985,999900,2382,999900,0);

     -- Underwater Breathing
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (5227,999900,5,1,1,1,4,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (5227,999900,1,5227);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1,5227,999900,2382,999900,0);
