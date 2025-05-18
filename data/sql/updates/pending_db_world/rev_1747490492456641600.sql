-- Sets the SAI Link to 0 from 1 for Ziggurat Defender (has only 1 cast, nothing to link to)
UPDATE `smart_scripts` SET `link` = 0 WHERE (`source_type` = 0 AND `entryorguid` = 26202 AND `id` = 0);
