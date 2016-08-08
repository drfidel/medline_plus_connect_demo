module ApplicationHelper
  # Handle HTML <head><title> content.
  def title(page_title)
    content_for(:title) { page_title.to_s }
  end
end
