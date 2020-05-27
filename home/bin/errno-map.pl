#!/usr/bin/perl

use strict;
use POSIX qw(strerror);

my %errno;

my $root = '/';
if (-x '/usr/bin/xcrun') {
    $root = `/usr/bin/xcrun --show-sdk-path`;
    chomp $root;
}
open ERRNO, "cpp -dM \"$root/usr/include/errno.h\" |";
while (<ERRNO>) {
	if (/^#define (E[A-Z]+) (\d+)$/) {
		$errno{$2} = $1;
	}
}

foreach (sort { $a <=> $b } keys %errno) {
	printf "%-15s %4i %s\n", $errno{$_}, $_, strerror($_);
}
