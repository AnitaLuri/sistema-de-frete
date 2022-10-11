require 'rails_helper'

describe 'Usuário ve prazos de entrega' do
  it 'e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Prazos'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'a partir da página inicial' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    Deadline.create!(start: 400, limit: 800, time: 72, transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Prazos'
    #Assert
    expect(page).to have_content 'Distância'
    expect(page).to have_content '400Km - 800Km'
    expect(page).to have_content 'Prazo'
    expect(page).to have_content '72h'
    expect(page).to have_content 'Modalidade de Transporte'
    expect(page).to have_content 'Caminhão'
  end
  it 'a partir da página da modalidade' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    Deadline.create!(start: 400, limit: 800, time: 72, transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Caminhão'
    #Assert
    expect(page).to have_content 'Prazo de Entrega'
    expect(page).to have_content 'Distância'
    expect(page).to have_content '400Km - 800Km'
    expect(page).to have_content 'Prazo'
    expect(page).to have_content '72h'
  end
end