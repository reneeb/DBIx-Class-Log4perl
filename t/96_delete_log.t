#!/usr/bin/perl

use strict;
use warnings;
use File::Spec;
use FindBin;
use Test::More tests => 1;

my $log = File::Spec->rel2abs( 
    File::Spec->catfile( $FindBin::Bin, 'test.log' )
);

unlink $log;

ok( ! -e $log );