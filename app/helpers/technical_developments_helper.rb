module TechnicalDevelopmentsHelper
  SKILL_LABELS = {
    "conduction" => "Conducción",
    "reception" => "Recepción",
    "passing" => "Pase",
    "finishing" => "Remate a gol",
    "dribbling" => "Regate",
    "throw_in" => "Saque de banda",
    "heading" => "Cabeceo",
    "dispossession" => "Despojo",
    "shielding" => "Cuerpeo",
    "sliding_tackle" => "Barrida"
  }.freeze

  RATING_LABELS = {
    "good" => "Bien",
    "regular" => "Regular",
    "insufficient" => "Insuficiente"
  }.freeze

  def skill_label(skill)
    SKILL_LABELS[skill.to_s] || skill.to_s.humanize
  end

  def rating_label(value)
    RATING_LABELS[value.to_s] || value.to_s.humanize
  end

  def rating_options
    [["Bien", "good"], ["Regular", "regular"], ["Insuficiente", "insufficient"]]
  end

  def trend_badge(current_score, previous_score)
    return "Sin referencia" if previous_score.nil?

    delta = (current_score - previous_score).round(2)
    return "Sin cambio" if delta.zero?

    delta.positive? ? "Subió (+#{delta})" : "Bajó (#{delta})"
  end

  def technical_progress_chart(records)
    return content_tag(:p, "Aún no hay evaluaciones para graficar.", class: "text-stone-900 dark:text-stone-100") if records.empty?

    width = 760
    height = 260
    padding = 44
    chart_height = height - (padding * 2)
    chart_width = width - (padding * 2)

    points = records.each_with_index.map do |record, index|
      x = if records.size == 1
            width / 2.0
          else
            padding + (chart_width * index.to_f / (records.size - 1))
          end

      y = padding + ((2.0 - record.overall_score) / 2.0) * chart_height
      [x.round(2), y.round(2), record]
    end

    grid_lines = [0, 1, 2].map do |score|
      y = padding + ((2.0 - score) / 2.0) * chart_height
      <<~SVG
        <line x1="#{padding}" y1="#{y}" x2="#{width - padding}" y2="#{y}" stroke="#52525b" stroke-width="1" opacity="0.45" />
        <text x="10" y="#{y + 5}" fill="#e5e7eb" font-size="12">#{score_label(score)}</text>
      SVG
    end.join

    line_points = points.map { |x, y, _record| "#{x},#{y}" }.join(" ")

    dots = points.map do |x, y, record|
      <<~SVG
        <circle cx="#{x}" cy="#{y}" r="4" fill="#38bdf8" />
        <text x="#{x - 18}" y="#{height - 14}" fill="#e5e7eb" font-size="11">#{record.evaluated_on.strftime('%d/%m')}</text>
      SVG
    end.join

    content_tag(:div, class: "w-full overflow-x-auto") do
      <<~HTML.html_safe
        <svg viewBox="0 0 #{width} #{height}" class="min-w-[680px] w-full h-auto rounded bg-stone-900 p-2">
          #{grid_lines}
          <polyline fill="none" stroke="#38bdf8" stroke-width="3" points="#{line_points}" />
          #{dots}
        </svg>
      HTML
    end
  end

  private

  def score_label(score)
    case score
    when 2 then "Bien"
    when 1 then "Regular"
    else "Insuficiente"
    end
  end
end
