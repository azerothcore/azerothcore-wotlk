# AzerothShard Development standards

AzerothShard follows an **open development model**, we share with the Open Source project all our blizzlike fixes.

So if you have a blizzlike fix for AzerothShard, try to merge it into Open Source project too. In this way your code helps the global development and can be reviewed by many more developers, and **everyone gains**.

Following guidelines describe how to handle all of the custom code.
With **custom**, we mean all stuff we need that **can't** be merged into the Open Source project (for any reason).

## Custom Commits

- Every commit that introduces custom changes should be labelled with the **[AZTH]** tag in its commit name
- Try to [squash commits](https://ariejan.net/2011/07/05/git-squash-your-latests-commits-into-one/) when they are all about the same thing

## Custom Code

With **custom code** we mean all code that is not currently part of the Open Source project. Example of custom code can be custom features, hackfixes or even blizzlike fixes that for some reasons are not yet merged into the Open Source project.

All custom code must be surrounded by ```// [AZTH]```  and ```// [/AZTH]``` tags, specifying the name of the author. Example:

```
// [AZTH] AuthorName,RevisorName.. :
// motivation/usage/comment

// custom code

// [/AZTH]
```

## Custom SQL files

### Directory structure

All custom SQL files are placed under **/azerothshard/data/sql** folder

Subdivided in 3 folders, one for each database:

- db-world
- db-characters
- db-auth

there is also a "tool" folder that contains various usefull sql to use occasionally

### File names

Every SQL file must be named using the following format: azth_*database*_*description*.sql

Example: **azth_world_queue_announcer.sql**

For structure SQL files the *description* should be the *table name*.

### SQL code format

Every SQL file must be **re-executable**. That means that you have to ```DELETE``` before ```INSERT```, and ```DROP TABLE``` before ```CREATE TABLE IF NOT EXIST```.

In order to ensure that your SQL code is re-executable, try to **run it twice before committing it**.

