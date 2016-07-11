SET
	@entry := 1000001;

delete from npc_vendor where entry = @entry and item = 47241;
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, VerifiedBuild)
VALUES (@entry, 0, 47241, '0', '0', '2425', '0');

SET
	@entry := 1000002;

DELETE FROM npc_vendor WHERE entry = @entry and item in (34649, 34651, 34656, 34648, 34650, 34659, 34655, 34652);
-- Hand
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34649, 2707, 12340);
-- Waist
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34651, 2707, 12340);
-- Legs
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34656, 2707, 12340);
-- Feet
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34648, 2707, 12340);
-- Chest
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34650, 2707, 12340);
-- Back
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34659, 2707, 12340);
-- Shoulder
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34655, 2707, 12340);
-- Head
INSERT INTO npc_vendor (entry, slot, item, ExtendedCost, VerifiedBuild) 
VALUES (@entry, 0, 34652, 2707, 12340);
