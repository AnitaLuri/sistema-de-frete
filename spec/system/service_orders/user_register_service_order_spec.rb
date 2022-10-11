require 'rails_helper'

describe 'Usuário registra ordem de serviço' do
  it 'e é administrador' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    click_on 'Cadastrar Nova Ordem'
    #Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABCDEF123456789')  
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    click_on 'Cadastrar Nova Ordem'
    fill_in 'Origem', with: 'Av. Paulista, 500'
    fill_in 'Destino', with: 'Rua Jureia, 849'
    fill_in 'Distância', with: '5'
    fill_in 'Destinatário', with: 'Maria Lucia'
    fill_in 'Código do Produto', with: 'DELL-7000-TEC10'
    fill_in 'Largura', with: '40'
    fill_in 'Altura', with: '20'
    fill_in 'Profundidade', with: '20'
    fill_in 'Peso', with: '2'
    click_on 'Criar Ordem de Serviço'
    #Assert
    expect(page).to have_content 'Ordem de Serviço registrada com sucesso'
    expect(page).to have_content 'ABCDEF123456789'
    expect(page).to have_content 'Origem: Av. Paulista, 500'
    expect(page).to have_content 'Destino: Rua Jureia, 849'
    expect(page).to have_content 'Distância: 5Km'
    expect(page).to have_content 'Destinatário: Maria Lucia'
    expect(page).to have_content 'Código do Produto: DELL-7000-TEC10'
    expect(page).to have_content 'Dimensões: 40cm x 20cm x 20cm'
    expect(page).to have_content 'Peso: 2Kg'
    expect(page).to have_content 'Situação: Pendente'
  end
  it 'faltando informações' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)  
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    click_on 'Cadastrar Nova Ordem'
    fill_in 'Origem', with: ''
    fill_in 'Destino', with: ''
    fill_in 'Distância', with: ''
    fill_in 'Destinatário', with: ''
    fill_in 'Código do Produto', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Peso', with: ''
    click_on 'Criar Ordem de Serviço'
    #Assert
    expect(page).to have_content 'Ordem de Serviço não registrada'
    expect(page).to have_content 'Origem não pode ficar em branco'
    expect(page).to have_content 'Destino não pode ficar em branco'
    expect(page).to have_content 'Distância não pode ficar em branco'
    expect(page).to have_content 'Destinatário não pode ficar em branco'
    expect(page).to have_content 'Código do Produto não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
  end
end