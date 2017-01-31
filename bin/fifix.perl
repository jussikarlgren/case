while (<>) {
    s/(<[^>]+>)//g;        # remove sgml/html tags
    s/&nbsp;/\ /g;
    s/\[\d+\]/\ /g;        # wiki refs
    s/&\w+;//g; # remove html entities
#    s/\W/\ /g;
    s/\s+/\ /g;
    s/[\'\"\`\~\|]/\ /g; # remove quotes and other non-characters
    s/[\\\/\-\_]/\ /g; # remove hyphens and slashes 
    s/[\}\{\[\],)(\"]/\ /g;	# remove punctuation (lesser)
    s/[;:!\?]/\ /g;	 # remove punctuation (sentence break)
    s/(\D)\.(\W)/$1\ $2/g; # remove punctuation (period - nondec) 
    tr/A-ZÅÄÖ/a-zåäö/; #
    @ddd = split;
    for $w (@ddd) {
	print "$w\n";
    }
}
