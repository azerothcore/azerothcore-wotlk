# LFG Activity Tracking

## Overview

The LFG Activity Tracking feature stores metadata about Random Dungeon Finder (RDF) events in the character database. This allows server administrators to analyze player behavior in LFG groups.

## Configuration

Enable the feature in `worldserver.conf`:

```conf
# Enable activity tracking
LFG.StoreStatistics = 1

# Enable automatic cleanup (optional)
LFG.CleanupOldActivities = 1

# Keep entries for 90 days (optional, range: 1-365)
LFG.CleanupActivitiesAfterDays = 90
```

**Defaults:**
- `LFG.StoreStatistics` = `0` (disabled)
- `LFG.CleanupOldActivities` = `0` (disabled)
- `LFG.CleanupActivitiesAfterDays` = `90` (days)

### Automatic Cleanup

When `LFG.CleanupOldActivities` is enabled, the system will automatically delete entries older than the configured number of days. The cleanup runs daily at 6:00 AM server time, alongside other maintenance tasks like guild cap resets.

**Important:** Automatic cleanup is disabled by default. You must explicitly enable it if you want old entries to be removed automatically.

## Database Schema

The feature creates a new table `lfg_activity` in the character database:

```sql
CREATE TABLE `lfg_activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `playerGuid` int unsigned NOT NULL,
  `eventType` tinyint unsigned NOT NULL,
  `dungeonId` int unsigned NOT NULL,
  `groupGuid` int unsigned DEFAULT NULL,
  `timestamp` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_player` (`playerGuid`),
  KEY `idx_timestamp` (`timestamp`),
  KEY `idx_dungeon` (`dungeonId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Event Types

| Value | Event Type    | Description                                    |
|-------|---------------|------------------------------------------------|
| 1     | Joined        | Player accepted dungeon proposal               |
| 2     | Refused       | Player refused/declined dungeon proposal       |
| 3     | Left          | Player voluntarily left the group              |
| 4     | Kicked        | Player was kicked from the group               |
| 5     | Disconnected  | Player disconnected from the group             |

## Usage Examples

### Find players who frequently refuse proposals

```sql
SELECT 
    playerGuid,
    COUNT(*) as refusal_count
FROM lfg_activity
WHERE eventType = 2
    AND timestamp > UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 7 DAY))
GROUP BY playerGuid
HAVING refusal_count > 10
ORDER BY refusal_count DESC;
```

### Analyze kick patterns for a specific dungeon

```sql
SELECT 
    FROM_UNIXTIME(timestamp) as event_time,
    playerGuid,
    dungeonId
FROM lfg_activity
WHERE eventType = 4
    AND dungeonId = 285  -- Example: Utgarde Keep
ORDER BY timestamp DESC;
```

### Track disconnect rates by player

```sql
SELECT 
    playerGuid,
    COUNT(CASE WHEN eventType = 5 THEN 1 END) as disconnects,
    COUNT(CASE WHEN eventType = 1 THEN 1 END) as joins,
    ROUND(COUNT(CASE WHEN eventType = 5 THEN 1 END) * 100.0 / 
          COUNT(CASE WHEN eventType = 1 THEN 1 END), 2) as disconnect_rate
FROM lfg_activity
WHERE eventType IN (1, 5)
GROUP BY playerGuid
HAVING joins > 5
ORDER BY disconnect_rate DESC;
```

### Daily activity summary

```sql
SELECT 
    DATE(FROM_UNIXTIME(timestamp)) as date,
    SUM(CASE WHEN eventType = 1 THEN 1 ELSE 0 END) as joins,
    SUM(CASE WHEN eventType = 2 THEN 1 ELSE 0 END) as refuses,
    SUM(CASE WHEN eventType = 3 THEN 1 ELSE 0 END) as leaves,
    SUM(CASE WHEN eventType = 4 THEN 1 ELSE 0 END) as kicks,
    SUM(CASE WHEN eventType = 5 THEN 1 ELSE 0 END) as disconnects
FROM lfg_activity
GROUP BY DATE(FROM_UNIXTIME(timestamp))
ORDER BY date DESC;
```

## Performance Considerations

- The feature is **disabled by default** to avoid performance impact
- Indexes are provided on commonly queried fields (playerGuid, timestamp, dungeonId)
- Consider archiving old data periodically to maintain performance
- For high-traffic servers, monitor table growth and consider partitioning by timestamp

## Data Retention

### Automatic Cleanup

The system provides built-in automatic cleanup functionality. Configure it in `worldserver.conf`:

```conf
# Enable automatic cleanup
LFG.CleanupOldActivities = 1

# Keep entries for 90 days
LFG.CleanupActivitiesAfterDays = 90
```

The cleanup runs automatically every day at 6:00 AM server time. The retention period can be configured from 1 to 365 days.

### Manual Cleanup

If you prefer manual cleanup or need to perform one-time cleanup operations:

```sql
-- Example: Delete records older than 90 days
DELETE FROM lfg_activity 
WHERE timestamp < UNIX_TIMESTAMP(DATE_SUB(NOW(), INTERVAL 90 DAY))
LIMIT 10000;
```

**Note:** For large tables, consider deleting in smaller batches to avoid locking issues.

## Privacy Notes

- The feature stores player GUIDs, not character names (names can be joined from `characters` table if needed)
- Data is only collected when the feature is explicitly enabled
- Server administrators should inform users if this data is being collected per their privacy policy

## Related Resources

- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/5477
- LFG System Documentation: [Link to docs if available]
