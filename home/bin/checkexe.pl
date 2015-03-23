#!/usr/bin/perl -w
# From http://stackoverflow.com/a/8141548/25507,
# "Comparing generated executables for equivalence", by David Tonhofer

$exe = $ARGV[0];

if (!$exe) {
   die "Please give name of executable\n"
}
if (! -f $exe) {
   die "Executable $exe not found or not a file\n";
}
if (! (`file '$exe'` =~ /\bELF\b.*?\bexecutable\b/)) {
   die "file command says '$exe' is not an ELF executable\n";
}

# Identify sections in ELF

@lines = pipeIt("readelf --wide --section-headers '$exe'");

@sections = ();

for my $line (@lines) {
   if ($line =~ /^\s*\[\s*(\d+)\s*\]\s+(\S+)/) {
      my $secnum = $1;
      my $secnam = $2;
      print "Found section $1 named $2\n";
      push @sections, $secnam;
   }
}

# Dump file header

@lines = pipeIt("readelf --file-header --wide '$exe'");
print @lines;

# Dump all interesting section headers

@lines = pipeIt("readelf --all --wide '$exe'");
print @lines;

# Dump individual sections as hexdump

for my $section (@sections) {
   @lines = pipeIt("readelf --hex-dump='$section' --wide '$exe'");
   print @lines;
}

sub pipeIt {
   my($cmd) = @_;
   my $fh;
   open ($fh,"$cmd |") or die "Could not open pipe from command '$cmd': $!\n";
   my @lines = <$fh>;
   close $fh or die "Could not close pipe to command '$cmd': $!\n";
   return @lines;
}
