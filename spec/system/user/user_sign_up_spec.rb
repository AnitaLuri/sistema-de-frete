require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    #Arrange
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Usuário'
    #Assert
    expect(page).not_to have_content 'Entrar'
    expect(page).to have_button 'Sair'
    within ('nav') do
      expect(page).to have_content 'teste@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Você realizou seu registro com sucesso.'
  end
  it 'com informações faltando' do
    #Arrange
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Usuário'
    #Assert
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
end