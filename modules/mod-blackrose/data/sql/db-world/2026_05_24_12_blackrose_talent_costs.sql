-- ============================================================================
-- Black Rose: talent cost tuning.
--
-- Dual specialization cost is stored in gossip_menu_option.BoxMoney. Set it to
-- 50 gold while preserving the existing trainer gossip flow.
-- ============================================================================

UPDATE `gossip_menu_option` SET `BoxMoney` = 500000 WHERE `OptionType` = 18;
