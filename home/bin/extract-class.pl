#!/usr/bin/perl
# Simple script to extract a class from a curly-brace-language source file

use strict;
use re 'eval';
use File::Basename;
use Text::Balanced qw(extract_bracketed);

my $class = shift(@ARGV);

foreach my $file (@ARGV) {
	local $/;
	open SRC, $file or (warn "Unable to open $file" and next);
	my $src = <SRC>;
	my($body, $remainder);
if ($src =~ /^\s*((?:\w+\s+)+(?:\w+::)?$class\s*:.*?(?={))/msg and (($body, $remainder) = extract_bracketed($src, '{}'))) {
		my ($declaration, $comment, $previous);
		$declaration = $1;
		$previous = $`;
		if ($previous =~ /\*\/\r?\n$/) {
			$comment = substr($previous, rindex($previous, '/*'));
		}

        my $output = "$comment$declaration$body";
        $output =~ s/\r//g;

		open OUT, "> $class-" . basename($file);
		print OUT "$output\n";
		close OUT;

		print "$file: extracted about " . scalar(@{[($body =~ /\n/g)]}) . " lines\n";
	}
	close SRC;
}

