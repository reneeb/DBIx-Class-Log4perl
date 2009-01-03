#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'DBIx::Class::Log4perl' );
}

diag( "Testing DBIx::Class::Log4perl $DBIx::Class::Log4perl::VERSION, Perl $], $^X" );
