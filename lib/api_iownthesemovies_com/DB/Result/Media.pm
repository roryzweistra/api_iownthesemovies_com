package api_iownthesemovies_com::DB::Result::Media;

use Moose;
use Wing::Perl;
use Ouch;
extends 'Wing::DB::Result';

with 'Wing::Role::Result::Field';
#with 'Wing::Role::Result::PrivilegeField';
#with 'Wing::Role::Result::Child';
with 'Wing::Role::Result::Parent';
with 'Wing::Role::Result::UserControlled';

__PACKAGE__->wing_fields(
    name => {
        dbic        => { data_type => 'varchar', size => 255, is_nullable => 0 },
        view        => 'public',
        edit        => 'required',
    },

##Add more fields here
);

#__PACKAGE__->wing_privilege_fields(
###Add privileged fields here
#);
#
__PACKAGE__->wing_children(
    movies  => {
        view            => 'public',
        related_class   => 'api_iownthesemovies_com::DB::Result::Employee',
        related_id      => 'media_id',
    }
);
#
#__PACKAGE__->wing_parent(
###Add parents here
#);



__PACKAGE__->wing_finalize_class( table_name => 'medias');

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

