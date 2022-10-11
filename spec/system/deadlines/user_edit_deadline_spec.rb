require 'rails_helper'

describe 'Usuário edita prazos de entrega' do
  it 'com sucesso' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                  minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')
    Deadline.create!(start: 400, limit: 800, time: 72, transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Distância inicial', with: '100'
    fill_in 'Distância limite', with: '400'
    fill_in 'Prazo', with: '36'
    select 'Motocicleta', from: 'Modalidade de Transporte'
    click_on 'Atualizar Prazo de Entrega'
    #Assert
    expect(page).to have_content 'Prazo de Entrega atualizado com sucesso!'
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content '100Km - 400Km'
    expect(page).to have_content '36h'
  end
  it 'e precisa ser administrador' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    Deadline.create!(start: 400, limit: 800, time: 72, transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Prazo de Entrega'
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
    Deadline.create!(start: 400, limit: 800, time: 72, transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Prazo de Entrega'
    click_on 'Editar'
    fill_in 'Distância inicial', with: ''
    fill_in 'Distância limite', with: ''
    fill_in 'Prazo', with: ''
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Atualizar Prazo de Entrega'
    #Assert
    expect(page).to have_content 'Distância inicial não pode ficar em branco'
    expect(page).to have_content 'Distância limite não pode ficar em branco'
    expect(page).to have_content 'Prazo não pode ficar em branco'
    expect(page).not_to have_content 'Prazo de Entrega atualizado com sucesso!'
  end
end