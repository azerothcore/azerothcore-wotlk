-- Remove link to non-existing entry from SAI 17671
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 17671 AND `source_type` = 0 AND `id` = 0;
