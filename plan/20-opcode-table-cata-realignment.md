# Plan 20: opcode-table Cataclysm realignment

Canonical issue: [#41](https://github.com/trolloks/azerothcore-cata/issues/41).

Status: complete. PR #42 converted the table; the accepted real-client run in PR #50 supplied the
remaining world-entry evidence. The closure audit found all 894 shared values matched the pinned
reference, no assigned same-direction CMSG/SMSG collisions, and no runtime handler overrides.
