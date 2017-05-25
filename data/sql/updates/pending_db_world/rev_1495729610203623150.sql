INSERT INTO version_db_world (`sql_rev`) VALUES ('1495729610203623150');


-- Bael'Gar's Fiery Essence requires Bael'Gar's Corpse, borrowed from TrinityCore/sql/old/3.3.5a/world/61_2016_10_17/2016_08_23_00_world.sql
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN(17) AND `SourceEntry`=13982;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17,0,13982,0,0,29,0,9016,10,1,0,0,0,'',"Spell 'Bael'Gar's Fiery Essence' requires Bael'Gar's corpse");


