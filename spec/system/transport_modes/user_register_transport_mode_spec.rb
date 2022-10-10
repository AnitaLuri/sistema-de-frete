require 'rails_helper'

describe 'Usuario cadastra modalidade de transporte' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    #Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Nova Modalidade'
    fill_in 'Nome', with: 'Motocicleta'
    fill_in 'Distância Mínima', with: '100'
    fill_in 'Distância Máxima', with: '1000'
    fill_in 'Peso Mínimo', with: '100'
    fill_in 'Peso Máximo', with: '15000'
    fill_in 'Valor Fixo', with: '30,00'
    click_on 'Criar Modalidade de Transporte'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Modalidade de Transporte criada com sucesso'
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content 'Distância mínima: 100Km'
    expect(page).to have_content 'Distância máxima: 1000Km'
  end
  it 'com mesmo nome' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    #Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Nova Modalidade'
    fill_in 'Nome', with: 'Motocicleta'
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Valor Fixo', with: ''
    click_on 'Criar Modalidade de Transporte'
    #Assert
    expect(page).to have_content 'Distância Mínima não pode ficar em branco'
    expect(page).to have_content 'Distância Máxima não pode ficar em branco'
    expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso Máximo não pode ficar em branco'
    expect(page).to have_content 'Valor Fixo não pode ficar em branco'
    expect(page).not_to have_content 'Modalidade de Transporte criada com sucesso'
  end
  it 'com informações faltando' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 1000, 
                          minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Nova Modalidade'
    fill_in 'Nome', with: 'Motocicleta'
    fill_in 'Distância Mínima', with: '1000'
    fill_in 'Distância Máxima', with: '10000'
    fill_in 'Peso Mínimo', with: '100'
    fill_in 'Peso Máximo', with: '15000'
    fill_in 'Valor Fixo', with: '30,00'
    click_on 'Criar Modalidade de Transporte'
    #Assert
    expect(page).to have_content 'Modalidade de Transporte não cadastrada'
    expect(page).to have_content 'Nome já está em uso'
  end
  it 'e não tem permissão' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 1000, 
                          minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Cadastrar Nova Modalidade'
    #Assert
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui permissão.'
  end
end