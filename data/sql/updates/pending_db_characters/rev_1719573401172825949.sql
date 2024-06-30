alter table characters add foreign key (account) references acore_auth.account (id) on delete cascade;
