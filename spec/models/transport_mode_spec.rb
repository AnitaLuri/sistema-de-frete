require 'rails_helper'

RSpec.describe TransportMode, type: :model do
  describe '#valid?' do
    it 'falso quando o nome fica em branco' do
      #Arrange
      mode = TransportMode.new(name: '', minimum_distance: 100, maximum_distance: 1000, 
                              minimum_weight: 10, maximum_weight:10000, fixed_value: '30,00')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o distância mínima fica em branco' do
      #Arrange
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: '', maximum_distance: 1000, 
                              minimum_weight: 10, maximum_weight:10000, fixed_value: '30,00')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o distância máxima fica em branco' do
      #Arrange
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: 100, maximum_distance: '', 
                                minimum_weight: 10, maximum_weight:10000, fixed_value: '30,00')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o peso mínimo fica em branco' do
      #Arrange
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 10000, 
                              minimum_weight: '', maximum_weight:10000, fixed_value: '30,00')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o peso máximo fica em branco' do
      #Arrange
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 10000, 
                              minimum_weight: 100, maximum_weight: '', fixed_value: '30,00')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o valor fixo fica em branco' do
      #Arrange
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 10000, 
                              minimum_weight: 100, maximum_weight: 10000, fixed_value: '')
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
    it 'falso quando o nome já está em uso' do
      #Arrange
      TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 10000, 
                              minimum_weight: 100, maximum_weight: 10000, fixed_value: 20)
      mode = TransportMode.new(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 10000, 
                              minimum_weight: 100, maximum_weight: 10000, fixed_value: 30)
      #Act
      #Assert
      expect(mode.valid?).to eq false
    end
  end
end
