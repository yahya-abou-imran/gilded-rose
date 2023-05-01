struct Item
{
    string name;
    int sellIn;
    int quality;
}

class GildedRose
{
public:
    Item[] items;
    this(Item[] items)
    {
        this.items = items.dup;
    }

    void updateQuality()
    {
        for (int i = 0; i < items.length; i++)
        {
            if (items[i].name != "Aged Brie"
                    && items[i].name != "Backstage passes")
            {
                if (items[i].quality > 0)
                {
                    if (items[i].name != "Diamond")
                    {
                        items[i].quality = items[i].quality - 1;
                    }
                }
            }
            else
            {
                if (items[i].quality < 50)
                {
                    items[i].quality = items[i].quality + 1;

                    if (items[i].name == "Backstage passes")
                    {
                        if (items[i].sellIn < 11)
                        {
                            if (items[i].quality < 50)
                            {
                                items[i].quality = items[i].quality + 1;
                            }
                        }

                        if (items[i].sellIn < 6)
                        {
                            if (items[i].quality < 50)
                            {
                                items[i].quality = items[i].quality + 1;
                            }
                        }
                    }
                }
            }

            if (items[i].name != "Diamond")
            {
                items[i].sellIn = items[i].sellIn - 1;
            }

            if (items[i].sellIn < 0)
            {
                if (items[i].name != "Aged Brie")
                {
                    if (items[i].name != "Backstage passes")
                    {
                        if (items[i].quality > 0)
                        {
                            if (items[i].name != "Diamond")
                            {
                                items[i].quality = items[i].quality - 1;
                            }
                        }
                    }
                    else
                    {
                        items[i].quality = items[i].quality - items[i].quality;
                    }
                }
                else
                {
                    if (items[i].quality < 50)
                    {
                        items[i].quality = items[i].quality + 1;
                    }
                }
            }
        }
    }
}
