class Graphic
  include Virtus.model
  include ActiveModel::Serialization

  attribute :date, Date
  attr_reader :productions

  def initialize(options = {})
    super
    @productions = options[:productions] || fetch_productions
  end

  private

  def fetch_productions
    Production.incident_with_wday(date.wday).to_a
  end
end
