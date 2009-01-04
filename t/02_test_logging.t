#!perl

use strict;
use warnings;
use Test::More tests => 4;
use FindBin ();
use lib $FindBin::Bin . '/lib';
use ReneeB::Schema;

my $error = "";
my $schema;

eval{
    my $db  = $FindBin::Bin . '/TestDB';
    $schema = ReneeB::Schema->connect( 'DBI:SQLite:' . $db );
    1;
} or $error = $@;

skip 3, 'can\'t connect to test database' if $error;

$schema->logging(1);
my ($user) = $schema->resultset( 'Test' )->search({
    id => 1,
});

ok( -e 'test.log' );

is( $user->id, 1 );

skip 2, 'can\'t create logfile' unless -e 'test.log';

my $content = do{ local (@ARGV,$/) = 'test.log'; <> };  
my $check = qq~SELECT me.id, me.username FROM myuser me WHERE ( id = ? )
'1'
~;

is($content,$check);

unlink 'test.log' or diag $!;
ok( not -e 'test.log' );