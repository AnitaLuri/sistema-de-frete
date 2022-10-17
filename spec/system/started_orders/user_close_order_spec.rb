require 'rails_helper'

describe 'Usuário encerra uma ordem de serviço iniciada' do
  it 'dentro do prazo' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    first_vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    second_vehicle = Vehicle.create!(plate: 'FGH4321', brand: 'Honda', model: 'PCX', year: 2021, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
    deadline = Deadline.create!(start: 0, limit: 50, time: 24, transport_mode: transport_mode)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
    StartedOrder.create!(service_order: order, transport_mode: transport_mode, vehicle:second_vehicle,
                                delivery_time: '24', total_value: '40.50', status: 0)

    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Iniciadas'
    click_on order.code
    click_on 'Encerrar Ordem de Serviço'

    expect(page).to have_content "Dia da Entrega:"
    expect(page).to have_content "Situação: Concluído"  
  end
  it 'depois do prazo' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    first_vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    second_vehicle = Vehicle.create!(plate: 'FGH4321', brand: 'Honda', model: 'PCX', year: 2021, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
    deadline = Deadline.create!(start: 0, limit: 50, time: 12, transport_mode: transport_mode)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
    
    started = StartedOrder.create!(service_order: order, transport_mode: transport_mode, vehicle:second_vehicle,
                                delivery_time: '12', total_value: '40.50', status: 0)
    started.update!(created_day: 1.day.ago)

    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on 'Iniciadas'
    click_on order.code
    click_on 'Encerrar Ordem de Serviço'
    fill_in 'Justificativa de Atraso', with: 'Endereço infomado errado'
    click_on 'Confirmar'

    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Situação: Concluído com atraso"  
    
  end
end