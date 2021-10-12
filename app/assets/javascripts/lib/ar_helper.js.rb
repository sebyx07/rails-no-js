module ActiveRecordHelper
  def load_records(store_name, repo_name, called_method, **options)
    needs store_name, default: [], store: true
    __load_records__list << store_name
  end

  def __load_records__list
    @@__load_records__list ||= []
  end
end

module LoadActiveRecord
  def initialize(*options)
    super
    __load_load_records_on_init__
  end

  def __load_load_records_on_init__
    $$[:setTimeout].call(-> {
      self.class.__load_records__list.each do |store_name|
        store(store_name, [1,2,3,4])
      end
    }, 500)
  end
end