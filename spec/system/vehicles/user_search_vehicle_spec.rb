require 'rails_helper'

describe 'Usuário busca por um veículo' do
  it 'a partir da página veículos' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                          minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00')
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                          weight_limit: 50000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                                          weight_limit: 40000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    #Assert
    expect(page).to have_field 'Buscar Veículo'
    expect(page).to have_button 'Buscar'
  end
  it 'e econtra pedidos' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                          minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00')
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                          weight_limit: 50000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                                          weight_limit: 40000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'ABC3759', brand: 'Ford', model: 'F250', year: 2016, 
                                          weight_limit: 30000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'FG5H970', brand: 'Fiat', model: 'W200', year: 2018, 
                                          weight_limit: 20000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    fill_in 'Buscar Veículo', with: 'ABC'
    click_on 'Buscar'
    #Assert
    expect(page).to have_content 'Resultado da busca: ABC'
    expect(page).to have_content '2 veículos encontrados'
    expect(page).to have_content 'Placa: ABC4252'
    expect(page).to have_content 'Capacidade de carga: 50000Kg'
    expect(page).to have_content 'Modalidade de Transporte: Caminhão'
    expect(page).to have_content 'Placa: ABC3759'
    expect(page).to have_content 'Capacidade de carga: 30000Kg'
    expect(page).to have_content 'Modalidade de Transporte: Caminhão'
    expect(page).not_to have_content 'Placa: FGH5968'
  end
end