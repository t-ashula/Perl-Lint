#!perl

use strict;
use warnings;
use Perl::Lint::Evaluator::NamingConventions::Capitalization;
use t::Evaluate::Util qw/fetch_violations/;
use Test::Base::Less;

my $class_name = 'NamingConventions::Capitalization';

filters {
    params => [qw/eval/],
};

for my $block (blocks) {
    my $violations = fetch_violations($class_name, $block->input, $block->params);
    is scalar @$violations, $block->failures, $block->dscr;
}

done_testing;

__DATA__

===
--- dscr: Basic Passes
--- failures: 0
--- params: {}
--- input
my  $foo;
our $bar;
my($foo, $bar) = ("BLEH", "BLEH");
my @foo;
my %bar;
sub foo {}

my  $foo123;
my  $foo123bar;
sub foo123 {}
sub foo123bar {}

package This::SomeThing;
package This;
package This::Thing;
package Acme::12345;
package YYZ;

===
--- dscr: Basic Failures
--- failures: 14
--- params: {}
--- input
my  $Foo;
our $Bar;
my  @Foo;
my  %Bar;
sub Foo {}

my  $foo_Bar;
sub foo_Bar {}

my  $FooBar;
sub FooBar {}

my  $foo123Bar;
sub foo123Bar {}

package pragma;
package Foo::baz;
package baz::FooBar;

===
--- dscr: Special case: main
--- failures: 0
--- params: {}
--- input
package main;

===
--- dscr: Combined passes and fails
--- failures: 2
--- params: {}
--- input
my($foo, $Bar);
our($Bar, $foo);

===
--- dscr: Variables from other packages should pass
--- failures: 0
--- params: {}
--- input
local $Other::Package::Foo;
$Other::Package::Foo;

===
--- dscr: Only cares about declarations
--- failures: 0
--- params: {}
--- input
Foo();
$Foo = 42;
