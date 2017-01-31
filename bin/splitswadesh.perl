while (<>) {
    chomp;
    ($en,$fi) = split ":";
    print "$fi\n";
}
