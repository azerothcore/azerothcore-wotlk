INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617016392531315494');

UPDATE creature_template SET InhabitType = 3 WHERE entry IN (
  3282, -- Venture Co. Mercenary
  3283, -- Venture Co. Enforcer
  3284, -- Venture Co. Drudger
  3445, -- Supervisor Lugwizzle
  5836  -- Engineer Whirleygig
);


