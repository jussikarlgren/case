my %seen = ();
my %live = ();
my $lemma;
my $err = 0;
my $obs = 0;
my $n = 0;
while (<>) {
    my $token;
    my $vec;
    if (/([\´\′\’\wåäö]+)\tcontext\t(\[[E\d\.:\-\ ]+\])/) {
	$token = $1;
	$vec = $2;
	$lemma = $token unless defined $lemma;
	unless ($seen{$token}) {
	    $seen{$token}++;
	    $live{$token}++;
	    $obs++;
	}
    } elsif (/([\´\′\’\wåäö]+)\tcontext\t\[\]/) { 
	$token = $1;
	unless ($seen{$token}) {
	    $n++;
	    $seen{$token}++;
	}
    } else {
	if (/([^\t]+)\tcontext\t(\[[E\d\.:\-\ ]+\])/) {
	    $token = $1;
	    $vec = $2;
	    $err++;
	} else {
	    #nop - no string
	}
    }
}
print "$lemma\t$obs\t$n\t$err\t";
print "$ARGV\t";
foreach $w (keys %live) {print "$w ";}
print "\n";
