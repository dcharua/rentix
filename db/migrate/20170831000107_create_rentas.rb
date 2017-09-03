class CreateRentas < ActiveRecord::Migration
  def change

    create_table :inquilinos do |t|
      t.string :nombre
      t.date :nacimiento
      t.string :nacionalidad
      t.string :curp
      t.string :rfc
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    create_table :propiedads do |t|
      t.string :nombre
      t.string :calle
      t.string :municipio
      t.string :colonia
      t.integer :numero
      t.string :numeroe
      t.integer :cp
      t.string :estado
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

  create_table :rentas do |t|
      t.belongs_to :inquilino, index: true
      t.belongs_to :propiedad, index: true
      t.date :inicio
      t.date :final
      t.integer :costo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
