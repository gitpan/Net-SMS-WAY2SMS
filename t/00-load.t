#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Net::SMS::WAY2SMS' ) || print "Bail out!
";
}

diag( "Testing Net::SMS::WAY2SMS $Net::SMS::WAY2SMS::VERSION, Perl $], $^X" );
