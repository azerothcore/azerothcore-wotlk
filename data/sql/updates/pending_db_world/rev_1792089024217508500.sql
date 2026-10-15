-- Borrowed Time (buff): chain the ranks so spell_proc -59887 covers all of them
DELETE FROM `spell_ranks` WHERE `spell_id` IN (59887, 59888, 59889, 59890, 59891);
INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES
(59887, 59887, 1),
(59887, 59888, 2),
(59887, 59889, 3),
(59887, 59890, 4),
(59887, 59891, 5);
