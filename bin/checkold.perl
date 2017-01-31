open(DIFFLIST, "<tammikuu/caseexperimenttammikuu.filtered.result.sorted");
while (<DIFFLIST>) {
($d,$one,$two) = /([01]\.[0-9]+)\s+([\wöäå]+)<->([\wöäå]+)/;
next unless abs $d >= 0.2;
$seen{$one}++;
$seen{$two}++;
$delta{$one}{$two} = abs $d;
$delta{$two}{$one} = abs $d;
#print "$one $two $delta{$one}{$two} = $d\t";
#print;
}
close DIFFLIST;


open(AMPLIST, "<radvis.analyses");    
while (<AMPLIST>) {                   
    chomp;
$token = "";
$num = "";
$case = "";
$poss = "";
$clit1 = "";
$clit2 = "";
if (/([\wåäö]+):.*NUM=(\w+).*CASE=(\w+).*POSS=(\w+).*CLIT=(\w+).*CLIT=(\w+)/) {
    $token=$1;
    $num=$2;
    $case=$3;
    $poss=$4;
    $clit1=$5;
    $clit2=$6;
} elsif (/([\wåäö]+):.*NUM=(\w+).*CASE=(\w+).*POSS=(\w+).*CLIT=(\w+)/) {
    $token=$1;
    $num=$2;
    $case=$3;
    $poss=$4;
    $clit1=$5;
} else {
    next;
}
    next unless $seen{$token};
    $num{$token} = $num; 
    $case{$token} = $case;
    $clit1{$token} = $clit1;
    $clit2{$token} = $clit2 if $clit2;
    $poss{$token} = $poss;
}                                                                                          
close AMPLIST;             
print "---";
for $pp (keys %seen) {
    for $qq (keys %{ $delta{$pp} }) {
	if ($num{$pp} ne $num{$qq}) {
	    print "$pp.$qq $poss{$pp} $poss{$qq} $delta{$pp}{$qq}\n";
	}
}
}


#%s = ();
#%n = ();
#for $pp (keys %num) {
#    for $qq (keys %num) {
#	next unless $delta{$pp}{$qq};
#	$n{$num{$pp}."-".$num{$qq}}++;
#	$s{$num{$pp}."-".$num{$qq}} += $delta{$pp}{$qq};
#}
#}
#for $s (keys %s) {
# print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
#}
