DELETE FROM acore_world.forge_talent_tabs WHERE id = 801;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 801 AND spellid = 1752;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 800 AND spellid = 1752;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 801 AND spellid >= 120000 AND spellid <= 120074;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 801 AND talentSpellId = 1752;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 801 AND talentSpellId >= 120000 AND talentSpellId <= 120074;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 801 AND reqId >= 120000 AND reqId <= 120074;
DELETE FROM acore_world.forge_talent_unlearn WHERE talentTabId = 801;
DELETE FROM acore_world.forge_talent_exclusive WHERE talentTabId = 801
	AND talentSpellId >= 120000 AND talentSpellId <= 120074;
    
DELETE FROM acore_world.forge_talent_tabs WHERE id = 801;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 801 AND spellid = 1752;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 800 AND spellid = 1752;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 801 AND spellid >= 1200000 AND spellid <= 1200074;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 801 AND talentSpellId = 1752;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 801 AND talentSpellId >= 1200000 AND talentSpellId <= 1200074;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 801 AND reqId >= 1200000 AND reqId <= 1200074;
DELETE FROM acore_world.forge_talent_unlearn WHERE talentTabId = 801;
DELETE FROM acore_world.forge_talent_exclusive WHERE talentTabId = 801
	AND talentSpellId >= 1200000 AND talentSpellId < 1300000;
    
/* Sinister Strike */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (801,8,32767,'Sinister Strike',1752,'\"\"',1,1);
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1752,800,0,0,0,0,5,0,0);
 
 /* Sinister Strike base node */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1752,801,11,5,0,1,1,0,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1752,801,1,1752);

/* Sinister Slam */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200039,801,13,5,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200039,801,1,1200039);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200039,1200039,801,1752,801,0);

/* Slamming Crush */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200041,801,16,5,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200041,801,1,1200041),
(1200041,801,2,1200042),
(1200041,801,3,1200043),
(1200041,801,4,1200044),
(1200041,801,5,1200045);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200041,1200041,801,1200039,801,1);

/* Heavy Slam */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200046,801,19,5,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200046,801,1,1200046),
(1200046,801,2,1200047),
(1200046,801,3,1200048),
(1200046,801,4,1200049),
(1200046,801,5,1200050);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200046,1200046,801,1200041,801,5);

INSERT INTO  acore_world.forge_talent_unlearn (`talentTabId`,`talentSpellId`,`unlearnSpell`) VALUES 
(801,1200039,1752),(801,1200039,1757),(801,1200039,1758),(801,1200039,1759),(801,1200039,1760),(801,1200039,8621),
(801,1200039,11293),(801,1200039,11294),(801,1200039,26861),(801,1200039,26862),(801,1200039,48637),(801,1200039,48638);

/* Sinister Sting */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200040,801,12,4,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200040,801,1,1200040);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200040,1200040,801,1752,801,0);

/* Penetrating Sting */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200052,801,15,4,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200052,801,1,1200052),
(1200052,801,2,1200053),
(1200052,801,3,1200054),
(1200052,801,4,1200055),
(1200052,801,5,1200056);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200052,1200052,801,1200040,801,1);

/* Apply Red Note */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200057,801,18,4,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200057,801,1,1200057),
(1200057,801,2,1200058),
(1200057,801,3,1200059);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200057,1200057,801,1200052,801,5);

INSERT INTO  acore_world.forge_talent_unlearn (`talentTabId`,`talentSpellId`,`unlearnSpell`) VALUES 
(801,1200040,1752),(801,1200040,1757),(801,1200040,1758),(801,1200040,1759),(801,1200040,1760),(801,1200040,8621),
(801,1200040,11293),(801,1200040,11294),(801,1200040,26861),(801,1200040,26862),(801,1200040,48637),(801,1200040,48638);

