require 'rails_helper'

describe 'Usuário edita preço por distância' do
  it 'com sucesso' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                  minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')
    DistancePrice.create!(initial_distance: 400, ending_distance: 1000, price: '5.00', 
                                  transport_mode: transport_mode)    
    #Act
    login_as(user)
    visit root_path
    click_on 'Tabelas de Preços'
    click_on 'Por Distância'
    click_on 'Editar'
    fill_in 'Distância inicial', with: '600'
    fill_in 'Distância final', with: '1200'
    fill_in 'Taxa', with: '4.00'
    select 'Motocicleta', from: 'Modalidade de Transporte'
    click_on 'Atualizar Preço por Distância'
    #Assert
    expect(page).to have_content 'Preço atualizado com sucesso!'
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content '600Km - 1200Km'
    expect(page).to have_content 'R$ 4,00'
  end
  it 'e precisa ser administrador' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    DistancePrice.create!(initial_distance: 400, ending_distance: 1000, price: '5.00', 
                                  transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Tabelas de Preços'
    click_on 'Por Distância'
    #Assert
    expect(page).not_to have_content 'Editar'
  end
  it 'faltando informação' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                  minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')
    DistancePrice.create!(initial_distance: 400, ending_distance: 1000, price: '5.00', 
                                  transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Tabelas de Preços'
    click_on 'Por Distância'
    click_on 'Editar'
    fill_in 'Distância inicial', with: ''
    fill_in 'Distância final', with: ''
    fill_in 'Taxa', with: ''
    select 'Motocicleta', from: 'Modalidade de Transporte'
    click_on 'Atualizar Preço por Distância'
    #Assert
    expect(page).to have_content 'Distância inicial não pode ficar em branco'
    expect(page).to have_content 'Distância final não pode ficar em branco'
    expect(page).to have_content 'Taxa não pode ficar em branco'
    expect(page).not_to have_content 'Preço atualizado com sucesso!'
  end
end