local npcid = 500011
function morph_gossip(unit, player, creature)
   if (player:IsInCombat()~=true) then
   --player:GossipMenuAddItem(0, "|TInterface\\icons\\Spell_ChargePositive:30:30:-15:0|t Buffs|r", 0, 1)
   player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_holy_layonhands:30:30:-15:0|t Me cure|r", 0, 2)
   player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_shadow_deathscream:30:30:-15:0|t Remover Sickness|r", 0, 3)
   player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_bg_trueavshutout:30:30:-15:0|t Resetar Combate|r", 0, 4)
   player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_holy_borrowedtime:30:30:-15:0|t Resetar Cooldown|r", 0, 5)
   --player:GossipMenuAddItem(0, "|TInterface\\icons\\ability_marksmanship:30:30:-15:0|t Resetar Talentos|r", 0, 6, false, "Tem certeza de que deseja Resetar seus Pontos de Talento?")
   --player:GossipMenuAddItem(0, "|TInterface\\icons\\Spell_Shadow_UnstableAffliction_1:30:30:-15:0|t Resetar Instâncias|r", 0, 7, false, "Tem certeza de que deseja descinvular-se de todas as instâncias?")
   player:GossipMenuAddItem(0, "|TInterface\\icons\\Ability_Repair:30:30:-15:0|t Reparar Itens|r", 0, 8)
   player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_reputation_01:30:30:-15:0|t Deixa pra lá...|r", 0, 999)
   player:GossipSendMenu(1, creature)
   elseif player:IsInCombat() == true then
   			player:SendAreaTriggerMessage("|TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t |cffffff00 Não é possível usar este serviço em Combate! |TInterface\\Buttons\\UI-GroupLoot-Pass-Up:14:14:0:0|t")
   end
end

function morph_select(event, player, creature, sender, intid)
   if (intid == 1) then -- Buffs
      player:AddAura(48162, player)
player:AddAura(48074, player)
player:AddAura(48170, player)
--player:AddAura(43223, player)
player:AddAura(36880, player)
player:AddAura(467, player)
--player:AddAura(26035, player)
--player:AddAura(69559, player)
--player:AddAura(53758, player)
--player:AddAura(24425, player)
--player:AddAura(30562, player)
--player:AddAura(35076, player)
--player:AddAura(26393, player) elunes blessing
--player:AddAura(30567, player) 
--player:AddAura(30557, player)
--player:AddAura(23735, player)
--player:AddAura(23736, player)
--player:AddAura(23737, player)
--player:AddAura(23738, player)
--player:AddAura(23766, player)
--player:AddAura(23767, player)
--player:AddAura(23768, player)
--player:AddAura(23769, player)
--player:AddAura(35874, player)
--player:AddAura(35912, player)
--player:AddAura(38734, player)
--player:AddAura(30567, player)
       player:GossipComplete()
   end
 
   if (intid == 2) then -- Heal
       player:SetHealth(player:GetMaxHealth())
       player:SetPower(player:GetMaxPower(0), 0)
       player:GossipComplete()
   end
 
   if (intid == 3) then -- Remove Sickness
       player:RemoveAura(15007)
       player:GossipComplete()
   end
   
   if (intid == 4) then -- Reset Combat
       player:ClearInCombat()
       player:GossipComplete()
   end
   
   if (intid == 5) then -- Reset Cooldown
       player:ResetAllCooldowns()
       player:GossipComplete()
   end
   
   if (intid == 6) then -- Reset Talents
       player:ResetTalents(true)
       player:GossipComplete()
   end
   
   if (intid == 7) then -- Reset Instances
       player:UnbindAllInstances()
       player:GossipComplete()
   end
   
   if (intid == 8) then -- Repair Itens
       player:DurabilityRepairAll(false)
       player:GossipComplete()
   end
 
   if (intid == 999) then -- Nevermind
       player:GossipComplete()
   end
end

RegisterCreatureGossipEvent(npcid, 1, morph_gossip)
RegisterCreatureGossipEvent(npcid, 2, morph_select)