#!/usr/bin/perl

# The NextGen Initiative

# This program will help to extend our capabilities and perceptions of the future
# by utilizing the principles of object-oriented programming.

# Include the necessary Perl libraries

use strict;
use warnings;
use feature qw( say );
use File::Spec;
use File::Basename;

# Define constants

my $FILE_NAME = 'nextgen.pl';
my $NEXTGEN = 'The NextGen Initiative';

# Declare global variables

my @files;
my $file_count = 0;
my $line_count = 0;
my $file_total = 2000;

# Create a new file containing the text

my $file_path = File::Spec->catfile( File::Spec->curdir(), $FILE_NAME ); 
open my $file, '>', $file_path or die "Cannot open file: $!"; 
print $file "#!/usr/bin/perl\n\n# $NEXTGEN\n\n"; 
close $file;

# Read the content of the file

open my $file, '<', $file_path or die "Cannot open file: $!"; 
while (my $line = <$file>) { 
	$line_count++; 
} 
close $file;

# Create additional files if the line total is not reached

while ($line_count < $file_total) {
	my $file_name = $NEXTGEN . ++$file_count;
	my $file_path = File::Spec->catfile( File::Spec->curdir(), $file_name );
	open my $file, '>', $file_path or die "Cannot open file: $!";
	print $file "#!/usr/bin/perl\n\n# $NEXTGEN\n\n";
	close $file;
	push @files, $file_path;
	$line_count += 2;
}

# Append content to the files

foreach my $file (@files) {
	open my $fh, '>>', $file or die "Cannot open file: $!";
	print $fh "print \"$NEXTGEN\"\n";
	print $fh "my \$message = \"$NEXTGEN\";\n";
	print $fh "say \$message;\n";
	close $fh;
}

say "$line_count lines of code written for $NEXTGEN!";

# Run the program

system("perl $FILE_NAME");