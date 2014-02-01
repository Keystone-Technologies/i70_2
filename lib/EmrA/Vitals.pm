package EmrA::Vitals;
use Mojo::Base 'EmrA';

has 'dbh' => sub { [ map {
  {
    recId => $_,
    v1 => scalar localtime,
    v2 => int(rand(100)+1),
    v3 => scalar localtime,
    v4 => int(rand(100)+1),
    v5 => scalar localtime,
    v6 => int(rand(100)+1),
  } } (1..8)]
};

1;

__DATA__
@@ vitals/index.html.ep
% layout 'pqgrid', url => "/emr_a/vital";
% title 'Vitals';
% content_for 'colM' => begin
  { title: "Vital 1", width: 190, dataIndx: "v1" },
  { title: "Vital 2", width: 160, dataIndx: "v2" },
  { title: "Vital 3", width: 160, dataIndx: "v3" },
  { title: "Vital 4", width: 190, dataIndx: "v4" },
  { title: "Vital 5", width: 160, dataIndx: "v5" },
  { title: "Vital 6", width: 190, dataIndx: "v6" }
% end
