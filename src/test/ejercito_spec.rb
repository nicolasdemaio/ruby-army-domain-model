require 'rspec/autorun'
require_relative '../domain/ejercito'
require_relative '../domain/creador_de_unidades'
require_relative '../domain/unidad'

describe Ejercito do

  it 'es_creado_con_unidades_iniciales' do
    creador_de_unidades = CreadorDeUnidades.new()
    caballeros = creador_de_unidades.crear_unidades_de_tipo(Caballero, 10)
    arqueros = creador_de_unidades.crear_unidades_de_tipo(Arquero, 5)
    piqueros = creador_de_unidades.crear_unidades_de_tipo(Piquero, 5)
    army = Ejercito.new(caballeros + arqueros + piqueros, 1000)

    expect(army.unidades().length()).to eq(20)
  end

  it 'cuando_es_creado_contiene_1000_monedas_de_oro' do
    ejercito = Ejercito.civilizacion_china()

    expect(ejercito.monedas_de_oro()).to eq(1000)
  end

  it 'cuando_es_creado_no_tiene_batallas_luchadas' do
    army = Ejercito.new([], 1000)

    expect(army.batallas_luchadas().empty?).to be_truthy
  end

  it 'ejercito_chino_empieza_con_2_piqueros_25_arqueros_y_2_caballeros' do
    ejercito_chino = Ejercito.civilizacion_china()

    expect(ejercito_chino.unidades_de_tipo(Piquero).length()).to eq(2)
    expect(ejercito_chino.unidades_de_tipo(Arquero).length()).to eq(25)
    expect(ejercito_chino.unidades_de_tipo(Caballero).length()).to eq(2)
  end

  it 'ejercito_ingles_empieza_con_10_piqueros_10_arqueros_y_10_caballeros' do
    ejercito_ingles = Ejercito.civilizacion_inglesa()

    expect(ejercito_ingles.unidades_de_tipo(Piquero).length()).to eq(10)
    expect(ejercito_ingles.unidades_de_tipo(Arquero).length()).to eq(10)
    expect(ejercito_ingles.unidades_de_tipo(Caballero).length()).to eq(10)
  end

  it 'ejercito_bizantino_empieza_con_10_piqueros_10_arqueros_y_10_caballeros' do
    ejercito_bizantino = Ejercito.civilizacion_bizantina()

    expect(ejercito_bizantino.unidades_de_tipo(Piquero).length()).to eq(5)
    expect(ejercito_bizantino.unidades_de_tipo(Arquero).length()).to eq(8)
    expect(ejercito_bizantino.unidades_de_tipo(Caballero).length()).to eq(15)
  end

  it 'cuando_un_piquero_es_entrenado_aumenta_3_puntos_su_fuerza_y_ejercito_gasta_10_de_oro' do
    piquero = Unidad.piquera()
    ejercito = Ejercito.new([piquero], 1000)

    ejercito.entrenar(piquero)

    expect(piquero.puntos_de_fuerza()).to eq(8)
    expect(ejercito.monedas_de_oro).to eq(990)
  end

  it 'cuando_un_arquero_es_entrenado_aumenta_7_puntos_su_fuerza_y_ejercito_gasta_20_de_oro' do
    arquero = Unidad.arquera()
    ejercito = Ejercito.new([arquero], 1000)

    ejercito.entrenar(arquero)

    expect(arquero.puntos_de_fuerza()).to eq(17)
    expect(ejercito.monedas_de_oro).to eq(980)
  end

  it 'cuando_un_caballero_es_entrenado_aumenta_10_puntos_su_fuerza_y_ejercito_gasta_30_de_oro' do
    caballero = Unidad.caballera()
    ejercito = Ejercito.new([caballero], 1000)

    ejercito.entrenar(caballero)

    expect(caballero.puntos_de_fuerza()).to eq(30)
    expect(ejercito.monedas_de_oro).to eq(970)
  end

  it 'no_puede_entrenar_una_unidad_si_no_dispone_del_oro_suficinete' do
    caballero = Unidad.caballera()
    una_cantidad_de_monedas_de_oro = 3
    ejercito = Ejercito.new([caballero], una_cantidad_de_monedas_de_oro)

    expect{ejercito.entrenar(caballero)}.to raise_error(RuntimeError)

    expect(caballero.puntos_de_fuerza()).to eq(20)
    expect(ejercito.monedas_de_oro).to eq(3)
  end

  it 'cuando_un_piquero_es_transformado_a_arquero_el_ejercito_gasta_30_de_oro' do
    unidad = Unidad.piquera()
    ejercito = Ejercito.new([unidad], 1000)

    ejercito.entrenar_para_transformar(unidad)

    expect(unidad.tipo_de_unidad().class()).to eq(Arquero)
    expect(ejercito.monedas_de_oro).to eq(970)
  end

  it 'cuando_un_arquero_es_transformado_a_caballero_el_ejercito_gasta_40_de_oro' do
    unidad = Unidad.arquera()
    ejercito = Ejercito.new([unidad], 1000)

    ejercito.entrenar_para_transformar(unidad)

    expect(unidad.tipo_de_unidad().class()).to eq(Caballero)
    expect(ejercito.monedas_de_oro).to eq(960)
  end

  it 'una_unidad_de_tipo_caballero_no_puede_ser_transformada' do
    unidad = Unidad.caballera()
    ejercito = Ejercito.new([unidad], 1000)

    expect{ejercito.entrenar_para_transformar(unidad)}.to raise_error(RuntimeError)

    expect(unidad.tipo_de_unidad().class()).to eq(Caballero)
    expect(ejercito.monedas_de_oro).to eq(1000)
  end

  it 'cuando_un_ejercito_gana_una_batalla_recibe_100_monedas_de_oro' do
    ejercito_ganador = Ejercito.civilizacion_inglesa()
    ejercito_perdedor = Ejercito.civilizacion_china()

    ejercito_ganador.atacar(ejercito_perdedor)

    expect(ejercito_ganador.monedas_de_oro()).to eq(1100)
  end

  it 'cuando_un_ejercito_pierde_una_batalla_pierde_las_dos_unidades_con_mayor_puntaje' do
    ejercito_ganador = Ejercito.civilizacion_inglesa()
    ejercito_perdedor = Ejercito.civilizacion_china()

    unidades_con_mayor_puntaje = ejercito_perdedor.unidades_con_mayor_puntaje(2)
    cantidad_de_unidades = ejercito_perdedor.unidades().length()

    ejercito_ganador.atacar(ejercito_perdedor)

    expect(ejercito_perdedor.unidades().include?(unidades_con_mayor_puntaje)).to be_falsey
    expect(ejercito_perdedor.unidades().length()).to eq(cantidad_de_unidades - 2)
  end

  it 'cuando_hay_empate_en_batalla_ambos_ejercitos_pierden_su_unidad_mas_fuerte' do
    ejercito_chino_norte = Ejercito.civilizacion_china()
    ejercito_chino_sur = Ejercito.civilizacion_china()

    cantidad_de_unidades_norte = ejercito_chino_norte.unidades().length()
    cantidad_de_unidades_sur = ejercito_chino_sur.unidades().length()

    ejercito_chino_norte.atacar(ejercito_chino_sur)

    expect(ejercito_chino_norte.unidades().length()).to eq(cantidad_de_unidades_norte - 1)
    expect(ejercito_chino_sur.unidades().length()).to eq(cantidad_de_unidades_sur - 1)
  end

  it 'cuando_hay_empate_en_batalla_ambos_ejercitos_registran_un_empate_en_su_historial' do
    ejercito_chino_norte = Ejercito.civilizacion_china()
    ejercito_chino_sur = Ejercito.civilizacion_china()

    ejercito_chino_norte.atacar(ejercito_chino_sur)

    expect(ejercito_chino_norte.batallas_luchadas.first().resultado()).to eq('Empate')
    expect(ejercito_chino_sur.batallas_luchadas.first().resultado()).to eq('Empate')
  end

  it 'cuando_no_es_empate_se_registran_en_los_historiales_los_resultados_correspondientes' do
    ejercito_ganador = Ejercito.civilizacion_inglesa()
    ejercito_perdedor = Ejercito.civilizacion_china()

    ejercito_ganador.atacar(ejercito_perdedor)

    expect(ejercito_ganador.batallas_luchadas.first().resultado()).to eq('Victoria')
    expect(ejercito_perdedor.batallas_luchadas.first().resultado()).to eq('Derrota')
  end

end
