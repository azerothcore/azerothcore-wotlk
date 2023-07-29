DELETE FROM acore_world.forge_talent_tabs WHERE id = 800;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 802;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 802;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 802;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 802;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 803;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 803;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 803;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 803;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 804;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 804;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 804;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 804;
DELETE FROM `acore_world`.`forge_talent_tabs` WHERE id = 806;
DELETE FROM `acore_world`.`forge_talents` WHERE talentTabId = 806;

INSERT INTO `acore_world`.`forge_talent_tabs` (`id`, `classMask`, `raceMask`, `name`, `spellIcon`, `background`, `tabType`, `TabIndex`) VALUES (806, 8, 32767, 'Class Specialization', 635, '""', 7, 0);

INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('1329', '806', '802', '1', '0', '10', '7', '0', '0');
INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('32645', '806', '802', '2', '0', '10', '7', '0', '0');
INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('16511', '806', '804', '1', '0', '10', '7', '0', '0');


/* Forge Skills */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (800,8,32767,'Forge Skills',2018,'Interface\\AddOns\\ForgedWoW\\UI\\spellbook_base',5,99);
 
/* Assassination */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (802,8,32767,'Assassination',8623,'Interface\\AddOns\\ForgedWoW\\UI\\rogue_assassination',0,98);
 
/* Combat */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (803,8,32767,'Combat',53,'Interface\\AddOns\\ForgedWoW\\UI\\rogue_combat',0,97);
 
/* Subtlety */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (804,8,32767,'Subtlety',1784,'Interface\\AddOns\\ForgedWoW\assets\\rogue_subtlety',0,96);
 
 
/* Assassination Talents */
/* Row 1 */
/* Improved Eviscerate */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14162,802,5,3,1,10,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14162,802,1,14162);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14162,802,2,14163);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14162,802,3,14164);

/* Remorseless Attacks */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14144,802,5,5,1,10,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14144,802,1,14144);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14144,802,2,14148);

/* Malice */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14138,802,5,7,1,10,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14138,802,1,14138);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14138,802,2,14139);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14138,802,3,14140);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14138,802,4,14141);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14138,802,5,14142);

/* Row 2 */
/* Ruthlessness */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14156,802,6,3,1,15,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14156,802,1,14156);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14156,802,2,14160);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14156,802,3,14161);

/* Blood Spatter */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51632,802,6,5,1,15,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51632,802,1,51632);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51632,802,2,51633);

/* Puncturing Wounds */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (13733,802,6,9,1,15,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (13733,802,1,13733);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (13733,802,2,13865);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (13733,802,3,13866);

/* Row 3 */
/* Vigor */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14983,802,7,3,1,20,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14983,802,1,14983);

/* Improved Expose Armor */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14168,802,7,5,1,20,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14168,802,1,14168);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14168,802,2,14169);

/* Lethality */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14128,802,7,7,1,20,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14128,802,1,14128);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14128,802,2,14132);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14128,802,3,14135);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14128,802,4,14136);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14128,802,5,14137);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (14128,14128,802,14138,802,5);

/* Row 4 */
/* Vile Poisons */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (16513,802,8,5,1,25,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (16513,802,1,16513);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (16513,802,2,16514);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (16513,802,3,16515);

/* Improved Poisons */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14113,802,8,7,1,25,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14113,802,1,14113);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14113,802,2,14114);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14113,802,3,14115);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14113,802,4,14116);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14113,802,5,14117);

/* Row 5 */
/* Fleet Footed */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (31208,802,9,3,1,30,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31208,802,1,31208);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31208,802,2,31209);

/* Cold Blood */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14177,802,9,5,1,30,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14177,802,1,14177);

/* Improved Kidney Shot */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14174,802,9,7,1,30,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14174,802,1,14174);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14174,802,2,14175);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14174,802,3,14176);

/* Quick Recovery */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (31244,802,9,9,1,30,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31244,802,1,31244);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31244,802,2,31245);

/* Row 6 */
/* Seal Fate */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14186,802,10,5,1,35,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14186,802,1,14186);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14186,802,2,14190);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14186,802,3,14193);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14186,802,4,14194);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14186,802,5,14195);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (14186,14186,802,14177,802,1);

/* Murder */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (14158,802,10,7,1,35,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14158,802,1,14158);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (14158,802,2,14159);

/* Row 7 */
/* Deadly Brew */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51625,802,11,3,1,40,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51625,802,1,51625);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51625,802,2,51626); 

/* Overkill */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (58426,802,11,5,1,40,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (58426,802,1,58426); 

/* Deadened Nerves */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (31380,802,11,7,1,40,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31380,802,1,31380);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31380,802,2,31382);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31380,802,3,31383);

/* Row 8 */
/* Focused Attacks */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51634,802,12,3,1,45,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51634,802,1,51634);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51634,802,2,51635);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51634,802,3,51635);

/* Find Weakness */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (31234,802,12,7,1,45,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31234,802,1,31234);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31234,802,2,31235);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31234,802,3,31236);

/* Row 9 */
/* Master Poisoner */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (31226,802,13,3,1,50,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31226,802,1,31226);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31226,802,2,31227);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (31226,802,3,58410);

/* Mutilate */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1329,802,13,5,1,50,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1329,802,1,1329);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (1329,1329,802,58426,802,1);

/* Turn the Tables */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51627,802,13,7,1,50,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51627,802,1,51627);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51627,802,2,51628);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51627,802,3,51629);

/* Row 10 */
/* Cut to the Chase */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51664,802,14,5,1,55,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51664,802,1,51664);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51664,802,2,51665);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51664,802,3,51667);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51664,802,4,51668);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51664,802,5,51669);

/* Row 11 */
/* Hunger for Blood */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (51662,802,15,5,1,60,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (51662,802,1,51662);


/* Combat Talents */
/* Row 1 */
/* Auto Throw */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (129999,803,5,9,1,10,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (129999,803,1,129999);

