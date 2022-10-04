require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'falso quando o nome fica em branco' do
      #Arrange
      user = User.new(name: '', email: 'teste@sistemadefrete.com.br', password: 'password')
      #Act
      #Assert
      expect(user.valid?).to eq false
    end
    it 'falso quando o email fica em branco' do
      #Arrange
      user = User.new(name: 'Maria', email: '', password: 'password')
      #Act
      #Assert
      expect(user.valid?).to eq false
    end
    it 'falso quando o senha fica em branco' do
      #Arrange
      user = User.new(name: 'Maria', email: 'teste@sistemadefrete.com.br', password: '')
      #Act
      #Assert
      expect(user.valid?).to eq false
    end
    it 'falso quando o email é de outro domínio' do
      #Arrange
      user = User.new(name: 'Maria', email: 'teste@qualquerdominio.com.br', password: 'password')
      other_user = User.new(name: 'Maria', email: 'regular@sistemadefrete.com.br', password: 'password')
      #Act
      #Assert
      expect(user.valid?).to eq false
      expect(other_user.valid?).to eq true
    end
  end
end
