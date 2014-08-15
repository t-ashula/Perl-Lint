use strict;
use warnings;
use utf8;
use Perl::Lint::RegexpParser;
use Capture::Tiny qw/capture_stderr/;

use Test::More;

subtest 'workaround for unsupported' => sub {
    my $err = capture_stderr { Perl::Lint::RegexpParser->new->parse('\Q\u\U\v\V\F\g\h\H\k\K\l\L\N\o\R\E') };
    ok !$err;
};

done_testing;

