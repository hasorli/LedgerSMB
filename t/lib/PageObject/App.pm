package PageObject::App;

use strict;
use warnings;

use Carp;
use PageObject;


use Moose;
extends 'PageObject';

use PageObject::App::Main;
use PageObject::App::Menu;

has menu => (is => 'ro', builder => '_build_menu', lazy => 1);
has maindiv => (is => 'ro', builder => '_build_maindiv', lazy => 1);

sub _build_menu { return PageObject::App::Menu->new(%{(shift)}); }
sub _build_maindiv { return PageObject::App::Main->new(%{(shift)}); }


sub _verify {
    my ($self) = @_;

    $self->menu->verify;
    $self->maindiv->verify;

    return $self;
};

sub verify_screen {
    my ($self) = @_;

    my $content = $self->maindiv->content;
    $content->verify;

    return $content;
}

__PACKAGE__->meta->make_immutable;

1;
