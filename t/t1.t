#!/usr/local/bin/perl

# Copyright 2001, Paul Johnson (pjcj@cpan.org)

# This software is free.  It is licensed under the same terms as Perl itself.

# The latest version of this software should be available from my homepage:
# http://www.pjcj.net

use Devel::Cover::DB 0.06 qw( cover_read );
use Devel::Cover 0.06 qw( -db t1 -indent 1 -merge 0 );

use strict;
use warnings;

use Test;

BEGIN { plan tests => 1 }

use lib -d "t" ? "t" : "..";

use T1;

my @x;

sub xx
{
  $x[shift]++;
  T1::zz(0);
}

for (0 .. 1000)
{
  time &&
    $x[1]++;

  $x[2]++
    if time;

  for (0 .. 2)
  {
      $x[3]++;
  }

  if (time)
  {
    xx(4);
  }
  else
  {
    $x[5]++;
  }
}

Devel::Cover::report();

END
{
    require Compare;
    ok Compare::compare("t1", *DATA{IO}), "done";
}

__DATA__

$cover = {
  't/T1.pm' => {
    'statement' => {
      '13' => [
        1001
      ],
      '12' => [
        1001
      ]
    }
  },
  't/t1.t' => {
    'statement' => {
      '35' => [
        1001
      ],
      '32' => [
        1,
        1001
      ],
      '28' => [
        1001
      ],
      '40' => [
        1001,
        3003
      ],
      '51' => [
        0
      ],
      '47' => [
        1001
      ],
      '42' => [
        3003
      ],
      '24' => [
        4
      ],
      '37' => [
        1001
      ],
      '45' => [
        1001
      ],
      '29' => [
        1002
      ],
      '55' => [
        1
      ]
    },
    'condition' => {
      '35' => [
        [
          1001,
          1001
        ]
      ],
      '32' => [
        [
          1002,
          0
        ]
      ],
      '40' => [
        [
          4004,
          0
        ]
      ],
      '37' => [
        [
          1001,
          1001
        ]
      ],
      '51' => [
        [
          1001,
          0,
          0
        ]
      ]
    }
  }
};