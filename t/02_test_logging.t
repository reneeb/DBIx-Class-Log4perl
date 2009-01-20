#!perl

use strict;
use warnings;
use Test::More tests => 6;
use FindBin ();
use File::Temp ();
use File::Spec;
use lib $FindBin::Bin . '/lib';
#use ReneeB::Schema;

my $error        = "";
my $logfile      = File::Spec->rel2abs( 
                        File::Spec->catfile( $FindBin::Bin, 'test.log' ) 
);
my $config       = create_conf( $logfile );
my $global_error = 1;

empty_logfile( $logfile );

{
    my $schema;
    eval{
        require ReneeB::Schema;
        my $db  = $FindBin::Bin . '/TestDB';
        $schema = ReneeB::Schema->connect( 'DBI:SQLite:' . $db );
        1;
    } or $error = $@;
    
    SKIP:{
        skip 'can\'t create config file', 5       unless $config;
        skip 'can\'t connect to test database', 5 if $error;
        
        $schema->logging(1);
        my ($user) = $schema->resultset( 'Test' )->search({
            id => 1,
        });
        
        ok( -e $logfile );
        
        is( $user->id, 1 );
        
        skip 'can\'t create logfile', 2 unless -e $logfile;
        
        my $content = do{ local (@ARGV,$/) = $logfile; <> };  
        my $check = qq~SELECT me.id, me.username FROM myuser me WHERE ( id = ? )\n'1'\n~;
        
        is($content,$check);
        $global_error = 0;
    }
}

SKIP: {
    skip "test not run", 2 if $global_error;
    empty_logfile( $logfile );
    ok( ! -s $logfile );
        
    unlink $config or diag "$config ($!)";
    ok( ! -e $config );
}

sub empty_logfile {
    my ($file) = @_;;
    open my $fh, '>', $file;
    close $fh;
    
    unlink $file;
}

sub create_conf {
    my ($logfile) = @_;
    
    my $new_conf  = File::Spec->rel2abs( File::Spec->catfile( $FindBin::Bin, 'test2.conf' ) );
    my $old_conf  = File::Spec->rel2abs( File::Spec->catfile( $FindBin::Bin, 'test.conf' ) );
    
    my $content  = do{ local (@ARGV,$/) = $old_conf; <> };
    $content =~ s/test\.log/$logfile/;
    
    if( open my $fh, '>', $new_conf ){
        print {$fh} $content;
    }
    
    ok( -e $new_conf, 'created ' . $new_conf );
    my $return = (-e $new_conf) ? $new_conf : undef;
    $return;
}