--
UPDATE `creature_model_info` SET `DisplayID_Other_Gender` = 0 WHERE `DisplayID` IN (18254, 18255, 18256, 18257);
UPDATE `gameobject` SET `phaseMask` = 2 WHERE `guid` IN (100343, 100342, 100341);