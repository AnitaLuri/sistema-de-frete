require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço'  do
  it 'e visualiza as modalidade' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00')
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                  minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
    WeightPrice.create!(initial_weight: 21, ending_weight: 50, km_value: '1.50', transport_mode: transport_mode)
    WeightPrice.create!(initial_weight: 0, ending_weight: 100, km_value: '3.00', transport_mode: first_transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 31, ending_distance: 60, price: '7.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 40, price: '9.00', transport_mode: first_transport_mode)
    Deadline.create!(start: 0, limit: 50, time: 12, transport_mode: transport_mode)
    Deadline.create!(start: 40, limit: 100, time: 48, transport_mode: first_transport_mode)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                                  product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    click_on order.code
    click_on 'Iniciar Ordem de Serviço'
    #Assert
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Motocicleta'
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
  end
end