DROP table if exists acore_characters.`character_perk_selection_queue`;
CREATE TABLE acore_characters.`character_perk_selection_queue` (
  `guid` int NOT NULL,
  `specId` int NOT NULL,
  `type` int not null default 0,
  `rollkey` varchar(100) not null,
  `spellId` mediumint NOT NULL,
  CONSTRAINT `pk_unique` PRIMARY KEY ( `guid`, `specId`, `rollkey`, `spellId`),
  index ( `guid`, `specId`, `spellId`, `rollkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

DROP table if exists acore_characters.`character_spec_perks`;
CREATE TABLE acore_characters.`character_spec_perks` (
  `guid` int NOT NULL,
  `specId` int NOT NULL,  
  `type` int not null default 0,
  `uuid` varchar(100) NOT NULL,
  `spellId` mediumint NOT NULL,
  `rank` int NOT NULL DEFAULT 1,
  CONSTRAINT `pk_unique` PRIMARY KEY (`guid`, `specId`, `spellId`),
  index ( `guid`, `specId`, `spellId` )
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

DROP table if exists acore_characters.`character_perk_roll_history`;
CREATE TABLE acore_characters.`character_perk_roll_history` (
  `accountId` int NOT NULL,
  `guid` int NOT NULL,
  `uuid` varchar(100) NOT NULL,
  `specId` int NOT NULL,
  `spellId` mediumint NOT NULL,
  `level` int NOT NULL DEFAULT 0,
  `carryover` int DEFAULT 0,
  PRIMARY KEY (`accountId`,`guid`,`uuid`,`specId`,`spellId`),
  index (`accountId`,`guid`,`uuid`,`specId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

DROP table if exists acore_characters.`character_prestige_perk_carryover`;
CREATE TABLE acore_characters.`character_prestige_perk_carryover` (
  `guid` int NOT NULL,
  `specId` int NOT NULL,
  `type` int not null default 0,
  `uuid` varchar(100) NOT NULL,
  `spellId` mediumint NOT NULL,
  `rank` int not null default 1,
  PRIMARY KEY (`guid`,`specId`,`uuid`,`spellId`, `rank`),
  index (`guid`,`specId`,`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;