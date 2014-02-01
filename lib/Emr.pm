package Emr;
use Mojo::Base 'Mojolicious::Controller';

use DBI;

our $dbi;

has dbh => sub { $dbi ||= DBI->connect("dbi:mysql:sql228584;host=sql2.freemysqlhosting.net", 'sql228584', 'rF5*eP5%') };

sub rest_list {
  my $self = shift;
  #$self->render(json => {data => [values(%{$self->dbh->selectall_hashref("SELECT * FROM emra_patients patients", 'id')})]});
  $self->render(json => {data => $self->dbh});
}

sub rest_create {
  my $self = shift;
  $self->render(text => 'Create: '.scalar localtime);
}
 
sub rest_show {
  my $self = shift;
  my ($id) = $self->param('patientsid');
  $self->render(text => "Show $id: ".scalar localtime);
}
 
sub rest_remove {
  my $self = shift;
  my ($id) = $self->param('patientsid');
  my $data = $self->dbh;
  splice(@$data, $id, 1);
  $self->render(json => {data => $data});
}
 
sub rest_update {
  my $self = shift;
  my ($id) = $self->param('patientsid');
  $self->render(text => "Update $id: ".scalar localtime);
}
 
sub index {
  my $self = shift;
  push @{$self->app->renderer->classes}, __PACKAGE__ unless grep { $_ eq __PACKAGE__ } @{$self->app->renderer->classes};
  push @{$self->app->renderer->classes}, ref $self unless grep { $_ eq ref $self } @{$self->app->renderer->classes};
  $self->render(lc(((split /::/, ref $self))[-1]).'/index');
}

1;

__DATA__
@@ layouts/pqgrid.html.ep
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/base/jquery-ui.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>    
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
   
    <style>
        .pq-grid-crud-popup *
        {
            font-family:Tahoma;
            font-size:11px;        
        }
        .pq-grid-crud-popup form.pq-grid-crud-form
        {
            margin-top:10px;
        }
        .pq-grid-crud-popup form.pq-grid-crud-form input
        {
            width:300px;
            overflow:visible;/*fix for IE*/
        }
        .pq-grid-crud-popup form.pq-grid-crud-form td.label
        {
            font-weight:bold;padding-right:5px;
        }
        div.pq-grid-toolbar-crud-remote
        {
            text-align:center;
        }
    </style>
    <!--ParamQuery Grid files-->
    <link rel="stylesheet" href="/pqgrid.dev.css" />
    <script type="text/javascript" src="/pqgrid.dev.js" ></script>   
    <script type="text/javascript" src="/pqGridCrud.js" ></script>   
    <script>
        $(function () {
            var colM = [
                <%= content_for 'colM' %>
            ];
            var dataModel = {
                location: "remote",
                sorting: "local",
                paging: "local",
                dataType: "JSON",
                method: "GET",
                //sortIndx: "contact",
                url: "<%= $url %>",
                sortDir: "up",
                getData: function (dataJSON) {
                    var data = dataJSON.data;
                    return { data: dataJSON.data };
                }
            };
            var newObj = {
                flexHeight: true,
                flexWidth: true,
                dataModel: dataModel,
                bottomVisible: true,
                selectionModel: { mode: 'single' },
                editable: false,
                colModel: colM,
                scrollModel: { horizontal: false },
                //title: "Contact Details",
                columnBorders: true
            };
            if ( colM != null ) {
                var $grid = $("#grid_crud-remote").pqGridCrud(newObj);
            } else {
                $('#grid_crud-remote').html("colM not defined");
            }
        });
    </script>    
  </head>
  <body>
    <div id="grid_crud-remote"></div>
  </body>
</html>
