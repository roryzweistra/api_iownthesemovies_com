package api_iownthesemovies_com::Rest::Media;

use Wing::Perl;
use Wing;
use Dancer;
use Wing::Rest; 



get '/api/media' => sub {
    my $user = get_user_by_session_id();
    my $data = site_db()->resultset('Media')->search(undef,{order_by => 'name'});
    #return format_list($data, current_user => $user); 
    return format_list($data); 
};

generate_crud('Media');

1;
