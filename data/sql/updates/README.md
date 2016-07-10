All files contained in this folders **must not be re-applicable**!


For this purpose we're versioning it using this format:



**File name**: yyyy_mm_dd_XX.sql    

yyyy -> year
mm -> month
dd -> day
XX -> an incremental number if an sql with same date already exists, by default: 00

**SQL Header ( the first query ):**

The following is an example of the query that must be present in first row of every sql updates ( This example is specifically for auth database:)

ALTER TABLE auth_db_version 
CHANGE COLUMN 2016_07_09_01 
2016_07_10_00 bit;

Of course the rule is:

CHANGE COLUMN 2016_07_09_01   <- the previous version

2016_07_10_00 bit <-- the next version
