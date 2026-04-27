#!/usr/bin/env python3
"""One-off: emit 2026_04_28_00_dk_ranks.sql for custom DK low ranks."""
import re
import os

def load_cols(path):
    cols = []
    with open(path) as f:
        for line in f:
            m = re.match(r"  `([^`]+)`", line)
            if m:
                cols.append(m.group(1))
    return cols


def scale_expr(c, fac, sl, cols):
    """MySQL expression for one column, template alias `p`."""
    if c == "ID":
        return None  # set per row
    if c == "BaseLevel":
        return str(int(sl))
    if c == "SpellLevel":
        return str(int(sl))
    if c == "MaxLevel":
        return "p.`MaxLevel`"
    if c.startswith("EffectBasePoints_"):
        return (
            "(CASE WHEN p.`" + c + "` = 0 THEN 0 "
            "WHEN p.`" + c + "` < 0 THEN -FLOOR(ABS(p.`" + c + "`) * "
            f"{fac}) ELSE FLOOR(p.`{c}` * {fac}) END)"
        )
    if c.startswith("EffectRealPointsPerLevel_"):
        return f"(p.`{c}` * {fac})"
    if c in cols:
        return f"p.`{c}`"
    return f"p.`{c}`"


def main():
    base = "data/sql/base/db_world/spell_dbc.sql"
    cols = load_cols(base)
    if len(cols) < 200:
        raise SystemExit("bad col parse")

    factors = [0.2, 0.4, 0.6, 0.8]
    spell_levels = [1, 4, 8, 12]

    chains = [
        (45477, 900200, "Icy Touch"),
        (45462, 900204, "Plague Strike"),
        (47541, 900208, "Death Coil"),
    ]

    out = []
    out.append("-- BlackroseWoW: DK low-rank rebalance (see DK Rank Rebalance Plan).")
    out.append("-- Rechains: 900200->Icy(45477+), 900204->Plague(45462+), 900208->DC(47541+).")
    out.append("-- C++: Player.cpp SPELL_PLAGUE_STRIKE_RANK1=900204, firstInChain DC=900208.")
    out.append("")
    out.append("DELETE FROM `spell_bonus_data` WHERE `entry` BETWEEN 900200 AND 900211;")
    out.append("DELETE FROM `spell_dbc` WHERE `ID` BETWEEN 900200 AND 900211;")
    out.append("")

    for parent, first_id, _name in chains:
        for i in range(4):
            new_id = first_id + i
            fac = factors[i]
            sl = spell_levels[i]
            sel = [f"  {new_id} AS `ID`,"]
            for c in cols[1:]:  # skip ID
                ex = scale_expr(c, fac, sl, cols)
                sel.append(f"  {ex} AS `{c}`,")
            # trim last comma
            sel[-1] = sel[-1].rstrip(",")
            out.append(
                f"INSERT INTO `spell_dbc` ({', '.join('`' + c + '`' for c in cols)})\n"
                f"SELECT\n" + "\n".join(sel) + f"\nFROM `spell_dbc` p WHERE p.`ID` = {parent};\n"
            )
            out.append("")

    out.append("DELETE FROM `spell_ranks` WHERE `first_spell_id` IN (45477,45462,47541) OR `first_spell_id` IN (900200,900204,900208);")
    out.append("")

    icy = [(900200 + i, i + 1) for i in range(4)]
    icy += [(45477, 5), (49896, 6), (49903, 7), (49904, 8), (49909, 9)]
    for sid, r in icy:
        out.append(f"INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES (900200, {sid}, {r});")

    out.append("")
    plg = [(900204 + i, i + 1) for i in range(4)]
    plg += [
        (45462, 5), (49917, 6), (49918, 7), (49919, 8), (49920, 9), (49921, 10)
    ]
    for sid, r in plg:
        out.append(
            f"INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES (900204, {sid}, {r});"
        )

    out.append("")
    dc = [(900208 + i, i + 1) for i in range(4)]
    dc += [(47541, 5), (49892, 6), (49893, 7), (49894, 8), (49895, 9)]
    for sid, r in dc:
        out.append(
            f"INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES (900208, {sid}, {r});"
        )

    out.append("")
    out.append("INSERT INTO `spell_bonus_data` (`entry`, `direct_bonus`, `dot_bonus`, `ap_bonus`, `ap_dot_bonus`, `comments`) VALUES")
    bonus = []
    for i in range(4):
        ap = round(0.1 * factors[i], 3)
        bonus.append(
            f"({900200 + i}, 0, 0, {ap}, 0, 'Custom DK Icy low rank {i+1}')"
        )
    out.append(",\n".join(bonus) + ";")
    out.append("")

    # Remove trainer rows we will replace
    out.append("DELETE FROM `trainer_spell` WHERE `TrainerId` = 13 AND `SpellId` IN (")
    out.append("45462, 45477, 47541,")
    out.append("900200, 900201, 900202, 900203, 900204, 900205, 900206, 900207,")
    out.append("900208, 900209, 900210, 900211,")
    out.append("49896, 49903, 49904, 49909,")
    out.append("49917, 49918, 49919, 49920, 49921,")
    out.append("49892, 49893, 49894, 49895")
    out.append(");")
    out.append("")

    # (SpellId, Money, ReqAbility1, ReqLevel)
    trows = [
        (900200, 10, 0, 1),
        (900201, 200, 900200, 4),
        (900202, 1000, 900201, 8),
        (900203, 4000, 900202, 12),
        (45477, 8000, 900203, 20),
        (900204, 5, 0, 1),
        (900205, 50, 900204, 4),
        (900206, 200, 900205, 8),
        (900207, 1000, 900206, 12),
        (45462, 5000, 900207, 16),
        (900208, 20, 0, 1),
        (900209, 150, 900208, 4),
        (900210, 800, 900209, 8),
        (900211, 3000, 900210, 12),
        (47541, 10000, 900211, 20),
        (49896, 61000, 45477, 30),
        (49903, 8000, 49896, 36),
        (49904, 12000, 49903, 40),
        (49909, 20000, 49904, 44),
        (49917, 5800, 45462, 56),
        (49918, 12000, 49917, 60),
        (49919, 20000, 49918, 64),
        (49920, 50000, 49919, 70),
        (49921, 200000, 49920, 80),
        (49892, 59000, 47541, 58),
        (49893, 68000, 49892, 64),
        (49894, 360000, 49893, 72),
        (49895, 360000, 49894, 80),
    ]
    tlines = [
        f"(13, {a}, {b}, 0, 0, {c}, 0, 0, {d}, 0)" for a, b, c, d in trows
    ]
    out.append(
        "INSERT INTO `trainer_spell` "
        "(`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, "
        "`ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES\n"
        + ",\n".join(tlines) + ";\n"
    )
    out.append("UPDATE `playercreateinfo_action` SET `action` = 900204 WHERE `class` = 6 AND `action` = 45462;")

    dest = "data/sql/updates/db_world/2026_04_28_00.sql"
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    with open(dest, "w") as f:
        f.write("\n".join(out))
    print("Wrote", dest, "lines", len(out))


if __name__ == "__main__":
    main()
