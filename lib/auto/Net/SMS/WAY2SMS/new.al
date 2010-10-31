# NOTE: Derived from lib/Net/SMS/WAY2SMS.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Net::SMS::WAY2SMS;

#line 48 "lib/Net/SMS/WAY2SMS.pm (autosplit into lib/auto/Net/SMS/WAY2SMS/new.al)"
our $VERSION = '0.04';



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

# end of Net::SMS::WAY2SMS::new
1;
