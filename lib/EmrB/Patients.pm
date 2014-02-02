package EmrB::Patients;
use Mojo::Base 'EmrB';

#sub rest_list {
#  my $self = shift;
#  $self->render(json => {data => $self->dbh->selectall_arrayref("SELECT * FROM emra_patients patients")});
#}

sub rest_list { shift->SUPER::rest_list('* FROM emrb_patients patients') }

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
 
1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid', url => "/emr_b/patient";
% title 'Patients';
% content_for 'colM' => begin
  { title: "ID", width: 190 },
  { title: "Name", width: 160 },
  { title: "SSN", width: 160 },
  { title: "DoB", width: 190 },
  { title: "Nationality", width: 190 }
% end
