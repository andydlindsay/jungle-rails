require 'rails_helper'

RSpec.feature "Product Details", type: :feature, js: true do

  def open_asset(file_name)
    File.open(Rails.root.join('db', 'seed_assets', file_name))
  end

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click on a product" do
    visit products_path

    within first('article.product') do
      first('h4').click
    end

    sleep 5

    image_name = Faker::Hipster.word
    save_screenshot "#{image_name}.png"
    puts "#{image_name}.png created"

  end
end
