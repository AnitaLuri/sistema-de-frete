require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Usuário'

    expect(page).not_to have_content 'Entrar'
    expect(page).to have_button 'Sair'
    within ('nav') do
      expect(page).to have_content 'teste@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Você realizou seu registro com sucesso.'
  end
  it 'com informações faltando' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Criar Usuário'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
  it 'com email invalido' do
    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'E-mail', with: 'teste@frete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Usuário'

    expect(page).to have_content 'E-mail não é válido'
  end
  it 'com email único' do
    User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password')

    visit root_path
    click_on 'Entrar'
    click_on 'Criar conta'
    fill_in 'Nome', with: 'João'
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Usuário'
 
    expect(page).to have_content 'E-mail já está em uso'
  end
end