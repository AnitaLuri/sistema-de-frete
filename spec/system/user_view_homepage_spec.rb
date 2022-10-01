require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da app' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Sistema de Frete'
  end
  it 'e vê as modalidades de transporte' do
    #Arrange
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                          minimum_weight: 100, maximum_weight: 15_000, fixed_value: 30.00)
    TransportMode.create!(name: 'Carro', minimum_distance: 10_000, maximum_distance: 100_000, 
                          minimum_weight: 1, maximum_weight: 100_000, fixed_value: 70.00)
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Modalidades de Transporte'
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content 'Carro'
    expect(page).not_to have_content 'Nenhuma Modalidade de Transporte cadastrada.'
  end
  it 'e não existem modalidades cadastradas' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Nenhuma Modalidade de Transporte cadastrada.'
  end
end