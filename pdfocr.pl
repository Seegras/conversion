#!/usr/bin/perl
# 
# OCR any PDF files in a directory are not already OCR'ed,
# 
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2014-04-07
# Revision: 2019-10-09
# Version:  0.2
# License:  Artistic License 2.0 or MIT License
# URL:      http://seegras.discordia.ch/Programs/
#

use Getopt::Long;
use Pod::Usage;
use File::Temp qw/ tempdir /;

# Config Options
# $debug = 0;
$language="eng";
@files = ();

&Getopt::Long::Configure( 'pass_through', 'no_autoabbrev');
&Getopt::Long::GetOptions(
                'help|h'                => \$needshelp,
                'lang|l=s'                => \$language,
                'overwrite|o'                => \$doover,
);

if (!$ARGV[0]) {
    $dname = ".";
} else { 
    $dname=$ARGV[0]; 
}

if ($needshelp) {
    pod2usage(1);
}

sub ocrfile {
        if ($debug) { print "$file\n" };
        if ($debug) { $dir = tempdir( ); }
        else  { $dir = tempdir( CLEANUP => 1 ); }
        system ("/usr/bin/pdfimages -j -png \"$file\" $dir/out");
        opendir(SCAN_DIR, $dir) || die "I am unable to access that directory...Sorry";
        @scandir_contents = readdir(SCAN_DIR);
        closedir(SCAN_DIR);
        @scandir_contents = sort(@scandir_contents);
        foreach $scanfilename (@scandir_contents) {
            ($scanname,$scansuffix) = $scanfilename =~ /^(.*)(\.[^.]*)$/;
            if ($scanfilename ne ".." and $scanfilename ne "." and ($scansuffix eq ".jpg" or $scansuffix eq ".png")) {
                system ("/usr/bin/tesseract -l $language \"$dir/$scanfilename\" \"$dir/$scanname\" pdf");
            }
        }
        system ("/usr/bin/pdfjam --outfile $name-2.pdf $dir/*.pdf");
}

opendir(IN_DIR, $dname) || die "I am unable to access that directory...Sorry";
@dir_contents = readdir(IN_DIR);
closedir(IN_DIR);

@dir_contents = sort(@dir_contents);
    foreach $filename (@dir_contents) {
    ($name,$suffix) = $filename =~ /^(.*)(\.[^.]*)$/;
        if ($filename ne ".." and $filename ne "." and ($suffix eq ".pdf")) {
            if ($debug) { print "$filename\n" };
            push @files, $filename;
        }
    }
    @files = sort @files;

foreach $file (@files) {
    $ocrd=0;
    if ($debug) { print "$file\n" };
    open PDF, "/usr/bin/pdftotext -raw -nopgbrk -q \"$file\" - 2>/dev/null |"
        or die "error opening pdf \"$file\"\n";
    while (<PDF>) {
        if ($_ ne '') {
            $ocrd=1;
        }
    }
    close PDF;

    if (!$ocrd) {
        print "$file\n";
        $tempmeta = $name . ".meta"; 
        system ("/usr/bin/pdftk \"$file\" dump_data output \"$tempmeta\" uncompress");
        ocrfile();
        system ("/usr/bin/pdftk \"$name-2.pdf\" update_info \"$tempmeta\" output \"$name-3.pdf\"");
        rename ("$name-3.pdf", "$name-2.pdf");
        unlink ("$tempmeta");
        if ($doover) {
            rename ("$name-2.pdf", "$file");
        }
    }
}

__END__

=head1 NAME

pdfocr.pl -- OCR pdf files via tesseract

=head1 SYNOPSIS

processscans [options] [directory ...]

 Options:
   -h|--help
   -l|--lang <language>
   -o|--overwrite

=head1 OPTIONS

=over 8

=item B<-h|--help>

Print a brief help message and exit.

=item B<-l|--lang>

Specify language for OCR. 

=item B<-o|--overwrite>

Instead of giving the OCRd pdf a new name, overwrite the old one.

=back

=head1 DESCRIPTION

B<This program> will OCR pdf files in the current directory which 
have no content in textmode (meaning consist entirely of images). 

=cut
