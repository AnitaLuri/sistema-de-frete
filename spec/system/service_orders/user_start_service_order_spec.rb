require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço'  do
  it 'e visualiza as modalidades' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    first_transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00')
    second_transport_mode = TransportMode.create!(name: 'Bicicleta', minimum_distance: 0, maximum_distance: 10, 
                                  minimum_weight: 0, maximum_weight: 10, fixed_value: '15,00', status: 5)
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                  minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00', status: 0)
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '0.80', transport_mode: second_transport_mode)
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
    WeightPrice.create!(initial_weight: 21, ending_weight: 50, km_value: '1.50', transport_mode: transport_mode)
    WeightPrice.create!(initial_weight: 0, ending_weight: 100, km_value: '3.00', transport_mode: first_transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 20, price: '4.50', transport_mode: second_transport_mode)    
    DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 31, ending_distance: 60, price: '7.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 40, price: '9.00', transport_mode: first_transport_mode)
    Deadline.create!(start: 0, limit: 10, time: 12, transport_mode: second_transport_mode)
    Deadline.create!(start: 0, limit: 50, time: 12, transport_mode: transport_mode)
    Deadline.create!(start: 40, limit: 100, time: 48, transport_mode: first_transport_mode)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                                  product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Pendentes'
    click_on order.code
    click_on 'Iniciar Ordem de Serviço'
    #Assert
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_link 'Motocicleta'
    expect(page).to have_content 'Valor Fixo'
    expect(page).to have_content 'R$ 30,00'
    expect(page).to have_content 'Valor por Peso'
    expect(page).to have_content 'R$ 5,00' 
    expect(page).to have_content 'Valor por Distância'
    expect(page).to have_content 'R$ 5,50' 
    expect(page).to have_content 'Prazo'
    expect(page).to have_content '12h'
    expect(page).to have_content 'Valor Total'
    expect(page).to have_content 'R$ 40,50'
    expect(page).not_to have_link 'Bicicleta'
    expect(page).not_to have_content 'R$ 15,00'
    expect(page).not_to have_content 'R$ 23,50'
  end
  it 'com sucesso' do
    #Arrange
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
                                product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
    #Act
    login_as(user)
    visit root_path
    click_on 'Pedidos'
    click_on 'Pendentes'
    click_on order.code
    click_on 'Iniciar Ordem de Serviço'
    select 'Motocicleta', from: 'Modalidade de Transporte'
    click_on 'Confirmar'
    #Assert
    expect(page).to have_content 'Origem: Av. Paulista, 500'
    expect(page).to have_content 'Destino: Rua Jureia, 849'
    expect(page).to have_content 'Distância: 5Km'
    expect(page).to have_content 'Destinatário: Maria Lucia'
    expect(page).to have_content 'Código do Produto: DELL-7000-TEC10'
    expect(page).to have_content 'Dimensões: 40cm x 20cm x 20cm'
    expect(page).to have_content 'Peso: 2Kg'
    expect(page).to have_content 'Situação: Em progresso'
    expect(page).to have_content 'Modalidade de Transporte: Motocicleta'
    expect(page).to have_link 'Veículo placa: ABC1111'
    expect(page).to have_content 'Valor Total: R$ 40,50'
  end
end