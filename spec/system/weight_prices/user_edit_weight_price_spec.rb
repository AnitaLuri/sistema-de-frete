require 'rails_helper'

describe 'Usuário edita preço por peso' do
  it 'com sucesso' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                  minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')
    WeightPrice.create!(initial_weight: 500, ending_weight: 2000, km_value: '1.25', transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Valores por Peso'
    click_on 'Editar'
    fill_in 'Peso inicial', with: '600'
    fill_in 'Peso final', with: '1000'
    fill_in 'Valor por Km', with: '1.55'
    select 'Motocicleta', from: 'Modalidade de Transporte'
    click_on 'Atualizar Preço por Peso'
    #Assert
    expect(page).to have_content 'Preço atualizado com sucesso!'
    expect(page).to have_content 'Motocicleta'
    expect(page).to have_content '600Kg - 1000Kg'
    expect(page).to have_content 'R$ 1,55'
  end
  it 'e precisa ser administrador' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 0)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    WeightPrice.create!(initial_weight: 500, ending_weight: 2000, km_value: '1.25', transport_mode: transport_mode)

    #Act
    login_as(user)
    visit root_path
    click_on 'Valores por Peso'
    #Assert
    expect(page).not_to have_content 'Editar'
  end
  it 'faltando informação' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: 'password', profile: 5)
    transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                  minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00') 
    TransportMode.create!(name: 'Motocicleta', minimum_distance: 1000, maximum_distance: 10_000, 
                                  minimum_weight: 1, maximum_weight: 50, fixed_value: '50,00')
    WeightPrice.create!(initial_weight: 500, ending_weight: 2000, km_value: '1.25', transport_mode: transport_mode)
    #Act
    login_as(user)
    visit root_path
    click_on 'Valores por Peso'
    click_on 'Editar'
    fill_in 'Peso inicial', with: ''
    fill_in 'Peso final', with: ''
    fill_in 'Valor por Km', with: ''
    click_on 'Atualizar Preço por Peso'
    #Assert
    expect(page).to have_content 'Peso inicial não pode ficar em branco'
    expect(page).to have_content 'Peso final não pode ficar em branco'
    expect(page).to have_content 'Valor por Km não pode ficar em branco'
    expect(page).not_to have_content 'Preço atualizado com sucesso!'
  end
end