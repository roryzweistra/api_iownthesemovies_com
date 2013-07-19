package api_iownthesemovies_com::Web::Media;

use Dancer ':syntax';
use Wing::Perl;
use Ouch;
use Wing;
use Wing::Web;




get '/media' => sub {
    my $user = eval { get_user_by_session_id(); };
    my $vars = {};
    if ($user) {
        $vars->{current_user} = describe($user, current_user => $user);
    }
    template 'media/index', $vars;
};

post '/media' => sub {
    my $current_user = get_user_by_session_id();
    my $media = site_db()->resultset('Media')->new({});
    my %params = params();
    eval {
        $media->verify_creation_params(\%params, $current_user);
        $media->verify_posted_params(\%params, $current_user);
    };
    if (hug) {
        return redirect '/media?error_message='.bleep;
    }
    else {
        $media->insert;
        return redirect '/media/'.$media->id.'?success_message=Created successfully';
    }
};

get '/media/:id' => sub {
    my $current_user = eval { get_user_by_session_id(); };
    my $media = fetch_object('Media');
    my $vars = {
        media         => describe($media, current_user => $current_user),
    };
    if ($current_user) {
        $vars->{current_user} = describe($current_user, current_user => $current_user);
    }
    template 'media/view_edit', $vars;
};

put '/media/:id' => sub {
    my $current_user = get_user_by_session_id();
    my $media = fetch_object('Media');
    $media->can_edit($current_user);
    my %params = params();
    eval {
        $media->verify_posted_params(\%params, $current_user);
    };
    if (hug) {
        return redirect '/media/'.$media->id.'?error_message='.bleep;
    }
    else {
        $media->update;
        return redirect '/media/'.$media->id.'?success_message=Created successfully';
    }
    return redirect '/api_iownthesemovies_com/'.$media->id;
};

del '/media/:id' => sub {
    my $current_user = get_user_by_session_id();
    my $media = fetch_object('Media');
    $media->can_edit($current_user);
    $media->delete;
    return redirect '/?success_message=Deleted successfully';
};

true;
