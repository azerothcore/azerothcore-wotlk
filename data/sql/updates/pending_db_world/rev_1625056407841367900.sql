INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625056407841367900');

use acore_world;

-- CREATE
SET @CURRENT_GLOBAL_SQL_MODE = @@GLOBAL.sql_mode;
SET @CURRENT_SESSION_SQL_MODE = @@SESSION.sql_mode;
SET @NO_SQL_MODE = '';

SET @@GLOBAL.sql_mode = @NO_SQL_MODE;
SET @@SESSION.sql_mode = @NO_SQL_MODE;

DELIMITER $$
CREATE PROCEDURE IDENTIFY_DUPLICATED_NPC()

BEGIN

    CREATE TABLE DUPLICATED_NPC
    (
        DELETABLE_GUID int unsigned,
        EVENT_ENTRY    tinyint
    );


    insert into DUPLICATED_NPC
    select guid, eventEntry
    from (
             select count(crt.guid), gec.guid, gec.eventEntry
             from creature crt
                      inner join game_event_creature gec on gec.guid = crt.guid
             group by position_x, position_y, ROUND(position_z - 0.1, 2) or ROUND(position_z + 0.1, 2), map,
                      gec.eventEntry
             having count(*) > 1) dupes;

    delete from creature where guid in (select DELETABLE_GUID from DUPLICATED_NPC);
    select ROW_COUNT() into @DELETED_CREATURES;

    delete
    from game_event_creature
    where guid in (select DELETABLE_GUID FROM DUPLICATED_NPC);
    select ROW_COUNT() into @DELETED_CREATURES_FROM_EVENT;

    SELECT CONCAT('Deleted creatures: ', @DELETED_CREATURES, ' and game_event_creatures',
                  @DELETED_CREATURES_FROM_EVENT);

END$$
DELIMITER ;

-- RUN
call IDENTIFY_DUPLICATED_NPC(); #fixme: this takes ~1.5m to delete 486 records from creature and 486 from game_event_creature

-- CLEANUP
drop procedure IDENTIFY_DUPLICATED_NPC;
drop table DUPLICATED_NPC;

-- ROLLBACK
SET @@GLOBAL.sql_mode = @CURRENT_GLOBAL_SQL_MODE;
SET @@SESSION.sql_mode = @CURRENT_SESSION_SQL_MODE;