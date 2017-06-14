require 'gilded_rose'
require 'item'
require 'pry'

describe GildedRose do
  let(:common_item) { Item.new('Big Fat Sword', 7, 20) }
  let(:gilded_rose) { described_class.new(items) }
  let(:items) { [common_item] }

  describe "#update_quality" do

    it "does not change the name" do
      gilded_rose.update_quality
      expect(items[0].name).to eq 'Big Fat Sword'
    end

    context 'When sell date has not passed' do
      it 'degrades quality by 1' do
        expect { gilded_rose.update_quality }.to change { items[0].quality }.by(-1)
      end
    end

    context 'When sell date has passed' do
      before do
        common_item.sell_in = 0
      end
      it 'degrades quality by 2' do
        expect { gilded_rose.update_quality }.to change { items[0].quality }.by(-2)
      end
    end

    #
    # it "Aged Brie's qualty increases the older it gets" do
    #   items = [Item.new("Aged Brie", 2, 0)]
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].quality).to eq 1
    # end
    #
    # it "quality degrades by 2 when sell date has passed" do
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].quality).to eq 1
    # end

  end

end
