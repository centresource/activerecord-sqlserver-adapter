class ::ActiveRecord::Relation
  private
  def tables_in_string(string)
    return [] if string.blank?
    # always convert table names to downcase as in Oracle quoted table names are in uppercase
    # ignore raw_sql_ that is used by Oracle adapter as alias for limit/offset subqueries
    if base_class.table_name =~ /\w+\.\w+/
      string.scan(/([a-zA-Z_\[][.\w\]\[]+]).?\./).flatten.map { |s| s.downcase.gsub(/[\[\]]/, '') }.uniq - ['raw_sql_', base_class.table_name.split(/\./)[0].to_s.downcase]
    else
      string.scan(/([a-zA-Z_][.\w]+).?\./).flatten.map{ |s| s.downcase }.uniq - ['raw_sql_']
    end
  end
end
