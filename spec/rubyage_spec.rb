require 'rspec'
require_relative '../src/rubyage'

describe 'Guerrero' do
  it 'ataca a otro y el otro pierde energía' do
    atila = Guerrero.new
    cesar = Guerrero.new
    atila.atacar_a(cesar)
    expect(cesar.energia).to eq(90)
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
end

describe 'Muralla' do
  it 'es atacada y pierde energia de acuerdo a su potencial defensivo' do
    atila = Guerrero.new
    muralla = Muralla.new

    atila.atacar_a muralla
    expect(muralla.energia).to eq(2980)
  end
end