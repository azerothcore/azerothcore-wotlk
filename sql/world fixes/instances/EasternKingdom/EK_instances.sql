-- Remove Arlokk event_script entry
DELETE FROM event_scripts WHERE id=9066;

-- Karazhan, fix nightbane
UPDATE gameobject_template SET ScriptName="go_blackened_urn" WHERE entry=194092;
UPDATE creature_template SET unit_flags=0 WHERE entry=17225;
DELETE FROM gameobject WHERE id=194092;
INSERT INTO gameobject VALUES(NULL, 194092, 532, 1, 1, -11107.77, -1879.43, 91.47, 0, 0, 0, 0.931636, -0.363393, 300, 0, 1, 0);

-- Ahn'Quiraj - C'Thun, fix rep
REPLACE INTO creature_onkill_reputation VALUES(15727, 910, 609, 7, 0, 2500, 7, 0, 1000, 0);
