use 5.006;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'MVCimple',
    VERSION           => '.99', # finds $VERSION
    LICENSE           => 'LGPL-3.0',
    PREREQ_PM         => {
        'Data::Dumper'   => 0,
        'XML::Simple'   => 0,
        'XML::Dumper'   => 0,
        'CGI'   => 0,
        'DBI'   => 0
    }, # e.g., Module::Name => 1.1
);
