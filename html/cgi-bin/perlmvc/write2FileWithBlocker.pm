#!/usr/bin/perl
use warnings;
use strict;

use Fcntl qw(:flock SEEK_END); # import LOCK_* and SEEK_END constants
##############################################
# Function: miWrite
# BLOCKS the file
# Receives: 
#	$string_2_write 		= (string) a line (or group os lines) to be concat in $path_absoluto_2_file
#	$path_absoluto_2_file 	= (string) path. It MUST exist
#   $open_modes				= (>>|>) modes of open. The default is >>
#
# Returns:
#	%return{status}  = (OK|ERROR) if ERROR then returns %return{message} with descritpion of error
#
# When the program exits, the OS automatically releases all locks acquired by the program and closes all files opened by the program.
##############################################
sub miWrite($$;$){
	my ($path_absoluto_2_file,$string_2_write,$open_modes) = @_;
	$open_modes = $open_modes || ">>"; # concat by default

	# control of open_modes
	return(status=>"ERROR",message=>"Wrong open modes") unless ($open_modes =~m/^(>>|>)$/);

	unless(-e $path_absoluto_2_file){ # File exists
		return(status=>"ERROR",message=>"File must exist ".$path_absoluto_2_file);
	}
	unless(-w $path_absoluto_2_file){ # i cant write on file
		return(status=>"ERROR",message=>"Write permissions needed for ".$path_absoluto_2_file);
	}
	# At this point: open_modes is correct, file exists and Write permissions are OK
	
 	my $filehandler;
 	return(status=>"ERROR",message=>"Can't open ".$path_absoluto_2_file.": $!") unless(open($filehandler, $open_modes, $path_absoluto_2_file));
 		
 	my %return;
 	$return{status} = "OK";

    %return = &lock($filehandler);
    if($return{status} eq "OK"){  # lock went OK
    	print $filehandler $string_2_write;   # <<< no \n added at the end
    	%return = &unlock($filehandler);
    }
	return(%return);
}

# Function: lock
# receives an openend Filehandle
# Returns:
#      hash{status} = (ERROR|OK) in case of ERROR has extra key {message} with description or error
sub lock ($){
    my $fh 	= shift;
    
    unless(flock($fh, LOCK_EX)){
		return(status=>"ERROR",message=>"Cannot lock - $!");
	    # and, in case someone appended while we were waiting (seek)...
	    unless(seek($fh, 0, SEEK_END)){ 
	    	# filehandled position could be set to 0
			return(status=>"ERROR",message=>"Cannot seek - $!");
	    }
    }
	# return(status=>"ERROR",message=>"error hardcodeado en LOCK");
	return(status=>"OK");
}
# Function: unlock
# receives an openend and locked Filehandle
# Returns:
#      hash{status} = (ERROR|OK) in case of ERROR has extra key {message} with description or error
# unlock is like close(filehandler)
sub unlock ($){
    my $fh 	= shift;
    
    unless(flock($fh, LOCK_UN)){ # could not unlock
    	return(status=>"ERROR",message=>"Cannot unlock mailbox - $!");
    }
	# return(status=>"ERROR",message=>"error hardcodeado en UNlock");
	return(status=>"OK");
}

# NOT FOR PRODUCTION, just for testing
# it is a copy of miWrite
sub miWriteWITHSLEEP($$;$){
	my ($path_absoluto_2_file,$string_2_write,$open_modes) = @_;
	$open_modes = $open_modes || ">>"; # concat by default

	# control of open_modes
	return(status=>"ERROR",message=>"Wrong open modes") unless ($open_modes =~m/^(>>|>)$/);

	unless(-e $path_absoluto_2_file){ # File exists
		return(status=>"ERROR",message=>"File must exist ".$path_absoluto_2_file);
	}
	unless(-w $path_absoluto_2_file){ # i cant write on file
		return(status=>"ERROR",message=>"Write permissions needed for ".$path_absoluto_2_file);
	}
	# At this point: open_modes is correct, file exists and Write permissions are OK
	
 	my $filehandler;
 	return(status=>"ERROR",message=>"Can't open ".$path_absoluto_2_file.": $!") unless(open($filehandler, $open_modes, $path_absoluto_2_file));
 		
 	my %return;
 	$return{status} = "OK";

    %return = &lock($filehandler);
	sleep(10); # <<<<<<<<<<<<<<<<<<<<<<<<<< The only Diference with miWrite
    if($return{status} eq "OK"){  # lock went OK
    	print $filehandler $string_2_write;   # <<< no \n added at the end
    	%return = &unlock($filehandler);
    }
	return(%return);
}
1;