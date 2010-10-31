# NOTE: Derived from lib/Net/SMS/WAY2SMS.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Net::SMS::WAY2SMS;

#line 153 "lib/Net/SMS/WAY2SMS.pm (autosplit into lib/auto/Net/SMS/WAY2SMS/_getgzip.al)"
sub _getgzip()
{
	my ($self, $dest) = @_;
	return Compress::Zlib::memGunzip($dest);
}

1; # End of Net::SMS::WAY2SMS
1;
# end of Net::SMS::WAY2SMS::_getgzip
