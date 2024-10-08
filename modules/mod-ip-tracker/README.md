# mod-ip-tracker

## Description

Storing all IPs from all accounts and their login times in `account_ip`.


## Requirements

mod-ip-tracker requires:

- AzerothCore v3.0.0+


## Installation

```
1) Simply `git clone` the module under the `modules` directory of your AzerothCore source or copy paste it manually.
2) Import the `auth/base/account_ip.sql` SQL file manually to the `acore_auth` database
3) Re-run cmake and launch a clean build of AzerothCore
4) Configure `ip-tracker.conf`
```

## Usage

Get by name: select all IPs of a given account name `ACCOUNT_NAME`

```sql
SELECT account.username, account_ip.* FROM account 
INNER JOIN account_ip ON account.id = account_ip.account
WHERE account.username = 'ACCOUNT_NAME';
```

Wording: given 2 accounts, they are **linked** if they accessed the same IP at some point of time.

Level 1: select all accounts/IPs linked to a given account ID `123`

```sql
SELECT account.username, account_ip.* FROM account_ip 
INNER JOIN account ON account.id = account_ip.account
WHERE ip IN (
    SELECT ip FROM account_ip WHERE account = 123
);
```

Level 2: select all accounts/IPs linked to all accounts linked to a given account ID `123`

```sql
SELECT account.username, account_ip.* FROM account_ip INNER JOIN account ON account.id = account_ip.account
WHERE ip IN (
	SELECT ip FROM account_ip WHERE account IN (
		SELECT account FROM account_ip WHERE ip IN (
			SELECT ip FROM account_ip WHERE account = 123
		)
	)
);
```

You can build up more levels from here, see:

- https://stackoverflow.com/questions/66723604/get-all-accounts-linked-to-a-certain-account-via-ip
