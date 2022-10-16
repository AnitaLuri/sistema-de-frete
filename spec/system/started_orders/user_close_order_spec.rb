require 'rails_helper'

describe 'Usuário encerra uma ordem de serviço iniciada' do
  it 'com sucesso' do 
    it 'e visualiza pedidos iniciados' do
      user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
      first_transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00')
      second_transport_mode = TransportMode.create!(name: 'Bicicleta', minimum_distance: 0, maximum_distance: 10, 
                                  minimum_weight: 0, maximum_weight: 10, fixed_value: '15,00')
      transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                  minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
      first_vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                                  weight_limit: 40, transport_mode: transport_mode, status: 0)
      second_vehicle = Vehicle.create!(plate: 'FGH4321', brand: 'Honda', model: 'PCX', year: 2021, 
                                  weight_limit: 40, transport_mode: transport_mode, status: 0)
      WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '0.80', transport_mode: second_transport_mode)
      WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
      WeightPrice.create!(initial_weight: 21, ending_weight: 50, km_value: '1.50', transport_mode: transport_mode)
      WeightPrice.create!(initial_weight: 0, ending_weight: 100, km_value: '3.00', transport_mode: first_transport_mode)
      DistancePrice.create!(initial_distance: 0, ending_distance: 20, price: '4.50', transport_mode: second_transport_mode)    
      DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
      DistancePrice.create!(initial_distance: 31, ending_distance: 60, price: '7.00', transport_mode: transport_mode)
      DistancePrice.create!(initial_distance: 0, ending_distance: 40, price: '9.00', transport_mode: first_transport_mode)
      Deadline.create!(start: 0, limit: 10, time: 12, transport_mode: second_transport_mode)
      deadline = Deadline.create!(start: 0, limit: 50, time: 12, transport_mode: transport_mode)
      Deadline.create!(start: 40, limit: 100, time: 48, transport_mode: first_transport_mode)
      order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                  product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
      StartedOrder.create!(service_order: order, transport_mode: transport_mode, vehicle:second_vehicle,
                                  delivery_time: '12', total_value: '40.50', status: 0)
  
      login_as(user)
      visit root_path
      click_on 'Ordens de Serviço'
      click_on 'Iniciados'
      click_on order.code
  
      
    end
  end

end