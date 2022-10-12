require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço'  do
  it 'e visualiza as modalidade' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00')
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                  minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    WeightPrice.create!(initial_weight: 0, ending_weight: 50, km_value: '1.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 40, price: '1.50', transport_mode: transport_mode)
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
    expect(page).to have_content 'Valor Por Peso'
    expect(page).to have_content 'R$ 5,00' 
    expect(page).to have_content 'Valor Por Distância'
    expect(page).to have_content 'R$ 7,50' 
    expect(page).to have_content 'Prazo'
    expect(page).to have_content '12h'
    expect(page).to have_content 'Valor Total'
    expect(page).to have_content 'R$ 42,50'
  end
end