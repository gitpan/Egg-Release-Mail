package Egg::View::Mail::Mailer::SMTP;
#
# Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>
#
# $Id: SMTP.pm 285 2008-02-28 04:20:55Z lushe $
#
use strict;
use warnings;
use Carp qw/ croak /;
use Net::SMTP;

our $VERSION = '0.01';

sub mail_send {
	my $self= shift;
	my $data= $_[0] ? ($_[1] ? {@_}: $_[0]) : croak q{I want mail data.};
	my $host= $data->{smtp_host} || 'localhost';
	my $smtp= Net::SMTP->new( $host,
	  Timeout => ($data->{timeout} || 3),
	  Debug   => ($data->{debug}   || 0),
	  ) || die qq{ '$host' Connection error. };
	$smtp->mail($data->{from});
	$smtp->to($data->{to});
	$smtp->cc ($data->{cc})  if $data->{cc};
	$smtp->bcc($data->{bcc}) if $data->{bcc};
	$smtp->data();
	$smtp->datasend(${$data->{body}});
	$smtp->dataend();
	$smtp->quit();
	$self;
}

1;

__END__

=head1 NAME

Egg::View::Mail::Mailer::SMTP - Mail is transmitted by using Net::SMTP. 

=head1 SYNOPSIS

  package MyApp::View::Mail::MyComp;
  use base qw/ Egg::View::Mail::Base /;
  
  ...........
  .....
  
  __PACKAGE__->setup_mailer('SMTP');

=head1 DESCRIPTION

It is Mailer system component to transmit mail by using L<Net::SMTP>.

Use is enabled specifying 'SMTP' for the first argument of 'setup_mailer' method.

=head1 CONFIGURATION

=head3 smtp_host

SMTP host name.

Default is 'localhost'.

=head3 timeout

Value of 'Timeout' passed to L<Net::SMTP>.

Default is '3'.

=head3 debug

Value of 'Debug' passed to L<Net::SMTP>.

=head1 METHODS

=head2 mail_send ([MAIL_DATA_HASH])

This method is what 'send' method of L<Egg::View::Mail::Base> calls it internally.

The obstacle is generated by operating the component built in when calling 
directly.

=head1 SEE ALSO

L<Egg::Release>,
L<Egg::View::Mail>,
L<Egg::View::Mail::Base>,
L<Egg::View::Mail::Mailer::CMD>,

=head1 AUTHOR

Masatoshi Mizuno E<lt>lusheE<64>cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Bee Flag, Corp. E<lt>L<http://egg.bomcity.com/>E<gt>, All Rights Reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut

