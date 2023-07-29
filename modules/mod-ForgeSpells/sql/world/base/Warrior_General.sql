DELETE FROM acore_world.forge_talent_tabs WHERE id = 400;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 401;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 401;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 401;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 401;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 402;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 402;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 402;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 402;
DELETE FROM acore_world.forge_talent_tabs WHERE id = 403;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 403;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 403;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 403;
DELETE FROM `acore_world`.`forge_talent_tabs` WHERE id = 404;
DELETE FROM `acore_world`.`forge_talents` WHERE talentTabId = 404;

INSERT INTO `acore_world`.`forge_talent_tabs` (`id`, `classMask`, `raceMask`, `name`, `spellIcon`, `background`, `tabType`, `TabIndex`) VALUES (404, 1, 32767, 'Class Specialization', 635, '""', 7, 0);

INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('23922', '404', '401', '1', '0', '10', '7', '0', '0');
INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('20243', '404', '401', '2', '0', '10', '7', '0', '0');
INSERT INTO `acore_world`.`forge_talents` (`spellid`, `talentTabId`, `columnIndex`, `rowIndex`, `rankCost`, `minLevel`, `talentType`, `numberRanks`, `preReqType`) VALUES ('2565', '404', '403', '1', '0', '10', '7', '0', '0');


/* Forge Skills */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (400,1,32767,'Forge Skills',2018,'Interface\\AddOns\\ForgedWoW\\UI\\spellbook_base',5,99);
 
/* Arms */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (401,1,32767,'Arms',9347,'Interface\\AddOns\\ForgedWoW\\UI\\rogue_assassination',0,98);
 
/* Fury */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (402,1,32767,'Fury',20375,'Interface\\AddOns\\ForgedWoW\\UI\\rogue_combat',0,97);
 
/* Protection */
INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (403,1,32767,'Protection',71,'Interface\\AddOns\\ForgedWoW\assets\\rogue_subtlety',0,96);
 
 
/* Arms Talents */
/* Row 1 */
/* Improved Strikes */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1120138,401,5,3,1,10,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120138,401,1,1120138);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120138,401,2,1120139);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120138,401,3,1120140);

/* Taste For Blood */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (56636,401,5,5,1,10,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (56636,401,1,56636);

/* Improved Rending */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1120145,401,5,7,1,10,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120145,401,1,1120145);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120145,401,2,1120146);


/* Row 2 */
/* Iron Will */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12300,401,6,5,1,15,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12300,401,1,12300);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12300,401,2,12959);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12300,401,3,12960);

/* Technical Mastery */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1120153,401,6,7,1,15,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120153,401,1,1120153);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120153,401,2,1120154);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120153,401,3,1120155);

/* Tactical Mastery */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12295,401,6,9,1,15,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12295,401,1,12295);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12295,401,2,12676);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12295,401,3,12677);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (12295,12295,401,1120153,401,3);


/* Row 3 */
/* Anger Management */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12296,401,7,5,1,20,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12296,401,1,12296);

/* Impale */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (16493,401,7,7,1,20,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (16493,401,1,16493);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (16493,401,2,16494);

/* Deep Wounds */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12834,401,7,9,1,20,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12834,401,1,12834);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12834,401,2,12849);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12834,401,3,12867);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (12834,12834,401,16493,401,2);


/* Row 4 */
/* Weapon Mastery */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (20504,401,8,7,1,25,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20504,401,1,20504);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (20504,401,2,20505);

/* Row 5 */
/* Weapon Specialization */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1120164,401,9,3,1,30,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120164,401,1,1120164);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120164,401,2,1120165);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120164,401,3,1120166);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120164,401,4,1120167);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120164,401,5,1120168);

/* Sweeping Strikes */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12328,401,9,5,1,30,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12328,401,1,12328);


/* Row 6 */
/* Two-Handed Weapon Specialization */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12163,401,10,3,1,35,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12163,401,1,12163);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12163,401,2,12711);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12163,401,3,12712);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12163,401,4,1120162);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12163,401,5,1120163);

/* Trauma */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (46854,401,10,9,1,35,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46854,401,1,46854);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46854,401,2,46855);


/* Row 7 */
/* Second Wind */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (29834,401,11,3,1,40,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29834,401,1,29834);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29834,401,2,29838);

/* Mortal Strike */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12294,401,11,5,1,45,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12294,401,1,12294);
INSERT INTO  acore_world.forge_talent_prereq (`reqId`,`spellid`,`talentTabId`,`reqTalent`,`reqTalentTabId`,`reqRank`) 
VALUES (12294,12294,401,12328,401,2);

/* Strength of Arms */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (46865,401,11,7,1,45,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46865,401,1,46865);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46865,401,2,46866);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46865,401,3,1120169);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46865,401,4,1120170);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46865,401,5,1120171);

/* Improved Slam */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (12862,401,11,9,1,45,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12862,401,1,12862);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (12862,401,2,12330);

/* Row 8 */
/* Juggernaut */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (64976,401,12,3,1,50,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (64976,401,1,64976);

/* Tactician */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1120172,401,12,5,1,50,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1120172,401,1,1120172);

/* Unrelenting Assault */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (46859,401,12,7,1,50,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46859,401,1,46859);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46859,401,2,46860);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46859,401,3,1120175);


/* Row 9 */
/* Sudden Death */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (29723,401,13,3,1,50,0,3,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29723,401,1,29723);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29723,401,2,29724);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29723,401,3,29725);

/* Endless Rage */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (29623,401,13,5,1,50,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29623,401,1,29623);

/* Blood Frenzy */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (29836,401,13,7,1,50,0,2,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29836,401,1,29836);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (29836,401,2,29859);

/* Row 10 */
/* Wrecking Crew */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (46867,401,14,5,1,55,0,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46867,401,1,46867);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46867,401,2,56611);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46867,401,3,56612);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46867,401,4,56613);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46867,401,5,56614);

/* Row 11 */
/* Bladestorm */
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (46924,401,15,5,1,60,0,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (46924,401,1,46924);



