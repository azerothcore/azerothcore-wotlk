"""Seed Plan 18 acceptance through the existing disposable-client harness."""
import argparse
import importlib.util
import json
from pathlib import Path
import struct
import sys

repo = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('runner', repo / 'apps/cata/run_real_client_authentication.py')
r = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = r
spec.loader.exec_module(r)
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('manifest', type=Path, help='prepared isolated client-run manifest')
manifest_path = parser.parse_args().manifest.resolve()
m = r.load_manifest(manifest_path)
g = r.active_generation(m)
if g['state'] not in {'prepared', 'inconclusive'} or g['mode'] != r.IN_WORLD_CONTROL_MODE:
    raise RuntimeError('Requires a prepared in-world-control generation')
r.assert_container_owned(m, g)
characters = g['schemas']['characters']
world = g['schemas']['world']

# Verify the normal periodic-aura -> persistent-area-spell path in the actual server DBC.
b = (Path(g['paths']['data']) / 'dbc/Spell.dbc').read_bytes()
magic, count, fields, size, _ = struct.unpack_from('<4s4I', b)
assert (magic, fields, size) == (b'WDBC', 234, 936)
spells = {row[0]: row for row in struct.iter_unpack('<234I', b[20:20 + count * size])}
aura, flame = spells[50247], spells[50249]
assert (aura[71], aura[95], aura[98], aura[116]) == (6, 23, 330, 50249)
assert (flame[71], flame[95], flame[131]) == (27, 4, 11030)
item_templates = r.mysql(m, g,
    'SELECT entry,ContainerSlots,MaxDurability FROM item_template WHERE entry IN (25,117,4496) ORDER BY entry;', world)
assert item_templates.splitlines() == ['25\t0\t20', '117\t0\t0', '4496\t6\t0'], item_templates
assert r.mysql(m, g, 'SELECT type,displayId FROM gameobject_template WHERE entry=2843;', world) == '3\t259'

migration = (repo / 'data/sql/updates/pending_db_characters/rev_1788937529456601782.sql').read_text()
old = ' '.join(str(i) for i in range(1, 37)) + ' '
converted = (
    ' '.join(str(i) for i in range(1, 22)) + ' ' + '0 ' * 9
    + ' '.join(str(i) for i in range(22, 37)) + ' '
)
# Temporary shadow table exists only for this one mysql connection in our owned schema.
query = 'CREATE TEMPORARY TABLE item_instance (guid INT PRIMARY KEY, enchantments TEXT NOT NULL);'
cases = [old, converted, '', '1 2 3 ', old.rstrip()]
query += 'INSERT INTO item_instance VALUES ' + ','.join(f"({i},'{value}')" for i, value in enumerate(cases)) + ';'
query += migration + 'SELECT guid,HEX(enchantments) FROM item_instance ORDER BY guid;'
query += migration + 'SELECT guid,HEX(enchantments) FROM item_instance ORDER BY guid;'
rows = r.mysql(m, g, query, characters).splitlines()
expected = [
    f'{i}\t{value.encode().hex().upper()}'
    for i, value in enumerate([converted, converted, '', '1 2 3 ', converted])
]
assert rows == expected * 2, 'Migration changed a modern/partial row or was not idempotent'

owner = r.CHARACTER_GUID
corpse_owner = owner + 1
bag, food, sword = 900001, 900002, 900003
x, y, z = r.CHARACTER_POSITION
# A separate offline character owns the visible corpse, so logging in does not reclaim it.
body_seed = r.populated_character_seed_sql().replace(str(owner), str(corpse_owner))
body_seed = body_seed.replace(str(r.ACCOUNT_ID), str(r.ACCOUNT_ID + 1)).replace(r.CHARACTER_NAME, 'Planbody')
r.mysql(m, g, body_seed, characters)
q = f'DELETE FROM character_inventory WHERE guid={owner};'
q += f'DELETE FROM item_instance WHERE guid IN ({bag},{food},{sword});'
q += 'INSERT INTO item_instance (guid,itemEntry,owner_guid,count,durability,charges,enchantments) VALUES '
q += ','.join(f"({guid},{entry},{owner},{quantity},{durability},'0 0 0 0 0 ','{'0 ' * 36}')"
    for guid, entry, quantity, durability in [(bag,4496,1,0),(food,117,2,0),(sword,25,1,13)]) + ';'
