DELETE FROM acore_world.forge_talent_tabs WHERE id = 805;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 805 AND spellid = 5171;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 800 AND spellid = 5171;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 805 AND spellid >= 1200000 AND spellid < 1300000;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 805 AND talentSpellId = 5171;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 805 AND talentSpellId >= 1200000 AND talentSpellId < 1300000;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 805 AND reqId >= 1200000 AND reqId <= 1300000;
DELETE FROM acore_world.forge_talent_unlearn WHERE talentTabId = 805;
DELETE FROM acore_world.forge_talent_exclusive WHERE talentTabId = 805
	AND talentSpellId >= 1200000 AND talentSpellId < 1300000;
    
/* Slice and Dice */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (805,8,32767,'Slice and Dice',5171,'\"\"',1,1);
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (5171,800,0,1,0,0,5,0,0);
 
 /* Slice and Dice base node */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (5171,805,11,5,0,1,1,0,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (5171,805,1,1752);


/* Roll the Bones */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200051,805,13,3,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200051,805,1,1200051);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200051,1200051,805,5171,805,0);

/* Fate Bringer */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200088,805,15,4,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200088,805,1,1200088),
(1200088,805,2,1200089),
(1200088,805,3,1200090);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200088,1200088,805,1200051,805,1);

/* Loaded Dice */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200091,805,17,6,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200091,805,1,1200091);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200091,1200091,805,1200088,805,3);


/* Dash and Gash */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200092,805,11,7,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200092,805,1,1200092);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200092,1200092,805,5171,805,0);

/* Nimble Movement */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200093,805,12,8,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200093,805,1,1200093),
(1200093,805,2,1200095),
(1200093,805,3,1200097);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200093,1200093,805,1200092,805,1);

/* Cut Tendon */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200099,805,11,9,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200099,805,1,1200099),
(1200099,805,2,1200101),
(1200099,805,3,1200103);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200099,1200099,805,1200093,805,3);

/* Cull the Weak */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200105,805,9,9,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200105,805,1,1200105);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200105,1200105,805,1200099,805,3);


/* Awe and Inspire */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200107,805,11,3,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200107,805,1,1200107);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200107,1200107,805,5171,805,0);

/* Elemental Carol */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200111,805,12,1,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200111,805,1,1200111);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200111,1200111,805,1200107,805,1);

/* Advancing March */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200113,805,14,1,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200113,805,1,1200113);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200113,1200113,805,1200111,805,1);

/* Refreshing Tune */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200115,805,16,2,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200115,805,1,1200115);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200115,1200115,805,1200113,805,1);

/* Battle Chorus */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200117,805,18,4,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200117,805,1,1200117);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200117,1200117,805,1200115,805,1);


/* Wild Cuts */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200119,805,9,5,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200119,805,1,1200119);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200119,1200119,805,5171,805,0);

/* Unpredictable */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200120,805,9,3,2,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200120,805,1,1200120),
(1200120,805,2,1200122),
(1200120,805,3,1200124),
(1200120,805,4,1200126),
(1200120,805,5,1200128);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200120,1200120,805,1200119,805,1);

/* Advance */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200136,805,10,1,5,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200136,805,1,1200136);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200136,1200136,805,1200120,805,5);

/* Blade Wall */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200130,805,9,7,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200130,805,1,1200130),
(1200130,805,2,1200132),
(1200130,805,3,1200134);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200130,1200130,805,1200119,805,1);

/* Striking Glint */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200137,805,7,5,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200137,805,1,1200137);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200137,1200137,805,1200119,805,1);


/* Generics */
/* Always Ready */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200139,805,13,7,10,1,1,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200139,805,1,1200139),
(1200139,805,2,1200141);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200139,1200139,805,5171,805,0);

/* Threatening Slice and Dice */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200143,805,15,8,3,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200143,805,1,1200143);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200143,1200143,805,1200139,805,2);

/* Action Economy */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200145,805,14,9,5,1,1,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200145,805,1,1200145),
(1200145,805,2,1200147);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200145,1200145,805,1200143,805,1);


INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200051,805,1200092);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200051,805,1200107);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200051,805,1200119);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200092,805,1200051);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200092,805,1200107);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200092,805,1200119);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200107,805,1200051);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200107,805,1200092);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200107,805,1200119);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200119,805,1200051);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200119,805,1200092);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200119,805,1200107);
