# NOTE: Derived from lib/Net/SMS/WAY2SMS.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Net::SMS::WAY2SMS;

#line 83 "lib/Net/SMS/WAY2SMS.pm (autosplit into lib/auto/Net/SMS/WAY2SMS/send.al)"
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
		my $dest = $mech->content();
		my $header = $mech->response->header("Content-Encoding");
		print "Fetching...\n" if($self->{'debug'});
		$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
		$dest =~ s/<form .*name="loginForm"/<form action='..\/auth.cl' name="loginForm"/ig;
		$mech->update_html($dest);
		$mech->form_with_fields(("username","password"));
		$mech->field("username", $self->{'user'});
		$mech->field("password", $self->{'password'});
		print "Loggin...\n" if($self->{'debug'});
		$mech->submit_form();
		$dest= $mech->response->content;
		$header = $mech->response->header("Content-Encoding");
		$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
		foreach my $mob (@mobs)
        {
			$mech->get("http://wwwl.way2sms.com/jsp/InstantSMS.jsp?val=0");
			$dest= $mech->response->content;
			$header = $mech->response->header("Content-Encoding");
			$mech->update_html($self->_getgzip($dest)) if($header && $header eq "gzip");
			print "Sending ... \n" if($self->{'debug'});
			my $isLoggedIn = $mech->form_with_fields(("MobNo","textArea"));
			die 'Unable to login... Please check your credentials' unless $isLoggedIn;

			print "$mob\n" if($self->{'debug'});
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
			if($mech->response->header("Content-Encoding") && $mech->response->header("Content-Encoding") eq "gzip")
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

# end of Net::SMS::WAY2SMS::send
1;