q += 'INSERT INTO character_inventory (guid,bag,slot,item) VALUES '
q += f'({owner},0,19,{bag}),({owner},{bag},0,{food}),({owner},{bag},1,{sword});'
q += migration
q += f'DELETE FROM corpse WHERE guid={corpse_owner};'
q += ('INSERT INTO corpse '
    '(guid,posX,posY,posZ,orientation,mapId,displayId,itemCache,bytes1,guildId,flags,time,corpseType) ')
q += f"VALUES ({corpse_owner},{x+3},{y+2},{z},1.5,0,49,'{'0 ' * 19}',256,123,4,UNIX_TIMESTAMP(),1);"
q += f'DELETE FROM character_aura WHERE guid={owner} AND spell=50247;'
q += 'INSERT INTO character_aura (guid,casterGuid,spell,effectMask,recalculateMask,stackCount,maxDuration,remainTime) '
# The loaded tick counter derives from remaining time; a full duration exhausts the trigger budget.
q += f'VALUES ({owner},{owner},50247,1,0,1,900000,450000);'
q += f'UPDATE characters SET logout_time=UNIX_TIMESTAMP() WHERE guid={owner};'
r.mysql(m, g, q, characters)
r.mysql(m, g,
    'DELETE FROM gameobject WHERE guid=9000000 AND id=2843;'
    'INSERT INTO gameobject (guid,id,map,position_x,position_y,position_z,rotation3,spawntimesecs,animprogress,state) '
    f'VALUES (9000000,2843,0,{x+3},{y-2},{z},1,300,255,1);', world)
assert r.character_row_count(m, g) == 1
assert r.mysql(m, g,
    f'SELECT COUNT(*) FROM item_instance WHERE owner_guid={owner} '
    "AND LENGTH(TRIM(enchantments))-LENGTH(REPLACE(TRIM(enchantments),' ',''))=44;", characters) == '3'
# Existing log path records the ordinary aura trigger; it adds no server test hook.
p = Path(g['paths']['world_config'])
p.write_text(p.read_text() + '\nLogger.spells.aura = 5,Server\n')
interface = Path(g['paths']['client']) / 'Interface'
r.require_owned_path(interface.parent, g)
if interface.is_symlink():
    interface.unlink()  # Detach only our overlay link; never write into the protected client.
interface.mkdir(exist_ok=True)
r.require_owned_path(interface, g)
addon = interface / 'AddOns/Plan18Evidence'
addon.mkdir(parents=True, exist_ok=True)
(addon / 'Plan18Evidence.toc').write_text('## Interface: 40300\n## Title: Plan 18 evidence\nPlan18Evidence.lua\n')
(addon / 'Plan18Evidence.lua').write_text('''local frame = CreateFrame("Frame", nil, UIParent)
frame:SetSize(500, 50)
frame:SetPoint("TOPLEFT", 20, -130)
local text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
text:SetAllPoints()
text:SetJustifyH("LEFT")
local elapsed = 0
local opened = false
frame:SetScript("OnUpdate", function(self, dt)
  elapsed = elapsed + dt
  if elapsed < 0.5 then return end
  elapsed = 0
  local _, count = GetContainerItemInfo(1, 1)
  local bag = GetContainerNumSlots(1)
  local food = GetContainerItemID(1, 1)
  local sword = GetContainerItemID(1, 2)
  local current, maximum = GetContainerItemDurability(1, 2)
  local pass = bag == 6 and food == 117 and count == 2 and sword == 25 and current == 13 and maximum == 20
  if pass and not opened then OpenAllBags(); opened = true end
  text:SetText((pass and "PLAN 18 INVENTORY PASS" or "PLAN 18 INVENTORY WAIT") ..
    "\\nSlots " .. tostring(bag) .. ", item " .. tostring(food) .. " x" .. tostring(count) ..
    ", durability " .. tostring(current) .. "/" .. tostring(maximum))
end)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function() OpenAllBags() end)
''')
result = {'generation': g['number'], 'migration_idempotent': True, 'legacy_words': 36, 'cata_words': 45,
    'bag_entry': 4496, 'bag_slots': 6, 'item_entries': [117, 25], 'durability': [13, 20],
    'gameobject_entry': 2843, 'corpse_owner': corpse_owner, 'corpse_display': 49,
    'aura': 50247, 'ground_spell': 50249, 'ground_visual': 11030}
(Path(g['paths']['raw_evidence']).parent / 'plan18-fixture.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result))
