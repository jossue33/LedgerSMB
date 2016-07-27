#!/usr/bin/perl

use Module::CPANfile;
use File::Find;
BEGIN { 
 local $@;
  eval { 
   require Test::Dependencies;
   if ($Test::Dependencies::VERSION < 0.20) {
       require Test::More;
       Test::More::plan(skip_all =>'Must have Test::Dependencies version 0.20 or higher, had version ' . $Test::Dependencies::VERSION);
       exit 0;
   }
   Test::Dependencies->import();
  };
  if ($@){
       require Test::More;
       Test::More::plan(skip_all => 'Must have Test::Dependencies version 0.20 or higher');
       exit 0;
  }
}
   

BEGIN { 
 sub skip_all {
   my $reason = shift;
   require Test::More;
   Test::More::plan(skip_all => $reason);
   exit 0;
 }
 local $@;
  eval { 
   require Test::Dependencies;
   if ($Test::Dependencies::VERSION < 0.20) {
       skip_all('Must have Test::Dependencies version 0.20 or higher, had version ' . $Test::Dependencies::VERSION);
   }
   Test::Dependencies->import();
  };
  warn $@;
  if ($@){
       skip_all('Must have Test::Dependencies version 0.20 or higher');
  }
}
   

use Test::Dependencies exclude =>
  [ qw/ LedgerSMB PageObject / ],
  style => 'light';;


use Data::Dumper;

my $file = Module::CPANfile->load;

my @on_disk = ();
sub collect {
    return if $File::Find::name !~ m/\.(pm|pl)$/;

    my $module = $File::Find::name;
    push @on_disk, $module
}
find(\&collect, 'lib/', 'bin/');

push @on_disk, 'tools/starman.psgi';

ok_dependencies($file, \@on_disk,
                phases => 'runtime',
                ignores => [ 'App::LedgerSMB::Admin', 'Image::Size',
                             'LaTeX::Driver', 'PGObject::Util::DBAdmin',
                             'Starman', 'TeX::Encode::charmap'] );

