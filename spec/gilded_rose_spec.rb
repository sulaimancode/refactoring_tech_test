require 'gilded_rose'
require 'item'
require 'pry'

describe GildedRose do
  let(:common_item) { Item.new('Big Fat Sword', 7, 20) }
  let(:aged_brie) { Item.new('Aged Brie', 3, 0) }
  let(:backstag_pass) { Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 30) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 1, 0) }
  let(:gilded_rose) { described_class.new(items) }
  let(:items) { [common_item, aged_brie, sulfuras, backstag_pass] }

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

    context "If the item is called 'Aged Brie'" do
      it 'upgrades quality by 1' do
        expect { gilded_rose.update_quality }.to change { items[1].quality }.by(1)
      end
    end

    context "If the item is called 'Sulfuras, Hand of Ragnaros'" do
      it 'does not change quality' do
        expect { gilded_rose.update_quality }.to_not change { items[2].quality }
      end

      it 'can not be sold' do
        expect { gilded_rose.update_quality }.to_not change { items[2].sell_in }
      end
    end

    context 'If item is a Backstage pass' do
      it 'upgrades quality by 2 if sell_in is 10 or less' do
        backstag_pass.sell_in = 10
        expect { gilded_rose.update_quality }.to change { items[3].quality }.by(2)
      end

      it 'upgrades quality by 3 if sell_in is 5 or less' do
        backstag_pass.sell_in = 5
        expect { gilded_rose.update_quality }.to change { items[3].quality }.by(3)
      end

      it 'sets quality to 0 when sell_in is 0' do
        backstag_pass.sell_in = 0
        gilded_rose.update_quality
        expect(items[3].quality).to eq 0
      end

      it 'max quality is still 50. if current quality is 49 it will not go above 50' do
        backstag_pass.quality = 49
        gilded_rose.update_quality
        expect(items[3].quality).to eq 50
      end

    end

    it 'quality can never be negative' do
      common_item.quality = 0
      expect { gilded_rose.update_quality }.to_not change { items[0].quality }
    end

    it 'quality can not be upgraded above 50' do
      aged_brie.quality = 50
      expect { gilded_rose.update_quality }.to_not change { items[1].quality }
    end
  end

end
