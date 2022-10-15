require 'rails_helper'

describe 'Usuário vê frota de veículos' do
  it 'se estiver autenticado' do
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                    weight_limit: 50000, transport_mode: transport_mode)
    Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                    weight_limit: 40000, transport_mode: transport_mode)
 
    visit root_path
    click_on 'Veículos'
  
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                    weight_limit: 50000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                    weight_limit: 40000, transport_mode: transport_mode, status: 3)
  
    login_as(user)
    visit root_path
    click_on 'Veículos'

    expect(page).to have_content 'Frota de Veículos'
    expect(page).to have_content 'Placa: ABC4252'
    expect(page).to have_content 'Situação: Ativo'
    expect(page).to have_content 'Modalidade de Transporte: Caminhão'
    expect(page).to have_content 'Placa: FGH5968'
    expect(page).to have_content 'Situação: Em operação'
  end
end