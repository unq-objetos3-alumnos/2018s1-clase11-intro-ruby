
module Atacante

  def potencial_ofensivo
    fail NotImplementedError, "Module requirement"
  end

  def atacar_a(otra_unidad)
    if self.potencial_ofensivo > otra_unidad.potencial_defensivo
      otra_unidad.pierde_energia(
          self.potencial_ofensivo - otra_unidad.potencial_defensivo)
    end
  end
end

module Defensor
  attr_accessor :energia

  def potencial_defensivo
    fail NotImplementedError, "Module requirement"
  end

  def pierde_energia(una_energia)
    self.energia = [self.energia - una_energia, 0].max
  end
end

class Guerrero
  include Atacante
  include Defensor
  attr_accessor :potencial_defensivo,
                :potencial_ofensivo

  def initialize(
      un_potencial_ofensivo = 30,
      un_potencial_defensivo = 20,
      una_energia = 100)
    self.potencial_ofensivo = un_potencial_ofensivo
    self.potencial_defensivo = un_potencial_defensivo
    self.energia = 100
  end
end

class Espada
  attr_reader :potencial_ofensivo

  def initialize(potencial_ofensivo = 15)
    @potencial_ofensivo = potencial_ofensivo
  end
end

class Espadachin < Guerrero
  attr_accessor :espada

  def initialize(
      un_potencial_ofensivo = 30,
      un_potencial_defensivo = 20,
      una_energia = 100,
      espada = Espada.new)
    super(un_potencial_ofensivo, un_potencial_defensivo, energia)
    self.espada = espada
  end

  def potencial_ofensivo
    super + self.espada.potencial_ofensivo
  end
end

class Misil
  include Atacante

  attr_accessor :kg_explosivo

  def initialize(kg_explosivo = 10)
    self.kg_explosivo = kg_explosivo
  end

  def potencial_ofensivo
    kg_explosivo * kg_explosivo * kg_explosivo
  end
end

class Muralla
  include Defensor

  def initialize(energia = 3000)
    @energia = energia
  end

  def potencial_defensivo
    10
  end

end