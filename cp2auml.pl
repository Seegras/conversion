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
	$_ =~ s/„/\&auml\;/;
	$_ =~ s//\&uuml\;/;
	$_ =~ s/”/\&ouml\;/;
	$_ =~ s/š/\&Uuml\;/;
	$_ =~ s/™/\&Ouml\;/;
	$_ =~ s//\&Auml\;/;
	$_ =~ s/ä/\&auml\;/;
	$_ =~ s/Ä/\&Auml\;/;
	$_ =~ s/ö/\&ouml\;/;
	$_ =~ s/Ö/\&Ouml\;/;
	$_ =~ s/ü/\&uuml\;/;
	$_ =~ s/Ü/\&Uuml\;/;
	$_ =~ s/ï/\&iuml\;/;
	$_ =~ s/Ï/\&Iuml\;/;
	$_ =~ s/ÿ/\&yuml\;/;
	$_ =~ s/ë/\&euml\;/;
	$_ =~ s/Ë/\&Euml\;/;
	$_ =~ s/©/\&copy\;/;
	$_ =~ s/®/\&reg\;/;
	$_ =~ s/ş/\&THORN\;/;
	$_ =~ s/Ş/\&thorn\;/;
	$_ =~ s/Ğ/\&ETH\;/;
	$_ =~ s/ğ/\&eth\;/;
	$_ =~ s/ /\&nbsp\;/;
	$_ =~ s/è/\&egrave\;/;
	$_ =~ s/È/\&Egrave\;/;
	$_ =~ s/ò/\&ograve\;/;
	$_ =~ s/Ò/\&Ograve\;/;
	$_ =~ s/ù/\&ugrave\;/;
	$_ =~ s/Ù/\&Ugrave\;/;
	$_ =~ s/ì/\&igrave\;/;
	$_ =~ s/Ì/\&Igrave\;/;
	$_ =~ s/à/\&agrave\;/;
	$_ =~ s/À/\&Agrave\;/;
	$_ =~ s/é/\&eacute\;/;
	$_ =~ s/É/\&Eacute\;/;
	$_ =~ s/ó/\&oacute\;/;
	$_ =~ s/Ó/\&Oacute\;/;
	$_ =~ s/ú/\&uacute\;/;
	$_ =~ s/Ú/\&Uacute\;/;
	$_ =~ s/í/\&iacute\;/;
	$_ =~ s/Í/\&Iacute\;/;
	$_ =~ s/á/\&aacute\;/;
	$_ =~ s/Á/\&Aacute\;/;
	$_ =~ s/ı/\&yacute\;/;
	$_ =~ s/İ/\&Yacute\;/;
	$_ =~ s/ê/\&ecirc\;/;
	$_ =~ s/Ê/\&Ecirc\;/;
	$_ =~ s/ô/\&ocirc\;/;
	$_ =~ s/Ô/\&Ocirc\;/;
	$_ =~ s/û/\&ucirc\;/;
	$_ =~ s/Û/\&Ucirc\;/;
	$_ =~ s/î/\&icirc\;/;
	$_ =~ s/Î/\&Icirc\;/;
	$_ =~ s/â/\&acirc\;/;
	$_ =~ s/Â/\&Acirc\;/;
	$_ =~ s/ç/\&ccedil\;/;
	$_ =~ s/Ç/\&Ccedil\;/;
	$_ =~ s/ñ/\&ntilde\;/;
	$_ =~ s/Ñ/\&Ntilde\;/;
	$_ =~ s/õ/\&otilde\;/;
	$_ =~ s/Õ/\&Otilde\;/;
	$_ =~ s/ã/\&atilde\;/;
	$_ =~ s/Ã/\&Atilde\;/;
	$_ =~ s/å/\&aring\;/;
	$_ =~ s/Å/\&Aring\;/;
	$_ =~ s/ß/\&szlig\;/;
	$_ =~ s/æ/\&aelig\;/;
	$_ =~ s/Æ/\&AElig\;/;
	$_ =~ s/ø/\&oslash\;/;
	$_ =~ s/Ø/\&Oslash\;/;
	$_ =~ s/¡/\&iexcl\;/;
	$_ =~ s/¢/\&cent\;/;
	$_ =~ s/£/\&pound\;/;
	$_ =~ s/¤/\&curren\;/;
	$_ =~ s/¥/\&yen\;/;
	$_ =~ s/¦/\&brvbar\;/;
	$_ =~ s/¨/\&die\;/;
	$_ =~ s/ª/\&ordf\;/;
	$_ =~ s/«/\&laquo\;/;
	$_ =~ s/¬/\&not\;/;
	$_ =~ s/­/\&shy\;/;
	$_ =~ s/¯/\&macr\;/;
	$_ =~ s/°/\&deg\;/;
	$_ =~ s/±/\&plusmn\;/;
	$_ =~ s/²/\&sup2\;/;
	$_ =~ s/³/\&sup3\;/;
	$_ =~ s/´/\&acute\;/;
	$_ =~ s/µ/\&micro\;/;
	$_ =~ s/¶/\&para\;/;
	$_ =~ s/·/\&middot\;/;
	$_ =~ s/¸/\&cedil\;/;
	$_ =~ s/¹/\&sup1\;/;
	$_ =~ s/º/\&ordm\;/;
	$_ =~ s/»/\&raquo\;/;
	$_ =~ s/¼/\&frac14\;/;
	$_ =~ s/½/\&frac12\;/;
	$_ =~ s/¾/\&frac34\;/;
	$_ =~ s/¿/\&iquest\;/;
	$_ =~ s/×/\&times\;/;
	$_ =~ s/÷/\&divide\;/;
      print($_);
   }

close $in_file;

