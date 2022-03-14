require 'rspec/autorun'
require_relative '../domain/creador_de_unidades'
require_relative '../domain/unidad'

describe CreadorDeUnidades do

    it 'crea_una_cantidad_de_unidades_dada' do
      creador_de_unidades = CreadorDeUnidades.new()
      una_cantidad = 5

      piqueros = creador_de_unidades.crear_unidades_de_tipo(Piquero, una_cantidad)

      expect(piqueros.length()).to eq(5)
      expect(piqueros.all? { |piquero| piquero.tipo_de_unidad.class == Piquero }).to be_truthy
    end

    it 'no_puede_crear_unidades_con_una_cantidad_menor_a_cero' do
      creador_de_unidades = CreadorDeUnidades.new()
      una_cantidad_invalida = -1

      expect{creador_de_unidades.crear_unidades_de_tipo(Piquero, una_cantidad_invalida)}.to raise_error(RuntimeError)
    end

end
