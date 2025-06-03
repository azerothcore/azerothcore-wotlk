
-- Remove Wrong Auras
UPDATE `creature_addon` SET `auras` = NULL WHERE (`guid` IN (129492, 129496, 129497, 129498, 129499));
