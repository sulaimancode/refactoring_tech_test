class GildedRose

  SPECIAL_ITEMS = ["Aged Brie",
                   "Backstage passes to a TAFKAL80ETC concert",
                   "Sulfuras, Hand of Ragnaros"]

  def initialize(items)
    @items = items
  end

  def update_quality()
      @items.each do |item|
        next if item.name == SPECIAL_ITEMS[2]
        unless SPECIAL_ITEMS.include? item.name
          degrade_quality_of(item)
        else
          if item.quality < 50
            item.quality = item.quality + 1
            if item.name == SPECIAL_ITEMS[1]
              if item.sell_in < 11
                upgrade_quality_of(item)
              end
              if item.sell_in < 6
                upgrade_quality_of(item)
              end
            end
          end
        end
          item.sell_in = item.sell_in - 1
        if item.sell_in < 0
          unless item.name == SPECIAL_ITEMS[0]
            unless item.name == SPECIAL_ITEMS[1]
              degrade_quality_of(item)
            else
              set_quality_to_zero_of(item)
            end
          else
            upgrade_quality_of(item)
          end
        end
      end
    end

private

    def set_quality_to_zero_of(item)
      item.quality -= item.quality
    end

    def degrade_quality_of(item)
      item.quality -= 1 if (item.quality > 0)
    end

    def upgrade_quality_of(item)
      item.quality += 1 if (item.quality < 50)
    end

end
