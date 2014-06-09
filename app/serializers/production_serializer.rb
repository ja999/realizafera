class ProductionSerializer < ActiveModel::Serializer
  attributes :id, :errors, :user_id, :start_day, :start_hour, :end_day, :end_hour
  attributes :repetitive, :cancelled, :confirmed_by_user
end

