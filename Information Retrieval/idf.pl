#$file = 'chuukan4';

#open(IN,$file) || die "$file: $!";

%tf = ();																			#defining empty hash
@docs = ();																			#defining empty document array
while($line = <>){#<IN>){
  if($line != /^[0-9]+/){
  	$N = $line;																		#Number of Documents
  	next;
  }
  else{	
	$line =~ /([A-Za-z][0-9]+)\s(\S*)\s([0-9]+)/;
	$docid = $1;																	#extracting the document id
	$term = $2;																		#extracting the term
	$tf{$term}{$docid} = $3;														#extracting the term frequency
	
#	print $docid," ",$term," ",$tf,"\n";
	
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
		push(@docs,$docid);															#if empty
	}
  }																					#end if
}																					#end while
																	
%df = ();																			#empty document hash
foreach $term (sort keys %tf){
	$df{$term} = 0;
	foreach $doc (@docs){
		if($tf{$term}{$doc} > 0){
			$df{$term} += 1;
#			print $term," ",$doc,"\n"												#This can show which word exists how many times in which documents
		}
	}
}

%idf = ();																			#inverse document frequency
foreach my $docid (sort @docs){														#for each document from D001 ~ D008
	foreach my $term (sort keys %tf){     
			if(exists $tf{$term}{$docid}){
				$idf{$term} = log($N/$df{$term}) + 1 ;
				$weight = $tf{$term}{$docid} * $idf{$term};
				printf("$docid $term $tf{$term}{$docid} %.2f %.2f\n",$idf{$term},$weight);
			}
	}
}

