require 'rails_helper'

describe 'Usuário registra um veiculo' do
  it 'e precisa ser administrador' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
   
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Novo Veículo'
    
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, minimum_weight: 50000, 
                                          maximum_weight: 5000000, fixed_value: '500,00') 
   
    login_as(user)
    visit root_path
    click_on 'Veículos'
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Placa', with: 'ABC4252'
    fill_in 'Marca', with: 'Ford'
    fill_in 'Modelo', with: 'F350'
    fill_in 'Ano de fabricação', with: '2014'
    fill_in 'Capacidade de carga', with: '50000'
    select 'Caminhão', from: 'Modalidade de Transporte'
    select 'Em manutenção', from: 'Situação'
    click_on 'Criar Veículo'
   
    expect(page).to have_content 'Veículo cadastrado com sucesso!'
    expect(page).to have_content 'Placa: ABC4252'
    expect(page).to have_content 'Marca: Ford'
    expect(page).to have_content 'Modelo: F350'
    expect(page).to have_content 'Ano de fabricação: 2014'
    expect(page).to have_content 'Capacidade de carga: 50000Kg'
    expect(page).to have_content 'Modalidade de Transporte: Caminhão'
    expect(page).to have_content 'Situação: Em manutenção'
    expect(page).not_to have_content 'Em operação'
  end
end