#!/bin/perl
##########################################
use strict;
use warnings;
use IO::File;
use File::Tail;
use Term::ANSIColor;
use Switch;
##########################################
# Color modifiers
my @mods = ('', 'bold', 'dark', 'underline', 'blink', 'reverse', 'concealed');
my @fgs  = ('black', 'red', 'blue', 'yellow', 'green', 'magenta', 'cyan', 'white');
my @bgs  = ('', 'on_black', 'on_red', 'on_blue', 'on_yellow', 'on_green', 'on_magenta', 'on_cyan', 'on_white');

$| = 1;

main(@ARGV);
sub main
{
	my $FILENAME = shift;
	colored_line('concealed', '');
	error("missing filename") unless $FILENAME;
	countines ($FILENAME);
	tail ($FILENAME);
}
sub countines
{
	my $FILENAME = shift;
	my $COUNTFILE = IO::File->new( $FILENAME, "r"  ) or error("can't open $FILENAME ($!)\n");
	my $COUNT = 0;
	$COUNT++ while( $COUNTFILE->getline  );
	message("There are $COUNT lines in $FILENAME\n");
	return $COUNT;
}
sub tail
{
	my $FILENAME = shift;
	my $TAILFILE = File::Tail->new( $FILENAME  ) or error("can't open $FILENAME ($!)\n");
	while (defined(my $LINEFILE=$TAILFILE->read))
	{
		print "$LINEFILE";
	}
}
sub message
{
	my $m = shift or return;
	print("$m\n");
}
sub error
{
	my $e = shift || 'unkowne error';
	print("$0: $e\n");
	exit 0;
}
sub colored_line
{
	    my ($mod, $fg) = @_;
	        printf(" %9s %-7s ", $mod, $fg);
		for my $bg (@bgs) {
			        print(colored([$mod, $fg, $bg], ' Text '));
				    
		}
		    print("\n");

}
