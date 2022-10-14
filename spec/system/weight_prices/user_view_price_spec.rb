require 'rails_helper'

describe 'Usuário vê os preços por peso de cada modalidade de transporte' do
  it 'a partir da página de detalhes da modalidade de transporte' do 
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 400, maximum_distance: 5000, 
                                  minimum_weight: 1000, maximum_weight: 2000, fixed_value: '500,00') 
    WeightPrice.create!(initial_weight: 500, ending_weight: 2000, km_value: '1.25', transport_mode: transport_mode)
    
    login_as(user)
    visit root_path
    click_on 'Caminhão'
  
    expect(page).to have_content 'Preços por Peso'
    expect(page).to have_content 'Intervalo'
    expect(page).to have_content 'Valor por Km'
    expect(page).to have_content '500Kg - 2000Kg'
    expect(page).to have_content 'R$ 1,25'
    expect(page).to have_content 'Preços por Distância'
  end
end