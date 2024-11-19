-- DB update 2023_01_03_02 -> 2023_01_03_03
DELETE FROM `battleground_template` WHERE `ID`=7;
INSERT INTO `battleground_template` (`ID`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`, `StartMaxDist`, `Weight`, `ScriptName`, `Comment`) VALUES 
(7, 8, 15, 61, 80, 1103, 3.03123, 1104, 0.055761, 10, 1, '', 'Eye of The Storm (battleground)');
