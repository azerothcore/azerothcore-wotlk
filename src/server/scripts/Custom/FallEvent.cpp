//made by Highlord

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ObjectMgr.h"
#include "UnitAI.h"
#include "GameObjectAI.h"
#include "Map.h"
#include "Random.h"

bool endevent;
#define MSG_START "Приветствую. Для запуска Ивента нажмите старт!"

class Eventstarter : public CreatureScript
{
public:
	Eventstarter() : CreatureScript("Eventstarter") { }

	struct EventstarterAI : public ScriptedAI
	{
		EventstarterAI(Creature* creature) : ScriptedAI(creature) {}

		void UpdateAI(uint32 diff) override
		{
			if (endevent)
			{
				me->SetPhaseMask(1, 1);
				me->PlayDirectMusic(0);
			}
				
		}

	};

	bool OnGossipHello(Player* player, Creature* npc)
	{
        if (player->GetSession()->GetSecurity() >= SEC_MODERATOR)
        {
            AddGossipItemFor(player, 0, "Запустить Ивент!!!", GOSSIP_SENDER_MAIN, 1);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, npc);
            return true;
        }
        else
        {
            ChatHandler handler(player->GetSession());
            handler.PSendSysMessage("Доступно только Администрации!");
            return true;
        }
	}

	bool OnGossipSelect(Player* player, Creature* npc, uint32 sender, uint32 uiAction)
	{
		if (!player)
			return false;
	

		switch (uiAction)
			case 1:
		{
			endevent = false;

            npc->Yell("Ивент начался! Платформы исчезают каждые 7 секунд, посмотрим кто из вас останется! Желаю удачи!", LANG_UNIVERSAL, NULL);
			npc->PlayDistanceSound(16037);
			npc->PlayDirectMusic(17289);  //17346
			npc->SetPhaseMask(2, 1);
  


			int FallObjectGuid[16]{ 166151, 166139, 166147, 166135, 166128, 166103, 166101, 166129, 166096, 166093, 166074, 166160, 166163, 166065, 166081, 166098 };

			int RandomData[16];

			GameObject* FallObjects[16];

			for (int i = 0; i < 16; i++)
			{
				RandomData[i] = irand(0, 15);
				

				for (int j = 0; j < 16; j++)
				{

					if (RandomData[i] == RandomData[j] && i != j)
					{
						i--;
					}

				}

			}

			for (int i = 0; i < 15; i++)
			{
				FallObjects[i] = ChatHandler(player->GetSession()).GetObjectFromPlayerMapByDbGuid(FallObjectGuid[RandomData[i]]);
				FallObjects[i]->AI()->SetData(1, i + 1);
				FallObjects[i]->AI()->SetData(1, 16);
			}

		}

		return true;
	}

	CreatureAI* GetAI(Creature* creature) const override
	{
		return new EventstarterAI(creature);
	}


};

uint32 timer = 8000;

class FallObject : public GameObjectScript
{

public:
	FallObject() : GameObjectScript("FallObject") {}

	
	struct FallObjectAI : public GameObjectAI
	{
		
		FallObjectAI(GameObject* go) : GameObjectAI(go) {}


		void SetData(uint32 type, uint32 data) override
		{
			

			if (type == 1 && data == 1)
				Events.ScheduleEvent(1, 5000);

			for (int i = 2; i < 16; i++)
			{

				if (type == 1 && data == i)
				{
					if (i == 2)
						timer = 10000;
					else
						timer += 7000;
					Events.ScheduleEvent(1, timer);
				}
			}
			
            if (type == 1 && data == 16)
				Events.ScheduleEvent(2, 120000);
		}

		void UpdateAI(uint32 diff) override
		{
			Events.Update(diff);

			while (uint32 eventId = Events.ExecuteEvent())
			{
				switch (eventId)
				{
					case 1:
					{
                        me->PlayDistanceSound(17442);
						me->SetPhaseMask(2, 1);
						break;
					}
					case 2:
					{
						me->SetPhaseMask(1, 1);
						endevent = true;
						break;
					}
				}
			}
		}


	private:
		EventMap Events;

	};


	GameObjectAI* GetAI(GameObject* go) const override
	{
		return new FallObjectAI(go);
	}

};



void AddSC_FallEvent()
{
	new Eventstarter();
	new FallObject();
}
