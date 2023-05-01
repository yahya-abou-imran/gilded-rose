#!/usr/bin/env perl6

use v6;

use lib 'lib';

use GildedRose;
use Item;

print 'TextTest', "\n";
my @items = (
    Item.new(
        name    => 'Vest',
        sell_in => 10,
        quality => 20
    ),
    Item.new(
        name    => 'Aged Brie',
        sell_in => 2,
        quality => 0
    ),
    Item.new(
        name    => 'Juice',
        sell_in => 5,
        quality => 7
    ),
    Item.new(
        name    => 'Diamond',
        sell_in => 0,
        quality => 80
    ),
    Item.new(
        name    => 'Diamond',
        sell_in => -1,
        quality => 80
    ),
    Item.new(
        name    => 'Backstage passes',
        sell_in => 15,
        quality => 20
    ),
    Item.new(
        name    => 'Backstage passes',
        sell_in => 10,
        quality => 49
    ),
    Item.new(
        name    => 'Backstage passes',
        sell_in => 5,
        quality => 49
    ),
    Item.new(    # This Bio item does not work properly yet
        name    => 'Bio Cake',
        sell_in => 3,
        quality => 6
    ),
);

sub MAIN(Int $days = 2) {
    my $gilded-rose = GildedRose.new( items => @items );
    for ^$days -> $day {
        say "-------- day $day --------";
        say 'name, sellIn, quality';

        .Str.say for $gilded-rose.items;

	"".say;
	$gilded-rose.update_quality();
    }
}
