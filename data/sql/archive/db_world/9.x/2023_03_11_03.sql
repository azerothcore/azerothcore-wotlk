-- DB update 2023_03_11_02 -> 2023_03_11_03
-- These were switched around
UPDATE `conditions` SET `ConditionValue1`=1032, `Comment`='SOHG: Turbulent Signet only for leatherusers' WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=10058 AND `SourceEntry`=51991;
UPDATE `conditions` SET `ConditionValue1`=400, `Comment`='SOHG: Turbulent Signet only for clothusers' WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=10059 AND `SourceEntry`=51991;
