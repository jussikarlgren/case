$path = "/home/jussi/Desktop/2016.swadesh/tammikuu";
open(DIFFLIST, "<".$path."/caseexperimenttammikuu.result");
while (<DIFFLIST>) {
($d,$one,$two) = /([01]\.[0-9]+)\s+([\wöäå]+)<->([\wöäå]+)/;
next unless abs $d >= 0.2;
$seen{$one}++;
$seen{$two}++;
$delta{$one}{$two} = abs $d;
$delta{$two}{$one} = abs $d;
}
close DIFFLIST;


open(AMPLIST, "<".$path."/radvis.analyses");    
while (<AMPLIST>) {                   
$token = "";
if (/([\wåäö]+):.*NUM=(\w+)/) {
    $token=$1;
    print if $seen{$token};
}
}
close AMPLIST;             
