#!/usr/bin/perl -w

use strict;
use warnings;

#foreach file in the testinputs dir, 
#  start an apache with that config, 
#  make a request to the default url, 
#  save or compare to the matching file in the testoutputs dir
#  and save a rendered image of that html to the testimages dir.

use Test::Httpd::Apache2;
use HTTP::Tiny;

my $testinput_dir = './en-US/extras';
my $testoutput_dir = './en-US/extras';
my $testimage_dir = './en-US/images';
my $apache_conf_preamble = <<'EOT';

ServerName 127.0.0.1

LogLevel debug
ErrorLog /home/test/error.log


LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
CustomLog /home/test/access.log combined
#CustomLog {APACHE_LOG_DIR}/access.log combined

#ServerRoot "/home/test"
DocumentRoot /home/test

User www-data
Group www-data

#without this, autoindex is not triggered
#DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm

#IndexOptions FancyIndexing VersionSort HTMLTable NameWidth=* DescriptionWidth=* Charset=UTF-8

Options +Indexes

EOT

unlink '/home/test/access.log';
unlink '/home/test/error.log';

opendir(my $dh, $testinput_dir) || die;
my @files = grep { -f "$testinput_dir/$_" } readdir($dh);
closedir $dh;
#print "\n".join("\n", @files)."\n\n";

foreach my $file (@files) {
	next unless ($file =~ /(.*)\.conf$/);
	$file = $1;

	next if ($file =~ /~$/);

	print "==== $file\n";
	open(my $fh, "<", "$testinput_dir/$file.conf") || next;
	my $conf = do { local $/; <$fh> };
	close($fh);

	my $httpd = Test::Httpd::Apache2->new(
	    custom_conf => $apache_conf_preamble."\n".$conf,
	    required_modules => ['autoindex', 'dir', 'mime'],
#	    server_root => '/etc/apache2'
	);
	print "-- listening to http://" . $httpd->listen . "/\n";
	my $url = "http://" . $httpd->listen . "/";
	my $response = HTTP::Tiny->new->get($url);

	if (!$response->{success}) {
		print "ERROR: GET($url) $response->{status} $response->{reason}\n\n";
		next;
	}

	#print "$response->{status} $response->{reason}\n";
	# 
	#while (my ($k, $v) = each %{$response->{headers}}) {
	#    for (ref $v eq 'ARRAY' ? @$v : $v) {
	#	print "$k: $_\n";
	#    }
	#}
	 
	print $response->{content} if length $response->{content};
	print "\n----------------------\n";
#	if (!-f "$testoutput_dir/$file.html") {
		open($fh, ">", "$testoutput_dir/$file.html") || next;
		print $fh $response->{content};
		close($fh);
#	} else {
		#compare..
#	}

	#screenie
#	if (!-f "$testimage_dir/$file.jpg") {
	#http://stackoverflow.com/questions/125951/command-line-program-to-create-website-screenshots-on-linux
		# start a server with a specific DISPLAY
#print "start X\n";
		`Xvnc :11 -geometry 444x333 &`;
		# start firefox in this vnc session
#print " sleep\n";
		`sleep 5`;

	#we want 444px width :/
		`DISPLAY=:11 cutycapt --url=$url --out=$testimage_dir/large_$file.jpg  --min-width=888`;
#		`DISPLAY=:11 cutycapt --url=${url}en-US/extras/$file.html --out=$testimage_dir/large_$file.jpg  --min-width=888`;
		`convert $testimage_dir/large_$file.jpg  -trim  -resize 444\\>x  $testimage_dir/$file.jpg`;

#print "start firefox\n";
#		`iceweasel -fullscreen --display :11 &`;
#chromium --ash-enable-immersive-fullscreen
#
#print "start $url\n";
#		`iceweasel --display :11 $url`;
		# take a picture after waiting a bit for the load to finish
#print " sleep\n";
#		`sleep 5`;
		#imagemagick
		#`import -window root image$count.png`;
		#scrot
#print " snapshot\n";
#		` vncsnapshot -passwd \$HOME/.vnc/passwd :11 $testimage_dir/$file.jpg`;

		# clean up when done
#print "stop X\n";
#		`vncserver -kill :11`;
#	}
}



 

 

