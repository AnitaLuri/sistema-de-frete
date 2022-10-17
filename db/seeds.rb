# User
  User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: 'password', profile: 5)
  User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', profile: 0)

# TransportMode
  transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 60, 
                                        minimum_weight: 1, maximum_weight: 40, fixed_value: '30,00')
  first_transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 401, maximum_distance: 5000, 
                                        minimum_weight: 1000, maximum_weight: 10000, fixed_value: '300,00')
  second_transport_mode = TransportMode.create!(name: 'Van', minimum_distance: 100, maximum_distance: 400, 
                                        minimum_weight: 500, maximum_weight: 1000, fixed_value: '200,00')
  third_transport_mode =TransportMode.create!(name: 'Carro', minimum_distance: 1, maximum_distance: 50, 
                                        minimum_weight: 1, maximum_weight: 100, fixed_value: '70,00')

# Vehicle
  first_vehicle = Vehicle.create!(plate: 'ABC1111', brand: 'Yamaha', model: 'YBR', year: 2020, 
                                        weight_limit: 40, transport_mode: transport_mode, status: 0)
  second_vehicle = Vehicle.create!(plate: 'FGH4321', brand: 'Honda', model: 'PCX', year: 2021, 
                                        weight_limit: 40, transport_mode: transport_mode, status: 0)
  third_vehicle = Vehicle.create!(plate: 'DFG7890', brand: 'Honda', model: 'PCX', year: 2022, 
                                        weight_limit: 40, transport_mode: transport_mode, status: 0)
  Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                        weight_limit: 6000, transport_mode: first_transport_mode, status: 0)
  Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                                        weight_limit: 5000, transport_mode: first_transport_mode, status: 0)
  Vehicle.create!(plate: 'FGH2635', brand: 'Scania', model: 'P310', year: 2015, 
                                        weight_limit: 4000, transport_mode: first_transport_mode, status: 0)

# WeightPrice
  WeightPrice.create!(initial_weight: 0, ending_weight: 10, km_value: '0.80', transport_mode: transport_mode)
  WeightPrice.create!(initial_weight: 11, ending_weight: 20, km_value: '1.00', transport_mode: transport_mode)
  WeightPrice.create!(initial_weight: 21, ending_weight: 50, km_value: '1.50', transport_mode: transport_mode)
  WeightPrice.create!(initial_weight: 51, ending_weight: 100, km_value: '3.00', transport_mode: transport_mode)

  WeightPrice.create!(initial_weight: 1000, ending_weight: 2000, km_value: '5.20', transport_mode: first_transport_mode)
  WeightPrice.create!(initial_weight: 2001, ending_weight: 3000, km_value: '5.50', transport_mode: first_transport_mode)
  WeightPrice.create!(initial_weight: 3001, ending_weight: 4000, km_value: '5.80', transport_mode: first_transport_mode)
  WeightPrice.create!(initial_weight: 4001, ending_weight: 5000, km_value: '6.00', transport_mode: first_transport_mode)

  WeightPrice.create!(initial_weight: 500, ending_weight: 600, km_value: '3.20', transport_mode: second_transport_mode)
  WeightPrice.create!(initial_weight: 601, ending_weight: 700, km_value: '3.50', transport_mode: second_transport_mode)
  WeightPrice.create!(initial_weight: 701, ending_weight: 800, km_value: '3.80', transport_mode: second_transport_mode)
  WeightPrice.create!(initial_weight: 801, ending_weight: 1000, km_value: '4.00', transport_mode: second_transport_mode)

  WeightPrice.create!(initial_weight: 1, ending_weight: 30, km_value: '3.20', transport_mode: third_transport_mode)
  WeightPrice.create!(initial_weight: 31, ending_weight: 50, km_value: '3.50', transport_mode: third_transport_mode)
  WeightPrice.create!(initial_weight: 51, ending_weight: 70, km_value: '3.80', transport_mode: third_transport_mode)
  WeightPrice.create!(initial_weight: 71, ending_weight: 100, km_value: '4.00', transport_mode: third_transport_mode)

