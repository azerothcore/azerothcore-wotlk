DELETE FROM acore_world.forge_talent_tabs WHERE id = 1980000;
DELETE FROM acore_world.forge_talents WHERE talentTabId = 1980000;
DELETE FROM acore_world.forge_talent_ranks WHERE talentTabId = 1980000;
DELETE FROM acore_world.forge_talent_prereq WHERE talentTabId = 1980000;
DELETE FROM acore_world.forge_talent_unlearn WHERE talentTabId = 1980000;
DELETE FROM acore_world.forge_talent_exclusive WHERE talentTabId = 1980000;

INSERT INTO acore_world.forge_talent_tabs (`id`,`classMask`,`raceMask`,`name`,`spellIcon`,`background`,`tabType`,`TabIndex`)
 VALUES (1980000,2047,32767,'Prestige',56902,'Interface\\AddOns\\ForgedWoW\\UI\\prestige',3, 0);


 -- Mob Exp
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900000,1980000,4,5,3,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,1,1900000);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,2,1900001);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,3,1900002);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,4,1900003);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,5,1900004);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,6,1900005);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,7,1900006);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,8,1900007);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,9,1900008);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900000,1980000,10,1900009);

 -- Mob Exp
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900010,1980000,4,8,3,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,1,1900010);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,2,1900011);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,3,1900012);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,4,1900013);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,5,1900014);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,6,1900015);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,7,1900016);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,8,1900017);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,9,1900018);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900010,1980000,10,1900019);

 -- Hearthstone
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900020,1980000,4,2,1,1,3,6,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,1,1900020);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,2,1900021);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,3,1900022);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,4,1900023);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,5,1900024);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900020,1980000,6,1900025);

-- Teleport to dalaran
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900027,1980000,16,8,20,1,3,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900027,1980000,1,1900027);

 -- Movement Speed
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900030,1980000,7,8,1,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,1,1900030);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,2,1900031);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,3,1900032);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,4,1900033);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,5,1900034);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,6,1900035);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,7,1900036);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,8,1900037);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,9,1900038);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900030,1980000,10,1900039);

 -- CD Reduction
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900040,1980000,10,8,5,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,1,1900040);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,2,1900041);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,3,1900042);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,4,1900043);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,5,1900044);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,6,1900045);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,7,1900046);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,8,1900047);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,9,1900048);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900040,1980000,10,1900049);

 -- Mount Speed
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900050,1980000,7,2,1,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,1,1900050);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,2,1900051);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,3,1900052);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,4,1900053);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,5,1900054);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,6,1900055);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,7,1900056);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,8,1900057);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,9,1900058);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900050,1980000,10,1900059);


 -- Recovery
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900060,1980000,10,2,3,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,1,1900060);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,2,1900061);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,3,1900062);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,4,1900063);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,5,1900064);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,6,1900065);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,7,1900066);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,8,1900067);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,9,1900068);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900060,1980000,10,1900069);

 -- crit
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900070,1980000,13,8,5,1,3,5,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900070,1980000,1,1900070);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900070,1980000,2,1900061);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900070,1980000,3,1900062);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900070,1980000,4,1900063);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900070,1980000,5,1900064);

 -- Additional kill for quests
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900075,1980000,13,5,10,1,3,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900075,1980000,1,1900075);

 -- Cheat Death
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900076,1980000,16,2,10,1,3,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900076,1980000,1,1900076);

 -- Max Quest Exp
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900028,1980000,16,5,20,1,3,1,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900028,1980000,1,1900028);


 -- Gasoline
INSERT INTO acore_world.forge_talents (`spellid`,`talentTabId`,`columnIndex`,`rowIndex`,`rankCost`,`minLevel`,`talentType`,`numberRanks`,`preReqType`) 
 VALUES (1900077,1980000,7,5,5,1,3,10,0);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,1,1900077);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,2,1900078);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,3,1900079);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,4,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,5,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,6,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,7,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,8,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,9,1900080);
INSERT INTO acore_world.forge_talent_ranks (`talentSpellId`,`talentTabId`,`rank`,`spellId`) 
VALUES (1900077,1980000,10,1900080);
