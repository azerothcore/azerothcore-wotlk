-- DB update 2022_09_25_02 -> 2022_09_25_03
-- Alter AzerothCore table to support Vanilla negative resistance values
ALTER TABLE item_template MODIFY fire_res SMALLINT;
ALTER TABLE item_template MODIFY holy_res SMALLINT;
ALTER TABLE item_template MODIFY nature_res SMALLINT;
ALTER TABLE item_template MODIFY frost_res SMALLINT;
ALTER TABLE item_template MODIFY shadow_res SMALLINT;
ALTER TABLE item_template MODIFY arcane_res SMALLINT;
