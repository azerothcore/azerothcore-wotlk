
-- Assisting Arch Druid Staghelm (3789), Remove duplicate quest start
DELETE FROM creature_queststarter WHERE id=5111 AND quest=3763;
