require_relative '../domain/batalla'

class Ejercito

  attr_reader :unidades,:monedas_de_oro,:batallas_luchadas

  def self.civilizacion_china()
    creador_de_unidades = CreadorDeUnidades.new()
    unidades = creador_de_unidades.crear_unidades(25, 2, 2)
    return Ejercito.new(unidades, 1000)
  end

  def self.civilizacion_inglesa()
    creador_de_unidades = CreadorDeUnidades.new()
    unidades = creador_de_unidades.crear_unidades(10, 10, 10)
    return Ejercito.new(unidades, 1000)
  end

  def self.civilizacion_bizantina()
    creador_de_unidades = CreadorDeUnidades.new()
    unidades = creador_de_unidades.crear_unidades(8, 5, 15)
    return Ejercito.new(unidades, 1000)
  end

  def initialize(unidades, una_cantidad_de_monedas_de_oro)
    @unidades = unidades
    @monedas_de_oro = una_cantidad_de_monedas_de_oro
    @batallas_luchadas = []
  end

  def unidades_de_tipo(un_tipo_de_unidad)
    return @unidades.select {|unidad| unidad.tipo_de_unidad.class == un_tipo_de_unidad}
  end

  def entrenar(una_unidad)
    una_unidad.entrenar_en(self)
  end

  def decrementar_oro(una_cantidad)
    validar_puede_decrementar_oro(una_cantidad)
    @monedas_de_oro -= una_cantidad
  end

  def entrenar_para_transformar(una_unidad)
    una_unidad.entrenar_para_ser_transformada_en(self)
  end

  def atacar(otro_ejercito)
    Batalla.realizar_combate_entre(self, otro_ejercito)
  end

  def ejecutar_empate_de_batalla_contra(otro_ejercito)
    unidades = self.unidades_con_mayor_puntaje(1)
    unidades.each { |unidad|  @unidades.delete_at(@unidades.index(unidad)) }
    @batallas_luchadas.push(RegistroDeBatalla.empate(self, otro_ejercito))
  end

  def ejecutar_victoria_de_batalla_contra(otro_ejercito)
    @monedas_de_oro += 100
    @batallas_luchadas.push(RegistroDeBatalla.victoria(self, otro_ejercito))
  end

  def ejecutar_derrota_de_batalla_contra(otro_ejercito)
    unidades = self.unidades_con_mayor_puntaje(2)
    unidades.each { |unidad|  @unidades.delete_at(@unidades.index(unidad)) }
    @batallas_luchadas.push(RegistroDeBatalla.derrota(self, otro_ejercito))
  end

  def total_de_puntos()
    return @unidades.inject(0){|sum,unidad| sum + unidad.puntos_de_fuerza() }
  end

  def unidades_con_mayor_puntaje(cantidad_unidades_a_obtener)
    unidades_ordenadas = @unidades.sort_by(&:puntos_de_fuerza)
    return unidades_ordenadas.first(cantidad_unidades_a_obtener)
  end

  # Private method
  def validar_puede_decrementar_oro(una_cantidad)
    raise RuntimeError.new('La cantidad de monedas de oro no puede ser negativa') if (@monedas_de_oro - una_cantidad < 0)
  end

end
