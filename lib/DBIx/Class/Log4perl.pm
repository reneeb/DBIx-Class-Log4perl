package DBIx::Class::Log4perl;

use warnings;
use strict;
use Carp;
use DBIx::Class::Storage::Statistics;
use Exporter;
use Log::Log4perl;

our @ISA = qw(Exporter DBIx::Class::Storage::Statistics);
our @EXPORT = qw(logger_conf logging);

our $VERSION = '0.01';

my $obj;

sub logger_conf {
    my ($class,$filename) = @_;
    
    croak "no config file given" unless $filename and -e $filename;
    
    $obj = __PACKAGE__->new;
    $obj->_logger( $filename );
}

sub query_start {
    my ($self,$sql,@params) = @_;
    
    $self->_logger->debug( $sql );
    $self->_logger->debug( join "\n", @params );
}

sub logging{
    my ($self,$value) = @_;
    
    if( $value ){
        $self->storage->debugobj( $obj );
        $self->storage->debug(1);
    }
    else{
        $self->storage->debug(0);
    }
}

sub _logger {
    my ($self,$filename) = @_;
    
    if( @_ == 2 ){
        Log::Log4perl->init( $filename );
        $self->{__logger} = Log::Log4perl->get_logger;
    }
    
    $self->{__logger};
}

1;

__END__

=head1 NAME

DBIx::Class::Log4perl - Logging for DBIx::Class via Log::Log4perl

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 logger_conf

=head2 query_start

=head1 AUTHOR

Renee Baecker, C<< <module at renee-baecker.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-dbix::class::log4perl at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DBIx::Class::Log4perl>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DBIx::Class::Log4perl

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DBIx::Class::Log4perl>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DBIx::Class::Log4perl>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DBIx::Class::Log4perl>

=item * Search CPAN

L<http://search.cpan.org/dist/DBIx::Class::Log4perl/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Renee Baecker, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
