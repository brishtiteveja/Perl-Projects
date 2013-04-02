#末尾のA-Z,a-z,0-9英数字以外の文字例えば.,!を削除
#複数形への対応(末尾のsやesを削除)
#過去形への対応(末尾のedを削除)
#全ての大文字を小文字に変化

#$file = 'chuukan2';
#open(IN,$file) || die "$file: $!";

while($line = <>){#<IN>){
	chomp($line);
	if($line =~ /(\S*\s\S*)[^A-Za-z0-9]$/){
		$line = $1;
	}
#	print $line,"\n";
	$line =~ /([A-Za-z])(\S*\s\S*)/;
	$line2 = $2;

	
	if($line =~ /([A-Za-z])(\S*\s\S*)(s|es|ed)$/){
		print $1,$2,"\n";
	}else{
		print $1,$line2,"\n";
	}
}
