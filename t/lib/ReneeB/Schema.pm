package ReneeB::Schema;

use strict;
use warnings;
use DBIx::Class::Log4perl;
use FindBin ();
use base qw/DBIx::Class::Schema/;

__PACKAGE__->logger_conf( $FindBin::Bin . '/test.conf' );
__PACKAGE__->load_classes( 'Test' );

1;