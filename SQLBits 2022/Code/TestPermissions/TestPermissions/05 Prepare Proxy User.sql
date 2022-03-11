use Test_Logins;


create user LimitedPermission WITHOUT LOGIN;

grant select on PublicTable to LimitedPermission;
grant select on Drop1 to LimitedPermission;