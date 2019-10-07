#!/usr/bin/perl
#
# Author: Peter Keel <seegras@discordia.ch>
# Version:  1.1
# Revision: 2009-09-09
# License:  Public Domain
# 
# Changes DOS codepage 850 umlauts to 7bit ascii representations
# 

die "Usage: cp2ascii.pl filename\n"       unless($ARGV[0]);

open(IN_FILE,"<$ARGV[0]") || die "Cannot open $ARGV[0] for input\n";
while(<IN_FILE>){
	$_ =~ s/�/ae/;
	$_ =~ s/�/ue/;
	$_ =~ s/�/oe/;
	$_ =~ s/�/Ue/;
	$_ =~ s/�/Oe/;
	$_ =~ s/�/Ae/;
	$_ =~ s/�/ae/;
	$_ =~ s/�/Ae/;
	$_ =~ s/�/oe/;
	$_ =~ s/�/Oe/;
	$_ =~ s/�/ue/;
	$_ =~ s/�/Ue/;
	$_ =~ s/�/e/;
	$_ =~ s/�/E/;
	$_ =~ s/�/o/;
	$_ =~ s/�/O/;
	$_ =~ s/�/u/;
	$_ =~ s/�/U/;
	$_ =~ s/�/i/;
	$_ =~ s/�/I/;
	$_ =~ s/�/a/;
	$_ =~ s/�/A/;
	$_ =~ s/�/e/;
	$_ =~ s/�/E/;
	$_ =~ s/�/o/;
	$_ =~ s/�/O/;
	$_ =~ s/�/u/;
	$_ =~ s/�/U/;
	$_ =~ s/�/i/;
	$_ =~ s/�/I/;
	$_ =~ s/�/a/;
	$_ =~ s/�/A/;
	$_ =~ s/�/y/;
	$_ =~ s/�/Y/;
	$_ =~ s/�/e/;
	$_ =~ s/�/E/;
	$_ =~ s/�/o/;
	$_ =~ s/�/O/;
	$_ =~ s/�/u/;
	$_ =~ s/�/U/;
	$_ =~ s/�/i/;
	$_ =~ s/�/I/;
	$_ =~ s/�/a/;
	$_ =~ s/�/A/;
	$_ =~ s/�/c/;
	$_ =~ s/�/C/;
	$_ =~ s/�/n/;
	$_ =~ s/�/N/;
	$_ =~ s/�/o/;
	$_ =~ s/�/O/;
	$_ =~ s/�/a/;
	$_ =~ s/�/A/;
	$_ =~ s/�/a/;
	$_ =~ s/�/A/;
	$_ =~ s/�/ss/;
	$_ =~ s/�/ae/;
	$_ =~ s/�/Ae/;
	$_ =~ s/�/o/;
	$_ =~ s/�/O/;
      print($_);
   }

close IN;

