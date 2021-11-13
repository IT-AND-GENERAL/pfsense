#!/usr/bin/perl
use warnings;
use strict;
use POSIX qw( strftime );

my ($customer, $instance) = @ARGV;
my $filename = "/pfsense_backups/$customer/$instance/backup.cache";
my @fields = ();

open(FH, '<', $filename) or die $!;
	<FH> =~ /^a:30:\{(.*)\}$/;
	my $data = $1;
	$data =~ s/i:(\d{10})/ts:$1/g;
	@fields = split(/ts:/, $data);
close(FH);

foreach (@fields) {
	my @val = split(/;\w+:\d+:/, $_);
	if ( defined($val[0])) { 
		print "File config-$val[0].xml -> ";
		print strftime('%Y-%m-%d %H:%M:%S', gmtime($val[0]));
		print " Version: " . substr $val[4], 1, -1;
		print " - " . substr $val[2], 1, -1;
		print "\n";
	};
}
