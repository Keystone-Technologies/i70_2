package EmrA::Patients;
use Mojo::Base 'EmrA';

has 'dbh' => sub { [ map {
  {
    recId => $_,
    company => scalar localtime,
    contact => scalar localtime,
    title => scalar localtime,
    address => scalar localtime,
  } } (1..20)]
};

1;

__DATA__
@@ patients/index.html.ep
% layout 'pqgrid', url => "/emr_a/patient";
% title 'Patients';
% content_for 'colM' => begin
  { title: "Company Name", width: 190, dataIndx: "company" },
  { title: "Contact Name", width: 160, dataIndx: "contact" },
  { title: "Contact Title", width: 160, dataIndx: "title" },
  { title: "Address", width: "190", dataIndx: "address" }
% end
