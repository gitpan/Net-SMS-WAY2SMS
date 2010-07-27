use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::SMS::WAY2SMS',
    AUTHOR              => q{adarshtp <adarshtp@gmail.com>},
    VERSION_FROM        => 'lib/Net/SMS/WAY2SMS.pm',
    ABSTRACT_FROM       => 'lib/Net/SMS/WAY2SMS.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'GPL')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-SMS-WAY2SMS-*' },
);
