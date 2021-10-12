class ApplicationComponent < Snabberb::Component
  include ComponentHtmlHelper
  extend ActiveRecordHelper
  include LoadActiveRecord
end

# ActiveRecordHelper