#$file = 'chuukan3';

#open(IN,$file) || die "$file: $!";

%tf = ();   															#empty hash
@docs = ();																	#empty document array

while($line = <>){#<IN>){
	$line =~ /([A-Za-z][0-9]+)\s(\S*)/;
	$docid = $1;  															#the document
	$term = $2;  															#the word
	
																			#creating a hash with the key and the document
																			#hash structure is as follows
																			# $tf{$term}{$docid} = value
																			# $tf{$term}{$docid} = value
																			# ...
																			# $tf{$term}{$docid} = value
	if(defined($tf{$term}{$docid})){
		$tf{$term}{$docid} += 1;
	}else{		
		$tf{$term}{$docid} = 1;
	}
	
	if(@docs){															   #if not empty
	    $c = 0;
		foreach my $doc (@docs)
		{	
			if($doc eq $docid){  										   # If there exists similar element inside @docs then count will increase 
				$c += 1;
			}
		}	
		if($c == 0){       												   #count = 0 means there exists no similar element inside @docs
			push(@docs,$docid);
		}
	}else{
		push(@docs,$docid) 												    #if empty
	} 	
}

$N = @docs;																 	#printing the number of documents 
print  $N,"\n";

foreach my $docid (sort @docs){												#for each document from D001 ~ D008
	foreach my $term (sort keys %tf){     
			if(exists $tf{$term}{$docid}){
				print $docid," ",$term," ",$tf{$term}{$docid},"\n";
			}
	}
}
