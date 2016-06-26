
-- Cleaning WRONG SAI Data
UPDATE smart_scripts SET target_type=1 WHERE target_type IN(0,8) AND action_type=41; -- set correct target for Force Despawn

-- Correct Wrong Linking in SAI
-- select * from smart_scripts AS ss where ss.event_type=61 and ss.id not in(select link from smart_scripts AS bss where bss.entryorguid=ss.entryorguid)
-- select * from smart_scripts AS ss where ss.event_type<>61 and ss.id in(select link from smart_scripts AS bss where bss.entryorguid=ss.entryorguid and bss.link > 0)
-- select * from creature_template where ainame not like '%Smart%' AND entry in(select distinct entryorguid from smart_scripts where source_type=0)
-- select * from smart_scripts WHERE id=link;
-- ZOMG SAME LINK ID=LINK


-- Range event npcs
-- Generic retardness fix, wont break anything but will fix maaany npcs (probably around 200)
-- On every update phase_mask is reduced by 1 and most of casting and other events requires phase_mask 1 which is set by entering combat
-- We set event_phase_mask = 2 for this event because second phase addition is made on burning out of mana, so this event should be run on phase 2 (phase reduction if enaugh mana was restored)
UPDATE smart_scripts SET event_phase_mask=2 WHERE source_type=0 AND event_type=3 AND event_phase_mask=0 AND action_type=23 AND action_param2=1;
