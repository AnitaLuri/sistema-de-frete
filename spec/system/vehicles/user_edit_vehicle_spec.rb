require 'rails_helper'

describe 'Usuário edita um veiculo' do
  it 'e precisa ser administrador' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                  weight_limit: 50000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'ABC4252'
    click_on 'Editar'
    #Assert
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                    weight_limit: 50000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'ABC4252'
    click_on 'Editar'
    fill_in 'Modelo', with: 'F450'
    fill_in 'Ano de fabricação', with: '2016'
    select 'Em manutenção', from: 'Situação'
    click_on 'Atualizar Veículo'
    #Assert
    expect(page).to have_content 'Veículo atualizado com sucesso!'
    expect(page).to have_content 'Placa: ABC4252'
    expect(page).to have_content 'Marca: Ford'
    expect(page).to have_content 'Modelo: F450'
    expect(page).to have_content 'Ano de fabricação: 2016'
    expect(page).to have_content 'Situação: Em manutenção'
  end
  it 'faltando informação' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                    weight_limit: 50000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'ABC4252'
    click_on 'Editar'
    fill_in 'Modelo', with: ''
    fill_in 'Ano de fabricação', with: ''
    click_on 'Atualizar Veículo'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar veículo.'
    expect(page).to have_content 'Modelo não pode ficar em branco'
    expect(page).to have_content 'Ano de fabricação não pode ficar em branco'
  end
end