/* Sinister Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200000,801,11,3,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200000,801,1,1200000);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200000,1200000,801,1752,801,0);

/* Booming Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200002,801,10,2,3,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200002,801,1,1200002),
(1200002,801,2,1200004),
(1200002,801,3,1200006);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200002,1200002,801,1200000,801,5);

/* Penetrating Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200008,801,9,1,5,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200008,801,1,1200008);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200008,1200008,801,1200002,801,3);

/* Refreshing Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200009,801,7,1,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200009,801,1,1200009),
(1200009,801,2,1200010),
(1200009,801,3,1200011),
(1200009,801,4,1200012),
(1200009,801,5,1200013);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200009,1200009,801,1200008,801,1);

/* Cleaving Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200014,801,5,1,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200014,801,1,1200014);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200014,1200014,801,1200009,801,5);

/* Further Echo */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200015,801,4,2,5,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200015,801,1,1200015);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200015,1200015,801,1200014,801,1);

INSERT INTO  acore_world.forge_talent_unlearn (`talentTabId`,`talentSpellId`,`unlearnSpell`) VALUES 
(801,1200000,1752),(801,1200000,1757),(801,1200000,1758),(801,1200000,1759),(801,1200000,1760),(801,1200000,8621),
(801,1200000,11293),(801,1200000,11294),(801,1200000,26861),(801,1200000,26862),(801,1200000,48637),(801,1200000,48638);

/* Sinister Wounds */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200016,801,9,5,10,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200016,801,1,1200016);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200016,1200016,801,1752,801,0);

/* Puncturing Sinister Wounds */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200017,801,7,5,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200017,801,1,1200017),
(1200017,801,2,1200018),
(1200017,801,3,1200019),
(1200017,801,4,1200020),
(1200017,801,5,1200021);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200017,1200017,801,1200016,801,1);

/* Transfusion */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200022,801,6,6,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200022,801,1,1200022),
(1200022,801,2,1200023),
(1200022,801,3,1200024),
(1200022,801,4,1200025),
(1200022,801,5,1200026);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200022,1200022,801,1200017,801,5);

/* Covered in Blood */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200027,801,6,4,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200027,801,1,1200027),
(1200027,801,2,1200028),
(1200027,801,3,1200029),
(1200027,801,4,1200030),
(1200027,801,5,1200031);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200027,1200027,801,1200017,801,5);

/* Bloodier Sinister Wounds */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200033,801,5,5,10,1,1,1,1);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1200033,801,1,1200033);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) VALUES 
(1200033,1200033,801,1200022,801,5),
(1200032,1200033,801,1200027,801,5);

INSERT INTO  acore_world.forge_talent_unlearn (`talentTabId`,`talentSpellId`,`unlearnSpell`) VALUES 
(801,1200016,1752),(801,1200016,1757),(801,1200016,1758),(801,1200016,1759),(801,1200016,1760),(801,1200016,8621),
(801,1200016,11293),(801,1200016,11294),(801,1200016,26861),(801,1200016,26862),(801,1200016,48637),(801,1200016,48638);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200022,801,1200027);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200027,801,1200022);

/* Generics */
/* Critical Sinister Strike */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200034,801,11,7,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200034,801,1,1200034),
(1200034,801,2,1200035),
(1200034,801,3,1200036),
(1200034,801,4,1200037),
(1200034,801,5,1200038);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200034,1200034,801,1752,801,0);

/* Subtle Sinister Strike */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200061,801,12,6,3,1,1,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200061,801,1,1200061);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200061,1200061,801,1752,801,0);

/* Nimble Sininster Strike */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200062,801,15,6,3,1,1,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200062,801,1,1200062),
(1200062,801,2,1200064),
(1200062,801,3,1200066),
(1200062,801,4,1200068),
(1200062,801,5,1200040);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200062,1200062,801,1200061,801,1);

/* Invigorating Sinister Strike */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1200072,801,18,6,5,1,1,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) VALUES 
(1200072,801,1,1200072),
(1200072,801,2,1200073),
(1200072,801,3,1200074);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1200072,1200072,801,1200062,801,5);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200039,801,1200040);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200039,801,1200000);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200039,801,1200016);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200040,801,1200039);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200040,801,1200000);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200040,801,1200016);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200000,801,1200040);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200000,801,1200039);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200000,801,1200016);

INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200016,801,1200040);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200016,801,1200000);
INSERT INTO acore_world.forge_talent_exclusive (`talentSpellId`,`talentTabId`,`exlusiveSpellId`) VALUES (1200016,801,1200039);
