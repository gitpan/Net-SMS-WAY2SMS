package Net::SMS::WAY2SMS;
use Exporter;
use AutoLoader;
@ISA = qw(Exporter AutoLoader);

use strict;
use warnings;
use WWW::Mechanize;
use Compress::Zlib;
use Carp qw( croak );
our $VERSION = '0.07';

__END__

=head1 NAME

Net::SMS::WAY2SMS - Send SMS to any mobile phones in India using way2sms.com

=head1 VERSION

Version 0.07

=cut




=head1 SYNOPSIS

Perl module to send sms using way2sms for any mobile/s in India

Usage:

 	use Net::SMS::WAY2SMS;
 
 	my $s = Net::SMS::WAY2SMS->new(
 		'user' => 'xyz' ,
 		'password' => 'xyzpassword',
 		'mob'=>['12343567890', '1111111111']
 	);
 
 	$s->send('Hello World');

=head2 new

Creates a new instance

	Args:
		'user' [required]
		'password' [required]
		'mob' [array reference of mobile numbers] - [required]
=cut


=head2 getMob

Returns the mobile number of the instance

=cut


=head2 send

Send the data to way2sms.com

=cut


=head1 WEBSITE

You can find information about WAY2SMS at :

   http://www.way2sms.com/

=head1 REQUIRES

=over 4

=item *

WWW::Mechanize;
Compress::Zlib;

=back

=head1 AUTHOR

adarshtp, C<< <adarshtp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-net-sms-way2sms at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Net-SMS-WAY2SMS>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::SMS::WAY2SMS


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Net-SMS-WAY2SMS>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Net-SMS-WAY2SMS>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Net-SMS-WAY2SMS>

=item * Search CPAN

L<http://search.cpan.org/dist/Net-SMS-WAY2SMS/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 adarshtp.

This program is released under the following license: GPL


=cut
