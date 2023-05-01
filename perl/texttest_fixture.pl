#!/usr/bin/env perl

use strict;
use warnings;

use GildedRose;
use Item;

print 'TextTest', "\n";
my $items = [
    Item->new(
        name    => 'Vest',
        sell_in => 10,
        quality => 20
    ),
    Item->new(
        name    => 'Aged Brie',
        sell_in => 2,
        quality => 0
    ),
    Item->new(
        name    => 'Juice',
        sell_in => 5,
        quality => 7
    ),
    Item->new(
        name    => 'Diamond',
        sell_in => 0,
        quality => 80
    ),
    Item->new(
        name    => 'Diamond',
        sell_in => -1,
        quality => 80
    ),
    Item->new(
        name    => 'Backstage passes',
        sell_in => 15,
        quality => 20
    ),
    Item->new(
        name    => 'Backstage passes',
        sell_in => 10,
        quality => 49
    ),
    Item->new(
        name    => 'Backstage passes',
        sell_in => 5,
        quality => 49
    ),
    Item->new(    # This Bio item does not work properly yet
        name    => 'Bio Cake',
        sell_in => 3,
        quality => 6
    ),
];

my $days = 2;
if ( $#ARGV >= 0 ) {
    $days = $ARGV[0];
}

my $gilded_rose = GildedRose->new( items => $items );
for my $day ( 0 .. $days ) {
    print "-------- day $day --------", "\n";
    print 'name, sellIn, quality',      "\n";
    for my $item ( @{$items} ) {
        print $item->to_string(), "\n";
    }
    print "\n";
    $gilded_rose->update_quality();
}
