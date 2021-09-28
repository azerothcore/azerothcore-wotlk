INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632860884559995600');


DELETE FROM `creature` WHERE `id`=11373;
UPDATE `creature_template` SET `ScriptName`='npc_razzashi_cobra_venoxis' WHERE entry=11373;
UPDATE `creature_template` SET `AIName`='' WHERE entry=11373;
