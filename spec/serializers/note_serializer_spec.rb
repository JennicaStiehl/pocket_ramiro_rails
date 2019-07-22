require "rails_helper"

RSpec.describe NoteSerializer do
  describe "When calling for a note" do
    it "returns the related user" do
      Note.destroy_all
      Resource.destroy_all
      User.destroy_all
      ResourceType.destroy_all

      user  = User.create(id: 1, name: "Cameron Marks", email: "cameron_marks@greatdivide.com", password: "password", role: 0, phone_number: 7208674848, active: true, created_at: "2015-11-29 00:00:00", updated_at: "2019-06-01 00:00:00")
      ResourceType.create(id: 1, category:"vehicle", company:"Brew Bears")
      Resource.create(id: 1, resource_type_id:1, name:"van", cost:"75000", user_id:1)
      note = Note.create(table_key: 1, table_name: "Resources",user_id:1, content:"Call Jeff before moving.")

      serializer = NoteSerializer.new(note, include: [:user])


      response = JSON.parse(serializer.to_json, symbolize_names: true)

      expect(response[:included][0][:attributes][:name]).to eq("Cameron Marks")
      expect(response[:included][0][:attributes][:id]).to eq(user.id)
    end
  end
end
