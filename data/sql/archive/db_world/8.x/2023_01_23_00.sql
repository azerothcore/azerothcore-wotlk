-- DB update 2023_01_22_00 -> 2023_01_23_00
--
DELETE FROM `quest_template_locale` WHERE `locale`='zhCN' AND `ID`= 3121;
INSERT INTO `quest_template_locale` (`ID`, `locale`, `Title`, `Details`, `Objectives`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`) VALUES
(3121, 'zhCN', '奇怪的要求', '在莫沙彻营地北边拉瑞斯小亭的夏拉什·火刃有我所需要的东西！他调配出了一种混合物，我需要用它来……好吧，你以后会知道的。$B$B快点出发，快点出发，去找夏拉什。拿着这个东西，这是一颗皱缩的徽记，我答应夏拉什用此来交换草药。这是某个可怜侏儒的徽记，我在森林里撞见了他，然后就……我敢说夏拉什会很高兴得到这个东西的。$B$B你可以在菲拉斯里找到夏拉什。', '将皱缩的头颅交给菲拉斯的夏拉什·火刃。', '', '', '', '', '', '', 0);
