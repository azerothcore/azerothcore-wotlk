



-- Update values
-- Itemset ID 1007
-- all values up by 10% from T10,5
update item_template set itemset = 1007 where entry in (81030, 81031, 81032, 81033, 81034);
update item_template set stat_value1 = (stat_value1 * 1.1) where entry in (81030, 81031, 81032, 81033, 81034);
update item_template set armor = (armor * 1.1) where entry in (81030, 81031, 81032, 81033, 81034);