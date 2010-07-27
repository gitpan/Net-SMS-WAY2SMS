package Net::SMS::WAY2SMS;

use strict;
use warnings;
use WWW::Mechanize;
use Compress::Zlib;
use Carp qw( croak );

=head1 NAME

Net::SMS::WAY2SMS - The great new Net::SMS::WAY2SMS!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


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

sub new
{
        my $class = shift;
        my %args = @_;
        my $self = {};
		croak 'Username, password and mobile number are mandatory' if(!$args{'user'} || !$args{'password'} || !$args{'mob'});
		$self->{'user'} = $args{'user'};
		$self->{'password'} = $args{'password'};
        $self->{'mob'} = ref $args{'mob'} eq 'ARRAY' ? $args{'mob'} : [$args{'mob'}];
		$self->{'debug'} = $args{'debug'} || 0;
        bless $self, $class;
        return $self;
}

=head2 getMob

Returns the mobile number of the instance

=cut

sub getMob
{
        return @{$_[0]->{'mob'}};
}

=head2 send

send the data to way2sms.com

=cut

sub send
{
        my ($self, $msg) = @_;
        my @mobs = $self->getMob();
        return croak "mobile numbers and sms text are missing" unless scalar @mobs || $msg;

		print length($msg)."\n" if($self->{'debug'});
		$msg = $msg."\n\n\n\n\n" if(length($msg) < 135);
		my $mech = WWW::Mechanize->new();
		$mech->get("http://wwwl.way2sms.com/content/index.html");
		unless($mech->success())
		{
			die 'unable to login to way2sms';
		}
		my $dest = $mech->response->content;
		my $header = $mech->response->header("Content-Encoding");
		print "Fetching...\n" if($self->{'debug'});
		$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
		$dest =~ s/<form name="loginForm"/<form action='..\/auth.cl' name="loginForm"/ig;
		$mech->update_html($dest);
		$mech->form_with_fields(("username","password"));
		$mech->field("username", $self->{'user'});
		$mech->field("password", $self->{'password'});
		print "Loggin...\n" if($self->{'debug'});
		$mech->submit_form();
		$dest= $mech->response->content;
		$header = $mech->response->header("Content-Encoding");
		$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
		$mech->get("http://wwwl.way2sms.com/jsp/InstantSMS.jsp?val=0");
		$dest= $mech->response->content;
		$header = $mech->response->header("Content-Encoding");
		$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
		print "Sending ... \n" if($self->{'debug'});
		my $isLoggedIn = $mech->form_with_fields(("MobNo","textArea"));
		die 'Unable to login... Please check your credentials' unless $isLoggedIn;
		foreach my $mob (@mobs)
        {
			if($mob !~ /^\d+$/)
			{
				print "Error: Mobile numbers must be integers..." if($self->{'debug'});
				next;
			}
			$mech->field("MobNo", $mob);
			$mech->field("textArea", $msg);
			$mech->submit_form();

			if($mech->success())
			{
				print "Done \n" if($self->{'debug'});
			}
			else
			{
				print "Failed \n" if($self->{'debug'});
				die 'failed to send sms';
			}
			$dest =  $mech->response->content;
			if($mech->response->header("Content-Encoding") eq "gzip")
			{
					$dest = Compress::Zlib::memGunzip($dest);
			}
			if($dest =~ m/successfully/sig)
			{
			  print "Message sent successfully" if($self->{'debug'});
			}
		}
        return;
}

sub _getgzip()
{
	my ($self, $dest) = @_;
	return Compress::Zlib::memGunzip($dest);
}

=head1 WEBSITE

You can find information about WAY2SMS at :

   http://www.way2sms.com/

=head1 AUTHOR

adarshtp, C<< <adarshtp at gmail.com> >>

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

1; # End of Net::SMS::WAY2SMS
