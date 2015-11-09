class AddCpuRamHddAasmStateColumnsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :cpu, :integer
    add_column :projects, :ram, :integer
    add_column :projects, :hdd, :integer
    add_column :projects, :aasm_state, :string
  end
end
