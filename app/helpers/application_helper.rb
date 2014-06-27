module ApplicationHelper

  def bootstrap_class_for flash_type
    classes = {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-info',
      notice: 'alert-warning',
    }
    classes[flash_type]
  end
end
