#!/usr/bin/perl
#
# Author:  Peter Keel <seegras@discordia.ch>
# Date:     2010-02-28
# Revision: 2020-05-06
# Version:  0.2
# License:  Public Domain
# URL:      https://seegras.discordia.ch/Programs/
#
# The Siemens S65 cellphone behaves very uncooperative when it comes to 
# reading out/syncing its addressbook. It's totally impossible via USB,
# but it _should_ work with bluetooth. Well, I managed to get it to 
# accept new records, but could neither read nor modify old records.
# 
# But you can read the filesystem of it via OBEX with USB or bluetooth.
# So this ugly hack can read the files in Data/System/apo/addr/*/* of a 
# Siemens S65 and prints out vcards/VCF. 
#
# Right now, it only copes with FIRST NAME, LAST NAME, EMAIL and HOME-, 
# WORK- and CELL-numbers and GROUP. 
# 
# Usage: apo2vcf <files> 
#
use strict;
use IO::Seekable qw(SEEK_SET);
use Switch;

die "usage: apo2vcf <files>\n" unless($ARGV[0]);

my $debug = 0;

foreach my $file (@ARGV) {
    if ( -e $file ) {  # double check existence
my $mobileno = ""; 
my $homeno = "";
my $officeno = ""; 
my $groupnum = "";
my $firstname = ""; 
my $lastname = "";
my $email = "";

my $buffer = "";
my $numrecs;
my $group;

open(my $in_file, "<", "$file") or die "can't open $file: $!";

seek($in_file, 0x05, 0) or die "seek:$!";
read($in_file, $buffer, 1);
$numrecs = unpack 'c', $buffer;
if ($debug) { printf "NUM: $numrecs\n"; }

while ( $numrecs != 0 ) {
my $rec1len = 0; 
my $rec1len2 = 0;
my $rec2len1 = 0;
my $nullrec = 0;
my $isname = "";
my $isnumber = "";
my $isgroup = "";
my $islastname = "";
my $isfirstname = "";
my $ismobileno = "";
my $isofficeno = ""; 
my $ishomeno = "";
my $isgroup = "";

my $rec1; 
my $rec1cont; 
my $isemail;
my $num1;

read($in_file, $buffer, 1);
$rec1 = unpack 'c', $buffer;
switch ($rec1) {
    case 35	{ $isname=1; $islastname=1; }
    case 36	{ $isname=1; $isfirstname=1; }
    case 44	{ $isnumber=1; $ismobileno=1; }
    case 45	{ $isnumber=1; $ishomeno=1; }
    case 46	{ $isname=1; $isemail=1; }
    case 42	{ $isnumber=1; $isofficeno=1 }
    case 50	{ $isgroup=1; $isgroup=1 }
}
if ($isname) {
    while ( $rec1len == 0) {
	read($in_file, $buffer, 1);
	$rec1len = unpack 'cX', $buffer;
    }
    if ($debug) { printf "(LEN1: $rec1len) "; }
    while ( $rec1len2 == 0) {
        read($in_file, $buffer, 1);
	$rec1len2 = unpack 'cX', $buffer;
    }
    if ($debug) { printf "(LEN2: $rec1len2) "; }

    read($in_file, $buffer, $rec1len-1);
    $rec1cont = unpack 'A*', $buffer;
    $rec1cont =~ s/\x0+//g;

    if ($islastname) {
	$lastname = $rec1cont; 
	if ($debug) { printf "LAST NAME: $lastname\n"; }
    }
    if ($isfirstname) {
	$firstname = $rec1cont; 
	if ($debug) { printf "LAST NAME: $firstname\n"; }
    }
    if ($isemail) {
	$email = $rec1cont; 
	if ($debug) { printf "EMAIL: $email\n"; }
    }
    $numrecs = --$numrecs; 
    }

    if ($isnumber) {
	while ( $nullrec == 0) {
	    read($in_file, $buffer, 1); #discard
	    $nullrec = unpack 'cX', $buffer;
	}
	#$ = unpack 'cX', $buffer;
	read($in_file, $buffer, 1); # discard
	read($in_file, $buffer, 1); 
	$rec2len1 = unpack 'cX', $buffer;
	if ($debug) { printf "NUMLEN: $rec2len1\n"; }
	read($in_file, $buffer, 1); # discard
	while ($rec2len1+1 != 0) {
	    read($in_file, $buffer, 1);
	    $num1 = unpack 'h2', $buffer;
	    $num1 =~ s/(\d)([a-f])/$1/;  
	    if ($debug) { printf "NUM: $num1\n"; }
	    if ($ismobileno) { $mobileno = $mobileno . $num1;}
	    if ($ishomeno) { $homeno = $homeno . $num1;}
	    if ($isofficeno) { $officeno = $homeno . $num1;}
	    $rec2len1 = --$rec2len1; 
	}
	$numrecs = --$numrecs; 
    }
    if ($isgroup) {
	read($in_file, $buffer, 3); #discard
	read($in_file, $buffer, 1);
	$groupnum = unpack 'c', $buffer;
	if ($debug) { printf "$groupnum\n"; }
	$numrecs = --$numrecs; 
    }
}

        close $in_file;

	switch ($groupnum) {
	    case 1	{ $group="VIP"; }
	    case 2	{ $group="Office"; }
	    case 3	{ $group="Family"; }
	    case 4	{ $group="Reenactors"; }
	    case 5	{ $group="Larp"; }
	    case 6	{ $group="Private"; }
	    case 7	{ $group="Business"; }
	    case 8	{ $group="Received"; }
	    case 9	{ $group="No Group"; }
	}

	printf "BEGIN:VCARD\n";
	printf "CLASS:PUBLIC\n";
	printf "CATEGORIES:$groupnum\n";
	printf "FN;CHARSET=ISO8859-1:$firstname $lastname\n";
	printf "N;CHARSET=ISO8859-1:$lastname;$firstname;;;\n";
	if ($officeno) { printf "TEL;TYPE=WORK:$officeno\n"; }
	if ($mobileno) { printf "TEL;TYPE=CELL;TYPE=PREF:$mobileno\n"; }
	if ($homeno) { printf "TEL;TYPE=HOME:$homeno\n"; }
	if ($email) { printf "EMAIL:$email\n"; }
	printf "REV:2010-02-28T00:00:00\n";
	printf "VERSION:3.0\n";
	printf "END:VCARD\n\n";
    }
}

