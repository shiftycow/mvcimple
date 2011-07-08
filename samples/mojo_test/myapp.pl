#!/usr/bin/env perl
#This is an example of Using Mojolicious with MVCimple. I decided to use our MVCimple engine 
use Mojolicious::Lite;
use XML::Simple;
use lib '../../lib/';
use MVCimple::App;

#The model read from the config globally

#Read our Model in from XML
my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
my $Person = new MVCimple::BaseModel('person',$xmldata->{models}->{person});

#Read in the Application config file
my $config = new MVCimple::Config('myapp.conf','.');

#Connect to the Database
my $dbh = MVCimple::DBConnect::connect($config);

has 'types' => sub {
  return {
    atom => 'application/atom+xml',
    bin  => 'application/octet-stream',
    css  => 'text/css',
    gif  => 'image/gif',
    gz   => 'application/gzip',
    htm  => 'text/html',
    html => 'text/html;charset=UTF-8',
    ico  => 'image/x-icon',
    jpeg => 'image/jpeg',
    jpg  => 'image/jpeg',
    js   => 'application/x-javascript',
    json => 'application/json',
    mp3  => 'audio/mpeg',
    png  => 'image/png',
    rss  => 'application/rss+xml',
    svg  => 'image/svg+xml',
    tar  => 'application/x-tar',
    txt  => 'text/plain',
    woff => 'application/x-font-woff',
    xml  => 'text/xml',
    zip  => 'application/zip'
  };
};



get '/' => sub {
    my $self = shift;
    my $viewdata = $Person->get_forms();
    $self->render_text(MVCimple::RenderView::render('templates/default.html',$viewdata));
};

get '/view' => sub {

    my $self = shift;
    my $person_data = $Person->load($dbh);
    my $person_xml = '<?xml-stylesheet type="text/xsl" href="xsl/person.xsl"?>' . "\n";
    $person_xml .= $xml->XMLout($person_data->{data});
    $self->render(data =>$person_xml, format=>'xml');

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
        my $result = $Person->save($dbh);
        $data->{'id'} = $result->{'row_id'};
        $self->render_text(MVCimple::RenderView::render('templates/submit.html',$data));
    }
};

app->start;

