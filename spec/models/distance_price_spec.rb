require 'rails_helper'

RSpec.describe DistancePrice, type: :model do
  describe '#valid?' do
    it 'falso quando a distância inicial fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = DistancePrice.new(initial_distance: '', ending_distance: 1200, price: '2.00', 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(price.valid?).to eq false
    end
    it 'falso quando a distância final fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = DistancePrice.new(initial_distance: 500, ending_distance: '', price: '2.00', 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(price.valid?).to eq false
    end
    it 'falso quando a taxa fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = DistancePrice.new(initial_distance: 500, ending_distance: 1200, price: '', 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(price.valid?).to eq false
    end
    it 'falso quando a distância inicial é maior que o final' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      price = DistancePrice.new(initial_distance: 1500, ending_distance: 1200, price: '2.00', 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(price.valid?).to eq false
    end
  end
end
