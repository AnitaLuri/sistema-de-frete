require 'rails_helper'

describe 'Usuário registra ordem de serviço' do
  it 'e é administrador' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                          minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                          product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)

    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on order.code
    click_on 'Editar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui permissão.'
  end
  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                          minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                          product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)

    login_as(user)
    visit root_path
    click_on 'Ordens de Serviço'
    click_on order.code
    click_on 'Editar'
    fill_in 'Origem', with: 'Av. Paulista, 600'
    fill_in 'Destino', with: 'Rua Jureia, 840'
    fill_in 'Distância', with: '6'
    fill_in 'Destinatário', with: 'Lucia'
    fill_in 'Profundidade', with: '10'
    fill_in 'Peso', with: '3'
    click_on 'Atualizar Ordem de Serviço'

    expect(page).to have_content 'Ordem de Serviço atualizado com sucesso!'
    expect(page).to have_content 'Destinatário: Lucia'
    expect(page).to have_content 'Situação: Pendente'
  end
end