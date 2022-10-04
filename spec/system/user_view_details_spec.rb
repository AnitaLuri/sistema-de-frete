require 'rails_helper'

describe 'Usuário vê detalhes da modalidade de transporte' do 
  it 'com sucesso' do
    #Arrange
    mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                        minimum_weight: 1, maximum_weight: 50_000, fixed_value: '50,00')
    #Act
    visit root_path
    click_on 'Motocicleta'
    #Assert
    expect(current_path).to eq transport_mode_path(mode.id)
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content 'Peso Mínimo: 1g'
    expect(page).to have_content 'Peso Máximo: 50000g'
    expect(page).to have_content 'Valor Fixo: R$ 50'

  end
end