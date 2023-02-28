-- DB update 2022_11_21_18 -> 2022_11_21_19
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`
 | 1            -- MECHANIC_CHARM  
 | 2            -- MECHANIC_DISORIENTED    
 | 4            -- MECHANIC_DISARM         
 | 8            -- MECHANIC_DISTRACT       
 | 16           -- MECHANIC_FEAR  
 | 32           -- MECHANIC_GRIP
 | 64           -- MECHANIC_ROOT  
 -- | 128          -- MECHANIC_PACIFY
 | 256          -- MECHANIC_SILENCE      
 | 512          -- MECHANIC_SLEEP        
 | 1024         -- MECHANIC_SNARE       
 | 2048         -- MECHANIC_STUN        
 | 4096         -- MECHANIC_FREEZE      
 | 8192         -- MECHANIC_KNOCKOUT
 -- | 16384        -- MECHANIC_BLEED    
 | 32768        -- MECHANIC_BANDAGE
 | 65536        -- MECHANIC_POLYMORPH  
 | 131072       -- MECHANIC_BANISH    
 -- | 262144       -- MECHANIC_SHIELD  
 | 524288       -- MECHANIC_SHACKLE
 | 1048576      -- MECHANIC_MOUNT
 -- | 2097152      -- MECHANIC_INFECTED
 | 4194304      -- MECHANIC_TURN
 | 8388608      -- MECHANIC_HORROR
 -- | 16777216     -- MECHANIC_INVULNERABILITY
 | 33554432     -- MECHANIC_INTERRUPT       
 | 67108864     -- MECHANIC_DAZE    
 -- | 134217728    -- MECHANIC_DISCOVERY
 -- | 268435456    -- MECHANIC_IMMUNE_SHIELD
 | 536870912    -- MECHANIC_SAPPED         
 -- | 1073741824   -- MECHANIC_ENRAGED 
WHERE `entry` IN (18503,20309);
