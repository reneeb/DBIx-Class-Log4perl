#!perl -T

use Test::More tests => 3;

BEGIN {
	use_ok( 'DBIx::Class::Log4perl' );
}

my $error;
eval{
    DBIx::Class::Log4perl->logger_conf();
    1;
} or $error = $@;

like( $error, qr/no config file given/, 'no config file' );

$error = "";
eval{
    DBIx::Class::Log4perl->logger_conf( 'reneeb_asdfsdfsdfasdfasdf.conf');
    1;
} or $error = $@;

like( $error, qr/no config file given/, 'non existant config file' );