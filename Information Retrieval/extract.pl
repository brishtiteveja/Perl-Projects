#$file = 'documents.txt';
#open(IN,$file) || die "$file: $!";
while($line = <>){#<IN>){
	chomp($line);	
	if($line =~ /(^\<NUM\>)(\S*)(\<\/NUM\>$)/){
		$docid = $2;
#		print $docid,"\n";
	}
	if($line =~ /([^(^\<\S*\>$)])/){
	 $fullLine = $line;
#	 print $fullLine,"\n";
	 @words = split(/ /,$fullLine);
	 $wordSize= @words;
#	 print $wordSize,"\n";
	 foreach $word (@words){
	 	print "$docid $word\n";
	 }
	}
}
close(IN);
