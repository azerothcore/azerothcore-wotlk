-- DB update 2026_08_11_06 -> 2026_08_11_07
--
-- The Heart of the Mountain is interactable regardless of the vault event
-- (wowhead comments); physical access is already gated by the Secret Door,
-- so drop the GO_FLAG_INTERACT_COND from its template addon.
UPDATE `gameobject_template_addon` SET `flags` = 0 WHERE `entry` = 165554;
