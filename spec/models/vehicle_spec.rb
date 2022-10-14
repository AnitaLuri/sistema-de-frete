require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    it 'falso quando a placa fica em branco' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      vehicle = Vehicle.new(plate: '', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 50000, transport_mode: transport_mode, status: 0)
     
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando a marca fica em branco' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      vehicle = Vehicle.new(plate: 'ABC4252', brand: '', model: 'F350', year: 2014, 
                                      weight_limit: 50000, transport_mode: transport_mode, status: 0)
      
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando o modelo fica em branco' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: '', year: 2014, 
                                      weight_limit: 50000, transport_mode: transport_mode, status: 0)
      
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando o ano de fabricação fica em branco' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: '', 
                                      weight_limit: 50000, transport_mode: transport_mode, status: 0)
     
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando a carga máxima fica em branco' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: '', transport_mode: transport_mode, status: 0)
      
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando a modalidade de transporte fica em branco' do
      vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 50000, transport_mode: nil, status: 0)
      
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando a placa já está em uso' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      Vehicle.create!(plate: 'ABC4252', brand: 'Scania', model: 'P350', year: 2014, 
                                        weight_limit: 50000, transport_mode: transport_mode, status: 0)
      vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 50000, transport_mode: transport_mode, status: 0)
      
      expect(vehicle.valid?).to eq false
    end
    it 'falso quando a carga máxima não é maior que zero' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      first_vehicle = Vehicle.new(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 0, transport_mode: transport_mode, status: 0)
      second_vehicle = Vehicle.new(plate: 'DEF4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: -2, transport_mode: transport_mode, status: 0)
      
      expect(first_vehicle.valid?).to eq false
      expect(second_vehicle.valid?).to eq false
    end
    it 'falso quando a placa tiver numero de caracteres diferente' do
      transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                      minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
      first_vehicle = Vehicle.new(plate: 'ABC42527', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 5000, transport_mode: transport_mode, status: 0)
      second_vehicle = Vehicle.new(plate: 'DE4252', brand: 'Ford', model: 'F350', year: 2014, 
                                      weight_limit: 2000, transport_mode: transport_mode, status: 0)
      
      expect(first_vehicle.valid?).to eq false
      expect(second_vehicle.valid?).to eq false
    end
  end
end
