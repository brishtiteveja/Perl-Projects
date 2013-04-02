$line = <>;
if(@ARGV != 1){
		print STDERR "Usage:$0 <index file>";
		exit;
	}
@queryTerms = ();																		#defining empty query term array
%weight = ();																			#defining empty hash
@docs = ();																			    #defining empty document array

do{
	chomp($line);
	if(@ARGV == 1){ 		
		$line =~ /[0-9]+\s(\S*)$/;														#extracting from the index file
		push(@queryTerms,$1);
	}
	if(@ARGV == 0){																	#extracting from the afterStemming file
		$line =~ /([A-Za-z][0-9]+)\s(\S*)\s[0-9]+\s[0-9\.]+\s([0-9\.]+)/;
		$docid = $1;																	#extracting the document id
		$term = $2;																		#extracting the term
		$weight{$term}{$docid} = $3;												    #extracting the term frequency
#		print "$docid\n";
		if(@docs){																		#if not empty
			$c = 0;																		#initial count is zero
			foreach $doc (@docs){														# If there exists similar element inside @docs then count will increase 		
				if($doc eq $docid){
					$c += 1;
				}
			}
			if($c == 0){																#count = 0 means there exists no similar element inside @docs
				push(@docs,$docid);
			}
		}else{
#			print "$docid ok\n";
			push(@docs,$docid);															#if empty
		} 																					#end if																				#end while
	}
}while($line=<>);																		#end do while

%score = ();																			#empty score hash
foreach $docid (@docs){																	#initializing the hash key with each query terms
	if(defined($score{$docid})){
			
	}else{																				#if the hash key value is not defined then define
		$score{$docid} = 0;																#initially scores are zero
	}
}

foreach $docid (@docs){
	foreach $qterm (@queryTerms){
		if(exists $weight{$qterm}{$docid}){												#if query term exists in the doc then
			$score{$docid} += $weight{$qterm}{$docid};									#adding all the weights of the doc
		}
	}
}

$hit = 0;
foreach $docid (@docs){
	if($score{$docid} != 0){															
		$hit ++;																	  #if the doc has any score then it is considered as a searched document
	}
}
print "hit = $hit\n";

foreach $docid (sort {$score{$b}<=>$score{$a}} (keys %score)){						 #sorting the hash with descending values for the hash keys
	print "$docid $score{$docid}\n";												 #printing docid and their score values.  
}






