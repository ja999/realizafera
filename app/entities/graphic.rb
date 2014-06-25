class Graphic
  include Virtus.model
  include ActiveModel::Serialization

  attribute :date, Date

  def initialize(options = {})
    super
    @productions = options[:productions]
  end

  def productions
    @productions ||= fetch_productions.to_a
  end

  private

  def fetch_productions
    Production.incident_with_wday(date.wday).order(:start_day, :start_hour, :start_minute,
                                                   :end_day, :end_hour, :end_minute)
  end
end
