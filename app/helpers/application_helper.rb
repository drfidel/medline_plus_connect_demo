module ApplicationHelper
  # Handle HTML <head><title> content.
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end

  # Add 'active' class to current controller's navigational element.
  def active_class(path)
    'active' if request.path =~ /#{path}/
  end
end
