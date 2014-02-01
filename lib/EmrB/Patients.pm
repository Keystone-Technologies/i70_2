package EmrB::Patients;
use Mojo::Base 'EmrB';

has 'dbh' => sub { [ map {
  {
    recId => $_,
    com => scalar localtime,
    con => scalar localtime,
    tit => scalar localtime,
    add => scalar localtime,
  } } (1..20)]
};

1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid', url => "/emr_b/patient";
% title 'Patients';
% content_for 'colM' => begin
  { title: "Company Name", width: 190, dataIndx: "com" },
  { title: "Contact Name", width: 160, dataIndx: "con" },
  { title: "Contact Title", width: 160, dataIndx: "tit" },
  { title: "Address", width: "190", dataIndx: "add" }
% end
