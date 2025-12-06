local blockedWords = {
   "[.]com", "[.]br", "[.]ml", "bit[.]ly", "servegame", "zapto", "wow", "pontocom", "pontobr",
   "[.] com", "[.] br", "[.] ml", "bit[.] ly", "bit [.]ly",
   "c o m", "[.] b r", "[.]b r", "[.] m l", "[.]m l", "b i t",  "s e r v e g a m e", "z a p t o", "w o w",
   "c  o  m", "b  r", "m  l", "b  i  t", "s  e  r  v  e  g  a  m  e", "z  a  p  t  o", "w  o  w"
}

local function antiPublishing (event, player, msg)
   string.lower(msg)
   for i,v in ipairs(blockedWords) do
       if (string.find(msg, v) ~= nil) then
           player:SendBroadcastMessage("Você não pode divulgar outros sites/servidores aqui.")
           return false
       end
   end
end
RegisterPlayerEvent(18, antiPublishing)
RegisterPlayerEvent(19, antiPublishing)
RegisterPlayerEvent(20, antiPublishing)
RegisterPlayerEvent(21, antiPublishing)
RegisterPlayerEvent(22, antiPublishing)