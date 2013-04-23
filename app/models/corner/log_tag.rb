class Corner::LogTag < Site::TagAssociation
  belongs_to :log, class_name: "Corner::Log", foreign_key: "associated_id"

end