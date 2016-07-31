SET
	@entry := 1000001;

DELETE FROM npc_vendor WHERE entry = @entry AND item = 47241;
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost)
VALUES (@entry, 0, 47241, '0', '0', '2425');

SET
	@entry := 1000002;

DELETE FROM npc_vendor WHERE entry = @entry AND item IN (34649, 34651, 34656, 34648, 34650, 34659, 34655, 34652);
-- Hand
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34649, 2707);
-- Waist
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34651, 2707);
-- Legs
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34656, 2707);
-- Feet
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34648, 2707);
-- Chest
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34650, 2707);
-- Back
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34659, 2707);
-- Shoulder
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34655, 2707);
-- Head
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost) 
VALUES (@entry, 0, 34652, 2707);
