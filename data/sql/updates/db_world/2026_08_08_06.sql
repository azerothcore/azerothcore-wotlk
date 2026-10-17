-- DB update 2026_08_08_05 -> 2026_08_08_06
-- Remove pool_template rows that have no members in pool_creature,
-- pool_gameobject, pool_quest or pool_pool. They date back to the original
-- DB import, spawn nothing and are referenced by nothing.
-- Pool 4508 ('Minerals - Rolands Doom - Duskwood') additionally sat as the
-- only pool_pool child of 11650 ('Solid Chests, Azshara', 2 of 10 active):
-- whenever the mother rolled it, a chest slot was consumed spawning nothing.
DELETE FROM `pool_pool` WHERE `pool_id` = 4508;
DELETE FROM `pool_template` WHERE `entry` IN
(896, 2021, 2024, 2025, 2027, 2028, 2030, 3122, 3123, 3124, 3125, 3126, 3127,
3128, 3129, 3154, 3161, 3210, 3310, 3410, 3413, 3418, 3444, 3463, 3477, 3479,
3481, 3491, 3609, 3991, 4001, 4333, 4334, 4337, 4486, 4489, 4490, 4495, 4498,
4507, 4508, 4630, 4644, 4653, 4671, 4763, 4769, 4934, 4991, 5122, 5679, 5680,
5681, 5682, 5683, 5684, 5685, 5686, 5687, 5688, 5689, 5690, 9900, 9901, 9902,
9904, 9905, 9906, 9907, 9908, 11212, 11642, 11676, 11677);
