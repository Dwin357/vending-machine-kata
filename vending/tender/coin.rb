LEGAL_TENDER = {
  penny:   { value:  1, weight: 3, size: 3}.freeze,
  nickel:  { value:  5, weight: 5, size: 4}.freeze,
  dime:    { value: 10, weight: 1, size: 2}.freeze,
  quarter: { value: 25, weight: 7, size: 7}.freeze
}.freeze


class Coin
  attr_reader :weight, :diameter

  def initialize(type)
    @weight   = LEGAL_TENDER.fetch(type).fetch(:weight)
    @diameter = LEGAL_TENDER.fetch(type).fetch(:size)
  end
end