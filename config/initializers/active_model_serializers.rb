if defined?(ActiveModel::Serializer)
  ActiveModel::Serializer.root = false
  ActiveModel::ArraySerializer.root = false
end
