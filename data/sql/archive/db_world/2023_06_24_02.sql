-- DB update 2023_06_24_01 -> 2023_06_24_02
--
DELETE FROM `npc_trainer` WHERE `SpellID` IN (
39973, -- Frost Grenades
40274, -- Furious Gizmatic Goggles
41311, -- Justicebringer 2000 Specs
41312, -- Tankatronic Goggles
41314, -- Surestrike Goggles v2.0
41315, -- Gadgetstorm Goggles
41316, -- Living Replicator Specs
41317, -- Deathblow X11 Goggles
41318, -- Wonderheal XT40 Shades
41319, -- Magnified Moon Specs
41320, -- Destruction Holo-gogs
41321  -- Powerheal 4000 Lens
);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`, `ReqSpell`) VALUES
(201013, 39973, 50000, 202, 335, 0, 0),
(201013, 40274, 50000, 202, 350, 0, 0),
(201013, 41311, 50000, 202, 350, 0, 0),
(201013, 41312, 50000, 202, 350, 0, 0),
(201013, 41314, 50000, 202, 350, 0, 0),
(201013, 41315, 50000, 202, 350, 0, 0),
(201013, 41316, 50000, 202, 350, 0, 0),
(201013, 41317, 50000, 202, 350, 0, 0),
(201013, 41318, 50000, 202, 350, 0, 0),
(201013, 41319, 50000, 202, 350, 0, 0),
(201013, 41320, 50000, 202, 350, 0, 0);
