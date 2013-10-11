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

my $testinput_dir = './testinput';
my $testoutput_dir = './testoutput';
my $apache_conf_preamble = <<'EOT';

ServerName 127.0.0.1

LogLevel debug
ErrorLog /mnt/error.log


LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
CustomLog /mnt/access.log combined
#CustomLog {APACHE_LOG_DIR}/access.log combined

#ServerRoot "/var/www"
DocumentRoot /mnt

#TODO: bizzare. just loading autoindex is /not/ enough
Include mods-enabled/*.load
Include mods-enabled/*.conf

User www-data
Group www-data

IndexOptions FancyIndexing VersionSort HTMLTable NameWidth=* DescriptionWidth=* Charset=UTF-8

Options +Indexes

EOT

unlink '/mnt/access.log';
unlink '/mnt/error.log';

opendir(my $dh, $testinput_dir) || die;
my @files = grep { -f "$testinput_dir/$_" } readdir($dh);
closedir $dh;
#print "\n".join("\n", @files)."\n\n";

foreach my $file (@files) {
	print "==== $file\n";
	open(my $fh, "<", "$testinput_dir/$file") || next;
	my $conf = do { local $/; <$fh> };
	close($fh);

	my $httpd = Test::Httpd::Apache2->new(
	    custom_conf => $apache_conf_preamble.$conf,
#	    required_modules => ['autoindex'],
	    server_root => '/etc/apache2'
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
	if (!-f "$testoutput_dir/$file") {
		open($fh, ">", "$testoutput_dir/$file") || next;
		print $fh $response->{content};
		close($fh);
	} else {
		#compare..
	}
}



 

 

