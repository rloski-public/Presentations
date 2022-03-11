use master;

create login testSysadmin with password = N'T3s$t1200GH@#&*', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
create login [testLimited] with password = N'T3s$t1200GH@#&*', DEFAULT_DATABASE=[Test_Logins], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
create login [testDBOwner] with password = N'T3s$t1200GH@#&*', DEFAULT_DATABASE=[Test_Logins], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
create login [testNone] with password = N'T3s$t1200GH@#&*', DEFAULT_DATABASE=[Test_Logins], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;


