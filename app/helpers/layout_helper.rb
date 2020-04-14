# frozen_string_literal: true

module LayoutHelper
  def title(content: nil, product_name: true)
    return unless content

    meta_title = product_name ? "#{content} | #{DEFAULT_META['meta_product_name']}" : content
    content_for(:meta_title, meta_title)

    content
  end
end
