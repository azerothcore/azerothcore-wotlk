-- DB update 2025_04_09_00 -> 2025_04_10_00
-- Changes the required skill from Blacksmithing (164) to Alchemy (171) to drop for the Items Recipe: Elixir of Empowerment (35294) and Recipe: Haste Potion (35295) for the LootReference (35008)
UPDATE `conditions` SET `ConditionValue1` = 171 WHERE `SourceTypeOrReferenceId` = 10 AND `SourceGroup` = 35008 AND `ConditionTypeOrReference` = 7 AND `ConditionValue1` = 164 AND `SourceEntry` = 35294 OR `SourceEntry` = 35295;
