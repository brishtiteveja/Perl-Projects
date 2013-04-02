#$file = 'chuukan1';
@unnecessary = ('a','an','and','as','to','am','but','or','in','of','the','is','are','you','was','were');

#open(IN,$file) || die "$file: $!";
while($line = <>){#<IN>){
	chomp($line);
	$line =~ /([A-Za-z][0-9]*\s)(\S*)/;
	$first = $1;
	$second = $2;
	$second =~ tr /A-Z/a-z/;
	$wordPerLine = $second;
	@match = grep($_ eq $wordPerLine,@unnecessary);
	$sz = @match;
#	print $sz,"\n";
	if($sz eq 0){
		print $first,$second,"\n";			
	} 
}
