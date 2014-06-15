class Graphic
  include Virtus.model
  include ActiveModel::Serialization

  attribute :date, Date

  def initialize(options = {})
    super
    @productions = options[:productions]
  end

  def productions
    @productions ||= fetch_productions
  end

  private

  def fetch_productions
    Production.incident_with_wday(date.wday).to_a
  end
end
