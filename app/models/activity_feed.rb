class ActivityFeed
  def initialize(items, current_year: Date.today.year)
    @items = items
    @current_year = current_year #Test seam
  end
  def calculate
    items = fill_in_empty_years(divide_into_years(sort(@items)))
    #Hash preserves order, empty years come at the end
    items.sort.reverse.to_h
  end

  private
  def sort(items)
    items.sort { |a,b| b.date_submitted <=> a.date_submitted }
  end

  def divide_into_years(items)
    items.group_by do |item|
      item.date_submitted.year
    end
  end

  def fill_in_empty_years(hash)
    return hash if hash.keys.empty?
    years = hash.keys + [@current_year]
    Range.new(*years.minmax).each do |year|
      unless hash.has_key? year
        hash[year] = []
      end
    end
    hash
  end
end
