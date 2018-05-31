
# module Unidad
#   def descansar
#
#   end
# end


module Atacante
  #include Unidad

  attr_accessor :descansado

  def potencial_ofensivo
    fail NotImplementedError, "Module requirement"
  end

  def potencial_ofensivo_proximo_ataque
    if self.descansado
      self.potencial_ofensivo * 2
    else
      self.potencial_ofensivo
    end
  end

  def descansar
    #super
    self.descansado = true
  end

  def atacar_a(otra_unidad)
    if self.potencial_ofensivo_proximo_ataque > otra_unidad.potencial_defensivo
      otra_unidad.pierde_energia(
          self.potencial_ofensivo_proximo_ataque - otra_unidad.potencial_defensivo)
    end

    self.descansado = false
  end
end

module Defensor
  #include Unidad
  attr_accessor :energia

  def descansar
    #super
    self.energia = self.energia + 10
  end

  def potencial_defensivo
    fail NotImplementedError, "Module requirement"
  end

  def pierde_energia(una_energia)
    self.energia = [self.energia - una_energia, 0].max
  end
end

class Guerrero
  include Atacante
  alias_method :descansar_atacante, :descansar
  include Defensor
  alias_method :descansar_defensor, :descansar

  attr_accessor :potencial_defensivo,
                :potencial_ofensivo

  def initialize(
      un_potencial_ofensivo = 30,
      un_potencial_defensivo = 20,
      una_energia = 100)
    self.potencial_ofensivo = un_potencial_ofensivo
    self.potencial_defensivo = un_potencial_defensivo
    self.energia = una_energia
  end

  def descansar
    self.descansar_atacante
    self.descansar_defensor
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