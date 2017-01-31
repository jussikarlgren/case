open(DIFFLIST, "</home/jussi/Desktop/2016.swadesh/tammikuu/caseexperimenttammikuu.filtered.result.sorted");
#open(DIFFLIST, "</home/jussi/Desktop/2016.swadesh/vec.a");    
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


open(AMPLIST, "</home/jussi/Desktop/2016.swadesh/tammikuu/radvis.analyses");    
#open(AMPLIST, "</home/jussi/Desktop/2016.swadesh/rad.a");    
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

for $pp (keys %seen) {


#    for $qq (keys %{ $delta{$pp} }) {

%s = ();
%n = ();
for $pp (keys %poss) {
    for $qq (keys %poss) {
	next unless $delta{$pp}{$qq};
	$n{$poss{$pp}."-".$poss{$qq}}++;
	$s{$poss{$pp}."-".$poss{$qq}} += $delta{$pp}{$qq};
#	print "$pp.$qq $poss{$pp} $poss{$qq} $delta{$pp}{$qq}\n";
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}

%s = ();
%n = ();
for $pp (keys %case) {
    for $qq (keys %case) {
	next unless $delta{$pp}{$qq};
	$n{$case{$pp}."-".$case{$qq}}++;
	$s{$case{$pp}."-".$case{$qq}} += $delta{$pp}{$qq};
#	if ($case{$pp} eq "NOM" && $case{$qq} eq "INE") {print "$pp $qq $case{$pp} $case{$qq} $delta{$pp}{$qq}\n";}
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}


%s = ();
%n = ();
for $pp (keys %num) {
    for $qq (keys %num) {
	next unless $delta{$pp}{$qq};
	$n{$num{$pp}."-".$num{$qq}}++;
	$s{$num{$pp}."-".$num{$qq}} += $delta{$pp}{$qq};
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}

%s = ();
%n = ();
for $pp (keys %clit1) {
    for $qq (keys %clit1) {
	next unless $delta{$pp}{$qq};
	$n{$clit1{$pp}."-".$clit1{$qq}}++;
	$s{$clit1{$pp}."-".$clit1{$qq}} += $delta{$pp}{$qq};
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}
%s = ();
%n = ();
for $pp (keys %clit1) {
    for $qq (keys %clit2) {
	next unless $delta{$pp}{$qq};
	$n{$clit1{$pp}."-".$clit2{$qq}}++;
	$s{$clit1{$pp}."-".$clit2{$qq}} += $delta{$pp}{$qq};
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}
%s = ();
%n = ();
for $pp (keys %clit2) {
    for $qq (keys %clit2) {
	next unless $delta{$pp}{$qq};
	$n{$clit2{$pp}."-".$clit2{$qq}}++;
	$s{$clit2{$pp}."-".$clit2{$qq}} += $delta{$pp}{$qq};
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}
%s = ();
%n = ();
for $pp (keys %clit1) {
    for $qq (keys %clit2) {
	next unless $delta{$pp}{$qq};
	$n{$clit1{$pp}."-".$clit2{$qq}}++;
	$s{$clit1{$pp}."-".$clit2{$qq}} += $delta{$pp}{$qq};
}
}
for $s (keys %s) {
 print "$s\t$n{$s}\t".$s{$s} / $n{$s}."\n";
}
