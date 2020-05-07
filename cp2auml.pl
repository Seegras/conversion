#!/usr/bin/perl
#
# Author: Peter Keel <seegras@discordia.ch>
# Version:  1.2
# Revision: 2005-08-30
# Revision: 2020-05-06
# License:  Public Domain
# 
# Changes DOS codepage 850 umlauts to HTML-Umlauts
# 
use strict;

die "Usage: cp2auml.pl filename\n"       unless($ARGV[0]);

open(my $in_file,"<","$ARGV[0]") || die "Cannot open $ARGV[0] for input\n";
while(<$in_file>){
	$_ =~ s/�/\&auml\;/;
	$_ =~ s/�/\&uuml\;/;
	$_ =~ s/�/\&ouml\;/;
	$_ =~ s/�/\&Uuml\;/;
	$_ =~ s/�/\&Ouml\;/;
	$_ =~ s/�/\&Auml\;/;
	$_ =~ s/�/\&auml\;/;
	$_ =~ s/�/\&Auml\;/;
	$_ =~ s/�/\&ouml\;/;
	$_ =~ s/�/\&Ouml\;/;
	$_ =~ s/�/\&uuml\;/;
	$_ =~ s/�/\&Uuml\;/;
	$_ =~ s/�/\&iuml\;/;
	$_ =~ s/�/\&Iuml\;/;
	$_ =~ s/�/\&yuml\;/;
	$_ =~ s/�/\&euml\;/;
	$_ =~ s/�/\&Euml\;/;
	$_ =~ s/�/\&copy\;/;
	$_ =~ s/�/\&reg\;/;
	$_ =~ s/�/\&THORN\;/;
	$_ =~ s/�/\&thorn\;/;
	$_ =~ s/�/\&ETH\;/;
	$_ =~ s/�/\&eth\;/;
	$_ =~ s/�/\&nbsp\;/;
	$_ =~ s/�/\&egrave\;/;
	$_ =~ s/�/\&Egrave\;/;
	$_ =~ s/�/\&ograve\;/;
	$_ =~ s/�/\&Ograve\;/;
	$_ =~ s/�/\&ugrave\;/;
	$_ =~ s/�/\&Ugrave\;/;
	$_ =~ s/�/\&igrave\;/;
	$_ =~ s/�/\&Igrave\;/;
	$_ =~ s/�/\&agrave\;/;
	$_ =~ s/�/\&Agrave\;/;
	$_ =~ s/�/\&eacute\;/;
	$_ =~ s/�/\&Eacute\;/;
	$_ =~ s/�/\&oacute\;/;
	$_ =~ s/�/\&Oacute\;/;
	$_ =~ s/�/\&uacute\;/;
	$_ =~ s/�/\&Uacute\;/;
	$_ =~ s/�/\&iacute\;/;
	$_ =~ s/�/\&Iacute\;/;
	$_ =~ s/�/\&aacute\;/;
	$_ =~ s/�/\&Aacute\;/;
	$_ =~ s/�/\&yacute\;/;
	$_ =~ s/�/\&Yacute\;/;
	$_ =~ s/�/\&ecirc\;/;
	$_ =~ s/�/\&Ecirc\;/;
	$_ =~ s/�/\&ocirc\;/;
	$_ =~ s/�/\&Ocirc\;/;
	$_ =~ s/�/\&ucirc\;/;
	$_ =~ s/�/\&Ucirc\;/;
	$_ =~ s/�/\&icirc\;/;
	$_ =~ s/�/\&Icirc\;/;
	$_ =~ s/�/\&acirc\;/;
	$_ =~ s/�/\&Acirc\;/;
	$_ =~ s/�/\&ccedil\;/;
	$_ =~ s/�/\&Ccedil\;/;
	$_ =~ s/�/\&ntilde\;/;
	$_ =~ s/�/\&Ntilde\;/;
	$_ =~ s/�/\&otilde\;/;
	$_ =~ s/�/\&Otilde\;/;
	$_ =~ s/�/\&atilde\;/;
	$_ =~ s/�/\&Atilde\;/;
	$_ =~ s/�/\&aring\;/;
	$_ =~ s/�/\&Aring\;/;
	$_ =~ s/�/\&szlig\;/;
	$_ =~ s/�/\&aelig\;/;
	$_ =~ s/�/\&AElig\;/;
	$_ =~ s/�/\&oslash\;/;
	$_ =~ s/�/\&Oslash\;/;
	$_ =~ s/�/\&iexcl\;/;
	$_ =~ s/�/\&cent\;/;
	$_ =~ s/�/\&pound\;/;
	$_ =~ s/�/\&curren\;/;
	$_ =~ s/�/\&yen\;/;
	$_ =~ s/�/\&brvbar\;/;
	$_ =~ s/�/\&die\;/;
	$_ =~ s/�/\&ordf\;/;
	$_ =~ s/�/\&laquo\;/;
	$_ =~ s/�/\&not\;/;
	$_ =~ s/�/\&shy\;/;
	$_ =~ s/�/\&macr\;/;
	$_ =~ s/�/\&deg\;/;
	$_ =~ s/�/\&plusmn\;/;
	$_ =~ s/�/\&sup2\;/;
	$_ =~ s/�/\&sup3\;/;
	$_ =~ s/�/\&acute\;/;
	$_ =~ s/�/\&micro\;/;
	$_ =~ s/�/\&para\;/;
	$_ =~ s/�/\&middot\;/;
	$_ =~ s/�/\&cedil\;/;
	$_ =~ s/�/\&sup1\;/;
	$_ =~ s/�/\&ordm\;/;
	$_ =~ s/�/\&raquo\;/;
	$_ =~ s/�/\&frac14\;/;
	$_ =~ s/�/\&frac12\;/;
	$_ =~ s/�/\&frac34\;/;
	$_ =~ s/�/\&iquest\;/;
	$_ =~ s/�/\&times\;/;
	$_ =~ s/�/\&divide\;/;
      print($_);
   }

close $in_file;

