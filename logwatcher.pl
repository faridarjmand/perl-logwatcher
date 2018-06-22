#!/bin/perl
################# Created By.Farid Arjmand ################

use strict;
#use warnings;
use IO::File;
use File::Tail;
#use Term::ANSIColor;
use Switch;

##########################################################
################### Color modifiers ######################
##########################################################

# print(colored([$mod, $fg, $bg], ' Text '));
#my @mods = ('', 'bold', 'dark', 'underline', 'blink', 'reverse', 'concealed');
#my @fgs  = ('black', 'red', 'blue', 'yellow', 'green', 'magenta', 'cyan', 'white');
#my @bgs  = ('', 'on_black', 'on_red', 'on_blue', 'on_yellow', 'on_green', 'on_magenta', 'on_cyan', 'on_white');

my $green="\e[1;1;32m"; 	# Foreground Green
my $red="\e[1;1;31m"; 		# Foreground Red
my $yelloo="\e[1;1;33m"; 	# Foreground Yellow
my $GREEN="\e[1;1;42m"; 	# Background Green
my $RED="\e[1;1;41m"; 		# Background Red
my $YELLO="\e[1;1;43m"; 	# Background Yellow
my $nc="\e[0m";			# No Color

##########################################################
########################## MAIN ##########################
##########################################################

main(@ARGV);

##########################################################
####################### Functions ########################
##########################################################

sub main
{
	my $Switch = $ARGV[0];
	my $FILENAME = $ARGV[1];
	print("Your Switch is : [ $yelloo$Switch$nc ] \n\n");
	error("missing filename") unless $FILENAME;
	switch ($Switch)
	{
		case '-tail' {tail ($FILENAME);}
		case '-count' {count ($FILENAME);}
		else {print "\nUsage: tail.pl switch:[-tail|-count] file_name\n";}
	}
}
sub count
{
	my $FILENAME = shift;
	my $COUNTFILE = IO::File->new( $FILENAME, "r"  ) or error("can't open $FILENAME ($!)\n");
	my $COUNT = 0;
	$COUNT++ while( $COUNTFILE->getline  );
	print("There are $green$COUNT$nc lines in $yelloo$FILENAME$nc\n\n");
	return $COUNT;
}
sub tail
{
	my $FILENAME = shift;
	my $TAILFILE = File::Tail->new( $FILENAME  ) or error("can't open $FILENAME ($!)\n");
	while (defined(my $LINEFILE=$TAILFILE->read))
	{
		if($LINEFILE=~m/error/){$LINEFILE=~s/error/$red error $nc/gi;}
		print "$LINEFILE";
	}
}
sub error
{
	my $e = shift || 'unkowne error';
	print("$0: $e\n");
	exit 0;
}

##########################################################
########################## END ###########################
##########################################################
