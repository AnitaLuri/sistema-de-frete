require 'rails_helper'

describe 'Usuário vê detalhes do cadastro do veículo' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                    weight_limit: 50000, transport_mode: transport_mode, status: 0)
    Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                    weight_limit: 40000, transport_mode: transport_mode, status: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'ABC4252'
    #Assert
    expect(page).to have_content 'Detalhes do Veículo'
    expect(page).to have_content 'Placa: ABC4252'
    expect(page).to have_content 'Marca: Ford'
    expect(page).to have_content 'Modelo: F350'
    expect(page).to have_content 'Ano de fabricação: 2014'
    expect(page).to have_content 'Modalidade de Transporte: Caminhão' 
    expect(page).to have_content 'Situação: Disponível'
  end
  it 'e acessa detalhes da modalidade de transporte' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
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
    click_on 'ABC4252'
    click_on 'Caminhão'
    #Assert
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content 'Distância Mínima: 100Km'
    expect(page).to have_content 'Distância Máxima: 5000Km'
    expect(page).to have_content 'Peso Mínimo: 50000Kg'
    expect(page).to have_content 'Peso Máximo: 5000000Kg'
    expect(page).to have_content 'Valor Fixo: R$ 500'
  end
end