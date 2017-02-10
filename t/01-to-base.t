use v6;
use Test;
use lib 'lib';
use Number::Base;
is-deeply to-base(10, 1), '1111111111', 'to-base(10, 1)';
is-deeply from-base(to-base(10, 1), 1), 10, "from-base to-base roundtrip for base 1";
is-deeply from-base("", 1), 0, "from-base with base 1 for empty string returns 0";
is-deeply to-base(0, 1), "", "to-base for 0 in base 1 returns empty string";
done-testing;