require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
    User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password')
    #Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end    
    #Assert
    expect(page).not_to have_content 'Entrar'
    expect(page).to have_link 'Sair'
    within ('nav') do
      expect(page).to have_content 'teste@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
end