# DistancePrice
  DistancePrice.create!(initial_distance: 0, ending_distance: 15, price: '4.50', transport_mode: transport_mode)    
  DistancePrice.create!(initial_distance: 16, ending_distance: 30, price: '5.00', transport_mode: transport_mode)
  DistancePrice.create!(initial_distance: 31, ending_distance: 45, price: '5.50', transport_mode: transport_mode)
  DistancePrice.create!(initial_distance: 46, ending_distance: 60, price: '6.00', transport_mode: transport_mode)

  DistancePrice.create!(initial_distance: 401, ending_distance: 1400, price: '30.50', transport_mode: first_transport_mode)    
  DistancePrice.create!(initial_distance: 1401, ending_distance: 2400, price: '40.50', transport_mode: first_transport_mode)
  DistancePrice.create!(initial_distance: 2401, ending_distance: 4000, price: '50.50', transport_mode: first_transport_mode)
  DistancePrice.create!(initial_distance: 4001, ending_distance: 5000, price: '60.50', transport_mode: first_transport_mode)

  DistancePrice.create!(initial_distance: 101, ending_distance: 200, price: '10.50', transport_mode: second_transport_mode)    
  DistancePrice.create!(initial_distance: 201, ending_distance: 300, price: '20.50', transport_mode: second_transport_mode)
  DistancePrice.create!(initial_distance: 301, ending_distance: 400, price: '30.50', transport_mode: second_transport_mode)

  DistancePrice.create!(initial_distance: 1, ending_distance: 20, price: '5.50', transport_mode: third_transport_mode)    
  DistancePrice.create!(initial_distance: 21, ending_distance: 40, price: '6.50', transport_mode: third_transport_mode)
  DistancePrice.create!(initial_distance: 41, ending_distance: 60, price: '7.50', transport_mode: third_transport_mode)
  DistancePrice.create!(initial_distance: 61, ending_distance: 100, price: '8.50', transport_mode: third_transport_mode)

# Deadline  
  deadline = Deadline.create!(start: 0, limit: 20, time: 12, transport_mode: transport_mode)
  Deadline.create!(start: 21, limit: 30, time: 24, transport_mode: transport_mode)
  Deadline.create!(start: 31, limit: 40, time: 36, transport_mode: transport_mode)

  Deadline.create!(start: 401, limit: 800, time: 36, transport_mode: first_transport_mode)
  Deadline.create!(start: 801, limit: 2000, time: 48, transport_mode: first_transport_mode)
  Deadline.create!(start: 2001, limit: 3500, time: 72, transport_mode: first_transport_mode)
  Deadline.create!(start: 3501, limit: 5000, time: 96, transport_mode: first_transport_mode)

  Deadline.create!(start: 100, limit: 200, time: 24, transport_mode: second_transport_mode)
  Deadline.create!(start: 201, limit: 300, time: 36, transport_mode: second_transport_mode)
  Deadline.create!(start: 301, limit: 400, time: 48, transport_mode: second_transport_mode)

  Deadline.create!(start: 1, limit: 20, time: 24, transport_mode: third_transport_mode)
  Deadline.create!(start: 21, limit: 30, time: 36, transport_mode: third_transport_mode)
  Deadline.create!(start: 31, limit: 50, time: 48, transport_mode: third_transport_mode)

# ServiceOrder
  order_one = ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Lucia',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 0)
  order_two = ServiceOrder.create!(from: 'Av. Paulista, 100', to: 'Rua Jureia, 200', distance: 6, recipient: 'Joana Silva',
                              product_code: 'XPTO-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 0)
  order_three = ServiceOrder.create!(from: 'Av. Paulista, 10', to: 'Rua Jureia, 829', distance: 16, recipient: 'Ana',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 0)
  ServiceOrder.create!(from: 'Av. Paulista, 6000', to: 'Rua Jureia, 30', distance: 2, recipient: 'Luana',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 15, status: 0)
  ServiceOrder.create!(from: 'Av. Paulista, 30', to: 'Rua Jureia, 8491', distance: 50, recipient: 'Rafaela',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 0)
  ServiceOrder.create!(from: 'Av. Paulista, 500', to: 'Rua Jureia, 6', distance: 1000, recipient: 'Bruna',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2, status: 0)
                              

 