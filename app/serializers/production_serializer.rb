class ProductionSerializer < ActiveModel::Serializer
  attributes :id, :errors, :user_id, :start_day, :start_hour, :start_minute, :end_day, :end_hour, :end_minute
  attributes :repetitive, :cancelled, :confirmed_by_user
end

