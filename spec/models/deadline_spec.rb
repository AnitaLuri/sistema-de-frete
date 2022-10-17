require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    it 'falso quando a distância inicial fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      time = Deadline.new(start: '', limit: 400, time: 72, 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(time.valid?).to eq false
    end
    it 'falso quando a distância limite fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      time = Deadline.new(start: 100, limit: '', time: 72, 
                                          transport_mode: first_mode)
      #Act
      #Assert
      expect(time.valid?).to eq false
    end
    it 'falso quando o prazo fica em branco' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      time = Deadline.new(start: 100, limit: 400, time: '', 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(time.valid?).to eq false
    end
    it 'falso quando o prazo é menor que 12h' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      time = Deadline.new(start: 100, limit: 400, time: 11, 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(time.valid?).to eq false
    end
    it 'falso quando a distância inicial é maior que o limite' do
      #Arrange
      first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
      time = Deadline.new(start: 500, limit: 400, time: 72, 
                                        transport_mode: first_mode)
      #Act
      #Assert
      expect(time.valid?).to eq false
    end
  end
end
