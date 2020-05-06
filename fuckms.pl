#!/usr/bin/perl
#
# Fixes Microsofts motherfucking bullshit of "smart" quotation marks.
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     ?
# Revision: 2008-12-13
# Version:  1.0
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
# 

die "Usage: $0 filename\n"       unless($ARGV[0]);

foreach $file_name (@ARGV) {
    $temp_file="/tmp/$file_name";
    open(IN_FILE,"<$file_name") || die "Cannot open $file_name for input\n";
    open(TEMP,">$temp_file");
    while(<IN_FILE>){
        # use this if already converted to UTF8
        #$_ =~ s/\xC2\x97/ - /g;        # dash
        #$_ =~ s/\xC2\x95/\xC2\xB7/g;        # middle dot
        $_ =~ s/\221/\'/g;        # They fucked up Apostrophe's
        $_ =~ s/\222/\'/g;        # and Apostrophe's
        $_ =~ s/\264/\'/g;        # and more Apostrophe's
        $_ =~ s/\223/\"/g;        # and Quotation Marks.. 
        $_ =~ s/\224/\"/g;        # and more Quotation Marks.. 
        $_ =~ s/\225/-/g;         # dash
        $_ =~ s/\226/-/g;         # dash
        $_ =~ s/\227/ - /g;       # dash
        $_ =~ s/\014//g;          # dunno 
        $_ =~ s/\267/-/g;         # might be a dash
        print TEMP ($_);
    }
    close IN;
    close TEMP;
    system ("mv $temp_file $file_name");
}