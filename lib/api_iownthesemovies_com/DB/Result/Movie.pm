package api_iownthesemovies_com::DB::Result::Movie;

use Moose;
use Wing::Perl;
use Ouch;
extends 'Wing::DB::Result';

with 'Wing::Role::Result::Field';
#with 'Wing::Role::Result::PrivilegeField';
#with 'Wing::Role::Result::Child';
with 'Wing::Role::Result::Parent';

__PACKAGE__->wing_fields(
    imdb    => {
        dbic 		=> { data_type => 'varchar', size => 60, is_nullable => 1 },
        view		=> 'public',
    },
);

#__PACKAGE__->wing_privilege_fields(
###Add privileged fields here
#);
#
#__PACKAGE__->wing_children(
###Add children here
#);
#
__PACKAGE__->wing_parent(
    media   => {
        view            => 'public',
        edit            => 'required',
        related_class   => 'api_iownthesemovies_com::DB::Result::User',
    }
);



__PACKAGE__->wing_finalize_class( table_name => 'movies');

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

