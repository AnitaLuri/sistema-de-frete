require 'rails_helper'

RSpec.describe WeightPrice, type: :model do
  describe '#valid?' do
    it 'falso quando o peso inicial fica em branco' do
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = WeightPrice.new(initial_weight: '', ending_weight: 3000, km_value: '1.25', 
                                        transport_mode: first_mode)
     
      expect(price.valid?).to eq false
    end
    it 'falso quando o peso final fica em branco' do
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = WeightPrice.new(initial_weight: 1000, ending_weight: '', km_value: '1.25', 
                                        transport_mode: first_mode)
   
      expect(price.valid?).to eq false
    end
    it 'falso quando o valor por km fica em branco' do
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = WeightPrice.new(initial_weight: 1000, ending_weight: 3000, km_value: '', 
                                        transport_mode: first_mode)
  
      expect(price.valid?).to eq false
    end
    it 'falso quando o peso inicial é maior que o final' do
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = WeightPrice.new(initial_weight: 1000, ending_weight: 300, km_value: '1.25', 
                                        transport_mode: first_mode)
      
      expect(price.valid?).to eq false
    end
    it 'falso quando a price é zero' do
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = WeightPrice.new(initial_weight: 100, ending_weight: 300, km_value: '0', 
                                        transport_mode: first_mode)

      expect(price.valid?).to eq false
    end
  end
end
