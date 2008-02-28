use Module::Build;

my $builder = Module::Build->new(

  module_name       => 'Egg::Release::Mail',
  dist_version_from => 'lib/Egg/Release/Mail.pm',
  dist_abstract     => 'lib/Egg/Release/Mail.pm',
  dist_author       => 'Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>',
  license           => 'perl',

  requires => {

    'Egg::Release'           => '3.03',
    'Egg::Model::FsaveDate'  => '0.01',
    'Egg::Plugin::Net::Scan' => '3.00',
    'MIME::tools'            => '5.42',
    'Digest::SHA1'           => '2.11',
    'Jcode'                  => '2.06',

    'Test::More'           => 0,
    'Test::Pod'            => 0,
    'Test::Perl::Critic'   => 0,
    'Test::Pod::Coverage'  => 0,
    },

  );

$builder->create_build_script();
