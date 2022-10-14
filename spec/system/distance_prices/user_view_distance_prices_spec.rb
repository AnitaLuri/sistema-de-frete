require 'rails_helper'

describe 'Usuário vê os preços por distância de cada modalidade de transporte' do
  it 'a partir da página de detalhes da modalidade de transporte' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    DistancePrice.create!(initial_distance: 400, ending_distance: 1000, price: '5.00', 
                          transport_mode: transport_mode)

    login_as(user)
    visit root_path
    click_on 'Caminhão'

    expect(page).to have_content 'Preços por Distância'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'Taxa'
    expect(page).to have_content '400Km - 1000Km'
    expect(page).to have_content 'R$ 5,00'
  end
end