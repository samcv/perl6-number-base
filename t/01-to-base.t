use v6;
use Test;
use lib 'lib';
use Number::Base;
is-deeply to-base(10, 1), '1111111111', 'to-base(10, 1)';
is-deeply from-base(to-base(10, 1), 1), 10, "from-base to-base roundtrip for base 1";
is-deeply from-base("", 1), 0, "from-base with base 1 for empty string returns 0";
is-deeply to-base(0, 1), "", "to-base for 0 in base 1 returns empty string";
is-deeply to-base(1, -1), '1', "to-base for 1 in base -1 returns 1";
is-deeply to-base(0, -1), '11', "to-base for 0 in base -1 returns 11";
is-deeply from-base('101', -2), 5, "from-base -1 for '101' is 5";
done-testing;