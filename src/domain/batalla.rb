class ResolucionDeBatalla
  def self.puede_hacerse_cargo_de_combate_entre(ejercito_atacante, ejercito_atacado)
    raise 'Subclass responsibility'
  end

  def ejecutar_resolucion_entre(ejercito_atacante, ejercito_atacado)
    raise 'Subclass responsibility'
  end

end

class ResolucionGanadoraParaAtacante < ResolucionDeBatalla
  def self.puede_hacerse_cargo_de_combate_entre(ejercito_atacante, ejercito_atacado)
    return ejercito_atacante.total_de_puntos() > ejercito_atacado.total_de_puntos()
  end

  def ejecutar_resolucion_entre(ejercito_atacante, ejercito_atacado)
    ejercito_atacante.ejecutar_victoria_de_batalla_contra(ejercito_atacado)
    ejercito_atacado.ejecutar_derrota_de_batalla_contra(ejercito_atacante)
  end
end

class ResolucionGanadoraParaAtacado < ResolucionDeBatalla
  def self.puede_hacerse_cargo_de_combate_entre(ejercito_atacante, ejercito_atacado)
    return ejercito_atacante.total_de_puntos() < ejercito_atacado.total_de_puntos()
  end

  def ejecutar_resolucion_entre(ejercito_atacante, ejercito_atacado)
    ejercito_atacado.ejecutar_victoria_de_batalla_contra(ejercito_atacante)
    ejercito_atacante.ejecutar_derrota_de_batalla_contra(ejercito_atacado)
  end
end

class ResolucionDeEmpate < ResolucionDeBatalla
  def self.puede_hacerse_cargo_de_combate_entre(ejercito_atacante, ejercito_atacado)
    return ejercito_atacante.total_de_puntos() == ejercito_atacado.total_de_puntos()
  end

  def ejecutar_resolucion_entre(ejercito_atacante, ejercito_atacado)
    ejercito_atacante.ejecutar_empate_de_batalla_contra(ejercito_atacado)
    ejercito_atacado.ejecutar_empate_de_batalla_contra(ejercito_atacante)
  end
end

class Batalla

  def self.realizar_combate_entre(ejercito_atacante, ejercito_atacado)
    resolucion_de_batalla = self.resolucion_adecuada_considerando(ejercito_atacante, ejercito_atacado)
    resolucion_de_batalla.ejecutar_resolucion_entre(ejercito_atacante, ejercito_atacado)
  end

  def self.resolucion_adecuada_considerando(ejercito_atacante, ejercito_atacado)
    return (self.resoluciones_de_batalla().detect { |resolucion| resolucion.puede_hacerse_cargo_de_combate_entre(ejercito_atacante, ejercito_atacado) }).new()
  end

  def self.resoluciones_de_batalla()
    return [ResolucionGanadoraParaAtacante, ResolucionGanadoraParaAtacado, ResolucionDeEmpate]
  end
end

class RegistroDeBatalla

  attr_reader :un_ejercito,:otro_ejercito,:resultado

  def self.empate(un_ejercito, otro_ejercito)
    self.new(un_ejercito, otro_ejercito, 'Empate')
  end

  def self.victoria(un_ejercito, otro_ejercito)
    self.new(un_ejercito, otro_ejercito, 'Victoria')
  end

  def self.derrota(un_ejercito, otro_ejercito)
    self.new(un_ejercito, otro_ejercito, 'Derrota')
  end

  def initialize(un_ejercito, otro_ejercito, resultado)
    @un_ejercito = un_ejercito
    @otro_ejercito = otro_ejercito
    @resultado = resultado
  end

end
