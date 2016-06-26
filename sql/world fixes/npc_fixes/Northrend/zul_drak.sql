
-- Zul'drak Sentinel (32447)
UPDATE creature_template SET mindmg=304, maxdmg=436, attackpower=600 WHERE entry=32447;

-- Horrified Drakkari Warrior (26582)
-- Horrified Drakkari Shaman (26583)
UPDATE creature_template SET flags_extra=flags_extra|64 WHERE entry IN(26582, 26583);

-- Jin'Alai Warrior (28388)
UPDATE creature SET equipment_id=1, curhealth=11001 WHERE id=28388;
