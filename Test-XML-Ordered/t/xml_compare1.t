#!/usr/bin/perl

# This code used to generate a memory error in valgrind/etc.
# Testing it.

use strict;
use warnings;

use Test::XML::Ordered qw(is_xml_ordered);

use Test::More tests => 2;

my $xml_source = <<'EOF';
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fic="http://web-cpan.berlios.de/modules/XML-Grammar-Fortune/fiction-xml-0.2/">
  <head>
    <title>David vs. Goliath - Part I</title>
  </head>
  <body>
    <div class="fiction story" xml:id="index">
      <h1>David vs. Goliath - Part I</h1>
      <div class="fiction section" xml:id="top">
        <h2>The Top Section</h2>
        <p>
    King David and Goliath were standing by each other.
    </p>
        <p>
    David said unto Goliath: "I will shoot you. I <b>swear</b> I will"
    </p>
        <div class="fiction section" xml:id="goliath">
          <h3>Goliath's Response</h3>
          <p>
    Goliath was not amused.
    </p>
          <p>
    He said to David: "Oh, really. <i>David</i>, the red-headed!".
    </p>
          <p>
    David started listing Goliath's disadvantages:
    </p>
        </div>
      </div>
    </div>
  </body>
</html>
EOF

my $final_source = <<'EOF';
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fic="http://web-cpan.berlios.de/modules/XML-Grammar-Fortune/fiction-xml-0.2/">
  <head>
    <title>David vs. Goliath - Part I</title>
  </head>
  <body>
    <div class="fiction story" xml:id="index">
      <h1>David vs. Goliath - Part I</h1>
      <div class="fiction section" xml:id="top">
        <h2>The Top Section</h2>
        <p>
    King David and Goliath were standing by each other.
    </p>
        <p>
    David said unto Goliath: "I will shoot you. I <b>swear</b> I will"
    </p>
        <div class="fiction section" xml:id="goliath">
          <h3>Goliath's Response</h3>
          <p>
    Goliath was not amused.
    </p>
          <p>
    He said to David: "Oh, really. <i>David</i>, the red-headed!".
    </p>
          <p>
    David started listing Goliath's disadvantages:
    </p>
        </div>
      </div>
    </div>
  </body>
</html>
EOF

my @common = (validation => 0, load_ext_dtd => 0, no_network => 1);
# TEST
is_xml_ordered(
    [ string => $final_source, @common, ],
    [ string => $xml_source, @common, ],
    {},
    "XMLs are equivalent.",
);

# TEST
ok (1, "Finished");
