require 'rspec'
require_relative '../src/rubyage'

describe 'Guerrero' do
  it 'ataca a otro y el otro pierde energía' do
    atila = Guerrero.new
    cesar = Guerrero.new
    atila.atacar_a(cesar)
    expect(cesar.energia).to eq(90)
  end

  it 'deberia descansar como defensor' do
    atila = Guerrero.new
    atila.descansar

    expect(atila.energia).to eq(110)
  end

  it 'deberia descansar como atacante' do
    atila = Guerrero.new
    atila.descansar

    cesar = Guerrero.new
    expect(atila.potencial_ofensivo_proximo_ataque).to eq(60)

    atila.atacar_a(cesar)
    expect(cesar.energia).to eq(60)
  end
end

describe 'Espadachin' do
  it 'ataca a otro con espada y el otro pierde energía' do
    zorro = Espadachin.new
    garcia = Guerrero.new
    zorro.atacar_a garcia
    expect(garcia.energia).to eq(75)
  end
end

describe 'Misil' do
  it 'ataca a otro explotando y el otro pierde energia' do
    misil = Misil.new
    pepe = Guerrero.new
    misil.atacar_a pepe
    expect(pepe.energia).to eq(0)
  end

  it 'no deberia poder ser atacado' do
    misil = Misil.new
    pepe = Guerrero.new
    expect{pepe.atacar_a(misil)}.to raise_error
  end

  it 'deberia duplicar su potencial ofensivo al descansar' do
    misil = Misil.new
    misil.descansar
    expect(misil.potencial_ofensivo_proximo_ataque).to eq(2000)

    super_guerrero = Guerrero.new(30, 20, 3000)
    misil.atacar_a(super_guerrero)

    expect(super_guerrero.energia).to eq(1020)
  end
end

describe 'Muralla' do
  it 'es atacada y pierde energia de acuerdo a su potencial defensivo' do
    atila = Guerrero.new
    muralla = Muralla.new

    atila.atacar_a muralla
    expect(muralla.energia).to eq(2980)
  end

  it 'deberia descansar como defensor' do
    muralla = Muralla.new

    muralla.descansar

    expect(muralla.energia).to eq(3010)
  end
end