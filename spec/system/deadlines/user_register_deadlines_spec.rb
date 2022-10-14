require 'rails_helper'

describe 'Usuário registra prazo de entrega' do
  it 'e é administrador' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 

    login_as(user)
    visit root_path
    click_on 'Prazos'
    click_on 'Cadastrar Prazo de Entrega'

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
    click_on 'Cadastrar Prazo de Entrega'
    fill_in 'Distância inicial', with: '100'
    fill_in 'Distância limite', with: '400'
    fill_in 'Prazo', with: '72'
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Prazo de Entrega'

    expect(page).to have_content 'Prazo de Entrega cadastrado com sucesso'
    expect(page).to have_content '100Km - 400Km'
    expect(page).to have_content '72h'
  end
  it 'faltando informações' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    first_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                          minimum_weight: 1000, maximum_weight: 15000, fixed_value: '500,00') 
    second_mode = TransportMode.create!(name: 'Van', minimum_distance: 400, maximum_distance: 1200, 
                                          minimum_weight: 150, maximum_weight: 1200, fixed_value: '20,00') 

    login_as(user)
    visit root_path
    click_on 'Prazos'
    click_on 'Cadastrar Prazo de Entrega'
    fill_in 'Distância inicial', with: ''
    fill_in 'Distância limite', with: ''
    fill_in 'Prazo', with: ''
    select 'Caminhão', from: 'Modalidade de Transporte'
    click_on 'Criar Prazo de Entrega'

    expect(page).to have_content 'Distância inicial não pode ficar em branco'
    expect(page).to have_content 'Distância limite não pode ficar em branco'
    expect(page).to have_content 'Prazo não pode ficar em branco'
    expect(page).not_to have_content 'Prazo de Entrega cadastrado com sucesso'
  end
end