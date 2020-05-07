#!/usr/bin/perl
#
# Author: Peter Keel <seegras@discordia.ch>
# Version:  1.2
# Revision: 2009-09-09
# Revision: 2020-05-06
# License:  Public Domain
# 
# Changes DOS codepage 850 umlauts to 7bit ascii representations
# 
use strict;

die "Usage: cp2ascii.pl filename\n"       unless($ARGV[0]);

open(my $in_file,"<", "$ARGV[0]") || die "Cannot open $ARGV[0] for input\n";
while(<$in_file>){
	$_ =~ s/„/ae/;
	$_ =~ s//ue/;
	$_ =~ s/”/oe/;
	$_ =~ s/š/Ue/;
	$_ =~ s/™/Oe/;
	$_ =~ s//Ae/;
	$_ =~ s/ä/ae/;
	$_ =~ s/Ä/Ae/;
	$_ =~ s/ö/oe/;
	$_ =~ s/Ö/Oe/;
	$_ =~ s/ü/ue/;
	$_ =~ s/Ü/Ue/;
	$_ =~ s/è/e/;
	$_ =~ s/È/E/;
	$_ =~ s/ò/o/;
	$_ =~ s/Ò/O/;
	$_ =~ s/ù/u/;
	$_ =~ s/Ù/U/;
	$_ =~ s/ì/i/;
	$_ =~ s/Ì/I/;
	$_ =~ s/à/a/;
	$_ =~ s/À/A/;
	$_ =~ s/é/e/;
	$_ =~ s/É/E/;
	$_ =~ s/ó/o/;
	$_ =~ s/Ó/O/;
	$_ =~ s/ú/u/;
	$_ =~ s/Ú/U/;
	$_ =~ s/í/i/;
	$_ =~ s/Í/I/;
	$_ =~ s/á/a/;
	$_ =~ s/Á/A/;
	$_ =~ s/ı/y/;
	$_ =~ s/İ/Y/;
	$_ =~ s/ê/e/;
	$_ =~ s/Ê/E/;
	$_ =~ s/ô/o/;
	$_ =~ s/Ô/O/;
	$_ =~ s/û/u/;
	$_ =~ s/Û/U/;
	$_ =~ s/î/i/;
	$_ =~ s/Î/I/;
	$_ =~ s/â/a/;
	$_ =~ s/Â/A/;
	$_ =~ s/ç/c/;
	$_ =~ s/Ç/C/;
	$_ =~ s/ñ/n/;
	$_ =~ s/Ñ/N/;
	$_ =~ s/õ/o/;
	$_ =~ s/Õ/O/;
	$_ =~ s/ã/a/;
	$_ =~ s/Ã/A/;
	$_ =~ s/å/a/;
	$_ =~ s/Å/A/;
	$_ =~ s/ß/ss/;
	$_ =~ s/æ/ae/;
	$_ =~ s/Æ/Ae/;
	$_ =~ s/ø/o/;
	$_ =~ s/Ø/O/;
      print($_);
   }

close $in_file;

