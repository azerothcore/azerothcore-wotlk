
class player_script : public PlayerScript

{

    public:

        player_script() : PlayerScript("player_script") {}

        

        void OnPVPKill(Player *killer, Player *victim)

	{

              if (killer->GetMapId() == 47)

                    killer->AddItem(40752, 1);

        }

};


void AddSC_player_script()

{

    new player_script();

}
