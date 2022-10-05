# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# User
first_user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: 'password', profile: 5)
second_user = User.create!(name: 'João', email: 'joao@sistemadefrete.com.br', password: 'password', profile: 0)

# TransportMode
first_transport_mode = TransportMode.create!(name: 'Caminhão', minimum_distance: 100, maximum_distance: 5000, 
                                minimum_weight: 50000, maximum_weight: 5000000, fixed_value: '500,00')
second_transport_mode = TransportMode.create!(name: 'Motocicleta', minimum_distance: 1, maximum_distance: 50, 
                                minimum_weight: 1, maximum_weight: 50, fixed_value: '40,00')

# Vehicle
first_vehicle = Vehicle.create!(plate: 'ABC4252', brand: 'Ford', model: 'F350', year: 2014, 
                                weight_limit: 50000, transport_mode: first_transport_mode, status: 0)
second_vehicle = Vehicle.create!(plate: 'FGH5968', brand: 'Scania', model: 'P310', year: 2015, 
                                weight_limit: 40000, transport_mode: first_transport_mode, status: 0)