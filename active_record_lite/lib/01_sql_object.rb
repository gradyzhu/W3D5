require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

#goal, create SQL object that gets inherited by other objects.  

class SQLObject
  def self.columns
    #should return an array of names of the table's columns
    @columns ||= DBConnection.execute2(<<~SQL).first
      SELECT
        *
      FROM
        '#{self.table_name}'
    SQL

    @columns.map {|el| el.to_sym }
  end

  def self.finalize!
    self.columns.each do |col| #[:sym, :sym2, :sym3]

      getter = define_method(col) do
        self.instance_variable_get("@#{col}")
        self.attributes[col]
      end
  
      setter = define_method("#{col}=") do |val|
        self.attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all()
    
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    @table_name
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
