#!/usr/bin/perl
# 
# Outputs hex-string in 8bit ascii
#
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2005-08-30
# Version:  0.1
# License:  Public Domain
# URL:      http://seegras.discordia.ch/Programs/
#

$var1 = $ARGV[0];
$var1 =~ s/([a-fA-F0-9]{2,2})/chr(hex($1))/eg;
print("$var1\n");
