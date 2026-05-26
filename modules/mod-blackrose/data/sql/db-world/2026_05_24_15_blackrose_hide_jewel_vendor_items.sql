-- ============================================================================
-- Black Rose: hide incomplete Jewel vendor items.
--
-- Jewel items and Rosy's Jewel Stick remain defined for future testing, but are
-- removed from Rosy's vendor list for the production-ready patch. Re-add these
-- vendor rows when Jewel effects are implemented.
-- ============================================================================

SET @ROSY := 900140;
SET @JEWEL_GEM_BASE := 901000;
SET @JEWEL_STICK := 901302;

DELETE FROM `npc_vendor`
WHERE `entry` = @ROSY
  AND `item` IN (
      @JEWEL_STICK,
      @JEWEL_GEM_BASE + 0,
      @JEWEL_GEM_BASE + 10,
      @JEWEL_GEM_BASE + 20,
      @JEWEL_GEM_BASE + 30,
      @JEWEL_GEM_BASE + 40,
      @JEWEL_GEM_BASE + 50,
      @JEWEL_GEM_BASE + 60,
      @JEWEL_GEM_BASE + 70,
      @JEWEL_GEM_BASE + 80,
      @JEWEL_GEM_BASE + 90
  );

DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 23
  AND `SourceGroup` = @ROSY
  AND `SourceEntry` IN (
      @JEWEL_STICK,
      @JEWEL_GEM_BASE + 0,
      @JEWEL_GEM_BASE + 10,
      @JEWEL_GEM_BASE + 20,
      @JEWEL_GEM_BASE + 30,
      @JEWEL_GEM_BASE + 40,
      @JEWEL_GEM_BASE + 50,
      @JEWEL_GEM_BASE + 60,
      @JEWEL_GEM_BASE + 70,
      @JEWEL_GEM_BASE + 80,
      @JEWEL_GEM_BASE + 90
  );
