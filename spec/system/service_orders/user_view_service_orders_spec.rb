require 'rails_helper'

describe 'Usuário vê ordem de serviço' do
  it 'pendente e deve estar autenticado' do
    #Arrange
    #Act
    visit root_path
    click_on 'Ordens'
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                                  product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    #Assert
    expect(page).to have_content 'Ordens de Serviço Pendentes'
    expect(page).to have_content 'Destinatário: Maria Silva'
    expect(page).to have_content 'Situação: Pendente'
  end
end