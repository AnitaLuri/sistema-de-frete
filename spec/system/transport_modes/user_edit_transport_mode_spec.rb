require 'rails_helper'

describe 'Usuário edita uma modalidade' do
  it 'e deve ser administrador' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 1000, minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Motocicleta'
    click_on 'Editar'
    #Assert
    expect(current_path).to eq root_path 
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 1000, minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Motocicleta'
    click_on 'Editar'
    fill_in 'Nome', with: 'Carro pequeno'
    fill_in 'Distância Máxima', with: '20000'
    fill_in 'Valor Fixo', with: '100,00'
    click_on 'Atualizar Modalidade de Transporte'
    #Assert
    expect(page).to have_content 'Modalidade de Transporte atualizada com sucesso!'
    expect(page).to have_content 'Carro pequeno'
    expect(page).to have_content 'Distância Máxima: 20000m'
    expect(page).to have_content 'Valor Fixo: R$ 100'
    expect(page).not_to have_content 'Motocicleta'
  end
  it 'e mantém os campos obrigatórios' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 1000, minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00') 
    #Act
    login_as(user)
    visit root_path
    click_on 'Motocicleta'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Valor Fixo', with: ''
    click_on 'Atualizar Modalidade de Transporte'
    #Assert
    expect(page).to have_content 'Não foi possível atualizar a Modalidade de Transporte.'
  end
end