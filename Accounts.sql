create table Accounts (
	Number INTEGER PRIMARY KEY,
	Balance DECIMAL(5,2),
	AcctOwner INTEGER
);
insert into Accounts (Number, Balance, AcctOwner) values (632642, 483.93, 1);
insert into Accounts (Number, Balance, AcctOwner) values (440673, 318.27, 2);
insert into Accounts (Number, Balance, AcctOwner) values (205385, 296.09, 3);
insert into Accounts (Number, Balance, AcctOwner) values (647151, 413.69, 4);
insert into Accounts (Number, Balance, AcctOwner) values (853350, 485.19, 5);
insert into Accounts (Number, Balance, AcctOwner) values (120284, 397.18, 6);
insert into Accounts (Number, Balance, AcctOwner) values (707345, 163.26, 7);
insert into Accounts (Number, Balance, AcctOwner) values (948680, 257.44, 8);
insert into Accounts (Number, Balance, AcctOwner) values (214420, 105.86, 9);
insert into Accounts (Number, Balance, AcctOwner) values (137593, 11.11, 10);
insert into Accounts (Number, Balance, AcctOwner) values (145409, 249.46, 11);

SELECT * FROM Accounts; -- 397.18, 11.11 > 297.18, 11.11