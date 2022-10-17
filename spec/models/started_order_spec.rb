require 'rails_helper'

RSpec.describe StartedOrder, type: :model do
  describe '#valid?' do
    it 'falso quando o prazo fica em branco' do
      transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                        minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
      vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                        weight_limit: 40, transport_mode: transport_mode, status: 0)
      WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
      DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
      deadline = Deadline.create!(start: 0, limit: 50, time: 24, transport_mode: transport_mode)
      order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                        product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
      started_order = StartedOrder.new(service_order: order, transport_mode: transport_mode, vehicle: vehicle,
                          delivery_time: '', total_value: '40.50', status: 0)
     
      expect(started_order.valid?).to eq false
    end
    it 'falso quando o valor fica em branco' do
      transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                        minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
      vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                        weight_limit: 40, transport_mode: transport_mode, status: 0)
      WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
      DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
      deadline = Deadline.create!(start: 0, limit: 50, time: 24, transport_mode: transport_mode)
      order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                        product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
      started_order = StartedOrder.new(service_order: order, transport_mode: transport_mode, vehicle: vehicle,
                          delivery_time: '24', total_value: '', status: 0)
     
      expect(started_order.valid?).to eq false
    end
    it 'falso quando o delivery_time é zero' do
      transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                        minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
      vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                        weight_limit: 40, transport_mode: transport_mode, status: 0)
      WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
      DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
      order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                        product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
      started_order = StartedOrder.new(service_order: order, transport_mode: transport_mode, vehicle: vehicle,
                          delivery_time: '0', total_value: '', status: 0)
     
      expect(started_order.valid?).to eq false
    end
  end
end
