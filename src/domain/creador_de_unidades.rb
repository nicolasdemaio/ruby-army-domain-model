class CreadorDeUnidades

  def crear_unidades_de_tipo(un_tipo_de_unidad, una_cantidad)
      validar_puede_crear_unidades_con(una_cantidad)
      unidades_creadas = Array.new
      una_cantidad.times do
          unidades_creadas.push(Unidad.new(un_tipo_de_unidad.new()))
      end
      return unidades_creadas
  end

  def crear_unidades(cantidad_de_arqueros, cantidad_de_piqueros, cantidad_de_caballeros)
    arqueros = self.crear_unidades_de_tipo(Arquero, cantidad_de_arqueros)
    piqueros = self.crear_unidades_de_tipo(Piquero, cantidad_de_piqueros)
    caballeros = self.crear_unidades_de_tipo(Caballero, cantidad_de_caballeros)
    return arqueros + piqueros + caballeros
  end

  # Private method
  def validar_puede_crear_unidades_con(una_cantidad)
    raise RuntimeError.new('La cantidad no puede ser negativa') if (una_cantidad < 0)
  end

end
