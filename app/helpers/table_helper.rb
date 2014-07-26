module TableHelper
  def table_for(table_renderer)
    render partial: 'shared/basic_table',
      locals: { headers: table_renderer.headers,
                rows: table_renderer.rows }
  end
end
