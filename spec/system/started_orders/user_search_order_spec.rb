require 'rails_helper'

describe 'Visitante busca uma ordem de serviço' do
  it 'com sucesso um pedido iniciado' do
    transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                minimum_weight: 1, maximum_weight: 20, fixed_value: '30,00')
    first_vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    second_vehicle = Vehicle.create!(plate: 'FGH4321', brand: 'Honda', model: 'PCX', year: 2021, 
                                weight_limit: 40, transport_mode: transport_mode, status: 0)
    WeightPrice.create!(initial_weight: 0, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
    DistancePrice.create!(initial_distance: 0, ending_distance: 30, price: '5.50', transport_mode: transport_mode)
    deadline = Deadline.create!(start: 0, limit: 50, time: 24, transport_mode: transport_mode)
    order = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                                product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 5)
    started = StartedOrder.create!(service_order: order, transport_mode: transport_mode, vehicle:second_vehicle,
                                delivery_time: '24', total_value: '40.50', status: 0, created_at: Date.today)

    visit root_path
    fill_in 'Buscar Ordem de Serviço', with: started.service_order.code
    click_on 'Buscar'

    expect(page).to have_content 'Resultado da busca'
    expect(page).to have_content 'Origem: Av. Paulista, 500'
    expect(page).to have_content 'Destino: Rua Jureia, 849'
    expect(page).to have_content 'Destinatário: Maria Lucia'
    expect(page).to have_content 'Código do Produto: DELL-7000-TEC10'
    expect(page).to have_content 'Situação: Iniciado'
    expect(page).to have_content 'Veículo placa: FGH4321'
    expect(page).to have_content 'Valor Total: R$ 40,50'
    expect(page).to have_content 'Prazo de entrega: 24h'
    expect(page).to have_content "Iniciado em: "
  end
end