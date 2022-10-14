require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end    

    expect(page).not_to have_content 'Entrar'
    expect(page).to have_button 'Sair'
    within ('nav') do
      expect(page).to have_content 'teste@sistemadefrete.com.br'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
  it 'e faz logout' do 
     User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password')

     visit root_path
     click_on 'Entrar'
     within('form') do
       fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
       fill_in 'Senha', with: 'password'
       click_on 'Entrar'
     end 
     click_on 'Sair'   

     expect(page).to have_link 'Entrar'
     expect(page).to have_content 'Logout efetuado com sucesso.'
     expect(page).not_to have_content 'teste@sistemadefrete.com.br'
     expect(page).not_to have_button 'Sair' 
  end
end