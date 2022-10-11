require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe '#valid?' do
    it 'falso quando a origem fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: '', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando o destino fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: '', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a distância fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: '', recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando o detinatário fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: '',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando o código de produto fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: '', width: 40, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a largura fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: '', height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a largura for menor que zero' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: -1, height: 20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a altura fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: '', depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a altura for menor que zero' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: -20, depth: 20, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a profundida fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: '', weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando a profundida for menor que zero' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: -5, weight: 2)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando o peso fica em branco' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: '')
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
    it 'falso quando o peso for menor que zero' do
      #Arrange
      order = ServiceOrder.new(from: 'Av. Paulista, 500', to: 'Rua Jureia, 849', distance: 5, recipient: 'Maria Silva',
                              product_code: 'DELL-7000-TEC10', width: 40, height: 20, depth: 20, weight: 0)
      #Act
      #Assert
      expect(order.valid?).to eq false
    end
  end
end
