# remove approved accounts from banlist

-- deprecated
DELETE FROM account_banned WHERE banreason = "New user waiting for approvement" AND active = 0;

DELETE FROM account_banned WHERE banreason = "Failed login autoban" AND active = 0;

