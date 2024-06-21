-- add TRIGGER flag to 'Ribbon Pole Fire Spiral Bunny'
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 128) WHERE (`entry` = 25303);
