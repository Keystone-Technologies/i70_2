package Mojolicious::Plugin::PQGridCrud;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

sub register {
  my ($self, $app, $conf) = @_;

  #push @{$app->renderer->classes}, ref $self;

  $app->hook(before_dispatch => sub {
    my $c = shift;
    if ( my $id = $c->req->url->query->param('deleteId') ) {
      $c->req->method('DELETE');
      $c->req->url->path(join '/', $c->req->url->path, $id);
    }
    if ( defined $c->req->url->query->param('recId') ) {
      my $id = $c->req->url->query->param('recId');
      if ( $id ) {
        $c->req->method('PUT');
        $c->req->url->path(join '/', $c->req->url->path, $id);
      } else {
        $c->req->method('POST');
      }
    }
    $c->app->log->info($c->req->url->to_string);
  });
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::PQGridCrud - Mojolicious Plugin to make ParamQuery Grid requests RESTFUL

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('PQGridCrud');

  # Mojolicious::Lite
  plugin 'PQGridCrud';

=head1 DESCRIPTION

L<Mojolicious::Plugin::PQGridCrud> is a L<Mojolicious> plugin to convert ParamQuery Grid non-REST requests to REST.

=head1 METHODS

L<Mojolicious::Plugin::PQGridCrud> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
