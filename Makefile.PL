use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DBIx::Class::Log4perl',
    AUTHOR              => 'Renee Baecker <module@renee-baecker.de>',
    VERSION_FROM        => 'lib/DBIx/Class/Log4perl.pm',
    ABSTRACT_FROM       => 'lib/DBIx/Class/Log4perl.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Log::Log4perl' => 0,
        'DBIx::Class' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DBIx::Class::Log4perl-*' },
);
