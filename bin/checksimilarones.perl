$path = "/home/jussi/Desktop/2016.swadesh/tammikuu";
open(DIFFLIST, "<".$path."/caseexperimenttammikuu.result");
while (<DIFFLIST>) {
($d,$one,$two) = /([01]\.[0-9]+)\s+([\wöäå]+)<->([\wöäå]+)/;
#next unless abs $d >= 0.2;
$seen{$one}++;
$seen{$two}++;
$delta{$one}{$two} = abs $d;
$delta{$two}{$one} = abs $d;
$ccc++;
}
close DIFFLIST;

print "cases: $ccc\n";

open(AMPLIST, "<".$path."/relevant.analyses");    

while (<AMPLIST>) {                   
    chomp;
$token = "";
if (/([\wåäö]+):.*(\[NUM=.*)$/){
    $token=$1;
    next unless $seen{$token};
    $ddd++;
    $anal=$2;
    while ($anal =~ /NUM=(\w+)/g) {
	    $num{$1}++;
	}
    while ($anal =~ /CASE=(\w+)/g) {
	$case{$1}++;
    }
    while ($anal =~ /CLIT\d*=(\w+)/g) {
	$clit{$1}++;
    }
    while ($anal =~ /POSS=(\w+)/g) {
	$poss{$1}++;
    }
} else {
    print "************** $_\n";
    next;
}
push @{ $anal{$token} }, $anal;
}                                                                                          
close AMPLIST;             
print "analyses: $ddd\n";

$numdiff = 0;
$numn = 0.0000001;
for $pp (keys %seen) {
    for $qq (keys %{ $delta{$pp} }) {
	foreach $panal (@{ $anal{$pp} }) {
	    $panal =~ /CASE=(\w+)/;
	    $pcase = $1;
	    foreach $qanal (@{ $anal{$qq} }) {
#		print "$pp $qq $delta{$pp}{$qq} $panal ( @{ $anal{$pp} } ) $qanal ( @{ $anal{$qq} } )\n";
		$qanal =~ /CASE=(\w+)/;
		$qcase = $1;
		if ($inner{$pcase} && $inner{$qcase}) {
		    if ($panal =~ /NUM=(\w+)/) {
			$pnum = $1;
			if ($qanal =~ /NUM=(\w+)/) {
			    $qnum = $1;
			    if ($pnum ne $qnum) {
				$numdiffc{INNERC} += $delta{INNERC};
				$numdiffn{INNERC}++;
			    } else {
				$samenum{INNERC} += $delta{INNERC};
				$samenumn{INNERC}++;
			    }
			}
		    }
		}
		if ($outer{$pcase} && $outer{$qcase}) {
		    if ($panal =~ /NUM=(\w+)/) {
			$pnum = $1;
			if ($qanal =~ /NUM=(\w+)/) {
			    $qnum = $1;
			    if ($pnum ne $qnum) {
				$numdiffc{OUTERC} += $delta{OUTERC};
				$numdiffn{OUTERC}++;
			    } else {
				$samenum{OUTERC} += $delta{OUTERC};
				$samenumn{OUTERC}++;
			    }
			}
		    }
		}
		if ($pcase eq $qcase) {
		    if ($panal =~ /NUM=(\w+)/) {
			$pnum = $1;
			if ($qanal =~ /NUM=(\w+)/) {
			    $qnum = $1;
			    if ($pnum ne $qnum) {
				$numdiffc{NUMDIFF} += $delta{$pp}{$qq};
				$numdiffn{NUMDIFF}++;
			    } else {
				$samenum{$pcase} += $delta{$pp}{$qq};
				$samenumn{$pcase}++;
			    }
			}
		    }
		} else {
		    $casediff{$pcase.$qcase} += $delta{$pp}{$qq};
		    $casediff{$qcase.$pcase} += $delta{$pp}{$qq};
		    $casen{$pcase.$qcase}++;
		    $casen{$qcase.$pcase}++;
		}
	    }
	}
}
}
print "numdif\t$numdiff\t$numn\t".$numdiff/$numn."\n";
foreach $c (keys %samenum) {
    print "$c\t$samenum{$c}\t$samenumn{$c}\t".$samenum{$c}/$samenumn{$c}."\n";
}
foreach $c (keys %numdiffn) {
    print "$c\t$numdiffc{$c}\t$numdiffn{$c}\t".$numdiffc{$c}/$numdiffn{$c}."\n";
}
foreach $d (keys %casen) {
	print "$d\t$casediff{$d}\t$casen{$d}\t".$casediff{$d}/$casen{$d}."\n";
}



#%s = ();
#%n = ();#for $pp (keys %num) {
#    for $qq (keys %num) {
#	next unless $delta{$pp}{$qq};
#	$n{$num{$pp}."-".$num{$qq}}++;
#	$s{$num{$pp}."-".$num{$qq}} += $delta{$pp}{$qq};
#}
#}
#for $s (keys %s) {
# print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
#}
