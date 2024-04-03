-- add npc text locale
DELETE FROM `npc_text_locale` WHERE (`ID`=50016) AND (`locale`='zhCN');
INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`, `Text1_0`, `Text1_1`, `Text2_0`, `Text2_1`, `Text3_0`, `Text3_1`, `Text4_0`, `Text4_1`, `Text5_0`, `Text5_1`, `Text6_0`, `Text6_1`, `Text7_0`, `Text7_1`) VALUES (50016, 'zhCN', '$c，你好。通常我应该在巡逻，保卫暴风城的人民。但现在许多暴风城的卫兵都在其他地区作战。所以我来了这里，代表他们来保卫边疆，虽然我更希望自己在巡逻……', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
