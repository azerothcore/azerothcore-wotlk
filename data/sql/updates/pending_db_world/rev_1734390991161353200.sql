--
-- Removes "While Charmed" flag from Frayfeather Stagwing and Frayfeather Skystormer
UPDATE `smart_scripts` SET `event_flags` = 0 WHERE `entryorguid` in (5304, 5305) AND `source_type` = 0;;
