#!/usr/bin/env perl
#This is an example of Using Mojolicious with MVCimple. I decided to use our MVCimple engine 
use Mojolicious::Lite;
use XML::Simple;
use lib '../lib/';
use MVCimple::BaseModel;
use MVCimple::Types;
use MVCimple::RenderView;

#The model read from the config globally
my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
my $Person = new MVCimple::BaseModel('person',$xmldata->{models}->{person});



get '/' => sub {
    my $self = shift;
    my $viewdata = $Person->get_forms();
    $self->render_text(MVCimple::RenderView::render('templates/default.html',$viewdata));
};

any '/submit' => sub {
    my $self = shift;
    $Person->store_input($self);
    my $validate = $Person->validate();
    if($validate->{error}) {
        $self->render_text($validate->{error});
    }
    else {
        my $data = $Person->get_values();
        $self->render_text(MVCimple::RenderView::render('templates/submit.html',$data));
    }


};

app->start;

