
class OnMapEnter: public PlayerScript
{
    public:
        OnMapEnter() : PlayerScript("OnMapEnter") {}

    void OnMapChanged(Player* player)
    {
    	if (player->GetMapId() == 0)
    	{
		player->CastSpell(player, 13007, true);
    	}
    }
};

void AddSC_OnMapEnter()
{
    new OnMapEnter();
}