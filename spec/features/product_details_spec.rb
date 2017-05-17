require 'rails_helper'

RSpec.feature "Visitor Navigating to product details page", type: :feature, js: true do
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

  scenario "They see product details" do
    # ACT
    visit root_path
    first('.product').click_link('Details')
    sleep(5)
    # DEBUG / VERIFY
    save_screenshot "test.png"
    expect(page).to have_css '.product-detail'
  end
end
