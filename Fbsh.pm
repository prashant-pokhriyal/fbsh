package Fbsh;
use 5.010;
use base qw(Term::Shell);
use Facebook::OpenGraph;
use Data::Dumper qw(Dumper);

$| = 1;

sub prompt_str {
  'fbsh> '
}

sub init {
  my $self = shift;
  my ($app_id, $app_secret);
  print 'App ID: ';
  chomp($spp_id = <>);
  print 'App Secret: ';
  chomp($app_secret = <>);
  print 'Access Token: ';
  chomp($access_token = <>);

  # get access_token for application
  my $fb = Facebook::OpenGraph->new(+{
      app_id => $app_id,
      secret => $app_secret,
      access_token => $access_token
  });

  my $user;
  if($user = $fb->fetch('me')) {
    say '=======================================================================';
    say '                   Welcome! ', $user->{'name'},' ';
    say '=======================================================================';
  }
  $self->{'fb'} = $fb;
}

sub run_me {
  $self = shift;
  $fb = $self->{'fb'};
  my $my = $fb->fetch('me',{'fields' => 'id, name, birthday, about, education, email, age_range, hometown, gender, favorite_teams'});
  say 'ID: ' . $my->{'id'};
  say 'Name: ' . $my->{'name'};
  say 'Gender: ' . $my->{'gender'};
  say 'email: ' . $my->{'email'};
  say 'Birthday: ' . $my->{'birthday'};
  say 'Hometown: ' . $my->{'hometown'}->{'name'};
  print 'favorite Teams: ';map{ print $_->{'name'},' '; }@{$my->{'favorite_teams'}};
  say;
}
