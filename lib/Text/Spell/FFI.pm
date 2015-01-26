package Text::Spell::FFI;

use strict;
use warnings;
use Carp qw( croak );
use FFI::CheckLib ();
use FFI::Platypus ();

# ABSTRACT: Check spelling using aspell or hunspell via FFI
# VERSION

if(my $lib = FFI::CheckLib::find_lib lib => 'hunspell')
{

  my $ffi = FFI::Platypus->new;
  $ffi->lib($lib);
  $ffi->type( opaque => 'hunhandle' );
  $ffi->attach( Hunspell_create  => [ 'string', 'string' ] => 'hunhandle' );
  $ffi->attach( Hunspell_destroy => [ 'hunhandle' ] => 'void' );

}
elsif($lib = FFI::CheckLib::find_lib lib => 'aspell')
{
}
else
{
  croak "could not find a supported speller\n";
}

1;
