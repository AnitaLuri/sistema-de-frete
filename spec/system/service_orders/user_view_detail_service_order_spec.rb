require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço'  do
  it 'e visualiza as modalidade' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00')
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                  product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
    #Act
    login_as(user)
    visit root_path
    click_on 'Ordens'
    click_on order.code
    #Assert
    expect(page).to have_content order.code
    expect(page).to have_content 'Origem: Av. Paulista, 500'
    expect(page).to have_content 'Destino: Rua Jureia, 849'
    expect(page).to have_content 'Distância: 5Km'
    expect(page).to have_content 'Destinatário: Maria Lucia'
    expect(page).to have_content 'Código do Produto: DELL-7000-TEC10'
    expect(page).to have_content 'Dimensões: 40cm x 20cm x 20cm'
    expect(page).to have_content 'Peso: 2Kg'
  end
end