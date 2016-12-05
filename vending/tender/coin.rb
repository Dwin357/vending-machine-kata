require_relative 'tender'

class Coin
  attr_reader :weight, :diameter, :type

  def initialize(type)
    @weight   = LEGAL_TENDER.fetch(type).fetch(:properties).fetch(:weight)
    @diameter = LEGAL_TENDER.fetch(type).fetch(:properties).fetch(:size)
    @type = type
  end
end
