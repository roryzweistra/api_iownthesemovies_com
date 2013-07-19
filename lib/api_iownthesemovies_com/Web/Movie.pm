package api_iownthesemovies_com::Web::Movie;

use Dancer ':syntax';
use Wing::Perl;
use Ouch;
use Wing;
use Wing::Web;




get '/movie' => sub {
    my $user = eval { get_user_by_session_id(); };
    my $vars = {};
    if ($user) {
        $vars->{current_user} = describe($user, current_user => $user);
    }
    template 'movie/index', $vars;
};

post '/movie' => sub {
    my $current_user = get_user_by_session_id();
    my $movie = site_db()->resultset('Movie')->new({});
    my %params = params();
    eval {
        $movie->verify_creation_params(\%params, $current_user);
        $movie->verify_posted_params(\%params, $current_user);
    };
    if (hug) {
        return redirect '/movie?error_message='.bleep;
    }
    else {
        $movie->insert;
        return redirect '/movie/'.$movie->id.'?success_message=Created successfully';
    }
};

get '/movie/:id' => sub {
    my $current_user = eval { get_user_by_session_id(); };
    my $movie = fetch_object('Movie');
    my $vars = {
        movie         => describe($movie, current_user => $current_user),
    };
    if ($current_user) {
        $vars->{current_user} = describe($current_user, current_user => $current_user);
    }
    template 'movie/view_edit', $vars;
};

put '/movie/:id' => sub {
    my $current_user = get_user_by_session_id();
    my $movie = fetch_object('Movie');
    $movie->can_edit($current_user);
    my %params = params();
    eval {
        $movie->verify_posted_params(\%params, $current_user);
    };
    if (hug) {
        return redirect '/movie/'.$movie->id.'?error_message='.bleep;
    }
    else {
        $movie->update;
        return redirect '/movie/'.$movie->id.'?success_message=Created successfully';
    }
    return redirect '/api_iownthesemovies_com/'.$movie->id;
};

del '/movie/:id' => sub {
    my $current_user = get_user_by_session_id();
    my $movie = fetch_object('Movie');
    $movie->can_edit($current_user);
    $movie->delete;
    return redirect '/?success_message=Deleted successfully';
};

true;
