#!/usr/bin/perl
# Simple script to extract a function from a curly-brace-language source file

use strict;
use re 'eval';
use File::Basename;
use Text::Balanced qw(extract_bracketed);

my $function = shift(@ARGV);

foreach my $file (@ARGV) {
	local $/;
	open SRC, $file or (warn "Unable to open $file" and next);
	my $src = <SRC>;
	my($body, $remainder);
	if ($src =~ /^((?:\w+\s+)+(?:\w+::)?$function\s*\([^)]*\)\s*(?={))/mg and (($body, $remainder) = extract_bracketed($src, '{}'))) {
		my ($declaration, $comment, $previous);
		$declaration = $1;
		$previous = $`;
		if ($previous =~ /\*\/\r?\n$/) {
			$comment = substr($previous, rindex($previous, '/*'));
		}
		open OUT, "> $function-" . basename($file);
		print OUT "$comment$declaration$body\n";
		close OUT;
		print "$file: extracted about " . scalar(@{[($body =~ /\n/g)]}) . " lines\n";
	}
	close SRC;
}

