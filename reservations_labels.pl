#
# MAIN
#
# 07/12/2011 
# MZ: takes group linked reservations and prints name/room number combinations for labels
# --splitrooms option splits name into separate labels for roommates
#
#
# works only with PAR Springer-Miller Report: 5AR Groups/Others -> Linked Reservations -> Linked Reservations

if ($#ARGV < 0) {
	print "Usage:  reservations_label.pl <file name> [--splitrooms]";
	exit(0);
}

$filename = $ARGV[0];

@guest_list_names = ();
@guest_list_rooms = ();

push(@guest_list_names, '_name');
push(@guest_list_rooms, '_room');
					
# open file for reading
open filet, "<$filename" or die "Can't find File: $filename\n";

while ( ! eof(filet) ) {
	$line = readline(filet);
	# skip lines that aren't reservations -- like headings etc.
	if(substr($line, 33, 1) eq "G" && substr($line, 40, 1) eq "G") {
		$room_num = substr $line, 34, 3;
		$guest_name = substr $line, 0, 25;
		# has roommates
		if($ARGV[1] eq "--splitrooms" && index($guest_name, '/') >= 0) {			
			# some last name combinations are so long, they don't have room for any first names
			# if no comma, split on /
			# handle case: <last_name>/<last_name>
			if(index($guest_name, ',') < 0) {
				@x = split('/', $guest_name);
				foreach(@x) {
					$guest_name_trim = trim($_);
					push(@guest_list_names, $guest_name_trim);
					push(@guest_list_rooms, $room_num);
				}
			# split roommates	
			} else {
				@x = split(',', $guest_name);
				@last_names = split('/', $x[0]);
				@first_names = split('/', $x[1]);
				
				$size_array = scalar @last_names;
				$size_array2 = scalar @first_names;
				
				if ($size_array < $size_array2) {
					$size_array = $size_array2;
				}
				
				for($i=0; $i<$size_array; $i++) {
					# handle case: <last_name>, <first_name>/<first_name>
					if ($last_names[$i] eq "") {
						$last_names[$i] = $last_names[$i-1];
					}
					$guest_name = trim($last_names[$i]) . ", " . trim ($first_names[$i]);
					push(@guest_list_names, $guest_name);
					push(@guest_list_rooms, $room_num);					
				}
				# if no criteria met, display line
			}
		# no roommates, just one full name
		} else {
			$guest_name_trim = trim($guest_name);
			push(@guest_list_names, trim($guest_name));
			push(@guest_list_rooms, $room_num);
		}

	}
}
close filet;

$size_array = scalar @guest_list_names;
for($i=0; $i<$size_array; $i++) {
	print $guest_list_names[$i] . "\t" . $guest_list_rooms[$i] . "\n";
}

sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}
