module TableHelper
  def table_for(table_renderer, html: {})
    render partial: 'shared/basic_table',
      locals: { headers: table_renderer.headers,
                rows: table_renderer.rows,
                html_options: html }
  end
end
