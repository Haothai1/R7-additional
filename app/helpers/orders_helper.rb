module OrdersHelper
  def format_order_total(total)
    number_to_currency(total, precision: 2)
  end

  def order_status_badge(status)
    badge_class = case status.downcase
                  when 'completed' then 'badge-success'
                  when 'pending' then 'badge-warning'
                  when 'cancelled' then 'badge-danger'
                  else 'badge-secondary'
                  end

    content_tag(:span, status.capitalize, class: "badge #{badge_class}")
  end
end