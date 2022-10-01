require 'rails_helper'

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da app' do
    #Arrange
    #Act
    visit root_path
    #Assert
    expect(page).to have_content 'Sistema de Frete'
  end
end