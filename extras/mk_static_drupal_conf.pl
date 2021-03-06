#!/usr/bin/perl -w
# run on linux appserver todo: update paths for *bsd servers.

use DateTime qw();
my $nowstring =	DateTime->now->strftime('%d%b%Y');
my $staging_dir = '/path/to/staging/dir/';
my $config_dir = '/etc/nginx/sites-available/';
open(VIRTUALS, "virt_domains.list.test") or die $!;
my @domains = <VIRTUALS>;

foreach (@domains) { 
   chomp($_);

   my $config_filename = "static.$_.conf";
   my $config_path = $config_dir.$config_filename;

   my $string = "# Generated via script on $nowstring. \n\n"; 
   $string .= "server \{\n\n";
   $string .= "        listen       80;\n";
   $string .= "        listen       [::]:80;\n";
   $string .= "        server_name  www.$_;\n";
   $string .= "        rewrite ^    https://$_\$request_uri? permanent;\n";
   $string .= "\}\n\n";
   $string .= "server \{\n\n";
   $string .= "        listen       80;\n";
   $string .= "        listen       [::]:80;\n";
   $string .= "        server_name  $_;\n";  
   $string .= "        root /var/www/html/live/m.$_; ## <-- Your only path reference.\n";
   $string .= "        include snippets/rsyncster_static_sites.conf;\n"; # must exist. we do not create
   $string .= "\}\n";

   open(STATIC_CONFIG, ">$config_path") or die $!;
   print STATIC_CONFIG $string;
   close STATIC_CONFIG;
}
