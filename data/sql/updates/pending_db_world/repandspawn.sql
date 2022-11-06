-- lots of Reputation changes
UPDATE `creature_onkill_reputation` SET `RewOnKillRepFaction1`=87, `RewOnKillRepFaction2`=21, `MaxStanding1`=5, `IsTeamAward1`=0, `RewOnKillRepValue1`=5, `MaxStanding2`=7, `IsTeamAward2`=1, `RewOnKillRepValue2`=-25, `TeamDependent`=0 WHERE `creature_id`=26081;
--Spawn to 8 hours
UPDATE `creature` SET `spawntimesecs`=28800 WHERE `guid`=1975960 AND `id1`=26081;
