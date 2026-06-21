-- mod-branding 8.4: world-spawned discovery content (scaffold).
-- Defines the object->reward mapping table, a small representative set of discoverables authored
-- against the 8.3 tier rules (Common 1-20 / Uncommon 20-40 / Rare 40-60 / Epic 60+), their
-- gameobject templates, and one sample spawn each. This is a SCAFFOLD: a handful per tier, not the
-- full content set. Bulk authoring ("generate N <profession> discoveries for zones X-Y, Tier T")
-- extends these three tables. Entry/guid range 5000000+ is reserved for the module.

-- Mapping table: gameobject entry -> tier + reward. reward_type: 1=Recipe 2=ProfessionXp
-- 3=Reputation 4=HiddenQuest. tier: 0=Common 1=Uncommon 2=Rare 3=Epic. The adapter rejects rows
-- whose reward_type does not fit the tier (RewardFitsTier, 8.3 contract).
CREATE TABLE IF NOT EXISTS `branding_discovery_object`
(
    `object_entry` INT UNSIGNED NOT NULL COMMENT 'gameobject_template.entry that triggers the discovery',
    `tier` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0=Common 1=Uncommon 2=Rare 3=Epic (8.3)',
    `reward_type` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '1=Recipe 2=ProfessionXp 3=Reputation 4=HiddenQuest',
    `payload_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item/recipe entry, skill line, faction, or quest id (by type)',
    `payload_amount` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'item count, skill points, reputation amount, or 1 for quests',
    PRIMARY KEY (`object_entry`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'mod-branding 8.4 discovery object -> reward map';

-- Sample discoverables: two per tier, profession-flavoured per 8.4.
DELETE FROM `branding_discovery_object` WHERE `object_entry` BETWEEN 5000000 AND 5000007;
INSERT INTO `branding_discovery_object`
    (`object_entry`, `tier`, `reward_type`, `payload_id`, `payload_amount`) VALUES
    (5000000, 0, 1, 4291, 1),    -- Common: rusted dwarven hammerhead -> Silver Skeleton Key recipe (BS)
    (5000001, 0, 2, 186, 10),    -- Common: scattered mining notes -> +10 Mining (skill 186)
    (5000002, 1, 2, 171, 25),    -- Uncommon: abandoned herbal journal -> +25 Alchemy (skill 171)
    (5000003, 1, 3, 469, 250),   -- Uncommon: weathered guild ledger -> +250 rep Alliance (faction 469)
    (5000004, 2, 1, 16208, 1),   -- Rare: master smith's schematic -> Recipe: advanced item
    (5000005, 2, 3, 72, 350),    -- Rare: stormwind requisition cache -> +350 rep Stormwind (faction 72)
    (5000006, 3, 4, 60, 1),      -- Epic: arcane residue node -> hidden quest chain (quest 60)
    (5000007, 3, 4, 61, 1);      -- Epic: sealed runic codex -> hidden quest chain (quest 61)

-- Gameobject templates (type 10 = GOOBER, interactable). displayId 210 = parchment/cache model;
-- ScriptName binds the module's GameObjectScript interact hook. REPLACE INTO is used (template
-- tables are not DELETE-able per SQL standards) so re-applying the update is idempotent.
REPLACE INTO `gameobject_template`
    (`entry`, `type`, `displayId`, `name`, `size`, `Data0`, `Data1`, `ScriptName`) VALUES
    (5000000, 10, 210, 'Rusted Dwarven Hammerhead', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000001, 10, 210, 'Scattered Mining Notes', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000002, 10, 210, 'Abandoned Herbal Journal', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000003, 10, 210, 'Weathered Guild Ledger', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000004, 10, 210, 'Master Smith''s Schematic', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000005, 10, 210, 'Stormwind Requisition Cache', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000006, 10, 210, 'Arcane Residue Node', 1, 0, 0, 'BrandingDiscoverableObjectScript'),
    (5000007, 10, 210, 'Sealed Runic Codex', 1, 0, 0, 'BrandingDiscoverableObjectScript');

-- One sample spawn each, placed in tier-appropriate zones (Common: Elwynn map 0; higher tiers
-- reuse nearby coords as placeholders -- final placement is part of bulk content authoring).
DELETE FROM `gameobject` WHERE `guid` BETWEEN 5000000 AND 5000007;
INSERT INTO `gameobject`
    (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`,
     `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`,
     `animprogress`, `state`, `Comment`) VALUES
    (5000000, 5000000, 0, 1, 1, -9457.0, 47.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Common BS'),
    (5000001, 5000001, 0, 1, 1, -9460.0, 50.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Common Mining'),
    (5000002, 5000002, 0, 1, 1, -9463.0, 53.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Uncommon Alchemy'),
    (5000003, 5000003, 0, 1, 1, -9466.0, 56.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Uncommon rep'),
    (5000004, 5000004, 0, 1, 1, -9469.0, 59.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Rare recipe'),
    (5000005, 5000005, 0, 1, 1, -9472.0, 62.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Rare rep'),
    (5000006, 5000006, 0, 1, 1, -9475.0, 65.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Epic quest'),
    (5000007, 5000007, 0, 1, 1, -9478.0, 68.0, 56.0, 0, 0, 0, 0, 1, 300, 100, 1, 'mod-branding discovery: Epic quest');
