ActiveAdmin.register Paper do
  filter :created_at
  
  controller do
    defaults finder: :find_by_public_id!
    
    def scoped_collection
      ::Paper.includes(:content_blocks)
    end

    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    column 'ID' do |c|
      link_to c.public_id, [:admin, c]
    end
    column :title do |c|
      c.title.value
    end
    actions
  end

  show do
    attributes_table_for paper do
      row "ID" do
        paper.public_id
      end
      row :title do
        paper.title.value
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title, as: :formtastic_translated_text
      f.input :content_blocks, as: :formtastic_content_blocks, width: 20
      f.input :copy_content_blocks_from
    end

    f.actions
  end

end