require 'rails_helper'

describe 'Usuário altera status da modalidade' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 1000, 
                        minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00', status: 0) 
    #Act
    login_as(user)
    visit root_path
    click_on 'Motocicleta'
    click_on 'Desativar'
    #Assert
    expect(page).to have_content 'Modalidade de Transporte desativada'
    expect(page).to have_content 'Status: Inativa'
    expect(page).to have_button 'Ativar'
  end
  it 'e é administrador' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 100, maximum_distance: 1000, 
                        minimum_weight: 500, maximum_weight: 50000, fixed_value: '20,00', status: 0) 
    #Act
    login_as(user)
    visit root_path
    click_on 'Motocicleta'
    #Assert
    expect(page).not_to have_button 'Desativar'
    expect(page).not_to have_button 'Ativar'
  end
end