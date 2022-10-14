require 'rails_helper'

describe 'Usuário vê detalhes da modalidade de transporte' do 
  it 'sem se autenticar' do
    mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                minimum_weight: 1, maximum_weight: 50_000, fixed_value: '50,00')

    visit root_path
    click_on 'Motocicleta'

    expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 'regular')
    mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')

    login_as(user)
    visit root_path
    click_on 'Motocicleta'

    expect(current_path).to eq transport_mode_path(mode.id)
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content 'Peso Mínimo: 1Kg'
    expect(page).to have_content 'Peso Máximo: 50Kg'
    expect(page).to have_content 'Valor Fixo: R$ 50'
  end
end