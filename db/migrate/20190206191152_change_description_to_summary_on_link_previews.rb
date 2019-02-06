class ChangeDescriptionToSummaryOnLinkPreviews < ActiveRecord::Migration[5.2]
  def change
    rename_column :link_previews, :description, :summary
  end
end
