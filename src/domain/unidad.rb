class Unidad

  attr_reader :tipo_de_unidad

  def self.piquera()
    return Unidad.new(Piquero.new())
  end

  def self.arquera()
    return Unidad.new(Arquero.new())
  end

  def self.caballera()
    return Unidad.new(Caballero.new())
  end

  def initialize(un_tipo_de_unidad)
    @tipo_de_unidad = un_tipo_de_unidad
  end

  def puntos_de_fuerza()
    return @tipo_de_unidad.puntos_de_fuerza
  end

  def entrenar_en(un_ejercito)
    un_ejercito.decrementar_oro(@tipo_de_unidad.costo_de_entrenamiento())
    @tipo_de_unidad.incrementar_puntos_de_fuerza()
  end

  def entrenar_para_ser_transformada_en(un_ejercito)
    self.validar_puede_transformarse_tipo_de_unidad()
    un_ejercito.decrementar_oro(@tipo_de_unidad.costo_de_transformacion())
    @tipo_de_unidad = @tipo_de_unidad.transformar()
  end

  #Private method
  def validar_puede_transformarse_tipo_de_unidad()
    raise RuntimeError.new('Esta unidad no puede ser transformada.') if (!@tipo_de_unidad.puede_ser_transformada())
  end

end

class TipoDeUnidad

  attr_reader :puntos_de_fuerza

  def initialize()
    raise 'Subclass responsibility (Implement this method)'
  end

  def incrementar_puntos_de_fuerza()
    raise 'Subclass responsibility (Implement this method)'
  end

  def costo_de_entrenamiento()
    raise 'Subclass responsibility (Implement this method)'
  end

  def puede_ser_transformada()
    return false
  end

end

class TipoDeUnidadTransformable < TipoDeUnidad
  def costo_de_transformacion()
    raise 'Subclass responsibility (Implement this method)'
  end

  def puede_ser_transformada()
    return true
  end
end

class Piquero < TipoDeUnidadTransformable

  def initialize()
    @puntos_de_fuerza = 5
  end

  def incrementar_puntos_de_fuerza()
    @puntos_de_fuerza += 3
  end

  def costo_de_entrenamiento()
    return 10
  end

  def costo_de_transformacion()
    return 30
  end

  def transformar()
    return Arquero.new()
  end

end

class Caballero < TipoDeUnidad

  def initialize()
    @puntos_de_fuerza = 20
  end

  def incrementar_puntos_de_fuerza()
    @puntos_de_fuerza += 10
  end

  def costo_de_entrenamiento()
    return 30
  end

end

class Arquero < TipoDeUnidadTransformable

  def initialize()
    @puntos_de_fuerza = 10
  end

  def incrementar_puntos_de_fuerza()
    @puntos_de_fuerza += 7
  end

  def costo_de_entrenamiento()
    return 20
  end

  def costo_de_transformacion()
    return 40
  end

  def transformar()
    return Caballero.new()
  end

end
