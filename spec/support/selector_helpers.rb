# frozen_string_literal: true

module SelectorHelpers
  # Finds an icon on the page and clicks it.
  def click_icon(**options)
    find('i', **options).click
  end

  def close_flash
    find(:css, 'button[data-dismiss=alert]').click
  end
end
