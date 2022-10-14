require 'rails_helper'

describe 'Usuário registra uma faixa de preços por peso' do
  it 'e esta autenticado' do 
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    
    visit new_weight_price_path
    
    expect(current_path).to eq new_user_session_path
  end
  it 'e é administrador' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
   
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Peso'
   
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 
    
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Peso'
    fill_in 'Peso inicial', with: '1000'
    fill_in 'Peso final', with: '3000'
    fill_in 'Valor por Km', with: '1.25'
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Preço por Peso'
    
    expect(page).to have_content 'Preço cadastrado com sucesso'
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content '1000Kg - 3000Kg'
    expect(page).to have_content 'R$ 1,25'
  end
  it 'com sucesso a partir do menu' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 
   
    login_as(user)
    visit root_path
    click_on 'Tabelas de Preços'
    click_on 'Por Peso'
    click_on 'Cadastrar Preço por Peso'
    fill_in 'Peso inicial', with: '1000'
    fill_in 'Peso final', with: '3000'
    fill_in 'Valor por Km', with: '1.25'
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Preço por Peso'
    
    expect(page).to have_content 'Preço cadastrado com sucesso'
    expect(page).to have_content 'Caminhão'
    expect(page).to have_content '1000Kg - 3000Kg'
    expect(page).to have_content 'R$ 1,25'
  end
  it 'faltando informações' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 
   
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    click_on 'Cadastrar Preço por Peso'
    fill_in 'Peso inicial', with: ''
    fill_in 'Peso final', with: ''
    fill_in 'Valor por Km', with: ''
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Preço por Peso'
   
    expect(page).to have_content 'Peso inicial não pode ficar em branco'
    expect(page).to have_content 'Peso final não pode ficar em branco'
    expect(page).to have_content 'Valor por Km não pode ficar em branco'
    expect(page).not_to have_content 'Preço cadastrado com sucesso'
  end
end