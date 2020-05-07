#!/usr/bin/perl
# 
# Author:   Peter Keel <seegras@discordia.ch>
# Date:     2014-04-06
# Revision: 2019-10-07
# Revision: 2020-05-06
# Version:  0.4
# License:  Artistic License 2.0 or MIT License
# URL:      https://seegras.discordia.ch/Programs/
#
use strict;
use Getopt::Long;
use Pod::Usage;

# Config Options
my $docrop;
my $doocr;
my $debug;
my $doreverse;
my $domerge;
my $dodelete;
my $dname;
my $needshelp;
my $pdfname;
my @files = ();

&Getopt::Long::Configure( 'pass_through', 'no_autoabbrev', 'bundling');
&Getopt::Long::GetOptions(
                'help|h'                  => \$needshelp,
                'ocr|o:s'                 => \$doocr,
                'crop|c:s'                => \$docrop,
                'reverse|r'               => \$doreverse,
                'merge|m:s'               => \$domerge,
                'delete|d'                => \$dodelete,
);

if (!$ARGV[0]) {
    $dname = ".";
} else { 
    $dname=$ARGV[0]; 
}

if ($needshelp) {
    pod2usage(1);
}

if (defined $docrop && ($docrop eq "")) {
    # Useful values
    # Letter @ 200dpi: 1700x2200+0+0
    # A4 @ 200dpi: 1654x2339+0+0
    # A5 @ 200dpi: 1167x1653+0+0
    # set useful default value for A4 @ 200dpi
    $docrop = "1654x2339+0+0";
    if ($debug) { print "crop: $docrop\n" };
}

if (defined $doocr && ($doocr eq "")) {
    # Useful values: eng, deu
    $doocr = "deu";
    if ($debug) { print "ocr: $doocr\n" };
}

if (defined $domerge && ($domerge eq "")) {
    $domerge = "1.pdf";
    if ($debug) { print "merge: $domerge\n" };
}

sub oddevenreverse {
    my $filenum=$#files+1;
    if ( ($filenum % 2) ne 0) {
        print "Error: Number of files not even\n";
        exit 1;
    }
    my $negi=-1;
    my @numbers = ();
    for ( my $i = 0 ; $i < $filenum/2 ; $i += 1 ) {
        next unless defined $files[$i];
        #print "odd $files[$i]\n";
        push @numbers, $files[$i];
        push @numbers, $files[$negi];
        $negi-=1;
    }
    @files = @numbers;
}

opendir(my $in_dir, $dname) || die "I am unable to access that directory...Sorry";
my @dir_contents = readdir($in_dir);
closedir($in_dir);

@dir_contents = sort(@dir_contents);
    foreach my $filename (@dir_contents) {
    (my $name,my $suffix) = $filename =~ /^(.*)(\.[^.]*)$/;
        if ($filename ne ".." and $filename ne "." and ($suffix eq ".png" or $suffix eq ".jpg" )) {
            push @files, $filename;
        }
    }
    @files = sort @files;

    if ($doreverse) {
        oddevenreverse();
    }
    my $page=100;
    foreach my $file (@files) {
        $page+=1;
        (my $oldname,my $oldsuffix) = $file =~ /^(.*)(\.[^.]*)$/;
        my $newname= $page . "-" . $oldname . $oldsuffix;
        if ($doreverse) {
            $pdfname= $page . "-" . $oldname;
        } else {
            $pdfname= $oldname;
        } 
        if ($debug) { print "$file $newname\n" };
        if ($docrop) {
            system ("convert -crop $docrop \"$file\" \"$newname\"");
            unlink ("$file");
        } else {
            rename ("$file", "$newname") unless (($file eq $newname) || (-e "$newname")) ;
        }
        if ($debug) { print "$file $pdfname\n" };
        if ($doocr) {
            system ("tesseract -l $doocr \"$newname\" \"$pdfname\" pdf");
        } 
        if ($dodelete) {
            unlink ("$newname");
        }
    }
    if ($doocr && $docrop && $domerge) {
        system ("pdfjam --fitpaper 'true' --outfile $domerge *.pdf");
    } elsif ($doocr && $domerge) {
        system ("pdfjam --outfile $domerge *.pdf") unless (-e "$domerge");
    }


__END__

=head1 NAME

processcans - process scanned images

=head1 SYNOPSIS

processscans [options] [directory ...]

 Options:
   -h|--help
   -o|--ocr <language>
   -c|--crop <dimensions>
   -r|--reverse
   -m|--merge <outfile>

=head1 OPTIONS

=over 8

=item B<-h|--help>

Print a brief help message and exit.

=item B<-o|--ocr>

OCR via tesseract and save to pdf. Default language is german, otherwise
specify as a string tesseract understands, such as "eng". 

=item B<-c|--crop>

Crop. Defaults to A4 at 200dpi. Otherwise specificy dimensions in a 
format GraphicsMagick understands, such as 1696x2396+0+0

=item B<-r|--reverse>

It assumes a whole stack of images scanned in first on one side, 
and then the whole stack turned over and scanned from the other side.
It needs an even number of files in the directory, the first page 
being the first in the directory, the second page being the last in the
directory, the third being the second in the directory, the forth being
the second-to-last in the directory and so on.

=item B<-m|-merge>

Merge resulting pdf files into one big pdf. You can specify a filename,
otherwise it will use "1.pdf"

=item B<-d|-delete>

Delete original and converted image files.

=back

=head1 DESCRIPTION

B<This program> will process scanned images in the current directory.


=cut
