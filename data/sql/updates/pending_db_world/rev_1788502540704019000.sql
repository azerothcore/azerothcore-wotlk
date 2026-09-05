-- Storm Tempered Keepers in Dun Niffelem must assist both members of each pair and evade together.
UPDATE `creature_formations` SET `groupAI` = 7 WHERE (`leaderGUID`, `memberGUID`) IN
    ((136763, 136763), (136764, 136764), (136765, 136765), (136766, 136766),
    (136763, 136783), (136764, 136784), (136765, 136785), (136766, 136786));
