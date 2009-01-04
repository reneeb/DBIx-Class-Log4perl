package ReneeB::Schema::Test;
    
use strict;
use warnings;
use base qw(DBIx::Class);

__PACKAGE__->load_components( qw/PK::Auto Core/ );
__PACKAGE__->table( 'myuser' );
__PACKAGE__->add_columns( qw/
    id
    username
/);
__PACKAGE__->set_primary_key( qw/ id / );

1;
