use DBI;

my $dsn = 'dbi:mysql:database=sqitch';
my $user = 'root';
my $pass = '';

my $dbh = DBI->connect($dsn, $user, $pass, {
    PrintError           => 0,
    RaiseError           => 1,
    AutoCommit           => 1,
    mysql_enable_utf8    => 1,
    mysql_auto_reconnect => 0,
    mysql_use_result     => 1,
});

$dbh->begin_work;
$dbh->do('LOCK TABLES changes WRITE');
$dbh->rollback;
