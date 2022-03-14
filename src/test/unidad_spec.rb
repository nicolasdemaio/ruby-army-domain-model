require 'rspec/autorun'
require_relative '../domain/unidad'

describe TipoDeUnidad do

  it 'arqueros_tienen_10_puntos_de_fuerza_base' do
    arquero = Arquero.new()

    expect(arquero.puntos_de_fuerza()).to eq(10)
  end

  it 'piqueros_tienen_5_puntos_de_fuerza_base' do
    piquero = Piquero.new()

    expect(piquero.puntos_de_fuerza()).to eq(5)
  end

  it 'caballeros_tienen_20_puntos_de_fuerza_base' do
    caballero = Caballero.new()

    expect(caballero.puntos_de_fuerza()).to eq(20)
  end

end
