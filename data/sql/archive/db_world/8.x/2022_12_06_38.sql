-- DB update 2022_12_06_37 -> 2022_12_06_38
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=30 AND `SourceEntry` IN (24753,22943);
INSERT INTO `conditions` VALUES
(30,0,24753,0,0,33,0,1,2,0,0,0,0,'','Pint-Sized Pink Pachyderm visible only if target is in party with its owner'),
(30,0,24753,0,1,10,0,2,0,0,0,0,0,'','Pint-Sized Pink Pachyderm visible only if target is drunk'),

(30,0,22943,0,0,33,0,1,2,0,0,0,0,'','Pint-Sized Pink Pachyderm visible only if target is in party with its owner'),
(30,0,22943,0,1,10,0,2,0,0,0,0,0,'','Pint-Sized Pink Pachyderm visible only if target is drunk');
