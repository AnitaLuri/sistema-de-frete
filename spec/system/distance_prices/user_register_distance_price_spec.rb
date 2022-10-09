require 'rails_helper'

describe 'Usuário registra uma faixa de preços por distância' do
  it 'e esta autenticado' do 
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    #Act
    visit new_distance_price_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'e é administrador' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Distância'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Distância'
    fill_in 'Distância inicial', with: '400'
    fill_in 'Distância final', with: '1200'
    fill_in 'Taxa', with: '2.00'
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Preço por Distância'
    #Assert
    expect(page).to have_content 'Preço cadastrado com sucesso'
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content '400Km - 1200Km'
    expect(page).to have_content 'R$ 2,00'
  end
  it 'faltando informações' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Distância'
    fill_in 'Distância inicial', with: ''
    fill_in 'Distância final', with: ''
    fill_in 'Taxa', with: ''
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Preço por Distância'
    #Assert
    expect(page).to have_content 'Distância inicial não pode ficar em branco'
    expect(page).to have_content 'Distância final não pode ficar em branco'
    expect(page).to have_content 'Taxa não pode ficar em branco'
    expect(page).not_to have_content 'Preço cadastrado com sucesso'
  end
end