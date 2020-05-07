#!/usr/bin/perl
# 
# Outputs hex-string in 8bit ascii
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2005-08-30
# Date:     2005-05-06
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
#
use strict;

my $var1 = $ARGV[0];
$var1 =~ s/([a-fA-F0-9]{2,2})/chr(hex($1))/eg;
print("$var1\n");
