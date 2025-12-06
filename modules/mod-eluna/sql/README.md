# BEST PRACTICES

## Create a new table

**Example:**
```
CREATE TABLE IF NOT EXISTS `table`(
  `id` int(11) unsigned NOT NULL,
  `active` BOOLEAN DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

**Boolean datatype in mysql:**
Use "TinyInt(1)"" or "Boolean" (this is the same thing)

"bit(1)" can also work, but it may require a syntax like b'(0) and b'(1) when inserting (not sure).

If there are multiple booleans in the same table, bit(1) is better, otherwise it's the same result.


## Resources

https://www.w3schools.com/sql/sql_datatypes.asp
