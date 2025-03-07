-- XOR PrevQuestID that was 499 Elixir of Suffering
UPDATE quest_template_addon SET PrevQuestID = PrevQuestID ^ PrevQuestID WHERE ID = 501;
