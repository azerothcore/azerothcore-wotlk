-- DB update 2025_06_08_01 -> 2025_06_08_02
UPDATE `antidos_opcode_policies` SET `MaxAllowedCount` = 1000 WHERE `Opcode` IN (564, 565);
