#!/usr/bin/perl
#
# Author: Peter Keel <seegras@discordia.ch>
# Version:  1.1
# Revision: 2005-08-30
# License:  Public Domain
# 
# Changes DOS codepage 850 umlauts to HTML-Umlauts
# 

die "Usage: cp2auml.pl filename\n"       unless($ARGV[0]);

open(IN_FILE,"<$ARGV[0]") || die "Cannot open $ARGV[0] for input\n";
while(<IN_FILE>){
	$_ =~ s/Ñ/\&auml\;/;
	$_ =~ s/Å/\&uuml\;/;
	$_ =~ s/î/\&ouml\;/;
	$_ =~ s/ö/\&Uuml\;/;
	$_ =~ s/ô/\&Ouml\;/;
	$_ =~ s/é/\&Auml\;/;
	$_ =~ s/‰/\&auml\;/;
	$_ =~ s/ƒ/\&Auml\;/;
	$_ =~ s/ˆ/\&ouml\;/;
	$_ =~ s/÷/\&Ouml\;/;
	$_ =~ s/¸/\&uuml\;/;
	$_ =~ s/‹/\&Uuml\;/;
	$_ =~ s/Ô/\&iuml\;/;
	$_ =~ s/œ/\&Iuml\;/;
	$_ =~ s/ˇ/\&yuml\;/;
	$_ =~ s/Î/\&euml\;/;
	$_ =~ s/À/\&Euml\;/;
	$_ =~ s/©/\&copy\;/;
	$_ =~ s/Æ/\&reg\;/;
	$_ =~ s/˛/\&THORN\;/;
	$_ =~ s/ﬁ/\&thorn\;/;
	$_ =~ s/–/\&ETH\;/;
	$_ =~ s//\&eth\;/;
	$_ =~ s/†/\&nbsp\;/;
	$_ =~ s/Ë/\&egrave\;/;
	$_ =~ s/»/\&Egrave\;/;
	$_ =~ s/Ú/\&ograve\;/;
	$_ =~ s/“/\&Ograve\;/;
	$_ =~ s/˘/\&ugrave\;/;
	$_ =~ s/Ÿ/\&Ugrave\;/;
	$_ =~ s/Ï/\&igrave\;/;
	$_ =~ s/Ã/\&Igrave\;/;
	$_ =~ s/‡/\&agrave\;/;
	$_ =~ s/¿/\&Agrave\;/;
	$_ =~ s/È/\&eacute\;/;
	$_ =~ s/…/\&Eacute\;/;
	$_ =~ s/Û/\&oacute\;/;
	$_ =~ s/”/\&Oacute\;/;
	$_ =~ s/˙/\&uacute\;/;
	$_ =~ s/⁄/\&Uacute\;/;
	$_ =~ s/Ì/\&iacute\;/;
	$_ =~ s/Õ/\&Iacute\;/;
	$_ =~ s/·/\&aacute\;/;
	$_ =~ s/¡/\&Aacute\;/;
	$_ =~ s/˝/\&yacute\;/;
	$_ =~ s/›/\&Yacute\;/;
	$_ =~ s/Í/\&ecirc\;/;
	$_ =~ s/ /\&Ecirc\;/;
	$_ =~ s/Ù/\&ocirc\;/;
	$_ =~ s/‘/\&Ocirc\;/;
	$_ =~ s/˚/\&ucirc\;/;
	$_ =~ s/€/\&Ucirc\;/;
	$_ =~ s/Ó/\&icirc\;/;
	$_ =~ s/Œ/\&Icirc\;/;
	$_ =~ s/‚/\&acirc\;/;
	$_ =~ s/¬/\&Acirc\;/;
	$_ =~ s/Á/\&ccedil\;/;
	$_ =~ s/«/\&Ccedil\;/;
	$_ =~ s/Ò/\&ntilde\;/;
	$_ =~ s/—/\&Ntilde\;/;
	$_ =~ s/ı/\&otilde\;/;
	$_ =~ s/’/\&Otilde\;/;
	$_ =~ s/„/\&atilde\;/;
	$_ =~ s/√/\&Atilde\;/;
	$_ =~ s/Â/\&aring\;/;
	$_ =~ s/≈/\&Aring\;/;
	$_ =~ s/ﬂ/\&szlig\;/;
	$_ =~ s/Ê/\&aelig\;/;
	$_ =~ s/∆/\&AElig\;/;
	$_ =~ s/¯/\&oslash\;/;
	$_ =~ s/ÿ/\&Oslash\;/;
	$_ =~ s/°/\&iexcl\;/;
	$_ =~ s/¢/\&cent\;/;
	$_ =~ s/£/\&pound\;/;
	$_ =~ s/§/\&curren\;/;
	$_ =~ s/•/\&yen\;/;
	$_ =~ s/¶/\&brvbar\;/;
	$_ =~ s/®/\&die\;/;
	$_ =~ s/™/\&ordf\;/;
	$_ =~ s/´/\&laquo\;/;
	$_ =~ s/¨/\&not\;/;
	$_ =~ s/≠/\&shy\;/;
	$_ =~ s/Ø/\&macr\;/;
	$_ =~ s/∞/\&deg\;/;
	$_ =~ s/±/\&plusmn\;/;
	$_ =~ s/≤/\&sup2\;/;
	$_ =~ s/≥/\&sup3\;/;
	$_ =~ s/¥/\&acute\;/;
	$_ =~ s/µ/\&micro\;/;
	$_ =~ s/∂/\&para\;/;
	$_ =~ s/∑/\&middot\;/;
	$_ =~ s/∏/\&cedil\;/;
	$_ =~ s/π/\&sup1\;/;
	$_ =~ s/∫/\&ordm\;/;
	$_ =~ s/ª/\&raquo\;/;
	$_ =~ s/º/\&frac14\;/;
	$_ =~ s/Ω/\&frac12\;/;
	$_ =~ s/æ/\&frac34\;/;
	$_ =~ s/ø/\&iquest\;/;
	$_ =~ s/◊/\&times\;/;
	$_ =~ s/˜/\&divide\;/;
      print($_);
   }

close IN;

