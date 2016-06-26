
-- Cenarion Hold Infantry (15184)
DELETE FROM creature_text WHERE entry=15184;
INSERT INTO creature_text VALUES (15184, 0, 0, 'Taste blade, mongrel!', 12, 0, 100, 0, 0, 0, 0, 'SAY_GUARD_SIL_AGGRO1');
INSERT INTO creature_text VALUES (15184, 0, 1, 'Please tell me that you didn''t just do what I think you just did. Please tell me that I''m not going to have to hurt you...', 12, 0, 100, 0, 0, 0, 0, 'SAY_GUARD_SIL_AGGRO2');
INSERT INTO creature_text VALUES (15184, 0, 2, 'As if we don''t have enough problems, you go and create more!', 12, 0, 100, 0, 0, 0, 0, 'SAY_GUARD_SIL_AGGRO3');
INSERT INTO creature_text VALUES (15184, 0, 3, 'You dare spill blood on neutral ground? OUT! OUT, I SAY!', 12, 0, 100, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro');
INSERT INTO creature_text VALUES (15184, 0, 4, 'We don''t take kindly to miscreants, $r.', 12, 0, 100, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro');
INSERT INTO creature_text VALUES (15184, 0, 5, 'Get a rope!', 12, 0, 100, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro');
INSERT INTO creature_text VALUES (15184, 0, 6, 'Believe me when I tell you this: You''re gonna wish you weren''t born, sissy!', 12, 0, 100, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro');
INSERT INTO creature_text VALUES (15184, 0, 7, 'Your actions shame us all, $c. I hurt inside as I beat you senseless.', 12, 0, 100, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=15184;
DELETE FROM smart_scripts WHERE entryorguid=15184 AND source_type=0;
INSERT INTO smart_scripts VALUES (15184, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Reset - Cast Invisibility and Stealth Detection');
INSERT INTO smart_scripts VALUES (15184, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro - Say Line 0');
INSERT INTO smart_scripts VALUES (15184, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 149, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Death - Send Zone Under Attack');
INSERT INTO smart_scripts VALUES (15184, 0, 3, 0, 0, 0, 100, 0, 3000, 7000, 6000, 12000, 11, 30223, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - In Combat - Cast Cleave');
INSERT INTO smart_scripts VALUES (15184, 0, 4, 0, 14, 0, 100, 0, 10000, 10000, 0, 0, 11, 27620, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - Victim Casting - Cast Snap Kick');
